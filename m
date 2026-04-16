Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C010BF8A16B
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 12:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73D184228;
	Thu, 16 Apr 2026 14:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="Rv8b//1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF1284228; Thu, 16 Apr 2026 14:14:46 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020E683FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1776341682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=foXlhDYNuwiXyOhqzlWbRyzIQ+HXu+KjiC4Dkk/6yRA=;
 b=Rv8b//1aAI++sbqoFDSmt8AyXJK83fhCD61PLS0lWouVphKwHPoKI3PSYYOZtdiTZ8ydcE
 dBPpwz6LZnQaQ8t3B1n4HBRHEftqzkw/5HJWUeRF8IKV3iDO/gFXebV6TVzzdSzqyAS2pO
 FUjbx2Jn9MKMun49Hpww3wiDAMQSUH8=
Received: from archlinux (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 9bf06457
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 16 Apr 2026 12:14:41 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, u-boot@lists.denx.de, sjg@chromium.org,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 1/9] m68k: dts: mcf5441x: add mmc device for mcf5441x
Date: Thu, 16 Apr 2026 14:14:23 +0200
Message-ID: <20260416121431.20852-1-angelo@kernel-space.org>
X-Mailer: git-send-email 2.53.0
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

Add mmc support for the mcf5441x family. There is only one esdhc
controller for this cpu family.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/dts/mcf5441x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/m68k/dts/mcf5441x.dtsi b/arch/m68k/dts/mcf5441x.dtsi
index dcca36312f5..7cd6072d4a5 100644
--- a/arch/m68k/dts/mcf5441x.dtsi
+++ b/arch/m68k/dts/mcf5441x.dtsi
@@ -163,5 +163,13 @@
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
+
+		esdhc: mmc@0xfc0cc000 {
+			compatible = "fsl,esdhc";
+			reg = <0xfc0cc000 0x8000>;
+			non-removable;
+			bus-width = <4>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.53.0

