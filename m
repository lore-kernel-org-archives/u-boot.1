Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03646CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E4EA60854;
	Wed, 14 Oct 2026 19:06:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7455pU_Asx51; Wed, 14 Oct 2026 19:06:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8832F60705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792004799;
	b=DRi1rv/ztwq7+KvNgQgbOR5aqV+c1mQHRkrzXTC1/1PQV799zY4ztki+UyZtxA2wH54n
	 KZMTYaxUB8mqOW4F6XVAaw9ZR0iPpRn8VAAZo/uYFTfzj8mkfwQHHz3jw+gVty96ZeCuD
	 wmSJO/mSS3gDcn1ZXE5r4Ud9y/XqszP77bPv00IMkwxercg0rva7E3XPFIx52b8HerEAF
	 gHNuYg3QH7dVPlZj8sz8+gFO9AP5tSMCc1mPdmc7VBnFkEhnqViYOwqGUuxkqvd3ZqVqe
	 V2lewL4+RtKdSn872Cp2b7+SSEZSy/VpxusjxHpz+KrnSA0jkL8dq+gU4EpAGhqeA1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792004799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RAelDWqiWba9BFsk9lrC9qtIbRYnrtKFLEayW8nPziY=;
	b=h+/iMd3BuI9tv68sKKVmbRTxs+IFIKKewJN3cSi7Vgu5KeWeZYl5KPra/ERrCb4HEG8t
	 rqBjqYIDb4rZSkEcC7enwvVQwCRqy1Ki8RIWaDCqYfzpHqdb22etRIVALIFk8nlK9laod
	 RgKOpY1fRbFOB54Z55mJe/hxhQbHaACa4fdydx9G0KE59LSosmdym+xWMcsil4bYLfq6R
	 oZpsVphIdBM0XKwd14oybhQOUTOSdJKK9INz603WXTBA643IXyNZ5XRdGnkTG7OGqu+N4
	 vvMkkcB93yE6v5hM0RXcq3/Y22IeFlvgwS7hlI0GOyjcDhrediTDb7NwBzdtr8jWiBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792004799;
	bh=RAelDWqiWba9BFsk9lrC9qtIbRYnrtKFLEayW8nPziY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sdPJ9LdHy2vTKlRDK2w3mS3py8DGEJxd/Mn/IsYU+lV0dWImQi+t/CCDwslMOsu9G
	 feV4I8qiP7cmDkQL/NLKl2fILUYjlKFp8L0GIjUN+FC9agiY5ogdvQ+diJ9LVe86I3
	 PUAqh+ObMQph5z41if88I81uCkKSnGEl5vhuPzt5IUXBpXD0L6J5PGVoLAjwt5JVsZ
	 mWRZNwzMEjD1zMsknzFQJFyC+kPjaO1g/FMxcGQ+FKUlOzTUeGMeye9HLaDeX6GTeg
	 FtEm9GQXeYlf2CzlwTWbU2EkownSyWtVVigMWWAfftitmUf3X4/Dh20Qddwlquvjn8
	 +D7MMowNOHxRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8832F60705;
	Wed, 14 Oct 2026 19:06:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01F782AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E802D40807
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktrzGy2Cf3ep for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:06:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1656340805
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792004797;
 b=pArXgJLj3yIesn5U0YBqaGeXL5cadxxRe6+4m0gOJEDKkP0mgqa5RF7JyFj31w+Idu5x
 zc/ZMfx6nL3lz7KYL3Td/B+hPEVoO/0LuK2ZaBsssyjZpxkHO2f64zWhUBh/JB97DKxpo
 /71pVW8jYxh8nF4cTF8C7NNAtKURAKiiX4UwMxh6q02XPWplrFOVGQjFR2wRdoo0rPfNc
 fwBjYI3efUTOygryNLyKOluTLiIm8t7MsDrXrMCsBR9jjPuiOxtLwLLxD7SNsJ4ojxoue
 FDC0w9mbMii8zdIwIEnHHLcjefL3l1C5K624Z4nt0/43m9N4PtOU4yWcHnh6pRxj1Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792004797;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=RAelDWqiWba9BFsk9lrC9qtIbRYnrtKFLEayW8nPziY=;
 b=sWf1IAmobiRzrdDKLtCxRJukUD+chfQVdQMK6GKUB4IhzN8J5ERyWH6U/2wu6DO8sF1E
 bQK9FIp5QRuddnHc4pyw2WQasBWlHnncABp8K9ZcP9A7xCmCPjMAtwc/j+PXJWQlQATPE
 DF+GXceKAwNIVTp7arud5jvjj3dG5Hqo6Kj+vREAB74D4kT/8INO7Z5V4btuGYQsKSuy5
 2Q942PgLNzxcB1oUyHCNidZ+90uOIIgv1b0nexfC/BuiJoMLWfYvcM2habIBmVDQxZDyP
 IKoAgrFJPbPrwUIRUseM2cAlj3g5sz70cY8V6pk8SaEvr3nPX/hiAWZdY3ksoknWqSA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EGzgg+XO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EGzgg+XO
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1656340805
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:36 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so775057a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792004796; x=1792609596;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RAelDWqiWba9BFsk9lrC9qtIbRYnrtKFLEayW8nPziY=;
 b=EGzgg+XOltn3Yqok+2jg4yMmuTtR+g3x7PSHH9tBS29k+Xh1mr7ta40K0rIjSdMTT+
 7FXIrtWnwAfGhnHV05spusmjrQA7u8qwGusi4FMcZYVgU2YZgW7iLBN6jgjQFwO+dSm1
 4+qft6YLIIqeA9cjLM6q89Yc0fVbli7dluxQIGy3dqJm8wD3CSxFXhTSqX1t0SVYc6Zw
 uDe6Y1QjgtnAxmBhJXLFWez61c6Xo9OSTDhj0wtlcEE9NeuiwA5q7o+MwLW66SH2+U8N
 M8fLi2KSO+wC3TqdJJniRYEn3U+eCe0Ity95AN5tl1Z5B+GBv3Xb5NH1Q1Huh9qX4IkJ
 toQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792004796; x=1792609596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RAelDWqiWba9BFsk9lrC9qtIbRYnrtKFLEayW8nPziY=;
 b=pNxwF5lHfRPZCiIIO4TTZe57a/qvAIUb9TdbjfkDzVuCXnO/j8XodbjLPQj6viRJbA
 WdtEW7OQMXz7qlFuaZA7gx3WvgDJH8fT5C6uiZ0imFsW0h4HFmp+4XHSFjkAToXYmJzB
 oHPb1oubGhIfqKZ6UrgaYhnRWC9mE9pyWVwX8N/Qe3lhYUAvrpvdDdda28S+fXeC3kQy
 If1XqYtU7RcV5qB1sPLi3eiJ4LkkYj6V9gXbG4cBe8LnzcNUh2DEQNlHx/sl0zfOJro5
 YMiJYZkLPGRHRij9DEb+eTzQnrvM8KXlLH0PDauDQqEFygw4uGQ9e86tgF5iNboheQ3W
 fpfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOI8x9gjykQlKfRgM6IDvDFDvjP2ENrCsgV5DxKzlJmIiX8UAVVM8oyJDAVzAErBEtL9LWvwc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLTd/t5zHwyL+rN0xLIBy6JnWGEF4780v7WIG1LDawpAkXmRNdE
 HgBz5YZSr2gOPG1GNVcjXCtYMt/pyy7jf9QbXB08d11tWLMc06gClRyN
