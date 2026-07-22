Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB8DC4453C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4158E40A57;
	Wed, 22 Jul 2026 21:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1rAmwzzxV33; Wed, 22 Jul 2026 21:44:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3E34407D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756654;
	bh=d+6NUKLw7x5r24/TF3Q4Bm+dtdddbZlwstY0NgcrItQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hUisRMfZRfHT4Iq3iRHI0A3pNRkHa6ISzHmPLpRrLgYvSCKyrVeKUbWX+QUculFf6
	 UwneVgVbFoWDiy2EngciU1X3RdSppmYYizI/A9GK3NMTRfh+QaW1oA9aWoqzmqLLEG
	 Y+/PHg7ooSyRzqPC0eRvMmjAyG7jvd1pqUNJHI5plKkEQqJGsI68r0zOU/gz8LIGVI
	 55Um0s+dhJusFsrE6uJslltKo41OAC6pcwbl0yWLLUGX0AFI0kdE/F5tps1vz2OkJH
	 23eogVcGrr5FhVNW/UwHa1tECVb2FcU9dzKEKfJAzkf3W/3crnDW8awMYyM2z7tKuJ
	 6wfbeTyTCgQmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3E34407D0;
	Wed, 22 Jul 2026 21:44:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71D92313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AA9B80F72
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JszmOGszRhw5 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:44:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5DFCC80D83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DFCC80D83
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DFCC80D83
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:12 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so29653115e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756650; x=1785361450;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d+6NUKLw7x5r24/TF3Q4Bm+dtdddbZlwstY0NgcrItQ=;
 b=TiZI/9rRrx17QuvGSSFwslasx46DnH4IjAH6u8O0YJrm01OB3pfltbPF2zMEP1DhpX
 a5zS3Gt4CV//aT9Tsj7UgEwDjTnTjl9CVy0sNxmNiKGAG4htYr4Q6QHiqPreirMNjnjw
 huH6msBtpRvkOMHVli2KbXhZqZQL8vT0TMJwJXF/5wHFxJJfWuhlQFPjdyBhdL2Zgeyu
 mH/UCT58ZblVLH8K1t5uASwr+lkLDkNEKciRuttYxh5H+jFkZ4DL6F42zf20iffcwmZv
 pVEQFlAQplUOdmoGEYggfDsDC7Mr6pYsGYRqGZZVn0s0m0q9CYUbCHc9dvlONmhFfp8Z
 kXlg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0ud/7Tethol/+qb3A4vEqlAODl6ZlX0sAQ/P0pVf9/9Aen7HidhnfiKFwdxGAucxEHW3gysI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzMHIyjwhAu5m3nv4BefsryGtwCj9YY9jc05ebba/aYQXf/AilN
 +97sZtaKl0ND4AwO73bPKLi7i7NLi/z1Ck2vk7stq/WZ8i0gnrCBfyZDkcU5n5Ly9pM=
X-Gm-Gg: AR+sD12OagWljP/eQKoU8bNs7Ys+M/GUH8qJknqv0iZYz6y4Xj8o41xRuK6K3A6sEiz
 Th61wCxzvQ0v2TeKDIWCM5H0uuQY7OpLDuRTyjOUk8eO4L4ifEtKWr/BTeUoLAJR9dlngDUQZV9
 xxMsU/r9lNzKoQh7Ngfbi40omK0S6LUXK5sIU4ymvLmN1pljtGbPmwRi2yr1MHjudFgiCo10tqA
 5GXfPVKSoN1WLZz1BUxtmF9e5JPMkRVGEzn/HpTpMptAK63IkKT4BMucM18YRyQp73pkJ9h3/SX
 /l44hEPEPO5Qe0nBiibgntPyfXpjYJuNTLmedRBYtTnVVSxl7xvyGenEsKwwURGKM6TRJ1+6aes
 WV/iMBY3PYpn9pPMisrSPw1m5SGY1NusBVzIKMaExwBdpwo/pFOzT7slJtShRLfGJjMJcwJfAo5
 U5MdOG1atPW6tiZzR5Z1zVJQ9eiSOe7SoI27+P4PXW2YDakZtr7OQhDLMCyw4=
