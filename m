Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422F5C282EC
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 02:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94772807D7;
	Wed, 12 Mar 2025 03:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j8Ekrvgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E88A80F9C; Wed, 12 Mar 2025 03:31:56 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17162800C2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 03:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-54957f0c657so421061e87.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741746712; x=1742351512; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85GFxk4/ZYUIO8DxrKcZTCjU30NtED1k+xH4QqgyFMk=;
 b=j8EkrvgxOOjJSWRDnKp+sgxKw37dXZCD08dkIx0ouJ0rKGkrcjNLpsxmmzJb+ublPF
 Vc5M/z6K9v2sxLuk6wMHoFZkDAtrUzZkOJ/FuwiBOTabWCosP6JTGEwTIHu08X/VC+w8
 xj/xpyd7a3Mpu42nDwMXrsbNhV6+rQvrH0YXqXavOuE/8e32iW8aUEOcRtHTUlaq3Zfa
 qPkk4t0r//9WRNGizJC8LHF2Sp8/wujiuVR2nWQMkS0wQ9ML1pf9CmIi8EvPY8HzKBtt
 jjJJlokXXVb0p/F+8j5sTrrBfz6ukJdNSS5heFAIcKRpi7ktImAhuwL4FUfaETxcQo7R
 qdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741746712; x=1742351512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85GFxk4/ZYUIO8DxrKcZTCjU30NtED1k+xH4QqgyFMk=;
 b=jEu4juvQggZEBLIcVskxuDLRkh5Y393r9S1PRLh9U/gB0ZlcnNGnC8evoBpZj8D5jK
 Kolf50gMqqHsLdlS9fg7rOfjVu5PMeB+GoMJrVRrUg9cPLwVkKh3egoGjXcjynTV6Wr2
 bnai2ogXblod+oNY2gd42xZW6ijZLsEf7D1QU+ejayIc+WGUuEF4ITZkGX0DEN+q3TMt
 LtziMqn1FJ6tIZ8KOfVgSJsiL8gDmJ2hhgllhs6ftHa8DX/lySu2a3iOJ6OsW8z1xwgY
 /EkG9lqtUk0iVKOnhJlBv80mHGN4V5/2MPJ/af+T+IsnicbCIvReGd+N/v9etiOm0bfQ
 xVcw==
X-Gm-Message-State: AOJu0YyoA5DL0TblpsBsaufBj4SiDP3ndyggkR6WGGOS03/I+I+OdE5v
 Fl1pT3UNn+pUMwdQAdeTRtqKERO7jtvDEwmrC7W13T8kmZr6rdY23gi5/K/un9GrAqsFP20G3rP
 iT3YcPcsxjqCHTr4WaObrKe4Qm0s=
X-Gm-Gg: ASbGncuSmkpH1XODZJB7YuZ36BL4JnRsxFhtQthyFVOkNR7eo0Vmliv246sAUyxpzat
 +qjt+iiiENS1Q53USQoVw/gJXgfAAmf3TtZsUV2qHpqdbZbvnICvEeo7rlZjRi8PU3mYWATDdp8
 2BarHc7zWZIn9QNDuB/45qHJTjDhX6QSisXiC3St8emThTstvfQMYo738kWw==
X-Google-Smtp-Source: AGHT+IFtv4gVFpWWVs3lzO1Bdtj7U8VrTeHtFBBeU9GiwHLJhf0tgQcLLPs2yhRpxzVgtI21fzKfDWVz8ExEuCcYhGc=
X-Received: by 2002:a05:6512:b9d:b0:549:981b:169d with SMTP id
 2adb3069b0e04-549abd0fa23mr2251185e87.3.1741746711947; Tue, 11 Mar 2025
 19:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250312003041.110023-1-aford173@gmail.com>
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Mar 2025 23:31:40 -0300
X-Gm-Features: AQ5f1Jrv_zi14v8fj8ro7e1bs7n4ZOejM2tqHy7xSnObSjDHqFgwKy30ugvkAyg
Message-ID: <CAOMZO5DRn08Q58PeHqi=1V8ZRv6B1+L_CB0NA=arQ2u6XUyi8Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] clk: imx: Use Clock frameworkt to register UART
 clocks
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
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

