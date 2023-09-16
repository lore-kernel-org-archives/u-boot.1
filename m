Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCC6CD37B7
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 08:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C873886290;
	Sat, 16 Sep 2023 10:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y9WlhhyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E73862B6; Sat, 16 Sep 2023 10:22:54 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C863F8609B
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 10:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so2500828f8f.2
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694852572; x=1695457372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIbbyzdJenrsLHklP4jKX5BEIHsmSdJxRTtBreQWcbk=;
 b=Y9WlhhyFlKqG+kKzIjzs2hrUWXPnAR2jdUyTxtmbftX/jjO+DAEa6uF5oBupQ49V36
 fVhoN3/cWjO8C50h2CbgH3oSCYjM12ANRMK7RSbOCk6CXlS7aj/bp24oXP6S84aHy0Z+
 v5JS/7uxBCBKOq9UdZnnA7sV9dD2gN35Dt7sjNhkmIw9XuVAApN8pBersppfXDMnrZUR
 CTvmhFik/Ge7ncUoGVc+cSoL0PLJoJ8EuR/84AmJeIY95F9Cnpo8SbxRPpaNyUjWIBA7
 +qQtKiN0KIaJvx8wEkT4yaywY7gU8+5LfOU74ynyGeg3uE2HU5rbcwwwQ4dbkkbK+Uxc
 EXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694852572; x=1695457372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIbbyzdJenrsLHklP4jKX5BEIHsmSdJxRTtBreQWcbk=;
 b=XC7wJRFe9lhL1Nn+6a+bRnImWSe5oka3t2LTYfyzckEczG6eKFgAQ/RMfdUI01JGIX
 SApJ5ReXVlNx5ynt/xQO0aETRjcP4xfdeg75nlhJuyBFr1AP8dsS0w7Uk2kvMSKD/eBE
 9IbemozFDgEhnlma3FVwEwPkQuihhZTcRqr7IK/8BjA4FN2Gn18Ge4/eGgDVL/q44IlZ
 DDzKSw+Vvk/IDGz9s4YCLHk8WVTxqvvOK7fXiCD4wrMWtvkBWO3EtWjJdYq3xme3ru0L
 h9Nx976dJlpXT7I5vP81BLiUKnM7oWWg4Q6Lep3qbLKzS6XCgjIYQfbTIPEc9oFbQJYg
 JRoQ==
X-Gm-Message-State: AOJu0YzZ5nXsbYpezDyaC6HJH13c5A0GRXBgJmm1DCTStu/Uf6Fec7o3
 H6VgZkTwQ2UEqJ0BJafBCq3xdEcXkqI=
X-Google-Smtp-Source: AGHT+IGWyxU0seLq9Cwoi6X+3ljZJddrGC+BWUBXoIjU6kntj7sdZvOis4fb01NExGB6Y6ZWJYJLOg==
X-Received: by 2002:a05:6000:18cf:b0:31f:8276:5d04 with SMTP id
 w15-20020a05600018cf00b0031f82765d04mr3010191wrq.34.1694852571936; 
 Sat, 16 Sep 2023 01:22:51 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.172.204])
 by smtp.gmail.com with ESMTPSA id
 bj17-20020a0560001e1100b0031fe0576460sm6320638wrb.11.2023.09.16.01.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:22:51 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/4] spl: atf: Fix potential bug on getting FIT data
Date: Sat, 16 Sep 2023 10:22:42 +0200
Message-Id: <20230916082242.583194-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

If both fit_image_get_entry() and fit_image_get_load() calls fail,
an uninitialized variable value is passed to TF-A as BL3-2 and/or
BL3-3 entry point in spl_invoke_atf().

In real world of current SPL flow this is not expected to occur
because a fit_image_get_load() failure should break boot during
images loading phase, and thus before entering spl_invoke_atf().

Update improve and fix comments.

A minor rework slightly reduces SPL code size up to 72 bytes.
Note: I am not enough confident about uintptr_t and ulong sizes
matching within all architectures, otherwise straightforward pass
of bl3x_entry reference to fit_image_get_xxx would be fine.

Massimo Pegorer (4):
  spl: atf: Improve comments and code readability
  image: fit: Improve functions description comments
  spl: atf: Fix potential but not occurring bug
  spl: atf: Reduce SPL code size

 boot/image-fit.c     | 12 +++----
 common/spl/spl_atf.c | 75 +++++++++++++++++++-------------------------
 2 files changed, 38 insertions(+), 49 deletions(-)

-- 
2.34.1

