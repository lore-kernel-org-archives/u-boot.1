Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B987C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 01:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 853AB80F47;
	Fri, 31 Jan 2025 02:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="yZ5Wv+ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D29180F5C; Fri, 31 Jan 2025 02:13:03 +0100 (CET)
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com
 [203.205.221.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0A580F44
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 02:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738285969; bh=/FZslxhiyNrqlPjIzD0jQYFKSEBcdJONAE9kqUbcHlE=;
 h=From:To:Cc:Subject:Date;
 b=yZ5Wv+ct53DaGprwTve8tvp4o6oAEpJvb3uhGXF6F3NM1ic3knz+gk8LO+1vOaziV
 4wlyrY8JIQ+qhCM8dvFfZ6yKEPSsv+9zRhRtB5i0LnXkzZrB7QXWMLYX8vrB2gS3lH
 RNIdIgxhtJ/bQU0ycwLHUe8evuoMh1BauBnZdlsA=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 32F33C4B; Fri, 31 Jan 2025 09:12:47 +0800
X-QQ-mid: xmsmtpt1738285967t80ihqkb4
Message-ID: <tencent_48B2E03220334C9CC9441FA11E8A412A3607@qq.com>
X-QQ-XMAILINFO: Ms5xyImz3IR/7escrQVjDE0N9cWOYaJ1/v585Bq5A2N8N2n5kgnQxwZZPIyMb+
 LgQbrsxUQ+QZVhpANCir5Cj5Nk5CUxjIzohBtl7grnTfaGIIZlxmTRAR7uW3clYI3HQWJih+fjMT
 zYEr6bVuVjlA18CUOWSTsrMmZI6Wfl/oQWB7PrPe8B5QIBu/zIKe7zOubx2323U5dvZfHL1JrMbV
 C2RZ52kTrSWvHxZGM+TJhLjcRfa0XGJEc/YDk0Op8GgjvW0Qu+a8hdWqjqny3tMMMIBUom0Kf9Ra
 kcpVsNqSOB6tffbCCPmNPpQyimOeqq5tazVlRsu/J0UInle121IlXOiaBMb8AJ7mR1M/aRh8pcQJ
 h/Zl4e2Pp6NZXs+gMb6JaZGjRJIewRMU1f2eoikHjc5jMGzjugVfxdBXxtGZpYdZ84R8fHpcV2Y8
 PJFZLZpvUKLSqaGfNhy7tpwQAZBnH/DPdV4WIrmANvCufgCW1DKreRppwIOR0vBzuLgax0NJdBTI
 fnI0AT1ga34+XT6Z5wnOthf69Rm7sR7tMxsUAnagFGvbHqamY5tMY/FhR2Mlk4VV3FpCtjNrdZac
 Y90C8yoyNR9y817va0vu4tRWUwwA0efpQy0vXDG+axJFSlrtxfQohvCYiwwcsII3qHyRHwBoJriI
 9laNR+pnfY2Rg4mHcDPsjrFERBrI4sWopaLNxduqiUrnNhxsaU83HJ5Sksthf0YECJlFrUg5qXDm
 cv1nAYx0s97/jqkipNRMhrV8nO1JIeEKfaY8pQK6/Qzm7xSDjwy8CsD+287ptlR3g646dZyiqhUq
 IRGyQ37GcW7cp+hg3lg7Cf+WbMJ+IP3Bg4aBvR1gLZ2UPXS/UYc074mn3UfwfgQrMioV0p+YBifL
 CfSvnbI58a+SSyCHiEyA5zIdrSl0Bf0ziZ92mZ/MPOuJa2/XGktgZxbyVBxEaKXIw6e464djEMJ2
 k1yXvLMQIgLGKEzv4+BgpwdYTbPoocx/UPXUU8C2Zrc/ZUz4fiKFnGgG9Hg4FZ
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1] sunxi: kconfig : Make CHIP_DIP_SCAN depend on ARCH_SUNXI
Date: Fri, 31 Jan 2025 09:12:43 +0800
X-OQ-MSGID: <20250131011243.344063-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

The CHIP_DIP_SCAN configuration option
is relevant only to ARCH_SUNXI.
Make CHIP_DIP_SCAN dependent
on ARCH_SUNXI so that it does not show up on other goals.

Signed-off-by: Liya Huang <1425075683@qq.com>
---

Changes in v1:
- Modify the if ARCH_SUNXI endif range.

 arch/arm/mach-sunxi/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ba1b1541437..cc28f403fae 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1131,10 +1131,6 @@ config BLUETOOTH_DT_DEVICE_FIXUP
 	  The used address is "bdaddr" if set, and "ethaddr" with the LSB
 	  flipped elsewise.
 
-source "board/sunxi/Kconfig"
-
-endif
-
 config CHIP_DIP_SCAN
 	bool "Enable DIPs detection for CHIP board"
 	select SUPPORT_EXTENSION_SCAN
@@ -1143,3 +1139,7 @@ config CHIP_DIP_SCAN
 	select W1_EEPROM
 	select W1_EEPROM_DS24XXX
 	select CMD_EXTENSION
+
+source "board/sunxi/Kconfig"
+
+endif
-- 
2.25.1

