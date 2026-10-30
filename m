Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B4606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mMj7/jED;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZtpSa6QW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3790060625;
	Fri, 30 Oct 2026 10:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlLKPoBv4plr; Fri, 30 Oct 2026 10:31:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF84C60690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793356289;
	b=bI90VjrJRm92/eY4lUhHWgPkSF/fJF5fSlIPyKuaATL4apYmafgQNSgHkEl3p1hJspDD
	 47aMp9lgr/pDGyO3OiBklntB+9byec179TBgaLIho1w1rT+G/NmMT+qftvzieQUhkjlXS
	 A7aTtX7fuKBNvOSPEellNQFE3HZjp+GakfK131ggGp54G6RD9D2ykVScEa04Pi4NWLdma
	 OUht53//h+2ID1BPJAqbUP7WGy1dzPLs63fgEWKMkKLzHLwqy7boz7d1pDVO/ptaC0+od
	 HG8E4gL9ErQZe+yOC2BoG3bgVhH+MaYqVvMNoz1lozk4B7QXLkuvg/ZUGXDdp3k/xeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793356289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uhD0uCdvE3M8zzLjaXWkP6ghvhNaN8aahcQVDVqrnX4=;
	b=oHGNysjOr7YlCfsJaR5uZjXPEO9r0oOo7GdsoGa6oN1r02Hf2sbEBeL/eghuKdiuFAyT
	 9vnqUi0Lco1ZxNWSLJHIbDzrIW0QrP3g3Kypy+Jg666R8u2tpCX2eogsjlWTKYBXWiXKo
	 4JUrUzyeNluTWUQ7MxnNLeNKZVxFvkDi3gZGeA8jlJPkNtVBIGElvzpw5piaFGFeVff6n
	 umEOlnS2lFc4nnG/mhYjm2CM6qQ849ew/eYFwMtgQqKVHJ+d4a4oirr0+GN1k+ZRlgYHn
	 71WRU074InOp84ivtEt2zfb4a6qP6a7Crz54/RQJHmPx5AIq1XzCvaTdntKlifoFpvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793356289;
	bh=uhD0uCdvE3M8zzLjaXWkP6ghvhNaN8aahcQVDVqrnX4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mMj7/jEDDg9XmKdm1q2ZqiKXdSGS3yAw7dtoz8M+vXmoxrWBo1OYiFyyosHpBxcUW
	 Fo7wQAkfS8JN9Bjnbyw8gtTx9Hn2pca1eW0s4GuLzaWqA1f3WqwQjWRKNbbjXDkaKs
	 3KZg/HEq4sQyEVdrh9EdVGoqNehE2yIJ+Cj8Wnixf8otKD744FWdhgRpMag66FYkZV
	 o0SgTAdCdwHeUpNrzEn9+C8ffkPzo09uhF/ooPoA5hzWD3qJGJf30XCQz4BS9zE1JP
	 zQ4BdrhtcJgcTFeje77gU/jqf/pk/Vl7OybmRwWoLH+dyoZrJZJfIcPL4KtH4F9EZZ
	 YMINUQ8OfqoJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF84C60690;
	Fri, 30 Oct 2026 10:31:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C23C4BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF8B740063
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJpgJ7qhcc66 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 10:31:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9F08C400B0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793356285;
 b=XvfsdTuiIidMESstVx+Oj27EaM1lM1nSTD3KiExisb0sgx/W8FjgIqDVeZ6lX+pPv9FX
 7+CYjMAdvWPA/Les72Ja7kOAUcYIDETxVSKDRsRJ4RjXlmNo9+x7REKW1XZ/n9rqlEhXI
 zajiMLUTaiUxw8hdVoue3ZBf9gVYS7hpO0Bl807HTpLFs/XIExLrAMPzrDwgm1CPznVbZ
 i7hSSBznbZrh7/6qy532D2q943SlK+4AEZZZv7tezw6fjyqGT6s44buT7KdKBDTs2p7uB
 FergB5dmm5ORIMPVtkFgTZfZ6vmQZtFTnxebK5WekGNuxZRoP2MY2vaBUHpQo8kcnVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793356285;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=uhD0uCdvE3M8zzLjaXWkP6ghvhNaN8aahcQVDVqrnX4=;
 b=fN8+gwILIKfpB5kD2MPdJ73jb7XxNiBKxVUGmY9ElmPnBlBYmLicHUvtsMIf6oP/bDMY
 CPGYaM39BbZUgRG1VXZXqkt9Pb9bOR6ht4JP3CuBDKv5Men+pw0dAZZ8zJOUOY5QzRR9k
 4np/n2wz0JY/92ZpdSnqPRP922a5THP31E6PhZT3HFJ4BpRglmE7VbVuAXCwnMx8e5CiF
 vhWrZuXWSI7tpR+9HS6y6KHUIzfCFQWMGFywlvNWw2ZdJ20Ao4hF+6ZfHMSNZ+RE1yAB1
 iWNpJKbm6jhknTaVqbexx/t8i/RraVggmITT9a5ter72VQ+0GvguuKwk1arf50hJOHg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=ZtpSa6QW; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=thomas.perrot@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=ZtpSa6QW
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F08C400B0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:31:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 177B14E41396;
 Fri, 30 Oct 2026 10:31:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D785A603C2;
 Fri, 30 Oct 2026 10:31:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 16B0F103287DA; Fri, 30 Oct 2026 11:31:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793356281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=uhD0uCdvE3M8zzLjaXWkP6ghvhNaN8aahcQVDVqrnX4=;
 b=ZtpSa6QWOdm8+eWRa5cxarbBrWvCVMl3+6P+xgFxXfs5AYinKiRRmI1LuDVV7OmPk85oSm
 RQE2BQFnDLJT5F4MCGQPQtc29Ltx2iTe2B9zWAGUYgq2l3hYwNUYTLKLsLa5Uhs8ygY6C9
 eb+e1O7/1kBZXGaXlAQ6jN6XmRNflhQbZV6L371xlX3HtRdjvLOhInwRdH/rjZ6+AX0gSr
 PcAwhj/zxTfRwvrb/ASM/0D2jAoFbtXGgq2PliqpHizrUwGc3TNUsdnT1ImmWKhczd05vj
 4OKrKPWlvof2MeXOtFt6BjkyBf9FykzQ6wZtk4H9zKEnoqpsxYOizEC/6WwwGg==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Fri, 30 Oct 2026 11:31:17 +0100
