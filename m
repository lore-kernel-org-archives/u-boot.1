Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46977C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7328C8882F;
	Tue, 30 Jul 2024 16:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fEUAtI72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7098882C; Tue, 30 Jul 2024 16:40:45 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C6188898
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8111f946f04so200836939f.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350441; x=1722955241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3d5hwQ0gNKzhfguNr1h0F3G2IGBNz5bCIdWLvWMU4Bg=;
 b=fEUAtI72/M5uds+8cuC24ZzDYZRE305thIIjJG7O0uQWh3/AqgLu4LgbMTqfSMqudh
 pOdsNr5kykeNylSzSsJooNjJJJBr+5bR+qDq9gu/GqeENy3CBDu11Xq+2FGvyGSBZAxa
 84Lqswavj97dGF+ZjsEz/lSOtAFxzrv2df5g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350441; x=1722955241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3d5hwQ0gNKzhfguNr1h0F3G2IGBNz5bCIdWLvWMU4Bg=;
 b=AHvKHvKCoJB1SDI9d56ta3RmmP+QQEfp6qdlEL0WNpmOUOWoFd9Hsec++dJuFpFir3
 4FIBcgpurooaMIvTTM2F8eMIYGIVoMDHjSVfZAbt+73lO6VDF6Yk92guUZR1HJzQioFr
 sCPE+HI4JS46pW9LlIfkIrRU+QsbRlNTunsq38GAOj3KoM+Lh1g6rCBt6s7vVtHcrcH2
 3VbiqkyWJ9Qy3DB7bktWXKN0smwveAkqccJvHs1WUWXPqrZlrF7Y3UNFs+vJxbAoGjBr
 bkCAXJZrwm1znm6NnOyy/J/jT8nECR+aWDWc7Rey4Eed+ndu6ABJ/WN1WuFkweOnTWOL
 kQmw==
X-Gm-Message-State: AOJu0YxdmaXPhfNXHKEpjqxoKCjxc+EVhymjqmSAPFPPeT70HQUJvIOH
 LFSj+Y2/tgEeso4SNEmB3+PSqxO+RVkv2eOFLE1x01nPYEyOPjCNpLiolCj3TmIa6Qe9WmZlY24
 =
X-Google-Smtp-Source: AGHT+IGfoFUk15IzDuupru5xuvUISNRJL4veiIlPdXuFKLyuhJ/gI1iwEg3Y4uGgap7POfNK2/dMfg==
X-Received: by 2002:a05:6602:2d95:b0:81f:a390:d1c with SMTP id
 ca18e2360f4ac-81fa3901bddmr1087934239f.10.1722350441073; 
 Tue, 30 Jul 2024 07:40:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa9338csm2714724173.39.2024.07.30.07.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:40:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
	Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 0/4] lmb: Tweaks as discussed
Date: Tue, 30 Jul 2024 08:40:31 -0600
Message-Id: <20240730144035.3992996-1-sjg@chromium.org>
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

This series adds a few tweaks to Sugosh's lmb series to show:
- save/restore of test stage
- putting lmb in a struct
- small code-size improvement


Simon Glass (4):
  lmb: Put internal details in a struct
  lmb: Tighten up the code in lmb_add_region_flags()
  lmb: Split init into two functions
  lmb: Ensure that tests don't change lmb state

 common/board_r.c  |   4 +-
 include/lmb.h     |  53 +++++++------
 lib/lmb.c         | 193 +++++++++++++++++++---------------------------
 test/cmd/bdinfo.c |   8 +-
 test/lmb_ut.c     |  54 +++++++++----
 5 files changed, 154 insertions(+), 158 deletions(-)

-- 
2.34.1

