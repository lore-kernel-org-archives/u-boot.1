Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B3DC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 11:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11470836A9;
	Thu, 24 Jul 2025 13:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQLt+6Cd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA2E836D5; Thu, 24 Jul 2025 13:28:31 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8882C83693
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 13:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so735152b3a.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753356508; x=1753961308; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2EKTIjcu2J+WzgsFrY95SUVw8HIckJKpmRACX1mpVFA=;
 b=QQLt+6Cd+n05JjLTLOGB85u6hLY8OBxF0jaVX4cJ2a/Z4ZrO2SVePDRlat2ZPVKJ1H
 1gomric/nb338mm5M18aGq3Lk0LtQdAiukLKNVgJZ3+8JVbWv5geVhJPcTugRnJupkBz
 dy/RRRSZnxsSW0EZNXw+/9jeCs79HXZhPb4Lzo2J8QinbmLUZSvLxZjfHC0GPDuqqDs+
 d1pJpheMJFeDchFfABzKopDeHItUfXhJkIXJYarx5eI57U2n7tNaEEfVsHokEqO8Pp3h
 +gPYjcWZ3BCDgbe225D7IzLqoq+y/iow63WnwtIVylM0KPxgVeXzAzOie0Hhu5IpPvg/
 JEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753356508; x=1753961308;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2EKTIjcu2J+WzgsFrY95SUVw8HIckJKpmRACX1mpVFA=;
 b=fNDkTQ+kXSzT3VsN096cgbuxJbYRuWqN8ohgF6R1gqaiqaUY+FGO4go1vtkETkrWsb
 FbiyCnpzHv45FTYfQJBCMjE0Qlkx6rDrAB+dOOzR21GhsuTGVDMWkUsKuUE3JXRcTOHA
 Wd8/etM5g7hdmKFLb5G3lluO5G4FAbXXfRHlbGHfTEQ4Z0DTZE0GWyDJKc2P/rUjPGkg
 FHEqZrNk4Ua5CmVSDwkiH/xRVERGZueER6G77gPQjcfLC0UgmdxlPimv7Y0BPKyTFk9u
 WAELOdE2ymn3k25LAiY0NFh58557Ht0N+fYLTMoli6rZFDlpc8egFwTvN/V87BbtmhjT
 Fprw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQL7zj+JwNYy2EvO0RpJ1YVekPeIMKhMUUx5h7crpG6J+7Hmn2PchGFopKCzSYds/iAwBbh4w=@lists.denx.de
X-Gm-Message-State: AOJu0YxRWI6tOKRsmH+im8ZKquUmbrjdjwzy9H18N9FF5M8Tkuj5wIH0
 r4I7r50x2viXGG4NomsFO5IYaZq1uJQaMj23At81GNxacguC8C30QYru
X-Gm-Gg: ASbGncsYZx7PDcSFagFQ+JzFjULIHJzkwLEUknIqt8jjT6IiGP566DA7J13gGpI1Zwo
 Y8r7T8Tbr3Xe8ytOSI6ifUFTH7mGnQoliMfoXFtrFzFz356z6rc/Doiq8tH8Sbvxs+aDH6jR4js
 GY0kYhM4LnDzQP1jC9jrGEtA2xMKwd+O4Vu8EsaaErQDyTZnwXksx7iQ/0/fEVEmOpjg+TUGoCO
 ssTN3Sd4u2kijDhb5pZ9Vcs9ObP6+JS/UvKelk5bi+KlcJTwllSmq0uZG8Nx4sYKutoT/eats9R
 D29cRTNRRtfWSxp5ljHsv48Va8mErwngWqlCylz3Pj/9A55PFE8Wp6h2KHHO6+iUGmpPwuQ3CTO
 Q1UDejDz7hnHulFvkYpQ7nHli1rTc6GH1EeQfoNnreIworkYrZlq0SVoR
X-Google-Smtp-Source: AGHT+IEgis48ylJuCyFoDcWI+ldlW1uVrrfQgO1ygKr3cap+ubNVdW9lD7OiEA62OQ6JSFKf8pf2IA==
X-Received: by 2002:a05:6a20:6a25:b0:232:1be:1e09 with SMTP id
 adf61e73a8af0-23d4913ec6fmr10111871637.34.1753356507784; 
 Thu, 24 Jul 2025 04:28:27 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b0641e14sm1470180b3a.134.2025.07.24.04.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 04:28:27 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:28:22 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
Message-ID: <kn34dabjpqywranhgrtpy77bmuviluhzgf2pgtdguqvgwk7e3d@3zud5czxsewc>
References: <20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com>
 <20250724033822.GE18395@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724033822.GE18395@nxa18884-linux.ap.freescale.net>
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

> If boot from USB, this means env_loc will be override here.
> 
> NXP boards always use RAM env when booting from USB.
In that case, this seems like an ARCH configuration and the ARCH should
imply the necessary kconfig. Currently, every i.MX9 board needs to
enable CONFIG_ENV_IS_NOWHERE or the boot hangs when booting from USB.

> If your boards has different settings, I think we may need to
> introduce board_env_get_location. Or add some device tree
> properties to specify the env settings.
> 
> Thanks,
> Peng

Best Regards,
João Paulo Gonçalves
