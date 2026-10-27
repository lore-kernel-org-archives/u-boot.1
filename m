Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687360A2609
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wrO5nYos;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=diKjT3RF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F32A40759;
	Tue, 27 Oct 2026 09:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYGDyxLCzpNQ; Tue, 27 Oct 2026 09:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9662B4074F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094036;
	b=VgpTHbkdoS0/+a+1fNXwUdqoaRJPxYSgh4vIkm+vKKAaaGZowji1x7Ev+MyfzHxQTQz/
	 jZAr9djgyNFq4hNChoa3xSKGTk62+bEb6Kl6vB+lLYnuMe9NgQH2oJUOGN6zZgNwfCV56
	 Lr3+mcpNA2BRWRFUI78E2ZsHmuaVBo8tWpT890/vSshN8dcWiUufwRrWBDbQ0xLya3sse
	 Y2Qk9dIdm8erO4btaCLDF5qampbNQizZiA+FUTjng2wx/H+sYKLnEXiFC+R/KIFkBtQ72
	 D6h3/g1EeiYnurKQSfP3iD7fwX5Z7nvt2uV4MpikhLDQfbWtviYRwuChQ9e1XjDG2gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xsU0WndcNufF1ADzeuPdS8Yy5FVitxTCtqBU9apG8c8=;
	b=CsoTCUd6IAiuwrcnUmIvfxx7MqyvkNaJ2Ck07bDlXk9ytvx4ZxHyIJxl0xwAY0+fywI1
	 FHGSKMSMY82V33ay2Le9LocgBrp11QsKATdwLF1kQAk+hGuEXIuWExWM56Pr2LMVNpcBR
	 PPgKjhYhylpMo0H1ZTpTrbAlytcUM3UxO2hyMR2iZYw2HWdPXFASulJrc3atxsgSEEnDQ
	 5T2ONte04TEnh+Cs6MRbYBaC8rhscK0irHFdwYcoIdtH7MrVs1wQFe9Yy38f/oXdA1CJv
	 RgrQUkkq17C1uQNzDi1FzKlMUiRcE/vpA7/jWsQKhIC1XDBsxU8lre1jXCx1XhvMAwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094036;
	bh=xsU0WndcNufF1ADzeuPdS8Yy5FVitxTCtqBU9apG8c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wrO5nYosUJrdJ5F7umAqgeC6cScBcL6UuOBxtp4dR6biMFkeWijbXVRwYo0VjXEES
	 1RbiDsG24fjCi067q2ACr5FdnNK0bkFDa3T4btl/amcws8e7ZuIOSEflUoY2qaoSOb
	 oZDuHJMLplD9CvtWrRCAP4O6iY/Hh6zjJRs2uFqBfjQst9yNGDMXRSiEgZ8Mb8k6AW
	 vBFr+vWKLLpjh+lBWuxEHelTvLbHnOLjmTjLpNVeSoSDZs5IkUe39zCn21pmHB7bQW
	 UDoGQsFmoAWgl2UNoIA97kiKMVZqwQ36a4tU9lQKo2ObH7LVYCGlRIi1CUYdpyetWH
	 Ckpu2eplc4U4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9662B4074F;
	Tue, 27 Oct 2026 09:40:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A88872
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C61080BF4
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nyVvxi04DPzJ for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FEC180BDF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094021;
 b=JdbYbuJQ+aUSLv4XvQIAi5jdAIzjZtH+dYRevbUDDdM6At6x8YhXlVOqgiUkIsj+xp7C
 gOWqZ97LZUYJQEyGWlyGuUvPyncfRCWC0yU5TpXYkG1MvCE/cPe/YH/+/ejpw0pc2g//j
 yvjNLsm3DXZ3Wj6rL4Iz3TO7cHL6z0IU93AhZ6HT8aqzAFCakcZPdMKZk/iljAHE82+Mj
 47RvJMUEXsmZ6erkfivgjwUWKOUu8jl1JscdMiL43AFBASP5ES1ac6gRX7FA2i8lNCHQK
 sw4ONYBYJLL4P866ENH+5r695wiRGCp/sM+caoaJ/AAd6BDmCWLjaTxbroTfXOVjyWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094021;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=xsU0WndcNufF1ADzeuPdS8Yy5FVitxTCtqBU9apG8c8=;
 b=UIbBrjmHhsqUj6hetT7mWv5dHvbThRPqlm756M4ghho7D0lrnnOR/1MCkAkfw/AQx6iC
 P3nwtmQ/Qh/aftC2Lqy509JJamLr1V1RBJa30YcFZe2mSU1DmSuU9uwIMNbmTOWt/L+OE
 L8IrsVNcdKDMUxe8yn+DX/C0xs4mY/NkBdbq5ylSmqAVrPPDweMnxF/PNBsz73PQdpbEx
 lSud+GKOmhunSqP3y2VJl6D5TTpFXF0s94/OsvWAl2213vw6O3xWRxKO6Is2tAkKVGQDx
 bECrJGA+eCeotB+SP5uK9FHEtLdKF8RlSH8Ny1DWsbsHWtV0Jf9kiZPm9h2T+pN9vYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=diKjT3RF; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=diKjT3RF
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FEC180BDF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=xsU0WndcNufF1ADzeuPdS8Yy5FVitxTCtqBU9apG8c8=; b=diKjT3RF2fd64ubwBs7FDzg8SV
 ELcRpJHFTlw/ZCqBV/ROt+Lghk3dsXaC0ku68+E5EgfVAgvvUX4i8oZEITtuajPoBABNsd1u2i57O
 bnecAetgFZnsc8yiKE9BfVGmCbpY3aP6Cw2MJyrzGnIdWlQFIh5ie1HiTbr/fT8PLd4qXU6Ujptqc
 ZOrm6K4z7IyswiF7yz09q2WGSh3CtQC59mDwcX0yiZy+AIi1vlPP6NyGnXCF54EZtfcQMRrU45u4j
 VIpgvbm6FshP25EazsEajtSWihhnggltw1dDByH6a4WoB6Pamfk8h2DnUL3Fkd+4C1MkSGryUwe8T
 pmtO+RaQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfF-0007VW-0V; Tue, 27 Oct 2026 10:40:17 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfF-00022y-0k; Tue, 27 Oct 2026 10:40:16 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 07/16] power: domain: imx-gpcv2: add support for power-supply
 regulator
Date: Tue, 27 Oct 2026 10:39:04 +0100
Message-ID: <d90ed4233d9dc4229ef00e6fd8b5beabc94f66ed.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
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
2.55.0

