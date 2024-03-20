Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92D6C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE2987EFA;
	Wed, 20 Mar 2024 13:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GkNE+uFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1264487E93; Wed, 20 Mar 2024 13:16:52 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CAFB86FCE
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so4359664a12.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710937006; x=1711541806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RPEzlgIewdUyV9z7PYvNF4VpPlqwOaf0pYSDI9FzfcM=;
 b=GkNE+uFnk3OfRvgE1fkpSf8ypiw8Mg/+AiL41uuKpl6jJEbrcuXColzsfyEbZJvbi2
 X1iw9pPDbPfjAYyObDp2VC+xkLJAjYwXcf4Z2aUHWxgMZYa1aaFuxQGQ2IuC0VWrXTZr
 2PaWf0lc0koM0DAHG1574g1l/Tk1GVOcp9d4obMzPITefhuPYs/6zuc8cq0cjW3Y8Nyn
 FOxWOx9Xaniq5N3xIGrn6/FXJXFPGkls01vXzd0ycEap1rgVaz2hq0r7qDterfixk9sI
 r8wkTNrsCB1WHEBq27kBw+Hqvin1z7sGvY0mIkZRFMjpXN0lGANypkZz9Mz9SN88ItYr
 1YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710937006; x=1711541806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPEzlgIewdUyV9z7PYvNF4VpPlqwOaf0pYSDI9FzfcM=;
 b=XZfePNj2XtB03XPRsWpJiaWCkgmtHLDBIiTezy5HNhfmhOYRlUKvbhbB0Dn/njdeEF
 1lO6UMOT6GMPaXPod/CJRtHvLUz5ufd047J7hdtlnXPJa/EeHHm5zlMAWNTRyIo3mqmq
 kqaCiKh7qATQp+AYKrwqnCzL5ds4hV+cbpHDkaK1Qi8JCbZWUEhoAUJb757mduplw783
 sewv32mHFlhHAFfxuzRovKvNvAAirxUNQX4DbC4qyv/gbFLxDygSVf9zUcd97qAzWmJT
 7Xn42f2TnehyuNdr1RDJ98YczOzLWvovy/99atXIKQEIp8B7xN2jbhPeY26+mRi5BPrH
 Wi7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFvzlFPfhUCkPUNLtF18rX87rtuqt8wORg6jRu3/RcxRrCSYYa/yYyzLHgOXuQMnmLkl2N112VsolLRIdzWbvSbPhsKA==
X-Gm-Message-State: AOJu0YwWywyJppEjW+6bbZCu8VIYc30+Ddmjb8LBuxfgBjUiLn/kRSJX
 Mp4cDnr5oF3ewyZ2IPfqHcpvbUwvywnNPpcGKUMhlZIrSvkeSCOM
X-Google-Smtp-Source: AGHT+IGUPNOmRaH6bzZknTOS54SicEkHt8lP/vUsBiGt1sPjVJcukWgOE3gTqv2N/iqTVOUTIlPIig==
X-Received: by 2002:a17:90b:14c:b0:29f:b55c:68d9 with SMTP id
 em12-20020a17090b014c00b0029fb55c68d9mr7904099pjb.21.1710937005737; 
 Wed, 20 Mar 2024 05:16:45 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 sj10-20020a17090b2d8a00b0029af5587889sm1447870pjb.12.2024.03.20.05.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:16:45 -0700 (PDT)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 0/2] arm: mach-k3: am62: change a53 clock frequency by speed
 grade
Date: Wed, 20 Mar 2024 09:16:30 -0300
Message-Id: <20240320121632.105730-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

This series introduces a method to dynamically set the AM62 A53 CPU frequency
based on its speed grade. It adds a new function to retrieve the A53 frequency
value by reading the speed grade from the hardware. Subsequently, it adjusts the
Cortex R5 device tree at runtime  with the frequency value before initializing
the remote processor.

Regards,
João Paulo Goncalves

Joao Paulo Goncalves (2):
  arm: mach-k3: am62: Get a53 max cpu frequency by speed grade
  arm: mach-k3: am625: Fixup a53 cpu frequency by speed grade

 arch/arm/mach-k3/am625_init.c                 | 62 +++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62_hardware.h | 15 +++++
 2 files changed, 77 insertions(+)

--
2.34.1
