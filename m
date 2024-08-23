Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CA2C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BD988C42;
	Fri, 23 Aug 2024 15:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QLQvptyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B0E88C17; Fri, 23 Aug 2024 15:50:09 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23CD4889D2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-371936541caso910834f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421006; x=1725025806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OU2VUMRGCTc+MvFx1Y4JV6qJNct5kwe7bvtCsqQAkio=;
 b=QLQvptycWiIui7gDl6oJduNayUkSjbxx/hO2TlU0qt5Hp4mzNazTovtZwFt+OA4YBD
 N/OrujlaBpRZlXvA3b6a8MpYufd9IZhhHk4F8W+rknRP/mM1kzUitvKSv388CkTExR2I
 8oL2G2zlLEKP+kvWL+VHPzRhqLNrFj0LKfkt75NiaUe9AvTv18SVsGlqe+CHD+/b+7TJ
 FfL7yjcgDkC+pq6dtft49W+cfoDLNvuCXMStNDllS7ApQvpOzTx4i2hEJ2wnzgbPyP+m
 acR8JJSSyUZflTGpFpEmwTLOngDdTRU4Ssfc17ct69scWukN3+t3rax77OTD/nfjf2V2
 JpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421006; x=1725025806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OU2VUMRGCTc+MvFx1Y4JV6qJNct5kwe7bvtCsqQAkio=;
 b=o1/fzXqSa7wfermXlek55gw21ZkXw5XpMvhqY7o+IB8vMCe1ZI1MpIMldeJsX20RTH
 lEb8raa0ZXuleisR7i/ni46EDpcFEMdE81y1wM+8HTqISDf0UPBElZlhwVI7YKMy6dVl
 YoPU4A2RzdQsl3Pz9T5KuWqew1A+raYN+jFVYZuSW7PALsXTae//26I932DPu8Hpcm+j
 F3W/aYpAnMI/yQ+V+eEZtQUG8/Td4lWjo/Ex7zyxr4khhxZbikchbRn/K7pCEwap289x
 cF6sxRjmPbtzz1XyYx3eeDkjcjuq5s62YzlmKmhe0OqfHTWChHTIu/aqkrrIUeCKuTFU
 R3vA==
X-Gm-Message-State: AOJu0YwhXVOVzhtnGdlRv+4KZ7Mzaige2S73WslD7GXR/tfaCtk1uOTe
 UeVz1Q2kGxJIkNzsfVLvqzpuZ7BWAxDegN3t21QMOM6BfEj2VrVc9WKdsxt3P5oXnz49AkHSqB5
 T1w0/TEu5
X-Google-Smtp-Source: AGHT+IH+6UXIij8r57BhMovSPWUuTszzB/IXQn03KdXImO/sOzT7oxEcD9ApJwwqT7QPK1DQTWZrgA==
X-Received: by 2002:adf:ce88:0:b0:368:7a04:7f5b with SMTP id
 ffacd0b85a97d-373118d12b0mr1627665f8f.40.1724421006406; 
 Fri, 23 Aug 2024 06:50:06 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:06 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 26/37] net-lwip: lwIP wget supports user defined port in
 the uri, so allow it.
Date: Fri, 23 Aug 2024 15:48:30 +0200
Message-Id: <9a357746ad72f7b78320d225c9d020e283000a8c.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

From: Jonathan Humphreys <j-humphreys@ti.com>

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/wget.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index e8768fc2acd..b495ebd1aa9 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -349,12 +349,6 @@ bool wget_validate_uri(char *uri)
 		ret = false;
 		goto out;
 	}
-	s = strchr(authority, ':');
-	if (s) {
-		log_err("user defined port is not supported\n");
-		ret = false;
-		goto out;
-	}
 
 out:
 	free(str_copy);
-- 
2.40.1

