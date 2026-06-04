Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD7ACD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BAB84957;
	Thu,  4 Jun 2026 22:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="bzDWbXQU";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="cDl5Hhwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF7E8849C5; Thu,  4 Jun 2026 22:41:55 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF83848DC
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-qw7b.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605713; 
 b=Z0talb/roplXYH2kzcQhmQfiZteCJWS2B/GwuCu9sAamMfx5iM5RjPTnNIJgtKhAFCmKIS/OUq
 PaGhq36Q6XCnEN/O7iy/XIZouyjYoPgOYHxWRYIO9lgpCBL3HkXr2B+iC7SVRturJXJLlmUAq2
 75Iza/78LeZ+T4voHii0QEDZa9d9s4ev87bewxceNVy48qyRms8viZa1ADnSYdrriP7gAeE1AM
 2nRfILpmXWWfV9Dmtl8UhYYJ37n8SoCslqmP7X8zld6KRpj7HCvZVyRF3dQbwl710SGn5rPomu
 EL2dRvnm96Zhxa98FejeObhxXWZJfs/zgl+gpZIvBiBGiQ==;
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
 s=arckey; t=1780605713; 
 bh=q/iZLYHYe5bIu3MWlVzDjlkL8AZTpHtqSekCiijF+tw=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=bm9GxwuJbdyCvEdCdOXsqsog8y3U13z3FK2ohUpnUy4EX/CdIJYcYjblUTV58mmIOBA0gT4sTN
 JKfJjJ1a2Fiof109p/g+/nRIAE5LqWXM1zVXc5RmRJEudZD8tm8xjF0P5qXUoE3o3hmzJGXllD
 dRUmqhiFW2wKoKEWwDSBG3042sDdeFicR4xCrV0krBSCAu8QfWAzEaVXM4GYbnJWszNrvMHpoI
 2zIrUBuhON1Y8f5adBr30szSG0rysMqbFDCXofEyr21XmTxkqkiZvIU1kH5J3UjVRNnzTmbwUU
 DEUGKtV7DZYD40yqM2S3xzi90Fp6StxNbREb2Jqu2oOE8Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=8MFUtW6a5iffrWyRf0V5odZT7HFbzaQ5SOqdc+ylrcc=; b=bzDWbXQUFbBbNxypNtjMjwdvJn
 fAySF+wJNaGkkS4JrSgHzHwiOGJCDLo0l4WqQEHmp3jH1qGVzVCu5fBVYBmmkWViRY8bvNk7zjcbd
 vejZ3y1lBo+WnHHpdBthoK8+8IErFcdHwtar2vMDR4SJmCLiSvaElISv1XZj1sygXIlE=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-qw7b.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <francesco@valla.it>) id 1wVEsx-00000005O52-2Zgq
 for u-boot@lists.denx.de; Thu, 04 Jun 2026 20:41:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=8MFUtW6a5iffrWyRf0V5odZT7HFbzaQ5SOqdc+ylrcc=; b=cDl5Hhwgz/hAcDeQkQWUs0AvI0
 Kd+iVm6wd6oEKwMCZ3HOcQhMrIjW4gqvByP+nRXMU1OPz2FY2AUWA1aEkt0TATb2HyWMEgE6ElpHc
 CnBS8S/fkcaX2MC1bVKIuVCbYlTQHReimtGVhd/c3ecjlUJX/a74ynfltD5+9NwKri1g=;
Received: from [95.248.69.182] (port=60898 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wVEsj-00000000GnV-42Cw; Thu, 04 Jun 2026 20:41:37 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 04 Jun 2026 22:41:35 +0200
Subject: [PATCH 1/6] boot: fit: fix FIT verification in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-spl_fit_full_cleanup-v1-1-ec036b5872e2@valla.it>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=francesco@valla.it;
 h=from:subject:message-id; bh=q/iZLYHYe5bIu3MWlVzDjlkL8AZTpHtqSekCiijF+tw=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmKjxkiN37yrVzjKD6/ySJ0q/+P6HD9N4dnnKiafcOsZ
 vcmv1k/O0pZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJnNzF8N8zS3CS/9M45tqK
 c4GzxX7a22wyUFZs952/++Mvy/ezzboZGfr3rZP03bjqh7SiVcVbhT3mKv/7W3uW8rwrrREofHL
 gPCMA
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
X-SGantispam-id: 57907dc70db522c0172beeea76dad33c
X-AntiAbuse: ID - 57907dc70db522c0172beeea76dad33c
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wVEsx-00000005O52-2Zgq-feedback@antispam.mailspamprotection.com
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

Align the behavior of fit_image_verify() called in SPL to the one in
full U-Boot. In particular, this function is called when both
CONFIG_SPL_LOAD_FIT_FULL and CONFIG_SPL_FIT_SIGNATURE are set (which can
happen e.g. in case of secure falcon boot).

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17fa..6723a5e659fc 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1439,7 +1439,7 @@ int fit_image_verify(const void *fit, int image_noffset)
 	size_t		size;
 	char		*err_msg = "";
 
-	if (IS_ENABLED(CONFIG_FIT_SIGNATURE) && strchr(name, '@')) {
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE) && strchr(name, '@')) {
 		/*
 		 * We don't support this since libfdt considers names with the
 		 * name root but different @ suffix to be equal

-- 
2.54.0

