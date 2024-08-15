Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F19CC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E55788C24;
	Thu, 15 Aug 2024 22:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JmnyKTtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8C788C31; Thu, 15 Aug 2024 22:33:20 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2709A88BFF
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d1ecfe88d7so1009885a91.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753989; x=1724358789; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdwbv6g6Yf98huaqtU6RLW5BRy59X6I+oCQQUZsDi4M=;
 b=JmnyKTtdfxEeGJ1yPIdxo1w7KYxlqSGeH70gfk0yGB5MTQeco+cNSnldm7jvAUwkkD
 mZdlAvfPjZp4DLKDOoQwOv3numXezJAwHHuSWVytBbtPt2nWZXyUt5QzU7LQWvKvm+I5
 XJmh4USEIM74wyxcL74D3O+b6GG1gJqq+jUdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753989; x=1724358789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdwbv6g6Yf98huaqtU6RLW5BRy59X6I+oCQQUZsDi4M=;
 b=D4gT/aixaKimVShctYs8a9E3xwfJhGoI4CN7Xa34gTvePVyGw4gSDeBe5owBjpujDh
 CWHwtPxlxBkso+6q92ZsYY4TiXHPo3SiOfXuTN5VlDf3Cz+kXATcsa+Nl67Db48cc85l
 2SZHKaG/sEotDpKWglt/WPt2pu6Swo83CA0u1i57TxRndNlDKVe8ZFygtEvl+xvFbzXp
 bzikfXoftAX6SKnY1XLPlSK/iT/UnsXkbkig2Ihrbyi8zVU0DVwhMO0BkrJKTIBABEsX
 DrTnSgWR9CL+GUHtqQw8CMgybUzQihIU1OfKwNnh58HATUVHqibDIDZ8JxcmeinjxjmV
 VohQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIw5jMuxMynPGoHNxGaTME7NovzWtrjk6Xrx218DlI+Duh1jHBXNQhTIEHUSupqmNdSFWz1fPh2b2UrlS3ePsEe/J+XA==
X-Gm-Message-State: AOJu0YyFATnF128VIJW2OmHRC+pU5D8h5iRiuD6Bp2ZAA8i7BLz441mI
 7ww7cPsGeeRGj49Or536+H7E2Lowa/isvMG2uAWPb7AX6Lds3Wkp2JcBMrg/EtDmpWcbq24149B
 +VkNj1AjXqcxosVcuLJrh87FCZoLWnyO+IjTC
X-Google-Smtp-Source: AGHT+IFXxGu8YTdfdMYziQZgk4eWz4bILJqYdvpztgyqTcjtLZQQbyQBPPFXkI2BLSyq6TLsFgNEgeV/HIHea+P7csM=
X-Received: by 2002:a17:90a:c28b:b0:2c9:96fc:ac52 with SMTP id
 98e67ed59e1d1-2d3dffddd10mr996616a91.26.1723753989190; Thu, 15 Aug 2024
 13:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240815082101.15612-1-emil.kronborg@protonmail.com>
In-Reply-To: <20240815082101.15612-1-emil.kronborg@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:32:57 +0100
Message-ID: <CAFLszTj_qsyRLvkUa-tNPWh0hcVpFWw8CsdLrs-JPNuE=BgGpw@mail.gmail.com>
Subject: Re: [PATCH v4] doc: document the pwm command
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: trini@konsulko.com, heinrich.schuchardt@canonical.com, 
 quentin.schulz@cherry.de, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 15 Aug 2024 at 07:29, Emil Kronborg
<emil.kronborg@protonmail.com> wrote:
>
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
> ---
> Changes in v4:
> - Changed license from GPL-2.0+ to GPL-2.0-or-later. Also, removed
>   trailing colon.
> - Simplified the descriptions in the Synopsis section by removing the
>   text following the '-'.
> - Reformulated the description of the invert subcommand to be more
>   precise and correct.
> - %s/duty cycle/duty period to be consistent with pwm.h and to ensure
>   correctness, as duty cycle is dimensionless and <duty_ns> is given in
>   nanoseconds.
> - Moved the common parameters, pwm_dev_num and channel, to the bottom of
>   the Description section, and added the remaining parameters.
> - Added a comma in the Examples section and used '=C2=B5s' instead of 'us=
'.
> - Rebased on top of master.
>
>  doc/usage/cmd/pwm.rst | 91 +++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst   |  1 +
>  2 files changed, 92 insertions(+)
>  create mode 100644 doc/usage/cmd/pwm.rst

Reviewed-by: Simon Glass <sjg@chromium.org>
