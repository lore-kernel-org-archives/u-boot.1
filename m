Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008A7CF8552
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF2E1840B5;
	Thu, 20 Nov 2025 09:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rEbuE4Zg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646E483D3C; Thu, 20 Nov 2025 09:13:13 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785908405B
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b427cda88so378768f8f.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 00:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763626391; x=1764231191; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oJmISXKsl7w1HYA3F2D3dkwyBHvNv/12pnGKsi/68EY=;
 b=rEbuE4ZgglufABWEzlpgoSoD/jj+9COXgjuxebmY5B/IaKhCVqYHVErPAbZTFWuPJc
 IMjFeGuuygWe66bkjH3J/nF+f2jNQEnIH6jiUtvt2CI9FeobV7vJnrt048J5aQh+yzva
 GgOhjLDaQl9fpmiEctIfyngkfJ5e6pj2Zz1V+bk2rl9WOUFUs//hz9cdjc1bAXDoK1ic
 kw7NtLmx4du+81AGqmA74fwG0B6AJzM7Yh7j8TM3oQg7U1Bf8ilDnctjgt6V5sSK31IG
 lTm98vIWRYixS5qcbbnJP9ZVARZr5vkOsrUggt7lBywd6SNNnZzm0javTQpJOzhgc98W
 /pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763626391; x=1764231191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oJmISXKsl7w1HYA3F2D3dkwyBHvNv/12pnGKsi/68EY=;
 b=Y/b2O3cJoSl6Fk/1gdCNAqk7wZoRDbmMnCJxGS8TsEYBKdFb5gNDueQ6+wN7aXka11
 4KpuifQWk5yLRLo444Lr7XcQHHfJ5Og/qJGshnMth1W5EcBUujSnOESoHWspGA2GRNrn
 amg2K7mKucP/Wlzjce90xnJMBV++r6Q7s4l4+odM6IwCRQN/1unnGArl8FwJe/vAyBq3
 u9An9ccu5l/d39iN0WS1/CCKwDp8/6PlcnB90/xr5TQOZw25dSTFTgFnuS8I8US7NrQ6
 PXqoHe5FQZBmXRrCxYbj/xeRgtoklKS8/1jKkQ0YK8llNGbM8OlT5rZuyGfqzilrW7DY
 B3NA==
X-Gm-Message-State: AOJu0YyW0LoJCECudhDdj0V6KlHXgJ+COvp4izauesFupnXcqoDbSV3j
 7go7rbdl+FE0WFxYMHQnFXTFG2SqYkg2ocOZq/Y9G0+E5XMtCla1FW+/zgy+DMBx+8M=
X-Gm-Gg: ASbGncvD1gvCe1z94fdrf1J1Rb2BwbgfOQyAB5ps9EsiIMkxZduoBtRLF3HYmVJTnQI
 Sw6wtoLSaMCMnHJEkopT+4GwX/D+4ZdJJTMJ2kSxbCkXSNXC/0CHMNjCJxRMp/pJUs2x27Qn5kn
 z5h5n4N3AWIXmn7sdhg+9HB7xJhEWTYWDAUPvQQR2XbTwVrAlkX+7Mz528C+vdybaa63/VmFYMb
 MC+dsOAvzg5qHgOyK0s5NmhZOyY1M5Ik1Nj82b6oBWEdBMTJwtB7XpFJceWZDZxAF+kINsxQ/qP
 JuLrle6cE4KWHFDK63vMJURrDIZMZ8y1uhVSVAMxgT5rv6F+cyTRyI6H/KA3qzA6SQ0VZCEiJTO
 bJxcG46toLjzabPmLZKgZ5gTAHWmTzISIqsw/UPlvA6srMDauldfoAeCdnfPYNY8h3cab3JxAGa
 +m8IEUjTq4xE8t/0pVh9FqmumI5IuOhLo=
