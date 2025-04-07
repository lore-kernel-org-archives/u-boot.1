Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45C7C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C6182CEA;
	Mon,  7 Apr 2025 12:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NezqFwam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D462882CF4; Mon,  7 Apr 2025 12:52:13 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DAF82CE7
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so4254351b3a.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744023129; x=1744627929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=buU1WhBzbGFiRO+/awEwijIu6SN5Ti0OJlzaf+GHH6M=;
 b=NezqFwamL1ZXxMbssfKX82vvwaILcsVCKnxRXSK1bsQ8Yigvxrv0ui/+yPiJ0Ia54s
 AANYwiB/6kQX+gJrn9seF3p0McdiwQN3XTTjlaTN6pZFr/tuEy0kUhK3pnRhWm8NpHt5
 r1YU8xjR9ID7gPgikphJLGqIT3UTGgDP1GrP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744023129; x=1744627929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=buU1WhBzbGFiRO+/awEwijIu6SN5Ti0OJlzaf+GHH6M=;
 b=Vyj9hxhdlHfIil6jYqDqnzhp1uXR1EVYDtuy2+QP96GkkZrbUkQ5UR0D0glJbkkJpz
 5jMATpo1XYiFE6asTcpmhidkmpBR2ax2MKLNxTnLBpD55X89Ijy13XJ29CMzkIvDd9Xl
 pc6uh6fvjliHPrh1i4PaiAxxrZhEgJnQ6cwl51Aomj9nYP7+vRQhzII2GKhuoUBKpAyu
 ishZhE8fuzKqtc56hGjqA7e/PoGEIlHVVAc/+VoMN1CRMYZyT0H61iEqLdscWujqqiF3
 MbOor70x8rIr05WR2w3+Un6sybYycEjrY+L/0Z3syCCQ9kE1mYGBp2vY5qrvGu9gkQ+7
 Jwyg==
X-Gm-Message-State: AOJu0YxsGSGRDhTepEV+AlDBJcvDGcpeq297QKDtjJX+zyme9yJxJLhK
 JoQpoA10sxy9mzWpmsnDOWFbLcFNVytW35Q5OE4jGcV8fnBTaKV0c1Snu0cDzanZXSjuqWdj6Ft
 l+Q==
X-Gm-Gg: ASbGncucQ6U0uJ1YUdImNWtV8CZH2DS7SRih7oHiDGKE6+E83hgEv/CCRRmvcFwwcEo
 vcdoah6v0nF1IVtN8/jP+dHiDR7LOb+wQd9xDKhc2GC85wlA5v17UjrTpfgokDh8G/R0D1pfRo0
 CFd8sLePS3uwBjwgYDe++TjNAV7lcEvN9gJhJmX/2LkCwu8rw70AVFWZulzV+NE8O3ENmmdFLB1
 3m0mgqK7Fmm6tUB+P5kuh7ac0b1jyjNdw2MZZCXzAhmJtGa4RL03kmgKcoI/0o6YeKbIVSkcpAW
 Qi8tGDiASI3lvWttVjIoyebCl9eDHYGtHlZOvQ==
X-Google-Smtp-Source: AGHT+IH62aEE3aqvoxdoO5avJlUt5mrGzXlnbNYnVTFmB81J6CcdFneudQPlMkIrMdf84LrYn2841w==
X-Received: by 2002:a05:6a00:1482:b0:730:97a6:f04 with SMTP id
 d2e1a72fcca58-73b6aa3dca6mr11043074b3a.7.1744023129116; 
 Mon, 07 Apr 2025 03:52:09 -0700 (PDT)
Received: from chromium.org ([205.220.129.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7a0sm8138736b3a.41.2025.04.07.03.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 03:52:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] patman: Separate gitutil fully
Date: Mon,  7 Apr 2025 22:51:42 +1200
Message-ID: <20250407105151.689453-1-sjg@chromium.org>
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


The gitutil module uses Patman's settings module, which is not allowed
as it is supposed to be a separate package. This series ties up this
dependency.

This series depends on these two patches being applied:

https://patchwork.ozlabs.org/project/uboot/patch/20250227192735.406389-1-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20250328130225.2607974-1-sjg@chromium.org/


Simon Glass (5):
  patman: Untangle settings from gitutil
  patman: Pass the alias dict into gitutil.build_email_list()
  patman: Pass the alias dict into gitutil.email_patches()
  patman: Pass aliases to Series.MakeCcFile()
  patman: Update Series.ShowActions() to pass alias

 tools/patman/control.py       | 11 ++++++++---
 tools/patman/func_test.py     |  8 ++++----
 tools/patman/series.py        | 32 ++++++++++++++++++++++----------
 tools/u_boot_pylib/gitutil.py | 34 ++++++++++++++--------------------
 4 files changed, 48 insertions(+), 37 deletions(-)

-- 
2.43.0

base-commit: d47b5693e21f78d8cd8caa8fcd9e64fd6ae85759
branch: pata
