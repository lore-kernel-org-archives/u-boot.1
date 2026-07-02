Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC54C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CB684A0A;
	Thu,  2 Jul 2026 16:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GUQy5scz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35DA684A29; Thu,  2 Jul 2026 16:04:37 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E9584A1C
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6989c0ec3c5so3279479a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783001075; x=1783605875; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j7aZQFbwz3/6Vdx/Pn46ZHWN4Ap177qTKAMxklaR5/M=;
 b=GUQy5sczLwG17/rHVv+XMTsuqMhODkbk00gZvO9pg4qLC8d0V6xNt1FvRmzz5hElSG
 eZnyqiOp1C9q9Fj2V6c9Rd5ReyB2KsUTKa446qqdiBouHi/pwk3h0YBB184W8M5U+JzP
 c56RQJr6BwB5j7Lronji3mfoFxoE3WJxCG7U8BJZ1HD6FJ7pgZGp9UE4sDeNOaHNVs/d
 psHeRTGgy2bZv13WwK5abs/VYYxuGXRxMc6njojt5LzdhFR+fET0TMB4OdrTyjxVqPPo
 Uo+9jMs7u7GCUF6P0H7P+beK8VimCbrUHJdnCga9RpDelzgEmEe8+F2SucuECGLkUROD
 bG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783001075; x=1783605875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j7aZQFbwz3/6Vdx/Pn46ZHWN4Ap177qTKAMxklaR5/M=;
 b=RRBZD4d3W/XmSYm+0JTkhN7mRm9GGAIVjXs0oXYGjQ7KJKkV/hZQNnyK4nnEbSjpDp
 LmGs6I+rNk1RJwuW3uT7K74IXOxdTogod/uBa3oGGY3pL0h30Qhq6G+YtMh19opyPPde
 sQ7JOIahsA9GBR/LCRoIQGkHmNAOHuyB16Nm7ksOFVQqrScv2+ZnRZoE7Nkg4TFwun71
 GZ6PpDhCqgE11zVNMfvFIrVkd/zJSaI4G7i7XmYrAR4eh5ICFhHyVaRaXymFiELA2nLt
 mF7Asd6/QAwxldmxKyRVrc/+N9J99bfXTNU3DDZIfNgPannScMJ7hvh3j9mupWjUwCk4
 5Tjw==
X-Gm-Message-State: AOJu0YwSYdBvAtqwtF8gzWoD/Pu5xZFy1HV2gNpYfIxicwmCsmSSF8E9
 mSP80SUfHvDoV50LxOvPXpzilCk4eUtmT4+B+juaJatDb3ysUz3ulbgrkFJw6kvz53Y=
X-Gm-Gg: AfdE7cmtCcCqeJ/fh9gecx3YTkvCjpXRPKgseME5S5MgJ4T5UhQOLvmqc4lRFjb9A5j
 UZBV6a5q/v22VpEEI78Vwz1l/ByIrnYkd2BaYDTXrTS62HKF5dY5h96quytiWo9fbuAPI9dcFba
 l6sOex6M5fXph7i8Ie0xGC1v+K2cxfM++mmG2MO+vcQKDxH1nVQ2IDbpXZzXKAK477L8b/DbUc0
 PiNcCm9GfgUnuht3Bb3OGE6zBAlpXJWTRwFrBblTsSjVcLrql6tQAYqSJ+lxDgVuapej0RtlgxF
 1NTnPtHu01krREkmQE6OPbJ3y/jkjNjJ8hn5VZi47+QzpfpGkoUq+9NJwx6bX2YLXmwiln6vanq
 hKlwvkk/zxgJ6/YIKWIe20R/BKjhKwWh0YDTRO6Cvc5DUrc8gq3xTdsqsDUGVfPFmWo2jfy6lbv
 1n/WCmyNFb716gDLxvdWhousEqs0WpAQlF26XyovfzNk8MHZd5SceyiGLCKrMqS2pcKYDOabPAh
 mFYxuL434UqhP4H0iiJBc2c7S94UsFo3MdbrIcseeJfbEmvrBX0TH9NZL7OtxNFzT2CNmY=
X-Received: by 2002:a17:907:9701:b0:c12:58ac:9869 with SMTP id
 a640c23a62f3a-c12a9d4280dmr298465966b.9.1783001074287; 
 Thu, 02 Jul 2026 07:04:34 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde19fd3sm9577619f8f.25.2026.07.02.07.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:04:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 02 Jul 2026 16:04:41 +0200
Subject: [PATCH 1/2] tools: qconfig: print a proper error when database is
 missing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-qconfig-check-for-db-v1-1-f0b96bf8fa44@baylibre.com>
References: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
In-Reply-To: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

When CONFIG_DATABASE does not exist, read_database() would fail with a
Python traceback. Add a pre-check to print a clear message asking the
user to generate the database first with the -b option.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 tools/qconfig.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 5b85f9d22c3..9b151566e03 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -871,6 +871,10 @@ def read_database():
                 value: set of boards using that option
 
     """
+    if not os.path.exists(CONFIG_DATABASE):
+        sys.exit(f"Error: database '{CONFIG_DATABASE}' not found. "
+                 f"Did you forget to generate it first with the -b option?")
+
     configs = {}
 
     # key is defconfig name, value is dict of (CONFIG_xxx, value)

-- 
2.54.0

