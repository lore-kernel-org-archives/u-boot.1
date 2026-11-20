Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1436606A6BE
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q3GtPnVQ;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pOKGL/sg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33BF260778;
	Fri, 20 Nov 2026 21:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOBcLWI4z-3f; Fri, 20 Nov 2026 21:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 451666069C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211450;
	b=U/xW0HQvvOLiwd855OpmGqSpOfb3UOHr3g3fE1YC13UuNwipWIZvjUTeQT4sB6n67Ed1
	 KCIMce/evFd5GxU8163QxrDIbhLW3/vkP+sTZ0mpgqDoqE0xvG1XAaqPtgwR1y2Uo15GT
	 WZ8piNYDNvugNolqBhFtPU34W9xejL7djXnYt8g9CyWiasbSBMWj+RHsfKnV1511W/baZ
	 xsM/uz3VDqQtXVOXJYSRNO+Uh5EXEff4LNBW7c+sftyijMwKR5zlbkMYS1VTvMOi/RsYB
	 wmqkxyKjjUXKdpkYrKhqDp8ooKCnokFcMviP5afMs25LysHjyxYSJxoM2EkWruz/TQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OtBbanz3LW1UU/i2TzKHYSQ+gUVtGLQ7raWIBHq3aRs=;
	b=XUya977+qjOYQhs+KVmpOw5PHKpzE8u8finSYIUPgQTBzh6+ttDwQ5Jsvd/6U/zcx77Z
	 n/XKYMQ0GUVTojovg81erVt4uE4AIYyeOPghDGj2piv5pQnbTzudW0BXEIvRSQvlQubKf
	 J8ih+or41A9eCqLd7ANrg5cUOITEkpFakU2LgZ3AMYhmd1dGWFFijtLhLQt9a/9ng2BqS
	 5MKT+Emh6mQPCiPPpRXX6yueY2hNnYURQyPYdLuf7AY3ZlWNgNIgKxmot7qH/ImCctZYK
	 E4Jkrwb02OmdOELtrgMp9ggznk4F6zr6X24lTwdDezC9SQ0JNpEND9+hyHmIAAOhCpw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211450;
	bh=OtBbanz3LW1UU/i2TzKHYSQ+gUVtGLQ7raWIBHq3aRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3GtPnVQavlnHkSwDYuDWd1ZYtsymmR1GjYdSasv0RNEMw8NcF8JUpwPgIKDwNHN5
	 ORnXPB88a3thke+ICMClwB1HOYILAT4V493Dh6hogvxSUEg+qPMaaDLvWFPO7w6QOZ
	 YOjtWJGauKoWrrR8ZuREurq6lXsZ90OepQMWb/DLtAo9sbQULVo6P+yWqlM+jxdym0
	 G8u1OS2E63Slfawd1Lx8pYt/+3/NHJxuDV8rbwFbszcTiPvn5pnpld9no5CLsBFHj9
	 y055HEAalH2lz3j9LQCTtIB/f62I36cBqMWNVX2T3yGn2bIWhkIBw4MV9oywIkoLRZ
	 ikLFB2Kw2cH3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 451666069C;
	Fri, 20 Nov 2026 21:50:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 74B599C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6655940208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUaXxJvEYx0b for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:50:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 557E840176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pOKGL/sg
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 557E840176
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:44 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-862b3a39d0dso775001a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211444; x=1795816244;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OtBbanz3LW1UU/i2TzKHYSQ+gUVtGLQ7raWIBHq3aRs=;
 b=pOKGL/sg12Z7JzLMBvQpkyimwRFTAE/5gYpwdMan5hwauv6kMZO+e8g02ua9urewdn
 iUprBU1H4/Gcd0/axO+Oa/aMBKOZRmdwjotSuY5X5q4xr+aOjfYpQyjosz2borYtmAW3
 mIRSHIwVlLWWS4YT1uF16p6qWe1qhT89slzOJW8cw82Jhip9Icp1rwjMbpFcDHFc3s+z
 0nBghCIThSV3eY/A6x5jTBriFGdIcINJ0hNrvshdtqIYm/EmRyg6+03Ly9poRGofpO8E
 3xpVcLD8Sd1PjNRkyyMGN4ccKfaU3raH7ctt0YlrRV6OFMvQTtkm/L1TE/FtSsN5tkr+
 dL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211444; x=1795816244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OtBbanz3LW1UU/i2TzKHYSQ+gUVtGLQ7raWIBHq3aRs=;
 b=1jmLWEdEYoD3IWdKEhGX5WRxvnZXhNm3WRanwXS6s6zytUKm+C2dgeaap0a6q5UQkT
 daur4LtCATyiEEFhIsPlcYmEQuYZxDoJB+7nv01vQo9Nbwlxsgf2m7QRXEPWgALOzeCJ
 yrCU5llta6ITX7qYiUZhjGdVDRXBdO/IEqZDIgYvtNyLzdA2bi3KbQM0zR9SvbsAYNLn
 52UpPB2m/+HtNUnNruuvjDWBsokpe+N99Hcb412TrnvQExcL+znhXbzVuz+TQRr241gV
 fvNYLyfBw3iT3pi091+9qYTQEfjTFsVajC7hojOyo8ChnAPWqYld6STfhmBkMrcogbMP
 Ar7w==
