Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700FFC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 11:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D183481E13;
	Wed, 30 Jul 2025 13:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HPNttCEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E555982BA1; Wed, 30 Jul 2025 13:18:10 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF88981E06
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 13:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-558f7472d64so803444e87.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753874288; x=1754479088; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BhVR4p5sBlQgPLBCD1OTzFM6elA9TGAGVzNp6PrxAI=;
 b=HPNttCEsGAlEMwCy53cMgS+vlUN9chW3O74cOfBzRLq3BslGTWyN9Vx+/xF6A/ACN0
 zT5/KQZjnW5SEip1L6Ec7ozcTcnqcvMOtrpaOIxCer/Li1rmRzPFVIgcQCfrDq5cl8bx
 eOggijOUwEJ5bB4k1pgrl2TbbiyTavuDfB4q60GpnmGrzSI2AR759KhARu1vYDioyffk
 bfV2FdbqHcvLiny46vsSZ+0hfPBcvfGlKv7KzH7elXiOCkH63h0QW+PZp9FEhce+rYPM
 QJUDAYthfWFMGaiVJEsQiTfL6SH7SRd6Wty/gD9epOdKmOE6rOARV2ihtdMrUxPQ9C6o
 MznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753874288; x=1754479088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BhVR4p5sBlQgPLBCD1OTzFM6elA9TGAGVzNp6PrxAI=;
 b=a2bEXv4Ln0HGjB9G6r/EJfRkVN2Y2++09uMFb5c5Fr+FM1AYy3s52H01kxvXIzYflH
 JgHNChue/gaY0yljz4svGl8x1sWpmn2rO61x0WG87lNxadpRe3Rm/riuiYmSjNEDkLxS
 SqCKp5MzsJSlBzxAJptL/z0ZzOMFNdRCRtF6Jo0x2ms217n4hCbhHG04aSJA8xXlLVms
 afaOrTuf2hld6ogK6asNbf+yNflHYwGqE72tBGfAmieVR4pVYzQK52glArs6HccXbSMM
 mlmXSvfIC6J3ZSHeI00JxiD0UrI4VsXJnEbKxQXuxVFMQQ5g8j/FkxqfI9tDYZcrt4Ds
 DLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Ii+HIMez3EDAOBbCqVIbbLZpJ8lX5qTO56/BoHNCocLeSOH2w1I2OYca6y8kQW0XyKwh8Bk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+jLAV5Rap0LjSHu2gVjCiE53Fw1trtQ5Z3gzR6WeU7+raKyet
 xxu/DkFLu/PFhMP4BUFPSCJOTqFyZL/zBJoXG7SYdjKvXfF+cvhXxo2HWUTpmlHSspQ3cs42eo5
 hN31APaQNeoZYLmlTKf2ORfuu5V/G4Mw=
X-Gm-Gg: ASbGnct6fcoPZkXo7LSxhtxtBvHRN4dOpENdtxo7olr8boNQdgXdWj3qwAWVnKF4fTv
 eu5OeiHRI+PkVGlJhC8DzdIwoJQu6wDeQI4DE4/6MhWJHJ7QJzvtVAWc6+w1w6lQ9PRLfPVXBOG
 7nYsqRPKxkKCo6/Ip81Qu2CxS78q3kbgnJEV02RETkcHUUJptp5VHMFgdr3gvFdIElPlFOfV4Mv
 9zRK4QIrVjG4OxIOJZctDsq1+6eR1yfe1s+opeyLObUYO6cPw==
X-Google-Smtp-Source: AGHT+IH68otZLeOiCKNFpBP6lqfZAV7kboe9toQtDNnvQXr412D0Nxj3x10GBGH5pNzTXUFIifQLGRO1KvMYTYebJss=
X-Received: by 2002:a05:6512:1384:b0:54a:c4af:15 with SMTP id
 2adb3069b0e04-55b7c366181mr1091442e87.19.1753874287904; Wed, 30 Jul 2025
 04:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-2-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-2-73da75bb33d3@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jul 2025 08:17:56 -0300
X-Gm-Features: Ac12FXxyZKd3w-d1e1Gd8kFHkskRJS9XsD7DeStAUPVPr7ehtYDANvIMxFLs6v4
Message-ID: <CAOMZO5Biqa8jf4Hv2mY+M=cxJDGwxjvkFYW_obQXDDX1CumtSw@mail.gmail.com>
Subject: Re: [PATCH 2/9] ddr: imx9: Fix DDR MRS bug
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>
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

On Sun, Jul 27, 2025 at 11:14=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_i=
nit.c
> index 5b0ad773875da9f6a57faa8c618b232056d1e702..7bade70bd0a1ca4d205ff4fb8=
525511188cb504f 100644
> --- a/drivers/ddr/imx/imx9/ddr_init.c
> +++ b/drivers/ddr/imx/imx9/ddr_init.c
> @@ -291,6 +291,8 @@ void ddrc_mrs(u32 cs_sel, u32 opcode, u32 mr)
>         regval =3D (cs_sel << 28) | (opcode << 6) | (mr);
>         writel(regval, REG_DDR_SDRAM_MD_CNTL);
>         setbits_le32(REG_DDR_SDRAM_MD_CNTL, BIT(31));
> +       while ((readl(REG_DDR_SDRAM_MD_CNTL) & 0x80000000) =3D=3D 0x80000=
000)
> +               ;

If this condition is not met, the system will hang forever.

Better use readl_poll_timeout() instead.
