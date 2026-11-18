Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFBE606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HiKK+p0i;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bps1SNn0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C2CF811F1;
	Wed, 18 Nov 2026 20:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWcoqUHPmtmq; Wed, 18 Nov 2026 20:30:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF3B4811C1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795033819;
	b=cq6BKo96z2cZfATvRW9iB4XNqIqyFiKDPMTPFn9zI40xn+pEVhMCm4iOq4CjOTmIxBaY
	 mLzQtFs5c5hvQSBLGPehVTg0EL/FE/sKIYIf05t922bU2s7+SAgrcGp/seuGOThW39mJV
	 dM6hxlA4d7uYpZk12rprCD/GRyOYzh8fRt5MssfAGyyWtr/wZNVnbSDPYI3io3V7TagfU
	 KrlYi+wAPjt2Wh32EFkXv7exP/bEUI6aEqoK6GilQ8SCxzFSEybgNBfc5LHFosLPyVry/
	 7VVu/FUnvYBXC0lXLGEeLECtZp1zjR3/lc/5U2KfNKwaHJs+7W8axntZJCVdAwAP9Yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795033819;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2CRC01Hil82fgxBJOQbR0iL3IKv1xays/YpHBvADPFc=;
	b=md5Uc/O2bRpjqLJtH0oYcRifGV/FRaMUYIm5n5cVTCqYu/ZfAsBKGcKPEPD6nwd4tqWe
	 a2hymaK1HCBjeTNvCTdYzpnAqhlNyTty06BdwzKeH2kbB1zC3IkJ5cUshPcOCnCc+RBXh
	 YXwUWdcu+MSABsLs43FRnreMBbAc2+IjxPQ9lXdiMfImvehhxrkJnn8TMf1dT1erYhgaO
	 0i+VGRLT2CoPDxj4olTE0p8zuBbco6Lze8qY16xAAo4PSIS+phZyv0NcTmI8Wgdg9E9sZ
	 DcUB0hu7V9c+6ORF279VY2UcY2EbVMXBs0/yMJRy3Kj4xtivzvP7+5HPsEp1WG4VrBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795033819;
	bh=2CRC01Hil82fgxBJOQbR0iL3IKv1xays/YpHBvADPFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HiKK+p0i1IzGY0h19tECsUqvysfSro1P82gUUiPMbHVYhS7LlbnHK+B57FiWgg17i
	 38JNq1MJLet1mP0KE6YckoH+07tk7KneUCqklg2sE0Sykhv7tf4VrTynOUtzSWFLYt
	 8cb5/f21Av3TwMRMr7oyqVKzoj0oDk5EX2roRRbs8L9iXD/7w0sQpFvoLrRx2FO2bf
	 axG3lWJb/9sG9myRXt73jmGdrm4SEDRY5e8uOE0K0V56Xs7rbKJ3GzNu6gfmiWcaao
	 7ZD9d2xiPSZ+YOpvR7E3hpXNJGaToJP6V5Eeb3gwgSDrOALMieLG4qun04a8leB/Au
	 gw33PRzJ34RpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF3B4811C1;
	Wed, 18 Nov 2026 20:30:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BBD062F1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB62040668
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrrtzoUSab46 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 20:30:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CC1240662
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bps1SNn0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CC1240662
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:15 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so1802435e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795033813; x=1795638613;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2CRC01Hil82fgxBJOQbR0iL3IKv1xays/YpHBvADPFc=;
 b=bps1SNn0KcEEAJ4Gz6osBmLeppqptGVt2Jx0bxzcjxUuVnopBNnDLci8GXNHX6yuRG
 78Y0ZoPb4oEx8ifGasseVHaAOVG+HbTKzP1Zl3pSWnCiR6XMndYtWlhjXsI/v0hKWlTR
 pw4/yc7rBCx00WmmeWFt5wghLvdM/goVGeXqKPUmISbGEVjqkHQvNhp55vqRz32DEvRO
 GSey7eGGAlIPZ1hfkBTD2NPbs+w7DDlZqNu2Vq5l5jSXDjl0ki/uAnOTxTnU3H9DM3/j
 LMTKX+S99zXPlUIqU+XaAt8J5FhLuxjj6TsMx2Guoz7UpDp7/MHYsUNQkZ+xhRtDQRJ8
 vbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033813; x=1795638613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2CRC01Hil82fgxBJOQbR0iL3IKv1xays/YpHBvADPFc=;
 b=K7BxNHhSRHig4mUCOwrDnobqxyMOBfNJINNxLVHe4T/FnnGOHBn96LBlH9tfeRClPy
 gnZQD4k8lHwTrBmXMcNMcUAJlk7q4z7Pa1wqf6ZZSyxVbFVwmcGFaJsIN3JFKtRe6inC
 tYYPqwojxASPQIUUPgeJ1hLbL4AZI1Nb401U7y+x1mo+6Nf6OLCA5gybgu8bebzEwypq
 Bj9IyfVp6y2gnrfYZLOOSM/GLDVRAtWZszMgSwjUyaSyIu3944jAcruEfd8dgUm0Misg
 fVAGQ6sqEer7FdDS+OyNNyJsGcFCb4VyOpp7vJYDRDnGCaL2tJWRHef+tQOeH7ng1XU/
 EVhQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHqbUGIgktMZYtmf1Fyna7VRB+M2EUpYEFNgIuS9G6dnBq43wbKk6QwYTq46PTqeH1TsyjmKH4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ywYrQdvtdzUn7yGNQWLGGsJb11dMJJ3aZmwhIlvvKypBixd1v
 70VZZko9RAvHt7UtKBIACnT/X2TiqFZu4/6D+x9QY8Vn4DViBhAG1nBlS8W/aT25CR4=
