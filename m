Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FFFC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 12:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43FAD829F5;
	Tue, 29 Jul 2025 14:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QnJWsfAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B7382ADA; Tue, 29 Jul 2025 14:05:16 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7249281E13
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so7004115e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790714; x=1754395514; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UfIM4cloxQRTDRj6afGMt/zP5bDFPnBvJB9mhQLlQIY=;
 b=QnJWsfAlyJVWy+FAXkk10Bwa3yNMrN/5ILkzGlx+Yy6wt/Pd+HCiDvb7ImAFVZS8SU
 FQr50TmLLbESdfQ7IPtnlKRUUdJHyW/N6mGBb79+HooW7oadh096655cNq+U+U66aHpC
 tQmuFM/KbeqxIgoeSXc1MhpCqTcRDJhHyjmLwSpuuFpZ/Ev1UQnWC57ybygE5kkBwrM2
 dS+GN1fjqDI70jxZpyVgMpy9VPnZVox8OJm+vgJoWSE60+sdqxKpNL9w8cuN1+r0Dvw1
 /OFdC8H3jY1kPJ2MfkXCUd6pVOLtIVBaF4iDP7YMTR+4i6eLe3JHiDqtFCh9/MWBugp2
 kyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790714; x=1754395514;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UfIM4cloxQRTDRj6afGMt/zP5bDFPnBvJB9mhQLlQIY=;
 b=qte/5PbQBaxzYjQ7mE4BPzPtB6KVaYdfS9R7rH2CNJkGuPw2Lme4Kn46nzc3yV3DvV
 ylsghjorQk1Z9+QEkkJBSzsvo0WDvcm1RR1PULCadpa5rMjfEWaekSaBUyCuCIg3w/Xv
 fyKkWul/hlWmkkUXUIS2UsryGRtVZRnGBx0MjQWIHZ6ohREmYysawAvFAIN4nWpCbG6T
 KhC6WuBQuFMy5nXCI5L5C4kd7QUlrlmH9UKF1DTehs1jY3ucu1UEPchQGCAbyLxG8kYj
 n+wV5o5/y2yv+ToEvCzAFgIi8OMgjr6Qiu9OiEeuFQMjfN56BnKULBRHJkqKBQ/P5iho
 PcnA==
X-Gm-Message-State: AOJu0YyVI14VdVw7y4PQEs0i5Er03GVInZNw+pgCydbAHCn95zq9g/g0
 0zl72s+fUKgCIM1O56sAR1VtXsUxh5JZYn5/5Ef1OiRzhALxWE30jeA6yE335PxXZ7/3aD/NoZv
 1ZFpvcXo=
X-Gm-Gg: ASbGncssYFYpkjikmbLQ41UmBLu8udhmTk8YE1iwJtqac0PxslCKJkgbodY233y1Kzz
 BbChpGk+O+mY/i+w302khGBAAa63L9prGRMCbz428rW7NObq3wR7oT6Hc1JoUPrzcauzXPkBiu3
 kbxa5mhiwLrcS2UcZIbliR+5JsxznoihrqqutKwlI1SRMIj7GlQ2vHvtjdTnEixWTVhqNmBH6MH
 NZwu3c7tzItH6mUrDDaAN7vAigiyVFzfWHWgkXMlqXCQWDESotXIFu9kZcBTVWsTTAb58iIoIjo
 cS203XbQR+qCkf91F0Hlv090tmvaINqPfbjQzj916aC6Non0uaDXR13DUV1YO5h7dAbCmuHevVR
 X9BTDUY2xYOdGxMyWDw9AoxdmMsYy4qN4oalm76ZHEwxm36kzDUw=
X-Google-Smtp-Source: AGHT+IGOpGmb2E3Am8rJ13FjcBJmV/IG0Ks9Kwt1IxgfsZVmQ3T6lY+J1APJOcnZs9+zs9uNCd3vuQ==
X-Received: by 2002:a05:600c:5493:b0:456:18e:eb7f with SMTP id
 5b1f17b1804b1-4588d110499mr28976775e9.3.1753790713655; 
 Tue, 29 Jul 2025 05:05:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:b80c:a2c7:328a:9067])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fdasm204110805e9.28.2025.07.29.05.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 05:05:13 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 29 Jul 2025 13:05:13 +0100
Subject: [PATCH] mmc: bcm2835-host: Remove duplicate NULL test for cmd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-mmc_bcm2835-v1-1-2184f316fc21@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPi4iGgC/x2N0QrCMAwAf2XkeYUto9T6KzKkjdHloZ0kIsLYv
 6/z8TiO28BYhQ2u3QbKXzFZa4Ox74CWVF/s5NEYcEA/BIyuFLpnKniZvKMYOPoYCD1BK3Iydll
 TpeVsSrIP6yneyk/5/Te3ed8P/ltrDHYAAAA=
To: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

In bcm2835_send_cmd the test for a previous command not being complete
depends on cmd not being NULL so a second test in the code block is
redundant as it is guaranteed to be true. Remove the test and the
unreachable code following it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/bcm2835_sdhost.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/bcm2835_sdhost.c b/drivers/mmc/bcm2835_sdhost.c
index 720127468d3..4ec8c672038 100644
--- a/drivers/mmc/bcm2835_sdhost.c
+++ b/drivers/mmc/bcm2835_sdhost.c
@@ -689,10 +689,7 @@ static int bcm2835_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 		       readl(host->ioaddr + SDCMD) & SDCMD_CMD_MASK, edm);
 		bcm2835_dumpregs(host);
 
-		if (cmd)
-			return -EILSEQ;
-
-		return 0;
+		return -EILSEQ;
 	}
 
 	if (cmd) {

---
base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
change-id: 20250729-mmc_bcm2835-c97e9597c25c

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

