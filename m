Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34842C624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F05A360758;
	Tue,  1 Sep 2026 09:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L9zQ8_AEbyDZ; Tue,  1 Sep 2026 09:13:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788253996;
	bh=cjwq/7PHNulTKAhDylNQtXCgdRNAa+td77cKUojErzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d7zK7LsECsYgiLdStTJu8xU4LT/QAqwGDLVGCu4NRjpSYeaDMVmK2raAWdOevUnhg
	 OKNHZecYsrj77tW2fG2tgPr0Wsh/0pmf9MEAgsUOLfmtFbfpWF//KjziA+EoTL42+1
	 zLCyCa53IAaWk4mDRfLwDgA8i9Jv/gvfi5hS0z9jqZpiMmxeW6rGp6wFsWKldhZBCk
	 zQ/skTezd8vPikkc4bxvvbGNXdTdl59dcETzrxROFQblEVzrvioLHKV+9yVUvSQup9
	 8PJbVebU409+qRO/cX0T028wYIgVr3JcsVjbN8MBEkjSR/L182v8qPZhhvky2h0ERb
	 Ujxy/BGZRFCzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 509CD60751;
	Tue,  1 Sep 2026 09:13:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56469105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45DBF80C63
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccE6uNkkI1qK for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UocaAeVD
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9710980BBD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EDC0602C3;
 Tue,  1 Sep 2026 09:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588281F00A3E;
 Tue,  1 Sep 2026 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253992;
 bh=cjwq/7PHNulTKAhDylNQtXCgdRNAa+td77cKUojErzM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UocaAeVD6wBZLYGrW3/ytcR9Ul5Oqja3t0bYuYaSK6enqLT1Pfhm3UfBrEcXDyxUf
 IBzlv+hx/VzbBMiAkfQEasGbwTYnaT40yxU/PYuNPx6/0nGF8CA0Cl+7GNMTMEZ/1j
 wg+HRoqAZDuIWW/r2FeLHP9qW0RTI3aFepzSn3pxv4jDeJiNcu/oJquOeXNfLckCTx
 G7+eCtkh2OBLlXGK4Wsw4fg/g9EKbuNjAoCPMoR134RJzDsCIWyHwLo2LyI9+cYUTd
 k4vxX+MLX4/pv5BAVvTGbKEMwNnDljEPWWWsqBBOJaCd4fBVvKSNxrtJMz+1vs6Il8
 +6JEvxk0V1xpw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:02 +0200
Subject: [PATCH v7 04/13] power: regulator: Add driver voltage clamp callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-4-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

The regulator core can clamp a requested voltage against device tree
constraints, but it cannot account for discrete values supported by the
hardware.

Add an optional set_value_clamp() driver callback. Apply the regulator
constraints in the core before asking the driver to select the closest
supported voltage in the resulting range. Drivers without the callback
retain the existing behavior.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/regulator/regulator-uclass.c | 2 ++
 include/power/regulator.h                  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 0f5ba51ad6c2..388c888546a6 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -134,6 +134,8 @@ int regulator_set_value_clamp(struct udevice *dev,
 	if (uc_pdata->max_uV != -ENODATA)
 		max_uV = min(max_uV, uc_pdata->max_uV);
 	uV = clamp(target_uV, min_uV, max_uV);
+	if (ops->set_value_clamp)
+		return ops->set_value_clamp(dev, min_uV, uV, max_uV);
 
 	return regulator_set_value(dev, uV);
 }
diff --git a/include/power/regulator.h b/include/power/regulator.h
index 8d4d1450b905..f6838cb4605d 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -195,13 +195,19 @@ struct dm_regulator_ops {
 	 * The regulator output value function calls operates on a micro Volts.
 	 *
 	 * get/set_value - get/set output value of the given output number
+	 * set_value_clamp - set the closest supported value within a range
 	 * @dev          - regulator device
 	 * Sets:
 	 * @uV           - set the output value [micro Volts]
+	 * @min_uV       - minimum acceptable output value [micro Volts]
+	 * @target_uV    - preferred output value [micro Volts]
+	 * @max_uV       - maximum acceptable output value [micro Volts]
 	 * @return output value [uV] on success or negative errno if fail.
 	 */
 	int (*get_value)(struct udevice *dev);
 	int (*set_value)(struct udevice *dev, int uV);
+	int (*set_value_clamp)(struct udevice *dev, int min_uV,
+			       int target_uV, int max_uV);
 
 	/**
 	 * The regulator suspend output value function calls operates

-- 
2.55.0

