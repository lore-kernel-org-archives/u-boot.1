Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82EAEC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF53086A66;
	Thu,  7 Sep 2023 17:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SDu5RPs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D1C86A40; Thu,  7 Sep 2023 17:58:35 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C0986A26
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-794c7d95ba5so46479539f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102309; x=1694707109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L9yWoJhj9N/voDiAUQZm3cMJgtPtUTz18fG9JYqvVcQ=;
 b=SDu5RPs9gwqQtrjUSZSVFNclONbw33iMoQxPMQpjsfRX93v5fBDrZlpBcTgZVqmiRF
 1d+q1gE0oiKek9wwmbWhay+55I+PIS0CaH4MaGS8mvPPmztV8OaiLwvALskrmXr2Tamf
 AXByzmsNEHn09AmWKoNjVz74zROV09zxP+sU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102309; x=1694707109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L9yWoJhj9N/voDiAUQZm3cMJgtPtUTz18fG9JYqvVcQ=;
 b=O+mFVm+EGxPzinZxbwbbtudACXkjdRuPds+dKWKtMteijyfsKbehYkZFi7a3wMeUVu
 yEyooxtzYe8MxUMc5X9ZQZDgT40PbQgCQAJOKmyTk4+zVVwUHyYleEHA8OqKO86T94qz
 3qfuglZ7P3W7Uuh8SA36QqM2t9HzbBBCFBjOyaB/4qDabILb2NWO04kovB+AsJft2LPQ
 4WqFtsIi9vndiw/joSrnN3WaUdil8gcQHnITUeMZ8rkAbt6wYJALnN9m/i8Xrjr/FF4b
 pqExkmXADwlk3sCRyQQwZtQzr6GI9Nq5Oga8ITyxAT0gAYGTN/W6BaI+RStFg7l6pn3m
 BAoQ==
X-Gm-Message-State: AOJu0YzR+J0J206YRlsHm1/ASWvdXI4IKuPgDaWFdl7VC50FbiPGRu6/
 iBlE5HGkLjT61t99bvUH8u384fLvjJCgUD/mU4A=
X-Google-Smtp-Source: AGHT+IFxNc42MR/TJrIR7MKK216RhoTKnCYxghntia7Ba0WCAxOC/acYudDvTFJXU5t2oqFppDMgZw==
X-Received: by 2002:a6b:ce16:0:b0:783:4bc6:636e with SMTP id
 p22-20020a6bce16000000b007834bc6636emr92492iob.21.1694102309031; 
 Thu, 07 Sep 2023 08:58:29 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 0/9] x86: Fixes for chromebook_link64 and
 chromebook_samus_tpl
Date: Thu,  7 Sep 2023 09:58:12 -0600
Message-ID: <20230907155825.48056-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

For v2, the 'Avoid starting up PCI automatically in SPL' patch has been
replaced with a global_data flag.

Changes in v2:
- Add new patch to allow marking driver model as dead
- Reword commit message for clarity and to fix typo
- Add new patch to mark driver model as dead when disabling CAR

Simon Glass (9):
  dm: core: Allow marking driver model as dead
  x86: broadwell: Show the memory delay
  x86: Add some log categories
  x86: samus_tpl: Correct text base and alloc sizes
  x86: spl: Change the condition for copying U-Boot to RAM
  x86: broadwell: Avoid initing the CPU twice
  x86: broadwell: Set up MTRRs
  x86: dm: Mark driver model as dead when disabling CAR
  x86: doc: Update the list of supported Chromebooks

 arch/x86/cpu/broadwell/cpu.c           | 10 +++++-----
 arch/x86/cpu/broadwell/sdram.c         |  2 ++
 arch/x86/cpu/intel_common/mrc.c        | 18 +++++++++++++++++-
 arch/x86/dts/chromebook_samus.dts      |  1 +
 arch/x86/lib/init_helpers.c            |  7 +++----
 arch/x86/lib/spl.c                     |  5 ++++-
 arch/x86/lib/tpl.c                     |  2 ++
 common/spl/spl.c                       |  2 +-
 configs/chromebook_samus_tpl_defconfig |  4 +++-
 doc/arch/x86.rst                       |  5 +++--
 include/asm-generic/global_data.h      |  5 +++++
 11 files changed, 46 insertions(+), 15 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

