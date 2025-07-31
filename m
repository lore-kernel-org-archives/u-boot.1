Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8969C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 18:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BD5838F3;
	Thu, 31 Jul 2025 20:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MIsu9+5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1474E83900; Thu, 31 Jul 2025 20:47:22 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF979838D4
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 20:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76bc68cc9e4so946622b3a.2
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753987638; x=1754592438; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5RmlQ1OTExx2EWzz5tbkHkNVXRExtStkNWFZmJwCvPE=;
 b=MIsu9+5wgcavpcIk9Nbo2mYk2erlK/yAkwGmPoWFWOFNttRZHQ2TginIAZu3LF+9YQ
 jVx63D154G3U2kOo2rIER6EpvICXgaOutScP1HztQI2dYKJ0ONDTJg7F+Kkm8Uk72Sda
 BpEIpztvHhp1qN89OQ3Ux5UdeNPP8LUqs6CncUyAkPLGfW6T6gUV5E5g4mMhHTQXsGzy
 81qhzoi00/7/MEhouRu5oT11V6Jks1gLqC1ZzctJ6oMUCVKI5lFHC3KPybsy+5hDp/5U
 x0Hh6g+Efvw9/FczsOPoTdLf5aABiioDI76vEGb2EmRSxHfqlHRf7Q9LURlSn89Z4ZAj
 nYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753987638; x=1754592438;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5RmlQ1OTExx2EWzz5tbkHkNVXRExtStkNWFZmJwCvPE=;
 b=PdSPJX/1B0bX98/c3pzV/B3Yhz+kqs4kyob3qNNWSGFK3ah5RPizpG25Xfx5DLwoa+
 yzJyaj4DQUDHLUMzHGIDoQud5EUTNKVNLW3bBs07ok/uxy611bqY59vpRvgBYRoBn+ey
 45RHqY9RkQ6taxfHhRQa3ZkqqnRIMIaWlPiQfgmxIgZOcOlHLjAJzYeuxHdsvF66LHkf
 2j2lDzQf7ia8EduDwG2DmOSz5cPMQAltWX5ROJAugOsuP05lEzb+0clBnEvBq1b3Ecrn
 /bDDbeRS0B+7QZ3Hxt2oy6sdjT486n5ru4qKpVb+lI/9YuaggbE7rT5mEEaFqe7f0aSp
 611A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+sbKEYenBJtcA/AOpHtHyAhZq+QMUyjwp5dxjWRS+Z0iud1PmTIxY4Vi5ETXJYbmpFfDEmH8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2OkTyobHI6GOi6d5XulfUiEMB+qodXJ57xwZgZhe9OZ+Y8EV1
 iKVx1GCrXLy4mcDOkY1fWeZ65HGpUMFz3O8NhOkDGCyhbyHWAoMkWZAf
X-Gm-Gg: ASbGncsemG/zMvIwW0JW7su9BjIrbxSHt4cyHDulHs4CPzofSc8oqG3gcLbA3LDqiFj
 QYjOkwXVNxKId7oCI+M0soAXCUlQYi51aRDK8zdbx9uITkgJMC/vwtbjFzsiR0ceci83Cb+uXYh
 znqva6KSLAHP+2BxB6zGEgmcebBT28Ii6taRv+RfIcTQuI8UZ89p2NR+VrclI1g6nuGYQZ7Ohg0
 x9qQ7ymDexvJAgGRRiAkY6GP9rGu5sD9bceKNUWvnZ1PtoivvRZsYrF8Ns+BvS6bjW6dZYBVwdb
 XZQ7cPqt/+quG+14mb+jyp67zV1qJ3nRceEcYrdKG8YV+QEFGzEToxD4hruoEzQKGj/DUtDLjUI
 w1tBIdwnYMiGq5Zkyz5rt+Ug/304K99lSGQ==
X-Google-Smtp-Source: AGHT+IEMKTkjw0ujbmBCix3vKSClESnH/yA6hZqrjK6AsMOYvCh09w0nlBslrZ5XmWI2+T/g0NB+fQ==
X-Received: by 2002:a05:6a20:a10d:b0:233:4862:753a with SMTP id
 adf61e73a8af0-23dc0cdf00dmr12908798637.0.1753987638044; 
 Thu, 31 Jul 2025 11:47:18 -0700 (PDT)
Received: from joaog-nb ([2804:14c:490:1191:d2f8:4e20:22a4:a32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f91esm2237625b3a.27.2025.07.31.11.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 11:47:17 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:47:12 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Fabio Estevam <festevam@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@oss.nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
Message-ID: <pqr4l75nuc57vmrp4r3hjwjxi4p5dgwxlz7h5nrn77rfxwpfmr@dto7364jv2ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5DT=ua+vCX5OQq6sx1nfcFjFY0S1hJ8OmNE1RWCQAmxJg@mail.gmail.com>
 <e5c64596-b118-4394-87b6-1b121c801af2@kontron.de>
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

Hello,

On Mon, Jul 28, 2025 at 11:25:04AM -0300, Fabio Estevam wrote:
> What confuses me about João's patch is that it was not tested against
> the mainline U-Boot.

In the end, the code is nearly identical between the downstream and
mainline U-Boot.

On Wed, Jul 30, 2025 at 08:35:40AM +0200, Frieder Schrempf wrote:
> I have the below patch in our downstream fork to fix the issue mentioned
> here for i.MX93. It is derived from Fabio's patch [1]. I'm not sure if
> it's correct, though.

We are also doing something similar on our branch.

I have two proposals. My goal is to prevent the board from hanging when
booting from USB if CONFIG_ENV_IS_NOWHERE=n (since the current code
assumes it is always enabled) and/or if the environment is defined
elsewhere:

1) Imply CONFIG_ENV_IS_NOWHERE for i.MX9 (as mentioned earlier), to make
it clear that it is required by ARCH.

or

2) Doing something similar to what Frieder showed for USB boot (which is
almost the same on i.MX8MM/i.MX8MP), but preserving the current
behavior:

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 13f13ca7d105..f973652d0cbe 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -635,7 +635,8 @@ enum env_location env_get_location(enum env_operation op, int prio)

        switch (dev) {
        case QSPI_BOOT:
-               env_loc = ENVL_SPI_FLASH;
+               if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+                       env_loc = ENVL_SPI_FLASH;
                break;
        case SD1_BOOT:
        case SD2_BOOT:
@@ -643,10 +644,16 @@ enum env_location env_get_location(enum env_operation op, int prio)
        case MMC1_BOOT:
        case MMC2_BOOT:
        case MMC3_BOOT:
-               env_loc =  ENVL_MMC;
+               if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+                       env_loc =  ENVL_MMC;
                break;
        default:
-               env_loc = ENVL_NOWHERE;
+               if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
+                       env_loc = ENVL_NOWHERE;
+               else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+                       env_loc = ENVL_SPI_FLASH;
+               else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+                       env_loc = ENVL_MMC;
                break;
        }

With this patch, I believe Peng's concerns are addressed, and it also
works for our use case.

What do you think?

Best Regards,
João Paulo
