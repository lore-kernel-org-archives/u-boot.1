Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1EB606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KO9hkdYk;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=urzIaj8E
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9854810DF;
	Mon, 16 Nov 2026 17:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CahoQs1lZdXz; Mon, 16 Nov 2026 17:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 793FC81103
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850578;
	b=fFi8B+di6tOMp10zc/uqoTYDdbgaJel7QaWhN/9xpYtRAPoDfqpri9DiaS+9t0fGYFxA
	 uS8VQ3rllT3UmBA+uzkHviU4OvHmLkauZQpV2Mslqn0jA3nwzktHw6mRHcNq8/wb5fPWV
	 8JfMcpgkxnYiFgCnKr5bZP/KWYMhTBT90jVrM7UL0uBl3egygeQJiS8sRSxh/if611l2H
	 VE1dmhiXueXg6FleGB3b7KGESMEqy2XffLsZkDlDaNZy5GnwHgwA0KFHf6FJqhXrfrxpT
	 1joVJZHmiNcnzI3+13hdyGgpGyKdYLTlCaVgevUmdHospoKygMwGE1SYyghrWJMOOxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eF5SbJz8/hQ8I0Dibr04t0R2qSMmI2Y49UFT3gj61xU=;
	b=Y9lT7VTpEYcrivUqp0o/KPsrU4MBwudUp+a/S7NyK8BQgmv6/9p5SlKVw/IZ2WOB6eRO
	 ZRfK+JcLe7t+qg+OA36NwAN5PULpTuQompnKElDT6pGWkpcYn/zyjIx6Y7Wekzl0VK6g5
	 wKLzxR/LB8I/HdU7imTGFA+aDTjuJrmyRzI8yOLKqvFOpr3bz02CpqTrcSStqQ9z5Lti7
	 7j/IX2vioZevuWjYtHOe/Oja1IMFQH4sWHqsHyOpLe2PMqVNYzWggqkk2tlE2jI1/lcmL
	 JQI/8XFEZooZ5/sRpcm1/dQysf6acI8XXJVdLFJO2oUs76kaHbcG7bJ5TNcpj1okr9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850577;
	bh=eF5SbJz8/hQ8I0Dibr04t0R2qSMmI2Y49UFT3gj61xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KO9hkdYkZfsT9YMPUuuk41Mhv740LZv+LRwcmVn3QTjEQliI6X9F9xkXtQdyp+qzM
	 rvWV7EtjWgHyOCoFxVQxpMUAn5MuAB6CUxhtnaAclieaWN1Q5ibzJqnFcRG34c0cgd
	 /lxNimtCHnOO0ARfPS91fLOD3cYQoSwVZ4hm+FBt+OBBvno5+r9sdsuwXUhsJaL+g6
	 44/sDFUScSFrxgMIl6q2nBezpX6GQBn6hZ3pBUOUrgKa21nnH2jSjIeNMzJUvZ6Dth
	 EGfmqbAaAjQrXf2eXvXkGbKFUpJoJk+Z4wuS1KpAEm6nBIp+NdXnlcw2nWBVg46HZY
	 EYQnu7cdWbtzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 793FC81103;
	Mon, 16 Nov 2026 17:36:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BB7B1E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E1DA402D4
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyFqFSBgR6rU for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1AB48402CE
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=urzIaj8E
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AB48402CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSw4s1yZyzMllj;
 Mon, 16 Nov 2026 18:35:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eF5SbJz8/hQ8I0Dibr04t0R2qSMmI2Y49UFT3gj61xU=;
 b=urzIaj8EIPJgJdJu/S7pHvGuNB7jbsSrMCzwMVRmil9+Bc207+7WYoGlOPL5ZygRLR6SE1
 SMI78IfQ9lSxhAkMdRFRu9MYfn9zGk3lFhiH/8mjNbdtfaXHaVVbdRpt0XfUkZa189uBIV
 xcjBS64radvYgMmF6j0CNO3bd+EBNRxjelIxzxsevvbxm9AE0IYyNxGZIE1Z5UGQwB4OHf
 pw/w9ueCBZbVh5dIKt7foH+NGez6mnnrY2e4pCjKU5NCU3TBXXjPvyckA9bVdjZosJFDVy
 dk0rOUp3BOl1eclhVRCldrj2HXB9mKHCesCbknXQKGmAG/+fPPX2Kln1sRgY7g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 10/20] clk: qcom: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:49 +0100
