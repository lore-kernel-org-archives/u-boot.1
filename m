Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B3CC54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D1482FAB;
	Thu, 22 May 2025 01:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JQt/kOY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DBC82FBE; Thu, 22 May 2025 01:01:38 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A3782FBE
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-606477d77easo4583269eaf.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868494; x=1748473294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fqODIuJmSGqMVJfiCxvzQlYFAKvljilxoe+df+A9/rA=;
 b=JQt/kOY2ZMwUEEzckK+BKswoQgbWvgUEluheZjcjAy2gQJSUZ8c/htyw1cGzFvgTBZ
 fOvM9YIX6OX/s73IbYLGG7+uNR8zqfhOHACvFeap45cZviYripCVrHKXaolbYc1urCjs
 NSerbupZFBpSTWiHtyG59VL9jQB9AJ+bUQ1m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868494; x=1748473294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqODIuJmSGqMVJfiCxvzQlYFAKvljilxoe+df+A9/rA=;
 b=lIrFm+B4h2+q/mU5yVON0Mb8GQvbWYn/mnZS5A6TsK2Pn9hQBo2Um2bT/8GPvp7uiI
 PZhKxIJV1QTrU17P3Bfs2VYJxPnCzSN71AX3dTjXWlW73kkT9zrI2iy1j3qHH4k2HaxG
 4Vd7ZVPsru3aUwwt0hAh5HZxqfps903y35HkWZuIN1PROJfe2lpiYTkXEPPA2pb0hfKH
 Y8G5DqUJHnoMovl4aRroClh2jVSHYttIA2s3CXOf/oiwPAFK7Yvz79eDNVDqZPBdFN7j
 0Wdl0Y1+TFAs+km4K9qdrQ17DRyqNT7q004n0XRlAVLUSjgqk5I4FbZoC7bNz6BIHHCB
 NTgQ==
X-Gm-Message-State: AOJu0YwS4uLSlfbkcF7R9ek3JHYXFarza4OWbxMHPPjQTxc0r/TOhegZ
 TTrCGQdzDgSgCNjhsLqJTjMKOKwNbgxhydUOFS6tTQolmRzPp5gDRIU78hp62PNNHtiXQZIXPgh
 w0xhqt7o=
X-Gm-Gg: ASbGncuxlWBA9doJZ4gfKm9MqSUArWyMim7iuvYOpqIt9+uvsN/uPup6pVeYVlHHWpT
 OZfZ9EDIe5aa+YbPVCR1uHrD0cMLrNsaS5baBnIR2D5der8aIslFkn5jjDa4mLkN4J5Xder2mG5
 VXPyT4Gh9OaAWaINvyEbztz5HL03WksIKsU6ch2Zl/11MnLtTX/QWzezAQCoaKXQ1pf070i/nlI
 wyIhvYsE8ARK299rO1dGouB4tvi0XRqpZShMnFv70e2MDo7hWtnPbx60lgJlX5QXOpV7hQUSNhX
 dnr4EzswzVpC/9jH/gh+G85dXNvwuZL2E7zXELu13VqbK54w0a/YstOPPzCNpIZ2zZZzND5kF6y
 8WX6ZYs3VgrmwfHk=
X-Google-Smtp-Source: AGHT+IFReMsDjkf+qkYHTK/zF8o9g04VPxbfKnyYDwnCLEqCQxV1E5wR3En3ef06ssUfFRke8Bwe/w==
X-Received: by 2002:a4a:ec43:0:b0:603:f809:ce19 with SMTP id
 006d021491bc7-609f38b5d20mr12553153eaf.3.1747868493694; 
 Wed, 21 May 2025 16:01:33 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 07/17] include/cbfs.h: Audit include list
Date: Wed, 21 May 2025 16:51:12 -0600
Message-ID: <20250521230119.2084088-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <compiler.h> but does directly need
<linux/types.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/cbfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cbfs.h b/include/cbfs.h
index 2bc5de2297e4..1244dbdba0d1 100644
--- a/include/cbfs.h
+++ b/include/cbfs.h
@@ -6,8 +6,8 @@
 #ifndef __CBFS_H
 #define __CBFS_H
 
-#include <compiler.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 struct cbfs_priv;
 
-- 
2.43.0