X-Google-Smtp-Source: AGHT+IFnYoRg38KmEtoCwOCObIvfyNs65UXAzqM7TLcK1NPP0mWg5BFhzpTa1JvARgkJ+3LVnDaH0A==
X-Received: by 2002:a05:6000:268a:b0:42b:3e19:b650 with SMTP id
 ffacd0b85a97d-42cb9a2462dmr1769870f8f.17.1763626390688; 
 Thu, 20 Nov 2025 00:13:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363c0sm3844398f8f.18.2025.11.20.00.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 00:13:10 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Nov 2025 09:12:57 +0100
Subject: [PATCH v5 6/7] ufs: qcom: vote for interconnect bandwidth on probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-interconnect-next-v5-6-e8a82720da5d@linaro.org>
References: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
In-Reply-To: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CvpCEKFxB+isktJw+V5Y+wRub94e+OdAuWFNJVHgqno=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHs2KQ4vfkxTargZiUFb1RfEtzsSyxUnxz0wSfaVV
 36QFl9WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaR7NigAKCRB33NvayMhJ0bInD/
 428MuaosxelTpzygL4lyqydo38v2fiidOCpCj9B+vjtDImce/TJc7E5yCUgs3Y9ZyVLk6ZJIA4mywP
 SjF1W+nZy/5bb2OW/cMGvBqSUtl6tO9DyeTaXhhp7nC/PdgwaDcztSLmu8BMsOn/4mEvTnjraO/PP2
 byvyYFE63LedF9Nt9CM4b9+1Rmy8Gew8yIQMPhCrDhwdvsXNfqc+2IqhQBtxEIyj7Z3bQvPVBRfD8v
 b1rGlPvIjpAv8N3cGg2CkHVUZeik61XzPg71uIdixsnzuUD6nYuRyAUeguNExOnuAw6hX7i9VA7uVd
 abQu2G7J3btINWsifi4+WsShevcLhXbkIxJFflQCUZw3cK+mgmvWRqvOBE6tP6NDPCOqR1pG2UcnC1
 KK9UCuBT5enBCS8HpI1I6w+dVpjJwlwnxerq6H//A9ssW1RPtIHySLuWNBiAygCa/5uV4shpkwh2PQ
 fybiMVrxsuyiZFEKUSQBBpJ+yYnIhCGh0yZDbW7Ele8/hP0f4jNbGYm+axRl6PBGYP32sdrRSjfkqk
 67+JL3DZT539qp/hbr6p549uwRcOg2U48JsDF5AkkP31Y9xeGFJVjmfiQIkR10ZjqVH4rYYde1anP4
 UYRDkz2mmm8l7tzmlQGUR5E6z1fI98m39q+lcYNAYofbyPlexo3O/HKx7J7g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:14:18 +0100
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

Add Interconnect voting on the UFS probe to ask for the largest
bandwidth possible.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index 9f0a6940d98..ee43958d5d8 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -16,6 +16,7 @@
 #include <generic-phy.h>
 #include <ufs.h>
 #include <asm/gpio.h>
+#include <interconnect.h>
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -26,6 +27,9 @@
 
 #define ceil(freq, div) ((freq) % (div) == 0 ? ((freq) / (div)) : ((freq) / (div) + 1))
 
+#define UFS_DDR_MAX_BANDWIDTH	7643136
+#define UFS_CPU_MAX_BANDWIDTH	819200
+
 static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
 
 static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
@@ -625,8 +629,17 @@ static struct ufs_hba_ops ufs_qcom_hba_ops = {
 static int ufs_qcom_probe(struct udevice *dev)
 {
 	struct ufs_qcom_priv *priv = dev_get_priv(dev);
+	struct icc_path *path;
 	int ret;
 
+	path = of_icc_get(dev, "ufs-ddr");
+	if (!IS_ERR(path))
+		icc_set_bw(path, 0, UFS_DDR_MAX_BANDWIDTH);
+
+	path = of_icc_get(dev, "cpu-ufs");
+	if (!IS_ERR(path))
+		icc_set_bw(path, 0, UFS_CPU_MAX_BANDWIDTH);
+
 	/* get resets */
 	ret = reset_get_by_name(dev, "rst", &priv->core_reset);
 	if (ret) {

-- 
2.34.1

