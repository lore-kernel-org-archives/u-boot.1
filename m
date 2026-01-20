Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307BAD262A7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 22:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 395A883A2D;
	Tue, 20 Jan 2026 23:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rq51+QwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A79DC83A83; Tue, 20 Jan 2026 23:34:14 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B05F83A83
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 23:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d11e2ee188so2007550a34.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768948450; x=1769553250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FASIz+rOGcI0qsrvUmTItUoRxvukZDfo8gRfBFOaaCg=;
 b=rq51+QwQoNHByWmCSmprGdc1Yh3SgX5SIetpdJi3FKequHXknlfcNScaoyB7OYTLlv
 lwj6pGSb5FzgVD9ih9n4He/ncLL5asSPDqCYw9s+3JtDJsgxjgGpWDcAY8W4QC6N7Fx4
 6nUA5VhAdBkHIUclxwWQMs421nLA+QUoBNdaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768948450; x=1769553250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FASIz+rOGcI0qsrvUmTItUoRxvukZDfo8gRfBFOaaCg=;
 b=gn09UJv4lywB2WV9FK3ylToq65KLKzX9Z2+5BDJ/XQ9Kda9TJU3xb0r7GyH7vesLgn
 LfcHYen7mevfQ3/jw3v4b2w5H0Vt8W2rp/HonVqgM5Z6mr2FDq7jYiJfnPiDObhkWe2O
 dM0mG3mAmN97L2s7u0HK4kQRl2EEs/Unts2bKhFXhtvLbuRe9W/enXqJasreKaMRornx
 KPQNzgwoSYodFqm3SDMKrTXrDHghHur52hqUcLmX9IyZlX7tMzhDYVvntKzJuZ8CrJYJ
 KsUIlIkxPNAVSlrHpKbKWhjX8mS5JSaYvGQb849gFwsrMDRhu0A2ms9pSgmDw42HERS/
 UaAg==
X-Gm-Message-State: AOJu0YxfOrQGXaBCeTYpEXflDyeroEy3kYp9kc2LJveXsnE/auh9A2mb
 aAuj7eq7zMf2xkEwuOXeENtiGCJ3wzSdUpAT6wl1A+GW93hh/5mrTSmgNkPIusLkkWx57M8q4bQ
 Dx9mYtvY=
X-Gm-Gg: AY/fxX5BhU0sK5jegxk9TcXdZuJM04MDQM/0hPCiTu43frScgPsv9PVA6KTTJNaz+v+
 LsCD9MefRgr3/R5K6Beq7TckM/MsWuOwoqXDOdCbuaeIMqhbbxeWyw58VPUunxm8psUqeeKaLvI
 vMyWCONPGG5JQKS6x10YxDlj0r0NAv0OO1za4R0QoWB6QldnQHfelw1t3ejVA1ZhcImX5IateOs
 DPxxneA6sTyH+Um/t6SwgvgQB7Y/WiEoipuuM4jqN45rICwyjj+1MK3Ds+5TUz3iiVXVL8nn1YM
 Wp2CkNuiQqxd5D6glTTVESPxNqceym0F6w5LFXwxUIHGVUyiRpj3JYFNFFGlKtmPvEu/SsKr7SR
 r2qtHZ0ASINdH4uf9qXIzfEP0KAdxH9gWigJouBu5lrKwi6WbU6T8fnBvr4hdImfMTWAxgqyChn
 PzDnckl715meaLuKlTLjP085AQP9fOU0JDrK2GVGxQKz8oIgPG6cI/XK4e1p2oxuDMGd6gkaAy+
 tcgD2ydJ/qyObWckiEHhhBSJuOVKTChuDlr3jze6A==
X-Received: by 2002:a05:6830:2b1f:b0:7cf:d1e7:852 with SMTP id
 46e09a7af769-7cfdff6081fmr8387306a34.6.1768948450343; 
 Tue, 20 Jan 2026 14:34:10 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b59e2sm9705687a34.30.2026.01.20.14.34.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 14:34:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/5] doc: develop: process: Make "Work flow of a Custodian" a
 subsection
Date: Tue, 20 Jan 2026 16:31:43 -0600
Message-ID: <20260120223405.469050-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120223405.469050-1-trini@konsulko.com>
References: <20260120223405.469050-1-trini@konsulko.com>
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

Make the "Work flow of a Custodian" section be a subsection of the
Custodioans section.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/process.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 3bda5e6b51dd..f436a98433a7 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -233,7 +233,7 @@ feedback to the submitter of a patch about what is going on:
     apply cleanly.
 
 Work flow of a Custodian
-------------------------
+^^^^^^^^^^^^^^^^^^^^^^^^
 
 The normal flow of work in the U-Boot development process will look
 like this:
-- 
2.43.0

