Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F43C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 13:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5738855E;
	Thu, 20 Jun 2024 15:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NQ0JeubA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8558C8846F; Thu, 20 Jun 2024 15:19:57 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA4C88385
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-375fb45f465so2718145ab.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718889594; x=1719494394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePRPLYEqoA6fcFBcClqbO6dFw5xoU1YwTXbb0Z2vPJk=;
 b=NQ0JeubAUYA6kBLQqsxrVQIsUwEnQb9QDgxGvm/YPhhlBhu7JOTeUTuHp3s1EN3LMU
 H5V370r2ffG7sKoVgC8tmE7+6KN4CUc/yMZCYe7f7vtilF8ZD3ycq0ph1ITizaUrQ2BT
 hT483N4B59tecXazIWGebZhfU6f4lu0k/J9SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718889594; x=1719494394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePRPLYEqoA6fcFBcClqbO6dFw5xoU1YwTXbb0Z2vPJk=;
 b=gAoJvAmE7PrjqgGAIXW9Py5P2Cf6R2wo76NMQypsXUAG5wbfDfvRyfC1RW0+erWj4q
 RynLC/hUs5hnfjOc1IvwzYr6dcI+WoKFT4npKnzoDfAR3xUBkx7YGorYqPeDCMXxFfnB
 becIYK2JNeJXIhzbG083uPiPzOxCuElbQf2A4SGdCgi6v/NonTTcLF5LY/RVRB1sAD4u
 GYsyGDrhCXsl2FkfTn8n8z3WQcshyol4eJZCJ6JGk+xp4/z+ZYch9aEe5BW3bectuUfT
 OaAAUjD3AjF+t6umlElyULJI7R/IcLWQIqXzBagk8gZCafd4sqa1Pvi1nMZYCdBIJEEJ
 6e+A==
X-Gm-Message-State: AOJu0YwqtORRT1e0tYYNPEd2zS1cOiej+S3lyflNDOV5N9mxbRq+8kma
 OtcJ717zhHm1+L8gfGv0cYbdIVK/RUNDPMaqW3VWEHw6AovhvWSl2iYdWh81Ff7J4Xbx3z2PIyz
 Gcw==
X-Google-Smtp-Source: AGHT+IFyZOHCd7ntnvH1I/punUAXK5UOPtZu0Aml0C2J4ehCiaQhwbs7Sj86ssy9gtAqjPtNRZGH2w==
X-Received: by 2002:a05:6e02:154d:b0:375:ac51:9c5d with SMTP id
 e9e14a558f8ab-3761d6bfa8dmr61682165ab.12.1718889594064; 
 Thu, 20 Jun 2024 06:19:54 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d866e260sm31807865ab.7.2024.06.20.06.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:19:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 5/5] CI: Run code-coverage test for Binman
Date: Thu, 20 Jun 2024 07:19:37 -0600
Message-Id: <20240620131937.1130446-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620131937.1130446-1-sjg@chromium.org>
References: <20240620131937.1130446-1-sjg@chromium.org>
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

Binman includes a good set of tests covering all of its functionality.
This includes a code-coverage test.

However to date the code-coverage test has not been checked
automatically by CI, relying on people to run 'binman test -T'
themselves.

Plug the gap to avoid bugs creeping in future.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 165f765a833..eb01fa4868d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -201,7 +201,9 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w
         --board tools-only;
       set -e;
-      ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools test;
+      export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath /opt/coreboot";
+      ./tools/binman/binman ${TOOLPATH} test;
+      ./tools/binman/binman ${TOOLPATH} test -T;
       ./tools/buildman/buildman -t;
       ./tools/dtoc/dtoc -t;
       ./tools/patman/patman test;
-- 
2.34.1

