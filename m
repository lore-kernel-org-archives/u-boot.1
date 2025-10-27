Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259ECCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C1B8393D;
	Mon, 27 Oct 2025 18:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tnE+NqNJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G1fUC5pL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762D08384E; Mon, 27 Oct 2025 18:07:30 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69181839C6
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwKgh14dyz9snh;
 Mon, 27 Oct 2025 18:07:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4USii+Cfg/oAlY9fFAgw8bRqHVP67NXk86liJ4YTIjA=;
 b=tnE+NqNJ5jXNUvQys7fI+M4i8fM+2QyEXUK0QGAUMoNtmMp3lEHPbBD8aQ0p5st82lyYP0
 +gdRl38wzVOcDarJmKz1d/NKy6QajR2SRd5f6BO7UD4VUFgF5w57ZRTaFlix24l92Y+7yG
 qkhGcdk1BQSU+UF2tBCe0qu2fmH6eWztCTKRkE2lPeTcXMSurZ2RU4uLq+yGwgGnewrn1n
 0zyoIBV846L8rkpLGkLI6nLg02UQhbZZiWJFdH2tsGVBdPA4CMN1nU04zq5v5Z4peIDga3
 FJwG06llUHvu7nLaWw+nj1Un+34iQzaTIF/ohBEuaKHgLvxjDYox5Jv0u1UO9g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4USii+Cfg/oAlY9fFAgw8bRqHVP67NXk86liJ4YTIjA=;
 b=G1fUC5pLLgPYMYg+dyapXa50IXa5HukwpfOSFivOf0ESGyvHTurMlFV9yIlK+GKwlLqcro
 w86LrvqgcIXr0F51hh3/SW//LCJKhoK48Fizd8XMXmCXNPxiTfKvcLqDIwqlCwRHWqgMDw
 +7KZ6f7XAHyZnc9DH+CVQYMfoYryUXQBXpkOYs51HSdWc5ZQFB2fFjzYA4CNAHSIdPhbro
 DUWuMojuLdX33QgHsW0l7wJsOn5Y+UpGyn0JVyfUNcBer+VBQu1BOOZ3P1Oe/iDbTafGlt
 pSOELe2dfHnPVlSjQ1qZx5wJN/K2k9BAMxOp12YAQ9s3Dy6Qm5mTNvGGknMb/w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 4/6] ufs: Call ufs_scsi_bind() from uclass .post_bind
Date: Mon, 27 Oct 2025 18:06:25 +0100
Message-ID: <20251027170706.29302-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n4whf5u1e3cq6k99faybbrpzasgca66t
X-MBO-RS-ID: 9bb5cb90afb97a9b0dc
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

Instead of duplicating the ufs_scsi_bind() call in every driver,
call it from UFS uclass .post_bind callback for every driver in
one place. While doing so, inline ufs_scsi_bind() directly into
ufs_post_bind() as trivial device_bind_driver() call.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/ufs/cdns-platform.c   |  8 --------
 drivers/ufs/ufs-amd-versal2.c |  8 --------
 drivers/ufs/ufs-pci.c         |  8 --------
 drivers/ufs/ufs-qcom.c        |  8 --------
 drivers/ufs/ufs-renesas.c     |  8 --------
 drivers/ufs/ufs.c             | 14 ++++++--------
 6 files changed, 6 insertions(+), 48 deletions(-)

diff --git a/drivers/ufs/cdns-platform.c b/drivers/ufs/cdns-platform.c
index 510a6a6aa5d..87d9c5bad79 100644
--- a/drivers/ufs/cdns-platform.c
+++ b/drivers/ufs/cdns-platform.c
@@ -101,13 +101,6 @@ static int cdns_ufs_pltfm_probe(struct udevice *dev)
 	return err;
 }
 
