Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9D0C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68559830C0;
	Mon, 14 Jul 2025 15:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DCX6AR85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB1E8309C; Mon, 14 Jul 2025 15:13:26 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E782083055
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so3614261f8f.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498804; x=1753103604; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nfo45vCtyMEXOKlVWCDJqB1mXX8njRuiSrfuD7Ghbb0=;
 b=DCX6AR85ij3lgHD4UBw93uaNFnUdpOI2pXtPEL5JVCrJCLTOg+i+5B1pOc/W1KDxzi
 4reo8e8fHGU9iIDWu+v0+ZV1BhzRKs0jxFroKbUabodSTOc/uxdimczIuLTguyXjHFFl
 VfaP686k+WLfOVStpFnTqfGGxONVRHlx3cHB3HJlkIuWZ5YZ3Y6WhalOeyJv/bj7Fifu
 JbUYfNTlQIKv7ZxDgpglA6Hqmt/OXmPeHnEwtGb6+dYjXLZBLuJ5meXRFAmAhDLMO7M0
 NRGjRfug8MvhUY18zHMMZMYI9XZyLB+Y4cd9RESc0OUvcRs7tPsBBPx1MGJXkwlaqqll
 eAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498804; x=1753103604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfo45vCtyMEXOKlVWCDJqB1mXX8njRuiSrfuD7Ghbb0=;
 b=LCHmde1/MO02EJG9YJRqfldtAMhHFUpvKl9u8oPqx1FNzKZA48E7CA+tPzwWtAU+ub
 cpw5ieXBpkbrOKqSEHdo+lKoPqkVJhKkSA6VmNBP67MR72qk1bWAlrUyxGRhaCNi5CXX
 ABKjobdvqqh50tGX7m8Dpa957HCbxUmULKft7y6Nza6Y60QOTZx7MbYPXgD4hZH2CKk3
 M4xTqVlVLoMITQzPTHXxyAwvmM2RdFDjBp6VR83bYZMcDyY0x7bNxSNbbTMp5xJXrVos
 jUwhALdIRiM+tgR2e8u+hfBObsmN4iZyivjcpzXyVtHZANowQ/I3ThR9aYbuiBsZhk5C
 VuAA==
X-Gm-Message-State: AOJu0Yx7VCkS/1QW3VodUsU97q/rGI9hiTtn0LoscFgelj8a0lrkc7VK
 7VuxsSb4TdlJo/I/KzbFQ7tUdUplp0FJINgrfbUcnJLEPPspgqLLbYxaxGXeZ0DFSHRaJewbWvs
 M1lh1
X-Gm-Gg: ASbGnctelgbwcRno0pHwHWmxuaslPuZTpKWpauBj5VP5AhaErvPkkJGwgSO7jTbZR7B
 Fm7SWsF2uPBYCYua60LKB8iIsMtmW3Ekjby/e2fDLlUivqxo2C2KOIBXhBVdsiecQzWAFGnRijK
 8chXW8nWudTdoOiN4IWAxJC0CKP6eq8rGOQSGNQxcaKZGzmyvPyQF3/fu/ZeI6pksqV6JjimRkV
 WlK9KExUl64GZOeZsQ+1oqccAk411rbH4pBnnxxJLWUcyurBSrHpAK2zi7suPuJbhzW8HZVa78O
 8fRG+auIzydlzyygHpFUQQHarthn/FjwInJ/4HwEX3IlaQ/c1zq01USjiwWCDFHthkxnUxT/uAm
 HFkr/AXOju7NLNPrmnwibdC/wVMpN/kbuhJzIT3K5B1UBxGLeoQxVdqc5wMZMgU7ZwrZLhsXi+h
 mGsVfO
X-Google-Smtp-Source: AGHT+IH5guXbrg6YiRwJzmMJXAxkLUmTBEuipGrzD8rZEwectnbpqFboD1ZsbkBPpuUVNNlALBLWcQ==
X-Received: by 2002:a5d:5f49:0:b0:39f:175b:a68d with SMTP id
 ffacd0b85a97d-3b5f18565f1mr11382710f8f.11.1752498804250; 
 Mon, 14 Jul 2025 06:13:24 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm12361010f8f.44.2025.07.14.06.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:13:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 14 Jul 2025 15:13:17 +0200
