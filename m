Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3479C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 20:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB7C87F65;
	Mon,  4 Mar 2024 21:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=georgemail.de header.i=@georgemail.de header.b="AkLjC0dO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543B987FAA; Mon,  4 Mar 2024 21:52:38 +0100 (CET)
Received: from smtp6.goneo.de (smtp6.goneo.de [IPv6:2001:1640:5::8:31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ECBA87EB0
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 21:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon@georgemail.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 1A4CF240A59;
 Mon,  4 Mar 2024 21:52:35 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 46B80240879;
 Mon,  4 Mar 2024 21:52:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.de;
 s=DKIM001; t=1709585554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QYE3aJQdHIVbr8GpkEUvC3O4vS1nHM91VCnjxWliVO0=;
 b=AkLjC0dOblhfOU3epogPcWdXNcLqwCOcgABK5cX46/3G1jQrjhMfmypQEJ96adgGsGP0pU
 b8/WhpTgFL+P9KrWMtkjdiwgNPf+kt/Wct7CBv7apbojJ7F+3mKTPnwIoKFj/xLzCAatY5
 EjUYnwOymDn7MA8m3Ah4BD3QhzPZNkbo/5sY2eG9pol9lntj+vVBw9GNCNUU8e+0+O/fWD
 qdvQKcBvFl61Zi8TPufwXIq5tlrTEWyLHWp0Kr2PSr4owJp6OnMLgwYCNZD6efHnjtv+el
 6EK0TQxKNONU2MBKl3LNqBrCW7g0gmlu7MXKQNwkrBvUOfzTbA/a61d50g4ODQ==
Received: from couch-potassium.fritz.box (unknown
 [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id F2D17240128;
 Mon,  4 Mar 2024 21:52:33 +0100 (CET)
From: "Leon M. Busch-George" <leon@georgemail.de>
To: Rick Chen <rick@andestech.com>,
	u-boot@lists.denx.de
Subject: [PATCH] riscv: dts: jh7110: fix indentation
Date: Mon,  4 Mar 2024 21:51:47 +0100
Message-ID: <20240304205203.64664-1-leon@georgemail.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 38849a
X-Rspamd-UID: b2d5ff
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

From: "Leon M. Busch-George" <leon@georgemail.eu>

Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>
---
 arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
index 55185314dd..3012466b30 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
@@ -112,6 +112,6 @@
 
 			u-boot-spl {
 			};
+		};
 	};
 };
-};
-- 
2.44.0

