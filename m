Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C28C3ABAA
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 01:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCCAA8213D;
	Sun,  4 May 2025 03:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbL6GCZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0780D8215D; Sun,  4 May 2025 03:52:37 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA36082114
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 03:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30bfed67e08so31427991fa.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 18:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746323554; x=1746928354; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maCQTLfn9UG/06v38N3a1VkYxSRlvRilhbSsEZsqNNc=;
 b=CbL6GCZaUfc2AqVlXNaWiEhqi638+rOpSBBA8yO1XvhuQZSr+q2DfJqHG6h61vxTIN
 0+HcixTccGB8TDhjwq00zbJUfulifypvbOQvC5UzHBswL/PPZemMMcEIgD/C4jkjuuuO
 1uZmYY/TBShhw1LrdHcPVoDwqEgqt1D2nDyzrbiNgTT0g8IuCE+2xVVB9mJCf2OBz9dj
 6cp5y1UG+0TpgMy3pBP+Eu5BEQxuXw93Z3JU3Y5ZxWMPeLJYgFDTtFmVHUsHNtoRF0lz
 YXxoS948rQntEAtU7LUgsxd2a80LUI13AaQ7odMi81FUIfYw8Wn1IvloFehGxTQ+p8Nb
 Q0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746323554; x=1746928354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maCQTLfn9UG/06v38N3a1VkYxSRlvRilhbSsEZsqNNc=;
 b=Rva6A3Valdi5iEn6v/AM2O5c+357vqI1l5YXkkM3cBvttUeCyHeF6duk1d2GcUQhIR
 SF6Gc96VOQIcNrj4mrJuWH3xN9IMlVWYAXiDUNxTst/H2jxIWI5RLPIasOkM1P/6E3E1
 PYloklf7N7lcoskLWW/wv8j8azRDxDowJlTHbwdPmKEH+N2XSnIR9AaX6yJIwMEmyLl6
 8O/FaudfVlTsnE92koeAeWoTZrhurT5ar19ngS909RG/39EcVqqwugLt6ker7rQaw4cN
 lRsHfUyGs9TnU+UYOX5V7WA0ys/V7SakMcNV8eSDHQD2j+PxghNxNXN45bgc+aL3gDIF
 9KQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO68NXmcg7nhKWLx8UnggPFlSp2oyn9L+AA7Qb2FQDBrbSMioLAU4GTHwZ28boc+y8koOvJyQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyhQc5Kdy39mh7/7yy/w3w3IFrs79jb3stEt/Hmynximpqf4l5h
 sXUBFoE3nCvryWZRpGYpnP4j+eL14QJqfLFhnbtnUR+Q26iDoR1lwpbYDdMBftErRhAX/x9+6TS
 zFfORdvCnjGHott+vND+/Gy7FH/c=
X-Gm-Gg: ASbGncsw6+4nSIyYvrIbaVlFzHLzOikmZO0ojMIJNwg2qRyL7X8I0Mx+XdoFugKiUkJ
 PP/ghM0ZUr4FT0RFOfztxM7sgFmsjz1JCE5CXM4ioQPOdwK2gwp2toLMOBXGFdzlMYsuRlje2O7
 3Inlajo8WObrSy0wyDonohlUZ1+L26h7/aiVVd8g/VojA8MKaScuaHwg==
X-Google-Smtp-Source: AGHT+IEiqnK4tgOpOVaqFhTdA2L0gk7eDbvppxRh/RsQzIIBmb9GelINWOrfd6GzeVGuUKCJflzJGy32X1aOLYf8FyU=
X-Received: by 2002:a2e:bc17:0:b0:30b:8f84:49c5 with SMTP id
 38308e7fff4ca-32351f2189fmr9256951fa.28.1746323553746; Sat, 03 May 2025
 18:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250418210430.27458-1-dullfire@yahoo.com>
 <20250418210430.27458-3-dullfire@yahoo.com>
In-Reply-To: <20250418210430.27458-3-dullfire@yahoo.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 3 May 2025 22:52:22 -0300
X-Gm-Features: ATxdqUGFA3mdMSpo31Jcs9bLNyAGGm6KKlVpT-EckxI_WiU1Mqk74RJGW3_9qVc
Message-ID: <CAOMZO5Bfq23ocQXd5pvsHzD+dnRexW=PFunf27dwtmz2o_ov-w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] spi: fspi: Add imxrt1170 device data
To: Jonathan Currier <dullfire@yahoo.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
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

Hi Jonathan,

On Fri, Apr 18, 2025 at 6:04=E2=80=AFPM Jonathan Currier <dullfire@yahoo.co=
m> wrote:
>
> Add the device specific driver data, the device tree entry, and the
> clock configuration.
>
> Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
> ---
>  arch/arm/dts/imxrt1170-evk.dts              | 28 +++++++++++++++++++++
>  arch/arm/dts/imxrt1170.dtsi                 | 13 ++++++++++
>  drivers/clk/imx/clk-imxrt1170.c             |  9 +++++++
>  drivers/spi/nxp_fspi.c                      | 10 ++++++++
>  include/dt-bindings/clock/imxrt1170-clock.h |  4 ++-

