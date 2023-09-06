Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D69EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B91B486A6A;
	Wed,  6 Sep 2023 23:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bbQIryaQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ixH9f5Ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E68886A26; Wed,  6 Sep 2023 23:30:57 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FCD869EB
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXZ201Wz9tTZ;
 Wed,  6 Sep 2023 23:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V11cmVUv96dpP77pmPkjuk+xNsjHmf7azykA3DnEZWM=;
 b=bbQIryaQC4PVNkGr3yjxqw8prhLMJ6Aq02KRerCaVwZzMV9Hw+IZvqf4Mh8nMM8By7vCYl
 32JHYsjjvpryOab1pI04LwLYP1TjwukJWHBDBQawbmBUGmQNKz10EFCq7Xosva2uI5SjZv
 p5BbHiYh7fKl81CQd3xk3XUV5QGN7YYCcwOHMnHDitzt6URuuVNqvb7+M2akdRfCD8cGLE
 sJdAbtIoaP1bEjjWivHnPymOcHYao1FuQP7h+WDnQ2DyPbvFZv3jDE+dLIfiLc8MJjxbrI
 4fOwU0U4znxn/pua3Aq6Tn/0o8E/9ZGAoSnBpBvYvlgV3Fu0z4ZCACYvYWCHiw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V11cmVUv96dpP77pmPkjuk+xNsjHmf7azykA3DnEZWM=;
 b=ixH9f5Ms8ZZivDl9xbi+q/8l94MqORyk4HY6jaZXD47iO1ygnEYParPxZYOVhpKoAXAaRr
 pHfSkaiAY/B7CiePhOHKkZtJynwS1K/BbcWIdNTwLGKTJEQrtF2eAOl9Pw03YwRty+4E2j
 hCdO4NmjyWha8K5jVS8AIveu8m3g5gY/gtKBnJxqUjg5n0vQURbe8fSt647qooKP0DmSen
 bwQg3XA8QR4hCAqq0+vG1D8Q0tFTX9W15Kxd0Da4Luk8fl89WQ8TvVN+TtcqEWavujIzKq
 xxmWOygVPs3txxIspA8uEClfRkTpN4xFeDJXOxjt5SdE4pGNkLH1Z/vm1UcyKw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 22/35] crypto: rsa: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:02 +0200
Message-Id: <20230906213015.203437-23-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b1ff11c2c1a809ecc10
X-MBO-RS-META: 7e3bop445dju5zq6e6pdwktrob11p8aq
X-Rspamd-Queue-Id: 4RgwXZ201Wz9tTZ
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/crypto/rsa_mod_exp/mod_exp_uclass.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/crypto/rsa_mod_exp/mod_exp_uclass.c b/drivers/crypto/rsa_mod_exp/mod_exp_uclass.c
index 6a4d235d57b..057cc74b10b 100644
--- a/drivers/crypto/rsa_mod_exp/mod_exp_uclass.c
+++ b/drivers/crypto/rsa_mod_exp/mod_exp_uclass.c
@@ -16,24 +16,11 @@
 #include <asm/io.h>
 #include <linux/list.h>
 
-#if !defined(USE_HOSTCC) && defined(CONFIG_NEEDS_MANUAL_RELOC)
-DECLARE_GLOBAL_DATA_PTR;
-#endif
-
 int rsa_mod_exp(struct udevice *dev, const uint8_t *sig, uint32_t sig_len,
 		struct key_prop *node, uint8_t *out)
 {
 	struct mod_exp_ops *ops = (struct mod_exp_ops *)device_get_ops(dev);
 
-#if !defined(USE_HOSTCC) && defined(CONFIG_NEEDS_MANUAL_RELOC)
-	static bool done;
-
-	if (!done) {
-		done = true;
-		ops->mod_exp += gd->reloc_off;
-	}
-#endif
-
 	if (!ops->mod_exp)
 		return -ENOSYS;
 
-- 
2.40.1

