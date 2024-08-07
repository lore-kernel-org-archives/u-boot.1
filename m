Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13414C52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 12:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73ADA88CE1;
	Wed,  7 Aug 2024 14:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k4xDiol9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC16488CC0; Wed,  7 Aug 2024 14:14:50 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3461888D9
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 14:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a61386so2622710a12.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723032888; x=1723637688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XtBdan1UAhIgqxh52F4EbCx2ZDqi2LLw2y8IDQBqr+E=;
 b=k4xDiol9yNv2qJyBDzNLi9DPSrHa2KTNOEcYoAbtLJngfLBrKxSjwn0Dhj4i2PTH9P
 FgRa0dswCS5zmgQunNQR9uY00XTIIPYekNEcOY/pCekmoETWyTHRDMwqz94mQTcIyrEG
 Gj1BqGb8j9kaplKkqbv8LElITQpKBrmr7HbVp/1A23hqMYEN0WhaT+wV8EeElYt2Bb+V
 iczVcxb3PM6b6gBduAPWRAUvuv/kXKoddRR+AQebY2AvAPUtYoroLlIole1hruJqrJXU
 yQCFr62rRUhQrXbTSABXormHR6As83mRlUBtOB8fNxGZ5u0aie2YKQ6SGOy3lcPt8MiY
 aYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723032888; x=1723637688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XtBdan1UAhIgqxh52F4EbCx2ZDqi2LLw2y8IDQBqr+E=;
 b=pHX0eAcKf6hLgvMHLcW+m4RJOYpYJhwFbJiObQkLrImK9jyFnMx7WksvmXdgx+fGgN
 38FqnIUfvbkCQxt9yXaOCELgWUlLOOOPIxPE6Scwlom+jFyf9nbl23LyVK1eGBOo5AbD
 U7KSTNF1UWRcIoLl44RkdnFS6ZNQklBqqr+D4eUSmedtBaQGO7f371G87RjWNB2rlJxj
 y6j04yjZu+BD9XsWUHUr/hUDcX51k+rcdr6P6pAxXt2fYXArFROGyWBx7NZuyq/kWNfV
 OLWigmIKQppJuvZ/opZkeadONP3kcywVI7yiasmXlpxc2RyDi9GWx1xUo2HldvIp8C40
 CJNg==
X-Gm-Message-State: AOJu0YzDW6BAR1C8t9fnMYy3r8SQJb6qyAf25W8xgsGBaOov1nBfOoNl
 u3Ib9MR1KZlqjOiCKO2UdqQOe735Fw5lJ9k2QUocUUmJbnv0yz5R
X-Google-Smtp-Source: AGHT+IHwdVTR5EYCoIoywY8WCq3HBEY/DtXXVzDZqHSyYEoMaGycgKgLzNjlieZUWYX0OhMrUAs5Qw==
X-Received: by 2002:a17:907:2daa:b0:a7a:b620:aa2f with SMTP id
 a640c23a62f3a-a7dc4e44184mr1203411766b.15.1723032888119; 
 Wed, 07 Aug 2024 05:14:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d427b4sm636207966b.130.2024.08.07.05.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 05:14:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] board: tegra: convert boards to text env
Date: Wed,  7 Aug 2024 15:14:33 +0300
Message-ID: <20240807121434.11761-1-clamor95@gmail.com>
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

Move env stuff into dedicated files in boards (1st stage).

U-Boot CI passed, boards I own work fine, tests are welcomed.

---
Changes from v1
- parameterized self-update script
- complete stdboot convertion of Apalis TK1
---

