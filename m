Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05E1C54798
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 23:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B67487BAF;
	Fri, 23 Feb 2024 00:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJeD56tG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FB2788081; Thu, 22 Feb 2024 23:18:37 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F08C87E21
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 23:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob.wolff68@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-607d9c4fa90so2839507b3.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708640313; x=1709245113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7mb1y3+1sZMjQ99X3U2vmZuG0v1cJV9fYhP3OMRJe2U=;
 b=BJeD56tGJZsMiy6BlICJTtnOeLpymh6LeN3CXCPNuDI3cZp5s3ugWjgzqIt18dL8nS
 sC20LEi2qCd3Qztc8XG/UHxBVHDM+wZhSu+SgbnaLMx71fH+DOLzas4qhBu2whG56LEZ
 BcRNQLniyziheHfzLHKty2V0fCmjNXTquA4kXR4/xovXSR/PNlPoHTb4LgiKITcwTjuw
 a++9HYLkYj/aNytYwhDfGFOXyT2n/YlSZ8WkzkeokqB8CgbveOAzEI92Z9zFpIPDFg+g
 BLdhU08bI0QmY3JrYjkkeT1HJSbaWnwBJvKIwJV/uTEq+mHP/kB7S2KJJA1aQGfF6Lms
 65qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708640313; x=1709245113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mb1y3+1sZMjQ99X3U2vmZuG0v1cJV9fYhP3OMRJe2U=;
 b=sjUwRoUj9CsvxMzxnVY/Atovz8gMmYY394Q1R/WZ4X+8VdOt9iJujFlHAKsfDxczcs
 piiKUJIkIZ4lwThI6Vob0+TIgJk1YUMKLT8neMW/Mf9MIIktQAlnyEOCMZuxwt166Bia
 ozjMiXY9KkkdoBTbFeeNm7IqdlJVVOlib9De3ALFM8lRZnnL9BWllUdBYjmde6Ar0xfV
 iR+mvkc+e3oZzTG+uFBQEY9AxPf4IVLyWXImTqtuhIwlG5CyiHy1eSz4WONSsgkUnsEo
 osO6yTRKK77QmVyamI1ekwxbkLin54w2FycXXto0F3nAaWGVK7UYxiBqgxctiCdZdEAO
 eamg==
X-Gm-Message-State: AOJu0YwWBwhvhfbBOFLXPNReeBvR/T+8B3C+wZ2SGwBhEU8wLllH6f4l
 cctawyPDb5F31/+4NcD3OpmX97JgTgMwfNFXH09HK9QA+3emNQVV8GgEeF8x
X-Google-Smtp-Source: AGHT+IGT6/bYPm/U2Pmk54QqI3NeFUAS2Sckni7uEQ89pCPReS4YffSB/Nvn0domBh3LnyCRsPK4SA==
X-Received: by 2002:a0d:ea84:0:b0:607:9d64:d68d with SMTP id
 t126-20020a0dea84000000b006079d64d68dmr478517ywe.11.1708640313278; 
 Thu, 22 Feb 2024 14:18:33 -0800 (PST)
Received: from localhost.localdomain
 ([2600:1700:bad0:373f:6c8f:ac7c:db9e:aac9])
 by smtp.gmail.com with ESMTPSA id
 et4-20020a05690c2e0400b0060892566df7sm701561ywb.23.2024.02.22.14.18.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 14:18:32 -0800 (PST)
From: Bob Wolff <bob.wolff68@gmail.com>
To: u-boot@lists.denx.de
Cc: seanga2@gmail.com, pbrobinson@gmail.com, Bob Wolff <bob.wolff68@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] Check curve_name for null to avoid crash
Date: Thu, 22 Feb 2024 14:18:14 -0800
Message-Id: <20240222221814.3496-1-bob.wolff68@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Feb 2024 00:02:31 +0100
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

If mixed rsa and ecdsa keys are specified in dtsi, an rsa key can be sent
into the ecdsa verify. Without the ecdsa,curve property, this function will
crash due to lack of checking the null pointer return.
Signed-off-by: Bob Wolff <bob.wolff68@gmail.com>
---

 lib/ecdsa/ecdsa-verify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 0601700c4f..4d1835b598 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -31,6 +31,11 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	int x_len, y_len;
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
+	if (!key->curve_name) {
+		debug("Error: ecdsa cannot get 'ecdsa,curve' property from key. Likely not an ecdsa key.\n");
+		return -ENOMSG;
+	}
+
 	key->size_bits = ecdsa_key_size(key->curve_name);
 	if (key->size_bits == 0) {
 		debug("Unknown ECDSA curve '%s'", key->curve_name);
-- 
2.39.3 (Apple Git-145)

