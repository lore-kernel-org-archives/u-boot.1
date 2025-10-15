Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BF5CCD19D
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1991583303;
	Wed, 15 Oct 2025 17:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C4q/NwiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B438323A; Wed, 15 Oct 2025 17:44:43 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B1F800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-57bd482dfd2so6735700e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543077; x=1761147877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cH8FBPPa6mID9+KpNYPgwerhLluxAZ3N4SsGcHlfzGM=;
 b=C4q/NwiIUZRgo0xyJerhhBliLIcJJ0K89EdGaNSzWV9rHzpzBZf/Yy+S9VcQgvLOpo
 I5ENIl/RWbC62UFXXQ9R53lp/aaFLmaFvlDeByQUueJviETvHak+1DjsRoD/3ApW0hrn
 obB0yg5QCq5hO5q3iPFfIK88ThIBj9UhRTuzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543077; x=1761147877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cH8FBPPa6mID9+KpNYPgwerhLluxAZ3N4SsGcHlfzGM=;
 b=iX5N6MKhgiR+KKSepfWU2bu7doINOQxEuhjsI22hsGBWcF+O6IlbvTwDKtcPqLsrKB
 hfz0LvxT5t+2v/9b3U+ZeNgtANTwrpUk3/2xBAhJLMRzWQkVhs7QI64ppwlMT8fRbyNh
 Dp5+KdrGN1zoq1jQp0UEap+x4oNNpC/BeFMGc2uHEJYazRWgCaysNuLHppZIOAa3/B5I
 EkThs9MHEejN6QXSDO1NW6e7A4v7T90xCx0jOcpPB+YoagOMaawTUu+erl1ewOd83Aic
 Np3ezf6s33UnOZkbCs+KY6RsQQhyjq2G9EvMDekROKLFRTq2nhSa8Xo9WtU6KUgKYzy+
 hQNA==
X-Gm-Message-State: AOJu0YxPoTo0lX9XTa2azbenzYtZ1bSoUzyHms4hYHhDjLfKmuW8EvYN
 CqO80kqnsfBbG29eH3bZomWMgZwGOGgLdCEzGo0lwmXvxXgX4xOAa+Tc2FIWeNLFwEUndBDoUPL
 RRCaybykfgt8=
X-Gm-Gg: ASbGncuWGKGcxoOHfJtXoi5093gZLTRxwlLt8Gs+qYWa+jPZ3Va+0DYYPDYkzh3NWbg
 AbGrzxXJv8NqgROq2bvuqzdWfa8FJW5LlEKn4uqzLGQglxFW8Z/hk2zs2S05kYriVPR5a2XpabN
 kihjB3tlj0dn4DWDdLp8upDGWIPO5FdKCYvgMK1YfmDnjKzwSIpk2mZMe/2p/MhJp+gVCkau09v
 l8CoqU7Sk+3dO+VfJkkUci1j8LETGYcVIsevDkzzVTH4sRS9WPFrRd9p5+Wlp13LRgujgvYskSn
 /ee8Ns+Nv23l5Xvy1fVleRl0lg/sHa0Lh7FinmAg4N6eaKBC3DUZJGiID2fpJE2A37a82vfwc9V
 nS2I/wWcAEzjMslRvkArsUKjlreSspy1ekL1IwnMRmTTM/Dyl
X-Google-Smtp-Source: AGHT+IGAaeWWPy8XSCieYpdlgIr7Abl2xoUY7HjpDxwKwbi0t7y0bpt964UqbyjTvX+dsPpzwKWpOw==
X-Received: by 2002:a05:6512:3e1d:b0:571:86bc:423b with SMTP id
 2adb3069b0e04-5906d9e8a5fmr8604527e87.44.1760543076954; 
 Wed, 15 Oct 2025 08:44:36 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:44:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 00/11] boot: Support priority for global bootmeths
Date: Wed, 15 Oct 2025 16:44:03 +0100
Message-ID: <20251015154423.908468-1-sjg@chromium.org>
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

At present global bootmeths always run first, before all other
bootmeths. Optimisations in the code take advantage of this, putting
them at the end, so they can be used once and then forgotten.

In some cases it is useful to run global bootmeths later in the boot.
For example, the EFI-bootmgr bootmeth may itself scan devices and the
network, so running it first can hold up the boot significantly for
boards not actually relying on EFI-bootmgr to boot.

This series introduces a new field in global bootmeths which indicates
the priority, using the same scheme as is used with bootdev hunters.
Thus it is possible to insert the EFI-bootmgr bootmeth just before the
hunter for network bootdevs is invoked.

Despite the simplicity of the concept and the relatively small series,
this is a fairly significant enhancement. It is also quite tricky to
implement, largely due to the way the original code was written, with
global bootmeths being a small, size-optimised add-on to the original
bootstd implementation.

For now we only allow each global bootmeth to run at most once, but this
implementation is written in a way that we could relax that if needed.
Then the bootmeth itself could decide whether to run at any particular
point in the bootflow iteration.

Size growth is about 390 bytes on Thumb2 (e.g. firefly-rk3288) if
CONFIG_BOOTMETH_GLOBAL is enabled, which it normally is. With that
disabled (which saves about 4K on the same platform), there is no
growth.

Changes in v4:
- Reword the commit message as Tom suggested
- Drop call to bootflow_show()
- Rebase on top of -master

Changes in v3:
- Pull doc changes into this patch

Changes in v2:
- Add a bit more detail suggested by Heinrich
- Update commit message to indicate the bootmeth will always run
- Document how the priority was chosen

Simon Glass (11):
  boot: Try all bootmeths on the final partition
  boot: Add a new test for global bootmeths
  boot: Update first_glob_method when dropping a bootmeth
  boot: Add a flag for whether there are global bootmeths
  boot: Keep track of which bootmeths have been used
  boot: Support rescanning the global bootmeths
  boot: Only run global bootmeths once each
  boot: Implement a priority for global bootmeths
  boot: Don't change the method count after global bootmeths
  boot: Run global bootmeths after all bootdevs are exhausted
  boot: Run the EFI bootmgr just before network devices

 boot/bootflow.c                  | 181 ++++++++++++++++++++++++++++---
 boot/bootmeth-uclass.c           |  11 ++
 boot/bootmeth_efi_mgr.c          |   9 ++
 doc/develop/bootstd/overview.rst |  40 ++++++-
 include/bootflow.h               |  19 +++-
 include/bootmeth.h               |   4 +
 test/boot/bootflow.c             |  72 +++++++++++-
 7 files changed, 307 insertions(+), 29 deletions(-)

-- 
2.43.0

base-commit: 996ded5463fd48497b6aa904a5647c2533d73ab3
branch: globa-us4
