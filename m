Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC183606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KnVC8kSs;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EgSof7Im
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B87E281205;
	Thu, 22 Oct 2026 19:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXxL2xVPS45C; Thu, 22 Oct 2026 19:02:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9B9E8127A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695760;
	b=l7tLr5O1tD0KkOFEI+JjaPj01FlrZoaaSMYPcmXDF1QtypDLGHBizrflQIb2WE7l1azL
	 HhI75k8vNS4Q7P7NA18D8gCyLEB0rykeE8hrcYSlMx2PRk+DZ3LWxrXCQe15XR0BdruBT
	 Jw+CzBvAWqmB6QFgY9ZGyxBRpQTXPrxJ5BQ6ymcssZNQVVULHp/95wKmwixNLo0mewGGl
	 ILn22OUTkNsy3hYsUypfxMD13v0S8pfbP5o2X2mJLj1f/tlNhUzlzn4z4ItsS4raql+kA
	 fm8ImVHm4QF+teoUkPJTqNbG8bDgwyJHls15sc/mvqSeplVfLJOZTS6ZDb3FriRocWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nq2UanLSkrnw3ED7bbStkwHz63pRIZugClI7Q3UdTaM=;
	b=R1jCwUjyb5YN7TnUd9nY5p8nhlKLY1oq6pEb6eJpvF9w1z3QMey1FmziS0c1UssVN2ge
	 pNsDr8tTObVRgc68zDAuy6cwiRcJKOZRU9FAE3JQscmas+D4dmU42my/C76lcAYpizbjb
	 NEK9BapXqMTy0cLriR7X40Yzfj4Of2v2I6okWIJs82n4BsXeyKt+l0YXRImlDHJ54d9jp
	 0T8dxm+dAoetm0L//9pZOJlhYNcjhAfWX8fgLL1mMthyJSa/pjeyVG00ajFmrozeIQTMr
	 EcW0syn7/7e4f3Erz0TmPP2f5UBk0SIgUVcY1vLpKLGMru4tfVgJmqy5kGMxK8QvWeQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EgSof7Im;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695760;
	bh=nq2UanLSkrnw3ED7bbStkwHz63pRIZugClI7Q3UdTaM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KnVC8kSsC3d8a/MmozbXgWThM/8GU1/tRhWqaMnf6RSOXlkBaB8CeLc0WgvmtPAFO
	 yy3e1Kp/QA9alOVJIZZ1tIiNStPspNWpsvX1n3LpNLCv3kQagYpPjI9paowg0NFznR
	 Icef+mZa84a0KbOA8FHBvbBcoCw8kvhrKKb3VTvnIX5k76lqjWJZum6CMXd+iycbK/
	 VxfNvy9ppnzz7Vz4c6ZvP6+U9V43Vxww7WJT8Joqooji4f7diYilOoBVU2g30DAAuW
	 0FrEhE5wkzndL1bOur+qE8E1TjNwGuXH7KOSJrEDy5/WNi6LFHZbw7q8WXhPm7B0k4
	 UwaxEMTYKYCvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9B9E8127A;
	Thu, 22 Oct 2026 19:02:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E4A84BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A9578124A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2U_9nuXNv9vp for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8772D81069
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695754;
 b=OyXhiPSxtzpIYeuEIPm6i5kWKEyXnFwoW2v4qqC/9uYTGVJyyv/XIoi4sPSEMdMi2xDQ
 P92yd3pT1qelE5bGdtv0ZNYAAdE8XOn0t23Ljj1d8cfVCYxib4YZuhOczCNdyE2b2cho3
 QjjY8tFvOPPYK44H/2VYGtW6vGY9bpkVj7zI8dR7+50//NTGqgCnWFhxmfuKPCLN6oTmV
 1AVIxd5T5/pew0Dk8TgaxOimDJ3txDvFdNG6OQU6QYf4QcCn2T57rD0yz8V/oQRDDiSSP
 jowaibOKzWICuGua8eI5YBTLjNGPwec0IINmDnGWhEKBHhqyGADXHTMd7z54qLsPF0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695754;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=nq2UanLSkrnw3ED7bbStkwHz63pRIZugClI7Q3UdTaM=;
 b=ZYORx/vsZgJK0mjVevtth2N85twQu7xpRxmB3emKjBffL2Z/jRSXgMRMLQ3Ly/5vjkXp
 kH8zvSspdehPhBiMVwmQYRHqGKfrmiffvVAYhQef/TKHkTz5DObldOu/uzrfHtpSsGbLM
 Y93lWqrLEmM+b48Qymw6PEwwKpFBK8PZCX9CCuG36zOKXtxL1GvBvjj1y93/8O5cuDK1G
 cz4mx6/+as0pXedzQuRm+tum+zsOxON32zGej7sCvcSBAnlvfxWWgEo+z1FBrxrIjcCsg
 Ckcp5l5mAugo5OAYgFMEt4mEBvKx3GdYhaPVZuzBHF/Ihp9DdQwvQfe0RKwPv/rR8zA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EgSof7Im; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EgSof7Im
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8772D81069
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:34 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2001dd4e7so1288205e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695752; x=1793300552;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nq2UanLSkrnw3ED7bbStkwHz63pRIZugClI7Q3UdTaM=;
 b=EgSof7Im56ZiLumIN9TXyA4qpETF6pIGg5VsgZLHR+3Mp3dPi4J2bmorYhCDLvkKii
 BkIb2wMbDWdWaodV71Ci55mhph8UYkgQrFmjVxFNyIjD6lD4N+U6FH/FbY933hrMJMOK
 SSRM71Fpq+4q2fG68edog4Lt/0+VGhBufmkOBPVV1U1EybmV6Bcgw2QK3ms62QOSZXko
 AmSXPYpWjrHZubjwdHRtXfaaLIp8r1zERVK1HdcYfw4kREDEHO6x1n6Ar+9fWSwpoGHq
 nisfcqnM7s6XkkcUGBiHB5jTSb1bS3bxUsgteyG3vk1D6mG46yaEj6jVpAFqQy+ceq8g
 OoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695752; x=1793300552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nq2UanLSkrnw3ED7bbStkwHz63pRIZugClI7Q3UdTaM=;
 b=l/30asBcExdMWCQUvAynY6pJW4Nb8CSmlttmUY5lGFcPpD75CsDN9BKXZFRG3V92NI
 sQNW/ZY9w+1FS9HMorXUvfOrtEnXVy1h5w3HtHqqA1iNVsd9x+TmR7hJwEAqfqGukMD3
 ULfd1RDGGWu5MRgQgW6xbvJBUTquW7aEy3pr3EdCsTpAYka44Qq9bJsjwH85ue/kVLo1
 wMyePKzv3mZBasp0I1ZVZpL40E368JEQ5WzkygoSbEG2Pazrf1xDWMds4/+8UzfOUlJc
 sNJJh6UbCet0hLwy7cN8WF+luv/gNScxDJTbT7e+/PuF+wTZdfqBMfKtJ8AO0OAkqIbV
 lhFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGpdLAF5RJ/HikKFhpRI7nt3Nl3utpRxHWrcqMfRjRMiDG9NUZsDgiQKwMZ5Tg0K9uTGzi67k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL/TWfWRgw45S7l2nNEt7crrvT0QGifvnYecgvOfMpDp7GLam1y
 011v0UvjHNAg59ltD4jJ0tYknbJgbYNy1OgsyLeXtKM0DK342Dr12LcJ
