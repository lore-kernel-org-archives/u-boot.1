Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5422C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 15:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B4988315;
	Wed, 26 Jun 2024 17:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xw7ZGg1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44964884C3; Wed, 26 Jun 2024 17:15:42 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3A78844C
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 17:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f9b523a15cso5384195ad.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719414938; x=1720019738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OORTs0mj5TMc9oB7rMv0D+xUrQn1N1a1AWAQ7bHl+Vk=;
 b=Xw7ZGg1tjn0Os3l70hhdZigReo7xqDmJO4+FBesaSgxX9sMc+BJq2IX2ykdcjDK30N
 CCILou17HHaTsLAJYXCJ7CqeCvIGdXnppyZqmKtKWd6GDwtS0UGCr4SWoHFeyjIv/m4L
 7rTxfcM6pzKqcQwQC/Rbh8wbfOTjwMTcCziOAhqVdt8y4YzivsvxbW0Q0W1/NpMThR9p
 XcUbrDJOOvWhT/54fQtpOLwEi2pqKP9PXtIJBs56psyk8ne5uJKsYbAPqWkueLVkoVb2
 ObYPnuMFfAhsJi8miey6Ei1+7zrW+GAg74cWXASk8WRTIiCckv0OXuMHfjiB22oyeX48
 8sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719414938; x=1720019738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OORTs0mj5TMc9oB7rMv0D+xUrQn1N1a1AWAQ7bHl+Vk=;
 b=KFy05mA5l8Qy11IpJgPz4/lg3ZY5eAboQej4/Waz6Rc8pIfkalSbtJatR7Dsqrq8mS
 7Nfc2Of/kOcQbx4K7lBQIZmi6MY60Y3A2ltq05Gz71O6Zqzi0Hl832TCDpsWYEKPb/sm
 EfZYEzchB4YD+HJksjatufM4c5yxM7gY39Fe4+qZgF2Kj4y27GA+Yp73bkl9+tnR9c8m
 yFgR4JnnVFoTHX9knkqlIPCroO9PgLAV+RD3ObhhGRtML/EcKrcAkeqFBD5m0/iVsAir
 JRJSdPluYRTIVDXBDoxtV0nYkhykBayMYbnV0kTBAbOuX1hM/CPde5Sek6OO0l4PChxJ
 xlag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOz/EBv/e8apEkJdq15tmd3bEISw1EeCYNX1DjNFrXvEO4FfJB/0YpguDSVYA9vF5suzq9IZTXVXQhhkrEfnXnsHqn8A==
X-Gm-Message-State: AOJu0YyvY7X53Hdl2oKPgnkCxKoh9MvAu3WA43X39yp91jFOP0UnNDgs
 3eAFxBZMx6zPxJln3m6DSRBFd8GgPCxDPA0Pp3Ze+iXcbSwYrlrewma+eg==
X-Google-Smtp-Source: AGHT+IFQZsskeHXv7EAXnEfEgl54rUVbSQVjF+LFjbBGGwF1xNRSBuPz77vSz6fNeaxhX7cbkshPiw==
X-Received: by 2002:a17:902:c411:b0:1f9:d6bf:a67c with SMTP id
 d9443c01a7336-1fa5e63f89emr107014035ad.5.1719414938282; 
 Wed, 26 Jun 2024 08:15:38 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fa060eeee9sm85536795ad.280.2024.06.26.08.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 08:15:38 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 --Minkyu Kang <mk7.kang@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/2] odroid: Fix target platform compilation issue on
 Odroid-XU3
Date: Wed, 26 Jun 2024 20:45:22 +0530
Message-ID: <20240626151522.83561-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626151522.83561-1-linux.amoon@gmail.com>
References: <20240626151522.83561-1-linux.amoon@gmail.com>
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

Resolved a compilation issue where the build system attempted
to compile for the Odroid-XU3 platform instead of the specified
Exynos4412 platform due to an incorrect CONFIG_SYS_BOARD setting.
Updated the Makefile to ensure that compilation only occurs for
the Odroid-XU3 specified target platform.

Now, object files will be generated only when building for the
TARGET_ODROID platform.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested om Odroid-U3 and Odroid-XU4.
---
 board/samsung/odroid/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/samsung/odroid/Makefile b/board/samsung/odroid/Makefile
index 5bf48313de..615c99f501 100644
--- a/board/samsung/odroid/Makefile
+++ b/board/samsung/odroid/Makefile
@@ -3,4 +3,4 @@
 # Copyright (c) 2014 Samsung Electronics Co., Ltd. All rights reserved.
 # Przemyslaw Marczak <p.marczak@samsung.com>
 
-obj-y	:= odroid.o
+obj-$(CONFIG_TARGET_ODROID)	:= odroid.o
-- 
2.44.0

