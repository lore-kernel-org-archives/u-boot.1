Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF19CE79D7
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 14:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75A886AE6;
	Wed, 20 Sep 2023 16:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AmSbFSGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC9C86C48; Wed, 20 Sep 2023 08:25:06 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB87C86BAC
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 08:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph.sklin@gmail.com
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4526f0bdf72so1294342137.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695191103; x=1695795903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUffWs50qFfh4XMWfO+J7jagjVwtRSGkovPURNTZmDs=;
 b=AmSbFSGGUmxMiNLbP0tuVeHwex9dTvu7WLzxGFz9mF7l9PNHb1+Lti0pt3w62MHmd6
 Usq6QZOdrGHVMqQ7XnU8I+9AINpXhu7Xj+i4U3ne4DKrqE+etjA6eD2bb06sHd+j1m6E
 aYZq97xKERHl+zdZJ8SRJ5L97mnsaBfH/pi7jP1Cm2AFwdTbjvCs8OeaEkIcbfyc5m7F
 YiIfv67IQsFVzVO+S3bewztNBsdGUcKVMQfqdetTGLboY/+dQ1iWi4gcK3aY8K1tP0T5
 2Dac5x8TWiqw/VGHExsVLNWymriRZDn6QTghybSgGp/cj6vhhTqTkyTmpEcYjBOrZuSt
 PfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695191103; x=1695795903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUffWs50qFfh4XMWfO+J7jagjVwtRSGkovPURNTZmDs=;
 b=rRGAIkAU1wZID9VQo3tqmAEWBWQg78DQ5g0F1uWxNLKIla3Ete2YWvz2x9Rs/4ScVK
 7SJnvDVvCot7aX0ZICSb5RdDru/ORps+aw751Gu0Pcg68SCJfY5/tdVFOt++qFcaRjll
 gG+Lgpi+BBN64y0FRylajtiSaFXHGYulf14NlFmQ5wVWoFrvKi22MZ6i1iv9Fa8s4oiV
 11dlDnb/giif164agMqcXj0pKCWs0WICtafUVPrwVHYZnRcpYcfNIBtljARAJl5XnwDJ
 ILyQTdqFVMDurpajL9/76BTyokvDiCyo+N+UeQDBrrY6Bq+3KeyAXLAsERiqImxTUjbw
 4WTA==
X-Gm-Message-State: AOJu0YxxpM1FF/u1LkagBjJFalxPdXwm5a+VNUsIkJ3eoSag8Nc9CZti
 BZVnN3nI+XnVK9xI/t2iXsE3m+UAbZcrAVwE6D3QAyO9Dn12WgBbcxk=
X-Google-Smtp-Source: AGHT+IFFmJ2iRoBh2Jf2fzJuo7BRu8CfUnoC9OUCukucBth0vV39JnQDUEtOALgoZTXiT+d4tJSD68USdraf8+8YwvY=
X-Received: by 2002:a67:ead6:0:b0:452:4f72:e2f9 with SMTP id
 s22-20020a67ead6000000b004524f72e2f9mr1853074vso.19.1695191103353; Tue, 19
 Sep 2023 23:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230918121136.2295900-1-randolph@andestech.com>
 <20230918121136.2295900-4-randolph@andestech.com>
 <20230918150426.GU305624@bill-the-cat>
In-Reply-To: <20230918150426.GU305624@bill-the-cat>
From: Lin Randolph <randolph.sklin@gmail.com>
Date: Wed, 20 Sep 2023 14:24:52 +0800
Message-ID: <CANy8aOhR76=LAsZP6BnP65D6GcSknVYLMzXRWrXmeAcR+u3suQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] dts: andes: add SPL config option for itb layout
To: Tom Rini <trini@konsulko.com>
Cc: Randolph <randolph@andestech.com>, u-boot@lists.denx.de,
 dylan@andestech.com, tim609@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 20 Sep 2023 16:27:33 +0200
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

Hi Tom,

Tom Rini <trini@konsulko.com> =E6=96=BC 2023=E5=B9=B49=E6=9C=8818=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Sep 18, 2023 at 08:11:36PM +0800, Randolph wrote:
>
> > Add SPL_LOAD_FIT_CONFIG for binman itb layout selection
> >
> > Signed-off-by: Randolph <randolph@andestech.com>
> > ---
> >  arch/riscv/dts/ae350-u-boot.dtsi     | 1 +
> >  arch/riscv/dts/ae350_32.dts          | 1 -
> >  arch/riscv/dts/ae350_64.dts          | 1 -
> >  board/AndesTech/ae350/Kconfig        | 6 ++++++
> >  configs/ae350_rv32_defconfig         | 1 +
> >  configs/ae350_rv32_spl_defconfig     | 1 +
> >  configs/ae350_rv32_spl_xip_defconfig | 1 +
> >  configs/ae350_rv32_xip_defconfig     | 1 +
> >  configs/ae350_rv64_defconfig         | 1 +
> >  configs/ae350_rv64_spl_defconfig     | 1 +
> >  configs/ae350_rv64_spl_xip_defconfig | 1 +
> >  configs/ae350_rv64_xip_defconfig     | 1 +
> >  12 files changed, 15 insertions(+), 2 deletions(-)
>
> So this is where I have a problem.  It's not clear why you need to
> change anything here, as there's no example given for doing something
> other than what you do today, and there's no documentation about it
> either.  From other contexts, it seems like you're trying to re-implement
> CONFIG_SPL_OS_BOOT but not explaining why you can't use the existing
> framework.
>
> --
> Tom
  We want to add our binman.dtsi (very similar to SPL_OS_BOOT) in the futur=
e,
but this may affect other vendors' code under arch/riscv. To take a step ba=
ck
and reduce the gap, we just want to rearrange our code now (in this patch).

  We are not re-implementing SPL_OS_BOOT, the goal (skip loading u-boot pro=
per)
is the same, the method is different. For example, in ARM architecture, the
Falcon mode (by enabling SPL_OS_BOOT), the boot flow is u-boot SPL jump to
Linux kernel. In RISC-V architecture, most SOCs require OpenSBI, the boot f=
low
should be u-boot SPL -> OpenSBI -> Linux kernel. Apart from the boot flow, =
the
code flow is also different, "jump_to_image_linux" is not necessary and the
names are not quite right in the RISC-V architecture. The CONFIG_SPL_ARGS_A=
DDR
macro is also not required when building RISC-V u-boot. That's why we need =
to
create another way for OpenSBI to do the actions like CONFIG_SPL_OS_BOOT.

Randolph
Sincerely
