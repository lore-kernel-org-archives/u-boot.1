Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344E2C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CAD82045;
	Wed,  2 Apr 2025 00:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZvPbWCmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EFB58205B; Wed,  2 Apr 2025 00:52:51 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD2E8171B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso46419825e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547968; x=1744152768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s6I56aDrJhtZws1wBDSiL2xEFDq2AIxZpJnbMwAxDUc=;
 b=ZvPbWCmoCXvJlsuZLcqKMyxxQDf7KcFLpwPwGM1o3st34YIYJJNLU73z2S8VEAT0sH
 T3GfyageZm6R70SoxCuN9kACddYV/73Ugg4Wqc/DmcoGLuPcq9aiYWRqS0ZkS5Bu/WCU
 YewJVRctEZZZ1eiS1Y2mLJgOQgKY5aH/pk6hYN3SnRt7jIXM5iIy4WW0Kwm7tqpyW9XV
 /w1E3A5aIolVCSZ7Z7i2QQJWUu8LSs9+oGc5BCoemsx/NWWcve/XznbzbrtXN9RBws9B
 RUSF4GYVImdZLIBZDE6U4Gg4Qc/gG3wbRyFxLjkT6kb+jvew66BNB6G37xTzyxWDZ1E+
 74VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547968; x=1744152768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6I56aDrJhtZws1wBDSiL2xEFDq2AIxZpJnbMwAxDUc=;
 b=X7HrdUa+uYYTef0+esxLpBCUEG7pPf3DYNd9ESYv1aKj0GBClZfU8p1TUsSBWrSeiy
 r92hWwCROJ8JMj9OjPHYD+u43VUTDlH+Qmg0dw2kXvVNJF+ufbB1rHUfi58kIG03fgEa
 A22p4lu38tD9jATyitpGpVv2rdEm884NmaDVX2Qytb+h7d047EgJ4yi9kDGLxBaThcRA
 HqXAWABVCJsA5BHCimHKsGyMlinY7AWQrkyyB5gbQH08UDmOuWARkqMShqjamrObw8uo
 3B2ksXO65R0rvr8ka0zHPmGbdcA5a62ZvErGiIoFrYeBs8QoqDkUGV5KAXvT0VzL5oxp
 kkbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZevLiN4yMJ++Yts7hDmR6iWprJvHriruhTW3PyeDUdTkU99GAotnKX143xkuiLXJpY98A0G0=@lists.denx.de
X-Gm-Message-State: AOJu0YyH2KaUEFOmho+7buQLGOQlj3Ks5g59iwrfCZB5SRaHePGn6ffJ
 3Krb4drNB8iO9BkntA53nYQzwr/ItiDWaBU/DhpGPp574uoi1YZ2
X-Gm-Gg: ASbGncvKhQaplohm1MpijxaOVlq8fZrJBkkg/Ka+n3UwBnLAKC27iui0u530G9/kWgW
 xXtspjW62sZ2lA+IG/RNGir4tmd/xfjoc1fcDwyM8sHgJ1vKQaip4Sltvzd3UfaR/ppx+5Aa8Ei
 8W3xKfjg0huaXc+WYyBpjZtE8hmk89gfYPOOyrB3MsGY3A76Z/uBzHLbgKiOQ+gG1ux+jdqw1hd
 v9t+EtKs3JVf8Q3rGcgidKdwVPBSyvBnOCMmCHGm0K0T1N//TS4/h//bO37O6tXEoj7T7EYGs1g
 FyQ7iWZBjjELfoUaV/FraLsVN1ithzhJRvuvinKlQuMmf8EkNnYXPnUecSOB5cRJGvAjnsIWo7g
 EiG1ZZj7sYwjEVg==
X-Google-Smtp-Source: AGHT+IGFlyeVxc7/61E71l/4DWea4BkF7q2VVQa6kb4Gspa99hdHPMBw/P1u8Wo4GzcGFOOcHnSvqw==
X-Received: by 2002:a05:600c:19cf:b0:43c:fded:9654 with SMTP id
 5b1f17b1804b1-43e9dec31c3mr61120045e9.19.1743547967891; 
 Tue, 01 Apr 2025 15:52:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 10/14] spi: Introduce setup_for_spinand()
Date: Wed,  2 Apr 2025 00:51:42 +0200
Message-ID: <20250401225156.25790-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

A common device attached to SPI are SPI NAND and some device might
require to have info on the attached NAND to know the flash page size
and spare size.

To support this, introduce setup_for_spinand() that pass the attached
spinand info from manufacturer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/spi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/spi.h b/include/spi.h
index 6944773b596..28f127feca5 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -10,6 +10,7 @@
 #define _SPI_H_
 
 #include <linux/bitops.h>
+#include <linux/mtd/spinand.h>
 
 /* SPI mode flags */
 #define SPI_CPHA	BIT(0)	/* clock phase (1 = SPI_CLOCK_PHASE_SECOND) */
@@ -537,6 +538,16 @@ struct dm_spi_ops {
 	 */
 	int (*get_mmap)(struct udevice *dev, ulong *map_basep,
 			uint *map_sizep, uint *offsetp);
+
+	/**
+	 * setup_for_spinand() - Setup the SPI for attached SPI NAND
+	 *
+	 * @dev:	The SPI flash slave device
+	 * @spinand_info: The SPI NAND info to configure for
+	 * @return 0 if OK, -ve value on error
+	 */
+	int (*setup_for_spinand)(struct spi_slave *slave,
+				 const struct spinand_info *spinand_info);
 };
 
 struct dm_spi_emul_ops {
-- 
2.48.1

