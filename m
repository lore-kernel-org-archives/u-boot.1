Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65FEE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7984B89635;
	Fri,  6 Dec 2024 16:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gzbLdpFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B443A89672; Fri,  6 Dec 2024 16:32:03 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6548989640
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725c49b5e45so455648b3a.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733499120; x=1734103920; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FwzgDUBL3qdkklmxeqgzHMN1QALbEFFjWrl3WlQkscA=;
 b=gzbLdpFbvyPc2dkWEOBb9ei4PuJRyY3gw95JUamvT/X+9OIrk8ayqUetSpeX8RzmQy
 HmAPvWgEXKjp75efiKTeFIcPF3+RKOb1idgOmrzkzDcQ0cQQxRDlG4BOHmjJ+Lw32C+c
 ykvyjhkHovwLb7+x4UAXAo7nYkihJg+TcmrX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499120; x=1734103920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FwzgDUBL3qdkklmxeqgzHMN1QALbEFFjWrl3WlQkscA=;
 b=jOnZNekEow4yuio1sF6lIUa66xmvvP28fIBtzktUSgllUDPiRBwtND8W7C4j0pIoZ7
 4R0lcKF8WrwWqhSiIQNSG5T2fI35WTzjNC/updtNwF9ByHqB3ZIhutuCZel6UUYTqWrN
 EpKahhl+RZ3NfaL2f/vfYD+/5E6kyau2C+l69PNfJ77H6t1lENxmx1NO4kfIXSkCSYCl
 gwZqokOSygf4CYTrbjltlI0/5AQD0VOGWAavfp+JfbKXtbkS05bISX8+R0aZ8oI+1GnU
 NHPy4roGG+HM0I+epcQaSIpUGccTkxw3pgN4Xev4ZoRqVoFE9vmh+Hzndt3ezF54M2Bv
 mdKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Tz7CxhT2ol21m9hjcsPzRMJuI7WDuQYvQmwYrYDzc7VQejcDMg9QzumXyVMmUNxkZJ0CtQE=@lists.denx.de
X-Gm-Message-State: AOJu0YyTy6mvjedKJ4EeMYztc5UU7WsDRO4oHPxzGViwZqBBAChJLG05
 es3pdGAip8qYjwnewzbLT+YE21b04T/iuoTUiZF3r+MA+N2VZ2Z1B5qva//bY6PcjN2khAOT9Ox
 ovxA+IBtVRS6OLobREq0R1N0lctqIy/YOvQ7J
X-Gm-Gg: ASbGnct52KV5dyN02ec3OggGwqRYYnUE0W0B9doY0EYDGoGTmqZijIMwBSSDaDovDE8
 plvL8Gg+KcykG4wLJRScI8bEirDBNX0q8
X-Google-Smtp-Source: AGHT+IE3joum+v3XBkSjwUkNQM05cHXYGJqNjhltEdZxB0Yalk6Wu3XNArOnhGJbnxy8X4IoMhEJSlsKbyd97ZZ8DP4=
X-Received: by 2002:a17:90b:3d87:b0:2ef:1134:e350 with SMTP id
 98e67ed59e1d1-2ef6ab2739dmr4384633a91.35.1733499119991; Fri, 06 Dec 2024
 07:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-4-05aff4b0ccf7@salutedevices.com>
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-4-05aff4b0ccf7@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 08:31:22 -0700
Message-ID: <CAFLszTisVG9Jn-Zi9F6VUERmecn=g=x6EwaNQORS+yiaCRBJRQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] test: sandbox: fix link error with do_ut_bootm if
 BLOBLIST=n
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, kernel@salutedevices.com,
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Evgeny,

On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
<EABachinin@salutedevices.com> wrote:
>
> Having CONFIG_OF_EMBED=y && CONFIG_BLOBLIST=n leads to the link
> error:
> ```
> ld: /tmp/ccwtRVty.ltrans28.ltrans.o:(.data.rel+0x4e8): undefined \
>                                             reference to `do_ut_bootm'

Are you sure? I don't see that one. The bootm test should not relate
to bloblist.

This is what I see:

buildman  -a OF_EMBED -a ~BLOBLIST --bo sandbox
Building current source for 1 boards (1 thread, 32 jobs per thread)
   sandbox:  +   sandbox
+===================== WARNING ======================
+CONFIG_OF_EMBED is enabled. This option should only
+be used for debugging purposes. Please use
+CONFIG_OF_SEPARATE for boards in mainline.
+See doc/develop/devicetree/control.rst for more info.
+====================================================
+
+Some CONFIG adjustments did not take effect. This may be because
+the request CONFIGs do not exist or conflict with others.
+Failed adjustments:
+~BLOBLIST             CONFIG_BLOBLIST=y
    0    0    1 /1              sandbox
Completed: 1 total built, 1 newly), duration 0:00:11, rate 0.09


> ```
>
> Fixes: fe158657a5b ("test: inconsistent bootm tests")
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> ---
>  test/cmd_ut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> index 842c2c3e7f65eb9fe017fa1949eb2390be171487..a14dbf4ca5e571a872585ff11bfe7adae3f4edf3 100644
> --- a/test/cmd_ut.c
> +++ b/test/cmd_ut.c
> @@ -107,9 +107,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
>  #if CONFIG_IS_ENABLED(BLOBLIST)
>         U_BOOT_CMD_MKENT(bloblist, CONFIG_SYS_MAXARGS, 1, do_ut_bloblist,
>                          "", ""),
> -#endif
>         U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
>  #endif
> +#endif
>  #ifdef CONFIG_CMD_ADDRMAP
>         U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
>  #endif
>
> --
> 2.34.1
>

Regards,
SImon
