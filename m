Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDA1CCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 06:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BF4838AB;
	Thu, 30 Oct 2025 07:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="L7jZc+Da";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A111F838BB; Thu, 30 Oct 2025 07:25:02 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF34E83849
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1761805461;
 bh=WD2TsxQIfZalFA1i8+73ye0dMr4ltCruXEtqX5gQ/4o=;
 h=From:To:Cc:Subject:Date:From;
 b=L7jZc+DalBofBKodv3yDvYXvzd9NIp1QjZXXU4R8M/D7+KNekJwi1PQUrk8T71Awi
 jQLHNVw3n/RLZYcmW8I83uZBEPuGx9WnCwdhPPQt77OX1Q4VX/TLLDjpTYldBFLHSw
 dumLo/jHo7S5gnDdjqeHnN3UJg/m6wzRihZSE/iAV3EflprfoZoT669vwHsqUxMECr
 VoDSHhrzuAPoW6Jvot+P4pBbi1ueUWan/qhzlZuVX6D1YowV21jhRk6GTCSX7XTAsL
 k1X4pwdJwMkOSqCzmNqM1xDh+erg5QaIB+BXl5nV0wL38QZx0VCvbxvJYxP55L38ti
 MRIQxNvtaLoMA==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 886E3B2200E2;
 Thu, 30 Oct 2025 07:24:19 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v1 0/3] ram: starfive: cleanup size types and typos
Date: Wed, 29 Oct 2025 23:23:31 -0700
Message-ID: <20251030062354.35413-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Fix some low-hanging fruit for StarFive JH-7110 SoC DDR code.

E Shattow (3):
  ram: starfive: drop references to 16GB memory size
  ram: starfive: use SZ_8G for 8GB memory size
  ram: starfive: fix typo for unsupported DDR size

 drivers/ram/starfive/ddrcsr_boot.c  | 3 ---
 drivers/ram/starfive/ddrphy_start.c | 1 -
 drivers/ram/starfive/starfive_ddr.c | 5 ++---
 drivers/ram/starfive/starfive_ddr.h | 1 -
 4 files changed, 2 insertions(+), 8 deletions(-)


base-commit: e34d01d23e45e007368685ffa6dfd674b6dd7b17
-- 
2.50.0

