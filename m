Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623F8C021A6
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 11:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656BF80F42;
	Sun, 16 Feb 2025 12:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O4ASxTgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7567F80F32; Sun, 16 Feb 2025 12:23:53 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B9A8056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-307bc125e2eso33616001fa.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 03:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739705031; x=1740309831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6msuFlFrfohWFkmDw92+5zdGzgobSAWsT/krdRNQA9w=;
 b=O4ASxTgYKMz8xbA7Um9+AN2pf6V/s27Rvs721M9AWLDhfSUBxhyL4WYqrdBUMHoNnd
 o0DW1NjSjLJDhoazYnClsEcBCSVVjMySzgCqfb3rpEBqdwqaQLpwBBe+Q4HxzRp4pDrT
 nLGoP26dO1dV3OFnpHLP7HVgyzl+4UEKHGMcAAl04z03cPvpDqPIfGJOTKCf0k3rnEQ1
 NRcT1/R6kjRuc9CzaD9JMQI2BDn5Bifeg/suuh2Uo+/MwXxed7lHHIG3+/6rUBukrj7h
 rYgLvRsutccKvVkZM/AF2X82SRgvts6EY1vUg5GoAbTjMxmHHeDMsEAFqjLr73BiYYmr
 AbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739705031; x=1740309831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6msuFlFrfohWFkmDw92+5zdGzgobSAWsT/krdRNQA9w=;
 b=QdCUId1XAla9oVa07IyGvRPRZU5M4n33aRzWdrgY6WcnQ8YqvBjKP8OuixZDBDhwtg
 FKVQ6SmAwx9/uy1Jekb4nLKkMugdvYVGBE/Y0luXmJzOdJwvMCVY1vkIEH5bH0utdNJS
 u1SC1aMYeoI8B0ODJQlfJoTo0v+XNoFOXvFJbmE6bvVH9Jezi5NPxwICF9sPXKAuIOEh
 Tf3GfNzfxijC6Hz1V1cHseyrP+GRwlliLDtrzM6uamefzQi0ONAR0U0wpn6yLIvTX5Tu
 P/npHin2nSZp+Jk0MDIxY96Fo6RdDEQKL+c3cr5nt2idSHljnC/PgjzauizVHs5o6TF2
 9+0A==
X-Gm-Message-State: AOJu0YxH/nsK1lAFLvXliWBdUyypZ1rPzBdxBjox76ZYwV8siIke817H
 cIL+Qv6DVObTjCnJ2HXS2g5gopHmIVrx9kF81Qju21jgfA8b8TA+
X-Gm-Gg: ASbGnctHaNUBUpR7xeF5bEkWgCU6wcy6rhQCxN8wCEzDl8KwVpeG2A0XjA7hhxluLM4
 pa/Dj/zlqNuyhyqJshGRFyVCcc3EWc72c3sQin3AFuKT0m32YETpzAXuW4ZejO0GoDhWcPmJ0wK
 mibV4vWHCyr+Az3IO3QzlV39Jd/Mux31E1dahXTW9CHZkZWvkCheS66hOIC7vdGemZORe0EVjr9
 ruQRc9e0CDuthR92t7Y/CHO0iCLWG8NuvIAW7jJ+FkiL/1LquzCb8/QrOzjwLkLhLis84HKhpxK
 sUzaITE=
X-Google-Smtp-Source: AGHT+IF43ZI9/Kp/jEEeF+8lufJbRL5seZxzvfBy4JUsGcZU5xSf+xTxY5YbKvJOXEteXcQwUk3OcQ==
X-Received: by 2002:a2e:380f:0:b0:309:1ee1:3512 with SMTP id
 38308e7fff4ca-30927b197bbmr16251511fa.26.1739705030457; 
 Sun, 16 Feb 2025 03:23:50 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-309100c528asm11976111fa.22.2025.02.16.03.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 03:23:49 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/2] test: dm: add ofnode_graph tests
Date: Sun, 16 Feb 2025 13:23:27 +0200
Message-ID: <20250216112327.59090-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216112327.59090-1-clamor95@gmail.com>
References: <20250216112327.59090-1-clamor95@gmail.com>
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
 arch/sandbox/dts/test.dts | 53 ++++++++++++++++++++++++++++++++++++++
 test/dm/ofnode.c          | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b8f3012873e..22c0d5388a8 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -2048,6 +2048,59 @@
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
index cc8b444ff9a..8faeabcf1db 100644
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
+	ut_assert(!strcmp(ofnode_get_name(node), "graph1"));
+
+	/* Request endpoint under port 1 */
+	node = ofnode_graph_get_endpoint_by_regs(graph1, 1, -1);
+	ut_assert(ofnode_read_bool(node, "test-property-0"));
+
+	/* Reqest remote endpoint from graph2 in graph1 */
+	node = ofnode_graph_get_endpoint_by_regs(graph2, -1, -1);
+	node = ofnode_graph_get_remote_endpoint(node);
+	ut_assert(ofnode_read_bool(node, "test-property-1"));
+
+	/* Reqest remote parent from graph2 linked endpoint */
+	node = ofnode_graph_get_endpoint_by_regs(graph2, -1, -1);
+	node = ofnode_graph_get_remote_port_parent(node);
+	ut_assert(!strcmp(ofnode_get_name(node), "graph1"));
+
+	/* Reqest remote port from graph2 linked endpoint */
+	node = ofnode_graph_get_endpoint_by_regs(graph2, -1, -1);
+	node = ofnode_graph_get_remote_port(node);
+	ofnode_read_u32(node, "reg", &id);
+	ut_asserteq(id, 2);
+
+	/* Reqest remote parent from graph2 linked endpoint */
+	node = ofnode_graph_get_remote_node(graph2, -1, -1);
+	ut_assert(!strcmp(ofnode_get_name(node), "graph1"));
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_graph, UTF_SCAN_FDT);
-- 
2.43.0

