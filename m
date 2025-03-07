Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2044C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 10:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19DA3811C1;
	Fri,  7 Mar 2025 11:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7Wz0dJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BE8812C8; Fri,  7 Mar 2025 11:16:53 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEF280F4C
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 11:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54993c68ba0so390099e87.2
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 02:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741342608; x=1741947408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AISWuhoLTcVBwfx3vUdzfG/F0m+np53mby4rxs/Wx0Q=;
 b=L7Wz0dJYjEJfvtSFTU+I8P3O8BnwJitTKhOU4Djxt9uiRhpP+chHGtW64QF41+CEWW
 hpuUW4Hf0u6Blv8ApkVme79/yBXGPJF8oG9KqHkdr39eMeFOg02gNANyoHJnao2GZjee
 Z2e2g8ukiNpfNW+qG96+gLnn32t6FZ84YxzRfWRa6gzC59cy1sAP+folq2YtVosr2xI9
 lRlhnng5Z9n/ETonEDaec9GTLIaKFe+6aSYBg5XbITZ2664Kp9pFVvWbfvQhLNPvfSth
 C1mq/I6ouV3zeNSJxXdAYVgz0pCgSpW2HMIND2tHpG8xRgTHFEVqcENUxA5hjIE6VGc4
 hGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741342608; x=1741947408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AISWuhoLTcVBwfx3vUdzfG/F0m+np53mby4rxs/Wx0Q=;
 b=gXtjhQEC+3uOQhDuKzVk5NqsQ2Zri61WCEiVM35UFr7m3msv/JqoeCE4xJEa7U4ufM
 z3e9FVMpAcLru64Nm9k73PQl9Youc3WYGx1hU7dalmRdadgvxI8cfF0ZvDOdupIm0Kqb
 Q95+7Mq/DrqzSutYg1pKzu174UxSd+6HQ558pxT17555UD+j7moCw84377iCh3aNZUps
 eItma9PHvVQn0t4qLqNmwHgwgiwFxzUjaPg5jwZ1Q0RuzAc8t6iXjCEwVOO7QuEJh7n1
 f0O9re9Q7Mc4TqqOV1NO1Vkdt35Y1zbiKYAXz2rcBZCB9OQhVmbTT4JxeiLj+FE3v26Z
 IRUg==
X-Gm-Message-State: AOJu0YxQ0M6mkTq4ybCz+b+NW5TZwjLKD6Hh3v4mw/vBdGdxMnhuPxa4
 Con2qFQAuZbTdylITkkIvv36DlWvjvo8e0uuJotBqfJ5FteEd4pz
X-Gm-Gg: ASbGnctQJvYhQIYqJzpxLd7t3QLEhYStE8557FOz/oDSr2ykq6oqdUUy2mS0Vlg8QKX
 RLmLi7R2yWwjuf+IuE36+C+iYII6hO4ASB5HPIS76zSzxcG7ZccKKU/QVdis6jvXt9NH37ivXY/
 pK+ly1RIrPxaVJHmXeSglFEgJmqEnyv5zn0P+jYD1H35mmWiglBeW2poJCmYVNWJA5Xf1f0LN1b
 lvKFaBq3mtuv9hnA4d5mAgJIAKAnwyVBXEsyAnxJ9T6agfKtUJ1My1EPLRaDgWBXJ6MGd728Vt8
 CQO+Mf7NnweUoIyJ475csSp/NKoBLjhOwtQL
X-Google-Smtp-Source: AGHT+IHQYIrwzbJ45lYEpBkJtYyK+TqNSg24roPGAp52FdGEXjO0dhf8a6kt1chD8qT3RYa6LYxxGw==
X-Received: by 2002:a05:6512:118a:b0:549:6451:7ea0 with SMTP id
 2adb3069b0e04-54990e5d407mr1040493e87.19.1741342608030; 
 Fri, 07 Mar 2025 02:16:48 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5498ae4610fsm438278e87.15.2025.03.07.02.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 02:16:47 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] sandbox: swap bloblist and fdt loading address sequence
Date: Fri,  7 Mar 2025 12:16:28 +0200
Message-ID: <20250307101629.51561-1-clamor95@gmail.com>
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

The existing memory layout places the bloblist at 0xb000 and the fdt at 0x100,
resulting in a 0xaf00 size constraint for the fdt. This constraint has been
reached. Lets modify the layout by moving the bloblist to 0x100. With a
bloblist size limit of 0x400, this allows the fdt to be positioned at 0x500,
thus expanding its permissible size.

Tests passed: https://source.denx.de/u-boot/custodians/u-boot-tegra/-/pipelines/25021

Svyatoslav Ryhel (1):
  sandbox: swap bloblist and fdt loading address sequence

 arch/sandbox/Kconfig         | 2 +-
 common/Kconfig               | 2 +-
 doc/arch/sandbox/sandbox.rst | 4 ++--
 test/lib/kconfig.c           | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.43.0