-static int cdns_ufs_pltfm_bind(struct udevice *dev)
-{
-	struct udevice *scsi_dev;
-
-	return ufs_scsi_bind(dev, &scsi_dev);
-}
-
 static const struct udevice_id cdns_ufs_pltfm_ids[] = {
 	{
 		.compatible = "cdns,ufshc-m31-16nm",
@@ -120,5 +113,4 @@ U_BOOT_DRIVER(cdns_ufs_pltfm) = {
 	.id		= UCLASS_UFS,
 	.of_match	= cdns_ufs_pltfm_ids,
 	.probe		= cdns_ufs_pltfm_probe,
-	.bind		= cdns_ufs_pltfm_bind,
 };
diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 89931921ff9..bf23439e59d 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -552,13 +552,6 @@ static int ufs_versal2_probe(struct udevice *dev)
 	return ret;
 }
 
-static int ufs_versal2_bind(struct udevice *dev)
-{
-	struct udevice *scsi_dev;
-
-	return ufs_scsi_bind(dev, &scsi_dev);
-}
-
 static const struct udevice_id ufs_versal2_ids[] = {
 	{
 		.compatible = "amd,versal2-ufs",
@@ -571,5 +564,4 @@ U_BOOT_DRIVER(ufs_versal2_pltfm) = {
 	.id		= UCLASS_UFS,
 	.of_match	= ufs_versal2_ids,
 	.probe		= ufs_versal2_probe,
-	.bind		= ufs_versal2_bind,
 };
diff --git a/drivers/ufs/ufs-pci.c b/drivers/ufs/ufs-pci.c
index 871f3f50f5c..5b9c72a695d 100644
--- a/drivers/ufs/ufs-pci.c
+++ b/drivers/ufs/ufs-pci.c
@@ -11,13 +11,6 @@
 #include <dm/device_compat.h>
 #include "ufs.h"
 
-static int ufs_pci_bind(struct udevice *dev)
-{
-	struct udevice *scsi_dev;
-
-	return ufs_scsi_bind(dev, &scsi_dev);
-}
-
 static int ufs_pci_probe(struct udevice *dev)
 {
 	int err;
@@ -32,7 +25,6 @@ static int ufs_pci_probe(struct udevice *dev)
 U_BOOT_DRIVER(ufs_pci) = {
 	.name	= "ufs_pci",
 	.id	= UCLASS_UFS,
-	.bind	= ufs_pci_bind,
 	.probe	= ufs_pci_probe,
 };
 
diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index 843585726c7..9f0a6940d98 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -648,13 +648,6 @@ static int ufs_qcom_probe(struct udevice *dev)
 	return 0;
 }
 
-static int ufs_qcom_bind(struct udevice *dev)
-{
-	struct udevice *scsi_dev;
-
-	return ufs_scsi_bind(dev, &scsi_dev);
-}
-
 static const struct udevice_id ufs_qcom_ids[] = {
 	{ .compatible = "qcom,ufshc" },
 	{},
@@ -665,6 +658,5 @@ U_BOOT_DRIVER(qcom_ufshcd) = {
 	.id		= UCLASS_UFS,
 	.of_match	= ufs_qcom_ids,
 	.probe		= ufs_qcom_probe,
-	.bind		= ufs_qcom_bind,
 	.priv_auto	= sizeof(struct ufs_qcom_priv),
 };
diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index ae05bdc8102..0b74b39dc2a 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -351,13 +351,6 @@ static struct ufs_hba_ops ufs_renesas_vops = {
 	.hce_enable_notify = ufs_renesas_hce_enable_notify,
 };
 
-static int ufs_renesas_pltfm_bind(struct udevice *dev)
-{
-	struct udevice *scsi_dev;
-
-	return ufs_scsi_bind(dev, &scsi_dev);
-}
-
 static int ufs_renesas_pltfm_probe(struct udevice *dev)
 {
 	struct ufs_renesas_priv *priv = dev_get_priv(dev);
@@ -405,7 +398,6 @@ U_BOOT_DRIVER(ufs_renesas) = {
 	.name		= "ufs-renesas",
 	.id		= UCLASS_UFS,
 	.of_match	= ufs_renesas_pltfm_ids,
-	.bind		= ufs_renesas_pltfm_bind,
 	.probe		= ufs_renesas_pltfm_probe,
 	.remove		= ufs_renesas_pltfm_remove,
 	.priv_auto	= sizeof(struct ufs_renesas_priv),
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index c1f3301b37e..5dff5c3aaec 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -2030,14 +2030,6 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	return 0;
 }
 
-int ufs_scsi_bind(struct udevice *ufs_dev, struct udevice **scsi_devp)
-{
-	int ret = device_bind_driver(ufs_dev, "ufs_scsi", "ufs_scsi",
-				     scsi_devp);
-
-	return ret;
-}
-
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffer *state)
 {
@@ -2092,8 +2084,14 @@ U_BOOT_DRIVER(ufs_scsi) = {
 	.ops = &ufs_ops,
 };
 
+static int ufs_post_bind(struct udevice *dev)
+{
+	return device_bind_driver(dev, "ufs_scsi", "ufs_scsi", NULL);
+}
+
 UCLASS_DRIVER(ufs) = {
 	.id			= UCLASS_UFS,
 	.name			= "ufs",
+	.post_bind		= ufs_post_bind,
 	.per_device_auto	= sizeof(struct ufs_hba),
 };
-- 
2.51.0

