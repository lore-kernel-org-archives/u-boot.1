Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1591DCD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC1184944;
	Thu,  4 Jun 2026 22:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="u8cfqSH6";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="JaeJK8t6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4710A84957; Thu,  4 Jun 2026 22:49:22 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A509844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-qw7b.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780606160; 
 b=g2kEfuWLmUmK6HUruTuyzGcvv3pWf6bArAIHv7rPc1f+rcclPWxqXHRcafqgToCuLiMV2hwzg7
 Hk6neF+pvkhzgCA2WOfFGiLlznbCiu0BpcFa/0dhr/3C3xM6S25jcj4uOLn1hXH7tS5LAeY8tg
 l+ffvxAAc5Za8p7id1xge68Zkjf9MgxTcHJNduDypgq/fM5KgeI2G7H3VWNFTKeuS5HXaz2z0M
 2OLLAJ98i9AbtiNNcO3Y24PqMmcx7nd7p0KJKOW+mvZiBzdH++eDsW2XkJ1BDhioM/RK12WH37
 tB2Tx9qNp8p2j2s9L6KkTiK4wmSrumkUI0H97mTcqMatrw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-qw7b.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-qw7b.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780606160; 
 bh=LeBmOzQkwOJWAgS1dCAZmfmnaY+BgcYK1pcCC0cxX8k=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=BKMvDsOa6yvVgSny8O0VK7oNfibnmZD9TXSdhwWZ5EZgvyyQxZbyxRWGdUdQoEjiWr4ytZglIo
 +CmzFWU485sLmmpWOTbU1W3+4zIf+XaflDpEQoE4JH913PvDtR45Z3IwGXjTaxcJqmiyvURSDo
 c0jpLWXOkjGP8PEv1d/ZCBTMcIKfTFV6YkMQDr0aFIfuRcUy3+a1QtwqpF1Svo0tlGS1KVc7Im
 gh2nRF4ylis7KI0V+WHcmSZGk0F4U1m3z6eWOnr26ToFKWVBwTtr5NgwnEsJ6hdh7+OnEzQ5H4
 2S6vvHUwoFvvX0M1KH6lOiM3g4od+6lwlk5pDxW/guwmvw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=7yUk4AAGZqyEMOWnECMP5oLU52Wkkq9bz/RMHwUB1LA=; b=u8cfqSH6oD1sUbjYr2JtNOZkuL
 3wmEfirtyb9pSzGFRDA8vU/7T9rC3yJtQ411AmS3G5wnwxDVmjjJpRRZBZxyXcpclnGMxwEXTmDcT
 KHKjIc5kME/4z38tNpkzBe0/BCz+DHcUWWl+eD+W5k22LOUbmnYfZz778RWL5L8f5aoI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-qw7b.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <francesco@valla.it>) id 1wVF09-00000005ZD5-3qKA
 for u-boot@lists.denx.de; Thu, 04 Jun 2026 20:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=7yUk4AAGZqyEMOWnECMP5oLU52Wkkq9bz/RMHwUB1LA=; b=JaeJK8t69/JdrR6DFPzQoZhyYY
 3dVdAqwNxKtdMSCpL+NoFOXqIUNg1EAkxtGE8izBraRxnvS10UP1e+0KA+fkCsIoambDkTDZxgMs6
 BpTBSrw6nfQHcYA7/lKdYP8c/MZxha6YkkZsg5sVq9KIXS/3lKBEtrQ/YOFFwock/XFE=;
Received: from [95.248.69.182] (port=60898 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wVEsm-00000000GnV-0MRo; Thu, 04 Jun 2026 20:41:40 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 04 Jun 2026 22:41:39 +0200
Subject: [PATCH 5/6] spl: fit: use CONFIG_IS_ENABLED whenever possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-spl_fit_full_cleanup-v1-5-ec036b5872e2@valla.it>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=francesco@valla.it;
 h=from:subject:message-id; bh=LeBmOzQkwOJWAgS1dCAZmfmnaY+BgcYK1pcCC0cxX8k=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmKjxkiC2a7+fRnR8nsm7v8kv+RD9uvf/+oIq/DpnnIL
 9JF82FpRykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjAR7hkM/8uc2+MfsJoEiD1n
 FZqaskjbYuecoyu36Ej9vaGeMrfvmA0jQ9Ot2tv3OQ6U5n9MmLPy1F6DI523p89wZLv56Ejoxxu
 BRgwA
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
X-SGantispam-id: d04cc9a3dc034e960de68ac2890bf170
X-AntiAbuse: ID - d04cc9a3dc034e960de68ac2890bf170
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wVF09-00000005ZD5-3qKA-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-qw7b.prod.antispam.mailspamprotection.com; 
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

Replace #ifdef directives with the CONFIG_IS_ENABLED() for better
coverage and cleaner code. In the mean time, convert the last
IS_ENABLED() to CONFIG_IS_ENABLED().

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 common/spl/spl_fit.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index e1c8b1c9b698..d89384449b38 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -775,7 +775,7 @@ static int spl_simple_fit_parse(struct spl_fit_info *ctx)
 	if (ctx->conf_node < 0)
 		return -EINVAL;
 
-	if (IS_ENABLED(CONFIG_SPL_FIT_SIGNATURE)) {
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
 		printf("## Checking hash(es) for config %s ... ",
 		       fit_get_name(ctx->fit, ctx->conf_node, NULL));
 		if (fit_config_verify(ctx->fit, ctx->conf_node))
@@ -955,9 +955,8 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	int idx, conf_noffset;
 	int ret;
 
-#ifdef CONFIG_SPL_FIT_SIGNATURE
-	images.verify = 1;
-#endif
+	images.verify = CONFIG_IS_ENABLED(FIT_SIGNATURE);
+
 	ret = fit_image_load(&images, virt_to_phys((void *)header),
 			     NULL, &fit_uname_config, IH_ARCH_DEFAULT,
 			     IH_TYPE_FIRMWARE, -1, FIT_LOAD_OPTIONAL,
@@ -984,9 +983,8 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	debug(PHASE_PROMPT "payload image: %32s load addr: 0x%lx size: %d\n",
 	      spl_image->name, spl_image->load_addr, spl_image->size);
 
-#ifdef CONFIG_SPL_FIT_SIGNATURE
-	images.verify = 1;
-#endif
+	images.verify = CONFIG_IS_ENABLED(FIT_SIGNATURE);
+
 	ret = fit_image_load(&images, virt_to_phys((void *)header), NULL,
 			     &fit_uname_config, IH_ARCH_DEFAULT, IH_TYPE_FLATDT,
 			     -1, FIT_LOAD_OPTIONAL, &dt_data, &dt_len);
@@ -1013,9 +1011,8 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 					FIT_LOADABLE_PROP, idx,
 				NULL), uname;
 	     idx++) {
-#ifdef CONFIG_SPL_FIT_SIGNATURE
-		images.verify = 1;
-#endif
+		images.verify = CONFIG_IS_ENABLED(FIT_SIGNATURE);
+
 		ret = fit_image_load(&images, virt_to_phys((void *)header),
 				     &uname, &fit_uname_config,
 				     IH_ARCH_DEFAULT, IH_TYPE_LOADABLE, -1,

-- 
2.54.0

