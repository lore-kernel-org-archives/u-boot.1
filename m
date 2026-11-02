Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FC606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=peIhvIIa;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LVdWhce5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 379CB40719;
	Mon,  2 Nov 2026 10:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWWuPEL-CTiJ; Mon,  2 Nov 2026 10:32:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3DD65406E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793615579;
	b=alzyZCWIuISv+AIox0uHPEaAY5Q4vaYP7fNIwKh2NkqEXFK+YYgieJwTTs0l0O6/QfHy
	 WK73Cj+WVgC/W5vDa04/DVSvlKWYmP+Jc7guFBnvsIJ3zk/JyorANYjlKeqgjrpgSYYYY
	 io/9D+pYAm5AOgR8OzX1m9btl5qb3d7kYjqRs4YeZ+Eiq01xpzdOTB7rGAK/kPz4okmFY
	 PguregVHVbRJKjk40j/s62miACH7/EwmZJm4+tuwb8XCyvp7+c0mWZHe4IZJ3AFtir/7M
	 WfVDYjcP4Q7lD+WJWtK52Ec8fwRDFS8NgOa4ZzZpEmFp9RChSpW73a0mhjr1lIj7cfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793615579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vPXZDE64MviQhC+jDA32kBa6yjiQJf9JcJc0ENghRz4=;
	b=sdi1BNYs6u2AZ47rZRcpS89a1/ky0uzTBzSe6E+T5Rdo7hl8vpq/HJPTGFxHflf8Q6CF
	 3hTidPYYOA6SnYYiFvg0K+l7xb0RehFsZ7VlTCROdJX62UoQ+A18/moOVpQz0T2tShcIE
	 YAYDPv3OqsJwuNphQ07eqqyd5Cngq2ClwsaIVQmyyyq/BZGKmMnDtSj6GTM5iyIgx3pt4
	 XJ/Z7YWmRgcjYGZM/yhugERMEYQwpQjq5vDVRPY2pI8gL3KR9CAcEMtN4C7Ju8RQ/VyFF
	 9jEH972h/zSQUtwTuxezM8pqMYiGknHgJ9LAflTyomQiP79oVLhIly5wHffJyW8bChQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LVdWhce5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793615579;
	bh=vPXZDE64MviQhC+jDA32kBa6yjiQJf9JcJc0ENghRz4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=peIhvIIaqse3TVejbayCQmsgELsTVXSxTmIm8xGl/FRw926MmkZgP2A5Im4AqNy1L
	 wV0qN6mePJoBf1x6UUcrVGbs5mn9TGnPjd9eu9xZUzQyzfUEyhsLCdvdJ2WJ692ZGJ
	 ExRn3FToo1CxiS3PX3ZhVFvP67eTOX0p/zwZ0B6LJf5QPeg1gUVbAEbge6vdYvyz8w
	 ueuIjcNDyaxmAGuNNsx03p/kKdaea/cxIrFiKrttUW4tmMSDpLxNPlyCYTqwWjr408
	 6AutDn0+Gn57v7C2Y6anWopJqAZMU1v+lV+M8oAwKtqG4hQVnZ/3ZYpkjePQyigpPB
	 r/jAHrH5Dp1QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DD65406E7;
	Mon,  2 Nov 2026 10:32:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12547435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 043CF406E7
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3nSx_iZq9FlZ for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 10:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 496BA406D4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793615576;
 b=I3vEI+EjClQsDpDaOkAzebNdGbdgEyGKs/Xtzb3mVdEa4QLOvqzMnKnFldSVrlY/9dg8
 uJaTaw29u8DAvw7paa6K+FzB1CAFvMDBsoOE5oK+4EQ8kjqbhDvLTNYtb37e2IPMwzsRD
 B5kmh2FUpg2JZUJ1xW75YeMJ9VeFrhF1inOCO9FaInKGlM3BQWqKCsixtMPdAjGO22SDm
 ju2ksJTe3pIaZSaVoMXuuyxHsv5DpBz2pbedtSebPj3k/0a4TzBMM70Wl8uNet/b6CKKO
 AY3ycU/pz/IcI5MiY8nCT6RzW04Lu+no6cBjuiwoyeK4hDwaALI4O3sGJw+wdItNzFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793615576;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=vPXZDE64MviQhC+jDA32kBa6yjiQJf9JcJc0ENghRz4=;
 b=Ax8qf5QpqlR1smmWyc7xxkYhMv2U5lO9JJIf52xz6rmkpwFnkTTn+M9x85gTkM2lq63F
 i8VALEgxRR73ZmJ4weQk63P3QFLe4wv3EuSFzHd+v0fEXU7HqZZ5qsnC4MXH7T5hmS5L9
 DmJi4vlI1eMISlWReIJzsy3X12y/KGQVL5lJXWKYXd2i8hD21+5SirskPXqTaTTjQgtfW
 M3k3e097XiG05lx4fyYguQpmPXZG6Dtg6RkLUoerboszQfE2pvsExwldtZFzf6X8A1Z+w
 /2p05bpRxXFKXYAbuz8X6N/GIZ3VlLpe/k6Cj/dblWa6iMxJI9fcH/vhzpiL46iwXjQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=LVdWhce5; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=thomas.perrot@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=LVdWhce5
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 496BA406D4
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:32:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E32054E413C3;
 Mon,  2 Nov 2026 10:32:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B74E560750;
 Mon,  2 Nov 2026 10:32:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF46B10329123; Mon,  2 Nov 2026 11:32:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793615572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=vPXZDE64MviQhC+jDA32kBa6yjiQJf9JcJc0ENghRz4=;
 b=LVdWhce527ncNoRpWyZKuq8tT/eGDmmgbI52AGXeLFFAta6qqct3OKhIKyyDOiOOVHLafv
 C+2C6keHiTqgXd2EAifCHLZRYtb0XF9gObW3eC0/orekb2mNjGWex7wZRbqmeO8WKy+0wR
 PyfQSISsrgQkwD4o5Qo4YkbdY/UX60slEQBoMaVK0E4jT2zY36sYsYPzgZ15WonefdWerm
 qjQ8ilHdDK/nIZTkWZhc4GF2S37dfW3oC/vr8DVF+vrmi5l3J0tszrmVFI5xloNVsHptgm
 MY33q5Mpn0O2A+XZqMm9AStHTEhhlC/LYyel8Z7l71YkCdPQROavc6zYRcZfSg==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Mon, 02 Nov 2026 11:32:44 +0100
