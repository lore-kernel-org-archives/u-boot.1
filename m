Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A2AC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 01:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9E684942;
	Wed,  8 Jul 2026 03:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n9kiQ4at";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE348499C; Wed,  8 Jul 2026 03:30:29 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABEB38497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso144104a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 18:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783474226; x=1784079026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=imtVOSIYnQwPsTJZSlflLLlr0E0LjxVirlyWymafiqw=;
 b=n9kiQ4at9fYa1IcnRyol5SphWsJhT2F8Zw924+aJ2wug130Bu/HqlGg/YxyeP0Emij
 tOYKjEeW6FFW5cFfNUIO0z0wHkzSRsiyhjcH98+OqTUQ/IPiIFAwbtqWOzy8aGkwPMmr
 /9XUFknc57mQP2UFWABV8c4yf2n9LTd1sAa0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783474226; x=1784079026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=imtVOSIYnQwPsTJZSlflLLlr0E0LjxVirlyWymafiqw=;
 b=Hvvvf1Cvw3ikqlUYm0JrgyTDGYc9l/RuIr/q6kG0j/GMTlgijWlnVWAocaHLly5Mv8
 MT4DtKxCXx6YIXQlbj/ZcqtdgiWf67JOjLfqMK/7V07hNfpgXYg1HrUohywM2xViqXl2
 KIODHj9GLz6sdjvYSnDcAjpmDLOAslW6b8YzmWj0YMmLHVz7rsD1LSsJKO+6A2ydaZzi
 C4fr1yAQroRRzxP26uld01O6Rx2dOehvz731ct16TDlqRPT+yJZw0nGxa0r4FmcU6X+e
 27Oc1eGWBD33BAzhkx5jrAxtvaMYv55h9vAY7K4bO4t3x3NPqYcBogmiqNm5Hu//uGy/
 A09A==
X-Gm-Message-State: AOJu0Yy9z5AbfSo09/dGNcb1bTPKUbIq64dmnQwnuFbWNzlUNjkeeT4T
 HN4UjHTNbhovrF+TJUC8XcceQXRwP2ZYzcrUWnIKt5Ek6akP47JPKRpeWJwrXPOX777668l3+++
 bXyuuahc=
X-Gm-Gg: AfdE7ck09H+1CzHwSzZvb6GUG7y/cuDHl3jP1GEDULaBtkiwIVbaPvtyu+MqTrMrZSk
 2xatD9QXmmID1cR/GljEGhv4Q+b9yXz0SfDA3w4kxwyFrAFLaOq4wODDpQwD2tvzOjH11GJUJz3
 CvaZZM8u4yI0L1Auinn0a4SYnzzOkaCwl+CvF/MUYT5d5N1JdAMCCBm7e7S/AZ4XJ01aA/vyEFO
 UWKY2qCVXOUsDFa5fX7MRmGA8OqPwniRLwfJzgci09t1dgqymMBBBUjv9zN6DejJUKY9e9w5v45
 3RVF0FgArCptk4BhzdMYIi1Ib6ko4kRmrDEVjgV28aOx9jfAuiOBumsb0QfgBkkuzodekziJG8W
 f4+9VmuUp+/oN9nPJpHRivZku9lI7hxXFo6mIOivhTqmCQ+wJf5vS4JOi+O6lYZ80afgvjPUWeK
 K7BVnYbZoGSaUx6V1rhhfen7gnmsVjrl+y3Zv7tZSlluRI7KuDjwC2lRRf2tZ2OmwY71jBgjSdy
 kCJUB25q1TyRPuTHXXRFMLXzkYDYM9JZSifA4kxq6CzulrjB05U2gcoNSWbwQ==
X-Received: by 2002:a05:6830:81d8:b0:7e9:3765:79c2 with SMTP id
 46e09a7af769-7ebcfe7cd01mr281517a34.12.1783474226349; 
 Tue, 07 Jul 2026 18:30:26 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf77ba4sm780182a34.9.2026.07.07.18.30.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 18:30:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/7] dts: Make DEFAULT_DEVICE_TREE depend on !OF_OMIT_DTB
Date: Tue,  7 Jul 2026 19:25:14 -0600
Message-ID: <20260708013019.288985-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708013019.288985-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
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

When we have configured the board to not omit a DTB as part of the
build, we should not have to say that we still need to build a default
DTB for the board.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 dts/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index dcabe33c1c1a..2eb48223de2b 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -216,7 +216,7 @@ config OF_OMIT_DTB
 
 config DEFAULT_DEVICE_TREE
 	string "Default Device Tree for DT control"
-	depends on OF_CONTROL
+	depends on OF_CONTROL && !OF_OMIT_DTB
 	default "sandbox" if SANDBOX
 	help
 	  This option specifies the default Device Tree used for DT control.
-- 
2.43.0

