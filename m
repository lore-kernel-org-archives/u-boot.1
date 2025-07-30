Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED69DC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 13:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22920801DD;
	Wed, 30 Jul 2025 15:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RzSCXqXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69CA80548; Wed, 30 Jul 2025 15:51:49 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8D980194
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-55b823c9129so653746e87.3
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753883507; x=1754488307; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIkPH+I23cA0840CfX8/f8PDEjtn1ZivaTWLN3zdQ5M=;
 b=RzSCXqXgwkgauXE22lW1cr4jkbDFAyJmf1LA977aZt8sDCL899HAoe2Ugo43bGDcOT
 7adaA2EjbdRCR8w4y1QyIYL8JMXhdmg5GbotxQET+yp/ZOw7hS94Us4QuWjb9fdAr794
 SrKWlQZZDaBIVCMJWakkicSCXd+2rNSPWuubwCFQ+sfdpCNO8pKq4e/Nb/lc2WNN0S4F
 vgXt9ZDyBG20B9+MJqIuZSqt9uSYm7hlNIFPJpEGt0bblplq+HPf4q40CP2sHjs4BEYg
 EFpmr5y1YEt0R1MFaW15h2MjFVaugcfhx4DfxAKoEnLPUszpp7MbdYBBlhv6tLxVooe4
 eNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753883507; x=1754488307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PIkPH+I23cA0840CfX8/f8PDEjtn1ZivaTWLN3zdQ5M=;
 b=HPDFz7bwGKw+AX5mktJD0wnt+bAmxpmobSRhWWMMYVR8/xCQ02SYOmX5gxPOrXHsPd
 g3+dBvvI1U5FTDb9qjaJhtKd2nlJ/Dsk8O0kp6t4orWOL5a2uVmJTRaFMXoP8KPQFw5j
 DkyAEiMxKVfsG3VICaWj2JEyM80wAoBZYUGZECXcwWRADJYTg+riM+KoIRG53xX49IGf
 DSPNEcKa3yX5PeHJAreoYXKq/VeXFHWGTKEikJxVnffJioNXQuE8s/PekwI2zSU+8oee
 x05enX34NbHj3rm4I6S1Ybji/2uleWXk9/0hQHU+aqEp/IUD944HQB6nArF5OY81kAvy
 aiOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfEw41Z/rLtNNXtoAYqwpanOgsga0E5DfDb7jG6pDs9wHMHNWytPN++VHMZTzvd2TyOfaOmxE=@lists.denx.de
X-Gm-Message-State: AOJu0YyzBloGvTffE/pxtbFLR0alJMCu0LCrKOxV92PFjuig1F1v0pWQ
 m5HWMobmorkqn3s6Npbia3tFy7NxDkDZbLCv+6PeBGyxSTBHYEdjnw/6K6t901k8B04QgAPXPIK
 YoShOH1+rFiL48Z16nPfa3ohRDmU1jdk=
X-Gm-Gg: ASbGnct4TNCZwYg8SJ7tmWpB7ysl/douGvlDeMgRaZ7y1r251/K4tVJFF0DHI8k/WVG
 eco2FQQWbGsprHJ0cGjUaUOoXYUmBtaxR+9zh/C1PhBhmjrU/TAqJ18cJl1nhak1Xv6ynw+rcIg
 FhH0d7RyewbmsLi1RhdAa3/lP4E3gKijZLrWF7xiIabp1lqcF6QxScQrsQYZ6VET90/38VHXUMN
 vHJUkckMnZdZeY7Mv95vQAmDiZt9jV6Km2eBuk=
X-Google-Smtp-Source: AGHT+IFeQ7QMaEMRY01qsjUTVFa3+wA9ZBOjCevTMGkFZE+XxSND50w1dKY+OSJg+mk0Y1dwHUmO78G6I5KqybLuULs=
X-Received: by 2002:a05:6512:e86:b0:553:3770:c91d with SMTP id
 2adb3069b0e04-55b7bff3a0emr1137512e87.4.1753883506872; Wed, 30 Jul 2025
 06:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-9-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-9-73da75bb33d3@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jul 2025 10:51:35 -0300
X-Gm-Features: Ac12FXxPbiHHLwz_ejVKXucQcGnI00qBfLtmx0f86oX4IFfZ7xz9dRKov-ZHYO0
Message-ID: <CAOMZO5D_byNG+rRmM=ax0w_gspcqi8k7EFCgzhsnv1GaWmZ1Bg@mail.gmail.com>
Subject: Re: [PATCH 9/9] ddr: imx9: Add errata registers support
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Tom Zheng <haidong.zheng@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Florin Pavelescu <florin.pavelescu@nxp.com>
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

On Sun, Jul 27, 2025 at 11:14=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Viorel Suman <viorel.suman@nxp.com>
>
> Collect errata registers values after the training and restore errata
> registers values before starting quick boot firmware.

Please explain why.
