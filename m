Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42060CDD56A
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B8788965;
	Thu, 19 Sep 2024 04:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IuxBSVgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9794288965; Thu, 19 Sep 2024 04:35:47 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E058A88E1F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f75b13c2a8so3323581fa.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 19:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726713343; x=1727318143; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6t3ay1vQp4vCPbZ5NnuMQ8Gmu/X8u7hhz9GA0RS8vUs=;
 b=IuxBSVgFv6WMgeUWqYpEGKwuQeyCab9iS6YNIcAknU49qdPhKi7XuanvDtGK7v8f5T
 NAkHPOF1OUy0PM7Nf7BXlqDEnPS2lIltp85UTn3Ohxpwhr8QuqWXtgOA3a13PNKnwvQf
 xAJIPS3mRA9NzWYT9oClXjZnHM6/H0x20UO0XmzoZUmawIR+KQv0ghbLkACFgVhZAD3I
 E0Gi3r4bK7BeUiO4i3UKJM2NB/INcTmFT1LpbFf9y46xMcM+bpVECHFgYvlV2uJZKwmy
 9oGqctg2CqMnWqX4rjdxFWz5J6+r1vaxsBNXpj0txFtFByPEQo7jc0FAlPtq78413OSL
 lStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726713343; x=1727318143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6t3ay1vQp4vCPbZ5NnuMQ8Gmu/X8u7hhz9GA0RS8vUs=;
 b=EjH1Shm9RZJvlfR90PcI6NWLv004AFokK8BMGhD5rzxMGJeWeO5xPchEKmy8KsHSMH
 xX26Vd8nol69zqsjbhmuJngQzmWouip1ffSmpix2mRFPK9FZkQ9KtyyEs8LWt4m+xabZ
 E2zyoCADJmHDoNs/7YMXnPte8o3g/uDdIjWVCwCKbZrhmWUGtBbNGqAL2ivzdsQCHdU8
 mTF7DNp8FUJqPATQ3AcgEFDX32FaHFGO2e9lMdE3i9iaZTaJ13X260qqIgj1vDRq794G
 qvpsydcC6vNK12CZ3ITNYoXgRMSJmCfXbB+NyL2rmYfWQOczNgKUxJIf5WAZ2sxtTOw2
 pGUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrU3bURVKEmZjJV5Yux5D5BkIo43ystD0rDkCfRR2G2ud3SIPOZMS8BsFe3NL+csvXUx2Tjfk=@lists.denx.de
X-Gm-Message-State: AOJu0YwQUJdu9OoPJntgAo1wpb43PDxlPvBgC/5q//PAAflYPw09x1rc
 Th59KhjC+icSPd7oLkLIMYIWCAnNq/S8cK//LDmdW2HTTLJWsW/sFnkxOvjayW6PEe+5lgwh/9K
 cjJOeI36MVuhtfgALSqo9gmEI90g=
X-Google-Smtp-Source: AGHT+IGGQLhAeYtZCtu/61Bpftq7Xjr+QLaAytDZuIEgCICVZErx60nvQiBm9O+yZZdnFq210P+9vZo3rwuthys80ts=
X-Received: by 2002:a05:651c:220e:b0:2f7:528f:69d4 with SMTP id
 38308e7fff4ca-2f787ed4ce0mr136920791fa.22.1726713342818; Wed, 18 Sep 2024
 19:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 18 Sep 2024 23:35:31 -0300
Message-ID: <CAOMZO5DEH2DMvz-mw-4PSXY8yZ+-yHq=iRntZze5c_a8CEmkCg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] imx9: various update
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>
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

On Wed, Sep 18, 2024 at 9:14=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> Peng Fan (12):
>       imx9: soc: wait ssar when power on power domain
>       imx9: soc: Change FSB directly access to fuse API
>       imx9: soc: Print ELE information
>       imx8m: soc: Drop disable_pmu_cpu_nodes
>       imx: Generalize disable_cpu_nodes
>       imx9: soc: Disable cpu1 for variants that only has one A55 core
>       imx: Generalize fixup_thermal_trips

This one fails to apply to the next branch.

Please rebase and resend.
