Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5500CC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A9E80F12;
	Wed, 26 Feb 2025 17:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gs3Qm5gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CD1810F4; Wed, 26 Feb 2025 17:26:38 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90FC78004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-855a5aa9360so511196639f.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740587194; x=1741191994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qATRWCaqoRLJRDZKdGW6NvcdXsCOE12MWnKcM5P4c9U=;
 b=gs3Qm5gv17oPEUvns965/+X4q76aMhwhAG8oQYRv5YODh90aXdyd6VmD6mCojAbsX0
 Gangt8xJumexdYda6bg7qsPlPBaviqCzCT504Iusi9dUZRqc2ChHtL0DfKKprPB8ko2l
 HLFQG6o6mZr86WXmuCCd+gWW/9q2CGnX/lMYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587194; x=1741191994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qATRWCaqoRLJRDZKdGW6NvcdXsCOE12MWnKcM5P4c9U=;
 b=fFg0ZKf4+3dv61YPFBNk5utBLtpleji7yPU4/AnslZAyk3Ds3IhPF9rdaCB9l1hf4v
 Y2CHtfF6t/cruL0Np4+EJwt9ZaC/LyQWUwb6X9oElngVYr/tY1nZG6iDe5tS80zJ2K/Y
 vOoRG6jbuJ7gjN9IXrU/wDaARm51F2NCGkf8H2T5PZ9lEyEHe1Emii8HV9635+V/EYbe
 wMTw+BxI0381TER3dKDwssWU7agFPVIiq7K6uEuXBxXe79P1OMqTZuaR4rFhOfUhH9EB
 aQgEhPVPyD5CpWKocjokIziKh5JuplPYRzC01wbxw1bhgj0BLlrffhvpDaEmscGVM5a5
 M3Fw==
X-Gm-Message-State: AOJu0YwrWjK12gD4t9Q8N/AxubSLPMYYYAuSr0yY6BZ8yKeC0lFNIgZS
 QdFuZ1izXnNRxGF/xXENZ7V3veZE/jH9oXKQWAWSrpPSdOh0tzz8Qk4ifyWWZTYAy2NzSV0xuoY
 =
X-Gm-Gg: ASbGncsRrhy5ccc8R7QNUlTVym4X3Cerf3uxp4C5rsgVwIgvzLSwNsauhNI6Za+QyHQ
 n7isRnuL8rwxxfyNs0FlTZaOBFpUqnHf5RiujP/dJyCYb/9Nd1S0FLq1RQMlIAalOaHZ6hUp6wB
 G8e6sojJRwimQw3ayObSEEOVapJ4UIQOVgvu8uiUv6DUJHtjFh5gSlSH0KowliCpLq6oJib2Pxy
 7FY9nIanCdIgNNkggAYbiqSR/Wa9Gwsf3KkYYzVOqPqwi6j0RAzFDfUrlgOh6cQlShBa8WC8SaG
 4MYGhr95+nYgBGMvL/++1XviNGPlQ5Qw9j50m2qX+ckYBBGa9zd0cpduFohCFmE=
X-Google-Smtp-Source: AGHT+IGI4K/rbayYisWngFV9devV92t1pOPoTDMaRoYxk1t7Qq4e4AHUdO8sH23uR8LKz3Al6RGP7A==
X-Received: by 2002:a05:6602:29cf:b0:855:cca0:ed1e with SMTP id
 ca18e2360f4ac-856203b281bmr1008680239f.11.1740587193801; 
 Wed, 26 Feb 2025 08:26:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85620a2f9c6sm77857539f.21.2025.02.26.08.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:26:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Janne Grunau <j@jannau.net>,
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/5] Syncing up on skip-at-start
Date: Wed, 26 Feb 2025 09:26:13 -0700
Message-ID: <20250226162621.2681677-1-sjg@chromium.org>
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

This series has the skip-at-start change and a few fixes.

Sadly it also includes a revert for the dm_probe_devices() patch, since
it breaks jerry (RK3288). I will need to investigate way.

It is based on -next and I can send a PR if desired.

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/24835


Changes in v2:
- Add new patch to stop working around skip-at-start on x86

Simon Glass (5):
  Revert "dm: core: Simplify dm_probe_devices()"
  samsung: snow: Use BLOBLIST_FIXED
  binman: Rename Entry.end_4gb
  binman: Honour the skip-at-start property more faithfully
  x86: Stop working around skip-at-start

 arch/x86/cpu/intel_common/intel_opregion.c |  1 +
 arch/x86/lib/fsp2/fsp_init.c               |  3 +-
 common/board_f.c                           |  2 +-
 configs/snow_defconfig                     |  2 +
 drivers/core/root.c                        | 17 +++++---
 tools/binman/binman.rst                    | 47 +++++++++++++---------
 tools/binman/entry.py                      |  5 +--
 tools/binman/etype/fmap.py                 |  4 +-
 tools/binman/etype/section.py              |  8 ++--
 tools/binman/ftest.py                      | 26 ++++++------
 10 files changed, 67 insertions(+), 48 deletions(-)

-- 
2.43.0