Subject: [PATCH v2] pwm: stm32: Fix division by zero for 32-bit timers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261102-tprrt-pwm-stm32-32bit-timer-div-v2-1-352fe74a27d7@tupi.fr>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw6CMBAAf8Xs2TV9GAie/A/DAegim1hK2k3VE
 P7dSrx7nDnMrJAoMiW4HFaIlDlxmAuY4wGGqZvvhOwKg1Gm0so0KEuMgsvTYxJvDVrTs6Cwp4i
 OMxL1qlbUOVVpKJUl0siv/XBrC0+cJMT3Psz6a39tq/62s0aNYzU21tWNsXS+9iHIg+fTEDy02
 7Z9AG0AiSTQAAAA
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
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
On a 32-bit timer such as TIM5 on STM32MP15, stm32_pwm_set_config()
divides by max_arr + 1, which wraps to 0 in a u32. Seen when a
backlight on TIM5 is configured from U-Boot.

I first implemented this fix on ST's U-Boot v2023.10-stm32mp tree.
---
Changes in v2:
- Drop the div variable and derive the prescaler from prd directly
- Collect Tested-by and Reviewed-by from Fabrice
- Reword the note on where the fix was first implemented
- Link to v1: https://lore.kernel.org/r/20261030-tprrt-pwm-stm32-32bit-timer-div-v1-1-f6f93d7923e4@bootlin.com
---
 drivers/pwm/pwm-stm32.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a691f75e4a71..212389088f74 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -13,6 +13,7 @@
 #include <asm/arch/timers.h>
 #include <dm/device_compat.h>
 #include <linux/bitfield.h>
+#include <linux/math64.h>
 #include <linux/time.h>
 
 #define CCMR_CHANNEL_SHIFT	8
@@ -33,7 +34,7 @@ static int stm32_pwm_set_config(struct udevice *dev, uint channel,
 {
 	struct stm32_timers_plat *plat = dev_get_plat(dev_get_parent(dev));
 	struct stm32_timers_priv *priv = dev_get_priv(dev_get_parent(dev));
-	unsigned long long prd, div, dty;
+	unsigned long long prd, dty;
 	unsigned int prescaler = 0;
 	u32 ccmr, mask, shift;
 
@@ -60,12 +61,10 @@ static int stm32_pwm_set_config(struct udevice *dev, uint channel,
 	 *   (period_ns * clkrate) // (NSEC_PER_SEC * (max_arr + 1)) ≤ prescaler
 	 */
 
-	div = (unsigned long long)priv->rate * period_ns;
-	do_div(div, NSEC_PER_SEC);
-	prd = div;
+	prd = (unsigned long long)priv->rate * period_ns;
+	do_div(prd, NSEC_PER_SEC);
 
-	do_div(div, priv->max_arr + 1);
-	prescaler = div;
+	prescaler = div64_u64(prd, (u64)priv->max_arr + 1);
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;
 

---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261029-tprrt-pwm-stm32-32bit-timer-div-eeb070ead061

Best regards,
-- 
Thomas Perrot <thomas.perrot@tupi.fr>

