Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C7ECA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 06:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 021AD81180;
	Thu,  8 Oct 2026 06:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2XP8y10QK1K; Thu,  8 Oct 2026 06:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4A38281164
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791442166;
	b=VUDaZ08D8CEK7zykU/1Teh0y31U/CSZluH/jG9VaxIBleqDohOI4X5floy/Ze/l7609k
	 hMxVh2e4mUcvXnJrbJrcit7tGHc/nu2yV487kEJ6n5/XrEw6EzNtxMYSH7RTrVEPgXIbD
	 K6VvYF8daCj8wyGWpWACJV9t4p5g2O7w9i/ZAC3F2r8D7WlvXuhQ5BDbBRk7Ykeud83mW
	 IXAaVF4jef8ylSas97FPu1f5NIbKVciLgDoR/Q82kHulhR7TeVLpRWV23gMPmEpCYdZV2
	 nyKmR8E1C2w5YnqSKAPt/YYh3G2LAHpIyZ0/lpseoj0CPFo6hjgiC8ViJpEZ/8idfjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791442166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 From:DKIM-Signature:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
	b=scavYq/wY2YCGXBgD22Zhvh6owy/tvTldrwiB9fs4NmpZ9r3P2xYKGscmlB+jyfCvlec
	 N6EQGeVDkFgtwdgPiN944N2i48iWJiiyI+Pl6PEMJdcNpyxoQAfPTgydardPWMD9lNABu
	 K24fjcuHf0bETsO1IaiYaLEjJIE3GWg8mowUJX87/oiIu/fR5asuDv5nXF/pCuCF0ex66
	 ujY1lCZN3c8B85EXuawGvcloiMMiXRjer2ibaBiBB57YxVVvLVuvLCIpnP9ezQ6inVzbn
	 VYFdQqvnhmkxEAPwzYHoicc50yurLnIYzmrTPt8M1jfe9DzCmuSARCUvFO0Vv9b1LLA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791442166;
	bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJ9DKUxo3+1wqElkKj5b81isnimtr1srSV3Ak758SoDMDoQQKsAhjJg2S0hSrCw9p
	 zWOlR7gv8EUm+6TQO8xQ5eMBL8FtH0M6eyPkskxJrg7tvpCMhcAFPmBmbVGZTMfsrF
	 eeRKdwsrmqvHAjOzVta8bTBR4OYvNJODdaZct+/RhcKsqehHVopWcKkPGaFdbt4Wao
	 20sdYWR7R3ITwYb8WacDXMxqp5vr6IjX4qUI7JVSai0dMI9zmyUN2X9UGIhOgq7IcM
	 0ZAd4X67SWLsMJuNvGoZWEQIvNByaWKUs/g/MIfdwhUujaKBN4LyHb1dLKfcBI1s+q
	 uFt58tQPq8I4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A38281164;
	Thu,  8 Oct 2026 06:49:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5225A22B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F8B2606CF
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lkrpHDrrh8QR for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 06:49:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 394C5606C6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791442164;
 b=PXwROC4jv2/4uyhCdIXNBVtvQsqLhrsAx5rg4tuG+TbM7MBY+N8xIBZizUwMk86zT+6Y
 dx5uYyTK4gz2h3uXz0d7OmO0iA+ZfW45+xnm0wRuc6SaXJOh+x91VagU2V9/Kiia05DMX
 nERciu0tttVb3tA+E54XccvrzMPbidn2zqGJQk+GOh8AgHKFxM2oJvCP444hQrLsfDmEP
 QwmolXjKtSnUgPcVHyRuFyrMi1kLIvw9v0ybzUBFRqPPTnzYr+7BSJeqMKb+am/GeZsbC
 tqvCfLoKdSLDqWeCXtwUVwAc/3O4wfVUC1d+mGhvkxSsQwsSpWTPT72dGjeLVP7B8Qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791442164;
 h=X-Greylist:Received-SPF:From:DKIM-Signature:DKIM-Signature:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Developer-Signature:
 X-Developer-Key;
 bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
 b=kL2FkUsEJy9WMUmJradNnDgJEtWDYLHpeNWVTWPbmhIXauvZVf0hQ0IMCgfeSEROMkJ6
 gZc4RE9WCxk6yImy1szOvk2EzYUYuhIJVl2TfWduT5IStnGJyd30z0A7MvrvSbH2Ydqkl
 P8dTdSc4XBJwOzw+sK0VccaNC1hzVcrM5b9uS7oAbO8GeSCvbh7MFntbsL8umWnXL2APT
 h7OhP5YoOZ/brltFcU7qiKopp8B/Ch8ZSRZ1lqLBEF50gyYlE4CWisbAFrTVUVdxRhdPU
 aIJw6vpODl+xHE3EZK3vm5gM+8KkF/hb/8Fs+fFKh954LVGGpw3ni9ERtK+MV3NoCRg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linutronix.de; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=Ec8eLMSD; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=g82MZrwL; 
 arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
X-Greylist: delayed 435 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 08 Oct 2026 06:49:24 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ec8eLMSD; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=g82MZrwL
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=gregor.herburger@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 394C5606C6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 06:49:23 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1791441722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
 b=Ec8eLMSD9DqTbg8uBg7+na9NvjvwsdshC5fvY8h0thNr7mWZZoAR9l7T1pYnYRUoTwFkE0
 1rS4/fPpWGQ7b0IT0ZqtliIg1lgLkvlXP51YYpFYSn2f+j8Nvae23jBQvClxDnvcsIl3Nj
 Cir40aABbtniFloNFnJHOKVMPXPcmGWWjzHj1/Xev0H5UpnZkGjeiwDrIF5h2g6nHK/T+S
 Nrvuh3d13PEvEGCAGhtzGmYFX6k0LoIQDJaOspr18T2cWWuQUSHIAM3Y89YapLIhDLxPav
 vpmwIImnK8nMmC7jMmA32XYBw8jAcUi4/wR9wlhg3WtuqGncl2cH3S4P3WK4BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1791441722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4ubcy5qsNckJj/be5p64sC5AyGpkOI6zL3kswSjNRY=;
 b=g82MZrwLQvnaDGrUl9EijK3jWEqL/T8d2AYiYF7dTF7JJskhySzb3etAwU4No6OFQEq5bA
 VYdfnD78GmKxF9AA==
Date: Thu, 08 Oct 2026 08:41:59 +0200
Subject: [PATCH RESEND v4 2/2] rpi: pass the bootloader node through to the
 OS devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tryboot2-v4-2-0ecf380c0e1c@linutronix.de>
References: <20261008-tryboot2-v4-0-0ecf380c0e1c@linutronix.de>
In-Reply-To: <20261008-tryboot2-v4-0-0ecf380c0e1c@linutronix.de>
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791441722; l=2068;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=TLV9C6neprJnZcXnK9YYoU52ziIohQRBaAaA79J03iw=;
 b=zGi0RCzM9IqMUKkYV8Xbhm6YMiNmXqVE4x5PIsYT8ERUBvqcsTWoZbS4PkKfrU3a/hY5Y3n9q
 Y9GI0kxFmSrCkY5XdoWPx+ZKe/8MMozYdG7DvdyKArh7rAz+z1+a7UH
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
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

