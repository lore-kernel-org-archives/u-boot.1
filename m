Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E994DC35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6D788E0E;
	Tue, 17 Sep 2024 14:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CH5SbeH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3018588969; Tue, 17 Sep 2024 14:25:06 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461AD88E0F
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f74e468baeso48945871fa.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726575903; x=1727180703; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICAu2V01muHS/vUnH3px2yV0uEqGQ6W2k2yTsgb9PRQ=;
 b=CH5SbeH1dbq5Q2QaBkILbtkbalwpNWmWrR83OTi6qHK2cndKWZDUA9fiEGEOhubZdq
 jsBjS4qFldNwEiDUBEsXeTc5Dya4cM1ghMlZ7u+QKboLmnbToaRG/gU6usfRlXdyZRJR
 rkFEhCz8fcHVsSHQxDIlgVDTKDKLZo+sebS3fnObfbyqn7G7jgo0ZroaC7vjyEqbdjxD
 qr96odeN+obSrbxsspsxZ9qF1ao4669dSlKdIDEzcv822pf3WZdtQnhTsd40NgDy6EEV
 44RzSy3W3+5GGa592IG/tylBEAde8OHWS0nSkGcXjtbotH6OBtn9xfCABThKYSJ7F2q0
 RmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575903; x=1727180703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICAu2V01muHS/vUnH3px2yV0uEqGQ6W2k2yTsgb9PRQ=;
 b=uuBScUhUREJghFtRpaCP2mM1XmuWuxD2Js6/LMH9hN9YFNBXk9JoSPL15PTQtF7ZFQ
 poose7rUnltyML4ViAb8Ei4+zyiX6ziDA2604iHbswqZdavJnCvZmWNQr9+VDAKTVJb4
 QC9wTho/mD2PXQUgFyi9Rj5eUtyVu6Stzc9mLdSx+3GFi7Y2v+OMoRZMAinS7kcsP8MP
 EgPuXDPH37kmT5Nh9aotOcfJav4537MvKqsfagkdchpC2ocDPK1wRmEkC7P0g/sMJC5h
 LuyAdQAKejcaZAg8obcc1zhUAV6fBj4h+ED738B6Js88pjO2h+oOsU5ccZe4CqpGm05f
 Vqtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9nyMOaBlU4/+SNYkRk2DwBjJ8eHAWncxbtQH6rF1tZ3QOwOVQEhDJMeNaljgzxH77JH3OiaY=@lists.denx.de
X-Gm-Message-State: AOJu0YzIcwnP2odfbXo7Zs+GYmN8XFxzfoJ8sf+ZbcVq7jc4B7ppRYTv
 wzUHCgLQBssaf73s4SGQe3MPlNxHDzMFzl1QhL8vAVOSDW7eQgSwTlt/HINUrAT8cTiL+DiizAo
 puKUGh6U17gQmXOZqpnN5wUzztWE=
X-Google-Smtp-Source: AGHT+IEB0KzSFYUykiZCd1um+whXpIAOgPgj/WCOHHIMzfltDigp/Cm19cnZp/yr8v7qpmjb2KHd0MMCO4aR2S0jta4=
X-Received: by 2002:a2e:be9e:0:b0:2f5:abe:b6c3 with SMTP id
 38308e7fff4ca-2f791a57e3emr80602161fa.33.1726575903344; Tue, 17 Sep 2024
 05:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-7-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-7-4fe8effc937e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 09:24:51 -0300
Message-ID: <CAOMZO5BOwB8JYLSNhQyG-7suNnMvMiaSDib8YBRsV+ZmDwBW4g@mail.gmail.com>
Subject: Re: [PATCH 07/21] imx9: soc: Add function to get target voltage mode
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
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

On Mon, Sep 16, 2024 at 11:30=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> Replace the static CONFIG_IMX9_LOW_DRIVE_MODE with runtime target

Should the IMX9_LOW_DRIVE_MODE symbol be deleted then?
