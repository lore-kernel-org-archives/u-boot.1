Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E40C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 08:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA803881EA;
	Wed, 15 May 2024 10:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZBOlzlXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED193881E5; Wed, 15 May 2024 10:01:52 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9134C8817B
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 10:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a59b097b202so100316766b.0
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715760107; x=1716364907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WfcKU1mLtvYqKO6TC0CO891kAc6XWruPKDkAqajCiGw=;
 b=ZBOlzlXXSUan3eBPtYCu4hatYIu/QknV31qsIzCcwmpTPVj9T8gCpWrzLeCY0v+p7V
 UNvnfnKyQzpPtPEFScKjGi/EVoK11TcwiIjZ9VvvOoyDkT1IZVIhUjbszwiEpzXPo39A
 mCy9cn4EnDVXvlC2xU8IfQsDnP9hCmw4L08alIuhMwLBmfJG0sQkaprHpii5GU7cMV61
 vmpITaXICvcyobK5BwdE1Rtta9kvWb03Jj45tsS3hGt+7HOAD6/1hjDw8ovJZPBJ4lvn
 Nvz6f9SmV+w69beZD8K75n6XMiEBMFurcHmLqOILY3196h+z8/mezpWXdTip5PFLN1GG
 zOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715760107; x=1716364907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WfcKU1mLtvYqKO6TC0CO891kAc6XWruPKDkAqajCiGw=;
 b=La9chj9L74OTygG/c4+RhEQlfvjLfdYAMD45H0AcqEMUZasGtD+lMjoNtMPkQzr6sq
 bWNKWsb5AezYVKGJ+dlch1VMSm1IOFfHEuPiGVhB+91Qb18lOxyo6cxzFZ+USMf91mt0
 QbeL0LFmiVf/Es7DlOBcrQWigREmPxYX/Y/5pwmBKMA/waxP/Z2vH4TbFx0WjmcQUDnl
 k6RUSqhYgYh5ikRHMMcY8DDKg2/cQYoA9CrZ9VN+s3Ty7thXxtlZjuXGAQxQt1G8w1ee
 o+dQyUBICRW/neMN7EIjGEt8V4jTJcg9gYeFWYKqw8kA4zjoFY5kUtA/TyFOJ+gG7hq4
 szGA==
X-Gm-Message-State: AOJu0YyR/+IetCLYz2WzTwR3Gda0KUOoExm7n3uvs4w64ehgl+VhkgH+
 LuRmHCA+hRP+rHKvzs5y7Q1gkCqBKmYWJt60lQc3K2B59kqH/Y7gZ49LOhqceBM=
X-Google-Smtp-Source: AGHT+IHszR5xBUWPMS/tps3zA96o8zbT7Gpf3ycugwjpXuTz7+E32tpaQR77pC5qpKJEU0G4wihVhw==
X-Received: by 2002:a17:906:56c2:b0:a59:9fc8:38be with SMTP id
 a640c23a62f3a-a5a2d55ae7dmr973444866b.26.1715760107119; 
 Wed, 15 May 2024 01:01:47 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01472sm823804966b.159.2024.05.15.01.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 01:01:46 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 0/2] arm: dts: k3-am625-verdin: Enable LPDDR4 WDQS control
Date: Wed, 15 May 2024 10:00:56 +0200
Message-Id: <20240515080058.1530985-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Manually, since SysConfig tool do not have the relevant option,
set PHY_LP4_WDQS_OE_EXTEND to 1.
Since WDQS control mode is required on our modules LPDDR4,
this enables WDQS control mode 1.

Emanuele Ghidoli (2):
  arm: dts: k3-am625-verdin: Update autogenerated LPDDR4 configuration
  arm: dts: k3-am625-verdin: Enable LPDDR4 WDQS control

 arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.34.1

