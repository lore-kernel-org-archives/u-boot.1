Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7EAC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C4682A39;
	Sat, 10 May 2025 15:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DOXGt5zD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585C482A4D; Sat, 10 May 2025 15:07:00 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778B9826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so443870366b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882417; x=1747487217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NiVRh+gHVMXjg/OZst1pEeHxoFui8lBed2DluPwAFAc=;
 b=DOXGt5zD3IfRwcbroaDTbsK7yjv2o5hXjJFeJXWOfMO7EGc4coQEKAp+xaCD+zxC8O
 Bv2mPDU9nF3JcbHdHZbVijCx/1Xek2e/RO8L7xdpOSZk+puYmAPlgo2NEORa0KQqiCMp
 mBot7df7gNNy9mAWpqr7Wwlrm6Dx+gQrg9TI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882417; x=1747487217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NiVRh+gHVMXjg/OZst1pEeHxoFui8lBed2DluPwAFAc=;
 b=fYZ+hdlG7gZgD0wW/6XRdX7evy7c1m05sosOEtAybJZtYkCW5Y60Y41kXrSKmgPxaY
 +LR9GT3//5OTIpCK18bI2zZyHVOyAgp9VQy0wSv7YY73jqIkFh96ln2EA7fyVg4SL2iF
 ZiFPM5yejv1mTa3elLq4yNVdG41DVL9XwOyuFKKhK6cEdfpHiVrwvVAYC5SG1BNJ7DQS
 T4hjJ8IV+YmFqS/uA514+YbavVJVXNBHCtdUl3MJXiNWdfiEztaKUq81tPH2RPox1RHY
 3eqIkTaoS/PD3xzZh3+1newEfmqCDKRpsAiwCgJXwMqSWaADR3B7lFkMWq9nMkqHwXDW
 czvw==
X-Gm-Message-State: AOJu0YxhAwgBj9XLBjKdSp0jRbUTMrDDwiYoglmxOl0ngoAJxcBAlqEJ
 RNjgXpXrgdgoD3xHCMQebhrO5LOYN4QKJ/I6AIG62JbHy78ZMnoCpIRnbj0iwwCIxNolLWhUq0q
 iZM0ecOchKg==
X-Gm-Gg: ASbGnctyszHuSHLgB870Ia5mLCpXF85jeqNdt5DVNz3X0WNr9048GWeShD3MpcXydpC
 ptw97fKxedliqvCjWU6h8uwkgPvelNrpaeZmuI1XMLwAmBSrDAUA4JwLtnQeFqhjiKbG7LMaIy+
 enuHVwN3rFISyM47lf0Orm9IEXTgMTNCIlGgCJoCJnwIr9UHZ/MZ7XyBXNqpXp4Dhy7oSLPKJHz
 Jj5VAWBRGiyALnhxUVOlYqtNM43mTF9tKFqyBGjbaBet36wBjq1j3HKL37mWjbwme/gzoRA1lAT
 5iFqWy5sEO+Ra7XqwwxdYaJRIPgTh0VI/2A8baxgkQpJLsrRfkGPO1pP7g==
X-Google-Smtp-Source: AGHT+IE8eB132lR6NVT023s0lZI9MwXfqMwD4s+ycLREcVuWs06f76YIC2/igoTNs9bG8tyoCqo/Sg==
X-Received: by 2002:a17:907:d16:b0:ad2:3616:8c37 with SMTP id
 a640c23a62f3a-ad236169015mr273211166b.30.1746882417367; 
 Sat, 10 May 2025 06:06:57 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:06:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Tom Rini <trini@konsulko.com>, Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 00/10] ext4: Overflow fixes
Date: Sat, 10 May 2025 15:06:06 +0200
Message-ID: <20250510130642.1575114-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series fixes some potential overflows in the ext4 code with invalid
or malicious filesystems.

To assist with this and future work, it brings in overflow.h and part of
limits.h from Linux.

Changes in v3:
- Split out into separate patches for easier review

Changes in v2:
- Add new patch to bring in linux/limits.h
- Add new patch to bring in linux/overflow.h
- Use Linux macros instead of gcc built-ins

Simon Glass (10):
  Bring in linux/limits.h
  Bring in linux/overflow.h
  ext4: Avoid expr in declaration in ext4fs_get_bgdtable()
  ext4: Create a var for the number of blocks to allocate
  ext4: Check for overflow of block count
  ext4: Bail out of no_blk_pergdt() if there are no blocks
  ext4: Replace multiplication with an existing variable
  ext4: Set a max limit on block-size in ext4fs_init()
  ext4: Make sure there is at least one sector per block
  ext4: Check for overflow when allocating tables

 fs/ext4/ext4_write.c     |  25 ++-
 include/limits.h         |   2 +
 include/linux/kernel.h   |  12 --
 include/linux/limits.h   |  21 ++
 include/linux/overflow.h | 443 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 487 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/limits.h
 create mode 100644 include/linux/overflow.h

-- 
2.43.0

base-commit: c5a631df96de7421d10ee03dceed1b79db213026
branch: sec3