X-Gm-Message-State: APuU4Z8xsDC49EHxxfIa6GSvH3nXDr7KmWzFNsjgLyBlF/8y3IiSgMJ5
 0cw7Yln1YXtZ7qY/gntLPnLayKHX3MpMFPI4wNO1hXNIZL0GtacoJ+7XkuV6ES+Prpw=
X-Gm-Gg: AYBFou3islvN3C72wc7sgkSZn+ffi512s5HUdmpB2t8F92eYP33rGqwN8kLlAUMVCSJ
 eqHzSLcUpUOaWu9zMMBY2x2WZDsol0Sqe6Hi02iQPRhCqYdDAvfgH90I2KI/GXybRzhDdsg3fRq
 QxYCYDqfD4C4gSeYMCFrsJtP2myX3VnBA+tSql7nC/31OWkO1pxrdLvf0WT7JXD7OXKTdpWDA6h
 nxLRx04IIP56FbVjOmD6HwwEwi/Ujeew7x+q+qi3sKExYGYfap3nMgsOiOpY4VZZ7SZiBZGl3rg
 lXVjtR67mcgRyLtKonI3afkpBRyZrODqVcKLkNDWofuWvbc2RyZhW8vrix/EfpF574mafR7ckAG
 MgDD/pH3enpQ0gHv3QxQaKg4fEnhsmSOpZcAEZH+crKdyNPIW4lZaVFVxrptcFCB2eXnYiT/Erl
 OYQBke4D/ZYgVVMUl9xhZlo6YP6zM/Vh0Bxd5JjIkXlJxWThITt63YoEvZSIhqderjyBr4Ys2gr
 /WQdX57ALqYrOGCdIU1osJ+OefzBgyOqNDoNc8mskTkrUEtLFsxS1YIpay6VbkroKdf74vgmccB
 AvJ+Cn3pNY5EpE/o/kR2i1OD8/a5qQtl
X-Received: by 2002:a05:6808:4f48:b0:4fb:6996:aac9 with SMTP id
 5614622812f47-57a0b64e24bmr5432479b6e.35.1795211443874; 
 Fri, 20 Nov 2026 13:50:43 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 15:49:29 -0600
Subject: [PATCH v2 2/8] ufs: mediatek: do not call the secure monitor at
 EL3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-2-3ef93cb27dcc@baylibre.com>
References: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
In-Reply-To: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4988; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=WDOUaU7OylGQQvUAmhad+kk38/Cmaqm4XlrUGZ8T5/8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMB704UqsGwlGuEfVRrIvTCrJwOWXthi1hZRQ
 VrlBu8DNQmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDAexYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACnAH/0QyIZv11LMuEq3YY9/u/z8Xg7Bz1bLPBMrFL7E
 LAzCQzZV/7lE0cOXEwCwaELvwZJicNRqeeoPGXuBjErkqrFbyb3sQ1j5sWM/Anty6ogBbvb5PWr
 SNNoNMqIVy22MEVoeH1y/r+QWdukbGThK+s1v3dQ3U7ezKmob4JM2kBAZ9QQaCypnQfoBNVzQvi
 VLqEnyT/x63Iuukhw0CuLrolWF/+CMtIpDscdPiaU1aHKy/O7Rnepyv/16ioMRoCxZuU4a9rP2K
 iq7zZdHepLxiKHCM9LBk0mL36TEVJQYKFlINoqYONjJE6WM/fxAka4+MxGIO8GsLO422rm6tsxI
 Xepc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do not issue the UFS SiP SMCs when U-Boot itself runs at EL3. There is
no secure monitor to handle them then, e.g. in SPL before BL31 has been
loaded, and an SMC would trap into U-Boot's own exception vectors.

Skip the reference clock notification, which only informs the secure
monitor's power management, and let the SoC code drive the reset pin of
the device instead, through mtk_ufs_device_reset_el3(). On SoCs that do
not implement it, the device reset is skipped with a warning, and an
earlier boot stage must have brought up the device.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/include/asm/arch-mediatek/ufs.h | 23 ++++++++++++++
 drivers/ufs/ufs-mediatek.c               | 53 +++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-mediatek/ufs.h b/arch/arm/include/asm/arch-mediatek/ufs.h
