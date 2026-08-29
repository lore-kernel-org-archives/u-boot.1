Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C1EC61DBE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 13:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1289080E91;
	Sat, 29 Aug 2026 13:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id taImVWkIy_8Y; Sat, 29 Aug 2026 13:59:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788011956;
	bh=ilkut5AZac9x/pg1pVCma/B6y+S761BTLIdIb2xjHHI=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l9PGJskahLsjC/2dRA/0kyJ9gJMw+FI9HKIrMd+kT4FF+v4as8cmMU439z1PARZVi
	 6T8YSCbaU4Fm/+wks8d6HB1I+6ha7v5TnG4JfStIXheIOWUN1VL0oJRNP4/C+3fE6R
	 OIuRHvPNCEcvgNwJiWQLKFJEwIvyrZlzb2gYwGHZh4PR6/QZ/ymghZcK+IoLT/6bkG
	 fL5X7lZKUYWoATDJO8hhEuj4/aaIFNvfTy6yKsTOY0Pu/QMDo1Z3Pb0bUC6lwGJvkQ
	 hQnUy6E8Ijq0BXhiMjD38/oLCTUie8HmNLsTSEpdqxM0ElmF9Ho1BrzYM0cgAnOFt4
	 LMNCexVZLgxLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07BF680E2F;
	Sat, 29 Aug 2026 13:59:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E874B127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 13:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE68E40098
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 13:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jO9MOkdKYVjO for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 13:59:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=oJ4A87fB
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F2B640052
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 13:59:11 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so13430355e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788011949; x=1788616749;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ilkut5AZac9x/pg1pVCma/B6y+S761BTLIdIb2xjHHI=;
 b=oJ4A87fBuOqGfrEF8GvNfljvhgR8FhXfKwsUZGbicc1ytpX6m+YvtZpepiwU5jEOQO
 wVELtWfIxRI48fyIh/4rBmEHyskyvZycTZnSzzZrwUv4h+JEBqP4hBBNHITiM7/Vzl2M
 PvTEI63blbJiEVpCIFpMV3G0jyVwqE077pxcFWWF49YowI6jDHED/QLrV1PAGaDOlHdX
 CqdlPw8RSTsis/XjPzExNs751fH3Fheyz2rF3pEYl74qm18ba9meTIw/bgteiakBH07s
 CwisnIVMWA/takRImnez44Fgb2jnWMrIIXDYyBCB7GQ1/IacigBYlgCbGLgG8qcOoGGY
 YfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788011949; x=1788616749;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ilkut5AZac9x/pg1pVCma/B6y+S761BTLIdIb2xjHHI=;
 b=ElyhMblZW9mV6pChd48u+tnG69ysrjQSM958r+lTiZBPzrkp8AJ2Hg38KjTKaKRbzY
 Hj46UoVY4crgN8u6ez5rXyYrLdf6TSBvBaNFGYNvKmwMwC4KQGaRtpJ/9tlw5QWPrmhz
 8FhqYlrPsYawOE6QFgqBuiHvWcmsWLxX4DEWnXRJZrDbX4vVuMAg0nNudMwmFwLNrAwb
 NeJ2A/qykdcYR20nKDuR6jPumaJ6Jft8Pp+BtA3+m52Yxng+p33CXBaKjzSd+BuJfdy4
 Tb+9Wc3kuVwVbNILI6pk+FmCYPXeVkTkASEr9hWqyxwKfnz1+aSXZ8+E218LhPaFM9fG
 BmIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+AbVMW2jcIjEnlFCNVBqwVquRA6g5W8Hfpe2mDSqudlVp9A+my5pgq8hN7KwaJ0DGceEESpE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kAcxnbWzuoxw04XAzZ82A31HJR49CSpiVSSH439Jir2Gpr4JyH
 lVjdhWPHcXxFfB2b4qG7+uMrXiHSVWtDQWtM663S6snoc0jkTXoeSrPPP9IWtw/NZSA=
