Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A54606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RHddyX1I;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EHe3oZN7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E7D9608AB;
	Wed, 25 Nov 2026 10:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEdx1mvuEETT; Wed, 25 Nov 2026 10:58:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBD19608AD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604327;
	b=Uc1ah1TYEUeAfpv7QV67wzly8bg06luDecXmA7AHNG+xadtbRlfsQMblOHB/HUi6wh24
	 bRbWsYePrx1NdoLhTVT6ZNm9zLlMKUWQUf8ShrlAbrUcj2OM2hY92VvPJ76TQ1Gd1cI1y
	 4OeHBVU/Djt5pAhBXiK32rdEs5Tfl+OH3HOiXCwFUrhXPlc/5EqibajYsH4kJBvQgHgxK
	 PT3vDV3yu3T7Rf98es8+KK8hZpaVGbv5pFQmnCyfhBU+PiIyQ/1fWNE/5yhA330tsR2Rr
	 LZsyxNeA4TjwoRQno+4+huGLrcgwQn6lQnQA88cbSQ8TI1+A7Tg/Ph/9pGUGSnCVfjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lSwApNLbQienEBCK86Dz8kbPKmDRzLXZNPWJLEQN4AU=;
	b=Bt6QT6BDWumviQODFolLKjZGYeqZXavr8cjhqgW4G1kh0BwdslH8ZRiQcMUwo78txueo
	 9k9ErGXtkpmVfQK7A12I3LTbduL8pwI7V2fUn4IMMxHmIsRuC0UyYx2vcyA3/CNWL7W1Q
	 MP6tsP7qijvSASmGCwjmoOPcjSlhl9RZmZQ0VHHs6wo/enArgtAjb7fDdQ8air1+nig1o
	 n7Jh4wi9URYHQeVbjXPGjPO+yDFiwexZ25nqyfCm9ERYloW6KcyIhpAT1N2iCV1y/CNwS
	 y9ysBPZ74Kxil2nNK7kBcRnKjQucjUgBkG8qFfP/JfD6wR2q4My9FpfoZRBXasfRkag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EHe3oZN7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604327;
	bh=lSwApNLbQienEBCK86Dz8kbPKmDRzLXZNPWJLEQN4AU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RHddyX1INA90onnsWVRO0VS43v6ebPnQTf45kLNHq3UFxpQ7dTI0uc43kXDmEGOvs
	 D7c3niHrw+mbxr+v5b4ISgaDhu3O67kYJMxdLq1Dkpqykq6KxCzf6PldXrLWTy1ZRO
	 rZOf/QNuPmCPGNpV4uAAzWD9HE5StML4OTA5Pm9/HvjkPDNoWkX0AXviQ152CZzKGK
	 USrXixaxhOgOoXI7d/10IZm3fNW6TTv3akvU7CYHPU+1Gdrlq6e6slGwD5WKrzYy9H
	 eUApLZAUdku5eGGu27E56Doei6PDJIIq8g8VZKZkTWODR/qN3hE6RzCNYh19cz1q9C
	 PRK8OytXiSYPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBD19608AD;
	Wed, 25 Nov 2026 10:58:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BF13325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26E0A607A7
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXl0lBEzcIq1 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0D72606A8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EHe3oZN7
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0D72606A8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:37 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so26357675e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604315; x=1796209115;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSwApNLbQienEBCK86Dz8kbPKmDRzLXZNPWJLEQN4AU=;
 b=EHe3oZN7w5YMhMqIIyYJN+OypRp/sr9w47OjzQnA1mDWQSyQQQNkKNFRIOJvkV/XEG
 EJ4WJInyhvbkfM0uGD/623R8S6A523vmn/LP5EIfuQG3HCjvhXDniojLwZQJYJx7CsW4
 453k5+E80d8gE7BkTI325c5zF8AU+zYxoIXOlSEIzvqvo/la5SL9rHDTumkagJU7Ytzs
 pl3HQmz+8k9OBqS6DKXrVZAU5p+H3JpMT0fYIFhpdnHQVG3T6QV317YUNSUDoo+teHSa
 xIRTwWz0nr1ixrbCFjbExWu2TCAKghiDj1M8dyoARdQUeDp8k/TfhQMqpm8AlXcptXsk
 8T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604315; x=1796209115;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lSwApNLbQienEBCK86Dz8kbPKmDRzLXZNPWJLEQN4AU=;
 b=IQNPPm+iz8Gr2L71UJSqTS9g9xWeS69N2IBpkDcUJE7mroSCfC8TDbdicseKi7cxcZ
 wQH4h4EX4dmWdv28kX3UqtN2rMt+rNdBihelkGrdgKfSBWxOmCHARRDVVKq2Qbc3/KuX
 WBSScFrFfbtnx83VmSBzjY/LqUonlMM/gv57HP4CRbsr5lt0XenRB/tko9hMqIu9e6Kr
 8us8O8Ol5NKOirjuUm2KgKnqO0FMB9N7xJ9XltvJCXIx0xjFewKrjJWILBx76VsVNrDN
 cmj7ivr3eyOh63aXPKsvuwAI/pxtQ5/AzAiqabhEqWeE7ZG4Z1/43vvDdIUqI034ZyYI
 FB5Q==
