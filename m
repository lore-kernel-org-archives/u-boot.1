Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FCECD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 10:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA84A84BDC;
	Fri,  8 May 2026 12:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="NS/7wPXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3657D84C54; Fri,  8 May 2026 12:41:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 57C5D84B56
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 12:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56DB81BCA;
 Fri,  8 May 2026 03:41:00 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.29.54])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2DD3F763;
 Fri,  8 May 2026 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778236865; bh=1+5KWcuXvt/IwuW1xj4repWiXI3s022rmyK0NsuK6Ko=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NS/7wPXPoy/P7hrJp9Da3u7PC76R/hxns0duOnTz35A1OCbcQLQ70dG7B6FJZAL3q
 aU5oQgfHwY4/otHYVXeRoQuWfbEfr3dBFmhba0GhSMxvZPT0KF2FfI1yTAbBRE7h9F
 LJuO+OA01yB52+MdqRqv2B7xF5bVVCyeR8hTsr68=
Date: Fri, 8 May 2026 11:40:55 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: hugues.kambampiana@arm.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de,
 xypron.glpk@gmx.de
Subject: Re: [PATCH 10/12] doc: arm64: document FF-A runtime path for EFI
 variables
Message-ID: <af29t9-mRW7wAXBP@e130802.arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-11-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424173151.371134-11-harsimransingh.tungal@arm.com>
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

Hi Harsimran,

> Document how EFI runtime variables use FF-A MM communication
> 
> Describe the FF-A runtime layer on arm64 and how EFI variable
> runtime services use the FF-A transport and shared MM buffer.
> Also clarify armffa command scope and link to the FF-A doc.
> 
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  doc/arch/arm64.ffa.rst   | 92 +++++++++++++++++++++++++++++++++++++---
>  doc/usage/cmd/armffa.rst | 11 +++++
>  2 files changed, 96 insertions(+), 7 deletions(-)
> 

Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Regards,
Abdellatif
