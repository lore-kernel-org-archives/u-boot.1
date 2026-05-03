Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F6ACD3424
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 20:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F4D8465C;
	Sun,  3 May 2026 22:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SPzuK+jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187558464D; Sun,  3 May 2026 22:50:26 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E248465C
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 22:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7df05fc49e5so197985a34.3
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777841422; x=1778446222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y0MMJ+PALVDpqV2fL5w3ouH0TD4nReMRMutIunEU3E=;
 b=SPzuK+jdDVKWU/VChpnzL4nCWl2Q9zSOxgUkZagv/nEcB+xPyRgjdm+dUbFNx4aXB1
 FUhmrPKWlaYEns6Jl7hS1ucHu2YTjrV6kdVGgiPuqwmp7/MY0mACMpvlXu8le30BJzR9
 fQzfPfaC9gay4sqNpcpwS7eq99iSLusURB1Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777841422; x=1778446222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5y0MMJ+PALVDpqV2fL5w3ouH0TD4nReMRMutIunEU3E=;
 b=Bb2Mysar9f4Eut+/jGR/mLzpdq5qzidfu+BGFlsKf2CxomzcgvM2dG66klZwi9fHjg
 dg2/7DRD1Z4XZ7/gJ4cdN0RsSgcge7thPpJE2DSfu6lTQ7fVmJ7ClmrgGbS42tpM6FDi
 Lbxo8E9oe7ZFVNinXn0m//1Tb6PjoCxxF0Mi2jkhTmJ8zu31p7eChGRQgXeutjFZ+PN4
 gVu73GvNHBX9Ph3VjyVs4ECYmQQAvew/sgwz2yDqY/bGlHk1ei5LyGf7oJG+MWJ2wSQI
 3YArabD6m/I/3PRbgt1VHRKEgMBQbq7lp45WCFiD2mvesfRrvkbIRdguE5NszOjQr0vN
 /gSA==
X-Gm-Message-State: AOJu0YxYWHUjgC1qojs2Bo1tsMuyxgBwGCOygvDdY+xJW9Kwk4pvY6jF
 YtcA1/BVwZ0wMoUTeixNflqGLNFhZ7hhgvuWOA1k3wWaSK/OUQuk/jIg9xuWBj7PxBxcEaSzP3P
 4g/s58Q==
X-Gm-Gg: AeBDieuAGQ4VPFGmWRU7aHzZPQM7ZHLqE0X4Rfw3pshhXeW0M+DfeA3ah9vTPAfXQQ8
 qcXkEo3TIiOhMWqjYk3rA7JyYtpP8edqY3YKklaOWzKHekP/AwDRR9Q0dozhf3HOWiqvIdBBcTo
 mvQDiP2DSXquUVZKl5tfOpYuFQ+zlGo//GVq1RUwlOIj1/bDIDdCU3OWF0LPqIfcq0Xibg5TfFw
 f6JfSRM6TUCJ9YsWYsRANZyQw574I+yVwrmiTBItY2YWhH3hOh2GYk3c2XbzDZznycHIbcb37pc
 BO5jczysMwrQBWq2QzWN6KB/mQVpYQHLS7HMeoJuGjM3uzDsxlOXm7uJTNmbbAu8qh9FogTuCHh
 r+8EIU1TExjlB08HfjKDmcLPgY5hcsXCNSDgWFc6TTD9kq8tk9WitwdKh9WuIX55Vb9eTILrY/c
 iTf1/TMSGsvkkSaC5H09B34Qnz08jD
X-Received: by 2002:a05:6820:1789:b0:694:8428:dfd8 with SMTP id
 006d021491bc7-69697c60c77mr3188435eaf.34.1777841421835; 
 Sun, 03 May 2026 13:50:21 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696aacbb5bbsm1142940eaf.15.2026.05.03.13.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 13:50:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <lukma@nabladev.com>
Subject: [PATCH 5/6] mccmon6: Quote recovery_status in bootcmd test
Date: Sun,  3 May 2026 14:49:23 -0600
Message-ID: <20260503204936.3151124-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503204936.3151124-1-sjg@chromium.org>
References: <20260503204936.3151124-1-sjg@chromium.org>
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

The mccmon6 bootcmd starts with:

    if test -n ${recovery_status}; then run boot_recovery; ...

The default state is "no recovery requested", i.e. recovery_status
unset.  The expression then expands to 'test -n' with no operand and
relies on a U-Boot 'test' quirk that treats a missing operand as
false to skip recovery.

Quote the variable so an unset recovery_status expands to 'test -n ""'
and the emptiness check is explicit.

Fixes: 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/configs/mccmon6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/mccmon6.h b/include/configs/mccmon6.h
index 9f401718bfb..0cf62d6bda8 100644
--- a/include/configs/mccmon6.h
+++ b/include/configs/mccmon6.h
@@ -88,7 +88,7 @@
 		     "bootm $loadaddr};reset;" \
 		"fi\0" \
 	"bootcmd=" \
-		"if test -n ${recovery_status}; then " \
+		"if test -n \"${recovery_status}\"; then " \
 		     "run boot_recovery;" \
 		"else " \
 		     "if test ! -n ${boot_medium}; then " \
-- 
2.43.0

