Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECCDFD8FD3
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB59583F54;
	Thu, 26 Feb 2026 17:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="mpiDW91H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBFC83F36; Thu, 26 Feb 2026 17:39:25 +0100 (CET)
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net
 [178.154.239.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D362883E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:26c5:0:640:cf7d:0])
 by forward100d.mail.yandex.net (Yandex) with ESMTPS id 52DA4C008F;
 Thu, 26 Feb 2026 19:39:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id LdlY8X2GsOs0-LPo8c9tZ; 
 Thu, 26 Feb 2026 19:39:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1772123961; bh=JJ/J9ERsmFrqLtLA4v1GDohD5uUAXPXw/aI8hJzog10=;
 h=Cc:Message-Id:To:From:Date:Subject;
 b=mpiDW91HvV1OpHhQE1DTsaxDZajPRsnJfvqYADLaMwCQaDYTw7eDUlsyZOhtPnJnu
 N6lgFRpeka7+IzXbgQSD8tEcfeIG7WsQauN7oI5UMpyl71M2o1elVFqT2EBSyzM2Ks
 cqWYsL75SFJb85FlDtAUUcuh86cwa/gKgglFTSQ0=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Thu, 26 Feb 2026 19:39:10 +0300
Subject: [PATCH v2] serial: ns16550: Fix return-type warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-serial_ns16550_fix_warning-v2-1-738146c5df53@maquefel.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NUQ6CMBBEr0L22xq22DXxy3sY0hRZYBMo2CpqC
 He3cAI/38zkzQKRg3CES7ZA4FmijD6BPmRw75xvWUmdGHSuKdea1LZ3vfURyZjcNvKxbxe8+FY
 ZJDzXddVUBUISTIFTvctvZeJO4nMM3/1rxi39SzujQsXOUMHkNPHpOrjHixvujwNDua7rD7IYh
 cTGAAAA
X-Change-ID: 20260226-serial_ns16550_fix_warning-51617ddbfb31
To: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Aiden Park <aiden.park@intel.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772123962; l=1439;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=5YPmZegSRL403cvm1Q2hDoUDJrMBmAf+RFXg4c5Rpio=;
 b=8shD8qMIpoFAyzMDz9YdiIJeWP6Mg60/OdKH34NRmQykebJClrkoUOmoFJraFNKFJhm2QB9EA
 EStjWHVbOjQBiIcdQqntcjg1qBMCFfi19wlstuq03uoOIKF7SScEtAg
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Mailman-Approved-At: Thu, 26 Feb 2026 17:51:10 +0100
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

Fix compiler warning:

drivers/serial/ns16550.c: In function ‘serial_in_dynamic’:
drivers/serial/ns16550.c:153:1: warning: control reaches end
    of non-void function [-Wreturn-type]
  153 | }
      | ^

Observed with gcc 15.2.1:

$ riscv64-unknown-linux-gnu-gcc --version
riscv64-unknown-linux-gnu-gcc (Gentoo 15.2.1_p20260214 p5) 15.2.1

Fixes: 62cbde4c4e46 ("serial: ns16550: Support run-time configuration")
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v2:
Tom:
- specified gcc version in commit message

- Link to v1: https://lore.kernel.org/r/20260226-serial_ns16550_fix_warning-v1-1-ea563e6a26e4@maquefel.me
---
 drivers/serial/ns16550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 4f7de3ea215..71e2bc026cb 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -140,9 +140,9 @@ static int serial_in_dynamic(struct ns16550_plat *plat, u8 *addr)
 		}
 	} else if (plat->flags & NS16550_FLAG_BE) {
 		return readb(addr + (1 << plat->reg_shift) - 1);
-	} else {
-		return readb(addr);
 	}
+
+	return readb(addr);
 }
 #else
 static inline void serial_out_dynamic(struct ns16550_plat *plat, u8 *addr,

---
base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d
change-id: 20260226-serial_ns16550_fix_warning-51617ddbfb31

Best regards,
-- 
Nikita Shubin

