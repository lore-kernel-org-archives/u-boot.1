Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB55CE8D78
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 10:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3045B89133;
	Thu, 19 Sep 2024 12:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WBg81gW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69178913A; Thu, 19 Sep 2024 12:55:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD73889127
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 12:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3EA9E3F2B9
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 10:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726743331;
 bh=IDCuXNyRn+8eP8NAzxLAa7L1IRKHyaovhQvNtqIRauo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=WBg81gW24A70MfgBW0LbRYa5TMMOBRYLhqykIekBxyXN/1BW5VyBpCzqJ7hzdzFtS
 46FYHmE9/21LzYCJDnz6n9M6MBhm2cLc1SntbbrzUZRJqU9sdvic6OJmypi7OUyxYM
 DJL5nnTg6/XXAz+hP853W0O+9yDr4nmhELtl3akltFwsEhKMv5ALA4Pi/f1hIHBTC8
 3bdEqAYKsYx2CvNn73Y4usdfbul98ovQWB9OFpR3ximM/DBm3p88MqwRHcR61moARw
 ecVyIigq7R+EYO3FH19/IHJOet2wciLMDAAtpOd/0N2GT2qeKS9sU18gcjYIuAlkWL
 tICV5ER4mq36A==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374c581ce35so287105f8f.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 03:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726743330; x=1727348130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IDCuXNyRn+8eP8NAzxLAa7L1IRKHyaovhQvNtqIRauo=;
 b=fr0Ux79XYGeXnpOOgcO+8uqWkMHZCf3ULk7NH5wB3dJQZSmlbvwP2r7q7b0xq2Tz4N
 vTOotecHfi+y46GFEgkja17U0+wvzsnIFOxUJUSp1yO47uzvnusy6wwWSw2/6cSxgeS6
 tYU5hMv9RPWFjUzF2o/WZQ+LfnPg01XZrolk9/jNbq0cCHGzyo01aDBJhbFYOjM4uAlL
 dzUg1T4CPiCHmECrXteVagEJO1Hp2T1rmScGGEKcUVjD7/QdnW7gbxHH1Aga8Q3nmMwj
 IlyoEfpz8FYtpSYaZ1o2+ZnvXs1nZSMNrt1BmFjFycn9gsf1BqVtUCZwnnw8dHbOPgA7
 ouww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTYGzAKpx4AQn0/v5/EkY4Yssth1zGAAZbv3sDIufXozwJirL+SWopZkzBx4DOomt6NMA8yIg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxhds7+WHJ4AIk/ONPl9fiAgmswLpOMtTzjK4pam8KkFBF6sL5l
 urSTMk6j70tMJ8snfeKUXa80AhT1SU87RtCqy9Mt3nAud0Rc5DIsA1XF3PY7w1ujXbqQCaRU9Rl
 8adqq6MsZJml3RO5g6M2onGQMF+VY2C2RuVlJI/q8BatGItbYDiAzbo+YXJuyU6ZBkJs=
X-Received: by 2002:adf:ff83:0:b0:374:ba7b:42af with SMTP id
 ffacd0b85a97d-378c2d11778mr13735957f8f.26.1726743329808; 
 Thu, 19 Sep 2024 03:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1VKu8jjqjBw1jPDw5bJOorN05f2S9Dct0S29LszQPoKgu711Yv9mXI0qtlNSxJY/Oto8bEQ==
X-Received: by 2002:adf:ff83:0:b0:374:ba7b:42af with SMTP id
 ffacd0b85a97d-378c2d11778mr13735945f8f.26.1726743329409; 
 Thu, 19 Sep 2024 03:55:29 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e71f0622sm14804706f8f.18.2024.09.19.03.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 03:55:28 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] lmb: add missing LMB_NOOVERWRITE description
Date: Thu, 19 Sep 2024 12:55:22 +0200
Message-ID: <20240919105523.179497-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

