Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B265CD379F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020F68841E;
	Tue,  3 Sep 2024 18:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fd0ps+4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5389687705; Tue,  3 Sep 2024 18:13:37 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A7F8841E
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42c7b5b2d01so35328275e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725380015; x=1725984815; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hAkEONzW+oXgMLW2KMeZTT3ujSgH9yx3Ok677iiHC3g=;
 b=fd0ps+4QnVFtturo1UgGfDJ4sLHP2aJYSp8DhqinT3m0Dx9t68Hd9Ix1K0iThMszRL
 sZZp2BFb9EItSoJ4oxdScyPIaPe4UwKZPYzRKP+wSm+UxMM3qTIs5mJldnHpwqf9lvJf
 k2vXF6evZKbXOJbfl6m3YEIsXNI1LZZO/ns/hf2wXLP0D/NxOszn7aqAFai2WwFupZDo
 68oGpXCYQcn5oNZ5LwjyElAFWs6bc3DG0h0YB84G6WXhKQJb7H7jTDIrJZ/Vt6fFpCLp
 FieW9EckxftV1o32reaL2Z+caG3sV14nnRN/L/u2wi6B+zvaW5dQBuKLL3+3zdMhvQb4
 5XZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725380015; x=1725984815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hAkEONzW+oXgMLW2KMeZTT3ujSgH9yx3Ok677iiHC3g=;
 b=brMUIcEsPR/Ni/S1ECsukfWR/NkkSpiHRexWdyL9/MeL+8HrzSWNdfVjogf3bnN1TG
 fIvPnAvRnVrlXy84M5kVdDH4lLaFz+2kCBbQ+emLaQ4ebLew5zbJ+NNnqVt2s8rruYey
 5V7dss4YAxexgESPy9fYSU7i1sYiSgQ2qFFCBtCYvM65N2DOPZ5O8O9iBpAbEAsxJ4qG
 pbtctmVc6tb2lnb+G4osLdqM3NDxyNbbfxaFByuJ/uaCni+e/vYLERj9bHVwORYJ9ppq
 XhsoT093lwr1LqjwZ3qq4dieOCzfW9SYqlaolqQyfoKtWzcQYItI/mJ3V3wXk4E5l1Ki
 d9Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIdl9BZTS8KY9nS+MZ+LY244CVB+uBlO48IkxWTJrfxJOhG7p7oes0nTWmrHApuYLpjpU5tAc=@lists.denx.de
X-Gm-Message-State: AOJu0YwNUTOzJ4+23/nrEVeuAjURI8Vnj+UBXVRFL6dM5Q2i8BcFxbmT
 j0iiE+sKu7Emznp8fkqqU76MxPZFNEXso8uOPm5HOFpYsjj24D5tzKWKP7SWMBs=
X-Google-Smtp-Source: AGHT+IHsyf//P+E0+9hfWB5qYNmLWSCSLi8hN6griS+Y0eWg9tqhbfVisa8x+DDFZWf6A1WKsrxSng==
X-Received: by 2002:a05:600c:4f42:b0:426:6b14:1839 with SMTP id
 5b1f17b1804b1-42bb0136dadmr170411535e9.0.1725380014289; 
 Tue, 03 Sep 2024 09:13:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3767dc16f83sm1807517f8f.60.2024.09.03.09.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:13:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 03 Sep 2024 18:13:30 +0200
Subject: [PATCH 1/2] soc: qcom: rpmh-rsc: add back __tcs_set_trigger() for
 SM8550/SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-topic-sm8x50-regulators-support-v1-1-0857185bddc0@linaro.org>
