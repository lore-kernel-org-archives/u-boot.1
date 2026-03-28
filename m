Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483D510BA424
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 07:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF9C83C14;
	Sat, 28 Mar 2026 08:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ppeCKt2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C79583C14; Sat, 28 Mar 2026 06:16:07 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886758394E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 06:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngotra27101996@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso1179699a12.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 22:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774674963; x=1775279763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V+UPu5cVM/AXy3VMCQunHsvKjHNgczRjnCcuiElLfl4=;
 b=ppeCKt2aVx3yiUgp4rG+RKiR0vP5RIlNmE6Yf5J8AGlB69sK03ixPzH12ElGP97CPH
 17YvxCHWqtl4zTyTC7cZ6cJH00zq067MpkdzvCqAZuR5lMpTC/ttjKxwg8gQiOpgCKut
 ZTDe4WrZCdXOGFp3TNfwpx+agQtrYI65zzLuXff+iTfv1NwOKLru2V7MiA8coTOLNK8g
 hIiN0RNXiy3/KxDtNHjIpe5A0fBitecY2eeF/w8k2Kj98B4ZxnlHTrSXuRCcx/BPcIEv
 UKhi5510HW1iXB1ZHvMCwcsyPBySz/WCOUefawW4CdUPgbUSpKYBURnA3OJZYeJ8GQjX
 DfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774674963; x=1775279763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+UPu5cVM/AXy3VMCQunHsvKjHNgczRjnCcuiElLfl4=;
 b=Caqvg6NyjlikuhfaC2rGAmI2Hon7VW4sg6kfn+AvsLb2S3YP7hkHOPs1f5WkaHpYr8
 u/IQgzILNEtqtDh/0ZBQUD9ewJvvCLlviDp46b21dvhmpRtk9g4uhnJWN4u4txWImbgd
 wwwVkRLcJL9tMtrtkej0XYoX53LRu/SoLWnsHRLl0G+7PQgwqLqIdKdCMb3PwCug8c9h
 R5MU0e7nqEEUtqs1S4XusFfbl2FqqgdYD/v94QXoQrTITQJUjFjUiPYAhYnzP0rse2C3
 QQG/plceIWoTKZr9L3y/pzaqjf/EomrOUcRPE0ild4x1EyxC7UEqCTeMKGRA+NYPdsQC
 uw1A==
X-Gm-Message-State: AOJu0Yyg2ZNXQb1AY2z/k92Ey1+D1Nsog2+lVXPEHbluhOfsa/6/e4KX
 +Vl9uIE2qervSNhiLYTPl4bJAbQirOaFPzt/HxK6lvrBC/bOerbxFTLeEehYQK8I
X-Gm-Gg: ATEYQzxiek3p4Vzyu/co4u6dzcxXQs6biP7KtowrcGwIUY7Ro4LexC/8nZ/9IN5dKl7
 +x4e01yGqBEoyM3VhhC8Wf3m+soymqu5eD4/kylXfk9jvLNNQ/YPV48Okigh56OiFlNQVzbJL0R
 W//1r0QDHbuT3q3tsfhNuOb3vj+yGaULoiRzoOfdpsMvdu2oiex//UG6aQnrFnsf1VdCpD2R5nb
 RbOLOIeW+5KRmBprqUqwFvvriadM8XwXIxiNlRXrGyfJvnZ6wBxy30UKjVuluq8b+z8O4PPlRmV
 FikenBlh99ht0zdiAC0piJYMBKcnrNKigJGbIQ9PW62X/MsbQfg+ubHgT60wNr4r4tq1RPl/hKp
 OUWfQOQoyxAZBwXXITaotJzvEBhHdjxbbdJa7fzwtnnGBOt6mAVTObSlIteU/wVa94/UI9o1e2J
 32tsYqTd/FRY4/Dh3XEgJpJUZyunctmPC3Dd5owqOR56dQ0Fr3/HepEoo99/pKiKPA8lKMvYo=
X-Received: by 2002:a05:6a20:72a3:b0:39c:12c5:c6f5 with SMTP id
 adf61e73a8af0-39c87915721mr5811663637.18.1774674962564; 
 Fri, 27 Mar 2026 22:16:02 -0700 (PDT)
