Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E3DCCF9E9
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 00:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3037882A9E;
	Mon, 27 Oct 2025 01:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zj3xA/l8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A26B82E34; Mon, 27 Oct 2025 01:25:04 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C9F80422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 01:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c531445439so436934a34.0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761524699; x=1762129499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dSeDUPwg9u+PeoMhkuDfE9DGIMdwZGOBZPLz08iHMVA=;
 b=zj3xA/l8Bbe8FIESkB2Wc7Qson8GWlev9RTOxQLu3YqbZ24JkRl3487cEpAry/rFUA
 X7WR1eWdNYt+k43dXxL77DiRLN1ij6qB3m/unxeH1UJqg6LVNS+RaYZZz7CO8UJJz5Hq
 csPzX+uyvC3knyPCCoyR9h5ppwnDxYDjSqCS4H4rHKGsMqRlCNUYBPJiyhrHxwm7RGEP
 ewEdXqMVfgt43C0T1UUXS/+MR3cpWBK+hNDkw/c0G6pmWRajxnDRBurh43DIfkZLkOne
 orsgZBdYZ4e2xOfCnbQTBo6h2KWTYrHyLsZAdb41ax6yFBgF6Pz4W6AeR+mhtmbISICQ
 JCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761524699; x=1762129499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dSeDUPwg9u+PeoMhkuDfE9DGIMdwZGOBZPLz08iHMVA=;
 b=eKhpa0aq5rD9nV+O4338vLkKAKw1mRA9s7CFZfArEYuI1zHambCyT6V7H5Cj+kky82
 l2RM16fOhi+BOr5Ol4MT+e3N9itxu9CikgfkEjmWCMtfmlIAB9Q/IJ7ChVc3lmL804gU
 /mgorekrj+wxMcAT6odEi3CV+TucYBLjaOK+/3sdz2UFAErRJt863KOtfVasK15CrT22
 cJEs38D7+HcyzG7thSWcuPIA75UcC7EgIxFkawjyD37WtmE+8228ZrgIVO8BMJfYzGv5
 F/n7w6AkpAsvV0z0v5hBXGV1P3UHCo7J7++gFGr6crkl7OaiD37uNhnqWKNCC14iOu/8
 f7Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUbceFp7+XkqPENEHsxtmDdVJjJVv5wzlIcomgGQWK+l3felYLRN4QJTlxlnCvnPxS8F2imgo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu5/zWZmS2KRlKULEK3J7WgM50nKhg/HMLqLI8KGo6Xnz01+U/
 Efu23fSae9cM9X9SZLd9T1FRpiaiizbdzCSd9rYW8SqWrE3wlUKsV872G//J1XdWbsuyQhxuqUn
 w8OBc
X-Gm-Gg: ASbGnctgGt32Ar6J5dJDJlyOxHUCYNDEerEVuNg0Vgn+RphJlL8HUKEmC0+A06Cxnnq
 9sI+DRyosPU6DTYqVoUWlEibTwVZjlRDVl+LpIoyZhI3VLQdsM07dADjSCyoXqjKjod/AYu74Mc
 EpotJs9j3EcjEBPR6CaLPCCESrKz4OM6mbnCuYDWH07cXTbJtwBuCtSnn6EuCTISVxPQ2CGFikg
 lOPkzTMva9nWc0xMUpY4nM/n1B5MWLtjJ9283eDDJ/SDwUJLY2bofUVR4Psdh/IH+IJFMrgEfkr
 DahQOdNp+nDSCnfAnuS8G+m0T0TdC+HV+72W/9gR0MSxr+QbpCvr23Bp+ZvmHhYcwnjD6a1q1Iz
 YvU2wkeUmqP7kBeGTwR/MsCqIs2tye0HnzI9l/GE8V7kzMaHWz6/db0C0fKx89GwgWyYVCV8gAH
 HJzO2o4NnOQhmdOCTsCecC
X-Google-Smtp-Source: AGHT+IFUOn1lGvHBXwE+gnvF6amBNGXq/CBg1PF9PPLKlIKta0Iq8bvAeZgQok6xlVpzSNzs87+77w==
X-Received: by 2002:a05:6808:3244:b0:44d:a783:dba1 with SMTP id
 5614622812f47-44da783fdd3mr1568323b6e.25.1761524699426; 
 Sun, 26 Oct 2025 17:24:59 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e21d77sm1445524b6e.3.2025.10.26.17.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 17:24:58 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: David Zang <davidzangcs@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH] autoboot: Fix inconsistent countdown output
Date: Sun, 26 Oct 2025 19:24:58 -0500
Message-Id: <20251027002458.16741-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit 5f70be08b015 ("Fix autoboot countdown printing wrong") introduces
inconsistency in how the countdown is displayed. For example, in case
when BOOTDELAY=5, the next output is observed during the boot:

    Hit any key to stop autoboot:  5
    Hit any key to stop autoboot: 4
    Hit any key to stop autoboot: 3

That happens due to different printf format (%2d vs %1d). Moreover, the
mentioned commit fails to handle the case when the user is holding some
key before the countdown is shown. E.g. if BOOTDELAY=101, the next
malformed output is being produced:

    Hit any key to stop autoboot: 1 0

That's because the fast path code wasn't modified accordingly, and still
tries to erase the number using '\b\b\b' format.

Fix both issues by introducing a dedicated routine for printing the
whole countdown line.

Fixes: 5f70be08b015 ("Fix autoboot countdown printing wrong")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 common/autoboot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/autoboot.c b/common/autoboot.c
index e39f4a32f957..1783ef92c94c 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -5,6 +5,7 @@
  */
 
 #include <config.h>
+#include <ansi.h>
 #include <autoboot.h>
 #include <bootretry.h>
 #include <cli.h>
@@ -376,19 +377,24 @@ static int abortboot_key_sequence(int bootdelay)
 	return abort;
 }
 
+static void print_boot_delay(int bootdelay)
+{
+	printf(ANSI_CLEAR_LINE "\rHit any key to stop autoboot: %d", bootdelay);
+}
+
 static int abortboot_single_key(int bootdelay)
 {
 	int abort = 0;
 	unsigned long ts;
 
-	printf("Hit any key to stop autoboot: %2d ", bootdelay);
+	print_boot_delay(bootdelay);
 
 	/*
 	 * Check if key already pressed
 	 */
 	if (tstc()) {	/* we got a key press	*/
 		getchar();	/* consume input	*/
-		puts("\b\b\b 0");
+		print_boot_delay(0);
 		abort = 1;	/* don't auto boot	*/
 	}
 
@@ -410,7 +416,7 @@ static int abortboot_single_key(int bootdelay)
 			udelay(10000);
 		} while (!abort && get_timer(ts) < 1000);
 
-		printf("\rHit any key to stop autoboot: %1d\033[K", bootdelay);
+		print_boot_delay(bootdelay);
 	}
 
 	putc('\n');

base-commit: fd976ff3a233ae7c6a9f5bec790b02bbbf57bb24
-- 
2.39.5

