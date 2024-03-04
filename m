Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB2AC54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4446E87F83;
	Tue,  5 Mar 2024 00:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bkwOcRIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4936487F8A; Tue,  5 Mar 2024 00:28:57 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20CC87DA8
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 76428CE0A4C;
 Mon,  4 Mar 2024 23:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D57FC433C7;
 Mon,  4 Mar 2024 23:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709594930;
 bh=j8f6NvdqS5Xdh7x1gQYdbseGfYjtFT62QhwiOh0CQfI=;
 h=From:To:Cc:Subject:Date:From;
 b=bkwOcRIf40cuf7qV9u6zssKSt1rW1pPucPuq/3uQNigT0R1jMFNwdAwCIfGunbKXU
 1lNFt0K1kaPiI12H/IzKQEA7OHh0yxBtnoqTCrWmXr1Mf0wyx3PXMWSYlmW2xl7Nzk
 jLOIVljaByT7EnYwIB0KqmbxNfHSr3M21iba4D4Kl1sDWOQRIf7zL33WAHlf9ZwWoO
 XeM4wwRK1bqXOHACQNam2A8SjQcha/jooEh+veSfqAKu0hYSAR7uTYF2IyUjjfIgTg
 m0taVJ+F+syxvSmURm0HfH9MsBMoXjR+xkZENhd9ZTfPa9/Nn9LoH39pDYwBopzZli
 WZt1Oe2DIeCaA==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 palmer@dabbelt.com
Subject: [PATCH v1] riscv: cpu: improve multi-letter extension detection in
 supports_extension()
Date: Mon,  4 Mar 2024 23:28:35 +0000
Message-ID: <20240304232835.3076533-2-conor@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Conor Dooley <conor.dooley@microchip.com>

The first multi-letter extension after the single-letter extensions does
not have to be preceded by an underscore, which could cause the parser
to mistakenly find a single-letter extension after the start of the
multi-letter portion of the string.
Three letters precede multi-letter extensions (s, x & z), none of which
are valid single-letter extensions. The dt-binding also allows
multi-letter extensions starting with h, but no such extension have been
frozen or ratified, and the unprivileged spec no longer uses "h" as a
prefix for multi-letter hypervisor extensions, having moved to "sh"
instead. For that reason, modify the parser to stop at s, x & z to prevent
this overrun, ignoring h.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
The parser in U-Boot only supports single-letter extensions & the
single-letter h has to be at the end of the single-letter section, so it
would not be difficult to terminate parsing once a h is seen (you'd need
to support the hypervisor extension to support additional hypervisor
extensions after all) if in the future a multi-letter extension starting
with h did come about. I've got no problem adding a special case for h,
but I'm tempted to just remove the multi-letter h extensions from the
binding, given there's actually not going to be any extensions ratified
using that naming scheme.

CC: Rick Chen <rick@andestech.com>
CC: Leo <ycliang@andestech.com>
CC: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>
CC: Chanho Park <chanho61.park@samsung.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Bin Meng <bmeng.cn@gmail.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: palmer@dabbelt.com
CC: u-boot@lists.denx.de
---
 arch/riscv/cpu/cpu.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index 8445c5823e..ecfefa1a02 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -49,14 +49,24 @@ static inline bool supports_extension(char ext)
 	}
 	if (!cpu_get_desc(dev, desc, sizeof(desc))) {
 		/*
-		 * skip the first 4 characters (rv32|rv64) and
-		 * check until underscore
+		 * skip the first 4 characters (rv32|rv64)
 		 */
 		for (i = 4; i < sizeof(desc); i++) {
-			if (desc[i] == '_' || desc[i] == '\0')
-				break;
-			if (desc[i] == ext)
-				return true;
+			switch (desc[i]) {
+			case 's':
+			case 'x':
+			case 'z':
+			case '_':
+			case '\0':
+				/*
+				 * Any of these characters mean the single
+				 * letter extensions have all been consumed.
+				 */
+				return false;
+			default:
+				if (desc[i] == ext)
+					return true;
+			}
 		}
 	}
 
-- 
2.43.0