X-Gm-Gg: AYBFou3WekDF8VVZ+0J+e5yYZciHAGGa7QjlffHEQOoBTg0F/VW6de/ym+kR6jw7oTw
 XOJ/oelOLXMPPQuZvVvtrUBHNTS7+Rfx+2K9odtD1CGFTna/EU9vn1OO9+qHzT3oJ64sPut7EDv
 O77nVAK5aDOsOdUK0RwjbeUtN00e0JEtZ336o1r2aWyPKV0Nb3jBOQNFQVckbeVfIAGzkPy7+Qw
 0EzVwPQ7/WKfNqGE5UsbWHR8JpTuezls2ScwE6w+ie2GLMGd2KroBxeqRMTyhHPSml5KbwACmqa
 fzoybBx/FBlUZUKoflmaWIny/QCPuJfPl79zsO3Eq20h+GihPONqx7FAvrcMp+OWNWNweqS67sF
 lquOu7nqSNCU4enYBNWJdT4TRx4MC52ui5Ok4Kzjrz7lNXU3gHiID/GO4Y91Ihk4zwGpjKdWdxL
 airJnapxXbq7lBJa54kInOIaSP7gHKKm4gtcgXAsYxFbPNr+wttEdmadrecyXijzTi+DIJ+2jB/
 vmtLffLl6PIYD7JA2FUrwQcRrGQcArQiKdZ3843Bm+tfSbHjQSpI6SrBlh0XhgKJl/qIwmQzZKM
 qWjAqrKoTU84bdbsrpg0SOJGabKKdMZ2XkGaIa/sVRUJpE7h5C1zTwHlN8fjCIVFmMotWO5SXXB
 qF5v0oBL8w0Jr1LNDXQ==
X-Received: by 2002:a05:600c:81ca:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb832639d4mr11337905e9.12.1795033813315; 
 Wed, 18 Nov 2026 12:30:13 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326c332sm13066705e9.15.2026.11.18.12.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:30:12 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 18 Nov 2026 21:29:51 +0100
Subject: [PATCH 5/7] pinctrl: mediatek: mt8189: fix the I2C3-6 pull
 resistor offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ccaione-upstream-mtk-g720-i2c-v1-5-916dd6cc8d1a@baylibre.com>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GPIO57-64 use offset 0xd0 for resistor selection. The driver uses
0xb0 instead, which controls pull-up enables. On the Genio 720 this
turns off the SDA5 pull-up when I2C5 is configured.

Fixes: 108e752b2aff ("pinctrl: mediatek: mt8189: fix pinconf bias")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8189.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8189.c b/drivers/pinctrl/mediatek/pinctrl-mt8189.c
index b01533ed80..db5ea7d5ba 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8189.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8189.c
@@ -1022,14 +1022,14 @@ static const struct mtk_pin_field_calc mt8189_pin_rsel_range[] = {
 	PIN_FIELD_BASE(54, IO_BASE_RB1, 0x00B0, 9, 3), /* SCP_SDA1 */
 	PIN_FIELD_BASE(55, IO_BASE_LM, 0x00B0, 0, 3), /* SCL2 */
 	PIN_FIELD_BASE(56, IO_BASE_LM, 0x00B0, 3, 3), /* SDA2 */
-	PIN_FIELD_BASE(57, IO_BASE_BM1, 0x00B0, 0, 3), /* SCL3 */
-	PIN_FIELD_BASE(58, IO_BASE_BM1, 0x00B0, 12, 3), /* SDA3 */
-	PIN_FIELD_BASE(59, IO_BASE_BM1, 0x00B0, 3, 3), /* SCL4 */
-	PIN_FIELD_BASE(60, IO_BASE_BM1, 0x00B0, 15, 3), /* SDA4 */
-	PIN_FIELD_BASE(61, IO_BASE_BM1, 0x00B0, 6, 3), /* SCL5 */
-	PIN_FIELD_BASE(62, IO_BASE_BM1, 0x00B0, 18, 3), /* SDA5 */
-	PIN_FIELD_BASE(63, IO_BASE_BM1, 0x00B0, 9, 3), /* SCL6 */
-	PIN_FIELD_BASE(64, IO_BASE_BM1, 0x00B0, 21, 3), /* SDA6 */
+	PIN_FIELD_BASE(57, IO_BASE_BM1, 0x00D0, 0, 3), /* SCL3 */
+	PIN_FIELD_BASE(58, IO_BASE_BM1, 0x00D0, 12, 3), /* SDA3 */
+	PIN_FIELD_BASE(59, IO_BASE_BM1, 0x00D0, 3, 3), /* SCL4 */
+	PIN_FIELD_BASE(60, IO_BASE_BM1, 0x00D0, 15, 3), /* SDA4 */
+	PIN_FIELD_BASE(61, IO_BASE_BM1, 0x00D0, 6, 3), /* SCL5 */
+	PIN_FIELD_BASE(62, IO_BASE_BM1, 0x00D0, 18, 3), /* SDA5 */
+	PIN_FIELD_BASE(63, IO_BASE_BM1, 0x00D0, 9, 3), /* SCL6 */
+	PIN_FIELD_BASE(64, IO_BASE_BM1, 0x00D0, 21, 3), /* SDA6 */
 	PIN_FIELD_BASE(65, IO_BASE_RT, 0x00E0, 0, 3), /* SCL7 */
 	PIN_FIELD_BASE(66, IO_BASE_RT, 0x00E0, 6, 3), /* SDA7 */
 	PIN_FIELD_BASE(67, IO_BASE_RT, 0x00E0, 3, 3), /* SCL8 */

-- 
2.56.1

