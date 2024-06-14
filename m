Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC77C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07DE988BD1;
	Fri, 14 Jun 2024 13:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="alc6r4ta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C02288BB5; Fri, 14 Jun 2024 13:44:23 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D086388A74
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ebeefb9a7fso20871921fa.0
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718365454; x=1718970254;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GwsIREMSR3J5Qczzdsjhpp/8Cftc3bbr+/x7T5/TXjA=;
 b=alc6r4taU527Jk9ym3FfGolu1z2HskHsGCh4w0z1zfbqzf2zGx74DqNA30UrIwzyf2
 /Ork7wbJ5UplFSNk6SsEzGQoTShQI3zs/IdnrtVViRfVxZCm4nGiKXIrimEvn9oSgMbG
 Z6OoVq883Ttd2mRq+bq1+UQhLGHFIHtMKQumSZvDIVtn8QmsC8M76Zt0SHjuqYvwIC4i
 z1UfSV5rF4mMsJuUhiMEspIqkJvmc8CHECcXEHfe8L4+y/sRqpLjM7m8wBJpWtTaFZN3
 qzrcULFG5qOY5M9xzvBNl06nvYLxoo94gEUJUu4Re2qgFChkxu8OWpQMyPEcBUhYwC7d
 SKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718365454; x=1718970254;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwsIREMSR3J5Qczzdsjhpp/8Cftc3bbr+/x7T5/TXjA=;
 b=NFxIoBdxmERUbOIt8ovC3sAaxIn4RcLK5/024BASxGO1TTbW20Zy0UzkGT0bfT/w7C
 s3pJJxslwNd6Vt4ZWa9i5H8n7JGdROO/XmmeXC/Mtxz07zZ9jyI40FEvjvMBCpDjmjHq
 YCJVCq5eqiL92kIA8Hljh7V0Q2PXbKXrgqA5OhsT/XOvcnkVmw3ERo7J7xyUtqedEbFf
 ojnYPmrRvcLRJN4Rfd4mEn4Jpc3jXxLQZ0T31PJpbdZDzPwvGq/zY43gf9gLhgTk/yqE
 +DpQR/COfoQX2AQmRioqCafKfTm6c1wfmFpiGo4h4RzB3aS6TN+H0zspch0s0Mfk/FR+
 S4Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxmEOILAmudei8NDxfHBYGm7vyY5NSezDLgBls1PTrAvfd/T+UH5XzH7MbzNR+5LqdiN9Jkzb9M7iAsbtoJ3lJ3Tt4nw==
X-Gm-Message-State: AOJu0YxN4beIUsAed7dGAegOKhlW5yOXTmHXOe4HiqNnjR+UCa6s2eat
 qP+/jMp/bHjiv+L58Myw6C51CGWaLcHC53jONTNaGD5348L12cXhUjJi9y6W0tI=
X-Google-Smtp-Source: AGHT+IEC4V6zWGD8l/9iD0cpSY2xStfrg1asvbmG6BZCsDQvFPsZq0YCV0ipsWAq6vd6gw5DB2YC1w==
X-Received: by 2002:a2e:3c0a:0:b0:2eb:d798:ba7c with SMTP id
 38308e7fff4ca-2ec0e60e234mr15933721fa.52.1718365453808; 
 Fri, 14 Jun 2024 04:44:13 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104a48sm4218266f8f.100.2024.06.14.04.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 04:44:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume LA ROQUE <glaroque@baylibre.com>, Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Roman Stratiienko <r.stratiienko@gmail.com>, Igor
 Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/5] bootstd: Add Android support
In-Reply-To: <6de699be-37f1-42fc-a38f-992e79a8e77e@baylibre.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <6de699be-37f1-42fc-a38f-992e79a8e77e@baylibre.com>
Date: Fri, 14 Jun 2024 13:44:10 +0200
Message-ID: <87jzirbvg5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Guillaume,

Thank you for testing.

On ven., juin 14, 2024 at 11:53, Guillaume LA ROQUE <glaroque@baylibre.com>=
 wrote:

> Hi,
>
> i apply=C2=A0 patch series with commit you give in cover letter and test =
on=20
> TI AM62S-SK board.
> Android boot properly , just with a small changes in uboot eenv
>
> setenv vendor_boot_comp_addr_r 0xd0000000

I see.

Thank you for sharing this.

I can confirm that this is indeed needed on next since
da3447d09fa0 ("android: Fix ramdisk loading for bootimage v3+").

Will take that into account when sending board support using bootmeth_andro=
id

>
> this changes is need link to patch done by roman on ramdisk and vendor=20
> boot loading.
>
> so you can add for this series:
>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
>
>

[...]
