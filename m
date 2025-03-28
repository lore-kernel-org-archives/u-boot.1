Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A4EC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D29881DDF;
	Fri, 28 Mar 2025 09:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jKBE2k+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FC581E1F; Fri, 28 Mar 2025 09:15:54 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA88D81DCA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1427773f8f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743149751; x=1743754551;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9OSAmp2HS40XlqPC6pOCuwPtLRl7yp/KYMM0DlusApE=;
 b=jKBE2k+mtv79CK3lUnvf87eafZRf05OMLavmcVzSAIqQp1co7BBBE3zLdTIESOjLpl
 4w0lzEaTr/GtEXc1nXhWN3g5s77b/EsMYaglhU8jNQimxpJIHkJJrXmCibKzTZer9MeZ
 l79+XJbIhZ8B+vJhLitFaPBL7ZoIBnaSlbfgzCyBXy8Vag0UAxrIVOey929pBFGgHU5Y
 vqJCH0fzoEn2ykcyATpJZ8bdovr2K/6FcOKTPUBwt8muETWGJoIaS/zvCF6RjeM79IS4
 4saAqu04jsxYB29Jrcdw86vrSywH2tTgdU4P2bwUwnnrVvkmd/H+1iIWbH0oE7upsDKw
 bIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743149751; x=1743754551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OSAmp2HS40XlqPC6pOCuwPtLRl7yp/KYMM0DlusApE=;
 b=XGKitAgSHk1LvADx3eOCK8BKVoiIcjOQ9bhHElAOzoSoomxdTabZkIn+lbiv1sYeeZ
 4OSPTgo4KH6eGdpJjtxJyVgMj7Mx6c/JlZCnW/LiRovshLnG6q2RRoi3cM0pRZLAGPo3
 d8rStoP2a8DblIwrIM0AMJvw7wM8uLnjzO+IvUR67kbs+EuiRtYP3mxsQyMkKlbJrklU
 ORsrZU6PTqkJ+xbolfJJ6vv6C3mp/45Qv5TKRXyePsQrFMA16qw5bhgK/TAveuTbZ2XY
 diaUt9sV5HA6u8b4qiVoyPYAAlvGh9uZOSG9kZ+9id1UFAiZb5gdwtMsON+u5LA9kEcs
 r66Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFOm5faWwKikIGP0aVLX0Xac9Kk+Sps1m0izVWv55Nyi7xfXc01L9ULfTi3+uFacVfiaHBzUo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3z/q0UMzlEY56amTjPl3BIBWX6PRDZfLi6GafZv6m82HRQgBT
 oIKmKj8UTGLUx5QdkWX2CFcRG3zDOUjHtg+10K5H7HuQJPiTG/g6xP1teCI/DIo=
X-Gm-Gg: ASbGncs48dLAsMuwJECCx6karDe2LUBPIaYzSveEtXQsH56YxIFsMQv6RjamHE0lsYw
 3Iyz44DFG21fPfcLwMf5YofhvirlgGcEjN4GRF05K9w5vUJZ1j+cdrHllXhR6c2q1fmLcWZJ1CH
 /Ugdcqth8rG21En7Zw1L3QxJxDpeCHIR35W5m7Yb6XovUMeZu7fg8qV7zLD5CkhMDLdomDp+6MC
 OnjzQ3dbSiz2jtSLHygCLeZ1UdiHtU51d4HILoOcOe5WrJn7TJ7ot+srEWPzYNRSoz1ncNhLzFM
 HeiekfeeGMwEuUZjVQwyEzmYWZ/bNW5KNmrVlDpaTri4cuA39VwD99naVfQJ7LkjIbeXCnA/iA=
 =
X-Google-Smtp-Source: AGHT+IEAwIKTaeqtE/8ArobG/sryzHyIBrWppkV52oC98q9GLo1swIkUf7YYKVl3awchSYVfRHjWEQ==
X-Received: by 2002:a5d:6c66:0:b0:39a:c832:4f46 with SMTP id
 ffacd0b85a97d-39ad17583e2mr5665774f8f.26.1743149751307; 
 Fri, 28 Mar 2025 01:15:51 -0700 (PDT)
Received: from [192.168.1.116] ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4c29sm20352065e9.5.2025.03.28.01.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:15:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 28 Mar 2025 09:15:43 +0100
Subject: [PATCH 3/4] usb: gadget: f_mass_storage: Fix NULL dereference in
 fsg_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-ums-gadget-leak-v1-3-3b677db99bde@baylibre.com>
References: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
In-Reply-To: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14.3-dev-94c79
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

fsg_common_init() can fail when memory is low. In that case, it returns
PTR_ERR().
fsg_add() does not check for failure, and thus dereferences an invalid
fsg_common later, which crashes.

Verify if we receive an error from fsg_common_init() and handle it
gracefully.

Reported-by: Zixun LI <admin@hifiphile.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/usb/gadget/f_mass_storage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 6f464185bd39..fcce6d12f56b 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2742,6 +2742,8 @@ int fsg_add(struct usb_configuration *c)
 	struct fsg_common *fsg_common;
 
 	fsg_common = fsg_common_init(NULL, c->cdev);
+	if (IS_ERR(fsg_common))
+		return PTR_ERR(fsg_common);
 
 	fsg_common->vendor_name = 0;
 	fsg_common->product_name = 0;

-- 
2.49.0

