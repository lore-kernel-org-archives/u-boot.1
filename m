Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23BAC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 07:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2361782AF6;
	Fri,  6 Jun 2025 09:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROY7YIPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E4D182AAA; Fri,  6 Jun 2025 09:22:10 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D6E82977
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so23079865e9.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749194527; x=1749799327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yVS8yHxCR/y1oQsixgszKCnhQKKtSrZIVRFD4mkoDvI=;
 b=ROY7YIPbwJjo/4/Biyiq1BAew3jpYUL628aVSANlq/cKAjuZSeJBjdB7wMWAB/EEKC
 cvRri8AgS4lMRBPO4BVwemTiw6oDYqlTsrzAqprE4rwJzvhlyunseAaKKLib5fwISQZp
 cJAj6SsQzG9wNSUZXFUF6LAJAbjY+wsWLpCFyJ95szhiMneTExeONgk4HbVBuLwHyETl
 n3OcTQM0mWg9jWwijiafrr+JoZNnckvn8FFOy5WDKlPAINH18IPrKyW1HvtPqG67V+0b
 1wff1y7YmpCbylRvz/3UBuou+FMOkMPFoY3xnzy29Vl+O5Qb1t6FTxPYCJ9S3XXPNdIU
 UtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194527; x=1749799327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVS8yHxCR/y1oQsixgszKCnhQKKtSrZIVRFD4mkoDvI=;
 b=QX+AQDtnPf87EVywPmQmRkOjpMJ3Geb84f5U9q0B5G4GfWWiYRm4uXJELm/y9hCyJe
 JRavvaLgqX9Ej7/rq7awHYA3EIexhzX94qvFMkjqqUzcb/a4cjZz2h/MibYy9l3BVnJ5
 eOIIzVYS66XrBssxXDvCiUCanAYOAZfCY0oHbNxagYsNAuT3wF8Jdqi79Be4tcAhRdXi
 mWxVmhNg9iML8QA2JVU1NGV73tOqqUxDTiEvB9HMJEjwU63b13FOClsHE9Wa2XB0L85d
 HCZlz2wyyebMQpwuzqwzMXP3xkkRj81ATl3C+LcR8QI5U3LvFx5Aw8HmVmOz8WVXzu5x
 S31Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAFis3xca8e0eL6p1TXHcQ52X5lkPU24qG5iW9aKbOJxRo9/CtM2U/ni0479dTVtg23EFE8bo=@lists.denx.de
X-Gm-Message-State: AOJu0YwyA1ldYzMlD6lopxM6wrgmhyhSRQ6RjG3MyC4JIqk3N6R+4HZ4
 pyy9OBkDB/j0HSwlNKQVQ8IMWa2IYeFVpAJT83qbqrA6C8u0rpEb7xaQ
X-Gm-Gg: ASbGnctoCqwlt9OcUcjoHEeyJ4TfLgUgBboLGx3TM29VAY7ZU0grtKMhvJo3J/5BJ9W
 8GMxvzBTtlyfsEqefdvzDbzuzqnsgqlejFD/861gaCdTFu0aePClqi0OVqjIlTf+ivxG2FKA5cz
 Z0NJCCEXcd6HffxS5vnfFMhsD7QuzB/B//i2QZEm54NZs4I0AHeVCMBxoKuWRCj/8frDv3ng+n2
 j2FeEetHKT+MQ7lWNGWdmkFKe2m4RjQiqkonOMnLQ41FNM/V6Yudf+pEu49ACQBA8lmWjnfHzBg
 KIEysXia4BSMjgr1cP64nYgmVpub/7N8Xu/ZlohEtTPYj0gmsuQ+iYQ0KBEGLc0EiFHi5j5CvGl
 9QY//+oSRoanmhQrVylUu
X-Google-Smtp-Source: AGHT+IHCHkg0DeTZWPt0WuMzOp+Po04jv1ObWG5QGOvrwflS9WVR6bVkb0knkbijOl16mLea5n6ubg==
X-Received: by 2002:a05:600c:35cf:b0:442:ffb1:b58 with SMTP id
 5b1f17b1804b1-452014586c3mr26068925e9.12.1749194527383; 
 Fri, 06 Jun 2025 00:22:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4521375b5e1sm14666295e9.37.2025.06.06.00.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 00:22:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 2/5] clk: imx: add missing linux/bug.h header for WARN
Date: Fri,  6 Jun 2025 09:21:31 +0200
Message-ID: <20250606072140.18824-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606072140.18824-1-ansuelsmth@gmail.com>
References: <20250606072140.18824-1-ansuelsmth@gmail.com>
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

The WARN macro requires inclusion of linux/bug.h header. It did
previously work as bitfield.h included it indirectly but now this has
changed.

Explicitly include the header to fix compilation error.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 81e19d393cf..b3926564a22 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -10,6 +10,7 @@
 #include <dm/devres.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-- 
2.48.1

