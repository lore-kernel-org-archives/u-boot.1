Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0EDCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA86186D62;
	Fri, 13 Oct 2023 18:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rw+j+60V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D285686EA8; Fri, 13 Oct 2023 18:55:22 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B0786B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7ab31fb8bso27036217b3.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697216117; x=1697820917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vj2E5KnB4XrNxJfUQ2iCqfDbq5GxjdrnUFy01eQDaJQ=;
 b=rw+j+60VtJQ+EOHKSLH7svxbloJFxz5jqiFXPkJP1Vlnuqr+E+9oebxjRSut4+29R3
 khUesZSmbo8SXhlGjM4O8IHU/XSbZbimUmMv07g2qVA7s8h9fYQlsYOAJtm/Ezvbh2Lh
 a4pLwBW8nl+AV20d1tM2syRWHHN7F7A9tLVEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216117; x=1697820917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vj2E5KnB4XrNxJfUQ2iCqfDbq5GxjdrnUFy01eQDaJQ=;
 b=K3Fz3c1bFs5bq4XcSuTPV15EiKgwGCM9Y/UIoSdkrzgZUu4tFkOgTXmlxUwHc4vnM+
 nEH/Y8miufqMzGt7zeP4bRVZAjmMHxq0R0XB3a7Ub7gXH+oQrIP1cgUBwdVd9JrCawdh
 zKRcB5lPFODvQ3glZNH/j3JwgnDmkK8U4OcJ8089tpUJZlYr9J0DHTXTyr8H004zwVf1
 LdFc9g4fWSK29hRX+XOSIrBI2fJW5jqd36U7XuUfADJ4gbzbl+L/2meZvijnNawreScq
 wdBgqW5pAKZ0Rgl5fOjGy42kklhbp7fBxZ+JwGfOZn7dxSmSWbPyfPqbx0ZIIudzqwMv
 QYvg==
X-Gm-Message-State: AOJu0YyJvHIhS8SyZHDta/kYnHIeFRkhBcjHy5RrG7FPd474W9i0WyJs
 s4F7hZzhvQ9szpEgg8T+VXB/Oeqom4Qa/Pl1RgD2Dw==
X-Google-Smtp-Source: AGHT+IFnQzgy8jnTLG8ZAAe4Set30Ssp94Ue03gissVUGqLZqwo673ocd5MdLGBV7g93Gc60xnBxIg==
X-Received: by 2002:a25:ac5f:0:b0:d9a:c4cf:a06a with SMTP id
 r31-20020a25ac5f000000b00d9ac4cfa06amr5646117ybd.36.1697216117097; 
 Fri, 13 Oct 2023 09:55:17 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-b33e-4d05-2330-607e.res6.spectrum.com.
 [2603:6081:7b00:6400:b33e:4d05:2330:607e])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a0562140b2c00b0065b21f1b687sm804007qvj.80.2023.10.13.09.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:55:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Udit Agarwal <udit.agarwal@nxp.com>
Subject: [PATCH] ls1088a: Move maintainership over to Udit Agarwal
Date: Fri, 13 Oct 2023 12:55:15 -0400
Message-Id: <20231013165515.3257221-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

As Ashish Kumar's email address is no longer valid, move these platforms
over to Udit as they are the maintainer for some of the other similar
platforms already.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Udit Agarwal <udit.agarwal@nxp.com>
---
 board/freescale/ls1088a/MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/freescale/ls1088a/MAINTAINERS b/board/freescale/ls1088a/MAINTAINERS
index 95a14149e4fb..1707ce9ca02b 100644
--- a/board/freescale/ls1088a/MAINTAINERS
+++ b/board/freescale/ls1088a/MAINTAINERS
@@ -1,5 +1,5 @@
 LS1088ARDB BOARD
-M:	Ashish Kumar <Ashish.Kumar@nxp.com>
+M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
 F:	board/freescale/ls1088a/
 F:	include/configs/ls1088ardb.h
@@ -9,7 +9,7 @@ F:	configs/ls1088ardb_tfa_defconfig
 F:	configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
 
 LS1088AQDS BOARD
-M:	Ashish Kumar <Ashish.Kumar@nxp.com>
+M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
 F:	board/freescale/ls1088a/
 F:	include/configs/ls1088aqds.h
-- 
2.34.1

