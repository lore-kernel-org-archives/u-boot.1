Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360C5CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D65846A5;
	Fri, 15 May 2026 15:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I20jja6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ABB7846B4; Fri, 15 May 2026 15:55:10 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D3EB80086
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a995ab70d1so2783383e87.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778853308; cv=none;
 d=google.com; s=arc-20240605;
 b=QjE4Dnl0YTB+dtxhWJ8uSqsf5NVcxq4EqdKtvv5hIg/YA+iUNx9TPZWsTXlux2yKxr
 jRfrASmjoxiXenAXucqa6Uh9IrQEo2BPK9oUH0yHfgXRCaCYQCdyKq9W/T4Udk0JFqqD
 m05bAk5RSvzCblwJbSDCofIDyAtlg0WeDIdtrHb5jP9+ABZEiEpl31rZPucpowUrnZy8
 PWcTvSBp5nGeKjNAAizUfDl83JLaKAfO6WR2UN1rzeuBRYZaJAkfK7qjDoCXGs8f/Tod
 wuolUpO97VUc07g/sQaYI3Wiav9uC7N2thncSrrnoMRFle47d3IhteDQ9QxukgJKntd4
 cf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S8RBZWzGq8AYr+RlPGaoYF89zNYBUkQKb3YhiJBI8/M=;
 fh=b8XmvhVbpxvKJhJIbUxSVGL0h2xFXOSGFnT3KJuTvoQ=;
 b=D02Y8jDuwzreExFGe2GdBDWTHBJh46tTYcdaZ+MCM5fJ/KgtjYI6HRXSKbRVIe8UzD
 rLCpn0WCdHrZSATMp2/Aojd92+ycXr7ypq3/ood4sdj9CfIguwUl1zX4GHF5VGJExYBD
 D+EWCAIHC6moSruzLEt27PlME/DLzXMJvCRDnK6ehAf2v4zeV4aEM8qQyzP3tTmksHXI
 9+2BDTlFm5IWrd/0R6VQvkZe+bd+rH6Zf323NyEPgWHTe3gHQvSNWb4T6/ZXqzACmmUv
 5cOBPRJqmfjKx/zTWA1H2b83A+o0Tbj/UaCJxjct6uL0FRKL/C22JcHn9F4C7b3gl5wP
 90yg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778853308; x=1779458108; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8RBZWzGq8AYr+RlPGaoYF89zNYBUkQKb3YhiJBI8/M=;
 b=I20jja6UkI7c/SuRHH5NQYN9rFcIix85g7V/6JsDWp9gtORwf60vpYWTjh/XeKVMRs
 XDyEVIOP998kq7zS5OCFMDN8Vm8d07n6Weeqps2SoWY2YjnTz8Vo3elNZkGcidsJ7w/N
 EAe7pNf6C4ke2oOBhgbZ7RfI0RBKjGU19AXOyPwtnr8RwUBzMMSgnwhK/7TyZQY4gxp8
 eKBQ1LjJpqMkopXbp/q9jj0ofLfIn6aDYO3v+wsbKjhqrMmt2AlcRSFa7JNVwQIGtCtn
 yH0PrcJXm8CEe/CUo/oY8yO8Hq9zWOtCyq8e19doDR4GmCg3SH2x8CM2EV4Coetq1fpK
 CIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853308; x=1779458108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S8RBZWzGq8AYr+RlPGaoYF89zNYBUkQKb3YhiJBI8/M=;
 b=BT4CtOgiElfxSgoguURO9n0ocFfMo5ZJc18vRpS2OM/pXX6RwTOLFbq0Ca7+hQLHSe
 082tScmiWD2dUjJtxF2b5Z0hsCiS3IMZy4PqGpOtDEZOZ29LeXHJFzWNIQTl1HBNHaAv
 oAlBnhlGqn4IENS6ZlRGyzdJS6fmPpVWtZ8EjfqE3DEUMBOzwuUd1ISam2y5qgxeiGCf
 XPWue+pm5s/vss025VF543hHgwW9Nn7YtGJqJ6nCqm8f8MTr6egPBTCqUCpDxaSOG44e
 qdDiPDXkTHYreU40CXxgPNyhZk20B58TjzX+ELXVlkmSN652VMJcCacEG584rAp4H2qF
 cxlw==
X-Gm-Message-State: AOJu0Yx2n+cp6VaFLBkqWfyLI4x2frmPD7aIdZyQl0c3vIByHRRBlTur
 G1D3+c45vDEY91CJTnCWecXfRNX7IyhOAoFFEfsvN0yU7CBr2UB9fehcuB44EnfyTQcTPPyB3p9
 ghHIzJtmY7aETVlZEplEt3/g8ZTq/6SIa4+IC
