Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403CCC54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9AD83285;
	Fri, 23 May 2025 15:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kaG5/pX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90FA48329B; Fri, 23 May 2025 15:48:30 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC6D83264
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad56cbc7b07so822822566b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748008108; x=1748612908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=krPPjQXn33wgBAcAOml2hJeJxPVWG4IV5CoyfVRXZoU=;
 b=kaG5/pX8iCt2rDRY/XwgjAH2tjhxa5Lg5mjze1XBLZLAnPdQPmvsu71Vt96zgm8nkJ
 iKD3SjurDbHzfKEpvEQevWKQH2cZVlEaUtIAKVB/bEC3lZ+e4uU7eZKRopOBxSmPBr3y
 1eoNfGpSArnLX5QYcWWh+KkvxEaFzojVP0fKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748008108; x=1748612908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krPPjQXn33wgBAcAOml2hJeJxPVWG4IV5CoyfVRXZoU=;
 b=oqT9Bo3RRbK61XsQi1BeABxOzELXhtRvffDYy6pYNAjRghq9s3h4Iyv6nx1wVj7XfD
 YEqn4xtSC+S3ehRnNQuImNlWMxrQUFt/E/7ylsB+O5P5zuxN1ptU99HkvRNWPRwNMT2v
 wPk8EgfAGvd3XUiW9kLwvh9EBTbfaTTpUldnlug7H3XzTFyEcq7ugbGWE04ZqCwoJAPV
 dv362xAhDa2JTc4rZud78Ho/NxNilSkDXemsADQgsScJgCeKWeAtanfgRW54D4myrCWL
 xtDlyU5h5sd6UYqew5PJNAJiQQtFkCu8ZS/yqDO/zW+QoJP77qUzde+opDhnfUz+eYGy
 c4eg==
X-Gm-Message-State: AOJu0Ywe0aQGvRW0EjFm0dh2Gz+BvFBMVFwUqIn+BzvRb56vOFStJsf8
 Gxam83kk+Ibk1JMKqNB+06Cxm9GgpDEpRbG3d+B9wbgullOna3GOXzNP1LLPpBQ7Qhrrfi9P8nx
 cAYSxMStWnb73OywnbqjITD5Wd7itiZ8dn0viw+kTwt0L1Jzlq2GM3kiv
X-Gm-Gg: ASbGncsW+OXBjYljApkmBlcVWREHDSPKxSZGY/oxMu4Bi8v7ubHBx+DIJsjRRoHzvTi
 ieKmBBzaK476MxQQtsEju6NBx2LXWHxjhl3D+dMnimPKUYt2hRRShWQu8tNJ84EF/tfBGO/oS07
 7JPsLNau2yfVMGZP8CBZvKswj4TmTm5CbCSw==
X-Google-Smtp-Source: AGHT+IEHX1DzEKU/efrFLoXpkRjEbmp5pd6G857t0eLsK5FzJOc5Y7PMcC/GM11UbkBBKcJEzJZIiWd693ImrMlbLzw=
X-Received: by 2002:a17:906:7310:b0:ac7:edfb:5210 with SMTP id
 a640c23a62f3a-ad7083b2d65mr272378466b.20.1748008107959; Fri, 23 May 2025
 06:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250520203515.25839-1-dev@benjarobin.fr>
In-Reply-To: <20250520203515.25839-1-dev@benjarobin.fr>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 14:48:15 +0100
X-Gm-Features: AX0GCFufpUSLa5l5_li6NLSWLSBF9ZHPg5CfMz0sF5jazzq3ATqFD-UQGXtc3FA
Message-ID: <CAFLszTigMGxSjxPZ44BUx4WoWqVdNY3p6AeQwy3xK3gJ+VccTw@mail.gmail.com>
Subject: Re: [PATCH v2] bootm: Fix bmi->images pointer not initialized in some
 cases
To: Benjamin ROBIN <dev@benjarobin.fr>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Hi Benjamin,

On Tue, 20 May 2025 at 22:35, Benjamin ROBIN <dev@benjarobin.fr> wrote:
>
> When building with only bootz command, without bootm, images pointer
> inside bootm_info structure is not initialized. And since this structure
> is stored in stack, the generated error is kind of random, but most of
> the time this will generate: "ramdisk - allocation error".
>
> Also, after analysis, this problem could occur with the command booti,
> if the command bootm is disabled.
>
> Currently bootm_init() is called by: do_bootz(), do_bootm(), do_booti()
> and by do_stm32prog(). And all of these commands execute bootm_run_states()
> which access the images pointer stored into bootm_info structure.
>
> So, to fix this issue, just do the assignment unconditionally.
>
> Fixes: c2211ff65136 ("bootm: Add more fields to bootm_info")
> Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
> ---
>  boot/bootm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index f6aa32746b7e..108ca7fb472e 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -1169,8 +1169,7 @@ void bootm_init(struct bootm_info *bmi)
>  {
>         memset(bmi, '\0', sizeof(struct bootm_info));
>         bmi->boot_progress = true;
> -       if (IS_ENABLED(CONFIG_CMD_BOOTM))
> -               bmi->images = &images;
> +       bmi->images = &images;

In my tree I have:

if (IS_ENABLED(CONFIG_CMD_BOOTM) || IS_ENABLED(CONFIG_CMD_BOOTZ) ||
    IS_ENABLED(CONFIG_CMD_BOOTI) || IS_ENABLED(CONFIG_PXE_UTILS))

but it seems that the few boards that didn't include boot/bootm.c have
been dropped, so your patch is fine.

>  }
>
>  /**
> --
> 2.49.0
>

Regards,
Simon
