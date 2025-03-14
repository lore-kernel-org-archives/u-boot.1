Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8726C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC9582072;
	Fri, 14 Mar 2025 22:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JceDNawo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A379A82027; Fri, 14 Mar 2025 22:56:07 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BD0820B0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so2302464f8f.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989363; x=1742594163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lz9WtFGzw2gotl6qOgzVW1XbdBJN4oMfKJNLXeOxrLU=;
 b=JceDNawoPJzwGPaS71D8w5HcOVy3vDr7kiGqtK4WEe39PtD7yGOYaGuh0b2cdw9cAP
 BReDQizHt0n/5cJfF05rU9Q0fA8nrIUHcFQQxhBiuStJeEVYjYajlZ4LjxeqQmXigI82
 gk93g3xbRsGcn17ebMbj7BlT79ezQDyS1tV7T7fAt1XrJkFr34vmaq/avoqPqnYqCzgy
 EeaQQuakhR2W3cz1U/BCj3sScJz35YuAVNYi1wxDA+EY4EmlHZk1AVVcFyPp3HFK+WMk
 apnXOpB7Z/1EidwQU/fPRV6JoNouIZTPbVL6h8lxrOJjZQp2KRlTouY4pZEOGw+2smNi
 FFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989363; x=1742594163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lz9WtFGzw2gotl6qOgzVW1XbdBJN4oMfKJNLXeOxrLU=;
 b=omMGlbj83bXOjyS+4y4QCnhUy4mP0AuHNzdfGfL17yfuzGnkfJmuG7NTPH3/qFn5Uc
 R7JL26eN1irYgc3Ze88rOGN3QO3P0jgIwFwfTSehAR8Mk7e/bNOluf7sKzP+FaaAFUKp
 99EPpMILioI4ite8EZHWNxmI9OoTr/tROszaqEY0YzeDjZveD5tXqEnlLfZvV94Ns1Y9
 lK7aOzvkA2oXv0DkaDnFxr7PT2dCSww7wr0VDSSy32zJ35X5Uef2BxwCH9zTCoahH91w
 qt4vk6Xwyiz+6C0OXd90R4Dr8gcUmEbE2UrrnZc5Nx4IX6cjtyOALdc5BoPxy62BkGvA
 yVcg==
X-Gm-Message-State: AOJu0YzJgF20/v8O4bbtpTfXLn/ct+w+jLPivfSODZ/Jwa1+7DfmXYL9
 RgRSK4X9kgzjjaaTXtCvCpaoECNm9fBLrCG/rYzNaPFuALMpw0T4tJ+FpcERzMJcuHErx/Uviof
 sgac=
X-Gm-Gg: ASbGncukJK/B2UJmIPPY/r0OtghBMCMVSr+s9R9c+tmaelot/0jQ+kXMUQOtp+O7rr0
 32UIEW5mwk4iAYCnD4Mr9UE77EUQTpegj1AdeXndFiuuAcWxLR1e+mEIdYuKd41p2voYgBoa8t2
 foE63Ii+LiK9uRMjb+hHPrnkmGa8WHTZ0osVBF/nnq1J8PYPMdAodWz+BJqR1YzuKa8IzLlJr3B
 y76IOWF9FO7g/O2NHTWTsFJMTWwjsMi3jGteUqBhQXDfkqdBTziui77WcTAWjsxusPB8nDRLWJD
 7uffRJVqzexnaJIJVKrdc7IcJlHKs5pQfTkotniGRTYdR8bHwYny6Q==
X-Google-Smtp-Source: AGHT+IHiDWwGCsCyB2x/XGCRPkaaJpNVHBaN2XZGNassa8u+eEToKyZV6l2xFiPNk0VJneCvG7vnUQ==
X-Received: by 2002:a5d:584b:0:b0:38f:577f:2f6d with SMTP id
 ffacd0b85a97d-3971ddd4b07mr5943119f8f.2.1741989362753; 
 Fri, 14 Mar 2025 14:56:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:56:02 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/12] configs: add sandbox64_lwip_defconfig
Date: Fri, 14 Mar 2025 22:55:13 +0100
Message-ID: <20250314215525.579655-12-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

Add sandbox64_lwip_defconfig based on sandbox64_defconfig with NET_LWIP
enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 configs/sandbox64_lwip_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 configs/sandbox64_lwip_defconfig

diff --git a/configs/sandbox64_lwip_defconfig b/configs/sandbox64_lwip_defconfig
new file mode 100644
index 00000000000..0e92728533f
--- /dev/null
+++ b/configs/sandbox64_lwip_defconfig
@@ -0,0 +1,5 @@
+#include <configs/sandbox64_defconfig>
+
+CONFIG_SANDBOX=y
+
+CONFIG_NET_LWIP=y
-- 
2.43.0

