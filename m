Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E90C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505A3803B5;
	Mon, 10 Feb 2025 12:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kaRO9+ZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAA4807B1; Mon, 10 Feb 2025 12:18:46 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BDB801F5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8DB1C3F175
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739186321;
 bh=rr1NH4g/HDsZAPaZgwRkoA+v+jzmLdnW3WHdJhoc9mw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=kaRO9+ZM3hwnoBKF6sNte1eTpYcDQb2B4VmrFHHingNIqMa91BJ1OiJzNxPRWLcsU
 qV61Je8R41melKHk+44scZlSn6A9YpcMz/Q3eOdVdpqNWUTg1AS6YeLpxR+P7mmJW5
 bfatJaxIARDMNLyd58CrUC7H8Mod04Rj8hzTGqeGTPW/3nD6Gt6DX7pFz6nC/4HthF
 noO1Ttl53r2kb0GR6MhJKGW9bsOdeietHcnn+FAXIAiG5WZPJXFmrMOvQPEsuA7F05
 +dA0iFyfLb/FEG5lf/8F75P5olTphYDgWGgqOkrqAHlskUDiXc6Ic3U8hyRwUT6pof
 5AAk1YZK4Cq3A==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dc709f938so1488175f8f.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 03:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739186321; x=1739791121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rr1NH4g/HDsZAPaZgwRkoA+v+jzmLdnW3WHdJhoc9mw=;
 b=QqgEjIKS7RFMMghkS8lgPc38ju4pnX7+VC9B3DnGTFhdO+qkVUQMOx1fKyvMKCiunD
 t+F98U7FRYUrTtcHk18WAK2zdP9hJaDiWIHV+joBLd5I50xQVF7L0JP9pQpKdvThtUob
 HMoJ/MQb4ASXzfyzEsDy7CGzPnvHsKnevqa4rN/xpvzYcB5CZET5iFS+WIF46uIYwf5W
 qyvv2NoX0mRtIaKYguvUyQtXfLHbtglA1ay+5Hg5paPfIE4KqthCk2w5FUORAhwYei7S
 VuRR0pfupBq1SjQQ9cXN0Rs8mb0K1T6IuADNusL9QWVXEcAjEm6fa16Ves+X5yAIbTQV
 ytoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdRropaHQ0KpmHQQapTSSV3/9YoVOgEudtrAGejY5QPfEX3Z64VDUVb3p/w/HMfxwvGm9Oov8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz30ZVTmIFPQqY3eb4rHdk/f073IZ3mRrG4fl3MTCHw3A0rNytC
 dpbU6CabMaQqCMwU/BVuFogL9otUGrUjXEUY+u5NutUDCZhuO4Uq7AXAOda+cWPwwcvfS/e3sjV
 jW9lwMxoei/FQuxsFRdiYCPrmN6kSqT06X/P7HoaBd67qjlkd4Gnf9NXiVxlpOb+a8j0=
X-Gm-Gg: ASbGnctWQy/To2+PRtdis50GD+u7KAtltFQFzliqXamG8+cu2d7tLqF8FdYnnrVtySG
 1lI+Q6x/5dGJatnmLxHvzk2BH3U3YH82b3Sa94fK4Yiat9fky2Rrlqkwr/lRWclEsl0WCUhlyYd
 5DgCUhyUk9+NQEQZC2oPYahftY2XlECY4rETSGk3wIzfvjFQ5YtE6sW48npevlbJgbCEPYDQYXS
 UMIdw9ruzzekhjqnQrqNz6FqtYhn3c4m5tk3UgAXYdTmiHtAGFPdkNmBL3O9+FcIOe64U/Zp2ps
 p/7GKUJm4Co3iVIR/S1Y527lWageKhyaClUQ6iLEB8JzPL5nallPeK2DWhAazNcrxZhGrPMIg2L
 wCFomKHs=
X-Received: by 2002:a5d:6da7:0:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38dc99a0a44mr8106345f8f.18.1739186320863; 
 Mon, 10 Feb 2025 03:18:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7v/fbYhSQxef+3eNRufpvJVip4hPVgQIVjRUWMlJpuPZnE3/X0emSeXWAFpPQNz5Z7W4WvA==
X-Received: by 2002:a5d:6da7:0:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38dc99a0a44mr8106325f8f.18.1739186320532; 
 Mon, 10 Feb 2025 03:18:40 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dda26c6f5sm4194243f8f.68.2025.02.10.03.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 03:18:40 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] riscv: dts: starfive: simplify binman config
Date: Mon, 10 Feb 2025 12:18:26 +0100
Message-ID: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

All StarFive JH7110 are supported via starfive_visionfive2_defconfig.
Up to now we have explicitly specified the multi-device-tree FIT
configuration. This more complicated than needed.

Binman can use the information from CONFIG_OF_LIST to automatically
generated a FIT image containing the necessary device-trees and
configurations.

This also removes the non-functional default configuration without a
device-tree that binman added up to now.

Before the patch set booting on an unsupported device would fail in main
U-Boot due to the lack of a device-tree in the default configuration.

With this patch set booting will fail in SPL because there is no
default configuration.

v2:
	do not use a default configuration

Heinrich Schuchardt (4):
  riscv: dts: add OF_LIST handling to binman.dtsi
  board: starfive: spl: strip off 'starfive/' prefix
  riscv: dts: starfive: remove duplicate itb entries
  riscv: dts: starfive: don't use a default configuration

 arch/riscv/dts/binman.dtsi                    |  7 +-
 .../dts/starfive-visionfive2-binman.dtsi      | 75 ++-----------------
 board/starfive/visionfive2/spl.c              |  4 +
 3 files changed, 14 insertions(+), 72 deletions(-)

-- 
2.47.1

