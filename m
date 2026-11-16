Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F3606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CENgKIfk;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qkwirifZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DBE5810D6;
	Mon, 16 Nov 2026 17:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dGTVkw_kBtwv; Mon, 16 Nov 2026 17:44:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B962810D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794851083;
	b=m54XWCCxwyKml+69t9V/VkM6JZR5SR2pMtED1+L1cl8rzcttibqhFKYe6AzlqwlBr0Ge
	 8hGpho0ILEoTh1wz3p0A+l9HxAXr3btISYk4SMUZdK4EUzG9gEjI2mrAoOErR/Pe8MvsU
	 VEHNsFGE95elx5bzHYtiqVPrZpeqjDVL77cWtfNJktzFPwe9YgH1kEdwy1DU2Nlf8NcRI
	 ufDLvISHwbxpo9OoOYzn1nVkA+5sxELYI9wTxIrnc/sEhreids0ZVeBD7OGHz/OQDkcsg
	 HuusjgVfAgSFyrHDpOnT7EubR9Ylu3FvtIyPxpmTqVymXE3R0ppcZ4IQUfzIrs4zLvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794851083;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wsrh29DOzfoh9oEq0wOmZnDYPHeQc9yF26PM7fyW3kw=;
	b=c4uxSZc8uXxUqDJHD20FLU/1siIBLGlgSi13l+YtFD/4aQqj5TjoQ18FoHg0FHyn25OL
	 WFOrP529R1zsGoADSQoW0F7/ZvuGCJVEL7CNgeFwaqTnHn8oOQM6e7t09AjM8KQWPRlHz
	 ri2OLQNSTRNCaWZDg36ZlKbejUZRR6cCNv9pomQr7XVOsgpLhBNGzLozSHHsxsNIBs4Bs
	 IYG4JaWdM25l81ThLxLaRcELLiWXx2OIBN0OF/IRuOai6DF5F4etCogldKHzyI5f4vjr/
	 XD6RMM6hyf/KP/kr0FsZO4LeBDhb1VwtNBbhB2iO4HAm/6zYI1Ce+sCFIBa+iBmB3gA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794851083;
	bh=wsrh29DOzfoh9oEq0wOmZnDYPHeQc9yF26PM7fyW3kw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CENgKIfk9SdhPyklJJ9G6LJLGfAcNRX/O+ISoxqVu7fzl8ZATRyAbW9KyaR6SAHEi
	 x6U3guRFoF1l6m9NvHztwniNY3pRIONED0GHgbzOZqLkrvL/bsIYhSIPww4fD4dBF9
	 jiPTKzBnVnYLoQx02j9itEXyB4Ef9qcjOdhiyiM8vMraOrr41eVSJ4S94jN4kAoyZ9
	 n90dKaOKzP3Sksue0BXu6oXUQT5JoXw5ezLqXQEbsluV395IZFTMlAWS6y8LQ/IVQM
	 6s7qu/k0sMMpXDn6Hb9G8K4uxNh40D/n6g+919WM4jnqoahqTT+fmNglFaO683oSj6
	 g3U4TSClj5LpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B962810D8;
	Mon, 16 Nov 2026 17:44:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 047354DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE2D7405B7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v9_Ju6cyT4Xa for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDFFA40583
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=qkwirifZ
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDFFA40583
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:39 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSwGr3hgSzMllZ;
 Mon, 16 Nov 2026 18:44:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794851076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wsrh29DOzfoh9oEq0wOmZnDYPHeQc9yF26PM7fyW3kw=;
 b=qkwirifZUhBHB0/bHvqxzMfKrbdeAoyKcx9BJByFoxzrqPbZ7rQ5/hLLla1EULLehxRQmr
 E3ilDNPiaB5w9KD++LAWCtV4CGnfq127aPo+DwPXEB2GwLgFcer/MQY6V/10ZJkomJecnW
 zUbZXHJGv5uwNNoHd2l8KEvzKxlTEFAlxgXqzOxwmyqGwzjKbDdOl7l0X6ZW0bM3R88Kxb
 /JCiiNEKW26S4WJRDE7iWQzd81SGcQbc3Eb8tShNnutoBBY0wCod7XbP27S3Twiyl5JWIf
 xERIfwUILkVmSW0b8a4A5QQns3BD1Xmbk2rijBMOuEo61UAmPHNBmcJb653I8Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot-qcom@groups.io
Subject: [PATCH] ufs: Constify driver ops
Date: Mon, 16 Nov 2026 18:44:25 +0100
Message-ID: <20261116174431.3488372-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dep9qpyxa51nte8baxgi3eas4yhuhmeu
X-MBO-RS-ID: 793eec284b2f9c1dd1e
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Federico Amedeo Izzo <federico@izzo.pro>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.u-boot-project.org
---
 drivers/ufs/cdns-platform.c         | 2 +-
 drivers/ufs/ufs-amd-versal2.c       | 2 +-
 drivers/ufs/ufs-mediatek.c          | 2 +-
 drivers/ufs/ufs-qcom.c              | 2 +-
 drivers/ufs/ufs-renesas-rcar-gen5.c | 2 +-
 drivers/ufs/ufs-renesas.c           | 2 +-
 drivers/ufs/ufs-uclass.c            | 4 ++--
 drivers/ufs/ufs.h                   | 4 ++--
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/cdns-platform.c b/drivers/ufs/cdns-platform.c
index 40883a187b0..36cb7f8dc14 100644
--- a/drivers/ufs/cdns-platform.c
+++ b/drivers/ufs/cdns-platform.c
@@ -85,7 +85,7 @@ static int cdns_ufs_init(struct ufs_hba *hba)
 	return 0;
 }
 
