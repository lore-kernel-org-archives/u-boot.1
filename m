Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC50C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD5187BED;
	Fri, 15 Dec 2023 19:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="C+vN4CBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258E187AF9; Fri, 15 Dec 2023 19:34:39 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D3187BED
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a1f8f470903so121718866b.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1702665276; x=1703270076;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UB00jkMhvweA0vOFj6AiTOiXAmdpBwdTQvfJe29SQjw=;
 b=C+vN4CBBfkYzVGrmqV3P9ztUNVPCbYyXIBSXNddQx3WurcYxPFJFb1xEcDMx3DXKzC
 Mqb0D5QmWNMjicyBsgjcviqKSw/08ZLBj/h/xemk99Iu6+hJ7FElibI1VQJEA+YGqYZr
 LNwfQmCRmvo7Fr5+VWYSvS+Nf3sGCZ2MOSykIteCjqlaxU33vLF58pTBM5/Er6B7bnuB
 1IAytltcQH243geXuwi1XajhNqKhYPyEbdXMb04XLkTw7jgLnhjZMbfVwHVGbVNRuUCC
 7bmr/WYoncB+Y8vcc4ly0ikq1RvUsyLlJS7kqMeJEO1T+o6W4+s63u4bzZQW8jGoAr/N
 xyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702665276; x=1703270076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UB00jkMhvweA0vOFj6AiTOiXAmdpBwdTQvfJe29SQjw=;
 b=V1APYM6kFeii2Wju8h2dAImMMiHX338D95EbT2Qazhvc8IzIesgzAkjSYrMq9DCnC9
 uaYmuV3UzZ0wEXongzxyTtMdQxam7B7W7nCjJItVYId1AvrfLS2OErGUEcaeDs6suaGV
 5nSRuaNIHnqwam1ctd8IoYgD1b8ZNL1reK8QMGX2Sa19S/QswJDZx7qmXJnlujBW1rzm
 vBegoPv1jnK0OnwAUwTDBuPKzN4F7fFg9zESTQivneBNjsHHikiy/gwoWs9JEsMjAY6N
 3F6hUMkDn+blhl052Z72iq6iIfNlD7QbzSRPsDMxHY1sT/XsLvghwBFphpiFLYbM+7PK
 QP9A==
X-Gm-Message-State: AOJu0YwrCPMuYNPLl+ltJxRDegKEvNNz3ki/pOgXJ7frOpmUnIgki/3j
 Zz2U9JpriUUV2twsPmtrTJHwxileFYJPq/o0XqdW/g==
X-Google-Smtp-Source: AGHT+IFQ1ySTppuXRm4COymJKGKro1Spnig117/9IOjiXK2hY1KwmM9a1tN0cHP+/yZo7VB4ZLQI4pDPrcd5io6693M=
X-Received: by 2002:a17:907:2cc6:b0:a19:a19b:c713 with SMTP id
 hg6-20020a1709072cc600b00a19a19bc713mr8462883ejc.99.1702665276259; Fri, 15
 Dec 2023 10:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20231214162543.1200276-1-tharvey@gateworks.com>
 <20231214162543.1200276-2-tharvey@gateworks.com>
 <CAOMZO5DuRnmNpT-GZxkjL4UmwNW-NyQWf+VNy4Q+N1=aitUptA@mail.gmail.com>
In-Reply-To: <CAOMZO5DuRnmNpT-GZxkjL4UmwNW-NyQWf+VNy4Q+N1=aitUptA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 15 Dec 2023 10:34:24 -0800
Message-ID: <CAJ+vNU0XbwbQoYDHm59LrFaK_hv29RkeZvbK=QCUMkoLYNM-hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx8mm-venice: prepare for dek blob
 encapsulation
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Thu, Dec 14, 2023 at 8:30=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tim,
>
> On Thu, Dec 14, 2023 at 1:25=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > Prepare for DEK blob encapsulation support through "dek_blob" command.
> > On ARMv8, u-boot runs in non-secure, thus cannot encapsulate a DEK blob
> > for encrypted boot.
> >
> > The DEK blob is encapsulated by OP-TEE through a trusted application
> > call. U-boot sends and receives the DEK and the DEK blob binaries
> > through OP-TEE dynamic shared memory.
> >
> > To enable the DEK blob encapsulation, add to the defconfig:
> > CONFIG_SECURE_BOOT=3Dy
>
> This option does not exist.
>
> Do you mean CONFIG_IMX_HAB=3Dy?

Fabio,

The commit log details are not valid for upstream. I was basing this
off of 8d060e4a66d6884341fbb3d8ab1d837a3f173d47 which made it upstream
with the same message.

I can submit a v2 if necessary.

Best Regards,

Tim
