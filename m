Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B515CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 745D383FBF;
	Wed,  8 Oct 2025 17:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Iqy8Ld3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79F4840B6; Wed,  8 Oct 2025 17:31:42 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30D283E8E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso49355035e9.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759937500; x=1760542300; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bQviYp84JciVky/cMfWzLwyOaJqzhDmDsna3rw9ihM4=;
 b=Iqy8Ld3BxGw78mftKafLBNljZNxAu/UCXbyDWipUj/HqKtQsAb5Sapcs8B3T5xLv0D
 bMjT+ZlsEn1paWWmtxlXlS89TNrj6wabIolJUq2g2U/kx0K0a2Toyy2wIAbVadKvG249
 hc+Eo+BOh3+HGlz5OunTGZFTQV2la6U4DoeHbwOkIJFCrPmu7c1WPN6vyDrmAJfsjNnU
 41UvOhvWKiFfm8dQxECD2Jh9ZHO8OOd1YmqBYeU9ORFnaUYbBHF3VYHmmrw52lLqQWYO
 8BemlmOBLU9iwXO6kvlhbjW4ZXU/8vBubPEbCS0jtW4ibXNBCkH/I44vrJ6WqMIqhE6g
 4GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937500; x=1760542300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQviYp84JciVky/cMfWzLwyOaJqzhDmDsna3rw9ihM4=;
 b=HYmUEeWNDUbRAu2v8r8ShXpp4OVWnQcY1vQJOXVFpC/eNg2CitT1dvgGu9D037eGf/
 d9RDS9vWmpoPSsIIgshg3q+tfMR/Fx3q/foGXxlPK0cfa9HwiLuS38Qnu8l8lFaNPilJ
 mA0fBYoUY3p39FTWhrun6SM+/ymRgfMbxNE9IMTPqLhQSwrWxy7BxeQQNQO0mpj9IQqF
 DEa10fIAXp7cR9z6XOepdypB8VYhzRfHqHkmX7kZrGn6nM/d/V+Boxe07agu8xSGWff9
 gocvlF2i2FfL1mBYJ8UI3JISxtJ1f3+DGjizVLr0EePXostfEziNpqimxM2jDsVfRdg+
 C5yg==
X-Gm-Message-State: AOJu0Ywo/7337rloKRQgm3LUbB96Ho0rpUc5qE6GFU7CzyCtbH5MfPPJ
 jW/6Kl8cQb8puWMXD1s63ytfHgQA4rrDRH9bv5WVNnesfoFywg2AQJCWOlctj73wrzw=
X-Gm-Gg: ASbGncvWnlOiVpy8Khuy+0N8TsCPUP0DCnGL9NFXNpy5QDX7eD78zT6V27/ENiBKedP
 XvqE0U1WBnvIpRpdncTsN+bL6c2CSavZ5NT1jqAXQxZ5Zg5PvjYdkOIhxEOXwaZQszdehhaT+0H
 JW4JayuOc8k6jG0HmwuOdLiX368pfsP57u8pakiBQQtR3WyPpsy3y20RNvUDdsBrYvKvVGkoETU
 e+rYYKRPzsCRjjMofxXR9T+E2d+RHMIFZ3JRyd89ndTs1mpkpPFqG+GxQv6BETcHT3sat96WKrl
 yxLvbVG/+XOI0W6DGqipbZjr6fNcZs6o1TqypxoY2LNGuTNhPBFCjuGrarp/jo/3qk3vMgh35Cb
 F+YT2Bih44Qj88pqxaBgnPS/jpOA1GsKvZT/dKs1+ewwexhjvYcXmpaG8rE37WsP4CJ1aPV0=
X-Google-Smtp-Source: AGHT+IGKsvXRBRj8hL8dbAv4fUj3/SuuIRNi7xAivYcWE+3o9SCqY/oUmqWga7XCrtKzQ7/TgvJJUA==
X-Received: by 2002:a05:600c:3b08:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-46fa9af830fmr29673125e9.18.1759937499898; 
 Wed, 08 Oct 2025 08:31:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm30715289f8f.32.2025.10.08.08.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:31:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 08 Oct 2025 17:31:33 +0200
