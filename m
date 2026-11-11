Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C8606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WtDuZQtB;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=Gxz6/re8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D1E840AB9;
	Wed, 11 Nov 2026 10:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dp5VSPcJsygf; Wed, 11 Nov 2026 10:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C486D40A71
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392023;
	b=jEE6iHfIcgqvCSthIA6/AYUHGPe0LsqavmfXjm57zqepeTAmkxTdzTfEOfu1eXrUROhR
	 0+9LFgms91o6Pv8LVg6MIcHtWq1vSwYUpM3B4MHWk8knGN2qRUHGjAOMhgD8VbUtg8GUz
	 dSDczhfV3Vt/ZPLn5Iv0CqiE2PlCQuXKPiEl6EriINToxxaxrTfMsrPEYvz8M7u1oSZdX
	 noFkomPfY3vrj1zEVUlva7I9MwEVUedDl/8hwn7wlD1ZKzbtFsRsCjNTgwavJQxxWXrON
	 uksGWQzT0G5Y8pXkdXUAOjiUWDeTJgLLvY+6qzlfEuL+egqRWP07RlMwyeT9dd47EDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2zfzkRNKh+hvqh7PDdcymyUiTGsEQVOvqHFFzAJAveg=;
	b=huZaEKLRGHi0jTXQCXDe4FU4eB+3PrecMbUDGZ/OPOCXCM96oQJYx3HIer9hqydlExQg
	 Jgqj9mXB8k9TFnuXqfREd3IbEtsfjFZSumYa7QXgF/Zpnoqz6OP5jAUUwiW7iPzVyb5hr
	 Q35YOth0LQnoYXYtcWyr7KrAxDvUBN4aiVjs9RFYaYDuvXkeeaFtDoTleoNv2XPzLJUdU
	 Mly5p/VXASRX5KSzadOPwCe4XizaH8zAujsi0xWz91g9VG7AtJSM3j3mWFexJX5l0HJvx
	 TKy30CUKS/CrR50i0cHxszMIH2G/iHCpyayJOtIs0R6TdAWNFhB1ugjO0yn6/f0pJDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392022;
	bh=2zfzkRNKh+hvqh7PDdcymyUiTGsEQVOvqHFFzAJAveg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WtDuZQtBQ4COIkra8ZdhXORZoVwaoCr9R4M2xeb5TEX1EYhAYwMSidy3DWu4Cx13U
	 mFRLNLeNb1o7teIg0YiQ6yThcMyr304EdZ3UiZc8FK9D1kSAC+twQIeMBf4ZGHLAm6
	 h0Kwx3d/kYUdsMkDVfEEA0H3V3UDwKTVJaLLtDyxjlN7l+VfVqfA1ItiqeOnXcLEU2
	 7Dd1j88QBJ/L+Lsoeq30q9HAFE5LT0rcOC5p6bzf5RKV1UCrnBgyByyUNb4V9qqiq6
	 HvoUKIDdNewW0EhPnUPgEHgkguPFYi+MvfbX2maaiQAqsHGiyYOiLl8mOOUz58feWY
	 uBd9x4FbjQBmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C486D40A71;
	Wed, 11 Nov 2026 10:13:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F97228C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 459FD606C9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmUCjzE0RjYr for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C137605FA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Gxz6/re8
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C137605FA
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=2zfzkRNKh+hvqh7PDdcymyUiTGsEQVOvqHFFzAJAveg=; b=Gxz6/re8kCs4jpM+cblTQ5fL5i
 Oi1YHrURLbl5VxnNz9pCvf4Kq6IDNGMLb3ZN2/ZRLpI21lYdJTC+unTdc+8KkhljA9fJTy/FfC2op
 5lQvsOyZXZX612V9Yz2d8qedZ0ZV+dQ4WAey1IlriDoz7dRJpjw0vhmtNWJHIuMRaDy6fyL69K9GN
 jyK8mCSQIsw3ivY0xVVclEqVhL9qhCw77+FzVbzO7oW5yquLTbJ7nVjcPPtcGwJaZrQuGiPtAdCqw
 CZX88Xo8KxR7FFeCxXoBeir+UdelRlprEPUF/sZDOjcndrSwrnRVeKLqLJkbEleSQQVwQBCvnsiZ2
 XaOWCp+w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KX-0004yW-39; Wed, 11 Nov 2026 11:13:25 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KX-000Lq2-2Z; Wed, 11 Nov 2026 11:13:25 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 6/7] power: domain: imx-gpcv2: add support for power-supply
 regulator
Date: Wed, 11 Nov 2026 11:12:57 +0100
Message-ID: <d7298563278ed3fe47d78bc54eef3c6c20ace082.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
References: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the i.MX7D, the integrated anatop regulator needs to be configured and
enabled with the power domains.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/imx-gpcv2-power-domain.c | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/power/domain/imx-gpcv2-power-domain.c b/drivers/power/domain/imx-gpcv2-power-domain.c
index b94ec60fc0d..d6334d1b8c3 100644
--- a/drivers/power/domain/imx-gpcv2-power-domain.c
+++ b/drivers/power/domain/imx-gpcv2-power-domain.c
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
 
@@ -141,6 +143,7 @@ struct imx_gpcv2_power_domain_plat {
 	struct power_domain pd;
 	const struct imx_pgc_domain *domain;
 	const struct imx_pgc_regs *regs;
+	struct udevice *regulator;
 	struct clk_bulk clk;
 	void __iomem *base;
 	int resource_id;
@@ -343,11 +346,19 @@ static int imx_gpcv2_power_domain_on(struct power_domain *power_domain)
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
 
@@ -392,6 +403,9 @@ static int imx_gpcv2_power_domain_on(struct power_domain *power_domain)
 out_clk_disable:
 	if (pdata->clk.count)
 		clk_disable_bulk(&pdata->clk);
+out_regulator_disable:
+	if (pdata->regulator)
+		regulator_disable(pdata->regulator);
 	return ret;
 }
 
@@ -450,6 +464,14 @@ static int imx_gpcv2_power_domain_off(struct power_domain *power_domain)
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
 
@@ -458,6 +480,8 @@ static int imx_gpcv2_power_domain_off(struct power_domain *power_domain)
 out_clk_disable:
 	if (!domain->keep_clocks && pdata->clk.count)
 		clk_disable_bulk(&pdata->clk);
+	if (pdata->regulator)
+		regulator_disable(pdata->regulator);
 
 	return ret;
 }
@@ -515,6 +539,16 @@ static int imx_gpcv2_power_domain_probe(struct udevice *dev)
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

