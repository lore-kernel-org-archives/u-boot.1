Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58EFC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 21:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B067849F0;
	Fri,  3 Jul 2026 23:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7sxkFGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68EC2849F0; Fri,  3 Jul 2026 23:40:17 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4E5848F3
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 23:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso422606a34.3
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783114814; x=1783719614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9bPR5HSqSjhM9KTHNU1GedcRo5yxBg8cQd+pl4XRRao=;
 b=j7sxkFGHqI8JqD6VCt+GO9ddE5cxMzOSgI/S6lK7FXmjXISk0dCXm+9HJ8bzjn4I8g
 nNIX3gtLmVszgn4LyyWqoswEJZceU50oGUKYXS+g4mZ3j8I9KEemuHY8ij+Q7qoRjAN7
 03MmqwoV/BOd6tN84So9q178AQz6NSjtWdzztsZVwB5gJ1MGYxB8RkOCSnUdsiR7j6na
 ciq0drCbOeZ+nJ8AEib/aVLXkPUJlHgPlWehm6421TgvE6nqUo+RB8usS8oQVSi+g/LI
 oCfCqmsX279lXwJ9P3ZwtqsJq4F0Sfi9Xx8BAz/3uiNG3Ru43PElbbjgMkcGQrZEuZPe
 hRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783114814; x=1783719614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9bPR5HSqSjhM9KTHNU1GedcRo5yxBg8cQd+pl4XRRao=;
 b=kHlzA0Ptf73G5hTi4lTmM1KSWUxR9ArOgHNNmMjfZ+JuELjdXPE9d6vtuBnVFA7Jh8
 1M+Q+71f/gANHUiy9aS5y9tY4jw5+0LATijNnumCisK3Fr/wu62oisxlMv4Uv7w683tZ
 9cpPi9iSWGEzfeP8skRMAukPHen0pPx4grHAkyr6m/R+DhJMW2cNFbZwaFnqcL151WHv
 orqAIRIQydrae1yYKn8YU4RQosPShrHQI+hvpOSwPsFUNBqh49fm+k5AfIiv0cak2Hoh
 KZLahNpLdHahIHpPgjH1z9eCeXI3V2P+Uw0FYciWh7wzI8nFma6BYmjk6g1sKXavy9J/
 qjMg==
X-Gm-Message-State: AOJu0YybLoXgdlCaDBnUDmejfu5NUNThzxI5jzeJQATsmpvKuz9rxjuw
 VhRfkl2khO1w8ggB5MXNKnzh3E1OEGLC7hdyWoHE7DF+eLJ4ax57VfmR1jkZ3VQ4+Q4=
X-Gm-Gg: AfdE7ckMrpK0hpWhK9bK2pvLs+FbszYA2Kbhg6ur0W01b96vLiz9RmPZSx7PNIu/nbd
 eVYkRBAuBBNCq54X9LzCxotJ1nz0p7XhOLWVqydVaJFOuFwQn5CZh1CNYw1EaSjWixQNo5sGcFf
 XFyqaU5LuZVGVYkq4SQXnP4eAQn62EILCs36Tr+eeuhevWbYWDwtH3zQn0y1r3skHpdKK3IXVO3
 Y1oojU2OVwsjMSgOmajody1x4y4/cEoD/3XfDSKIw1/Ym27K2aFeAKXLPl1d0fR+99WUJbZ+XRQ
 KS4TYiac1Jts7lEItqwsL1OyjXbgidgIQYRoWW+nBeUOP0+fr93kR0qxAMDtXbh3h4WjrIWhA5y
 vCIxe/lmyk3f1UceD8zp43E/fKRpqhnQckAGbV9qkM0ehuyBjKU2GQU9Pi/7gtf6M6yMNXo4TfF
 pAH5LO9aVlK1dAvn+DCsmoVvppkt4a4b3rkxMEZbGxo+waCqclKI+SAfnQB1EuE7vVSVJTpYzWP
 gfUjYTmwaXI3BtLjhk2Jbt1WlWsJO9/aMJTaFqPXYId3GzSxpHhsnaHMQLmoku5GObWSCD9k0e/
 oHwFfev12rhRwME=
X-Received: by 2002:a05:6830:4413:b0:7e6:fdea:7aee with SMTP id
 46e09a7af769-7eb7ff99dcbmr753820a34.24.1783114813960; 
 Fri, 03 Jul 2026 14:40:13 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb542936e6sm5915119a34.5.2026.07.03.14.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 14:40:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lucas Dietrich <ld.adecy@gmail.com>
Subject: [PATCH] lib: ecdsa: use .key extension for keydir keys
Date: Fri,  3 Jul 2026 15:40:03 -0600
Message-ID: <20260703214005.3818185-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The keydir/keyname path should follow the FIT signing key convention and
read <key-name-hint>.key. Using .pem here is incorrect and does not match
the filenames used by mkimage and binman key-directory flows.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/ecdsa/ecdsa-libcrypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..ef3e42cb0f8 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -338,7 +338,7 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	} else if (info->keyfile) {
 		snprintf(kname,  sizeof(kname), "%s", info->keyfile);
 	} else if (info->keydir && info->keyname) {
-		snprintf(kname, sizeof(kname), "%s/%s.pem", info->keydir,
+		snprintf(kname, sizeof(kname), "%s/%s.key", info->keydir,
 			 info->keyname);
 	} else {
 		fprintf(stderr, "keyfile, keyname, or key-name-hint missing\n");
-- 
2.53.0

