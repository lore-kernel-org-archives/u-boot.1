Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65CDC27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A1788477;
	Thu,  6 Jun 2024 18:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="ENV+7vX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACFB88216; Thu,  6 Jun 2024 18:33:39 +0200 (CEST)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6048843A
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPSA id 4EA551C2B75;
 Thu,  6 Jun 2024 18:33:33 +0200 (CEST)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1717691613; bh=P+tgm4SM/H5pV84x1Fmbl2Ps5ssk3T0WiK1XXjIPD1g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=ENV+7vX1clyixFxnUnAAyeh8hTKYoixvhBju4QLTeXsoBpUtJPzm7VajJOiaZnyIJ
 PqW9fti1tnjm5hYhHKRcaybVbGuvt5Jl7LJy2icb0x8hjLFifVKyj79/nUOlhC9ZKI
 zYGTC9uzQPPXLbgTo3zJRMC8ZQnpjtONt+pfkeOU=
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de
Cc: kabel@kernel.org,
	marek.mojik@nic.cz
Subject: [PATCH 5/6] powerpc: use CONFIG_IS_ENABLED() when checking for
 DM_SERIAL in include/asm/config.h
Date: Thu,  6 Jun 2024 18:33:25 +0200
Message-ID: <20240606163326.386950-6-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606163326.386950-1-marek.mojik@nic.cz>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.10 / 20.00]; REPLY(-4.00)[];
 MIME_GOOD(-0.10)[text/plain];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]
X-Rspamd-Action: no action
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 4EA551C2B75
X-Spamd-Bar: ----
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
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

Use the CONFIG_IS_ENABLED() macro when checking for DM_SERIAL so that
CFG_SYS_NS16550_CLK is not defined as get_serial_clock() in SPL if SPL
does not have DM_SERIAL enabled.

Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
---
 arch/powerpc/include/asm/config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/config.h b/arch/powerpc/include/asm/config.h
index f0702cab14..f61f4e1ea6 100644
--- a/arch/powerpc/include/asm/config.h
+++ b/arch/powerpc/include/asm/config.h
@@ -39,7 +39,7 @@
 
 /* The FMAN driver uses the PHYLIB infrastructure */
 
-#if defined(CONFIG_DM_SERIAL) && !defined(CONFIG_CLK_MPC83XX)
+#if CONFIG_IS_ENABLED(DM_SERIAL) && !defined(CONFIG_CLK_MPC83XX)
 /*
  * TODO: Convert this to a clock driver exists that can give us the UART
  * clock here.
-- 
2.45.1

