Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3A4ECE587
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 19:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A9288DB3;
	Mon,  9 Sep 2024 21:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BSkJPTBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7C688E1C; Mon,  9 Sep 2024 21:33:14 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 214A688AE8
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 21:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5365392cfafso4490315e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725910391; x=1726515191; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICx76sB5hVNrhmS1sNDXTBAXaJjZk3SZep+hRrqc0IE=;
 b=BSkJPTBLOmXByqpF66+TMrAFoYvehrSlmDg+nelpAbJII5nEXh/rQ+865Xkm1Msc/l
 7xL1xHVJ59lSWJZxSFvzEzRILYCLUwmuggQyAcxeouNbwiQmk6r8n65AXxN5udFJR4qV
 SbFzl6KffZ/iVyZ3+K6x7UvZ6ykEA9rzaM9/+TcezVePCEbkTT32LINBfgGKuc0uw1iU
 PH3ouPwDVRn283f+N7BC0joCdirkeb0RbelHFSvEFu+zKcNVp8elqbnAZZaRH87yGqqO
 oi/YHJW/QxdcJsrkMHKkEjC0THxcbJ+C+ZUjG61HqZWUujbsvGAjsZDgvtH2mL9hJrtH
 hzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725910391; x=1726515191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICx76sB5hVNrhmS1sNDXTBAXaJjZk3SZep+hRrqc0IE=;
 b=owTVEprh4PdMmwKsmFEjgzNhb+MwU6N3FAdk2RLYgIwoctkqHjgUzvOFbW6ol+3n8y
 3nposl/gmPCvl07uuDtUXnTDxvBsMddxMYPBM3s5V0qJQ4IyPooXpyZSylDbkRVy3a3O
 uQYH/Uns0BOVZRPAWQGTBUdv7NQ0MUWSgr7TTYkI9/mytcqBDxsLMupx+fjYh+7m2Yv1
 lFa4Uf5zJ6l6acF+YypyMtgm2gXho42+f88hy4PhQD+HKJMzYOcrMAIEvbDwSDd3iB7a
 M4iX/II1y82WNxQ8vebPufjTBkeEOn1duvOzc+XQi0xaACSfMp7q09OgpuqCvmneEPd6
 D8Jw==
X-Gm-Message-State: AOJu0YyR9h1YJYUYAIcvCm43M0XhfOj1WcgHO6FGWO14YgQxadjLJjQ8
 79kGoYTjQjGITIqhcHt3TG5YKapqfRXuikGujGA0RGH3+fJsBlS43crF7f+fa7VFggwbhzYFUQA
 4WhFwMftSRfrPhkrs66+FEs2av20=
X-Google-Smtp-Source: AGHT+IE17LBaIdrlZXO80jwANNVrQPh9wa4oITmeZOGV2rpCUDE9zDL+3+7jg2Gq763npIKtNHnQkf6pnv1b5f4Ff5I=
X-Received: by 2002:a05:6512:114e:b0:52e:f77b:bb58 with SMTP id
 2adb3069b0e04-536587cdcf6mr6450785e87.36.1725910391213; Mon, 09 Sep 2024
 12:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DT5-dtAF1cDbga3vjtk1UakQin1XboPyjmG=-h3-808g@mail.gmail.com>
In-Reply-To: <CAOMZO5DT5-dtAF1cDbga3vjtk1UakQin1XboPyjmG=-h3-808g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Sep 2024 16:32:59 -0300
Message-ID: <CAOMZO5Ce0g3tqWe2k47J5A74bVey7X33bzdir8DfM8zX5OnkDg@mail.gmail.com>
Subject: Re: imx8mq_evk: Boot regression
To: Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Otavio Salvador <otavio@ossystems.com.br>
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

On Mon, Sep 9, 2024 at 4:11=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi,
>
> imx8mq-evk fails to boot with top of tree U-Boot:
>
> U-Boot SPL 2024.10-rc4 (Sep 09 2024 - 16:08:22 -0300)
> PMIC:  PFUZE100 ID=3D0x10
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from MMC2

I have sent a fix:

https://lore.kernel.org/u-boot/20240909193003.707732-1-festevam@gmail.com/T=
/#u
