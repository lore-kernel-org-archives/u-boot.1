Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D653606A329
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X3PGltVG;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZeNXMb3y;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vMTIP3qm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E2D560861;
	Tue, 17 Nov 2026 10:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BOFzDnwxH71e; Tue, 17 Nov 2026 10:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10C566084E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794910039;
	b=GZfXFI/x+Iz88NDHyxvPJKwUMB/xPLNnQIYnxyIPEtPxr9t0cQqmk1tSbpfeamDsGiRg
	 OHhHcDa00G/3ynwpBxhosuTeBcqqKGQxbMgQG8MZc08eUVl12kKURGdqj+/RCBaQY9CSo
	 Skbl3xWa1KOlY7NmiZM16bIxoQ0SNJbI1pu9xK/zp3X1f8yCjRfqUqItj97Q5CGJ3K9PG
	 lQakOALXMSa3B9FBLBSKi7LlMcFGVpLgFe5gK7c+zKzBdOTWz/qH2CN2/ELIAYFxURPtz
	 Qd0OWI5knzoMXNhchV82Zy6teY09BN0tfNnFn48iiFDwoTmngc5f+25rAIVe/ddilDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794910039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
	b=F8vWH1LW8S9/SIJbi2y2DME/yJVXUT4gjsMSF2IsIqGh/ZrMKvKnZ2IjHrFMWKTXQmv3
	 AJScSWMZivB/XYreECneIilJUo5l19fx1ElZUoml+q6NMHZGHn5FAnZXGcqJlcMDHRJmp
	 aABrc+Sf7YNOxi1EiwTg9RpeySvnjjyhAxu0oqnnKr4o/vDSGzaYqgK6iIPCkG3yAw7L1
	 HKaulL4lOetmypWioeXfwY8qtS1rDiRudYxyaksH9ocmRoZv9Xhnhz43FydHftaAQTg5n
	 qgwkD6TXq5/hiQw75PjB1Ycc5GuPtmIkp+eTAkfpXM+slznOxXFMPtkcSsTGagrRimA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794910039;
	bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X3PGltVGOzdIKCw9sLusjDhq1aEdB95OrMle4PPzG058zzkVRQejqGDWHjC7dFZZS
	 Cvq13VH1yoAmi2nVCNzv9lgrhXYUoiLqR4vM/zW41AyiDPMpTNXrdj/WQkuTu91Hkd
	 YOFXSUqtd0ufDEOWx18KgGlLcoBS+jt9d+sxVjYUqBJix7SdKYwqIBSgGZAuRrtZco
	 szSPTRMMGu3y0wyKXcdCqL2kDc/felS+srMBYSRTUmoirNGZhWVR0MHil0LrsNdWVa
	 w+Wft0CqD+dMuCDu+TW+urB8kZcUDkmZ8fmurc/EmC0BYBxozAhX2axxJod1MgeYqv
	 BdCkU5gmS+/TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10C566084E;
	Tue, 17 Nov 2026 10:07:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A9911E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F9154008E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fkAPeKj2L7Pd for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 10:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5787B402CA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=gregor.herburger@linutronix.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=ZeNXMb3y; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=vMTIP3qm
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5787B402CA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:07:11 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1794909596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
 b=ZeNXMb3yvAw5IsLfJbh+M53+LldpaQciu6ww3ZiyV0VEtmSb+JYUj2etoA9EBAVDP6hlos
 pA/jm8fcduWA1FUloc3X1OVE/J/r0G2BwjTF79mJC3eYo3azg52ACUs/QQPp0ZRM8sgUnc
 7+X9pjyMb94s5J/GUEekinh8H5wunTrK+FjI2AHuo2YilTO3VlXHusf8iemoBev03z2KpO
 HL//kSPexTcEoi3AfxRM7xI4ZbygyqI0CnrnVD7gPhyQmdc4FIWtC92I3BU2dau/xQIwc6
 8ljjRWsKM/hIhWTnf91uwu4kUI8TrxgWcddKxwbzLAtISQVw/Kns/5Yx2fCRIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1794909596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
 b=vMTIP3qmj8Xmj2HbHtdXw+2ZrSAcilyhBwdq1tTsFDIsC0MYqKcLaYAnri5Ky0E32KQPo2
 vGSt3Z0y66oS13Bw==
Date: Tue, 17 Nov 2026 10:59:46 +0100
Subject: [PATCH RESEND v4 2/2] rpi: pass the bootloader node through to the
 OS devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-tryboot2-v4-2-d59fa66de789@linutronix.de>
References: <20261117-tryboot2-v4-0-d59fa66de789@linutronix.de>
In-Reply-To: <20261117-tryboot2-v4-0-d59fa66de789@linutronix.de>
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794909594; l=2068;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=TLV9C6neprJnZcXnK9YYoU52ziIohQRBaAaA79J03iw=;
 b=cf8orMz5ILF80XVr/HWLWPYMoIy73JNPgkl62g1Magi+nCQw+1PkylJMURvxULbTuo3s27vL2
 qWPN6pueVjkDIBJhzOoWYrTGXMHmZZkMGz2IlqS4/t5MOWGn3LYZPLv
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

