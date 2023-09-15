Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1E1CD37B2
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 03:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD9B864F0;
	Sat, 16 Sep 2023 05:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F2Qhtdjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19C5864A2; Fri, 15 Sep 2023 20:15:00 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DDDE864EC
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 20:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.linux@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-577a98f78b2so1785993a12.3
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694801696; x=1695406496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mnMmxIQ4jgOSOgdvur1npm/sr86+uGjczwIjVYdbWdE=;
 b=F2QhtdjtUfQAUrhhbLy6iJjHQehVhB+5C+dal0SB/yWVaCwR/Ok/YMZcJ1BF5j4EEI
 0mIh85NZVNCuGpLvOxC3E4oYpaTs9pD2xugwpeB4BAGEfHJIEdokIwkQ6kmLHN7dwNsc
 oRFAdDxXPWbaVKWjHhrVpdTpa1SwkiZqZGQbcQ5YSFhsZB5MxZs/Cdxa+jfgN0rH/+gg
 EA4XXQyU0SrwI0770y+0AqQSFyndy6OsoD9Fv+LNOqOsfclzWwW416Wx3IPo685jPxOD
 Y624I+HsvJbnMnYqb5wz+nYWRFvc0NEXeXoTd30uu1cqMSUBShcvuQm2XztBrStZNXos
 /Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694801696; x=1695406496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mnMmxIQ4jgOSOgdvur1npm/sr86+uGjczwIjVYdbWdE=;
 b=sxON2E2vo79TGZmSc7usligcbTIjWyK6wFJLmlfkTqj9ea3T1pC4/Bp9HSFYwHknDR
 J+GKuDngX36aoTwgQhvrq3F4k++EhhoEPBl59IAPvmoI7CtHy7woKVdiXQwauFPgHfr4
 DgjEPj92qq1bBqDxdKlIqg13255MA+ADgOaTZ5/UzhzWKZMQYmCe2mib5LLHGCAFNv2B
 yqJeLIXSJDxmy/vTbwh7HQqUzGpoWaXij+xuHONWfkubQkzaq7Q9EKHaKtoM59zaefxj
 R5oUATW9UXQSyyX3wNb6tna13cmmlnHnnr7mfvkfsklCPeKh/fWl+8YpzBhwAbIDfQlg
 ALkA==
X-Gm-Message-State: AOJu0YylCHXWB0xI2zi9vkiksFFQzzeVrIbzZ/NSffdCbxQG5YqsxMgO
 G1FC8h5VS06KhgOB0fTWU7xBzn1Nb7Se1HAg
X-Google-Smtp-Source: AGHT+IGXlIiYnElodrVIe/3EAeeMCNEi2t8qgVRs61FUpDNIxy5SgpW9GyNbWCqBlrpDTyjD78Ml9g==
X-Received: by 2002:a17:90a:7066:b0:269:3cdb:4edf with SMTP id
 f93-20020a17090a706600b002693cdb4edfmr2219645pjk.16.1694801695914; 
 Fri, 15 Sep 2023 11:14:55 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1c60:c4b6:7c40:e65a:7139:4b63])
 by smtp.gmail.com with ESMTPSA id
 f93-20020a17090a706600b0026fa1931f66sm3569432pjk.9.2023.09.15.11.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 11:14:55 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.linux@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.linux@gmail.com,
 marex@denx.de, n-francis@ti.com
Subject: [PATCH] MAINTAINERS: ufs: Change Bhupesh's email address
Date: Fri, 15 Sep 2023 23:44:41 +0530
Message-Id: <20230915181442.3403172-1-bhupesh.linux@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 16 Sep 2023 05:32:51 +0200
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

Set my current personal email in the MAINTAINERS file.

Signed-off-by: Bhupesh Sharma <bhupesh.linux@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 536df4a896..b1f5ae0591 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1597,7 +1597,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
 UFS
-M:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
+M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
 S:	Maintained
 F:	drivers/ufs/
-- 
2.38.1

