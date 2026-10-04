Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1BBCA5FF0
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 21:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A9F680D88;
	Sun,  4 Oct 2026 21:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gwRyUy5A0zEB; Sun,  4 Oct 2026 21:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6BE7280BD4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791150810;
	b=ekBhl3UZmoG1rITb5gJ2GqZUVd6t36IB97QC7EXQxQ96eaM56A/coCvJp4JcrE1tb0X1
	 GTc+MCm7yQBKb0WNzfhcDepzt/A5suPcQxzyXDzWbPsNtl2phCmQkV8KadD2i+SHSEOAU
	 MydS9oLFnOPQp63N8mB/mLjjxMBUymNVYsWLFbniaNUa2O0AFE2urwvz4C53mjwBuLZSe
	 ZgNxqSomlWezHsF3iEaD1BpV0G8RBu05pqM7iTRXxPufaBomzUrVf8lISg9o0x5A+Q//R
	 S4NJwIEV2Rg7W36j5x5RcF7J2tWlOQho1oPcX5r7xVUEacVWW4P9ysmIkUvbKt4KDdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791150810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eegrl2CXAUIVBheWmWGh6zZWpa1mwa3Fwz5taahK5xI=;
	b=St/k0gq+oUYY53jVL6QxHzSUyhjapFEvxK1GhlRpMJ4XkIaFDFtrY1NyxZDYFFIgWrEO
	 R9XJsOb00eea91Ekyon70B8/htxvnxHJSPXpBFUB6o9+hZFehdX0G7oOwKtVuMnXU+cdV
	 AHJ4zkYgxf5NnZxeim8czMvIZu4IgtjhXeBo0y4pgVCiW3TfMnxDJfIsKRGo7hDAMrXkq
	 DuvN3EyLj9Z0eNk8Pe07y+OPE2lKOUkAIe0QP/wmfKP8XQ0bVQSCwFxIoIbo2XsNzxdHC
	 f0OrFAmenswLF9OBayCDTtuNyMVXTd4h/x3EFQ7unJ3BDBmkoh43T+Q0j+fj4h9ofHQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791150810;
	bh=eegrl2CXAUIVBheWmWGh6zZWpa1mwa3Fwz5taahK5xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xjPB+JJl4/+fXzyfWteLxEtX0znqsQWW5qUjJxHvK3KosqR9c2wj/+9fZ7cqeQasc
	 lU3L+BIHg5p4L7R5N4fLtXWpOFqsHOLGNtbPbDjDXXlAMKuvE8u5DVj1L3HeS6DYNi
	 eY3qV+j1iP6K/leFFIaZpjTnvAdd6dlSWIXK61+CpxEV2BJtpUOpnI9nnMutRSIgTa
	 gKkmlyezJI5ENTyzsg8S3vn4howFDHcrKv8HQhZc2N6seZQn5sltd7KnFVXJI7MXlV
	 8Xpi6jmXZEJDAilEc1FnNiOggCPJKUVU/rn8QLHtAtcm5kNuSNQx2Af6OHp9fSAatl
	 LiWYl+gwrmuaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BE7280BD4;
	Sun,  4 Oct 2026 21:53:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AB101A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CB4840049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0iDYlkV7-Pc for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 21:53:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C5CCD40004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791150808;
 b=jhAG4KdnptlfSn2t6dnFBLr4f5Y94G1gY/+K5yyQXQypHiNw/jmUPyF/lX+TPlGRfyRb
 +SpfOtAdabPF+fcINuWnfadWKgbgrQEdh1mhOKlB+IEy06YNHgX+K7RV80fro4SQaKM6B
 OREjRmxVEFRj/TxDzQ/LHA9YngXaL4U0BP2FxwpDMbDh41zON5SAsoSr68uWBT0Mc93xf
 +gZSV2tSHqMtBd79Gkb2fq16XGMW1twbUZ9kZ4ber0uvQbsIDDpk+rtIEkeeszt52giPH
 9ddTyd1hUVxv4s1N2SS5z1KgIan8YQBGLATAeYCrYAyJwSHiDlKegVGGENTTzfVv1iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791150808;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=eegrl2CXAUIVBheWmWGh6zZWpa1mwa3Fwz5taahK5xI=;
 b=NsEuX9O3DgFWt/VqdaTRJYTZyBq5SH91WkYLAaPQnbkJZlQLh91sfP8F33pX0lDINJli
 31Xfjllc4y6k1Q4sU962qccd6nglufI2tDniqbgmspUOlJx8Lhn+uP22IMCSVKb/MffXm
 x1zufvj1O56A2OGomHRSKzby58xfAX/VZFf7m6WaEsQ7b/L9yr5+VjzBWbQKGFW33yJNb
 mf3DFjQbK2KEjN695ISlY1GIbdnNDsyvZFsB+ii0fTuo6okq7RROPUt624wtztHP1cpXR
 PcnI+A37z1Y3GaVGshhMyXSuo7n5od82M1wbwu0GlZneAzPRYZJ2sZiomqnhQZQLtbg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=htaMDAQL; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=htaMDAQL
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5CCD40004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791150806; bh=eegrl2CXAUIVBheWmWGh6zZWpa1mwa3Fwz5taahK5xI=;
 b=htaMDAQLtB14awFXN4PmtKv47JB8PCswtO8F98HT8dxvN496hMtHUWNSz4SC86Ogzio4o/Jl5
 cQVrxG/Bs4Qd8s8Wyl7zcr2P9v4bs3pXGQ2gCiVCPr8gju09hEVpbzMZDmcDDkKwqK2bibGbtC5
 D72/v/YBsmWSoLn5QF1v3JMwsAQr7M4DIB2g9myJZw9qmcMlt3MxiebpveSkbjgo5Cms3hlyyvR
 EMZBDPQOfASZFsVGzaV7RcJh53IOOgqVKi1etfgj1avH0MJVPO3GTjUJscn8Ayuf9aSk3d6XqYw
 qyVBSsHka/6phnpQbdaQpo0xMasdB9seErx9KLgsKHiw==
