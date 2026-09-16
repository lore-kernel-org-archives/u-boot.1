Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A188BC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B79780E10;
	Wed, 16 Sep 2026 09:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3gVBUbCbIGfo; Wed, 16 Sep 2026 09:37:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BF89B80892
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551467;
	b=KbXk2Th89Jbr5j63dvvD0Ta+VlNuSb0e3mTrcldBgRHOvjnXfA6ExKPwm4RQj2iqSQ1K
	 DsaYVc1k8ynUknKHOqQwWWIKgJ9mYvxKHaXcV0ED2DOT7s5zC+eODw9/Q2b1aPNHUczR2
	 F3i96Nl+VTsmECsfEK4eaShgGS4Fc4lcmmSw+e0CE+jRdro13K9TJDyV32IDDe5ZBWVnY
	 50xqJrC9nrpH9uVxmIM3XeVWwAiZVdf5QChrmBZ8dhN3VGl/zBN/o69hIfxTXbHA4MSok
	 hTPLzpUtikp91qAzAPq7Rr7XWvQCbPYotKwjvxNNkm5KohpkRdbCUD20++zzV8OTBHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cjwq/7PHNulTKAhDylNQtXCgdRNAa+td77cKUojErzM=;
	b=QPZNuG+ayfsv8XFQd7SusAzXm+pCC9Zo/secWgcOYqAKEeDKkUg9kpdlzesKbQ92VmIV
	 +J2swJuPtzb4I/adTCqqdv5IyhNnhs63t6U2Wn3oj5HqwLqNM/e6q3wK54aUpdj+lKzvC
	 jMXFx3FAK4aOZxwzTpwoXENG/wgX4+LwEAw6AZ8qGVZ9RO8tet0O/BxJtn0SDq8fWpA/e
	 QyWngO2yv69KuU3ELD7eN2/lBkg3EOP7h9FIpyi0eeiltfRex/6fJVb9HIYwQBHalGcx9
	 hMgWDP6zCi9cec+8MqYKpEP1cEJKK1ArjOyyLIW7z0pnzmXV/ezBOX9qB3qiOemQWqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQP+NBrE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551467;
	bh=cjwq/7PHNulTKAhDylNQtXCgdRNAa+td77cKUojErzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bhvh/kXxEDoqHSRO2lcnGaTAXW05bxr6T6vf0ioQ1789RmPz3mqICYzD/652Rzr3/
	 /Rpzu4D8ePGKyxxF3sefbunHXWCRHe0Xe/MQ+thSqWPaJex0jEvj70GoHbsVHH3/9P
	 v39jElIbo2OJxX1ABx+QkKTyXb/9cwTZrnmsv9BvyvoWM7W9CcSGUcqM56GBu1IquH
	 OdF7uLW1FQNIx/up3H2w6q0lDYVv3Zdbz/xi9dqMH888lUQKhNSuS8muyMQsXh8kTa
	 /yk/oVfEyIEMHSzNrs/0Lr5w+lt1nWQK55sbKf64G0PYbrBeyBP8qVkRA9UWiAKaTn
	 mj+yrWrMKs9MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF89B80892;
	Wed, 16 Sep 2026 09:37:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 234F829B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08DF580892
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymiHFUaDtF3h for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5094380E0D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551465;
 b=LmjHRFXxXCXg33MSVF0thm6ypaXCYqGz2BdHDuZwto8l9PiGHpww+Elq5EJgFCv+0vbt
 CMrjnkvRUlOLiFIvPtybbR5ngKWb4f0ykRq1dqjexA2h+qMijv2pQxRyWhmwyX/w7tLBD
 F9I+V/zXGosOQHmxWLbX98woDbrUNaYr1L83jfl72186RIsfk7EWtT0y1ODQOiukRnuoe
 rCJtBOcY4rqv6ZfRmJShPMeQ9Kn3oa+B06+fxlAVYMYnwGHDuJ9Kxtzz/WqXboaZv87hT
 FTz9R5lHvTQjksLkWja+ywOj2aBDULqdixmYD83z+pak8soeM9foW8cNVnyo6v3Be9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551465;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=cjwq/7PHNulTKAhDylNQtXCgdRNAa+td77cKUojErzM=;
 b=m2m4CliUFRVEM3Omo3f6fKleq4JbkubJDoee5EKEcr+QN7a89iax3PXNJerSgZSNwwEX
 xQUl87ARb8RnF5mQR0tEeLhIR5HVyY8Ko5V2ICX9DB7Hpt26niW9UR09s6prCWrFNRoxw
 pE9SYmroMMckTix20Q8ibG3t/iKLcD3bVczCSEFQehsEvtUWJ6rf2WxXM0TZ4r1KJdDdj
 wptSOVnY7FL9kgkOkzViTlvl5Io8EZJX3A6kQIpPYiWAaQwz2YidTX3iLNUXBRYXtxO8c
 SfHTHXcyboyQu7Jo1JSliT+dTza7VU210qaKLNblxukUAfEOljfffloLJEKYCuQjN8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dQP+NBrE; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dQP+NBrE
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5094380E0D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0681D6053B;
 Wed, 16 Sep 2026 09:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206951F000FF;
 Wed, 16 Sep 2026 09:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551463;
 bh=cjwq/7PHNulTKAhDylNQtXCgdRNAa+td77cKUojErzM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dQP+NBrEYziioxLpOuAZA+50PCxpsiZSwmgpaGGSUF3oozlc+35ABZYsKi6XcGwC3
 zmcifHjJ79+sy71nvxhz0qflESX7nA75Z+9oDwyROJ5WXwjMEiTFzrzSqR+DQk+EeH
 Qn8Y/TZsH4h9QASrb35md+v5n5O2BPIKCgFhYQhx0swZQiX2U4+fUG5KrxN5TNNkTc
 ByMf26iSc0tVT+M6G6h2NOQRMZOniR3cdUq75blfnE9kExHr3vDdaFS/AYjRIFWtPu
 4KlTS+jjCIt7Q/9ZTw7+r3E8VLg5aFBwyNCfB82O1aVnRTcVf48HTNkZfnVyhv7rSy
 8TkuOCCTsJr1w==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 11:37:35 +0200
Subject: [PATCH 3/8] power: regulator: Add driver voltage clamp callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mmc-pl180-improvements-v1-3-5d7670c3bb32@kernel.org>
References: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
In-Reply-To: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
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

