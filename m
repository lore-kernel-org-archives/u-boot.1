Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336E2CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 09:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B150E83A56;
	Wed,  8 Oct 2025 11:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A6BPK6kX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6624A83D0F; Wed,  8 Oct 2025 11:23:40 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4545A8393D
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 11:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so3712235e9.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759915418; x=1760520218; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kdj4hxLMn5B8HnzTWtoPw2rKNVRA391CZ5ug9szkLGw=;
 b=A6BPK6kXNqqKMeK3cSpsGx+fPgo8lfEJfQ+hx8or6H41u0wblIICV0snnIORQ5s2ho
 jJdYQRl7VwIb2YYlD7Vn0IvoqxTSzZR3VCQnqN9hdqp5m8GOovx+LOT7FFhIxDMLIdQw
 XRVLCDEsDkIfOJcuh6eW12zRCNknyUXi91TIKjtYDdvKjl6QhvHx+AC0P9ozsJAaVD/u
 ydUtwwzZupm/kd/GbUbUHLsNwmNnWpGBtV/PujptqNzsNdmNHeOTXH6naDMt3Y1R4b17
 RtKCCe7iMoc6neY4FjxJB4ldG6fQcdwhWObuqGh9y743aG+8iOD9uhkInN/w5MNWbahW
 ZJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759915418; x=1760520218;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kdj4hxLMn5B8HnzTWtoPw2rKNVRA391CZ5ug9szkLGw=;
 b=HQM4Pxbwml+xw7PyelstN8OI9MIu/XK9jcyWovfhYneGh06r5JhSTvewAeT00N3GX3
 SbaJ02dSssXvXzpLTTn/vy3yIpt+4eRA484+niKiW+uDyWsCeQyj5CEgWJUXjQZyGHUr
 jqrTwEofndKTprfcLtF+c3V+uXfUCSzJyUNDTO0CLJvIfNv+i+3SNJtB5fH6fw/8biWd
 ae14WAEE+PZPvIlc7nzCPgSxpsvUCyfyRTZXaHNnfXmnPZ3yeBOSKAzZVV8vqqOMfWjm
 8oVrgxAxe80uGJd1nklLQU7iZeKpBH6v/gV4Ichv6+D0CiiVLtz4naj/b8lF7e4Fsrmm
 DG5A==
X-Gm-Message-State: AOJu0Yw4FIP032yh08/wxUOlfe4s+ayCjZx+nS36x1harv5tuWZE51wA
 qp/O5/h9jZBh0KtZ86U3RoZS2Rgp8mnwiCx1PB6lifgGTQ6pOeBy3bFwdWTF6ULZz9g=
X-Gm-Gg: ASbGncvUklPMkOxvo1t7s3XG0qx8CsQnwWsrkeqPKucrgwhkORfH8oPDlo2EhAAzU3V
 FQd0ggBSlbhIkpgt1sCPSF8CiXe1SR/vdRA2nPN6St0/C6P5tNJiGm95ODhMw/bKX6yTT8xgM0I
 xqigyp94hpMJTDFJLo+VYhMIhWpxJM4EWaVGZWdsYsYjoRh+Bytgr3u92VI0Oo1+XT+LG/BjRgh
 OHL4izakBxOV+fVa0e4DJJvsYqKwqyKcTw/iSESpZanpn+ocldaUxDybSlxpm/yAXcZgQlguKqj
 UMm6erFzkAUMYB5RMeFYrLKifiXEZUP6fNGoD7e77aVHvAPRIdbWfIsePXTQ8aSQBWtNTb6Kg3g
 vl7/d4nmTAqBDaZGvmFTHDC/CI9AInwEcImvxbsejU92Hz+x6EJg7mqv8Ti2xap/sWRxT1Zf3TB
 2Ut6KAs5jMGcZ0Kg==
X-Google-Smtp-Source: AGHT+IFA2i9tWHePW5xUoRAbUlBsxUyWENIXUQp0eeJB01qB181khzj8gxI6HqkSM9cjcPnJKXXehA==
X-Received: by 2002:a05:600c:674a:b0:45c:b6d3:a11d with SMTP id
 5b1f17b1804b1-46fa9e8dc8bmr19389305e9.1.1759915417734; 
 Wed, 08 Oct 2025 02:23:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:5f9f:be0f:fb04:8dc4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm28864715f8f.34.2025.10.08.02.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 02:23:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v3 0/3] ti_sci: Address some issues found by Smatch
Date: Wed, 08 Oct 2025 10:23:34 +0100
Message-Id: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJYt5mgC/1WNywrCMBBFf6VkbSQZSUNd+R8ikse0HdBUkhKU0
 n83KSi6PDP33LuwhJEwsWOzsIiZEk2hwGHXMDeaMCAnX5iBACU0KD7TNTni2jqlnBXOW8NK2Jq
 E3EYT3Fjjd5NmjPXxiNjTc1s4XwqPlOYpvrbBLOt165ZCtJ/uLLngncO+A5QCwJ9uFEyc9lMcW
 O3I8OvprwfF06qVXqMR2sKft67rG8q+zdzuAAAA
X-Change-ID: 20250725-ti_sci-7bc55cb0cdba
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Prevent a memory leak from a non-freed malloc.
Return an error code on an error path.
Assign a value to a pointer before it is dereferenced.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v3:
- Pick up review tags
- Change dev_dbg call to dev_err to be consistent with surrounding code
  in 2/3
- Update subject line of 3/3 to be more explicit
- Link to v2: https://lore.kernel.org/r/20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org

Changes in v2:
- Add cast when assigning to resp
- Replace malloc with devm_kmalloc
- Link to v1: https://lore.kernel.org/r/20251006-ti_sci-v1-0-9cef92e1022d@linaro.org

---
Andrew Goodbody (3):
      ti_sci: Prevent memory leak
      ti_sci: Provide error code on error exit
      ti_sci: Pointer is never assigned to valid value

 drivers/firmware/ti_sci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)
---
base-commit: c280c4f7e52f08255f491783b3143a3be1fc08b0
change-id: 20250725-ti_sci-7bc55cb0cdba

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

