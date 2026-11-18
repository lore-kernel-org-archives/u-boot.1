Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92F606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CJr5VwKG;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HKrgGy/R
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7084407F0;
	Wed, 18 Nov 2026 00:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dbgtte0dvUw8; Wed, 18 Nov 2026 00:37:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E98BD40710
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794962253;
	b=pDdKuTEa9e4kV/xElE2SHVnCEX/haFeUpHOI6/SZpk3WxszRhB0tjDbMvhQfxyLiO2Gf
	 zmuxLgMKMaYipRfnhkZ6Vs7gsc3frytspr4ydgg3JPaG5k+BkIOcoS+Fg1zHegpbC+uYb
	 pJjXPDJckzfA19HgX8wxj3rZoNBOHmxW4/IXNJW0zn1TsOEgoZSOucJymG2CKQTQhXV7j
	 jHCjEasiZU6QuWkvO7Xl/bsf8KIxWfJHyfBDmlYkZlGYVBnhe8xnSFPIbXGfls0z8HUAK
	 6neCLDzP8gMDLrQXSAwJpuBbJu2YWOvAdxtz2Kqr+SkbtJClfUvrW33m5tm7ue/cUFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794962253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cDQCk7dOLa6eIT8qmFTYyY0v4JCbW82MdltBFeUT1cA=;
	b=M25UD8JcvFBY/6mKmZEInVxBDi0EJXFutCtqECsLtJVaRYTppvsFyVAeN7Q92czwThye
	 1gnW3ha902YmfSxZuThZ3mro8SmlZ900V8BoHFfha90tRRRVjy+dYYElpqpDDSKFqUItq
	 xRV+Op0odwDe+1NQ1MkPwykw0D612FnbFmi/vWmzmT0uj7Hv4XxvNPLi1QZnQUO/ATULs
	 4TdsQRwe2hajixg5TQzH4IAZgykHrqF2Nkr6jD3kRw3nfuMSzhs+jcDLcI1xK/tNztKjF
	 N2FbL7Mvyl4F59NPi0tOZ8lm0pIsxYLj6Arx7i2Fk+jAZHaphMX1ladYixC/xd1qXSg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="HKrgGy/R";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794962253;
	bh=cDQCk7dOLa6eIT8qmFTYyY0v4JCbW82MdltBFeUT1cA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CJr5VwKG5TnpgeWn2SSmDzFuhQbsq3vr692ha/7PGYEldA1QgyY9QoWnoKyVlA4OX
	 OkMJEqOfIGbcCgVbY1kbTGaY3q61wKJtj1sMPVj9nK+nMqDdH0I50XiogMuR34Y/ES
	 OY6eyKQP8PGWD1gU1RHMAEJYfoIYEZE2yQujmYrOODLk+LHpEWv/IjJStl8z7rU5GC
	 qAT06LoPUwm75Drlh2fOt+0b/ib+stQ/futgz5BH6axofZNdeHs1Q2XbdvltKOe66B
	 X0Hvj6zcM+CGIthFceRSGzUEPu6ct5HZ3UH00kEKAztRA9M3E3t7dPJvZBhEWvjYjN
	 uCtHLrJd4VCIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E98BD40710;
	Wed, 18 Nov 2026 00:37:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DEDF105
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F5FC406C8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZF1V7pQoByA for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 00:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A37240710
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HKrgGy/R
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A37240710
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:37:29 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6ddef424972so379422eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794962248; x=1795567048;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cDQCk7dOLa6eIT8qmFTYyY0v4JCbW82MdltBFeUT1cA=;
 b=HKrgGy/RjC/5r6aOikAAOTjB7h4Hgg5Gc7oW6KY0pk9NwERW4dtYApnnn8ksUOsXHi
 2GVYrVAG7jc9XPB8thxYisZid4IQFMST5dqWzzddurysOcqDyguGdGRIjbo66FGH18ba
 m+Lpd82HhrC9Z2dfH9T5rTgyIrsnOt7hJN8CJB1XZ00Qbe3GwFZv0nx+pLubr2yBn+wD
 2BmhKECebwC1WhZwYv3SOTYzwoS0B8H8SG4EubxDmLDit2SvopnH0Q7hP2zPExFrfalH
 K+iCh1jYK598zxUOxaKqmVrBi6AAIW0gjxH+muF9T+alvKg+PnReY2y57RnHOiwJazCi
 xENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794962248; x=1795567048;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cDQCk7dOLa6eIT8qmFTYyY0v4JCbW82MdltBFeUT1cA=;
 b=Yc0os2GuCRRzl9ms5vkzzoVa6UcrUx9CRkig/CH0Yp+fefAOBVSh9/Veu4YYAmqx7G
 rtzcMZPU9Ual1Drwk31sLcgp+/uGnGnTeR6V+kbP7JUQOT5qktNjC0i+6NBphvCTXpem
 lMMlxuTe0SF613mBiXvdArlv7x1MfwG+DnGjvOvYn4EIs4JTSsp596vCd4na0ymlaLQ2
 GKZBIfQatWUCs4KtU3ZuVqAaIUkmSTvA42BmHqi+li/hX9Hc9ThqFuQsTooG+yipjJET
 uewolPx+ysnKVKkSIpqi1y4VYhJSRKstGCncALXaBqxNyrDXhrZN6kBd0FkNrZZ5DlHg
 N2Vw==
