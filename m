Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B825CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 11:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E0F80F0E;
	Thu, 30 Apr 2026 13:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FkP56wgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11AC284255; Thu, 30 Apr 2026 13:39:50 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0118063E
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 13:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-479f7e75a6bso364453b6e.2
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777549185; x=1778153985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gcpgneQkRHUA5FwP6Ud0GXwiux7nJTnp673yLAktABI=;
 b=FkP56wgzLkFxg/IS85lkfu86SqLW701XBGwRQ+a9oAt6FZvbjO33VaHkQb2p5aYHqg
 d4HUkGH1sEu/Me1XWQPRaUPbrcyKbyuu/qu6nEuYNN+I53TwahJ5xx/40KAMRPYrkwUj
 /nCSjP73zpy+5ICnX8FgMjnXIpTddBo/BwYig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777549185; x=1778153985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcpgneQkRHUA5FwP6Ud0GXwiux7nJTnp673yLAktABI=;
 b=K2FyPL8RB1KKI7sHGTC/Er3Ga9XqUZ7E12sY86+ZmrL4VoXuBFVOqPdGhlfH5ZZt8J
 mxyyzMpMRfq0FZHRO9UL5aFPQP0EbwE4ks3c37z8uHoV7+wIiRrllPsNRhXQzxVms8nk
 GzO5TfpdVgjZUTxX7QUi5NREEuc4zqIgsdEqAvdDJyVjU/MnEKtV3GqIhQZHOxbuRXR6
 fQnLMOf6+j2x5rttJby3LRRdzJE+LjkRQNDCmHKjqRu84y0lQjDSxbrMQ9oIfBl7aRTh
 hznswt/sBnNDE3IUA7LJWedID+gwRNZ6iYjJAjVI1l2sEB73A6QMybdNAH46Hc6dq8oV
 LrkA==
X-Gm-Message-State: AOJu0YwwUWj+J9F8MLkgQ2WCS8FuLEFW71VKlTuR79ORFxLWDuTNMF2/
 HETeSJNwQgw0yjSPVya+tmpm626PcwDJ37s5Xm0AGNHlHiUqq2xuDxoG/VBbKtO/q/a37NhxPoQ
 YmYvOv05J
X-Gm-Gg: AeBDievgoH0SyIGYcLZxMPEh7lnWLTeNhTHIc9gB/3V18h321U1mWXcQz/BaCflUTPI
 caowzl+yQNiVr7l0J+6vOwEQ9ArOA+iOPJtEFfEPOf/ECzRsZ++KCCjD57uqcjDgCwffyzZuFAj
 uxfyqEEtDTt7RJKuO7cH68bS42Jc8XTUOKtr5vre3XKMlftIR22unvRCSjSvORgyAResiSp26Pu
 r8NZMFKG5o30a/2S5TbYX+avRmMueOaUzJ7JUpzfGo6+ejr422ZynLMrPmGi/SG5K94I5OHU+pt
 h+V7Ky2k1psLgxvuL+LwzwLnlQeqJgsdkhWJMlfSK3chLCjQVuekyxp342k01XUUM2sE9AG+Xc1
 DsdUskbKynK1PS3myjlaiAfjBc/gI5USb+l3caslYKXQ0POrEmAmChyw65dx8InYQxutfpLQUmK
 OztquUvtWXBKmPx17hc9MyCIPEt13EQKkOGWnZBrk=
X-Received: by 2002:a05:6808:c1fc:b0:467:155f:8c2a with SMTP id
 5614622812f47-47c5fd8e304mr1013172b6e.35.1777549185140; 
 Thu, 30 Apr 2026 04:39:45 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43ee0400sm2715523b6e.7.2026.04.30.04.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 04:39:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] cros_ec: Sync with upstream Chrome OS EC
Date: Thu, 30 Apr 2026 05:38:32 -0600
Message-ID: <20260430113937.1274693-1-sjg@chromium.org>
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

U-Boot's include/ec_commands.h is significantly behind the upstream
https://chromium.googlesource.com/a/chromiumos/platform/ec ChromeOS EC
tree.

This series updates it and provides some fixes to resolve the resulting
compilation errors and warnings.


Simon Glass (2):
  bitops: Guard GENMASK and GENMASK_ULL against prior defines
  cros_ec: Sync ec_commands.h from upstream Chrome OS EC

 cmd/cros_ec.c                  |    4 +-
 drivers/misc/cros_ec.c         |    2 +-
 drivers/misc/cros_ec_sandbox.c |    2 +-
 include/cros_ec.h              |   28 +-
 include/ec_commands.h          | 7738 +++++++++++++++++++++++++-------
 include/linux/bitops.h         |    4 +
 6 files changed, 6268 insertions(+), 1510 deletions(-)

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
branch: ec

-- 
2.43.0

