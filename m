Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CD4D132C8
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 255A58909B;
	Mon,  4 Nov 2024 14:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NOR06I99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF028909B; Mon,  4 Nov 2024 14:40:20 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B94B088C7C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83abe4524ccso156687439f.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727617; x=1731332417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmwBZyjxTwrCXhBnxmI4WJ5bHwoqqqPAZonFjR4CMlk=;
 b=NOR06I99r7qNswBDNsT/O3NGHT+TyDQvyHTEkpTN4EKukvbDzYAc9U1drSru7AN/Xr
 EK1q0d8lH8OEtp/b6COc2P2PLqT3QI2+6gUVa+xhGFb+Q9dZJrpOGYeuTfY+FEJG9+19
 buPj5VccWZco1qi2VtE654P0efllaax2wPCPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727617; x=1731332417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmwBZyjxTwrCXhBnxmI4WJ5bHwoqqqPAZonFjR4CMlk=;
 b=HVjl0qg4rkLE1zz/C9e0DN5Rc9HP/DPCNrK57m27JzuEgVqFLCL6OoNd7NoQtOgG2L
 V7+eAzpPsXvCD8lZ+a7jMZIvdN3VT5fLu2cWjFm5a23Oq9Jpo+MhTwmiEZDiFWu3SY6w
 slyT6V+2GZfEopLOnA/LeJFlOepiP9EA0Ypea2hE9L2OxxNjLRrD8FHN8oJi2tp/Z/xu
 xWQhKGfj3+4JyauDzve6SgqjheaYLus67rynNFTkf5BaJCdkZe+2DiZfCCmIAJdzGKs+
 dbBUxkJy+wu19qWf7cC2biY4fPVV8WZbuJF1zUcgRVjrOUITDoVetj0Xqdw8Hy22wFmi
 MRmw==
X-Gm-Message-State: AOJu0Yz9lBDS+Y+L0LDXGOcnqkRG3eoTFQYiptMwnUuQCwJUxlLZfu9J
 yeP5ax/bO/l8dVY/4qycu5ErHV5vK/dqcAY9b9EFup9JarswWUD4KXQEA8WGuJHSzGMg1xwLOT8
 =
X-Google-Smtp-Source: AGHT+IH9BNIKrxnBKyOP81Dvzs5CTEhz1DlJojSdxh+v4rUCD8FCz5FhnRdrTEsJOKUMDCEjjncxLg==
X-Received: by 2002:a05:6602:2d87:b0:832:13ce:1fa3 with SMTP id
 ca18e2360f4ac-83b64faa3f4mr1760414739f.8.1730727616892; 
 Mon, 04 Nov 2024 05:40:16 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 9/9] CI: Add platform variable
Date: Mon,  4 Nov 2024 06:39:53 -0700
Message-Id: <20241104133954.840994-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104133954.840994-1-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
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
---

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

