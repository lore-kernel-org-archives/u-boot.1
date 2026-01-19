Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32832CCF2D4
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD9480B98;
	Mon, 19 Jan 2026 10:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="nsZ+d+6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E514E83956; Mon, 19 Jan 2026 10:54:44 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B915F80B98
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peko@korsgaard.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=nsZ+d+6GTBd+2WUL5a2hxreuRY/igxxZZjupJsa4iNlEUYGns20nHB9OcTruiHYM8UR/VU51rPbH78HRE9mbxWwPMnjNarfTrKXAEGzMeupR1mZESpZntLXHcYJV7hwUc7mO70EiEgtUBhvlA59BSEBWfFXjVIfmb6i8xqAUspRtB2jCLy8Z3KIm5p0cdptgM21JNzuTyWdWGpWbD0me7oIXXx8h4ObciSLiDU69CSFrsD90kAZ1EI9+jz5Ang6Uo19ncF4AhRyTRFlRbRNBtTa8SUbHZ5jznzqkz8C2AdfxaRlh4H6NUB8mu9FcQIWnfob9EmT0mauMRH/6HqGyCQ==;
 s=purelymail3; d=purelymail.com; v=1;
 bh=8vzLx12y4zlaTLGni9zFCWB9+fEh1dKob0EWnve21io=;
 h=Feedback-ID:Received:Received:From:To:Subject:Date; 
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1117429823; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 19 Jan 2026 09:54:40 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
 (envelope-from <peko@dell.be.48ers.dk>) id 1vhly3-0000000Bdvc-1yXc;
 Mon, 19 Jan 2026 10:54:39 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, lukma@denx.de, Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH 1/2] drivers/clk/Kconfig: fix "related" typo in help text
Date: Mon, 19 Jan 2026 10:54:36 +0100
Message-ID: <20260119095437.2775081-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
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

It looks like the original zynqmp typo was copied to versal as well.  Fix
both.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 drivers/clk/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ae783254008..c88931c8ec4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -228,7 +228,7 @@ config CLK_VERSAL
 =09depends on (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
 =09depends on ZYNQMP_FIRMWARE
 =09help
-=09  This clock driver adds support for clock realted settings for
+=09  This clock driver adds support for clock related settings for
 =09  Versal platform.
=20
 config CLK_VEXPRESS_OSC
@@ -262,7 +262,7 @@ config CLK_ZYNQMP
 =09depends on ARCH_ZYNQMP
 =09imply ZYNQMP_FIRMWARE
 =09help
-=09  This clock driver adds support for clock realted settings for
+=09  This clock driver adds support for clock related settings for
 =09  ZynqMP platform.
=20
 source "drivers/clk/adi/Kconfig"
--=20
2.47.3

