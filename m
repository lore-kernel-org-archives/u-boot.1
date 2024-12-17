Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFF2E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 10:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 259DB8020C;
	Tue, 17 Dec 2024 11:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YXLlEWXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A21E80214; Tue, 17 Dec 2024 11:56:00 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE4D0801F9
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54025432becso5151808e87.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734432957; x=1735037757; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lho5u0Ey1c/pJPTOkITKQxRv7LrX7T1W0yEYTF64psE=;
 b=YXLlEWXmV5pPvSL4rx4so/jPMZn3DO6ODuUOTLkAmIi7sJ4S20ExS1w6UEUFWjZN2+
 9p9aouwCDyXDf5UxcvEZgbqKXezlXdQxuemKcRNvLTU51PXUJZ9IAAt1UQs7T4hCMXZN
 +jZAsbXC7gw5OI1TKabqP0krT8uq9mwZBqsDR+VBMEg8rJW2vr+32/IrVwAV6ZE19crK
 mNLNS2bqs47o0GCkKPmBlkYSVwnGpe0lXPyNxKkapcmGhMbvamZ7jyvHK0u65lrqFYrB
 B7IGoixiMAwYbXWsiBt4KEKJmq7Pnd9eEWNHFwwi7hhatdSkSEAqEfP9D+bYPdYMHfEP
 oFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734432957; x=1735037757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lho5u0Ey1c/pJPTOkITKQxRv7LrX7T1W0yEYTF64psE=;
 b=Xdx5tY7huxVNOEHV0HUZyc3Nx88X1+26NHy1w6racfI0l0x2ZcQ1nEr4hADucGWxoe
 7IdXdDERUtpA/+GB+phOadH6pEmvHhyxviVoqlesuy7bXYmKngYg2zt6Dmhb80Mh8/fF
 zMvJXthZiv/ET45IqNFjDmVzfU5Qc0H/7oBl52Vvuny5EOOVVU3SB2PRFZA53j2mmHQk
 9l6ZW7s1SNvikDeieceFxydwhQ4NB74l7OKWCyI32qy7XLTBK8AXNET5F2P20VTDrr9u
 xejKZwZJo2v8ir5UDDwn5jKuUnuAvpP1Aj5Q1S7e/W8Yob+YHd+NF/yS2sBSEveUUgmT
 zDMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxPAZ1yES6Tjb1Hud3do9gy53a4vI6U6OefsSX0CF1MZIuJjBvmKi6KuOPqhrsMQTgXA3jHGw=@lists.denx.de
X-Gm-Message-State: AOJu0YwxL5bZZajkRJ94CiTT1oFEDwRGDx1EQUEaKf0USfs4mK7maYuG
 X6PxoEo4f6kwDwClwKv5WCTPVVEyZbmdMpprVrCngWsu2USh89HbVYhhYeRPc2B/XVxRzAV87a+
 J1c0yTWNWFJsyXE2LdV4Brvmwgwg=
X-Gm-Gg: ASbGncs45H9F5+UTUGwpt0mAVj7wp29swGg10Fqt7U4KHBUVfyhgTXRkYpI/c6oz6/h
 rIbOUuFfB0Ye9b6uGceglm6CSUBq34ijs0cFnvHDj+9GST6tqJvZs26vBlNVv5mWXQkWi
X-Google-Smtp-Source: AGHT+IGwXRdIyuukbslB1zYchP1H2vWd7YlvPcnWHJknlTwaaCK6sfpW7/k1Qyw7kgET3Y/7WOlrPogpiR+UIYHzOvs=
X-Received: by 2002:a05:6512:3b0b:b0:540:1b07:e031 with SMTP id
 2adb3069b0e04-5409054e874mr6187713e87.24.1734432956645; Tue, 17 Dec 2024
 02:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20241211122036.103383-1-eichest@gmail.com>
In-Reply-To: <20241211122036.103383-1-eichest@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Dec 2024 07:55:45 -0300
Message-ID: <CAOMZO5A5Fuh29m4vtrhGRvsmMo2MW5Rf54ZhFgg74h-bBV_HdA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] add support for Apalis iMX8 1300MHz version
To: Stefan Eichenberger <eichest@gmail.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, trini@konsulko.com, 
 francesco.dolcini@toradex.com, stefan.eichenberger@toradex.com, 
 peng.fan@nxp.com, emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com, 
 vitor.soares@toradex.com, igor.opaniuk@foundries.io, u-boot@lists.denx.de
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

On Wed, Dec 11, 2024 at 9:20=E2=80=AFAM Stefan Eichenberger <eichest@gmail.=
com> wrote:
>
> This patch series adds support for the Apalis iMX8, which utilizes the
> industrial 1300MHz version of the iMX8 SoC. Additionally, it includes
> minor cleanups that do not affect functionality.
>
> First, the series adds support for the new Product IDs (PIDs) found in
> the configuration block of the Apalis iMX8. The primary difference is
> that this version uses the industrial SoC, which features lower CPU and
> GPU frequencies compared to the automotive variant we used before.
>
> Second, the series extends support to this new SoC. During testing, we
> observed that the cpufreq driver did not account for the reduced CPU
> frequencies, despite enforcement by the System Controller Firmware
> (SCFW). This mismatch led to discrepancies between the frequencies
> reported by the cpufreq driver and those actually set. We have also
> updated the GPU to operate at the correct frequencies, as the SCFW does
> not enforce these limits. Previously, this caused the GPU to overclock
> to an unsupported frequency, as documented in the datasheet "i.MX
> 8QuadMax Industrial Applications Processors" (IMX8QMIEC).
>
> This patch series depends on the following patch and should be merged
> only after it has been applied:
> https://lore.kernel.org/u-boot/20241125174911.70723-1-ivitro@gmail.com/
>
> Stefan Eichenberger (5):
>   toradex: tdx-cfg-block: set apalis imx8dxp to always disabled
>   toradex: tdx-cfg-block: increase indentation for longer defines
>   toradex: tdx-cfg-block: add new apalis imx8 pids
>   toradex: apalis-imx8: simplify module version handling
>   imx: mach: imx8: fdt: set correct frequencies for the industrial SoC

Applied all, thanks.
