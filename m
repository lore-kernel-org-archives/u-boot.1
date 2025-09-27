Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61324CAC5B0
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 11:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B66083544;
	Sat, 27 Sep 2025 13:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q6aOV7H5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67ECE8350A; Sat, 27 Sep 2025 13:34:14 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 077998350A
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 13:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8c62e313847so110282339f.3
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758972850; x=1759577650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QoYTH1eXFNDV862fGdzX1XAgAGlaOnOyX1FmjXGcs6I=;
 b=Q6aOV7H5x5KU9y3h1xDvtMoxVqMqCCOpjWnMINzpE7r/CgQr2jkkVRR667kXfF+MiK
 IDgfmYceGPDBYcKvduMEIlNBOaVAVMJQ3QQvYLRbLhO6ZexzBE3VCdnEUo8iUyvjA+GW
 gpi/3uKmzS81ALoQK/41yWlYjQKZAArmTIsE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758972850; x=1759577650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QoYTH1eXFNDV862fGdzX1XAgAGlaOnOyX1FmjXGcs6I=;
 b=xS5Efofec5RutGUENtWgwV7i60ODM02EBuBVvjWWGcb1gv0tcXlA3J1FxmZBOEERlR
 He4L8PiEPDipzx32vzV+ZNXDjf0FtKxqvZQf57k2mI0Yq1yWtCjW2krGNi83isQ7fSIu
 YKRWzrGyEOz+85azSmgEPMw0666qV0Z5KnyZQyJRczQKygoKEOst7LFzoii0hcprV/Tt
 6WaRSIJJXAuvbDOUs/Lz67XgZmkbhCinuOz1p0n19GlphqNHCKCmi86AYETI7ykd+yMM
 oguI4FlPwIJv7kI8hLB6Q6Dlhj0dC5/PYyFyhq0vu9iufmSLsURN72c8vAb/IYm4+bAi
 J1fg==
X-Gm-Message-State: AOJu0Yy4QQ0wC1d+2UivxxwXoqUSNW/hyp0dAp6csCx0mH8ceAYlPDw9
 w0Wp8FD74BZYJq+tz1Pr0kZMqZSl25xgUJHm4NprTzU8z4zXdTq9GqBAKNdLyiznKBXYTxJR5um
 Yjf4SXg==
X-Gm-Gg: ASbGncunxYQPNCxXa27HLbkIptf4EJ7Ca+RfpOEHdZXd+MlL+cBT1JaBq4APQOWO45G
 IqCOQNbDx2xzlWN32jZQ0JUdeUMjO/ADY+G98A0i9uVPRCpvyLRry1Zq7sTysIanCpssxGI023o
 8K8vrBwnRpaI25K3S6UxGhFKqvRkPH4ZAMc+khetkbrxqc3gJnYgTDikag2qbpba+RotTjDN48e
 sCsnEV85o4lQZ1R44usuDEXEVUEOLLgIMWGc/G8XZN/jCjHlpYKH4+MmIRHQ6IyrltM2Zukx27b
 9VUrpl4DyWZgYrlw8HYuLGFw22gIBUwhxFU6u9DMz6vlLs38sGSkDSPLIsyvddp+P+5adpnrJnb
 5trZ1rA/Ulz/uA+VKMct0Dzayw+Y=
X-Google-Smtp-Source: AGHT+IEgEcVvOpI0tdoxTFNQP6m+UVi7Ji7v7aTdadAIgqTJHEsdkFZjdJbfVAp5xieI/ctj285yjA==
X-Received: by 2002:a05:6602:6b08:b0:887:3efb:6101 with SMTP id
 ca18e2360f4ac-901567eeec7mr1746222039f.7.1758972850125; 
 Sat, 27 Sep 2025 04:34:10 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-9040f54c16esm261142939f.19.2025.09.27.04.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Sep 2025 04:34:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>,
 Fiona Klute <fiona.klute@gmx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Stolpe <martinstolpe@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Mauro Salvini <m.salvini@koansoftware.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v5 0/1] rpi: Tidy up booting
Date: Sat, 27 Sep 2025 05:30:14 -0600
Message-ID: <20250927113019.2863093-1-sjg@chromium.org>
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

This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
ramdisk, by expanding the available space.

It also tidies up some strange behaviour with the provided FDT, where a
separate pointer is maintained to it, even though U-Boot has copied it
and placed it in its own space. This avoids strange bugs where it
accidentally gets overwritten when loading a file into memory.

The patch to expand the devicetree was dropped, meaning that people
should be careful to unset fdt_addr in the environment.

In version 2, it incorporates some changes to fdt_addr, etc. suggested
by Tom, as well as adding myself as a maintainer.

Changes in v5:
- Rebase to -next
- Drop patch to add myself as a maintainer

Changes in v4:
- Expand the comment on set_fdt_addr()
- Update the commit message to talk in terms of my testing

Changes in v2:
- Drop patch to allow expanding the devicetree during relocation

Simon Glass (1):
  rpi: Use the U-Boot control FDT for fdt_addr

 board/raspberrypi/rpi/rpi.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.43.0

base-commit: 14b784aaf2a96b0f597b4fc3c5a3b4cb70f18182
branch: stc5
