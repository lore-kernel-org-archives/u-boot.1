Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E529FC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 11:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120978339C;
	Thu, 17 Jul 2025 13:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b+Eb9qQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83098833C0; Thu, 17 Jul 2025 13:09:18 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73BF683242
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 13:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45611a6a706so4189015e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752750556; x=1753355356; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lq1Q0xXZxN9plEJBl0m0EL7PmLpD5UP4AdB6zUvRIgo=;
 b=b+Eb9qQSCwau8TX4sZ8nSa1qxVn8VIq4jMEiqdgVox8Fj1u/svSDP7oddv3RuTQO1C
 pWKpq/fxWYa8LmQbqsbsDf4PLpH+jCQfTCuoQIbcmbZyX3eiVoaMXId0kmjEXhVK2Q7f
 B1N6dfPH1C1Uax6PkkZRTeWobJo+tKlCZWhMJHBd4QjRjL8NoE/+FrjSwmkaUA6bwRmp
 DbIRhguAmw0IlTazdXdU5ebaGFeorsXFc0AGxhF257wDUxs8aE22hdg96xbJp46vPvRW
 +TkyyxIyoVwSnbDA/Jzvj3rUZehakEeixawuJ3VlTXnAAomFluFAEEXjq49emUILG3U4
 /qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752750556; x=1753355356;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lq1Q0xXZxN9plEJBl0m0EL7PmLpD5UP4AdB6zUvRIgo=;
 b=wjO3o4hgb0JdnfT1Fem/TbrhVF07yvO5IQfXjZhqdggo87Z6PiQWVtqJSjtbFi7gI4
 I0F/n5M4aWQjkB3Q/2p5RsG4/+qFwCPVm7GuzT/SoPXbe2ylDuzkud6yobuXdkhmYDNY
 YepfMv3SQad6jlcRGbzV8r58rveiDSoCzP0soLmlLvyun/Zy8ifQMyJx/WBUBWMruVno
 dQc1t0U5fyCPg1bWd3xraWS6BlOfWDTRw60RzjB7wIdn/EtnJWrJsd2y/7evVfrvCH4X
 8lE/57Ub5q2/jQcv3CuhyJ16QqJMUnkFHpTd7SYhBc69/5NWMAv40iNpVcHnJbSV7QQc
 aatA==
X-Gm-Message-State: AOJu0YzGjKJQPrGPQqLIPraCZtP4+aQGMgRK0Hu0k8Zagb51sHFDP3AN
 /7YfKz6TuqsyueFPTGkB7zHSLoiMyla1fUZH9e9jL/c6uC4dNqTdMMz0rKyey1yr/lc=
X-Gm-Gg: ASbGncsK+uuoSFlbavptRT4o28UadHciuOtZPzQRVu+HdMUmP0/2VTCfr5hTN957b7w
 a0jefA6k9wgRXjxoHCXvnPQDLSMcnr+cBrjWOocCT38dFRFp7FPeRZ3zrCFCLz61UtF67inwoUR
 5BxXGQanTX+8C7p25S+5QYWUaTDqqYObNg4ElhYr2cDucvsQpmR0IBbS8m2EnY94ukVhRdJrAH1
 ttgRDqG5C/AQ7wa6DGmiPAr9mdY9UNM7pIfENGQrCXTrtry0SBEgtuslz0sFuGph9e7pvXSiOsM
 NfjD50YmiD6pTRLwqOMaiNMLnY9ZpMcPCUiIWzzYkplN2jUF7d/RSvNKJOPVmuyOTdc00YwhOWd
 qhoi7wpzoNxMJnNeIA3Pot/UOx5LCmgmozl+IrEuEp/h/awZEChA=
X-Google-Smtp-Source: AGHT+IF+F6/tzd/NBStXfNvZsDEABOPkB77sVWEUKE6COWBnEKxxxtHYosd0f1THHBitLd6B86AW5w==
X-Received: by 2002:a05:600c:5246:b0:456:1006:5401 with SMTP id
 5b1f17b1804b1-4562f2a8d16mr57726465e9.5.1752750555736; 
 Thu, 17 Jul 2025 04:09:15 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:f497:a590:bf80:45c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f5dd61sm19517015e9.11.2025.07.17.04.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 04:09:15 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 17 Jul 2025 12:09:15 +0100
Subject: [PATCH] sandbox: eth-raw: Prevent possible buffer overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-sandbox-raw-v1-1-934ffc784d36@linaro.org>
X-B4-Tracking: v=1; b=H4sIANrZeGgC/x2NwQrCQAwFf6XkbKDduhT9FfGQ3T5tDm4lkVoo/
 Xe3HodhmI0cpnC6NhsZFnWdS4Xu1FCepDzBOlam0IbYDt3ALmVM88omX4b0/UVCjOcMqkUSBye
 TkqejeYl/YId4Gx66/je3+77/ADjXSot2AAAA
To: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

Instead of strcpy which is unbounded use strlcpy to ensure that the
receiving buffer cannot be overflowed.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/sandbox-raw-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sandbox-raw-bus.c b/drivers/net/sandbox-raw-bus.c
index 15670d6d24a..c698a07c784 100644
--- a/drivers/net/sandbox-raw-bus.c
+++ b/drivers/net/sandbox-raw-bus.c
@@ -42,7 +42,7 @@ static int eth_raw_bus_post_bind(struct udevice *dev)
 		device_probe(child);
 		priv = dev_get_priv(child);
 		if (priv) {
-			strcpy(priv->host_ifname, i->if_name);
+			strlcpy(priv->host_ifname, i->if_name, IFNAMSIZ);
 			priv->host_ifindex = i->if_index;
 			priv->local = local;
 		}

---
base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
change-id: 20250717-sandbox-raw-ea339a2554ce

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

