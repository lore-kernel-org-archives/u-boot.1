Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46262EE6454
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA0988E9B;
	Thu, 12 Sep 2024 09:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E/y0VL6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1A488E6B; Thu, 12 Sep 2024 09:30:16 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E59988DF1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so5601255e9.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726126212; x=1726731012;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pKSxveBp8uKERJDKPUw3kbNibw9JDA3vPq3VlPcRg0s=;
 b=E/y0VL6Bz4KWIaEydilNUOsg+6lcTKUg8EgSyEI3ocTyQ3DWk1SHCnaFpLSE+Oddqj
 Kr4wavD/WEqWn7jBPuBS2se2Xdkyhh6ucmYdqA+cWAshPgM852jR1T6gLU+VG+M6UX19
 XpTQlCfO0mZyXGVxrQrsN4Jb5efYNAaBMRhgNj6E0dq44Lw30G+3NCF6NBhwbfL81ztg
 CSYW4RpfpA7kscYctK6KE3i9modA7JlyDMZR7RYerY1BWYuC7mOxN5IKNPjVthf1WwPZ
 e4rIRYUNdzejtSmVSDGQwGn/vUU95tnEjQZBa9hJAWCz3OzKncmdSv1m/MEwqxGwgLRn
 haEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126212; x=1726731012;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKSxveBp8uKERJDKPUw3kbNibw9JDA3vPq3VlPcRg0s=;
 b=tUUSA1tRW16boHkvwv5tlRrrNrOEX5VbXhzeqHFJJV5//GvEG1mjmTa7z0kNpgVXsO
 E3xku8RR74vHVukY/pIbfbu2MoEreUtNa+W4g8dGvTOkyA05NdPH7plqs54xQO5GeDLT
 b+7UVx+pxQY7RW8OyriW7yZtabQzTABC5FTPlhbFGQSuhN4nDETLLV+5tEco5moIM7K7
 +7y/KSNfd6+VQ2yqSK3EtIRvCBHj7S7U5LX5nzmKZYPKIxTNWGFiWGR4YQPaHcUVgcqD
 GYbLuuSw7k/yrEcco2sCs/fnFmwIjY6opuf1V+b4vtzyQATYBB7Qo+NwbKcBNNyGyVId
 x5dQ==
X-Gm-Message-State: AOJu0YxXtfSPLIjvJ5RX/M4/yIaNW1f/xERNGS+RpGsuiB2lzYwvcKLy
 mSHFY8qvT922j/811OXN3afmYw/RuADR6UwdEryrz2A9st9j+o2c1Gps02dmi5k=
X-Google-Smtp-Source: AGHT+IGlFOYRQD+o6OTK3CpbHx9BeMwNYJboSo/hI0SB4B29COoE353LfQQ2Jmk0VlcCQ1wJ5HKOcQ==
X-Received: by 2002:a05:600c:4d06:b0:42c:acb0:ddb6 with SMTP id
 5b1f17b1804b1-42cdb531b66mr15494865e9.9.1726126212065; 
 Thu, 12 Sep 2024 00:30:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:ce21:4d2b:8554:e76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21a5csm164330065e9.6.2024.09.12.00.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:30:11 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v2 0/3] Add Android 14 bootflow support for AM62X and AM62P
 board
Date: Thu, 12 Sep 2024 09:29:56 +0200
Message-Id: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHSY4mYC/13Myw6CMBCF4Vchs7ZmaDEWV76HYdHWQSaRS6aVS
 AjvbsWdy/8k51shkjBFuBQrCM0ceRxy6EMBoXPDgxTfc4NGXaE1qCInJ+41xSTkenXypW2Nr62
 uWsinSajl9w7emtwdxzTKsvtz+V1/VI36n5pLhQpDdbbBmIDWX71bnuyFjmHsodm27QM7aDvrr
 wAAAA==
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

Ths patchset add support of Android 14 with boot image version 4
for :
- AM62X-SK EVM: https://www.ti.com/tool/SK-AM62B
- BeaglePlay: https://beagleplay.org/
- AM62PX-SK EVM: https://www.ti.com/tool/SK-AM62P-LP

Android Images use to test this series are on the Official TI website:
- AM62x/BeaglePlay: https://www.ti.com/tool/PROCESSOR-SDK-AM62X
- AM62PX: https://www.ti.com/tool/PROCESSOR-SDK-AM62P

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Changes in v2:
- Remove uneeded part in android fragment
- Update commit message.
- Link to v1: https://lore.kernel.org/r/20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com

---
Guillaume La Roque (1):
      board: ti: am62x_evm: Add android bootflow

Mattijs Korpershoek (2):
      board: beagle: beagleplay: Add android bootflow support
      board: ti: am62px: Add android bootflow support

 board/beagle/beagleplay/beagleplay.env | 30 ++++++++++++++++++++++++++++++
 board/ti/am62px/am62px.env             |  5 +++++
 board/ti/am62x/am62x.env               |  5 +++++
 configs/am62x_a53_android.config       | 21 +++++++++++++++++++++
 doc/board/ti/am62x_sk.rst              | 14 ++++++++++++++
 include/env/ti/android.env             | 31 +++++++++++++++++++++++++++++++
 6 files changed, 106 insertions(+)
---
base-commit: 57949a99b7bd0aa21abbde1ffa7e50e5d9e10a4e
change-id: 20240830-sitaraupstream-5b18f3b9824f

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>

