Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89485EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06EC98083C;
	Mon, 21 Aug 2023 21:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="Srwdb2pq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36EA780805; Mon, 21 Aug 2023 21:33:59 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FA585F9F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so484852266b.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692646435; x=1693251235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uuxufY2klI0UCDH5da/lF6p4GEZsSb2IQBcna2kLdXY=;
 b=Srwdb2pqrqAQHG3+Ui98yVh48ffJCuaneEAGuteEbNe4wUtiriIpwmkHNfWIL5Q6eW
 dxK8NaCXbWQ5sd7MrP8voO4UhdY0GrRWKh5UHR8CwCoebAem/sSWYYpwg4ZoW8ViqCZ5
 oO3SxcVMyjexxYITpbp/AijKKMduPev1+VBYGZn7x2yOC48obtHcFYWnzVE9KzS5uLJG
 McCvLAt9lVN4jrcx1yvJ4OHfvBRfU9BsQau1CQ+1iYcWgv1BfG2H3j9VjBfulOOvcTeT
 eQz6q90uYAqTgsLeNkH0fPlgI9uAzMO/8RRzt91AriHmgtj9lOQfiNo1pfgQsaBDT7G0
 wRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692646435; x=1693251235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uuxufY2klI0UCDH5da/lF6p4GEZsSb2IQBcna2kLdXY=;
 b=baAjmHS+9WE7d0BmGvHn6tT/u6A+GiRApCGoLkvn9/FSUjZEJHr4LUI4RR+az/L06H
 L50fb78NApl23q4IWlbxZF1QQ2jv0Cgj5k7jAVjuSa3m6uSGT7DUnLFFgz/emAhzMmnZ
 8CIYkO09dT9X5KrzFp58uOKfzkA7O675fpTGZYq4go04HlSl5v9PxIHfRLWZAx91V7OA
 DdOdmLSkhsFYBooCjNRjm14VFJUhol6JFsZ7pAOsbFYUmCEAdYAue6bhXQUuZuA787si
 Um1TpwQc7ws54r/QebgFRZOQoVVIORAQnlDeLsXeMDlHOZSfROeIV/sbAh+8wG7Hokg/
 WUgA==
X-Gm-Message-State: AOJu0YxFub+BKjjI9+suT4dgptCL56zKt4hQhkHW4UTp+c3uozWC1Z06
 MF4Zv71TIGlvbAA9RpnmUW0jVwCW5LE5Mcigcyo=
X-Google-Smtp-Source: AGHT+IHOJBPsZEej/nn33kd8Ja4wkargON0WBq0LOqIDNkYLGoCX2zFc+myLt5o9iqEtpBM8CV9zHQ==
X-Received: by 2002:a17:906:304e:b0:9a1:b05a:c07c with SMTP id
 d14-20020a170906304e00b009a1b05ac07cmr661535ejd.55.1692646434747; 
 Mon, 21 Aug 2023 12:33:54 -0700 (PDT)
Received: from localhost.localdomain ([194.104.22.162])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a170906249600b0099cc1ffd8f5sm6936771ejb.53.2023.08.21.12.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 12:33:54 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] imx: imx8: ahab: refactor do_ahab_close command
Date: Mon, 21 Aug 2023 22:33:41 +0300
Message-ID: <20230821193343.77847-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

From: Igor Opaniuk <igor.opaniuk@foundries.io>

Move an OEM closing logic to ahab_close() function to be able to use
it directly without calling a u-boot command.

Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Co-developed-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 arch/arm/include/asm/arch-imx8/sys_proto.h |  1 +
 arch/arm/mach-imx/imx8/ahab.c              | 45 ++++++++++++++--------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8/sys_proto.h b/arch/arm/include/asm/arch-imx8/sys_proto.h
index e7625c42985..405e9bd3d81 100644
--- a/arch/arm/include/asm/arch-imx8/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx8/sys_proto.h
@@ -23,6 +23,7 @@ struct pass_over_info_t {
 
 extern unsigned long boot_pointer[];
 void build_info(void);
+int ahab_close(void);
 int print_bootinfo(void);
 int sc_pm_setup_uart(sc_rsrc_t uart_rsrc, sc_pm_clock_rate_t clk_rate);
 int imx8_power_domain_lookup_name(const char *name,
diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index b58b14ca9b4..a7891bf8d98 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -340,6 +340,32 @@ static int do_ahab_status(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+int ahab_close(void)
+{
+	int err;
+	u16 lc;
+
+	err = sc_seco_chip_info(-1, &lc, NULL, NULL, NULL);
+	if (err != SC_ERR_NONE) {
+		printf("Error in get lifecycle\n");
+		return -EIO;
+	}
+
+	if (lc != 0x20) {
+		puts("Current lifecycle is NOT NXP closed, can't move to OEM closed\n");
+		display_life_cycle(lc);
+		return -EPERM;
+	}
+
+	err = sc_seco_forward_lifecycle(-1, 16);
+	if (err != SC_ERR_NONE) {
+		printf("Error in forward lifecycle to OEM closed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int confirm_close(void)
 {
 	puts("Warning: Please ensure your sample is in NXP closed state, "
@@ -361,27 +387,14 @@ static int do_ahab_close(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int confirmed = argc >= 2 && !strcmp(argv[1], "-y");
 	int err;
-	u16 lc;
 
 	if (!confirmed && !confirm_close())
 		return -EACCES;
 
-	err = sc_seco_chip_info(-1, &lc, NULL, NULL, NULL);
+	err = ahab_close();
 	if (err) {
-		printf("Error in get lifecycle\n");
-		return -EIO;
-	}
-
-	if (lc != 0x20) {
-		puts("Current lifecycle is NOT NXP closed, can't move to OEM closed\n");
-		display_life_cycle(lc);
-		return -EPERM;
-	}
-
-	err = sc_seco_forward_lifecycle(-1, 16);
-	if (err) {
-		printf("Error in forward lifecycle to OEM closed\n");
-		return -EIO;
+		printf("Change to OEM closed failed\n");
+		return err;
 	}
 
 	printf("Change to OEM closed successfully\n");
-- 
2.41.0

