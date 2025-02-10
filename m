Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06642C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E19DF80B98;
	Mon, 10 Feb 2025 17:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RuPg7b/3";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="KTK34Nji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F4E803CC; Mon, 10 Feb 2025 16:30:00 +0100 (CET)
Received: from a7-44.smtp-out.eu-west-1.amazonses.com
 (a7-44.smtp-out.eu-west-1.amazonses.com [54.240.7.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDAC3807B1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020194f07b459d-184820e6-90c2-44fe-9850-f57fc2ebaafe-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1739201398;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=YlFfI4bEDx3IXs527f2I/EURFsvLrXobIvoBnZz0LY0=;
 b=RuPg7b/3LwWD6/jhX1xYPxGXpbaxBN5M5fY0lIBfrjSXowKps3pSWKDPEAHNiul3
 ptZl0Kxjh6ZnDZamgjhC1YL7qar/Jm3KdR66aeiyQN+aPHfRA2NeGbV9SSSKmKm4Jf7
 5vBV+LiChsh7Yc1v3uOrJZz7nK26s6B3Qu3E5kGN1gfpdKIdRXGlg3IZWzMpirQHgg/
 Uwv7NyZ8rbI74xUUptyvNVDaO1yck2dg9ynkmHZvjxFtNvSea1afVYcUsqt3xqxUetu
 AkHZg5I9UzRoYV5F4AR/Xh0aQ1taov8ZpaDVnSdtg8lylzNqPL45kQ1y9+Fgy95RJCf
 vfGiuHk/QA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1739201398;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=YlFfI4bEDx3IXs527f2I/EURFsvLrXobIvoBnZz0LY0=;
 b=KTK34NjiDP702FI08BVgF2s7Xru9OsCduUePeraCshlLlDQUr+pMYqcRBOyqlJPh
 16orl/6tNUKuO/JaRsQFQOqRFCVlL7vpp2dEwnYMmu0G16Pt7/KDaqk9AbYe1enmTWV
 D020uU62ADj/+zbsPu1yQJNVpsl9JVWbkuVlpIDs=
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] drivers/Makefile: Fix TPL build with dwc3 generic
Date: Mon, 10 Feb 2025 15:29:58 +0000
Message-ID: <01020194f07b459d-184820e6-90c2-44fe-9850-f57fc2ebaafe-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210152947.3909357-1-arnaud.patard@collabora.com>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.02.10-54.240.7.44
X-Mailman-Approved-At: Mon, 10 Feb 2025 17:47:57 +0100
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

When building TPL with DWC3 generic enabled, the following error is
occuring:
aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_bind_common':
.../drivers/usb/dwc3/dwc3-generic.c:527: undefined reference to `usb_get_dr_mode'
.../drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue_bind_common+0x20): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
aarch64-linux-gnu-ld.bfd: .../drivers/usb/dwc3/dwc3-generic.c:529: undefined reference to `usb_get_dr_mode'
.../drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue_bind_common+0x2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_probe':
.../drivers/usb/dwc3/dwc3-generic.c:683: undefined reference to `usb_get_dr_mode'
.../drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue_probe+0xb0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
make[1]: *** [scripts/Makefile.xpl:544: tpl/u-boot-tpl] Error 1
make: *** [Makefile:2137: tpl/u-boot-tpl] Error 2

Enable building drivers/usb/common.c in TPL.

Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
---
 drivers/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b..7cee5750396 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -78,6 +78,7 @@ endif
 ifdef CONFIG_TPL_BUILD
 
 obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
+obj-$(CONFIG_USB_GADGET) += usb/common/
 
 endif
 
-- 
2.39.5

