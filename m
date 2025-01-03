Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF531E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 11:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1113C802EF;
	Fri,  3 Jan 2025 12:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tD/HpnhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34998036D; Fri,  3 Jan 2025 12:13:38 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4086780196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 12:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso80163765e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735902815; x=1736507615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Bh+Oi3+/MfMXp90xA23mSEyYFYf9RwnI3vNi5WYaFw=;
 b=tD/HpnhLGWBiQGUMuZ+U82m+BVATwdAD+uZlfsX4DtsWt7FrtMxm/hLbHsy1EznZYZ
 kshfGXbO5wxVVv2pwtr8T08Tfr4NKGs2OrmCPuSWR2Jo9dADrflFmgN1GppRj1PWLGUL
 uIWQvCNed3cqH1URlaZVvJkeYaYcgzNDh0PXkmzC7ehi97DAQN0k7ViNs6B9VLWOFvGe
 8MmVFg3dIBuMEQKtwoBBRotz7AlANEveFYw8tSa9QJWE6EZ0couANakOqKHc1F8D80Qh
 u1wb82EiEEc0CxX89AvLIAU6xHPCeUkxHeH+8EVddvqW9DPmRUvbngK02QfxXEZ7F9YO
 3p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735902815; x=1736507615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Bh+Oi3+/MfMXp90xA23mSEyYFYf9RwnI3vNi5WYaFw=;
 b=dNnWfW9b2Awx37qAwLYzGjixALISy+iRnCMYweAPh/BVZHlW0ovH/zhC5FOJ9fvtmN
 ILrDN8V1gyQW+yrgL0I3iQsHorzf0PhoK+u+lNosojaSLMh2Cg/jexnAUN5oRdjaYIvy
 86CXs65BNhgSWaXvFUMiYBfUcsndLxtJYMK53LJj/PgcMGB3PD+abcVrimXBFMQTmaC8
 bNrg84WYef22JqKSH/q1H9h/5txC/bbNOBeow4zzLWtCtGiL1nwAhPrSOZfsyK3BqyPS
 mKXZRWOj2HnCTGuKbong/xZi2IIYZ01KHBFjXnA4c12c+g9S/bSQnqxFSFBsr7rdmBkG
 w3/A==
X-Gm-Message-State: AOJu0YyTIdcg5eRZC0Dt5ldOS6Ce1vhMcqA5386NskK9Tyk3Esn5NJFE
 kPmqeDPSLLdTM+wbX3zkThDr7YdtNiLm/WiUWlxFqSlsEIbH2NuUlNtb5Cu1kDchJYwo4sHFzoj
 nHlc=
X-Gm-Gg: ASbGncvh0QYHisF2IG8crYBwf8vn8wolsNs9DTP91WdsEemDk/Xs/rx3kgN5h44HHfy
 bMhUKb43pu5lq7HBWu/TAFGMT8CZz6nX72jIM4fZKSghUxHkstIntcDOZGLH2cMHdlxKZuwm+R2
 McEODZ1V+3pbPi/ow0k/xa3VI1RiVCM72Ui9SypiwHhlOvcAFG99Qd8Vw56Z7qWZigcvWS7KWbh
 wwTOS58kH5tN300jDlk/04rXhfpEhcDbdpIAI7kAJx0po3xNtXyuBT8i5P7t1+1Xg==
X-Google-Smtp-Source: AGHT+IEGC2SnOBkXG3aKXRZ/Oh4cM3eHodxCaE0QjGgYEnxCoa5JdhyjrVzAxm3uTpa9/4NI0jN+vw==
X-Received: by 2002:a05:600c:3505:b0:434:fafe:edb with SMTP id
 5b1f17b1804b1-43668b5f326mr377767045e9.24.1735902815388; 
 Fri, 03 Jan 2025 03:13:35 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656a0b361sm513138075e9.0.2025.01.03.03.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 03:13:34 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v3 0/5] Static initcalls
Date: Fri,  3 Jan 2025 12:13:12 +0100
Message-ID: <cover.1735896540.git.jerome.forissier@linaro.org>
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
binary slighlty smaller: -2217 bytes/-0.21 % with LTO enabled and -510
bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).

Execution time doesn't seem to change noticeably. There is no impact on
the SPL.

Changes in v3:
- Use printf() rather than debug() to report initcall failures
(Quentin S.)
- initcall_run_f(): replace one erroneous call to WATCHDOG_INIT() with
WATCHDOG_RESET() (Ilias A.)
- Fix relocate_code() in arch/sh/lib/board.c to address CI failures with
r2dplus (https://lists.denx.de/pipermail/u-boot/2025-January/576213.html)
(Tom R.)
- Add comments to initcall_run_f() and initcall_run_r() (Simon G.)

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

 arch/sh/lib/board.c         |   9 +-
 common/board_f.c            | 214 ++++++++++++++-----------------
 common/board_r.c            | 245 ++++++++++++++----------------------
 include/initcall.h          |  45 +++----
 lib/Makefile                |   1 -
 lib/initcall.c              | 102 ---------------
 test/py/tests/test_trace.py |   8 +-
 7 files changed, 220 insertions(+), 404 deletions(-)
 delete mode 100644 lib/initcall.c

-- 
2.43.0