X-Gm-Gg: AR+sD10DebBZhVaYVnRX1wIeSsw9GyijYBPHahyAxS7IyQca3rT8iUIIGTa+xXsJLRd
 1uneCbGunZ8k0Hhx7/ZZsdwqH3QCpDCsBZGT/bh4r4v7EujPWm2DNoTX4wf4DEuj6RbMv+LEGi4
 B1/roE9wp1JJCiqIgJjCRVd5jxzgi6N6OLbT3bM4EdpeCOIZQTuVZj75I9KNH4+XQkGvSHGgTNN
 /6tRyY06wiU5zGiP+5NOc/8RsQiYQkbBvOlOLLCXaYYthFiaORzHSbSQ+uMqe7vNBxvGbtMBz7W
 Oz37zeIyzuxosrRQQVJTdLJ/hxl2SzN4cF49HDqxSfcJXZHw3Jepoop5IXlCr/iTJI6Lv5Ftrql
 3MbfqJ5QicOwui1WwfhXEYjYK7bQk9p3iKGekyNxlLd+M/TH174gVGt4+2lUs54fmCyIXya7IKl
 MxE3Xo5UZli2MEtEilJnIBoMjMXrcRMtUGJZE+NEGcDXPJ/K0UWFJ7ApVjINP9C75Xvq0GakOop
 5E79SnMiaYSNB3zlO4cF8um3aHWP9wKrUABRI24pK26l8zp5e9j+vY=
X-Received: by 2002:a05:600c:4f92:b0:49b:90cc:3c87 with SMTP id
 5b1f17b1804b1-49b91c487b2mr214310515e9.13.1788011948600; 
 Sat, 29 Aug 2026 06:59:08 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm299752915e9.2.2026.08.29.06.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2026 06:59:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Aug 2026 15:59:07 +0200
Message-Id: <DL1HC4XCVFUG.16T2OM80OX3BO@baylibre.com>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH 0/3] Add RITY devicetree preparation support
Cc: "GSS_MTK_Uboot_upstream" <GSS_MTK_Uboot_upstream@mediatek.com>,
 <u-boot@lists.u-boot-project.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Ryder Lee" <ryder.lee@mediatek.com>,
 "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng Yun"
 <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Johan
 Jonker" <jbx6244@gmail.com>, "Macpaul Lin" <macpaul.lin@mediatek.com>,
 "Chris-QJ Chen" <chris-qj.chen@mediatek.com>,
 =?utf-8?b?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>
To: "Tom Rini" <trini@konsulko.com>, "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
 <20260828145911.GH3959812@bill-the-cat>
In-Reply-To: <20260828145911.GH3959812@bill-the-cat>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri Aug 28, 2026 at 4:59 PM CEST, Tom Rini wrote:
> On Fri, Aug 28, 2026 at 10:39:55AM +0200, Carlo Caione wrote:
>> RITY images select a base devicetree and an ordered list of overlays
>> through the storage, storage_dev, dtb_path, boot_dtb, fdtfile and list_d=
tbo
>> environment variables. EFI boot needs the selected tree to be assembled
>> and published through fdt_addr before the operating system is started.
>>=20
>> Add MediaTek support to consume that interface. It locates the selected
>> source on GPT block partitions or on the RITY UBI/UBIFS NOR layout, load=
s
>> the base DTB, applies list_dtbo in order and publishes the completed tre=
e.
>> Both raw and authenticated DTB and DTBO inputs are supported.
>>=20
>> Expose mtk_fdt_prepare for interactive use. Retain the dtbprobe and
>> fdtprobe command names and positional arguments used by RITY EFI boot
>> environments. Also provide bootembedded for legacy boot. It locates and
>> runs the appended RITY boot script through the standard source command,
>> leaving the legacy policy and authentication to source and bootm.
>>=20
>> The implementation uses existing block, MTD, UBI/UBIFS, libfdt overlay,
>> image verification, source and bootm services.
>>=20
>> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>> ---
>> Carlo Caione (3):
>>       arm: mediatek: add RITY devicetree preparation
>>       arm: mediatek: add RITY devicetree compatibility commands
>>       arm: mediatek: add bootembedded compatibility command
>>=20
>>  arch/arm/mach-mediatek/Kconfig            |  45 +++
>>  arch/arm/mach-mediatek/Makefile           |   3 +
>>  arch/arm/mach-mediatek/cmd_bootembedded.c |  59 ++++
>>  arch/arm/mach-mediatek/cmd_fdt_prepare.c  |  66 ++++
>>  arch/arm/mach-mediatek/fdt_prepare.c      | 502 +++++++++++++++++++++++=
+++++++
>>  arch/arm/mach-mediatek/fdt_prepare.h      |  10 +
>
> Is this some mediatek specific format? But even if so, cmds should go
> under something like cmd/mediatek (and get docs..).

Yes, this is Mediatek-specific. I=E2=80=99ll move the commands under
cmd/mediatek (didn't notice that) and add documentation in v2.

Cheers,

--
Carlo Caione