new file mode 100644
index 00000000000..bf4a74e829c
--- /dev/null
+++ b/arch/arm/include/asm/arch-mediatek/ufs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ */
+
+#ifndef __MEDIATEK_UFS_H_
+#define __MEDIATEK_UFS_H_
+
+#include <linux/types.h>
+
+/**
+ * mtk_ufs_device_reset_el3() - drive the reset pin of the UFS device
+ *
+ * The UFS driver normally asks the secure monitor to drive the reset pin of
+ * the UFS device. When U-Boot runs at EL3, e.g. in SPL before BL31, there is
+ * no secure monitor yet, and the SoC code drives the pin instead.
+ *
+ * @high: true to release the device from reset, false to hold it in reset
+ * Return: 0 if Ok, -EOPNOTSUPP if the SoC code does not support it
+ */
+int mtk_ufs_device_reset_el3(bool high);
+
+#endif /* __MEDIATEK_UFS_H_ */
diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index 268627d5863..ad8c7b8dfe9 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -12,12 +12,15 @@
 #include <generic-phy.h>
 #include <ufs.h>
 #include <asm/gpio.h>
+#include <asm/system.h>
+#include <asm/arch/ufs.h>
 #include <reset.h>
 
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/err.h>
 
 #include "ufs.h"
@@ -236,9 +239,17 @@ static void ufs_mtk_get_hw_ip_version(struct ufs_hba *hba)
 	dev_info(hba->dev, "MediaTek UFS IP Version: 0x%x\n", hw_ip_ver);
 }
 
+/* There is no secure monitor at EL3, e.g. in SPL before BL31 */
+static bool ufs_mtk_has_secure_monitor(void)
+{
+	return current_el() != 3;
+}
+
 static int ufs_mtk_setup_ref_clk(struct ufs_hba *hba, bool on)
 {
 	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
+	/* Only informs the secure monitor's power management */
+	bool notify = ufs_mtk_has_secure_monitor();
 	struct arm_smccc_res res;
 	int timeout, time_checked = 0;
 	u32 value;
@@ -246,7 +257,8 @@ static int ufs_mtk_setup_ref_clk(struct ufs_hba *hba, bool on)
 	if (host->ref_clk_enabled == on)
 		return 0;
 
-	ufs_mtk_ref_clk_notify(on, PRE_CHANGE, res);
+	if (notify)
+		ufs_mtk_ref_clk_notify(on, PRE_CHANGE, res);
 
 	if (on) {
 		ufshcd_writel(hba, REFCLK_REQUEST, REG_UFS_REFCLK_CTRL);
@@ -276,10 +288,12 @@ static int ufs_mtk_setup_ref_clk(struct ufs_hba *hba, bool on)
 	 * If clock off timeout, assume clock will off finally,
 	 * set ref_clk_enabled directly.(keep DIFN disable, keep resource)
 	 */
-	if (on)
-		ufs_mtk_ref_clk_notify(false, POST_CHANGE, res);
-	else
+	if (on) {
+		if (notify)
+			ufs_mtk_ref_clk_notify(false, POST_CHANGE, res);
+	} else {
 		host->ref_clk_enabled = false;
+	}
 
 	return -ETIMEDOUT;
 
@@ -288,7 +302,8 @@ out:
 	if (on)
 		udelay(10);
 
-	ufs_mtk_ref_clk_notify(on, POST_CHANGE, res);
+	if (notify)
+		ufs_mtk_ref_clk_notify(on, POST_CHANGE, res);
 
 	return 0;
 }
@@ -348,11 +363,33 @@ err_clk_enable:
 	return err;
 }
 
-static int ufs_mtk_device_reset(struct ufs_hba *hba)
+__weak int mtk_ufs_device_reset_el3(bool high)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ufs_mtk_device_reset_set(bool high)
 {
 	struct arm_smccc_res res;
 
-	ufs_mtk_device_reset_ctrl(0, res);
+	if (!ufs_mtk_has_secure_monitor())
+		return mtk_ufs_device_reset_el3(high);
+
+	ufs_mtk_device_reset_ctrl(high, res);
+
+	return 0;
+}
+
+static int ufs_mtk_device_reset(struct ufs_hba *hba)
+{
+	int ret;
+
+	ret = ufs_mtk_device_reset_set(false);
+	if (ret) {
+		/* Rely on an earlier boot stage having reset the device */
+		dev_warn(hba->dev, "cannot reset the device: %d\n", ret);
+		return 0;
+	}
 
 	/*
 	 * The reset signal is active low. UFS devices shall detect
@@ -363,7 +400,7 @@ static int ufs_mtk_device_reset(struct ufs_hba *hba)
 	 */
 	udelay(13);
 
-	ufs_mtk_device_reset_ctrl(1, res);
+	ufs_mtk_device_reset_set(true);
 
 	/* Some devices may need time to respond to rst_n */
 	mdelay(13);

-- 
2.53.0

