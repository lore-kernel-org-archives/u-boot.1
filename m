Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13426D13564
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 15:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617CB89051;
	Sun, 27 Oct 2024 16:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=khoahoang.com header.i=admin@khoahoang.com header.b="XAKteiYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AC488CEA; Sun, 27 Oct 2024 06:13:36 +0100 (CET)
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com
 [136.143.188.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3751F889DA
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 06:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=admin@khoahoang.com
ARC-Seal: i=1; a=rsa-sha256; t=1730005986; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gouXq8rLMVlVOND2IKEW8l9qpCrAsDSgAxz6m7aIhHwIXaaC8MDjxz/feqNakbubQeAHX6ybZDkzWdKh9Kn3stxP8Vk6bymk1tfgHfjtTVQWTBKoMu5ku/UJE1yv8daVH/hJeBiD3vWRDderDdD37WmLFIBbiYP6GBr34NlFqm4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730005986;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/MOjq3K3U7hB+1rb1leJB+h9RD62zL5X4RZeFWYdlGc=; 
 b=RkI+QkPRxNgwsmmvURFaaI9EF0zjYWUtZXYEpqnvX/9ynBnnbBRknbP5uPEIPVuRs53D5AkHJsb9geAcA5Y2MWJES9NAI+SccUU+GbzxoYCKWZnqzkhIMZU2gcyj5Jvs63A9IhwIK88qZfHfGvftoW4H/LoGCzSHDDSCKvazf24=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=khoahoang.com;
 spf=pass  smtp.mailfrom=admin@khoahoang.com;
 dmarc=pass header.from=<admin@khoahoang.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730005986; 
 s=zoho; d=khoahoang.com; i=admin@khoahoang.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
 bh=/MOjq3K3U7hB+1rb1leJB+h9RD62zL5X4RZeFWYdlGc=;
 b=XAKteiYjd2MFSQuK49DgYAkMTzejBxxSRu4CwmfJ0w6gqeidZoouxpW+8UQZsvnY
 Scyr0mfhzkQ4ikgcNamw41U3iY8CnC78z5+I+mFXx8YV3ijCh5l1cqwBhJlhsQ3N8xr
 FEtdr+3oW3J/uCc5RwfsrjaeozV0fF/ibKOuXVg0=
Received: by mx.zohomail.com with SMTPS id 1730005984856320.0090046280545;
 Sat, 26 Oct 2024 22:13:04 -0700 (PDT)
From: Khoa Hoang <admin@khoahoang.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Khoa Hoang <admin@khoahoang.com>
Subject: [PATCH 1/2] eth: asix88179: Fix ASIX AX88179A PHY hang
Date: Sat, 26 Oct 2024 22:12:49 -0700
Message-Id: <20241027051250.35627-2-admin@khoahoang.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241027051250.35627-1-admin@khoahoang.com>
References: <20241027051250.35627-1-admin@khoahoang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Oct 2024 16:06:22 +0100
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

In the original code, the MII_ADVERTISE register is modified while
auto-negotiation is still in progress, which causes the PHY to lock up
with the ASIX AX88179A.

This patch disables auto-negotiation and resets the PHY before
modifying the MII_ADVERTISE register, then restarts auto-negotiation
afterward. This prevents the PHY from locking up.

Additionally, both AX88179 and AX88179A variants do not appear to
support the ADVERTISE_LPACK (BIT(14)) in the MII_ADVERTISE register,
as setting this bit does not seem to have any effect. While I do not
have access to the AX88179{,A} datasheet, in most Ethernet PHYs, this
bit is reserved as 0, so we should avoid setting it.

Signed-off-by: Khoa Hoang <admin@khoahoang.com>
---
 drivers/usb/eth/asix88179.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 4bd3b9d1..a856aa2d 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -344,14 +344,22 @@ static int asix_basic_reset(struct ueth_data *dev,
 		 AX_MEDIUM_GIGAMODE | AX_MEDIUM_JUMBO_EN;
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
 
+	/* Disable auto-negotiation and reset the PHY */
+	*tmp16 = BMCR_RESET;
+	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, tmp16);
+
 	u16 adv = 0;
-	adv = ADVERTISE_ALL | ADVERTISE_CSMA | ADVERTISE_LPACK |
+	adv = ADVERTISE_ALL | ADVERTISE_CSMA |
 	      ADVERTISE_NPAGE | ADVERTISE_PAUSE_ASYM | ADVERTISE_PAUSE_CAP;
 	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_ADVERTISE, 2, &adv);
 
 	adv = ADVERTISE_1000FULL;
 	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_CTRL1000, 2, &adv);
 
+	/* Restart auto-negotiation */
+	*tmp16 = BMCR_ANENABLE | BMCR_ANRESTART | BMCR_RESET;
+	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, tmp16);
+
 	return 0;
 }
 
-- 

