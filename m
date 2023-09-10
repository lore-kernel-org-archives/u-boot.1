Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A3EEE57DF
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 15:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB45486C5B;
	Sun, 10 Sep 2023 17:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AZc/oQu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2092086C58; Sun, 10 Sep 2023 17:35:50 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5984786C0B
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 17:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-579de633419so35540607b3.3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694360146; x=1694964946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=udFxHH7rO+my7fuESkfxFdSK5Xpa70W9oaVh7RepJPM=;
 b=AZc/oQu4zFXnL2chWsep2xZOHBqRMZmYsiOHYwEAxcLARiJB+7FwLwAig9HZ5ZiBe5
 0rZUq1nU+wnMaLAVzgIsPt3v2Mxi8l5+7ly9vd3HP8V9n781x2b9/RH1blQHb3T8fgko
 OhTONHZfr4Gjc/giR3v9+ItAJqzgFVWAVvWp6zxBS0vFZzzxBLeiDIpNcclH1axydS8R
 eXpoKYaE8WL4v7km2xJZqovzCerurtD6Bf1CKdUFzq/esAaRWyU/V8ezv6ddr1Zhq7Yf
 wDnsdEYOv6fcjwz198M/ZFad8YI8+j8PDPfDASuYKQ4hwOtnb5hqWueam2+GN2+vI/Oz
 xJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694360146; x=1694964946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=udFxHH7rO+my7fuESkfxFdSK5Xpa70W9oaVh7RepJPM=;
 b=j2RFsKHYNG20cqWOGm7eSwCTdpdHBV8wMoTIHTgajczM3e8n82DgiS8o2H9ICT4kwY
 7/OrsP7lvmSwtZ7oOYH7b+um1BfxsigFMzMNSJiPxwMGPAETF1f1IpTrc0Rs5EjrmQWg
 ATukJaImSn9KPLTTwnOJxUpLxBsrhdA+Y3qYOFmho25Ct/3RFeTtzukjfskx/CCnFdh5
 shwnzX50EhpMOq8zrK+3R70RSeWQMTqp1RlUqpo+kl8bA5KTvc9RRGJVl1ql6f9wW+7h
 hv8o5h4is9uSvmkMz7xbbKpvjAlj6qlzrlZ/bO/D7lBXLX92Hz9VW0aJxDwPZDeG0mM+
 lIkQ==
X-Gm-Message-State: AOJu0Ywi/dtNyADmJ+FeYe5lKrO85ESeefSUY6S1KHOPemz2kLHTxgFa
 oekH8ggufC2qBvhfHdqU6EISbWnrtBOrit2QGyw=
X-Google-Smtp-Source: AGHT+IE19cOpmc3a8l+MjaJv4nS0Z+q5IJQz4mKmom0c25+AtA3ADaOFITFCCMScvU7So1doob3qDy9h8hqPtVxHZjQ=
X-Received: by 2002:a81:5fc2:0:b0:58f:a19f:2b79 with SMTP id
 t185-20020a815fc2000000b0058fa19f2b79mr7640573ywb.9.1694360145874; Sun, 10
 Sep 2023 08:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230909135235.21242-1-massimo.pegorer+oss@gmail.com>
In-Reply-To: <20230909135235.21242-1-massimo.pegorer+oss@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 10 Sep 2023 17:35:34 +0200
Message-ID: <CAC928HZipzfTmucsBOFeta+9od_41AZx7Ot9ErGs4kX0ACOMSw@mail.gmail.com>
Subject: Re: [PATCH] binman: doc: fix reference tag placement for Logging
 section
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon, Heinrich,

Il giorno sab 9 set 2023 alle ore 15:52 Massimo Pegorer
<massimo.pegorer+oss@gmail.com> ha scritto:
>
> Move BinmanLogging reference tag after section "Signing FIT container
> with private key in an image" and just before section "Logging".
>
> Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>
> ---
> Note that at the end of section "Replacing files in an image" and just
> before section "Signing FIT container with private key in an image"
> there is a line which seems a typo or an incomplete sentence:
>
>  Repacking an image involves

Any comment about this note? Should I remove this line in a v2?

Regards,
Massimo

> ---
>  tools/binman/binman.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index aeea33fddb..8945b19446 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -1482,7 +1482,6 @@ when it was created.
>
>   Repacking an image involves
>
> -.. _`BinmanLogging`:
>
>  Signing FIT container with private key in an image
>  --------------------------------------------------
> @@ -1501,6 +1500,7 @@ If you want to sign and replace FIT container in place::
>  which will sign FIT container with private key and replace it immediately
>  inside your image.
>
> +.. _`BinmanLogging`:
>
>  Logging
>  -------
> --
> 2.34.1
>
