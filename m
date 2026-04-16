Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7ADF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D0F884474;
	Fri, 17 Apr 2026 14:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ESn8gILQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2740B841F2; Thu, 16 Apr 2026 17:20:23 +0200 (CEST)
Received: from mail-yx1-xb142.google.com (mail-yx1-xb142.google.com
 [IPv6:2607:f8b0:4864:20::b142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9A6840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-yx1-xb142.google.com with SMTP id
 956f58d0204a3-649278a69c5so6790809d50.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352820; x=1776957620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjMt5FfFUjBZkNKWcKRTVKFgaNmjlBbG3pSMdJEyPck=;
 b=ESn8gILQccay/xpG5mXNyRTrwvtMLOI9g5n5prML9UG+wo6LaUwFxl8o/ptrYY5pNv
 j44reFqNYMFyWlpFH+WVDKlYLM6SvvpYl2aIAWvITbfvEm1mh09f3pOYuF0aIc39ne9S
 AkAelKrnwke2EQoD8DWJLhVuCpzPd0e3C66oJKQSjrdpm+P05dzBzlxjd49aB5Tb67hB
 p1TscYqqjbVA0gHDcjAT8GccTdwkG0nKVead6UgZyRt7JGT+SIsneEaRru2y22A4GVUM
 IwjhoaSWSlgvPxp6R7v1RIRKdH/SIX1faxGYGYnxQt2UWT8vRWuJ4j2DHN+RTz3baVy6
 4p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352820; x=1776957620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjMt5FfFUjBZkNKWcKRTVKFgaNmjlBbG3pSMdJEyPck=;
 b=I/4VgbCZRQ+5EvAfSFThKFWNeRlxXdRZKCyb5jRtV79YePURdolhMUqYg97MeP+Iav
 zn9gCZVe7zBGIG9g81BSMestwKUtXDjNJwK7Oz211PeUFo3j5t1NP+MNoHPs2c1yZoYN
 m0jKHFwAP5a82Yji2O2+hPKKb69LkPsi1DZnAQZU/x5revJ7nn7sR6T4O0MfSmPB6LUl
 bAfBSEQgKN0g/Ka5lVdMnZ7ZWvgiRR65tT+8+dwES25bkhbpuXWzMtLf3/BrRqSom1wg
 FbB5JZv/NIMVBv8aOJ14Z0dS7XcQmtVymtzRTkG/6L5aRFmvlKZFTPKte8wzrATNw3dl
 7NLg==
X-Gm-Message-State: AOJu0YwGm8GtAApIavhhex8nEMejmiZHgzzTDhNXHaezXUSzlWgjORu7
 vmN101pU6rpKRKR6+7byWtlVV5/Hf1Far8xzE3UlOxyb2ws3uEX5UpgJlr4krsbB
X-Gm-Gg: AeBDieumaqJwlqH+8m8fqY4Ni4zJq0aN3g8oCIfIH4t0kx5ifFTk2hPcFEZa+nugeOm
 X07hp/4Pllie1ejM8LdiCDmiDXPT++Ut/3Qpr31GgFIpYCOSnrmfjusncnCXDrUzYC9VnUWWeRe
 9zygKhL7rTW0AeZjp0dGtCCIgBkXdR1/xJ7fnmRDTq0g3rCFPoyPJQ+IykXp17OLLLroSRPx8JO
 SFS4ZuU6PliTYr0yQH/Te/dFVCbR4NaVMjBdRH0vUpAwK5+4ikwOABOJI2sXuxCTLDlhnSR4Tua
 IC3EJlp+tZnDfT0hw0VbccQB8asitNzdTWDb3srOyoan2KWMAD8NsMp83c91Uf8HsieRVd9YR1q
 ZoQ+ZxoWEVuTtSIg0C//7tfJHqANWXLn73/Yy5XqKPoLSGXkqYQZVrwsjIc7SODU7KVmpmlS2Ar
 Bf6ooeMwVcgIJfz0urAwWTbmZ2vwBdIM/ga7MdvE6emvWF
X-Received: by 2002:a05:690e:190c:b0:652:55ec:6a1a with SMTP id
 956f58d0204a3-65255ec7219mr10134190d50.60.1776352819780; 
 Thu, 16 Apr 2026 08:20:19 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:19 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 07/14] dts: sc594: Fix gige-reset line on EZKIT
Date: Thu, 16 Apr 2026 11:19:42 -0400
Message-Id: <0067cab6ebf6390aa2fe97ce8f403c4e6b8ed940.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The gige-reset line on the EZKIT was updated for the
sc598 but not the sc594. This commit aligns the two .dts
files since they are describing the same hardware, the
EZKIT carrier board.

Fixes: be79378 ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc594-som-ezkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index dea9a6e27f2..396502b6745 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -130,7 +130,7 @@
 
 		gige-reset {
 			gpio-hog;
-			gpios = <15 GPIO_ACTIVE_HIGH>;
+			gpios = <15 GPIO_ACTIVE_LOW>;
 			output-high;
 			line-name = "gige-reset";
 			bootph-pre-ram;
-- 
2.34.1