Received: from localhost.localdomain ([118.69.37.28])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76916cd89esm716033a12.8.2026.03.27.22.16.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Mar 2026 22:16:02 -0700 (PDT)
From: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
X-Google-Original-From: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: nanopi2: fix bd_update_env() cmdline buffer overflow
Date: Sat, 28 Mar 2026 12:15:48 +0700
Message-ID: <20260328051552.29343-1-S4210155@student.rmit.edu.au>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Mar 2026 08:05:42 +0100
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

Replace unbounded strcpy()/sprintf() calls with snprintf() and
check the return value against remaining buffer capacity at each
append step. The previous size guard did not account for
subsequent dpi suffix, remaining bootargs tail, and bootdev
token appends, allowing overflow when those later writes exceed
the remaining space.

Fixes: d1611086e005 ("arm: add support for SoC s5p4418 (cpu) / nanopi2 board")
To: u-boot@lists.denx.de

Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
---

 board/friendlyarm/nanopi2/board.c | 49 ++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index 4dff32e10d6..eb10cd5143d 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -328,6 +328,7 @@ static void bd_update_env(void)
 #define CMDLINE_LCD		" lcd="
 	char cmdline[CONFIG_SYS_CBSIZE];
 	int n = 1;
+	int ret;
 
 	if (rootdev != CONFIG_ROOT_DEV && !env_get("firstboot")) {
 		env_set_ulong("rootdev", rootdev);
@@ -347,49 +348,63 @@ static void bd_update_env(void)
 	else
 		cmdline[0] = '\0';
 
-	if ((n + strlen(name) + sizeof(CMDLINE_LCD)) > sizeof(cmdline)) {
-		printf("Error: `bootargs' is too large (%d)\n", n);
-		goto __exit;
-	}
-
 	if (bootargs) {
 		p = strstr(bootargs, CMDLINE_LCD);
 		if (p) {
 			n = (p - bootargs);
 			p += strlen(CMDLINE_LCD);
 		}
-		strncpy(cmdline, bootargs, n);
+		ret = snprintf(cmdline, sizeof(cmdline), "%.*s", n, bootargs);
+		if (ret < 0 || ret >= (int)sizeof(cmdline))
+			goto __exit;
 	}
 
 	/* add `lcd=NAME,NUMdpi' */
-	strncpy(cmdline + n, CMDLINE_LCD, strlen(CMDLINE_LCD));
-	n += strlen(CMDLINE_LCD);
+	ret = snprintf(cmdline + n, sizeof(cmdline) - n, "%s", CMDLINE_LCD);
+	if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
+		goto __exit;
+	n += ret;
 
-	strcpy(cmdline + n, name);
-	n += strlen(name);
+	ret = snprintf(cmdline + n, sizeof(cmdline) - n, "%s", name);
+	if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
+		goto __exit;
+	n += ret;
 
 	if (lcddpi) {
-		n += sprintf(cmdline + n, ",%sdpi", lcddpi);
+		ret = snprintf(cmdline + n, sizeof(cmdline) - n, ",%sdpi", lcddpi);
+		if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
+			goto __exit;
+		n += ret;
 	} else {
 		int dpi = bd_get_lcd_density();
 
-		if (dpi > 0 && dpi < 600)
-			n += sprintf(cmdline + n, ",%ddpi", dpi);
+		if (dpi > 0 && dpi < 600) {
+			ret = snprintf(cmdline + n, sizeof(cmdline) - n, ",%ddpi", dpi);
+			if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
+				goto __exit;
+			n += ret;
+		}
 	}
 
 	/* copy remaining of bootargs */
 	if (p) {
 		p = strstr(p, " ");
 		if (p) {
-			strcpy(cmdline + n, p);
-			n += strlen(p);
+			ret = snprintf(cmdline + n, sizeof(cmdline) - n, "%s", p);
+			if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
+				goto __exit;
+			n += ret;
 		}
 	}
 
 	/* append `bootdev=2' */
 #define CMDLINE_BDEV	" bootdev="
-	if (rootdev > 0 && !strstr(cmdline, CMDLINE_BDEV))
-		n += sprintf(cmdline + n, "%s2", CMDLINE_BDEV);
+	if (rootdev > 0 && !strstr(cmdline, CMDLINE_BDEV)) {
+		ret = snprintf(cmdline + n, sizeof(cmdline) - n, "%s2", CMDLINE_BDEV);
+		if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
+			goto __exit;
+		n += ret;
+	}
 
 	/* finally, let's update uboot env & save it */
 	if (bootargs && strncmp(cmdline, bootargs, sizeof(cmdline))) {
-- 
2.53.0

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: fix/nanopi2-cmdline-overflow
