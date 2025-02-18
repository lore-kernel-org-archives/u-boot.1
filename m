Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8649C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 17:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C865780F53;
	Tue, 18 Feb 2025 18:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lzh9XpR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC55380EC0; Tue, 18 Feb 2025 18:09:04 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54C980C8F
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-30930b0b420so30314551fa.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739898541; x=1740503341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIvJIqbMgwNZ+HCleExKnnUCvLSob5EofFhH2DXQeOI=;
 b=lzh9XpR8kPfnO+im+lGG3+05/LfqjDGzQ51tTLca/pl7wuZtIYbAqBliyoJR5V5RLa
 nb1yaT2h1D/DwaaiZhYNmiLgmd9YWDsReHRE9P56SuqD522oSKTZ24j+SODeIucuRSRj
 JSXs1T2bCAAPB0c7CaSdYz9MQBVENmrolSfNPFWtdq/LakfxvBN8yfARxV+2DkD73Tbh
 kywbSdPz+JsTx4RL9gR36asz9m0bAZqv7jaV9cSQE6Y6KpIYydaf5GCYc1KOVfFJIPVA
 /vcJDMTfLcLXbnPHE9tyHMWWFln+Icj+YlJ0Q/7vOBYQpPF+zep0lOGv8caKP9iQLBkv
 kAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739898541; x=1740503341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIvJIqbMgwNZ+HCleExKnnUCvLSob5EofFhH2DXQeOI=;
 b=RWsEq7sviYtUGSayqraA77Ij8+VfSKQOmVc9WD+ws0IMQvusR6SeOHS06tmhol6mVj
 GRhhYhitzBd3+SqzxAUqzR+ribYOgEhHqdb3caq/iBFoRZDBC54+axMLWKsf/kVErIkl
 pH241CGLcFd0bXrqEXKkk6NWgtv3OiJtr0MijCK484b812EqmfzkHJ8MsXmVFcqMz7CY
 YojMFwlZvEXQmbx95mn9XSic5hKaL7RQyKCFfxjrqwoO5bTeRD/z+paN87/tNSTcP/Aq
 1ebt9BWdQ/HgTB2DMFLfBQUiYe6GOHQQ+ytWR1+/cKJRKvlcb0iRhie1jIZcuTQ+YOKY
 jI7w==
X-Gm-Message-State: AOJu0Yy5OBOM+dOyaIEQcUVbjrkjhVdHNLYjPxvvwX29BGsHJPa4DuYT
 sWA42Ufu4xw3Ip78NTG/Yto9k8kWJR9rA6wvX2pM1tFSc4qZEEnF
X-Gm-Gg: ASbGnctM6+GtwDUczKBcAGoIVA5OSNxeDFfNgYFV7206s8Y6CUy6HBJeZ64DHGvcadh
 LrBe9Rf0ri43MrgCqCHTR8iWb2U+g9DGXt3hKT+0rVsslkCmstJ0MIzSom5y/WcoWRoIQ0009rz
 XRkyeDbMPWDqZIFg2XqfAKNakq+E62UrW5wi7jhDwW6mDGbFLhBgDOTucZy9A39IhcVLk1cOBLT
 Da25XgaYOrFvZISSVhHtSvXWovDlXeWxRbs6jq4/IsnEqSZO7JOr9LhNdsubYXsb4tzloFyZaya
 9M08FK4=
X-Google-Smtp-Source: AGHT+IFVqegIyaWVwSz3qQAAnVI74eyZFESpEgRzxlu1BgrAhZlAJjMe0V720xZu5aT4ZmqBZBPqbA==
X-Received: by 2002:a2e:874c:0:b0:308:eb58:6580 with SMTP id
 38308e7fff4ca-30a4506209dmr361421fa.33.1739898540849; 
 Tue, 18 Feb 2025 09:09:00 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30a266e4968sm10888621fa.77.2025.02.18.09.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 09:09:00 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 2/2] test: dm: add ofnode_graph tests
