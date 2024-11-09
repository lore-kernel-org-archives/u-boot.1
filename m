Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA4DD5E379
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 18:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED74892FB;
	Sat,  9 Nov 2024 19:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ReGvoHdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81976892D5; Sat,  9 Nov 2024 19:01:21 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A26889232
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 19:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43169902057so26275135e9.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731175278; x=1731780078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=imxB9txU9E4kpeIEzTUjt2FpC+8k1rlSRr9nRX2IoYw=;
 b=ReGvoHdT8Ehmm+xjJsukCTI7jVavobaHFL/nubFMsLFrkv4rh3spQKSR4XZVvql9mz
 s9dpAzakQFQINjpo6pcfyaw+T4Kcc+2CJpMY68hM/HxamgPEedb+kwXSV7mVeCwnGVRL
 QTnaKLSxaqbsOfkmaLvJrRCoCtCL1cuq2XJHxoKLE1npYXBhSDCMeO/6xcuc0XV5Py8s
 AexovlHTsjLMOBCvZZLPHwjBeOIkPPVkM19KMAANqE05aBG+yNhVK3bDHBiJa0F0NV0P
 bJ0NRZSdhq//eBWbyMg+6r52zcgRt6Lbs9ajz4DI8BVuNLl+uADawi5cd7Eibf9/mGM/
 AHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175278; x=1731780078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imxB9txU9E4kpeIEzTUjt2FpC+8k1rlSRr9nRX2IoYw=;
 b=Aech3IfA0rtDjE1rVmxoocmtACgipxBV6awjRQrMQZNB6mkDtFwkQ2fzX2YYN/nw1N
 s/X+oQdOb9z7el4Vz+JI8G1hg+KE28jWV48VmhylDC1Lz6GWbDm2bM+w0Cvq+qu2FFBO
 +qCt63F+r9YaTBZL5PJ1wSMQ6oGCAZBNkMauhq0wW+unC72Y2Opu7h/+NRSulGBu7mhm
 Rx3FKdN1venDCrwhbINQJqwEk+vGRqKIItxsSp2ux6/0XYl0nPF7YHA8Jy7yYO8nFcCw
 Pi01z9JcAwVtbYZvDdFI5TKkphZhtOTz46FFWtfMpxFQRx/QVxSC6a5i7tVHvocXvpp9
 e4iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbLzCxk5tF1GiJ+3weHpTClHucQVYdNO7na04kJJoYlOj/QcRdoMfzfoQtE5qHbHtx9h8Iits=@lists.denx.de
X-Gm-Message-State: AOJu0YwcvYGQQdVhr7gIhyNA5GSjMmwobwmcDhznsMJcjdbl1Ylm+/nj
 LLvgfR0TDrl4BJ05GGQ0WoiyJE8ugveIqMxam4U16ojYFyxTpjYB
X-Google-Smtp-Source: AGHT+IHBQqcSHyfMjGInwjwCa3xyYXu+RH5tzvHzZ9fa8g0O7ULjBAvZLILS95sL17f94GQMNg8HZQ==
X-Received: by 2002:a05:600c:1f93:b0:42c:a89e:b0e6 with SMTP id
 5b1f17b1804b1-432b7501c60mr58342845e9.11.1731175278399; 
 Sat, 09 Nov 2024 10:01:18 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm146095025e9.41.2024.11.09.10.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:01:18 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH 6/8] test: dm: Add test for ofnode options phandle helper
Date: Sat,  9 Nov 2024 19:00:31 +0100
Message-ID: <20241109180038.10344-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109180038.10344-1-ansuelsmth@gmail.com>
References: <20241109180038.10344-1-ansuelsmth@gmail.com>
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

Add test for ofnode options phandle helper and add new property in the
sandbox test dts.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts |  1 +
 test/dm/ofnode.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b8a46463158..1ffa64a43e2 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -106,6 +106,7 @@
 			testing-bool;
 			testing-int = <123>;
 			testing-str = "testing";
+			testing-phandle = <&phandle_node_1>;
 		};
 	};
 
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index c05de1c54ca..0c9d856b97a 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -697,6 +697,10 @@ static int dm_test_ofnode_options(struct unit_test_state *uts)
 {
 	u64 bootscr_address, bootscr_offset;
 	u64 bootscr_flash_offset, bootscr_flash_size;
+	ofnode node, phandle_node, target;
+
+	node = ofnode_path("/options/u-boot");
+	ut_assert(ofnode_valid(node));
 
 	ut_assert(!ofnode_options_read_bool("missing"));
 	ut_assert(ofnode_options_read_bool("testing-bool"));
@@ -707,6 +711,13 @@ static int dm_test_ofnode_options(struct unit_test_state *uts)
 	ut_assertnull(ofnode_options_read_str("missing"));
 	ut_asserteq_str("testing", ofnode_options_read_str("testing-str"));
 
+	ut_asserteq(-EINVAL, ofnode_options_get_by_phandle("missing", &phandle_node));
+
+	target = ofnode_path("/phandle-node-1");
+	ut_assert(ofnode_valid(target));
+	ut_assertok(ofnode_options_get_by_phandle("testing-phandle", &phandle_node));
+	ut_assert(ofnode_equal(target, phandle_node));
+
 	ut_assertok(ofnode_read_bootscript_address(&bootscr_address,
 						   &bootscr_offset));
 	ut_asserteq_64(0, bootscr_address);
-- 
2.45.2

