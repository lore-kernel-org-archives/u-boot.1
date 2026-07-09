Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B0FC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6D484B9C;
	Thu,  9 Jul 2026 15:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="OI1Wjx1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5152884A3E; Thu,  9 Jul 2026 14:58:23 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5494E84AFF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso4438595e9.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601901; x=1784206701; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ArrA+Y23BrqdKJeKkH2B0pXjIQvh3ZKL/fUYeilXdlA=;
 b=OI1Wjx1a2uebCHR/ks3OQUho2nm+eJne9nQxKrJh206jmA4Zt4geFh0NHSk6czpMSP
 h9lyAE1R0zzkrwai1GWTXLdrsJKFAzK23Np725MrG2JKCQ2daEQ12GAPyEFsRWmtKyyl
 +jI8cYafy6jN5kvcN8RGqNkCS7VqXE6E8GWdPzHWEkNXeH5nENot1X5Jkg9aSnHrLTRN
 3kcj2klc4TLVkZbrnIohQljvHZwK8kjMFp3tcOeCKGyJuDwRdC4pALHMCqSQD4z1VJXQ
 zsljcBRNIh7vlcOMUHgdHQYBKeAoW3YuR1qLYg+gzF0gIcUqKQKn33xOBjXiRYADS4pR
 gaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601901; x=1784206701;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ArrA+Y23BrqdKJeKkH2B0pXjIQvh3ZKL/fUYeilXdlA=;
 b=eHgDTdsuf+hMl5iJimomp7nlf8BEbUbwBTlsnlZobgzeFW05mud6AD2WrcJoOVHJfJ
 dl43qhtOB/sBAVtcUne9n3UAsYTjgBemXfPlMaFwFBjqdx1ErSvHu9/WE6xbfommBq5s
 6/ozFoEUurnt9Q7YTfM64k2gXQxwsWKGwPwJQOHfjh3YTqxTrxn6bo3NFU2xsp9YRMdu
 56x4SY0AHj89Eyj4bfRda6lXUmNP8wi5lq6aDdlLg1o/aDzmPT9uJVFh3CWkUq9Yih58
 BEPRMnERe3sBlLD/ihDcQBcDm2tIPzoCVktHQxDoC5pCVLWlF7X8WX5EqYM4xjs6zWVt
 HWXA==
X-Gm-Message-State: AOJu0Yw2VCfAnEY1Ip34aCygVfjEQUXOTQ1rJ3WmUjjDuhhu3hix6PJm
 V0Szxdoea/JgHPg5IxTcwImPmtzUzEvQlLk/+l5VMRFVF/WFHKWaOIBL+80kRvyLpAQ=
X-Gm-Gg: AfdE7cnoO8TUcXHBn/FOejpUIWwUrX0snax7lXXyD58NVk2FEehXcCSz39gaInRJpxi
 ebKfDj/uWH4Fgm8uExTAu2TE3cXlB0viTM1OZbLhuKz3h5noV/94hAcoCpI7qCPsqvuyXHYctch
 gSoF0t1ozYSlbf7/huu8tqjjp+kNdiBylIpUBhifrLy02TbYAOqeFbZ/sTHC41y2ZulmZXBLQVQ
 1BEZkApYw4IKO8Kg51tf3E/h1XXxDCkLG6iS+nG9hfGn2iijGELcpjA7pnUW/pSsRzkILIHZzC6
 kwUAvVVyMPt1SddYzg2n6HEgNg0MFZIX+tA98/8xkfJcYHhfaRdLZdX2TpTUvvprdWp3VeQj1Cq
 Yo0EpFpd8puzEQSLQgRy7aJn//JGc/T3C1Y+vUJ2Tg+/2PtmT3fQJ7TbJuasSzv4cDvqKCMzmE8
 UmZ3WIo5bBXPrzy/P0kqyjFEDtMuI8H/DWhsoHwuvbmpJ590OEnbpPlNrAN2dkj0dHej0QUGMe5
 G8XtXOcTTr63vIBqnLDutKRDkHyWIZtYlVIvdQ3DmWYSWgFgFMEsZaajHxbPj8FFc9Hwgs=
X-Received: by 2002:a05:600c:8a0d:10b0:493:d9f7:a3cf with SMTP id
 5b1f17b1804b1-493e695bcf9mr54141885e9.17.1783601900646; 
 Thu, 09 Jul 2026 05:58:20 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:15 +0200
Subject: [PATCH v2 09/14] power: domain: mediatek: wrap domain tables in
 struct scp_soc_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-9-589ace7d30e2@baylibre.com>
References: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
In-Reply-To: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
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

The per-SoC match data currently points directly at the array of
mtk_scp_domain_data. Wrap it in a new struct mtk_scp_soc_data that
carries the table pointer together with its size, and add a
MTK_SCP_SOC_DATA() helper that fills both from a single table definition
via ARRAY_SIZE().

