Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD670CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 21:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0622A83A24;
	Thu, 14 Aug 2025 23:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Z7YEQxxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E48083A1F; Thu, 14 Aug 2025 20:07:15 +0200 (CEST)
Received: from mail-yw1-x1163.google.com (mail-yw1-x1163.google.com
 [IPv6:2607:f8b0:4864:20::1163])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18608399C
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-yw1-x1163.google.com with SMTP id
 00721157ae682-71d6016a730so551167b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1755194832; x=1755799632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=c9jIJ/MvLWmm0WzzwU8hAy2H0VAppgsVqR318w5iBsM=;
 b=Z7YEQxxdNwCd/KzquCoX/lFXjlftfTNSg7ZE/nbC1V20UpqCjecqFy7N1sqoVTxATq
 vNtCIoOGHQ2OSPbCu+YIXkue4A1+kwE232OrQg20A6QrwTcT5ByEXN6ChEopFtusNJA2
 M58AVuRsO1qkvybg3rJC1bPg1hPdEIQ6FWyag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755194832; x=1755799632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c9jIJ/MvLWmm0WzzwU8hAy2H0VAppgsVqR318w5iBsM=;
 b=P0+Rhj1UBtjGo80n/DaeZ0RVo7OpHzn2+vKq+vZpR7M3JNpQAcNNvCodPM9Bcl+tLM
 uhtzPM6MY826o9U3v2Xoe9zcC16THaRN5ehCNI5vzEe8jwQuKc84BnJRh6UETQ4NgX0C
 UuCtfetCZ2O6HVR7IO7hSuUWIJpkkjS8n00tFtbllDcezkql5GCAKW8PCZVbLWcwVPGv
 b+HCoBoDEoxxYGODig9sx9ZWt+Cq/qFTVF7pWD58H3lw1+v4QXh9SFb+BsrvIR7tcQgl
 B0MyrwxqIhVINMuahBXGLwVt5sG+h+wVEC+7FuI6NSQN67+1534XXkcnieB2L4O9uP+8
 8jXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK2z8ZQVPWvrETRQN1Uwr54zrsV/a4k80q5YGt0OSAnUiMiyUCiFoC+9Y9owl5c5bY5bxKyyY=@lists.denx.de
X-Gm-Message-State: AOJu0YyLv09QHRi31VzVq/cBrjQjYTeagYG9ruuh2S4BVPRRswaOVQyA
 q88W6qp3Ow1SBkq302icUXP6W5Vvx6i9T2eJykHYEVDCB0Llsoudr801Ah0tIDTt+SRgoG/dhkk
 GlMmzPesfivY8yWuuCoFsApb3FUntP+Zi7A==
X-Gm-Gg: ASbGncuXALkNkeGUAQlBjIdiNfbxRyFzGzzVuh5UOg+eBasj+c/GAsTGCe4Lm8rgDGR
 ulXXPWsq8xl4rFuy1Alb618/xrv/6hGVGFW0y1w91TTvlbYyQiTNISN1w3aM+SuWy9RX+vE1Yo7
 rAjhb1oYMksPDLIC30tuXEpwE+VGpTEkmgwPV5wLbgz4IFBweotC5b1ZMbgjgzmyTxZ4iwn8wbG
 6jtqtxL9mbsafUT4e4uyMEbhn+tipfVAYmFGrYbRXEhM8an3q6f1aJYd7snYtNokkATK2bBHRDG
 0olzM/lQnS4n+3+ctGz8fgu/2MP8mrneJ1p2UDVETlo2rkPRu226cy3cSSerky6BavAYnRgbUQC
 cGl0O4w3IfK26vg==
X-Google-Smtp-Source: AGHT+IGp9NM6QpAS+H/TD593kKa55Qw+82fTUEH+C0FhktDzSxBVOLARHKV7BcoyRlw4jRrSXR1DF8dC4A8y
X-Received: by 2002:a05:690c:490c:b0:71a:20b7:451a with SMTP id
 00721157ae682-71d635b48b1mr27856747b3.4.1755194831728; 
 Thu, 14 Aug 2025 11:07:11 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-71d60d6b387sm1970937b3.5.2025.08.14.11.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:07:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: dregan@broadcom.com, dregan@mail.com,
 Quentin Schulz <quentin.schulz@cherry.de>,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH v2 0/4] cmd: nand: various updates
Date: Thu, 14 Aug 2025 11:04:54 -0700
Message-ID: <20250814180647.1805196-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Aug 2025 23:00:20 +0200
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

Bug fix of name changed OOB placement option
Change ambiguous 'count' to 'pages' for read/write raw
nand dump display update to show ASCII characters and data offset
  into NAND
Add option to nand dump with ECC corrected data
---
 v2: applied MTD_OOB_AUTO to MTD_OPS_AUTO_OOB fix to env/nand.c
     per Quentin request & added Fixes tag

david regan (4):
  cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
  cmd: nand: more descriptive help info
  cmd: nand: nand dump display update
  cmd: nand: nand dump with ecc option

 cmd/nand.c | 56 +++++++++++++++++++++++++++---------------------------
 env/nand.c |  2 +-
 2 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.43.5

