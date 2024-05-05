Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AFDC4345F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 05:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB30987DEF;
	Mon,  6 May 2024 07:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="nx9mq0/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5514E87F8B; Sun,  5 May 2024 15:54:14 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1FD87F65
 for <u-boot@lists.denx.de>; Sun,  5 May 2024 15:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yoann.congal@smile.fr
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2df83058d48so13555301fa.1
 for <u-boot@lists.denx.de>; Sun, 05 May 2024 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1714917251; x=1715522051;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0lGIfDj9qkeRjNZDf6W3Wv+Rqr4Z/6LuE8dA+wZWONE=;
 b=nx9mq0/7BNkmbjlm79eWyIH7UEf+QSJUGuBerOeYGNlvn+QvFw7XRqtVv1x6W4dp7U
 uBsV/IUD5coYOe9pz+aHJKfcybknkOPNqXEehAvDvR9oDeYtCjSpb9s2x5tSeJHYJZcJ
 2CwbPwEt31wfmDn+EmHQqQ1/8ODcjr7bN371GZUEi9B70O3cwWZekZZYr+kKxtXYWmQ6
 j/eUlUeIgfrcTACtE9lTVpK7kGzdwy42q/rKu0VXnCpx+ZvJWqre1rApHGEPpT1Y0wPW
 2Zn9aR9kjttJBjlxzwtw6A0VWUjuMVt529amWTh+0TZ/9KKrtgncTodosct0SFpxpcwA
 q7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714917251; x=1715522051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0lGIfDj9qkeRjNZDf6W3Wv+Rqr4Z/6LuE8dA+wZWONE=;
 b=hsK/58xZC4Y8Ik22aJ+0tFA4z4MHLLrQZwwXmDBrjktMOr01JTmujL6ASShHnUq4wy
 Gw4qEPPcJot8G95dp1Z7CJ91riAzrLAPJTVVoP0ly7WAx3nHT1S9uEfNQTwy3Rx4XmdR
 T2s40VaxeRHWfRrgdgOzVQOnTpVr+zyZUSyvOIYAIqTbM+z3eVxKon+uN6iwWQLLZ3kY
 cicndA+Mhej0V1E7PyaS1Pxy2jtpX5lMPXpB5j59/cM8fYHckPjSGYL3QsZgs8cWAYY2
 OniV50xyArzpy27kFWWOCtb//mdRVBR/KUInfYoyGv/ckH9iF7Hio5ggAieTij+NMtcK
 3Csw==
X-Gm-Message-State: AOJu0YzAq/j752cQOmQdCgIgcyf1E9zexm5YL6T2ebI3Yv45hnq6Wz5c
 YuASxjoJXTZzwY/swf9AISVgIxo8WCKDYW/e13GvGhdx5Kbsr+8pFyWhuavgEbohJJawVq6I26J
 Caw8TbA==
X-Google-Smtp-Source: AGHT+IEbQKfSsiLHEIx6vPON3Yo9YJ8d8waSRd3AOeRQXWBNZI/HzxUQvjrK5ZNVHJRfT2Tdp3xLug==
X-Received: by 2002:a2e:9ccd:0:b0:2e2:466b:1a68 with SMTP id
 g13-20020a2e9ccd000000b002e2466b1a68mr3946137ljj.41.1714917250668; 
 Sun, 05 May 2024 06:54:10 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c138500b0041ac5f19213sm12643736wmf.8.2024.05.05.06.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 06:54:10 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: u-boot@lists.denx.de
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
Date: Sun,  5 May 2024 15:53:53 +0200
Message-Id: <20240505135353.1507200-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 May 2024 07:54:49 +0200
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

From: Masahiro Yamada <masahiroy@kernel.org>

This is a cherry-pick from the kernel commit:
6262afa10ef7c (kconfig: default to zero if int/hex symbol lacks default property, 2023-11-26)

When a default property is missing in an int or hex symbol, it defaults
to an empty string, which is not a valid symbol value.

It results in an incorrect .config, and can also lead to an infinite
loop in scripting.

Use "0" for int and "0x0" for hex as a default value.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
Added context that was not in the upstream commit:
The infinite loop case happens with a configuration defined like this
(a hex config without a valid default value):
  config HEX_TEST
  	hex "Hex config without default"

And using:
  $ make oldconfig < /dev/null
  scripts/kconfig/conf  --oldconfig Kconfig
  *
  * General setup
  *

  Error in reading or end of file.

  Error in reading or end of file.
  Hex config without default (HEX_TEST) [] (NEW)

  Error in reading or end of file.
  Hex config without default (HEX_TEST) [] (NEW)
  # This loops forever

NB: Scripted config manipulation often call make with /dev/null as
stdin (Yocto recipe, CI build, ...)

This was discovered when working on Yocto bug:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
---
 scripts/kconfig/symbol.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 703b9b899ee..b4c51de3f20 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -343,7 +343,11 @@ void sym_calc_value(struct symbol *sym)
 
 	switch (sym->type) {
 	case S_INT:
+		newval.val = "0";
+		break;
 	case S_HEX:
+		newval.val = "0x0";
+		break;
 	case S_STRING:
 		newval = symbol_empty.curr;
 		break;
@@ -753,15 +757,17 @@ const char *sym_get_string_default(struct symbol *sym)
 		case yes: return "y";
 		}
 	case S_INT:
+		if (!str[0])
+			str = "0";
+		break;
 	case S_HEX:
-		return str;
-	case S_STRING:
-		return str;
-	case S_OTHER:
-	case S_UNKNOWN:
+		if (!str[0])
+			str = "0x0";
+		break;
+	default:
 		break;
 	}
-	return "";
+	return str;
 }
 
 const char *sym_get_string_value(struct symbol *sym)
-- 
2.39.2

