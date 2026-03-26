Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D878710AB82A
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 23:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D85283FD3;
	Fri, 27 Mar 2026 00:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZzOYpJfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2785C83F14; Fri, 27 Mar 2026 00:00:33 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1074583FD9
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 00:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-46702742c99so1003614b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774566024; x=1775170824;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8SdwYQgVrfwqO/lLh0b7KhO1/SqUcZfnoedtBT8V+gc=;
 b=ZzOYpJfO1nw2KiNmbqBl/v4gUkVQyMr5gdc8WEUAcWHWAaWFCPcziOwr1yICsJPk1u
 tQWLt/9zlAZk94lDzxA0CEtexSpEIWnO4fyppf11bTDbwdmEKpTepjH+jqPkc/DadaIy
 X5V6ho++iFjTvzj1HBfMciTnCjDImaegjvTfj9BED55/3PX9R0c3gZ4U22yLcR/3W4Xl
 fEoFHTTPqo7c3z4lcCm4k/LzgcDlRRkTi3+rqgQhAgp+wH2orrfBV4Fh6CodmAYYNWdD
 QlrrrbOD+kidrOqgo66f/pUe63y6WGckpvrBDfUiJSkD8VSUoCM0SIPh38D74mZ+CbC9
 9aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774566024; x=1775170824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8SdwYQgVrfwqO/lLh0b7KhO1/SqUcZfnoedtBT8V+gc=;
 b=iQupMOEfYz3FBzbXGiyJYopinWBqOwVzBBpDy6UK8A1D05h7TFUP2Chc72g7tQneB2
 jYolY+pLIWshNnQX7nR6FNgnF6btE9cG/atpMZ1GQsu2wmPPqfd7ws3Cfd9nOkQSViR3
 Hx9IcnJnsHb1z0DdH+VntKyX14UitMOC2fXw6Y31WP/5TBQhq1sdP2SjNDG1PGO9cHmP
 lXmHclDuMxXsteX6AP8toY+vXqZAwtb8OrQZQQ8r2A0MmVgxx+sfYBe1uJDKVU5mmq9C
 Z/913Qz7p2K9gcWJI0WIv7rWWH2ahGaPUQ+tYqGmH3UXdxVbhapr0FkWmD1Nz5aSNdWZ
 m4qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm/gTnIBPXzaMPEDEZnV9/k7PlqkmSCSJeEhHbHLZc9Ui6j0i9Nx2QdEzM0J/oC/sWWXH+3Gs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1rUlDcIQwFJMsvJt5dXPPJGzDhEO8JUoxxt8S/GA+pYK/DkFD
 GtM2FEb5BNMt8tSMnkLGNbj9CtuuV6GC45qab6D4bpnmZEsZPuVGVRJtQWOOboatFmQ=
X-Gm-Gg: ATEYQzyvuzpIW9cHkQubIQqKkitma5hPxoHBIIcGfofYNv2lheoQRoLi8SGXmd6AyAi
 QcpPPfxddvEFHuVX9qqJ4P/4NXM9odN7w9wXHfmblogZ0tOjjzRf9X8JbUJ3dpFswGwfVX5MVuK
 Xc1ytOKK+UxxdZ38tLXkMZuiwHwus+0ChJTWPFk/891pW1NBi5HrUyaGdy8LsL3xzJ3V5lRtdPg
 yCkhGUBp4yZ1Hw02JfVxH0NdKTe5gbMLwiIk72qJbTEDe8fxL5jPKbWeNUyGokGqXhpHrB35Dyv
 HRXPCO1JSmCL7Xdpd0z4IwNKC60Wq7ZusTpFAGH5qsim01z6YDRy+3T72faHPzYGmkXgshQR64o
 j5mdmDmkXSW8xpecAWp41FmiHm1h9kFP140sIrr8VflAYlc7lF3Kv7MbT7LMFFGHx2bL7nUSUhN
 c91J+PreCUJ5dBvHXEKiKkGtUfpZw/jqoYLxA3+JI=
X-Received: by 2002:a05:6820:2d0c:b0:67c:25b9:d366 with SMTP id
 006d021491bc7-67e18705d11mr223155eaf.42.1774566023633; 
 Thu, 26 Mar 2026 16:00:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm2742836fac.16.2026.03.26.16.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:00:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Mar 2026 17:59:28 -0500
Subject: [PATCH 6/6] env: scsi: document requirements for ENV_IS_IN_SCSI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-env-scsi-hw-part-support-v1-6-55c9dd07a2cb@baylibre.com>
References: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
In-Reply-To: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ZhZ4cewrnGWhFTk3zKHvrdPwo7D3mdsYgMBmBNKvoIE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxbp4k4FIU6nuPSPsPcaqxkEB0xdtuZ4rKS5H0
 FyNMkPegxyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacW6eBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AbpYIAKICUDKK9Hfi2YHdW8l7Rt2DGGlPn+QxiO9EnQt
 jg8nUu8sVvDmaj5/FgQfG+Rtgvx2ISj4kTlq9YIawEq5truf++0yerzPCkPgMZsS/elCI0l2UQ4
 6FqAmjXYWI8jPEneZN7DAohYTO+voof0Zx+mT9Xv2uznBGE9QMNIRTUOUR4FtAcQf0q9ZaBpxJe
 inS9j1rP76WfDsQPwtMZVV5B83Kdr3juElI/HFp0RViIGblRfIl8jwhtYTbsxiCu4JwqXAS8711
 LrKqZp6VLRSSZt+o/ne89HGS29cAWfUrhLWUzjrKRTzC6s2VJWQhBvxFXJ9lE0KWd8BTGQyBXKu
 5OXE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Expand the Kconfig help for ENV_IS_IN_SCSI to explain the other
required config options when this option is enabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 env/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/env/Kconfig b/env/Kconfig
index ffaf16c581c..9eb941b74a4 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -293,6 +293,23 @@ config ENV_IS_IN_SCSI
 	  Define this if you have an SCSI device which you want to use for the
 	  environment.
 
+	  - CONFIG_ENV_SIZE:
+
+	  The size of the partition where the environment is stored in bytes. Must
+	  be a multiple of the partition block size.
+
+	  - CONFIG_ENV_SCSI_HW_PARTITION:
+
+	  Specifies which SCSI partition the environment is stored in. If not
+	  set, defaults to partition 0, the user area. Common values might be
+	  1 (first SCSI boot partition), 2 (second SCSI boot partition). Ignored
+	  if CONFIG_ENV_SCSI_PART_UUID is set to non-empty string.
+
+	  - CONFIG_ENV_SCSI_PART_UUID:
+
+	  UUID of the SCSI partition where the environment is stored.
+
+
 config ENV_RANGE
 	hex "Length of the region in which the environment can be written"
 	depends on ENV_IS_IN_NAND

-- 
2.43.0

