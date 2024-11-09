Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CB3D5E367
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 12:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC36A8909B;
	Sat,  9 Nov 2024 13:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jtLtZqdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 655BE89102; Sat,  9 Nov 2024 13:04:05 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79AA189072
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 13:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53c73f01284so3709602e87.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731153843; x=1731758643; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adth6QyJRLRWAfGpC9DYVLlG4LiumwEb0Da+ozRvLcY=;
 b=jtLtZqdSliBgl51hyyeBi/LOzT4c29YQ0G2fL1gV0rkdWOBK00uoBGD+oiZP8JlVtY
 d3p8B1Zp+WxToD4wiK9TTZGl6uG6aZJcZR93/bYyiwUuZLGcOTu6hPsyUwt3A9FeeF0f
 A1cnq24wB/j2mx3xFhsGZPrgaysykohMC1SVl87/JP6c0nI0GL5t7dhM9WcuXAkI701L
 pIw04snXL3vRvXFwQOQ4vpIbT8RbvBmCCAoCpMfUeKpy9eGFIMtMQgxIzZyyWcGPPKVP
 nmDKWqXE9gaDDlnovICBg6miSDlJr+seXA0PLbO/BTGAOZX4k7nYQaM2Y2BXbavlQar/
 divQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731153843; x=1731758643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adth6QyJRLRWAfGpC9DYVLlG4LiumwEb0Da+ozRvLcY=;
 b=ngTWONUTmM/x1HH6gbmvvi8drAEJxOxMNjodRSM5GTPV0iE6GLfApbOeR76MCWuFEV
 xazj0LVOlb6N6IniDj78Fihw6tCB5LDpyrnIJFLDlvQt2pAb2NPeEDCtTvvh7oEkQCc3
 MRj4VdMKJ9yP0HCFGjNkAniOrnJbtk715qW4zdSROfw0FINoc/gg6iXiC2tVoktMtfpp
 c3la48sRhr4HYeED2DDsYUKwHdMFs8G+SsU2a3GXGiYfxEmPmSXI/epAFmvbhtkihujq
 C2+RoeX37uC44bmYtKtO80KubXQH5Ad3q3TrVeYBIQKx5M8t5NhLIdKi906QkOmvJ7Et
 IlPw==
X-Gm-Message-State: AOJu0YyzvoPatv7jL6sZzmaEeGyB0xFdN3OWtMWoHP0nOnIrrWr/d/5u
 N0oP2vW5w+rQRDGLexPhS2cRkW4mHpc4h6ShsffZ3OteZRn/AxA+8+MsyreZSqpCldISEg3WXUa
 XQabRoo5xCoNiGXdpoV2s1LLp2hM=
X-Google-Smtp-Source: AGHT+IFgCB3oGnE8juHD5fI0cqL30ylPdrx3XNdOch8GCsp67WmGThRNOvs/Qb+0/7pcrWCj+VxN+HoNGgCkN6ly640=
X-Received: by 2002:a2e:a887:0:b0:2fb:6277:71d0 with SMTP id
 38308e7fff4ca-2ff20280dadmr31214731fa.22.1731153842525; Sat, 09 Nov 2024
 04:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-13-hs@denx.de>
In-Reply-To: <20241108052143.26874-13-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 09:03:51 -0300
Message-ID: <CAOMZO5Bar=_Z0YJ1ayQbA2ec9ykH70Ngy2JHgmTtQUnejkOSLQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/22] siemens: capricorn: add missing ARCH_MISC_INIT
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
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

Hi Heiko,

On Fri, Nov 8, 2024 at 2:22=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> add ARCH_MISC_INIT to capricorn configuration. Add
> it in
> arch/arm/mach-imx/imx8/Kconfig

Please explain the reason for doing this.
