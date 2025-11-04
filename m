Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D68CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E2F8391C;
	Tue,  4 Nov 2025 19:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="Y6bzq+Kp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 928F78003E; Tue,  4 Nov 2025 15:51:20 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEA28389A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 15:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=igor.belwon@mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=Y6bzq+Kp/XZaI5S4SEMqkhYrBxLoyjH2G18kl+7vsLgNdp7ti9wQrMmHF8jU9ihABECqaLKZ2UHSM01kZo4wL2+cjZCWq7zqMZZz9377hZAjx3pjzNDg7FrpWGgehanrct3n5Ag4ckfqhhK8zJ4O3MzNjQnbd2vcn/sqtfNdCeZMPvWMRHKremIrHcLzvF6QusZCwswQlKHqq9MrqvffVZSxLGJRKlEjsvlq86kSQ5JjUsyDD7rZb/jk8YsfQJJzpKLtGzJuqYQQGTL4yf7TTX8oTMoLGeyV9BHjDUJzg+sGRKbn+Wu8vMEeMd2Y41g5KuQvSvJLh2+Z+Gge/Wi18w==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=VhGe73EPSnP2jMr/q6Uf1REukRsfaZsceDNL5syPkNM=;
 h=Feedback-ID:Received:From:Date:Subject:To; 
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1990521561; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 04 Nov 2025 14:51:11 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Tue, 04 Nov 2025 15:50:36 +0100
Subject: [PATCH] video: simplefb: Add stride handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-sfb-stride-v1-1-698d419a8be1@mentallysanemainliners.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMT3eK0JN3ikqLMlFRdY0tzSyOzJEMDM8sUJaCGgqLUtMwKsGHRsbW
 1AKR6dPVcAAAA
X-Change-ID: 20251104-sfb-stride-397926b1069d
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762267870; l=1485;
 i=igor.belwon@mentallysanemainliners.org; s=20251104;
 h=from:subject:message-id; bh=VhGe73EPSnP2jMr/q6Uf1REukRsfaZsceDNL5syPkNM=;
 b=fhjuUo3KyMvp04QUm8+mY1PR4O65wHR2PXs09rUPsE3+MWEdblVwDPWaFgA/TO4sWnQRg2ykR
 aMqJKW2s5DrDWRcsXclskt+CZrsn3kHoAlfGWWwrt+aqDTr44ql0cLy
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=i9++1bbnBwoyc3uhTaetGXS1TbBJoS0mcxT59GrpYh0=
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:32:24 +0100
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

Some framebuffers (i.e MediaTek) do not have regular stride - its line
length is more than the display width by 8 pixels (on MT6878). As such,
introduce the optional stride property, which fixes these framebuffers.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 drivers/video/simplefb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 239b006744d8deed758da95f9c41c0d59dbb48d1..8d0772d4e51ebba3d8a66cd35ae2660d3ac859c1 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -19,7 +19,7 @@ static int simple_video_probe(struct udevice *dev)
 	int ret;
 	fdt_addr_t base;
 	fdt_size_t size;
-	u32 width, height, rot;
+	u32 width, height, stride, rot;
 
 	base = dev_read_addr_size(dev, &size);
 	if (base == FDT_ADDR_T_NONE) {
@@ -52,6 +52,11 @@ static int simple_video_probe(struct udevice *dev)
 	uc_priv->xsize = width;
 	uc_priv->ysize = height;
 
+	/* Optional - in most cases, auto-calculation works */
+	ret = ofnode_read_u32(node, "stride", &stride);
+	if (!ret || stride)
+		uc_priv->line_length = stride;
+
 	format = ofnode_read_string(node, "format");
 	debug("%s: %dx%d@%s\n", __func__, uc_priv->xsize, uc_priv->ysize, format);
 

---
base-commit: c9fdb9ac4d5234953ffaaef0cfc9d4ccb03f0ce5
change-id: 20251104-sfb-stride-397926b1069d

Best regards,
-- 
Igor Belwon <igor.belwon@mentallysanemainliners.org>

