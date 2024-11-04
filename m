Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454ADD132B5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92A488C9C;
	Mon,  4 Nov 2024 13:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zr6Cof7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F91A88D35; Mon,  4 Nov 2024 13:30:38 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F3E88009
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb5638dd57so37108461fa.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730723436; x=1731328236; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/GmbjUdPd49adkdcimSw0wnGkKlXaIMCt7oKTTJK0E=;
 b=Zr6Cof7FcCQiFlMTW/wfLvyAcYW2YOGqxvQ/a97K4P7x+//GZsvhQ48GpnfDNEX/s5
 ZMTy8HAA/jEcW0s2eFWDZoYdDBosandmIhrYAPQEH1O7TMTjZfsi6zzIOIIQ+8moz2t0
 cjPipAhCQg6sRBal3xp348D93hIhpXNVL7BDcGjCCSf0/SU/ymtYgF+UUC1x0QE4EPXC
 qz+EZopnOnw4NQEAgPOHpFIbhJLd8HXLlXw54maFa6IridfSZoKBHMG1ypI4nuPouNFp
 MNS/2EppCA4YR3v8fM/Lw2rUvsvrP796QOwM7fxVIwymVakOmZNpC/IBizJGEkDatUrZ
 4t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730723436; x=1731328236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/GmbjUdPd49adkdcimSw0wnGkKlXaIMCt7oKTTJK0E=;
 b=VuTNDo535xqaywyqVJFmjvCVbaPVX/wuVo23Oa6K0fW0Ae7pqyrVHTRpepn3NM49kI
 3JJ0SZ+mbjuInt7E02j+29CqiEOAi+B+BRSQ+FiKuzuGzslA/kIEsctrdeZNpC7cAi1s
 cFNDtjSnGD5Ww7dhl6a5CUVv/9y56wIndsVambQeNZd/33gj+TWN1Ts2FPKFXWfVQ9R0
 6f12Q6wl2PCwigjOacUvGAAuDfOXWhpcXXwpes/jEgLIWR5dPc8ppQaUUNg2u9QMF/oJ
 Z58RiPw1z+iDRdxrX7KC5jhS29L7f+AmXPYNdWCVEnPtDBqoPL8fkV4A+aeI1iilE1z/
 KRBg==
X-Gm-Message-State: AOJu0YwEMqpihNV0FQxmq+MGmHW93pHxL/jfJtckancBywSYAVPq1oEP
 GdA9cMDCQ9kqv+JzEogqt2LRJALXXbXKqVvP0ZhZvJXfhO0fRj2BKwjnHMofSL2/X//8XkJzdLP
 fyfE/EMv9EPE2JiSSywxXbFiW4AM=
X-Google-Smtp-Source: AGHT+IEfATuIUVKYk6MErJ+sxpl3TEmCCrmLX2OzePu5RMcAkaHEFBWedqwyLd20O75UvgzhlB38x1YygaofH0xFvs8=
X-Received: by 2002:a05:651c:1a0a:b0:2fc:a347:6d87 with SMTP id
 38308e7fff4ca-2fcbdf7db3dmr140905341fa.13.1730723435517; Mon, 04 Nov 2024
 04:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20241104104148.748331-1-c.stoidner@phytec.de>
 <20241104104148.748331-2-c.stoidner@phytec.de>
In-Reply-To: <20241104104148.748331-2-c.stoidner@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Nov 2024 09:30:23 -0300
Message-ID: <CAOMZO5AW5+nDHODrOMD2G6AZrzQbR5OiM85GaW6Q1dY_sx+iog@mail.gmail.com>
Subject: Re: [PATCH 1/3] board: phytec: phycore-imx93: Add 2GB LPDDR4X RAM
 timings
To: Christoph Stoidner <c.stoidner@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Mathieu Othacehe <m.othacehe@gmail.com>
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

Hi Christoph,

On Mon, Nov 4, 2024 at 7:52=E2=80=AFAM Christoph Stoidner <c.stoidner@phyte=
c.de> wrote:
>
> The phyCORE-i.MX 93 is available with a 1GB ram chip or a 2GB ram chip.
> Add the ram timings for the 2GB chip, in form of a diff compared
> to the existing LPDDR4X 1GB timings. With that, the SPL can select the
> appropriate timings at startup.
>
> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
> Cc: Mathieu Othacehe <m.othacehe@gmail.com>, Christoph Stoidner <c.stoidn=
er@phytec.de>, Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de=
>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.=
com>, Wadim Egorov <w.egorov@phytec.de>

As Teresa pointed out, the correct way to add Cc is as follows:

Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>
... etc

You can even put the Cc list below the --- line so it does not appear
in the commit log.

Please run checkpatch on all the patches too. There is a warning on
this one that is easy to fix:

./scripts/checkpatch.pl
~/Downloads/1-3-board-phytec-phycore-imx93-Add-2GB-LPDDR4X-RAM-timings.patc=
h
CHECK: Please don't use multiple blank lines
#879: FILE: board/phytec/phycore_imx93/lpddr4_timing.c:1350:

+

total: 0 errors, 0 warnings, 1 checks, 1051 lines checked
