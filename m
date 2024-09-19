Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D7ACE8D78
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 12:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA028914C;
	Thu, 19 Sep 2024 14:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R7C09o/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 790F08914A; Thu, 19 Sep 2024 14:00:50 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97EB48914C
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 14:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f75c6ed428so8102661fa.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726747248; x=1727352048; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTWD4npzmv1+ZrKdDgE8uwiPAwqFuRhQpbUNh3jeAJQ=;
 b=R7C09o/4gJvK6f59Ajv6PTnoPa1MpMj0DtSMYraMGo9oBdhEIHeaBR7O5ryAfW2PWm
 nlzv1rC09L3Pnxz28ht3YM0gsh9Ip4zK40U8KerMMSy6gf4L52ki77x8KCCHxPt6LRaV
 V7K2+fmsQoCO1OW3qPkIW7rHVUVhI0fRIw4rLVEl1dqQ8OcEITBAiVb5vJUv4W1M55T7
 D7kTVpVgazMErAtZBCLORGlgnwC2SHQxO36PDmA+Z/fJoXFchJDVTpd3A7wZJcQB25SZ
 Jhte8h2fe+HrATmKw+mDFFNQpKcuotyfT4KCAKvu8Pv4nF/DPppdI+7xeXWOEOPNVORK
 W43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726747248; x=1727352048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTWD4npzmv1+ZrKdDgE8uwiPAwqFuRhQpbUNh3jeAJQ=;
 b=sh+u+Fm/xJzFcbLCUTBTlGMUcD5BU6SlLH4DJ26vffSPbN6OUrrSp6VBqKCLVleVh9
 /u7VGOUVYWsRs+23wKbbqwvSaC3qj54OGTZM+yjlajYVHdYrNDX0e+Bm5D5jArAAWLoI
 Tjfxexevia3eEbsppVsOz40ezQqXxvejtuchw8hz6phQ4GwKO47Uk9neD/Ir4vo6bl4Q
 B2kYs9iTazzmhjAToolUdQCXpGqrgf2IIxX+HG312lrOZv/CPEt+z6qWw2LT4ko6K+XE
 /87Xiqfr8bacEzTcHkAi8vXHSm43cMQVN7w+sKTGWSkMEuUNKm9FRsSdidMqIB9zu9O2
 IaBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJzHv4pRbjdR8kgCVn2+SJ+9ZFkA8U8QzGeJz/W0pg0dBFYWuUSJTN3aIzWup37el4d+TkCk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzwpf0sN3K66o0E8nPrZT083N0I+CE2Yzf8aUACY+npsbkjr3PT
 4sX8JBLSLsqDvJ7FV7GdXpEyYmb0+57k36BVVYOU4Cyk0NPpNxDktgdJW3V8DtlLWT1UtAJNsJG
 kkSg8xWQb2yDePMaOU8LkOuFteXE=
X-Google-Smtp-Source: AGHT+IG/z1hfgCoilWyXFJ9CiKNQe7Ptz5TyY4Yosfg3je2dRBII6yNmJFhJ01m4we8al3ilbfqEaYt/lrobLI0lzuA=
X-Received: by 2002:a2e:b8ce:0:b0:2f7:5d53:7196 with SMTP id
 38308e7fff4ca-2f7918e843bmr125450631fa.4.1726747247388; Thu, 19 Sep 2024
 05:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 Sep 2024 09:00:35 -0300
Message-ID: <CAOMZO5DRGHjbE0xRpNhYjdRwYnacPghLFspp_9m1K_YGvyeCfA@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] imx9: various update
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

On Wed, Sep 18, 2024 at 11:58=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> Several updates to i.MX9 SOC and i.MX93 EVK, the related code
> has been in NXP downstream for some time and gone through several
> public releases. Some are directly cherry-picked(with R-b kept),
> some are modified from downstream.

Applied all to u-boot-imx/next, thanks.

Next time, please send the contributions in smaller chunks. It is
easier to review and process.
