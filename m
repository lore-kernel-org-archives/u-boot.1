Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6572C982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 22:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1951480DEE;
	Mon, 21 Sep 2026 22:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fHPBYdb4S0eg; Mon, 21 Sep 2026 22:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E01780DE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790031107;
	b=BQHdW4eDneiBBOuL+pKIuyj5BiJLBnEB70vostxKybfiRYJ/3G/0niobjZNe5mdYNEcG
	 pLorIlXpcr6KXearr097ETbMYFB39ChCTA9DJCfukvosUnGK2lUQOZs6r0HOhEkNHJYB4
	 opjFIZuKSTabQTmQrBcPmyjD8cgN/e051QA4bvWXqY8GjM/cnRiYhJ3p44WpF7zFpTTag
	 1SJH1+MNpOoKsTNISvIJRzJ0sbWpykHE0fEbioVsXWC7IBfqNP+1jFuAcX3TnykFmkPQm
	 8gu7hf3QWiowtSEuTQIRIeXgC53ZJU5F5ZcSwAy0nmNkEJF8UxZ07CHk5tJ3AFqbGpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790031107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rqo49a3HnhtVAbpKI6LYLCyeDnGhNX80gPhHgmQtgYA=;
	b=mM6KxpjslE5yk8II80zIykRZvKw2hhBxEq75dVy5pPmz0h/EnN2Fdq3yPOn6URtXW4qj
	 u6QlawLQJQKYu+5WGy5Dc0l9W111X2sCeQ9t3wZ2XKGzbZqmzg+ecJ6xg0oQaKQl+LdIO
	 SoKl19UBhJD/dz8DZYT1Om3FWhnZhklS+B22BieiPnVroVHiIfamsp8KmvO2kQtXgFS5p
	 c+gmw8kdHZRGhfCGSYgH0+z4XGrYZ5QGMDN9Ga9oQAQ1T1xqhY2ay8fo3lbrsOTREFbHI
	 3NghIigPkIAxvZgDhjZkTYz22f0w1cHzV0GHForFm271yEJ2un0XCKoIic6jNGhJeWQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790031107;
	bh=rqo49a3HnhtVAbpKI6LYLCyeDnGhNX80gPhHgmQtgYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mn2SqpxKLelid99i3/FURLi1T4egJqKjSMv0S1sWNpS0naI6v1HQ1MeAyogNOBbju
	 BAohxXFAj7loVpb9OtnTOw9egTAfX+IQa+wIVSim/ENkXDJM7rhjMvkFZYgonNBHP5
	 ctG5XzgUu9YqpyFstK27lvvuvcYvG3itKHOabuINuQII3brYmZSiSkTr/LVRWB56fk
	 CuRVlO71+pfTntVm6w35zdoUo/YBMzWTiQeoF/GeIdXKqtRaZ+x6BU2RKlZqzJhS9h
	 Cn+Tx/7Als6aVly4QPHlm5o7P8+9k86sepywsO7t902M+R3aL/pHSynW8A7I3U19T4
	 2OFhn0ocTTatQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E01780DE8;
	Mon, 21 Sep 2026 22:51:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4691C386
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 375CE40206
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5RPMHwzvNJ3 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 22:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 60D0A40112
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790031102;
 b=BVBl4Y7WIT6ce0wpV68Ilgv+HWcePIOqmF7Jh9XJE402knA9VTx3lDdA7obewZUgJEvh
 +jQd4Y4WxH+nBOSmGm62JZtNtrcqdwj5ptitNnAlZ4lxWWP7HSOR49pGJ9taEa7eEXIgy
 LOVOQiq2uzLdUMxsZ6ak1BFnx5QoqNrXpO7vDlaf1VZcK+7KKhA1w09A5m7HgbyeERqr8
 LfN104wuDCEI2tbubHhuJWLPPgof6EPPi36grwQEPiWNJonR6bHnrzP6T/Nj7mNyJfUV1
 cuYHcE2EXcClR7LD0l0dVXoi03cBHB1NV09fDg71iHOH3tPWCEA8ZXI5c4ztL5J+Z/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790031102;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=rqo49a3HnhtVAbpKI6LYLCyeDnGhNX80gPhHgmQtgYA=;
 b=Tf8cMUu6vGZYkpIy8GieWXvPGNYuoNY1VmDxE0jw7hvjpn/ZoRVsRHV59+aTOvGOp4OM
 YLs/4SdWeyThFNwWButUzb4DlmVG4dQjlDuWa5IxFZPonGwL6ffjYdH353sHp5emxesKE
 I2pLej/6NCMxn0d04QSJJt7ZO7glhxakvlj4QJ+7ahDnbxJAhFpAHpKZhUNnRZ61el1BH
 7Qp8fdLxd/blUcOcX9yhBg0UvYkm6MjxGxZ4UHnFWys50HnUToJjmm3GzLHEMYDZL9CVU
 uxzBZA3j6oST0j9lpvj81omtm4VSphWFTAxqgzUEAOy5rtruMISNBfWjKFzbAW00NGA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fN3+4SVs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fN3+4SVs
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60D0A40112
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:42 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-47be948a50fso2547787fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790031101; x=1790635901;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rqo49a3HnhtVAbpKI6LYLCyeDnGhNX80gPhHgmQtgYA=;
 b=fN3+4SVswxJOvStfd3GFtouItt9z5gFIO5WiKtpMHMvmE5e5OW6pMQQJUajqgEfma5
 ce3II15IB5j3tM8IMQ0KxgX8ADTwgv3OTB+A5LT6VRNiV6+p4XfYKKjoF6Feci7VMh+7
 0aHL/hzGXDGQf3N/SpYz9zVtXDZoIz698JBiQ7+tBG4/rh/AkS4sVrfPpTteHgF5yKnU
 o/UL0C5h9xYxupqA5P2SGV1JENYWPd+JoD2//bAhd1hyg3SLsEl5/0FEI9O3OJ7XSbJL
 G6aST6yPnmrfBl0vwL6VH6OLeGGpCO0+8bb7Qmnr5F0vAymz5YuW5MjUV2RjYRiloos8
 E3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790031101; x=1790635901;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rqo49a3HnhtVAbpKI6LYLCyeDnGhNX80gPhHgmQtgYA=;
 b=zET1Q/Oz4rAkyHZkULIefxo1aQzGYodSSHs/SdjWafKQtNKp4mVN7pftDjcnG712vh
 /FBaCghNz9MsQylV6nZ2BPvaphNUNDyVaUQRfHauARzkvl2RJfyGn62bRMUGEqVeQYzv
 DkXk6VbJrO9J0nbfVUrgAp+w0A/xDjwQuDyZJHcPWOITTJyt9Z2zL0+5f5/0Rj8k9SnH
 3IYNb6Q8DMva1L+JX6JBu95t5oc7kj9L34+YSQCx+nRDs8Ei3SRCcyPVsmN6XtHQy4QI
 z/QMWa+fim+fbHHrLgyO7ttXaVRxzw0dgAonN0MQt95NPHH2ly0cA/YuZ/Pdobj9PB5k
 bJ7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwM7+dhpmB1qMXtHwUTT2WUI+5jr8lkG/XGWfcVlZGnvFWAoFxxsC6pNO1XJeS4kMdnh0XfTzc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++korDNrzOWQGDxLRcU8QI7b9d4CRk/h/QWQ7K79PxOOTx1A0muZ
 VRcfWcJl0JnGUUIVdegGixFHodx52xFd5/m43jlCCMQqKZHo4Iu3oB0uaW7Hp2yawIw=
