Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66502C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 00:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0EC87075;
	Thu,  9 Nov 2023 01:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Aq3wXhOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34AC1870DD; Thu,  9 Nov 2023 01:36:43 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1643487033
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 01:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3lylMZQkKBkwrw025w11Cu22uzs.q208-p227zw676.rs1B.rs@flex--dimorinny.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5a7aa161b2fso4138357b3.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 16:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699490199; x=1700094999; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UfLGj+dpYGlWifD4q2jPs/DpEGgjeii/6HZyewehUJ8=;
 b=Aq3wXhOwDsdT80UNdqUaSAu+0AytQpQjRIrM+E2ew4FWsNFo3tlzhYDdyEwAs7bWh2
 fR+Blbo8UzA89tiFXlf0lJInS3s1Fn1c57Ry9iBccsUNX3LFo8BB7MeI31YNcWI7QOiF
 8TccKAhimX54GrAI1PwPISVLdtRSOIKNzwEA+b2YBUXOxaTpX/Nb3X/VRJd7pWM8C6p2
 X5TSpAvEhldyiKZoAal/DnO2tm1C7pG5f7PaVls87HLqhkfPE/te90XPLvR/7v0W1l52
 xehS1n5VdvalFyB2O9tPd4G+8q1GCBcyzlaFD4xzl5C8YnWrAReWobLkz7oHKjKZ4GZ9
 VUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699490199; x=1700094999;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UfLGj+dpYGlWifD4q2jPs/DpEGgjeii/6HZyewehUJ8=;
 b=iRQm51IWNuBoQbWbpI3PEe3ueFauSQYSCVtNokPNQbzi3QzOSIDgVf+vnDaAdPWwep
 4imKQvkULTYqjCGNkui+xxbAnRCysSn3V4BaLphDaRJmO8gVubYZaLaaldYPIMrYj3sQ
 thdrJptyroc7aAfXfnU7oBYC5dcPKzmHRR1K4PXlUnSywde/rXDP/46N8ulOukuQSIsN
 Y4bumjHiA6/NuP/ynQVSsa9lABd26ixCQG7NUrywedcPzzKSzUPLEjbA1ixFX01SQp/F
 QCkfBCsrdqLxCBtNoyIHLv00qCy0shWk4Hm0KBsyBniuu9+aK7KEuQNpGlNDg+S9wWik
 5v2Q==
X-Gm-Message-State: AOJu0YyEh705+44WtbyMHON1itHwxl9CnwO3Kh/GpNkk9BvccNIvPN2D
 cF1GBl1c4pntWh1h0w0wf7HIi2+y4DcE/sOhrkWwxRicQgamEOWvHuYhqHzu2nf7TUTCxUAxwqW
 RnDh4OVYDGLnSDwi4oSJi8ysu+iifsrvyJex3eXigtARyn6146zfqwITsWpQXYdyWbMk=
X-Google-Smtp-Source: AGHT+IE3KRui1JvkamrhRwqCQ6vthsbKlQJAu0pok4Qddx/LD4avM8NL5/gpLr/MgQVzXQAXe1qTOlmKtP7AdoY=
X-Received: from dimorinny0.lon.corp.google.com
 ([2a00:79e0:d:209:a191:82a1:563a:5b26])
 (user=dimorinny job=sendgmr) by 2002:a0d:ccd0:0:b0:5a7:b496:5983 with SMTP id
 o199-20020a0dccd0000000b005a7b4965983mr75784ywd.9.1699490199577; Wed, 08 Nov
 2023 16:36:39 -0800 (PST)
Date: Thu,  9 Nov 2023 00:36:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109003634.577152-1-dimorinny@google.com>
Subject: [PATCH 0/2] cmd: bcb: extend BCB APIs to support Android boot flow
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, 
 Eugeniu Rosca <erosca@de.adit-jv.com>, Ying-Chun Liu <paul.liu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Cody Schuffelen <schuffelen@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Following patches introduce various block interfaces support
and extend API of BCB (bootloader control block) to reuse it
for Android boot flow of Cuttlefish virtual device.

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Sean Anderson <sean.anderson@seco.com>
Cc: Cody Schuffelen <schuffelen@google.com>

Dmitrii Merkurev (2):
  cmd: bcb: support various block device interfaces for BCB command
  cmd: bcb: extend BCB C API to allow read/write the fields

 cmd/Kconfig                  |   1 -
 cmd/bcb.c                    | 206 +++++++++++++++++++++++------------
 doc/android/bcb.rst          |  34 +++---
 drivers/fastboot/fb_common.c |  14 ++-
 include/bcb.h                |  59 +++++++++-
 5 files changed, 227 insertions(+), 87 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

