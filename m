Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BD2C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 10:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29788835D4;
	Thu, 31 Jul 2025 12:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cfDcIHry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC6BA83816; Thu, 31 Jul 2025 12:51:24 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431EC836A7
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 12:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so2277085e9.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753959082; x=1754563882; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a7wuWqin4rIXDmJj0ovd0CKvqDr0s83QoI3bvZRTErU=;
 b=cfDcIHryB+qI7ARXX3yHbvAvP0RGAV65+WmVTe7WDxcVKGV2kS+3CWtlDx7SyJV+Gz
 weHYeQWkH1Sh6xUmksfWDle3TNTVTo6xpWQ5eBoAxRuyvgyVUSTQ3KKnFkT6hLb+6wtp
 om75bATUhTFMZDXcFQgJO/hGYbZyURxw669OfZfWx8pftqIjyJjOD2ouZmtxhUpfOZCu
 I9JXb3bL1N21rtPsgVedIYFxC48rj+gHsOD7VVEt4EVBq1pN1Pp90neBXMJfZgTswbK0
 hPAOI/xQkRfL5NtW5U/RruZEy37jGQm/k0rXeKwRe6G5HuyJcPY02PF3dnUqBwI9aKm4
 p/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753959082; x=1754563882;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a7wuWqin4rIXDmJj0ovd0CKvqDr0s83QoI3bvZRTErU=;
 b=KzBa/8ug4+lh+tlyA8g6dsyceHBl9XDygHgjML5szL1cgNJ9Hkwk7k0FbiF5mrtOcp
 pEzXS6ZjV6Qbe6JhHSZ2nSc5liO5m52iQjTaaYv1gOlt9fZMolMNF1c9ydOd/vJaHYRb
 8lk98nmQXuxgniLPx0814htD0brj1Wx9uV86dibH5Wun98inx9REnQHLkGh4oxowxnMs
 4lZIO3wf8lLKoBt85Bm37X2OMEUNQIb5TF1zofiQUFi5WIMFRMQSb7fy0uWRu2kALRRE
 Un6nhv229XHiwdWCWtxK1xbSX2QRHnc+aOJpRICJKBH1R0TBrqryeuxo5yNEMyJMdUE4
 xCbA==
X-Gm-Message-State: AOJu0YxdPfKW1XKJeHaDltbpqJASalK/c/D7nnV5ZyV7OeWGnQJs2KWU
 DzxUaR5eb5dMeqN6yp7WM46oaDkLNZj/4yZ7RxU/UVQjfIw16wR6lRnydi8NYq3NOsg=
X-Gm-Gg: ASbGncskl1mkMOUKT1yP8qPQqUAIWj0miOAo6fDULaPHA1mKTB7KqAZetbJCttkzM0v
 sS+H1xL88i+Mi6Cri2r0z1chdI91UJpE5GnW3ogb11pInfmYwb6b+zJVFgwow1IvO/y5cPo6YY+
 TslTisZ6czJ+CJiFBLRSP8q2QhaBDLLff829zP9wfIZJWd2Y+IG/19MkciOkAIjI17byQxEX0vB
 HdbQZ/vJaJrPMIXs+uxRtowRRL9Z/1QoxPTUFusJxL9qi3w436wgtFmoF72wzSugOO/dKq386Zf
 28eOKfuWen4F+jsycWPc9jGGVWI0GMaRnCPZkN8WlEWqWEa/n1bv2ERNL+MEQwc/B1Ks2/cKKc4
 235w/6oshStzfgTwgWlgJKoh7T0xn/DPRrRZcAxo2YkIjQ4YKjQ==
X-Google-Smtp-Source: AGHT+IGXNHBy+H0zHiQS2CGGE59ddnAGtcjHP4MftXE3OrugWa50DpMNEVsxjZbSuLLZ3E9NYEjjrQ==
X-Received: by 2002:a05:600c:3e8f:b0:456:201a:99f with SMTP id
 5b1f17b1804b1-45892bc022bmr65833665e9.18.1753959081709; 
 Thu, 31 Jul 2025 03:51:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:14a5:dbc6:afe:7138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45895377708sm58900755e9.8.2025.07.31.03.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 03:51:21 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] mmc: octeontx_hsmmc: Fix two Smatch issues
Date: Thu, 31 Jul 2025 11:51:20 +0100
Message-Id: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKhKi2gC/x2NQQrDIBAAvxL2XEFTpLRfKaXouql7UMuuhEDI3
 2t6HIZhdlASJoXHtIPQysqtDnCXCTCH+iHDaTDMdvb2dnWmYadW+/bOWgoa8hjTcrfexQQjikH
 JRAkV85mVoJ3kFF+hhbf/6fk6jh+IqLSBeQAAAA==
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
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

Smatch reported two issues. Firstly that an expression probably needed
parenthesis to be correctly interpreted. Secondly that two unsigned
fields in a struct were both being tested for being less than 0.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      mmc: octeontx_hsmmc: Need parens in expression
      mmc: octeontx_hsmmc: Remove impossible test

 drivers/mmc/octeontx_hsmmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
---
base-commit: a8f20bb6650df56d2600cda2c66f9349df9e49c8
change-id: 20250731-octeontx_hsmmc-e5cbdf9051bd

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

