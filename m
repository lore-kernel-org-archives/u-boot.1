Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FA606A322
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z1V8SNSp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BNoB5Qbu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1F5780C95;
	Wed, 28 Oct 2026 03:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9Ea4QbAGA5h; Wed, 28 Oct 2026 03:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3949480C97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793156841;
	b=GPfoQORuUznKIU7pJy4rhxnXkT/2GNrYEavCEFSRGfs8tVecfw8eT7X5WY4NtoX4K3Qx
	 LDHMXJrejuw6/C05NYUtjX+OHSyamSdtQsgRuj7xrmZcgik9i+p1ONdwBOrHVbvAaCQ4c
	 k7729Xg3Uq8x0LnkcQSN3iR2nQci3g3pDWVXGL7CUY8xYKa9qMITDeV9ChLBu5bXg4W+z
	 +2Q4kKjV8UmnkLUk3KJgDAOKsBi/jhBT+7GaSVYjLS/xqR5ECVavVdtGBzOnhAaIkYkzy
	 aJARLGI8rPhlOC8hyOvfc7dYKdRYkXjvJw7DYkgKSFL7voMzr1aDcUYkglNqGcOWt9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793156841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e355wVhvawSmfPh25Zs5UIvgJm6av2mMRevKeMieLQ0=;
	b=XcYrbhkcwYwYfSGwN7FmdMa4JYsRrTXRX2nA5bAWLYae+tgPxm8CSvm0xvXE2698DAtp
	 K+gv5RA0KuGKelIdi1ifVifJcjS/I8PKeEwMTj4bM2/KuOcoE2IT+c7SiZEjfkOelLpw6
	 IyGhZxzpRtqYTBWzQGJcc+8QT/R9rKGTNZlh50IJ3LsXBNcouJLecJ8fAzr9sp9frzKok
	 NJLWUZ8s9GH/nUKVeGZAlBuWW7z2mdJfW7qbLWxdckwKMFszkzRLR5ciCHZaJLgdWNJt5
	 77XpuJx3KQx0N2S+YDcFMsMFsZAFpwQnJ9yB1w8UC/QLPuEGOXU0yPx/7VFelrU6pkg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793156841;
	bh=e355wVhvawSmfPh25Zs5UIvgJm6av2mMRevKeMieLQ0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z1V8SNSps41PMCBIN7qr2T+jk5ekJxso+YU4dqMyVbgHr9zrPLyF+CKew5Jw6sqDh
	 yrq/fCVY6ongKNrfvdd5b6mtUpkrkmh2vUZgJuTHEb5GdC4TvHByNY3lVVnVcTzOcK
	 TCSSxsRkdthtzNFlmKX1oJ52WG7GIe9E0/qyy3BnbETIVUEta7bMe8amieVU/5o/z0
	 Jnhi5w4CAmQ5H6dJPrjyD1dPTw3x1vcI++gK+qNXU6/EimmmZ5Dovjjyc16RI263FY
	 YKWJHKn1Kg4eBxVB0QCrTTQAqfCWMdNNbdYxt60WgPfHN25lkDRvZl9fzJ9WbVFGQ2
	 d1Xz0sKjG1X9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3949480C97;
	Wed, 28 Oct 2026 03:07:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C63164BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7F5D40567
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S7sVqpIBSNjU for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03BF340566
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793156839;
 b=JpWNS9dq6EbbEBzX3GdzQ34PBT93pm6ScJc+UPFoY37Sws1JcSlJOigcqP1NrczG3u6k
 N64ZdCj95rNxDo9YMxD+MTNgJ/lAhCdTGL0iwkEqRYMBdjrPGtedcf0X5b3GDO9pcUayJ
 L/PQUrUn3sVEctzLOIFlYLjI1+hLNdEZ8nh4Qvhf81LaYyFnKdIoqTYPkG3azAp7vGxeY
 6359kjuM1bUh8gl/tL7KJmFxdnNuvkxyMBzkWwfR7bxYlbrRZwrgjhsOzJNNpxc3djqGJ
 tansKHgFjBTt/oGX4pO5q5lnA0H+vAxVwhlRpy6BLVZSNdp3nw9ZDOS5X1sAh9V7+QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793156839;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=e355wVhvawSmfPh25Zs5UIvgJm6av2mMRevKeMieLQ0=;
 b=BzBAKFYYcoeKXypkZuqNuwb2Y8ug9NVu7TwdzpJMU9J25Vfqi0m4X/O1DmkkbGkYmPTQ
 vcMO3IA3colbTPSnFxlOTZ80278C2BPI/Bxw1CfbD9lHKS8kpUQ3pglJVvNS6hh2Ybb99
 UXWUZPCa0DKD8pE/6yEYQXn3WktfS5dA+ywIqta+X6oMQZF3/TmjnCAIr7s94KJ1tjl3N
 C2GS/E+IhqYCEyhOa+r1RLNtRmuKwcEaui9R63Jlm09feE77N63B1IRAoRTTaQ7Ar8X4x
 XtD3M3ita8yzzH73igEeW3CdicmsQvx5R9vtLjmjM0YCoumjTj+K9ukWtNIi5fT49jw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BNoB5Qbu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BNoB5Qbu
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03BF340566
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:18 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso331157a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156838; x=1793761638;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e355wVhvawSmfPh25Zs5UIvgJm6av2mMRevKeMieLQ0=;
 b=BNoB5QbuBTcODF7GA1BzlqtJbkq+Ao/E5U9dMUji4I6aKcEcsXn7QtrPGZJzVYBCmT
 vaBGfnobB7uR2/JzW+cl3kJ/sOaRPEU8/hM6s9cxdacF5KqRLBHCYVPpk7vFWvnYOfUp
 PkeWF6+At6cnkAQWMjSKyq2VqeyAYWy41zNubsSsI+5u17ProsA24wRsafLLQz0I686a
 2s4X5gYAYM+2oqhrdb+C3d2Q9QDIPZUI9xdadZQCmBk6M/VVbKjPQgn7BKfX4G53O0cn
 0QZm9H09XEkRvDthv7vJ0DB3D4/DqhG/hWnW+1SuHyL/JB871v1Kw1Z5Gb4DLDM8zwVn
 CcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156838; x=1793761638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e355wVhvawSmfPh25Zs5UIvgJm6av2mMRevKeMieLQ0=;
 b=uxOS3nK/j6OyfskKN5X9Z0QdY9mndnmJAGgjE4vWWTclasrB/MkgAzIZUNXZRPBKGD
 YfPy5PcVDyYK/2EP7the7ICTku2iECD1sJucbz5V5cOmjJ5lL5j7zSbh5K8kQ3i/T9nJ
 TVPF4nZjXf1BxM7D1LseQGB5lQR5+SP+5icSOQV4B6/o5vXd3oD2560bXdaDF1KrJZEB
 BsKEDvbIoONW+MilCOA6TGrOKTT+RR7JHUYGzUSNtP45Z+BgDLUL9AJ0tVg9NUAM9NCf
 JrxYZaKCLPuwawUIxWJuvsQjxt5GNVF7EyBF1NN3njs/mEQwcsyC1mf7VquMhmPw5QhT
 +iHg==
