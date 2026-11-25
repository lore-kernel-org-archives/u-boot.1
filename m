Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A2606A32A
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gtg2JOGY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbIi5uLS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FC9C80CCA;
	Wed, 25 Nov 2026 22:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CwA1K9bRqthR; Wed, 25 Nov 2026 22:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55DC080CB6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795646091;
	b=TbER/3ebjs9vycP0RNSQ+pdXbR1OKqTaIiVgHyhd5KltVpZMPzd9WcZB4pESAuf1LHWv
	 ASqses5F1TDg+wsRETHHk2LYxL8oZ9oI2l63f44TI8nx5M/jOOszuWPpKfrffC+LbG7LI
	 b6wZOJxepA+tr8WzbYYIfXW8Y8zD/4MuwqwKvlvHiwp2GSLUFqczkH71VFHV2DuXBrlWv
	 8xqQNAoTjtwd/9pyZglK7AvlaGeTuBNkcIdes6zzhtGm/5z97Zfcyuo7XqrsDQzcCLBvi
	 A4Tf2j0gG06uF3cGUlNsgF3QuP9gvZzU2Rs0IhQ7rAv7WPEiYkKxP/Y5s+S9ZX5lHnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795646091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yfrrvMRn17ljA4Z2BsXLQoJbXuGYWI5MpP2XtJur0ow=;
	b=rF4bX2HZ6NjQ+X40WX/EOJpDu1ko0W/ufU/CWdOVZrzxn9w25zNgveZBJt6dqTUddWGe
	 IMwv9ByNGIBO4B4Pa7rZm65GB6eLSQpMmhUYiycd6MV8Lq3zGcLL7Egz6dJpzXw6ArlRC
	 ZQKQaxnVEmNSOttgGcv9unV5R1+yLbpP9wppp3Pw4SMvHiua860xvhtFbnoUeJZl1w95N
	 whbYBfCk1OWjaIM8EepaaXtfD7usryX0P9iuCroqRk8VvZsck2t19CKR7JgM7ezG3c+Td
	 lZyei2zskne+wFuXOqjzIzU9+YSA/TZDgqpWCCTFU8rOFvehI8YPE46CDK1YGtEJ/mw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbIi5uLS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795646091;
	bh=yfrrvMRn17ljA4Z2BsXLQoJbXuGYWI5MpP2XtJur0ow=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gtg2JOGYXdLkIDrvHs4HHmfHAZAjunVfkWD+og+5lEdort/fCaM3iY4kbuEw+Isp9
	 CeQjgeWV9f0ejpJc9Y+MkSEfQ4YmCFtUzGa4RafHy3wqf+ix3b2MQSyo4Qyhm3TUwn
	 2+HMxRPiGXebqQJDcmZHg+4Ix4RK1/Vj6u4PVBzs/3g8yuysAYDoDuBqG+NxPoxW6I
	 d/Fi1SEI75ULNTehIR0E2VB5y5k0oEa1Uom7FN559cmf5dSUvCpMBB3hYweUuejfdA
	 Kyd6Mw8+HjR2GifnvTtb2biRHeGpcgLhGK5qFhFUpTwER6fJK/NDR/OvSaH5omwXXQ
	 7UAN4S1CrfOfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55DC080CB6;
	Wed, 25 Nov 2026 22:34:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E85932D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2094F80CB6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:34:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpkOWnfeRG2B for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 22:34:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3914F80B88
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=macroalpha82@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fbIi5uLS
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3914F80B88
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:34:48 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4a77dcc4ca0so3364907fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795646088; x=1796250888;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yfrrvMRn17ljA4Z2BsXLQoJbXuGYWI5MpP2XtJur0ow=;
 b=fbIi5uLSIXjPKk2NthaWTESA0Kr5H8xwDkhaIi0UHJH8HqAYVl2QUDxBuFx1Q+aYIN
 Mbq7G59Z4zVa46OAODooPPGnyK5vxomdxVaXNaDOF2/isMtaow8u73UJvTE63TcLaPw7
 wppAtLC2/amugSmtaDLo2IiHA8qrk6gVFV61hvDrXS3AnXU1x4dycfb7b4ebFvvLf+b8
 zjjjsOZgnZlOS36pLW+3l5oRB9yYDYwwrmoaJ5h+4HEc7rNSxYiDAafHC+u5VOruuyMB
 06R4L9q2C63w2GBxhuvkcy47ANE2AVJ+Qu4kjfMVWv9CZyx3D3EIfWha634Yrh/7ZQ2Q
 +kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795646088; x=1796250888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfrrvMRn17ljA4Z2BsXLQoJbXuGYWI5MpP2XtJur0ow=;
 b=iuNmnNMTpH0gJ5pJOYEPm/NlTYCn5aVzRCVsnJ0Zi8NJ35uQ7pcsePUOUheScV36Ly
 x6jFvaupGZIhQdeQzigz+2m+nXr62R+gFtO8UHzlZta/0XAS8gilEnIOhhC2f9Xr3eWw
 CUIGGYavS8JKSegpgxxFC+xHQLzoJswOUYC9EbIaps1vT/UlVepSV7TJqaZ8GkKdaHdw
 Cjb2ChSTWOiLlRQWO1Wo5UJxCEF1jccCX1uWA8+VWS5BAhXuQFPC6di7qjGjEX55pDim
 mcQMrzd0LuzBMJTjRcxQILcpGDmaBMt8OIcNoJbm2c4CCIxM2PAzmKTMKYb6OTP9uda+
 4R2Q==
