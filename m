Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAF2CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D27286E77;
	Thu, 12 Oct 2023 04:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SzU/9j+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23B786E65; Thu, 12 Oct 2023 03:59:36 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52E086E71
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d0169cf43so2658826d6.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075805; x=1697680605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTIipH2Q6nQ48JP/D7WlUdjJsrJiVUyUJaHpADXhjtU=;
 b=SzU/9j+9oIuRDtxEj7BpDbB1mRBSYZHgj/0M3OtEyXhipva2dikiIrfBUIHVZt8Eax
 R40nieW5unCY895fTctfqRTELHc1ln6ysRfDD7Wd6A8o4PCx3eFLm0+7MzxGH/Ye+5Jd
 JTCH0zTbX0jwbBD7fSTXoxIRM1PePetfYWT1VfBq9PgLpfKEQDAUH9+wfwwr+6+RdRuI
 1Dzz8lwheszWeNrmxkKewk0C8+ESnU8oimwZNRTrS1SgxYxydMPJWTB6USc0//eKYooW
 20tk2k5xfX75Hfr5boKZhJ7kb76L4YnsLmSr7o/vIghLjMq9DDDz3GAuccMhbsVyNo/U
 Zo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075805; x=1697680605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTIipH2Q6nQ48JP/D7WlUdjJsrJiVUyUJaHpADXhjtU=;
 b=wKi+uzWNEk5XYHuD2c/wEQ9MFsC8rVhizxGSlAqRrC5Yk4JcU9VBEUJWOre4eu94vN
 /EMBs32CpjrgkuZU7nLUgs/67L1BD0QEs/xdvenzhOwlJ6bRStXzgTLn/aaYHlYJM/9m
 tsuVvvRir3N++a+BSJpfM6FW7CmksRZPHKLvOBxG8DW9TlRQjh6Bf63R93cQn+HwjIdi
 Jo+B0v98UBmsBqv9SfDC1lOiD9qZYUK8BjExW5WERUQgmofKPTUmylBWXHXTZ2eaJIy2
 k0xGv9apDv+T+WbPskJAh2qrIZmDSbjEKm88/e9jBvo88Win0wlP0i65kp4piphgEiwi
 EWEA==
X-Gm-Message-State: AOJu0Yx0GlsIaj2mMq2iRTjG9oT+sjhhyA3hWdA36lsItDODGzckblvr
 UmGhYZ0oDRWjLvNj+lBUadcoEiWvzDiJfA==
X-Google-Smtp-Source: AGHT+IHNV3kbc8+rC179TMTGzRuYv0p17TASxYVFOQKlA06tgudZijUAWS/DId0u4MblHVZ815NGhQ==
X-Received: by 2002:a05:6214:c8d:b0:66d:12cd:7136 with SMTP id
 r13-20020a0562140c8d00b0066d12cd7136mr1130200qvr.2.1697075805304; 
 Wed, 11 Oct 2023 18:56:45 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 e30-20020a0caa5e000000b0065b1b5cd70csm6239149qvb.31.2023.10.11.18.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:45 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 14/26] net: bootp: Move port numbers to header
Date: Wed, 11 Oct 2023 21:56:14 -0400
Message-Id: <20231012015626.3487451-15-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

These defines are useful when testing bootp.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 net/bootp.c | 3 ---
 net/bootp.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index 8b1a4ae2ef8..2053cce88c6 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -41,9 +41,6 @@
  */
 #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
 
-#define PORT_BOOTPS	67		/* BOOTP server UDP port */
-#define PORT_BOOTPC	68		/* BOOTP client UDP port */
-
 #ifndef CFG_DHCP_MIN_EXT_LEN		/* minimal length of extension list */
 #define CFG_DHCP_MIN_EXT_LEN 64
 #endif
diff --git a/net/bootp.h b/net/bootp.h
index 567340ec5d4..4e32b19d424 100644
--- a/net/bootp.h
+++ b/net/bootp.h
@@ -15,6 +15,9 @@
 
 /**********************************************************************/
 
+#define PORT_BOOTPS	67		/* BOOTP server UDP port */
+#define PORT_BOOTPC	68		/* BOOTP client UDP port */
+
 /*
  *	BOOTP header.
  */
-- 
2.37.1