X-Gm-Gg: AYBFou3trEoKxy/jr7oOhJ1jxGX2laPgzxz8bIpYDsPdQb/JNPvNYMNb32hft3YJYKZ
 t17q4IDcnaq4YS5R3Jq7UEW2FVislpcV2Y7Ca3j78rUPIh/MbWPoIJhskBU2tkKtRfvt63ak0Aw
 uQ15CZV5BIbWsZM5PBHp7NPgblhL5s3SZHOdwFoKWbIIiKvoWqaVJKhZ/DJciwfvwUC8EhlTBzz
 Py/rkbvxZA8mdZAhafnVQXXxm+qStdtMLxueY8D2UthxvKyP97LBVVoeWb1xX/h0pVk8TUbi+Zv
 h5sssP3h8BlOIJTbOylsR15iNBU1vm2k0Xbi1ejXO0F3DzD4bgpxoyGacqvPEhokak6iEhxoAEH
 m+IaCwcBmDdBrolnX+9tbWIG28um6kGucjNCCV+cUDFpUIYSNQWXBW78ZGQ2oyWeCyC3sHe6cJe
 pb8b7i8bmHJQ0qKSoJJpbPNy7QRNpM5FKiB7cGfy4vZViqddj7fMFTV8UkfSRp87mfA1mUp2f9V
 BG+9zpBVeOZ7gTHWy+DMMOdb6oRscA3ZpUdZvFvQoOiqAFP+p3ge1r/tn+2oY8C7dUtDAH+AQDw
 ujjAaw47yXG3/czQSB4qm9NyZV6qQBHAQuq9Gy7v706jbyGHz4SbLlnEL20PsGRTFh35Ekp+Vyt
 xPtvWuw==
