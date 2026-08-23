Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326EDC5DF9B
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C46380D8D;
	Sun, 23 Aug 2026 20:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wjhS0kJYrBg1; Sun, 23 Aug 2026 20:39:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517583;
	bh=6cetTYhB9oFURdujld0K2Si8X8tubVC0WlSwIBVyCCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y6OrQFwDhVz2MKsaddqZGktmkVNyZvTnliUzYup6NllPPV0moUNkG38ER5NR9SbQu
	 tXNnOVEzeO9oNU8+Zl9hgHN7oINyN3It1x7RpkKVo4O0AwoUUGzi7ZCap5NZ4eQiiw
	 c85EZZ2gP+q2h1FjV+mlYgAhiJ4xJ2R3m8EW+hd9NzdApT0bHou/zCsITqGCCXuFOO
	 9P2THFPnfKUfTnjgArSmF+diy8XRgwhLBUGtc5k2L1/jq8Mw6PI5QRaXkWR+4U9T5A
	 3TX0H7uvW/RKu5wrgoa4ncu0p6K0oHKOJLS6Q7KEMbGCOFaY9T7LctaIBOFDHcfePU
	 r2Tl6J9oIpGGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 141A380D5E;
	Sun, 23 Aug 2026 20:39:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC0AD435
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBC0A6064D
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GD1FsbVH_eCB for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dWUP3N5J
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BFAF60616
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E123B4064C;
 Sun, 23 Aug 2026 20:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975CB1F000E9;
 Sun, 23 Aug 2026 20:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517575;
 bh=6cetTYhB9oFURdujld0K2Si8X8tubVC0WlSwIBVyCCA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dWUP3N5JSlq+7h5GQ3yxI3lSwlNBCYuGMAf+5TLB0Pq5BAU0V+PJA8hSDboAVzZsI
 8xFhUgBr+l4BZaCrCDh9ywL5qAM+hOqmhaYi7PlIF+UKTBqozDksYY+s54s8kiUE9O
 Wpl3CiW+KeL1MVqqOLOqsCIngvBCVEslQP59dPKZqjZk+3KMmQM0ZXmmRGdT4ABJZE
 eyWy9FwS1IbczRSH6v1S8URBt+lobk8jEsH0KpGAdcWg+l4ys6YaxZONKHn+usW/sN
 wKPgUwVgPfow6R9+yv+CcNpmysbNcx38VFERdxYTJ7ZxainwtEtNZcTPiCNfElYWr6
 KjhwRGapT5QHQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:23 +0200
Subject: [PATCH v5 04/13] power: regulator: Add driver voltage clamp callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-4-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
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