X-Gm-Gg: AYBFou3dcP3v9Bbvx4QHSt7AoPc6b2Fwgtxmh8o2X0JPB9W30Cdl7OzrJQXBnos5IoT
 5cLll3RmOS0/lOXXQdWg+xfZP+QDl9US0Q7NqQGSWAVEEQepWVjLrIw5RGLZ53cYA3k0S3nO9hC
 vt3spiT3FSu2cGo5KvFCfjVy7XGyn2T8ctnauGnPTYqA6CQCqXc0guSVnCOOAiok8xB02+8Dl1B
 JZl6N4+KKjPYfrVPWYmeBt9fNdnpqBxQjYvL5v9SVKkr2RY+ZiPn+9/ziX01zGGc/vQ3xQtaoLy
 4TficFVJWyD9ytyLtG/4JlORpvtQZ/+mjw5zcas76987hiODIFSitIkABRjm34vq0ICx36U1qt2
 IQqUhBpC0lN9mrqwEIEDRXPsXyGbnDBRF+Zqn/zlrzF3wEk06MhFkG5pZcjg1rz7oH+QWz9HdTL
 gy5IsO3lzmGptcn8uxRXRbo5nr5qj+8oghaWB0fC0/D4tU2zovDjB9u4vLCSUSPtnmaRwrqZfub
 QY=
