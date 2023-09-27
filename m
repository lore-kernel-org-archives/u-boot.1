Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FC4E810AD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9FDD86D80;
	Wed, 27 Sep 2023 11:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6RL1nPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1C086DC7; Wed, 27 Sep 2023 11:43:00 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B249801B6
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=okhunjon72@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50307759b65so17385062e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695807777; x=1696412577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRpBAVPx7Mp9giQ9yk+YOFRSp8j4plIwxLPeBKKHrT0=;
 b=E6RL1nPJVcqoKflYtEbPumkNgqntaLZQXs1KzBMNKAkm1aLA4l0hgf9fG7aU2Xi+u0
 oD5dWb0wptTe6DfD6jZuH0dcLRBeArv7+o2ipbT/SbvIu1PAlI5MC9dMudHQN/9clcRC
 gcIugfrq4EF+mMFdCCznbE5DYHDdaiwC/YJL/HCu2QIs5/eOmpjb+DdXKdMQMN37lMPQ
 0DWROLl9QBBmHcO7K/5aUtr0ELd8P17HYKCC/yGg42QnrB2hsuYvXMEVDTiXyWVnziMA
 vD7O5BAu3Wa1MW39RCQbaRHPB5avMf9svtmbsYCxd8puCLMRsjlqMKgIsKwdICCTsHad
 Mp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695807777; x=1696412577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRpBAVPx7Mp9giQ9yk+YOFRSp8j4plIwxLPeBKKHrT0=;
 b=joXCahloSCFGkoo/3fUyy2zpxZpctJgG5F3s3ODGlKO4wEuL33Yro8cFaL6+8fpD0V
 ex9N+vX+vE5IBQG04dARXNRvUMyHbRGgcZSXooN8Gg5jpsC2vN8CS1cwpbgT/y5vTJHQ
 QtI51f/SN7Ey8AQW+jJGJRpmHvkWhU/yS1fCGiaYdPuTXPJGhKcOtm70DSpUCwlrY4+4
 Cq508tTBUWVkMT9kmmhWVsdg59giQ/+z19Um1bO8FjykGERVcW9u+6OkhTZBa5FCwBae
 YMBvmlEFSXmwDcY4EZY39DDq1e8D1YVqQdtKUc4z0/3W/2VXktn96qKFgTvsFyh2ZEmQ
 p8mA==
X-Gm-Message-State: AOJu0YzMs4O54miJz+G1NrWbG5ywCFzDGXnbxwO1JivahU5MPRUr6z5k
 IOkC3DIlWGPMSxPMS5BRWJM=
X-Google-Smtp-Source: AGHT+IEgr9ZrYR/8ZTlJcBC7u1IjWbhaIrfLEcObqVd1wG4lgdemJ1NL0FSL1kmEaSGPygpgmAk73w==
X-Received: by 2002:a19:4319:0:b0:502:fdca:2eab with SMTP id
 q25-20020a194319000000b00502fdca2eabmr1064851lfa.37.1695807777209; 
 Wed, 27 Sep 2023 02:42:57 -0700 (PDT)
Received: from okhunjon.localdomain ([94.158.55.47])
 by smtp.gmail.com with ESMTPSA id
 i37-20020a0565123e2500b005044391b610sm1853823lfv.289.2023.09.27.02.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 02:42:56 -0700 (PDT)
From: Okhunjon Sobirjonov <okhunjon72@gmail.com>
To: andre.przywara@arm.com
Cc: bigunclemax@gmail.com, cfsworks@gmail.com, jagan@amarulasolutions.com,
 jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev, samuel@sholland.org,
 u-boot@lists.denx.de, uwu@icenowy.me,
 Okhunjon Sobirjonov <Okhunjon.Sobirjonov@Mec-electronics.com>
Subject: sunxi: introduce NCAT2 generation model
Date: Wed, 27 Sep 2023 12:42:52 +0300
Message-Id: <20230927094252.61765-1-okhunjon72@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721134606.4505-9-andre.przywara@arm.com>
References: <20230721134606.4505-9-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When NCAT2 generation model's introduced for t113,
the modification in drivers/mmc/sunxi_mmc.c
> + IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) && (sdc_no == 2))
in struct mmc *sunxi_mmc_init(int sdc_no) seems to have
some negative side effects, meaning enabling 8-bit mode for MMC2.
Paticularly,  IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
should not be used for D1/T113 
since there is not support for 8-bit mode for MMC2 yet.
Therefore, the solution would be to drop this particular
change entirely.

Signed-off-by: Okhunjon Sobirjonov <Okhunjon.Sobirjonov@Mec-electronics.com> 
