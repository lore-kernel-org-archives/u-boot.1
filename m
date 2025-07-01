Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1258C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 07:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CE281FEE;
	Tue,  1 Jul 2025 09:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tpFzzHjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B788B81FEE; Tue,  1 Jul 2025 09:27:51 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EE58006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 09:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60c01f70092so8988620a12.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751354861; x=1751959661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QQYwxdGFFofIEuDBBGnVVlbLc87fvloZIquDBocdkrk=;
 b=tpFzzHjbcX2MwhDCf1hgxRhCnBOYhkCGlexAp6IH6SOSYALSH0A8ICDbqZCRoZfcPn
 Qmrj4/14VImHHRqfOMGrqIos0VsTDdVdieDAx8lHkR5uHD7g1UOBVUcULJtp6bUmJAJh
 8IuhMXIyKAQAryqUsry306ez3kDcJZJZ1a+PpG+x7p4OlyZBR+b4YWIEHb9z8OcflBD1
 2+MmT2E/KLOnBXTmw5bOKgQqF5U+23Ea6X+Fd1wiQrSZJgDXC+0a6W2StSWzvjBNmfPM
 7f5ijNTK5EnYoVUi088Rx4WA6LLpWXCFcg4NbJk7Q4GbrXdBAloM+Q38wQNbU9g6Kz7X
 qnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751354861; x=1751959661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QQYwxdGFFofIEuDBBGnVVlbLc87fvloZIquDBocdkrk=;
 b=GO88kh01sOSjD88q4hkuzyrfVGpSlZll2JW29p+TYnK6/TihoumDaAH65g2hPyTbdS
 fDr7JuHUrxzYVkXtaq9398Z1/TROe6ooLrOhzkg0eZHodZClod2XZfX619eLEY9ROA1a
 o7d1kD2R3mKJm9o0pD2Sg2u755l2D3ghDPhXs3ZAJlILgbwzMfboLx+7Imj/nUFw0kTK
 Zkz2dIc3epGRL4G/On9+cOfBwXhFvdLlM6QXNN91eENHOBR2ngmv61Io1wlriDNHezXf
 lbPEflYR3M4pY2+D4xVm6wDcTiBFrQ+uPEUExzks1MiRPOe3b1LE1T6lNiqHz7ej0xHO
 14og==
X-Gm-Message-State: AOJu0YyzjFtt4k4KiPuLhn3VPlkcDukgJDOIcOwriM4j7lRfQtLuFHqP
 TH78IpPJVnKhyk3BrhaGY7Ce9G4mlKFYpPqd8KkbNNia4+Z/ydjLMNR8So6dSZW6EiGXfS7GdlE
 zMVH7
X-Gm-Gg: ASbGncv+1U5pSqw8cEi82j+kBAcvC+EN/wMDJI7sQpMAm0dWFplcdTm/lt+FP6sLvTT
 6SJGy+RsM08mI/1JL+6sk5MEjpZsbbKeT/Qqh/keehuHiQp7//UTkZpqtc6yqOuGA/O1oxGDkxz
 mYjKRcO2GHFDyLc7XRIecdpHErasAdwBdCB+wtXR4qhBAuv7XL/PIMSbkZWRkDYpNmxBgrJ//Hx
 BieFMz8MUzm1tWofkFnmI07+OvCxLSvThheWwDM9VHBwT/x6v4THSZxJ+tsnUi9A/R1rvjQxbZ0
 3QkMT9kr40glvO38QwwMq0SDtop5XemsKzMy4MTsaA4Y6lYw/Zc+4eyJJ8L7te4gvju2wm2Oofg
 TqiwfYz3glfyW+iSIiSLT
X-Google-Smtp-Source: AGHT+IEOHovLATPS0LrRQU92LXPSTxSYJNbw3e6+vkaFpcomY0+sZGdJmiNIgQByIp5eB955SzWDbA==
X-Received: by 2002:a05:6402:4312:b0:60c:4521:aa54 with SMTP id
 4fb4d7f45d1cf-60c88daa48fmr15398677a12.17.1751354861316; 
 Tue, 01 Jul 2025 00:27:41 -0700 (PDT)
Received: from hera.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c828bbea9sm7016975a12.1.2025.07.01.00.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 00:27:40 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	andrew.goodbody@linaro.org
Subject: Pull request for tpm-next-01072025
Date: Tue,  1 Jul 2025 10:27:39 +0300
Message-ID: <20250701072739.374111-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Some minor smatch reported issues from Andrew

The following changes since commit 490ae8ceae2d5999c9de863e014e463f5c1495a6:

  Revert the last two mach-k3 changes (2025-06-27 13:07:43 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-01072025

for you to fetch changes up to 8280d2a77ffe72727ef1c729861231b523680dfb:

  tpm: Make use of TPM2_ALG_INVAL from enum (2025-07-01 08:46:38 +0300)

The CI seems happy
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/26897

Please pull
/Ilias

----------------------------------------------------------------
Smatch picked up cases of enum functions returning integers
instead of enum values for error codes. Add an extra value to the
enum and return that instead
----------------------------------------------------------------
Andrew Goodbody (2):
      cmd: tpm: Fix attempt to return value not in enum
      tpm: Make use of TPM2_ALG_INVAL from enum

 cmd/tpm-v2.c     | 6 +++---
 include/tpm-v2.h | 2 ++
 lib/tpm-v2.c     | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)