X-Received: by 2002:a05:6871:cc5a:20b0:487:7075:2d1d with SMTP id
 586e51a60fabf-48770755456mr7166550fac.30.1790031101254; 
 Mon, 21 Sep 2026 15:51:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48f71e90570sm481468fac.4.2026.09.21.15.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 15:51:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 21 Sep 2026 17:51:03 -0500
Subject: [PATCH 1/2] power: domain: mediatek: support SRAM isolation and
 inverted power down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mtk-power-domain-sram-iso-v1-1-52e9b365d2d1@baylibre.com>
References: <20260921-mtk-power-domain-sram-iso-v1-0-52e9b365d2d1@baylibre.com>
In-Reply-To: <20260921-mtk-power-domain-sram-iso-v1-0-52e9b365d2d1@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4739; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Hi+yXQfSQy+HPhCw/U0+t3SMgsb+L3L3rMtEFz/ThSs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqsbTrNDqFkRg7Y3+4jmDDersgccVVsmNV57VNB
 52IrnjM7CiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarG06xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASAcH/2TuqnbAsE9ZKVn2QAEsf8CkPpo6R3f6OXlqLrI
 1vLk5aw9Bw1MMlWjnNWQIlwQBymsGYziWwKLzygvF6TBR7vMFK5VxPMuL7lxEhn59gq/G+jZwNJ
 l5JLFEjkhcg/wfY2Fcqb0zI4E2w0CMU0NhY802Y5iZSq31eqhx31qy7Zbzds59zbL+iI8xTPif/
 PmMbTgNEJ8CIV0iJUWAfGFZUMPoj00AQnliP8alqU1GgoRaWtQOZqd8spaXrQL3SN8KlOyqPqIt
 TjoW/LMrufZCrWJBIELRVzhgvtlE2RNfEQEopidriC3K9idLuzkQ7LXg/cW4bOiYJhflvuv/8+8
 yFOk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Some MediaTek power domains cannot be brought up with the plain
sram_pdn sequence the driver implements today. Two variations exist,
matching the MTK_SCPD_SRAM_ISO and MTK_SCPD_SRAM_PDN_INVERTED flags in
the Linux driver:

  - the domain's SRAM sits behind an isolation cell that has to be
    released once the SRAM is powered, and re-asserted before powering
    it down again, and

  - the sram_pdn bits are active low, so they are set to power the SRAM
    up rather than cleared, and the ack then reads back as all ones.

Add a caps field to struct mtk_scp_domain_data and implement both
variations in the power on and power off paths, so that a per-SoC driver
can describe such a domain.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 51 +++++++++++++++++++++++++++------
 drivers/power/domain/mtk-power-domain.h | 17 +++++++++++
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 768ab8bab9c..60dd9ee9d2f 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -9,6 +9,7 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <asm/io.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
 #include <dm/device_compat.h>
@@ -240,13 +241,32 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 	if (ret)
 		return ret;
 
