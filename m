Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E70CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 11:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83CD98486D;
	Tue,  2 Jun 2026 13:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DnXuCfzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F5C84898; Tue,  2 Jun 2026 13:58:17 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C9084868
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
 bh=ClMbfzl8oFl2LKkzKOLah+O52T3miJkH4bUmCVF4jeU=; b=DnXuCfzBrDlxM0FD5Hg1FzULVf
 ZFWd6WezT2QiZlWxjSPTV1aPGEh6yWGy0aywRUast9axvSspTR0VAQXxzE3piQsrqhHZaFDXaSQJM
 YL1ZAwNyxMAyt97UbgNHPyMw7uz3GERmWMqyetEBEG5TJl94oBs8CYpvrTXpUFxlx2H0NTJrJR0U4
 UOADBjMdpVosFpp3Sho7uo3LR3WukXhk+SvJW25as6oM9R1r2xw3qmM2uHfG247xEWgcEJ8UGBywl
 Z+7CFwIbimj4Ws4+MzsNRzQfmMM79y74H/i1KQVp2wR+AwhnEoex2kmQrBHJRbHuxBMwPrq1nyqB7
 /3hIeGwQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl5-000Lhq-26; Tue, 02 Jun 2026 13:58:11 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl4-000J89-1c; Tue, 02 Jun 2026 13:58:11 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v4 1/7] sysinfo: uclass: use sysinfo_priv size for
 per_device_auto
Date: Tue,  2 Jun 2026 13:57:49 +0200
Message-Id: <20260602115755.371164-2-Alexander.Feilke@ew.tq-group.com>
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

Reference the struct itself for the size as it is more robust,
even if it contains just a bool at the moment.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/sysinfo/sysinfo-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysinfo/sysinfo-uclass.c b/drivers/sysinfo/sysinfo-uclass.c
index f04998ef8bb..bf0f664e8dc 100644
--- a/drivers/sysinfo/sysinfo-uclass.c
+++ b/drivers/sysinfo/sysinfo-uclass.c
@@ -152,5 +152,5 @@ UCLASS_DRIVER(sysinfo) = {
 	.id		= UCLASS_SYSINFO,
 	.name		= "sysinfo",
 	.post_bind	= dm_scan_fdt_dev,
-	.per_device_auto	= sizeof(bool),
+	.per_device_auto	= sizeof(struct sysinfo_priv),
 };
-- 
2.34.1

