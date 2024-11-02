Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56CFE67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 16:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547A38917E;
	Sat,  2 Nov 2024 17:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="J0/GWaF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6602B892A2; Sat,  2 Nov 2024 17:33:10 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67821890F2
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 17:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-107-023.46.114.pool.telefonica.de
 [46.114.107.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E88A3408D6; 
 Sat,  2 Nov 2024 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730565186;
 bh=8faITywa6drQh3z2dzbfYqArxyKTLtT0QEAoAlCKZuY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=J0/GWaF0Drw83OtFm4wRdCWwGf0rTyFi1HdZk+d2brdP9dI+oP8hlKtzh7/W7x1g0
 CLjQQZXtB1bIRK7Rgs4GWWMWHJCPi9rhis3HAQ1J/aOFeqiastH7+qtSbJYUJatJPS
 L0Ncd8DhUc6DnlCIlNc7SnKru3N/dTMQI21H8r+Q7LTfbQ/SFvVMOhtmOP7oiAZ0IE
 z76JZPgalagaQe5IwdF0SBNryeIPJOcJVoNp+9BjRhA8zg37Hc+BN0glULAmeEoSul
 VUZNwZ05fBScdPilUEWOhJiJnDiFz7uydIoqbJYZRJ+Zx028krOZRV+3PDNQu7ffwK
 bG+4gJEKXITOA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>,
 Simon Glass <sjg@chromium.org>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Dahl <ada@thorsis.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: use cryptographically safe RNG
Date: Sat,  2 Nov 2024 17:32:59 +0100
Message-ID: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The PRNG implementing the random() function only has 2^31 states and
therefore is unsafe to use for cryptography. Use arc4random() instead.

Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of rand")
Addresses-Coverity-ID: 312953 Calling risky function
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/image-host.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 5e01b853c50..e24e053825b 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -364,36 +364,6 @@ static int fit_image_read_key_iv_data(const char *keydir, const char *key_iv_nam
 	return ret;
 }
 
-static int get_random_data(void *data, int size)
-{
-	unsigned char *tmp = data;
-	struct timespec date;
-	int i, ret;
-
-	if (!tmp) {
-		fprintf(stderr, "%s: pointer data is NULL\n", __func__);
-		ret = -1;
-		goto out;
-	}
-
-	ret = clock_gettime(CLOCK_MONOTONIC, &date);
-	if (ret) {
-		fprintf(stderr, "%s: clock_gettime has failed (%s)\n", __func__,
-			strerror(errno));
-		goto out;
-	}
-
-	srandom(date.tv_nsec);
-
-	for (i = 0; i < size; i++) {
-		*tmp = random() & 0xff;
-		tmp++;
-	}
-
- out:
-	return ret;
-}
-
 static int fit_image_setup_cipher(struct image_cipher_info *info,
 				  const char *keydir, void *fit,
 				  const char *image_name, int image_noffset,
@@ -465,8 +435,9 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 		if (ret < 0)
 			goto out;
 	} else {
-		/* Generate an ramdom IV */
-		ret = get_random_data((void *)info->iv, info->cipher->iv_len);
+		/* Generate a random IV */
+		arc4random_buf((void *)info->iv, info->cipher->iv_len);
+		ret = 0;
 	}
 
  out:
-- 
2.45.2

