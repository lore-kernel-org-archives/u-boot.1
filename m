Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4218DD43366
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 14:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898D78927F;
	Thu,  7 Nov 2024 15:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eRMP+pup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B010D892A1; Thu,  7 Nov 2024 15:16:42 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 435ED89270
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 15:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6ea5f68e17aso10609737b3.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 06:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730988999; x=1731593799; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+EKd+fuC2X1dZiuS2TRWG4f6GxX9+nR8Ki45pbRHRo=;
 b=eRMP+pupgBxULSp3UQ/NeHoZYUQhkqKjFvedvYIe3tpAEyCyH+RN+NQEnEnEsqlm3S
 t+lkaYjIPiZEjnQv2gjOPljuKBdkrQGtk2LWllNtgDLGfK278GoehiSdp3I4SqhVApNf
 qsTDe4ytniqqtKg6DyECL2s9O4rneqwCw8WqVhMH2oCEttG8nyCbl4/5EotjVt8W7Pcg
 2oTxIAmxRIV4peyGjH6iRAxJkeAOncLJmrka/Dn+xJglTqQmQFpvmJxB5AxlYxxCJJ+i
 rl+gkCP677JvCXidW7eFtWF/Sny0Qi30L+kFw4MLnxBzQAtjWRxvnOhZG9Ku/niySes8
 Uexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730988999; x=1731593799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+EKd+fuC2X1dZiuS2TRWG4f6GxX9+nR8Ki45pbRHRo=;
 b=ZxjGvn7vPTyJVq+fiW/6JXFxd4Lo95Bm+tAnHq85VA1q2PodsLNQiRdwrVLW6Z+Kuk
 LsVs6gEiK9NvP9aoLKMeipMMERufeg4GZq4JXKYRPFe5n4oSd1NWdvgS/FYBueN7pKqO
 X9I2cf+GegJbnsWcek+0GNhC3+n5PKxkkk4rGrgqZ1SHAo4eMTmZ+debK4YO3NVS3XN0
 DQI9yJjBSN+UowKyFuNGyTLsuobJes4v8cLVmJZA5z/Sf2V4a2pK+JXjEB56Ghgtiqao
 C/7vVQHGRSyvtEZqOym7aylDt3Jfh62tBLODC9LQ9AueM88CeTqMJQI35eU8KpI6ceyk
 La2g==
X-Gm-Message-State: AOJu0YwwQyQRUXEQv+fVT2FHcLF2zE/ismx4CI4O0v5MzRXJl4H7ToJd
 I+FavMUsr0LztL3pMhBEb6c+7fCGi1uIXIvXw6k+ckEqEm/ck9CcVzR4DBzpKrqIuwLomhrCUBT
 BZW+Y33Nnd4yAFxAXYBUdEnUX3RWr5/XOGM8uxZiyI0Kl3aKZeFc=
X-Google-Smtp-Source: AGHT+IG7QHiG2FIv72Bs2KIabf6o+8U8S7Yl4M7QKweQPLtL8FYkdH4hQY7JokF8YShX+2h1Vz09rxWlo1ubqJUF7VE=
X-Received: by 2002:a05:690c:f15:b0:6e7:f98e:12dc with SMTP id
 00721157ae682-6e9d88cf8cfmr452385887b3.9.1730988999120; Thu, 07 Nov 2024
 06:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20241106210348.218507-1-dregan@broadcom.com>
 <20241106210348.218507-4-dregan@broadcom.com>
In-Reply-To: <20241106210348.218507-4-dregan@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Nov 2024 15:16:26 +0100
Message-ID: <CACRpkdYt64S=X2_-VO5h=0kgZ5hcoVWOnzYRK5k39AX0cMkD_A@mail.gmail.com>
Subject: Re: [PATCH 3/4] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
To: david regan <dregan@broadcom.com>
Cc: u-boot <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@mail.com>,
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Wed, Nov 6, 2024 at 10:04=E2=80=AFPM david regan <dregan@broadcom.com> w=
rote:

> The BCMBCA broadband SoC integrates the NAND controller differently than
> STB, iProc and other SoCs.  It has different endianness for NAND cache
> data.
>
> Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
> and performance improvement using the optimized memcpy function on NAND
> cache memory.
>
> This is a port of the upstream Linux patch to U-Boot.
>
> https://lore.kernel.org/linux-mtd/20240223034758.13753-12-william.zhang@b=
roadcom.com/
>
> Signed-off-by: david regan <dregan@broadcom.com>

The patch looks fine, but shouldn't the existing brcmnand_read_data_bus()
in drivers/mtd/nand/raw/brcmnand/brcmnand.c also be replaced with
brcmnand_soc_data_bus_read()?

Maybe this is a problem in the upstream kernel driver though :/

Yours,
Linus Walleij
