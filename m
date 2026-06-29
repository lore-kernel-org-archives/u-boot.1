Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B12FC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C211084942;
	Mon, 29 Jun 2026 20:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="twBOS88t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B2884A30; Mon, 29 Jun 2026 20:16:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 04FC08490A
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE5DD3514;
 Mon, 29 Jun 2026 11:15:53 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.80.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 681473F905;
 Mon, 29 Jun 2026 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782756958; bh=uexJaNGagN4EbYebb+lEfhdCEUvNc4iJ3cHESkbuImQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=twBOS88tePCxhZrboZ3+h03Q3C4FP8Jc1HwNTr5wOUTi3eRFagB6IknB/UFkqvRy9
 aWgiFWnKb4lxo71uuMbD5WVhPHwWhmLfmw4RbuXbkBWUrKuQhiMChUFYfWwNyNfNAT
 jVwEExZDaTVN7X2XH33nfHgZpS0SYVdX8G3rb0qQ=
Date: Mon, 29 Jun 2026 19:15:47 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 09/10] doc: arm64: document FF-A runtime path for EFI
 variables
Message-ID: <akK2U_FejiNORLxp@e130802.arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-10-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627144421.2067410-10-harsimransingh.tungal@arm.com>
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

On Sat, Jun 27, 2026 at 03:44:20PM +0100, Harsimran Singh Tungal wrote:
> The arm64 FF-A documentation still said EFI runtime support was a
> future development, so readers had no description of the current FF-A
> runtime transport or how EFI runtime variable services use it.
> 
> Document the FF-A runtime transport, the shared MM communication path,
> and the EFI runtime variable flow on arm64. Also clarify that the
> armffa command is boot-time only and point readers to the architecture
> documentation for EFI runtime variable services over FF-A.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
