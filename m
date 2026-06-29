Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F0C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478E684867;
	Mon, 29 Jun 2026 10:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="eFXztNVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B6DE84832; Mon, 29 Jun 2026 10:02:49 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4899A841F2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202606290802457a7de9ba6a000207c9 for <u-boot@lists.denx.de>;
 Mon, 29 Jun 2026 10:02:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RkEMlsS7GbOM3wB8srjbLKKi/7BTxZu/8y1OXoh/bXU=;
 b=eFXztNVh7l/XpKjAQfeCly3fKosJ3sD53NY3ymNwdvXzCHGl8Bj/xcGA4si6nc/Pe/87AD
 KznUpRlbo6sa9t6Ouu2+DM/AlTJeSwa5p0y+D2h04x4cT6deDDiMSeGlaKMStOVFbs0j30JW
 LBm4tDxeZh9b3htLsqBsifj8K25C3HljcTJ+JijMokqs1x608LwQHDyC1VBCAX7CLiuA1dYf
 qV5qoL4KwYQxZ/uJ9z8vK6BdyC6HyfifFF01QTSHT+lQAsRDzKN1IoSSRTur2oD6/9NALJyr
 jcCFza/qgkyMCi3wcIaeJHc3jU/PG58S+sM49mcTz2Uz6dDY5RlRpBsA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 6/6] Fix tcg2_measurement_init call
Date: Mon, 29 Jun 2026 10:01:05 +0200
Message-ID: <20260629080241.36311-4-ludwig.nussel@siemens.com>
In-Reply-To: <20260629080241.36311-1-ludwig.nussel@siemens.com>
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Needed to fix the previous, forward ported patch

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

(no changes since v1)

 lib/efi_loader/efi_tcg2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 1da0bc37fa1..5935cb2ac8c 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -870,13 +870,10 @@ static efi_status_t efi_init_event_log(void)
 	 * vendor_info_size is currently set to 0, we need to change the length
 	 * and allocate the flexible array member if this changes
 	 */
-	struct udevice *dev;
+	struct udevice *dev = NULL;
 	efi_status_t ret;
 	int rc;
 
-	if (tcg2_platform_get_tpm2(&dev))
-		return EFI_DEVICE_ERROR;
-
 	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
 				CONFIG_TPM2_EVENT_LOG_SIZE,
 				(void **)&event_log.log);
@@ -904,7 +901,7 @@ static efi_status_t efi_init_event_log(void)
 	 * platforms can use different ways to do so.
 	 */
 	event_log.log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
-	rc = tcg2_measurement_init(dev, &event_log, false);
+	rc = tcg2_measurement_init(&dev, &event_log);
 	if (rc) {
 		ret = (rc == -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERROR;
 		goto free_pool;
-- 
2.43.0