Subject: [PATCH v2 6/7] ufs: qcom: vote for interconnect bandwidth on probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-topic-interconnect-next-v2-6-c46e94dd328e@linaro.org>
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
In-Reply-To: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HGjAeo99U8ytQ9lxmyzlg3znvKIGM1GFqv9/Tqd3110=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5oPVZyF4iD8VvqK4N4uq/fIq9l4wbCmawZlbYV6x
 y3Csk7CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaD1QAKCRB33NvayMhJ0Z3oD/
 9uHoO6KKczKd7fZbyhblFNhYK12XBhVGYXXV6m4qPRb6hSNvSjhTnZTRZLV7xCrvczBm1fhu6x+UVP
 UgrJm7InjZaGKIjMBEfZyvU13JSIP+wJH7auvIze5cBrTMqqSA6y0he2AiAWzFu0dxexoCpMKEF2CO
 yP+/FNZhE7BUdPRJ3SIXTOoNsfxl4XDAOGn1f4uaereGzUoogDnEf/fEv7gKhRGcaJ2oww1W7z9Ptr
 q/NmHPDNEqDYN+43FQXGW/Sr4EzDVimU71Ot+JwxEMTusn6qVJlFX4w5heGRKj5GL0UZySxXflUcsY
 EACIa612MRTR5UqqoJLoZ0MXa81JF6iBaEpIJIdcpDcplT4u9hnKYIdCgC2itRe0AOIlXxfz+x5Em/
 1BnUfuVmXxG3+EkfqIVfMSyGGAEzCyhZiaN+Dejij89vTKl0RlQWyXofPjsQmB4Ila1d3NuehlK840
 x+YV3HkydyejdNIsOYwGdQkKxCwf53ATzKRgYUrSrx8csR+Qho9QyovubN1aRL6lVJCD2nMfioQO0M
 +b4dHL6XGFWyum+4sGhRTVsxUp4kMAQUyxh/gUXIGLMaOl30AaT6G2F3AOj5fZCMC/luUkFBSBv0xS
 YtDCyDVr7a9JewlkD8HHj8iLXC7SH2OowkL/aiVhANUaSIySjqEvi5A6QWkg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add Interconnect voting on the UFS probe to ask for the largest
bandwidth possible.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index 843585726c7bf001321d927a4daceb64d0d6f153..c21a7b9947c96af61eeb33a2f06d48b2e71afe41 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -16,6 +16,7 @@
 #include <generic-phy.h>
 #include <ufs.h>
 #include <asm/gpio.h>
+#include <interconnect.h>
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -26,6 +27,9 @@
 
 #define ceil(freq, div) ((freq) % (div) == 0 ? ((freq) / (div)) : ((freq) / (div) + 1))
 
+#define UFS_DDR_MAX_BANDWIDTH	7643136
+#define UFS_CPU_MAX_BANDWIDTH	819200
+
 static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
 
 static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
@@ -625,8 +629,17 @@ static struct ufs_hba_ops ufs_qcom_hba_ops = {
 static int ufs_qcom_probe(struct udevice *dev)
 {
 	struct ufs_qcom_priv *priv = dev_get_priv(dev);
+	struct icc_path *path;
 	int ret;
 
+	path = of_icc_get(dev, "ufs-ddr");
+	if (!IS_ERR(path))
+		icc_set_bw(path, 0, UFS_DDR_MAX_BANDWIDTH);
+
+	path = of_icc_get(dev, "cpu-ufs");
+	if (!IS_ERR(path))
+		icc_set_bw(path, 0, UFS_CPU_MAX_BANDWIDTH);
+
 	/* get resets */
 	ret = reset_get_by_name(dev, "rst", &priv->core_reset);
 	if (ret) {

-- 
2.34.1

