Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBFDC46CD2
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 07:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71AF787730;
	Thu, 21 Dec 2023 08:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="u0BRNcd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC5A9877D0; Thu, 21 Dec 2023 08:55:48 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91FB887730
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Thu, 21 Dec 2023 08:55:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1703145345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=CqhGtrCTotevDpuyZOaHgfi4iIBN8qZoAYKYi4FfvRE=;
 b=u0BRNcd/GfviNyfjzJrH3TRQC7UXJSX3MnyqcoToMPr6TzisGpoHQnCXKV6kwSrHn53MNa
 x0qeSCSN2Z6yqDDUZ3/r1U4M8jwvvAkOi+6kanZ8x/le8vJ/KIGSLPbv9AiahSTalEK8B5
 NPnzCY6MvgJWFm9rxh4U6GuTyz7pgv/wSfWn3f+F/QRInOLLwwm/AsAymiwo7T07LZhvvh
 pyOS9AoLPnVv9CZIF+zD0Q+Vnz2OJBW/PH2a0g2PNwttqTqgTJvO7AeT6NM1f0Ml5v/5rR
 vLolAEoIM2klS11qEbYt/OahaOahnzhLNZ4IDpD4Khn2z1rXPQ/Uog1RRmvU5g==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Terry Lv <terry.lv@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 0/2] tools: Fix build without host OpenSSL
Message-ID: <20231221-e31a65ee69439a94d1a823ee@thorsis.com>
Mail-Followup-To: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Terry Lv <terry.lv@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20231221072611.11479-1-ada@thorsis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221072611.11479-1-ada@thorsis.com>
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

Hello,

Am Thu, Dec 21, 2023 at 08:26:09AM +0100 schrieb Alexander Dahl:
> Hei hei,
> 
> both patches of the series got a review and this is my last work day of
> the year, so I just incorporated the feedback, collected the tags, and
> send this out before returning to office in January.
> 
> Link to v2 with whole motivation text:
> https://lore.kernel.org/u-boot/20231214121136.3286703-1-ada@thorsis.com/
> 
> Have some peaceful days everyone.
> 
> Greets
> Alex
> 
> v2 -> v3:
> * Rebased on v2024.01-rc5
> * Removed a superflous new newline introduced in v1

This change was in v2 of course.  I made the same mistake in the
changelogs of the patches, where it should have been v2 -> v3 instead.
Sorry for the confusion.

Greets
Alex

> * Collected tags
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Link: https://lore.kernel.org/u-boot/20211021093304.25399-1-pali@kernel.org/
> Link: https://lore.kernel.org/u-boot/20220111153120.1276641-1-marex@denx.de/
> Link: https://lore.kernel.org/u-boot/1884029.XjOfZupGQm@ada/
> Link: https://lore.kernel.org/u-boot/20230121154743.667253-1-paulerwan.rio@gmail.com/
> Link: https://lore.kernel.org/u-boot/AM6PR04MB61521B84F78571B282FE1D828FD5A@AM6PR04MB6152.eurprd04.prod.outlook.com/
> 
> 
> Alexander Dahl (1):
>   tools: kwbimage: Allow disabling build on non-mvebu platforms
> 
> Paul-Erwan Rio (1):
>   tools: fix build without LIBCRYPTO support
> 
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  include/image.h             | 2 +-
>  tools/Kconfig               | 6 ++++++
>  tools/Makefile              | 4 +++-
>  tools/fit_image.c           | 2 +-
>  tools/image-host.c          | 4 ++++
>  tools/mkimage.c             | 5 +++--
>  7 files changed, 19 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 97a897444235921ce19b4f8a3b27de6f5a9ab367
> -- 
> 2.39.2
> 
