Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABCEE9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 13:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773F683AA9;
	Wed, 18 Feb 2026 14:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YTWYgIJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5D183AC5; Wed, 18 Feb 2026 14:56:07 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0421383A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so5751553f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771422957; x=1772027757; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQNjtsGsgI+9L9P9VfhZeYGxkXGUivYoMvT0PnRaVuM=;
 b=YTWYgIJHrJhhkYKMIEsfmjJINpOliRcEoCcJYU/N69Xpm/vmH4NDCjlNf1QAcooseC
 fmfZQtnemgu8n3KqTSII9GkAdl4qRhU3VNsOTpyuG5qwRubmKV8EdyZht6Z//ZwPUHZl
 DEsJ2DMcbPPkEXJWbUzUtjrJX5PygASgNHzZ/uhJQ80V4+BLd1Phmzig4PKPczG7aCQi
 4BQ+NQgbFCSUjbKiVZinEiw24aFTJJ0hBxLEAgNiBmO5fynoF71/5J09E3q/5aGf7PLG
 SkCLWd9/zp4aS4qqv9UOuYXd2rxuxqiUaj7srJCvbALd4Mk3EtUoOMczVmlz06R85dSZ
 TLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771422957; x=1772027757;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iQNjtsGsgI+9L9P9VfhZeYGxkXGUivYoMvT0PnRaVuM=;
 b=Q0cB5StX4KbspLgBj52EMEHHTXOs47KeieKSa6U8DiVoMcr/4DfJpgZpIYTvQ9gQzT
 12z5ppCPbZr8YOw/RHEEo3vDZrAG78dEL8q0CjVRx+L3H0WmLBXU9132PqeUtagqs6yl
 E6MNxA43gCAS5sDFF+RFoRjmfBDH3TEv6oqhj6307O6FxgfyHytR4zRklkGy2VL8iaAL
 X+IlR4+VtX6pH4DCNOqMN5oVQJBsi3E051MJime7S74V0FhHu/FVmzpstYYg5ql9Zqe7
 6HTk/g7G2+ef3/pBnlADDcFfiz4l50khMGrf8tljWPfW6u+4EemqEgQWg/WNG5AiQj7k
 EYBA==
X-Gm-Message-State: AOJu0YxJLXwwUgLVQVrK/xXx6u+Org4BTZYUG5x3k/z+NnCcAMYU9O7R
 ed+EMG1JrnC2e2AnCcuAxcSbffg9zeUp8YlQR24g1kq3bfAdh7HmOM00bzhAtp7A3pc72acmB0u
 cPSuNleM=
X-Gm-Gg: AZuq6aKJLzY+w98NKGpwORl0xAOsuK066nCX5yFQEX87/GcQLE22kgLbJeN61RHWmsI
 hVCGmgZgRKwlWayvfZWNlX5VPUR+amIwQ18nW+8xFSLdUyikASRq5npQjo4Ov5UVkYZzYxmPstH
 pT46abiY0Ei6y3GNwJCKaguO9RQv56rGiZ5khNxE0gCEkjzh1izlOIG6/60jcPP/1ChyYkmINCu
 7BWB76A0tAFvS5TjPoN41rr0Ehftuk1g557AhccpamwOjAsXnyD8SID5PCMMXVmf43gdGK9TaPl
 26PO7+xPNCi5nOGuQJQdRZeUoW5HT4SZYC0PhzrCuYT8kfOrNPoIqYZ9kOmxkdUCeW1oBkG/8n+
 za31Lm+EyADLEsoGjhh4Rw6lzxTzGuRwnE7tPalP09JD0Nt+eI/w0p8nWGe1ay/GZN841YQS7f3
 Te3fro3HrgtCe+FJ/PjxhHdn7dZtutedJK4DjenCsq4r0Mh4AhapuPv9+H+w7yEzJOIT4yOe6h0
 ONlDdrXn83QQznXwyg4ZPYQu9W2K1bAa/qoexmm41WbHM9LLe3V/n7STAXjzJ62LzRD8Zrtp4k9
 pfA2a9KDPkzkWOcUyf2RlRTNpbnTegH2KbUg/3wAcgMiU4SxHHRmJqnCTKw9XFF8GYvmm9KzyhK
 HNK36bNnQPQaQazxEVAIGwePj3heQR2XOksbCopgHpE44oUsjUWxbhWPhZXRaCUPFAKJcT7yFlN
 IgEkECNfG4ZD2sUeYHKfvZ3oAHPlgewVLYiDJb9IX1Rp3PpfHbIh6CafelXpyAu0ULUSU=
