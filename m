Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB44CDB46F
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 11:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9124849D1;
	Mon, 22 Jun 2026 13:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YNyUc+yW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10682849BD; Mon, 22 Jun 2026 13:20:27 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BAE849BA
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 13:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kctJwTdYKj+2lsGEcqisifHHlazFA/wsdGSd/4LBS4Y=; b=YNyUc+yWgH59qJWJlpivaLw4x9
 NhAAhqhWcXPOsvBmZTY5HKhZSAxfkQar/N6e2Pdr+G6S3JWA7hxl2yF3BW4H28d5xbrhvfdm5vsNb
 0iu2mQHfWiSgQd4bOoO9TTKwe6VPIYMgcCji9ky9pTAzkTLMN7QfrBxhWSaq7t1I+VEFOMUWsPpdk
 aK8lkmEUXavYUvkT3FprmnotipLQDCsh79uv1ekcMbEhCx3aHoEzHav0Ocmiwc3Fg3xVsAuPCE/jN
 fWCMJTkkip012t8v3SE1YqNFt3+NaBQNYg1SIDcn3vGLO5OCTuZ9Iwso6qFDnsqC2UfrlbAOKJFb/
 2BF/a65Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wbchR-0002Xo-3D; Mon, 22 Jun 2026 13:20:22 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wbchQ-000N6e-2u; Mon, 22 Jun 2026 13:20:21 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 3/3] bootm: allow omitting entry point for
 IH_TYPE_KERNEL_NOLOAD
Date: Mon, 22 Jun 2026 13:19:33 +0200
Message-ID: <20260622111933.1488593-3-nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622111933.1488593-1-nora.schiffer@ew.tq-group.com>
References: <20260622111933.1488593-1-nora.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For IH_TYPE_KERNEL_NOLOAD, the entry point is given relative to the
image start, making 0 a valid default, and for IH_OS_EFI, it is ignored
altogether, so it may be preferable to omit it.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---

v2: no changes

 boot/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index b1cc6fe6c5c..1aeabdd5db1 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -429,7 +429,7 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 
 		ret = fit_image_get_entry(images.fit_hdr_os,
 					  images.fit_noffset_os, &images.ep);
-		if (ret) {
+		if (ret && images.os.type != IH_TYPE_KERNEL_NOLOAD) {
 			puts("Can't get entry point property!\n");
 			return 1;
 		}
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

