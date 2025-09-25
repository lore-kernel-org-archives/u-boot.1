Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51524CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE6D835D8;
	Thu, 25 Sep 2025 22:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s7DRJxrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 541B3833ED; Thu, 25 Sep 2025 22:56:21 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4206D833ED
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7a76561c291so417871a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833778; x=1759438578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/fqgJIf71LxwC09gy89JDWHJgJxmBhhAEDL55BS5g64=;
 b=s7DRJxrBgG08HfcL91td2UWA9bdTDuuKUTqviakyn2Z41zq8gBlKn0c911Wl08CDoU
 H3QA+HYfij0emM+LiVBnIqI/ONNyOLHZEAgDg+FwfXNQ/2X77I78YUFHZzVM2lLv0/4s
 XV/am88NLsoDCaeEr1lJ8LQ5SWiG0VkrH4ozs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833778; x=1759438578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/fqgJIf71LxwC09gy89JDWHJgJxmBhhAEDL55BS5g64=;
 b=p5cMmQEifJYbQvOqqFWEpW19qb2I+XY72/wk4JUKTZdGmzRsy9f9NIuKxr/aVJvpeO
 gVvBBTiY0fJ0s71XF0TxiCiS+uv78hobw9l/zg/3+B3wIdNsgOT34o5FEfqq6Rtj7Dtx
 HI9k6qYnCNF7aiKRNkormt+mFf2qf+vbKx6VX1/FV5fSwhrblr68UG2Sy/K6pcEMFyvA
 MKfq4VfLkBoTFu4d3RW6+EAxW9w74AW/HnkXivdzwHXXNVjj5d9CLRRsf8ATnBz3r/6G
 vSI0f57qs7qpq+eCqptcJrgMEhBORgQ/lGO81ZwfqF43IefvJ/vuRWCzAdmMw59zMbwR
 qWwA==
X-Gm-Message-State: AOJu0Yw6nnqpMXCMsWoy3MAfWwXpHZfVmDr/ssoeJVguf0HWHLWz2zCo
 +9/Sr+VdcUndIqozHQNCMmVJ5cN15tWdORUcYUS8YZKcMVS6vybZB9Un34VDEZkOwJjXr8Gu4ZB
 Z5Oe8L0s=
X-Gm-Gg: ASbGnctsHDfaohLZth3umWyf85pIW6ZVGmsM6vczm3KwgpecQHs1pOARSF/YDUMquMq
 DFd+36VGtPgx45mE/5ClP2C3ADGth2qyp8dxl3gydXn+vPTOUWbAtDm9tqvP+5+ch58Yrs/+lMm
 sXTUYV4kWaaD5bHgsYC06kZYgxy4E64aFLhrc8AK+DvPI9uXbJgLBo4tt2E31gl2ojYE2+3MNNM
 DAOLa9V1enJ27gFcGTfRbATxCaWS2qHNvY4Jf6rDWoKEvz8AOn0KxwUImeUJWc1tKUkr6gqLWUQ
 GbHxZFvqZ+X9SdoGPkdf0yUUtCvDNhMjw3m30TN237r49r9gdxaoIfx/dbhIaFo44ZTJVjSuyqn
 Lnsm3zxu3fDA6I8DvEtNCmNcMkWvGOCR5m/g4rOJzCa66THBCY72+GRlnFsU=
X-Google-Smtp-Source: AGHT+IHNppDwOSNrwY9jp4H+5I4Rttnhx24Qy3PZxKZ7JWzKAni5qvTkHdZHbyK/yhBvlw2yAWOzXA==
X-Received: by 2002:a05:6830:3c87:b0:758:ebf:fb35 with SMTP id
 46e09a7af769-7a03a9d10cdmr3050687a34.4.1758833778046; 
 Thu, 25 Sep 2025 13:56:18 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a2422794c0sm604323a34.41.2025.09.25.13.56.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:56:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] rtc: Make U_BOOT_DRIVER entries unique
Date: Thu, 25 Sep 2025 14:56:16 -0600
Message-ID: <20250925205616.3562560-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

All instances of the U_BOOT_DRIVER must use a unique name or they will
lead to link time failures due to name space conflicts when both are
present. In this case the driver was reusing the max313xx name.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/rtc/ds1672.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/ds1672.c b/drivers/rtc/ds1672.c
index 4705e5abc932..651b1dc950fc 100644
--- a/drivers/rtc/ds1672.c
+++ b/drivers/rtc/ds1672.c
@@ -108,7 +108,7 @@ static const struct udevice_id ds1672_of_id[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(rtc_max313xx) = {
+U_BOOT_DRIVER(rtc_ds1672) = {
 	.name	= "rtc-ds1672",
 	.id     = UCLASS_RTC,
 	.probe  = ds1672_probe,
-- 
2.43.0

