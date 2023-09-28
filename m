Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC6EE810DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 02:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219D386B95;
	Thu, 28 Sep 2023 04:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k649as27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F5C86BE7; Thu, 28 Sep 2023 04:41:26 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1566386B3B
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 04:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-503056c8195so20657708e87.1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695868883; x=1696473683; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BbPwaxG84lzpsPxFo8xub7ibu0dOqWI4eirfkdgPFAk=;
 b=k649as27zE5lBVvJ4Vuwrso0Z8ZRFP0Oq6zMSODCll/7ArMctTeTPVuRSNOqRq16vd
 8zavj6v58YAiAjVG4eIypJWFxZYJPzRaiTuWhrS3i8yqK8k0oc11zzqERCtJwkZxbPMD
 UYeRDgO9Saa1sNJIyLu+HvGjgKfdLF9TiZc38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695868883; x=1696473683;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BbPwaxG84lzpsPxFo8xub7ibu0dOqWI4eirfkdgPFAk=;
 b=p7kLRg/7mWgll/8xOysOQTDuANGurLP2n/zfSinUIXOluJ2BXc8GK93CNYL9JyryeZ
 ntnzSdsYzaYodEiEctF8yczWp/kGjrq/x+dIR8Cs+YwKyaH+xBjJ204S6jdH/V7TcmE0
 q9yGGLueXwEkPp1/DaL/g8yqaYg4hMkvza7TuW3JLaUlW9k3XFbWBkQxtS914H1Ofgx0
 loGCns0T7GBKvdx/z6C94QI5Py5wmkWXuJJUPjxMvZzqV2aOgAP1VTfz3KQASuWA9cSd
 2EMUGq1kWr+K9ZmKQd9rptuDKkGek6b2oZAwZkiWbWVWTI4FQThZ42KJqoqAh/hZVoLz
 P8rQ==
X-Gm-Message-State: AOJu0Yx7TbymkBhnkFKBtTfFN2qhG+6h9BFlL37q+6drANII5dG08T+b
 7MY5smmMjPcKVMY2x7l28IpERbOE2u0+LiLMEcdTW8NKkt2jE34bMN/E2w==
X-Google-Smtp-Source: AGHT+IHBuq3eBzD8QLLoOYb1RscpyCzalhJA6wB5JyKGQaHaFDRFkitD6RnBK+x5k/5k2rQzn/nhOntwP+2/rQpuwgg=
X-Received: by 2002:a05:6512:224d:b0:500:b74b:e53 with SMTP id
 i13-20020a056512224d00b00500b74b0e53mr4201181lfu.46.1695868882594; Wed, 27
 Sep 2023 19:41:22 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Sep 2023 20:41:10 -0600
Message-ID: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
Subject: SSE instructions
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>
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

Hi Bin,

U-Boot 64-bit on x86 disables sse, but when enabling Truetype I get a
compiler error:

drivers/video/console_truetype.c: In function 'frac':
drivers/video/console_truetype.c:30:15: error: SSE register return
with SSE disabled
30 | static double frac(double val)

Do you know how to enable SSE for 64-bit?

Regards,
Simon
