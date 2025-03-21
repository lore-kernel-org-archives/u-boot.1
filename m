Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF68AC36001
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 23:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEEA0809A4;
	Sat, 22 Mar 2025 00:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KSy+HYOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D57810FE; Sat, 22 Mar 2025 00:21:35 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE38806FC
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 00:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2F37E3FCCF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742599292;
 bh=MyELMPqZWXR1CrIQaIMutNUbRkDtiAi8rIEzWJ7TJUE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KSy+HYOZSRHHHVDMcYYpjI3Y126bMiE5NPpKThZ+XXDC7OWQbYjz1g5JoQeGAiw9B
 GI1rK7ZjlDLB2rokOEph2rxFtEIXzVnKyVlpUl4Szz5BSUdjvuL+WEv8lywE1z7q/v
 dSsgBB90uB6iuTUwWNEPZZ6sDMngoDEgHUTdvkhfThEXyAzxurtYBM/qmy5Ov319Nx
 scYCMx0ziPke2Mn1lgFtXUBCmfR0TRNpjFT/IXpANKyLbboQBuTAVrrjHmYSK8AsNs
 pMPnrANEYuH1oxtFNzczSsH7y/yex6OxUTzAjzTsXhYbbmUZY8NwKzXeR8QP9RYa4a
 R+YlyWaEX1P1A==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab397fff5a3so189785166b.1
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 16:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742599291; x=1743204091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MyELMPqZWXR1CrIQaIMutNUbRkDtiAi8rIEzWJ7TJUE=;
 b=vFYtJP5idHQ3+JGkEZN/+igR036LZ1bj3ckXCbK0a3PCHAMkKUeGJqHHuXe0gdTmMG
 1Sok6YRtmc3JMznjZEU1agzJeMnHCNfcv5pkH/h+KyHhYaPNuJc5VfLeRhauRovU1VqT
 Z9W5NnGDuFY1+ErWl7zTEV5Eh0JsavDd22YuzkuGdDWzs2brz8fSdpjCWcyXHFjuv1Rk
 Yz9xl0IA5sv4fuSVHankR3jdbQji8CKFgqGMuSP0C+XJ4IHAeLe992pmQVRMFBx1Hr7c
 i8LCg7skRA6WeP7v8uvubmB/Ogabvl/pwEi0p9x2kKumhGjNWZueQJVObTkYdNgFQD++
 hmwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw8yredmxZpYwxvASbId1MPunUsYXbN65XiW3pYUlZZdBolnbWJhgJN8NMhP8LkKord4hLRKE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz69BOneCAHmBdResOdwE3PCNwSc/lD1Z6rJl73UaaV0APL1do0
 8YUUh1qL+efRtiI7ICk7BvrQUDroN4Jt7jzRRt4cBg3o1LYsehqUjcexEv3rZJUDKr8ANSmsUjN
 uzNFufW/BWVtB+ErQzWdod+b17ubzYBIW3tLFeT1t4jzzv2BUizswmx3oyJQXrTQVIBE=
X-Gm-Gg: ASbGncvBm6/uO5KcZvLCJCooRzYXgvJWUQMDQPyD2z7eL/+ZgIvbCFqKc9FPkorPdJk
 l2c69wFZuxAdF4bmZBzZulEaINAr13Y1k2EMmWIrC4R5mDR8TS1GwwdornYknUhziqhJLjqC+aU
 RdNFo65qbQRm8mWPitBSspMxJysJYApvEanwV5psyZJnR/SbkUJuk1sd3Tb2g2NPO1CgPUmJ/uX
 A2Nhfsv/Y7bGTT1XNJGxHeJTmL16aZqHrLn4LiPnGkM+Kp68nXn30k948Jem699Kw0pwjsBjxjh
 lDaOq6WU4w/dsvbZwG7g3vuaFUa5fGr3DG3/RMT8llJcVCSL1judoEQhei4QCx4XcKpnL6rZUVr
 BI1NlpZjdOTTBNH1zoQ==
X-Received: by 2002:a17:906:d7cc:b0:ac2:b813:ac25 with SMTP id
 a640c23a62f3a-ac3cdbe1802mr946515766b.14.1742599291513; 
 Fri, 21 Mar 2025 16:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGDwBCVkvx7EhizPTnwMEPVYbNLMQgrhNJo22PA1k8wLehde77Eq/KtkAQKN5lANuA34LOdA==
X-Received: by 2002:a17:906:d7cc:b0:ac2:b813:ac25 with SMTP id
 a640c23a62f3a-ac3cdbe1802mr946512266b.14.1742599291012; 
 Fri, 21 Mar 2025 16:21:31 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd3aa21sm231673866b.158.2025.03.21.16.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 16:21:30 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/5] acpi: simplify updating ACPI table header checksum
Date: Sat, 22 Mar 2025 00:21:15 +0100
Message-ID: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Introduce a new function to update ACPI table headers.
This allows to simplify the existing code.

Heinrich Schuchardt (5):
  acpi: new function acpi_update_checksum()
  acpi: simplify updating header checksum
  x86/acpi: simplify updating header checksum
  qemu-sbsa: simplify updating ACPI table header checksum
  arm: simplify updating ACPI table header checksum

 arch/arm/mach-bcm283x/bcm2711_acpi.c |  4 ++--
 arch/x86/cpu/apollolake/hostbridge.c |  2 +-
 arch/x86/lib/acpi_nhlt.c             |  2 +-
 arch/x86/lib/acpi_table.c            | 11 ++++-------
 board/emulation/qemu-sbsa/acpi.c     |  4 ++--
 board/raspberrypi/rpi/rpi.c          |  2 +-
 include/acpi/acpi_table.h            |  7 +++++++
 lib/acpi/acpi.c                      |  7 +++++++
 lib/acpi/acpi_table.c                | 18 +++++++-----------
 lib/acpi/base.c                      |  6 ++----
 lib/acpi/csrt.c                      |  2 +-
 lib/acpi/mcfg.c                      |  2 +-
 lib/acpi/ssdt.c                      |  2 +-
 13 files changed, 37 insertions(+), 32 deletions(-)

-- 
2.48.1

