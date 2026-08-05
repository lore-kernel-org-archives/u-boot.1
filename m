Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C844C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 13:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C6F8607C9;
	Wed,  5 Aug 2026 13:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Phwr1navyYh; Wed,  5 Aug 2026 13:21:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E413E60674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785936112;
	bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z1KMOel0FxxagBF9KW6F2/kDwKNeKAZTQ/3Kn6fG24OvKWt/84yFlqznV0gE9Df6p
	 AeMChqWrE+EgwFuAAUz12zDZm0/1WC+KfA1929hNhQ0uk+wxmGyWAWwgG8rgmlIBpD
	 bNaioLKYXXfZiKPPhC5mQu5U4OtZsrc3gqkr5tXsW0xRJL0ru1u3gRcoCFbtJlKQqI
	 UO9IRepITgcpzKLGOWFp9D3GT6GMtsG98c2KUTg/zKysFHxx8/siYimacjCOVkBbtU
	 ylXhm65EWcSQYIk0hfnvtTy9FBxVH69oCMwGjnRapudaM1AVMv4eGsv0u8OhNEzeFg
	 b9tqEchwsGfjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E413E60674;
	Wed,  5 Aug 2026 13:21:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC642DE
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30ACE406A1
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SMDuG_EFlBXK for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 13:21:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=gregor.herburger@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 60C764068E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60C764068E
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60C764068E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:48 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
Date: Wed, 05 Aug 2026 15:21:41 +0200
Subject: [PATCH v4 2/2] rpi: pass the bootloader node through to the OS
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tryboot2-v4-2-6e6d755222a5@linutronix.de>
References: <20260805-tryboot2-v4-0-6e6d755222a5@linutronix.de>
In-Reply-To: <20260805-tryboot2-v4-0-6e6d755222a5@linutronix.de>
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785936106; l=2068;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=TLV9C6neprJnZcXnK9YYoU52ziIohQRBaAaA79J03iw=;
 b=d6AAWv4xao9NG33iR352ZK1o3x9wWEVQ1XMU4PQKCyPCpHcSkYj8T32HAQIP5O5Pyo6hG+J+Y
 IM0abkDjl8TDvPppQzX4kNpnDBCcDC0VxsPUJcGLqSV0lTRlW8A49jO
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1785936106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
 b=MkI3JPN21exOeVQY3l0ZBxDkMs5vple9K7yn/0CJxiK/0q9yEXvK7PtJTAmrZYDcDZKOaN
 G6gC4LyjMRAu3Hd3JpCp+AFI9fQz9mJJsJzzFrcTqquGmi6KC64SyeefTWK7/4cXzu7C5z
 RZmTC0ZizhRtEu//672mxO1sJRM1qXTeOvV/9bsZJKJvuYoPjZEsHPhphtIwGQaAHTpBDt
 MSXkh2efDEf/pXftTu9a2RWpmCZ2LeQItZXiZ85j3uWdnUGbQbwMuBwjSGKtxl6s5HTD8k
 WgaYyrxJlOJa2NZp7LNPRdfUNyUUhnnDv601gFkkXAg3KHLu8X6O19oefE81/g==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1785936106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
 b=+ypuCYgVNFWu3Ur0kCBdHgLjR8hGyU48bkDwaVktWvjYkO8J75dQI5xprh/knMVSb3qW66
 RQLOCmele18GYLAA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=MkI3JPN2; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=+ypuCYgV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Raspberry Pi has the "tryboot" feature where it can boot from a
different partition enabling failsafe A/B updates. After boot the
firmware adds some properties in /chosen/bootloader, e.g. partition.

Copy the complete /chosen/bootloader node with all its properties to the
OS device tree.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 8354fec833cc..ba8a2c1ba4cf 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -594,6 +594,39 @@ int board_fdt_blob_setup(void **fdtp)
 	return 0;
 }
 
+int copy_node_all_properties(void *dst, void *src, const char *path, const char *node)
+{
+	int src_parent, dst_parent;
+	int src_node, dst_node;
+	int prop;
+	int len;
+
+	src_parent = fdt_path_offset(src, path);
+	dst_parent = fdt_path_offset(dst, path);
+	if (src_parent < 0 || dst_parent < 0)
+		return -1;
+
+	src_node = fdt_subnode_offset(src, src_parent, node);
+	if (src_node < 0)
+		return -1;
+
+	dst_node = fdt_find_or_add_subnode(dst, dst_parent, node);
+	if (dst_node < 0)
+		return -1;
+
+	fdt_for_each_property_offset(prop, src, src_node) {
+		const char *name;
+		const void *value = fdt_getprop_by_offset(src, prop, &name, &len);
+
+		if (!value || !name)
+			continue;
+
+		fdt_setprop(dst, dst_node, name, value, len);
+	}
+
+	return 0;
+}
+
 int copy_property(void *dst, void *src, char *path, char *property)
 {
 	int dst_offset, src_offset;
@@ -656,6 +689,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 
 	/* copy uart clk as provided by the firmware */
 	copy_property(fdt, fw_fdt, "/clocks/clk-uart", "clock-frequency");
+
+	/* Copy the bootloader node */
+	copy_node_all_properties(fdt, fw_fdt, "/chosen", "bootloader");
 }
 
 int ft_board_setup(void *blob, struct bd_info *bd)

-- 
2.47.3