X-Gm-Message-State: APuU4Z94NAc69Kp78+04cHehmFC/TQnPmDvT17UXODVr10ZT2ixkFJXJ
 mkJqzEd1RzlKhellbcD8c6lyd3oWe2Cw2FIojKrvlj9fQ8POPjmgTLizLs9RIrFEL/w=
X-Gm-Gg: AYBFou1jIMJRA5GCPVX74Ewz2peuDdnOKkh3yvX4mzk6sJWzSLczMV0kxLx9kHplXNB
 D8z9ix32yP5v4mU/jq3m7La8RmvHdOoddCPLocBX8OBRznq772qDX+99auG5Dcy7qfRWX5xVubc
 +3zvMXEhZITphGFwTmf6EsPyt1LZjDxszqtU0sxSqYd8jbdDdSd/J39ZB1KL7Jj++pYetmwfqp0
 5QfhethH4J2n0uNsRuubqB7jHE3Ib0popOkaexf83gqNTpqNoK9imdaPOWAWTvxCSk9wc/wMsEw
 C0MWjMliUxCnE5kfCopUBmzPksVNjE8rwheO5M4ixuIxE26kBsT8gqBG2xdT6jEjkhBQ5k1iOY0
 wLZ0T0VkMiUOov1+kC8M5Ct37rukw7AsT2bAdQg59OpxTM756Muf10b5Nl5gduasvP3gfme8dyr
 6fnA3Hyj3sHdcWBL1txL295uZxgLgGzjIbvLSeAL4PNLJ44p3UXBskUVROpu8995jqHD1x8QBm7
 ZHLIyCrj7mRL6ry4quZVD+/5Mvp0oSnFA1ndjfwa6qTMSssC6GquHhLtQT4Yroa49AOntfyY8jG
 5yJXQlr0sTwV1l6FBtROzIOAfJXcENhCaQ==
X-Received: by 2002:a05:6820:83d1:20b0:715:21d1:b81 with SMTP id
 006d021491bc7-71b18810accmr612501eaf.80.1794962248615; 
 Tue, 17 Nov 2026 16:37:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b19450af7sm730288eaf.4.2026.11.17.16.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:37:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Nov 2026 18:37:18 -0600
Subject: [PATCH] lib: sparse: fix raw chunk bounce buffer size with large
 blocks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-sparse-bounce-buffer-size-v1-1-bb0c4f7eb99f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6DMAwEv4J8biScVkTqV6oeQnDAPQRkN1VVx
 N8x5bQ7h5kVlIRJ4d6sIPRh5bkY4KWBNMUykuPBGHzrO0QMTpcoSq6fa0k2NWcSp/yz77v26mO
 4YUhg/iKU+ftvP54na+1flN5HELZtB1WTNLN9AAAA
X-Change-ID: 20261117-sparse-bounce-buffer-size-b26032a7417c
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VLMkjk6obreU4Ppf8UUGStUJnPPOTLXfBPeozqXP6tQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/PM/U6ZyXtl7qcZqDHLNl4P6/VJSJjy7+513k
 VWr0XlrwFKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavzzPxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvZAH/1ei5WgFn003aur5PUILUxe3w4Y8NfTYqjj90Cv
 RHV0idNeQb2WudGklW+ZKnEsqpR+unIYrREG5Y4QzNmIpsmu2i6oFk0G9v6VoiDj5HoNth2zWBm
 xPFYMOAJOlZ3bFWSb7on1vrMbJ7OSPzNFUe8eFpwMP2tQ2oSJjrMaxo/G22AQrpBXUEALzFdeJY
 5BWeB2JpgtYsXaBs566wyscjQS5cEhNkOmrphCCoOPBBB9Ue1TYJvvYNIdvkRRrS2e5eKR+bM5k
 KgIrGDQZWg6ZcXpHZixn1NX/qGUiI2q5QVVStEf09AJmfSkM3vVV2zmTfTpI9WEYOPvJZU/ObPN
 RxPQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Limit the bounce buffer for raw chunks to 8 MiB instead of
FASTBOOT_MAX_BLK_WRITE blocks. That is the same with 512-byte blocks,
but 64 MiB with the 4 KiB blocks of UFS, which is too much to allocate
with a small heap.

Fixes: b1aade87ca1f ("lib: sparse: allocate FASTBOOT_MAX_BLK_WRITE instead of small number")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 lib/image-sparse.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 48e5d8ee869..bbcae433f20 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -46,6 +46,8 @@
 
 #include <linux/math64.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
 
 static void default_log(const char *ignored, char *response) {}
 
@@ -55,7 +57,8 @@ static lbaint_t write_sparse_chunk_raw(struct sparse_storage *info,
 				       char *response)
 {
 	lbaint_t n = blkcnt, write_blks, blks = 0;
-	lbaint_t aligned_buf_blks = FASTBOOT_MAX_BLK_WRITE;
+	lbaint_t aligned_buf_blks = min_t(lbaint_t, FASTBOOT_MAX_BLK_WRITE,
+					  SZ_8M / info->blksz);
 	uint32_t *aligned_buf = NULL;
 
 	if (CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {

---
base-commit: 6201222134cd704b5717211fc917e2ca6263577a
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261117-sparse-bounce-buffer-size-b26032a7417c

Best regards,
--  
David Lechner <dlechner@baylibre.com>

