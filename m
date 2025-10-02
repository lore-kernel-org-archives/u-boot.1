Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE24CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 09:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02414828A2;
	Thu,  2 Oct 2025 11:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MSHlxjZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA1C8328F; Thu,  2 Oct 2025 11:40:02 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA5180107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 11:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so451976f8f.2
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759398000; x=1760002800; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C1Dryu4eQ+pcr5kZNYYLJhdWOCT9N4KVhbUK8m6GX3A=;
 b=MSHlxjZBIBCjbtTODzXFc81VPNsPflgLpkgYM8R2TPAlTUQmBeEyGsHnqcTV9N2haz
 OtB3VK5sL6lIT4tKhpivLUSDdCkPCURRdDMTwdWD5opEiHrbtlv+V1iYGRFIqTaKz12B
 K0PYJIQQx7PL+wKtLgmN2zL3iBdL5VLNu1/pFFlf7izeZdqK6BSsqEW6IzkODA0kp8hR
 rciQQU0rSTTHz9c0qymz/AftVHg49NcNMgqu7Ag1JkWw7L7oA1/KzmIVtkN6DU2StUGS
 8fzBl5to4w3xMcVrjCFoFKFR1O8iA6JHwaLA/alPmaDlWuxM21CSXBT04SXIlXVv8eUV
 gxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759398000; x=1760002800;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C1Dryu4eQ+pcr5kZNYYLJhdWOCT9N4KVhbUK8m6GX3A=;
 b=rB23Oi5Oq6/j1MGFlXjvTcjHXRO2pSz3t0mcDmRbMQabAn46baOA6GdyPrvkBms5FY
 y/e8l5p3NmYk2GZPVjAIy5e8/NWi/DV8aUCugnPf+w13bg4EaGYYzd6CFAUsJ+Q4rDBX
 bEfWFEKEKlYcdNJpVE+ubQ0cCfYexCJFYoxGoqNEZn9rqMilbCf+2kmzXWq3TCTrvPIY
 PSkhoed7xwJvvpLrDmnIMZ5cdYluXu27FyHV4sSz8ujUz78L7XUP3n89i2z1xkddmhKI
 z1OfXID2sJi8Qw5MiykPcxoroVhotyGQBk2IPSmHsyKsaJm/oTJg5MNrQ4Og+N2qB25y
 UXlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX21AaZGjBXKSVqjMFPTxpR2lpelRcyq3dTj8wXVNYZ/m9cq8qaWcncmoX5qN9e8BiU9zeeib0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh82tiZJclbuNaU9oW6UifP4fPxlRcyX8YRDqZTH6oYQ3T4u6d
 p6y5Icf9/GwwZJsmQt8MwRHfbZXJ1H14wMEF7QFpBrxcvI5wABZZXr9Ttowu/wnWHvu93p30PJx
 AonWg
X-Gm-Gg: ASbGncu0EWZF43qDbWQGmKX+AF3+HH81g0+sX+U24rPPYfOLl15WjfpI8TTQUJ35b41
 O4x3fFNuZJdIH4SMqvf/uPHspz1q5PDQwA8G99GjcnHUhTEWYpBnZ9ALVhZbbonBF4PWp8WC6KM
 CnFY1kXMqZHGqm/1IQ6n7H/HMTxKhNFgpnoeEY74ZzpO0kQxDGBwrbHrI2ZMpDKGjdysAXLnmyx
 hsGI6d/4/YNtB7MSmVnABJA+6qfiv3JZW6H3BGffe6YwHN5JQly521EalcaMFhLQmvu+Sgn+Jo8
 ypWZ7a4PfalrglD3NFOUQHlGUQGCSA3NWMAaACEfojgG3K3DucF0zhfLzQa6gerzauID7KaHu3S
 w+9mOeTU/hqyxqZLE3l2Zb74pr7e6G2xPo3Yk/nI+/+U+MjBQ8QJFof3+445ZuKfqYOpx4O8/ut
 6DhAQ=
X-Google-Smtp-Source: AGHT+IE2MMHfbYNUvP+8zvG++A370vbY+dkL+9XuB7opBVh15Xzhe7kIIJvW3zcI6zyF67+6LL2AGQ==
X-Received: by 2002:a05:6000:40c9:b0:3f5:453:77e3 with SMTP id
 ffacd0b85a97d-425577ed808mr4038391f8f.6.1759397999770; 
 Thu, 02 Oct 2025 02:39:59 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a21d:c610:1e27:3706])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e960asm2823165f8f.37.2025.10.02.02.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 02:39:59 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 02 Oct 2025 10:39:58 +0100
Subject: [PATCH] fs: semihosting: Use correct variable for error check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
X-B4-Tracking: v=1; b=H4sIAG1I3mgC/x3MTQqAIBBA4avErBNU6PcqEWE66iyycCKC6O5Jy
 2/x3gOMmZBhrB7IeBHTngpUXYGNJgUU5IpBS90oKbXwvDBuFHc+KQXRN64dOr96axyU6Mjo6f6
 H0/y+H5YVWapgAAAA
X-Change-ID: 20251002-fs_semihosting-85d697fbfcad
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

After calling a function that can return an error, the test to detect
that error should use the return value not a different variable. Fix it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/semihostingfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
--- a/fs/semihostingfs.c
+++ b/fs/semihostingfs.c
@@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
 	}
 	if (!maxsize) {
 		size = smh_flen(fd);
-		if (ret < 0) {
+		if (size < 0) {
 			smh_close(fd);
 			return size;
 		}

---
base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
change-id: 20251002-fs_semihosting-85d697fbfcad

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

