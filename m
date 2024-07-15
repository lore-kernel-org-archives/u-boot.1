Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038CDC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073E188820;
	Mon, 15 Jul 2024 12:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lxHYyaxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00D988867; Mon, 15 Jul 2024 12:08:53 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B671288840
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-595712c49ebso4926581a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038131; x=1721642931; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GRz+XTlCpnsYYi0KK9pzBnfO6FEF2vig2L6TEuG8pO8=;
 b=lxHYyaxWZJ8vFsE33K1LSq2BxRUlUpETRxkFNB7t/LjuTWCeorGSZT6JRruqLXLF+O
 T1zU6VhiKJHGJJLcDwD+JwiMeQWthV3YN38KxmAI3MRJK31iBW1+GwCPtIpIW/xyccGh
 nayXj7SiErS4+UMbas1FwWQsFcqGHaH4JQlInnc1ovI6k+0V0rVGrvwAYVDZ1NHIa6ms
 IrNDwCuGpXxz04hiRaFhsY6zfoZfrESOv9XTQMAyviFOMFnICqyPTczLmQ1OhX4FbMMG
 8oEeri/l6VtcloAyVMwTyB4e0fPZxFs/NANmDgl/0W6q2C0uX8pDJ5JVWjwQ0zgRKR3R
 UzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038131; x=1721642931;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRz+XTlCpnsYYi0KK9pzBnfO6FEF2vig2L6TEuG8pO8=;
 b=vIyOebwf9cZIGDWIHb+JFT89odXb2ZHGCnKLUhtGJU3siNQBtr2YWwqJNlGfk/X+HT
 Gg4i9MjEkcb7aLEqfSZkPIiAm9tcu7p8g6tGf4cKrWyztABFVWWgeNhHBBLQtZ8Aey4u
 AFXj+RmkEiezzBghyb+53c6bo60cTvfVaFcEi+iYlLY9AuirFtDRnJLstFlPwaaUOXhO
 i79EK8tADOFBVrkQx2PFr8u3L6DLCZHL578m1fOwXKbhMATZHY0rSd/kxFufw2TmVZGB
 ts7GP7Kd9cPw+y8qpusO4OEnZZkQEO+6otDCavALCnPmQzEBSEa/u/oeCMvwOFqN/Een
 hG3g==
X-Gm-Message-State: AOJu0Yzg667y0A2IkRYv5rnBIzU2X25kkDnmDxXzzZFbJVO1rg8mEDXY
 3s5Wtk/HIjFreZ9hrH3YRpHsAtTODiYScZeGaf8yJv0X5AVTn1bYsenv0mCXULxKEg6vjLVS4bP
 0lsM=
X-Google-Smtp-Source: AGHT+IFq+Oti7x7CS3mU0GzKjlDESbdy9yIo+VLziYbYeo4pwdv2SqAw4b1lSy5KpYl8KCzJxboh3Q==
X-Received: by 2002:a17:907:2d2c:b0:a77:dc70:b35f with SMTP id
 a640c23a62f3a-a780b883d8amr1588066966b.58.1721038131293; 
 Mon, 15 Jul 2024 03:08:51 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:18 +0200