Subject: [PATCH v5 6/8] serial: msm-geni: Enable SE clk in probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-geni-load-fw-v5-6-5abbc0d29838@linaro.org>
References: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
In-Reply-To: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Stephen Boyd <swboyd@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=K/H613JlL9P0Y4Lqb131zIGOsIyrc6a0IgfctsGGgV0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBodQJq4ZaCSjUOt9Z0C8il/KgRjMlDubH+XI1nj
 J0MONwL8u2JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaHUCagAKCRAFgzErGV9k
 tlHAD/46hUU14NjdWyou+0S2pPyeRYEoWX6WiTBEDd6iFCbtKeYcp37lscg2bAmrecDKGZHqiJO
 yt+kjj0LaLNe/9Ateg7w4p5khH6itWj2Sa8KFbEIHJ+2wR705rW0l6+tk0WjzTdw8QQg9qu9XDe
 aTZkybZzZwuxF82nEcHF7H6mSBvyul92dEWnv8lQhLIfJtXH/JdxVVFQgajV9Iy3ex14U2bUwhX
 hngeqehyzfyH+bJIDl/tR32p7o1JFJ5A//TiQD+0vPk8bMv3NKdIwG1/dm5wDRxI0Z9naaW6f9G
 7zyaNRl8j9cx1Lf8nSUshSH3OmWBlh+/JCToKgUjIUUZgGOu93QUeVvRQ4J1MvXAd2EcyiXWQTr
 ONaHmRbEoApX6ikWqQdkYYVuiK12KnxzoYyBLfo/6+JJazai66k1uD7LhfoWJz9ZG1rToZtxBYc
 1nGC0453vZW4QevP9VxPgkSVsvMBBSaQpx9LtcqdINyGtsxzj8GBhVPOimvPoG0xU7WSco7nEzD
 r/olu1b7yXzjn52R8nKqSGLK4FQOoLiua971D4UhCJVYRF6MKz6V3AcQYGYs+7wZ6yBI21CYk64
 wUcBXa1KwKic0TSsccWDiHP+lUeZmYtYJgdiubdDQ/Gxq/Nvlq+LRZHsn63y2sw4vQv9y6Ykyqw
 WyObfwAsz7XP/NA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

From: Stephen Boyd <swboyd@chromium.org>

Enable the serial engine clk in probe so that this driver can work on
platforms that don't already initialize the clk for this device before
this driver runs. This fixes a problem I see on Coreboot platforms like
Trogdor where the UART hardware isn't enabled by coreboot unless the
serial console build is used.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/serial/serial_msm_geni.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 44603ead77cd9f7948a2bf52ebddfebbfeb9f1c2..35e0029144be7948eb5ab0da5a2d1317a08fb0c5 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -130,8 +130,9 @@ DECLARE_GLOBAL_DATA_PTR;
 struct msm_serial_data {
 	phys_addr_t base;
 	u32 baud;
 	u32 oversampling;
+	struct clk *se;
 };
 
 unsigned long root_freq[] = {7372800,  14745600, 19200000, 29491200,
 			     32000000, 48000000, 64000000, 80000000,
@@ -180,21 +181,8 @@ static int get_clk_div_rate(u32 baud, u64 sampling_rate, u32 *clk_div)
 	*clk_div = ser_clk / desired_clk;
 	return ser_clk;
 }
 
-static int geni_serial_set_clock_rate(struct udevice *dev, u64 rate)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	ret = clk_set_rate(clk, rate);
-	return ret;
-}
-
 /**
  * geni_se_get_tx_fifo_depth() - Get the TX fifo depth of the serial engine
  * @base:	Pointer to the concerned serial engine.
  *
@@ -251,9 +239,9 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
 
 	priv->baud = baud;
 
 	clk_rate = get_clk_div_rate(baud, priv->oversampling, &clk_div);
-	ret = geni_serial_set_clock_rate(dev, clk_rate);
+	ret = clk_set_rate(priv->se, clk_rate);
 	if (ret < 0) {
 		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
 		return ret;
 	}
@@ -560,8 +548,18 @@ static inline void geni_serial_init(struct udevice *dev)
 static int msm_serial_probe(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 	int ret;
+	struct clk *clk;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	priv->se = clk;
+
+	ret = clk_enable(clk);
+	if (ret)
+		return ret;
 
 	ret = geni_set_oversampling(dev);
 	if (ret < 0)
 		return ret;

-- 
2.50.0

