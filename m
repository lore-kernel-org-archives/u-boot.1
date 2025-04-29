Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B7EC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507438215E;
	Tue, 29 Apr 2025 15:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZyE+lNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E53EE8215F; Tue, 29 Apr 2025 15:15:26 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F6982145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d81ca1d436so53579435ab.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745932523; x=1746537323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ACyM7opzsaKcvW4RpDaCauuqhlApDhc4ThV1povD/zI=;
 b=gZyE+lNi7dnDp7iEtC4rA0kEuyGFK5mnI4DKoWdKlwQdsIHS2amPlufbyXZIitNKWS
 5pQzHGZz/bLNIYxYoWk5uS8S2plyny5U/9Poahgu/Ot4+vCH5QdUvXpRF6B8aWAuUPwE
 7zGwM+ZDkzPrmMXG0u2+rgC1u55BL5axdtmZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932523; x=1746537323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ACyM7opzsaKcvW4RpDaCauuqhlApDhc4ThV1povD/zI=;
 b=pzGBM+b/zd3HwdlRWNOSOAcKTnd0hNnWXAvnv+cEiUo9F63AkN2askzrdZwobH3Qvj
 +xArhUB8HhYgnGGk9HCtC2rA3UnTaU6qJwfYRUvZJdbp3RNVgpUnIeCyFFCJU+eDH/fJ
 xw55AXKLoKezhwcxFkcVy9dh9rzJ8oqPVrNOk4oly1M3w9aYT7VVS6DkKEmA3Qgoriey
 GXb67q0xvMIlEajqmpx9dlwn/lOGTZLJBviSXEvSVYZ1u1ZCZ9h9swFerahubKKcOeLe
 BjBIMZ/JqkHPZycf1B5BznSf4Vmb6QIJammcM9z1nF2lOm24DMGIlPE3xOao0bebJRTf
 Wq9g==
X-Gm-Message-State: AOJu0Yz0Xecl0rr2t7DWfMjhvVCInSFcxdIO1vvt7wRMsgh4JYu8ub55
 dP+3FQ3tQusRhIei4rGIhrqhbszHQaEL1XyZ4M7e2YE/E83JrC9KE1NSsNgNVruLOpI+bLRogrs
 =
X-Gm-Gg: ASbGncthOq9V18N4hWRz1D3CuvHJhLJ9vhLqi0+eoiZBxpcNSdYXrdCDPsTjaoDHQnZ
 RgdTxR2J6Ol1+yVCmz8FiXSMP844ZLabJ9yeZcULyMfwAw2ndcsIQ+bHp4EtqDdD0qeiG51qqYL
 +0sACe6jRFiKGMgyJ2AFj4hH3SstSDz5NGuK86gWnGk6zxFu8naHytvcg8Wdic45Iw7+uE8vg8T
 D29iRpSYv3Lz56xRAHDFmBPxsVOs89FndZYuCBWmE+vbATOA+mYSMrH+wCr3lQhmYA51mfUrRbq
 6HKOL1zs1KM5x0q1caa06mmZDO5fNZZaCEpwzEjesnoGyksEKH2eHXJAPHyUWasoVA5tdbG6ezS
 Erw==
X-Google-Smtp-Source: AGHT+IEHNLsNbRHqFExDIUyyovv53t+Fi1jfBJBBzJOeCNQfYLVYOh5+HvBa02cmm1ItulnAvaiP5g==
X-Received: by 2002:a05:6e02:3d87:b0:3d9:65f3:974f with SMTP id
 e9e14a558f8ab-3d965f398camr4315145ab.16.1745932522741; 
 Tue, 29 Apr 2025 06:15:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f86311cccbsm271816173.84.2025.04.29.06.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:15:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] tools/make_pip.sh: Use debian packages instead of pip
Date: Tue, 29 Apr 2025 07:15:05 -0600
Message-ID: <20250429131515.244061-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Recent distros complain about using 'pip install'. Adjust the script to
use 'apt get' instead where possible/required (e.g. with Ubuntu 24.04).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/make_pip.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
index d2639ffd6e4..90756279770 100755
--- a/scripts/make_pip.sh
+++ b/scripts/make_pip.sh
@@ -107,8 +107,10 @@ mkdir ${dir}/tests
 cd ${dir}
 
 # Make sure the tools are up to date
-python3 -m pip install --upgrade build
-python3 -m pip install --upgrade twine
+if ! sudo apt install python3-build twine; then
+	python3 -m pip install --upgrade build
+	python3 -m pip install --upgrade twine
+fi
 
 # Build the PyPi package
 python3 -m build
-- 
2.43.0

base-commit: 0312b271dd6dff8ca6d60c53ab028af526c45dde
branch: patb
