Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B483C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 22:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDEF188FD3;
	Fri, 26 Apr 2024 00:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zKsYy4Ef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8054C88FD3; Fri, 26 Apr 2024 00:07:09 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00478885A0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 00:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PM73o0038783;
 Thu, 25 Apr 2024 17:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714082823;
 bh=HF+ynq3wJNpdzSAJg7WBiW431HgCdqKF7zOjfOCI4cQ=;
 h=From:To:CC:Subject:Date;
 b=zKsYy4EfVmnqvG3XvyGp3w63Jphpj1l7OzohrAIivRlFIdcfPhPKL9XIgW9udC+cJ
 vHfmbJKWz4nXKlbe+rCA4DJwl83eEHsZ5hGEeSk1jXmCZt0DEBakIbSxLAIbCtNa/e
 giy1fLg9i5vX3EJPmNjqqJE6HI1BnZ3HWmTp/Z+4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PM735x115090
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 17:07:03 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 17:07:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 17:07:03 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PM6xPZ047679;
 Thu, 25 Apr 2024 17:07:00 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <bsheraw@ti.com>, <s-anna@ti.com>, <a-limaye@ti.com>
Subject: [PATCH v2 0/2] Generate all SR boot binaries
Date: Fri, 26 Apr 2024 03:36:57 +0530
Message-ID: <20240425220659.2056955-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add support for missing HS SRs in the build for J721E and J7200.

Boot logs (updated for v2):
https://gist.github.com/nehamalcom/e652752623537aced8cf31308015d7c9

Changes since v2:
- removed redundant HS-SE SR2.0 generation for J721E (Andrew)

Neha Malcom Francis (2):
  arm: dts: k3-j721e-binman: Add support for HSFS1.1
  arm: dts: k3-j7200-binman: Add support for HSSE1.0 and HSFS1.0

 arch/arm/dts/k3-j7200-binman.dtsi | 95 ++++++++++++++++++++++++++++++-
 arch/arm/dts/k3-j721e-binman.dtsi | 90 ++++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 2 deletions(-)

-- 
2.34.1

