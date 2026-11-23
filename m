Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6B606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JTnZ9Ngo;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bEOKZQYh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59CFA60721;
	Mon, 23 Nov 2026 10:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qvglUv2OTdf1; Mon, 23 Nov 2026 10:22:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A66B260731
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429377;
	b=K28sf0Jk4SOg5DUHfqRLfzrKvQhYLZgmzWOOoj9Fu76HbHtTlpmlt6ion1W0h2M0ccSv
	 nG9if6rc3/86pKydruF3KDg5bI3dFAYryNpoZcY6N7AyaXpiLHoeYBCx7jn5wdogsaDWL
	 MQzNdiYa/4PSb3Nv7sOx83yECkCQhkAC/B63dbWQnDS1ogZ2/nHdZpSeTCjqjDaPAkgMB
	 BF4yMBam1NTldSFN+DNmwAT67djlyjhOynBbVnOKkb1bB3aT0VlhfPRujHUFWClViq/Zd
	 txC+yqSqG0NFE+6CMQ2A6qTP7NxRRMOR/PYC31pxPdOe6FaW4z8q1qIEOL6T/qu51NQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429377;
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
	b=BaMsDyzQOPNe7Mfwfh9XYa+xJJT4WsuOOHCFfBxea4dG18F80U8MNT+tw+vusz9mOCRf
	 3KJpSK3OHa0f4jdiaqszyDad0RpP/dUMe/CUrhAQ8omlnUWAkYJJvj3GokEIXB/F7CNhr
	 gn9mgVBDmggxRBH2XBUuLxwKII6QvlooEto+NclItp6dzPWHvqfeX3vgfi5RJC+5oIIVA
	 MQOcEUzWuJPuz5oAodaWfswGBGnc0fxwCvplxdkKWsNFGZxUpLDF7irt3hz8VU39ISiTD
	 0pk2Z5YHN0YBl0Yp09O8hXjtjYmyM8XGmJHMgBAunL2joF8xw4oukWB5i9xiF/eJXag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429377;
	bh=2CRC01Hil82fgxBJOQbR0iL3IKv1xays/YpHBvADPFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JTnZ9Ngo2JrnIhsgSV0tsaYGoMVeu59Ti3AZgQ8FBiIqZl3lzAWWsqNxLpg5sJxhh
	 mJjcTA0BEvvHFDTXv/zuAb7PlQqave3YoSB90hrrXaz7/mnzu8QHWya+AoFTNxP9cu
	 6sd3w4iPS351X9zWmEjHlJC3G3cOp+5Oz+YGaeIUlct8Yn9H1wzNY27GvDtP5HrMeo
	 ZXw+IhsrRpf1gukcin3WmzSCdHn3xXIIoAmNzehi3n1+rojmmSc1GEbEEZWMXKLpdg
	 uMDmXgqr8dtD+5UnuEIdmGjUatkQFcW+jySaRLDFP5uyJOimuVmaYb60/QbCUHKUdj
	 B2wiQNl/6OOzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A66B260731;
	Mon, 23 Nov 2026 10:22:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4F1E1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C28D64066D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RnydeoLQumdg for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F6104065C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bEOKZQYh
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F6104065C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:49 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so29717645e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429367; x=1796034167;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2CRC01Hil82fgxBJOQbR0iL3IKv1xays/YpHBvADPFc=;
 b=bEOKZQYhjeehMQHh92igMC619Y745vu0VF5ierdU4mUVQNMxbaihYJNoZj6vz/gNLR
 sYkZ0DDH2qpXSA2WRwbBPJqTdtLQQrHEKRLI84gbuUZBOElqOlHhWt/NXHRppIPwYYmv
 Ts/12gwga14aGwMEQnGUqpdh9YSjUm75PA+sVsbZgZA10cXBDs83q5dN0IAM/OiOCLmB
 qMgAmmZk/PB1o9f+u7iEWP3KHuIpGMBkNyQcZX32KoJ1t2O3/gN3Vtum0cR0M5e75P6n
 o5btHVC6gac1Ww6oFhdrEvT1crUXV/JjbASkL9+T4DXblOSjAjZ1EJVTogYdFNkEQ4nG
 Ll1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429367; x=1796034167;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2CRC01Hil82fgxBJOQbR0iL3IKv1xays/YpHBvADPFc=;
 b=DlvbDX6mKDpo+6ynIJzwdREM7dVYrV/lQE/wL/01OSQPa46TBJ9xB3CyZL7CETONAR
 FYtnVZ6FlL93Ed578mQQy9wjW5Hs4aSPbzLUKMIf4xwLwdCk1OxzY12rTON7MA9/J0tu
 +wBfQP06F7f2uDA9sDv/i5Gtc3S8EOyKGeZ7vPQFCxYBVM6kw4v0Z161EDs4KdWsfwUM
 VpQfQ3tJkXSo/gQCiWHPgiTteXWdHCGoBiE+kcJc5zwMc1ehevzEKTQdJpiFiBrU7wtc
 8ChOWIOZT/skiS2qXASl0+CLjsv3gJC+wGdxqpbjR+BDb5dXPWo3egrZdfyO0vScnSZf
 JMrg==
