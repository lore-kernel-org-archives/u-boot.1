Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3FCC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 17:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BED6807E2;
	Tue, 12 Dec 2023 18:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SD2r7r6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D83D80844; Tue, 12 Dec 2023 18:33:55 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53611804CE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 18:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50dfac6c0beso3426447e87.2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702402431; x=1703007231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sSEzRB6F/9q3x0IvJ35JV0W7klsQRoW3I1+qiHJDAOU=;
 b=SD2r7r6Lm/N3b53u+K9AA6VRAamPGDnd7s3NSmAMT8E4FFj+PbhDGhnAE+tvBEdbHp
 OWDeL4umVKVIlxctw48RAoJvDYBZaW4Qg8oUd7W0oSejRHY9C9uF9dIqysK82ZWpfq0S
 u2CeSeG9jwJxVKvJoxW4WtBjUY3IsAvx/dNcN3dkXceGS4kGFrtyuGEPE+jUHu8RBO4B
 Vh+AMNJ7BqtNlWord4th4nsvmR9cL922yGQP9vGz3MKzHYdQ41rpUOBd/a2CFKbdJGsl
 bJI4rV0keANdFjvG6gStTDiPMCjB2QnuS7weU98pBydXCYImDtVi9nresZ39A8GVq5HY
 +Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702402431; x=1703007231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sSEzRB6F/9q3x0IvJ35JV0W7klsQRoW3I1+qiHJDAOU=;
 b=C8qPYq3uEHa800RK84ZBOiONHDIgJZLmt/Gj7+cwA9Hv7VLLyJCSyrHPvdFhnVzuD1
 k9HeUKqimxwsX06MocxVlyv1UfVHcBwOUYv3GivgRYvnqQ9gcff3/B3weSNLsUFvWTQz
 2/cJlBgjMbnyjavh4NDXfkiIt2OVjnXUJPEzCbPTmpfP7q3dakxK6SxmH7UjWYTbEKjB
 1C6Qa+0s/thadhzkadHh35Gg6lAT1RymtBwsOXtkhKnkLHTiz5Pcf2XKOY4iRPaxUXef
 5KYWlxmxhXxRpX1qJFvC+S5zYVdy3MZLzYXox/xBI7wmImnbtSW1J2N97DU3SgsmpOrm
 rK2g==
X-Gm-Message-State: AOJu0YyQo8DW8iY56gbGZ4+afz0XdeZA/TjxXGY57rVjHGGK5vLrLk+k
 wDFSJ9kxYSxhRjInJ97D+Hmc5yfc02I=
X-Google-Smtp-Source: AGHT+IHYqK4wASv56l1bxQz+d1Uy4WQQ6ZbuR4D4uRv9KnfhOojSPT0v5JBZrqijsMCG08k2WGRHxw==
X-Received: by 2002:a05:6512:1154:b0:50d:1b79:b34a with SMTP id
 m20-20020a056512115400b0050d1b79b34amr3561135lfg.82.1702402430668; 
 Tue, 12 Dec 2023 09:33:50 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 vi7-20020a170907d40700b00a1dc7e789fbsm6493714ejc.21.2023.12.12.09.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 09:33:50 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] fw_env: fix reading NVMEM device's "compatible" value
Date: Tue, 12 Dec 2023 18:33:27 +0100
Message-Id: <20231212173327.22819-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Call to fread() was changed to check for return value. The problem is it
can't be checked for returning 1 (as it is) to determine success.

We call fread() with buffer size as "size" argument. Reading any
"compatible" value shorter than buffer size will result in returning 0
even on success.

Modify code to use fstat() to determine expected read length.

This fixes regression that broke using fw_env with NVMEM devices.

Fixes: c059a22b7776 ("tools: env: fw_env: Fix unused-result warning")
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index c9a8774ace..bf8b7ba304 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1732,6 +1732,7 @@ static int find_nvmem_device(void)
 	}
 
 	while (!nvmem && (dent = readdir(dir))) {
+		struct stat s;
 		FILE *fp;
 		size_t size;
 
@@ -1749,14 +1750,22 @@ static int find_nvmem_device(void)
 			continue;
 		}
 
-		size = fread(buf, sizeof(buf), 1, fp);
+		if (fstat(fileno(fp), &s)) {
+			fprintf(stderr, "Failed to fstat %s\n", comp);
+			goto next;
+		}
+
+		if (s.st_size >= sizeof(buf)) {
+			goto next;
+		}
+
+		size = fread(buf, s.st_size, 1, fp);
 		if (size != 1) {
 			fprintf(stderr,
 				"read failed about %s\n", comp);
-			fclose(fp);
-			return -EIO;
+			goto next;
 		}
-
+		buf[s.st_size] = '\0';
 
 		if (!strcmp(buf, "u-boot,env")) {
 			bytes = asprintf(&nvmem, "%s/%s/nvmem", path, dent->d_name);
@@ -1765,6 +1774,7 @@ static int find_nvmem_device(void)
 			}
 		}
 
+next:
 		fclose(fp);
 	}
 
-- 
2.35.3