Subject: [PATCH] pwm: stm32: Fix division by zero for 32-bit timers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-tprrt-pwm-stm32-32bit-timer-div-v1-1-f6f93d7923e4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQqDQAxA0atI1g1kIijtVUoX6qQ1i7FDJqgg3
 t3B5dv8f0ARUynwag4wWbXof6kIjwameVh+ghqrgYm7QPxEz2aOeUtYPLWMLY/q6JrEMOqKIiP
 1JEOkLkCtZJOv7vfh/TnPC4GsQyBxAAAA
X-Change-ID: 20261029-tprrt-pwm-stm32-32bit-timer-div-eeb070ead061
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.u-boot-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Tom Rini <trini@konsulko.com>, Cheick Traore <cheick.traore@foss.st.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

stm32_pwm_set_config() derives the prescaler with
do_div(div, priv->max_arr + 1). max_arr is a u32, so on a 32-bit timer
(max_arr = 0xFFFFFFFF, e.g. TIM5 on STM32MP15) the sum wraps to 0 and
do_div() divides by zero. Configuring a PWM on such a timer, for
instance for a backlight, resets the board.

do_div() takes a 32-bit divisor, so widening the operand is not enough.
Use div64_u64() with a 64-bit divisor. The prescaler then comes out as
0, which is right since the period fits in ARR without prescaling.

Fixes: be5523d38296 ("pwm: stm32: add driver to support pwm with timer")
Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
On a 32-bit timer such as TIM5 on STM32MP15, stm32_pwm_set_config()
divides by max_arr + 1, which wraps to 0 in a u32. Seen when a
backlight on TIM5 is configured from U-Boot.

The fix is ported from a change carried in ST's U-Boot v2023.10-stm32mp
tree.
---
 drivers/pwm/pwm-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a691f75e4a71..3f2b593477b1 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -13,6 +13,7 @@
 #include <asm/arch/timers.h>
 #include <dm/device_compat.h>
 #include <linux/bitfield.h>
+#include <linux/math64.h>
 #include <linux/time.h>
 
 #define CCMR_CHANNEL_SHIFT	8
@@ -64,7 +65,7 @@ static int stm32_pwm_set_config(struct udevice *dev, uint channel,
 	do_div(div, NSEC_PER_SEC);
 	prd = div;
 
-	do_div(div, priv->max_arr + 1);
+	div = div64_u64(div, (u64)priv->max_arr + 1);
 	prescaler = div;
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;

---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261029-tprrt-pwm-stm32-32bit-timer-div-eeb070ead061

Best regards,
-- 
Thomas Perrot <thomas.perrot@bootlin.com>

