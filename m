Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7AAC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 15:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C1C809A4;
	Sat, 15 Mar 2025 16:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h06Da5jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E36680C93; Sat, 15 Mar 2025 16:37:20 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5CE780756
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 16:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso969959a91.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742053036; x=1742657836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pufmbCOUK6VHsBoOusnuAXpY/p4gnnc+m+L7cDbS5WY=;
 b=h06Da5jvWo0yL0dQ8FlHvH03N+M+fi0chiR8JRKfzgpfZ10aS/xiWVa16sBfMtISa/
 LJFeioe5UeBYZjvBSdJHuKpuEc/Reb0x6W3yOiCUsetXDxLC/RDjmKy6KwA4LAuLLMVn
 uUTM1wLK48cbCXhrJ/L6n41wNvBEBfpmu5lk6NaCgiRqt7Efv/ebpZ3yBRRgPET/FXPS
 ILrQ1UoWKFdIfpHGSVo24AwH+dPsohf2CWZ/T1R94H83r50lNBlWxyGaKo1Y+x3lL64M
 BK9Mq/ySjfQyfZxNsvzPKZqE+NZ8UIWjrTMxOdBeP4kpEmPUAG/KHB1Ln6WiPwkv0uLM
 5RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742053036; x=1742657836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pufmbCOUK6VHsBoOusnuAXpY/p4gnnc+m+L7cDbS5WY=;
 b=WI6a7YrMCVhcWgiESiZuT1zA3tRVtfJoOQ0nAX3TlFlRRKuamusQIX/eZu5gpYd4Sc
 jVBskWhdME/FNSJYYK4+3RUVQz770In6OuZQ++L98gAcXRGY2CB+KrRQXoIqnZUxzmz5
 +zaW9iWitX2Si9EuGi4TxmLQi9OdUMfW+4m7suupYJqt//W8M/0Sl15OnmL608l/Rsx5
 pnz84s+qncFCxBX4jHXQIrHGUGqKG4GywvUJen2UoDuHbtinHwHch04y5F/2/POzpfob
 eFn+1dzSTIPRi9jtudzBQKNFW3ofcqX1+0Rd/EpaRWXiVJZmZClh7rwEmMjKGpGshl3c
 jWsw==
X-Gm-Message-State: AOJu0YypiAU39hPK3V0mZbg+Z7UztutKZ/FQ1Wx/C40lpluYs301vg/P
 Zw2fXidY8JbSl5Qhzq6lQ7hCsFEcVWF83qtscEywHWzSgm5B+Uud8XwMKdQMdRhAsaWKCG3hbhH
 C/9ez5eD6LtqkrTm0kev0+TtPKmQ=
X-Gm-Gg: ASbGncvVakZBQL2+PcwLHYnKmynEEOdBGYCcCF5TnV/r4dyWF/8tCTwIUAadSus9o61
 8X/Qps51kS2slM82Kijx9dUBxz73h598d5waElOd1rrSCayWay5kAnD/szoNNE4w1WHKk6oe6kI
 oBaDsa5UZEgrH+ahoHltDJQQtlzA==
X-Google-Smtp-Source: AGHT+IEA2SUdkXUzF8tKKqg7yBoytBCSsWfNxzD3MteX6EbqXpmQoWxi4IwuA5MOQYMPA+ucDii6ZD26/x0pYnEnZ64=
X-Received: by 2002:a17:90b:1f87:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-30152189910mr8396058a91.14.1742053036242; Sat, 15 Mar 2025
 08:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250312003041.110023-1-aford173@gmail.com>
 <CAOMZO5DRn08Q58PeHqi=1V8ZRv6B1+L_CB0NA=arQ2u6XUyi8Q@mail.gmail.com>
In-Reply-To: <CAOMZO5DRn08Q58PeHqi=1V8ZRv6B1+L_CB0NA=arQ2u6XUyi8Q@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 15 Mar 2025 10:37:04 -0500
X-Gm-Features: AQ5f1JrKTH2utc6pl_CmgPsEP2FhiSayIf0nbcHHMfb13a4okBuf9vN6GBkBAQE
Message-ID: <CAHCN7x+grtVs1JDvfth+7VdT1Xm=_GSBsr0PD1XQSPxpRBZcfw@mail.gmail.com>
Subject: Re: [PATCH 00/10] clk: imx: Use Clock frameworkt to register UART
 clocks
To: Fabio Estevam <festevam@gmail.com>
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