-static struct ufs_hba_ops cdns_pltfm_hba_ops = {
+static const struct ufs_hba_ops cdns_pltfm_hba_ops = {
 	.init = cdns_ufs_init,
 	.hce_enable_notify = cdns_ufs_hce_enable_notify,
 	.link_startup_notify = cdns_ufs_link_startup_notify,
diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 48854792cbf..55ebb6ec50d 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -485,7 +485,7 @@ static int ufs_get_max_pwr_mode(struct ufs_hba *hba,
 	return 0;
 }
 
-static struct ufs_hba_ops ufs_versal2_hba_ops = {
+static const struct ufs_hba_ops ufs_versal2_hba_ops = {
 	.init = ufs_versal2_init,
 	.link_startup_notify = ufs_versal2_link_startup_notify,
 	.hce_enable_notify = ufs_versal2_hce_enable_notify,
diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index 268627d5863..4ab03c3d7f3 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -373,7 +373,7 @@ static int ufs_mtk_device_reset(struct ufs_hba *hba)
 	return 0;
 }
 
-static struct ufs_hba_ops ufs_mtk_hba_ops = {
+static const struct ufs_hba_ops ufs_mtk_hba_ops = {
 	.init			= ufs_mtk_init,
 	.hce_enable_notify	= ufs_mtk_hce_enable_notify,
 	.link_startup_notify	= ufs_mtk_link_startup_notify,
diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index 6357fd82e12..958a27bcdc0 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -649,7 +649,7 @@ static int ufs_qcom_device_reset(struct ufs_hba *hba)
 	return 0;
 }
 
-static struct ufs_hba_ops ufs_qcom_hba_ops = {
+static const struct ufs_hba_ops ufs_qcom_hba_ops = {
 	.init			= ufs_qcom_init,
 	.get_max_pwr_mode	= ufs_get_max_pwr_mode,
 	.hce_enable_notify	= ufs_qcom_hce_enable_notify,
diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
index c6e436fe197..1a2bf96730e 100644
--- a/drivers/ufs/ufs-renesas-rcar-gen5.c
+++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
@@ -198,7 +198,7 @@ static int ufs_renesas_get_max_pwr_mode(struct ufs_hba *hba,
 	return 0;
 }
 
-static struct ufs_hba_ops ufs_renesas_vops = {
+static const struct ufs_hba_ops ufs_renesas_vops = {
 	.init			= ufs_renesas_init,
 	.hce_enable_notify	= ufs_renesas_hce_enable_notify,
 	.link_startup_notify	= ufs_renesas_link_startup_notify,
diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index a206e3c6d58..1ada5288ea8 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -300,7 +300,7 @@ static int ufs_renesas_init(struct ufs_hba *hba)
 	return 0;
 }
 
-static struct ufs_hba_ops ufs_renesas_vops = {
+static const struct ufs_hba_ops ufs_renesas_vops = {
 	.init		= ufs_renesas_init,
 	.hce_enable_notify = ufs_renesas_hce_enable_notify,
 };
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 2ca4fb2a020..50597c26759 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2198,7 +2198,7 @@ static int ufs_start(struct ufs_hba *hba)
 	return 0;
 }
 
-int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
+int ufshcd_probe(struct udevice *ufs_dev, const struct ufs_hba_ops *hba_ops)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(ufs_dev);
 	struct scsi_plat *scsi_plat;
@@ -2316,7 +2316,7 @@ static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffe
 }
 #endif	/* CONFIG_BOUNCE_BUFFER */
 
-static struct scsi_ops ufs_ops = {
+static const struct scsi_ops ufs_ops = {
 	.exec		= ufs_scsi_exec,
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 	.buffer_aligned	= ufs_scsi_buffer_aligned,
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 9f55735602b..7a8f715e8cd 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -699,7 +699,7 @@ enum ufshcd_quirks {
 struct ufs_hba {
 	struct			udevice *dev;
 	void __iomem		*mmio_base;
-	struct ufs_hba_ops	*ops;
+	const struct ufs_hba_ops *ops;
 	struct ufs_desc_size	desc_size;
 	u32			capabilities;
 	u32			version;
@@ -810,7 +810,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 	ufshcd_writel(hba, tmp, reg);
 }
 
-int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
+int ufshcd_probe(struct udevice *dev, const struct ufs_hba_ops *hba_ops);
 
 int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
 			   int desc_index, u8 param_offset, u8 *param_read_buf,
-- 
2.53.0

