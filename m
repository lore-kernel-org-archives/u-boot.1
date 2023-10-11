Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C797CD6E56
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708E986D5E;
	Wed, 11 Oct 2023 12:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aEkAq1yH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A58386D01; Wed, 11 Oct 2023 12:07:55 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D316586CFD
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ae473c0bd6so1173534b6e.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018858; x=1697623658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKQCA4NmtQLw2v1OtVuIkV/l8UfbIwEX1Xgxft/0LvQ=;
 b=aEkAq1yHxNa5Qbe0T6SPEOgzekI5yoJb/jIX21Rw6XEM++pHDuq6IJD7JqCCjz9il6
 FBuKtOHjEfWRJkufQjD/O1hw9LzKA2RWSbs1TKQZSWh5bPKVNMT8nuMqwWK+cLjm0m+p
 1pn76Bkf5waSI7hLTLjcnnm72wegi2mwTgJKgRReCg37IUf/DHLQqS16LnGQqJKv9shS
 aWDbSWyyM+Pr8EnqKGWClzMJ+z7V55tyLZfxd+AchRy51Wct7nRdF10ExlsuFYXwg9t9
 GeFiIqMNvu5yo0I0JjpX/JEuvKsUdAgxUWDysSAa9AtEBNwqDZuPNVWa46qjrXBzVNko
 xzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018858; x=1697623658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKQCA4NmtQLw2v1OtVuIkV/l8UfbIwEX1Xgxft/0LvQ=;
 b=hGghDV3M56y7t1kxS2nWHrwg6PgzO+cvb15XITobuxb2/CIrQop9lInAXDzg2vDIJK
 FXfhNNSgkMmTK1qTaBBe7SS+ucF8KVNDaPIoQoby4asdaG5vCZdqNHkQSYVl4mE+8+3l
 Y86xsKLRS+mvbjx1zJNZ8DvNYHPtZ3v8sX4NjecPh44u7GvmVHfeliPw34Mw8lh0ii0O
 TnucjADdTdp+QwnhbMmX4gwhgEvlCLiQTqaz8W8CJbJA+Zt1cBNqieeLMUtcAuDBAPkv
 Z9vgv954R+ZG++0LsOOiJFuXh1hGN1Bs2W36PgpHiVOEuQdb5VwyVIdM37WEzPpCDcqo
 cs+Q==
X-Gm-Message-State: AOJu0YymNbWAQVxhCas8It6+EedvtBoZWbg6KMLnJRXC9A/y5e11vPFK
 BCUPCZlQ7jR12kiR3yv4XnIlxBpo1smC8RmpnjNQ+Q==
X-Google-Smtp-Source: AGHT+IGuVALzfpRXv7c9RnJkfujwUpXy5iCaUzQhTb8bwLv4ciyxUZUsUHxqASl9hH9zqHD9vXDmwQ==
X-Received: by 2002:a05:6808:3008:b0:3ad:af12:2fe0 with SMTP id
 ay8-20020a056808300800b003adaf122fe0mr23806151oib.3.1697018857755; 
 Wed, 11 Oct 2023 03:07:37 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:37 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 06/14] test: dm: add protocol-specific channel test
Date: Wed, 11 Oct 2023 19:06:59 +0900
Message-Id: <20231011100707.1007417-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v6
* add missing header files (scmi_agent.h, scmi_protocols.h)
v5
* new commit
---
 arch/sandbox/dts/test.dts |  1 +
 test/dm/scmi.c            | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 057e1ca1f4a8..73224e385b8a 100644
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
index d87e2731ce42..8db3ad32f85e 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -16,6 +16,8 @@
 #include <clk.h>
 #include <dm.h>
 #include <reset.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
 #include <asm/scmi_test.h>
 #include <dm/device-internal.h>
 #include <dm/test.h>
@@ -109,7 +111,7 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
 	struct sandbox_scmi_devices *scmi_devices;
 	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
-	struct udevice *dev;
+	struct udevice *agent_dev, *clock_dev, *dev;
 	int ret_dev;
 	int ret;
 
@@ -124,6 +126,14 @@ static int dm_test_scmi_clocks(struct unit_test_state *uts)
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
@@ -172,7 +182,7 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
 	struct sandbox_scmi_devices *scmi_devices;
 	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
-	struct udevice *dev = NULL;
+	struct udevice *agent_dev, *reset_dev, *dev = NULL;
 	int ret;
 
 	ret = load_sandbox_scmi_test_devices(uts, &dev);
@@ -186,6 +196,14 @@ static int dm_test_scmi_resets(struct unit_test_state *uts)
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

