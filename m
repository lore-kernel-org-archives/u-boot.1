Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442E3CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB418491C;
	Wed, 10 Jun 2026 16:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="c7suSpDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8498489F; Wed, 10 Jun 2026 16:17:20 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D358848D1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C09E4C58472;
 Wed, 10 Jun 2026 14:17:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D23645FFC9;
 Wed, 10 Jun 2026 14:17:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 15803106B9A0B; 
 Wed, 10 Jun 2026 16:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781101037; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XZ3k1aRZQwXuL00MUpkQxv6RW20V7+TNXGXluJTeXV0=;
 b=c7suSpDLrtCDWTu9k5wXLOOjGAuL8pfmhB1zvbt2w8XFhFTrHUtwfh45XtAFyS6afqoBYA
 nYdnxaSQpoLm+/N1LbQVjjn6EHtgWGCH7Tz/8n37GG523ydbokVZpiyYvN0nzpuRkTTQZL
 h25513E/PcTK2mL+HruVCEGba4kO0KIGjNxccLRtzKCh7RP7Ge/DxSDeVrOfP3ksMBUBly
 06O2h+xQhTYEmfolYAnTYZTzgHWTb+41IJJbp3UkWUP7I0YEfxCB2vTT8vcA4VQNDMb4dk
 UrcFhWM85hckhNOX+dXsHHN+x2O88U7pb/Qi5WfhQ7ci0ocJviuk8WEgsC9O4A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 10 Jun 2026 16:17:09 +0200
Subject: [PATCH v2 1/2] binman: Add optee binary to i.MX9 platform types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mathieu-optee-fix-v2-1-197aee94b7ad@bootlin.com>
References: <20260610-mathieu-optee-fix-v2-0-197aee94b7ad@bootlin.com>
In-Reply-To: <20260610-mathieu-optee-fix-v2-0-197aee94b7ad@bootlin.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781101032; l=1013;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=7TYyY85eFzfZLsF04HDS2qoVNHGCa1wx16VgroxHDks=;
 b=+xsGRMQRLvWaBvpplTPpC+GkiSpIrrgdB+6QynoYlY4RDfcqkXZMWCBkDOrmGyjtwLgeEHzSQ
 F0ReQ1j2fK7DD9xEXJ1CX4Rs5L+9hwWHIKRZTRpaORs4bgg+tO9OxOj
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
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

OP-TEE tee.bin is generated externally and might be missing during the
build.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 tools/binman/etype/nxp_imx9image.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/nxp_imx9image.py b/tools/binman/etype/nxp_imx9image.py
index e0e806f2b7f3..138563ba33ae 100644
--- a/tools/binman/etype/nxp_imx9image.py
+++ b/tools/binman/etype/nxp_imx9image.py
@@ -36,7 +36,8 @@ class Entry_nxp_imx9image(Entry_mkimage):
             'append', 'boot-from', 'cntr-version', 'container', 'dummy-ddr',
             'dummy-v2x', 'hold', 'image', 'soc-type'
         ]
-        external_files = ['oei-m33-tcm.bin', 'm33_image.bin', 'bl31.bin']
+        external_files = ['oei-m33-tcm.bin', 'm33_image.bin', 'bl31.bin',
+                          'tee.bin']
 
         with open(self.config_filename, 'w', encoding='utf-8') as f:
             for prop in self._node.props.values():

-- 
2.47.3

