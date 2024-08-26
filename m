Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C93C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01CB88B1F;
	Mon, 26 Aug 2024 20:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jj4T3/IB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C996889D4; Mon, 26 Aug 2024 20:05:06 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD8E888F0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-715abede256so918064b3a.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724695503; x=1725300303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jj7U/Uot6r+6ymS5HcpOzDbqzK/XGSFvlksSinMAU3Q=;
 b=Jj4T3/IBnbtDgKhCOyx8jYDX3kkbrY2RfXUIDgOEG0jh+LS294946shhD7H0MDUArI
 MNp19foE8aocZDiWyPn2TM8E0DodGeFhncmjyK5fkMqlgz2QkESuYQ7vhnuuAJmcRK8W
 062chC1TQqGsgZpSuXogNtLQ5budi9woZ8XTz/SfAbYi0p9aJhHBBvqaYWXUZbsCUGgM
 x5RTIbS7aTMywqzNaxeuJdO/cOiIXCF8qzR7k8btounBb5kD7lUZ/m3H9doG6eY9HRb7
 F2ev3M5LUhcqavhi9NDFO78ZjkfESXtWlO0Fs3Lh4Mh85MuYJEXRasw0zolKBgjnCu26
 JWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724695503; x=1725300303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jj7U/Uot6r+6ymS5HcpOzDbqzK/XGSFvlksSinMAU3Q=;
 b=Mn2rUhsBGReHBphaSdf/D4i+hYzS7N65suZAFe+N1p2hhlmv8qJoj/SwoK+2/Gbh2V
 xL2eR05bsCoMKurDh0O5y/5WJirZlA+ENsRYLKGyiesKLsvuAPsN8UfSFnCxhUg+nb16
 6G/m8xPME0LMLeAab2m1BZuR65rZXkfKOeJ1Npz6kdEn8UxyPlObxfq6WpKeCV/+qegE
 wzEOODDwOaequtMlAIZWs20CvmvulzNbtl/t65vXnPcPXKQFlfDpgGvoBR6YVFlwKrid
 mLio9sS0vR8/d557SDokZSNk4hggFc5J6iLxBSvcffHxFvfOH3MW6doQkUKsvvfB4NHp
 Ru6Q==
X-Gm-Message-State: AOJu0YzAdXPDSSLN7KGtno89zXeT/ZWxLHhcWnd00JY6dEDqFQt1mduW
 rknojHi1CEj58CWOw+hdgfaeLMpopuqy+PYakakyVNtUigChjojw
X-Google-Smtp-Source: AGHT+IFdMq1ltHtKxxA62c204oC5TXbojvjZEPSnABIB+Vohv5iVYT9hsE8i3aqyyGVlDLVlMBQn/A==
X-Received: by 2002:a05:6a21:9101:b0:1c6:a66e:1dea with SMTP id
 adf61e73a8af0-1cc8b514738mr9692134637.32.1724695502830; 
 Mon, 26 Aug 2024 11:05:02 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc67:f2c3:ca16:906f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422eaabsm7544947b3a.12.2024.08.26.11.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 11:05:02 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/4] mx6slevk: Convert to watchdog driver model
Date: Mon, 26 Aug 2024 15:04:51 -0300
Message-Id: <20240826180454.2778016-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/mx6slevk_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/mx6slevk_defconfig b/configs/mx6slevk_defconfig
index 9beb045d7df3..a9d7435c0e89 100644
--- a/configs/mx6slevk_defconfig
+++ b/configs/mx6slevk_defconfig
@@ -63,9 +63,13 @@ CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MXC_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_SYSRESET_WATCHDOG_AUTO=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