X-Gm-Message-State: APuU4Z97pBh0/XjW0CQd7VZSvb7zMUY2D37QvDxXdCNDQ1RP5OU9Bkq2
 Ynbw6FfMw8OLLxoURay6J9T6nukqsVivWucMeOF1WgHQiiDEPFANm+5VPCIBWg==
X-Gm-Gg: AZFdTZdELGr3+mqk/LqhlwnKW8DdKuqdQFENOgcvh8Pf7MEF2rRE37YTF0pm6ZEX/gu
 3UHMVXwjg0ONF2Evbty0EP/MNxOMtvyjCPQ5tgWzpRmAuqZES6ozwlrDITEUCTFGE+qr9bCMwMY
 3iHYGAOVsMd1r1w5aqZeGaNlGiBFRbKGBEqjleMEOVrehnihtV2xhalA87MoNm7e5niF4qYaWP2
 FjTVZ9iZoA/C9iBb9iBgjK37m5Ienwla/40OVqCiod9GH0EYdczC/uqnE6MLe4yOis3YnXEsYzM
 XurRYoO/QLXlDsMsEKCwcWtPWH1C6hox6ORCsrimxc1cm9G8HS5raTAAleTpzX0AnjVjKung0yC
 EsxT5KBX6CAKbpWJaF03GxH36E5lJFQzvwoTWilCm6qtwQmrK94ZjstYkcw45ZSdyulMgiJQhgU
 K6SceoMh2htRZwS48fwCa2xu09es+Kb8WvEqMkjZj3/WLk32NxOxJAB0MT6tNrnYQlIGHrFj4fw
 UKMAwJ1xJK07Tv7w7n2HAgGsu/Obv2r9zefJSKSRp8uiKDpRuKyaiCT9alT7zz0OwH2b1d/ikXz
 hdsfTTKA7HzC4oZl9GfWDF1tQ4aWpA==
X-Received: by 2002:a05:6870:1b08:b0:4a6:f6e2:690 with SMTP id
 586e51a60fabf-4bc80ec7089mr16970572fac.22.1795646087821; 
 Wed, 25 Nov 2026 14:34:47 -0800 (PST)
Received: from neuromancer ([75.28.21.198]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60497300sm18335121fac.11.2026.11.25.14.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 14:34:47 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, u-boot@0leil.net, peng.fan@nxp.com,
 jh80.chung@samsung.com, clamor95@gmail.com, zhangqing@rock-chips.com,
 kever.yang@rock-chips.com, power.xu@rock-chips.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v2] power: pmic: rk8xx: Don't set RK817_POWER_EN_SAVE bits
Date: Wed, 25 Nov 2026 16:34:44 -0600
Message-ID: <20261125223444.603529-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chris Morgan <macromorgan@hotmail.com>

Don't set the RK817_POWER_EN_SAVE0 or RK817_POWER_EN_SAVE1 bits, unless
the device-tree property of "not-save-power-en" is present and set to 0.

Per a discussion on the mailing list these registers are used by the
BSP kernel to save the regulator state at early power-on so that
late shutdown can ensure the regulators stay at this state to prevent
a possible overvolt situation. However, these registers are not used by
mainline Linux and actively setting them in U-boot interferes with
their function for BSP kernels, causing systems to hang when
regulators are enabled or disabled incorrectly. [1]

By skipping this behavior except when the BSP only parameter is
present and set to 0, we can preserve the registers function without
creating additional problems.

[1] https://gist.github.com/fr0z3n-cs/047b24a6fd430e816fe02a877ad7ab8c

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/pmic/rk8xx.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 95b71d2fe49..614d749d5ff 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -293,15 +293,23 @@ static int rk8xx_probe(struct udevice *dev)
 		off_source = RK817_OFF_SOURCE;
 		init_data = rk817_init_reg;
 		init_data_num = ARRAY_SIZE(rk817_init_reg);
-		power_en0 = pmic_reg_read(dev, RK817_POWER_EN0);
-		power_en1 = pmic_reg_read(dev, RK817_POWER_EN1);
-		power_en2 = pmic_reg_read(dev, RK817_POWER_EN2);
-		power_en3 = pmic_reg_read(dev, RK817_POWER_EN3);
-
-		value = (power_en0 & 0x0f) | ((power_en1 & 0x0f) << 4);
-		pmic_reg_write(dev, RK817_POWER_EN_SAVE0, value);
-		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
-		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
+		/*
+		 * If the BSP only attribute of "not-save-power-en" is present
+		 * and if it is 0, only then would we save the register values
+		 * for use by the BSP kernel for use on shutdown. If the value
+		 * is not present or not 0, we skip this.
+		 */
+		if (!dev_read_u32_default(dev, "not-save-power-en", 1)) {
+			power_en0 = pmic_reg_read(dev, RK817_POWER_EN0);
+			power_en1 = pmic_reg_read(dev, RK817_POWER_EN1);
+			power_en2 = pmic_reg_read(dev, RK817_POWER_EN2);
+			power_en3 = pmic_reg_read(dev, RK817_POWER_EN3);
+
+			value = (power_en0 & 0x0f) | ((power_en1 & 0x0f) << 4);
+			pmic_reg_write(dev, RK817_POWER_EN_SAVE0, value);
+			value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
+			pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
+		}
 		break;
 	case RK806_ID: {
 		u32 rst_fun = 2;
-- 
2.53.0

