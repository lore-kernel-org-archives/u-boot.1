Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA2FC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03F35409C3;
	Fri,  7 Aug 2026 19:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k2XqVrXbrv8k; Fri,  7 Aug 2026 19:00:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30250409C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786129223;
	bh=5oNx2TdEr0Ma256dnxOZlEvbFNbpMBQPpLkOlHgFk3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vdtwKuBwNLmaUFj4HdPKvV9jsDFtT0lrInhVElpwkXvnuIONwUhSBL0yBlouks8RR
	 E7+n+/D9pBII3K94yUA63Quwx9PMIohbOq2+IkGQaPheRt67+eeZ2mm36NsGqFaz57
	 bS9ONuJr0llYEC7vPaEqUGymYoa1y7oX0bQHxRFpPOVtthbq5rPx/Gj3E5Z4osh6ER
	 pbVGp1e3FEI8Is18q9qoZSYTiR2xcwgni4y09/DBcgo66OpGElIqPr8SLqwKzx4Mgu
	 2mhcK5dw9yP0p7QRUKh1B+w9oE+Cc7oo03FPUa5NjXY/lw58t0/BwBxjEPNjr8Z3xw
	 m4irZ+tCXU90A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30250409C8;
	Fri,  7 Aug 2026 19:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68B00392
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EAE281296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjQZZ6fkWfpi for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:00:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 733BE80E6A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 733BE80E6A
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 733BE80E6A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:21 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6ae9b721927so2027182eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786129220; x=1786734020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5oNx2TdEr0Ma256dnxOZlEvbFNbpMBQPpLkOlHgFk3I=;
 b=QEVRex4t6H2a3QaH8vYWMex1DynU7LhaeApECcyZOp3PZqAxwNymK2IW2dB6zhRgyJ
 IKnpdDPKnf2EIxUb1kXD6p9gATlKDZbultZBbB7soAljL2Hi8FEUH8gz2PIpgvbyhm0D
 TGhaZL3hqrN4MDKRZvI9yat0vyz5xOZx66jq3Dgai6C3lom5HKc0wr6NX20YNCF7z7Ov
 PFRPOe4bnb5MnemdZUbSROL9Ga9IMPBdvJLqk64Ca40HcOFItkdrJ4sPlJkVXWWtBi7E
 xprdP5b2bUiKRT0s8D8q+XvSQ/2TBm+uNclBvjahprlcGhqPT7DSzfThv4pX9ec21Gu1
 sf9g==
X-Gm-Message-State: AOJu0Yz6XZOkt4Pcdcldv5xs1GY3E8ghjl/DHtxmmE0loFz1EGakdXi8
 QW55wz+rbVTHMY60fXeyFImPyNlLjXRUvHEErHiBqG9jf79OkmuypyYwlI9rXD7Bv+M=
X-Gm-Gg: AR+sD10abwiSyM3lNDcJC4ewBsInaZLtFIcMJF3810eCYKpGAUtqBZaG20Y3FPcYArK
 a+SNFJTOMpt93iy3VfyV3YGYVeST2r5ivseJUdC8//xLy9SHfZeBgD7bJP+wXOJymxQThqCAHPB
 LzvzEhoLmimLchPBtH76oPaZSN7c2H+kRdmbixq/h7LYgngM2NV9Jxzy5fpSugQAHTqdoChPmmK
 /LN/hkOPY9WbE4i5RtWzmE3liW8q+8/l5K2Zfz2SGhueDEKyZVdhKVu5dqykn2zmHeAGv546JQl
 Yvi5EZYd/tzDnQ9lcsttEz4AoFbM4aoYvNbN5ufm/MMzUSMt9Uac7kDcCSyu5Moi7Z1eDLw7o0y
 O4g3BX8WQ8WflGYIAMlGx8It/38vU9zYd0V+5d6Rewdei0erSOBEbbPk8P40Klew0wKnk53T2Wr
 WNGiv1X4PQdjLJ4y8f47frIETJppyeAYiF993GQ7AvmSi+aWMN7Nig0NPRRk9rwcvn
