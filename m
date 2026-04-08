Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FF410FC454
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 22:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBFD3840AB;
	Thu,  9 Apr 2026 00:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="S12JMdhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D4783DC9; Thu,  9 Apr 2026 00:09:52 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32DB883DC9
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 00:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82d03827316so128682b3a.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775686187; x=1776290987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iu1IV7fN6Di9cLbZ9FsckTwcGiY3VXXFK3bXNqkZ4Cs=;
 b=S12JMdhu7LRm2dzuWsLWtgzy0iEnJGfyjkhDkFFWm1vyBD4xpTv5qMEyfw6BW7oPiy
 4gSEGXRY6u6+lDTQhYpAu6bMh+3LeFEr2ext9Nt8QzIZ+F60GJOODHOevb6iaMur/YAx
 jhWU2j6aM0mpUgy/K26CmqE4ZgW3cWpDbwrhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775686187; x=1776290987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu1IV7fN6Di9cLbZ9FsckTwcGiY3VXXFK3bXNqkZ4Cs=;
 b=PDtFtfEWZ7enm6bSX+u5cGh5giUVtsw3m//xkOW5BDDnt+ZRlLz6oWDqQk/tB+6YRq
 wbwsz5J6KnRDzAsWqGZixqyjABE9aXQrEt6+z7gbA5C6LMhrrnLYqTEIyaoFLi4RbcfE
 owOu9yv/9xEfBf115KRzL3RiYdpxWkY1y6a++Jzuq1NQHqsP/XGh+tLrCBfCu548Cztp
 YgGBKo40uO1I4OepHoV2UJ8w56jgsHe2xzWte74kSoF2BGCYxkFs5j0q6WEjNr+u063B
 eb5KjfvAvsAd23twLbysN2iLEADCwAWAnP5gxUfPlbHo5M8t6008PWZi5gO8CrviMYZT
 P0Mg==
X-Gm-Message-State: AOJu0YzZeovNRS/9HE/rupmajk6JppB86LTchWNMAjNR4hF+jmGfK4Gs
 TeUa62e2fjf7nn9Bs0HZ9dOerbERb2ybvVxfSKWHR4ip2+5ayf1G7gIfTrUK8jhdf9w=
X-Gm-Gg: AeBDievwwNcv+JxzD8r/1Xb/hxI5llitO0iKF3t+XxCS//6jwaDx6rbakUIahj7j9Ja
 y/uDE4SMNaACrPU96KP1eNSN7Tw9MTRHWkwyCZS577hNcbzwGjYS0nUs/3L80yprHPOq9TuTO1/
 tZPphcA41+boVY19A8r6zNPM0zjoExUhUmoRljfKqtmTztg/6ATOXVckaYo8n2nSq3s+LAnuQr9
 VBpTdA+Kk6v0nilWrJWS/3xkSozDBfK6bJutzlwhy6vN4oDa75jS++rZ6ahl+EE0VLFVO57L1JV
 9f9oRiUV0/BJi3afMeybDsN6nqtmhzmiaIChxQJ+K8sswEF+o6k9EXET3Rw5IIIurD11HyxpSAn
 IEBoanUkIUuAkREvZM0spdYt5VbpisKy6wSwoFUNiqQ4zax5MRlKXAqqyLLsOgnmFMCSKRngV+0
 BnJ+u99czkH03P
X-Received: by 2002:a05:6a00:180a:b0:81f:c6d1:5608 with SMTP id
 d2e1a72fcca58-82dd8a5bf0amr966134b3a.1.1775686187239; 
 Wed, 08 Apr 2026 15:09:47 -0700 (PDT)
Received: from kinako ([2400:2200:7f0:5ee8:dac6:2cde:760c:93f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b60199sm19877723b3a.25.2026.04.08.15.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 15:09:46 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v3 0/5] Add virtio-mmio support to m68k virt machine
Date: Thu,  9 Apr 2026 07:09:23 +0900
Message-ID: <20260408220928.3328551-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
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

Lets start making the m68k virt machine support useful.

First we need to fix some m68k endian issues.

Then allow virtio mmio driver instances to be created with
platform data and fix a minor endian issue.

Finally, add the code for the board to create the instances.

v3:
  - Fix the bug with the vendor string in virtio-blk properly,
    this removes the last endian hack in virtio-mmio
  - Leave the current behaviour for readl() for coldfire as it
    breaks thing.

v2:
  - Added patch to fix readl() etc on m68k, hopefully this
    doesn't break everything. This should match Linux now.
  - Added patch to fix sys reset which is broken by the above
  - Hacks to virtio-mmio are gone because they aren't needed
    anymore, just one minor endian fix now.
  - Removed RFC because it looks good to me*.


* I wouldn't trust me. :)

Daniel Palmer (5):
  sysreset: qemu virt: Use __raw_writel()
  m68k: Fix writew(), writel(), readw(), readl() endianness for classic
    m68k
  virtio: mmio: Allow instantiation via platform data
  virtio: blk: Fix converting the vendor id to a string
  board: qemu: m68k: Create virtio mmio instances

 arch/m68k/Kconfig                          | 14 ++++---
 arch/m68k/include/asm/io.h                 | 31 +++++++++-----
 board/emulation/qemu-m68k/qemu-m68k.c      | 47 ++++++++++++++++++++++
 drivers/sysreset/sysreset_qemu_virt_ctrl.c |  2 +-
 drivers/virtio/virtio_blk.c                | 12 +++---
 drivers/virtio/virtio_mmio.c               | 27 ++++++++-----
 include/virtio_mmio.h                      | 14 +++++++
 7 files changed, 113 insertions(+), 34 deletions(-)
 create mode 100644 include/virtio_mmio.h

-- 
2.51.0

