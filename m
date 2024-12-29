Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C075E7718B
	for <u-boot@archiver.kernel.org>; Sun, 29 Dec 2024 14:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B31804E7;
	Sun, 29 Dec 2024 15:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XVXqGLTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE82804FA; Sun, 29 Dec 2024 15:46:13 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1137C804CE
 for <u-boot@lists.denx.de>; Sun, 29 Dec 2024 15:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so4686661f8f.0
 for <u-boot@lists.denx.de>; Sun, 29 Dec 2024 06:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735483570; x=1736088370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JF8+fQW1RCYXPxdPB6NJ4FigNGgMPXECfdwHuShGfGY=;
 b=XVXqGLTfRDpaVi5q6DBffAHKK9yQWrjI8D6JWTW91XVs8atsJkoKnjpWt0ejtYePGY
 iWM5IvMlnC60GUbFSV8Z3yt8ewgdEXrqZeyYELW0XETYIEkdHFqAASRlCiJu30hrrYin
 NqW2z6x9h67UppEf3lmSKDeXMekfspMW0ofIGB+bI7iTRqLOk7QWtIf830mIKFzWv3eL
 JLCV6gS9w7yGkl67MhG4NmLhOcIBDXGyMq9tcbDMAIgNVULmFykUZluBG7l4XpqBL7Ej
 1O7OVL5loOF6qAlYOMIvyTN/cEHg+T8UTVgwbF/xQdftnxMMxxOsmmLvGYL6xAQQ+VRb
 gu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735483570; x=1736088370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JF8+fQW1RCYXPxdPB6NJ4FigNGgMPXECfdwHuShGfGY=;
 b=Jt4TKqFsbJboc30ezl4DDGfxrYeV+qrq8NkL1+utTYrBsBTSvl7JlT2Sw1wgM/5Wga
 gOjsrpKlNSuH2JmOCdqfKhtfwriuvQarO93sqeDqvZwv/h3iGosetCAPbmhd9Q/gXO/7
 kqXoH1WfDEzjYxNmGL8RInRVIoaJ0bvfR/K79UgNCT2FA7a8bbeuy0mDtVAt9K9z8PYz
 pU5L/OsaNWwyfKTe61rpkLeP1Z7PkLtlzIRxGzaJs0LIK1x6Fv/8OEJETBYLMQqBdaLt
 4+JQsbIy37tTM038DEUSwWAMrL+MKPmSzkzLsURhKYwOKR3Pq0eRl8RbCPV9oIyLNOBq
 qHWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcStNR/t5SacTlXPHm4cy23Yn06Ya9TRJfrh0Vv5/kpLTbkRkmAg13JH1TtT9jVMHGaWjI6G4=@lists.denx.de
X-Gm-Message-State: AOJu0YxlwGQsZTgy0B8Okb/5T+j8kSZg2txtcU1bbPlgV6riBk5dBCqm
 BNUKKp419XY+31dVnaH26IgOwMyZxp4bVSlj0tmkUeEGyxiWXw+Y
X-Gm-Gg: ASbGnctpVbr3XEh8XBMggd+/L89OdTxBB/1kLUDOC8L1Kj6mUMk5Ab1j+klkkqauXeg
 nWXlLdMhGPhRNXrR7GnlheGewHpeNyf+ivCbW4DY30ywnV5t6mcIN5YMeFMLL6y0yLMe6KTSUWU
 +gjiUxC4R6orj/l+Jn8TIOW3zD1vot6I9VK8COytwM3UoN+fCjHnq6rQzKKdztfLk3+2pesK9Q+
 Z3FV+Qz03dWmzI3UP5U48+7k3ocUN5D+QWxJ/RgxDPdKRoiFAtaR4qYuBopObndKc5e5s3N9SVj
 aSBKi966MofrGMrzXOvtdlJGC2w+iJMnQvKbNqJp95yVWwiG9/xfHBWk2lbpoCsLcoh9RB4G9lO
 k
X-Google-Smtp-Source: AGHT+IGv8vYQe8rUmwo/HkPBDteRS9r28sZfeHxo6MhDdkkeZuPpVDncHYh75rQ+UNYwiS4C1Mzv5Q==
X-Received: by 2002:a05:6000:4810:b0:385:e961:6589 with SMTP id
 ffacd0b85a97d-38a221f13ffmr33793547f8f.20.1735483570200; 
 Sun, 29 Dec 2024 06:46:10 -0800 (PST)
Received: from cypher.localdomain
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c66sm369195505e9.5.2024.12.29.06.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2024 06:46:09 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] rpi: Add identifiers for the new RPi 5 series
Date: Sun, 29 Dec 2024 14:46:05 +0000
Message-ID: <20241229144607.1051889-1-pbrobinson@gmail.com>
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

The Raspberry Pi foundation have released the Raspberry
Pi 500, CM5 an CM5 lite devices so add the assoicated
revision identifers so we can detect them.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 18be244aa79..1e43c631898 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -193,6 +193,21 @@ static const struct rpi_model rpi_models_new_scheme[] = {
 		DTB_DIR "bcm2712-rpi-5-b.dtb",
 		true,
 	},
+	[0x18] = {
+		"Compute Module 5",
+		DTB_DIR "bcm2712-rpi-cm5-cm5io.dtb",
+		true,
+	},
+	[0x19] = {
+		"500",
+		DTB_DIR "bcm2712-rpi-500.dtb",
+		true,
+	},
+	[0x1A] = {
+		"Compute Module 5 Lite",
+		DTB_DIR "bcm2712-rpi-cm5l-cm5io.dtb",
+		true,
+	},
 };
 
 static const struct rpi_model rpi_models_old_scheme[] = {
-- 
2.47.1

