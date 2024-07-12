Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CD0C3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 17:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F5488667;
	Fri, 12 Jul 2024 19:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J373hMQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECE2886D1; Fri, 12 Jul 2024 19:28:30 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55984885EC
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 19:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f40bso3028365a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720805308; x=1721410108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8MaZExMXvJuh1wPFGc6JWmvyK0t8DkYxWIXXaVNqB0U=;
 b=J373hMQg7H39oe/dAeu1BDqUljMH9kY9/1JvCuT/QRxpgVFMY4bLGQCUOrlFolJbDf
 EGOsXqsXzqjeuCAvbyI6HogIYoasf423FkEheqLCfF8TnXoSmz7arW26Kb9SnroorIhn
 L97TDAZqFoQDZGBT/TtqtA2AzplwaXlP27j2BxgQjpM2tzRWYRX4nVcBH700++e2z/qO
 n5Ix09Ii6GppwhGdAt2uhAMGTMi75nUtRDf3rXpQDQPuVwxYg52FwmWU+NHGo2ULlq4o
 ZqgRv5jsJsaZSy84JXYsyQb9vZ6BmQW8n0M8drF5XBh4qnAY9X5GXimflUw5JiqYvwD+
 LvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720805308; x=1721410108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8MaZExMXvJuh1wPFGc6JWmvyK0t8DkYxWIXXaVNqB0U=;
 b=ABgdHNSdgz13HvMi3+DewEqr49zJbIaZx3QKZ6XEyA7E3EuHrdcBzXrtJsvq9KuyP5
 SLQL77/pA75Um6V86LDdobKYBT8WohzSK9abLgXizClz37p6pDsIH9MQepqZgm91dZoQ
 iDGNKdpIPBuXfpE4xdCaIAu6jjqdWtSApTwVrvlcp29sVuybsC4YW+Qy5jJuy4UZ1Dmf
 ZCfg259X/FJLeYqZdzN+t3qlsI5tTUA9nFQp9qGftmluVQPRF8GvV9VumXuI7atld7lp
 0iS2MbsurhqsrFCc7LsLRUdQaWmrCrTNoK86c9WADFnZCsuLXvMrfYr/CoWHhjKL+eCG
 gTfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVabMm/yjG/GblKUtZ40rn4eY6XSAlalVTm/zmH41wNxnCtyD3rYGkA8n1LfTA/0r1DBAlsT/zd2Q555n3C0fXykHO+vA==
X-Gm-Message-State: AOJu0Yxo71N872qaAdse+NkK3jPfqbzyiEoV8IFOhZ1XL5esB1DBFO+a
 wfUUM+oVgk/UtgxdRQyRIfVybXKsCEViC9/R9fNi03bDXy0qRZQKFun6doSbPFXPo4UrTDih3US
 pa4RLt6vTFc6F+8c1KTI/oradSNE=
X-Google-Smtp-Source: AGHT+IEhgCli86tB678iz7UOQ05dPa3cWjBZna2e4YTHCJywt3MhyCupwd/PKLSVCTFN8yvwqf5VBVMgSZskOojqWxg=
X-Received: by 2002:a05:6402:17d4:b0:582:9fb8:11a1 with SMTP id
 4fb4d7f45d1cf-594bcaaf426mr7665883a12.35.1720805307426; Fri, 12 Jul 2024
 10:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240712171457.3104804-1-mwalle@kernel.org>
In-Reply-To: <20240712171457.3104804-1-mwalle@kernel.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 12 Jul 2024 18:28:15 +0100
Message-ID: <CALeDE9P05YN092mYQ15Kha+1sd6Yp97qkk-ODMyXASB2Ae_SVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] spi: sunxi: Improve the loading speed
To: Michael Walle <mwalle@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de
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

On Fri, 12 Jul 2024 at 18:25, Michael Walle <mwalle@kernel.org> wrote:
>
> Right now, the maximal transfer speed from an SPI flash on a V3s is
> about 240kb/s. That is pretty slow. It turns out, that due to an
> error u-boot is setting the maximum frequency to 1MHz. By fixing
> that another bug is unearthed: one cannot set a clock divider of 1:1
> due to the handling between CDR1 and CDR2 handling. By fixing that
> I achieved loading speeds of about 1.5MB/s.

Minor nit, should the clock fix go first so there's not a regression
if someone needs to do a bisect on the first commit?

> Michael Walle (2):
>   spi: sunxi: drop max_hz handling
>   spi: sunxi: fix clock divider calculation for max frequency setting
>
>  drivers/spi/spi-sunxi.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> --
> 2.39.2
>