Svyatoslav Ryhel (1):
  board: tegra: convert boards to text env

 board/asus/grouper/grouper.env                | 15 +++
 .../asus/transformer-t20/transformer-t20.env  | 17 ++++
 .../transformer-t30/configs/tf600t.config     |  1 +
 board/asus/transformer-t30/tf600t.env         | 16 ++++
 .../asus/transformer-t30/transformer-t30.env  | 17 ++++
 board/htc/endeavoru/endeavoru.env             | 13 +++
 .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
 board/lg/x3-t30/configs/p880.config           |  1 +
 board/lg/x3-t30/configs/p895.config           |  1 +
 board/lg/x3-t30/p880.env                      | 15 +++
 board/lg/x3-t30/p895.env                      | 13 +++
 board/microsoft/surface-rt/surface-rt.env     | 14 +++
 board/nvidia/cardhu/cardhu.env                |  2 +
 board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
 board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
 board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
 board/toradex/apalis_t30/apalis_t30.env       |  9 ++
 board/toradex/colibri_t20/colibri_t20.env     |  3 +
 board/toradex/colibri_t30/colibri_t30.env     |  9 ++
 board/wexler/qc750/qc750.env                  | 15 +++
 configs/apalis-tk1_defconfig                  |  3 +-
 configs/apalis_t30_defconfig                  |  1 +
 configs/cardhu_defconfig                      |  1 +
 configs/colibri_t20_defconfig                 |  1 +
 configs/colibri_t30_defconfig                 |  1 +
 configs/endeavoru_defconfig                   |  1 +
 configs/grouper_common_defconfig              |  1 +
 configs/ideapad-yoga-11_defconfig             |  1 +
 configs/p2771-0000-000_defconfig              |  1 +
 configs/p3450-0000_defconfig                  |  1 +
 configs/qc750_defconfig                       |  1 +
 configs/surface-rt_defconfig                  |  1 +
 configs/transformer_t20_defconfig             |  1 +
 configs/transformer_t30_defconfig             |  1 +
 include/configs/apalis-tk1.h                  | 58 ------------
 include/configs/apalis_t30.h                  | 12 ---
 include/configs/cardhu.h                      |  4 -
 include/configs/colibri_t20.h                 | 11 ---
 include/configs/colibri_t30.h                 | 12 ---
 include/configs/endeavoru.h                   | 43 ---------
 include/configs/grouper.h                     | 45 ---------
 include/configs/ideapad-yoga-11.h             | 58 ------------
 include/configs/p2771-0000.h                  | 20 ----
 include/configs/p3450-0000.h                  | 13 ---
 include/configs/qc750.h                       | 42 ---------
 include/configs/surface-rt.h                  | 18 ----
 include/configs/transformer-common.h          | 91 -------------------
 include/configs/transformer-t20.h             |  4 +-
 include/configs/transformer-t30.h             |  6 +-
 include/configs/x3-t30.h                      | 44 ---------
 include/env/nvidia/prod_upd.env               | 60 ++++++++++++
 51 files changed, 332 insertions(+), 476 deletions(-)
 create mode 100644 board/asus/grouper/grouper.env
 create mode 100644 board/asus/transformer-t20/transformer-t20.env
 create mode 100644 board/asus/transformer-t30/tf600t.env
 create mode 100644 board/asus/transformer-t30/transformer-t30.env
 create mode 100644 board/htc/endeavoru/endeavoru.env
 create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
 create mode 100644 board/lg/x3-t30/p880.env
 create mode 100644 board/lg/x3-t30/p895.env
 create mode 100644 board/microsoft/surface-rt/surface-rt.env
 create mode 100644 board/nvidia/cardhu/cardhu.env
 create mode 100644 board/nvidia/p2771-0000/p2771-0000.env
 create mode 100644 board/nvidia/p3450-0000/p3450-0000.env
 create mode 100644 board/toradex/apalis-tk1/apalis_tk1.env
 create mode 100644 board/toradex/apalis_t30/apalis_t30.env
 create mode 100644 board/toradex/colibri_t20/colibri_t20.env
 create mode 100644 board/toradex/colibri_t30/colibri_t30.env
 create mode 100644 board/wexler/qc750/qc750.env
 delete mode 100644 include/configs/transformer-common.h
 create mode 100644 include/env/nvidia/prod_upd.env

-- 
2.43.0