References: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
In-Reply-To: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2858;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=smjWN8nyrz0L2KEatxfzxGPqyWxT87Bxols/pVkOpFc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm1zWrC70kVHZ/i/ruCWdkyzLbcVH03srzXs7KSSUL
 H6202MyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZtc1qwAKCRB33NvayMhJ0UVnD/
 0UKDYWPHANqAQt5YsFueE1R+4QERL2GjBgNmieCBhpNAnsxtePuxIg6CO3195EB1kM3NNp6q6ox1Ko
 hgZksreGpLbu5XV1dKlyo1LxlDI0Ck0EdV6nZBs4ioeUIOqjci7624hzrxpCs4N7l2w2cTZZ6ZA4Uh
 B5xOvTrGA9qb6iE36zqPNWS5DAkGoahjfuxm70V4ScdsEs47klKVqd4tl2XHXcvfGAezscSbLUunVr
 4tZLiPyI3EK6QwQSfpiyACVnIAZmMH5ygD7Qz7s9FKP9Sjj2M3wHVyoHI6wX78YQMI+o7PFueMsWWC
 tlrgIDFIn+3QSpCIZJ7PCvXoi7hfEApaBlZ84jdS5S37Im/Iw4OCBFoNbBEwcfDGx47PlGtCnMvI25
 zW0RqDstVAXcAe0OsdicKFmj4tkLplwRnEGBMrteHfZrQWhxbBQb6yNml4oJ9mUcDA+V4kPsZj0bbr
 vIQEvxtjhz3PexH6xn1krTfo3sKdyqcKPmp/XZaYRD6f+f+CAu8JFcYFaLjdOXYS56NV8cNQIYU9wW
 worCxgIFKoj3+phMNIF0MJns+WRaQ1TP9+R0bpEHIX/OpEjevvL9VJx/O7yvIi8V0A0diDWhXrkTVD
 dgavnHIlUb6Ek1ukq00LquLQbEVPN7oOs8JpMa/S4vkM/A0LBGwGZVKH08AQ==
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

The TCS writes has no effect after the removal of the __tcs_set_trigger()
call, obviously it seems the RSC version 3 requires it to complete the transactions.

Fixes: 80c5be164ad ("soc: qcom: rpmh-rsc: drop unused multi-threading and non-active TCS support")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 61fb2e69558..aee9e55194e 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -293,6 +293,48 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, cmd_enable);
 }
 
+/**
+ * __tcs_set_trigger() - Start xfer on a TCS or unset trigger on a borrowed TCS
+ * @drv:     The controller.
+ * @tcs_id:  The global ID of this TCS.
+ * @trigger: If true then untrigger/retrigger. If false then just untrigger.
+ *
+ * In the normal case we only ever call with "trigger=true" to start a
+ * transfer. That will un-trigger/disable the TCS from the last transfer
+ * then trigger/enable for this transfer.
+ *
+ * If we borrowed a wake TCS for an active-only transfer we'll also call
+ * this function with "trigger=false" to just do the un-trigger/disable
+ * before using the TCS for wake purposes again.
+ *
+ * Note that the AP is only in charge of triggering active-only transfers.
+ * The AP never triggers sleep/wake values using this function.
+ */
+static void __tcs_set_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
+{
+	u32 enable;
+	u32 reg = drv->regs[RSC_DRV_CONTROL];
+
+	/*
+	 * HW req: Clear the DRV_CONTROL and enable TCS again
+	 * While clearing ensure that the AMC mode trigger is cleared
+	 * and then the mode enable is cleared.
+	 */
+	enable = read_tcs_reg(drv, reg, tcs_id);
+	enable &= ~TCS_AMC_MODE_TRIGGER;
+	write_tcs_reg_sync(drv, reg, tcs_id, enable);
+	enable &= ~TCS_AMC_MODE_ENABLE;
+	write_tcs_reg_sync(drv, reg, tcs_id, enable);
+
+	if (trigger) {
+		/* Enable the AMC mode on the TCS and then trigger the TCS */
+		enable = TCS_AMC_MODE_ENABLE;
+		write_tcs_reg_sync(drv, reg, tcs_id, enable);
+		enable |= TCS_AMC_MODE_TRIGGER;
+		write_tcs_reg(drv, reg, tcs_id, enable);
+	}
+}
+
 /**
  * rpmh_rsc_send_data() - Write / trigger active-only message.
  * @drv: The controller.
@@ -348,6 +390,7 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	 *   of __tcs_set_trigger() below.
 	 */
 	__tcs_buffer_write(drv, tcs_id, 0, msg);
+	__tcs_set_trigger(drv, tcs_id, true);
 
 	/* U-Boot: Now wait for the TCS to be cleared, indicating that we're done */
 	for (i = 0; i < USEC_PER_SEC; i++) {

-- 
2.34.1