The num_domains field is not used yet; it is added here so that upcoming
SoC support can validate the domain index coming from the device tree
against the size of the table.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mt2701-power-domain.c |  6 ++++--
 drivers/power/domain/mt7622-power-domain.c |  4 +++-
 drivers/power/domain/mtk-power-domain.c    |  8 ++++----
 drivers/power/domain/mtk-power-domain.h    | 14 +++++++++++++-
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/power/domain/mt2701-power-domain.c b/drivers/power/domain/mt2701-power-domain.c
index 5626235360e..58ef47c3001 100644
--- a/drivers/power/domain/mt2701-power-domain.c
+++ b/drivers/power/domain/mt2701-power-domain.c
@@ -65,14 +65,16 @@ static const struct mtk_scp_domain_data mt2701_scp_domain[] = {
 	},
 };
 
+MTK_SCP_SOC_DATA(mt2701, mt2701_scp_domain);
+
 static const struct udevice_id mt2701_power_domain_ids[] = {
 	{
 		.compatible = "mediatek,mt2701-scpsys",
-		.data = (ulong)&mt2701_scp_domain,
+		.data = (ulong)&mt2701_scp_soc_data,
 	},
 	{
 		.compatible = "mediatek,mt7623-scpsys",
-		.data = (ulong)&mt2701_scp_domain,
+		.data = (ulong)&mt2701_scp_soc_data,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/power/domain/mt7622-power-domain.c b/drivers/power/domain/mt7622-power-domain.c
index 487ae477bb0..b98c384c3b1 100644
--- a/drivers/power/domain/mt7622-power-domain.c
+++ b/drivers/power/domain/mt7622-power-domain.c
@@ -36,10 +36,12 @@ static const struct mtk_scp_domain_data mt7622_scp_domain[] = {
 	},
 };
 
+MTK_SCP_SOC_DATA(mt7622, mt7622_scp_domain);
+
 static const struct udevice_id mt7622_power_domain_ids[] = {
 	{
 		.compatible = "mediatek,mt7622-scpsys",
-		.data = (ulong)&mt7622_scp_domain,
+		.data = (ulong)&mt7622_scp_soc_data,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index a8045c1f91e..752ca404875 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -44,7 +44,7 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
 static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 {
 	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
+	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
 	u32 sta = readl(scpd->base + SPM_PWR_STATUS) &
 			data->sta_mask;
 	u32 sta2 = readl(scpd->base + SPM_PWR_STATUS_2ND) &
@@ -65,7 +65,7 @@ static int mtk_scpsys_domain_is_on(struct power_domain *power_domain)
 static int mtk_scpsys_power_on(struct power_domain *power_domain)
 {
 	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
+	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
 	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
@@ -114,7 +114,7 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 static int mtk_scpsys_power_off(struct power_domain *power_domain)
 {
 	struct mtk_scp_domain *scpd = dev_get_priv(power_domain->dev);
-	const struct mtk_scp_domain_data *data = &scpd->data[power_domain->id];
+	const struct mtk_scp_domain_data *data = &scpd->soc_data->data[power_domain->id];
 	void __iomem *ctl_addr = scpd->base + data->ctl_offs;
 	u32 pdn_ack = data->sram_pdn_ack_bits;
 	u32 val;
@@ -170,7 +170,7 @@ int mtk_power_domain_probe(struct udevice *dev)
 	if (!scpd->base)
 		return -ENOENT;
 
-	scpd->data = (const struct mtk_scp_domain_data *)dev_get_driver_data(dev);
+	scpd->soc_data = (const struct mtk_scp_soc_data *)dev_get_driver_data(dev);
 
 	/* get corresponding syscon phandle */
 	err = dev_read_phandle_with_args(dev, "infracfg", NULL, 0, 0, &args);
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index 0c2c06a045f..ade77af8f33 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -12,6 +12,7 @@
 #include <power-domain-uclass.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/kernel.h>
 #include <linux/types.h>
 
 struct udevice;
@@ -68,10 +69,21 @@ struct mtk_scp_domain_data {
 	u32 bus_prot_mask;
 };
 
+struct mtk_scp_soc_data {
+	const struct mtk_scp_domain_data *data;
+	int num_domains;
+};
+
+#define MTK_SCP_SOC_DATA(_name, _domains)			\
+static const struct mtk_scp_soc_data _name##_scp_soc_data = {	\
+	.data = _domains,					\
+	.num_domains = ARRAY_SIZE(_domains),			\
+}
+
 struct mtk_scp_domain {
 	void __iomem *base;
 	void __iomem *infracfg;
-	const struct mtk_scp_domain_data *data;
+	const struct mtk_scp_soc_data *soc_data;
 };
 
 int mtk_power_domain_probe(struct udevice *dev);

-- 
2.54.0