Date: Tue, 18 Feb 2025 19:08:39 +0200
Message-ID: <20250218170839.5427-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218170839.5427-1-clamor95@gmail.com>
References: <20250218170839.5427-1-clamor95@gmail.com>
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

Test suit for of_graph parsing helpers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/sandbox/dts/test.dts | 55 +++++++++++++++++++++++++++++++++++++++
 test/dm/ofnode.c          | 54 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b8f3012873e..80291958533 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -2048,6 +2048,61 @@
 			sandbox,err-step-size = <512>;
 		};
 	};
+
+	graph1 {
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				reg = <0>;
+
+				endpoint@0 {
+					reg = <0>;
+				};
+
+				endpoint@1 {
+					reg = <1>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				endpoint {
+					test-property-0;
+				};
+			};
+
+			port@2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				reg = <2>;
+
+				graph2_link: endpoint@0 {
+					reg = <0>;
+					test-property-1;
+					remote-endpoint = <&graph1_link>;
+				};
+
+				endpoint@1 {
+					reg = <1>;
+				};
+			};
+		};
+	};
+
+	graph2 {
+		port {
+			graph1_link: endpoint {
+				remote-endpoint = <&graph2_link>;
+			};
+		};
+	};
 };
 
 #include "sandbox_pmic.dtsi"
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index cc8b444ff9a..0f60c2a6281 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -23,6 +23,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/of_extra.h>
+#include <dm/ofnode_graph.h>
 #include <dm/root.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
@@ -1651,3 +1652,56 @@ static int dm_test_bool(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_bool, UTF_SCAN_FDT);
+
+/* test all helpers found in drivers/core/ofnode_graph.c */
+static int dm_test_ofnode_graph(struct unit_test_state *uts)
+{
+	/* 3 ports with 5 endpoints (2-1-2) */
+	ofnode graph1 = ofnode_path("/graph1");
+	/* 1 port with 1 endpoint */
+	ofnode graph2 = ofnode_path("/graph2");
+	ofnode node;
+	u32 id;
+
+	ut_asserteq(ofnode_graph_get_endpoint_count(graph1), 5);
+	ut_asserteq(ofnode_graph_get_endpoint_count(graph2), 1);
+
+	ut_asserteq(ofnode_graph_get_port_count(graph1), 3);
+	ut_asserteq(ofnode_graph_get_port_count(graph2), 1);
+
+	/* Request port with reg 2 */
+	node = ofnode_graph_get_port_by_id(graph1, 2);
+	ofnode_read_u32(node, "reg", &id);
+	ut_asserteq(id, 2);
+
+	/* Reqest parent from prev requested endpoint */
+	node = ofnode_graph_get_port_parent(node);
+	ut_asserteq_str(ofnode_get_name(node), "graph1");
+
+	/* Request endpoint under port 1 */
+	node = ofnode_graph_get_endpoint_by_regs(graph1, 1, -1);
+	ut_assert(ofnode_has_property(node, "test-property-0"));
+
+	/* Reqest remote endpoint from graph2 in graph1 */
+	node = ofnode_graph_get_endpoint_by_regs(graph2, -1, -1);
+	node = ofnode_graph_get_remote_endpoint(node);
+	ut_assert(ofnode_has_property(node, "test-property-1"));
+
+	/* Reqest remote parent from graph2 linked endpoint */
+	node = ofnode_graph_get_endpoint_by_regs(graph2, -1, -1);
+	node = ofnode_graph_get_remote_port_parent(node);
+	ut_asserteq_str(ofnode_get_name(node), "graph1");
+
+	/* Reqest remote port from graph2 linked endpoint */
+	node = ofnode_graph_get_endpoint_by_regs(graph2, -1, -1);
+	node = ofnode_graph_get_remote_port(node);
+	ofnode_read_u32(node, "reg", &id);
+	ut_asserteq(id, 2);
+
+	/* Reqest remote parent from graph2 linked endpoint */
+	node = ofnode_graph_get_remote_node(graph2, -1, -1);
+	ut_asserteq_str(ofnode_get_name(node), "graph1");
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_graph, UTF_SCAN_FDT);
-- 
2.43.0

