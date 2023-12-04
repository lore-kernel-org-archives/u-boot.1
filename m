Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625A1C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9955187716;
	Mon,  4 Dec 2023 11:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="bA+2v4Q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C2DE87716; Mon,  4 Dec 2023 11:48:20 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0EA187225
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 9af5e040-9292-11ee-abd3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 9af5e040-9292-11ee-abd3-005056999439;
 Mon, 04 Dec 2023 11:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=tpWnXWAgdJCSDUxqsLweBeBMJLbWotFFc8iFn5lHRL0=;
 b=bA+2v4Q0b2kWWxG+2R+rwECFnbXaJ9mlIGlcHvpvV6ztucxjsrHpPHbpe04CzlInsmFaO0WVUZ7bN
 01NokKOU/KWWNG5vlZ9w8B+3CNnRZ4LbeC0pSyiLuK9wXzhtrGgn0Lt2MY2TZyb40PexB4rJMqdEdg
 ksTFXAo0EV/gOYw6KB35eDO1/m4WCcpMzonKH5DFn66W1Ipw22kA0fLqK89kBKWQad8kb6CatNQehB
 NYm/1n/LZixOI+cmVBmmRDjeAxJ+SEwNrXHJ6oHBaUgJsDBXOLUA32TpeH+Zy9hUo964b8l+KTpMNk
 szhWHoyErPU/2f0rACH7KeIY8F+dUpw==
X-KPN-MID: 33|xWKGDAbP1JVk3xftCt/r8VgrwswwdiDunC8opyxpRx48Ki56c3KYRRHsfmo+8GO
 5GU4oxCGBhhlRuywlCzRjHQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jKnWX+aCyf0QU1D0nbabGUwnGl9fvXFgLxg5lU/I8KmJ5GzCACc6PsWEzu1kpot
 MU6HA/Omh4Lm/81AiDoc1Ug==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id a1b569e6-9292-11ee-9dc8-00505699772e;
 Mon, 04 Dec 2023 11:48:17 +0100 (CET)
Date: Mon, 04 Dec 2023 11:48:17 +0100
Message-Id: <87edg2b5vy.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 marek.vasut+renesas@mailbox.org, sean.anderson@seco.com
In-Reply-To: <20231204002642.895926-2-sjg@chromium.org> (message from Simon
 Glass on Sun, 3 Dec 2023 17:26:17 -0700)
Subject: Re: [PATCH 01/18] bootm: netbds: Drop passing of arguments
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231204002642.895926-2-sjg@chromium.org>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Sun,  3 Dec 2023 17:26:17 -0700

Hi Simon,

There is a typo in first line of the commit message: s/netbds/netbsd/.

> It isn't clear how useful it is to pass the arguments of bootm to the
> OS. For example, if "bootm 1000 2000 3000" is used, the three arguments
> at the end are passed to the OS. This seems like a strange approach,
> since the argument have already been parsed by U-Boot and processed.
> 
> Rely instead on the "bootargs" mechanism, which is the standard
> approach.

It is a very Linuxy approach though.

I suspect this feature was added to pass kernel arguments for
"one-off" boots.  For example

    bootm -s

could be used to boot NetBSD in single-user mode and is quite a bit
more convenient than:

    setenv bootargs -s
    bootm

That said, I'm not sure to what extent the bootm command is used to
boot NetBSD these days.  So this may not really matter.

Cheers,

Mark

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  boot/bootm_os.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index b92422171a84..b5055d78706c 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -102,19 +102,9 @@ static int do_bootm_netbsd(int flag, int argc, char *const argv[],
>  			os_hdr = hdr;
>  	}
>  
> -	if (argc > 0) {
> -		ulong len;
> -		int   i;
> -
> -		for (i = 0, len = 0; i < argc; i += 1)
> -			len += strlen(argv[i]) + 1;
> -		cmdline = malloc(len);
> -		copy_args(cmdline, argc, argv, ' ');
> -	} else {
> -		cmdline = env_get("bootargs");
> -		if (cmdline == NULL)
> -			cmdline = "";
> -	}
> +	cmdline = env_get("bootargs");
> +	if (!cmdline)
> +		cmdline = "";
>  
>  	loader = (void (*)(struct bd_info *, struct legacy_img_hdr *, char *, char *))images->ep;
>  
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
> 
