Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC415E7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 18:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A97801A0;
	Fri, 27 Dec 2024 19:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="AbUQATMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E8F68036D; Fri, 27 Dec 2024 19:46:50 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868A680087
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 19:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e3fd6cd9ef7so8906820276.1
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1735325206; x=1735930006; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvDGBkXjn6zfraiSanoLQgDguMBH2eCYCEcusSiyoN8=;
 b=AbUQATMtCG/bYGMsNPBfXkMhvz9h24UB9ow72fgpTwT+80rDD0Av1Bk0mUa4dOcAKv
 J6qN2LDG7EPUygcqBj6mb9UE9WWP6fjJaYSsUsFtJ3oeOGVRcnB7U0tViyduIQ+qt33y
 bo8B7TLebRQjmguezxgjc5elKapbginut8lq++jvgN7ZMGKFfIYNT5MXawapktmALwqU
 R1ztdfv1lSM/PCuxj6zzPjSI0EfiT9GslZKWbPDldvieMo+RihanKSBSgGTwNplixZET
 U2bZDeuFjG7OFBtKcMFDLnWA6OrwUM4o1MiFRWHeT15SiUINXNTrUdK7dJ8oz5IsUDrc
 Y+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735325206; x=1735930006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvDGBkXjn6zfraiSanoLQgDguMBH2eCYCEcusSiyoN8=;
 b=PLqL04RWxPEh3+YlVDFdPGYXB47wJciB7nJKinXxCxe9Zsw1nnyNn1emMWplh5P4vK
 m8RTnCPtMjLP02nwQN7yoMbg0pCpwH73RxGnc70+mglruwbA7JMgommjlPVr1SHhRML6
 rJnQWogwBMCLfG/cuJYaYyWuLBnwCl2RiBMiwDpH3HAOwBnSwbA6G9+ff6wjCsNY6d+F
 gEJaltdLJLFNO4ZBtGCR0tmlkoMsBCUZNL6Jad9SjuPYTDKs53o8drig0Ej2rNtTDtPZ
 0kKITlp64SL/wK8k1NDsRbiNN27Do6wvjRnksFtv6+m6wf1jrDOdOTLhVQLHd3doJadW
 AkdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2rPx9bWTR1POmhLiuUA49FV3u3EV9tdkAZaGnBZ+lIs3vFpb0iTCNb8l+bt4NS16jtN8vUdk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3tbkBGV5QGwd+ew9GPJ6HEM91ggj/W5Mm9OWv90Q0NgD5Gv2p
 frJR+Z8+VLUHDUTknz6A9szQXukua4Ew9YnMLfM4YAoj9zH/Re1T5WkwnkBmj/HCKgMqm7nJ86a
 M4SZiJb5R5KRncc7+IK3wMNLTZhSRtNqiRpie4w==
X-Gm-Gg: ASbGncuBWW4kPR8v4jrDnfsBszlPsGMRDpRQD7Hf/dUbsQvjAvwgoz8cOcfiYA+0LUR
 N1fdSOz5ALSgCfLpDf/X68SLBEv19ZgsSNUq8AA==
X-Google-Smtp-Source: AGHT+IG5xKwQLFmO//VxJaWxGC2QWLZnWFftA/GvBEpBv1SiNp1PQiXkeeHlesMCt9eFOGQF2xcRHixL1M43pmoEs9U=
X-Received: by 2002:a05:690c:9c04:b0:6e5:2adf:d584 with SMTP id
 00721157ae682-6f3f7ec3a3cmr168868697b3.14.1735325206409; Fri, 27 Dec 2024
 10:46:46 -0800 (PST)
MIME-Version: 1.0
References: <CAFA6WYMvXXi19tjxhi-N4D3-tbVkbJQeUHwzuC5FME6vzPir=Q@mail.gmail.com>
 <20241224180758.GW1505244@bill-the-cat>
 <20241226151739.GZ1505244@bill-the-cat>
In-Reply-To: <20241226151739.GZ1505244@bill-the-cat>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 27 Dec 2024 10:46:35 -0800
Message-ID: <CAJ+vNU3=Tq8QTA8j4L5wmeO_XXPsKVwg0fjxJhv7mSQu0yj+fQ@mail.gmail.com>
Subject: Re: DT subtree sync for v6.12
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Dec 26, 2024, 7:17=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 24, 2024 at 12:07:58PM -0600, Tom Rini wrote:
> > On Tue, Dec 24, 2024 at 12:54:22PM +0530, Sumit Garg wrote:
> >
> > > Hi Tom,
> > >
> > > Do you plan to perform DT subtree sync for v6.12 which seems to be du=
e
> > > for some time now?
> >
> > Yes, thanks, I'll see how that goes shortly.
>
> The only problem with this is that it looks like there were two device
> tree renames that we care about:
> rename from dts/upstream/src/arm64/freescale/imx8mp-venice-gw7905-2x.dts
> rename to dts/upstream/src/arm64/freescale/imx8mp-venice-gw75xx-2x.dts
> and
> rename from dts/upstream/src/arm64/freescale/imx8mm-venice-gw7905-0x.dts
> rename to dts/upstream/src/arm64/freescale/imx8mm-venice-gw75xx-0x.dts
> and I updated the two defconfigs (imx8mm_venice_defconfig and
> imx8mp_venice_defconfig) to use the new names, but I'm also CC'ing Tim
> in case this is wrong now.
>

Hi Tom,

I've been waiting for the dt refresh to address that rename. Thanks
for updating the defconfigs. I have a patch I'll submit that takes
care of something in the SPL and renames the u-boot.dtsi's that are
affected.

Thanks,

Tim
> --
> Tom
