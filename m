Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDFDC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 09:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E3B83A15;
	Fri,  1 Aug 2025 11:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TiN2B9m3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE0883A15; Fri,  1 Aug 2025 11:54:08 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCDA839F1
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 11:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so805733f8f.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754042045; x=1754646845; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sRQoKJvjuN0GwEqkVMrSejIaXN4FAr6c7m6VgHUBCuA=;
 b=TiN2B9m3YDMsRdbp2sjLrJGq7ZIiLEKfJmbAlv63rwn5gi0yp0bfLzc91m1/CcOlev
 6lG8oso+ClT7Y1eQuol005REiHWnqxhTFUhPTtXnglEe0p8RGJ3oHAzpcmlj8C+0xP6J
 AgNSIzAipF3Jyy0yyaLGMwgNhv2XUmYGNDJ7C2aWcM4HXPD7DucmL+oUy3tiqu1p5veR
 OC5k13vqD3JIIuUCwfPIG9oN/6RFluOKZ2bvZjjyxoC4TGLFQvuNTGvo0YXrvCVJx+Cd
 4j8UCLOxJobTY4kEKIsZQqf+T+28x26MdV7ycXiZ17+bzwN0Z+XWsJb/TZQx0gKiRZvN
 vbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754042045; x=1754646845;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sRQoKJvjuN0GwEqkVMrSejIaXN4FAr6c7m6VgHUBCuA=;
 b=kEVsKUAnq7eo7CYzSFxwTPb3mKEseRJ1LLtJnaEiEUF2Eg1LBEAJpDOHqJ27wa8MO6
 IF3vvi2cEANZZEkur2XYSXJmQq3aKBSlRKt6ZUfIa1N2scSWtoNPQDVk0z6pzpnVcRUY
 wd/SMonN5EuZ0BXf3pufpNGA0dxwiJFeKloz+nh+B1WrTymECejmaRs5Wokta+CzHD3w
 pquKERlreyq0k2uaXpAJn4Ha4Eo2ghp90CMgxM6Gll/TezVwoEC9Fz0z7MI5yCkYRGuK
 NBQ1GJp1Zays82R3WMDewwopZ6ZkXa6ktmyd+ahr5kk58RXMuFmJcJVmz5IIZwt+kvKv
 0vcA==
X-Gm-Message-State: AOJu0Yw3UQ/OZQW1IrvYYEpMf3z2X+nOwChDct92ozGwWuVf2TGbuZ4V
 RJ/DyYFQ2GmQbvGwipkgp/13r3bQ245yQtoe70LYZe38e2xIpKtsB59we7o0nbfYY9Dl2+KAs39
 dowvs
X-Gm-Gg: ASbGnctGT6SbiHzzOUCcqCAlpZxagVn7/31OyL3HOVOxQcvAhTY2AVS5RrpOpny9Etc
 dTMy4aRITYk1tvgtlsHEiMkLVhKzTlRHKGdtNbGZaOYS8HO52SWaNEJtwVNXNL6FO9P0CYEjuu1
 o5sVb0hKuuLsK5fqQ3XjM4jlOWsrzZzdb+k1+LHznD0ajMbEfTu94UuOJd7hyYDb3ZC4nXzq8LR
 6YFq6WADDz5dk6nEXbjazkarHXwVE4OZqQ/mtpLL3HEQbr7OsWN+86H0vxrixakpK5B8mZfdx3E
 IPLTB0XVVWnrZz8pOSdGoI0vegUMG6Jmnk5vGEZT9KZDFcnZJqfCpTBGYJWmBQtU3zi2uLF9eRg
 qs9TL5COAzqzfoQZQ6NjLtqXYkbk/VAA3pQ8vhy3iQ0knDja7s+w=
X-Google-Smtp-Source: AGHT+IGRBWYm/5c4NrIdaGb/CsTq13CaAda7rukLZBmA+KBKavXgLYlxfxvNliZM8ysRcav+W4BxVw==
X-Received: by 2002:a05:6000:2889:b0:3b7:9d83:5104 with SMTP id
 ffacd0b85a97d-3b79d838459mr3840629f8f.51.1754042045399; 
 Fri, 01 Aug 2025 02:54:05 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eba17sm95280515e9.24.2025.08.01.02.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 02:54:04 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] mtd: rawnand: Fix some Smatch reported issues
Date: Fri, 01 Aug 2025 10:54:03 +0100
Message-Id: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALuOjGgC/x2NQQqDQAwAvyI5d2FVtth+pRSJJltzMC2J2IL4d
 9ceh2GYDZxN2OFebWC8istbC9SXCsYJ9cVBqDA0sUmxi3WYF+oVlXrDb+jomm45c6KWoCQDOof
 BUMfpjGb0he0UH+Msv//n8dz3Awk2LPV3AAAA
To: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
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

Smatch reported some issues with rawnand code.
Firstly detecting allocation failures for cortina.
Secondly an always true test for denali.
Lastly using goto an error path without setting the error code for
return for mxs_nand.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      mtd: rawnand: cortina_nand: Fix -ENOMEM detection
      mtd: rawnand: denali: Remove always true test
      mtd: rawnand: mxs_nand: Ensure err is set for error path

 drivers/mtd/nand/raw/cortina_nand.c | 11 +++++------
 drivers/mtd/nand/raw/denali.c       | 10 +++-------
 drivers/mtd/nand/raw/mxs_nand.c     |  6 ++++--
 3 files changed, 12 insertions(+), 15 deletions(-)
---
base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
change-id: 20250801-mtd_nand_raw-8d659ffe5d3d

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

