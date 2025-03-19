Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE513C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 11:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF6181101;
	Wed, 19 Mar 2025 12:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l9H7sz8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E7898141E; Wed, 19 Mar 2025 12:41:24 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A752F810F2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30bee278c2aso7066741fa.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742384481; x=1742989281; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pE5Ge3Ls+gwRS7QcNTaDGaz0/hBm5K/mxVmeQ3wJ0bg=;
 b=l9H7sz8q/v7UEcbuBQWYAQrunLo/jUDQ1lLtzNUZq0l2vAM+qy7DzRi4PmszMEDjNI
 z3w+94/MtdgrdBSDoi3K5+mDST8uySBcSz04NtAJFfPgbb4NGg3qggVxZtNxkb5++LXR
 2Dbao484PLVlBqa/244JYGAEO14zcH6IQ68mZ6awsMEAO56j1aLirdhhuu/frgOnt6Dl
 uqGrSEwHafqwCB+W32YMKobHVZ8/66NZq/fbgiThgBIri3M/MHjy6vV4/rH6zZ2cE/MG
 a2jqJbw8Q81/PSJvPLxarelD0OBTJDVnSc337s7bjpjB0wCUXRMCjGRbvs3+ZFdFGf7J
 g6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742384481; x=1742989281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pE5Ge3Ls+gwRS7QcNTaDGaz0/hBm5K/mxVmeQ3wJ0bg=;
 b=hjECx66uwKQasN0zy/jRf9Uj55k/UzIM9ClDi8DzAzpUApaUw2Evi1IE1SczDkEmBy
 GweO9CsLVlp3PftAe+RipkIqT+zhUElIZ1+Xbs/5tNraWXtx8C/rMcagGZN53S0SkIxo
 e1RJ91qbP+ecuKeLDU+ZTEC0bJ3UJJBzJ5B7WSgDjdYS7GXThapqoNcRomCCqxdkFivD
 /9W5C3NjJLysZ+n1Fza6DT+fGJKbdPi2sCIqMO83SZ7hQQ6VvTg32cyjDpJOaK4isA07
 vOodFOH3/Qwuh1tzAmAz7oQay4pzTCWyHfyEJgx9D4AVLov1wL8cAQUzYWB3RbzIOBCe
 R8yQ==
X-Gm-Message-State: AOJu0YyqVLe6fLyVN9mxqch53i3hQH9kdbRjD5TQ+buwufHWxE7Ot4vU
 UpqaVfxLjLMFLKj9t4bjD81o50ZJ0DcZAFtvf3lAwHtCNqNRSlNDAu8q/dUNPjpA2WaOidPqTxn
 x7/mGhE0t2VT1eFX9qEQNsJFzEK4=
X-Gm-Gg: ASbGncvT8Gq7VdavVV3N3zEqk/qkMKc8AMdFKucLxIzKumDdXhpumdWifgW+l2yNkO2
 vvWPN0RKurt4kiEb92fd7hEDp1jh0UO/fwShBatDSraU7zf6ZC25y6md55nqIPsJJimLFMqWG6e
 ne54dON0Al2wZwDUyXarKA2w7yIuazzHPo+LKqwDRyHFk83Od0QuRg3ZeEYA==
X-Google-Smtp-Source: AGHT+IG2N66R7BmG9amEEey38SXj8H0r3guApPkCRNOn+MO/ZSg5lD2a5Y1jXAXwiFS2fEPymciPhgCa2us0eOI6by4=
X-Received: by 2002:a05:6512:3193:b0:548:ae6e:bf43 with SMTP id
 2adb3069b0e04-54acabe25d6mr871978e87.24.1742384480582; Wed, 19 Mar 2025
 04:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250318233849.587520-1-aford173@gmail.com>
