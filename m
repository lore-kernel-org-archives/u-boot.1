Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBF9D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BECA891EA;
	Tue,  5 Nov 2024 17:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RljTlxxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C0B89232; Tue,  5 Nov 2024 17:08:11 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D489389025
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a4e5a7b026so19805675ab.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822888; x=1731427688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWmhibPxKBzf7aRs2ImAjQZgqb5Gc72CGPfvOObhEdA=;
 b=RljTlxxBOZv2LM+QxS9WRas0w+uP8DmfKbAX1ra+GI8L9NcQqBbw87JEBB9ZEn95mU
 yyoLKgh3IdYy9kUCbJ5CchMPeSG9CgEDdm2+cc6xMv5dJaLpW9ZaeIEwRhgEMpb+M7W6
 NkyirG0BmtQZALR0n/MnZWLyld8AmTsfN7ngU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822888; x=1731427688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWmhibPxKBzf7aRs2ImAjQZgqb5Gc72CGPfvOObhEdA=;
 b=MNzm3c2N6ngUftX6xEckb2AR/YL0IdWc06Ph5DrOk8uFMPTu7d1xQRFq/BncmiMF4z
 Vp0tDlIYM+7w2FP7+Z1dGURlDj92MJdCdj0QCcjEMvac7J2ONa16/+sdJmd8Pg1VyZ3d
 itAl8saQDrnXYZJ9e4LlhcgSvy0QaJGWW8zFSvLR4Y6XRsx8Z8uUxYLNLnKWDt86K774
 lWAysAIwSvskoNxPgs+UocW9PtEjHDuGLkuwKebyn8uNqoRLcXUS2CltF6Zw5mevSJnV
 qJxSZeAWdngumddkKujmP/sHCSaBOJWzAhJ4Rr5Kb+z7JzNL9T8rDVG+JntfiUOePWuZ
 YGZw==
X-Gm-Message-State: AOJu0YyPl0al6xaz0s8CgqfaahVTX1QDyG1Mu9lr67xoBGY7ZAtMFZLw
 ELQtXpUSlGMED1oJOpF038ThbLVcUHE1a1hbnPL1jrA288il0Gi1OzIw12CZuFdmG7ZUb95IuaE
 =
X-Google-Smtp-Source: AGHT+IHYbZ7UndEoQOvXiOv9q4Qf8ZOegoDNA9iYMK/dIhhWHfLrve/Z9dh3fCMhn0jIhgu7AlicXA==
X-Received: by 2002:a05:6e02:168c:b0:3a6:c43d:12ff with SMTP id
 e9e14a558f8ab-3a6c43d15bcmr89582765ab.8.1730822888065; 
 Tue, 05 Nov 2024 08:08:08 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:08:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 9/9] CI: Add platform variable
Date: Tue,  5 Nov 2024 09:07:38 -0700
Message-Id: <20241105160738.3795497-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105160738.3795497-1-sjg@chromium.org>
References: <20241105160738.3795497-1-sjg@chromium.org>
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
---

(no changes since v1)

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

