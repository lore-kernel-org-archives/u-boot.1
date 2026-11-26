Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752D606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VWoeiuiw;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=k55WFc55
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49A9E409E9;
	Thu, 26 Nov 2026 12:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmC7SMvzhBEF; Thu, 26 Nov 2026 12:24:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2929C409D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695890;
	b=H8vIc2VEajzgL4uaWZI/fLARqMi4qvvKvhH9SSGgBWQBFJ577mjc9+X8Hi53AiOuEtcz
	 rRz/JRuCXerXOwCA9yzQ1UXVtVJiFcVnwdhYB0TQCSkvBr5uQqru/SishNHF0DJM13Tw5
	 oFR9zLhBVmCtlyma7ZKC70/PPqbPdNjc8OHoKSLWXxt8Ee0KLmZMMI6seVVedLlC+t6tt
	 u9jJMoaYLGuRdRMou6OHH2gJ6VFEkpvugVuNj0bpNaGP3G2Lqa6/jBGQcaEnqvFFebf08
	 FJR55LUX0ttTBocxzXdgctIu3/x24/H+1Kn2CdTd+/IJVRzxK5KX1lPELp5BemQkCBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7pZ5ai9d6Xth/UwYD9ZAIQplsfnhau/G8mCs4TqRiFU=;
	b=Y010tIAOxBLo0SyjtMFJ4tUZr8hHhKEwNDhmqbgtJVdqeNlV8Z95I71841m8UBw8sYaC
	 1fNX/I5O/loAmxuBy91th+Ht7OYU5apg13Qilj+qGvIDvw6YsoGrFRSYrjij4NV5QIKgk
	 C9+PM7U3cRv1o0Am7WuRjIWtp1uv8mHmihzHaloYNwSCVAEpr1wx+jGx8ZITnpSIEj3CQ
	 Olvqm1oFLR4pEHAvpQ8QfF8vDXEu2htCXLN/+nvTbr6Z5DuB6rk4kgzYbSJaGTCg0/1wJ
	 54D7kBWlwhVWEp7T/t5QonO7xnvJVKP1NXNtydU6BxhjWxKKUC7LENd1qrus8rvnPoQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695890;
	bh=7pZ5ai9d6Xth/UwYD9ZAIQplsfnhau/G8mCs4TqRiFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VWoeiuiwFq92+ySLfc+SqfEkbtN8/FLwrMSmTQ+r5UYZlAeGK/8b25afSjOMup7lg
	 T8kq6KxumjpbDXQ/Lr+fHk268T8vb2bSnJyesI4XFtpNw0l0xV3b+uTFJ3gvy6qmop
	 f1j+lEN3joAcGVBRQN9W6NBkfUU5pROwCtvz0wfF5vvVpKqItdr6t7zyoMqNAB5O+k
	 fyxBShRaV6eygQLtFFMlBB2RkEg17aIYdtgwfKwXQaA4YaiG9z53eXi0yVZsNBlcq4
	 lPSYze7iBI3xVtvu2vJrlMbEJn2nIDRw4bx1aBlHEA4LmK9Am9U4FR+HB9dEGNXOqR
	 WIwPeSrTlHSdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2929C409D1;
	Thu, 26 Nov 2026 12:24:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AFC3B1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2024608CD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZx7Z1nljhH8 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F63A608EF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=k55WFc55
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F63A608EF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=7pZ5ai9d6Xth/UwYD9ZAIQplsfnhau/G8mCs4TqRiFU=; b=k55WFc55LLfPxoX2hyTP4aW8U4
 DCb91YLEC063m+gfvztKUZuSqqEJQcMmiU3vGnIf9DoksxbimZ1egwYqYHXMv5fwgcf0HXqHWUvCk
 3kYJTcschVa1avamV+c9TNiYoKYg5pHI+GbMHipNwSXwXsFMZhTJGEQjuI6AyHYhY9NYBmqn5o4DA
 aDi/QDW9/Vhxf1sbAFtRvrS+gEaHfvN/1dqKObS9dp6XfLGhs998G071VQsCmof3sk4Ui24cBex15
 GOlDoa2NKMOjf237OCXyYvCgVEzE0sed6Cg3sQ63sC6sEn0WGjrtwtIlc+SwpJA8921FbRcvHeoCL
 5CncUh2Q==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWg-000ICc-12; Thu, 26 Nov 2026 13:24:34 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWf-0003gJ-0k; Thu, 26 Nov 2026 13:24:33 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 6/7] power: domain: imx8m: add support for power-supply
 regulator
