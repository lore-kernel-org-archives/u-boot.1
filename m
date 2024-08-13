Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E594FC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 13:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5398388981;
	Tue, 13 Aug 2024 15:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="udwvmAxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2102988981; Tue, 13 Aug 2024 15:03:46 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55D788842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 15:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-530c2e5f4feso5560436e87.0
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723554223; x=1724159023;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/cTq1/2LiUloVezOAlxvhr1V7ummqnW4uSbjN55tPd4=;
 b=udwvmAxswMB6h8UFWfcV6bY66OBeIx8hRRxVNYa8cqjwCieRTv0TDnsuyKB8g8Zf8e
 XucAw+S5hTOtU2IADuRmnJzDO8t4CDEjjxYStPvdPGJjQOtB7/ENLaiFlAN8gkGgl+fJ
 sRC12dvx9YMnsOsKVwQWxnhHZyiOtVQsEWwSC184FkAyL9coT6+KzWM4WcG8z9xnh7/F
 r4igT0k25PhzatIa6cgfHIncwLiAyWxzwGuSm2NzTt1cJuDq2kF96gAlmA89qECeGByV
 p6vBEY5PjbZxtHtSZNdtmPdcbyupqWChkAYuNcPXlFJsKqv5VqSuRe1zXPhqO7JY1L+U
 20Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723554223; x=1724159023;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cTq1/2LiUloVezOAlxvhr1V7ummqnW4uSbjN55tPd4=;
 b=Vi0L8lDepdIM9SQZudF8YauyRvpVT5K5ZMzu0akLWQQX4C1AKqO131DvGZwoebw+J+
 K983vupfa7acMpnCHctSXE7sPZzvcdIMP7p7SNt2cSsHdEKstrFS/5Y3Eq0mSgp9XeBY
 7GwMWOKpveT1W666wzZdWdQYwTflz/P4nC3MzqOtaX8QtMe46yVYJUYw43oZZNxe9ymr
 CX8tU0NkxIjEFuVZAC6Af37CthCLdbGUID0y1LdWHszYdLyITG3e1IjUXpozbF8MywEt
 wVVVY6uCtiBRDz640FNmTDUEk2+/kkGyfJbQmC2DgGwADb0PvzwNquQAWXfsTqRKZgV4
 mvoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV303EMKvxph78/5QWBlwLPmG9ipaxSs55ZYQsaSAxlE0QYbeFJt/oU6ZyjsCmUNb+RpNCEbrz3oMTInqbq6XyS+Cy2Mg==
X-Gm-Message-State: AOJu0YybkIGRNl0gu7aYEYebgqhcLRWuzSgvddzFor7iKYBZJPUKBsrg
 dELl2KmTA3Sv9iPjQagwhmIPa2tYLKnepTLz3Jhl+Pt7eMM0TndsijaIq1NHq1E=
X-Google-Smtp-Source: AGHT+IHUyCMeycgkEQLNITwoBg8uDYTeIxUXqKvRZe5376bYg8+CJVXj4sIem0CUv66Pebvp4Le/Zg==
X-Received: by 2002:a05:6512:3ca5:b0:52c:e047:5c38 with SMTP id
 2adb3069b0e04-53213657c4bmr1919551e87.15.1723554222523; 
 Tue, 13 Aug 2024 06:03:42 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429d877f822sm17373295e9.1.2024.08.13.06.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 06:03:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Stefan Bosch
 <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: dwc3: support USB 3.1 controllers
In-Reply-To: <CAOMZO5BWjyy_nuHaRKrh=ct9_e8JqfRZ6qtTmBG_r2-bpHMwPw@mail.gmail.com>
References: <20240423141551.2410199-1-caleb.connolly@linaro.org>
 <eb12b7f6-dba1-42ac-adb6-3c180d811130@denx.de>
 <87ed6ssj5x.fsf@baylibre.com>
 <CAOMZO5BWjyy_nuHaRKrh=ct9_e8JqfRZ6qtTmBG_r2-bpHMwPw@mail.gmail.com>
Date: Tue, 13 Aug 2024 15:03:39 +0200
Message-ID: <878qx0shg4.fsf@baylibre.com>
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

Hi,

On mar., ao=C3=BBt 13, 2024 at 09:43, Fabio Estevam <festevam@gmail.com> wr=
ote:

> Hi Mattijs,
>
> On Tue, Aug 13, 2024 at 9:26=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>
>> Marek, should I pick this up through u-boot-dfu or will you pick it up?
>
> This one is already in master:
>
> https://gitlab.com/u-boot/u-boot/-/commit/ef1e322f3e1d9a221a1ee6109f65714=
29ee9fb4a

I see. Since I did not see any "applied" message I assumed it was still
pending.

Sorry for the noise!
