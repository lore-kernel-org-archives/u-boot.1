Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18E7E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 02:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB7E8021D;
	Wed, 11 Dec 2024 03:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YalCHL1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDDF8023C; Wed, 11 Dec 2024 03:25:57 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC63280212
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 03:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eb7e725aa0so348858b6e.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733883952; x=1734488752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtanFdORLhTmdzbVZdrqL+jolyIQBa2nxpLfZ7SB234=;
 b=YalCHL1aKYqVcM2Afbj+b4RWBt1770lV4l9v0eGsBPv1UMyWdfMyOfor9SNr3hUE37
 AL37ehsH/Euc4RNa9DEVyEx9jAuke91hfx/dCXzexY3tHfiIdnrPn6E2U4tRR5Qs1Ef7
 CU9QfOn+4b3dT/omtOHC42obdTUE00NKwUdog09fWNnukgkqLcSQDeIT3+58nXGuV5+i
 MJy+nRiCQtQhZspOxmt2KCzph2WPXSz9roUEJX4OSdkzBwVT9XWYKhAIO9VyDQRijHdB
 sARTQWBnUB0vCU8xUb225OyVespfzYY5FvAlYc02Gr3I+j1cGwoL9UYtIqHZY10llTyp
 IDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733883952; x=1734488752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtanFdORLhTmdzbVZdrqL+jolyIQBa2nxpLfZ7SB234=;
 b=dNFuPA215UlC0R6Aemk8SuJNkC9Uk7wDihdx7Gg1MEIr3opFnlxz2Crrzx2aFrcGZM
 7VShlRZ5fj8qfZlFgpSEhvCpa41e+PBLhh1zNggLqUoSKUA5nkFiD9RhjtQ9iKnlle5x
 3J7s0lnNyZVRK3QcTtHI+FyaGMOE9GgBySyZzXxXzjzt78sh8ELmfC5psWcvveKI7IfM
 vghTFlsjM3o8iKH41fU5Ewm/qx3Q2yNSsZK/tDv87AEpJezNj2fdPt38MKWmGSmKoibP
 +5C8CXmD8x+fwXOegwLmwQFpCen2TpPytAIc7bLGqi8ZqNP5TfNc5Xvrvgb4tEdWs3g+
 9jKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV76WRTbtiI8ui+UZbWMur8wE0YPlhX7qV7OjLVO/josgE0VeTT6v9LQyrwRFHUFw0M27OwtZ0=@lists.denx.de
X-Gm-Message-State: AOJu0YwHm0L00qDJzzP9hgHmXAzRrIJAvbINGC6uPB1UmXhcvfdfAbZl
 JQbSpJCMbubzpOv5NXUINjO5FKIxw2eTmCrdwzALCIAJl2YSiK+J+hk6t5J3Glo=
X-Gm-Gg: ASbGncvt36xAyuRG5bsdd14Nhtq6OTc38PZ3P7OQQz8/4uzxUQN5djn+uxY7gjKPSX3
 iZddGvm5waHBHgtkavlFFd+O5vXFmckSjViLThjDYShMlIC9g76i1WQ1XNmQxSJqia0rEib0fsf
 zdAWtV3j4Yi05oC9Aw+WEG5JVRrfS6oJ1hQ93m1gLBSHwLsb9Br0udNqKcvniK2Kmgu2ksqdpNp
 7pw0SYl1sbAvBduK5mNRToLffse4czIdE6J0PdWP5Ep9av0qcL+h9bRQeE=
X-Google-Smtp-Source: AGHT+IFU640hN+d4MPVJoS8mV9G0GYioThGNZ9na6L3JPLKGkgE4OgQVMgwjO3jGWnaIwAKQXTL+qg==
X-Received: by 2002:a05:6808:19a4:b0:3ea:5880:fe1d with SMTP id
 5614622812f47-3eb85dda405mr527832b6e.35.1733883952450; 
 Tue, 10 Dec 2024 18:25:52 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm3130892a34.52.2024.12.10.18.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 18:25:52 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/4] lmb: Fix flags data type in lmb_add_region_flags()
Date: Tue, 10 Dec 2024 20:25:47 -0600
Message-Id: <20241211022550.2995-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211022550.2995-1-semen.protsenko@linaro.org>
References: <20241211022550.2995-1-semen.protsenko@linaro.org>
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

rgnflags variable in lmb_add_region_flags() has incorrect type: it's
declared as phys_size_t when it should be enum lmb_flags. That
copy-paste mistake was firstly introduced in commit 59c0ea5df33f ("lmb:
Add support of flags for no-map properties"), and then copied further
into commit ed17a33fed29 ("lmb: make LMB memory map persistent and
global"). Fix it by using the correct type to match struct lmb_region
field.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes in v2:
  - Added R-b tag from Ilias
  - Added Acked-by tag from Sughosh
  - Removed Fixes tags, as suggested by Sughosh

 lib/lmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index a695edf70dfa..1d57f48bff67 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -202,7 +202,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		phys_addr_t rgnbase = rgn[i].base;
 		phys_size_t rgnsize = rgn[i].size;
-		phys_size_t rgnflags = rgn[i].flags;
+		enum lmb_flags rgnflags = rgn[i].flags;
 
 		ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
 		if (ret > 0) {
-- 
2.39.5

