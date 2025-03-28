Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46F7C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D11681DED;
	Fri, 28 Mar 2025 16:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ai2ZDSO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2830581DCD; Fri, 28 Mar 2025 16:44:20 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE3681A0C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85e15dc8035so56960639f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176655; x=1743781455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3l/RSPp8xP1e8xlYNLFJudfraciI/rHjOQcPYaj/07Q=;
 b=Ai2ZDSO7gzcBLCt0l605z0+EsgOezKIPE+imQ57MPz3Ds1bIZW5tSQ79P8pbHMqYMu
 6deuT6cmh5EBLlhPl7VeTIo+dryZJev1nJJ8wEEnP85gZX7leXQtc0xVKZDvC9CYoIyH
 JsUrNKEdEgAv6nLiyl+fQKn1JX4Hka1ISC3Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176655; x=1743781455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3l/RSPp8xP1e8xlYNLFJudfraciI/rHjOQcPYaj/07Q=;
 b=aJ6l3BUlJMaYeDK5AtizzNsq6C3sArA3+1VRQMrjzfl8ZqXy1pmLqNM4GJ5Ey1WNbB
 eJ4Mu47aANVOv7o4pX2XdBTdDE8cmcuFNw6TBp3lvgXiu0AKYHmf9VW3dNPx/h2tFeOd
 9ew8jq1aSS441RFCPic3R+weHGLZd1u+jBPLw88ayejUQmsUI9beKSqhO3pQZDfKHyWK
 5f3pG+4bCrVPtAUSgSErp4H/plS4i06yieRey7guILaozgH0nehB1pM+kPWRPLI1o7gN
 EsXjQAUCftGK1EAyKQBk1gKin38dz9fhSBrq3YEEhTam9AJwrl0jfnL57ccaMmTMCHKB
 sZdQ==
X-Gm-Message-State: AOJu0YzkrYpDkggqizTMagyjGpEa0Ik4cltBSNH2wb8sHW6K38cgyg7U
 alMyZzMZ6yOlioSpI2PzNyADT0u/AcV1IGvGJeGoHyhRBaqUCsmJKIYm8aHJuB+SONS+meO8w0Y
 =
X-Gm-Gg: ASbGncuiCmefKEBREdJw/Qn9FzhrTVMsubu8u55spxL38ifeBwoZjj0Wigv0p6TjBfA
 jlF/pDUF0gJOHFqVtDAKE+7RI5PkE0jxX2YJraKbTWbbFKa3bJ0cgL66EaQmHHzodndGZVLNO/M
 Zv9lPTIiBkTN1IJmgcVIDREOpolot0gc4iaJOhfcXgqbQiiCYk0hb0Vkl7FunxNikVbT2mlUW+8
 dNaj3ixeTxlSJEdZeFfhVt8rEVxh+sZ7OjwctbygrMvZ9f+oakQmmniiixr5tgvp51P45nEU5fF
 j6v4oRl+UZiT9OQBqMF72JLyQuwphwbwyULrOGagH/eS4zGGEZuSBLVGerC0h4cN9m0H36P8O4n
 Re6hjvA==
X-Google-Smtp-Source: AGHT+IFoIDqUEjm7bhjrWLWKequICoM439IhY4SIf8PpLDIBuORtUFjrHnR2sExqcaaygJQP5iPxEg==
X-Received: by 2002:a05:6602:3a03:b0:85b:b82f:965b with SMTP id
 ca18e2360f4ac-85e82147058mr1057801339f.12.1743176654682; 
 Fri, 28 Mar 2025 08:44:14 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85e8ffd6b56sm42174439f.17.2025.03.28.08.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:44:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, mason1920 <mason1920@use.startmail.com>
Subject: [PATCH 0/4] bloblist: fdt: Clean up the code
Date: Fri, 28 Mar 2025 09:43:54 -0600
Message-ID: <20250328154401.3563921-1-sjg@chromium.org>
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

The bloblist code took what I consider to be a wrong turn a year or so
ago. As discussed with Tom, this series proposes a way to arrange things
so that it is simpler to understand and manage.

- Unwind some of the nesting in bloblist_init()
- Avoid needing to init the bloblist just to get the FDT
- Create a deterministic OF_BLOBLIST option rather than using guesswork

It is to be hoped that we can get a platform which uses OF_BLOBLIST into
CI at some point. In the meantime, the standard passage series[1] could
be resurrected to give some coverage.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*


Simon Glass (4):
  bloblist: Simplify bloblist init
  fdt: Introduce OF_BLOBLIST
  bloblist: Provide access to the FDT address
  fdt: Obtain the FDT from bloblist without parsing it

 arch/arm/lib/xferlist.c            |   6 +-
 common/bloblist.c                  | 102 ++++++++++++++++++-----------
 doc/develop/devicetree/control.rst |   3 +
 dts/Kconfig                        |   8 +++
 include/bloblist.h                 |  16 ++++-
 lib/fdtdec.c                       |  65 +++++++-----------
 6 files changed, 116 insertions(+), 84 deletions(-)

-- 
2.43.0

