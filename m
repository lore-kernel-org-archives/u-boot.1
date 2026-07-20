Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDE2C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C429406F4;
	Mon, 20 Jul 2026 18:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4V4mSAqXRTY; Mon, 20 Jul 2026 18:10:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 889FF40726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571018;
	bh=wYnzJTe2sPkUQ8zNhGd/6NCus3JaGzuzkqWJcIc0gpQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QxityTBiwUTb1difcqMPXjEIkAry7LM/980rGrQRYL8UPn08F3yeBtC4Ec851fee2
	 XvK58O9QwJZ/hSad21miX5JcL+6aIpAZ3t43bvlZQHO4I6Q42o2mV88sgrI/5zrZ4b
	 itNdBTbW+qChiFy0bJxj2EsfVxNMCkRStoFPxqcel1xe/MRqWVmNmYc6wJ2EHVxOre
	 MIAld4gpmFiNqimDi8Csoy592g6hyLAkuAg9W8kL+Fw8BRKDCnmhROLywEWWDsTJLT
	 r9X8qv6uf4Yr28JH4kuU43TO5m2FrIzT1BCjSLddUorUGSsbke2EoqdlgfXMVxflEP
	 qWYekzof+TKxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 889FF40726;
	Mon, 20 Jul 2026 18:10:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 16CA3132E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0CDC406BE
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqRO816b_S6p for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:03 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CF7F8406B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF7F8406B3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF7F8406B3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA3A84A7A; Mon, 20 Jul 2026 18:42:27 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C03A84A60
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:42:25 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so81455375e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565745; x=1785170545;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wYnzJTe2sPkUQ8zNhGd/6NCus3JaGzuzkqWJcIc0gpQ=;
 b=IJg3jq0qsVfYRYL8JeubOGZs51/iFNnsQORf11L8ZPBrjU+QgmcSA5bb2vxtsrY0M1
 cCdiUpaP66/nx7PlOGckxYiTCvIkuwCmbLOfxJOa9xBN1VgEJScxvuQTLm1bZNOgWV4X
 IbwctZCDZSk1tjo0BfcRLZYIABz0zRJqp1P9iAqoSmkkp9ekVEcBlcPJaTYAbkWXFXm3
 qDKZN74JGYupfUuwb4BTxrwsDF5ZxydaK4sJC7RP61RDb4eeeiJd5stAiV4k1ZIrezLo
 dNS9+/7xVER8PWj7hMuMENzPf94W1qj3CRgUUuYbsMA6pizBF/9GeOIrSfUTyR4mILXl
 k0PQ==
X-Gm-Message-State: AOJu0YxY09hDRNV9DAt0Xuq31Bp76kaMtxZ8hMwMtL17x3cXic9lWAjA
 tBQO0TIBkDHbZKFk5d0n+aTy2uWovKy+iorCapf9cWa6L8rXJSBZ+H69HwwyYqDV0go=
X-Gm-Gg: AfdE7cnOeAryG+mYFbbFQUxYFRh5pTkpQG22xXsobePL+lCjGrbOtJ13EZ0PjJFZ3q+
 pABlLYHD3iQRgY4a+9JiIQA0lChH2JY6DB2efhKhaxuY9BB+oCHdgNn8Gza+xDEUPiZN471phiy
 Oo6PvZjwDS82Oc3EIAgSJxWifSti6l1fPQQeGzt056IILvVrv3K7B9565LXzhTnvdEd7cEbYlwg
 VEfxQL/wJG8bxGNE6Mrj9/RGs5CtM53YU+vC9hL4Rbxa8ko+PTFW6/pt45H+qj5muQGWRXsD17f
 qw0pnoU3JZmQefZcTwdeFf6aZBeEJlzDPnGtjyzXGgXMP+3JIFU1/v+KDdCqXAZBWfQ5XS3yj9N
 G4eCwU1F9hmXQYcydGd8VFR2ufYZpOnpFJJ2DqXDEcSDGNTSNbT3d+fAdbM1Il8VNqq+9WZCkSJ
 9qVPn+NrsZCpsQJrx7XK94MjiSpmRFWZhflWM3dnuH
X-Received: by 2002:a05:600c:3553:b0:495:3a21:4e5d with SMTP id
 5b1f17b1804b1-4954a395fb3mr168041915e9.0.1784565744669; 
 Mon, 20 Jul 2026 09:42:24 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:42:23 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:41:03 +0100
