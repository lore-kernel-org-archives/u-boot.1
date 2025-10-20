Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7CECCD184
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 01:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F6D1831D5;
	Mon, 20 Oct 2025 03:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dQ8sYG6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159D883043; Mon, 20 Oct 2025 03:29:38 +0200 (CEST)
Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com
 [101.71.155.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9968807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 03:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shawn.lin@rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 266e49e63;
 Mon, 20 Oct 2025 09:29:29 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>, YiFeng Zhao <zyf@rock-chips.com>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] ufs: core: Add ufshcd_dme_enable() and
 ufshcd_dme_reset()
Date: Mon, 20 Oct 2025 09:29:13 +0800
Message-Id: <1760923754-47718-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a99ff3c57fb09cckunmb1003277433a33
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkkZGFZJQx0fHklMHU5JSR9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=dQ8sYG6SGjlPAetJ40ws1dR90CloUp75SOjly6aCLp9WZ9WsE1gbVTRu6CO7T4YO129TS+dNlc5GJKj3QF/7aE1Fs0KmC0lICQ86IU6zbSMnRbW1QojJZbpuE5VHJUvczESr7fcJ62hKWWHWUAfWK3o4jtlOfvLJ64olZmLL8/A=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=4+2+4nHXxb4nEtyvw8I0PxVSbhI4mwkojaqEiYrDAPI=;
 h=date:mime-version:subject:message-id:from;
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

In order for host drivers to use.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/ufs/ufs.c | 30 ++++++++++++++++++++++++++++++
 drivers/ufs/ufs.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 57e6e8c013b..92cd9ad239f 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -368,6 +368,36 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
 	return ret;
 }
 
+int ufshcd_dme_enable(struct ufs_hba *hba)
+{
+	struct uic_command uic_cmd = {0};
+	int ret;
+
+	uic_cmd.command = UIC_CMD_DME_ENABLE;
+
+	ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
+	if (ret)
+		dev_dbg(hba->dev,
+			"dme-enable: error code %d\n", ret);
+
+	return ret;
+}
+
+int ufshcd_dme_reset(struct ufs_hba *hba)
+{
+	struct uic_command uic_cmd = {0};
+	int ret;
+
+	uic_cmd.command = UIC_CMD_DME_RESET;
+
+	ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
+	if (ret)
+		dev_dbg(hba->dev,
+			"dme-reset: error code %d\n", ret);
+
+	return ret;
+}
+
 /**
  * ufshcd_disable_intr_aggr - Disables interrupt aggregation.
  *
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0337ac5996b..ebbd5d6cad7 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -435,6 +435,8 @@ int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
 			u8 attr_set, u32 mib_val, u8 peer);
 int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 			u32 *mib_val, u8 peer);
+int ufshcd_dme_enable(struct ufs_hba *hba);
+int ufshcd_dme_reset(struct ufs_hba *hba);
 
 static inline int ufshcd_dme_set(struct ufs_hba *hba, u32 attr_sel,
 				 u32 mib_val)
-- 
2.43.0

