Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC56C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA608643C;
	Wed, 23 Aug 2023 20:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hg/NZYgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FF086443; Wed, 23 Aug 2023 20:48:01 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D5E86434
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7923ae72111so104373639f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816476; x=1693421276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pf5j5Tax6ly5DM5Tk13B+qAdfHyOEUqnLp8jRE+meIw=;
 b=hg/NZYgfMGae036hw5FhgIlbCB+lVCIsxLawBdhIBRHAaRSVJvd0fWpf+J6BPg1kGV
 uAburuGDmBQiZNjj9hJ99f2WBE1wHLj4JlHmnB6rcpXoZZvzrmOE4QjFPp7ZM2PNJ0MX
 tGltx06BsUH8EkhfFhsRfwJKs2bNWmc9n5PTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816476; x=1693421276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pf5j5Tax6ly5DM5Tk13B+qAdfHyOEUqnLp8jRE+meIw=;
 b=X6RGc4ySfBsWOQebklX6b8TLbgPfrqFGa0Ti7H58cAT0cNGewXXKGdKGXYHuFKHMOE
 Q80cMWVxutPq+OWAwUivmiU3KdSSUWgAVNf7JAPMZGylN/wW7yCT3xedez7NsnNQ96jL
 KReRdi1sgfQqqIl5/qszVT/+8SUhLUWkNPm88OXs9PViQiW8aZ/UODHXRwpHmG9AiIZt
 01C0KTF5cYfcPP4ZLjQprUWa9btP0rGkx0t20qLDnnxu+jNNJKXcIvYnVpnN9doUJ97v
 JZZEx2IHH4+O/BAfVi18ttP/qeSgpLXxd8cCBQ5gVDbk2Y7JEW0Awhz9gU/Q2bQjg6kB
 X3cA==
X-Gm-Message-State: AOJu0YyYhpOXR30gGOssqsOGNhmv6Pl1K4Nza9QsaNSH3XZFNTQFmtI4
 4IKygSpIVnpzUCEkFeuqpMsCZjE7adlTl9JcrGg=
X-Google-Smtp-Source: AGHT+IHOTGfZ7QauUahIL40RqsjaQY7RUrhbFr82OnFpar8BuAhv4Bv3Ox8+orPGBttpFENEMIv/pQ==
X-Received: by 2002:a6b:917:0:b0:791:1e87:b47e with SMTP id
 t23-20020a6b0917000000b007911e87b47emr3736339ioi.15.1692816476420; 
 Wed, 23 Aug 2023 11:47:56 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:47:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Suchanek <msuchanek@suse.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 0/8] x86: Fixes for chromebook_link64 and chromebook_samus_tpl
Date: Wed, 23 Aug 2023 12:47:33 -0600
Message-ID: <20230823184746.842091-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

These boards have various problems which prevent them from booting. In
the case of link there was a recent regression with PCI probing added to
SPL. For samus_tpl it needs a few tweaks to get things back up and
running.

This series resolves all known issues.


Simon Glass (8):
  x86: broadwell: Show the memory delay
  x86: Add some log categories
  x86: samus_tpl: Correct text base and alloc sizes
  x86: spl: Change the condition for copying U-Boot to RAM
  x86: broadwell: Avoid initing the CPU twice
  x86: broadwell: Set up MTRRs
  spl: x86: Avoid starting up PCI automatically in SPL
  x86: doc: Update the list of supported Chromebooks

 arch/x86/cpu/broadwell/cpu.c           | 10 +++++-----
 arch/x86/cpu/broadwell/sdram.c         |  2 ++
 arch/x86/cpu/intel_common/mrc.c        | 18 +++++++++++++++++-
 arch/x86/dts/chromebook_samus.dts      |  1 +
 arch/x86/lib/init_helpers.c            |  7 +++----
 arch/x86/lib/spl.c                     |  2 +-
 arch/x86/lib/tpl.c                     |  2 ++
 common/spl/spl.c                       |  2 +-
 configs/chromebook_samus_tpl_defconfig |  4 +++-
 doc/arch/x86.rst                       |  5 +++--
 10 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

