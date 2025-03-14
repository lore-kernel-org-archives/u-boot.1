Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402A6C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 15:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E34681DD6;
	Fri, 14 Mar 2025 16:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qxgiGRg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF5481E18; Fri, 14 Mar 2025 16:31:26 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD5DF81DE9
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso1887043f8f.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741966283; x=1742571083; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s0m4/Z5dOo+I7WTYK65j7lHlRCfu5BFPnI6We4OMi+U=;
 b=qxgiGRg8BDJ0wl9nzUKbSMX41ktyclIUo5gYbiVgmJJhYxfArS/xLz9C0tCMeFYlvP
 Det3siBrKsQErRccCYvHZT8KNBjHS4HR9CxK/rYf+dpsRq3TXuIMQ5q/iTwVaQ6xUkRy
 ioiBItBtZpbR4cpoR/UW5r4sX8WFwBK26Ti8nXOoGte8Ns/wzWOvQejY2uUgoaQh+vh9
 tIzOl60DSKXLwTEB5u6I4KUQz6STDGuDOjNR3uPZ6JuICOou5n3jcowZMzAnuus102PA
 Gzm6St9dRUeOGlAb0BpATzivbSOU+CPB3yNwXQgJgq8zZZJjCI2LhrHfM90Kd528G1kN
 BoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966283; x=1742571083;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0m4/Z5dOo+I7WTYK65j7lHlRCfu5BFPnI6We4OMi+U=;
 b=UYIHJo0FrV+9d/01YfefAQ3uzODMVmOlz0HcSF8l7VP7IhVYPb+5ezfuj6cNVFxUTY
 mwpo2acbB2tD/PGARKBp+iT0jIgjQCC9ptcLSof4oOrOCcOlGpK9taMeIAZ5NIy+bkED
 cZXRFV2owr7e7KAmh4boTZXIONdRupjFwAXL4nHluYvarYUG2igRbVnp7d3dD7zWWrKZ
 fh3Hx+OBPQGsOp2nG0BnwyDVMx9GnG5p5J2NaGX2s/oB57/gpJSU+m4QST74c0C9Z134
 J7wS6xRQpHWOk3TF/7Mlo9S9H8/Dkf/H7JirppefJrupsHDKsVeqNTVcsXRY/LaiU4SZ
 dhlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO2QEPhNEBnnj6bJU6jR8v3A95MjT9VbuQ2YAZYwOW5RxVpdl5+tWi+gNdsp7u68e0R1yB+d8=@lists.denx.de
X-Gm-Message-State: AOJu0YxjJJRV65g8RYiAVyYk17jZGpJosS+cNtFsB2JcVdOByJrMTE/p
 IVKbBuZLIb5nvB998Li4qqXlzr1GFFWLd+MYnaYzPOx+jdbCe1rNarPEHDGvu9E=
X-Gm-Gg: ASbGncugLV6jtRP4H84TKHQKTjJEYK6RCjml+AL/IayPvog0szst+y7+w/Fxv6R+hjD
 mdSOWz95mJvKRdQLxHQeKio6jPYnecAyQtHdCD2emdltr3/L1f3y+eJhtw9FerPm56nFWgjbaZM
 qwG8UpOMISIZbrtHutRgdW+RvT4rVhcjqCWXPx7EkutEXU3kBuIG0KleVKWL7PUxEQvTngLeiMl
 9K7AGCZRgYtrKBEcMIUZkT+zBJSR5OLiRN1x3FV4R2tEtn/B2BGa+9lQ0W5B2Mk9saeHwNckMnx
 CLm5KKDNPbuBg4mH49cIb7XhtDy5hxaP8m5gMlfKHuKui3xNYbZ+CdtO3NWp
X-Google-Smtp-Source: AGHT+IEYZfbGgoUo6hnoFqPo19czatl0FM/45my6qY9NTtYykiA3FibC1nJl4+YGFYIy51bW7t50pQ==
X-Received: by 2002:a5d:6d89:0:b0:391:4835:d888 with SMTP id
 ffacd0b85a97d-3971e971f65mr3749516f8f.42.1741966283164; 
 Fri, 14 Mar 2025 08:31:23 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:2b81:563b:c694:c380])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318af0sm5907399f8f.73.2025.03.14.08.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 08:31:22 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 14 Mar 2025 15:31:19 +0000
