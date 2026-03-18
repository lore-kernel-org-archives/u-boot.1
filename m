Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAFA103E17A
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9A3839A8;
	Wed, 18 Mar 2026 15:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U7l+XMqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD1B83AC5; Wed, 18 Mar 2026 15:30:05 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC897839A8
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F47960053;
 Wed, 18 Mar 2026 14:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D2AC19421;
 Wed, 18 Mar 2026 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773844200;
 bh=h7ZTFErJTHMS8PjvXh4veyS7dIqjvlusZyLYfuIZoYc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U7l+XMqSwBxmNnD8GgesOmqyGu753i37izXBI14rWODCt9z437Lr8ZpGnmBlGDFdM
 h6K4IKFYh+SBH5HqCuoPvff7yoko+TCMePpgb5My5XGf7cN4ot7Xxp4++zwu1U7O1G
 5M4GcJz/RL7YkeOwqJ5cO7dC3En5LsCNEVSxSRb5D27VfnfzbDg0snPBOzNirwgohL
 n1wRnDufSTSg4odnh/jEhSDFkbmzD9nBPya4eXCOVmdVOPtXpTTCzuWGJVeHENK1TU
 N6w2OTLPR9SxKq+4ahbRixfm3SjhrZ2GD3kpWj8bNwgCmIyUH09cCz06+AEomI+J0V
 jGdDzhxJd4fQA==
From: Michael Walle <mwalle@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ashish Kumar <Ashish.kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/3] arm: dts: ls1021a-tsn: add default serial output
Date: Wed, 18 Mar 2026 15:29:15 +0100
Message-ID: <20260318142949.2479033-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318142949.2479033-1-mwalle@kernel.org>
References: <20260318142949.2479033-1-mwalle@kernel.org>
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

Since switching to DM_SERIAL 'stdout-path' seems to be necessary.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/dts/ls1021a-tsn.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/ls1021a-tsn.dts b/arch/arm/dts/ls1021a-tsn.dts
index 68f5543644e..e74d0956194 100644
--- a/arch/arm/dts/ls1021a-tsn.dts
+++ b/arch/arm/dts/ls1021a-tsn.dts
@@ -22,6 +22,10 @@
 		ethernet5 = &swp4;
 		ethernet6 = &swp5;
 	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
 };
 
 &dspi0 {
-- 
2.47.3

