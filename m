Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1286C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9179440799;
	Mon, 27 Jul 2026 17:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VziB2oZ761Wz; Mon, 27 Jul 2026 17:14:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FCDF4078C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785172478;
	bh=ZxPxn1YkOoYz8M5HkrODrLMl3xpWfXKeqOpbLlk6Y50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qg7OrQRaLRHE+m30XvoM+iBL3UZJCIOtBuQBvcN6ZCM1fSOSi7pU/2/5yrOGbM3t0
	 dhbnJfa9ZeYD2jJ2bbasPvZkKTdo8issJ/rZmQWAC8//D+SE0dLItmydy1fH594Ppm
	 F4Ymw6WA2kI7j/xU2tis6OFRyVDkpnrTzJ0SKmzYYu0HxiVgJBhJUvhZf4M2vOzApX
	 +/LaydwxtB8J56oOnaPNvykNLB2O41SEf33Ejd4u5cveefPPaKyAXQ4ipW5UzHPD76
	 xwdOgGboJInVWgRRRAyfNKaXZUsfvQ3VZFQxK15Lr+4w3LlyGOtdRy+/Q7rayTavDJ
	 hCPBmvroECYcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FCDF4078C;
	Mon, 27 Jul 2026 17:14:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 97CF92E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 898A140741
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e1ptL3LKUkYl for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:14:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9657140720
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9657140720
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9657140720
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:31 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso1606656f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785172469; x=1785777269;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZxPxn1YkOoYz8M5HkrODrLMl3xpWfXKeqOpbLlk6Y50=;
 b=sy+vztaPsUD7SK0eENhwWols2ayHbKelq04dUFN4N51533WyF5ryTvCmSt8FyZbg6m
 qt5vHkOpYV4R8mducVP8GX4y23KxoT7tYBfNGsrxVfnqaLVARMh6sPaPinAnZVH7t5a+
 l2kfXssI2NQ+sa9UFNHYxkVJ6DdiEy+cP+lZ8m+gYIgm4jY9UghMGqekEVAvUyAKViYd
 0LCSxwy8Rb1lC37baTNT1pcB9AGaLvhoDwp6QXNXSo+V7yJhaR7BbRXOW2kyZhi+NCGl
 FAzOAnjNhH4NbkbSjQ67sJtE5c+sN2z8Gy1zT9d0xU3PqzOTE2Zxl/juyyds9kL449C9
 gH7g==
X-Gm-Message-State: AOJu0YywrqVoJwf0Bm+0ogtbito3iALk1qHiA75pLIDCDJ24nZ6wmNnB
 qQNREnNhya7nabjQ/5vGIs7FjhVImEaanGYeHzCX2GChm8aSMbuyhFWg
X-Gm-Gg: AR+sD12w3dgji2R1nU9cvFUjVzE/ijdnuFKoXnU8pmqLjm7g0Ckf+szh05SQ0iJIPv8
 grUH/o2W9gnDFjSoc4lkdTV+6+824VYw9L+mSGuWebkrQtA5sQJJlw+CIgM3XItXh8srfAhuYrD
 3T4rBrfpOWCFYT92f/xeHYwOgW1+dDYLR9BByDdTV+ZCkTEZlwnL4Yy2Mksn8wdqPraSIuDei/c
 PqWSx7yWX2HROYxfO+hNRSjFhcQwCUWKS1XJoTHMZKVFk3YxrpCakwiUq75JrwVXX+Si+accL4k
 a1pViyi0oaJXUxuJhkCTUC0cxt751jO0D3rRn4clWDnbS5kXCjqQ6tbhTQXDATAqdvR2rrs58Bn
 IzChYpRwL0ikA9pis5OkCfJWdefr9HkLYupq90OvYIwu3l4tTr5TkPVvTrneOkyzk/Eu/zoG8gc
 MuAtqz/piapLq5aAi0KQdlpJCFdNBunq9Tf3A+wcBqjboDvL9SWWR24DZ+STn7Wo3ceXDYsf7LS
 4r9Cq3W