On Tue, Mar 11, 2025 at 9:31=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Tue, Mar 11, 2025 at 9:31=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
>
> > ---
> > V2: Fix name of "ECSPI" and elimiate helper function, and fix build err=
or.
>
> Still get errors in CI:
>
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057306
>
> Please make sure v3 passes CI.

I ran the config that failed on my V3, and it passes that build test,
but I don't want to waste your time if it fails on others I don't know
about.  Can you point me to documentation on how to test this across
multiple boards/platforms before I resubmit it?

adam
>
> +In file included from board/liebherr/display5/display5.c:30:
> 3873+include/dm/platform_data/serial_mxc.h:12:25: error: field 'clks'
> has incomplete type
> 3874+ 12 | struct clk_bulk clks;
> 3875+ | ^~~~
> 3876+make[2]: *** [scripts/Makefile.build:257:
> board/liebherr/display5/display5.o] Error 1
> 3877+make[1]: *** [Makefile:1917: board/liebherr/display5] Error 2
> 3878+make: *** [Makefile:177: sub-make] Error 2
> 3879 arm: + kp_imx6q_tpc
> 3880+drivers/clk/imx/clk-imx6q.c: In function 'imx6q_clk_probe':
> 3881+drivers/clk/imx/clk-imx6q.c:83:51: error: expected ')' before '{' to=
ken
> 3882+ 83 | if (of_machine_is_compatible("fsl,imx6qp") {
> 3883+ | ~ ^~
> 3884+ | )
> 3885+drivers/clk/imx/clk-imx6q.c:83:9: note:
> '-Wmisleading-indentation' is disabled from this point onwards, since
> column-tracking was disabled due to the size of the code/headers
> 3886+ | ^~
> 3887+drivers/clk/imx/clk-imx6q.c:83:9: note: adding
> '-flarge-source-files' will allow for more column-tracking support, at
> the expense of compilation time and memory
> 3888+drivers/clk/imx/clk-imx6q.c:179:1: error: expected declaration or
> statement at end of input
> 3889+ 179 | };
> 3890+ | ^
> 3891+drivers/clk/imx/clk-imx6q.c: At top level:
> 3892+drivers/clk/imx/clk-imx6q.c:41:12: error: 'imx6q_clk_probe'
> defined but not used [-Werror=3Dunused-function]
> 3893+ 41 | static int imx6q_clk_probe(struct udevice *dev)
> 3894+ | ^~~~~~~~~~~~~~~
> 3895+drivers/clk/imx/clk-imx6q.c:39:26: error: 'ecspi_sels' defined
> but not used [-Werror=3Dunused-const-variable=3D]
> 3896+ 39 | static const char *const ecspi_sels[] =3D { "pll3_60m", "osc",=
 };
> 3897+ | ^~~~~~~~~~
> 3898+drivers/clk/imx/clk-imx6q.c:38:26: error: 'uart_sels' defined but
> not used [-Werror=3Dunused-const-variable=3D]
> 3899+ 38 | static const char *const uart_sels[] =3D { "pll3_80m", "osc", =
};
> 3900+ | ^~~~~~~~~
> 3901+drivers/clk/imx/clk-imx6q.c:36:26: error: 'periph_pre_sels'
> defined but not used [-Werror=3Dunused-const-variable=3D]
> 3902+ 36 | static const char *const periph_pre_sels[] =3D { "pll2_bus",
> "pll2_pfd2_396m",
> 3903+ | ^~~~~~~~~~~~~~~
> 3904+drivers/clk/imx/clk-imx6q.c:35:26: error: 'periph_sels' defined
> but not used [-Werror=3Dunused-const-variable=3D]
> 3905+ 35 | static const char *const periph_sels[] =3D { "periph_pre",
> "periph_clk2", };
> 3906+ | ^~~~~~~~~~~
> 3907+drivers/clk/imx/clk-imx6q.c:26:23: error: 'imx6q_clk_ops' defined
> but not used [-Werror=3Dunused-variable]
> 3908+ 26 | static struct clk_ops imx6q_clk_ops =3D {
> 3909+ | ^~~~~~~~~~~~~
> 3910+cc1: all warnings being treated as errors
> 3911+make[4]: *** [scripts/Makefile.build:257:
> drivers/clk/imx/clk-imx6q.o] Error 1
> 3912+make[3]: *** [scripts/Makefile.build:398: drivers/clk/imx] Error 2
> 3913+make[2]: *** [scripts/Makefile.build:398: drivers/clk] Error 2
> 3914+make[1]: *** [Makefile:1917: drivers] Error 2
> 3915+make: *** [Makefile:177: sub-make] Error 2
