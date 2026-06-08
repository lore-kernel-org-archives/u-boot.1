Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01B5CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3674784715;
	Mon,  8 Jun 2026 15:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q3f+VsmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD0184704; Mon,  8 Jun 2026 12:34:05 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717BB807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 12:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E8431440DC;
 Mon,  8 Jun 2026 10:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC8A4C2BCC7;
 Mon,  8 Jun 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780914840;
 bh=LaQqF/M539crvy+xt8p7kwJ55FrlNd5NEnVcLe+Fcw4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Q3f+VsmJ5UuZ/DnLfGX46hFk3hvhgfW5JTWB9e3VcMT3dulJN7lE8lTz+4uqerwA0
 cG1rvZxDXebu2JxfUIjFewzv/z84qcmN2RLj187K9O31bo212KWe8OWuXFK29ZmN9w
 j06nhn2XVhaw4766WGAr/qHGTdAyYMmNsRSsAKD6uvH6GPGGF0qw6dxVtXYG+B4MXg
 H7oxMNdo34hdc9eXz5mzg5zFndzuRxJXcGL5lG+yPbNOOqNL6am6x7GZmbOWCKpu+C
 9LTV8fYbm7fH5lKUxPrrNFH19Rw37B04nm0xgV+VX7bC5acfRxa941oSD8WqvbtPXa
 C5wCTmiCmeowg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AF44ECD8C92;
 Mon,  8 Jun 2026 10:34:00 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Mon, 08 Jun 2026 13:33:25 +0300
Subject: [PATCH v3 1/5] ufs: Expose selected UFS functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ufs_tool2-v3-1-a9f181e86229@mobileye.com>
References: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
In-Reply-To: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=tjVVnkP/yyjwwqNo6tVzv9fccgwCQWNEWJR2cUikUkk=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJpqUCc2cgzcbqEL8AyUlDmbqeRJ7EC2hHEtVN
 y/Qi/rVbqSJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiaalAAKCRCfmumUluiO
 OfOPD/9tQTrR7PxnlUJYtp2dynahoED/rmcduan5Vx6L41iOkWMr0UHmiyEHq/IgCj2dglvO50J
 cEGTNqKg4kT0OnbSz7dgFC0gIhK5Af+TGAMOk4el9MmddnpVyPonH0kKcpmb65ALtFyBmtLiGw5
 g3JRxXxHHhPb8W8Ro0YifvqfpvKgh7II0tgDHaRCWXd9ldwxG/lWZadOcoUtv6fNyxq0XSd5TDN
 N7Etb9z+c5fknR7lYAqf+j58nQ/gTuLUGFRJ9hD3YKJbF0GakUlSh/usTqaKd5UKqTsIBHOwToo
 lH0S3X+xKmD1vDT5p46OOmOopWCwbPQae/GfAj3S2aBA4hL15af92WGKcyuNoDLizTjhxG90pQQ
 sEj8HN2L7HblEualkTKPJ+kcaCsO2KqWwpVyzI8MdyT9+WvN+jix5/NZsu6sBjZPd0+cOeCuqbe
 3UmqnZE3pr7PMg/qVITKg6WbzRXAqXueqJS897N5awtZIne8+02VcB0HRg/PEJ0qTXWZAyrgF/1
 8sNLUpLE35cg8/JasFwONv3xaf4QoD60r7mzOE/zsIRKbIUcajQPAuB82Ybsxh8jUs5Rns+msdb
 Yh/iWuHijNg/uYC7HbTSKBS3FrCs+gtdshcS5+flCZF/k6LgopKa9MiX71xXGuCYM6Q4hzC62VA
 1tVw/W7yieaObnw==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:05:23 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

Remove static qualifier from selected functios to allow
future use

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/ufs-uclass.c | 18 +++++++++---------
 drivers/ufs/ufs.h        | 13 +++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..78f6064ddea 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -757,7 +757,7 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
  *
  * Flush cache in aligned address..address+size range.
  */
-static void ufshcd_cache_flush(void *addr, unsigned long size)
+void ufshcd_cache_flush(void *addr, unsigned long size)
 {
 	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
 	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
@@ -1089,8 +1089,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
 /**
  * ufshcd_query_flag() - API function for sending flag query requests
  */
-static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-			     enum flag_idn idn, bool *flag_res)
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum flag_idn idn, bool *flag_res)
 {
 	struct ufs_query_req *request = NULL;
 	struct ufs_query_res *response = NULL;
@@ -1320,9 +1320,9 @@ out:
 /**
  * ufshcd_query_descriptor_retry - API function for sending descriptor requests
  */
-static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
-					 enum desc_idn idn, u8 index, u8 selector,
-					 u8 *desc_buf, int *buf_len)
+int  ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
+				   enum desc_idn idn, u8 index, u8 selector,
+				   u8 *desc_buf, int *buf_len)
 {
 	int err;
 	int retries;
@@ -1457,9 +1457,9 @@ static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_
  * ufshcd_read_desc_param - read the specified descriptor parameter
  *
  */
-static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int desc_index, u8 param_offset,
-				  u8 *param_read_buf, u8 param_size)
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset,
+			   u8 *param_read_buf, u8 param_size)
 {
 	int ret;
 	u8 *desc_buf;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..213b489e5e4 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -809,4 +809,17 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset, u8 *param_read_buf,
+			   u8 param_size);
+
+void ufshcd_cache_flush(void *addr, unsigned long size);
+
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum flag_idn idn, bool *flag_res);
+
+int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
+				  enum desc_idn idn, u8 index, u8 selector,
+				  u8 *desc_buf, int *buf_len);
+
 #endif

-- 
2.43.0


