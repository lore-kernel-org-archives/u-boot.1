Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2086606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m8KaLREm;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CanLuTLZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9740608C3;
	Wed, 25 Nov 2026 10:58:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKRbhJKgVzzn; Wed, 25 Nov 2026 10:58:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A455608C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604333;
	b=XSIGcgD4kzL/2eT4ECzsxVR+15VTeB9T39aXthkYDUVfa61NPnnPQbJprtKK9A15P4Rx
	 nvkX9wiRVf8Lt3jE1ge8dflVgxnfLWU+PTAAbKpbka1MnndTYF/9XlLbRkpdb/iP1gZrR
	 4QcqnmUreyVOEAXZBGBFSkTdslCDMusdEaw8HdDKIjoJnugVUiVtxHhLgDi7PUUvHFS+x
	 DSPaKriodNC8A4NScLtyB+/+aH+2Km+XiHY5ytfR4rTT0WgXQWtElUxeyreJDeUfMnYpj
	 +vJ5Jxfdkr2MadwmVTbQzBYrtx3EOAwbuL00f9on1RB5vff32vRUrkuw7OTNGhRyJjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZdgVeD0cg+CSbtYJFXFa6HuTZpw2BVmEAQvLBHgq3hA=;
	b=gPz4Z+znec3QicRmNQnZoUoWF/JnvWI+TCORzLRAp9/q9YSnNhNhYOqb3h8gL5f1Hj89
	 5KItgV1jcASC87FNl7+i01qSRhmO2ZPLzDIF4RWW0373olREcLHWswbeMDnXC1I0F7vCy
	 9yHXPMoof8QOIbhrhALCahxuk7I4XtwVYMiGB+CvpuYOpsLcZY6v4wQdM9IKYMms4thLH
	 nLbn18sbh8A2Mdvani3qvOfoEZ+RFeNNcTtYUAXMQl+I6K7h+wFx1PgE8ehWY0+aBi5PP
	 EddiLGKQK7nF9OQqlSwaMmrSgLSU/uyS1uG0wmSemETYnY4QsNG+EPLmsMaGb92eiwA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604333;
	bh=ZdgVeD0cg+CSbtYJFXFa6HuTZpw2BVmEAQvLBHgq3hA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m8KaLREmsl2sMyOpvSe/7op5qhi6FDOvgsxkfLVk1j/aftNV2nYJNhKbwWP7tF8nZ
	 Dnd7buB0JZUbDEAJNGLyIa9tMKv46D6BAk7XxrKiht9eCOQQMxemYC94lvn8HAurfb
	 /bcNGgTyvKvLIjbuSw6ic6WwgYAc2WfGMHUbvLXC95ZUj25+iWC1PoThYVm4MqZ0bC
	 DSfOFanhYdqrIGRO84B8Ky7WTnMZvF6TgYPIkYn3hZN8w6kxcWkN/8Dnax7FSdykHi
	 sIOTm6N6E/NqK9l9fD2FVimWSNU0FFPvU7X0Yodci5Y2nnZD04ZH3SzWDg6YPIwKnU
	 yV3Jc8OI7+bbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A455608C7;
	Wed, 25 Nov 2026 10:58:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17F01325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F15A8401D2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9zTjs7cZl9TE for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE780400D6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CanLuTLZ
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE780400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:39 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so3597772f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604318; x=1796209118;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZdgVeD0cg+CSbtYJFXFa6HuTZpw2BVmEAQvLBHgq3hA=;
 b=CanLuTLZPOg5Sh3jxXnfmhS4W3Suu7lYyXCecrpgSU7InsKkC5alTvvRXCmUGgyUoY
 Wu66DBs/VOtRm6JpCRtvwmB3UoBamQq9gI6ByV1bafMxA0IY6+rfy7DrFXyWFAQ1D0Dj
 m3j09nqwMCYceyk2xIHs2E38Wl1ybH4OchqMe47Cn0iAx1hMbVFF0IQXgGsGGvPdHVPY
 SbzZuetkEp6+Myaa6D5zB6pKBjH3IaKfDrbcIRKwNNbqhEUyzMANcF7qDcr2aYYgspUB
 //YxTidL7tuk9+figHGeX+iWpZJO4KPLjfRw7bJq57W6VE8E7tvuosfkK4ZmnUPKZIMv
 xq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604318; x=1796209118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZdgVeD0cg+CSbtYJFXFa6HuTZpw2BVmEAQvLBHgq3hA=;
 b=p6VTzCw0SiYDO1mokuoit12EwI6If0fYhUZRXga+3J9/Y6Z94iEYYgMawJc9KRCl2F
 i33wIz89ZzUTctGGYg6P0/9cmddEvgpEt24jXfmtrmmVoQjwtWf6s2oz5FzDtGFwkQqu
 ietgw5sncfsgqgIFpuMt5ty+9wFm7Yye62z5tRhC/bqr9DEz8xI1Oq4oBvDkSzf25brA
 9+EMyZr44EQmsMkc/+wVzjfDc+tQ55r/bcRyDNQgXTpIc8AsJG0hnkvwneELMO1pqwoh
 NrkOhbaQQ3Adq4UsBXPEqyt6+xVZ88Dtk6ygCnWOJxcN6Hs0GUewY/z50Ho9zwr6mE1e
 FhUQ==
