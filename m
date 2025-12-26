Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020A3E8FDB4
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 19:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8CA83A64;
	Fri, 26 Dec 2025 20:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="CssNQ3d1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0587583A64; Fri, 26 Dec 2025 20:32:32 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06A1D839F1
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 20:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1766777465;
 bh=YjUQ9ZSjbihwY+6mlIq00Xl86cCKfv1wq2DBOMnCgfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CssNQ3d1+eyhwoMuy1w6xXaGY0cLCqEvXfNigqNnP9m6M3HIVccNXraJv6gaBrlAM
 xZfaMWkI6AtnotcBxJ47LDTVjXrVxqfkweg3/qq1fWymc2DwreOu4TVQCykuiI6N8E
 b+54foOvpnIX1i9ZuKvW47lClS8DXvw4ncrOQhcyPbpSo/Bye5taEuAr3pfjdfipt/
 bV7ZqaRG5c0w7IQbh3rvbV4GsVyrlv+iJ96YwR4CekXqBS1Mrzgvwp0QwpFb0lkOm5
 fGrRKW25UcnyrrktRLNzLVug0IAfxZRzoCoam3c4PeGsepH2nj3ugAlRktnm7WCdUT
 aH/3YB0kco95Q==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7D46BB221526;
 Fri, 26 Dec 2025 20:31:02 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Michael Zhu <michael.zhu@starfivetech.com>,
 Drew Fustini <drew@beagleboard.org>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Icenowy Zheng <uwu@icenowy.me>, Conor Dooley <conor.dooley@microchip.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: riscv: starfive: add xunlong,orangepi-rv
Date: Fri, 26 Dec 2025 11:30:02 -0800
Message-ID: <20251226193034.181659-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251226193034.181659-1-e@freeshell.de>
References: <20251226193034.181659-1-e@freeshell.de>
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

