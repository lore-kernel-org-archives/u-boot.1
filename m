Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F541E8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A68483B91;
	Sat, 27 Dec 2025 15:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JUdX3wJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C7683B99; Sat, 27 Dec 2025 15:24:35 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E833183B8A
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so6154061b3a.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766845471; x=1767450271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WbW3NmzmRQCHy+IV1Hg2zMVO0NjyHy445th0Uwq7mYk=;
 b=JUdX3wJI2GBbUG9bf46j+YgegtavvEhWW9yN0mKVuhZnppcVroeCd8eJPW+9y7R+0a
 MFwmiwPSnt20kZ99mycfg+FH8EhlkADkwixB+LCO2Nsby+5131oLSKknzPoTC6Uoqwdn
 LhKNpS6biKK9FhSoGqAUCn7Fh6BWEdTJwTZtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766845471; x=1767450271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbW3NmzmRQCHy+IV1Hg2zMVO0NjyHy445th0Uwq7mYk=;
 b=bOtpENVBm2r/qFNvt1lzvQn4FzJyazD7v0ROl7qAOGTOPGrcTzbamzTDSLiI2NalII
 69rbS/d8cslQCyLSNskHD/G7prxYY8SnkSci0bdd1GaJ8ar83nV1G/m9/21+n1N6wxe8
 ZgpbIcNJ/lYI8LJX1VQOt9K1jwrNqGgZ7cS412n3xVVWfjM7krFctLbVC25vUAgqnIPh
 JjPPeFODd/nXSxAA9+k5fOUPqnmMCpVOQ7p6Wemab4HGaea8eAxVhjx3g6xkoxBylwfE
 zd5Bb1fV5ANTMxgGBIbRC2ToL/1w4y46wiLkJCYTaS/OAK7sujfPh7UKQoiU8F+hdZAO
 gIxA==
X-Gm-Message-State: AOJu0YxDRIW9gi9cYuVzWuxdUmaF5OSyu6b72/xvu8r4arXxumeYaFDu
 hJrpw9HhUal1Rb2YqMqa1mTYsdQC5GGr946dGJ5OKDu09e9JJirMO5VlKw91YodqcwCMB3Ud1cm
 DC0mV483o2Gn10XSgSmMhXvuKeILiA9gIMCwDFtGL
X-Gm-Gg: AY/fxX5zhlcPfrAMUaHk4Fg7ppSRmB3oT0C+D2G1IPC0EbTJXW1aXwK4S1xIiRSdYYT
 45JdbdvlgPr2mm5k/xTPLM+BDtVPsHx0QudCobVsrlQFZEosEZIRTb4efvLO/J2xpe75tmTT7tt
 lGsBRqreTNjVLtBVmmk/YRvfvasuSZG13xgx0axqWoNhYWQtlodoDHruW6TfdsfSPoIRb5CSfG4
 GH9Usg9mzteQSDMGLGudg3MyS4BpRUQXQ+L8Bu/D6iZMpcCNUFEfLBSh0u4r97Zhgygrw==
X-Google-Smtp-Source: AGHT+IFKnrw2PBOgYdh78lyVLTEM1xkUvg7WMTnaF1dKredLlgGq68P48bopQUR/m6PYikBZMUqqLV+4Lr9LPNo/AGI=
X-Received: by 2002:a05:6a20:3c90:b0:361:4f83:10f5 with SMTP id
 adf61e73a8af0-376a96b9ea8mr25394764637.48.1766845471358; Sat, 27 Dec 2025
 06:24:31 -0800 (PST)
MIME-Version: 1.0
References: <OS7PR01MB13834F194560C2E3E4361E252BCA1A@OS7PR01MB13834.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB13834F194560C2E3E4361E252BCA1A@OS7PR01MB13834.jpnprd01.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:24:15 -0700
X-Gm-Features: AQt7F2qnjeYPo0D245qjJGTEWnsXgkCE4nTiGwsygl_p9xXnGT1l2jzqvHWCDv8
Message-ID: <CAFLszTgZGmmwD_YgCF6N8h182eD5EvKhjrBC4V_OzitFrUEOCw@mail.gmail.com>
Subject: Re: [PATCH] common: cli_hush: clear Ctrl-C pressed flag before
 exiting loop commands
To: Shiji Yang <yangshiji66@outlook.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
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

Hi Shiji,

On Wed, 10 Dec 2025 at 23:39, Shiji Yang <yangshiji66@outlook.com> wrote:
>
> If the Ctrl-C flag is not cleared before exiting the for/until/while
> loop, the next loop command will be unconditionally interrupted.
>
> Closes: https://lore.kernel.org/u-boot/OS7PR01MB138341D2719717E66B069F33FBCA0A@OS7PR01MB13834.jpnprd01.prod.outlook.com/

What is this, please? The link does not seem to work for me. But
really the detail there should be copied into this commit message, so
we can see what is going on.

> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  common/cli_hush.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/common/cli_hush.c b/common/cli_hush.c
> index 7bd6943d3ed..ec07bf6b3be 100644
> --- a/common/cli_hush.c
> +++ b/common/cli_hush.c
> @@ -1798,6 +1798,7 @@ static int run_list_real(struct pipe *pi)
>                                 /* check Ctrl-C */
>                                 ctrlc();
>                                 if ((had_ctrlc())) {
> +                                       clear_ctrlc();
>                                         return 1;
>                                 }
>  #endif
> --
> 2.51.0
>

Regards,
Simon