X-Gm-Message-State: APuU4Z8G8EmdRtZXWL8+EBYHoZmW9mt9ALI1SoBlCX/ED0QF3s/+qjN5
 LA1ru3TNngsX9KnFckQ5O3Nk573LlHKtCrxbxjJJ5nx9R8ZRbRsbmtsatUh6z6+pfDi9Tu8SgJ/
 JO78ai09jWQ==
X-Gm-Gg: AZFdTZczn8MaVdgHW4FEYXlmlZnlo1rHiq375JBBD30encuX4SdQ4m9dllVuTisDuR7
 pALelw4sog/4LmpeA7/2hRvgF5Sx/J8xV448f2OfQZqgZcwdEjUG2xlbhSGgEy+RG57gD8E2E+e
 ycjGoaJYLOKTucQMyP4UNHX9+neA7DPY512URJU4MOeSo5pcczCvHFbcP5mQvx1s2/J08Yimx9J
 +9M6poe4JK9FsCwQ9cFJIKFOOI5kTCOiaYe01qH2mA1Rnyas5+JJeaayV8ZsTyrfEPziubQu63h
 yXVn/goxUhcLEwvcyXwEWEqD66YLvmNpPGYAXOz2eSb5ishwmntcXRr7Fk73P5zP961+9ImI86v
 kmp2e31tdF3bALVzXk9N1z+4THKjNv/hgMyEKNgDkkfohOZl5J5EdvUE/7UNy0Ttw+5GAOilIy6
 jky1HZEdVF7iyQ2WfZHDDDBnV+y9jKr8aeadpdECQUD8SQEtKfHWC7hLDZbRyFZr/UIfUNWyTaI
 PKiN6+rxvoK9cVOCB6PCWrk4bb0q+0HwKpCxVWO/lirLGZ+Wvy5sF0+C3sahTqDF8rofGDJIxm7
 6QFJcfrqyvSna0w8279jbDXXZ0mAMy+bLG5dzOXwyF8yqWZ3VuU=
X-Received: by 2002:a5d:64eb:0:b0:4ae:e824:1fa8 with SMTP id
 ffacd0b85a97d-4aee8241fc9mr23296353f8f.9.1795604317681; 
 Wed, 25 Nov 2026 02:58:37 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf6804sm33058428f8f.10.2026.11.25.02.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:37 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:16 +0100
Subject: [PATCH v2 07/11] env: flash: Drop end_addr and end_addr_new
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-7-8d31a33a54d2@baylibre.com>
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

