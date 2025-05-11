Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0A1C3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66C882998;
	Sun, 11 May 2025 16:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="miy3cz6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C750829A0; Sun, 11 May 2025 16:18:37 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BB3828BC
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5fca2805ca4so3603713a12.1
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973114; x=1747577914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xxgSGQ3ime/XgLJNo/31CdvWhGYaEzvFtEQjkNjjKkY=;
 b=miy3cz6EVvaAIbNSrKH73GHqeUGlWuWmKnzcGOjUX3vjiLt8fl9MC3umCbhvG621Ek
 Xi9CcrwhSxhPv1bFuwrcBINqL0SI8zeqUGsGxufM+645Dr3/CxLikfBM2rxVZ7mRvIy3
 XwnOoU6zBaRq7wqMn36eimJWvkytWp6ELGwyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973114; x=1747577914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xxgSGQ3ime/XgLJNo/31CdvWhGYaEzvFtEQjkNjjKkY=;
 b=PPlndjzMElwtGPRTIS2RrUuG6j9tYSVbkj78eGWXcuWUBfv32ZoHyqW/BWDFxwYFD3
 3xyLgU8iYsAZvukUjvgGHj2/0UicnyZZuhOB9VRGCsD4pN4z0B1KueTSokkChD0PpDc3
 G8Mi2nir1uzWqCquwXgb2Xr9rmzuiKKytqcqFF8jv75ragJvswLEJHQhv+JLsa/bjvWh
 eKMUTKV3eNQ27CK1ro1BkkfoqId8x3eaWBXdlVx+6VZOl/kI+tn60w/VYwnbGO2HhekT
 Q+WNsCmofaJrOOqI1EUala/n1GJNQmWg30tTK9GwTdQZakxD0vLan/RS6gJmbAagg0TE
 xdnQ==
X-Gm-Message-State: AOJu0YzvwCNF6aQOf8u+yy1uZmPrWma5tOwNzjo/tuNX8ELEuuI71mce
 95rlS6txwdOaJxX/YzR4o3qGsWmE7XdwmpXeLeSBoHx3PDD4mq1SCP0HRk8PlOUoNTVVj++yraz
 lzaE6zrxAWQ==
X-Gm-Gg: ASbGnctS86GNU5PcEv9rjrk3JYNzbkcD97u+tzeN7YtUMDYHCIy+by/ywkDZLYQZrKI
 Q8JeLX/3bhaxvEbPdvuaTQJof3uMf3mVY+Xzlf6chglgLwGNIiloScM8JTUZPlYX3DDVICt8kZw
 Z0qDJnDQewaTM5UNkcrNxi97vS613Cuw2oYs435pY8cb//IQTepFA6jXkPu8LFCm07dByY52hBf
 VmSezFs4cKaQdVt9Vo5TQEa6OEuCvz0rP7qhFeJa839Xjw9pxIBdTcUoJ1GbHyrKtTAYJLWiXkW
 g/OPpkKRmCoSpjYD7DgyzPJLPoxM+QZZxU5NUvKRZuo0iMk=
X-Google-Smtp-Source: AGHT+IFMoADGxc0L43FOSIA9rM+m+o6k05iONulxflbkTznv8sngWXxVJngY4U8B9RL4ibPbIrbg/Q==
X-Received: by 2002:a17:907:c243:b0:ad2:5198:d711 with SMTP id
 a640c23a62f3a-ad25198d88amr117802966b.10.1746973113698; 
 Sun, 11 May 2025 07:18:33 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad21985858asm477789266b.176.2025.05.11.07.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 07:18:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Richard Weinberger <richard@nod.at>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/6] script: Improve the QEMU scripts to Python
Date: Sun, 11 May 2025 16:18:15 +0200
Message-ID: <20250511141828.2367318-1-sjg@chromium.org>
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

This series updates the two QEMU scripts available in U-Boot:

- Converts build-qemu to Python
- Converts build-efi to avoid sudo (unless SCT is used)
- Introduces a proper settings file shared between both scripts

It also includes a few documentation updates.

The next step is to get these scripts running in CI.


Simon Glass (6):
  test: Update fs_helper to support passing in the image
  scripts: Rename build-efi.py to drop the file extension
  scripts: Convert the build-efi script to avoid sudo
  scripts: Create a common settings file for QEMU scripts
  u_boot_pylib: Support a fatal level in tout
  scripts: Convert the build-qemu script to Python

 MAINTAINERS                         |   5 +-
 doc/board/emulation/script.rst      |  78 +++++-
 doc/develop/uefi/u-boot_on_efi.rst  |   7 +-
 scripts/{build-efi.py => build-efi} | 159 ++---------
 scripts/build-qemu                  | 414 ++++++++++++++++++++++++++++
 scripts/build-qemu.sh               | 211 --------------
 scripts/build_helper.py             | 126 +++++++++
 test/py/tests/fs_helper.py          |  18 +-
 tools/binman/control.py             |   6 +-
 tools/u_boot_pylib/tout.py          |  22 +-
 10 files changed, 660 insertions(+), 386 deletions(-)
 rename scripts/{build-efi.py => build-efi} (52%)
 create mode 100755 scripts/build-qemu
 delete mode 100755 scripts/build-qemu.sh
 create mode 100644 scripts/build_helper.py

-- 
2.43.0

base-commit: c5a631df96de7421d10ee03dceed1b79db213026
branch: script