-	val &= ~data->sram_pdn_bits;
-	writel(val, ctl_addr);
-
-	ret = readl_poll_timeout(ctl_addr, tmp, !(tmp & pdn_ack), 100);
+	/*
+	 * An inverted sram_pdn bit is set, not cleared, to power the SRAM up,
+	 * and the ack is then expected to read back as all ones.
+	 */
+	if (data->caps & MTK_SCPD_SRAM_PDN_INVERTED) {
+		val |= data->sram_pdn_bits;
+		writel(val, ctl_addr);
+		ret = readl_poll_timeout(ctl_addr, tmp,
+					 (tmp & pdn_ack) == pdn_ack, 100);
+	} else {
+		val &= ~data->sram_pdn_bits;
+		writel(val, ctl_addr);
+		ret = readl_poll_timeout(ctl_addr, tmp, !(tmp & pdn_ack), 100);
+	}
 	if (ret < 0)
 		return ret;
 
+	/* Release the SRAM isolation now that it is powered */
+	if (data->caps & MTK_SCPD_SRAM_ISO) {
+		val |= PWR_SRAM_ISOINT_B_BIT;
+		writel(val, ctl_addr);
+		udelay(1);
+		val &= ~PWR_SRAM_CLKISO_BIT;
+		writel(val, ctl_addr);
+	}
+
 	if (data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(infracfg,
 							data->bus_prot_mask);
@@ -295,11 +315,26 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 		return ret;
 
 	val = readl(ctl_addr);
-	val |= data->sram_pdn_bits;
-	writel(val, ctl_addr);
 
-	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
-				 100);
+	/* Isolate the SRAM again before powering it down */
+	if (data->caps & MTK_SCPD_SRAM_ISO) {
+		val |= PWR_SRAM_CLKISO_BIT;
+		writel(val, ctl_addr);
+		udelay(1);
+		val &= ~PWR_SRAM_ISOINT_B_BIT;
+		writel(val, ctl_addr);
+	}
+
+	if (data->caps & MTK_SCPD_SRAM_PDN_INVERTED) {
+		val &= ~data->sram_pdn_bits;
+		writel(val, ctl_addr);
+		ret = readl_poll_timeout(ctl_addr, tmp, !(tmp & pdn_ack), 100);
+	} else {
+		val |= data->sram_pdn_bits;
+		writel(val, ctl_addr);
+		ret = readl_poll_timeout(ctl_addr, tmp,
+					 (tmp & pdn_ack) == pdn_ack, 100);
+	}
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index 06760286a3a..fa5c12b47d3 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -39,6 +39,22 @@ struct udevice;
 #define PWR_ON_BIT		BIT(2)
 #define PWR_ON_2ND_BIT		BIT(3)
 #define PWR_CLK_DIS_BIT		BIT(4)
+#define PWR_SRAM_CLKISO_BIT	BIT(5)
+#define PWR_SRAM_ISOINT_B_BIT	BIT(6)
+
+/*
+ * Domain capabilities, matching the semantics of the MTK_SCPD_* flags in the
+ * Linux driver. The values are this driver's own: only the handful of flags
+ * U-Boot has a use for are defined, so they are packed from bit 0 rather than
+ * carrying Linux's numbering.
+ *
+ * SRAM_ISO:		the domain's SRAM sits behind an isolation cell that
+ *			has to be released separately once it is powered.
+ * SRAM_PDN_INVERTED:	@sram_pdn_bits is active low, so the bit is set to
+ *			power the SRAM up rather than cleared.
+ */
+#define MTK_SCPD_SRAM_ISO		BIT(0)
+#define MTK_SCPD_SRAM_PDN_INVERTED	BIT(1)
 
 #define PWR_STATUS_CONN		BIT(1)
 #define PWR_STATUS_DISP		BIT(3)
@@ -100,6 +116,7 @@ struct mtk_scpsys_bus_prot_data {
 
 struct mtk_scp_domain_data {
 	u32 sta_mask;
+	u32 caps;
 	int ctl_offs;
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;

-- 
2.43.0