end_addr and end_addr_new hold the end of the flash_addr and
flash_addr_new sectors, and follow them.
env_flash_rewrite_sect() and env_flash_set_flag() now compute that end
from the start of the saved environment, so nothing reads end_addr_new
any more, and only the redundant env_flash_save() still reads end_addr.

Simplify the logic by computing the end from flash_addr in
env_flash_save() as well, and drop both variables.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 env/flash.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/env/flash.c b/env/flash.c
index 2340926b07a5..cd5474acddf5 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -49,19 +49,13 @@ static __maybe_unused env_t *env_ptr = &embedded_environment;
 
 static __maybe_unused env_t *env_ptr = (env_t *)CONFIG_ENV_ADDR;
 #endif /* ENV_IS_EMBEDDED */
-static __maybe_unused env_t *flash_addr = (env_t *)CONFIG_ENV_ADDR;
-
 /* CONFIG_ENV_ADDR is supposed to be on sector boundary */
-static ulong __maybe_unused end_addr =
-		CONFIG_ENV_ADDR + CONFIG_ENV_SECT_SIZE - 1;
+static __maybe_unused env_t *flash_addr = (env_t *)CONFIG_ENV_ADDR;
 
 #ifdef CONFIG_ENV_ADDR_REDUND
 
-static env_t __maybe_unused *flash_addr_new = (env_t *)CONFIG_ENV_ADDR_REDUND;
-
 /* CONFIG_ENV_ADDR_REDUND is supposed to be on sector boundary */
-static ulong __maybe_unused end_addr_new =
-		CONFIG_ENV_ADDR_REDUND + CONFIG_ENV_SECT_SIZE - 1;
+static env_t __maybe_unused *flash_addr_new = (env_t *)CONFIG_ENV_ADDR_REDUND;
 #else /* ! CONFIG_ENV_ADDR_REDUND */
 
 static env_t __maybe_unused *flash_addr_new;
@@ -218,6 +212,7 @@ static int env_flash_init(void)
 static int env_flash_save(void)
 {
 	env_t	env_new;
+	ulong	end = (ulong)flash_addr + CONFIG_ENV_SECT_SIZE - 1;
 	int	rc;
 
 	rc = env_export(&env_new);
@@ -225,27 +220,23 @@ static int env_flash_save(void)
 		return rc;
 	env_new.flags	= ENV_REDUND_ACTIVE;
 
-	debug("Protect off %08lX ... %08lX\n", (ulong)flash_addr, end_addr);
-	rc = flash_sect_protect(0, (ulong)flash_addr, end_addr);
+	debug("Protect off %08lX ... %08lX\n", (ulong)flash_addr, end);
+	rc = flash_sect_protect(0, (ulong)flash_addr, end);
 	if (rc)
 		goto done;
 
 	rc = env_flash_rewrite_sect((ulong)flash_addr_new, &env_new,
 				    &flash_addr->flags);
 done:
-	flash_sect_protect(1, (ulong)flash_addr, end_addr);
+	flash_sect_protect(1, (ulong)flash_addr, end);
 	if (rc)
 		return rc;
 
 	{
 		env_t *etmp = flash_addr;
-		ulong ltmp = end_addr;
 
 		flash_addr = flash_addr_new;
 		flash_addr_new = etmp;
-
-		end_addr = end_addr_new;
-		end_addr_new = ltmp;
 	}
 
 	return 0;
@@ -322,13 +313,9 @@ static int env_flash_load(void)
 #ifdef CONFIG_ENV_ADDR_REDUND
 	if (gd->env_addr != (ulong)&(flash_addr->data)) {
 		env_t *etmp = flash_addr;
-		ulong ltmp = end_addr;
 
 		flash_addr = flash_addr_new;
 		flash_addr_new = etmp;
-
-		end_addr = end_addr_new;
-		end_addr_new = ltmp;
 	}
 
 	if (flash_addr_new->flags != ENV_REDUND_OBSOLETE &&

-- 
2.56.1

