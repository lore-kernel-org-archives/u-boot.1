Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C799CFC299
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF02483A47;
	Fri, 21 Nov 2025 18:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aJilL5If";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A92E83A5E; Fri, 21 Nov 2025 18:34:36 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF7C839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so24474455e9.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763746473; x=1764351273; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=04neC7cu5NUF6hK60yYsmAIXoLrJTCjFdD08XEEfi5A=;
 b=aJilL5If0BGPnhgjDX1E3nqqgWcvADfqvXiBVbuAdRWaSU6jCgwrS+nM754HlODEph
 LF3ShRtobHW5hgyFP3eIx//xu2L3VBFmsI/teBMe95YhDTBjoGn45gpuhRt6bWRpLMDN
 cPwL9Ykk4jOeFMFVbjOAjOgnTPL3qkRVKzsY8gppM338ZIAnCSCyaxYQI3DCUoq2M4sn
 LCldi1lH063ll37Ab7quJxOlF1ER21LWhzOslJbfP7OF6m7VCi6nNMVdBoRYmuNh4NUU
 HqWCEfLtPEecvljUHqEU1gCsP3eYrS5MDBdLf5OxFDkUsz7sOke8EE8UG5Axgu29BJ3E
 lLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763746473; x=1764351273;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04neC7cu5NUF6hK60yYsmAIXoLrJTCjFdD08XEEfi5A=;
 b=WoaHoPj01uGQRiqdh92TNP8QLl/W384s5kBlFhjGSX0pbr/eoiMl/ZfHDdl7FOqt9k
 Yr2gchFns9hvsxYkiaComJaARuFLZI3c4p0lQfqc7medj4YBoKkN6yM2U6qOWa+UIekB
 6PwS6ixan27XvGHa1aBVn1RPd/4/ugP9zV5I3sz0wmL+5FPOeHPf6b8nEWMS6DLf3J4p
 GueL45RFp0+sNu9pmZCUI60qnjQBp+pwivtknpe5soeuD0BLfp20TW+rHZBTdROx4hpr
 Ixorn56Bs8UlJXrUBDgjZoCHYT8e9TyCx0+PHx0iv4a36pxeh2Z+ynnzvmMH3Cr1PjAi
 CKAQ==
X-Gm-Message-State: AOJu0YyGyqdlhWNnjt4+qAeGF183vsZ+fI4vJahXsKxEl5fCI0+pF/94
 rwa8X5p80HMXVZNbMWlP7cg+7HqPw7O/gCIvMC+IXn6vHvDVMEabROFwkLVJARxNHDY=
X-Gm-Gg: ASbGncsNV0jOP867xdm6BYjOqL3Dc4gLLa3t82YTJGcjLzUgCTtRjpNCExPhPbtCIeR
 pnc16HfB0CYRDmFN32faNqpigT4hxvOad4S2g8HX7Zt6i8MrjGwfb3hKXiAZ75n6fGwZXZYPJSZ
 7Yd+VIhFMkJyZeuA23GamM9a3G6TdCxM25+CsdKkg/EyZjBynY+xdkqFKOlBfNdCqD5JPaJHgw+
 SLKJ/dN4aX2KutfphyfyegdBUrSZ1EkH/SeIl9yuIrTO9GJLEjjHMAMMzNpEn6pbm3LDdhpuMXP
 zCCGo9lUpjqRXm8YgeWCMvjMDWmJVsBoGbWD8R6bLXPyj9+0G6UIyDn2pXUMktgtXBKA1NOS+yN
 O3VbCP2d8fZeyiBe5/fQFooNzcrsKuHnPwd3c8SFzc6bCOaNLggzLGfR/H9B6WidlLE3KpeVoou
 i+yhySJFhfh0WAiUA5itgRMAZMWZfQ6LruNT5zHa8=
X-Google-Smtp-Source: AGHT+IFtDrhPdTik2KI+MIf8pC12LijgmxsBMYqH2iN7FAfoCnHv+2Z55oj2KCQB+o9P1AFkh93pQQ==
X-Received: by 2002:a05:600c:19ca:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-477c1143073mr26303805e9.22.1763746473570; 
 Fri, 21 Nov 2025 09:34:33 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:2c01:4a49:22af:8b98:6c9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e1b657sm87078365e9.17.2025.11.21.09.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:34:33 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Date: Fri, 21 Nov 2025 17:34:30 +0000
Message-Id: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKaiIGkC/3WNTQ6CMBBGr0K6tqatgODKexhC2nGARmzNDBIN4
 e4W9i7f95O3CEbyyOKSLYJw9uxjSGAOmYDBhh6lvycWRplCndVJwvho3zBa5rbzH4m2K/PKGXS
 uEOnkLKN0ZAMM2+1peULaihdh2u+mW5N48DxF+u7iWW/pX8espZa1KwEqDXVeq+vog6V4jNSLZ
 l3XH0ZIEMfGAAAA
X-Change-ID: 20250703-clk_uclass_fix-eaf648b2ebb5
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Smatch reported an error where a value calculated by ERR_PTR was not
used. Fixing this to return the generated value led to a test failure
which meant updating the sandbox clock code so that it would still cause
the tests to pass with the above correction.
Debugging this problem led to a SIGSEGV which is addressed in 1/3.
Possible memory leaks noticed are addressed in 3/3.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Added 1/3 to prevent SIGSEGV on debug statement
- Added code to original patch now 2/3 to fixup sandbox code that is
  needed to keep tests passing with fixed code
- Added 3/3 to prevent memory leaks on error
- Link to v1: https://lore.kernel.org/r/20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org

---
Andrew Goodbody (3):
      clk: Prevent SIGSEGV on debug
      clk: Return value calculated by ERR_PTR
      clk: Prevent memory leak on error

 arch/sandbox/include/asm/clk.h |  1 +
 drivers/clk/clk-uclass.c       | 10 +++++-----
 drivers/clk/clk_sandbox.c      | 17 +++++++++++++++++
 test/dm/clk.c                  |  5 +++--
 4 files changed, 26 insertions(+), 7 deletions(-)
---
base-commit: 2bc0715b558fa1ac5c88b11e250740b16a905837
change-id: 20250703-clk_uclass_fix-eaf648b2ebb5

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

