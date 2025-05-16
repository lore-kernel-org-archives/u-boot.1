Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04645C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 16:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF1D80107;
	Fri, 16 May 2025 18:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FRzyzU4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444CD8059D; Fri, 16 May 2025 18:05:51 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501B58006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 18:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-550ee1cb0a3so592931e87.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747411548; x=1748016348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JGFzeT5hhK1wMltMuV/rmhKbqMrW76cA8zChJvefCvk=;
 b=FRzyzU4sLTcFEnfb83CqljluBY2dd9G8rJh8r4TzhpHN7hqq8ozg6sKPDxTHWoXmnG
 up45xD0HFUb773Go6ul6r+unqBcGkOy5CCxoK1r288Uj1a2SzQfQsEAkmGbhBD1tsaKo
 nWZ++DeVU1iiIldDVwdMA/Qar1da2jJjZ9AG/isGW575IUDI9i9JXvEPlK1Sk/aYSnNr
 NtkD8FjjCkXKo9pfGiFJ0mffSaRErmxhGNJh6/6DoWy2GxjzW1m7Mz/iHNFoLASsANe0
 gcfCsYnITYKzNgZI7vyUEWF9oTxn9pswqujhpzxjmpc6J2GyO8yUdm/JSQwenW/uiKZ8
 G8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747411548; x=1748016348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JGFzeT5hhK1wMltMuV/rmhKbqMrW76cA8zChJvefCvk=;
 b=CbBzBsaWypthVJs8ya/JqLBv36wvHiiIhGSkzOu8dtsZuUHoc5I3YhH4Hdyqol/1F3
 HtlA6Zw9dGacdDfd49jtyPsNm11UwBJo41fX88xAbf8g2tR/YILZjD+m+w0ejXPUt8Db
 g7vCMrN8xMRaSfzvCTFoc044w1GDzzR/ZI7vZBygGz9qSS156kMmT6YY/wfzqNZTO1cU
 u4CEIo28hfwHs+l2u4HSle2/CG2RdHOmr+Db2761xW+IWr7x30D2ba7lP3CF1+134gx1
 COAPIQugOtCIV5qDhX6D7GjJIv0H8un7kmAiDBrcUjodDizFosh0TW1PRUqZS2Bmrdak
 IwRw==
X-Gm-Message-State: AOJu0YyFGWsGzfcdWdhiMimasIJXQzoMAppQljPIt+hzWwiHIrMET8Ha
 Yea4nRyvIhZ+6gfCbpYtZbsS34505D608M7/VczLYzNY3xktZXCFWTUOo3bHvqv/
X-Gm-Gg: ASbGncuoOYKGypMxe5MXt8S2KVGyxf4E647aGm1BgxvAIujVcenrSJXkVEk3IR8ZiVl
 caimaWeXN5eNiu7BPWTQc2m3tEq6AZi74B3f1yXrgRl1JuI4XlOVB/byXjco8rnXrNTd/qnHhCF
 yJXrYZU7PvMlMZYkmrvinNM48izdtTtojxISMgvGPBdtjSih9TzY6T+SQhREK0LOKNSYmtKlTZL
 2C9ntjfPeYiojT74gu0Co4sZlIVJ0mumE4y4tENl1EF1UKoJemSccVMp1ram8Oh6o6KALW/O3lw
 CY1D1Sq8Y80n6fb0rMrfudGKdBIqrIW9EoYD1oSRtqYzC2JbGclRPfMtQoiI6n8/6yULEw57e01
 d1/MYFV1Mw5sumTkarQ==
X-Google-Smtp-Source: AGHT+IEnQlyB0r1DwK1ijkdGztzjNUOFZrV/k8z39bN3ygm6Uu55GWLLJHD8dUApWDXmy2KAKUmsdQ==
X-Received: by 2002:a05:6512:6805:b0:54f:c887:c7ca with SMTP id
 2adb3069b0e04-550e7230366mr1008551e87.45.1747411547916; 
 Fri, 16 May 2025 09:05:47 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e7017eecsm491081e87.143.2025.05.16.09.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 09:05:47 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] boot: fix memory leaks by freeing token.val in pxe_utils.c
Date: Fri, 16 May 2025 19:05:42 +0300
Message-Id: <20250516160542.86835-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

 Added free(t.val) for T_STRING case
- Added free(t.val) in T_EOL and T_EOF cases
- Added free(t.val) in default case
- Added free(t.val) on error conditions
- Prevents memory leaks from get_token() allocations

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 boot/pxe_utils.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 82f217aaf86..81b7602387b 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1277,6 +1277,11 @@ static int parse_label(char **c, struct pxe_menu *cfg)
 			break;
 
 		case T_EOL:
+			free(t.val);	
+			break;
+
+		case T_STRING:
+			free(t.val);	
 			break;
 
 		default:
@@ -1285,12 +1290,15 @@ static int parse_label(char **c, struct pxe_menu *cfg)
 			 * of a label and whatever token this is, it's
 			 * something for the menu level context to handle.
 			 */
+			free(t.val);
 			*c = s;
 			return 1;
 		}
 
-		if (err < 0)
+		if (err < 0) {
+			free(t.val);
 			return err;
+		}
 	}
 }
 
@@ -1383,19 +1391,28 @@ static int parse_pxefile_top(struct pxe_context *ctx, char *p, unsigned long bas
 			break;
 
 		case T_EOL:
+			free(t.val);
 			break;
 
 		case T_EOF:
+			free(t.val);
 			return 1;
+		
+		case T_STRING:
+            free(t.val);
+            break;
 
 		default:
 			printf("Ignoring unknown command: %.*s\n",
 			       (int)(p - s), s);
+			free(t.val);
 			eol_or_eof(&p);
 		}
 
-		if (err < 0)
+		if (err < 0) {
+			free(t.val);
 			return err;
+		}
 	}
 }
 
-- 
2.30.2

