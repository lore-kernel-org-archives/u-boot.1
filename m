Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60CDCD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 09:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D222784878;
	Wed, 10 Jun 2026 11:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="d1dQxTrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C49841C2; Wed, 10 Jun 2026 11:02:05 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2FA8485F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 11:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9P2KOB8VcEnTute3D2xHE3aGwb5I8e9y9mPEv4J45eQ=; b=d1dQxTrT17tjy5E20182Inyc4c
 p8pGi+sTR5H1OQarkQjm3Bc0wAUej7ibSp8K09HXwsKnU3AVJdy3kAcedkUjN20zOEMJEUX1fXEz0
 OGas1BYBB0eBkZinvVi3IXxL/CxYx0GQF75Gd9h71TglstRX2b3iCfTNQro5i6MOCwkzYL6NjzSrz
 xBmmmqMa60NzCC82gNmd977Ij0dddYTx7u8Z8K3l2O0AAqMDpo0xliycm5uKiBz9ZyLHjcgKLygCL
 CFIIQm3VCkxe8jx+W1KhD6iIaZWXjOj1hscRtd3re9uUMUi1BoaK/0PoqIza+RfP0lOALzblCs14S
 ULgp5dxw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wXEow-000Fgm-33; Wed, 10 Jun 2026 11:01:58 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wXEp7-0007Wr-1S; Wed, 10 Jun 2026 11:02:09 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 3/4] bootm: warn about load address for IH_TYPE_KERNEL_NOLOAD
 in FIT
Date: Wed, 10 Jun 2026 11:01:24 +0200
Message-ID: <20260610090125.99112-3-nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
References: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Jun 2026 11:31:59 +0200
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

The load address is ignored for IH_TYPE_KERNEL_NOLOAD. Instead of
failing the boot when none is set, it makes more sense to warn when it
*is* set.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 boot/bootm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index db29606021d..79f09b3b415 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -371,11 +371,17 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 		images.os.end = fit_get_end(images.fit_hdr_os);
 
 		if (fit_image_get_load(images.fit_hdr_os, images.fit_noffset_os,
-				       &images.os.load)) {
+				       &images.os.load) &&
+		    images.os.type != IH_TYPE_KERNEL_NOLOAD) {
 			puts("Can't get image load address!\n");
 			bootstage_error(BOOTSTAGE_ID_FIT_LOADADDR);
 			return 1;
 		}
+		if (images.os.load && images.os.type == IH_TYPE_KERNEL_NOLOAD) {
+			puts("WARNING: load address set for kernel_noload image, ignoring\n");
+			images.os.load = 0;
+		}
+
 		break;
 #endif
 #ifdef CONFIG_ANDROID_BOOT_IMAGE
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