X-Gm-Message-State: APuU4Z+HZYhgFSo60gLGndJDReAfUpAXhwqKtWZyuCP5WzzNLNKlQ6Nx
 6WtcvKz0VeyND4HEyY11ZpVQlULtaBhfaMDBengbSWiCCzOjWuyTULJDlng3mH/sJJMLmD7VPD5
 nfrRZZEKLLA==
X-Gm-Gg: AZFdTZcRWr0VW/jr4iUZ50RUOEKHJIk19BkEmwtE4A9DmgE0Tfb2cFYrMGJbu2oBFpz
 6aB3/vZuKypOfBB8QCGtQfHonZQ5uuBlB+vFCz1KvslSbMP3OqnByDWM8m77Ztqu+361M4F6xap
 +mZwnAM6k6Y7n+qb5j/UbhEjLXW4rqWKTb2PXJvCpEHcJ1yIRxeWUmqm8ZOBMdpRB9R901coVQQ
 8jQyk2hYHGf6Qb35ToRs91ZhVnFwOCskYHV2818ut6arESTqR89GBHI4PbhOs4H7Ry/2+08dalj
 hOR0Fr4uQWamwFxOKshCrS0L2LNlwMdUA+SvXq0F9k0ZH2viC0R/ke6JWjYqI4lLEemOR466AOH
 YjXNiTBLssLvCGXzTPMHFJClcQAbUV+6B3SijwL5P7xCBWdeagtRbR5RmKnDAV9pV2AJsqtxeI8
 c7+fiOol+qU5egP5T/fnz1NtK8UM4OUdH37tT7ZM4Th4Xt5Rl3bjxHD0d5i+yl9orJDBrO7pO/x
 gKAJK++3t4/SGVZ1EKdTIfhAQ+epXpb0YCBoHd4PVc8F+VKkAhm7tdUrOsWFOnj3um2KvatO5pz
 +HbUytbNRLdaRizgNBQHk4eSDMQL+XFIk/17mYBwlnd70zI6IoHHz6nDnqTGe9K4m5yanDcDSA=
 =
X-Received: by 2002:a05:600c:4f0f:b0:4bb:87f4:3674 with SMTP id
 5b1f17b1804b1-4bb8880ef40mr443625735e9.15.1795604315367; 
 Wed, 25 Nov 2026 02:58:35 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm615710715e9.6.2026.11.25.02.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:35 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:13 +0100
Subject: [PATCH v2 04/11] env: flash: Factor out the sector erase and write
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-4-8d31a33a54d2@baylibre.com>
References: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
In-Reply-To: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Fiona Klute <fiona.klute@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adding an erase operation to the flash environment driver would
duplicate the sector erase and write code of both env_flash_save()
variants.

Factor it out into env_flash_rewrite_sect().
This also fixes both variants, which returned success when the sector
erase failed.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 env/flash.c | 238 +++++++++++++++++++++++++++---------------------------------
 1 file changed, 106 insertions(+), 132 deletions(-)

diff --git a/env/flash.c b/env/flash.c
index 3130b35250d0..7697afa340e5 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -67,6 +67,98 @@ static ulong __maybe_unused end_addr_new =
 static env_t __maybe_unused *flash_addr_new;
 #endif /* CONFIG_ENV_ADDR_REDUND */
 
