Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF1FC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 12:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FAE88A39;
	Thu, 15 Aug 2024 14:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S9FdkS/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 378138863B; Thu, 15 Aug 2024 14:25:43 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480738863B
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 14:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef2c2dfaf9so1878151fa.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723724740; x=1724329540; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWHdBKiVeA210XgX+IYkJ9qP/sOyZdGJ3JwbYP/f8ZE=;
 b=S9FdkS/T5HPJ5+k9y90/NHc3bl1h/I1SuGruVWpDSMLF2+QJ8L1inGwSJdw8NEsBH1
 yQkkJgSiChBXlBgzvG2/QF/cZFm+rrpEcESTAhylHGSqZ+Ag0mki2u/yc6mODL93bHp+
 PotC1+siLwQVDLHA1QicFrQgPKj0JWRHqsbfqURrxvOISKGWApj9a1vbt0nqukgHoDfA
 XqQWiCbEnQm8VnvWAqD8SyOJg4jD/hj7cSWk0HkDnByDBPfQ/QB3OMSFuO3Dmgci44RO
 ArlrSa9gFNSoC4KJsYs15TE10aLVLJ5I8sYfHgAlZW7SXfpP4u5xhAcXcJSrv/Q9gLin
 vr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723724740; x=1724329540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWHdBKiVeA210XgX+IYkJ9qP/sOyZdGJ3JwbYP/f8ZE=;
 b=dAWBh3rH0HNzbUn9FbHVFnglBazYtMXhPwd/qFb5vDgyZTl+W6nCzyRggP7TaGJMNz
 XTGVfUavJwZ74Qk7M4ksOpen0BJIwO4ow3Xpmai8j15XCtqzCdo5hEnxRC4FmdBMLVpp
 ARmmjJOWC1fKLe+txmpn91rV7cZEJ94OwFMK1y51IsfelFRXt+fmssXvhNxg8rlDWJKL
 tmsbnTMtL/pEWAemsvwuamYYQZiuPH7+3VZkTrLLt5LHBA4/8PgIN2gT4zjRhx3cK3Qr
 fR/6S9Ld8zUlSU6OSE2O0O4W2PE9rBTsTjNdKnxjzIveto0VH0b5c4fssFQKbvwGCxj8
 X4Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXopcV1FPNEh7PcQmSEppOyWBEq4c0yF/6pz4xQKsfScG+ZlPj/k1JYRFFKYHD90lS0LT7m7y4=@lists.denx.de
X-Gm-Message-State: AOJu0YwlLEzUQEjB6ucIoBiz5SSaTvNL1jJgsHGWJldMk0zI1Txum1Oo
 GpDJNwY3TsuhRUv7E/0K+D6L/n/oElD72tNtxSgoTZ09vqPv6RLUaRispoBDMPwHPNui1OgruEh
 2CUJyEyp4Fm2jnE6dbjhko2LcNZE=
X-Google-Smtp-Source: AGHT+IGj9GE1HPCvc9VOIRd4RIExmbxS6a4KRmYbYMIq3SDpijMk62vOqfwI+LGI6AwUSPk8ufAFTjU2D07lp0WZUI8=
X-Received: by 2002:a05:6512:3b0d:b0:530:b78c:445c with SMTP id
 2adb3069b0e04-5330a67530cmr810429e87.8.1723724740146; Thu, 15 Aug 2024
 05:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240815084012.477436-1-lukma@denx.de>
In-Reply-To: <20240815084012.477436-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 15 Aug 2024 09:25:29 -0300
Message-ID: <CAOMZO5BM0w1aphmZ4D5cEch_eWVT3ebeZa3gfB9TbfGcT_gOdA@mail.gmail.com>
Subject: Re: [PATCH] config: imx: Add PHYTEC's phycore-imx8mm-fspi_defconfig
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com, 
 Cem Tenruh <c.tenruh@phytec.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

Hi Lukasz,

On Thu, Aug 15, 2024 at 5:40=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> This configuration file provides support for booting phycore module
> (on e.g. polis-rdk base development board) from QSPI memory.
>
> Moreover, the SDP SPL gadget is supported, so single flash.bin
> binary can be used with uuu (with uuu -v -b qspi ~/u-boot/flash.bin)
> to flash QSPI in the factory or during debricking.

This looks good.

I suggest adding an entry in doc/board/phytec/phycore-imx8mm.rst to explain=
 how
to build and flash U-Boot for booting via QSPI.

This can be a separate patch though.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
