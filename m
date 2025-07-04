Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCB3C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 10:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947E7806D8;
	Fri,  4 Jul 2025 12:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TK+RGZaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42388091A; Fri,  4 Jul 2025 12:53:21 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2950801BE
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 12:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso8721975e9.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751626399; x=1752231199; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TYUfGgVQKxjeNoqTBMQyIM1QXOFI8iFSnNKeX8Ix47s=;
 b=TK+RGZaMMDT47qP0RxYdhaozgT6bbtO9P1oHUta9/q0JXwSJZ4fApCJWI/WfP+LB4O
 Bp3JhU8SLx4eYLOFfencdwa/ssoMhqmBcYybIVOTNUaCTbb3jW4JBeunU8lZjLlsbZmH
 I7uI0diJDjzfcluftIAuD4/+cC5cz5kV6w7B3mR+FXWOBDMYqE91QJh/D+o2S9zo4FLn
 wBMjiLSF7h8wQMHhdocwPuc+qHgOzvvCEehtySCW9+AUo5ca78/rvq7xZ16aUef9gjgF
 CjMvWeWZZxb00h6DRp70/cH6nRuMecUXaMAibVSRYq2T31wlRqifTQkylQhWURpddtjA
 ktKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751626399; x=1752231199;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYUfGgVQKxjeNoqTBMQyIM1QXOFI8iFSnNKeX8Ix47s=;
 b=Y9qvlKkkmnVOEPJshW3vvtL64/eXnSTssF78C3WpGQMnILQBhw/IQ6EX14KoGL0uHS
 60oxMhPrX6w/wazVrnWnFc6vdZszvLmB+Al0+DPvzlLYMX08UYfQy0TOf4preuJSSxMd
 Q1rnknfFUKltb46PeCF5hBbZXgZxaxfKs8TFGwtBNZqVOelwlj3YLiLL7uVjvgDIm9iY
 BdkIL3bsfgtsOMR3r729TTJjlKnv9lPh0LwXt1rhJMO9/sivSnm/XsKY9fYpXiDGXGQI
 osWwzXan18Aa7VZKyiN77rr7FXkUpgjoRYyzALJzbbhv2hUSjMthTqj3boo1UCHrS5/6
 u5qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpptcQX3Bb7Gwx+EkftXqT/M2KBxCG6/wCBfORTA14Vt2XZVfJ0F8Star1oYF3HiTwO5Z23Qs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0p71kGDcy5QvBsM3hsACx6WR0MPCRwF7ApYoolSSk0SQ6r+oH
 xHKEBGpsYcfUfxfT3SuNUU822dG1+V6eom8/6bmcGW4ntFaGTmhfU1+zeV3dMvt6dq4=
X-Gm-Gg: ASbGncuKdecNGaRVzrtu9tP7WgzP/pF0PEv9uroWF6IYzzzzshNES/cIEhh7JDDrOw4
 7tsmtU5dYm9CIIEjB4i2VLfiXtoX/BvX9zVPyJtHWhYvnQ7urKWK4lKz7jMM/E1bmKKDWWXKCRg
 E8mlTh3Cf4RZl3+ruqz8VLDBsMXCH/ARKKFex96Jq2UsU5YUQKbl2Lp7X6eKkLHUmPjS4aU9bWn
 4yaa1QEWFVm8Pmks6zDkUfPQG6IWwHmn8LfPkPR/9MRwPM+qfICeHsNg7YF+6LuY4Ww+dC0DlVI
 UgmNQO/WsJvMZAaI7AU/EX0ePKMeIo3onlvMNLK8essISO0ugR1xDoPi3J0CFzj8/9/3APVitQC
 LdYUQue7R+B++lw==
X-Google-Smtp-Source: AGHT+IHumStWARKzwTLDqj3gsQQkKaFeOVDjsrI8sZ0pzfL6/B1IPNJbdgB3aKVC5ZDfDADStvqK9g==
X-Received: by 2002:a05:600c:5292:b0:453:6146:1172 with SMTP id
 5b1f17b1804b1-454b4e6e64dmr18293705e9.3.1751626399055; 
 Fri, 04 Jul 2025 03:53:19 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2854:bc73:8076:c06f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e367sm51506035e9.15.2025.07.04.03.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 03:53:18 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 04 Jul 2025 11:53:18 +0100
Subject: [PATCH] fs: erofs: Do NULL check before dereferencing pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJ2yZ2gC/x2N0QpAQBBFf0XzbGsJi1+RtNYs82BpRlLy75bH0
 z2ne4MgEwq0yQ2MJwltIUKWJuAWG2ZUNEWGXOelNrpQyJuXwdOljHFTrRvTOF9B9EcrqEa2wS1
 fsVo5kL9hZ4z+f9L1z/MC91MXfnQAAAA=
To: Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

The assignments to sect and off use the pointer from ctxt.cur_dev but
that has not been NULL checked before this is done. So instead move the
assignments after the NULL check.

This issue found by Smatch

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/erofs/fs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
index dcdc883e34c..db86928511e 100644
--- a/fs/erofs/fs.c
+++ b/fs/erofs/fs.c
@@ -11,12 +11,15 @@ static struct erofs_ctxt {
 
 int erofs_dev_read(int device_id, void *buf, u64 offset, size_t len)
 {
-	lbaint_t sect = offset >> ctxt.cur_dev->log2blksz;
-	int off = offset & (ctxt.cur_dev->blksz - 1);
+	lbaint_t sect;
+	int off;
 
 	if (!ctxt.cur_dev)
 		return -EIO;
 
+	sect = offset >> ctxt.cur_dev->log2blksz;
+	off = offset & (ctxt.cur_dev->blksz - 1);
+
 	if (fs_devread(ctxt.cur_dev, &ctxt.cur_part_info, sect,
 		       off, len, buf))
 		return 0;

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250704-erofs_fix-77cd80979cf6

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

