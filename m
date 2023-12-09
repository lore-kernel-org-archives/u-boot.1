Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA7AC10F04
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 17:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E9E87642;
	Sat,  9 Dec 2023 18:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702143100;
	bh=JyfN+7bVpLeOnPQaoo4q3lLDx/+1wTAQGRxicRDgqJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yCmcr/9jxQGvRmuJWwKiyPeaIP2ell53itwKX+MYDPuCUShVv+cqIA2CSy8Gl5OhY
	 2fwlAbPVF3/eKEzm3vBKUEUvVM0NOggx1jLiZ+uBZFoh5mS/LnHq32SxG/AeMl6+kx
	 pGDSbuIzRVPjUvBaqVq4pSEgBOTJ31dezP3x4kEBurWL1/yhZ6oyjVuhwpiEm2pvyd
	 MBFHDbkYd3xqcAtyVXuOd2VPSxN9HWM+Bi+FuPFLF1tqjNrsVyWZuMJ8XNyVrrc9dT
	 MlM1UHOcl4nX82LHakTptknc9K1yvHMM4dAoSFmZtXAuHoZOEQU05adXVuAyIQI/jj
	 MPFezt/+uo2nA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F010D871CF;
 Sat,  9 Dec 2023 18:31:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702143099;
 bh=JyfN+7bVpLeOnPQaoo4q3lLDx/+1wTAQGRxicRDgqJU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gaQToToXFpPdtRUp92zxI8J9CFrH4w8sEGNvBzdtRGoX6d7lUZbGiMwVFMx3btO20
 7r5q6W70tJ7UyilnlpqCMCaRYHaZPZuHk2p2vkzHlG/ZT1aD9xM40YBYQ5Wgl9Gbg2
 xWsEWWKC0dlNQy9+mA9v2jSn65p9dc98tc+NXcloX4Xt4niPWfAKtbW1m9Nu0SO9Ox
 lLX2iCNjCVm3Ft8QezzxVRRrDJWnk22KKvKdb/BDCBnBCxTv9aGObc8pQ/p+NQYuwn
 eNOb2tggMFAD0EN3q1ubYlYDubAUF081VDrLR/oS1p8B0yKYnftCE1gqH9rYDl9oof
 OmZtsD/QDJkeg==
Message-ID: <edd57912-f38f-4589-bb21-c638db8535e1@denx.de>
Date: Sat, 9 Dec 2023 18:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dts: rockpro64: Disable usb regulators-always-on
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20231208000947.248849-1-i@shantur.com>
 <20231208000947.248849-3-i@shantur.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231208000947.248849-3-i@shantur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/8/23 01:09, Shantur Rathore wrote:
> USB port regulators should be controlled by phys

PHYs

> so we remove always-on property and let phy manage the
> regulator.
> 
> Typec port has misconfugred

misconfigured (typo)

> phy-supply in upstream and
> now that we are removing always-on, we need to fix the
> phy-supply until its fixed upstream.

Where is the upstream Linux kernel patch ?
Was it submitted already ?

You should send this patch separately, it doesn't depend on the USB Hub 
1/2 patch and will go in through different (rockchip) tree.
