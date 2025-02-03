Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA519C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E644D800B3;
	Mon,  3 Feb 2025 17:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WexmR9KR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D823F800CF; Mon,  3 Feb 2025 17:26:18 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2BC80079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso326031939f.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738599975; x=1739204775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PJevPlsvmEbKFTXONA3T6NhJUhgNClPw3yfXNpMDg5M=;
 b=WexmR9KRih/xcf6ZthVKzbGjRtVkXWcgZn+XoO0/M1sXw9UGXE8+9mZ/KovdxDuOHn
 D6IcIk4ip2Qrt2Capy4BV13tqnveXdeTJ5qLbs1/iokyAhVTcQYwzpXkDb87SygX9eka
 7JSRVSmhbHxzsiVdZxeENvsgj6CoYOdDuRZCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738599975; x=1739204775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PJevPlsvmEbKFTXONA3T6NhJUhgNClPw3yfXNpMDg5M=;
 b=RO4Nn4X+nUorFLB8E9Lml4ICBcuj7ZRtfqdDGxOGIQwyZwQ15ZsT/Fp2q0ySQUXayK
 gSLFWt7eQw0+HEyS9LHm4tviWrK4ve1aBlkMDLCY08NOaokL5CumZJkBnIgBLR8i+zgR
 zX82+J6C1QZYHD0kISpWegoqsW+lwDfe8z+3NXu/ygj5Y1/3nnib4NXxjtZpMPeRDfDG
 2fFAnpAUxIb3o6pry0zGdwDYX6Is8QOjQPf+t94grdKOpToYEW/x4I0hTNoeLA+NYzKP
 /DF5zG7KRmxyLCywz5a+xes33TRZ0btCmp0Jr5wmqt2ebAZp7KyGuMXYy8V+YgjWn17D
 mFwQ==
X-Gm-Message-State: AOJu0Yy1OplSF8oihYqxVhtj1YnuWuhhkpnrSk6ZrY2YLYebY83/mtKd
 brdX0ZNUfwfHBFi+V8Rvj+qMrzbtaUTR2sUOM2WYvbKIt/MEN88htCg4MxnLOOD2a5sodMF5OLY
 =
X-Gm-Gg: ASbGncuYGgkxSYCrgJhBcpgeOin1ilRvBoc7Xmep9NoeKiRSWwWu+IPN/H/qBCd9GfH
 u2Zj3nSXOMNiIoCE3uTVZ0Tq+Djk1q5TgTaLUld5JNIOpGRZ7R+ciUPmoqAl0bP2GwqaT2N1e5X
 O5EQjjxtH5orDWa+AM8eI7LR0bQGteyRiXgV3pasb40E3VASwtotAgcrYWvc8ib3G/JEBnBJXWX
 E4Noe5FxRJuasydN3GQDWzvsBqRF13QxFfrYOHb8up6SDZYf1AOKM9gHV9+YflzkwiVvxqLdtE3
 td8gqLHUQplzrgzTMhDepKIPhuoDseUgupaa8yv/SCtcZTyEmsSB
X-Google-Smtp-Source: AGHT+IEgpeSuhFeD69qhjChaP/UPJFOh6g5MsmCDbGZop8zI3AjrfhbSN1IhDRJnXKR85/hmfH/YPQ==
X-Received: by 2002:a05:6602:134c:b0:83a:f447:f0b9 with SMTP id
 ca18e2360f4ac-85439f8c936mr2146464039f.9.1738599974765; 
 Mon, 03 Feb 2025 08:26:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854a15f8394sm258652539f.11.2025.02.03.08.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:26:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] CI: Use different containers for concurrent runner
Date: Mon,  3 Feb 2025 09:25:54 -0700
Message-ID: <20250203162608.626479-1-sjg@chromium.org>
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

When running multiple runners on the same machine, each should be in its
own container to avoid them interfering with either other.

Add a container name for this. Ensure it is removed after use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1d4d3a85741..3487ad7e579 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -14,6 +14,10 @@ default:
 # in the u-boot tree at tools/docker/Dockerfile
 image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
 
+services:
+  - name: container:${CI_JOB_ID}`
+    command: ["--rm"]
+
 # We run some tests in different order, to catch some failures quicker.
 stages:
   - testsuites
-- 
2.43.0

