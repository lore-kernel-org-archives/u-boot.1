Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01093CCD187
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 09:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4956F84486;
	Thu,  9 Oct 2025 11:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dVzGlgWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537238448F; Thu,  9 Oct 2025 11:30:09 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FB488447F
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 11:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-911520e43edso32350939f.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760002204; x=1760607004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BMVKd3zWed2Vsd7Au8ujwmPaxObP/Xcd1/DI+2vAdKs=;
 b=dVzGlgWnM/IwNEKeceUteL/uACsTYZ1VtSgC0vqWn0KcHDq7NdLHXv0mFYk4qkEKBA
 kdjIDd9b3zg7fjsr9DlcmY6t1B1T6iqXDhhFWvW2SqW468s7s90HXNPMsgzEZw7qMmAA
 meCevd4H3LEiCnqoNyDyorAUQogUJyh9ECoM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760002204; x=1760607004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BMVKd3zWed2Vsd7Au8ujwmPaxObP/Xcd1/DI+2vAdKs=;
 b=FMFuajlCywPiYxT/Cb0eJaBlAQKUuJ+vjd4BnyQOmRu23GOPRSWcYo+Ur4XED3YZCW
 m5gtG/8SI7WwDG3/NO4nCgKx7HJtd9ewIAOQaQycV3wurQT1SLM/jLwkwGxlKiKuwvSP
 O9S6I728xZCooRa/i0V8keKGbgoM9jJRgozug2m5lJpINlPUapek736bpsBtz4BxDkZd
 DeJumAoe/hfspZ23lustVid9DHA5i9kP4mIhwo3R7QYeiS+p4lCyn5AdvnbUAZJ/EhAx
 PkBwz1N12hoq1UW/mY0SwanMJ8Fw92BwX7fHZEtBlIqFcYkE4yE64kRrxRDqCzMfKx/M
 aI0Q==
X-Gm-Message-State: AOJu0YwHl8CzHf9/wMXRZOG3O2MzGxFukchoK6SX6+pOmfvkQtp+DMA/
 wUeGoWW0x7fHlnI6gvLzDAPcyHkFmjb9PDrBBIpesJBtHX+92luaN4TU+ew2m/tWan7FljEI7SG
 AyFXekCjB
X-Gm-Gg: ASbGncsQ8IkfeV7Gp8emlXUyXqU+faCIgm6YsE0syG084wk12qDDEWs4PZ5tvdlcO40
 9VCv8tO9blWEpdvtL997zLbExsah5Z3ADaTQKKiAS5Ckdk9jJQNW2+t0osafHVN5bN4NywkpkGJ
 09tXI/XR0gRKpbqk1QMnDgGvCcvclpo4mIeDfIDQGp1xb77Fak0XWML6j62+RjmoTXzo7LrD1uL
 2+xzIHTfcOY7FEvcaWx6ZXwAGYJc0amIAo8SAa1Qqf26xnldPolaF+Fic4oXDHT2CiWGWu/+tpL
 6AppjJqE+w2BSu3Ey8TW6/8p/KCim6Vdh0TRP0NrxIPre+1hHLIGfhlKhfaE6Tevw4I/oRqeSGv
 V7Qs2RCy9G+sCu6GBNyOAhChf1hfY4137NtvKKfVlHXaHPhMUQb4=
X-Google-Smtp-Source: AGHT+IGzKGFPBn7iCtGiup/Stfdx8vQS4Jt+5QUywlY3DIb+yrEBzMPro7AXcMg6bnRZOFH1cAGwTQ==
X-Received: by 2002:a05:6602:2d83:b0:93b:ac2b:d63b with SMTP id
 ca18e2360f4ac-93bd186fcd5mr675602839f.6.1760002204034; 
 Thu, 09 Oct 2025 02:30:04 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ea300f7sm7839341173.16.2025.10.09.02.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 02:30:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 0/4] boot: Precursor series for global bootmeths
Date: Thu,  9 Oct 2025 03:29:51 -0600
Message-ID: <20251009092959.260121-1-sjg@chromium.org>
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

This series contains a few patches pulled out from the global-bootmeth
series. No functional change is intended.

I left out this one:

   boot: Move showing of bootflows out of the command

since Tom has already said he doesn't want it.

Changes in v4:
- Series pulled out from previous glob-us3 series

Changes in v3:
- Drop the spacing changes

Simon Glass (4):
  boot: Improve comments related to global bootmeths
  boot: Move obtaining the label into a common file
  boot: Add more debugging to iter_incr()
  boot: Move preparing bootdev into a function

 boot/bootflow.c        | 83 ++++++++++++++++++++++++++++++++++--------
 boot/bootmeth-uclass.c |  1 +
 cmd/bootflow.c         |  8 ++--
 include/bootflow.h     | 11 +++++-
 test/boot/bootflow.c   |  4 +-
 5 files changed, 86 insertions(+), 21 deletions(-)

-- 
2.43.0

base-commit: 0ee639ff5af33342c6c2f4579e210d707abc9bc2
branch: glob-us4