X-Gm-Gg: AYBFou2KM9l+aJuzbGgtD3pw6TT0CBGRGLIxwKKspDoOkANoGvkvfTFcspNo8cl0Ag4
 U6pLjq61Zztk9iLJmfAJELyFblVzU7x/KyOj8nMtUL/NLReRKH264hIbMQQTmWcZVfas7hXZl2S
 IGwlkvVCtgVg87+W9DvoHy3hFkqS1hUQkDMX4poS/XEdu8vxrA91zckTTqFcuwa6XArBLlnnt27
 hN8myqcCcO1lyPpS+rwqD4SWOoXPDDtZvJX3KyfMIZaWGxyoRr9W9OPMWQh2wvgXLnsOCGndY+k
 8N8qt6E9kPxYQBhp8dSVd3VX0+H+4kkgk23IHXWlYXVTMqS/ZsbadJ0E3k5wbne7yvmsp/ibS/p
 xkb2pWtw9XE4Yo3Q8MF7TfS4PB0USwygqkmbGKvPpgRxSzHyzVsIJyasD0OM1Ub4yQe07PyXkvq
 a7/fEQlGQ+i1mA4/UJgEChAdYlqNv2ned+TKV0jDBnHVuNs2nOxkyvkaujXCxRkHui2aBWt+18V
 5yyY7rbMhLRstM/BV8vec+c3Q7qmKb6n0LABqMMhRpSFKXyl5EE+i+VvyWaEBUJ1lOGD9Z0Thlh
 EdePdpnDkkR0+G7iHKkLQcbeo2/nHZGRJ4Z4proTRUtGg76/0apC1Q==