+#ifdef CMD_SAVEENV
+/* Erase addr, then write env_new, the obsolete flag and tail_data, if set */
+static int env_flash_erase_write(ulong addr, ulong end, env_t *env_new,
+				 uchar *obsolete_flag, char *tail_data)
+{
+	int err;
+
+	puts("Erasing Flash...");
+	debug(" %08lX ... %08lX ...", addr, end);
+	if (flash_sect_erase(addr, end))
+		return -EIO;
+
+	if (env_new) {
+		ulong data = addr + offsetof(env_t, data);
+
+		puts("Writing to Flash... ");
+		debug(" %08lX ... %08lX ...", data, data + ENV_SIZE);
+		err = flash_write((char *)env_new, addr, CONFIG_ENV_SIZE);
+		if (err) {
+			flash_perror(err);
+			return -EIO;
+		}
+	}
+
+	if (obsolete_flag) {
+		char flag = ENV_REDUND_OBSOLETE;
+
+		err = flash_write(&flag, (ulong)obsolete_flag, sizeof(flag));
+		if (err) {
+			flash_perror(err);
+			return -EIO;
+		}
+	}
+
+	if (tail_data) {
+		ulong tail = CONFIG_ENV_SECT_SIZE - CONFIG_ENV_SIZE;
+
+		debug("Restoring the rest of data to 0x%lx len 0x%lx\n",
+		      addr + CONFIG_ENV_SIZE, tail);
+		err = flash_write(tail_data, addr + CONFIG_ENV_SIZE, tail);
+		if (err) {
+			flash_perror(err);
+			return -EIO;
+		}
+	}
+
+	puts("done\n");
+
+	return 0;
+}
+
+/*
+ * Erase the environment sector at addr and write env_new to it, or leave
+ * it erased when env_new is NULL. The rest of the sector is kept.
+ */
+static int env_flash_rewrite_sect(ulong addr, env_t *env_new,
+				  uchar *obsolete_flag)
+{
+	ulong	end = addr + CONFIG_ENV_SECT_SIZE - 1;
+	char	*tail_data = NULL;
+	int	rc;
+
+	if (CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE) {
+		ulong tail = CONFIG_ENV_SECT_SIZE - CONFIG_ENV_SIZE;
+
+		debug("Data to save 0x%lx\n", tail);
+		tail_data = malloc(tail);
+		if (!tail_data) {
+			printf("Unable to save the rest of sector (%lu)\n",
+			       tail);
+			return -ENOMEM;
+		}
+		memcpy(tail_data, (void *)(addr + CONFIG_ENV_SIZE), tail);
+		debug("Data (start 0x%lx, len 0x%lx) saved at 0x%p\n",
+		      addr + CONFIG_ENV_SIZE, tail, tail_data);
+	}
+
+	debug("Protect off %08lX ... %08lX\n", addr, end);
+	rc = flash_sect_protect(0, addr, end);
+	if (rc)
+		goto protect;
+
+	rc = env_flash_erase_write(addr, end, env_new, obsolete_flag,
+				   tail_data);
+protect:
+	flash_sect_protect(1, addr, end);
+	free(tail_data);
+
+	return rc;
+}
+#endif /* CMD_SAVEENV */
+
 #ifdef CONFIG_ENV_ADDR_REDUND
 #ifdef INITENV
 static int env_flash_init(void)
