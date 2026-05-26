Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB4ACD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5548487C;
	Tue, 26 May 2026 14:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="n3KmAPNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C6948484C; Tue, 26 May 2026 14:40:57 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D602D84868
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=tgjjOYOe4KJ8/sf+eznQHx5AJ2q84ysH9SXQT+3HZHU=; b=n3KmAPNak41jC/kVRfMdLHB9kK
 XxZdA6Ggih54v4ZAYI4vwHaaTvJkZ3rA74Dht9rz+rrzVusFJuI5/ib/YuL8Gv69iej+mGDTn4TIQ
 HHS+8X6mQhgOcQ2vGey+poQj+Y2avd76rXKf3xbafHLt5HYKZH6P/m3RItszXKhkVw7HGWkZDBZ9y
 jnI0ZauOMC/02wjCGVfXj+KLDYuXY66bt139CWP4Dct/a0oW5qmzR5HkjqT9IoxYuWp4K7zScfYpX
 OekNTWmeG/uy4dIJ4Oyknsv071VQyewCB6c+4N40FB+O7GSmzc0ch49uRMmMQcdoHj4A68MqcN7Ge
 hW4knXyg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wRr5Y-000PJ5-1a; Tue, 26 May 2026 14:40:52 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wRr5X-000B1h-1k; Tue, 26 May 2026 14:40:52 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v2 2/6] sysinfo: add sysinfo_get_and_detect() helper
Date: Tue, 26 May 2026 14:40:40 +0200
Message-Id: <20260526124044.354578-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
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
 include/sysinfo.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/sysinfo.h b/include/sysinfo.h
index 54eb64a204a..f3ac5fdd2c5 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -373,6 +373,26 @@ int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
  */
 int sysinfo_get(struct udevice **devp);
 
+/**
+ * sysinfo_get_and_detect() - Get the sysinfo device and runs its detect
+ * operation.
+ * @devp:	Pointer to structure to receive the sysinfo device.
+ *
+ * This is a convenience wrapper around sysinfo_get() followed by
+ * sysinfo_detect()
+ *
+ * Return: 0 if OK, -ve on error.
+ */
+static inline int sysinfo_get_and_detect(struct udevice **devp)
+{
+	int ret = sysinfo_get(devp);
+
+	if (!ret)
+		ret = sysinfo_detect(*devp);
+
+	return ret;
+}
+
 /**
  * sysinfo_get_fit_loadable - Get the name of an image to load from FIT
  * This function can be used to provide the image names based on runtime
@@ -438,6 +458,11 @@ static inline int sysinfo_get(struct udevice **devp)
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
-- 
2.34.1

