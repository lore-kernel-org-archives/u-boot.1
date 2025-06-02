Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B893C5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 08:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B088212B;
	Mon,  2 Jun 2025 10:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PSUi+rtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6CD828F8; Mon,  2 Jun 2025 10:04:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C1A81D6A
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 10:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6687449B81;
 Mon,  2 Jun 2025 08:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED193C4CEEB;
 Mon,  2 Jun 2025 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748851452;
 bh=GSEKndvtZPkK5+T1mpY525dBoewEqxX9Oqb4SJCAoP0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=PSUi+rtfGXfALYh1e/9sISHCj7PMzko7C6wlCtdzvrxFXZsr+jUISLPaB8xuilF7u
 rtvWEjLOj75e6jEQob4pr8FMgezBbCGPBSlKyyMZ1WGslHH0P7BqGWauwPH7AnAM8A
 M5l6+l7Lxq6haKZWGcEFm6s8+smKyYSgxuIQKshijw4/HJEMlBMlTRBUHNmhbKiXdf
 uIi7yiKKxqqPOZtrQvVnQigVRnwgm7bgmYF5KWFySvJ718mxZxAOY+Ywt/+Y0oHxfL
 O+Fyg1j96bFeCY2+ys/W47HkDC9SIz/sSF9I3zAngcvwbXMjUn62nbXAT/uFMe9zLB
 1vcIkgEHeZdng==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250126-dwc2-clrsetbits-refactor-v1-1-68c27e1b6f84@pigmoral.tech>
References: <20250126-dwc2-clrsetbits-refactor-v1-1-68c27e1b6f84@pigmoral.tech>
Subject: Re: [PATCH] usb: dwc2: Refactor register operations with
 clrsetbits macros
Message-Id: <174885145015.25094.4624762218014237606.b4-ty@kernel.org>
Date: Mon, 02 Jun 2025 10:04:10 +0200
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

On Sun, 26 Jan 2025 00:29:59 -0800, Junhui Liu wrote:
> Refactor DWC2 USB gadget driver to replace manual read-modify-write
> operations with `clrsetbits_le32`, `setbits_le32`, and `clrbits_le32`
> macros, which simplify the code and improve readability.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: dwc2: Refactor register operations with clrsetbits macros
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/42911f61b776cda40ba2b8c9e57988a84ad359a5

--
Mattijs
