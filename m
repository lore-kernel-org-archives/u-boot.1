Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8A4D1A427
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 23:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB058940D;
	Sat, 12 Oct 2024 01:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MZlOYOE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 482B3893DB; Sat, 12 Oct 2024 01:01:52 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51EB189413
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 01:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so18662716d6.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728687707; x=1729292507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JieCaRFGMCvozzjyM7zoqyjj40/6tNiUOQ1fO+B731U=;
 b=MZlOYOE9xzihEeO3qAk35EccBq6lStNk+sPMV76mwsE4cHUwS91TynQid1LtrDRloH
 sC7qmETyQuxbYbiDSGBTbch7b62b30wmwHkLFZBCMp9YZ3YdLN0iA380PcXj+ARgQcSs
 pSMbK4XLTuoGig22OpjNPK36sBXDVzLhZzmcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728687707; x=1729292507;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JieCaRFGMCvozzjyM7zoqyjj40/6tNiUOQ1fO+B731U=;
 b=SFK/Ch4ScV9VgiaDztPike/oF741EhijDS+dlw8c4Zq0iheyzbgrKU/t0NVqHEELPV
 gMOQI/icVvXyqOkKmKdUeN7PAv6zQEWOYcLykmBqNvcfyTv161SJ+wibCroh0JRZVSHI
 N1WjeJ/HhbqyC3B/nVZ7/y1CYbw+F8T0pytLg87uQUoBKCAyCCjIy08gQ2vdnNfneY+E
 6XXmdIpsbtOAJ40Se7b8VUQuhP9KJ7e0ptY/9lkUJgmyfN4x4XR+dzWQQ8VmqF7q3VRS
 GkPiif6u0NaCo9uzJvg3dnILfCE4KjecmJF6Cn4NHR/QnFnpQf/hj6uM/akGMpDm3X/E
 QQ7A==
X-Gm-Message-State: AOJu0YyH2rp8iQc69YRqIa4n1c6IzRcz7GY724bMN09ola/ZXy+h5Ws/
 9su6HONt9pD12hZ+O+k4dLZbcruh7ExBaLKl0S9l70zsdV7nyIWNDUbbEjuhOJ0=
X-Google-Smtp-Source: AGHT+IGXdq0oyHHSK3y5IdaxMLYgcTRvNlhjFsklALnVoVyEOsHS4tN/xSpAGCuzQn447N3vau6sqg==
X-Received: by 2002:a05:6214:4686:b0:6cb:5605:ffb2 with SMTP id
 6a1803df08f44-6cbf9d0f37bmr18369016d6.24.1728687707135; 
 Fri, 11 Oct 2024 16:01:47 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe863042esm20380646d6.120.2024.10.11.16.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 16:01:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Apurva Nandan <a-nandan@ti.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Harald Seiler <hws@denx.de>, 
 Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>, 
 Heiko Schocher <hs@denx.de>, Huan 'Kitty' Wang <HuanWang@gehealthcare.com>, 
 Ilko Iliev <iliev@ronetix.com>, 
 =?utf-8?q?Javier_Mart=C3=ADnez_Canillas?= <javier@dowhile0.org>, 
 Jesse Taube <Mr.Bossman075@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Leo <ycliang@andestech.com>, 
 =?utf-8?q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, 
 =?utf-8?q?Martin_F=C3=A4cknitz?= <faecknitz@hotsplots.de>, 
 Martin Kurbanov <mmkurbanov@sberdevices.ru>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Randolph <randolph@andestech.com>, 
 Richard Hu <richard.hu@technexion.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefan Roese <sr@denx.de>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Teresa Remmet <t.remmet@phytec.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
Subject: Re: [PATCH v3 00/33] Tidy up use of 'SPL' and CONFIG_SPL_BUILD
Message-Id: <172868770294.633135.16808979120632226260.b4-ty@konsulko.com>
Date: Fri, 11 Oct 2024 17:01:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 29 Sep 2024 19:49:23 -0600, Simon Glass wrote:

> When the SPL build-phase was first created it was designed to solve a
> particular problem (the need to init SDRAM so that U-Boot proper could
> be loaded). It has since expanded to become an important part of U-Boot,
> with three phases now present: TPL, VPL and SPL
> 
> Due to this history, the term 'SPL' is used to mean both a particular
> phase (the one before U-Boot proper) and all the non-proper phases.
> This has become confusing.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


