Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7FCC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 07:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CD18212B;
	Mon,  2 Jun 2025 09:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gUO7V8z5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE66D828F8; Mon,  2 Jun 2025 09:58:43 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C67D8070C
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 09:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 12E5361126;
 Mon,  2 Jun 2025 07:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729D9C4CEED;
 Mon,  2 Jun 2025 07:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748851119;
 bh=dTL5cq5Qsuz+pB9X2zqj09GNFdjvxzXQJu0VpUzBCUA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gUO7V8z57w9mvDdkQisYDc3ezq2igTsnNXrW4VyqHakgN1az8V8wRl9pIWvOXPU2o
 Jh00ZfBdn2HKhRztgjktla3uB16i0PkFRQxh8UevRB53H51jusuIxeOtIUm82Xs7mQ
 /PZ3zlhZ8G00Fgy2yb5GWNM/DBFQnsBwOlk43mL1m3W2ijgtyd2aHlyHTOpN0ZLGC4
 hKTM7cHpzUnQriwePR0XOzRtmJL3vVJt/nBrtJaJE2IzLUvDu0KrxPBT468uGzuDVZ
 z+BhMAf5C6TLVNs3GAC6KM9jRei2kLYgA37Hxy3xVilc7JxhytgyIhApHNQDwSsiwL
 HLXY2M7K6yDjQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com
In-Reply-To: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
References: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
Subject: Re: [PATCH v4 0/8] usb: dwc2: Refactor and update USB DWC2 driver
Message-Id: <174885111752.14505.10091538998953169230.b4-ty@kernel.org>
Date: Mon, 02 Jun 2025 09:58:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On Fri, 10 Jan 2025 21:55:19 +0800, Junhui Liu wrote:
> This series improves the USB DWC2 driver by extracting register
> definitions into a common file for better readability and updating the
> reset method to reflect changes in version 4.20a, including the new
> GRSTCTL_CSFTRST_DONE bit for reset completion indication.
> 
> This series has been tested on two platforms:
> - MK808 with RK3066 SoC and dwc2 v2.91a, tested with USB flash drive and
>   connected the board to the PC through the rockusb command. Test log [1].
> - K230-CanMV with K230 SoC [2] and dwc2 v4.30a, tested with the onboard
>   rtl8152 USB to net chip and an external rtl8152 adapter connected to
>   the onboard USB-C interface via USB hub. Test log [3].
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/8] usb: dwc2: Extract register definitions to common header file
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/14f904130964f251e78349a2e370c5069f2af500
[2/8] usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/94a1f8fe47e26250dd5704b2c2187622522eca6b
[3/8] usb: dwc2: Fix HBstLen setting for external DMA mode
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/bd6ef5097dd6c6219f12c0f2866ee4d578f190e9
[4/8] usb: dwc2: Clean up with bitfield macros
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a5699130f4ad3f08d5192a459d116cd0ffc9ee4d
[5/8] usb: dwc2: Align macros with Linux kernel definitions
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6def014bba5ee779c7faeec012bc93d2ff90f6d3
[6/8] usb: dwc2: Extract macro definitions to common header
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/24b0e2604e2980dd04078b85a7a8929588dc0988
[7/8] usb: dwc2: Unify flush and reset logic with v4.20a support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c5d685b8993cf9e2fa4321dc3f9f866d5655e976
[8/8] usb: dwc2: Replace uint<x>_t types with u<x>
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/bd88148a1bf3457ffe05d3bb0563dc4bfbfeee96

--
Mattijs
