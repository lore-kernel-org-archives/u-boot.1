Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CDBC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A170A88429;
	Tue, 16 Apr 2024 14:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LaYf6wqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A34D882FE; Tue, 16 Apr 2024 09:53:15 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72682881CE
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so3211340b3a.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713253990; x=1713858790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GskfWD83mpbVUZ8DWIEShRMg8Dx2VJkL60GtsYTEGOo=;
 b=LaYf6wqeCR9z8W1oCNZTQGjNlDR6s+ZL12yWeJlLYTZQLxTajX8SU1iuYdxVbKRNL0
 vZ3O5gOWEmLjiVE5MIPnP4FQ1FpWhl68a9HBprk/qOibi4HM0t4ZzPTzqzuTUwZZHChi
 naawIQtKsXpTLJOc/6cXNtwr+AqdO0bhKd38NNzL0XctNKiPPJ3mG05fBUpUJFPL3QEx
 uJHFKlyR7vIl856hlZK3/85Rk26AMk10UFlUHARKQIOWynnGxx22JNS5BfhnIWb6Woba
 nhKKGwdhExp8iKUA5CcSraJesB3Xjra3q0EfzRkrYVLqEmWF1nyecwjTZ908VyhcQ9jo
 Fc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713253990; x=1713858790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GskfWD83mpbVUZ8DWIEShRMg8Dx2VJkL60GtsYTEGOo=;
 b=YC1hEei4Vdtdkj3881rU+zxuzoYbjSDAY0I0G2J7/A+pX1r9hpKB1ckI+J9GLiytFX
 JZYSKA/vzfM4EQUAwOgCxVJ62uuw96o8VmuUufzdXQr6yb0axVxGTyg3KD6U8c/cLjel
 tHSiSTQ4XeUD0lEXTRZO50IhYWV0RgdasLbQKR9nm8AXXAOpWmmunTw/eYu5uGj4QAKt
 ST/3IETtxARFWp0qOpYo2lkyyVqn9sXpsm/47+8H/AE5ScOKbH52ACKmcr1WLue2Y6lI
 WAUFUulcW4W8t+TjE1SZ/H95UBDlzX4N9NgS+5ljBUppv22H1EE+npK/oGWgTCTR9Kbl
 khOg==
X-Gm-Message-State: AOJu0Yw7fiuOHdyengKQBvX0isxC0Zrzgax0dsxm/w+bFcrRdCR86UFU
 JcVpo9WgA1gej+yEeemzYkoz5U6B8AnXIEhjFUF0BkV9DiGgOO+ru3tvxed8gDTWDg==
X-Google-Smtp-Source: AGHT+IFfMthi0DQnHUkuBDFc+wh753bI4L6yfoA1IB1FOhAnZpAykc8tzrLjs0ykgfE5MgdLuv1ICA==
X-Received: by 2002:a05:6a00:190b:b0:6ea:e2ed:497d with SMTP id
 y11-20020a056a00190b00b006eae2ed497dmr10811942pfi.19.1713253990015; 
 Tue, 16 Apr 2024 00:53:10 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a056a0000cc00b006ed2709ada6sm8391681pfj.65.2024.04.16.00.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 00:53:09 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] sysreset: sophgo: milkv_duo: Add sysreset support for
 Milk-V Duo board
Date: Tue, 16 Apr 2024 15:52:37 +0800
Message-ID: <20240416075254.13729-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Apr 2024 14:51:12 +0200
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

This series add sysreset driver for cv1800b SoC and enable poweroff and
reset commands for Sophgo Milk-V Duo board.


Kongyang Liu (3):
  sysreset: cv1800b: Add sysreset driver for cv1800b SoC
  board: sophgo: milkv_duo: Bind sysreset driver
  configs: milkv_duo: Add sysreset configs

 board/sophgo/milkv_duo/board.c      |  4 ++
 configs/milkv_duo_defconfig         |  3 ++
 drivers/sysreset/Kconfig            |  5 +++
 drivers/sysreset/Makefile           |  1 +
 drivers/sysreset/sysreset_cv1800b.c | 64 +++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_cv1800b.c

-- 
2.41.0

