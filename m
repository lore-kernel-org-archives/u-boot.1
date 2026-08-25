Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BA0C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46006606E5;
	Tue, 25 Aug 2026 19:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1xVnlll_9je; Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684658;
	bh=6cetTYhB9oFURdujld0K2Si8X8tubVC0WlSwIBVyCCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M/aMwhIDiaFLC3TKJPtKa/7TZzaN8AnekQRZXqMMlLKDCAezq6w4asmj6xyxd3MOO
	 zWX7DYFiC3EPUMSiuz9FQii7MvUyVu38zE5YUVK//1jaQFInF735Gq3BsLdY/2Zq3w
	 JGL5EeGFXNigxBH1ky4wbl7G3AmhcoxbSyDdab3ckMnuauJ4ImsDGceMV+YGDP+DUh
	 8fl/3od+36mpZtUZ6Lp88Ancwm+/3hC9K4vTSjRZxtYwSmb50QnDv6WjjeZYBiR0cn
	 zYjfSYlNlbMbksQeIsIggWsKzwk7cAr7t7ZBY7I9jwoXmkhQIbytqd/uX6ntne9QGa
	 Dzavdx8yFwyKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9614260746;
	Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 737F4334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59C786071F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSEiWhQJ3TDG for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XR9w/au+
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7A93606FA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8B7540AFE;
 Tue, 25 Aug 2026 19:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2C01F000E9;
 Tue, 25 Aug 2026 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684653;
 bh=6cetTYhB9oFURdujld0K2Si8X8tubVC0WlSwIBVyCCA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XR9w/au+Z0e4QQmn5JpC1s8O3T1+P+pUQnCJPqx8nl+HBxRVe1xPNh0v3a4uCXeat
 FHQ05IDLS0fdzhrWwLQE/BOagMsESSMZtQCZ2inS9nlgwiMys0tExFjCkIfOhOvRzj
 R3npmknGzbreT6Z1urtDdJzoMwDVxwCP5gkP2tNa0HSojVTaDeORWNHAmUqwSb8M3n
 byk/4ZPbgnlOehE4pL0Ni5YViUn0NwaG8DDEOEDs23EUK28K8bAt6BkWQwAv3t1Fpf
 IZGQlJ6D33psQ5WeYS7cMjX27iTpwBVWwl8zX0oF57si6STx0FVPNS8n99U5ciDOux
 yi/XFu/PGZYdQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:04 +0200
Subject: [PATCH v6 04/13] power: regulator: Add driver voltage clamp callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-4-61446b6c289e@kernel.org>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
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

