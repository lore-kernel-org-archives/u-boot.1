Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0110D637A9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59DE388A1B;
	Wed, 13 Nov 2024 19:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ICZYT+/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05D988A1B; Wed, 13 Nov 2024 19:54:19 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229978953C
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a6bba54722so28262115ab.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524055; x=1732128855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGOHf02Y2SH65juNCjKeaaUi8gPlJaO+F1lijuUd8/g=;
 b=ICZYT+/xAnwsbafE+SkasMWfweOX1R8TW9yHsl87536ab7KeuLt+LKjfYNimj1Sw36
 xNMqfmmXTgASgEGBDJ0/L8u3INyzkWAqQmY435C/0oQj7+5WOoiMdd9z+m01lvns0esK
 ZEvjIJ5NtfpUPfQJZydRr+uj79jELpvut2ox8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524055; x=1732128855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGOHf02Y2SH65juNCjKeaaUi8gPlJaO+F1lijuUd8/g=;
 b=N0dfMWmuxCxljy8XJzPLLbM/t/xGU9kWMHbfGesLQYNXxR7LB8buYW0FmyqMOI/ew0
 17vJ+u8RqeShqoNs25MMYafKm4OwlUPJwFM14AH9lIiF1yrVUTvbK5PRrhM4Dy4sM3O/
 kbXchQvhmrR0HQqenmhDimmLW8NPKFNQRF4r5ZX35iP6o2kltBI2jJBk8h1SzCBwfRjL
 UCqDLmTKuWVkQnGaYkqbdqfDqxPk5i/dqSDJ6SMvt9gyMeEf6vyv6pFTIE4YRdniS556
 iD/QrOpmEi597dUSxZLKj+nIs8lJOvnfAjls6DSd9qtVr9w/0FEWmHS+YazmL471eNmM
 HCDw==
X-Gm-Message-State: AOJu0YxbsSe63L5xZBBPisMWaXcD1h+wfwUpaaGgfPEYk5hypiRgIhCP
 8VWRFYR5A6sohERfItvjQNY3RUp0/d8TVJQ8EFQbUC32uhXXXH3kYjxxvGDDJmV3YLPp/4hKyB0
 =
X-Google-Smtp-Source: AGHT+IESRjw7JGdlixIplPulNYzPXB9I3pGliZuvwjONfBB7aod9uqvig8WSinhjqpU2oYCj2Il+IA==
X-Received: by 2002:a05:6e02:1608:b0:3a6:ab13:2b7d with SMTP id
 e9e14a558f8ab-3a6f1a48de7mr243452735ab.15.1731524053711; 
 Wed, 13 Nov 2024 10:54:13 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:54:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 9/9] WIP: CI: Update for arm64
Date: Wed, 13 Nov 2024 11:53:40 -0700
Message-Id: <20241113185340.1661198-10-sjg@chromium.org>
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

Do not apply.

Switch over to the new multiarch image so we can try a run.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e152060b046..3275d9ffa45 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -11,7 +11,7 @@ default:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240808-21Aug2024
+image: ${MIRROR_DOCKER}/sjg20/u-boot-gitlab-ci-runner-multiarch:jammy-20240808-13Nov2024
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
-- 
2.34.1