Subject: [PATCH v6 19/24] power: regulator: qcom-rpmh-regulator: adjust
 structs for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-19-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=U6yGComMBKaDzfG1OpRVhDZGEEuD6iB3cAcmWsZo69M=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUHPp/DLeYKNG/EoHourpkS4Q7DVbyVpp+Ah
 0fztWFUtMKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BwAKCRAFgzErGV9k
 toOzD/44/Nckpaeq/xvcbZeq5n2eoXt+Sb7fwuJHkyIuq2R1THFP9S2lR0Z1hPEPS59JGzrDyGh
 edFsqVIoHwUg497twRg+Oafpz5LEiRSbEc+GOmb4ozAR8qkWgj+PYeJFT5wT5mUgv0554Yd0yPa
 HLKCTWa9PVrypKPWk0YQBPU/DrKZ14sRBAr3+DisMJ7+K3axfQwSpMtncfYbHznovK0AvIiQ7sy
 X3GYmR8//4OST9vyjf/e/Su+vedvruhmnG+OQ6fqBXAMu0jZDfrmIi378AiiLExIG+MLR+2e0tw
 k4DHyeZdfhegYgn0Pun+BeqWtP9EMgRkkL2PUTFv2aBfN+I5WqRIiKa3er8iPscP+8bM/Ppj+2C
 3/vHBntDaM0PEFzxoLygW6XVNKffCwVOAlBnlxa8XO21gz7D+fRwWebN8zW25P1z+gZkhMB6gvt
 kfIg9beWvmxoa5QYSQTCrGuyVUkl705vredE7jqBuUmxcUA7Scd50gtlrvUlAP8fckrUmoBECBa
 /jqjJbYNw8KgrU/1OAI+vCC+GryQJkXm69jkWnpnKblcOZyiwTUubcBLnnmRL8G8rAY3kvThegS
 C2PM+K/nsXHMjMLznSa39g0bkEM1AJFXF01Zk1kG2cOQUsgQTDg3SVlmRCU35l5OMLYA+f+I8xm
 75b0uJcYk//UJWQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Switch to our linear_range helpers and remove unused/unsupported
linux-isms.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 28 +++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index d0acee9f558e..089623f3a2b9 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -102,13 +102,12 @@ struct linear_range {
  * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
  * @regulator_type:		RPMh accelerator type used to manage this
  *				regulator
  * @ops:			Pointer to regulator ops callback structure
- * @voltage_ranges:		The possible ranges of voltages supported by this
- * 				PMIC regulator type
- * @n_linear_ranges:		Number of entries in voltage_ranges
+ * @voltage_range:		The single range of voltages supported by this
+ *				PMIC regulator type
  * @n_voltages:			The number of unique voltage set points defined
- *				by voltage_ranges
+ *				by voltage_range
  * @hpm_min_load_uA:		Minimum load current in microamps that requires
  *				high power mode (HPM) operation.  This is used
  *				for LDO hardware type regulators only.
  * @pmic_mode_map:		Array indexed by regulator framework mode
@@ -119,15 +118,15 @@ struct linear_range {
  *				in device tree to a regulator framework mode
  */
 struct rpmh_vreg_hw_data {
 	enum rpmh_regulator_type		regulator_type;
-	const struct regulator_ops		*ops;
-	const struct linear_range		*voltage_ranges;
-	int					n_linear_ranges;
+	const struct dm_regulator_ops		*ops;
+	struct linear_range			voltage_range;
 	int					n_voltages;
 	int					hpm_min_load_uA;
-	const int				*pmic_mode_map;
-	unsigned int			      (*of_map_mode)(unsigned int mode);
+	struct dm_regulator_mode		*pmic_mode_map;
+	int					n_modes;
+	unsigned int				(*of_map_mode)(unsigned int mode);
 };
 
 /**
  * struct rpmh_vreg - individual RPMh regulator data structure encapsulating a
@@ -148,23 +147,22 @@ struct rpmh_vreg_hw_data {
  *				not
  * @bypassed:			Boolean indicating if the regulator is in
  *				bypass (pass-through) mode or not.  This is
  *				only used by BOB rpmh-regulator resources.
- * @voltage_selector:		Selector used for get_voltage_sel() and
- *				set_voltage_sel() callbacks
+ * @uv:				Selector used for get_voltage_sel() and
+ *				set_value() callbacks
  * @mode:			RPMh VRM regulator current framework mode
  */
 struct rpmh_vreg {
-	struct device			*dev;
+	struct udevice			*dev;
 	u32				addr;
-	struct regulator_desc		rdesc;
 	const struct rpmh_vreg_hw_data	*hw_data;
 	bool				always_wait_for_ack;
 
 	int				enabled;
 	bool				bypassed;
-	int				voltage_selector;
-	unsigned int			mode;
+	int				uv;
+	int			mode;
 };
 
 /**
  * struct rpmh_vreg_init_data - initialization data for an RPMh regulator

-- 
2.45.2

