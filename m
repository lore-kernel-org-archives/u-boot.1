Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA8FC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 14:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 187488388C;
	Thu, 24 Jul 2025 16:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S7RMdFnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85D783893; Thu, 24 Jul 2025 16:23:13 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7157583844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 16:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4560add6cd2so9044765e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753366991; x=1753971791; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DyZv9w+R07eRLGGBUgQqCYASiBWuvWRCq1UEbcShjKc=;
 b=S7RMdFnJn6i9Vy/wRIC21gz3FmPtMdN2VcqpQOL4yJ0TRwZsZFgx2OMrvE1EP4TQH2
 tO6PdKIW9DNR0BHf7FXja9GNjX192azTTrk7hv04rdy9Q9qAmDdLcLOmnVTap9AqEgkN
 bEthu8V8QfFxa3JncLuSz4wXG0aC1sFZedChtz3qyqYBcDKrW3pOUz8vsk098u/ue45e
 MPru9FePSUikvmxF38rSMVcZxObXMJ5IQZl2UNmaXV8FFwlTIyVJ3QV5jmJVdeFK+pKd
 KWN08kcUzf77ir49LVSrndspA1SJi7GS1uS2GAkj4g3S6XB4XEA5Vg0ugIEckF4/uCGM
 c2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753366991; x=1753971791;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DyZv9w+R07eRLGGBUgQqCYASiBWuvWRCq1UEbcShjKc=;
 b=UdxVx8ArZkaN4wg19SBpRaZvyHEpBhEg9+8L2gxN4NqpIy2bUwuW7LxI6b1o4P1lkz
 eRk1USgqdfBlQ8p6+JSgZEDQv0J5++hWQ/6677Yaq8Kcx/R6X6F8XRtRS9sMS2GEbiM/
 dfn39ZO5F6YPZVScogH0i5IISYVJjfl7jSxN+PkybDeSwlvnXXlxHs8awVc504zQgnfu
 4j9qn0rUBTqVOrpwI4xpNXy2fR+X6UKZ4Na2dpStKl4GHv2PhijtNysjAX5UkIgiHHgS
 wTeGuXH3jLne5CC3afFTrBn5tZnfHiouKUJqCcIE3FWY8/trzR+t9h9a4rEo8Rgoenoy
 aDzA==
X-Gm-Message-State: AOJu0YzTUd6DBK3UMg/Qa0EsVFEKNYY0atT9/l5sYEd6iU+qi5/6UvwO
 Dzt1S46SGlrsi1JNTwZR78qRTfM7ry6x9/Ij6DBsJvzQ/dTKBkVFgMuecLh3yzPdrfOyG1v+cCj
 B1ylbAY4=
X-Gm-Gg: ASbGncsq+16HF1O6KOwDlDS+kkZunuxTWL5AvMxIlAhsayfrf6Am2on2nWcNpcEcEOU
 i6C7K7JP9wxEEVJBkzmtKoo6gwkQRdNDw/v1ooRqRNoSV5naqdwOkxHPUC6mrx/+C6QZ5YHAr7R
 ws74o9NKfp9N/F5mhHzIXw5zL2IbZjTEGvQNE3ejfkACRAATXJVVFUkvQ/36x4azXbxNaAm+nQr
 +GHKl212h92Kg7o5e6iNPrxnxiB0FsnjQXUyaIZAtq3ipyN/f/edNRjNQ/Z32dQUhmLHGHCLGkk
 /vEfnm0zdDcU6kF/n/yD8feBwKgKwJqXOKgWfaW718uxueft5M9mJZNtN9Wgz4Yl7z1ybXWLGr7
 ySdAhOevBPX8awWq5pPK4fTr7XXQF9kqR6TQhwOANT05AfdN4SXw=
X-Google-Smtp-Source: AGHT+IHTDDjUoCcVJMsAY2nkgVy2CRuRQDeQrRnqe8n9o+Ge3HrYj15cljO0mF4cUbI1qlyqHuoSJg==
X-Received: by 2002:a05:600c:12d4:b0:456:23e7:2568 with SMTP id
 5b1f17b1804b1-45870580784mr16402955e9.13.1753366990679; 
 Thu, 24 Jul 2025 07:23:10 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586f5169a2sm16203945e9.4.2025.07.24.07.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 07:23:10 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 24 Jul 2025 15:23:10 +0100
Subject: [PATCH] arm: mach-bcm283x: Fix binary logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-bcm283x-v1-1-f56f1a458991@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM1BgmgC/x2NQQqDQAwAvyI5dyGmK5Z+RXrIrlFzcFsSKYL49
 649DjMwB7iYisOzOcDkq67vUqG9NZAXLrMEHSsDIXXYUwwpr/S474EiM2IfxwlbqHVil5CMS16
 ufmXfxC7xMZl0/y+G13n+ACurdH1yAAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In bcm_cpu_probe the test on the return value from clk_enable is
incorrect and will not work as intended. Change the || to && in order to
achieve the desired effect.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/cpu/bcm283x_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
index 59a7b142c95..7db00dadd90 100644
--- a/drivers/cpu/bcm283x_cpu.c
+++ b/drivers/cpu/bcm283x_cpu.c
@@ -174,7 +174,7 @@ static int bcm_cpu_probe(struct udevice *dev)
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (!ret) {
 		ret = clk_enable(&clk);
-		if (ret && (ret != -ENOSYS || ret != -EOPNOTSUPP))
+		if (ret && (ret != -ENOSYS && ret != -EOPNOTSUPP))
 			return ret;
 		ret = clk_get_rate(&clk);
 		if (IS_ERR_VALUE(ret))

---
base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
change-id: 20250724-bcm283x-24aa0074df01

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

