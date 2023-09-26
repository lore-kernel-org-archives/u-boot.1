Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB34BE7D240
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A851B86C5D;
	Tue, 26 Sep 2023 08:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tfze/bZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6241F86CC2; Tue, 26 Sep 2023 08:58:22 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4622186C5D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ae08c64f68so918040b6e.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711499; x=1696316299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ik3nT2QALNs6ZxffYnItFAFu0LxTa/+AMnaipd9inek=;
 b=tfze/bZ8OWUfLLyrBZYxCtKVpKL7nAbjMEs/asZDTgweTQolgyL++1RbBm8JW1qdjY
 NUWJTs6NX4CCP7bUxArC1tG2tVAW+Xnu2eT8bvdYVy6tNdSlh7PIJaqzNRhrURmxaatI
 rZBEDTMvAovejjD2PR+JckCDW7kCAfMZhafI//xQmqRPuZqwsrFtMRTmnROhm6mrpf4+
 9Gdg1tWmPNpLpv6eKhpXc9mq44tTIzBWFqzlzOwhIg/oKcYyGMmX+flhitRJ21iO3vrZ
 U/XPg6C76ERO5IMRiw7zIHTqPfDnqHjcBOYj4tv0GdbhhskBEGs03R9icZH413AMt6ml
 hqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711499; x=1696316299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ik3nT2QALNs6ZxffYnItFAFu0LxTa/+AMnaipd9inek=;
 b=AbkrizcW8k+9ynH2IzIiWUioX3E0ZuGhaRYZwxyPEdrGrNx9WMDjQHxRYuPZgrSDwS
 1Ays2i7cMwknaDPZNPnWyqN4ciMleVaRLY9kGD5QvvL0IJBqqKABMPjR4If8dDS5kz/h
 jS+TjC9lGe0OtQ9XC1VBGi880WrfYi2xd8Qbku7XB60BZSOYBM3soCLgOy6SfTTDwgln
 hufaZ2qL4Kce4dJE1/NcwhIA3he4lxlU37C2HzwlKz9zJKv3R0wmxdBKRx3zFFu0vq0G
 gzYoKGbU8zud/EydzTntFI6n5sPMt7dlhsGgHIABvmA9E1qi57oYSVKodtqo6bUx8G22
 14Ig==
X-Gm-Message-State: AOJu0YwwB854PfeLl24lRBy7m6YWuD9uHOLae4CJ2OlVWVS3TrQpfN3k
 jxmp+ychzdLwei47vI+iwvCFRQ==
X-Google-Smtp-Source: AGHT+IErHKDpQMlbhm6Pq1W27JNb009o+X5eRaqCEYSde4dDNzfOG9O4tE2Cc2PMRevnbtN4056VBw==
X-Received: by 2002:a05:6808:6410:b0:3ad:ae0d:f845 with SMTP id
 fg16-20020a056808641000b003adae0df845mr9826905oib.5.1695711498687; 
 Mon, 25 Sep 2023 23:58:18 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:18 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 04/16] test: dm: add protocol-specific channel test
Date: Tue, 26 Sep 2023 15:57:38 +0900
Message-Id: <20230926065750.734440-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926065750.734440-1-takahiro.akashi@linaro.org>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
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

Any SCMI protocol may have its own channel.
Test this feature on sandbox as the necessary framework was added
in a prior commit.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v5
* new commit
---
 arch/sandbox/dts/test.dts |  1 +
 test/dm/scmi.c            | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index f351d5cb84b0..5e2bf8623dff 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -700,6 +700,7 @@
 			clk_scmi: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
+				linaro,sandbox-channel-id = <0x14>;
 			};
 
 			reset_scmi: protocol@16 {
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index d87e2731ce42..e4fb1bc635cb 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -109,7 +109,7 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
 	struct sandbox_scmi_devices *scmi_devices;
 	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
-	struct udevice *dev;
+	struct udevice *agent_dev, *clock_dev, *dev;
 	int ret_dev;
 	int ret;
 
@@ -124,6 +124,14 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
 	agent = scmi_ctx->agent;
 	ut_assertnonnull(agent);
 
+	/* Sandbox SCMI clock protocol has its own channel */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
+					      &agent_dev));
+	ut_assertnonnull(agent_dev);
+	clock_dev = scmi_get_protocol(agent_dev, SCMI_PROTOCOL_ID_CLOCK);
+	ut_assertnonnull(clock_dev);
+	ut_asserteq(0x14, sandbox_scmi_channel_id(clock_dev));
+
 	/* Test SCMI clocks rate manipulation */
 	ut_asserteq(333, agent->clk[0].rate);
 	ut_asserteq(200, agent->clk[1].rate);
@@ -172,7 +180,7 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
 	struct sandbox_scmi_devices *scmi_devices;
 	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
-	struct udevice *dev = NULL;
+	struct udevice *agent_dev, *reset_dev, *dev = NULL;
 	int ret;
 
 	ret = load_sandbox_scmi_test_devices(uts, &dev);
@@ -186,6 +194,14 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
 	agent = scmi_ctx->agent;
 	ut_assertnonnull(agent);
 
+	/* Sandbox SCMI reset protocol doesn't have its own channel */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
+					      &agent_dev));
+	ut_assertnonnull(agent_dev);
+	reset_dev = scmi_get_protocol(agent_dev, SCMI_PROTOCOL_ID_RESET_DOMAIN);
+	ut_assertnonnull(reset_dev);
+	ut_asserteq(0x0, sandbox_scmi_channel_id(reset_dev));
+
 	/* Test SCMI resect controller manipulation */
 	ut_assert(!agent->reset[0].asserted);
 
-- 
2.34.1

