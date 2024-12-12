Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B091E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFFA2801DB;
	Thu, 12 Dec 2024 11:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZHXAtEwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D8680212; Thu, 12 Dec 2024 11:21:30 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD798012C
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so544854a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998888; x=1734603688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xy7Y1iIxF48hXxiLrT1fupj+3imL266859yXvw4fHFE=;
 b=ZHXAtEwkXwhJMN/7OBinbyaGO3pOgdJm2oLsiyPmmnBtaavi6eOjJHb+vvRmKIHYOY
 qNcsC8rATbonsMIsh2YbU5WYtSx0LsMhD/BaumUskfzGVSKkubf0ZdLZcu7Xg2ogE9uU
 i7CqlmTa6O9HerR5JBHuQzwY3ZdkhAOI0qDulpSEytfSHHoAYwy9xm0ik9WA1lASGKl7
 pXZHqZBnF4NaJh/Trofs75mhV8dPrngzQqKnOUa3mE1u+xxEkssQwHFYAyDJQ7L4ysVT
 FSyqoQ22AarzkE/ywR1D0i/KVVy5Z2CWaYoJRipxIFpMW06nNAX9MgzkPnwaCQlGAECC
 gSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998888; x=1734603688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xy7Y1iIxF48hXxiLrT1fupj+3imL266859yXvw4fHFE=;
 b=GWxPAVpj19ehE4i7cY6FtJfJCv67SqYUG3n4uJIDqxvwuTIIAyWeQv8xgPyHmO58kU
 qcw08r+oxfKr28n2L7vZ1vpNtBPqLgjXJIb+d0CgL6TgvRjeKQztmspt5+QeJCQ/zkGk
 8QCQMhaiJqLJ6Zd4kP9lLnxLwpX7eRnJEv2CSLsijQkHoQ1FyX+o5fNeSShBvjGmHHFz
 IP+UJSevCDfD62a2YQjkFKvYYJeyk8UwvpNQJOPYAz0LrcqB3ck6TMBGRvtXXU+Fnonz
 I9szymxSPRd1IaiGd/cbdv8ANLXRvWjBkXUPkbsDRHJkaoI/Pl8E6Oh1WIihbKFFxZ37
 sYGQ==
X-Gm-Message-State: AOJu0Yw431lU9bqOGxFUJDdAxSfF/DpSrTJicXs2Wktt5NBp3KqHKb/b
 vTIFVE6wrKGfQ+fuZrQqJeJEoEB//M814Fi33R5aSEnBlK/EBUDT
X-Gm-Gg: ASbGncsL/6V1P2WfN8gf+ZMc0FKZNfqJGwO1qmerE8+q43f1xGW9059zLAeXbBaOQkq
 a1x2BLd4piAycvFDPbjDnRwJ5Kz2Lp9vH6Am9cmCw3bahwUcofaX35KNGD0ki7sOTfz00A/Xyab
 kW7/XW+93zOBLPqFXYM8pzQzB8tX2xBwaIc2tfBGtX0e6F6G6s4baukoNJE5mNZUYF5EiDoO3a8
 CPJ3/wONEKYfjFFGG/x2brkQJR6pWdBQAxRW8Tl7T2kG3QH
X-Google-Smtp-Source: AGHT+IHzddediVCezXJ6BMBWHlZ8vQ29Z6wHpict8P993m8Tbm4hFOJl/PhIQQ8OtqSlmsb/dxljmg==
X-Received: by 2002:a05:6402:34d6:b0:5d3:cf89:bd3e with SMTP id
 4fb4d7f45d1cf-5d4fa1b2936mr1115018a12.30.1733998887831; 
 Thu, 12 Dec 2024 02:21:27 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 00/12] Tegra DSI/DC code refinement
Date: Thu, 12 Dec 2024 12:21:07 +0200
Message-ID: <20241212102119.6466-1-clamor95@gmail.com>
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

- Use DM based clock API
- Switch to upstream style DSI panel bindings
- improve ganged mode support
- remove hardcoded Tegra 2 parts

Svyatoslav Ryhel (12):
  video: tegra20: dc: switch to newer clk API
  video: tegra20: dc: remove hardcoded Tegra 2 specific parts
  video: tegra20: dc: remove excessive headers
  video: tegra20: dc: improve code quality
  video: tegra20: dsi: check for panels among child nodes
  video: tegra20: dsi: switch to newer clk API
  video: tegra20: dsi: move ganged DSI configuration before master panel
    enable
  video: tegra20: dsi: make SOL delay calculation mode independent
  video: tegra20: dsi: calculate packet parameters for video mode
  video: tegra20: dsi: enable DC only if it is available
  video: panel: lq101r1sx01: remove unnecessary setup
  ARM: tegra: endeavoru: adjust panel node

 arch/arm/dts/tegra30-htc-endeavoru.dts        |  23 ++-
 .../include/asm/arch-tegra20/clock-tables.h   |   2 +
 drivers/video/sharp-lq101r1sx01.c             |  28 ++--
 drivers/video/tegra20/tegra-dc.c              | 104 ++++++-------
 drivers/video/tegra20/tegra-dsi.c             | 146 ++++++++++++------
 5 files changed, 170 insertions(+), 133 deletions(-)

-- 
2.43.0

