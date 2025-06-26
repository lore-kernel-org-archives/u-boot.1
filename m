Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622D0C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 08:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB59B82AA4;
	Thu, 26 Jun 2025 10:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZhU1hLHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949C882D83; Thu, 26 Jun 2025 10:58:20 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 393BE8006D
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so7378285e9.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750928284; x=1751533084; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4RdJGdjRLTAOFN5nepA511pZmDj8K3N8+FxbfeIEm3Y=;
 b=ZhU1hLHok1/eRfxsCd9KvT6CCKKqhupPEBUnTtqGluzvM6TpY8Hanho9PYieO9nOn6
 C4XYOKCJNSeK3zCme78F8cBm7OfdctjoXDMEH4GaThh2jSQpZyLN7v7ZKbqfdki6yZEJ
 xoWLxl9HfI2LpWlN76BLXoDlL6jQ+RZmnD/2AFxER0umKrtC/MiEZJMop/iFXISl6DhA
 6BXUrw83K+eoymDO2JxxKPYVxmQGXvEuW5a0QxUUs0DIKYWViTbYHbuymnEsTCI/+eTv
 T+SMsOLP/qfYfaEW+myCf2ZZvQj6VAx7b8Dee16NE/ksbWXB5algwsbXyuCC5Hf8yGbZ
 3ERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750928284; x=1751533084;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4RdJGdjRLTAOFN5nepA511pZmDj8K3N8+FxbfeIEm3Y=;
 b=Caa8iCSCDZJkT0uouZoQNPInG1aHkiNXU6FgxflJ+x7wOTDF4hbpd8lbGAbqXXKGg1
 FdCLUDYxAhoa8avKVMLq+vjPtr9KsEDpcJO01qiazhEe7QFNzM1Mpk/F367FjBbQwqCn
 0Zj9xKOSJItWK/Xc5yH3b3+u3nK5dX4wTZ28B/gPMULlUNWLjCIdfhiXl35YQyJeUHwy
 MiAEHQLLV4pqPKiTyLkZzKwH5LP+xDyoI/G0ciXWIe0w4UYQ7Mgfgtc9CMRLRbPdiBgu
 tLUGMZbX+MDCH/4N5hv2lfRLN3it/kTtNbuhkO1KSM6+kLcHKHj9BaI3uekb6sOMiyLr
 spAg==
X-Gm-Message-State: AOJu0YwrrkcDKr+on2m4nfPZUcN9J0uTTBgf/cH7OiWVaLKS6eDcpoq/
 aX+rb5Y42Lvt1QGAfZaUOvHRKFwidN9chXeAwJAdz8aTNKzazOTKohPMKIqtavfwO3g=
X-Gm-Gg: ASbGncvEaJmO3yaTzI4MxeNAfwLLljyFohk8CWe/T1NyvPwdTFbGUil4kND1ghshYRN
 snClwzWuUAGxxqGQCa7+DN/ZGMyzcGQ3rMBXIfPHJWJR88HPl1S4mbe/wPMdSCfmF33oarwEyCB
 0ohTu0fb89Rqc2sJpBMKyH1n2Tu4yqa0lH7QD0kDwi855Ld48l0ebncSb9Q1R1M8bbaoX4cdOqA
 7NBn7yNJhI+MhoKJn6fxfl0bh2lCTsemCJqQplrgtbhGOxtTvm763tDIfZAKgd7KCrZe/49MP3g
 8WZ0BPaGukf8PJBC0kth9C8tExFKU2AkKt1QsIS+YHhNCQFcnnQfLwB7x3HoqpRfsjz8j6Eb75X
 /hGQVHfQw9U2HeQ==
X-Google-Smtp-Source: AGHT+IFjGU/FBi8XnLCVKsQfWa/jZhWZlgeS8/cfRipXNGowT/NVM7Y5L3k/O+p8UcXQFYifANmXug==
X-Received: by 2002:a05:600c:a315:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-453822d608bmr45680055e9.5.1750928284540; 
 Thu, 26 Jun 2025 01:58:04 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c3a96sm42955735e9.35.2025.06.26.01.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 01:58:03 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 26 Jun 2025 09:58:03 +0100
Subject: [PATCH v3] cmd: abootimg: Prevent use of unintialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-abootimg_fix-v3-1-9f302e96807d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJoLXWgC/32NwQ7CIAxAf8VwFgNM5ubJ/zDGdNBtTRwYWIhm2
 b8Lu3nQ42v7+hYWMRBGdt4tLGCiSN5lqPY7ZkZwA3KymZkSSotaaQ6d9zNNw72nF9eyFsKaptI
 1sKx0EJF3AZwZizRBnDGUxTNgvt8611vmkeLsw3vLJlmmPwpJcskNyvqowbTNqb08yEHwBx8GV
 j4l9c9W2RZWtdoa2UtUX/a6rh8jyuIxAAEAAA==
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Initiaise vhdr to prevent its use when uninitialised.

This issue was found with Smatch.

Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v3:
- Just initialise the variable rather than exit early
- Link to v2: https://lore.kernel.org/r/20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org

Changes in v2:
- Add unmap_sysmem(hdr) in the new exit path
- Link to v1: https://lore.kernel.org/r/20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org
---
 cmd/abootimg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index ae7a1a7c83b..9ae87581d2c 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -95,7 +95,7 @@ static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
 		return CMD_RET_USAGE;
 	struct andr_image_data img_data = {0};
 	const struct andr_boot_img_hdr_v0 *hdr;
-	const struct andr_vnd_boot_img_hdr *vhdr;
+	const struct andr_vnd_boot_img_hdr *vhdr = NULL;
 
 	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
 	if (get_avendor_bootimg_addr() != -1)

---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250625-abootimg_fix-51600dc8356a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

