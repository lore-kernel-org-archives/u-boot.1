Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7BCCD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 09:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAA8846FA;
	Wed, 27 May 2026 11:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QueIwrjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1314844CF; Wed, 27 May 2026 11:52:30 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2612F83FF5
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=upJDW/4llexDWY9pThnB0ehtHLHQe/h2Zk1+KQrBmy0=; b=QueIwrjC7d+nPVHk786abtjMo3
 Hy5v8zox03z3C8OXzcN2h0FvsuCG0voRE1F8k3E+53n0gCANdHqZ+L419AtCCA1gSJxiD0a2VEzuv
 hFpxBFU51X6G6VhUZmvttN0+CvTXvXCuOwdYIs2Yw9VSQhSQ1P96QPTBhzjnccuv6xdcmtwjqMKRv
 lZ/Xoy5TkfNKWKlqzhL+4a7sWPdU2Ob700V5YOXtHqmoXMqDFL7CIaAEcDbDmlgOENdoVKzjMtaMe
 xjNgtfRk/fUgMfeDEzvE6ZwSFJSDt8OwH8fyoDmUwWX8J07Y5S0gypfEvGNkeLqMxI5QooIoyvLUh
 EqOlbYNA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw4-0002RZ-3D; Wed, 27 May 2026 11:52:25 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw4-000JXI-0D; Wed, 27 May 2026 11:52:24 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v3 2/7] sysinfo: add sysinfo_get_and_detect() helper
Date: Wed, 27 May 2026 11:51:18 +0200
Message-Id: <20260527095123.50797-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
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
index 54eb64a204a..7fcc3e273be 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -373,6 +373,26 @@ int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
  */
 int sysinfo_get(struct udevice **devp);
 
+/**
+ * sysinfo_get_and_detect() - Get the sysinfo device and run its detect
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