X-Received: by 2002:a05:6000:1a8c:b0:47f:93b4:2df4 with SMTP id
 ffacd0b85a97d-47fae7a0458mr2059232f8f.39.1785172469446; 
 Mon, 27 Jul 2026 10:14:29 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm55287391f8f.7.2026.07.27.10.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:14:28 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 27 Jul 2026 19:14:16 +0200
Subject: [PATCH 4/4] doc: android: document the AVB root key source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-avb-root-key-pluggable-v1-4-7e27b2b92cc0@gmail.com>
References: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
In-Reply-To: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785172469; x=1785777269;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZxPxn1YkOoYz8M5HkrODrLMl3xpWfXKeqOpbLlk6Y50=;
 b=IWy0rzIBER11fVWOyS7f8TJU2hdbwltFvBslHhbUSiwczQXu4QYTRmh71NdwvTm6Kw
 ATSBLm0Jjxn1CyMume66CFD4UtqDrHbbWVncyO6juf1zkG//HWmCoJheSZxUk+AfkIVZ
 FtOFQ3MV+aXAA7/0n3irpPJH0ugswFHss8djuugPYVhXV5BarvVkRCbzwwqMw1qFR5Wv
 JrU6OwsNUydlcwcylUd5qdIRxGBKuw7dC1Xa2nlM+5ZQKTM5G7+9aXaZh56S+sXRHSG3
 LJ4YgTeNO5BhUWNMgypIn0gWxdFpkMyDsY0TyI2DW2+3pk1o4Pzlr3R7t2sves/rJp8/
 XldQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IWy0rzIB
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The root-key choice carries security pitfalls that are not obvious from the
Kconfig prompts alone: the built-in key is only a test key, a digest stored
as a TEE persistent value is worthless unless the TA refuses to overwrite
it while the device is unlocked, and the board provider must fail closed.
Spell these out so an integrator does not ship an insecure default by
accident.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 doc/android/avb2.rst | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index 178e8a2681e..b79b2468968 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -37,6 +37,43 @@ indexes and device lock state are stored in RPMB. The RPMB partition is managed
 by OP-TEE (see [2]_ for details) which is a secure OS leveraging ARM
 TrustZone.
 
+Root of trust
+-------------
+
+AVB anchors its chain of trust in a single public key: the key embedded in
+the vbmeta image is attacker-controlled, so ``validate_vbmeta_public_key()``
+hashes it (SHA-256) and compares the digest against a *trusted* digest. The
+source of that trusted digest is selected by the ``CONFIG_AVB_ROOT_KEY_*``
+choice. Any error obtaining the trusted digest fails closed, i.e. the vbmeta
+key is treated as untrusted.
+
+``AVB_ROOT_KEY_BUILTIN`` (default)
+  Use the SHA-256 of the ``avb_root_pub`` blob compiled into U-Boot. By
+  default this is the AVB reference/test key, whose private half is publicly
+  available; it is intended for development only and MUST be replaced for
+  production. The built-in key is only a meaningful root of trust if the
+  U-Boot image itself is verified by an earlier boot stage.
+
+``AVB_ROOT_KEY_TEE``
+  Read the trusted digest from OP-TEE secure storage as a named persistent
+  value (``CONFIG_AVB_ROOT_KEY_TEE_NAME``, default ``avb.root_pub_digest``)
+  via the OP-TEE AVB TA. Requires ``CONFIG_OPTEE_TA_AVB``. The 32-byte digest
+  must be provisioned into the TEE beforehand. Note that the OP-TEE AVB TA
+  lets normal world write arbitrary persistent values, so for this to be a
+  real anchor the TA must reject writes to this value while the device is
+  locked; otherwise it can be overwritten from normal world.
+
+``AVB_ROOT_KEY_BOARD``
+  Obtain the trusted digest from a board/SoC specific strong definition of
+  ``avb_read_root_key_digest()`` (for example reading a hash fused into
+  OTP/eFuse). The default weak implementation fails closed, so a board that
+  forgets to override it refuses verification rather than silently trusting a
+  wrong key.
+
+Note that device lock state and rollback protection are only enforced when
+backed by OP-TEE (see `AVB using OP-TEE (optional)`_); without it,
+verification is advisory regardless of the root key source.
+
 AVB 2.0 U-Boot shell commands
 -----------------------------
 

-- 
2.53.0

