Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27094C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B02844E8;
	Thu,  7 Aug 2025 13:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aXIFMr8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE684844EB; Thu,  7 Aug 2025 13:30:27 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D1083C46
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b7825e2775so774841f8f.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754566224; x=1755171024; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QdDkzHzKGLlfW9jDi9txv2DbbV+Ewkced8s3UvOL3Ss=;
 b=aXIFMr8er+BT6kzWA94h05F8rg9ouLbVARxrAkZloKPh6hyaulayJduAZrCiZv7Div
 Rw+BmAfiyCx82GZGnKg/wqnog2cCClIbeMtED5HIW1Z+ZeupZ+roGwaZcVirLDt1qtLH
 ddINv66Bcr9jZw2njimlO4CB8i6HEX9zAsVrf13mIkF23qhUbK3oZeXnfDDDG8tbQuQ6
 mEggvNvkUvytmU8onMgu+xYX7Nt3rLgQ4tmAkVbS02j9EPsZ3Os0lmJEQ8Czc2Jke9ZU
 MPnqHzWFp/+tABTrnuxngO0cPn/EyJ5ce1JJBgfBajAD30nZP5k20Q08/uxgi8y+aRp6
 TG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754566224; x=1755171024;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QdDkzHzKGLlfW9jDi9txv2DbbV+Ewkced8s3UvOL3Ss=;
 b=cd3r46VkGXlAoDZum/IAJxTYz+fVHwyGp2a+sMr0HMtEiccCOr0K03buc+K3d3DZZL
 ZXg3N6MsTQt5XjzRJ6lgMYGWrs5ar5TYHteSZOhZJswL6xUCHsY/a8+ZtDqa4JZ/xxmg
 IW5It5/ZLveivXcJXhMmXlx+XxK9ZCessJgbjUmg4KZLYlPZdM5oY6f6pb50b6ZsnDkZ
 mEXEMoN2T3YSbKBuE2pp70hIelNjYZb/Nd6E32Z9VEMHFNKoLV6Y0/kc/a6KyZo0PVQu
 he8XbreTCTPQGtU5vBslr9Tp49yB/LtEuuLPdzd9nFOWYaHb4V/CyzbZisrLteo9f0NX
 WOeA==
X-Gm-Message-State: AOJu0Yz/uZ3mPYekaTTSRtfMXwYpeVLsymoQ2Fj30RhRtgfgHPcqs7e/
 i7/YZD42ywHY37CD720jk0QAi02Sk8F4Npy1Zxakj2w3jSmMOtHVb/M+rZhQ51vPaIc=
X-Gm-Gg: ASbGncsgtQfI4bkfl2ol7rKpRI6cFrWwouRGtN5ZqCqzexA4ebfZukShS3KXQ7C7x7E
 3Swyv5btlzg1jffGRmdBsFSn5AAWWlp/YRrLhyk/zXle9IRIkwkT8hTlDYiHTIUogFlM8E8N2PB
 vV0oD4hgTyNDirZnz/fjMECY1P7+Ot8DMLHq04HDQsJxeFHJXpXtM3r0LOA8hheS+aKrpVBNL+P
 5pet6qQ6JPzYtl2EDL6W/uHWa60eOxN9zS9963tSrKgwEb8vqUa+VJGN1zX16oZ2K95ymMkTXHy
 LaG4Wym/OvewsiDYLIf8E670vuf9tFAWjnKAOvC4oVlDKKn7rHZ7s79jyLquRwRWlox46YPTRkN
 GJx7FmRUTR8y9+M7ZPNjTJ3aVXWNotCHJWedTRhtyn+gevbr5mEk=
X-Google-Smtp-Source: AGHT+IGrmWFgifO+FjIjJ/Afsy1CsWSCwx+B9TyNezP6DpyoporHsz6b5p1iLR/FBiECki2qVZ9p6g==
X-Received: by 2002:a5d:5d87:0:b0:3b7:89c2:464b with SMTP id
 ffacd0b85a97d-3b8f41595b5mr4893698f8f.5.1754566224108; 
 Thu, 07 Aug 2025 04:30:24 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm12240027f8f.19.2025.08.07.04.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 04:30:23 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 12:30:20 +0100
Subject: [PATCH] pinctrl: rzg2l: Variable may not have been assigned to
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_renesas-v1-1-055ace62c1dc@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEuOlGgC/x2NUQrCMBAFr1L220BSFYNXEZFNfLULupbdIkLp3
 U39HIZhFnKYwOncLWT4iMtbG6RdR3VkfSDIvTH1sT/GHE9hEq2zPW8GhbOHcsg5ZQwxlT21qrA
 jFGOt49a92GfYJibDIN//6nJd1x+f3AK+egAAAA==
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul@pbarker.dev>, Tom Rini <trini@konsulko.com>
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

In rzg2l_pinconf_set and rzg2l_get_pin_muxing if the call to
rzg2l_selector_decode fails then the variable pin may not have been
assigned to. Remove the use of pin from the error message.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pinctrl/renesas/rzg2l-pfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
index 3c751e9473a..3bdba5e365c 100644
--- a/drivers/pinctrl/renesas/rzg2l-pfc.c
+++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
@@ -353,7 +353,7 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		/* The pin selector refers to a multiplexed pin */
 		int port = rzg2l_selector_decode(data, pin_selector, &pin);
 		if (port < 0) {
-			dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
+			dev_err(dev, "Invalid pin selector %u\n", port);
 			return port;
 		}
 
@@ -550,7 +550,7 @@ static int rzg2l_get_pin_muxing(struct udevice *dev, unsigned int selector,
 
 	port = rzg2l_selector_decode(data, selector, &pin);
 	if (port < 0) {
-		dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
+		dev_err(dev, "Invalid pin selector %u\n", port);
 		return port;
 	}
 

---
base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
change-id: 20250807-pinctrl_renesas-b48818ef01b3

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

