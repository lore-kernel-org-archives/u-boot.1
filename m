Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0417BC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 07:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77F485C98;
	Tue,  7 Nov 2023 08:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z3aEAH1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D4D85C98; Tue,  7 Nov 2023 08:34:11 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC65B87116
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 08:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32fb1d757f7so2861487f8f.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 23:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699342446; x=1699947246; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEZJAoYxQVXOUJg8i/jb/0+KnNuIJVzR4qQaTAb1kvc=;
 b=Z3aEAH1uFp977LwAyCW7mq42TsHBeBV2TIbEqKtenCKvXqsvpUimQHp/B4t6RJHwEC
 r9nGd+KE+hJVk8g2a7Yt6mPpunVOMkUesc+zSqULF+CDcNTcMIUlpJo2O5YSU6jH/Dhi
 v8IH/MANjMeWUR9n5I+Wyv5mJI+f6wTjqXiQ7krAVBTzUgepHlO5BfBDFAQ3ti65PvPO
 E1vRVvVtWfir7IuJcf66pLWuYDibw2x2S/ZBIV2fevtO51TJ9uz3lO/tgrl/zAuNZwj9
 0vrp2gE4BB3jtbKDlbkcJTkqjnZT4JCk8BtZdqVk+ew82SlM/kqIck/zWrtblnom19Td
 KtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699342446; x=1699947246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEZJAoYxQVXOUJg8i/jb/0+KnNuIJVzR4qQaTAb1kvc=;
 b=Q9MwKpeFZKdlkExS0BnFFVmXPnxVuSi9dus/ruU8OhYSkYJs+Q0Zkzf0Zeh6m3PV/3
 Xh3/6EzxM2Na/tvqGQ8TLAYGUQ67dxLSEtNkhiaQhd/fsTJAzoKqaYVoVGeW7orxZHtO
 3NhRW0OopLCzfHH7YPD7yxiPujxVsSAJTkBnAjdiZMII7+l6MTfmFRt+kM9B7Cghc8wo
 0j8J1p8LQXaAw8gTudKEnrriE2nyJr6exWnSquxpQJovymNAn/xqXVgwp4nPIl+VZkPY
 WsJodKZgGUtN57jBITget0epz43fbCSHPbvw9iKkle4sXz5FmkgCRF1W8OkqyN48zwaf
 EPgg==
X-Gm-Message-State: AOJu0YzY1S4ExIpfXMWMR6XhjCWzglvHXt6W6WjJ2ckUZYie9+fWWR7X
 gLMiOS2rAg+AYNWMiBkYd8so92z6Ukgco7JLOR8=
X-Google-Smtp-Source: AGHT+IFMDmoHREVFOhgqnTPpTHNnd6rlrMX3R18pQb2L1+m6sLClT4CblshgdqmnhIp81VL0UtvH3P9jRkrnjMb2Qb4=
X-Received: by 2002:a5d:518c:0:b0:32d:d756:2cd3 with SMTP id
 k12-20020a5d518c000000b0032dd7562cd3mr23166348wrv.22.1699342445875; Mon, 06
 Nov 2023 23:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20231106090046.258589-1-clamor95@gmail.com>
 <CALeDE9MbigiaW-c_4PABBp+=BJ7=WHmz6p25k-JL6Aq6mYJJDg@mail.gmail.com>
In-Reply-To: <CALeDE9MbigiaW-c_4PABBp+=BJ7=WHmz6p25k-JL6Aq6mYJJDg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 7 Nov 2023 09:33:54 +0200
Message-ID: <CAPVz0n0CDYtrTTXgiJCPXdMnSD9gnkWvYgGKMrJ03gD__TwWnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Implement GPIO cells for PALMAS and MAX77663 PMICs
To: Peter Robinson <pbrobinson@gmail.com>
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

=D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 14:00=
 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Nov 6, 2023 at 10:18=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > This patchset adds support for gpio-uclass to work with pmic gpio child=
rens
> > properly and implements MAX77663 and PALMAS GPIO cells/children as a
> > reference and to be further used in devices I am currently maintaining.
> >
> > All drivers are tested on actual hardware and confirmed to work as
> > expected. MAX77663 GPIO cell is tested on wexler qc750 tegra 3 device
>
> Is the MAX77663 seems more related to the MAX77686 PMIC, why is it
> being done as s a GPIO and not a PMIC driver or the existing driver
> extended to support this chip?
>

This patchset brings support for MAX77663 PMIC GPIO cell support of
existing PMIC driver, it has nothing to do with MAX77686.

> > and PALMAS GPIO cell is tested on tegra note 7 tegra 4 device.
> >
> > ---
> > Changes from v1:
> >  - isolate PMIC GPIO cells parsing behind enabling DM_PMIC
> > ---
> >
> > Svyatoslav Ryhel (3):
> >   drivers: gpio-uclass: support PMIC GPIO children
> >   drivers: gpio: implement MAX77663 GPIO cell
> >   drivers: gpio: implement PALMAS GPIO cell
> >
> >  drivers/gpio/Kconfig                |  16 +++
> >  drivers/gpio/Makefile               |   2 +
> >  drivers/gpio/gpio-uclass.c          |  19 +++
> >  drivers/gpio/max77663_gpio.c        | 178 ++++++++++++++++++++++++++++
> >  drivers/gpio/palmas_gpio.c          | 132 +++++++++++++++++++++
> >  drivers/power/pmic/max77663.c       |   9 ++
> >  drivers/power/pmic/palmas.c         |  10 +-
> >  include/dt-bindings/pmic/max77663.h |  18 +++
> >  include/power/max77663.h            |   1 +
> >  include/power/palmas.h              |  12 ++
> >  10 files changed, 396 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpio/max77663_gpio.c
> >  create mode 100644 drivers/gpio/palmas_gpio.c
> >  create mode 100644 include/dt-bindings/pmic/max77663.h
> >
> > --
> > 2.40.1
> >
