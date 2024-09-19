Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEC8CE8D77
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 10:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 852058913C;
	Thu, 19 Sep 2024 12:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="loE7gEsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0DFA89127; Thu, 19 Sep 2024 12:55:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F2589138
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 12:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F5153F5B8
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 10:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726743331;
 bh=IDCuXNyRn+8eP8NAzxLAa7L1IRKHyaovhQvNtqIRauo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=loE7gEsIkkZQm+CC6Zn54t+4/FB+ZUNvauWzmrt+sk/e/6xbXD4Fvh/VThYX95T85
 ZGk4gaRoOKcsjFksQ5rI09c0Rm2Bh9pnK6xtQAWY1zejlkZ3NgD1x91++5kV37VV0k
 Yhug7kOBqNAvcXNDU22JIRw9WV6mTkL3ycyie+pB5C2fOon5IYsBaDWdkoGGbMaNNu
 y7hXFz4WCHtUVTX3pTfOkQq2iSzVOwNhIg0Xbt0G8M8h4/vt7JnuqK9qJVHrkqgFo4
 Al6RUsADzrmDRyumkD9r75Yjvr97LzutITwqFOlnW8Vy4sKzS0IBG+XkgxEgIWFcdB
 ITg00x9g+ebgw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374ba33b2d2so256853f8f.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 03:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726743331; x=1727348131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDCuXNyRn+8eP8NAzxLAa7L1IRKHyaovhQvNtqIRauo=;
 b=kkdX8wyMFCx2taGjYEWb+h4HNoq6Ylf2B1yx6PB2NCl2qPOZ6FwanIflC1GNXiDln7
 d5IlBkRdYwsRaCvG9y0AHhaaUx7ruJO7V7wQWdWpdSsUnb13WsCvgwvAaDqFPMxD562Q
 lnZLaduj4wQWBT5YBBI8Vo2JzJWNqkHwm2Yuyib6FBjrxodc73h2eEk6VJth3oHeeniK
 7Mn64iVC4hI8jSojaZY1SVsrWjd2e+DN6KN2OkyrEjpQxOMec+lN0FkTGRREr872xdG5
 4ANPErk+NVIAlgbc8u1/1pJqtm36PLdp2cb0xG9N92J4Z4DON5MiMu9WvhrGTr2hyxnY
 1x9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtK1z+GsJdh4RKhFKx6CwipChazMFFCO6JG/NBtklX5F8x9rx2Qg1EhxXCMNeocNyqnzcuy4Y=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg96SWI5sSIVdPwaSxXWqN/RF9Xw/JSNoWoa+iOgq+0Fc+ZNbZ
 13OyzNK6uT5uOc44fgjlUjERYBz2KZsYV/9Ty2sld4aoQn+3rLryHNq094WKTCzpiXPDOz/Ajjt
 qr99GOziG1OJhIVBDNYfS335cPDxRlTft9dFP3XTcTH6Jyf7XSB8ZXzyJf1FOniRdmcc=
X-Received: by 2002:a5d:4312:0:b0:374:c407:4e07 with SMTP id
 ffacd0b85a97d-378c2d5a719mr13770615f8f.46.1726743330834; 
 Thu, 19 Sep 2024 03:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4An68jspSg3yrVtDHlP7GMGeK/JqjCsJaVLrPfUPDnkzkDTuLVfocBjejfPMns2ARW22GhA==
X-Received: by 2002:a5d:4312:0:b0:374:c407:4e07 with SMTP id
 ffacd0b85a97d-378c2d5a719mr13770601f8f.46.1726743330395; 
 Thu, 19 Sep 2024 03:55:30 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e71f0622sm14804706f8f.18.2024.09.19.03.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 03:55:29 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] lmb: add missing LMB_NOOVERWRITE description
Date: Thu, 19 Sep 2024 12:55:23 +0200
Message-ID: <20240919105523.179497-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919105523.179497-1-heinrich.schuchardt@canonical.com>
References: <20240919105523.179497-1-heinrich.schuchardt@canonical.com>
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

Without a LMB_NOOVERWRITE description building the HTML documentation leads
to a warning which should be treated as an error.

Fixes: 5e9553cc72b8 ("lmb: allow for resizing lmb regions")
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	change description text: %s/resized/overwritten/
---
 include/lmb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lmb.h b/include/lmb.h
index fc2daaa7bfc..97fc9764c13 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -18,6 +18,7 @@
  * enum lmb_flags - definition of memory region attributes
  * @LMB_NONE: no special request
  * @LMB_NOMAP: don't add to mmu configuration
+ * @LMB_NOOVERWRITE: region cannot be overwritten
  */
 enum lmb_flags {
 	LMB_NONE		= 0,
-- 
2.45.2

