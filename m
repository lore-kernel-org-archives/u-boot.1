Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC49CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E28284C63;
	Fri,  8 May 2026 10:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Xcp7cvnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2376184BD1; Fri,  8 May 2026 10:48:54 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1B384C19
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=FmW6PIlps73Dbn9zGjS17eDeKI1tz1mfkcXyQa60sJg=; b=Xcp7cvnEQUqdPl17N8kXkPTOBI
 tMwqEqNI4EqEbyZnrW4qXNm1iBC+FtCuPymEbOm4TDGA8zDEe/aOKIJbMcD3dzW3GgJ8Yg0SRjpcD
 MGrkF8tQsElKCGlYX8cIQng99tistsQcbt95OPDiEIorKU9j1lYn2FYBa/RfL85LohnDy61WUVnw/
 vPrVmv7DOvRWnDg1GSFChxS/e1Gp52JJuiQX8N+QyDu+MfQyKCnoqdX7ydivBbzQZjooc404ZwGlR
 bYhbQEh51jQ69D9J4tisi0rOKqgTg7sY+AQO5yuzRnIt/0KkN2DTg39q+l/XoHDRc7KaNLp1ltitR
 eyyZShcw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGt9-0009ZZ-0P; Fri, 08 May 2026 10:48:51 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGt8-000KsG-0i; Fri, 08 May 2026 10:48:50 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 2/6] sysinfo: add sysinfo_get_and_detect() helper
Date: Fri,  8 May 2026 10:48:30 +0200
Message-Id: <20260508084834.45637-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
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
 include/sysinfo.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/sysinfo.h b/include/sysinfo.h
index 54eb64a204a..026ea393730 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -446,3 +446,24 @@ static inline int sysinfo_get_fit_loadable(struct udevice *dev, int index,
 
 #endif
 #endif
+
+/**
+ * sysinfo_get_and_detect() - Return the sysinfo device for the sysinfo in
+ * question and runs its detect operation.
+ * @devp: Pointer to structure to receive the sysinfo device.
+ *
+ * Since there can only be at most one sysinfo instance, the API can supply a
+ * function that returns the unique device. This is especially useful for use
+ * in sysinfo files.
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
-- 
2.34.1

