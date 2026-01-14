Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5A4D3CC84
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 22:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B031680433;
	Wed, 14 Jan 2026 23:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XWGTVrld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921198063E; Wed, 14 Jan 2026 23:24:33 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C31803F5
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 23:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfd65ea639so53549a34.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768429470; x=1769034270;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cir+NmngjDOSGEcP2tkk+1L11N8VkJpQ3a48dgvWm7s=;
 b=XWGTVrldI1m9zBct7gmliADJAAi3hPvh7p+MuJbg/uTZWe6REOiVMF8CIeWaLoJy32
 sYj+R4qR5SPP9mjOB/z5wxNlBee1tbfuw7y3cdl0dJcjHJOfwIRFuj0W5sGmZYh9Ecay
 F1bAHiptb4IT+bKCys0heMYx/jsuLmk4zgriyQD6R394XOXnGj6CHWxQZHgd+ot06KCA
 q0RLxkpCGQbU6qkG834rT/nV5eDHpXb7cde/zzCQj0JLZZXpbuAQ12BuMHgw/e8mcBxo
 XHdT8cvHw1VCW9vLylWoPDh5S7oOy4j+ZKt6xnrdk+bKwYUzJzVT8HyeBIQ2PNX9xZP0
 Njlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429470; x=1769034270;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cir+NmngjDOSGEcP2tkk+1L11N8VkJpQ3a48dgvWm7s=;
 b=VmXHugOi9BLIXSJjZX223iQJUQQEMQ1TflehlmiEO9Xb83GY9xhHuxRdFJskUbO3iS
 ZhrXXA44G/Vi4YDWbVHzKx0fvVfXh72Lst3feBh2kf2wJ5Rd+ez+k+HcGzeh8VEUcCFM
 W+i8/J6dZyL0vWWtBKhV2yLSsi1Ip7p4CH5TCQZ5y05IdrH0B5yChXPQa4lnOLTddclR
 ECIyRWFaH1cTRFeZ8xFFxyPqz3L8WgYqxjNLw74/7DXi8XqwMFBrIFgU16qU0vyeCJ+x
 6XjwF+enl4SBpnQfHXIQLtlgmgFQTYHDk75qoyg6PTMN8M0JBPPajMHjx5BB/J0D1B3J
 ArrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVIHcSboG9oTDEpZKdpUYioaaIbtgohye1RXP2QtWFXfJZ5ryOCPrj78txZj666dZppptJa5k=@lists.denx.de
X-Gm-Message-State: AOJu0YyX/uVtrD/HpTJO6GUgxdQGtSHocv7oofUp5/CHDhl9aKLaJ9Lt
 0Lz+IWPA2bv+oOJY/Vm5lI3k/62ioZKafZbnkFKXP1Sk/KwFQxEUmqcVDz9wAF0nLck=
X-Gm-Gg: AY/fxX6mycjQvTLhVP0Cg9sLzNAhUGv8piHkp919E9EW6/8nHWFKMCOEEDHk8dMyYfO
 hHTidnWYhuucUYb6GSZbvecQ6nRfv42xCTccDfPqWtat/lVFXiHmiPNSvP67r1uGKjB9RCuGMF0
 k+1SGM1f7fBLwyEXvEc/Y5soTxL0HT4+UzbDO8ia/7PxT3QxbbH5mAfVqFxCEH6sA1teAWaQ7UE
 6UIzkMAXd2xv7Dh0vEavHFImPYlBfiJbCbClrw3pdRy5naepX/cwwrdtii+HI1DE2RhsDYeiKaR
 yEljAz1kxCHaa1bdAZXcieK22PvaN/DiXRPIIBUO5k2a/etYPf1g+VcjgDkW7M0ydVgMDpUgh+n
 zRZRt2BmVfyt0m5KZIy/bW4QagdjldkzU/3l5bt1hdILk4Kf7W8wRqnMRefZ72MZRm86oND4Pr7
 9gvvm4uQ0lcMR3d4c=
X-Received: by 2002:a05:6830:264c:b0:7c7:827f:872c with SMTP id
 46e09a7af769-7cfc8b8467fmr3529765a34.38.1768429469881; 
 Wed, 14 Jan 2026 14:24:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3ff3:5a3e:f89a:1938])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4781c43asm18776014a34.7.2026.01.14.14.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:24:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 14 Jan 2026 16:24:14 -0600
