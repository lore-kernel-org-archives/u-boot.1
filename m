Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B50C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 17:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260B283623;
	Fri, 18 Jul 2025 19:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="TOvWvxer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65EA08363B; Fri, 18 Jul 2025 19:10:45 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id 765B1834B6
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 19:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1752858459;
 bh=JxcjWCN/2FVSunNrSw9v/dbyMHaTPJ/1UZqtWSS3ZBk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=TOvWvxertYdzVy367U0sJfPMl/KWHnORYu/ksIPpK5zF2aev04STUHM9xFJ12OS8E
 By2PItxCn9Be3GJT1gCN0B5OmAeZ5yEGVXPy6RNglstYjA4FUUcPY/gvT5KzFLcZ7u
 +qzG1Zxbzoui7wPQcLVnIIgwrqGljAUDQEk4zy5SpVyLUJO+EvpqX/L4eupS8m7bDc
 teqM28vEvbFXBy8N+t9E7WTUPPY6TtML2FovXROg8rRKqxU84ukUsltXTQ15J6+ip4
 5VOHp4VuZksEpEiq8+W6DmIA74o8zxzMFOh/s56IYk2G4fk8Vqp5IFuYChqIbWlDgy
 vykCqhQ0I8Tzw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Casey Connolly
 <casey.connolly@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, =?UTF-8?q?Vincent=20Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH V5 2/4] test/py: Avoid stopping the test on console output "##
 Error: "
Date: Fri, 18 Jul 2025 19:06:00 +0200
Message-ID: <20250718170602.10746-3-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
References: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

Some tests deliberately provoke an error, but if the console output is
"## Error: " pytest catches it as an error and cancels the test.
Remove this to enable this type of tests.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: "Vincent Stehlé" <vincent.stehle@arm.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
---
V5: - Add this patch to the series
---
 test/py/console_base.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/test/py/console_base.py b/test/py/console_base.py
index 88d444b44b8..1ac42ef83a0 100644
--- a/test/py/console_base.py
+++ b/test/py/console_base.py
@@ -21,7 +21,6 @@ pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))'
 pattern_u_boot_main_signon = re.compile('(U-Boot \\d{4}\\.\\d{2}[^\r\n]*\\))')
 pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
-pattern_error_notification = re.compile('## Error: ')
 pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
 pattern_ready_prompt = re.compile('{lab ready in (.*)s: (.*)}')
 pattern_lab_mode = re.compile('{lab mode.*}')
@@ -45,7 +44,6 @@ bad_pattern_defs = (
     ('main_signon', pattern_u_boot_main_signon),
     ('stop_autoboot_prompt', pattern_stop_autoboot_prompt),
     ('unknown_command', pattern_unknown_command),
-    ('error_notification', pattern_error_notification),
     ('error_please_reset', pattern_error_please_reset),
 )
 
-- 
2.30.2

