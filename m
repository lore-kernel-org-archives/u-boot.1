Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50BDFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A01D846A5;
	Tue, 28 Apr 2026 22:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="JLq1e0+q";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="sxHnenZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930DF846A5; Tue, 28 Apr 2026 22:25:27 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633DB8467A
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407924; 
 b=XzjZupXsLvw+uFkL9NJLayLBqSquJa3y+P5bULnRU58qBsQQBblS/7/6i1ofB/dXKWFUayOTo9
 Tvrm/fMd6BZY1r23Ro4XHOro4ObCqOZMPZHiTKI2Bcwso6Swec/jhcdqoocYau8pTTyr/R3FI2
 Sobe2MXDwwVJfnbs9BFwM06kQ/22sWTG3uCsUAlAv91GgI+JIbyCgwvtIfTePMMqeaHbaSEnE5
 K7D82/70YUDW3T0tLhQ2qulHL/GZpQaU6zAsquWBUGhZDphhH6M7dFRFSKNJfRtD4ND6HO0RuX
 y7Sn6uIXBCciKR5geiDexsMnkYfEd1horMtEGJ4MzmSXhw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777407924; 
 bh=JXldWlksF/u6AqaeEah0UjogWUgGFjrKo+WV3/f1ghs=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=iMs8c+GsD+o24h3E0a3of/vWyafY0rUc7ebi+xrLwl/0pIRzIfwi7HZdNvQ/k61VM5xt2/6CaU
 OzdR6617ZPB1X/iIcZ/QMHrJC/lqJCRLit2krbGSDE/dclO6rmzj/1BH/Im7q/F0x4bwZK7O/q
 OK+StkqWbVVATZYgQKHeQu6XsrKAEeWFaT2mWEWh/a/23vcp0lRYFbFdMOBzbO5+D+fduB/5m3
 O5pOJz3Msg19uhF8FteFkQq1JaEKTw84obwDMnRfZ2Qx1it393wSXtX/8MrxD+uzZe3GqMQ8V3
 Y/SwepCzlsm/QI1fEmf5J1dmjILKlbzbJUBW51jud3f+ng==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=EmBjnh7aWboNK0adWhoL4InUo/DbI1WkwFUI2ibEHZw=; b=JLq1e0+qn9/brkvaDErngOXQZ7
 luAzPSgVfbq0PVe8u9UTUxCgHxUereqgQ2lrnPWrcsGb2Z293uDRr++Ky60KLtcMvUFUD6uVESJOI
 U9H0Wp8ee4jm2eWktvl/wLKuASFkm6qgH3NOrwex7nw2V8arXeyLyz5Qnec+obHx8lZg=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wHozh-00000002IeC-31TP
 for u-boot@lists.denx.de; Tue, 28 Apr 2026 20:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=EmBjnh7aWboNK0adWhoL4InUo/DbI1WkwFUI2ibEHZw=; b=sxHnenZi2fnrGhUNWBU+6T0Rdr
 0FdsxsnBMzvGeZVcgYvgHqYzr5YOImj/jq4YMXvcRbcyvfDXyUtHPh0wl+YX97PywH9DlwuZIGm4u
 sVc6LqKt2kF8gwRps/JvsCQjJJxrjXgIvW6KTNR1zpr1VLDUk1f8ujHCM1MNx4X4dugk=;
Received: from [95.248.129.24] (port=64167 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wHozM-000000002Bh-1F6w; Tue, 28 Apr 2026 20:25:00 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 28 Apr 2026 22:24:44 +0200
Subject: [PATCH 3/5] boot: fit: enable FIT image post-processing in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-spl_fit_full-v1-3-dde63beeaab1@valla.it>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>, 
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Michael Walle <mwalle@kernel.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 David Lechner <dlechner@baylibre.com>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=francesco@valla.it;
 h=from:subject:message-id; bh=JXldWlksF/u6AqaeEah0UjogWUgGFjrKo+WV3/f1ghs=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJkfxadHyvEuizq0K990jsSm1QFzF7x+V3z5z9vOlDkl0
 VMdj/xv7ChlYRDjYpAVU2QJWXfj3p655t/SNjA+gpnDygQyhIGLUwAmcomTkWHT5aQNfY1bgz/w
 Jr3X3KXJbeRhH3y1zX9+r9nCroBPwraMDNOOy0i+Zjbb+q1g8pXmYo1zRgoL434sOvwxbknQ3qf
 nW1gB
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
X-SGantispam-id: e35e4513ef152d7ccad355d6f998bf1f
X-AntiAbuse: ID - e35e4513ef152d7ccad355d6f998bf1f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wHozh-00000002IeC-31TP-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-w4q9.prod.antispam.mailspamprotection.com; 
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

Since CONFIG_SPL_FIT_IMAGE_POST_PROCESS is a valid configuration, allow
it to be used when using the "full" FIT loading logic in SPL.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index f3ddee940dbd..347304956a99 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2243,7 +2243,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	}
 
 	/* perform any post-processing on the image data */
-	if (!tools_build() && IS_ENABLED(CONFIG_FIT_IMAGE_POST_PROCESS))
+	if (!tools_build() && CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
 		board_fit_image_post_process(fit, noffset, &buf, &size);
 
 	len = (ulong)size;

-- 
2.54.0

