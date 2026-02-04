Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12D2E9D40F
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 16:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7CC83015;
	Wed,  4 Feb 2026 17:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J7ycjnwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46948341A; Wed,  4 Feb 2026 17:32:17 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C88548063E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 17:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8c711959442so94697485a.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770222734; x=1770827534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oic5PCQHbS5sFWDrawcBRYcD3vInAjhdv8UKqW+RjL8=;
 b=J7ycjnwBDxuHl74ijL+yddT06rzEP85aFkfS/3cZJ9k7qrBv2bwp1dpZo7iAleQCpg
 4PyySYY1g8RIeimXtJoaHIR8EaSSo9nLD7DSf7NMsmm7S62DTqlxvfiM99OQppLrqgUX
 cpkCnS/lqNj/Xi3eoyzk/IU0FyV3j+a2w/6BbaxQafcyHV6BCVdy7FY1p48kmrnDfhVv
 xJuHES4Y+cWgQmnU0+i5DJ0LsGjs1ovk6+474iKZ+ayM+n69ACekSdSxrU+D3+xU0rZv
 O7kEgJaGQXMpXH5a/UlZtxDduy/b/UK6VaDHy/jInpcg/SQoWUad10DV5aEHzhjQNSNc
 nyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770222734; x=1770827534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oic5PCQHbS5sFWDrawcBRYcD3vInAjhdv8UKqW+RjL8=;
 b=TGHAe7UbMr6W4JS5GaALcALfsmlPZCMb7RaHJ0aF+BXJdCFOYF1JLsm5EAoh2fvdAY
 v91hReakr6rliWu1tZSXxkBgTHhyYe/zhk979OOhXzOMemiWHwUIKBewb+b2Kcsc2dJa
 t/iaIXTsj4FuLH+PkrQJj2i01AXdH18B8yS9z1EA7BmoQXLPmBtRT/cvM3kynD6/ptX/
 /2Xkbdk1/9rk1CvEpzyDR1+LiHQeDasQzthjM2IYz852PdDRyth/0w5ifOmETJpoAvR+
 kNLGsBlFjJfc20O++MKCYZUUYdUSnM73K6XqwlQ2CmDEqpDleINLQHxdBiqTt7IMnDgi
 HSXg==
X-Gm-Message-State: AOJu0YxZkvtf4/BfRslnLkHqOG+DZd2LwYeFi2QcTxDCBCCMaeKVj5ch
 y6MJoaxQqEu9qXC+W/TB9gH4f4O6RZZKFEfcA1Pxo4oa4xWHLYDWrvb+64TXfg==
X-Gm-Gg: AZuq6aIWcRdWC23hftb51+uplGfsZJTxInEwP1D27NBJL5ag5DQTAnathK2e4KGIG6U
 dbbi0Pv1iTA2pVadzy66Omo996yYv14LG4KNMMctsm+dxAp3cRlqEe50fD4ErTCiRe5fcmO54jC
 rIl49Yyc8Mm1WO+8xCFX8y/F/JmS2+ckfmf0upA4B+w7YmXhdlywneIEfQQngh1x7IjHxbQC4XQ
 WA1NUgwPopDtAwDhlhX9OwMV+6X1RU5pbWUY50g70gJnvdfqUX0dh5rtTvmfUWpcrZGvpVo7bHy
 3+pSoDgfXBt19PPdcHSASEVTjTIxO4XEk67qRqcBgVLtGWX/ynLLOeQRS2ZDBWfpht+B8ZER36a
 yHWAEj7Eker/HZIlLI1MY7qJfg5YblTAP2kseYlxZRKQx9kcsKMXII2jWcpqQvu/5THa3DfGl5X
 Hp/tbP5Q0uQKwHyk4H6do1cd6sdeugoqAmxXDpartWMtMDEZueG1GoRQMe2kafJEjERgXIgws=
X-Received: by 2002:a05:620a:1983:b0:8b2:e1b5:a4d5 with SMTP id
 af79cd13be357-8ca401cd551mr2028785a.16.1770222734260; 
 Wed, 04 Feb 2026 08:32:14 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ca2fa80c71sm213746985a.12.2026.02.04.08.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:32:13 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH] MAINTAINERS: Add entry for SMBIOS
Date: Wed,  4 Feb 2026 11:31:40 -0500
Message-Id: <20260204163141.2228295-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add entry for SMBIOS in MAINTAINERS and assign myself as maintainer.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87d2e267dd9..288b892f19b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1732,6 +1732,15 @@ F:	cmd/sm3sum.c
 F:	include/u-boot/sm3.h
 F:	lib/sm3.c
 
+SMBIOS
+M:	Raymond Mao <raymondmaoca@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/smbios_generic.dtsi
+F:	cmd/smbios.c
+F:	drivers/sysinfo/smbios.c
+F:	include/smbios*
+F:	lib/smbios.c
+
 SMCCC TRNG
 M:	Etienne Carriere <etienne.carriere@linaro.org>
 S:	Maintained
-- 
2.25.1