X-Received: by 2002:a17:90b:5343:b0:39e:4c81:6c5f with SMTP id
 98e67ed59e1d1-3ab3a953758mr12633358a91.26.1792004795827; 
 Wed, 14 Oct 2026 12:06:35 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a1f906sm624938a91.0.2026.10.14.12.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:06:35 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/3] virtio: Add a virtio RTC driver
Date: Thu, 15 Oct 2026 03:06:28 +0800
Message-ID: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

QEMU v11.1.0 added a virtio RTC device (virtio-rtc-pci and
virtio-rtc-device), but U-Boot has no driver for it. This series adds
one: it finds the first UTC clock on the device and reads it through
the RTC uclass, so "date" and anything else using dm_rtc_get() work on
any virtio-capable QEMU target, not only on machines that also have a
goldfish or PL031 RTC.

Patch 1 adds the driver, patch 2 updates the virtio documentation, and
patch 3 adds a MAINTAINERS entry.

Tested on QEMU v11.1.2 with qemu-riscv64_smode_defconfig:

- With -device virtio-rtc-pci and with -device virtio-rtc-device, the
  driver probes. As "date" uses the first RTC, which is the goldfish
  RTC on this machine, I also built with RTC_GOLDFISH disabled: "date"
  then read the host time from the virtio RTC, advancing between reads.
- Setting the time fails with -ENOSYS, as the clocks are read-only.
- With RTC_GOLDFISH disabled and no virtio RTC device, "date" fails
  cleanly with err=-19.

qemu-riscv32_defconfig also builds the driver without libgcc helpers
for the 64-bit division. On sandbox, where VIRTIO_RTC now defaults to y,
"ut dm rtc*" and "ut dm virtio*" pass.

The alarm feature is not supported. I have not added a pytest because
the CI Docker image builds QEMU v10.1.2, which does not have the
device yet.

Changes in v2:
- Patch 1: look for the UTC clock on the first read instead of in
  probe(), as the virtqueue must not be used before DRIVER_OK (Bin)
- Patches 2 and 3: add Bin's Reviewed-by

v1: https://lore.kernel.org/u-boot/20261014140716.1181882-1-alan.tseng.cs@gmail.com/

Hung-Chun Tseng (3):
  virtio: rtc: Add virtio RTC driver
  doc: virtio: Mention the RTC device
  MAINTAINERS: Add entry for virtio RTC

 MAINTAINERS                         |   5 +
 doc/develop/driver-model/virtio.rst |   4 +-
 drivers/virtio/Kconfig              |   9 ++
 drivers/virtio/Makefile             |   1 +
 drivers/virtio/virtio-uclass.c      |   1 +
 drivers/virtio/virtio_rtc.c         | 213 ++++++++++++++++++++++++++++
 include/virtio.h                    |   4 +-
 7 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc.c

-- 
2.43.0