X-Received: by 2002:a05:6820:1905:b0:6aa:e524:fd7f with SMTP id
 006d021491bc7-6ae970b941bmr13223527eaf.34.1786129220218; 
 Fri, 07 Aug 2026 12:00:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be47604sm2679283eaf.10.2026.08.07.12.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:00:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 13:59:39 -0500
Subject: [PATCH v3 1/4] serial: mtk: use ulong for clk_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-serial-mtk-clock-fixes-v3-1-8cc94d313b57@baylibre.com>
References: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
In-Reply-To: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Q4nklDDnZz1dZY+qjW3cH6vr9f1RjgFQXQRgpvM5zUU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdisll05GhQAvIF86r/wSfFJhd3RoM5fIJJknS
 GZ3KiH6wV2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYrJRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArMkH/0x7cM7A9A5dCz9VPbWskeWoiV7ol+JALMZkmnr
 PG7JRh9bYRIyx1ar/qe/iEBDcQXpzfa6h7sVjLF8+kiMvmKAQYMXlWZDgYSiCbSkONftp30oVFO
 TApitxkdpcz3xGhbWyX9Dmf49i8edP6GrUy2RNvOtYwg8lwNhYg642+NUUhYyRKcZn70EXqLHYp
 8XI5cPQtM6kpK2pHyZsrG6/solnyk0rgprUYasKyAXy+xcSYbkHwErX+dvOlKM+HeW1ljlsiwpm
 9N4Xm35mNBotYNskPv3B0c7t1e7NkFzDiq1F6a170wBien6S4ebq7leU5QDyoKdAb+udfTWHC2v
 iEI4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786129220; x=1786734020;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5oNx2TdEr0Ma256dnxOZlEvbFNbpMBQPpLkOlHgFk3I=;
 b=jtHi+z5mf5/u7WkGtPDhWSd2rulEAiJdX7jE7eZI3MDmn06onr1HytK2W9Yr3zDWj8
 XDT37DOKH6RqbOUL5BR5jMWoiVWybLklcSx590EF9dkWv9ouvPDc2SvCIp0jv06hiqC2
 bhyuFzpe2sQIgg95v+Br2zj4yllCGz0ovbwQWGllMblB7l0AbEw2H/EW7cbnCnOjJyyn
 PPDy49Mu9jW4UID443mJwRjGmAHjr7WKKRcLxAbjJGqoqwh1UExQImNxe1bgXpMmkw5V
 FaWpo4H25anu6gNg1pT+hvEbo4NWG/jyn5Dwz46LOZGvZ1pjUykYcBJT3rYkfBgSJAWd
 oDRQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jtHi+z5m
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

From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>

Use ulong for return value of clk_get_rate() in the MediaTek serial
driver.

IS_ERR_VALUE() does a signed 64-bit comparison against the range of
possible error codes. If clk_get_rate() returns an error, assigning this
to a u32 truncates the top 32 bits making the value smaller, defeating
IS_ERR_VALUE() and producing a garbage divisor that hangs the UART.

Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clock souce")
Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/serial/serial_mtk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 01cc415efdd..28e87f485a2 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -213,7 +213,7 @@ static int _mtk_serial_pending(struct mtk_serial_priv *priv, bool input)
 static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
 {
 	struct mtk_serial_priv *priv = dev_get_priv(dev);
-	u32 clk_rate;
+	ulong clk_rate;
 
 	clk_rate = clk_get_rate(&priv->clk);
 	if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
@@ -266,6 +266,7 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 {
 	struct mtk_serial_priv *priv = dev_get_priv(dev);
 	fdt_addr_t addr;
+	ulong clk_rate;
 	int err;
 
 	addr = dev_read_addr(dev);
@@ -282,8 +283,8 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 			return -EINVAL;
 		}
 	} else {
-		err = clk_get_rate(&priv->clk);
-		if (IS_ERR_VALUE(err)) {
+		clk_rate = clk_get_rate(&priv->clk);
+		if (IS_ERR_VALUE(clk_rate)) {
 			dev_err(dev, "invalid baud clock\n");
 			return -EINVAL;
 		}

-- 
2.43.0

