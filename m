Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A83E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBB988FD6;
	Sat,  2 Nov 2024 20:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U8Zqfq6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BE388B0B; Sat,  2 Nov 2024 20:36:24 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 887EB8901D
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b15467f383so222916085a.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576181; x=1731180981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8YMsP+9cGgf3k/P0Y42Eo/RiI9pBEX+/XPa59EuRgrg=;
 b=U8Zqfq6ajH6IpVdnf97BGwwihFyQFWcvBBmQOcuRp/qfo7xu6PNZKYgQeZ7J5bxmOC
 JBVCNLNed7nzD5RB2KAD4Ze4D+THzLTFl41TtxNmxGvxkHe1y2Kcxlk5C4PbZAbGiPY7
 UrC3ne4Fh2FhhXUptmFi5QogwwXHYhMagdpKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576181; x=1731180981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8YMsP+9cGgf3k/P0Y42Eo/RiI9pBEX+/XPa59EuRgrg=;
 b=g2i7pCIy5yBrfIGexdToZ1ElDaeZ17HwRcubhjgthrktZ0Htai1r6PnvLtGIN1acGk
 YrKddJs4c0NE2Sk2LX2gcCO+3LbNhJLNmZLHJvxa4l1SvgPOQP+GbOyCkKxMRqHdeG1P
 9y6QUmo0nmGr9rwW88GW3ZmvU/P6NwlgZrGYVwPiOl1zaanbwG9yW/BLZouwTlF/grJn
 ugHZ+lcN23VIGKtyGuO70kfyCMqEJmva8dFuPaHkaoYXf1PiSXlqFDWhEo5DnbQQrtac
 Xj1Q2PRB4mzK0uvZ7KeJ5MeahfjRrj/YEWw2L6rM0txOy+LlW+xLJ6wBpUnjx0sMcT2i
 Wrqw==
X-Gm-Message-State: AOJu0YwP1DJxsGdCivCopsgWhnSCz/dMvfT1kosv96NA0Kbxpw3dIAOE
 q8CLh+alY6FWhVgPR/b+XNOiKhcN10LAIRYLwXt847ItLuGD+aZnZE0TOKEQoB9Au3KRBug7VMN
 xN1bo
X-Google-Smtp-Source: AGHT+IE+2hQEyd1OQJkX+6SDQFtApm/4RcfPmkeyhcda+kLfgHI7Uk+PJQVYVuylQWgqZo1WNa8S7Q==
X-Received: by 2002:a05:620a:371a:b0:7b1:506f:7796 with SMTP id
 af79cd13be357-7b2f2534c77mr1629798385a.47.1730576180856; 
 Sat, 02 Nov 2024 12:36:20 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad1b54e3sm30665761cf.90.2024.11.02.12.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:36:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3] sandbox: Add a build without CMDLINE
Date: Sat,  2 Nov 2024 13:36:11 -0600
Message-ID: <20241102193615.431681-1-sjg@chromium.org>
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

Sometimes this breaks, so add a build to keep it working. Since sandbox
enables a lot of options, it is a good board to use. The new config is
created simply by copying the existing sandbox and turning off CMDLINE

Once we have tests for non-CMDLINE operation, this can be adjusted to
run those tests.

Create a new build which will be picked up by CI. Update the maintainer
entry as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use #include in the defconfig
- Fix 'Something' typo

Changes in v2:
- Create a new build instead of messing with CI

 MAINTAINERS                         | 1 +
 configs/sandbox_nocmdline_defconfig | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 configs/sandbox_nocmdline_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index df046192ea0..c7044220452 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1544,6 +1544,7 @@ SANDBOX
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	arch/sandbox/
+F:	configs/sandbox*
 F:	doc/arch/sandbox.rst
 F:	drivers/*/*sandbox*.c
 F:	include/dt-bindings/*/sandbox*.h
diff --git a/configs/sandbox_nocmdline_defconfig b/configs/sandbox_nocmdline_defconfig
new file mode 100644
index 00000000000..03173113fd5
--- /dev/null
+++ b/configs/sandbox_nocmdline_defconfig
@@ -0,0 +1,2 @@
+#include "sandbox_defconfig"
+# CONFIG_CMDLINE is not set
-- 
2.43.0

