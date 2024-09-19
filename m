Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E7ACDD56A
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E8588E41;
	Thu, 19 Sep 2024 04:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rl8HIzXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEFC188C60; Thu, 19 Sep 2024 04:41:06 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8162688E41
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f78b28ddb6so3001021fa.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726713658; x=1727318458; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfqvmPNZs03q+O9ocwge1uJQJqPOi3l+HSq60vYOLp4=;
 b=Rl8HIzXtq82xUefFOCvP9AznntCmYjaGatopDJSiyv+toCpct9MpNdzB/QZqivopB+
 ygqgzRmTQsXgm14K58vNwDIMC+D2b1qig63FrDeBmnnmWuIXi4WYPQlhjN8vxCei+mcc
 7RTZvUuTXKlHlXLtBthxD7hLXR3KsM0PBye6n+cpJ4xPr7np22XLsRJDzjOtz2D2TWBC
 R+oPEJUvJAm70u5Y2g/d8Gw0K0P/IuclcolUOyKnDs2jCqG45U/C1W8/5c1WwpirmWxp
 zNAXWJPdso1SlBo7ifq0SRNz0IquFD4zEUwEyCjVCPSndzECk+tRDntoKAjhz2SzvfE2
 yHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726713658; x=1727318458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfqvmPNZs03q+O9ocwge1uJQJqPOi3l+HSq60vYOLp4=;
 b=NdDTm4FrJaQ/oR3KVUMnYeH1NrpZ5Pf/dqjLc21QCWCafrBFH103DBybh7o16l8/u0
 Gp8iEQYZBM4IAMFRAyYog+gC4XqkzuOKadpU2+F5OGcLgogBf6ZohPgzpvG2DymSihGW
 AoWHMPDLQxDPzRwUdamJwMPPtWOLoMoEPAigw/X0nNjmU6gn1JwOnGD6CCocoihwmiZT
 23zgBhgEkuKcLbOg0uC7UUaqmM4OUaw+quic9gdIKgkORZqNovOJRVUwZtGDtfD3+HAG
 E72lq4cBtMW0qkxlubLfBL5Mt9vcln6E04p/rUyO5Mq3et+DiiT0FvkMNDX5inTDxeSr
 1/ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsYfUFb1sumE9sKu5u0hFJ1c+/xOs90j38rYEJFRla9XxxQddf1YYcPU1MDpVYOarPdLsoMgo=@lists.denx.de
X-Gm-Message-State: AOJu0YyY7K0G+MZiknUwh1m9ue/BpOijM5fsT1NuKlbaZfTxYhfhT56g
 VvRObL6eP9ntaf3NFQVw7hz2PkcRL7FgZ3bYHDM/np1k0iZGqMQUlSMBbOw2Rq70NSkyeeF0CBM
 QoKp9yzFVs9IPszNZUZkp917JXQNYXbmF
X-Google-Smtp-Source: AGHT+IF5lcW4jorIdFjg+7ZLFwC4CR8iFtrWoTGIZFQnvLUePewGC9wZVqHfCM+Vxzm/5LkkyotqwK6iw+m1SIJAGnE=
X-Received: by 2002:a05:651c:2220:b0:2ef:2b38:8796 with SMTP id
 38308e7fff4ca-2f787f302c5mr137201411fa.32.1726713657350; Wed, 18 Sep 2024
 19:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
 <CAOMZO5DEH2DMvz-mw-4PSXY8yZ+-yHq=iRntZze5c_a8CEmkCg@mail.gmail.com>
 <PAXPR04MB8459282AEEA486C87029C26188632@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459282AEEA486C87029C26188632@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 18 Sep 2024 23:40:46 -0300
Message-ID: <CAOMZO5CGL-jHZY-6hificRuNYngOeWLnpuvYs4DOBRS-ULS-xQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] imx9: various update
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>, 
 dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>, 
 Frank Li <frank.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
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

Hi Peng,

On Wed, Sep 18, 2024 at 11:38=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> Based on Tom's next branch, right?

Correct.

This is the error I get:

git am -3 ~/Downloads/imx9-various-update.patch
Applying: imx9: soc: wait ssar when power on power domain
Applying: imx9: soc: Configure TRDC for M33 TCM access
Applying: imx9: soc: imx9: soc: Align UID endianness with ROM
Applying: imx9: soc: Print UID in big endian format for EL2GO
Applying: imx9: soc: Change FSB directly access to fuse API
Applying: imx9: soc: Change second Ethernet MAC fuse layout
Applying: imx9: soc: Print ELE information
Applying: imx9: soc: Add function to get target voltage mode
Applying: imx9: clock: Update clock init function and sequence
Applying: imx9: soc: Mask the wdog reset in src by default on i.mx9
Applying: imx9: Add 233Mhz DDR PLL frequency
Applying: imx8m: soc: Drop disable_pmu_cpu_nodes
Applying: imx: Generalize disable_cpu_nodes
error: sha1 information is lacking or useless (arch/arm/mach-imx/imx8m/soc.=
c).
error: could not build fake ancestor
Patch failed at 0013 imx: Generalize disable_cpu_nodes
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
