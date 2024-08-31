Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC51CA101C
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 11:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D6C8863E;
	Sat, 31 Aug 2024 13:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UqHM1sqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2970E8888F; Sat, 31 Aug 2024 13:16:53 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF8E884DB
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 13:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5343e75c642so3560064e87.2
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725103010; x=1725707810; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nET3b3DVeArkXHXIiMc7G7+xPaGpw/mVXd2Kj0G1rDg=;
 b=UqHM1sqVecbsRUWXSZi5FP5QgfOdECTKAW0zFE2Gsao49GrIiFBgbN2ASgYXp9tCHm
 SC+hv/cycCd4TgdjYvRNYvI/94PlvmB5nXwPPG9pD8WzfXEhPT3RPTd7BKCaimv11bTv
 UjLeSL3lhtoX9JbWeexj3/+f40wFCLJMVuRDsxnxClqY0UelAgzbHj5cUIGw6g9pDRTL
 H08PGkrHcjuheHJ15QO8CzS/x2yR1zsXnQTIu/zBoAtvoPeKZ1Q1FzpKsWMhWAfz0i5z
 8aFP+WKj+aALqTdFUhKyeV1UmNhvaT154EWsVCkf4ae2igekfm8fg25cg0UEC5Pccle5
 x7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725103010; x=1725707810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nET3b3DVeArkXHXIiMc7G7+xPaGpw/mVXd2Kj0G1rDg=;
 b=Y+5qxaYmYagEkhUudigsdLXwfsX8fuC/7irR6sXUQnbnqg0Q7XpeOsuw9G+atdgkdI
 eFvqdUovKd64rCuqP+FKlKAq7gTAtm0JRCGGwbjuFlASF8XKg/imfvKn3q2FkcZqqo/G
 ugWJbbBhnuyakQrxHKmm+a4DnPgCliqlMuJRcfl06ay0jy2e/38Uv7lJqzSW+0mzlY7a
 FLLngOGgf7ECRLQ/axa6Z9ZY/vevcBLTow3KNvaZesche4x/40zTsVF7D7Zg1qLrNemR
 aI/FwyXdf7kygkXQiD7xC7ByBfcZy/MUtlMPorC2dcs17hXvWFBpNHvpCG6qH3l+twC8
 zH0w==
X-Gm-Message-State: AOJu0YzwmDVtnQm6z/SSAd8Hw/ljpYq/mExaDcPN3z1TzUG9rabeZcSR
 QpWLCt+/vOgVMOqK2K5L7pugWGDTm4Zb+fXm+AAeThFaHJqn8hu8X6MeTTnI7LtH6/J5jswvDnm
 zfRvWo6+wIthdjnJLQioh2LV319Y=
X-Google-Smtp-Source: AGHT+IHI/AoI+XEW4Gbn3cPEwzHDVU81tstT1XjQpTEsc3C+IIq3I1P9imqX0VJ3Yva33xQg0e3ZDvHtQ49qfTh23Z8=
X-Received: by 2002:a05:6512:3191:b0:52c:e4cf:4f31 with SMTP id
 2adb3069b0e04-53546bc01a4mr3646955e87.49.1725103009481; Sat, 31 Aug 2024
 04:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240827200400.217058-1-marex@denx.de>
In-Reply-To: <20240827200400.217058-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 31 Aug 2024 08:16:38 -0300
Message-ID: <CAOMZO5CXfVAXnyZ9s5dZdHbK+QLJZvmP5UeUaz=Bkv3mtbxc4g@mail.gmail.com>
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

> +/*
> + * Place early TLB into the .data section so that it will not
> + * get cleared, use 16 kiB alignment.
> + */
> +#define EARLY_TLB_SIZE SZ_64K
> +u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(0x4000);

This causes a CI failure:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/895190/raw

   aarch64:  +   imx8mp_beacon
+arch/arm/mach-imx/imx8m/soc.c:602:24: error: 'SZ_64K' undeclared here
(not in a function)
+  602 | #define EARLY_TLB_SIZE SZ_64K
+      |                        ^~~~~~
+arch/arm/mach-imx/imx8m/soc.c:603:14: note: in expansion of macro
'EARLY_TLB_SIZE'
+  603 | u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(0x4000);
+      |              ^~~~~~~~~~~~~~
+make[3]: *** [scripts/Makefile.build:257:
arch/arm/mach-imx/imx8m/soc.o] Error 1
+make[2]: *** [scripts/Makefile.build:397: arch/arm/mach-imx/imx8m] Error 2
+make[1]: *** [Makefile:1897: arch/arm/mach-imx] Error 2
+make: *** [Makefile:177: sub-make] Error 2

Please take a look.
