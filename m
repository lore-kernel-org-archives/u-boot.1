Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE47F4384C
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D895B8421D;
	Wed, 15 Apr 2026 17:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="e/HnOd4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A91E8421D; Wed, 15 Apr 2026 17:41:00 +0200 (CEST)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD3B584129
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776267656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZrSxf6ckX384UqqPLbIT/7pjppJxspx3wLMVSrNvYU=;
 b=e/HnOd4YiABCw2E+dTCuQ9qgezXzOJQMK1J2lKzXXFeIkBKVySbCVIVDLB+rR2wNP7hx1o
 VXOEQkwE30lLSgJOS7kyxL6JuXP2UZIBMeCWu7MiJ2ohvrgN6S54S7TyH0RaD7gZRwdS5E
 Gnh92HrJqh+qWx79g0eO4//Xm1PeEGo3pdTwKpWhngeBktqF467VDOUtezHWb3DDgaJftD
 dtJX0vEpYjNUIMVUJnuja5VCt6SMZ3A99j7hrRihsgnNT3tiAgiudBLp90yThnKxuPwBGu
 1jHjH8l2sDl91Xf6s1aG0BMhXbBVqf2aL28pyprj8i/3tCTdiMHtAOHdSHCLgg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Apr 2026 14:32:32 +0000
Subject: [PATCH v3 2/3] cmd: bootmenu: ANSI_CLEAR_LINE before entry name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-ui-cosmetics-v3-2-aa8308a47e33@postmarketos.org>
References: <20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org>
In-Reply-To: <20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=709;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=gRFMsdTbH87+UZY8Gp3qVC28CYTjUgFe4xb6Rw0ialU=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp37GDEy5bB9esF3JgMCX10mJH/0IU2DkUV5K83
 /7V8ceZnf2JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCad+xgwAKCRCEr8vQ14ma
 Aw07D/9Zx+OkRkVgQrxH1rp30vuBBpH+KXeTsbGD86aHoLU+S8ufAEqt2lwZGfqILx53/JprD2p
 Weq5wMedpuTnrG94x9mHl9veo7jPgj6llDvEIxFrOiufe7ITixTdy/CCC0Kjb9qHrKBYoT4R9Dv
 YxX3VO/w8f39Rktmm8q+caWINBwM2E3cdvWuwvV80THJzpAGoh0Te0k6Fp/twpTP+PjIKS0ARZl
 ZQryfLDSddOWGhn3KuvW7WMMTxrmSSp62EmKz2AdZbbuM8Kuo7A0Xx3GW1Z8jgHBRmvX0AMuIBW
 865uZXbnMtIfhuab3KgPXAm0dimuJ9BiYBDhyvUZVSDlYkEgTpkmc8ED9JYxt1OcZEYQU6kjkT8
 QalCDY2CA8POu9xi9zz/8htuqGAWH3QkvXGOsD6+t0dq0frvh5m5CA4rmkTfMr2IkONHEiBDOqc
 xXbc3gNw3eSAi48kKvJE1WpP9RlwYWWVl7pkl+fzBOBEnPEftesSUR7kqNRLU3foqBMfL92LKs0
 DrS1RMj2G3peUJJfy0LmewyIaHNVs7SLuML/pEB+p5KgDnzyXMrF+L0/xd8lnt+FXf4BfZYqBLH
 kqrLiPT0sF7oX+DTIwfnskzotJQhsU7XqEpO08UShR1vt/mH4k0cOO3YiozMca9KSAWvEs4Fii4
 C4663fBV+8QBMMQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

This has the effect of highlighting the whole entry when it is selected
(on vidconsole), which makes it consistent with eficonfig too.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 cmd/bootmenu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index d3108778c6f..a07fea49322 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -76,7 +76,7 @@ static void bootmenu_print_entry(void *data)
 	if (reverse)
 		puts(ANSI_COLOR_REVERSE);
 
-	printf("%s", entry->title);
+	printf(ANSI_CLEAR_LINE "%s", entry->title);
 
 	if (reverse)
 		puts(ANSI_COLOR_RESET);

-- 
2.53.0

