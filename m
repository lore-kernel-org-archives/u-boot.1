Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB5AC001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57861869A5;
	Mon, 14 Aug 2023 23:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t4DCHBAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F6E8869A5; Mon, 14 Aug 2023 23:55:48 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04DFB869B4
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc5acc627dso32030055ad.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050144; x=1692654944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQ0vp8PrPT7Qt9cmREurbyHikOAvTdgzhiZxZJi0znc=;
 b=t4DCHBAWVFcSNT/knqitxag/xC5FVh2hLILY6mNSmKtRMFqUmHXBMQezvdcjZOMeJu
 1m/ZvnjyB7CWn+6bcV1F2b0v+1rU6ctZvcnvh6VGX2WFyMGKiVUIdZVxkVNPMFXcnFyT
 +JBQc/Py10WeGMY5HnLxfUrS/NuAQGO65PHyGvBGP4BpG6vtU1h69RO87mNgQ357NijI
 bTKzlu2805Noir3iFNxIGH+2D+w4qNL5XEwOqaIix0jh17P/7rIYZzAC1ki6bmkeYcDI
 pnSXiPvSAnS8PrWv7QVDupor79EuYJVG7rksimy+qx/twUrFpjySoxSZFZc5EGs1iH9h
 3U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050144; x=1692654944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQ0vp8PrPT7Qt9cmREurbyHikOAvTdgzhiZxZJi0znc=;
 b=OHg7AHOO2qKrjb/4ff3xIMl6KomA0Cwj7VP8loJ/HJSZn1HBbGAyH3r7Q5u5zybpaC
 2DHKU+pUz459NytRLdfc314v7P7MuzyLnyY3Vh5IYCmWtjSfzQcns0hbaYrqnXGVW2mF
 9k/NJVqSsGr67FgiMzbBJtW1OX0uwrg5DLWE01aUhqr4X8GFPDp+d68aVhA1mpPChIgq
 e4l+vT8bIVjp7A+kPfhIaExMPZ37u+uP+jFCpFZR1l4hHVrU/m9vBPrhfHAx9b5a0VO1
 nl0Yl322RCDbOgax7+kSqjmPPGKy6GroBRvCd0bLM+D0kq+MidoWeQ0/8ug7ZzmXRdtI
 4pEQ==
X-Gm-Message-State: AOJu0YyOKAQ4b5/hXtjbb41w2gzfjHRLZ3tYr5oM1lO2VigpOMX7Jjn1
 Jc3WiGh6N7jr6eucy3s4eQmGqVtM3zT5MrJKblw=
X-Google-Smtp-Source: AGHT+IFNsEvGZ5dt1Hvg1YOG1tAKqUwiKK7GGsRdb4BpiwUSq7uJMmCWuV04v5mbnb5eNahiEDUz/Q==
X-Received: by 2002:a17:903:1248:b0:1b3:9d13:34b3 with SMTP id
 u8-20020a170903124800b001b39d1334b3mr10842589plh.37.1692050144100; 
 Mon, 14 Aug 2023 14:55:44 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:43 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 08/17] ufs: Expose 'ufshcd_ops_dbg_register_dump' vops to
 allow dumping debug registers
Date: Tue, 15 Aug 2023 03:24:48 +0530
Message-Id: <20230814215457.4075025-9-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

Add more verbose debug capabilities and vops to allow dumping
UFS debug registers / regions, similar to how the UFS Linux driver
does it.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs.h |  9 ++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index b2c3af429e..15fa3832b9 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -59,10 +59,81 @@
 /* maximum bytes per request */
 #define UFS_MAX_BYTES	(128 * 256 * 1024)
 