Subject: [PATCH 36/36] ufs: qcom: fix core clk max rate setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-36-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=1EuS7hjuhebcOUIbes+2a3a2UgAFi2wjzdhZSAFDEcs=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+Hja/ScIvcCuxUJO5sfleCul849sYlTLecG
 1cyJg5SGUSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhwAKCRAFgzErGV9k
 tgqoD/0cKW7qrQ+21Jza0MWfwMBbSaqc0l1mGcQg4/kclQhaFRjtnp3DOsO+DplIHdYWCNlrLoB
 9ha1m9XSb0s0Cv1kwwrS3pOAEM/Bc81cqAV8+QJDrVffKNYLqYjvXAgCM877WfrWlJ6o4EpggV3
 FBHEe+FCf9hnb+8Icyy0TUM+bXg/pbSpHijsxaw2YsIOauRLQZWXxumjWXfs3MI9RfYbCYNlOOr
 wdAdY+8euyY4YLZdb9IgZu2+bMEg44ycGR3rL9F8NjaMg/BmKKnDc+FZIooHaEeNjenKAD6fgp4
 a5QDWvtuSdx3HOwPIxVK7uyVByg5z3LyYvGFS4DUWMxBKb+TC7AXfNA4VEPD/4t9gLx+cllZqGB
 OdWUYteCXxf49f1h9YvPQD1Z6mUllbFRVMVDKx3m6KPaOlYuEIdSy9oU2hKz3ftwHB2enlhXK2q
 8UTldJ6NZ0UhzczukCljWK1rZRCcMzsfEyt+tMHNUDCVJS2whVnptQ5rgsC7jygwsBINRbxRNCB
 qy4gqIQfPPjoe4EjMBePLgaOGF3j9TPI6w7k83Ritku73kynIcDOjGI0Wt8AZ1d5ESip+BMTscA
 6eQ4powgFDoWGX9ZgeOYnuZaMxtYg21fLeW4WtJj6zR6v1yk24oAD+Y+uTEca5T4WS+PWzDxJ9R
 ROUF/bI3q3spvXw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565745; x=1785170545; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wYnzJTe2sPkUQ8zNhGd/6NCus3JaGzuzkqWJcIc0gpQ=;
 b=umttbPNB7BcIZHj2SvZ90aCVoqZpJsQgkIkcRvdNU1Wuorti8Q/rAlb+58KcVAls+x
 xk6FqsxnJwGmGQEXV/3j/b+n0NsMyASoWrqK5DZDoZuvl/cqqgriHro/DuNAV2ESmDF1
 e3ZwucotsM1iAKXpbeUee+FXM5kz4GKbfbAj+ezUoFR7mhjDj1O7MQ6E92/qBd3jq8as
 oGDK4KMFcAb45VPLvTggzxVmyopwUd8iQjXUzgOGqLTIkeY1RP4HSfM6Fta3IGCVdYvl
 XmwXNtDUU8ROkEoPGX7u1JJ61jY8uMy7zklngZ4/V7XPVNbxU8sm+BtWh05limd6kqIr
 SMbg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=umttbPNB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="umttbPNB"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The unipro core clock rates are described in an OPP table, but we were
not reading this correctly at all. Fix this and actually get the max
rate and call clk_set_rate(). This fixes UFS init with CCF.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/ufs/ufs-qcom.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index 3656c3861cb5..f514b32afc6d 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -315,9 +315,9 @@ static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba)
 	if (pos < 0)
 		goto fallback;
 
 	/* Try parsing the opps */
-	if (!ofnode_parse_phandle_with_args(node, "required-opps",
+	if (!ofnode_parse_phandle_with_args(node, "operating-points-v2",
 					    NULL, 0, 0, &opp_table) &&
 	    ofnode_device_is_compatible(opp_table.node, "operating-points-v2")) {
 		ofnode opp_node;
 
@@ -547,9 +547,8 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
 static int ufs_qcom_init(struct ufs_hba *hba)
 {
 	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
 	struct udevice *dev = hba->dev;
-	struct clk clk;
 	u32 max_freq;
 	long rate;
 	int err;
 
@@ -557,28 +556,28 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 
 	/* Get maximum frequency for core_clk_unipro from device tree */
 	max_freq = ufs_qcom_get_core_clk_unipro_max_freq(hba);
 
-	/* Get and configure core_clk_unipro */
-	err = clk_get_by_name(dev, "core_clk_unipro", &clk);
-	if (err) {
-		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
-		return err;
-	}
-
-	rate = clk_set_rate(&clk, max_freq);
-	if (rate < 0) {
-		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
-			max_freq, rate);
-	}
-
 	/* Get all clocks */
 	err = clk_get_bulk(dev, &priv->clks);
 	if (err) {
 		dev_err(dev, "clk_get_bulk failed: %d\n", err);
 		return err;
 	}
 
+	int unipro_idx = ofnode_stringlist_search(dev_ofnode(dev), "clock-names", "core_clk_unipro");
+	if (unipro_idx < 0) {
+		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
+		return err;
+	}
+
+	rate = clk_set_rate(&priv->clks.clks[unipro_idx], max_freq);
+	if (rate < 0) {
+		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
+			max_freq, rate);
+	}
+	dev_info(dev, "Set core_clk_unipro rate to %u Hz\n", max_freq);
+
 	/* Enable clocks */
 	err = ufs_qcom_enable_clks(priv);
 	if (err) {
 		dev_err(dev, "failed to enable clocks: %d\n", err);

-- 
2.55.0