Subject: [PATCH 1/3] clk/qcom: bubble up qcom_gate_clk_en() errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sc7280-more-clocks-v1-1-ead54487c38e@linaro.org>
References: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
In-Reply-To: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9051;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BVqaHgiN6EQRAggbVE1+JSiYr2C0HUvLyJDG4E7p7jk=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn1EvIsREelhZXVniohXwlS8IlSM9g+sa6X2T8I
 twdSxyPu3KJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9RLyAAKCRAFgzErGV9k
 tmLRD/4wQnJo0hLnQQICsVM+iuGmglMTW2zNBi/wfEjZuYg7EP43D0Y01DgdpDtouk2eC3c5NaK
 UwAxtxJI4O7OMdEOlnaS7avZi6m2EsgxDxp/iCmAubaK2DkP4UZvGIevy7z6I11hnMJK3RyA5yF
 3Fvn0WFjSU69BFO4LaKWnaIqbQyn1pQT+JOembHifj87s4bizJ+b5OZMSCaRKzRkEU/j3MqrTDG
 OOw3wU0K/Y7nYr0InSncfho3iCMI0M/b+FRq52eEMimLEHLl2Dm5RdQ2R1eJzCVhId/3Eu4AlwO
 IdfcE96hJq/FqETDcAAoUmLxXwaQx7vGvUxYKzdt2kvDTUSwO9YT/3ZsAZ9o7EqV+ACHweByhUD
 WOagYtQDEeyQsqUdKLF36syCwlldpmH2t1+28qksyRucyyBn/2vkUDpNECb4gESQko+yQzx5B3i
 crqqgY5BQzntKL9jYmEX2YXYxY3lAEFN0eyHtEclTVfA2hAMU9Z7EpLgcnCIbR8mu9+TY9c78eV
 SfCx3tIRb4WEz7xnF8BSYe1dyfO99d2H/GvertA7k1MNYj1JM8Ob/huWjE61eHAITdOEv6q/Hkk
 s2dl60oZwKlpLjRO2geWf3njmY5IQyXtyUGMUyY5JXIXiPO5lPVs0sICsG51QNK36EPPWGzwq5V
 342lIndvu9h4TEQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

If we try to enable a gate clock that doesn't exist, we used to just
fail silently. This may make sense for early bringup of some core
peripherals that we know are already enabled, but it only makes
debugging missing clocks more difficult.

Bubble up errors now that qcom_gate_clk_en() can return an error code to
catch any still-missing clocks and make it easier to find missing ones
as more complicated peripherals are enabled.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c  |  3 +--
 drivers/clk/qcom/clock-qcm2290.c  |  4 +---
 drivers/clk/qcom/clock-qcom.h     | 12 +++++++++---
 drivers/clk/qcom/clock-sa8775p.c  |  4 +---
 drivers/clk/qcom/clock-sc7280.c   |  4 +---
 drivers/clk/qcom/clock-sdm845.c   |  4 +---
 drivers/clk/qcom/clock-sm6115.c   |  4 +---
 drivers/clk/qcom/clock-sm8150.c   |  4 +---
 drivers/clk/qcom/clock-sm8250.c   |  4 +---
 drivers/clk/qcom/clock-sm8550.c   |  4 +---
 drivers/clk/qcom/clock-sm8650.c   |  4 +---
 drivers/clk/qcom/clock-x1e80100.c |  4 +---
 12 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index b5def55dbc2ac671130624dec56592288a0ceb3d..3bafbfea3b6f5bf903f6f5a593e1f062bd40c53a 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -144,11 +144,10 @@ static int apq8016_clk_enable(struct clk *clk)
 		return 0;
 	}
 
 	debug("%s: clk %s\n", __func__, apq8016_clks[clk->id].name);
-	qcom_gate_clk_en(priv, clk->id);
 
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static struct msm_clk_data apq8016_clk_data = {
 	.set_rate = apq8016_clk_set_rate,
diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
index c78705cb8cf19a75508f5a3a0fbc7c04d750d273..1326b770c3ebd723120de4b6657aafac726023d6 100644
--- a/drivers/clk/qcom/clock-qcm2290.c
+++ b/drivers/clk/qcom/clock-qcm2290.c
@@ -133,11 +133,9 @@ static int qcm2290_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_CLKREF_CLK);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map qcm2290_gcc_resets[] = {
 	[GCC_CAMSS_OPE_BCR] = { 0x55000 },
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index ff336dea39cf5cbe35f37f93669285897ba185a4..e9eb659f3ed37522a71e04e9418f48091bf9a0aa 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -6,8 +6,9 @@
 #define _CLOCK_QCOM_H
 
 #include <asm/io.h>
 #include <linux/bitfield.h>
+#include <errno.h>
 
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
@@ -104,15 +105,20 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, uint32_t cmd_rcgr,
 void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 		      int source);
 void clk_phy_mux_enable(phys_addr_t base, uint32_t cmd_rcgr, bool enabled);
 
