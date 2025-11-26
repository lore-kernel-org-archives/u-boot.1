Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD458CCF9F5
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FDB783A71;
	Wed, 26 Nov 2025 23:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="ZnBw7xQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0013D83A98; Wed, 26 Nov 2025 23:18:51 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 252F283A64
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 23:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1764195399;
 bh=2c4yQMwP5PFbodjB51A2a2HpcGMCq6BUmOQev0ffeeY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZnBw7xQxkTH6Q9BX8XaBtLJYtMeF9/nmlBkLWZ3pmheCF5imX2sWzoxf74wB/ol7h
 vBjKaewNFcehGyoZhwn+GPu6gPPPpGQ6J/bM/rxDPJ2X08Zvhag+1WwOTGybeoNV7L
 1+Q7SvhX+09P9Asju9BcYW+9xrI8y/cNL592PNHSVXu3BgJM4McDGOx22JSGqQ8ank
 /2oA9c1mExTJpnB+JWxga6XJvY0R2BTkBO54/LlASW8qmaLwzGQum2z8j7HPWT2ABl
 PfCSYrAR4HCN0U3edXmq/MAynWeiRou0AD9xbkoGkjGlcSWFMhmKFxolfSnMwIMfey
 1K9G6+0PCZkDA==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 158D2B22131C;
 Wed, 26 Nov 2025 23:16:36 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH v1 3/4] riscv: dts: Add placeholder files for pending
 upstream Orange Pi RV
Date: Wed, 26 Nov 2025 14:15:28 -0800
Message-ID: <20251126221552.87574-4-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251126221552.87574-1-e@freeshell.de>
References: <20251126221552.87574-1-e@freeshell.de>
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

Create placeholder file for Orange Pi RV in dts/upstream to placate the
build system. This is required when building on a dts that is not yet
landed in devicetree-rebasing and adopted as an dtsi include.

This placeholder file is empty and should be superseded when
devicetree-rebasing release candidate for Linux 6.19 is sync'ed.

Signed-off-by: E Shattow <e@freeshell.de>
---
 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts

diff --git a/dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts b/dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts
new file mode 100644
index 00000000000..e69de29bb2d
-- 
2.50.0

