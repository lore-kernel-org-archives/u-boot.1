Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525C5D637A9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA64A89579;
	Wed, 13 Nov 2024 19:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Djjxjryb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B940E8954E; Wed, 13 Nov 2024 19:54:14 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C9B88216
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a4ccfde548so3181885ab.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524051; x=1732128851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNi2V+RVQWA5DgX5aBIc2csZ5EC5UdZ2f7TtHz/ncy0=;
 b=DjjxjrybPi50gv7wKJAhzq/MYFrfj8YiZOX1AO20hYSsCIB1ZOYmkiC2sRY4rwXsOn
 Nuai2wfYWa5Pe1dVWjd+Wfo2dUP7LesvyZ9BJHuDEoWh1EeTxyyzkQaCBhvcPqHeCE2j
 TIlB2hEvR/YJ2Frff6uUEYqnOWFYabgjCcY78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524051; x=1732128851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNi2V+RVQWA5DgX5aBIc2csZ5EC5UdZ2f7TtHz/ncy0=;
 b=PJGCEjKd5kHTY745U5yAyMLr+FO8edkNUo+G0qap/3KhfYa1I67Ej/gZsskg8JTOqQ
 kLxmyDU9lYl9ZzT63wQahMqhW240BLZfC7vVkq5nAGb80/stwl0YByweGQ9/DaBCzN39
 QOVJEfxEmWUQKtdcio0UUu82RC/p+V+Ai7/78PDhfp+5wNzF3ccCBJDsgbkV6lZIqyEe
 NVjHH+GsQ6SCjGY9CT8OrHWGsCHFyuhObUsf8H9rjaHvSe6q3+9xSJODT8TRZAM4u8ue
 JA5g9hwq6mXMx//66wUavdPwBgrewDsHHUxW5xoPns6ZFcLS3NvNziw9VXoghYH3KoIN
 jF0g==
X-Gm-Message-State: AOJu0YxCYg5LU5Lob5SpAkx3wffb06WzMcgLP6yvvPMvTmHtAW9RCZ5M
 mEnB2UVm9O8jiNfF8Odic6LYrFTVlI2HCSJRNsSc/Or1n8h6u1Ssl7SuO9eiPhHFn/QZ1MRxPjE
 =
X-Google-Smtp-Source: AGHT+IFDo1Y9ciwwIYMGyxKtrcQQEFW/SjoAF3JRDFkkwAuCC7lW6kp/0pfm1dP1LExfoFn9Z0naVQ==
X-Received: by 2002:a92:c951:0:b0:3a6:c6d1:8c4b with SMTP id
 e9e14a558f8ab-3a71de50ca1mr6497555ab.3.1731524050676; 
 Wed, 13 Nov 2024 10:54:10 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:54:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 8/9] CI: Add platform variable
Date: Wed, 13 Nov 2024 11:53:39 -0700
Message-Id: <20241113185340.1661198-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113185340.1661198-1-sjg@chromium.org>
References: <20241113185340.1661198-1-sjg@chromium.org>
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

Add a list of possible platforms that can be used by gitlab runners.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v3)

Changes in v3:
- Drop patches which remove grub and tracing for arm64

 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0aeda53bc2d..e152060b046 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -3,6 +3,7 @@
 variables:
   DEFAULT_TAG: ""
   MIRROR_DOCKER: docker.io
+  PLATFORM: linux/amd64,linux/arm64
 
 default:
   tags:
-- 
2.34.1

