Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D7BCAC5B0
	for <u-boot@archiver.kernel.org>; Sat,  4 Oct 2025 08:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2092783826;
	Sat,  4 Oct 2025 10:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="DRYVm1DB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0CD88386F; Sat,  4 Oct 2025 10:05:47 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D1A83775
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 10:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61cc281171cso6188143a12.0
 for <u-boot@lists.denx.de>; Sat, 04 Oct 2025 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1759565145; x=1760169945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3yT8Qj9Dc+6wcEPUW4dcP2dWFdUkrQhg8EAIE4/6I4=;
 b=DRYVm1DBxeI2CIvb3P40tD2WOgiWiFEGCue8/efm1m6HuRTW/KfVI1hI4XbMrwPO5G
 /ugfqioG1qeDIg8Fz4XXgnVJ8d+cuijBz/iHgRHK/VJp7mupJ1H3v63oP/qf873EJ7Y0
 coqL0rvwRJV/o4vEv389HRJO6HJ+D/ecgMxruq0OVSNSpd9Yodi/9vjtLmhsD6t0wukw
 MIb4IBkl7zIfSVmTPQhGHibFboIXc4fPk1uIXc9Gjiqas6poBz+IFxlVZGBlXUthCpFn
 iyLOVAvOG9lHdAXW2XId33dv1wrOQZ83saQRfoMLqF1YF78TwDgxjMlQBUgoD989zl3R
 0UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759565145; x=1760169945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3yT8Qj9Dc+6wcEPUW4dcP2dWFdUkrQhg8EAIE4/6I4=;
 b=Ex8+kO/t7Kr7iSGsmcEMIP7POucUkgCKYFyI8A/5KZqFC+twqj2nIryViO5QfT5SeH
 OEkdiGjNDqPpjq5NuT00NHWRTzcrX8tZ3FdEnABByXXOB9cQL3OIORT4+HmqVZbBjQDI
 C0nvjrT4Ux5DG1lEwPbwbIam3ni8PuVl0rjI2WtqhUJO6oWiGpBHb9uuaKDrT9AQy/y3
 Ktj1FHM7SIUUV8EIynTsEOxFu+wqjfC/Xa8ZlKX2nJLFnJQVLcjSJBIwcVfeLL6FdwtC
 5XHAJnrQQOWYAtUCZ16RwnsVqzSGcVH8qH3q7HgeFasGWIxCbHcJVdXA9dYpM6dyP12s
 8U8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3qnPScZEiDBQDtGNKMLUh6g0cGGHIIaI+GNOAlnKfsMtfmTmkCfEIx+P9zqaeKzAe7ZlKCyk=@lists.denx.de
X-Gm-Message-State: AOJu0YzCvJykA72JOVntSxNl0pMoQ2Hdc50MTuXjXilMlHiGltRu6yKy
 334D6VjfEajBMzUbnDBtwwtQasZZSmuIPsVRUq6CWugQFl3PdyF8m1vH8LD2bpJAZSY=
X-Gm-Gg: ASbGnct6KlLa2i2GbvmtaCNCh9k2KbjvpaPv406EQeYNZAYrHtGiOnzjXoKaLz5QblZ
 O+aVVmjmPhf7SxKh8AP9KFZhOfJFsaIaMOrqnPdAcPA/H6jujWS9qO/TX9zkq8ttWjpdmdQavyN
 V6BjgSaBUIl341EmG95zGO/WKIBKdDnVc6M38PdC+dGdC83uChboWcqZgAQAh0jWKSQBC1cJrV1
 3jZUVxHPbbruP+J+y/BUqcZAhK7IjhliptQ9vCb6wgFMpz2BO4dXCos50mRo19LTcwyKVsUzILn
 VlCHviNer2OkFHE2z2EK4VYMC75wHwnLpR44PhGmELcC8Koh0hyGViiigHXRLHYfqsIHv9T6z+k
 TiY2kKrlZ5dpkIqMmmszS1yc75ddABD8rhOnoxbsFlWnyWnBEXzKX5hvxsPv7cVvrsPMEtUlsJb
 J91AgK576D/Zc=
X-Google-Smtp-Source: AGHT+IFdiTy7od41JXE3GEiAJwCk6eJqDLPI+ITSJRoD6VrX71EwmqggdqtA2md+st4ZDDleLO0nLw==
X-Received: by 2002:a05:6402:35c1:b0:62b:53af:78ca with SMTP id
 4fb4d7f45d1cf-639348de758mr5696253a12.9.1759565145083; 
 Sat, 04 Oct 2025 01:05:45 -0700 (PDT)
Received: from somecomputer (85-127-105-34.dsl.dynamic.surfer.at.
 [85.127.105.34]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6376b3abcd7sm5620510a12.2.2025.10.04.01.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 01:05:44 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Tom Rini <trini@konsulko.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 u-boot@lists.denx.de, ddrokosov@salutedevices.com, sjg@chromium.org,
 tharvey@gateworks.com, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
Date: Sat, 04 Oct 2025 10:05:43 +0200
Message-ID: <5561663.0HT0TaD9VG@nailgun>
In-Reply-To: <20251003210149.GA6093@bill-the-cat>
References: <20250529150213.27149-1-richard@nod.at>
 <10664479.lqRGMn8q6B@nailgun> <20251003210149.GA6093@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Freitag, 3. Oktober 2025 23:01 Tom Rini wrote:
> > My current way to work around the problem is having these commands in
> > my U-Boot scripts:
> >=20
> > fdt addr $fdt_addr
> > fdt rm /chosen linux,initrd-start
> > fdt rm /chosen linux,initrd-end
>=20
> I do wonder if the best path forward is adding some opt-in CONFIG option
> here?

Hm, yes. Maybe something like CONFIG_FDT_INITRD_EXPLIZIT which is enabled
by default for the RPi target?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


