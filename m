Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBF71099B56
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 23:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A6283FC5;
	Sat, 21 Mar 2026 00:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ozp7YZCh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF1083D71; Fri, 20 Mar 2026 16:45:52 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A83883CF3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 16:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+casey.connolly.linaro.org@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7486860130;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24BCBC2BC87;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774021549;
 bh=RwPetbFsL/DFnkmQJk/U8igJhu1TdhQYN4wtLRk48Ss=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ozp7YZCh4Be5m5hL8+8DksbV2V7aOO4unUhhuF6BY3p08wGCjz6OT27pXrl9OYB6W
 xq78798JGA6WwOzTgV+Zpem59eMyhA4/Ziy3CxFL8wCo1mmFH9/xfXIC/AmSGvnYsO
 eZ55yjkYLpCWtG2KWavclD3XT3Lit1FBFoFD0Uh1T3tW2CbyYdphlPf6+cgyKWfKdi
 VNT7nUxWmz8+8RiEdHYnM1In3wIIsDRW+QgIYlTe3veHKljmX4PsL3aOzWbbU2g8he
 RJ5WxeunNpOsLybG8fATe3EFS1kkrTFO8Lw04emJQyXqc0RaYb0d+5M3Uf83GyEKgU
 MKqGpudI910cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 151E11098797;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
From: Casey Connolly via B4 Relay
 <devnull+casey.connolly.linaro.org@kernel.org>
Date: Fri, 20 Mar 2026 16:45:40 +0100
Subject: [PATCH 1/2] serial: msm-geni: allow invalid clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-casey-qcom-rpmh-serial-fixes-v1-1-b81d05832eec@linaro.org>
References: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
In-Reply-To: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=7/r+622xulBFw7ksZmxxltq0sQqqtV5oui7FCVQq6rg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsy92avV9pyY864hSPfec00jD/biMuk1T2vOuTbOuf58i
 8XCjG+6HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiPNcY/tfuW37uR2/W4fMr
 ZrFsOOuj93DTytDK+Nrb/ZPcZm7JOSHN8M+0uWXiAfljlSd9FVz3bF5dXVnnea//tMoV/ayHKRt
 MCs8CAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Endpoint-Received: by B4 Relay for casey.connolly@linaro.org/default with
 auth_id=688
X-Original-From: Casey Connolly <casey.connolly@linaro.org>
X-Mailman-Approved-At: Sat, 21 Mar 2026 00:54:11 +0100
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
Reply-To: casey.connolly@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Casey Connolly <casey.connolly@linaro.org>

Pre-relocation we probably won't have a clock but it's usually
been enabled for us already, or worst case we will enable it after
relocation.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index bb5a2cb4d2cd..c37255f57d05 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -211,9 +211,9 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
 	}
 	ret = clk_set_rate(priv->se, clk_rate);
 	if (ret < 0) {
 		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
-		return ret;
+		return 0;
 	}
 	geni_serial_baud(priv->base, clk_div, baud);
 
 	return 0;
@@ -516,15 +516,14 @@ static int msm_serial_probe(struct udevice *dev)
 	int ret;
 	u32 proto;
 	struct clk *clk;
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-	priv->se = clk;
+	clk = devm_clk_get_optional(dev, NULL);
+	if (!IS_ERR(clk))
+		priv->se = clk;
 
 	/* Try enable clock */
-	ret = clk_enable(clk);
+	clk_enable(clk);
 
 	/* Check if firmware loading is needed (BT UART) */
 	proto = readl(priv->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
@@ -546,12 +545,8 @@ static int msm_serial_probe(struct udevice *dev)
 	/* Don't actually probe non-debug UARTs */
 	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,geni-uart"))
 		return -ENOENT;
 
-	/* Now handle clock enable return value */
-	if (ret)
-		return ret;
-
 	ret = geni_set_oversampling(dev);
 	if (ret < 0)
 		return ret;
 

-- 
2.51.0