X-Gm-Message-State: AFq9FYIRJoYnjipcz+3+BusZVl7/zNdSsVVhNyoU8oyXjR5GYn+ARI3z
 ZQkalhy5Puhln4NVHy3MYaq2hulkj2Aj04OBs+Nn5PlMfGb6hcAOWrSBOTivz2vZ
X-Gm-Gg: AYBFou38BObKo77SdbGF/FwN1iRt4GLiN8Ud98MEReaDWr1TTRPsVum46C7Rvp+Zv8K
 bumGxtjom2Owqu6UO9js7EmX6WyMneyoCIdlVsLwIrVx55tKerG8nqzOd7ALHrSL2y06ia6WktQ
 Qn4w9pCDZEmsbWyJpT9rfH10Qjms3jdypQFFhQGtvn/lpo0R1JU/2gCIdjY8gJLCVzbrB2yG4VI
 boEUwPLPaNoCASaQC4lSSlQBTaoxe3Pe2VfSPCVKNID1BT+KZ6ZwWHfpn0G9xYOwDUOS2H/p4bt
 yDhkEz9icrtHdgIEa4FQThY79DHZfKsz529nP6vss4KNYxGPbAfedITABZdYjqMI63liffq6lI1
 fglkoNVCAj+HNQQmoKcnntBQ85HJS5SsmPHcEReFBEarMuhBAHZG71kn/xPxdoTYu/rNNg+mhqO
 piP46Ks2/wlOnjfH3Q9gNwH5PYNNmv43OdDqvnKpW7FPYVOvomI8n+hkq2bmINzYJpMYhGBRWvJ
 NmLwqvBu52LsOp44ptzOpwz+wz5gKFnaoxPIvU+t+JIK677uIB9ClZvlZgemNq9Id7g+CygEmq7
 +CG3q7k4nvnHCnkJyaXbqXYHOeOZwZPVGG7LhobXZnWye8F0t82XDvUuhqS3IPwWipxMh79B0rO
 sqdPvwRp7n+nEDaKgTxruOTcARAOCCOdMSgvbMBoEaLYxoI4UMy3gvlVLlRY9WoA3Wagbf5uImz
 F9C6Yj0KxZ