-static inline void qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
+static inline int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
 {
 	u32 val;
-	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0)
-		return;
+	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0) {
+		log_err("gcc@%#08llx: unknown clock ID %lu!\n",
+			priv->base, id);
+		return -ENOENT;
+	}
 
 	val = readl(priv->base + priv->data->clks[id].reg);
 	writel(val | priv->data->clks[id].en_val, priv->base + priv->data->clks[id].reg);
+
+	return 0;
 }
 
 #endif
diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index e31f24ed4f0ca989f20d1eadcff5f24f173455fa..527cecf5c8282a7c2e16740e6520241a230bca73 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -72,11 +72,9 @@ static int sa8775p_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map sa8775p_gcc_resets[] = {
 	[GCC_CAMERA_BCR] = { 0x32000 },
diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 5d343f120519da02d8ec3e269d348ab46cde70a8..8ffd1f43f23e51140c7822f0f523fdfd8ab1de7a 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -72,11 +72,9 @@ static int sc7280_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map sc7280_gcc_resets[] = {
 	[GCC_PCIE_0_BCR] = { 0x6b000 },
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index adffb0cb2402a6b27e0e998af2f121c519301820..6a0bf16ba2dce7f922adf971817399c71ac35586 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -161,11 +161,9 @@ static int sdm845_clk_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map sdm845_gcc_resets[] = {
 	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
diff --git a/drivers/clk/qcom/clock-sm6115.c b/drivers/clk/qcom/clock-sm6115.c
index 9057dfe0bb1873e9edcfd8c01c0a81b6b8b4ca2c..17c2e5617580aae9ad3f0d802bbc6882c2c81043 100644
--- a/drivers/clk/qcom/clock-sm6115.c
+++ b/drivers/clk/qcom/clock-sm6115.c
@@ -145,11 +145,9 @@ static int sm6115_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_CLKREF_CLK);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map sm6115_gcc_resets[] = {
 	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
index 88f2e678f43cfcc9b80917f26c211049ebca6f9d..7dd0d56eb43031e893541e4031cbda2e92ae402d 100644
--- a/drivers/clk/qcom/clock-sm8150.c
+++ b/drivers/clk/qcom/clock-sm8150.c
@@ -242,11 +242,9 @@ static int sm8150_clk_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
 		break;
 	};
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map sm8150_gcc_resets[] = {
 	[GCC_EMAC_BCR] = { 0x6000 },
diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
index e322a923a5c048769dd5134c6c24e16bb74e7317..26396847d85964d5056cf9af62b8bc89be34dc43 100644
--- a/drivers/clk/qcom/clock-sm8250.c
+++ b/drivers/clk/qcom/clock-sm8250.c
@@ -194,11 +194,9 @@ static int sm8250_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map sm8250_gcc_resets[] = {
 	[GCC_GPU_BCR] = { 0x71000 },
diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
index 62b5a409e8e08243ad53a0bc58af1c7754a3d950..7c06489b9c4df9ce94fa9b44a762c10133377423 100644
--- a/drivers/clk/qcom/clock-sm8550.c
+++ b/drivers/clk/qcom/clock-sm8550.c
@@ -219,11 +219,9 @@ static int sm8550_enable(struct clk *clk)
 		clk_phy_mux_enable(priv->base, 0x8d078, true);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map sm8550_gcc_resets[] = {
 	[GCC_CAMERA_BCR] = { 0x26000 },
diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
index 9baaecb571f6c575c0e7c48d66214c1331b6642f..364454644a699c495479b3099f590562c415ce82 100644
--- a/drivers/clk/qcom/clock-sm8650.c
+++ b/drivers/clk/qcom/clock-sm8650.c
@@ -216,11 +216,9 @@ static int sm8650_enable(struct clk *clk)
 		clk_phy_mux_enable(priv->base, 0x8d078, true);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map sm8650_gcc_resets[] = {
 	[GCC_CAMERA_BCR] = { 0x26000 },
diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/clock-x1e80100.c
index bd9c6ed1c8a0b4ca0b5164d849efa5c0755c1e2e..542d6248d658d2921ef18877c70389549c471ab8 100644
--- a/drivers/clk/qcom/clock-x1e80100.c
+++ b/drivers/clk/qcom/clock-x1e80100.c
@@ -173,11 +173,9 @@ static int x1e80100_enable(struct clk *clk)
 		clk_phy_mux_enable(priv->base, 0x31088, true);
 		break;
 	}
 
-	qcom_gate_clk_en(priv, clk->id);
-
-	return 0;
+	return qcom_gate_clk_en(priv, clk->id);
 }
 
 static const struct qcom_reset_map x1e80100_gcc_resets[] = {
 	[GCC_AV1E_BCR] = { 0x4a000 },

-- 
2.48.1

