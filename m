Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C774EE7735F
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 08:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C591986ACA;
	Sat, 30 Sep 2023 10:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SWXMx1sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEEE86ACE; Sat, 30 Sep 2023 10:31:16 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 664E886A23
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 10:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiconglu58@gmail.com
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-27927d37ec7so1708412a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696062672; x=1696667472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pygnyEnUmmj8LHKYXQbVb61LS2uU97Ko3WP0F/TMxS0=;
 b=SWXMx1sfquc7NFx5A4+OKLoTKZkVMSPNO900oAvDd5KetYKReIBYeakCB5Ve49fad4
 FE4k2vbq7w7BGOTGIC1XlQFaGMYKplXl2Fx9UDzrulmNFQ+jUM/NEU2l4Pp7YMuoDarz
 DKE+h/SroYIdiyAFAUu0zCSmyWdZiEhEQ77fz+vHP1QPxvN1YshDPmqPpFmKzxq7Vxab
 LvSKb0V4q6487sGuYxksNkfqjDHEXFMF8P1x44YZe7cCRLLRVpbw7v//moGaaEv+rvZl
 rgLngrCxZ3c496qwDbtzelYqzvR/kq6LwwkNbe6x58bcyX8L4V4rFAVYwTcuDQ7qvDks
 QNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696062672; x=1696667472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pygnyEnUmmj8LHKYXQbVb61LS2uU97Ko3WP0F/TMxS0=;
 b=XUKK4wzw3iLNZemH2eLVdVp3ww/gXW6e+oWgT/gLByGVVfEd0BAK3i2lDB8teE6hht
 KzKejkwrzK9FOmu7utWmLBGfWFludbZ7uIc++xmlpIIEryItCzkge0d2ZFyC1dundvnE
 JpFfWFUID8Q8lgCQV64qZtDgzFHuHwxQON6fEc6VU+zLTMD4mWFWzN12/QkMdW3KZ+7s
 2g+UhLe0nn+m4+Un0I9tQuKzKjSoekkV7BCRyOwqFrAOVuSqqmFNCwysONYx8u3ZVByv
 ORTbIv24GjHMGaFd2odcqwtZhNmSxp51k2xU5nIzaHpR/Po2vuwPLAUqzP13UhJLSQwq
 7rQw==
X-Gm-Message-State: AOJu0Ywua/FtUk3mLLcqcIwkTX4mOT3WfzjOzVkhvnXhY2e37cW+Gul5
 MwVsEecyOpA5R5yJJsJVh/p2lO9wh4Ji
X-Google-Smtp-Source: AGHT+IFlHCdUcu2WzAMhr+ZNck9E0AiJu2i9A4Zo9baM35TDnfbFFjPA8v/ljPqjoNAZA3qW2WzcgA==
X-Received: by 2002:a17:90a:7486:b0:268:b682:23de with SMTP id
 p6-20020a17090a748600b00268b68223demr6480749pjk.28.1696062672206; 
 Sat, 30 Sep 2023 01:31:12 -0700 (PDT)
Received: from localhost.localdomain ([62.204.54.223])
 by smtp.googlemail.com with ESMTPSA id
 d5-20020a17090acd0500b0027903762fbesm2679841pju.14.2023.09.30.01.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 01:31:11 -0700 (PDT)
From: Lu jicong <jiconglu58@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 jagan@amarulasolutions.com, Lu jicong <jiconglu58@gmail.com>
Subject: Re: Re: [PATCH] rockchip: rk3399: nanopc-t4: use 1600MHz sdram config
Date: Sat, 30 Sep 2023 16:30:46 +0800
Message-Id: <20230930083046.2524-1-jiconglu58@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <f7f5c5f1-16bc-0ed6-b25f-0d1954be9004@rock-chips.com>
References: <f7f5c5f1-16bc-0ed6-b25f-0d1954be9004@rock-chips.com>
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

I'm not satisfied with this result. All of FriendlyARM's official system images use 800Mhz DDR binary.
So they shouldn't found any problem when some boards' DRAM cannot run at 933Mhz.
Although they tested them using 933Mhz DDR binary, my board will still pass the test.
But now TPL initialized DRAM cannot run stably, so I can tell TPL DRAM config must be more strict
than DDR binary.

Before I add openwrt support for NanoPC T4, there is no public linux OS using TPL to initialize
DRAM for NanoPC T4, so there is probably not many people tested TPL. We should make sure
every qualified board can run U-Boot without probelms, shouldn't we?
