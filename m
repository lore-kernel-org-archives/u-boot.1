Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD00E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 02:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E53F8069A;
	Wed, 15 Jan 2025 03:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4SUNzNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B1F806D4; Wed, 15 Jan 2025 02:43:55 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5590480027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216426b0865so108682425ad.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736905432; x=1737510232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6CBVz5021LfmNYPPOCpoOCJxOPZ0KxEsd/n+moihRM4=;
 b=U4SUNzNzTBlgxE2VW1ipD7aLwyV51+5RnXDcCU4OG/pK84ikoj/mmIGjFi7c9PltUz
 fp2QvDUGPkNLA7C2/NTgLcNoGbM2WJ1Sl9gYSIbIcOTe4rDON3mgQObkufGfb5DrO5gt
 aq4GXe27Pv8VVeMSaoHWB9bfWqmjEZgY5R0T10lfgoZWtS0g0z6ITZlrRQ2a4GtGypAP
 K0a6ka468bxNip13iREV7myz7OwZT8DYagjmyXhOU4k5oshLWeOD/BRkKqYABUI5nr29
 rvuyXasiZ1ZvyNgprFkcXnKwHN8YoKzZy6ccboSe3/LJGIs01pacar8t3KTh4NOJAIFm
 5D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736905432; x=1737510232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6CBVz5021LfmNYPPOCpoOCJxOPZ0KxEsd/n+moihRM4=;
 b=RcA0Se5LxE9c5yMEX3V/pshzteUMNyOTTZJ6bqduRGBJtZNKCTgu714Bnm9vLQEfjv
 Gh/K9xTVSVWy5NUVdu0fyGogvybrgJCgCDuSMHPWhgLSluvhq9d/0DsVgmVcz+1xwyUC
 rmmpeWehs8sEsuUZsowFXO3Nw79MOLBk/sjuzR3OjXVeldIRgLA2Jp5j2SCDHQd1xkK+
 T46wIiyzFNZnnkPuQP+HD2GbHN7K+pTXWLtT0lfLMkX29jfBxzQ740qv/PE7ADiitiEc
 fmFtxCoE75aQwly33aNmq4n+NK8ZMedccy/lgaM5UXMLDbVwLiF8c2Ot5XcTyteMDNzd
 1Qow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuRAy/vUDAAjh4rIDtbDU36vB9dOQyeNS/iR5b/hhWXSWAysk1tfCgdM6W8c5kbYc57OkCIOE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9mmsIgaPkYXiQlkHmbWcHJbPeHJaK1HqhGAoYjo+4VzEvx5Y0
 FYnh5ccOKGBa5ZeJmYdEXon2cA7wA+LDv2T5bgJSnianbEPVJ49N
X-Gm-Gg: ASbGnctgLEBFQqAtdmt8DXi0ylkXOSbjT95HOc+VIKmWtfSGerlBD9GciBNwnRGSF94
 1/iNTvo9K/uZcPA7gnXANrluncuNSIgsDW/f6Pspow7ireIG8NcZt+wScI0TNSCej9sxOMHCJ8O
 I6OBCJGcaf2YfoU+IBIH6GzQ/StG34EzBC0fj160uFx0d6T/i6UaEXl63ySUBda63weX5+YRr41
 gimm1G5QxxEDmMe2U68XnraXpOqpQtvdxZEMS45hJ++0ODjpcXH9+T/DyoaMezK6ZSEUQeNVoY5
 3RLuRZYyACz8vnQTO1001QJvjwQr
X-Google-Smtp-Source: AGHT+IHuCU4v8v3OWPjDjMiLIPlLC/gPLe1VRgb9IsCo9OaBYT9K7Qa2lNwhZ75Y2duW9fuXhSeMrw==
X-Received: by 2002:a17:902:db0f:b0:21a:5501:938 with SMTP id
 d9443c01a7336-21a8400ae3fmr419967255ad.52.1736905431749; 
 Tue, 14 Jan 2025 17:43:51 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10ddbesm73634675ad.2.2025.01.14.17.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:43:51 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 zhang971090220@gmail.com
Cc: JJLIU0@nuvoton.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 0/1] net: designware: Add bitbang feature for designware
 driver
Date: Wed, 15 Jan 2025 09:42:10 +0800
Message-Id: <20250115014211.2599328-1-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Jan 2025 03:09:20 +0100
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

Changes for v3:
	- Support multiple buses for multiple Ethernet interfaces.

Changes for v2:
	- add bitbang delay dts read
	- modify printf to debug


Michael Chang (1):
  net: designware: Add bitbang feature for designware driver

 arch/arm/dts/nuvoton-npcm845-evb.dts |   1 +
 drivers/net/designware.c             | 111 +++++++++++++++++++++++++++
 drivers/net/designware.h             |   6 +-
 3 files changed, 117 insertions(+), 1 deletion(-)

-- 
2.34.1