Please split the devicetree parts and driver change into two separate patch=
es.

> +       clk_dm(IMXRT1170_CLK_FLEXSPI1_SEL,
> +              imx_clk_mux("flexspi1_sel", base + (20 * 0x80), 8, 3,
> +                          flexspi1_sels, ARRAY_SIZE(flexspi1_sels)));
> +       clk_dm(IMXRT1170_CLK_FLEXSPI1,
> +              imx_clk_divider("flexspi1", "flexspi1_sel",
> +                              base + (20 * 0x80), 0, 8));
> +

CI reported the following error:

       arm:  +   imxrt1170-evk
+drivers/clk/imx/clk-imxrt1170.c: In function 'imxrt1170_clk_probe':
+drivers/clk/imx/clk-imxrt1170.c:169:28: error: passing argument 1 of
'imx_clk_mux' from incompatible pointer type
[-Wincompatible-pointer-types]
+  169 |                imx_clk_mux("flexspi1_sel", base + (20 * 0x80), 8, =
3,
+      |                            ^~~~~~~~~~~~~~
+      |                            |
+      |                            char *
+In file included from drivers/clk/imx/clk-imxrt1170.c:15:
+drivers/clk/imx/clk.h:195:55: note: expected 'struct udevice *' but
argument is of type 'char *'
+  195 | static inline struct clk *imx_clk_mux(struct udevice *dev,
const char *name,
+      |                                       ~~~~~~~~~~~~~~~~^~~
+drivers/clk/imx/clk-imxrt1170.c:169:64: error: passing argument 3 of
'imx_clk_mux' makes pointer from integer without a cast
[-Wint-conversion]
+      |                                                                ^
+      |                                                                |
+      |                                                                int
+drivers/clk/imx/clk.h:196:39: note: expected 'void *' but argument is
of type 'int'
+  196 |                         void __iomem *reg, u8 shift, u8
width, const char * const *parents,
+      |                         ~~~~~~~~~~~~~~^~~
+drivers/clk/imx/clk-imxrt1170.c:170:28: error: passing argument 5 of
'imx_clk_mux' makes integer from pointer without a cast
[-Wint-conversion]
+  170 |                            flexspi1_sels, ARRAY_SIZE(flexspi1_sels=
)));
+      |                            ^~~~~~~~~~~~~
+      |                            const char * const*
+drivers/clk/imx/clk.h:196:57: note: expected 'u8' {aka 'unsigned
char'} but argument is of type 'const char * const*'
+      |                                                      ~~~^~~~~
+In file included from include/linux/libfdt_env.h:13,
+                 from include/linux/libfdt.h:6,
+                 from include/fdtdec.h:17,
+                 from include/dm/ofnode.h:11,
+                 from include/clk.h:11,
+                 from drivers/clk/imx/clk-imxrt1170.c:7:
+include/linux/kernel.h:44:23: error: passing argument 6 of
'imx_clk_mux' makes pointer from integer without a cast
[-Wint-conversion]
+   44 | #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
+      |                       |
+      |                       unsigned int
+drivers/clk/imx/clk-imxrt1170.c:170:43: note: in expansion of macro
'ARRAY_SIZE'
+      |                                           ^~~~~~~~~~
+drivers/clk/imx/clk.h:196:84: note: expected 'const char * const*'
but argument is of type 'unsigned int'
+      |
 ~~~~~~~~~~~~~~~~~~~~^~~~~~~
+drivers/clk/imx/clk-imxrt1170.c:169:16: error: too few arguments to
function 'imx_clk_mux'
+      |                ^~~~~~~~~~~
+drivers/clk/imx/clk.h:195:27: note: declared here
+      |                           ^~~~~~~~~~~
+drivers/clk/imx/clk-imxrt1170.c:172:32: error: passing argument 1 of
'imx_clk_divider' from incompatible pointer type
[-Wincompatible-pointer-types]
+  172 |                imx_clk_divider("flexspi1", "flexspi1_sel",
+      |                                ^~~~~~~~~~
+      |                                |
+      |                                char *
+drivers/clk/imx/clk.h:142:59: note: expected 'struct udevice *' but
argument is of type 'char *'
+  142 | static inline struct clk *imx_clk_divider(struct udevice
*dev, const char *name,
+      |                                           ~~~~~~~~~~~~~~~~^~~
+drivers/clk/imx/clk-imxrt1170.c:172:16: error: too few arguments to
function 'imx_clk_divider'
+      |                ^~~~~~~~~~~~~~~
+drivers/clk/imx/clk.h:142:27: note: declared here
+      |                           ^~~~~~~~~~~~~~~
+make[4]: *** [scripts/Makefile.build:257:
drivers/clk/imx/clk-imxrt1170.o] Error 1
+make[3]: *** [scripts/Makefile.build:398: drivers/clk/imx] Error 2
+make[2]: *** [scripts/Makefile.build:398: drivers/clk] Error 2
+make[1]: *** [Makefile:1919: drivers] Error 2
+make: *** [Makefile:177: sub-make] Error 2

Please fix and resend.