Subject: [PATCH] clk: mediatek: fix mux clocks with mapped parent IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-clk-mtk-fix-mux-set-parent-v1-1-bccd82b10027@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtQi6SuEi1CpxoqC7UIpLsnL
 R98foJAnilAVyTwdHPgw2XIsgCzjG4mZJsNSqhGSFmj2Vbc44oTP7hfDwaKeI6eXMS61VZUlTV
 aSciD01Ou/nk/vO8HFZ7892wAAAA=
X-Change-ID: 20260114-clk-mtk-fix-mux-set-parent-497d033dc721
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2825; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=KYf424vIWPPfbdNDTW4eFgFTBF7Fv3rBLcNmiF8WVMA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpaBeVHKewNsNo8VYkkllYSDic+KKUT+y0yMUwx
 t8yn4eMH+KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWgXlRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AKk4H/RqJ4Lt+ix8qXNfNmm5BC6MOa0v6usltiDiWrOD
 ADKDkzhx3QaHhx1axczm40Yc/ifACQodhqeMZKFFksYTi7ZWMQomR/+DuhxEpwxz+S5JwZ2JPdu
 nHxF14SPhdqPMGxcmLuDFjHfi+r54VyXUEWrjwzJOJmsXg4FwW3ffqXqqv6L2ByJyM8/fI0AX4f
 nDz08/mtte3fMkaHinOm2wWYt7Qi3GG6GQOo0ZSDi2ZUN127svybvzhzK6Gn8AUH/khM+6yFLRk
 tU5faOURDPPaZTG06JdOHRKT7NzDMNbQqG3lHaJ/M9f9jFQ0vKXTaUnBfzy4BdX6XBjhY5j8o8+
 VOD4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 14 Jan 2026 23:34:54 +0100
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

Pass the unmapped parent ID when setting parent for mux clocks.

For technical reasons, some Mediatek clock driver have a mapping between
the clock IDs used in the devicetree and ID used in the generic clock
framework.

The mtk_clk_mux_set_parent() function is comparing the passed mapped
parent ID against the unmapped IDs in the chip-specific data structures.
Before this change, we were passing the mapped parent ID. When there is
a mapping, this resulted in buggy behavior (usually just incorrectly
failing to find a match and returning an error). We need to pass the
unmapped ID of the parent clock instead for the matching to work
correctly.

Since the reverse lookup is a bit verbose, a helper function is added to
keep the code clean.

Fixes: b1358915728b ("clk: mediatek: add of_xlate ops")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 82306ae285c..acc28d1da1a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -66,6 +66,24 @@ static const int mtk_common_clk_of_xlate(struct clk *clk,
 	return 0;
 }
 
+static int mtk_common_clk_get_unmapped_id(struct clk *clk)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	int i;
+
+	if (!tree->id_offs_map)
+		return clk->id;
+
+	/* Perform reverse lookup of unmapped ID. */
+	for (i = 0; i < tree->id_offs_map_size; i++) {
+		if (tree->id_offs_map[i] == clk->id)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
 static int mtk_dummy_enable(struct clk *clk)
 {
 	return 0;
@@ -812,6 +830,7 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct mtk_clk_priv *parent_priv = dev_get_priv(parent->dev);
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	int parent_unmapped_id;
 	u32 parent_type;
 
 	if (!priv->tree->muxes || clk->id < priv->tree->muxes_offs ||
@@ -821,8 +840,12 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!parent_priv)
 		return 0;
 
+	parent_unmapped_id = mtk_common_clk_get_unmapped_id(parent);
+	if (parent_unmapped_id < 0)
+		return parent_unmapped_id;
+
 	parent_type = parent_priv->tree->flags & CLK_PARENT_MASK;
-	return mtk_clk_mux_set_parent(priv->base, parent->id, parent_type,
+	return mtk_clk_mux_set_parent(priv->base, parent_unmapped_id, parent_type,
 			&priv->tree->muxes[clk->id - priv->tree->muxes_offs]);
 }
 

---
base-commit: d503633a36767d756c7de28305cf0de79440cbc0
change-id: 20260114-clk-mtk-fix-mux-set-parent-497d033dc721

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

