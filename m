Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C65D12D56
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74A183F93;
	Wed,  3 Dec 2025 13:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FJpydO9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C50883F9A; Wed,  3 Dec 2025 13:57:44 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A19883F91
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-787f586532bso55040927b3.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 04:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764766660; x=1765371460; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9E5z7Pouj7D5o2ZRDpJ9910wN0coPkD+Pvyrf62hSJ8=;
 b=FJpydO9e6OqrTHKFYCnZx+5qPvMGia+YYnnUkbzoQ1gzjYhhnDnHVojm94VYlqNaOH
 fss585Z3gIz8iBkP3SCvvoTb4FJ9YF00omWhvoaORXPUkAP6VEf3yS4Aox797+DNR/E2
 FTUd1ffqKmmCxENztYwRmzZ1H8hm2403acHn0nI3MYplpv+WfUeCkHAow+C8rKCrwlTp
 AYrBCxaplHFLDOtpq/aRgXrJVwPbP/imEzNUA8KcMvJLAFep6WvaJ2GEWt1gPKfYmZTa
 xC3Cgvk5NKNTZFuUUx5/jaQSWCxN1/H020X907o9VG4/QxlYkjX9/hie0vg+Bqy63EbO
 +5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764766660; x=1765371460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9E5z7Pouj7D5o2ZRDpJ9910wN0coPkD+Pvyrf62hSJ8=;
 b=iO92HDZSt1pO7ejghskjffQvz8DkXDbIeFOPkTV0AfGpaoOhAVl6a37YEz7wty2jSM
 HUfD4rs92n6AyyxeDn97bHoxHI/I/Xt0RHM+DG8Rgy6BjzqVXDdGExlPXMUCknx0Lgit
 NO0Tbuhl1KbrApDAkPqvinqwsHu83/DPfRKPrLIguD834Va1Ldr2MnulDs8kccbdnA/K
 1KOs1/TlPBahyetA9qz8VMYGAZKcPLkVBJjtAA4zsT8p4ceUUpLpYKNuZOnEGWB8kXHt
 j3ufo1KOxR87tGgNMm1fRS5U66EuAAw/8DmEOMI453KIO/20G7JmmjDN8YQBMiXbc9Om
 K+0w==
X-Gm-Message-State: AOJu0YwMT6TkB4kPwdswDSg7sdz9nxwyvZy5/8378JzCM8/rlspMQewA
 5nfVeam1jfXyu12P9lqWJcE5Evs+U2Im5Ic4qPbOjmU6+cHSQLzzjAogMjCZvu84pulfiA1E+Lb
 NjW6WY2varnAL4II6KF8Vt9Q5EN/lofS3TuZZAZxO1Q==
X-Gm-Gg: ASbGnctiO5xTZlaGv3yghXwFfFyYmPLsvH1I5Imdhu36hUUgq/nIAdG9maZVzjeR8Dh
 Aoj+meVFVNhGhEuk70iWNzgRV6smN8W0HL3M9cJTwBG8YerTEAMyQngkvdioi3zw0+Jzaa7WM/S
 cEltzMj4kM9dMDXYH/4I+TOMV7PwRVfVR6f6nhnhb/nCSl7KHwwepmCGiJUubSqffalM+pUMoyc
 bC5Eo5gquL+uqs/I6xWPpDUH0aRJm0zYVLx8KaZP8+yRkK4ZuAUTO3kHo3smlmy2XaqaAqVMVDe
 x3bYkOJMH0HVpZEuPHGZQs/Dfy2qW3qodRESZVD8GmdzrlmOCJtgYXxOPvXVRFhEz18lEd8OFrO
 GIz5rYLs=
X-Google-Smtp-Source: AGHT+IGseHN6BeBHI/wttXpLmZ7c7zgSJXwsC8BnKgZyxon+VPDqjmwu4tl4w+jU9SHwTRT8ZfMG0GPmHx3JZ3S0/bU=
X-Received: by 2002:a05:690c:3508:b0:784:8b82:98d8 with SMTP id
 00721157ae682-78c0bef4d80mr19308717b3.16.1764766660057; Wed, 03 Dec 2025
 04:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
 <20251203110108.1d93975d@kmaincent-XPS-13-7390>
In-Reply-To: <20251203110108.1d93975d@kmaincent-XPS-13-7390>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Dec 2025 14:57:04 +0200
X-Gm-Features: AWmQ_bkIgxblhZuEn-7hYm8nxZZ5bHmYlVlXqcJ-FO4MmBViwAn__oSy8oo0L1E
Message-ID: <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for fwumdata
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>
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

Hi Kory,

I'll try looking the patches in more detail tomorrow

On Wed, 3 Dec 2025 at 12:01, Kory Maincent <kory.maincent@bootlin.com> wrot=
e:
>
> On Tue, 02 Dec 2025 18:28:25 +0100
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> > Add a new fwumdata tool to allows users to read, display, and modify FW=
U
> > (Firmware Update) metadata from Linux userspace. It provides functional=
ity
> > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > metadata, change active/previous bank indices, modify bank states, and =
set
> > image acceptance flags. Configuration is done via fwumdata.config file.
> >
> > Made a few change to mkfwumdata tool along the way.
>
> Still wondering about the choice of putting this fwumdata tool in U-Boot
> instead of TF-A. TF-A is the boot part that manages the update process an=
d
> rollback through the FWU metadata,
> therefore, this is where it should belong.
> Why, in the first place, mkfwumdata was accepted into U-boot instead of T=
F-A?

The actual update happens via capsule updates only, which runs in
BL33. TF-A needs to be aware in case it's involved in the boot process
and fails to boot. In that case BL2 is responsible for booting via the
other bank.
But generally speaking it's U-Boot that processes and usually updates that =
file

Regards
/Ilias
>
> Regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
