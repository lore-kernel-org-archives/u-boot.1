Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B155ED111B0
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ABBA83A8F;
	Tue, 20 Jan 2026 16:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="YaFw84eK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E535983A8F; Tue, 20 Jan 2026 16:56:03 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A37083A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768924474;
 bh=zXKKNfuFlZeL7wn+dICOS8KB+0Fzh1jHRX7kij/AuVI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YaFw84eKpfU6kz5owGwx/WoAGYQlX7Yf7Bz9c4ZHn/TffhvBhB3noSGoUBJPk23qm
 SZiYCVT+u6hJCSS0CxHPDTxaxXQjPlwTzTyZTEzTYNHH0aBq+cgvPssCe9sppUDS0R
 GVIfTicqnHukXbSuIOVTQH7PZyX/fhR7eZa/48ct+FGcBaErWEbBWsS5uu6nTXFpsQ
 DvVkjoSIQTQJhgqN3CUXsrOpOQHtk9+OYlSLTyYGa4C4cMXrBGDI1KEPsKB+Eba2At
 XwcIDWouJS4ItC1X4OUoY/aXD0uNKR5TrTA5VB0UowC0lX0AOtezZ54IYLl+iOg+UE
 jX+DNZ4wAUYuw==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 1F880B220B62;
 Tue, 20 Jan 2026 16:54:31 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Michael Zhu <michael.zhu@starfivetech.com>,
 Drew Fustini <drew@beagleboard.org>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Icenowy Zheng <uwu@icenowy.me>, Conor Dooley <conor.dooley@microchip.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v3 1/5] dt-bindings: riscv: starfive: add xunlong,orangepi-rv
Date: Tue, 20 Jan 2026 07:53:34 -0800
Message-ID: <20260120155406.34916-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260120155406.34916-1-e@freeshell.de>
References: <20260120155406.34916-1-e@freeshell.de>
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

From: Icenowy Zheng <uwu@icenowy.me>

Add "xunlong,orangepi-rv" as a StarFive JH7110 SoC-based board.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: E Shattow <e@freeshell.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[ upstream commit: d94ebab404b0ce6498770888e25102e32b2b13da ]

(cherry picked from commit 19644ea3243c8749d1c08d4397b4522965a9bf8e)
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 dts/upstream/Bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/Bindings/riscv/starfive.yaml b/dts/upstream/Bindings/riscv/starfive.yaml
index 04510341a71..3fdeab9d8f0 100644
--- a/dts/upstream/Bindings/riscv/starfive.yaml
+++ b/dts/upstream/Bindings/riscv/starfive.yaml
@@ -33,6 +33,7 @@ properties:
               - pine64,star64
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
+              - xunlong,orangepi-rv
           - const: starfive,jh7110
 
 additionalProperties: true
-- 
2.50.0

