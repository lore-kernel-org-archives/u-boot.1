Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EA0CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 11:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32DDF84879;
	Tue,  2 Jun 2026 13:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XSAbwTUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55EB184895; Tue,  2 Jun 2026 13:58:15 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73EDE8485F
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 13:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=OL6lTzmqclbRmTL0Y8EzxgcbM4S7MokexxXSIzzzZD8=; b=XSAbwTUN43zq9c7aLsiNuAS6Tb
 e5/t/utcFdBzADOmlzmtUrgfNW2Sh3fxUR5wq6LNSgzRe11Uty0lnVbABPNzXS5hkKmoIke3810ds
 CG75TZpxmfvEBjFOsGSDI64E3jXgQsItIZMd8dT4VNgI2dYB3aJVgigJ6ep3EtOoJcQC+xTEY0Hip
 GrMMmH9iKES+i1xi5iPyS/DgPKr/kP2Hlogf3JjxmtXlNMxpI3Ba9ya+MLBluHQNFk71VMrWwR77/
 chdqyasSLgDYF/6zWPxlgTWbQlDlJ/PT/vDLMJ1V4qWQ9Xq1oNZg+IbBQH8qDFE9Nc3qd2l3u8HTv
 wCMx22NA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl6-000Lhw-02; Tue, 02 Jun 2026 13:58:12 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl4-000J89-2t; Tue, 02 Jun 2026 13:58:11 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v4 2/7] sysinfo: add sysinfo_get_and_detect() helper
Date: Tue,  2 Jun 2026 13:57:50 +0200
Message-Id: <20260602115755.371164-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
References: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
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

From: Nora Schiffer <nora.schiffer@ew.tq-group.com>

sysinfo_detect() is commonly called after sysinfo_get(). Make the API a
bit more convenient to use by introducing a helper.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/sysinfo/sysinfo-uclass.c | 10 ++++++++++
 include/sysinfo.h                | 17 +++++++++++++++++
 test/dm/sysinfo.c                | 16 ++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/sysinfo/sysinfo-uclass.c b/drivers/sysinfo/sysinfo-uclass.c
index bf0f664e8dc..d18a168614e 100644
--- a/drivers/sysinfo/sysinfo-uclass.c
+++ b/drivers/sysinfo/sysinfo-uclass.c
@@ -42,6 +42,16 @@ int sysinfo_detect(struct udevice *dev)
 	return ret;
 }
 
+int sysinfo_get_and_detect(struct udevice **devp)
+{
+	int ret = sysinfo_get(devp);
+
+	if (!ret)
+		ret = sysinfo_detect(*devp);
+
+	return ret;
+}
+
 int sysinfo_get_fit_loadable(struct udevice *dev, int index, const char *type,
 			     const char **strp)
 {
diff --git a/include/sysinfo.h b/include/sysinfo.h
index 54eb64a204a..7ca396b2ee4 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -373,6 +373,18 @@ int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
  */
 int sysinfo_get(struct udevice **devp);
 
+/**
+ * sysinfo_get_and_detect() - Get the sysinfo device and detect it.
+ *
+ * @devp:	Pointer to structure to receive the sysinfo device.
+ *
+ * This is a convenience wrapper around sysinfo_get() followed by
+ * sysinfo_detect()
+ *
+ * Return: 0 if OK, -ve on error.
+ */
+int sysinfo_get_and_detect(struct udevice **devp);
+
 /**
  * sysinfo_get_fit_loadable - Get the name of an image to load from FIT
  * This function can be used to provide the image names based on runtime
@@ -438,6 +450,11 @@ static inline int sysinfo_get(struct udevice **devp)
 	return -ENOSYS;
 }
 
+static inline int sysinfo_get_and_detect(struct udevice **devp)
+{
+	return -ENOSYS;
+}
+
 static inline int sysinfo_get_fit_loadable(struct udevice *dev, int index,
 					   const char *type, const char **strp)
 {
diff --git a/test/dm/sysinfo.c b/test/dm/sysinfo.c
index 14ebe6b42e7..611f2e98d14 100644
--- a/test/dm/sysinfo.c
+++ b/test/dm/sysinfo.c
@@ -66,3 +66,19 @@ static int dm_test_sysinfo(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_sysinfo, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_sysinfo_get_and_detect(struct unit_test_state *uts)
+{
+	struct udevice *sysinfo;
+	bool called_detect = false;
+
+	ut_assertok(sysinfo_get_and_detect(&sysinfo));
+	ut_assert(sysinfo);
+
+	ut_assertok(sysinfo_get_bool(sysinfo, BOOL_CALLED_DETECT,
+				     &called_detect));
+	ut_assert(called_detect);
+
+	return 0;
+}
+DM_TEST(dm_test_sysinfo_get_and_detect, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.34.1

