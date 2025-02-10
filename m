Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B50FC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4124F80BAA;
	Mon, 10 Feb 2025 17:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ijsXTK1a";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="BQjYv5dM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D4780821; Mon, 10 Feb 2025 16:30:05 +0100 (CET)
Received: from a7-31.smtp-out.eu-west-1.amazonses.com
 (a7-31.smtp-out.eu-west-1.amazonses.com [54.240.7.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB1AE803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:30:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020194f07b531d-9000caf1-993c-46d4-879a-8c7374167311-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1739201401;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=g0DlYwRUZbymTehm50N1rHw9JdkqI0CRrPvVj5mdWAw=;
 b=ijsXTK1a50RZkMPxzr5izF8H+idF3N10pvKsTxh3QYbSobW+I51ijDg0hr+jrki8
 NVwhgD9z6B2tgytDwYC2SfErfi7GAV+AEu8QwouVI5K0HTuZwWdy4TF3rDNzs9G9SYV
 fLMLfgPwo4MJTyqsiXUpu1R8R4hoI2T0NexDz2l5yAYRmX247hCXK1ZKsderoVdCeWP
 ArPKOk0N7qBKl4Y716qAELrl2O63ZP6QWlBvz6xp8lLVQiDHJBxDI0v+33m70wSWLP4
 0W6vYF94FcnYvDdlY6hce07OxdUKNJgsYgk1ikLRuKQid5B4CBMZxsb3Tyc7bX2QyLE
 24CBo8IPQw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1739201401;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=g0DlYwRUZbymTehm50N1rHw9JdkqI0CRrPvVj5mdWAw=;
 b=BQjYv5dMG9AORBGJULVZrLa0wGlySkCQfSHbp5U+OgLMlK05mhYvB9Nf5sJ3rujl
 NXW2K8nue1jqevG/W6aJkK8CEjB0kELKAvpxY9y2rOm0QqtepVJR8GcjMn2M68TOyTi
 sLB6sHkhSmC3csZYj54LpS4VPWypVjp964dvwodI=
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH 2/6] arch/arm/mach-rockchip/spl-boot-order.c: Add DFU boot
 media
Date: Mon, 10 Feb 2025 15:30:01 +0000
Message-ID: <01020194f07b531d-9000caf1-993c-46d4-879a-8c7374167311-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210152947.3909357-1-arnaud.patard@collabora.com>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.02.10-54.240.7.31
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

Make it possible to boot over gadget.

Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
---
 arch/arm/mach-rockchip/spl-boot-order.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 3dce9b30898..7cc410d0ae7 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -75,6 +75,9 @@ static int spl_node_to_boot_device(int node)
 	if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;
 
+	if (!uclass_get_device_by_of_offset(UCLASS_USB_GADGET_GENERIC, node, &parent))
+		return BOOT_DEVICE_DFU;
+
 	return -1;
 }
 
-- 
2.39.5

