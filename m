Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F4DC4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D7D786C33;
	Mon,  6 Nov 2023 13:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="amfWF7Yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D34C86F8F; Mon,  6 Nov 2023 13:00:26 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2B48622B
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso8776567a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 04:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699272024; x=1699876824; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+0RIXPxL7Rp6gRPd/VahNJjbO3PV+JFdmpM6YRTG/U=;
 b=amfWF7Yf4JFtnIFRBHou1m4omhQBKwqrzT1oX/RbWIU+mqw355zCkFzwZsW2f2zDwf
 RWYqE7lqislJJhCABw/SCM+LF//wLm5bdcRcrbwdlcW5uW/NUwII34jZgW/7usYQW9N1
 W67+1qXE5Tb4OWEHsW7lAXzKvzCWRyYnfNAaDrlhpukbDb/Cvf6+gfDw5SKbQz/HHz1z
 hUdvyBtNmPNBd8WTZTZakBg+Bv7F1uc0kTVhmuTfgjXoLnUwXx0RStT9Ll7Hl7Suaskn
 58H0R1oXNQx/hRK5RD+kuQaAgMsamPuIqDJmZoO4jO+0r0t3qGCWlRU+EJ1Q7SkZYRSc
 csrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699272024; x=1699876824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+0RIXPxL7Rp6gRPd/VahNJjbO3PV+JFdmpM6YRTG/U=;
 b=efaKepJgaybU98kk1LaogKv4HwySSPSqSYiVHwK2q6qOWt/Hq2WKShu/hvdHVYiwb+
 W+3b65QIJnG6s07nkQnWatEF91tb7g9zo0clME+DhoWzY57+/bDZuZ6o+JLqWaI/cIbL
 M9VGQ+kTA6gHbduw27IXpcjoOUKPXEt0uZReAugG+4dwraivizI9e5T2uL1pzWbswdxS
 HzlYhecp2D9NohltNYKWQJv/whKDn6GFteBFxR4bfA8+FtycewO4RYAzSSnKTaVzS3pK
 Q4L7m6yzdtBseQTQIqgJ6Ayci1pRCjnaereDZnpJNzhH8vJFNd2EnRWFFt8jwD+Puntj
 05RQ==
X-Gm-Message-State: AOJu0YxoJgQwnAUvT9JtGektHXJlLmKu0wIaCxpubsrMUXi6gCyoiSRO
 +hBEaAy0LhzGMM8kUNXnS0t8uhebL27sYAqvlgU=
X-Google-Smtp-Source: AGHT+IGFkWcu/zcoC8ItQzUIgVgqLUTNKtL2njHQUQNHT1TEkIJ16+OSxROp9eWfpng6Ig6Uzhe9Ji6GuSC3w5Qorss=
X-Received: by 2002:aa7:c75a:0:b0:533:5d3d:7efe with SMTP id
 c26-20020aa7c75a000000b005335d3d7efemr9244622eds.6.1699272023672; Mon, 06 Nov
 2023 04:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20231106090046.258589-1-clamor95@gmail.com>
In-Reply-To: <20231106090046.258589-1-clamor95@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 6 Nov 2023 12:00:12 +0000
Message-ID: <CALeDE9MbigiaW-c_4PABBp+=BJ7=WHmz6p25k-JL6Aq6mYJJDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Implement GPIO cells for PALMAS and MAX77663 PMICs
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Mon, Nov 6, 2023 at 10:18=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> This patchset adds support for gpio-uclass to work with pmic gpio childre=
ns
> properly and implements MAX77663 and PALMAS GPIO cells/children as a
> reference and to be further used in devices I am currently maintaining.
>
> All drivers are tested on actual hardware and confirmed to work as
> expected. MAX77663 GPIO cell is tested on wexler qc750 tegra 3 device

Is the MAX77663 seems more related to the MAX77686 PMIC, why is it
being done as s a GPIO and not a PMIC driver or the existing driver
extended to support this chip?

> and PALMAS GPIO cell is tested on tegra note 7 tegra 4 device.
>
> ---
> Changes from v1:
>  - isolate PMIC GPIO cells parsing behind enabling DM_PMIC
> ---
>
> Svyatoslav Ryhel (3):
>   drivers: gpio-uclass: support PMIC GPIO children
>   drivers: gpio: implement MAX77663 GPIO cell
>   drivers: gpio: implement PALMAS GPIO cell
>
>  drivers/gpio/Kconfig                |  16 +++
>  drivers/gpio/Makefile               |   2 +
>  drivers/gpio/gpio-uclass.c          |  19 +++
>  drivers/gpio/max77663_gpio.c        | 178 ++++++++++++++++++++++++++++
>  drivers/gpio/palmas_gpio.c          | 132 +++++++++++++++++++++
>  drivers/power/pmic/max77663.c       |   9 ++
>  drivers/power/pmic/palmas.c         |  10 +-
>  include/dt-bindings/pmic/max77663.h |  18 +++
>  include/power/max77663.h            |   1 +
>  include/power/palmas.h              |  12 ++
>  10 files changed, 396 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpio/max77663_gpio.c
>  create mode 100644 drivers/gpio/palmas_gpio.c
>  create mode 100644 include/dt-bindings/pmic/max77663.h
>
> --
> 2.40.1
>