X-Received: by 2002:a05:600c:c05a:b0:495:5eca:f9b3 with SMTP id
 5b1f17b1804b1-49573d0ccf7mr3840065e9.26.1784756650055; 
 Wed, 22 Jul 2026 14:44:10 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a967289sm96879285e9.11.2026.07.22.14.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:44:09 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:43:58 +0200
Subject: [PATCH v4 1/2] usb: mtu3: support the upstream devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-1-9719f4cecaeb@baylibre.com>
References: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784756650; x=1785361450;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d+6NUKLw7x5r24/TF3Q4Bm+dtdddbZlwstY0NgcrItQ=;
 b=poQ2ywZufquQXyagNDcLaAX1Wb1B1yolUDtpaa/zXBM9/asrSsDQHnHe8bL+gaPIz8
 ktLJG8nzpf7n8dkWWZKJtW99f5Ko0XSQRMAobi8Mg0Gfn/t8/C2aF8Yfxrv+Mo1wWOle
 MaGfIg6xUQND4y8hX/VFiW+b45mJPkGweWZ0+ikBxSgmLwLOpm8p/sneu9mZEmw8zAgT
 ds3SZVk2YPFoj5UX0L3kzKCP2djx/StwmW2F8fUne6Hr1rpFbojx480yhfRyPISgPGr8
 N1Px6M4ILYosAnS49kSgBJ8Am2HJC8eMYaYkkHVMr7AFHFj3z+u5YTfVWuXoVwYVsezW
 DpIw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=poQ2ywZu
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The MTU3 glue driver only supports the legacy U-Boot layout, where a
synthetic mediatek,ssusb child owns the gadget resources and dr_mode.
Upstream devicetrees instead place these properties directly on the
controller node. The gadget therefore cannot bind when U-Boot uses an
upstream devicetree.

Search the controller children for the legacy U-Boot-only node and use
the controller itself when none is present. This preserves compatibility
with existing U-Boot devicetrees while allowing the driver to consume the
upstream binding.

The two bindings also use a different base for the mac resource.
Normalize the upstream device-block address by SSUSB_DEV_BASE before
mapping it, while leaving the legacy whole-MAC address unchanged.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 26fee141f6e..da617d81c30 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -136,6 +136,7 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 {
 	struct udevice *child;
+	fdt_addr_t mac_addr;
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vusb33-supply",
@@ -166,7 +167,17 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return ret;
 	}
 
-	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
+	mac_addr = dev_read_addr_name(child, "mac");
+	if (mac_addr == FDT_ADDR_T_NONE) {
+		dev_err(dev, "failed to read mac address\n");
+		return -ENODEV;
+	}
+
+	/* Upstream bindings describe the device block, not the whole MAC. */
+	if (ofnode_equal(dev_ofnode(dev), dev_ofnode(child)))
+		mac_addr -= SSUSB_DEV_BASE;
+
+	ssusb->mac_base = map_physmem(mac_addr, 0, MAP_NOCACHE);
 	if (!ssusb->mac_base) {
 		dev_err(dev, "error mapping memory for mac\n");
 		return -ENODEV;
@@ -317,9 +328,15 @@ static int mtu3_glue_bind(struct udevice *parent)
 	ofnode node;
 	int ret;
 
-	node = ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
+	/* The mediatek,ssusb child is a legacy U-Boot-only binding. */
+	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
+		if (ofnode_device_is_compatible(node, "mediatek,ssusb"))
+			break;
+	}
+
+	/* Upstream bindings keep the gadget resources on the parent node. */
 	if (!ofnode_valid(node))
-		return -ENODEV;
+		node = dev_ofnode(parent);
 
 	name = ofnode_get_name(node);
 	dr_mode = usb_get_dr_mode(node);

-- 
2.55.0

