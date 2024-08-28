Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03A9C636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D6408857C;
	Wed, 28 Aug 2024 20:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hv1/qHn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41C788916; Wed, 28 Aug 2024 20:36:09 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51AD80805
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-533de5a88f8so6621073e87.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724870167; x=1725474967; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbjpZIiEBDiLSjZy7BgydKGdhv/3eL/qI4wRA65slac=;
 b=hv1/qHn5Jjp6AUntCeL1XNen5zFPopYet/IcHwMj1zHU4E+BqCHAlmN42hjjJ9qEuC
 ijag8PPvYh+Nh8Xd7SQtfc6UrSe9dC19NjPjOQWGpu4dpWMALZwX61by7LTaUoJb6kIW
 oYRW1Kzfl8O74DWwJ9OzFNyYo1ufyHzfF/paNCjIL7V3WPoqaJq0ifz5PLHIP72/Hpeh
 36Sbqjvjpt+4VRswlJkicHjQdv10MUhs4nqH/KWjT/qkYlcxVo0Sym/hGevGGtXdi/Ws
 H3o1XwVSU2Jly1lT3s5iTTNkYnGnO7JFcVsvvCPYAv1Sm4PquB7HSZVN/OZTXvg4Zy92
 gxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724870167; x=1725474967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbjpZIiEBDiLSjZy7BgydKGdhv/3eL/qI4wRA65slac=;
 b=Y0kHuY+Cb7JHbi18yNHZKm3nSXutcQerLUtfd2iIr6PnBia0hNoKcaGsuKsMKWZFsd
 PsytQwCuzkbDf1HAOQronUpQgSwtvspxkTTuumDUrfGp4Qj1siTma6CncA5jNenEaJGO
 Mo8bpf5twNb56tzQjuD4XqA1U8W/MyVbElAMVDEYNBfPdDbPwljKZZWYRe0VPii3GC4+
 +MbhjhuL5U253PUBSZVqOw7VSAszc1dQO1hCyKBHm9p0xVaQE1hhfhoTZZUCT4TLpjFZ
 Imd3XyN89JInNc0Agl0sMSbH2iQSr1ZBlkxcdt47gVaOovV1V/HZal0S52QE8zE1YgH9
 gqow==
X-Gm-Message-State: AOJu0Yyr0CHClDp7xPe/JMg5xqHjgiDMxaJ+XkMi1kV2bdll2gQLisAX
 2sVRU6jpM9v5/bJdooyBbYvP4/zuVvwXA6hTJd47Jhp5dPjhcCVXmO4BanlvAi9q9HNH4cc1mCI
 y/X0DwBn2DCdvXK31NA21t3JrnYQ=
X-Google-Smtp-Source: AGHT+IFVGvLqq6EhUjIxuy+19nzslttpGsnJiC75zyfeU58g2m3r2UcWMlNUo8A2nJtVZA1cJe0WZXhJQgCCnKvur7g=
X-Received: by 2002:a05:6512:2211:b0:530:ab86:3 with SMTP id
 2adb3069b0e04-5353e54640emr110777e87.1.1724870166675; Wed, 28 Aug 2024
 11:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240827200400.217058-1-marex@denx.de>
In-Reply-To: <20240827200400.217058-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Aug 2024 15:35:55 -0300
Message-ID: <CAOMZO5DDkkV-M+3MEUJAKJwFMwSdFfkJTySkc=0aG3CxCdWHVw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable MMU and dcache very early on i.MX8M
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Tue, Aug 27, 2024 at 5:04=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable MMU and caches very early on in the boot process on i.MX8M
> in U-Boot proper. This allows board_init_f to run with icache and
> dcache enabled, which saves some 700 milliseconds of boot time on
> i.MX8M Plus based device.

Nice improvement!

Reviewed-by: Fabio Estevam <festevam@gmail.com>
