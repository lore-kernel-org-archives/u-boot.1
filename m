Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C2DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 02:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A805A871C1;
	Tue, 14 Nov 2023 03:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hCybj/ZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889F6871A5; Tue, 14 Nov 2023 03:14:49 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59237870F6
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 03:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc703d2633so5563575ad.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 18:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699928085; x=1700532885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMQ30vVJ6x3VuIzzlPgixo+7jt4+e1KA7PiQ5YhXggU=;
 b=hCybj/ZDsvbt5ZxHNErB/Q/w/QPzuoSRz3AiFcWrerQ8FKLGapwfbj9Glj3NpBmkSK
 eJ8xbItjVm/jz4iiD21e+rVvj59c1/wSo6Cmul+qOeh+xItw0Gg7coyHhw6Ss7HSB6cq
 pr8rPr+s4VkeoU/UQawH9Ct/JTk8+W5YidmgdJi7y00aZ0gXRDi3vcNXmFYgE2cmWNwO
 dv67BO9wiFsrGyL8Cky07MgdgtgSCpz0XHLJH2f6cI+ZVc2sbeZGvVCn9//OD8r/rLrv
 Kts7dgLzq3sZLIxSaf2OzDdeWmPE0peekej5V/QAg2B6hD/0OyOznC2f3iNf2Sa8QBD5
 krqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699928085; x=1700532885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMQ30vVJ6x3VuIzzlPgixo+7jt4+e1KA7PiQ5YhXggU=;
 b=IlayWiP4lgEL8x/PfklzYaHaIbhuyJTJoZ1PVxyBjia7mwOfg/e08DQrXMM2tvt41i
 IZaD0hpk0Q9O1i9tD4Rv9VHOuSungoxkNnbFs80OtIJQivj7f5W9rFhxD1HJKSuFonIb
 bahxlMJ7RripoOJRyKNaO8cQ/xkbZg1UvHFApoOTtAg7402wA4wXpxarSImA/1VuFAoB
 Vl0pz9wpw/jyE7hqIsnAZUVbe8fQOj88I8Xu+8sAjRY6vW2kWpoiNvkaMGI4lc0PP6CC
 je7FrCGl2xCQ/hWikQGlG56Q80Gr6sGDaUBSLcidiJzOOO2XLWRjhkhCAkc3DNWriDgN
 IODA==
X-Gm-Message-State: AOJu0YxRSfs6UvSOidvDVOMem8Xbliqf9wOS2QI+UtYEC5s+3AnBJbld
 DAyY3OC4tNiEllh4g7QwrFVbTx5ax47Rr8zRf+ddAA==
X-Google-Smtp-Source: AGHT+IFBQR3QdKMQxMxC+6YfUOO3Tjw5lrGI7y3pWvMMmZqAeutcqzwXsAXRFgVJb7HioEj4a2h4Dg==
X-Received: by 2002:a17:902:d2c9:b0:1cc:2bc4:5157 with SMTP id
 n9-20020a170902d2c900b001cc2bc45157mr1201454plc.1.1699928085520; 
 Mon, 13 Nov 2023 18:14:45 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:66f2:cd5c:3d82:6e6f])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a170902c94400b001c61afa7009sm4680475pla.114.2023.11.13.18.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 18:14:45 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 1/5] test: dm: skip scmi tests against disabled protocols
Date: Tue, 14 Nov 2023 11:14:24 +0900
Message-Id: <20231114021428.531887-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114021428.531887-1-takahiro.akashi@linaro.org>
References: <20231114021428.531887-1-takahiro.akashi@linaro.org>
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
a specific protocol be enabled. If a given protocol is not configured,
we skip the test by returning -EAGAIN.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v9
* return -EAGAIN if we want to skip a test
* use CONFIG_IS_ENABLED() rather than IS_ENABLED()
---
 test/dm/scmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index da45314f2e4c..582485471fff 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -217,6 +217,9 @@ static int dm_test_scmi_power_domains(struct unit_test_state *uts)
 	u8 *name;
 	int ret;
 
+	if (!CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN))
+		return -EAGAIN;
+
 	/* preparation */
 	ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
 	ut_assertnonnull(agent);
@@ -317,6 +320,9 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
 	int ret_dev;
 	int ret;
 
+	if (!CONFIG_IS_ENABLED(CLK_SCMI))
+		return -EAGAIN;
+
 	ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
 	if (ret)
 		return ret;
@@ -382,6 +388,9 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
 	struct udevice *agent_dev, *reset_dev, *dev = NULL;
 	int ret;
 
+	if (!CONFIG_IS_ENABLED(RESET_SCMI))
+		return -EAGAIN;
+
 	ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
 	if (ret)
 		return ret;
@@ -418,6 +427,9 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
 	struct udevice *dev;
 	struct udevice *regul0_dev;
 
+	if (!CONFIG_IS_ENABLED(DM_REGULATOR_SCMI))
+		return -EAGAIN;
+
 	ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
 
 	scmi_devices = sandbox_scmi_devices_ctx(dev);
-- 
2.34.1