X-Received: by 2002:a05:6000:420e:b0:437:7168:af4d with SMTP id
 ffacd0b85a97d-4379db93a8cmr32440712f8f.38.1771422957310; 
 Wed, 18 Feb 2026 05:55:57 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm46124053f8f.28.2026.02.18.05.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 05:55:56 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 15:55:54 +0200
Message-Id: <DGI512YNMO8N.16UJEORE7YFKK@linaro.org>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Sughosh Ganu"
 <sughosh.ganu@arm.com>
Cc: <u-boot@lists.denx.de>, <jose.marinho@arm.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tom Rini" <trini@konsulko.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, "Paul HENRYS"
 <paul.henrys_ext@softathome.com>, "Greg Malysa" <malysagreg@gmail.com>,
 "Arturs Artamonovs" <arturs.artamonovs@analog.com>, "Vasileios Bimpikas"
 <vasileios.bimpikas@analog.com>, "Utsav Agarwal"
 <utsav.agarwal@analog.com>, "Nathan Barrett-Morrison"
 <nathan.morrison@timesys.com>, "Peng Fan" <peng.fan@nxp.com>, "Simon Glass"
 <sjg@chromium.org>, =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>, "Stefan Roese" <stefan.roese@mailbox.org>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Heiko Schocher" <hs@nabladev.com>, "Alif Zakuan
 Yuslaimi" <alif.zakuan.yuslaimi@altera.com>, "E Shattow" <e@freeshell.de>,
 "Raymond Mao" <raymondmaoca@gmail.com>, "Jan Kiszka"
 <jan.kiszka@siemens.com>, "Shiji Yang" <yangshiji66@outlook.com>, "Daniel
 Golle" <daniel@makrotopia.org>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Leonard Anderweit"
 <l.anderweit@phytec.de>, "Yao Zi" <me@ziyao.cc>
Subject: Re: [PATCH v3 5/6] tools: Add support for fwumdata tool
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
 <20260216-feature_fwumdata-v3-5-9ecc5b10456d@bootlin.com>
 <aZWKyl6r8BphaePp@a079122.arm.com> <aZWM0_v4eUgKLTSz@a079122.arm.com>
 <20260218113116.3c447668@kmaincent-XPS-13-7390>
In-Reply-To: <20260218113116.3c447668@kmaincent-XPS-13-7390>
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

On Wed Feb 18, 2026 at 12:31 PM EET, Kory Maincent wrote:
> Hello Sughosh,
>
> On Wed, 18 Feb 2026 15:26:35 +0530
> Sughosh Ganu <sughosh.ganu@arm.com> wrote:
>
>> On Wed, Feb 18, 2026 at 03:17:58PM +0530, Sughosh Ganu wrote:
>> > On Mon, Feb 16, 2026 at 02:35:35PM +0100, Kory Maincent wrote:
>> > > Add a new fwumdata tool to allows users to read, display, and modify=
 FWU
>> > > (Firmware Update) metadata from Linux userspace. It provides functio=
nality
>> > > similar to fw_printenv/fw_setenv but for FWU metadata. Users can vie=
w
>> > > metadata, change active/previous bank indices, modify bank states, a=
nd set
>> > > image acceptance flags. Configuration is done via fwumdata.config fi=
le.
>> > >
>> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>> > > ---
>> >
>> > I am not sure if this has been discussed with Ilias earlier, and
>> > apologies if it has been, but I do think that this patch is not
>> > adhering to the DEN0118 specification, specifically the part mentioned
>> > in section A3.2.1, which says that the metadata is to be maintained by
>> > the Update Agent. I would like to hear from Jose Marinho, who is the
>> > author of the spec, on what he thinks about this approach.
>> >
>> > I do think that the other patches in series look fine, and can be
>> > applied. There is just an issue of inclusion of the tool for
>> > building. I will comment on that patch separately.
>>
>>
>> Adding Jose to the discussion.
>
> We indeed already had some discussion about it with Ilias.
> https://lists.denx.de/pipermail/u-boot/2025-December/605924.html
>
> It seems ST deviate from the original idea behind the standard. It does n=
ot use
> EFI neither update capsule.
> TF-A is managing the selection of the boot partition (FIP image: OPTEE +
> bootloader) according to the FWU metadata content and is dealingwith the
> rollback mechanism. Linux through this tools is the update agent to selec=
t the
> boot image.
> The final goal is to have RAUC updating the boot A/B partition and switch=
ing to
> it calling this new tool.

The whole point of adding this via EFI, is that we had an existing mechanis=
m for
reporting. e.g when an update is in trial state and an acceptance must be e=
xplicitly
approved by the OS. I assume RAUC etc will implement that ad-hoc?

Thanks
/Ilias
>
> Regards,

