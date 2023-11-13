Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF05C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 01:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84F186B9A;
	Mon, 13 Nov 2023 02:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OcYs+CEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A8808701D; Mon, 13 Nov 2023 02:49:36 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA81786B9A
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 02:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d63e0412faso518076a34.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699840172; x=1700444972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhuXaK1nkfB94SXKHqcAWitSO/acsFBFmPnl2Cf7zBo=;
 b=OcYs+CEPCH++WJ+pyxVRvbhsQw2cBXeho80URbgE/A8Gx7RsQr8Ai6M+VzN7A591+x
 OIEaaOQ/I0tviVPy4Z+4JsX44j3gRkMb/tWrvQh9cbvbq+O24y4bh5xcPrYVCyDT2V+X
 0t9VILB2woZXuCaJo4Dmkpths/1pF8fffzrbzPQ7WCFYe5lIYq1+qsIYwn5xhDHrlyFh
 9tpKzrqucTmx0wcNU7J0dZLaHJ40g6H2mtAdQIuYgzBBrI6XIfYBaVJwCHsj4HbvfSom
 41FE/gIKgn7Y1jnsBexn05bnvv4oRWAPBrGfEXBYyos/wKmhL2y7qo8SFhLWgH9iLUQB
 FHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699840172; x=1700444972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhuXaK1nkfB94SXKHqcAWitSO/acsFBFmPnl2Cf7zBo=;
 b=ZXYPo8XIl4CoE5k5SIIu6LT7rowZ/Ge5ATsOFRQGxIDMDPuQK4Gz9fetKpWAHDMrRf
 xBqG3xnGRYl/ipCCa1AnsoVdLU6G8Ghe3862hu8+0XVxcClfMkEKNCCj3RnKT9RsqMNN
 uzQSgemXEH8VDB0z+H0fpo9jfVvHnv6PD2FuiiMJEFsYnSV/8QufTlQV4JdvjZrF6kl7
 s132StGKkTLy56zCW9Qrx1lSGsn7mRqU3nbGKANjXIoABfansGMNXCcavAdeWYDb1Gpa
 FaI2nijZTt5/Tc4F/SQuwWgCzKKH8/o3kUX9LSUYFATUBcrayH1nbeJ+sN23+i5RmnG7
 VzRA==
X-Gm-Message-State: AOJu0YwclcldCSr7biMtxyXCZPFj58Meo67HWGVEMr0LTvZ67ZONP5MM
 nUvBaAopo8jFr4pV1JNWWm/e5g==
X-Google-Smtp-Source: AGHT+IGARVO+QpxvHewi3PNoVF19tAicU2bdXZG8NwFtadTVZOu44rI0+fmlcWIQw1CcxG83T9Nf2g==
X-Received: by 2002:a05:6830:33e3:b0:6d3:3332:fbfb with SMTP id
 i3-20020a05683033e300b006d33332fbfbmr5407245otu.0.1699840171852; 
 Sun, 12 Nov 2023 17:49:31 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:ba59:509b:48bc:9f1])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a65644e000000b005b92e60cf57sm2635549pgv.56.2023.11.12.17.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:49:31 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 1/5] test: dm: skip scmi tests against disabled protocols
Date: Mon, 13 Nov 2023 10:49:07 +0900
Message-Id: <20231113014911.3308990-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
References: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
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

This is a precautionary change to make scmi tests workable whether or not
a specific protocol be enabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 test/dm/scmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index da45314f2e4c..2f63f2da16fb 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -217,6 +217,9 @@ static int dm_test_scmi_power_domains(struct unit_test_state *uts)
 	u8 *name;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
+		return 0;
+
 	/* preparation */
 	ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
 	ut_assertnonnull(agent);
@@ -317,6 +320,9 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
 	int ret_dev;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CLK_SCMI))
+		return 0;
+
 	ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
 	if (ret)
 		return ret;
@@ -382,6 +388,9 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
 	struct udevice *agent_dev, *reset_dev, *dev = NULL;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_RESET_SCMI))
+		return 0;
+
 	ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
 	if (ret)
 		return ret;
@@ -418,6 +427,9 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
 	struct udevice *dev;
 	struct udevice *regul0_dev;
 
+	if (!IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
+		return 0;
+
 	ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
 
 	scmi_devices = sandbox_scmi_devices_ctx(dev);
-- 
2.34.1

