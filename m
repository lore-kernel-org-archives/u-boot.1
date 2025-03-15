Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E619EC28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE89B81BC5;
	Sat, 15 Mar 2025 15:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SJdUrgIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D54981C67; Sat, 15 Mar 2025 15:27:39 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C9C81428
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so6173855e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048856; x=1742653656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OHbEsnHwRxX59csm80YE2M40ZbkK24iC/vPmoTrBDE=;
 b=SJdUrgIe44QppegBW/Nde0UB6cgG4SfBRV/sujBNm6kOLAhx5b3ss5sY83pMOxUGO/
 J32mo+VjZPZwSIO67AZ1uqG0XLn1HSVzaqweDSCkLlSmVfHNT6iSv7e/puIN1ChnAYz5
 pZy3jES2DznSupzrED8xEnDqkkLVYH8NahKlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048856; x=1742653656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OHbEsnHwRxX59csm80YE2M40ZbkK24iC/vPmoTrBDE=;
 b=iVda9zz3+jyF8t8+Qb0WELhBhYI4LhpfZtH8Ox5mmeGaClySI7rii6hVuxHwCLUcpg
 4YOtOwO8ewyla8b2ZppAhjW5CAmtFRlnix1CtFgFas33q3tVWCRdMMTskqxxjVFmYiur
 f2rtJEO4B4yngzUvIq687TySUXIU3CQer0igtBXdncJoOquzT54OGNj0IFdq5g2NsYHu
 El+/QNLE4ZVLBnZFMDKLz3XuJyAILpnEwfznQJJ9Xrh46XrcvKV0DkFUxoVfjmaF9fw/
 yyOQjsdzVABROicFCHciP0VzDLfNGBE2ZDi+QbvJA9pieeW0U2+EoW4nVPDnJSFQny4+
 2Yyg==
X-Gm-Message-State: AOJu0YycWrFirdSGT88IiJbPZYh3Eszr2g0iFJl0035+yqG95Iebj9vv
 un5FZxK3np2EiLvWhxkZHoBqF5K3VC3HIwfU3gyfscCt1toX+9y8UUwSSpUOsj7WP99cUvSKmlx
 SSw==
X-Gm-Gg: ASbGncuxujz3kDBMOZ0bv7EwF6BLfF+LJBZYGvU4xo+r83b0ENatX2SvB0Nj4vCb2UR
 Ghm07jsogK3mZcJxM5rYvqqkLSY2qvqUxzw6w9BedZSavwBBH4AQnTndjjWQCtQYjroTMau//iU
 EEj5KNj0JweX6e5lFg1pnyg5anQlUIUKpH7cNlldDnD+JdZcFr/VKzyG/QW6iHi7y1J0de1rEKT
 XiK0URnh8HVqzGOtBm4iudTRJQOoVn4fPSRwvrZYQJwlCcLyTnvAzIjyJWZ9o5sT2RkNhP1wujO
 2z7KQpDF3u9iDliN6CJJJRM5MM8dsT4Ho7RPBrx7Hw==
X-Google-Smtp-Source: AGHT+IFD1/WWvF1WgNDz93lmPnvp2yR5YGcyIG9EXju41uozqgU9nU1ajrXxuos5rLptihAM14BkIg==
X-Received: by 2002:a5d:64a2:0:b0:391:4231:416 with SMTP id
 ffacd0b85a97d-3971e9720e5mr8892742f8f.36.1742048856171; 
 Sat, 15 Mar 2025 07:27:36 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 13/46] x86: spl: Drop duplicate CPU init
Date: Sat, 15 Mar 2025 14:25:33 +0000
Message-ID: <20250315142643.2600605-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

x86_cpu_init_f() is called by arch_cpu_init() a few lines below this
code. Drop the duplicate call.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 7a033505101..47cf9c862b5 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -84,8 +84,6 @@ static int x86_spl_init(void)
 	log_debug("x86 spl starting\n");
 	if (IS_ENABLED(TPL))
 		ret = x86_cpu_reinit_f();
-	else
-		ret = x86_cpu_init_f();
 	ret = spl_init();
 	if (ret) {
 		log_debug("spl_init() failed (err=%d)\n", ret);
-- 
2.43.0