X-Gm-Gg: Acq92OENY5MUf0q/3tnPNP0sYHXbc/x53EOSb9wYXxWOJVHSlR4IknrzOQUKFxfI0mi
 kzUJWbAgslBHduzTk7wy9/oMT0WvVDS+uJcCVecvChmK0bdUXRCm9RksPKhNjx75mAL87GwIey6
 +YGk8LMqqNSwjZ+Orku8O0WNB2a0ZUxj96tY6nBUV85YK3tDzeyAHL5G+TcX/vTW5C44jBhVMp0
 q7MXnD17TVGtrDCALXixmvjsRkQKUWArUnIEekQf+91FsiIwqp0AqTp5/Ntm/jkOJTQQKZXsACF
 Y/YhsDObddLhjv3INHMgYKKvHUMfkikxLgkKK1fNoq3RjM/zDE5n1FzLhsbVBm2E7tntIGNEStZ
 w4a/ZQ/M=
X-Received: by 2002:a05:6512:3a81:b0:5aa:b6a:6028 with SMTP id
 2adb3069b0e04-5aa0e753337mr1110847e87.45.1778853307569; Fri, 15 May 2026
 06:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260501162706.543779-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20260501162706.543779-1-alexander.sverdlin@siemens.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 May 2026 10:54:56 -0300
X-Gm-Features: AVHnY4LwAc169TBvEmHmkzUgq9WKrpsTUajzFlxGB0TLM7AIJ84AU5CiPlBcW3Q
Message-ID: <CAOMZO5B9W=WOXHRKdj-gpirD3z1WeODiFkYFB9ULZR-a=QE8sg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: don't build i.MX6/RTxxxx code for all users of
 CCF
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>
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

On Fri, May 1, 2026 at 1:52=E2=80=AFPM A. Sverdlin
<alexander.sverdlin@siemens.com> wrote:
>
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> When commit 1d7993d1d0ef
> ("clk: Port Linux common clock framework [CCF] for imx6q to U-boot (tag: =
v5.1.12)")
> introduced the parts of Linux Common Clock Framework, it was done for i.M=
X6
> only and even had "depends on SPL_CLK_IMX6Q" conditions. Since commit
> ccab06689aa2 ("clk: imx: expose CCF entry for all") the framework can be
> re-used with SoCs of other vendors (say, TI), but NXP SoC-specific code i=
s
> still being build. Is is especially problematic for size-constrained SPL
> images on TI AM62x.
>
> Make the build of the i.MX6/RTxxxx code not only dependent on
> CONFIG_$(PHASE_)CLK_CCF, but also on the corresponding CONFIG_ARCH_*
> options taking into account that only two platforms seem to use the code =
in
> question.
>
> This saves 2264 bytes on ARM platforms [using CCF].
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

This breaks the build.

make imx8mm-icore-mx8mm-ctouch2_defconfig
make
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/l=
d:
/tmp/cc1Ra7A0.ltrans4.ltrans.o: in function `imx8mm_clk_probe':
/home/fabio/custodian/u-boot-imx/drivers/clk/imx/clk.h:129:(.text.imx8mm_cl=
k_probe+0xbd0):
undefined reference to `clk_register_gate2'
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/l=
d:
/home/fabio/custodian/u-boot-imx/drivers/clk/imx/clk.h:129:(.text.imx8mm_cl=
k_probe+0xc10):
undefined reference to `clk_register_gate2'
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/l=
d:
/home/fabio/custodian/u-boot-imx/drivers/clk/imx/clk.h:129:(.text.imx8mm_cl=
k_probe+0xc50):
undefined reference to `clk_register_gate2'
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/l=
d:
/home/fabio/custodian/u-boot-imx/drivers/clk/imx/clk.h:129:(.text.imx8mm_cl=
k_probe+0xc90):
undefined reference to `clk_register_gate2'
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/l=
d:
/home/fabio/custodian/u-boot-imx/drivers/clk/imx/clk.h:129:(.text.imx8mm_cl=
k_probe+0xdb8):
undefined reference to `clk_register_gate2'
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/l=
d:
/tmp/cc1Ra7A0.ltrans4.ltrans.o:/home/fabio/custodian/u-boot-imx/drivers/clk=
/imx/clk.h:129:
more undefined references to `clk_register_gate2' follow
collect2: fatal error: ld terminated with signal 11 [Segmentation
fault], core dumped
compilation terminated.
make: *** [Makefile:2109: u-boot] Error 1
make: *** Deleting file 'u-boot'
