Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C57FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 18:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3D0849B8;
	Tue,  5 May 2026 20:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hhsAu1ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA6884974; Tue,  5 May 2026 20:13:13 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2912B84974
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 20:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479ef2b78f3so4238410b6e.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778004789; x=1778609589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+chlawyNOKDkuKVi+L6UcxpgMdEmabY4VlirHWm1qmA=;
 b=hhsAu1eybx5zxu4eJKlHTagTLXFmYXERrDYo96iQSTI9o8eGWtxCf8kZnhc07zedM9
 BSYpqIwklhjZT2f/KHfJYtgZaHgNXYwyn8GkGfPSh/PjIyhoZIH7SP8QD2Uj2LEOV4n5
 S5Uo1bCxvdtqol0ITkC2ku4w1C77/Js2o4aZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778004789; x=1778609589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+chlawyNOKDkuKVi+L6UcxpgMdEmabY4VlirHWm1qmA=;
 b=m0AVFDyTTpudK790r8SmENyRFcZXRNA8RSXZguZRNJPp0IGDpacgPKOOU9SlWPOr42
 Fo5xE8exQ+3OrEA6HSUovIeb7Iyy1870eRYxkFQA9+t14x8Bla0fhNNcROtvuIBtDAuG
 3O9DlUVhcK2I49zQv8x5t7xInteQq/TbpT40d5qkP26PTbM8rUzrfykpsMcNEej5xL5R
 kNg9kFc2KPNC4NXcGlS72YbIu+0xzpQUHwDcdo2fmasGdJp92bY4az+uzwqlPpuSMlqe
 mj0jp5TZNBo+19Izo5iq2xAlYMbE0ewn1ZTgVydE5t8cvwdmPsPcEDDNmTKk41cN3XV7
 qJWQ==
X-Gm-Message-State: AOJu0Yy8o3qRUnt3JDC/CYEoT5cNBbjmrOu2PFVltiWEBvTkq2fHdL3F
 RgF0e4Q00qf3zbE9WMPq23ie3R63uYjRt4Oju/FPaKBRqs4YR+iiHrSrJa1UXwqDDlrmbf6MOz5
 FIVIPZg==
X-Gm-Gg: AeBDietfR8usONPjdTZNEnGJaUTBJ2xWAZTNbzf1mjdcEM7pEJgniW54sJBXN9rEDpQ
 mjMGhlzcbVDjwqeMLZxHghBCcVAZFfTmirh3qn3dn0S93jqcFZZW30GftHditZ8277YuhY63L3M
 ggOJNc4vv4iOi3m55uqhRrjkJ4u/o1J2vNr/UIktPj/p7yVuMLyDKY1HM0AvLAwE63FeNLRfJk1
 uV6rSe8fNBI5dswCRaIKXOl0w4+BTtcIdsZwAl8yTBwQRoC7C07e4qvMGG11/Zx1G/DGT7jyhhb
 j1g/WTY2dg3JFXgRjx0MEnXF6hz/Pw5HLP1VsNySYVD3BulO0w8i8s6bbNRR0iL3Z3rkRXv24Fs
 7ZpWmR8Frd5E+Pu7BB+58xmgx/uiLcTFyObE5ESz19//vDlBebhqRj8AcZlAd9i2i6+g84Il1ME
 JwthuiOw0DhK/AAefKD2rRkSPdLtUo
X-Received: by 2002:a05:6808:e642:b0:479:874b:15a3 with SMTP id
 5614622812f47-480424d5a14mr63014b6e.43.1778004788729; 
 Tue, 05 May 2026 11:13:08 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434549540b2sm14585754fac.6.2026.05.05.11.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:13:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/4] binman: Tidy up some missing bintool docs
Date: Tue,  5 May 2026 12:12:51 -0600
Message-ID: <20260505181300.223439-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some of the bintools are missing documentation. This series adds the
missing pieces to bring things up to scratch.

Changes in v2:
- Add patch to route PKCS#11 test fixtures through the bintools
- New patch in v2 (per Quentin's review): replace tools.run() of
  softhsm2-util, pkcs11-tool and p11-kit in ftest.py with the
  Bintool.run_cmd() wrapper that already exists
- Reword the docstring per Quentin's review: binman uses this bintool
  only as an availability check, not for runtime PKCS#11 operations

Simon Glass (4):
  binman: Flesh out the p11-kit bintool docstring
  binman: Flesh out the pkcs11-tool bintool docstring
  binman: Flesh out the softhsm2-util bintool docstring
  binman: Use bintool wrappers for PKCS#11 tools in tests

 tools/binman/btool/p11_kit.py       | 11 ++++++-
 tools/binman/btool/pkcs11_tool.py   | 11 ++++++-
 tools/binman/btool/softhsm2_util.py | 12 +++++++-
 tools/binman/ftest.py               | 46 ++++++++++++++---------------
 4 files changed, 54 insertions(+), 26 deletions(-)

---
base-commit: 57460fde4ba84d67de4066ee1141e89e8139ed23
branch: binj-us2

-- 
2.43.0

