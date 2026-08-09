Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D5CC5AD56
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1983405A5;
	Sun,  9 Aug 2026 01:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FkFek4tl9_C; Sun,  9 Aug 2026 01:43:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8AF640597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239792;
	bh=xbRdiY5beTK2j7uG0t00QPyRIvlknz81igqCuUCJVgQ=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hhhAVi9F6DBIn4w5SLgaNTIKkRKxAsomhO/r4tW02LROXbpC3lST+6antrCfUOCPe
	 5jYEYIxvco/TGIyJnuD1MU7lZ6MqTGO8MCQ3fd0jFsWk9Jacb0KKR6K8lx/OcLA2k3
	 UUl7DyAmUSmXVaqC3byjiPBMuoqeZ6EQMzeU5q/CGP9I8JETkcmbfrOYuwRS5qPnKG
	 XNQ3Nc3U/CCfEnDNO8O2qOgPOwiy45g270aBoejsAtwSNZ4PUtqetMRXxmFKEHp6ln
	 /NslsILDU+aEPsrS1dfJDjQnv1bgdlq51u1Zjl5zj02v1Ej+D1IjVEEs+yTevYou2l
	 vcXrdS+p0LB7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8AF640597;
	Sun,  9 Aug 2026 01:43:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B33922B6
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99ADF400D3
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jraytj-dZbkm for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:43:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 92B9740068
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92B9740068
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92B9740068
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:09 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hHgd74MkczKrqk;
 Sun, 09 Aug 2026 03:43:07 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: renesas: r8a779g3: Add bootloader update
 environment on Retronix R-Car V4H Sparrow Hawk
Date: Sun,  9 Aug 2026 03:41:41 +0200
Message-ID: <20260809014258.447774-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809014258.447774-1-marek.vasut+renesas@mailbox.org>
References: <20260809014258.447774-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qz98zbgp38sza3gi44c933yd8h7uqbh8
X-MBO-RS-ID: 387ad2bdaa5b92cc5cd
X-Rspamd-Queue-Id: 4hHgd74MkczKrqk
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbRdiY5beTK2j7uG0t00QPyRIvlknz81igqCuUCJVgQ=;
 b=svhYexorNqMJSl2ynIzLg+sV6cgzN3jqGiIp4rSYwMUUFFB5hsTLnqQoQSEjVscxrYZ+MD
 4GPvHmFnz82mu6Fw9QuaJMuS7ZKgC1ccQRf9HnRSQOKD737FF7iYOokD1ew+XQRQXGIxeJ
 EUpSi5Rxcb7W4yPPsiDIdGI42zbSULQkYgROcSdURWw2hWLzeQb/jsrU/gXYZJ8/u/IS5A
 uFzExe9omet7GhsKRoeRufyIg+erOUQIvNC0b+LqnNfGHP+zvoodLGQoq3CZ18Q7IMhBxb
 HBqyYyU0P8NPywnIU6BQMAO1uFQU5sB3PrCtAPZfSwM3ghMxzllBxZxDQWdn0A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbRdiY5beTK2j7uG0t00QPyRIvlknz81igqCuUCJVgQ=;
 b=EoI5c8YmhDMzpD8opyNygENmWv9mQMeymeo4YE09j1HVj0CObijmijHbgVuLnxZH/3+fJz
 xnFm3cJ6lf/Gt4PXO/O/1iyaH3LsLxiBX4fd7KfFI9RtKJKP3fpD+c3SuW/p1BG6H7Kd7l
 nvkeX/ZJSvvHZnerlaW5ipRSr3Ot1ep45COnAoU2iFuxOKy/RGRhuME64aimWpXV1ASc63
 jurpkslFB3hosScEbEaMftDp5abIwqPHUslSPXvGAAi3rtWMfniK+Sg9y3KwgN7rm0DXGw
 7/FvwY0MpbQ2TjKU45qylj6fV2m7ZCZxbKEaM8BFPsU4bRVIdyY6WvMRk+/MBQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=svhYexor; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=EoI5c8Ym
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EoI5c8Ym;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add bootloader update environment to Retronix R-Car V4H Sparrow Hawk.
The "update_loader_from_{mmc,nvme,usb}" script updates U-Boot "flash.bin"
in SPI NOR at offset 0x0 from SD card, NVMe SSD and USB mass storage
device respectively. Each script sets up parameters for the generic
update script "update_loader_from_blk", which can be used to update
the "flash.bin" from any block device. The parameters are these:
- renesas_update_loader_iface ....... Update block device (mmc, nvme, usb, ...)
- renesas_update_loader_dev ......... Update block device number (0, 1, ...)
- renesas_update_loader_part ........ Update block device partition (1, 2, ...)
- renesas_update_loader_filename .... Update file name (flash.bin)
- renesas_update_loader_sf_offset ... SPI NOR target offset (0x0)

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 include/configs/sparrowhawk.h | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/configs/sparrowhawk.h b/include/configs/sparrowhawk.h
index 731455c9d8e..e6e18bc97b0 100644
--- a/include/configs/sparrowhawk.h
+++ b/include/configs/sparrowhawk.h
@@ -31,6 +31,37 @@
 		"sf probe && "						\
 		"sf update ${loadaddr} "				\
 			"${renesas_rcar_gen4_pcie_firmware_sf_offset} "	\
-			"${filesize}\0"
+			"${filesize}\0" \
+	\
+	"renesas_update_loader_iface=mmc\0"				\
+	"renesas_update_loader_dev=0\0"					\
+	"renesas_update_loader_part=1\0"				\
+	"renesas_update_loader_sf_offset=0x0\0"				\
+	"renesas_update_loader_filename=flash.bin\0"			\
+	"update_loader_from_blk="					\
+		"load ${renesas_update_loader_iface} "			\
+			"${renesas_update_loader_dev}:${renesas_update_loader_part} "  \
+			"${loadaddr} "					\
+			"${renesas_update_loader_filename} && "		\
+		"sf probe && "						\
+		"sf update ${loadaddr} "				\
+			"${renesas_update_loader_sf_offset} "		\
+			"${filesize} && "				\
+		"reset\0"						\
+	"update_loader_from_blk01="					\
+		"env set renesas_update_loader_dev 0 && "		\
+		"env set renesas_update_loader_part 1 && "		\
+		"run update_loader_from_blk\0"				\
+	"update_loader_from_mmc="					\
+		"env set renesas_update_loader_iface mmc && "		\
+		"run update_loader_from_blk01\0"			\
+	"update_loader_from_nvme="					\
+		"pci enum && nvme scan && "				\
+		"env set renesas_update_loader_iface nvme && "		\
+		"run update_loader_from_blk01\0"			\
+	"update_loader_from_usb="					\
+		"pci enum && usb start && "				\
+		"env set renesas_update_loader_iface usb && "		\
+		"run update_loader_from_blk01\0"
 
 #endif /* __SPARROWHAWK_H */
-- 
2.53.0