X-Forward-Email-ID: 6ac2cad45dbe246f1b817a66
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] net: eth-phy: Add reset control support
Date: Sun,  4 Oct 2026 21:53:17 +0000
Message-ID: <20261004215318.65492-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004215318.65492-1-jonas@kwiboo.se>
References: <20261004215318.65492-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add support for Ethernet PHY reset using reset controls.

This closely matches how Linux handles Ethernet PHY reset using reset
controls, initially introduced in the Linux commit 71dd6c0dff51 ("net:
phy: add support for reset-controller").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/eth-phy-uclass.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
index 7c60b3e57975..a13e2fc7c50a 100644
--- a/drivers/net/eth-phy-uclass.c
+++ b/drivers/net/eth-phy-uclass.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <log.h>
 #include <net.h>
+#include <reset.h>
 #include <asm-generic/gpio.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
@@ -18,6 +19,7 @@
 struct eth_phy_device_priv {
 	struct mii_dev *mdio_bus;
 	struct gpio_desc reset_gpio;
+	struct reset_ctl reset_ctrl;
 	u32 reset_assert_delay;
 	u32 reset_deassert_delay;
 };
@@ -139,6 +141,13 @@ static int eth_phy_of_to_plat(struct udevice *dev)
 			return ret;
 	}
 
+	/* search "resets" in phy node */
+	if (CONFIG_IS_ENABLED(DM_RESET)) {
+		ret = reset_get_by_index(dev, 0, &uc_priv->reset_ctrl);
+		if (ret && ret != -ENOENT)
+			return ret;
+	}
+
 	uc_priv->reset_assert_delay = dev_read_u32_default(dev, "reset-assert-us", 0);
 	uc_priv->reset_deassert_delay = dev_read_u32_default(dev, "reset-deassert-us", 0);
 
@@ -161,6 +170,13 @@ static void eth_phy_reset(struct udevice *dev, int value)
 	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&uc_priv->reset_gpio))
 		dm_gpio_set_value(&uc_priv->reset_gpio, value);
 
+	if (CONFIG_IS_ENABLED(DM_RESET) && reset_valid(&uc_priv->reset_ctrl)) {
+		if (value)
+			reset_assert(&uc_priv->reset_ctrl);
+		else
+			reset_deassert(&uc_priv->reset_ctrl);
+	}
+
 	delay = value ? uc_priv->reset_assert_delay : uc_priv->reset_deassert_delay;
 	if (delay)
 		udelay(delay);
-- 
2.55.0

