Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27522C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 15:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8632983F56;
	Mon,  4 Aug 2025 17:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J/AJCQwm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC27483F8A; Mon,  4 Aug 2025 17:11:41 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582A383E16
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 17:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-458bece40fcso10035115e9.3
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754320299; x=1754925099; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0tahjuYiNn6sHXDWr9z7Kow7X2bWhiuuJ0HupxW2Aoc=;
 b=J/AJCQwmAdA8oyN7CNcVL3hJ66yd3mcN7rdPpXnUwpWE+tAtT7f5Ul+orpBqLT0MCM
 vjMutoDPakYUqnZf3F5UqvvZqAQBRV2WOZoQfP0mRf9asH2sHxPltjef9qQunq+Kq8pB
 yKwN/dB8eAwQ2mO3bTf5pWBm8SslX6OStUKSY6luTG/ncbUIST63Bi4cQoO1ewx3LJ90
 XnEuVYWS220sfoDzsQAOCaoNgCBhTIvRLvNumEZcJD5KTDmyZJrDRnFUgtIiJ7uKbiEQ
 A5myV0PkPGx3nK3itaDyxHiP9ryZrm8PJQ+ox2zaZ+ZxOHscLNPKTLByQu0Y0ZHw+rtf
 tR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320299; x=1754925099;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0tahjuYiNn6sHXDWr9z7Kow7X2bWhiuuJ0HupxW2Aoc=;
 b=GROrdGMpYjYQa7l7d7jxyi4oBqsGyQy5Kya/MGPxFLkTrLF5G9O0MWlb1VIwCftA5Z
 Og/2xom03ST7UDgHZB2JaJzVhCoqpgqWCIjo77D1gvjHnIG1BoStU/TK1dzgOKO5o+BY
 cBIyd4DcuNMcynGoI0VztKIvfNIIij/+hbK4+aWohx4ND01EPYfGGC1K82mTF5hOG9ng
 deWXbxHPGU1KAPn7Z2vRApsl/QO71mGGQtHiyzWezul8OG47OL9nmVcBP7hlrLzc8dGW
 jSVtD4SfBsY1nZzyDMsZGt5e7cENG9RhsW6JAUnrn6gNV2PH4Y3St5H2JmjeTq9PoSZm
 JcbA==
X-Gm-Message-State: AOJu0YxQYsV2AO4UnV5tQp7Iw3+7WypocBc7jWhfEp3X0due8CcsOSXw
 ArVr4aNCr3PLzW7zgUgCe8QzsH43OF/pe/lphpjeksT6mXuKus7VCR00Dq7TgFUjCW4=
X-Gm-Gg: ASbGnctuunnQwomCKPMFVpIN2xmpKwK0CUBLMPU5lxI1bzNWKbUVrTwOYL7DHPHMwBB
 3tFiTo/j0TtblvTLdYlsWOj0moHfYjlhlDrpSAyA3Sci+40H+Jzj2yywVQklSzz9gxT0BMK8U31
 B/4Zf1Y7sDdsikR1GMEZrAfrFeXyCVaCPPAi0QL/DkCJiFUiQIHeaceuYfUKFy4mprP7V1VV0xO
 xXLZI+xEc82/3CQ7+y9YjwacHHdG+CDdZ7evylUV0Ry54tTaIrnvvqvRU9r62Bpsh8MxQhlZKD/
 WXNJ9r8IGZ3g/baikYvA1PEx7hysqnu3h9GJumyAGtTJZuhYoXp3HVD3GC8bOXqnHJrkNnLFn/X
 8Na8WWjcDTbH3XR84ZVNQRr0AngBldYmwii2Pbv3hBGyyDnvQnzQ=
X-Google-Smtp-Source: AGHT+IFBlMol9pJoMJchaC362vt1h67sjMybNxcx48lDr6fVq6CBHuODY+l4rX6jaNmeohBCb69q8Q==
X-Received: by 2002:a05:600c:3145:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-458b69dd37bmr80360625e9.10.1754320298673; 
 Mon, 04 Aug 2025 08:11:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b866392csm63586455e9.2.2025.08.04.08.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:11:38 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] net: dwc_eth_xgmac: Fix two Smatch reports
Date: Mon, 04 Aug 2025 16:11:36 +0100
Message-Id: <20250804-dwc_eth-v1-0-d2a652a69fcd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKjNkGgC/x2NzQrCMBAGX6Xs2UBMrVRfRYrk52uzB6PsllYof
 XdTj8MMzEYKYSjdm40ECyu/S4XzqaGYfZlgOFUmZ11ne3sxaY1PzNm4a5duIcW2HUG1Dl5hgvg
 S89G/vM6QQ3wEI3//i8ew7z8DzuR2cgAAAA==
To: Joe Hershberger <joe.hershberger@ni.com>, 
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

Smatch reported two issues with this driver. Firstly a direct return
instead of using an unwind goto and secondly a test for a condition
guaranteed to be true by an earlier test.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      net: dwc_eth_xgmac: Use unwind goto on error
      net: dwc_eth_xgmac_socfpga: Remove always true test

 drivers/net/dwc_eth_xgmac.c         | 2 +-
 drivers/net/dwc_eth_xgmac_socfpga.c | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)
---
base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
change-id: 20250804-dwc_eth-265d9bdc33fe

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

