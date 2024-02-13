Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE221C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0D487061;
	Tue, 13 Feb 2024 12:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIDTCf4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE8587D10; Tue, 13 Feb 2024 12:19:58 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32EC86F67
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 12:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-410826218a7so4098485e9.1
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 03:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707823189; x=1708427989; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrGpI2QCR1T3pU1vKQk3VWqSlnEJEUXF1Tc7cm6Hr6M=;
 b=hIDTCf4EVOLYzgNDDlHrcGDWansLtvny+bPNACbAzlmxK5GMqI0KimyL12TmlKPsU0
 K51Ztx00Qx3y8M72m6lxVlN4KBzsOdjVNZpOKNLzbHBIyvt+yaB6rKz8QbAhNHG6/jzz
 fPOH3fKUVYrCXd373hwT3+XqGU5OsxmwPb5u7dUetqQqHP5SOM0UULvsV40vB9MExpI3
 xb1LMPK6vQAjl0xRlrHXhorjqHz+IcMcVTvLz99IlMwhdW4OmTd2spjcwPgc63vuK8m6
 Cgz2zC6CkU4FUJM7S1QQ91xbDT3Z1gqriVeyDKeMNVfT7bxY6zjiyai3ckoPMj6gbxLo
 9RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707823189; x=1708427989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrGpI2QCR1T3pU1vKQk3VWqSlnEJEUXF1Tc7cm6Hr6M=;
 b=l/21kljBAAzisxsGUEQ7QZ2PpmT7GEuNVu2D8HWbBvFWlCCBJTy1BdMJEHyz8nQyQF
 3gPX0+0nEb4eLo1Xv7z+qwn+h4ch1UHMZuUgy/PTovLWTsB8Z1/ULyRJDFQU9X0MzQqH
 8Ul79GQQYO1ZMMFe1pMQypxkTMcu+8cZK52QWmhmOHBB78cyVZ0MOP248B/T3ahyrVvs
 mx8tFQlt9gLqmW7A7UMwxLQ8FViUS0k5iv6YoNMVAuZoHU9/HzKFM4KQnU3+9foLzItM
 ef9U22dqd8uILHtJYJZ/inIcK2a19Zq0NEZ6pdaRPN8JZ/6mDy3OWpKPz8Iqy9Be8Xmg
 jO4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWvgEQdlJlQ1yLamEtDbeIevp8QPiDoHHYrVRSgGTsCwJiOUFxPAQ/9BqHBD4FmLlU+TfqWZ9BjIyX7ZKkVk0XnTsO0w==
X-Gm-Message-State: AOJu0YyLfXkf2OtUEOxlDxlY3B05CxK51bYi+/cH4jn0PKl4PujRarnV
 iMARquMb0sd7z6sID9JmIczKf8bwV0iN1zYDr+zOLe5DoR0tVSx4gRdtfBsBU69T4tAtpPBTzT0
 fFOAYgypRof0u/yaznLRmJlAyzeM=
X-Google-Smtp-Source: AGHT+IHjVjpJ4sVgNi28+WZ8EEzSx0sPA9OdPKYaCSObidoYQ9V8hY7FtikrIkt4JIBzP9g5pHNnuzlAjMT7rdzzkaA=
X-Received: by 2002:a05:600c:1991:b0:40f:d34d:c0c5 with SMTP id
 t17-20020a05600c199100b0040fd34dc0c5mr7511810wmq.1.1707823188556; Tue, 13 Feb
 2024 03:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
 <20240209192045.3961832-2-igor.opaniuk@foundries.io>
 <b457cb25-ea09-4e27-85aa-0e97a5aa7fe0@moroto.mountain>
 <CAByghJYSy86JjsC2cvGA0-5RupogR-vkADwQ6f9vSRnW4LtcFA@mail.gmail.com>
 <87h6icg4sw.fsf@baylibre.com>
In-Reply-To: <87h6icg4sw.fsf@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Tue, 13 Feb 2024 12:19:36 +0100
Message-ID: <CAByghJa8QqYvU7hnYEwihhTBo=YAH1Ky9YtB95w0RQ0H0RW+KQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] common: avb_verify: don't call mmc_switch_part for
 SD
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 u-boot@lists.denx.de, Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Mattijs,

On Tue, Feb 13, 2024 at 9:13=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Igor,
>
> On lun., f=C3=A9vr. 12, 2024 at 09:05, Igor Opaniuk <igor.opaniuk@gmail.c=
om> wrote:
>
> > Hi Dan,
> >
> > On Mon, Feb 12, 2024 at 8:05=E2=80=AFAM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> >>
> >> On Fri, Feb 09, 2024 at 08:20:39PM +0100, Igor Opaniuk wrote:
> >> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
> >> >
> >> > mmc_switch_part() is used for switching between hw partitions
> >> > on eMMC (boot0, boot1, user, rpmb).
> >> > There is no need to do that for SD card.
> >> >
> >>
> >> Is this a clean up or a bugfix?  What are the visible effects for the
> >> user?
> > avb cmd fails for SD cards, as mmc_switch_part() fails after trying to =
access
> > EXT_CSD register, which obviously is not available.
>
> Does this means that we only need this patch to fix AVB commands when
> booting from SD cards?
>
> If yes, I propose adding the following note to the commit message:
>
> "This fixes the avb command usage on on SD cards."
>
> If you agree, I can do this while applying.
Yes, could you please add to the commit message so I don't
send v3 for that (if there are no any additional objections/comments)

Thanks
>
> If not, we can keep the message as is.
>
> >>
> >> regards,
> >> dan carpenter
> >>
> >
> >
> > --
> > Best regards - Atentamente - Meilleures salutations
> >
> > Igor Opaniuk
> >
> > mailto: igor.opaniuk@gmail.com
> > skype: igor.opanyuk
> > http://ua.linkedin.com/in/iopaniuk



--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
