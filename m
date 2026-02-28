Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B6FEE4F2
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 15:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E1783DBF;
	Sat, 28 Feb 2026 16:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cLc6KsKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A62C83DBF; Sat, 28 Feb 2026 09:51:33 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A40801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 09:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF1F63F197
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772268690;
 bh=I33hZ1WhYdVxJGpqwtLUd+6qsGz5VMbDFbJjqtaRMyY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cLc6KsKt/7HuEZm8hLmceqwrJyNH4+TV1pExpAxI/ApZTVUCstulZHgbiL9FiUjKu
 /Twe7D00G+gfCSyTtGHF3ZxJwN+88wIQlmNAsN281kQ/kNBhtdRcC3VL1Wkc794al+
 Zgk/0u0dv+0ao2gNsrUPSCZxULFJE+gJVvlKxMwiqKte6vfVcZyb1D/z07LS19YWZl
 5DecjW/OczYg28eLp02mD0bGaDV8nkeOM+Fy3s44uDPPnzy6wMl1JYDmZeoKZYFb+r
 2LQPT0BnTqclbGGKXlrUJqVJ1U+sbDulwjqUrvlVeUYtDWVIrcTyxYDyhF+PHCMY2F
 lO3ldNGmdyd2NUpOF69+lw+w8Cx4LzBDqLY5fuaGiBSWyLg2aQyrP67FyYVAcnRSB4
 YH2itUENRAdaMT65WYff74FVnou5B/6QIQRQX2K+HmLKLU9wGtWsZWP9jcZ0iHsXfy
 zcXslKxPe8FMEGhMM8DACdnbFG7E5G3EqqoPUkXiq/4Tc4+02Ly3LDRJUTwrTZaxWx
 aAC0t96CaHBupCt/YLVwAJ7Tj78iPKuKZUs0zZOm5QTRwhOcUhNoA7ItBrxzEulsie
 KXTiJpmHgaSJ3Vr14ThHexOcONsltVTi72UiRHDg0/Lj7bx2BzIebAnXx9bC+Zl0C1
 pTnBMZ2DJHEiCg3ZK2IUE/fw=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2adaa9c4b89so42164515ad.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 00:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772268689; x=1772873489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I33hZ1WhYdVxJGpqwtLUd+6qsGz5VMbDFbJjqtaRMyY=;
 b=q2Wt59hpzYfv3Dv6eusqMBr+Nut8ghra9dJF/VKvF1kzlTrxGpRvuxrL+CmVotWb7c
 oWxR8KliTzDyEXpcjqs9O/o0yEVBlXPzsZ56BThVPnP8pZFvCd5ZwnJmmDpckVFW8c2X
 rWEElkVTFL5Sc4dSYv34Z3K+3xLQAm43MqcWn66xkKl1x6HUh4/lr8qOWKezcxgKG3Ly
 uIYthKHfdvHCX2e+4RDkB8rrYhVoxwQkZAhvTlcO46aErMwx89mt7HBymXicqhL4g5jz
 v2A2jxBtIABrqL49N0w4I1wu9MZjpO6r0Uh9i/1GSS/0rjukaB5RYrpBMH4DBGtAkVq8
 wVjg==
X-Gm-Message-State: AOJu0YxKUu+M57S1K665r+WP3k8jIFhab5b9dWjNRgBZCv6ZeSzaJb0P
 UOIgbsDW0xBXHvsP1aeDb7sZYZsInp2N8+qgPnXiuA4tda1FQBVyaO18pof9+WXsp46iwbyM2Y9
 kqHIE0jSAk5AfXfrKfR9OO3K653bl/HRr+Hw+hOHLCUkAoZBPdg9Uhj8y/jDq5vra4wlLGKmIYR
 WGcccQOQ==
X-Gm-Gg: ATEYQzwdHjVoayAWIF9ESUcqAPLwV9goXrihJcCAwrPvzUP63vMFji5skUpNSGy71Fy
 9ahrQUk7AqGBiDimlRkFLDGIY34f7ls9QfIVbZJe8jIVQ67gdRYosOwYQxZMzMoiixwzsInMHTY
 FlNcvTCHsOpPPiiDBO4HZuW7u+kq/olQHs7/kyZT1fX/drLtSPIMLaNUnpwzcX1rrn97CzU5zir
 4iiOfg/Ydfzxm5KZe1oO5YmMr6A1BZoHNNwH9kc8kUd29WF8mAtnRol2Km8wDyfZxZq8OaS0D3W
 cCvb/W4fc1V46nR7Crtq7kBPCvbJLUFzXy0Xi6xQ+MZnBR8JLOvTfNOw7DM0DIp2fG6ACYYLd5z
 1nbCzrjLhuRtnOSzqt5NtD/cl5dAiqwuWO8a9ZhdZSzfdVC8khdnVbI8cVLIM1wIvMYPnxi73
X-Received: by 2002:a17:902:ccd0:b0:2aa:f43d:7c41 with SMTP id
 d9443c01a7336-2ae2b6500cfmr54471895ad.10.1772268688931; 
 Sat, 28 Feb 2026 00:51:28 -0800 (PST)
X-Received: by 2002:a17:902:ccd0:b0:2aa:f43d:7c41 with SMTP id
 d9443c01a7336-2ae2b6500cfmr54471775ad.10.1772268688597; 
 Sat, 28 Feb 2026 00:51:28 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5b53f4sm77114665ad.18.2026.02.28.00.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 00:51:27 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH v1 1/1] rsa: fix incorrect positive EINVAL in
 padding_pss_verify()
Date: Sat, 28 Feb 2026 08:50:26 +0000
Message-ID: <20260228085121.3355465-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Feb 2026 16:59:24 +0100
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

All other error paths in padding_pss_verify() return negative error
codes (-EINVAL, -ENOMEM), which is the same as the rest of the U-Boot
RSA stack. The positive value is inconsistent with U-Boot's convention
and is a potential bug: any caller that tests (ret < 0) to detect
failure would incorrectly treat a malformed PSS signature as a success.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 lib/rsa/rsa-verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 3169c3a6dd1..28d1a915d94 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -274,7 +274,7 @@ int padding_pss_verify(struct image_sign_info *info,
 	if (db_nopad[0] != 0x01) {
 		printf("%s: invalid pss padding ", __func__);
 		printf("(leftmost byte of db after 0-padding isn't 0x01)\n");
-		ret = EINVAL;
+		ret = -EINVAL;
 		goto out;
 	}
 
-- 
2.43.0