In-Reply-To: <20250318233849.587520-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Mar 2025 08:41:08 -0300
X-Gm-Features: AQ5f1JrnWl1pwuRgzqoSwDtsZp7yzpzHAUVrc39akzD17pg-nMLgRRolU-N3CPw
Message-ID: <CAOMZO5CfmCCN=YgtvysOuq8Mm37ikjqDaso=Yy0GfiL1BtZacQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] clk: imx: Use Clock framework to register UART
 clocks
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Tue, Mar 18, 2025 at 8:42=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> Currenty, most peripherals enable/disable their respecive clocks using
> the clock framework, but serial ports various imx platsforms do not.  Som=
e
> of the newer NXP SoC's register the UART clocks, but they are not necessa=
rily
> associated the to serial_mxc driver, so these clocks need to be manually
> enabled.  Even when the driver model enumerates the UART, the driver mode=
l
> doesn't always reflect the proper clock state, because these clocks are n=
ot
> controlled by the serial driver.
>
> This series does a few things:

Still fails:
https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1068998/raw

       arm:  +   kp_imx6q_tpc
+drivers/clk/imx/clk-imx6q.c: In function 'imx6q_clk_probe':
+drivers/clk/imx/clk-imx6q.c:83:51: error: expected ')' before '{' token
+   83 |         if (of_machine_is_compatible("fsl,imx6qp") {
+      |            ~                                      ^~
+      |                                                   )
+drivers/clk/imx/clk-imx6q.c:83:9: note: '-Wmisleading-indentation' is
disabled from this point onwards, since column-tracking was disabled
due to the size of the code/headers
+      |         ^~
+drivers/clk/imx/clk-imx6q.c:83:9: note: adding '-flarge-source-files'
will allow for more column-tracking support, at the expense of
compilation time and memory
+drivers/clk/imx/clk-imx6q.c:179:1: error: expected declaration or
statement at end of input
+  179 | };
+      | ^
+drivers/clk/imx/clk-imx6q.c: At top level:
+drivers/clk/imx/clk-imx6q.c:41:12: error: 'imx6q_clk_probe' defined
but not used [-Werror=3Dunused-function]
+   41 | static int imx6q_clk_probe(struct udevice *dev)
+      |            ^~~~~~~~~~~~~~~
+drivers/clk/imx/clk-imx6q.c:39:26: error: 'ecspi_sels' defined but
not used [-Werror=3Dunused-const-variable=3D]
+   39 | static const char *const ecspi_sels[] =3D { "pll3_60m", "osc", };
+      |                          ^~~~~~~~~~
+drivers/clk/imx/clk-imx6q.c:38:26: error: 'uart_sels' defined but not
used [-Werror=3Dunused-const-variable=3D]
+   38 | static const char *const uart_sels[] =3D { "pll3_80m", "osc", };
+      |                          ^~~~~~~~~
+drivers/clk/imx/clk-imx6q.c:36:26: error: 'periph_pre_sels' defined
but not used [-Werror=3Dunused-const-variable=3D]
+   36 | static const char *const periph_pre_sels[] =3D { "pll2_bus",
"pll2_pfd2_396m",
+      |                          ^~~~~~~~~~~~~~~
+drivers/clk/imx/clk-imx6q.c:35:26: error: 'periph_sels' defined but
not used [-Werror=3Dunused-const-variable=3D]
+   35 | static const char *const periph_sels[]  =3D { "periph_pre",
"periph_clk2", };
+      |                          ^~~~~~~~~~~
+drivers/clk/imx/clk-imx6q.c:26:23: error: 'imx6q_clk_ops' defined but
not used [-Werror=3Dunused-variable]
+   26 | static struct clk_ops imx6q_clk_ops =3D {
+      |                       ^~~~~~~~~~~~~
+cc1: all warnings being treated as errors
+make[4]: *** [scripts/Makefile.build:257: drivers/clk/imx/clk-imx6q.o] Err=
or 1
+make[3]: *** [scripts/Makefile.build:398: drivers/clk/imx] Error 2
+make[2]: *** [scripts/Makefile.build:398: drivers/clk] Error 2
+make[1]: *** [Makefile:1917: drivers] Error 2
+make: *** [Makefile:177: sub-make] Error 2
