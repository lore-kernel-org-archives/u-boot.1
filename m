Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69E5C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 14:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC687849BA;
	Wed,  8 Jul 2026 16:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bbwCwX7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4ACF849D2; Wed,  8 Jul 2026 16:32:22 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF19484994
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 16:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-92e67555e24so35845285a.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783521140; x=1784125940; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZMG5TEcUuUXVMUEzyztTkgmn16k5vqB3IflvuydOI/E=;
 b=bbwCwX7zbEYNCG3mKWgz8atqIBWaAP6XVadF1adeoXQoeK8H10mTV/G3lKOMAJpXov
 J/g2OivneT/8sv/W74eavSani0XDNI5PyYHhtwNI1xLyBquGMoAWV3InDKDL5iNlOiHd
 EjN4mdHYkexYUqlmSYg+vJw6V+3F22X0ZrWVcQD7QBVbH95Ch5DmOPg6xFjCTjPf5V89
 nIaIRBO9ITBXAnMNw4sKfhsYc8zFh9fvDaZ1RH2JOcrqCPYvwjEOBelyGgabQ+poJELB
 hNCNJXO/JxlrRSCvwbx3dzdNMB2/KtQ10V7+sS1wSOFzpA7m+MAUDGUF+LCJWfwCMldd
 gRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783521140; x=1784125940;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZMG5TEcUuUXVMUEzyztTkgmn16k5vqB3IflvuydOI/E=;
 b=dHtNqGOXJjle/CHk7B3R9tiNPUsdcfAXSkkrQLsdZ/MxoWU2e6zjPMgB6mdmEUDW8C
 tVZeAaXCj1F3L78RdKA61ITq1hwRQdo4K9f551fJlwX0uYd81FEDkpYzLSDVoAIRpoDz
 5avKCxJJ9+owJxWpSm0+YbvHY9bHmRUMnULJiuuR7IulJ1VFPAUEub6FJzmgpoQkmIpc
 d9xzUvkhuNrOUTaYg0DV+cwi68YFA8T84TP0Tc5Ol4YPdrC2GIDEZw/hl+PDKRy4AQng
 V24cE/vCq9kZDXatDOUlP3oNVUQCYoaXnkZ3Pq8Y+33kthRQCPZLkIwE4lCUDh+AnKiE
 q+NQ==
X-Gm-Message-State: AOJu0YyJaU4703rcXoKkF7E58z5mt4NKWBrFaSn9vcMTmXboXOyIFGDB
 F2cabuBwNeXFHpasOKlqopripLJs71VlvWaSYfbwyP3/fJEEnJ+Ggyur
X-Gm-Gg: AfdE7ckTq01NdPilmatu+7T+f2YlllX9evE82xBgNfoEh088TxkMIdG/DmKFW2Df3+J
 Y3uD7HWzUXQqbBuhKB8NyJn4p30097G0fHdj6NGdDdPPE/oNcAh59A3CSOfL4BJZnoWAxGG2926
 OPqirYht4jTwsjop0+CADMafsP14oqxDrKmh7Hc4lvCGUySguiYC1e0Wc/BRJgZyT+Pibe72tVC
 JhHytq5lkLqjZlM0M0unVCZ0g1GhlM30Sjy32GR41Nyntu86QObwlL7TlgYlhVeN9o4afDy8ClJ
 xW5LpxIVMBOc3DHFT7iIebS9f8XGFsb8lf9zNNrjGTHbtn4ho2DPXruw2Ulm4tl1hKJzfIIlgCR
 RgmLZTc6C2R4WXvsF+nbKPvdKXkuScN/NOr1HWeFPV7JUlEdNn5ulm5ykOyQxYjTbOVWwJWgbLl
 mIMg60tGi6Ew==
X-Received: by 2002:a05:620a:45a5:b0:92e:70e9:6865 with SMTP id
 af79cd13be357-92ecf68ce28mr261772385a.59.1783521140441; 
 Wed, 08 Jul 2026 07:32:20 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90b804dasm1417154285a.1.2026.07.08.07.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:32:20 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:02:17 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: led: reject unknown LED state instead of silently
 returning success
Message-ID: <ifny32czr2jodibz3wyerwqfjzbepdkt3tfhvgw5qp6ymm736m@kmqqewswdxqq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

get_led_cmd() searches state_label[] for a matching name and returns
-1 on no match, but its declared return type is enum led_state_t.
All enumerators of that enum are non-negative, so the compiler is
free to pick an unsigned underlying type (and does so with
-fshort-enums, which several U-Boot targets enable). In that case
-1 is reinterpreted as a large positive value and any subsequent
comparison against -1 silently misbehaves.

In do_led() the returned value is stored into an enum led_state_t
and dispatched through a switch that has no default arm and no case
for the sentinel. When the user supplies an unknown state name the
switch falls through, ret was already set to 0 by led_get_by_label(),
and the command reports success without doing anything.

Return LEDST_COUNT from get_led_cmd() on no match. LEDST_COUNT is
already a valid enumerator, so this avoids all questions about the
enum's underlying representation. In do_led(), when a state argument
was actually supplied (argc > 2) and the lookup produced LEDST_COUNT,
reject it with a diagnostic and CMD_RET_USAGE; the existing
LEDST_COUNT switch arm continues to handle the "no state argument"
case where it means "show current state".

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 cmd/led.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmd/led.c b/cmd/led.c
index 296c07b3b38..d547276e480 100644
--- a/cmd/led.c
+++ b/cmd/led.c
@@ -27,7 +27,7 @@ enum led_state_t get_led_cmd(char *var)
 			return i;
 	}
 
-	return -1;
+	return LEDST_COUNT;
 }
 
 static int show_led_state(struct udevice *dev)
@@ -84,6 +84,10 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return list_leds();
 
 	cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
+	if (argc > 2 && cmd == LEDST_COUNT) {
+		printf("Unknown LED state '%s'\n", argv[2]);
+		return CMD_RET_USAGE;
+	}
 	if (cmd == LEDST_BLINK) {
 		if (argc < 4)
 			return CMD_RET_USAGE;
-- 
2.43.0

