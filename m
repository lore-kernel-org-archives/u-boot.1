Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A7DC83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 10:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1476831D5;
	Wed, 16 Jul 2025 12:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iA/nQuOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBF4831D8; Wed, 16 Jul 2025 12:55:50 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDCCC830B5
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 12:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so5093833f8f.0
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752663348; x=1753268148; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wb5tHSBM/opltbHkS98dk2DFf6uwiPzNadibZN8Imxw=;
 b=iA/nQuOush7Vmtj2RIbV22B4T52G9uThh985KVyn8lBvwSm2lCjWLRclV/iNIuUTfT
 S1tbwWO9nT34BNEA/oaCPGunYF7f4su6p8B9wvSSXStLXkhQrAwGwkM+oDza2m/vhUtz
 HiGGKsjU6W1T7hrX0GHTvk9OE6vGQgM+BbbzkyfXXuPEuj8B2hHADBlabb0+/XW5sNDq
 lWuKAXzOvlc/gNL3jW8t3afkaq0Dv6AHi+To2TG1M9YjiJ3SP0t6vOA3OeVwactbnNgQ
 rCLKh8BSQozjT8Z1qtLsIREvQZZrjBUhzIO7XYtnfBa6+haX/xpgGYxKwn/hRQ7pLEqn
 dYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663348; x=1753268148;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wb5tHSBM/opltbHkS98dk2DFf6uwiPzNadibZN8Imxw=;
 b=XOomjfd6fRU4vH4VuAIlgxyIMuwH2FhiidfCRt9y4V721+lz1XJdvBDy6Yb4J+scer
 iIz9FhYnC0F+1wsTkEeBKrt8H+Fy9cLMUtDhxO4Ey+ExVnVEREqLNJltCOnT6mZBK1WP
 g/1wERfz6qevJlHyjyU4K1McLBcpYc4GqYaAn4O9d0yGDqgvD9vVc6cqTujacFARo+K7
 rXPrxyewIvS3XqoTcPpZDpo5ugTpzpQ3gOkRp8r0aQTNfxjZjqagDurYY/92kavsXZ6x
 RSapUGpka5iZBYpGNOCanWgYjugj16gfXfPolv+B47VCcrIxl8wokRURuPwwQ4a9W39p
 bUuQ==
X-Gm-Message-State: AOJu0YzR4TLuzapDsTjRBWgioViyvq5OTISf7mhFKhv82GX2kpZFxAJI
 SDWuFKzkggzPGkiRkK3cQMxAi6mao+pkQ/UTWQqaOn+0YOzJ6sAbctkr27Hu0sc/ae8=
X-Gm-Gg: ASbGncsnsSWQrq/glYY3r2klqin3AMNQZHxt4fozK1PalyKo5SwawwhFVQheAYudA4e
 tEgun1/8I7vfRQGE3BUQvrDPzRFvt8kX6nKO7boiVUZiWLai4bwYfilUabrnLYd/CEwCBbYeALB
 lMJGNEwzrzhs6nJJDo2hCn5wrP3zVh15rtA/rqBOPI0BfEbQtffy/BzMbLma1nZLGFy5jwkTHb0
 13HJiouq/WW0LobUWWnTFX+czdamjcmhitJEQX0jmXusNB+sFJBalMNWKGd1gjOfvNAn9xfMdGn
 TpQNQ8aj4mRzieAZ1r2XVgjPzhRvvdv+MSNxX8UwqJSvEXgx1UcbZJy7hkZ9HcOtO4gqD1hae/Q
 cKcWsjGberlQ1y6uNOnBt36wN3pntOpuvytgPZUN80vvBAr8w6w==
X-Google-Smtp-Source: AGHT+IHobgHsi/9Gw1+qQHrZnIqZldo9dQdN5wBVWT0hFbbK8JbHsM9TWKMu/Az21Zn/qwm3/SohOg==
X-Received: by 2002:a05:6000:42c6:b0:3a3:7115:5e7a with SMTP id
 ffacd0b85a97d-3b60dd7b0dbmr1545328f8f.42.1752663348200; 
 Wed, 16 Jul 2025 03:55:48 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:d584:3606:6325:3ecd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26c97sm17766603f8f.90.2025.07.16.03.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:55:47 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 16 Jul 2025 11:55:47 +0100
Subject: [PATCH] cmd: gpt: Fix off by 1 errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-gpt_offby1-v1-1-6aa3546069ba@linaro.org>
X-B4-Tracking: v=1; b=H4sIADKFd2gC/x2NQQqDMBAAvyJ7biCJNZF+pYgkutE9NMquiEX8e
 2OPwzDMCYJMKPCqTmDcSWjJBcyjgmEOeUJFY2Gw2jbaG6emdeuXlOLXqLa1ztfG6qfzUIIYBFX
 kkIf5Tj5BNuRbrIyJjv/l3V3XDxyOiBx1AAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The buffer for a name to be copied into must also contain the
terminating 0 byte but strlen returns the length of the string without
counting that 0 byte. Adjust the length checks to take this into
account.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/gpt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 27aea2df197..e18e5036a06 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -911,8 +911,9 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 		goto out;
 
 	if (!strcmp(subcomm, "swap")) {
-		if ((strlen(name1) > PART_NAME_LEN) || (strlen(name2) > PART_NAME_LEN)) {
-			printf("Names longer than %d characters are truncated.\n", PART_NAME_LEN);
+		if ((strlen(name1) >= PART_NAME_LEN) || (strlen(name2) >= PART_NAME_LEN)) {
+			printf("Names longer than %d characters are truncated.\n",
+			       PART_NAME_LEN - 1);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -967,8 +968,9 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
 		*first = *second;
 		*second = tmp_part;
 	} else { /* rename */
-		if (strlen(name2) > PART_NAME_LEN) {
-			printf("Names longer than %d characters are truncated.\n", PART_NAME_LEN);
+		if (strlen(name2) >= PART_NAME_LEN) {
+			printf("Names longer than %d characters are truncated.\n",
+			       PART_NAME_LEN - 1);
 			ret = -EINVAL;
 			goto out;
 		}

---
base-commit: bcc7bc69b92ab728790aea0d08b2ae5e22d3b09d
change-id: 20250716-gpt_offby1-882673120467

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