+#define ufshcd_hex_dump(prefix_str, buf, len) do {                      \
+	size_t __len = (len);                                           \
+	print_hex_dump(prefix_str,                             		\
+		       DUMP_PREFIX_OFFSET,				\
+		       16, 4, buf, __len, false);                       \
+} while (0)
+
 static inline bool ufshcd_is_hba_active(struct ufs_hba *hba);
 static inline void ufshcd_hba_stop(struct ufs_hba *hba);
 static int ufshcd_hba_enable(struct ufs_hba *hba);
 
+int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
+		     const char *prefix)
+{
+	u32 *regs;
+	size_t pos;
+
+	if (offset % 4 != 0 || len % 4 != 0) /* keep readl happy */
+		return -EINVAL;
+
+	regs = kzalloc(len, GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+
+	for (pos = 0; pos < len; pos += 4) {
+		if (offset == 0 &&
+		    pos >= REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER &&
+		    pos <= REG_UIC_ERROR_CODE_DME)
+			continue;
+		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
+	}
+
+	ufshcd_hex_dump(prefix, regs, len);
+	kfree(regs);
+
+	return 0;
+}
+
+void ufshcd_print_tr(struct ufs_hba *hba, int tag, bool pr_prdt)
+{
+	int prdt_length;
+	struct utp_transfer_req_desc *req_desc = hba->utrdl;
+
+	dev_info(hba->dev,
+		"UPIU[%d] - Transfer Request Descriptor phys@0x%llx\n",
+		tag, (u64)hba->utrdl);
+
+	ufshcd_hex_dump("UPIU TRD: ", hba->utrdl,
+			sizeof(struct utp_transfer_req_desc));
+	dev_info(hba->dev, "UPIU[%d] - Request UPIU phys@0x%llx\n", tag,
+		(u64)hba->ucd_req_ptr);
+	ufshcd_hex_dump("UPIU REQ: ", hba->ucd_req_ptr,
+			sizeof(struct utp_upiu_req));
+	dev_info(hba->dev, "UPIU[%d] - Response UPIU phys@0x%llx\n", tag,
+		(u64)hba->ucd_rsp_ptr);
+	ufshcd_hex_dump("UPIU RSP: ", hba->ucd_rsp_ptr,
+			sizeof(struct utp_upiu_rsp));
+
+	prdt_length = le16_to_cpu(req_desc->prd_table_length);
+
+	dev_info(hba->dev,
+		"UPIU[%d] - PRDT - %d entries  phys@0x%llx\n",
+		tag, prdt_length,
+		(u64)hba->ucd_prdt_ptr);
+
+	if (pr_prdt)
+		ufshcd_hex_dump("UPIU PRDT: ", hba->ucd_prdt_ptr,
+			sizeof(struct ufshcd_sg_entry) * prdt_length);
+}
+
+void ufshcd_dbg_register_dump(struct ufs_hba *hba)
+{
+	ufshcd_ops_dbg_register_dump(hba);
+}
+
 /*
  * ufshcd_wait_for_register - wait for register value to change
  */
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index c9320a905e..b3d2bd0368 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -695,6 +695,7 @@ struct ufs_dev_cmd {
 
 struct ufs_hba_ops {
 	int (*init)(struct ufs_hba *hba);
+	void (*dbg_register_dump)(struct ufs_hba *hba);
 	int (*hce_enable_notify)(struct ufs_hba *hba,
 				 enum ufs_notify_change_status);
 	int (*link_startup_notify)(struct ufs_hba *hba,
@@ -746,6 +747,12 @@ static inline int ufshcd_ops_init(struct ufs_hba *hba)
 	return 0;
 }
 
+static inline void ufshcd_ops_dbg_register_dump(struct ufs_hba *hba)
+{
+	if (hba->ops && hba->ops->dbg_register_dump)
+		hba->ops->dbg_register_dump(hba);
+}
+
 static inline int ufshcd_ops_hce_enable_notify(struct ufs_hba *hba,
 						bool status)
 {
@@ -931,5 +938,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
 
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
+int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
+		     const char *prefix);
 
 #endif
-- 
2.38.1

