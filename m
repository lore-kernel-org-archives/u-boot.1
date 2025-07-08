Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15885C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7708305C;
	Tue,  8 Jul 2025 13:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HWxwfANH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2CD8328D; Tue,  8 Jul 2025 13:16:45 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23C4D83043
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso47404905e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751973402; x=1752578202; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EX1+4n1d2Tzr2wHtwyQs2KlLQb5RSdaQKIPPnQSct0I=;
 b=HWxwfANHRED4EHhIsAiyOp5JGaOU+PP7MO40QThji18tbnwqlC2jmnli+KMxrOZ2vv
 unIXjlsGFmu/OS0Uap6PNXrrVKHnpcPJ0NI24BMTn3f4Zt3o1YF5KB1i0MbpZplt1q3o
 abyttDJY+YIM6+gWtO63mahVHX5RfZamBuq7qOK3MIWyClPhnLtatgKBmo6BiZk8mMgw
 Qvzh0VSuPhXm12bBeAzcPFTilOSvwgspK1jd5rbahSqPbNjy5c2KHCxlsm2RSbCpwtEi
 UslzNIqYIdl+yg6RlroJb/Lj3KS8Np5mcfmN0pp7g/ucEn0k5+omjGKLqUNd18WjxseN
 4FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751973402; x=1752578202;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EX1+4n1d2Tzr2wHtwyQs2KlLQb5RSdaQKIPPnQSct0I=;
 b=ouH1pF+eIfoWcg+iNLsbjE5yoQVs3R/dSSdoJHj5iF2aNnIkDlL64HRYKwiB0K0Ii3
 iaC8dHOyCgtkbPzJUSAKZ3/+TLvYlkW4RR2oYTpW7mfzvpMSOkW0T1QSmvIQO2m+ha1s
 V2Cvv7eRA6cx+trU6M12bF3d3w2r0VZNjSRhPZPyfNDRK5oZGUNDMBvFRbFpRhggCe5L
 oGzVnDStGIRUSK/ewlcsH/IiWDubmrIwqD2mvUJ7LBTnF63M2c8I2NvwswyIhsiGi2wy
 PT0vy7rVviXWtr7s3U0t66DCHPWp0F03vEFwqTdmMyviuKNWSh9Y9Ml1d8m1bw1WMsVY
 XQ8Q==
X-Gm-Message-State: AOJu0Yx8p6yBYJyTi7SLdryA3/WqUkoWB/fDi4Qa8nqCIGsYHFxz4CaN
 hgtTcyMlJtwf5/nDOr5BsxA8S86Mw0tR4P+1hKAa/kUDF1NfH7u4Hh7ZFaJFtyFgDAw=
X-Gm-Gg: ASbGnctgd4vyPnMn5UGLVgdtWSE0EJCLKx71rzslPmP4j8vitznSK41Iw6/yAEzYB5Z
 4qdkFrpuPJzxiX+jrUTkcHqVG88h1ESDCeOuNe+Fl7AWL8MMvDZjGQsqjGT5AC067DnrTvNb11R
 sk/nha/dbBadyQhzd3Rw+j6i7KWMrLocn5+LrbxcBaYrQT54v53XQhB8iSXn1wivA8tlF8iB3fU
 IyEynQhVY4frXQEqNEeHuITQM7+rUpJ+zzQkB/bhAq/mSS8j6HdPIOn7zoDb7IKhuWfXSJq/A3R
 8kaWGAxAT03mOa8QD71DBAFn90ZHjaMbPYCU9YiHwSyLKsuYw15o2cQXV1ESUHxGJwFComXrcDn
 enJR02NUSASH6
X-Google-Smtp-Source: AGHT+IG8nl5xSo9dfZLaNA4AglzEqOg9NMSZsaO2b6+f8caU+40A888wpfwJqOujiJpoPB6uZL8QnA==
X-Received: by 2002:a05:600c:8b2f:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-454b4ec3e6fmr173887385e9.30.1751973402491; 
 Tue, 08 Jul 2025 04:16:42 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d806bsm19168985e9.33.2025.07.08.04.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:16:42 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] fs: exfat: Fix some Smatch issues
Date: Tue, 08 Jul 2025 12:16:40 +0100
Message-Id: <20250707-exfat_fix-v1-0-e5783978cd11@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABj+bGgC/x2N0QqCQBBFf0XmuYXVLLNfiYjZ9W7Og1vMSAjiv
 7f6eLjncFcyqMDoXq2k+InJJxeoTxXFkfMbTobC1Pjm4jvfOSyJ51eSxZ1vIcShra+pBxU/sME
 F5RzHvZjYZug+fBXFP04ez237A5ySaAd0AAAA
To: Tom Rini <trini@konsulko.com>
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

Smatch reported issues with variables being dereferenced before NULL
checks and also testing an unsigned variable for being negative.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      fs: exfat: Perform NULL check before dereference
      fs: exfat: Remove pointless variable uoffset

 fs/exfat/io.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)
---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250707-exfat_fix-38bbcd416f9e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

