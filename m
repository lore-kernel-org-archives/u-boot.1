Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03D5C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0DF864C7;
	Wed, 23 Aug 2023 19:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GmobYlRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5328864C7; Wed, 23 Aug 2023 19:26:51 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BDB8645E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1a2dd615ddcso1036515fac.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692811608; x=1693416408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxeOjGTClngPveVaFX9Z++B47YlexX04q7ofHyMprkk=;
 b=GmobYlRn7P8he/TmmlXFg68ikOkEqwP7TrtkdKnnh2UbSidCMNQ5wVHnG57ijFRUl3
 6/ou0CNp9trAvMudAC/nP0xNmDTa9WZFtR18FiNqUm5RbqrDkrvjvsd4jihK7/yvcBPK
 ZzPtHszQMmKy0z3GCuSa7Fk9tcUrRpbFViNo8tglws1vVTJvfnRWt0FlA1h3XwHSXRe2
 i4Obe61cQvmr+/CViEQKYteNesoIbfdN12rH5mJoyuQ6VDKBL8gqjX/086mtJKcKvxnN
 AffLkCif3480LmjRK/7MXroyud5fA3dVA0ZOBDMSp+CE7D2gftdZ7z16SO7vyGjbJnab
 JXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692811608; x=1693416408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxeOjGTClngPveVaFX9Z++B47YlexX04q7ofHyMprkk=;
 b=Ugsqxd5YK/K9/U3pJHhTs64lV0L6jCPQjmU8cw8kSxLVkft07tL53MrKc2L4lcnjAs
 wT5n2yWDqmds1IOXUequbBwFG67E0bXXJbHrrtTzM5N3juYbC05mWz+anQQ1hMbukVPk
 UOhx/TWIinxx41Y2sb1A/yCBlvS2yHG57I3KCRofjD9zhizHvNGcgZM3boaxNqlryH6a
 Erfi/gqAIYl+K+AkWJ0cxEbIluofvVKQQbvTGNNUyaENPm0JBdYCG5jioSd+mv6bjDjF
 TSqag0jDYZmyWe9Jh9kZfBEkVaD73RYPCMOqdMIBEW9I48K1SHYxeV6FugvPiONCzRb1
 Loxw==
X-Gm-Message-State: AOJu0YxmEFGVJfkZcNe+AVB/NfyRbLsAemAoFnVEpySveNYIFPKIOnSF
 OumewtnojT1NJG8wa7yCusyOn7F0MtQ=
X-Google-Smtp-Source: AGHT+IFEpwF6S1CCgPh462EQrmDJMD0iRIvIXS1MMR6ykjWk2fTS2c7zMhxLKQwdZ6Pz4NZPg9ZaUA==
X-Received: by 2002:a05:6870:d10f:b0:1be:ec3c:1ef with SMTP id
 e15-20020a056870d10f00b001beec3c01efmr14703469oac.0.1692811607806; 
 Wed, 23 Aug 2023 10:26:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ae60:b44a:59b3:894f])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a056870734700b001c0e840ebcfsm7158926oal.35.2023.08.23.10.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:26:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/5] thermal: imx_tmu: Fix the polling default
Date: Wed, 23 Aug 2023 14:26:34 -0300
Message-Id: <20230823172637.303101-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823172637.303101-1-festevam@gmail.com>
References: <20230823172637.303101-1-festevam@gmail.com>
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

When the 'polling-delay' property is not passed via devicetree,
pdata->polling_delay keeps at 0. This causes the imx_tmu driver to get
stuck inside the busy while() loop when the CPU temperature is above
the alert point.

Fix this problem by passing a one second polling interval, which provides
a proper delay to let the system to cool down and exit the while() loop
when the temperature is below the alert point.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/thermal/imx_tmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index 97efc55044..d9a04eaf79 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -37,6 +37,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define TER_ADC_PD		0x40000000
 #define TER_ALPF		0x3
 
+#define IMX_TMU_POLLING_DELAY_MS	1000
 /*
  * i.MX TMU Registers
  */
@@ -574,6 +575,8 @@ static int imx_tmu_parse_fdt(struct udevice *dev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
+	pdata->polling_delay = IMX_TMU_POLLING_DELAY_MS;
+
 	if (pdata->zone_node) {
 		pdata->regs = (union tmu_regs *)dev_read_addr_ptr(dev);
 
@@ -602,7 +605,8 @@ static int imx_tmu_parse_fdt(struct udevice *dev)
 
 	dev_dbg(dev, "args.args_count %d, id %d\n", args.args_count, pdata->id);
 
-	pdata->polling_delay = dev_read_u32_default(dev, "polling-delay", 1000);
+	pdata->polling_delay = dev_read_u32_default(dev, "polling-delay",
+						    IMX_TMU_POLLING_DELAY_MS);
 
 	trips_np = ofnode_path("/thermal-zones/cpu-thermal/trips");
 	ofnode_for_each_subnode(trips_np, trips_np) {
-- 
2.34.1

