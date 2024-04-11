Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9C6C04AB7
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 13:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 282CB882A1;
	Thu, 11 Apr 2024 15:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NEZ8PH2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204A1882A1; Thu, 11 Apr 2024 15:23:41 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310E58332E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-516d536f6f2so6915569e87.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712841818; x=1713446618; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EWNk4NbKuJqXYmL1LyX1Lv0d8l3BfwA52j3xyheLFy8=;
 b=NEZ8PH2TfxesaAQ3eva0GV9xK4enBsxsNzFexRYO0f+F0W5EpETluwsMDzdiDoTwN3
 GjSd5rLBAp/90ktFMr6K7qU0Fglg+QwNP+FoTOMfULIzvlNNOouN9if8l/9X0FIyU3Jv
 4tO1+d1zwKgmGiKMKLHyNPfTRfGt+qR6PfUTsCSKg4VwAdrYJDRflFUQXGmd7KF+/07V
 cIkeF8Adm2zufZ2QWwUvA9wc6xFPxRbzfrA3VKsvD20MB2mGWzOhbxzodnXqCNDQV0xu
 RRKba47+CvK255wST6PFH6Qj4uy0GfuQknxLkmLqTh5LImBRl5Zi20sd1JyRvH/Q2+NZ
 aJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712841818; x=1713446618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EWNk4NbKuJqXYmL1LyX1Lv0d8l3BfwA52j3xyheLFy8=;
 b=W4fIYPYicKILd2/wDzXJdPcg1UAVJmTLMB91fh9Rp2pCOTE3Na6VhFJdPs6pf/0cFh
 593spegHhUMcJ/i8hiWHCTzcrBIf8bqNFSmPuabUiOkR08OLrfIaRVBrIxU5kjl1oBnI
 P8u2PKG+tkKVhRPa4JEkbEZTEdx9rYUBLxAYhqh1fJDPn9S7vdzjLBWllR4VB6NG8vuu
 x+PWJAOqKc4ULURXCoavmHlUBvUePxXHi0jgvRjsrtxFo84HtB77ZCocAhpCKtOIZyh+
 fCR5iCVDXiHqhhLFXZXvfJbRsYyZ95MKd9UH9NDK383MX8w7p4Lhm17LWCo0aEcdcvj1
 eR9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5NkWLmdH9mIizE5iktBwWDg7PeUbXhWP4aW5u3Nd6+/GLwa9nq1ZeW/fSkNRxWs1Y2xKQIX+I+p3aYV4JxAp7za9qYA==
X-Gm-Message-State: AOJu0YzD1rVLkirncr4kWWWjC2sJwS8CWZGq/dTMghV9ut32V8mmVPNT
 PPu8iH1Nas2hPIgAptGiXB5hTtZg7lVgmouE4n2PGYW9DkbXoAj34GyS+OrDb0seyOe+q9wX4Fk
 Y33Tvg+HgDU+DAq/Bk2x8vP/5qKP2ParoGEX5lfwqxzoXtzCjVTnrew==
X-Google-Smtp-Source: AGHT+IE4jUPSAOljhW5/oYQEfrztVui5eApGGyqtKN3DrYVUrkqYZl1cBh08Fith++jhr6sGXbFIgA5MqG+fg4h5m7U=
X-Received: by 2002:ac2:5192:0:b0:516:d04f:b58e with SMTP id
 u18-20020ac25192000000b00516d04fb58emr4094289lfi.30.1712841818374; Thu, 11
 Apr 2024 06:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240409180456.39581-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240409180456.39581-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Apr 2024 15:23:02 +0200
Message-ID: <CAC_iWjL5NxUq4XTrWAM1ja2xnYbbjUj9VOxPqbEh9eCSCRMDCg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: fat: convert change month correctly
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Tue, 9 Apr 2024 at 20:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The month is stored in 5 - 8. We need to shift it by 5 bits.
>
> Cf. Microsoft FAT Specification, 2005-08-30
>
> Fixes: 13c11c665320 ("fs: fat: add file attributes to struct fs_dirent")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/fat/fat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index 14e53cf2d5a..2dd9d4e72dc 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -1254,7 +1254,7 @@ out:
>  static void __maybe_unused fat2rtc(u16 date, u16 time, struct rtc_time *tm)
>  {
>         tm->tm_mday = date & 0x1f;
> -       tm->tm_mon = (date & 0x1e0) >> 4;
> +       tm->tm_mon = (date & 0x1e0) >> 5;
>         tm->tm_year = (date >> 9) + 1980;
>
>         tm->tm_sec = (time & 0x1f) << 1;
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
