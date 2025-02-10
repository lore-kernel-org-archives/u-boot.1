Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2F3C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C873280C58;
	Mon, 10 Feb 2025 14:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=baocheng.su@siemens.com header.b="DBAZ8LjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2637803B5; Mon, 10 Feb 2025 14:06:43 +0100 (CET)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F64805C2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baocheng.su@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20250210130641b82a8b4a80d68ba95d for <u-boot@lists.denx.de>;
 Mon, 10 Feb 2025 14:06:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=baocheng.su@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wULGKMTQqxR+NR+2/vrVePlyYupky0YsGXhoSnCDjHY=;
 b=DBAZ8LjPIcVZAOPWfEL1V580cJwzQ3MuLG52jyObK8zRoB0LFpeGNDsjHDg42+V49YBhBt
 UT++rn8viUNPADdNR0qYKnytAZXjBbKMuUzpjHLimV6xZPwHBbwjsUCa2nmVUvXlxgxk1fTs
 AjvVi5HhoPWNNKDOZoYuk4aqREiz4fEQ1uecqKNoFYs33Xfe+g4jZsUImP3HB0gEVv+oiSlL
 hW8gv1MNQtcatMaSkWdLurz1rtf26si7obmx7nt9YoEDT2/JDNuuLiydie2Ie3QyqA+y86CV
 7tnFgjvTpd2H41kj1SJzc7W2HGDi3YIWwEJzZviDSf8AG/M73bT840Tw==;
From: Baocheng Su <baocheng.su@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Bryan Brattlof <bb@ti.com>,
 Baocheng Su <baocheng.su@siemens.com>
Subject: [PATCH v3 2/5] sysinfo: Add API for accessing data elements
Date: Mon, 10 Feb 2025 21:05:41 +0800
Message-Id: <20250210130544.2781284-3-baocheng.su@siemens.com>
In-Reply-To: <20250210130544.2781284-1-baocheng.su@siemens.com>
References: <20250210130544.2781284-1-baocheng.su@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-909155:519-21489:flowmailer
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:33:36 +0100
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

This commit introduces a new API to the sysinfo module, allowing access
to data elements. This is particularly useful for handling data with
multiple instances, such as MAC addresses.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>

---

Changes in v3:
- New

 drivers/sysinfo/sysinfo-uclass.c | 29 +++++++++++++++
 include/sysinfo.h                | 63 ++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/sysinfo/sysinfo-uclass.c b/drivers/sysinfo/sysinfo-uclass.c
index 3c0cd51273e7..f04998ef8bb6 100644
--- a/drivers/sysinfo/sysinfo-uclass.c
+++ b/drivers/sysinfo/sysinfo-uclass.c
@@ -119,6 +119,35 @@ int sysinfo_get_data(struct udevice *dev, int id, void **data, size_t *size)
 	return ops->get_data(dev, id, data, size);
 }
 
+int sysinfo_get_item_count(struct udevice *dev, int id)
+{
+	struct sysinfo_priv *priv = dev_get_uclass_priv(dev);
+	struct sysinfo_ops *ops = sysinfo_get_ops(dev);
+
+	if (!priv->detected)
+		return -EPERM;
+
+	if (!ops->get_item_count)
+		return -ENOSYS;
+
+	return ops->get_item_count(dev, id);
+}
+
+int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
+			      void **data, size_t *size)
+{
+	struct sysinfo_priv *priv = dev_get_uclass_priv(dev);
+	struct sysinfo_ops *ops = sysinfo_get_ops(dev);
+
+	if (!priv->detected)
+		return -EPERM;
+
+	if (!ops->get_data_by_index)
+		return -ENOSYS;
+
+	return ops->get_data_by_index(dev, id, index, data, size);
+}
+
 UCLASS_DRIVER(sysinfo) = {
 	.id		= UCLASS_SYSINFO,
 	.name		= "sysinfo",
diff --git a/include/sysinfo.h b/include/sysinfo.h
index 14e923c6589f..2866ac293cbb 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -152,6 +152,7 @@ enum sysinfo_id {
 	/* For show_board_info() */
 	SYSID_BOARD_MODEL,
 	SYSID_BOARD_MANUFACTURER,
+	SYSID_BOARD_MAC_ADDR,
 	SYSID_PRIOR_STAGE_VERSION,
 	SYSID_PRIOR_STAGE_DATE,
 
@@ -221,6 +222,30 @@ struct sysinfo_ops {
 	 */
 	int (*get_data)(struct udevice *dev, int id, void **data, size_t *size);
 
+	/**
+	 * get_item_count() - Get the item count of the specific data area that
+	 *		describes the hardware setup.
+	 * @dev:	The sysinfo instance to gather the data.
+	 * @id:		A unique identifier for the data area to be get.
+	 *
+	 * Return: non-negative item count if OK, -ve on error.
+	 */
+	int (*get_item_count)(struct udevice *dev, int id);
+
+	/**
+	 * get_data_by_index() - Get a data value by index from the platform.
+	 *
+	 * @dev:	The sysinfo instance to gather the data.
+	 * @id:		A unique identifier for the data area to be get.
+	 * @index:	The item index, starting from 0.
+	 * @data:	Pointer to the address of the data area.
+	 * @size:	Pointer to the size of the data area.
+	 *
+	 * Return: 0 if OK, -ve on error.
+	 */
+	int (*get_data_by_index)(struct udevice *dev, int id, int index,
+				 void **data, size_t *size);
+
 	/**
 	 * get_fit_loadable - Get the name of an image to load from FIT
 	 * This function can be used to provide the image names based on runtime
@@ -304,6 +329,32 @@ int sysinfo_get_str(struct udevice *dev, int id, size_t size, char *val);
  */
 int sysinfo_get_data(struct udevice *dev, int id, void **data, size_t *size);
 
+/**
+ * sysinfo_get_item_count() - Get the item count of the specific data area that
+ *			    describes the hardware setup.
+ * @dev:	The sysinfo instance to gather the data.
+ * @id:		A unique identifier for the data area to be get.
+ *
+ * Return: non-negative item count if OK, -EPERM if called before
+ * sysinfo_detect(), else -ve on error.
+ */
+int sysinfo_get_item_count(struct udevice *dev, int id);
+
+/**
+ * sysinfo_get_data_by_index() - Get a data value by index from the platform.
+ *
+ * @dev:	The sysinfo instance to gather the data.
+ * @id:		A unique identifier for the data area to be get.
+ * @index:	The item index, starting from 0.
+ * @data:	Pointer to the address of the data area.
+ * @size:	Pointer to the size of the data area.
+ *
+ * Return: 0 if OK, -EPERM if called before sysinfo_detect(), else -ve on
+ * error.
+ */
+int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
+			      void **data, size_t *size);
+
 /**
  * sysinfo_get() - Return the sysinfo device for the sysinfo in question.
  * @devp: Pointer to structure to receive the sysinfo device.
@@ -365,6 +416,18 @@ static inline int sysinfo_get_data(struct udevice *dev, int id, void **data,
 	return -ENOSYS;
 }
 
+static inline int sysinfo_get_item_count(struct udevice *dev, int id)
+{
+	return -ENOSYS;
+}
+
+static inline int sysinfo_get_data_by_index(struct udevice *dev, int id,
+					    int index, void **data,
+					    size_t *size)
+{
+	return -ENOSYS;
+}
+
 static inline int sysinfo_get(struct udevice **devp)
 {
 	return -ENOSYS;
-- 
2.39.5

