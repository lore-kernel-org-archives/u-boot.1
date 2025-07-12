Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDEFC83F10
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 18:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F343808AF;
	Sat, 12 Jul 2025 20:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="S3bAge99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC75D808AF; Sat, 12 Jul 2025 20:54:56 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 895BD805D7
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 20:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: c66493fa-5f52-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id c66493fa-5f52-11f0-beb8-005056992ed3;
 Sat, 12 Jul 2025 21:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=K0FM72+ins/fJmh1kgxONmjc46Ufi+I1d8Mju8lcWRo=;
 b=S3bAge99maI81mKjonks00Jir9JntUXF5L7KkAjZwpMKlbyi/r19rM+bYaGL9pK0vF1MV7Hq3SAub
 yBdg/G+MYINS+Z5omQb8l5ELswV3tGhppUpmm6D8237oesEB8rRzc6bvkb5jzweBq1mMCtEQYiRmkB
 eypb4jdwbPapPsSN+2Jar3mfB56yr3SlSk6QBcT0E9U7qOFOEDJqNJNntVdp+rdxMIbd94nDOTL1ol
 lvmHYApaED6xZ8DPZHpo1z2y8fOK4P8GANcpmTGiQlg1sttVdewSJYEo3sJvMvCMkb+vLhmwPUE/Qg
 vhKFkNrA5TEOwfLFHX6pAqG8YGB4XFQ==
X-KPN-MID: 33|u/9JbKZrX5Zo45wWhyFjsLrOSQMRl0Qx/D5bz1GoQkReDIFTjro9CP2wXLtg4A6
 PQEcImMOy6tsKpBSn9d32Kg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|H/DTXcF3P1h2T3qAqj88DXcuvPubxM3mwba4TRrlHOsMrpsas1lnBXmjS36672f
 4YbjtcsP2gF/sHM/mUm7Jiw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b166ec5f-5f51-11f0-9821-00505699d6e5;
 Sat, 12 Jul 2025 20:54:52 +0200 (CEST)
Date: Sat, 12 Jul 2025 20:54:52 +0200
Message-Id: <87o6tpb5oj.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 ilias.apalodimas@linaro.org, kettenis@openbsd.org
In-Reply-To: <20250712104558.77355-1-kettenis@openbsd.org> (message from Mark
 Kettenis on Sat, 12 Jul 2025 12:45:58 +0200)
Subject: Re: [PATCH] kbuild: Don't mandate gcc as the host compiler
References: <20250712104558.77355-1-kettenis@openbsd.org>
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

> From: Mark Kettenis <kettenis@openbsd.org>
> Date: Sat, 12 Jul 2025 12:45:58 +0200
> 
> Systems that use clang may not have gcc installed.  Set
> HOSTCC to cc and HOSTCXX to c++ like we did before to make those
> systems work again.
> 
> Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")

Just realized I forgot my Signed-of-by tag.  So:

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>

Or should I resend the patch with that included?

> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index e8f12716640..121ebd5c353 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -416,8 +416,8 @@ HOST_LFS_CFLAGS := $(shell getconf LFS_CFLAGS 2>/dev/null)
>  HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
>  HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
>  
> -HOSTCC       = gcc
> -HOSTCXX      = g++
> +HOSTCC       = cc
> +HOSTCXX      = c++
>  KBUILD_HOSTCFLAGS   := -Wall -Wstrict-prototypes -O2 \
>  		-fomit-frame-pointer -std=gnu11 $(HOST_LFS_CFLAGS) \
>  		$(HOSTCFLAGS) #-Wmissing-prototypes Enable it and fix warnings
> -- 
> 2.49.0
> 
> 
