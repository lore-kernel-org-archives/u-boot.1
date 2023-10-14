Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D44FCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FEC86F1E;
	Sun, 15 Oct 2023 09:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ef4DyjPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9163386F1E; Sun, 15 Oct 2023 09:22:04 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7319686FAF
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32da7ac5c4fso651507f8f.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697354488; x=1697959288; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ww3JHLhyJZ4AnzCsx8RF2cOhvATK4y38QyVl99tfrFA=;
 b=ef4DyjPyoTtK/lu9AYDD0iLNgOvpns7bpNfPpM8xmzsKRQZZneFD0nB4PFgB5OtWwV
 T/rrusZmI2gfv4uhNT++ZJsnC5nidNljP/XGPEqstWQB8r6oe+K/0ZzpvM7CA0ODGdU/
 /PaPl3SpFHme4zOkerKS1g9/IjiIXd+bWH1MhVUoiZYZ2JwjvW+Whz1UfdRNhITkWPc+
 IFWNzDuv9WSjYkcANT2QS1vv7qgXQFCxFFTSNQCqReekva53ErFajwINWhZI5R0NsaHF
 /9RZT/fHPL9XRllRdK9QIDEsKsV0Zt3qUacv6rGe5hmhSj9e+Xc1alLY5k+VhK5DFs/c
 6UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354488; x=1697959288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ww3JHLhyJZ4AnzCsx8RF2cOhvATK4y38QyVl99tfrFA=;
 b=IK0QLfbFZhKF93C02z4QBx2cQdGCqjyYXyZmyZ/WpRrj8mKIRm1nTGD7Q6dZ4uDSUk
 nnWDIrnssNL08PDek1pxaH/pH8bcK766tOK+OhBnSpjfssDUzfoiGHUfGbOM+xCjG05U
 axAreBmh3TSjqMMErcqcOwGVksadtjbVS3clsjCtn7s/Flx8C8ASQjQSNgfmQMBZRFr3
 /33voXSftnGVwiH7sEMSNSYjk9gsEJMsqv9bRU9WvFX3qJCCpeKZmKJoN4e9b9Hx6uuG
 /2Zjad8IBHXFvyT+OakWQJ4jmIMJU+UtMTVEirf28DmRyFjlWzDg663rP4Erx4GNPA/R
 Eq+g==
X-Gm-Message-State: AOJu0Yz7vrE+V8OYbct6xg6OIdQZnOSexgbB8kGZxS3jovlyoMAkavon
 5BAf90BDlAr0W0F8JGMDEXWfI6Ay/7K9WP27sjKqL0i8GIE8QXDnGKQ=
X-Google-Smtp-Source: AGHT+IGpwIV6OO/9sVQxC5EN+/Y6ZUqA8tPgxDfINPenPFc6HdKLXxyA+9dmcY9bxRZnbNEWEYD4r461HyG1k/52LaU=
X-Received: by 2002:a17:907:d1a:b0:9bf:990f:ea11 with SMTP id
 gn26-20020a1709070d1a00b009bf990fea11mr538306ejc.19.1697307600619; Sat, 14
 Oct 2023 11:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231013130411.46569-1-avromanov@salutedevices.com>
In-Reply-To: <20231013130411.46569-1-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 14 Oct 2023 12:19:42 -0600
Message-ID: <CAPnjgZ1n9F5CdB3KQHsaC0WCn8bkP24YFV7Z23Y3hGyzYgzo4Q@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: don't compile Secure Monitor UCLASS
 unconditionally
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
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

On Fri, 13 Oct 2023 at 09:57, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> It makes no sense to compile Secure Monitor unconditionally.
> For example, this break the SPL build on boards with a small
> allowed SPL image size.
>
> Fixes: 126fbbefd89e ("drivers: introduce Secure Monitor uclass")
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
