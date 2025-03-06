Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76FCC282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B4B812D9;
	Thu,  6 Mar 2025 15:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VJ0rcbMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A8F812D8; Thu,  6 Mar 2025 15:32:58 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B83881253
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bcfa6c57fso4463765e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741271575; x=1741876375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GeCc92RzMRmJnWM8yJEjR/jIdnDg3PNyaSrnQWLO/y8=;
 b=VJ0rcbMqv/nbboDctMFV0+5gaKribZCq2RhdKY2u8SadC9dul0OCACniY8fyzWJ+Ql
 sFiAzgdoMpSEfjmEvj8k9NzR1BmD2EeiyiVWw6Fycc6WrcUROWLzE4PP29VDqi/H46mM
 EX/LybPQl33XWKR/FSH5JZnvwyH7Adm44mdmKR+HCIKQqloghOvWDCouDifJ7zZh8tde
 2ViZyy6bp1aJyBMAze5A6vDhIx80mIcnynTgKROXsJrZc0BXHKK9PCCDeFC+voOPAHVs
 yZv47WKxnWb4HvjwMYaCcmdq1qYmTqoUfIq17zruuOjbYpUqSLn0Kf065mPeErexZ34K
 PsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271575; x=1741876375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GeCc92RzMRmJnWM8yJEjR/jIdnDg3PNyaSrnQWLO/y8=;
 b=IRJhFYcZ/QNaIp+/QMUqIq9C4EIIUbK35koxSKFLbwXZrnvWZ8B/RY23uD7yRnsodp
 +ChgodPcUlMn7N7Vi2R/CL4jOucJkwwKYNI8o/XHwUUdLI6rarCCGduFqs2LvKgmcfCb
 U7QEUVXhmgMOupR1FHLSa7DzxrP0SnzCm30/rsLNvRKyebOGDQhhIA48J2e8F43LqWdx
 PiYZKVSxUCLcmY6gD6i3DDPzefEdL6ta+590a5YuNBplPEdnwhnWKKy+5xRtn6PfZ0+y
 Yv2kgphN0Cd2XvXEPzHWGodg6sXbCwCvsLRfeDqB0fpJeVTnYeiP7svty0kl+kC6dVb7
 pa2g==
X-Gm-Message-State: AOJu0YwBasXh9RMW9jXA/RU5Qb+T1MgHA5AtWA/xfPKJd0Z1FiyOmjTr
 SGvrbt/c76BRqv+DcQYYcL3w0CqWS1uKq2Reg3bgVuZmjzP9Ylmv+8qx+ZRMNp2OSgIPU0F8XWk
 Z
X-Gm-Gg: ASbGncu0mtZhcV6uVkwa2WEAeqVrRR+yUYkRJzrXnKoYf66yem/C+TqUNC9apde7kFj
 vIQeuiXJPUnQtfKBgtPut6Js5D4DZ8qodFQjksCLJOxWDvSYZrtB5V6nBG9K6xnWnqJpIPDewuo
 PPyhgU4nyF5ZrA1Q3LL2l2ERp/RIkmLVBp+xAO9zfL26dMHgcOL7T2uS1CkFPgfjXhPRqW1yDan
 MB+v7A79hoQumKf1agpCGpSjTrKYmgt5SLbGlSj1dJ6ByyuvWGifiavmOgrnSP6rj2YXEAcpqIY
 y9VHotID4KsNTOd5blPP5p4jWyjeJENX6+x2H5nuG742iECk8ZfSkw==
X-Google-Smtp-Source: AGHT+IF8oVQ7YksLr9IQ5s3BzstrqSyPazwXNWJ3ECguvdjFE+6KdH+FfqhQoXYt1cEB0a38BHPMJw==
X-Received: by 2002:a05:600c:4f86:b0:439:96b2:e8f with SMTP id
 5b1f17b1804b1-43bd29d040dmr54563925e9.28.1741271575518; 
 Thu, 06 Mar 2025 06:32:55 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9470e2sm21561065e9.33.2025.03.06.06.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:32:55 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 0/2] net: lwip: rename output function, add packet dump
Date: Thu,  6 Mar 2025 15:32:20 +0100
Message-ID: <20250306143224.3080316-1-jerome.forissier@linaro.org>
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

A cosmetic patch and a new Kconfig to help troubleshoot NET_LWIP=y.

Jerome Forissier (2):
  net: lwip: rename linkoutput() as net_lwip_tx()
  net: lwip: add CONFIG_LWIP_DEBUG_RXTX

 net/lwip/Kconfig    |  6 ++++++
 net/lwip/net-lwip.c | 18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.43.0

