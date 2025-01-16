Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA212E77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FA58033D;
	Thu, 16 Jan 2025 05:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000339;
	bh=BC1hFDQ6cqse32agj7/r9fvQHJYYyW+urmYbe/vGRAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZigVza5mRXUpI7B0bXbkSizqCZqrpMfF34A7p1IKDpOmlaK6b+JIpD9BuPMWzPvIW
	 mbpMKu/fUoNksJREZu/bvMlWf4f+VgoFkUHgpxnQEq3lSZgVvTZPFDWvBq6TvCNSqy
	 DaVr1RpwoStBzQKswWD6iXCD6LHZqgYTGWhVhqC736Tsnk389+7IdoGj66NXfopqOY
	 afbIb2rtqKVRt5iVqVsLdNd0HUPB/BZCoHvnask44Nl2ot/3F97DKyMQH4IdDDOeKJ
	 76tdbQnqhF/nfNIJrpsvEEzg9kMcb8yEvLOCVg1k1hWGIH63trYYla8Q3mj5yIh3/Z
	 3476NiDiKi+fw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF4E806D4; Thu, 16 Jan 2025 05:05:37 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F8E80658
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gqa2Jkpp"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9AC5810936A0E; Thu, 16 Jan 2025 05:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BC1hFDQ6cqse32agj7/r9fvQHJYYyW+urmYbe/vGRAI=;
 b=gqa2JkppDz+kvPT8fCMnCAyYx1wI5HQsac/JFXiWLS3Q38/ghpG0XPMLrxjzxQ4hWEfpE1
 /p3hLI/mpw5FAMeTCGQ9SyqIt+h6+RN4kIe5CqoPWrCYS1I3YdvNxn98YsbMzyBhfq4n86
 c87bVeK3I5dcsHXI9fYS+qRjpDThOfl8UYvhkivQtFHX04hSgQIQXNjJEEfI4fdfqt7+9O
 pWxHb0gB6elYrHiwShVNZWl+aLaMVcoGDmSLDrQcvbkdReKmHwzPzU4yh+J09ptqo7vRH4
 5Htbzbo9H/yHckTZvlFaQTczNhdOzSHizbwLvCC+kSKp+PRTAZpAPMi+qCaNZA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 02/13] net: fsl_enetc: Remove ifdef around
 enetc_set_ierb_primary_mac()
Date: Thu, 16 Jan 2025 05:03:19 +0100
Message-ID: <20250116040449.306098-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116040449.306098-1-marex@denx.de>
References: <20250116040449.306098-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Use enetc_is_ls1028() instead of ifdef around enetc_set_ierb_primary_mac()
and clean up the function. No functional change intended.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Markus Gothe <markus.gothe@genexis.eu>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Romain Naour <romain.naour@smile.fr>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/fsl_enetc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index d1414167723..fc51647257e 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -36,29 +36,29 @@ static int enetc_is_ls1028a(struct udevice *dev)
  * sets the MAC address in IERB registers, this setting is persistent and
  * carried over to Linux.
  */
-static void enetc_set_ierb_primary_mac(struct udevice *dev, int devfn,
-				       const u8 *enetaddr)
-{
-#ifdef CONFIG_ARCH_LS1028A
-/*
- * LS1028A is the only part with IERB at this time and there are plans to change
- * its structure, keep this LS1028A specific for now
- */
 #define IERB_BASE		0x1f0800000ULL
 #define IERB_PFMAC(pf, vf, n)	(IERB_BASE + 0x8000 + (pf) * 0x100 + (vf) * 8 \
 				 + (n) * 4)
 
-static int ierb_fn_to_pf[] = {0, 1, 2, -1, -1, -1, 3};
-
+static void enetc_set_ierb_primary_mac(struct udevice *dev, int devfn,
+				       const u8 *enetaddr)
+{
+	static int ierb_fn_to_pf[] = {0, 1, 2, -1, -1, -1, 3};
 	u16 lower = *(const u16 *)(enetaddr + 4);
 	u32 upper = *(const u32 *)enetaddr;
 
-	if (ierb_fn_to_pf[devfn] < 0)
-		return;
-
-	out_le32(IERB_PFMAC(ierb_fn_to_pf[devfn], 0, 0), upper);
-	out_le32(IERB_PFMAC(ierb_fn_to_pf[devfn], 0, 1), (u32)lower);
-#endif
+	if (enetc_is_ls1028a(dev)) {
+		/*
+		 * LS1028A is the only part with IERB at this time and
+		 * there are plans to change its structure, keep this
+		 * LS1028A specific for now.
+		 */
+		if (ierb_fn_to_pf[devfn] < 0)
+			return;
+
+		out_le32(IERB_PFMAC(ierb_fn_to_pf[devfn], 0, 0), upper);
+		out_le32(IERB_PFMAC(ierb_fn_to_pf[devfn], 0, 1), (u32)lower);
+	}
 }
 
 /* sets up primary MAC addresses in DT/IERB */
-- 
2.45.2

