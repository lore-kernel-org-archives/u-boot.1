Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AB6E7718A
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E2980283;
	Wed, 18 Dec 2024 16:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mX+ZeIks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46611802B4; Wed, 18 Dec 2024 16:54:21 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28F28022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862b364538so556580f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537258; x=1735142058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Eiu7YI2wQw0BiUs4Yelr/KiFGNsOgw725BMzy3ewQo=;
 b=mX+ZeIksTgjQD8SJOOLz1NTEvF2jn1D3vB84VotVgBCEfdO7vb6GXSY65yZ99QDxUF
 qeLwzAlRZVEW9OGeSjvfxscxV05JiBUWGshNNfNDyHRYFNp+cJtV+4CkgB4U2zavt9Vd
 +dcshO1iTIiVU/BZYPGyiKNJ0dPiWLI2tZFc6ZH/o0cGI/+e3CrIABBShbIDe8r1qAhF
 97EAi81knO7GcuoPAWxYhM/DeKPCeYvUkcHsySPrNnZRyUz0G4b/LhEfS/pn//ypCrS3
 sYfvVMuBAuk1zN94nse7gTeg8jcHsdQD6c/Coegx6sMjN5U8dePrRVmiMIxQRQcYBgTa
 wplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537258; x=1735142058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Eiu7YI2wQw0BiUs4Yelr/KiFGNsOgw725BMzy3ewQo=;
 b=sAxCqVNDcvIEBsEJjtuTTtGfvUzyrOQiah6Lt2P8CRasHp9YEEUZ/AnIDWnXg6jVxd
 M9wLje5H1R+wohZn/shQI04RVQQ7EsI3kQQDN9icJH2smy7mHamgxCLfVT95rhusYO49
 28qbyQfrGyZfuE3GvDXEgVD4pVpwM3wBxzRlVVD+970wMO6FN9JZWu6HI2r0JkodfQsq
 k8Ry/MCrHCUS6xrY5i6GUk3aciYhZk1bbJ8p9k1YyiHaqnF/rzW80nd7k7/WcsenoGxt
 ZSTXA+I6qONI6rkTDbfYqK+41OROWZF7p31fuaBIIUP46XTyu7aKJ2t5lfukKGCZY1U1
 wKXg==
X-Gm-Message-State: AOJu0YwW0RCSRZ/VwrXYfjly9fzEmtKx0NwlI54kXeqBi+Wqva8f36DC
 wtkQhDC2DIRY4rmXkxhD660ptuk9UQsmhGFmLVZzws8f3N1zxVNxKlnFqjZXO4CJbSjFTtT1mPh
 mc/A=
X-Gm-Gg: ASbGncuv3sJE5YEiBfCkUH858yodd7vzfC9GRT1MTz+SyL+UCtKRsGlRpbPa8Gc+jWW
 fb3WqRMAW3Lt9x5zx/YRXQ8NhTpT+4LtR86ie090dukPqYujeQ4JQC40K/M3TlabUXXwtu1/ZV6
 0iO7COBbCVHkd61tyGSfCPNTNIOQXES40Y/5838tqo5KvJhjhvz5gdTMhS0Ynz6M7ULeEgrebiy
 Vc/CSO/7s93gdD/krGdyIwMYujW8jlnvCbe5UQu+uQCle5hpmqI9oU9yakp2brlcA==
X-Google-Smtp-Source: AGHT+IEB93EaGcyiJdk7V4d1wzDISc4xOiy4BWnEp8u/owaiCgqPNYDVb47nYY+szZXu02EP+Mq9+Q==
X-Received: by 2002:adf:a113:0:b0:386:42b1:d7e4 with SMTP id
 ffacd0b85a97d-388db275325mr5956143f8f.19.1734537258211; 
 Wed, 18 Dec 2024 07:54:18 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afc125sm25181705e9.6.2024.12.18.07.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:54:17 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 0/5] Static initcalls
Date: Wed, 18 Dec 2024 16:53:53 +0100
Message-ID: <cover.1734537135.git.jerome.forissier@linaro.org>
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

This series replaces the dynamic initcalls (with function pointers) with
static calls, and gets rid of initcall_run_list(), init_sequence_f,
init_sequence_f_r and init_sequence_r. This makes the code simpler and the
binary slighlty smaller: -2507 bytes/-0.23 % with LTO enabled and -1232
bytes/-0.11 % with LTO disabled (xilinx_zynqmp_kria_defconfig).

Execution time doesn't seem to change noticeably. There is no impact on
the SPL.

Changes in v2:
- INTICALL() and INITCALL_EVT() now call hang() immediately on error 
- Fixed typo: s/intcall_run_f_r/initcall_run_f_r/

Jerome Forissier (4):
  board_init_f(): use static calls
  board_init_f_r(): use static calls
  board_init_r(): use static calls
  initcall: remove initcall_run_list()

Michal Simek (1):
  common: board: Simplify array with function pointers with
    CONFIG_IS_ENABLED

 common/board_f.c            | 210 ++++++++++++++-----------------
 common/board_r.c            | 241 ++++++++++++++----------------------
 include/initcall.h          |  45 +++----
 lib/Makefile                |   1 -
 lib/initcall.c              | 102 ---------------
 test/py/tests/test_trace.py |   8 +-
 6 files changed, 210 insertions(+), 397 deletions(-)
 delete mode 100644 lib/initcall.c

-- 
2.43.0

