Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73377C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 13:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DE180BA8;
	Tue, 18 Feb 2025 14:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i1RpM71D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4A880BAD; Tue, 18 Feb 2025 14:39:55 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A48980ADF
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 14:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 705A65C2C4B;
 Tue, 18 Feb 2025 13:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 647FAC4CEE2;
 Tue, 18 Feb 2025 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739885991;
 bh=pdShaeI2YbREnlXx/d1BZ1cfsPnLq8JLDPkc5vdQCO4=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=i1RpM71DTH0IFv+GeLcWJSlAOXjD4qla+TJ2Y8HI1nU+pQTUXEHuBI+7yFFdHTkRT
 An5Xi9N13SGwQ99pHgh3Ry68Fk0doltymq7dSPfX7XLVDkucvq0W9U9O0tYyeDRl0Y
 ePOOlZe6LybXueNhxRnPfwZMuWyF+Fi5a2xmCOHujHmKPiRCzLcHbOJ7il0EaZmDa/
 AK+qraxBqc6nsVVDCWWD0OVU68Jux4QfI3xST68vpV7nsEabFVff1lq0eNaX5LnTNw
 MqTW5z7WFwKTPSIV1aNpjiyoGGEP3cspgsbDME7JGvAN8WE/poFM2miB8QUU5oGlfU
 6L3gDGGxiPohA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 51202C02198;
 Tue, 18 Feb 2025 13:39:51 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 18 Feb 2025 14:39:45 +0100
Subject: [PATCH] serial: ns16550: Fix pointer type mismatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-serial-type-v1-1-c05a15bd21c5@posteo.net>
X-B4-Tracking: v=1; b=H4sIAKCNtGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MLXZD6xBzdksqCVF0Ls2RjQ0sLg+QkI1MloI6CotS0zAqwadGxtbU
 ANz12Cl0AAAA=
X-Change-ID: 20250218-serial-type-86c31980cb25
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739885990; l=2033;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=t/ngiIGfYy3uOUv1UZCztlmqW9gxocba7Dk0oGKMID0=;
 b=6pBhflOOUL5nBy12CPzIcGj4mflaevCFVTsF5jkffkTjzIHKyb1sZTzEdmSyPXM2NvTwLbjb5
 jYqBLyDCaK/D5yTLnhAadNqSYegdL0ijC0zGt0FpQwzdhmi4I68ITzp
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

serial_out_dynamic() takes a u8* addr and uses it for 8-bit or 32-bit
accesses, depending on the value of plat->reg_width. This results in a
pointer type mismatch that the compiler may even turn into an error:

drivers/serial/ns16550.c: In function ‘serial_out_dynamic’:
drivers/serial/ns16550.c:115:42: error: passing argument 1 of ‘out_be32’ from incompatible pointer type [-Wincompatible-pointer-types]
  115 |                                 out_be32(addr, value);
      |                                          ^~~~
      |                                          |
      |                                          u8 * {aka unsigned char *}

This error was observed on PowerPC.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/serial/ns16550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 042220081079382a611877aef14ab3ea4b005441..06665d1b3385d90b14c09c3f816bb01802cea2ab 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -112,9 +112,9 @@ static void serial_out_dynamic(struct ns16550_plat *plat, u8 *addr,
 	} else if (plat->reg_width == 4) {
 		if (plat->flags & NS16550_FLAG_ENDIAN) {
 			if (plat->flags & NS16550_FLAG_BE)
-				out_be32(addr, value);
+				out_be32((u32 *)addr, value);
 			else
-				out_le32(addr, value);
+				out_le32((u32 *)addr, value);
 		} else {
 			writel(value, addr);
 		}
@@ -132,9 +132,9 @@ static int serial_in_dynamic(struct ns16550_plat *plat, u8 *addr)
 	} else if (plat->reg_width == 4) {
 		if (plat->flags & NS16550_FLAG_ENDIAN) {
 			if (plat->flags & NS16550_FLAG_BE)
-				return in_be32(addr);
+				return in_be32((u32 *)addr);
 			else
-				return in_le32(addr);
+				return in_le32((u32 *)addr);
 		} else {
 			return readl(addr);
 		}

---
base-commit: 3b1c055bf9e254ab6395907779af4e2ce14bb7e6
change-id: 20250218-serial-type-86c31980cb25

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