On Tue, Mar 11, 2025 at 9:31=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> ---
> V2: Fix name of "ECSPI" and elimiate helper function, and fix build error=
.

Still get errors in CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057306

Please make sure v3 passes CI.

+In file included from board/liebherr/display5/display5.c:30:
3873+include/dm/platform_data/serial_mxc.h:12:25: error: field 'clks'
has incomplete type
3874+ 12 | struct clk_bulk clks;
3875+ | ^~~~
3876+make[2]: *** [scripts/Makefile.build:257:
board/liebherr/display5/display5.o] Error 1
3877+make[1]: *** [Makefile:1917: board/liebherr/display5] Error 2
3878+make: *** [Makefile:177: sub-make] Error 2
3879 arm: + kp_imx6q_tpc
3880+drivers/clk/imx/clk-imx6q.c: In function 'imx6q_clk_probe':
3881+drivers/clk/imx/clk-imx6q.c:83:51: error: expected ')' before '{' toke=
n
3882+ 83 | if (of_machine_is_compatible("fsl,imx6qp") {
3883+ | ~ ^~
3884+ | )
3885+drivers/clk/imx/clk-imx6q.c:83:9: note:
'-Wmisleading-indentation' is disabled from this point onwards, since
column-tracking was disabled due to the size of the code/headers
3886+ | ^~
3887+drivers/clk/imx/clk-imx6q.c:83:9: note: adding
'-flarge-source-files' will allow for more column-tracking support, at
the expense of compilation time and memory
3888+drivers/clk/imx/clk-imx6q.c:179:1: error: expected declaration or
statement at end of input
3889+ 179 | };
3890+ | ^
3891+drivers/clk/imx/clk-imx6q.c: At top level:
3892+drivers/clk/imx/clk-imx6q.c:41:12: error: 'imx6q_clk_probe'
defined but not used [-Werror=3Dunused-function]
3893+ 41 | static int imx6q_clk_probe(struct udevice *dev)
3894+ | ^~~~~~~~~~~~~~~
3895+drivers/clk/imx/clk-imx6q.c:39:26: error: 'ecspi_sels' defined
but not used [-Werror=3Dunused-const-variable=3D]
3896+ 39 | static const char *const ecspi_sels[] =3D { "pll3_60m", "osc", }=
;
3897+ | ^~~~~~~~~~
3898+drivers/clk/imx/clk-imx6q.c:38:26: error: 'uart_sels' defined but
not used [-Werror=3Dunused-const-variable=3D]
3899+ 38 | static const char *const uart_sels[] =3D { "pll3_80m", "osc", };
3900+ | ^~~~~~~~~
3901+drivers/clk/imx/clk-imx6q.c:36:26: error: 'periph_pre_sels'
defined but not used [-Werror=3Dunused-const-variable=3D]
3902+ 36 | static const char *const periph_pre_sels[] =3D { "pll2_bus",
"pll2_pfd2_396m",
3903+ | ^~~~~~~~~~~~~~~
3904+drivers/clk/imx/clk-imx6q.c:35:26: error: 'periph_sels' defined
but not used [-Werror=3Dunused-const-variable=3D]
3905+ 35 | static const char *const periph_sels[] =3D { "periph_pre",
"periph_clk2", };
3906+ | ^~~~~~~~~~~
3907+drivers/clk/imx/clk-imx6q.c:26:23: error: 'imx6q_clk_ops' defined
but not used [-Werror=3Dunused-variable]
3908+ 26 | static struct clk_ops imx6q_clk_ops =3D {
3909+ | ^~~~~~~~~~~~~
3910+cc1: all warnings being treated as errors
3911+make[4]: *** [scripts/Makefile.build:257:
drivers/clk/imx/clk-imx6q.o] Error 1
3912+make[3]: *** [scripts/Makefile.build:398: drivers/clk/imx] Error 2
3913+make[2]: *** [scripts/Makefile.build:398: drivers/clk] Error 2
3914+make[1]: *** [Makefile:1917: drivers] Error 2
3915+make: *** [Makefile:177: sub-make] Error 2
