Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720EEC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB0F8206E;
	Thu,  3 Jul 2025 13:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yn95wAJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A5C82103; Thu,  3 Jul 2025 13:31:54 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCC482063
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso4681647f8f.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 04:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751542312; x=1752147112; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3F3Gg9xNFkqV/t/I22Y1vUeMPYn2NhNlMvqiprwzQUs=;
 b=Yn95wAJTmxxglLOFfv59pXV5HdyRQyXHRLNBlCHh4HSFjTlLTj21K9b2rxGfCdZBEv
 hX1IrtxvkxheE4Y/mlKdxQT+N2GXncLke9mU/AHDBSeaiwJ56f6NOJIynRmVD6S88WZ9
 WV5pCPOtH+LpriBVqXC+2YlrWeCBl1JUny5WZpelZMKAJghVWvYfcMgJqXS5qbdiVBk9
 SBIVm/uZb2TL4AZB+2PhZArKwDFyMy1y2GiRK0YxECgfNw97i3ZWbnZyLosRmEBI5+7d
 x5MFzngOtPEP6mz1zO4eajlZ3ypQguA/Cb2L4Z+mKuayyY6Maoxk8HNK1mjpcTOusW/l
 Owuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751542312; x=1752147112;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3F3Gg9xNFkqV/t/I22Y1vUeMPYn2NhNlMvqiprwzQUs=;
 b=IvA3ONiLW2IPJ6NveTmI0B+ywc+HljG+i/ZXbog4A4mCT1EwFi588X0ucPjKJ/Hszd
 1mh4oU7LXbKKaw0JpyAyvNRdoVHfO1p+rbw5C8RyZd1oQodBKACCVXabEssog+PhnRtt
 FjNOaZ4/gMGYJGj0AXuSwaSRBhfdhqgF+O9uTufbGo20okklw2giSBXEOV/ILkPgXe9T
 IedhNwzHOTP7Xf60XO1rh4iA4knhel0pce3lm00innUgndH0OQjvM0ptUNd7hhV/L6dU
 A117OrO0p0AJ85OpPLAsrL8Y8N/1IoqI4gYAREaa/4aZ+/+MrUDih3M3s9Jn9HKtlTyX
 FU7w==
X-Gm-Message-State: AOJu0Yxtf0YRfnApbs+srqxVZAJyTUccVTn8t8BwwgN7Ijwnnatp/pmH
 mN7b6xghVEN8PpvxM80Vfd1FVqIjgGhOuG3z8vLOVvUpKPVpFjUNFOwoDYTYGJ50+HU=
X-Gm-Gg: ASbGncsxck83mznHRX3iViogvCEPvkZlhA/XsYbTZNf+ZFMEE9Zpy8JZgJvp4FBgcVO
 bpgLis6Se7DBBtTGQH0/d/99kaZNh004IyOOqn1SO2pmnK9VX5c2sDYbL/750gtTKDDqNxy41q2
 JSPnNCqRkT5vAJ+YAvoHGFGP0sARnmTP6c1T66JbOWW4M/Ep2vhidiYQ1CyE2FFejMg5/yec/eL
 McvbKQXd5AJuOluS4uvL+Mrp4M/ETerhOgp4UG8jwrQZV9BnxrgTi48hQx72W0GCvGtTkt5XXdb
 HC47cWGy7qj+0pxVeTtpc0Z+iEBb61ium7CP2DSq0hWN/MIxLc7xDWyRr7tcoA93BrjiPAJI0PJ
 Hajk+AqFyhqUX
X-Google-Smtp-Source: AGHT+IEcCEbEd6sXUiGf7PedI32Y0c4v9d9yDr2cmfLCDQRpkQsda/Lkc1IDhAyauwe526Ia4eKr+w==
X-Received: by 2002:a05:6000:38a:b0:3a4:f2ed:217e with SMTP id
 ffacd0b85a97d-3b200f20826mr4600024f8f.42.1751542311509; 
 Thu, 03 Jul 2025 04:31:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:b5c8:44f:55cc:3182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f34csm18045682f8f.85.2025.07.03.04.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 04:31:51 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 03 Jul 2025 12:31:50 +0100
Subject: [PATCH] power: pfuze100: Ensure loop index is incremented
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
X-B4-Tracking: v=1; b=H4sIACVqZmgC/x2NQQqDQAxFryJZdyCjlpZeRYrEMVOz6CiJilS8e
 0eXj/cffwdjFTZ4FTsor2Iypgz+VkAYKH3YSZ8ZSizv+MDKTXH5sUdso2yuJiQfKnzWIUJOOjJ
 2nVIKwxl9yWbWU0zKeX/9NO/j+APJHXvCdwAAAA==
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

The for loop in se_desc uses i as the loop index and also to cause the
loop to end if the passed in name is not found. However i is not
incremented which could cause the loop to continue indefinitely and
access out of bounds memory.
Add an increment of i to ensure that the loop terminates correctly in
the case where name is not found.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/regulator/pfuze100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index bf3a7019411..eff166b368b 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -247,7 +247,7 @@ static struct pfuze100_regulator_desc *se_desc(struct pfuze100_regulator_desc *d
 {
 	int i;
 
-	for (i = 0; i < size; desc++) {
+	for (i = 0; i < size; i++, desc++) {
 		if (!strcmp(desc->name, name))
 			return desc;
 		continue;

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250703-pfuze100_fix-4a0a1c3084cf

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