Message-ID: <20261116173546.3487841-10-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a988875e4d1ebb80982
X-MBO-RS-META: etpuus8uz9b75xm9bjiwohi3r7sojkxu
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Francois Berder <fberder@outlook.fr>
Cc: Luca Weiss <luca.weiss@fairphone.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/qcom/clock-milos.c    | 2 +-
 drivers/clk/qcom/clock-qcom.c     | 2 +-
 drivers/clk/qcom/clock-sm8550.c   | 2 +-
 drivers/clk/qcom/clock-sm8650.c   | 2 +-
 drivers/clk/qcom/clock-x1e80100.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
index bb2cb19aeb2..33a843c078a 100644
--- a/drivers/clk/qcom/clock-milos.c
+++ b/drivers/clk/qcom/clock-milos.c
@@ -183,7 +183,7 @@ static int milos_rpmh_clk_nop(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops milos_rpmh_clk_ops = {
+static const struct clk_ops milos_rpmh_clk_ops = {
 	.set_rate = milos_rpmh_clk_set_rate,
 	.get_rate = milos_rpmh_clk_get_rate,
 	.enable = milos_rpmh_clk_nop,
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 4e57f9f15e3..fbb0552ad9f 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -377,7 +377,7 @@ static void __maybe_unused msm_dump_clks(struct udevice *dev)
 	dump_rcgs(dev);
 }
 
-static struct clk_ops msm_clk_ops = {
+static const struct clk_ops msm_clk_ops = {
 	.set_rate = msm_clk_set_rate,
 	.enable = msm_clk_enable,
 #if IS_ENABLED(CONFIG_CMD_CLK)
diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
index cf96f1c631f..84984ed7ec6 100644
--- a/drivers/clk/qcom/clock-sm8550.c
+++ b/drivers/clk/qcom/clock-sm8550.c
@@ -345,7 +345,7 @@ static int tcsrcc_sm8550_clk_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops tcsrcc_sm8550_clk_ops = {
+static const struct clk_ops tcsrcc_sm8550_clk_ops = {
 	.enable = tcsrcc_sm8550_clk_enable,
 	.get_rate = tcsrcc_sm8550_clk_get_rate,
 };
diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
index dfe7bc6ce90..0f74cf08628 100644
--- a/drivers/clk/qcom/clock-sm8650.c
+++ b/drivers/clk/qcom/clock-sm8650.c
@@ -343,7 +343,7 @@ static int tcsrcc_sm8650_clk_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops tcsrcc_sm8650_clk_ops = {
+static const struct clk_ops tcsrcc_sm8650_clk_ops = {
 	.enable = tcsrcc_sm8650_clk_enable,
 	.get_rate = tcsrcc_sm8650_clk_get_rate,
 };
diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/clock-x1e80100.c
index bed3b2b8f2c..7c6c777a50f 100644
--- a/drivers/clk/qcom/clock-x1e80100.c
+++ b/drivers/clk/qcom/clock-x1e80100.c
@@ -376,7 +376,7 @@ static int tcsrcc_x1e80100_clk_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops tcsrcc_x1e80100_clk_ops = {
+static const struct clk_ops tcsrcc_x1e80100_clk_ops = {
 	.enable = tcsrcc_x1e80100_clk_enable,
 	.get_rate = tcsrcc_x1e80100_clk_get_rate,
 };
-- 
2.53.0

