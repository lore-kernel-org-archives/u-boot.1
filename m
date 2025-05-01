Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BB7C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 11:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9A68059D;
	Thu,  1 May 2025 13:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ayYWweNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90801809D4; Thu,  1 May 2025 13:10:21 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 472F78056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 13:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d8020ba858so9581585ab.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746097817; x=1746702617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JCYWTn3sCFaWaqofl90LuvyeO5zbrvXhrVjrv+28OT8=;
 b=ayYWweNW+wCh2CcFHvnfrSZSIqyOwKvRBjgiBUAax9d5VU0miDbuu6T/ebFsE1TrCJ
 I+jTM72HvQBOI4fypzfomOjXOBgLmDMu5uShSwoeeAgze+wV1nbs/hqVRn4nQpARr5OW
 sjrbBSsP11/lwzfIejcaDejsBfAu8XqezgRJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746097817; x=1746702617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JCYWTn3sCFaWaqofl90LuvyeO5zbrvXhrVjrv+28OT8=;
 b=FMnMiodEcE4PH/SJjoUCpS/+Au7agKmSofpNBaWj5tbjezCu4MmmYmdOqV3HxKq3pg
 kofmd1XbKmypAVLu1Rdz+WKwiVN0rGJSdO5ueGsR1Ytd/acVNWNFisZ9YUL0nB0iVpAF
 jaYbi/0gmqLIHS9iLD69L/e2W9TvYoRgaOGauHJDqAoywUGQ4a/iYBROWG5BAr7GWjPl
 dMMTZJ13njGQoZ1X3AQAkC0EfBrE413AsciPsQIfUget0mh8n/rrX/fGIjBCP3UcyYb0
 jhWQqzY04RSNsA0T7JeqLwrzK0x4aR/8ZkXG1pCHWq/1oWsy3+D+F5dGfmuaohPZqJYT
 ycyQ==
X-Gm-Message-State: AOJu0YwBa2vcOfRM8fu0nU2UzxtSzpJUKwf7GOdohq3rDdwUG7MsR5ha
 Tiv8sqoCXDHZJcuxIA/VOreaduGPEGbXncQ5HFR9u07CZmeI3IuIzOylRQEy1gME+Dh/f+bS80U
 =
X-Gm-Gg: ASbGncsu+hk8JcBuzySmuDj69c/1KMRMDOymUUIkY4am30S+h+OUeIQB2a8l0md2cXG
 KU3UQe2gGCueawgTZulz1sSAzSmbFJgp3ZnyAtUHFumPLAbGvZzrkiblRYx/9DxqWd66WKpZbO4
 qkY1wPyLJAwYahpliUvbEZngU28EVP+rfCBhdbyfitfo9sEr0dT0ZyDI/qNSeFg1Hz+/18YbtaI
 kKHclVVrGJMWc0dHG4i1qJ10ZpqIaEDKzGucgDiWKMNVufirnVDgAkoOXuLXC6NDD8c/9RxaAsS
 M1bdNHbl3PkWz7A0Hn7+9lceBZwZRLFZP9czfNGtqRBJkln9HI6joUuX3SZ73th3Igvv/2Uyzr0
 l1Q==
X-Google-Smtp-Source: AGHT+IEwG/gvgQ7tLlTOP/W84H5i62iHnwCn+YJ4A2p+o2n7ChnpjxSCJ1M37qLnK2MMUX/fcasNNw==
X-Received: by 2002:a05:6e02:2146:b0:3d4:244b:db1d with SMTP id
 e9e14a558f8ab-3d9701cb10cmr25278325ab.6.1746097817299; 
 Thu, 01 May 2025 04:10:17 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975e77924sm875915ab.20.2025.05.01.04.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 04:10:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/2] strim: Sync up with Linux version
Date: Thu,  1 May 2025 05:10:08 -0600
Message-ID: <20250501111012.705638-1-sjg@chromium.org>
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

Linux changed the behaviour of strim() so that a string with only spaces
reduces places the terminator at the start of the string, rather than
returning a pointer to the end of the string.

Bring in this version, from Linux v6.14

Add a comment about the new behaviour.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/linux_string.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/linux_string.c b/lib/linux_string.c
index d5a5e08d98c..4b92cd923f2 100644
--- a/lib/linux_string.c
+++ b/lib/linux_string.c
@@ -31,13 +31,15 @@ char *skip_spaces(const char *str)
  * Note that the first trailing whitespace is replaced with a %NUL-terminator
  * in the given string @s. Returns a pointer to the first non-whitespace
  * character in @s.
+ *
+ * Note that if the string consist of only spaces, then the terminator is placed
+ * at the start of the string, with the return value pointing there also.
  */
 char *strim(char *s)
 {
 	size_t size;
 	char *end;
 
-	s = skip_spaces(s);
 	size = strlen(s);
 	if (!size)
 		return s;
@@ -47,5 +49,5 @@ char *strim(char *s)
 		end--;
 	*(end + 1) = '\0';
 
-	return s;
+	return skip_spaces(s);
 }
-- 
2.43.0

base-commit: b5d6220dd2f4612912989f3c2b5a710f2248cb36
branch: schn2
