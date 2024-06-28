Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EA1C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D29885B3;
	Fri, 28 Jun 2024 19:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LR6+ERU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6548E88214; Fri, 28 Jun 2024 19:41:48 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C9888214
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52cdc4d221eso952331e87.3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596505; x=1720201305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6F5ybLaYMxMz/YMh27YPw6ZfjMfXIOjhKIRsES3BtE=;
 b=LR6+ERU0y59gO0H3sGuOoM/WCs2BRSOpJxTGcsnHh6MJ1V8nWKbL7DzmApAu5X6fK8
 Y7JioI+miSb0ihzYAsrsPYiETKZWIWrsrApuNJYAIxbGKjFN8WGXdf61LTkNVPGLng/V
 Ao3IvKGxRA+Rs13z+i5LCXdpbB9l7Dxo08y7oswHkHiAwPIV2xBT0B4Zh/VLUYS8u3PH
 Pz/TkchKzNumqLsfEDCPmoflil+ZBiOoZvOfUxmX6cwp6gzCEyAxsVImNBacqSAPH5K2
 ibBu/2VyVPkWAVFGn8wSiRDDxxOEOeHrBevCu1wieRTmuDY1dEmbvthvegqqqaFA5Gqo
 TRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596505; x=1720201305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6F5ybLaYMxMz/YMh27YPw6ZfjMfXIOjhKIRsES3BtE=;
 b=N0BwZTegDikcuOKkvYzhRSVSr95y4FSfNJ4nt2UTmRQJDdZNUcvIdy3WihBvbhjPTM
 v4VKh6FJh/Y9CPhj7pzw+vS3k/xIDHDE9ahbqtEOKAvN8Fq5w/uxEkJ2bLsUc1K7PO+0
 +B/vowl2+wEqNFZe5AL7KN01ZTadcmfyovjy+dmvIEsDKtE7s4YWCOltrLJPLrRcdBcH
 PDtjPUMnyfSRUBKJHIChOZM1KxjkZrbHQIFlxhieRknVLlcnsnAhTVHRmq9akYKR+WF1
 uUiOPrzZaH5WiJAG+t2ez56Zr0uOrhU+NcrQiQvNC48Pc0foiarh5UEteqcmSLFFYfTG
 x8ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6qZ751weOuoou0rqxyEH5JQ+iF8dAmz7StB2cIi48Du0aPwe0G3NezCrmAbVZz6upY7CKfSwVVKmPDK+oUqe0cjwodw==
X-Gm-Message-State: AOJu0YwsaYmGozRXAkDeknjfOKZKRaRzH0URoqtUt4NPUhfhiIj6jllw
 HSzaE/3uOSMsQZ4OY/Lm6Gdg3wq5GSzfRMnaRZ9nt1D1YO7JIspY
X-Google-Smtp-Source: AGHT+IGnMy4RWNo27p3nSuJM83XYfnNbFY/Wo55FnlNy5r7WBOdD9hnBnpQ31D+OTmWinz0FZxTLqA==
X-Received: by 2002:a05:6512:1115:b0:52c:eeb0:8208 with SMTP id
 2adb3069b0e04-52ceeb083admr10107040e87.66.1719596504728; 
 Fri, 28 Jun 2024 10:41:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 10/12] clk: mediatek: implement MUX_FLAGS and MUX_MIXED_FLAGS
 macro
Date: Fri, 28 Jun 2024 19:40:55 +0200
Message-ID: <20240628174114.8675-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
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

Some simple MUX might require flags to specify the parent source.
Implement MUX_FLAGS as a variant of the MUX macro that takes custom
flags as last arg.
Also implement MUX_MIXED_FLAGS for PARENT_MIXED implementation and
MUX_MIXED with no additional flags.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index c448ed024aa..c1d9901c10b 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -179,7 +179,20 @@ struct mtk_composite {
 #define MUX_GATE(_id, _parents, _reg, _shift, _width, _gate)		\
 	MUX_GATE_FLAGS(_id, _parents, _reg, _shift, _width, _gate, 0)
 
-#define MUX(_id, _parents, _reg, _shift, _width) {			\
+#define MUX_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _flags) {	\
+		.id = _id,						\
+		.mux_reg = _reg,					\
+		.mux_shift = _shift,					\
+		.mux_mask = BIT(_width) - 1,				\
+		.gate_shift = -1,					\
+		.parent_flags = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.flags = CLK_PARENT_MIXED | (_flags),			\
+	}
+#define MUX_MIXED(_id, _parents, _reg, _shift, _width)			\
+	MUX_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, 0)
+
+#define MUX_FLAGS(_id, _parents, _reg, _shift, _width, _flags) {	\
 		.id = _id,						\
 		.mux_reg = _reg,					\
 		.mux_shift = _shift,					\
@@ -187,8 +200,10 @@ struct mtk_composite {
 		.gate_shift = -1,					\
 		.parent = _parents,					\
 		.num_parents = ARRAY_SIZE(_parents),			\
-		.flags = 0,						\
+		.flags = _flags,					\
 	}
+#define MUX(_id, _parents, _reg, _shift, _width)			\
+	MUX_FLAGS(_id, _parents, _reg, _shift, _width, 0)
 
 #define MUX_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,\
 			_mux_clr_ofs, _shift, _width, _gate,		\
-- 
2.45.1

