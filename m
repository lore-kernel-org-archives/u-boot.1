Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA515D15D99
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D07088EFB;
	Mon, 21 Oct 2024 17:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X0QiIfgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E731288E3A; Mon, 21 Oct 2024 17:51:48 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB3488EA7
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso5244386e87.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729525906; x=1730130706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iHWMXtWqQN+rpWH4zrkbn91YMs6Okwfs92lsHuKrYgI=;
 b=X0QiIfgXLwIHGU0jdeMpOdP3z73D4tfq7GARNXQyzMIyFsG9Y8QuZ9L5gR6cW8BdSe
 aZQWVWTL9aQZqyF+5nBmtUOnol7lS8c0/ph33yDkWbzHOxHooG4ZVbiWcCgDzJhWL8Ql
 gs3i6pjJsad7g6ZMsfFSd5pb+3c4IzwkcK81M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729525906; x=1730130706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iHWMXtWqQN+rpWH4zrkbn91YMs6Okwfs92lsHuKrYgI=;
 b=Sh7LjF3UDmzXmg3vVX1vqPLZ8qx1kMumI+qiNzp0aliqOZAWdOeN8HA5pISOlKyOJz
 M4gTDS+0+DHOFLHrFBRxUeejPjYDbEZqVnRyVG/WdxWfllZFGHk/wqDbVPyOgaANLKxE
 5W51gBD6a+GdlkTVP1jTkeGUQdxGeJAo9AE5x4IBrtbmdMpGdwfB8MP8uWC4MZ8PeplJ
 jDyoiJYCVGHECzEKpILBK5+okmTVy7hEjET8UfZNPCOnsbLDfecO965GVML0Kobr6EqF
 RNnIdeATSYDmhP0fDwtL2XrrMxyk36OWEhCGDRZTqWiBYrNhpr5O7MuI9cX+7TgN+nkL
 xgZA==
X-Gm-Message-State: AOJu0YykHPa0dYUrUZIbu4pWulYknJVmO8Qt+OR9wJbBOSQc89Tl/9fG
 IK8qyaH2WZzU1Qobc/1tRv0lqA+OBNKJ7BP3Xl709bl0sy7PaqY63UbugLuXsXW86jox6teU+G3
 pm6a/
X-Google-Smtp-Source: AGHT+IEK0NOmfTIrWqZMyAtsyhw6qRQDdags+7MShLOdKHzSowZySUJ9fKyXM+NmYkyqnvNK20S3Sw==
X-Received: by 2002:a05:6512:b95:b0:535:6aa9:9868 with SMTP id
 2adb3069b0e04-53b12bfcf01mr238541e87.19.1729525905790; 
 Mon, 21 Oct 2024 08:51:45 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d798sm2143886a12.50.2024.10.21.08.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 08:51:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Artur Rojek <artur@conclusive.pl>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] Adjust how autoprobe is implemented
Date: Mon, 21 Oct 2024 17:51:28 +0200
Message-ID: <20241021155133.29557-1-sjg@chromium.org>
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

This little series makes a minor change to how autoprobe is
implemeneted, as discussed on the list.

SPL is left out for now, but we can discuss how best to deal with that.


Simon Glass (3):
  common: Drop check for DM in initf_dm()
  dm: core: Simplify dm_probe_devices()
  common: Move autoprobe out to board init

 common/board_f.c    |  9 +++++++--
 common/board_r.c    |  4 ++++
 drivers/core/root.c | 27 ++++++++++++++++-----------
 include/dm/root.h   | 10 ++++++++++
 4 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.43.0

