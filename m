Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F1FC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 14:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABC38006D;
	Fri, 16 May 2025 16:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fjFa/b6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D2780079; Fri, 16 May 2025 16:56:17 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EFEA80050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 16:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-549b159c84cso2546440e87.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747407375; x=1748012175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M7kFL5d5mEPcpnlk+1YklRLsSe5xLFvoGBDdjIdB5dk=;
 b=fjFa/b6oDeFcIS56+PuB0Tirqz7ojVv1MKhx4Ahjvu8fnnb/WlRdfx2rOMZpozcJdJ
 pYOH6qc6MAkujwyIKkc2ag9qEiKkWuaLarc7KsQ4PvH7KwGLEUQEWfLQ6+733C/8tQFv
 QylTFjJWoL7Ewrc5uJnK5+8W0LekXCMfYMtPsSM+RWJcm/7RdiF+gKRdUYwLZL6EAQ+H
 f0/wOgJqdmurtko45ZZ1vDzj3Qxb28W4uCwd6dJOsNl5WexZ1kfliR6AMSyW1TPOkMmk
 8hMpwLg28XuD0+5P20DECBXFQRVasLYvXAlhu3bIEwMxMdDE+597s9p+RPfxogNGn6t2
 NKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747407375; x=1748012175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7kFL5d5mEPcpnlk+1YklRLsSe5xLFvoGBDdjIdB5dk=;
 b=L4WMjI7cS0TU7TQ48VPXP3FyCYJ7TTiRTT542q8++F0WCP1LIm8QUl3lLgERqhzRd5
 caIoiq7wUJKyDQU9YhHg3FffTvI+nD54HBXnwVPmi3ovdRAO76Uqa//zJ6wnlWupMT4m
 ljz9zulyD6IdO8VwHJIr295EShLr4zQshRKOKZcoPhb0UDQeXjuceKWwRCA88xLcXNvy
 CzZHX4srie7hAjFA24awzL9kFkXknSrSwzgUrLP2WlOVtmpsd02U3JJR0cNDEUgpTIhy
 BeR6s+afOM/Eeu2pJhgso7s8Hl8JLEweuqCemNcCluiXQHga/Gb/450h/9jkqE/+HGrk
 nr3w==
X-Gm-Message-State: AOJu0YypIAeij/guEntp7rLtpelnVB8eb14kxLizvZZ6MWZH/0VTOoEg
 7Vh1GYNTVGKXa4x6FAIRAPfFefY5/HEPiKiF5Oh19wQbz985wPMnZC1g86mgXisz
X-Gm-Gg: ASbGnctiizTawLxLRV/Aoso9vop5zlY1paJCF5tUm6RdX3kAqwxK3T4WQZ6z1t1pK7S
 wUswVOYracyVMQOWucZldzKoI3Mv+bkwf63nZXgB+3gu+yQ8agetoQu83WqY6OlgMcZ307wrH5d
 o9au/0fjifdIHrnNmBZiuTzQ55XiKW/QDUZCSycPl9+1Q8rmWlyC83ZHXW86ctGbdU2nd41f2YD
 J1ZHn3SMmL6IG3nkICoGyusUIhF0mZoYPpRWU1WJK+89M5Onyh9itEUFqURrJJtw+CIzYX50qKw
 FGWOOxYLADAT6KagyAXy1RqR1GtUPRp+s5t7pVVc/MLsu/C1t91fm0OlTvUV5l0qDIzidlKSi9v
 agKMrlPg5SFw35NInNGrCSQxNPMiA
X-Google-Smtp-Source: AGHT+IGby1SHbSx2Gac1eAdUQZ2/2jUEa2HJZ3asYjUQy7sA/KjIjaACzcq87i9RE/QJC6zh3Y8TNw==
X-Received: by 2002:a05:6512:230b:b0:549:903a:1bf with SMTP id
 2adb3069b0e04-550e9906dccmr850698e87.48.1747407374211; 
 Fri, 16 May 2025 07:56:14 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e702c186sm477389e87.174.2025.05.16.07.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 07:56:13 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] scripts: kconfig: fix deref after null in menu.c
Date: Fri, 16 May 2025 17:56:11 +0300
Message-Id: <20250516145611.67022-1-ant.v.moryakov@gmail.com>
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

Static analyzer detected a potential NULL pointer dereference when 'sym'
pointer is passed to for_all_prompts() and other functions after being
checked for NULL earlier in the function.

The issue could occur when called from gstr get_relations_str() with
NULL symbol pointer.

Changes made:
1. Added early return if sym is NULL or has no name
2. Added NULL checks before all sym pointer dereferences
3. Maintained existing functionality for valid symbols

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 scripts/kconfig/menu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 0fe7f3255af..2907f0ebfbf 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -796,6 +796,9 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 {
 	struct property *prop;
 
+	if (!sym || !sym->name)
+		return;
+
 	if (sym && sym->name) {
 		str_printf(r, "Symbol: %s [=%s]\n", sym->name,
 			   sym_get_string_value(sym));
@@ -809,7 +812,8 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 			}
 		}
 	}
-	for_all_prompts(sym, prop)
+	if(sym)
+		for_all_prompts(sym, prop)
 		get_prompt_str(r, prop, head);
 
 	prop = get_symbol_prop(sym);
@@ -823,14 +827,16 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 		}
 	}
 
-	get_symbol_props_str(r, sym, P_SELECT, "  Selects: ");
+	if(sym)
+		get_symbol_props_str(r, sym, P_SELECT, "  Selects: ");
 	if (sym->rev_dep.expr) {
 		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "  Selected by [y]:\n");
 		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "  Selected by [m]:\n");
 		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "  Selected by [n]:\n");
 	}
 
-	get_symbol_props_str(r, sym, P_IMPLY, "  Implies: ");
+	if (sym)
+		get_symbol_props_str(r, sym, P_IMPLY, "  Implies: ");
 	if (sym->implied.expr) {
 		expr_gstr_print_revdep(sym->implied.expr, r, yes, "  Implied by [y]:\n");
 		expr_gstr_print_revdep(sym->implied.expr, r, mod, "  Implied by [m]:\n");
-- 
2.30.2