@@ -126,78 +218,24 @@ static int env_flash_init(void)
 static int env_flash_save(void)
 {
 	env_t	env_new;
-	char	*saved_data = NULL;
-	char	flag = ENV_REDUND_OBSOLETE, new_flag = ENV_REDUND_ACTIVE;
-	int	rc = 1;
-#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
-	ulong	up_data = 0;
-#endif
-
-	debug("Protect off %08lX ... %08lX\n", (ulong)flash_addr, end_addr);
-
-	if (flash_sect_protect(0, (ulong)flash_addr, end_addr))
-		goto done;
-
-	debug("Protect off %08lX ... %08lX\n",
-		(ulong)flash_addr_new, end_addr_new);
-
-	if (flash_sect_protect(0, (ulong)flash_addr_new, end_addr_new))
-		goto done;
+	int	rc;
 
 	rc = env_export(&env_new);
 	if (rc)
 		return rc;
-	env_new.flags	= new_flag;
+	env_new.flags	= ENV_REDUND_ACTIVE;
 
-#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
-	up_data = end_addr_new + 1 - ((long)flash_addr_new + CONFIG_ENV_SIZE);
-	debug("Data to save 0x%lX\n", up_data);
-	if (up_data) {
-		saved_data = malloc(up_data);
-		if (saved_data == NULL) {
-			printf("Unable to save the rest of sector (%ld)\n",
-				up_data);
-			goto done;
-		}
-		memcpy(saved_data,
-			(void *)((long)flash_addr_new + CONFIG_ENV_SIZE),
-			up_data);
-		debug("Data (start 0x%lX, len 0x%lX) saved at 0x%p\n",
-			(long)flash_addr_new + CONFIG_ENV_SIZE,
-			up_data, saved_data);
-	}
-#endif
-	puts("Erasing Flash...");
-	debug(" %08lX ... %08lX ...", (ulong)flash_addr_new, end_addr_new);
-
-	if (flash_sect_erase((ulong)flash_addr_new, end_addr_new))
+	debug("Protect off %08lX ... %08lX\n", (ulong)flash_addr, end_addr);
+	rc = flash_sect_protect(0, (ulong)flash_addr, end_addr);
+	if (rc)
 		goto done;
 
-	puts("Writing to Flash... ");
-	debug(" %08lX ... %08lX ...",
-		(ulong)&(flash_addr_new->data),
-		sizeof(env_ptr->data) + (ulong)&(flash_addr_new->data));
-	rc = flash_write((char *)&env_new, (ulong)flash_addr_new,
-			 sizeof(env_new));
+	rc = env_flash_rewrite_sect((ulong)flash_addr_new, &env_new,
+				    &flash_addr->flags);
+done:
+	flash_sect_protect(1, (ulong)flash_addr, end_addr);
 	if (rc)
-		goto perror;
-
-	rc = flash_write(&flag, (ulong)&(flash_addr->flags),
-			 sizeof(flash_addr->flags));
-	if (rc)
-		goto perror;
-
-#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
-	if (up_data) { /* restore the rest of sector */
-		debug("Restoring the rest of data to 0x%lX len 0x%lX\n",
-			(long)flash_addr_new + CONFIG_ENV_SIZE, up_data);
-		if (flash_write(saved_data,
-				(long)flash_addr_new + CONFIG_ENV_SIZE,
-				up_data))
-			goto perror;
-	}
-#endif
-	puts("done\n");
+		return rc;
 
 	{
 		env_t *etmp = flash_addr;
@@ -210,17 +248,7 @@ static int env_flash_save(void)
 		end_addr_new = ltmp;
 	}
 
-	rc = 0;
-	goto done;
-perror:
-	flash_perror(rc);
-done:
-	free(saved_data);
-	/* try to re-protect */
-	flash_sect_protect(1, (ulong)flash_addr, end_addr);
-	flash_sect_protect(1, (ulong)flash_addr_new, end_addr_new);
-
-	return rc;
+	return 0;
 }
 #endif /* CMD_SAVEENV */
 
@@ -244,67 +272,13 @@ static int env_flash_init(void)
 static int env_flash_save(void)
 {
 	env_t	env_new;
-	int	rc = 1;
-	char	*saved_data = NULL;
-#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
-	ulong	up_data = 0;
-
-	up_data = end_addr + 1 - ((long)flash_addr + CONFIG_ENV_SIZE);
-	debug("Data to save 0x%lx\n", up_data);
-	if (up_data) {
-		saved_data = malloc(up_data);
-		if (saved_data == NULL) {
-			printf("Unable to save the rest of sector (%ld)\n",
-				up_data);
-			goto done;
-		}
-		memcpy(saved_data,
-			(void *)((long)flash_addr + CONFIG_ENV_SIZE), up_data);
-		debug("Data (start 0x%lx, len 0x%lx) saved at 0x%lx\n",
-			(ulong)flash_addr + CONFIG_ENV_SIZE,
-			up_data,
-			(ulong)saved_data);
-	}
-#endif	/* CONFIG_ENV_SECT_SIZE */
-
-	debug("Protect off %08lX ... %08lX\n", (ulong)flash_addr, end_addr);
-
-	if (flash_sect_protect(0, (long)flash_addr, end_addr))
-		goto done;
+	int	rc;
 
 	rc = env_export(&env_new);
 	if (rc)
-		goto done;
+		return rc;
 
-	puts("Erasing Flash...");
-	if (flash_sect_erase((long)flash_addr, end_addr))
-		goto done;
-
-	puts("Writing to Flash... ");
-	rc = flash_write((char *)&env_new, (long)flash_addr, CONFIG_ENV_SIZE);
-	if (rc != 0)
-		goto perror;
-
-#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
-	if (up_data) {	/* restore the rest of sector */
-		debug("Restoring the rest of data to 0x%lx len 0x%lx\n",
-			(ulong)flash_addr + CONFIG_ENV_SIZE, up_data);
-		if (flash_write(saved_data,
-				(long)flash_addr + CONFIG_ENV_SIZE,
-				up_data))
-			goto perror;
-	}
-#endif
-	puts("done\n");
-	rc = 0;
-	goto done;
-perror:
-	flash_perror(rc);
-done:
-	free(saved_data);
-	/* try to re-protect */
-	flash_sect_protect(1, (long)flash_addr, end_addr);
-	return rc;
+	return env_flash_rewrite_sect((ulong)flash_addr, &env_new, NULL);
 }
 #endif /* CMD_SAVEENV */
 

-- 
2.56.1

