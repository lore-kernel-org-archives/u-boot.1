Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98677D3B9B8
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15EA89A2F;
	Tue, 26 Nov 2024 17:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNP1iKOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55DA4895EC; Tue, 26 Nov 2024 17:19:35 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B941895F1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fc22a88bcbso2084431a12.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732637971; x=1733242771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oxgs3mWvrbqxYh2nudLIJ4Lh2dINpCqOYvseK2Mmv7Q=;
 b=gNP1iKOhn4VImO9Wu6a/rxOGVDw0KES36aQb6E4Z1kmPVLaxO7M9KYfGjwObtlgm9F
 xugKqMvJWhdi8BlIfT0VwCLjKMpBDcvCBJ74Lj4USlm0wF+ZUnKdo2x61ZTnrTTbT6vD
 Ja8g4CRHZ8tGQ/AfEQm06+g+RLVS/ws4oyQ34gEMX+b1S2Z1cu9hR51cjO6359gaJR1R
 EKrWP46f6DyVVs/80rmOSJ25jsr3DArKIlK9rl0RNLQy9fzaOCOXZvALduFTg5X8TV4X
 3mjQvMhypy+YLy6wMzmrX37Hm+zxF8QLmKGd5spe+nAhEIqDkFb2KHziQ4XK7cAIYPfz
 +tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732637971; x=1733242771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oxgs3mWvrbqxYh2nudLIJ4Lh2dINpCqOYvseK2Mmv7Q=;
 b=fvnUeJDPvyS0ZpQ9CN6tX1hjgYv7YcPD/ZR5wQ3TKmrTlsz+kzwH6MHaEHwkoOQdbH
 SmdrGSzJNMH8iHCdkkaEqQG9uxEr6eC4ueUDS/wqDIZf0wsZfb5s3UneqgdchCujw1Xe
 qwO42U4oEpM+ZGNmUuhaJQoIRbOlY4q3zhmKLZQpn/FUx1O9Nr9r8T7LNuQj+YryQDzY
 wP696OVXi8DYb746kxphvKp5I0M0Wz/m47Z/mIEEIYRvYTx4qIo9XrovnD10aYNT6HUT
 Kca4H9buZQPYdZaSh74fVzTW2Eng/s7g1ThxnWiE2TvFeUzrSnrC4EFbnUbBYn2dV+Ks
 Ovtg==
X-Gm-Message-State: AOJu0YzQJ5lOCzLwkvmxfOQ6x1HEphGGJ1DEn3zqy1nC51ddYcqq1X3Y
 LcWeCI1jcuo+eGij9csr0KVaxSg4x18wvg/N55+2H8cu80nj/L9jJfYwadd9Ufo=
X-Gm-Gg: ASbGncvyGABeDYjrOhYHYfxQzIdYI1XMWHlnopgTuPAQLGhaERgVHo4WmQA2MVbyr1v
 uAzgGxgsXSs4lCAaEprnwY4awH46KtHqwZHkbhA/d0sNcAfv6Xso2mXhRfaFHzo1tOvOHKMzrAd
 VbRHVdte1Zfoi+lk2bTz7UAkbAcpS6bcZH3eeZBuybqFtrJIBdg64JWKRuK5DNHCe80y70Isdbr
 LQ/wemlP/o7PxTsjLT6seVXfzmQkVXwSQ4uveolydQ=
X-Google-Smtp-Source: AGHT+IE1la0YebV8QVDRmouFUmbTauwQ8vO5pXjc2AveTVV33liVjbgo3OdV81gA3w8qiw9um/euVw==
X-Received: by 2002:a05:6a20:3946:b0:1db:eba6:225 with SMTP id
 adf61e73a8af0-1e09e606a57mr28186926637.35.1732637971436; 
 Tue, 26 Nov 2024 08:19:31 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724ea6a23a4sm7863865b3a.60.2024.11.26.08.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 08:19:31 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de,
	joe.hershberger@ni.com,
	rfried.dev@gmail.com
Cc: jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, trini@konsulko.com, sjg@chromium.org,
 pbrobinson@gmail.com, yasuharu.shibata@gmail.com, marex@denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 1/2] net: zero terminate string with headers in
 wget_fill_info()
Date: Tue, 26 Nov 2024 13:19:20 -0300
Message-ID: <20241126161922.388901-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Commit 2dd076a9c1b4 ("net: wget: integrate struct wget_info into legacy
wget code") introduced function wget_fill_info() which retrieves the
headers from the HTTP server response. As we want to parse the string in
later patches we need to ensure that it is NUL terminated.

We must further check that wget_info->headers in not NULL.
Otherwise a crash occurs.

Fixes: 2dd076a9c1b4 ("net: wget: integrate struct wget_info into legacy wget code")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v2:
- removed double check of wget_info->headers
- removed an unnecessary "- 1"
 net/wget.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 3bc2522cde..5d70b7a82e 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -208,8 +208,13 @@ static void wget_fill_info(const uchar *pkt, int hlen)
 	const char *second_space;
 	char *pos, *end;
 
-	if (wget_info->headers && hlen < MAX_HTTP_HEADERS_SIZE)
-		strncpy(wget_info->headers, pkt, hlen);
+	if (wget_info->headers) {
+		if (hlen < MAX_HTTP_HEADERS_SIZE)
+			strncpy(wget_info->headers, pkt, hlen);
+		else
+			hlen = 0;
+		wget_info->headers[hlen] = 0;
+	}
 
 	//Get status code
 	first_space = strchr(pkt, ' ');
-- 
2.43.0

