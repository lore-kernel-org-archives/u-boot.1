Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526FDCA1010
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 22:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94238362A;
	Thu,  4 Sep 2025 00:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i04NSZ8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A304C835C1; Thu,  4 Sep 2025 00:09:48 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A55C835C1
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 00:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-54492cc6eb1so244911e0c.2
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756937385; x=1757542185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aabHYnN18Kr36Ervx3AMxVKBnnaeqGQPKgWA307VgzU=;
 b=i04NSZ8kKoMr0mpE8nr7rzK/rYH3BK4FEqeBvfrExSHaQX0CZWgXl/wfYPaknLbZ/n
 T2selLr47cOhRxEPluxG/XoZu6pujK9T1zKZSc3EUVVIn6HDBB38PhEzn5oaQJMwVj0i
 M/KRWoFZvJXh+lcVFITRRcwdx7FYfE+cC34I7W3Zg2cRDxcI0yPToV/Jd+EeDq9oECxC
 EDCuFe9asFt+4dtnpKNM88xsk1ObU58Lk9LE3Gh6eBDM8VAwVj4tKERhjeSVxcH2VGqX
 6XFlmUzISFN5RSkdg+j/ycNf7ek1vcccKty5vWlSwotxf/0nLZNHDp9s+VwIGvSaOOtn
 FW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756937385; x=1757542185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aabHYnN18Kr36Ervx3AMxVKBnnaeqGQPKgWA307VgzU=;
 b=vGZsPwrYvX1EOeTpqvyheB4L6UWr96P5AvUrpPPghCXrqZ9Z2OMI42amWsAYUeQV2m
 b+8nq/z3fC/ujOZjr53kYTdmCuxUuJ0T9xU/JoM2RVQ/aPsvBoLIx7QwDt8dcjXJeVG5
 5a17fW/KhgIg3ilDKbZQz6KbG7SUw6WqRwxyOFlifc16CS1uiNM6sZUfBoU8IIF5BKFn
 YL7HszNS2H6Z2tuxYH5qMFjl1VLtGmLihmzTnfogA/KxAFCrY+NNX2J0bVvwEnqqbcQ0
 vcwIAtSSipqidDdZa4VbohL53rJuhrhjVF0lfrkfzyQiagLSh1xTueY8CF4jpw74B9OO
 I15w==
X-Gm-Message-State: AOJu0YwgYEWSLAveKvD8KINxcYgT7MY8qdeCMbqWNaO31FvnJfYhrw6L
 LLym+JyMaoP7Ol3Qazops2RenoUcfJ2XpCYDOS0T8AgxMeYRNYWiCgU3y4lJrnUj0od7xKUK+Og
 Qk6Iq
X-Gm-Gg: ASbGnctlbd2EDAFQ1Cw3hDS+08dZP+flSEqtdrBRHqGEH0psLfQk0FjMJS048b7K3Oj
 S4PwXAmfNcz92RS2y7ORaadOqW3nKiu4VdrckKtxw8ef5VKsKGlCGCEZmZtuqEMY+Q9TVuhB5Kk
 MRjglof2w6Xlf9kohliq4JjYdjm+HwU/Yww7z3f2sgQAR3dpxswLZtL8k8PuRswxLfXU0OWtV7q
 nd/grIO+cHzJIqtaKRYQmXM5tFFJFYhGzdEj3UKPydHTDekRr3trvEeZmRjqXz6W6RJmUvgPCz9
 NfhVYzgXaQO7wQ3HagNVp0MFLHNz22lEBKYgwftb1tXaLiT3hM4zjWbb72EtMMp+lVw02ZSTyGr
 3lLBlftcugc/1f4ZAX+P4kd6iBU5alwae+X96IkhIoxf6OmhUmj57JEAQOaxgVJANHYYBhg==
X-Google-Smtp-Source: AGHT+IHKzZn0fAukLSvyRvHf8q5GGi3WEXd8ioQuvecedoMbRnCcnFAgSCb2P5v7rCkF6XA2hi4XvA==
X-Received: by 2002:a05:6122:3c95:b0:537:3e5b:9f66 with SMTP id
 71dfb90a1353d-544a027f945mr5940579e0c.12.1756937384662; 
 Wed, 03 Sep 2025 15:09:44 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544912c7125sm7474211e0c.5.2025.09.03.15.09.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 15:09:44 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de
Subject: [PATCH v2 0/4] Modernize U-Boot code formatting with clang-format
Date: Wed,  3 Sep 2025 16:09:37 -0600
Message-ID: <20250903220942.473282-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
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

This patch series modernizes U-Boot's code formatting infrastructure by
transitioning from the legacy scripts/Lindent tool to clang-format, aligning
with current Linux kernel practices and providing a more robust and
comprehensive formatting solution.

Changes in v2:

- Replace Lindent with clang-format before remove it

v1: https://lore.kernel.org/u-boot/20250829233951.547352-1-javier.tia@linaro.org/

- Removal of the obsolete scripts/Lindent wrapper
- Documentation updates for the coding style guide
- Migration of existing tools to use clang-format
- Copy .clang-format from Linux kernel v6.16 tag

v0: https://lore.kernel.org/u-boot/20250829190058.GY124814@bill-the-cat/

Javier Tia (4):
  clang-format: Add configuration file
  tools: zynqmp_psu_init_minimize.sh: Switch to clang-format
  Lindent: Remove wrapper around indent tool
  doc: Update U-Boot coding style guide with clang-format usage

 .clang-format                     | 804 ++++++++++++++++++++++++++++++
 .gitignore                        |   1 +
 doc/develop/codingstyle.rst       |  40 +-
 scripts/Lindent                   |  18 -
 tools/zynqmp_psu_init_minimize.sh |   2 +-
 5 files changed, 844 insertions(+), 21 deletions(-)
 create mode 100644 .clang-format
 delete mode 100755 scripts/Lindent

-- 
2.51.0

