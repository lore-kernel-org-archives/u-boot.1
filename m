Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0923DC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 23:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541B587DBB;
	Sat, 27 Jan 2024 00:35:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hVOKsaO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5306787DC3; Sat, 27 Jan 2024 00:35:50 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA3C87DA8
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 00:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d2dfa80009so520523241.0
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 15:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706312146; x=1706916946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9uTmJ799kbCd/oKOhxppd0+MO8nhCT1oaif8V3jG5bE=;
 b=hVOKsaO14CjYgcR039euOpclLVBv6+c+FemnJLMDf9UXS8bZXe0788zlv+syRCb8nz
 mhL2dQt8dsUmHjBO8KftFxuUgprubuNG5hek99Xq97SZ+jOlO0/ygECsqYwTl4lo5siE
 KGsAXKj45e+/X/2hctU51QRFr0b4T3RhiKjcwiIBvUyFsc8oJy419z0CMdfIa68eUpvL
 t1ZqH2mht7PtDc8ebvvijopf/9GRBapUhqwA7dehE3bEf9zWLcyDjw2ssQjF+IBzAAu+
 iDwJe6Kv2tUvYeo9ZtMPy09x69NiR0Jfq4PJxsB5QbVGEst3nb4Tl0AV4vIKUH2QV09u
 C8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706312146; x=1706916946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9uTmJ799kbCd/oKOhxppd0+MO8nhCT1oaif8V3jG5bE=;
 b=UXCnweiXSvY1RvJjtwwXZgvx0W9cld+J90DnJNnQG8FWOs6qWdfkJWB3WeJ6+sebxp
 fIbFvhNTsM2XH3mw30XzN0amc/O2NIyxIKq7H5HhkZcohXlOcj8JOFXvMzNKMcrQ9dJu
 owHbYYVgKYUEa4/rPUGb208yyIERQYTPqb1fn/lOF2p1GGSryR0PhKjK7Oj/H1hlZuFB
 l3aVAIju/wP4oRMEMEtZHcCkBktBQvx6b+4iLmWQWfIBJPjDfzGopifGJZKoHJOX/Die
 8HEq+80rKLEXES1baiKedDcu9909cWfTrqB9vXeyC9y0dA1FAElIKXdGIolyeoAgQtSS
 UKnA==
X-Gm-Message-State: AOJu0YwKxaQKIaSDkRpWF4Mdcyax31MLXX2YnkZ8uKGGtApcW6O00ZPT
 OlAHOfnuVFmOpSg73sdPaiFKWz/sWpef2DuVX4lziTyCa3Ubxr1txLP3LgeugABienqKWNL9+zo
 QjGItUPnZIFcaMn29AOURdnBJJv6xmHj4k9M=
X-Google-Smtp-Source: AGHT+IGecmqKM2jBSiPwnPWYALCcFMBKvL0W5wMxoH4B6m9bFDfwo1AfqUyfT6bqo074dYMkDfiJE1ysXsATy31LPSM=
X-Received: by 2002:a05:6122:4592:b0:4b6:bee9:3cbd with SMTP id
 de18-20020a056122459200b004b6bee93cbdmr592342vkb.5.1706312146455; Fri, 26 Jan
 2024 15:35:46 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTO9aVPxkvWp_PY+NwB+bzzNtJ211NxQLHxi_uz_1Gce4w@mail.gmail.com>
 <20240126131951.24af4e07@namcao>
In-Reply-To: <20240126131951.24af4e07@namcao>
From: E Shattow <lucent@gmail.com>
Date: Fri, 26 Jan 2024 15:35:34 -0800
Message-ID: <CANV2PTMV80wNesNHSYdDwO2a1T1GPrA0orivnMWZXkV2WYzuZQ@mail.gmail.com>
Subject: Re: riscv defconfig starfive visionfive2 env is nowhere, missing
 axp15060 regulator, misc vendor hacks for Milk-V Mars CM Lite
To: Nam Cao <namcao@linutronix.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Aside: Mailing list archive mangles devicetree node names in the patch as
if it were an email address to obscure.

related linux dts axp15060 node naming updates:
https://github.com/MichaIng/linux/commit/1419a6eeb6a8b834ce9631fc558a57fb63=
4f6949

GMAC and eMMC functions depend on power regulation.

The sus commit for ENV_IS_NOWHERE=3Dy in the starfive_visionfive2 defconfig=
:
https://github.com/u-boot/u-boot/commit/7d79bed00c9e02187a09e74e90c5bd5a927=
a6a61

Why should ENV_IS_NOWHERE=3Dy and CONFIG_ENV_IS_IN_SPI_FLASH=3Dy both survi=
ve a
make oldconfig, I would think they will be mutually exclusive. Local
testing make starfive_visionfive2, disable ENV_IS_NOWHERE, compile and
flash to the board and saveenv works as expected.

On Fri, Jan 26, 2024 at 4:19=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:

> On Fri, 26 Jan 2024 02:53:45 -0800 E Shattow <lucent@gmail.com> wrote:
> > There is missing the AXP15060 power regulation in u-boot needed for
> SDCard
> > and networking. As it is happens to work for some variants and not
> others,
> > and not always. The AXP15060 driver exists in mainline Linux as a varia=
nt
> > of AXP20x and there are corresponding devicetree entries of the StarFiv=
e
> > JH7110-based VisionFive2 variants queued up (ref: *1 Patchwork series
> > 806238).
>
> I sent a patch to add AXP15060 power regulation device tree node:
> https://lists.denx.de/pipermail/u-boot/2024-January/543614.html
>
> However, I sent it because it is needed by OpenSBI to reboot/shutdown. I
> was not aware that U-Boot also needs this.
>
> Best regards,
> Nam
>
>
