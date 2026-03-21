Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80E41094478
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 13:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28AC483FED;
	Sat, 21 Mar 2026 14:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SJOgpNI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACB083AC5; Sat, 21 Mar 2026 14:46:38 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9136880050
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 14:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d91f82d819so186209a34.1
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774100793; x=1774705593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ucbSs83ZnIGDgS7GcanvbmOQBe2/ZSPlV8vQCkdqyqE=;
 b=SJOgpNI3eYed2tbXguaaGTTCY8dX/bC57deHiOuMUGMEnJN27TouFH0wrheUpbLgCm
 AQL8se02xxUm32uN8OaGpyJKOZW1EHkpTx9azEJdZfO7WSq0n4YJOqWDs9RfTeYGC2D7
 R6iZIf7fP9aCtm0vNDMJWv50dC9NkbZAzyQA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774100793; x=1774705593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucbSs83ZnIGDgS7GcanvbmOQBe2/ZSPlV8vQCkdqyqE=;
 b=AZBYTVYS645DTADQdaHqW8+C9AH1DD3Z9GojnYfWxxYrbhzWbIYZGKCpjQJE2cfOPn
 NKbzYhqRZojI8UxcOZ0HXEFk5D6j2NV+Urx+TeB/hA9wgTrfVw8C0zVwujmZTrNDPHlR
 7gMoPNQ6WovqjY07gu0OZEwAEVlPigvTAYSQ+fELn3mPjcPbLRxti9huiAfqIVVb82IA
 lK3j2ts2zJlpV1c62xC6h5/FIe48FYH8GBi3eWWoxrSwaPwak7d5FhAZ97V2kzEnwX9p
 C9oKt7xc1zg1Fgiw1uVNh4JAmjOBgAVfluWoLagCpcgEimBrtpDcrvqkpjofUvcnNI0h
 H8qQ==
X-Gm-Message-State: AOJu0Yz/cxkv/8V0fnAiQVLz4aSC0XBRQNRmJwtg8CIEsS56zqFHv0Xj
 1e/I+SO8hXDxXP8vse4wrtfKMF0JQKHnZGpSfzbFy22EBUFCDcV9l1lEvJ3mDnw2cSBx+OnxYAi
 Ov8kPFg==
X-Gm-Gg: ATEYQzz1uSalnzxKNGWCF6ZvCdKuc9AsiTndpAwwLHv2s9UCRvMIYo6AE+TS5nBNLYq
 xYid3rU6aYG0WG0mZQNzregLu1HECposIn3hFthhpPy8DNdy6Y6cuLP2FlAHHTxta6x2mJ1imPC
 P3rMzBdXY3X9bR/0puq74itBE3FuTKsHNhckRBzXw5uSesx7jINIxv/swNpbwLyQx7XE5OCAy8Y
 Og4QiGyf40wp49aRK0W0H0MN3Aq3vk3HRXN3aufY15700wtPo4Dr4dlUuIWhVmSuXG4wNWHXShl
 6vK/cBTZ0Ii8Y7Ub/nK3d1Nq8Gqp1zeTfnmBTGQHdDx0HCeyv5RgJIi8zq4sjyvwlNZ2AF10WVk
 q1bya41dhQ+Zl2+JNT4yF/NIUiKDu3UBnQV4KxOrUl/ruR8ix3p+8RGq8nZzjGMPJ1FdlfyE8oE
 LtqTf68o1XMyAnCFqpnw==
X-Received: by 2002:a05:6870:788b:b0:315:b768:bd1d with SMTP id
 586e51a60fabf-41c10e80979mr4369318fac.6.1774100792930; 
 Sat, 21 Mar 2026 06:46:32 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm4947257fac.3.2026.03.21.06.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 06:46:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] A few linker-list fixes
Date: Sat, 21 Mar 2026 07:46:22 -0600
Message-ID: <20260321134626.516665-1-sjg@chromium.org>
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

This series includes two patches to fix aignment problems with linker
lists. In certain circumstances these can cause the drivers list to be
non-contiguous, causing crashes, hangs, etc.


Simon Glass (2):
  linker_lists: Fix end-marker alignment to prevent padding
  dm: Fix linker list alignment for ll_entry_get()

 include/linker_lists.h | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

-- 
2.43.0

base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
branch: llistb