X-Forwarded-Encrypted: i=1;
 AL+hErEXZ59zYA787v2mi2fbJv/b4dbJ/rYf3QVe9Pn+D2rU3BxAmSlzQgBzdS17MqQ6gePefJb+LMI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z83HFML3BfS0zRWZKiNdskjOMq1cCRQt/Q3RyqsIOxlaUFRIaQF
 UDHg+nkCXikfuhZxqQ/TmzAeT8dNaKnBNaS5Bg5n5er3LK8DOo+IA+0Od/tE2m3n5H8=
X-Gm-Gg: AZFdTZdsRmvdMS9NzzcemIVpkiQmUAMoUsys7USrCuICy+6nWNTC5HqSxn/g3pEOgA7
 zdSAqonAkuyboVzSaYUQnayE4TWxxgNbMOX4jhkhYAsR1rcQdIhAm1UvESHUTY68azUtTYQeCjZ
 9IZenhbW4kRgPyM4Wvw3r8/yc/38OcMStNE2WM5oCuUX8XJ2z4yr0QbKi78dBFQB4WhZm39fvO9
 sWLXUCJi9d6WErGbbyvx/juAHju7BHSl0iHXYIUiYXGddejKqbT79XofNBHngo352b/mbXVpu7d
 WwMGIya4KSUSylDu2YKqdd89J2j0ca9MagHm/44KLtVDl/tJIyh0/Eeb35v+kDDdB1eUg+c0c9Q
 hfG3DmEYa6tT4TetDw0i8krtS6hMryIXHTxV31sp9MYnx9GduXR4xbNKWsIg5begdGAJePr8De1
 tdPzlxCpgISLA3mGHz7aYBFtte2SxmAFMJrga+jdV5VtP50gJOsmi/bHK26w23AAo8mzkcEbc9x
 LHEhEhgQ6pfBO0Rjw8dwZtxNlQ2SSysBgZ5yr8Tq/NEBY8/vRmKTR6I9yg86+N6ojzTWYGFsjYb
 oAn5QGQkYlXnqKDz4P/Bvxr9hSw20pCTdkxMr/SkAK4jezyVW9a5FFV2zwfzfzyIY/Iil279L11
 HZRjhEqMI/jaItMAXZfJmXmO/0u0toqPQUykyXUfIs+Wz5g==
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id
 5b1f17b1804b1-4bb888074bbmr268204245e9.12.1795429367360; 
 Mon, 23 Nov 2026 02:22:47 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:46 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 11:22:21 +0100
Subject: [PATCH v2 6/8] pinctrl: mediatek: mt8189: fix the I2C3-6 pull
 resistor offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-6-7d3f843db7ef@baylibre.com>
References: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
In-Reply-To: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

