Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A749D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5801789454;
	Tue, 12 Nov 2024 15:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TKqRmdCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0DA48947C; Tue, 12 Nov 2024 15:11:30 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A7A8946C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a6c1cfcb91so23919345ab.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420686; x=1732025486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgU05Kl1zINJ5FKbp611jN/Qq11Cr6/3qt0GkGKWc0w=;
 b=TKqRmdCFM7uucQM8GsLCMJ98Y2JqwhaWdHRpA/gf6wtwRE3xs6rJoD2K9+xgPKE8V5
 vJO2/IpcrOXuzcskAyAmAzvNKJaGU6GTpvTGxLBNT3Rk9IbeU7ZL0S986JN5nSiq4/S/
 VkSYMHUgmSyAfxIQtEj8FsPTWsUYCm6L8gXFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420686; x=1732025486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgU05Kl1zINJ5FKbp611jN/Qq11Cr6/3qt0GkGKWc0w=;
 b=T1MVo8ginQdAJ63sxEcNbTrR7I04heJ/fhwIUsh+ojAtEJJ0qTsUfgvqYq6Pxqe9vS
 v2PfzetAr3ZLdwGA2afnvYMPV4wxhJDxuKi+FFvIwCQ+NJrd7Sd3so88nLznPwVBTnHY
 kd/qZRY3MkH/pd2Tx5t3MacXFJG4urvegf7zPUKBVHvEyKWsN/bJdZdqLzG+gZ5hrC4H
 KuhCAjgCTnKqCMeBFGF7QSTc4lwfTZWwIU+zzDNkVSuUq/Gv/C2mnGinCfp0/cXgRODY
 2QYx6d1MMHPOGpcA/vzeFBMtazRkZXQ+IKdEoLM0HUjl6jaUoVXSwB7L+kx1hjyLdPJr
 XjFw==
X-Gm-Message-State: AOJu0Yy41Gagmuu3jhwC29T0oIoPH3zwoR0yDqJhXLOC6PInMsgZUAg7
 Z4kXA/BaBkYNMEJDxbkcxAAGtk73GvJLyGhTpINCIGx7XvE6hMXqln+uJMMuPCg3Y8phwV74MBY
 =
X-Google-Smtp-Source: AGHT+IHvOAT/9NIuFVrZ2qwuZ7aSp8rTgBR7JugtER8qECFftV5NGkiICYLaYhDix9ey1HsVt8hRxQ==
X-Received: by 2002:a05:6e02:1709:b0:3a6:bb77:a362 with SMTP id
 e9e14a558f8ab-3a70c7f906dmr28512095ab.4.1731420686361; 
 Tue, 12 Nov 2024 06:11:26 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 8/9] CI: Add platform variable
Date: Tue, 12 Nov 2024 07:11:04 -0700
Message-Id: <20241112141105.640189-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141105.640189-1-sjg@chromium.org>
References: <20241112141105.640189-1-sjg@chromium.org>
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

