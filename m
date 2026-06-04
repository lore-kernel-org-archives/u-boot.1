Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948D6CD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79166849E4;
	Thu,  4 Jun 2026 22:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="FkZaxLQR";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="JOQ+9OVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E77A4849D1; Thu,  4 Jun 2026 22:41:58 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBF1849BD
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-zx4m.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605715; 
 b=WtP8hwPpWWK0JBUGcKQFLRcXEt1W/0zPA0lec4dpNSGftbAcpIDjyZCwYy+Na3J0chqeTOsW+r
 wZ0MuoZlKVJzzeDoOHbWLqJGt2yd/ZVMvo1Vd7EKHuVDVAJknqLMbFo1IQGDuiNdNDLhdGOsNx
 uupu7ZNG9JcZ72eRkOSpbrjDFT17vQTrxdCtsKMQsbV+ut4Ckaczt2UyxDxs2QzWwjW8kwVS4H
 X9kM+iNKo0SMYG9shh0jtQ0qtwN/wsYwoouoZOjFo8gaGhUwLEMOPlIfMYyEU9ajsZpXqKAuWi
 /S6A2PQuYlPvgh6ZYBOGep0hSVRwsn0IxiVSdnUWzbbhJA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-zx4m.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-zx4m.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605715; 
 bh=xQKEmBEgcCN8YLWNuMNUF+LhPDU9VqF8NbGhm30Kb5E=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=BFTbz1yk93+LX6MOTqLHPNHlxL7ddKCrbr1b+GBkcNXXl6lLJMeiO19aBoNxIpImFAek7sVzlg
 d1xMkwD2n13ypuNEqCNQ2r5IV2nEBGzPwALrm1zcmQiFAi6Ir/a4spzweHUbrDBvayF2UDheTP
 zMfm2hvVtNs/ZnjHiFXQx3QSgIDLR0K7HpHtTq8kL1rVQZ+mL9lbNSNV5zadnB9eijO9V4LdzT
 2mZyXUfQO+iSYyWNO2EFty0k+bikZ3TCzueww3Nb54d2BbqTu4rzkotqYGTeVhBrL60kt2uq54
 6wGqk243bekcfGlNO/iU0GD6aC79TEei2VdTnb9iO7J2Wg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=HMe/S4Guh63GFGWeZ+bg/aqPwU+1Eqm8Z1k/+DMojaA=; b=FkZaxLQRkaqUMXSOgurLFRuwwM
 Np3CzxiWT50RQjqq/wmtlOl3Dy7v0iT7tP5cXvwAEJe7lCj5MwSsGESKlnlDPdXFrufXImCjoQvGZ
 ZX4bvAjnVq07CK9koqlAydLoGoauIB7uuMB+tAK0Y8F2OmwzBuxgUvsr7e7OpykXiB/k=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-zx4m.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <francesco@valla.it>) id 1wVEsz-000000049Vy-1Uox
 for u-boot@lists.denx.de; Thu, 04 Jun 2026 20:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=HMe/S4Guh63GFGWeZ+bg/aqPwU+1Eqm8Z1k/+DMojaA=; b=JOQ+9OVT+BEZ24hCdgjK2Qgrs+
 BQ6OgyI44c9KBuPGKKI+xqQIbG4AdNTo2+mI95Krn7zYWC5La8CVV+w66K3XEnTaKCnqzDPI2p2Vu
 Gthaey/yGwAYai6Z1rybg2oygEcg+5KwslFuPDbZ9qmoXLfv5ntiHDq4dAR7CU1RlX1k=;
Received: from [95.248.69.182] (port=60898 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wVEsl-00000000GnV-2NSF; Thu, 04 Jun 2026 20:41:39 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 04 Jun 2026 22:41:38 +0200
Subject: [PATCH 4/6] spl: fit: drop the 'standalone' load attempt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-spl_fit_full_cleanup-v1-4-ec036b5872e2@valla.it>
References: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
In-Reply-To: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=francesco@valla.it;
 h=from:subject:message-id; bh=xQKEmBEgcCN8YLWNuMNUF+LhPDU9VqF8NbGhm30Kb5E=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmKjxkezZa5vfyWsumSyv2GuybOO86k0n/uv9hrlsNa0
 imWu5b/6ChlYRDjYpAVU2QJWXfj3p655t/SNjA+gpnDygQyhIGLUwAmIvCS4X/Z9mMTNe9/WvtP
 5ua6b9dEtu5mu3kmpuH1quhTm17Nu5rSzfA/+59Qu4CjhJXQr0/OzuGfRPr3z/79mPOEe26Iw/x
 HH24wAQA=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 6481639d4f96f04600f3475fa3fb29a9
X-AntiAbuse: ID - 6481639d4f96f04600f3475fa3fb29a9
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wVEsz-000000049Vy-1Uox-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-zx4m.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

The 'standalone =' config property has been deprecated for ~5 years [1],
with the loud warn about the deprecation lasting much more than the
foreseen couple of releases.

Remove the attempt to load the primary image through this property to
save some boot time and code complexity.

[1] https://lore.kernel.org/u-boot/20210401182531.2147653-5-mr.nuke.me@gmail.com/

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 common/spl/spl_fit.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1f3f7e549502..e1c8b1c9b698 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -959,18 +959,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	images.verify = 1;
 #endif
 	ret = fit_image_load(&images, virt_to_phys((void *)header),
-			     NULL, &fit_uname_config,
-			     IH_ARCH_DEFAULT, IH_TYPE_STANDALONE, -1,
-			     FIT_LOAD_OPTIONAL, &fw_data, &fw_len);
-	if (ret >= 0) {
-		printf("DEPRECATED: 'standalone = ' property.");
-		printf("Please use either 'firmware =' or 'kernel ='\n");
-	} else {
-		ret = fit_image_load(&images, virt_to_phys((void *)header),
-				     NULL, &fit_uname_config, IH_ARCH_DEFAULT,
-				     IH_TYPE_FIRMWARE, -1, FIT_LOAD_OPTIONAL,
-				     &fw_data, &fw_len);
-	}
+			     NULL, &fit_uname_config, IH_ARCH_DEFAULT,
+			     IH_TYPE_FIRMWARE, -1, FIT_LOAD_OPTIONAL,
+			     &fw_data, &fw_len);
 
 	if (ret < 0) {
 		ret = fit_image_load(&images, virt_to_phys((void *)header),

-- 
2.54.0