Date: Thu, 26 Nov 2026 13:23:58 +0100
Message-ID: <c1f130e537b2e0a99c70b563c37d5284ee0b0ef1.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
References: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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

On the i.MX7D, the integrated anatop regulator needs to be configured and
enabled with the power domains.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/imx8m-power-domain.c | 36 ++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index fdca4d9d9ff..aef7f4cbb35 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -14,6 +14,7 @@
 #include <dm/device_compat.h>
 #include <imx_sip.h>
 #include <linux/bitmap.h>
+#include <power/regulator.h>
 #include <wait_bit.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
@@ -128,6 +129,7 @@ struct imx_pgc_domain {
 		u32 hskack;
 	} bits;
 
+	const int voltage;
 	const bool keep_clocks;
 };
 
@@ -141,6 +143,7 @@ struct imx8m_power_domain_plat {
 	struct power_domain pd;
 	const struct imx_pgc_domain *domain;
 	const struct imx_pgc_regs *regs;
+	struct udevice *regulator;
 	struct clk_bulk clk;
 	void __iomem *base;
 	int resource_id;
@@ -343,11 +346,19 @@ static int imx8m_power_domain_on(struct power_domain *power_domain)
 	u32 pgc;
 	int ret;
 
+	if (pdata->regulator) {
+		ret = regulator_enable(pdata->regulator);
+		if (ret) {
+			dev_err(dev, "failed to enable regulator: %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (pdata->clk.count) {
 		ret = clk_enable_bulk(&pdata->clk);
 		if (ret) {
 			dev_err(dev, "failed to enable reset clocks\n");
-			return ret;
+			goto out_regulator_disable;
 		}
 	}
 
@@ -392,6 +403,9 @@ static int imx8m_power_domain_on(struct power_domain *power_domain)
 out_clk_disable:
 	if (pdata->clk.count)
 		clk_disable_bulk(&pdata->clk);
+out_regulator_disable:
+	if (pdata->regulator)
+		regulator_disable(pdata->regulator);
 	return ret;
 }
 
@@ -450,6 +464,14 @@ static int imx8m_power_domain_off(struct power_domain *power_domain)
 	if (pdata->clk.count)
 		clk_disable_bulk(&pdata->clk);
 
+	if (pdata->regulator) {
+		ret = regulator_disable(pdata->regulator);
+		if (ret) {
+			dev_err(dev, "failed to disable regulator: %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (pdata->has_pd)
 		power_domain_off(&pdata->pd);
 
@@ -458,6 +480,8 @@ static int imx8m_power_domain_off(struct power_domain *power_domain)
 out_clk_disable:
 	if (!domain->keep_clocks && pdata->clk.count)
 		clk_disable_bulk(&pdata->clk);
+	if (pdata->regulator)
+		regulator_disable(pdata->regulator);
 
 	return ret;
 }
@@ -515,6 +539,16 @@ static int imx8m_power_domain_probe(struct udevice *dev)
 	if (!strstr(dev->name, "power-domain"))
 		return 0;
 
+	ret = device_get_supply_regulator(dev, "power-supply", &pdata->regulator);
+	if (ret) {
+		if (ret != -ENOENT && ret != -ENOSYS) {
+			dev_err(dev, "Failed to get domain's regulator (%d)\n", ret);
+			return ret;
+		}
+	} else if (pdata->domain->voltage) {
+		regulator_set_value(pdata->regulator, pdata->domain->voltage);
+	}
+
 	/* Grab optional power domain clock. */
 	ret = clk_get_bulk(dev, &pdata->clk);
 	if (ret && ret != -ENOENT && ret != -ENOSYS) {
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