X-Received: by 2002:a17:90b:54cd:b0:3a4:6f38:f2a2 with SMTP id
 98e67ed59e1d1-3ae580f1940mr791119a91.25.1793156837947; 
 Tue, 27 Oct 2026 20:07:17 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a48c2c5sm828615a91.4.2026.10.27.20.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:07:17 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v5 0/5] virtio: Add a virtio RTC driver
Date: Wed, 28 Oct 2026 11:07:09 +0800
Message-ID: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU v11.1.0 added a virtio RTC device (virtio-rtc-pci and
virtio-rtc-device), but U-Boot has no driver for it. This series adds
one, so that "date" and anything else using dm_rtc_get() work on any
virtio-capable QEMU target.

Patch 1 adds the driver, patch 2 updates the virtio documentation and
patch 3 adds a MAINTAINERS entry. Patch 4 lets sandbox tests answer
virtqueue requests as the device would, which patch 5 uses to test the
driver.

v5 only changes the documentation in patch 2, following Kuan-Wei's
review, and adds his Reviewed-by to patch 1. The code is unchanged from
v4.

Tested with qemu-riscv64_smode_defconfig and RTC_GOLDFISH disabled, on
QEMU v11.1.2, which reports a UTC clock, and on QEMU master, which
reports a smeared UTC clock:

- With -device virtio-rtc-pci and with -device virtio-rtc-device,
  "date" reads the host time and advances between reads.
- Setting the time fails, as the clocks are read-only.
- With no virtio RTC device, "date" fails cleanly with err=-19.

On sandbox, "ut dm virtio_rtc*" passes.

Hung-Chun Tseng (5):
  virtio: rtc: Add virtio RTC driver
  doc: virtio: List the supported device types
  MAINTAINERS: Add entry for virtio RTC
  virtio: sandbox: Let tests emulate the device side of a virtqueue
  test: dm: Add tests for the virtio RTC driver

 MAINTAINERS                         |   6 +
 arch/sandbox/dts/test.dts           |   5 +
 arch/sandbox/include/asm/test.h     |  25 +++
 doc/develop/driver-model/virtio.rst |  15 +-
 drivers/virtio/Kconfig              |  11 +
 drivers/virtio/Makefile             |   1 +
 drivers/virtio/virtio-uclass.c      |   1 +
 drivers/virtio/virtio_rtc.c         | 244 ++++++++++++++++++++++
 drivers/virtio/virtio_sandbox.c     |  15 ++
 include/virtio.h                    |   4 +-
 test/dm/Makefile                    |   1 +
 test/dm/virtio_rtc.c                | 306 ++++++++++++++++++++++++++++
 12 files changed, 629 insertions(+), 5 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc.c
 create mode 100644 test/dm/virtio_rtc.c

-- 
2.43.0

