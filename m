Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BB3C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AF988199;
	Sun, 21 Jul 2024 12:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c9VK7hmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F0A787E64; Sun, 21 Jul 2024 12:09:52 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA9187F7D
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so15697885e9.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556589; x=1722161389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqYwDwOSLx0ihxHHzrIHxU16O+SMROHfMeqCbeSYKxA=;
 b=c9VK7hmPMVHoy7Vj8iJWtHBwNVNXCQ+Dvoq8CVyPSHSfh4vPh7Ltf3OYOSkIh69pbl
 B8P7m1O6nCnxGVT4yVkYMLrMfNubvRxMd3/BMu3z5sPdd2NFnZ3l5Oi8BqDkmrelrbpy
 dVDfrFTeQw2uA8TfmV0/IGgdyOnVZyGHNyMzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556589; x=1722161389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqYwDwOSLx0ihxHHzrIHxU16O+SMROHfMeqCbeSYKxA=;
 b=kh/HRYvgTEvXIGqx4jR4aNw3ubBOBG4NGshywL5ZOJntge44/jxeLFacnDJgY0q35y
 4F2XXVMP+1YuOLOJ7Q/kSRm9rMNmQg+HO/65eDB6CpdTNrpU3oHxw6+Ci6FENQr/Jr8l
 kEcMMpVNuauS/g2oY0nsY15AMQZq5s4Kte5dVsTqZ0IrjP8EHz0RzEjd1ytRBo11T2rp
 xxtii8YPWwQp+X9Eq7LbViOS2VT6PwokMjrZbrjLLdXDpGZiWKbwUJUwb3E0QCuC1bJQ
 05R9Cysx6YWjxoRFCSo7vvY/79LrU5zdghimyH5SyuqF49vLpF5DSF2FQD3SalEshmdx
 6hKA==
X-Gm-Message-State: AOJu0Yw10ykx1xSvZ+cfaBusb7zfl4f4zHvbqD6BRnwBQwS+H53uKyDV
 +li0tdApLx+a9axdzdvDm6Dn80stZAmJ0/Qb89Vym9n0qgLzjXILqiJ8sukpsuX5Fj6JTpZKyX8
 =
X-Google-Smtp-Source: AGHT+IF+ZO8AVTU9kRrW4s6aBmmNVoyyexl3C5XLylhA+ToKkvr/5LhqucBraJGeEVR4tDs2W8aEIg==
X-Received: by 2002:a05:600c:5486:b0:427:aab7:976b with SMTP id
 5b1f17b1804b1-427d2a8e1b1mr64380455e9.5.1721556589304; 
 Sun, 21 Jul 2024 03:09:49 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:09:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 02/21] sandbox: Fix a comment in os_find_u_boot()
Date: Sun, 21 Jul 2024 11:09:20 +0100
Message-Id: <20240721100940.3202027-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

Fix a missing dot in a comment, since '..' is confusing.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 arch/sandbox/cpu/os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index a04eb5aa18c..da96ebe43c9 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -964,7 +964,7 @@ int os_find_u_boot(char *fname, int maxlen, bool use_img,
 	p = strstr(fname, subdir);
 	if (p) {
 		if (*next_prefix)
-			/* e.g. ".../tpl/u-boot-spl"  to "../spl/u-boot-spl" */
+			/* e.g. ".../tpl/u-boot-spl"  to ".../spl/u-boot-spl" */
 			memcpy(p + 1, next_prefix, strlen(next_prefix));
 		else
 			/* e.g. ".../spl/u-boot" to ".../u-boot" */
-- 
2.34.1

