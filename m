Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEEECDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 04:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5035787248;
	Fri, 20 Oct 2023 06:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotsplots.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6E186F80; Fri, 20 Oct 2023 01:06:58 +0200 (CEST)
Received: from mxb.hotsplots.de (mxb.hotsplots.de [185.46.137.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAAC487184
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 01:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotsplots.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mf@hotsplots.de
Received: from build2.hotsplots.bln (unknown [217.66.62.140])
 by mxb.hotsplots.de (Postfix) with ESMTPS id 6D4478C01E5;
 Fri, 20 Oct 2023 01:06:56 +0200 (CEST)
Received: from mf by build2.hotsplots.bln with local (Exim 4.89)
 (envelope-from <mf@build2.hotsplots.bln>)
 id 1qtc6S-0006VR-1g; Fri, 20 Oct 2023 01:06:56 +0200
From: =?UTF-8?q?Martin=20F=C3=A4cknitz?= <faecknitz@hotsplots.de>
To: u-boot@lists.denx.de
Subject: [PATCH] mpc85xx: relocate code in non-SPL build
Date: Fri, 20 Oct 2023 01:06:55 +0200
Message-Id: <20231019230655.24974-1-faecknitz@hotsplots.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mxb
X-Rspamd-Queue-Id: 6D4478C01E5
X-Spamd-Result: default: False [-50.00 / 500.00];
 ASN(0.00)[asn:33811, ipnet:217.66.48.0/20, country:DE];
 IP_WHITELIST(-50.00)[217.66.62.140]
Authentication-Results: mxb.hotsplots.de;
	none
X-Spamd-Bar: --------------------------------------------------
X-Mailman-Approved-At: Fri, 20 Oct 2023 06:13:48 +0200
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

When building a non-SPL image, relocation is needed. This patch restores
the old behaviour before commit b35316fb67: CONFIG_SPL_SKIP_RELOCATE was
only defined if CONFIG_SPL_BUILD was defined.

Fixes: b35316fb67cb ("Convert CONFIG_SPL_INIT_MINIMAL et al to Kconfig")
Signed-off-by: Martin Fäcknitz <faecknitz@hotsplots.de>
---
 arch/powerpc/cpu/mpc85xx/start.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc85xx/start.S b/arch/powerpc/cpu/mpc85xx/start.S
index 562b6993b9..318872f82b 100644
--- a/arch/powerpc/cpu/mpc85xx/start.S
+++ b/arch/powerpc/cpu/mpc85xx/start.S
@@ -1617,7 +1617,7 @@ relocate_code:
 	mr	r10,r5		/* Save copy of Destination Address	*/
 
 	GET_GOT
-#ifndef CONFIG_SPL_SKIP_RELOCATE
+#if !defined(CONFIG_SPL_SKIP_RELOCATE) || !defined(CONFIG_SPL_BUILD)
 	mr	r3,r5				/* Destination Address	*/
 	lis	r4,CONFIG_VAL(SYS_MONITOR_BASE)@h		/* Source      Address	*/
 	ori	r4,r4,CONFIG_VAL(SYS_MONITOR_BASE)@l
-- 
2.11.0