X-Received: by 2002:adf:e00d:0:20b0:48c:69b3:610f with SMTP id
 ffacd0b85a97d-48e264b385cmr9206775f8f.26.1792695751939; 
 Thu, 22 Oct 2026 12:02:31 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 04/16] arm: airoha: introduce AN7583 helpers to get SCU and
 CHIP_SCU regmaps
Date: Thu, 22 Oct 2026 21:01:46 +0200
Message-ID: <20261022190206.666950-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

We need access SCU and CHIP_SCU regmaps in several places (clk-airoha,
reset-airoha, airoha_eth). Unfortunately these regmaps can't be easily
retrieved with a common code, because of different Airoha SoCs uses
a different dts structure.

To make life easy we can write a commonly named SoC specific helpers
for these tasks. This patch implements helpers for Airoha AN7583 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/include/asm/arch-an7583         |  1 +
 arch/arm/mach-airoha/an7583/Makefile     |  1 +
 arch/arm/mach-airoha/an7583/scu-regmap.c | 30 ++++++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 120000 arch/arm/include/asm/arch-an7583
 create mode 100644 arch/arm/mach-airoha/an7583/scu-regmap.c

diff --git a/arch/arm/include/asm/arch-an7583 b/arch/arm/include/asm/arch-an7583
new file mode 120000
index 000000000000..d2317ed3bc3c
--- /dev/null
+++ b/arch/arm/include/asm/arch-an7583
@@ -0,0 +1 @@
+arch-airoha
\ No newline at end of file
diff --git a/arch/arm/mach-airoha/an7583/Makefile b/arch/arm/mach-airoha/an7583/Makefile
index 886ab7e4eb9f..51f978aa1017 100644
--- a/arch/arm/mach-airoha/an7583/Makefile
+++ b/arch/arm/mach-airoha/an7583/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0
 
 obj-y += init.o
+obj-y += scu-regmap.o
diff --git a/arch/arm/mach-airoha/an7583/scu-regmap.c b/arch/arm/mach-airoha/an7583/scu-regmap.c
new file mode 100644
index 000000000000..544cee8adbc6
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/scu-regmap.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <syscon.h>
+#include <linux/err.h>
+#include <asm/arch/scu-regmap.h>
+
+struct regmap *airoha_get_scu_regmap(void)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,an7583-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	return syscon_node_to_regmap(node);
+}
+
+struct regmap *airoha_get_chip_scu_regmap(void)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-chip-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	return syscon_node_to_regmap(node);
+}
-- 
2.55.0

