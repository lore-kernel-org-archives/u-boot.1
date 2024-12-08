Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9589BE7717D
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 00:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A64168941D;
	Sun,  8 Dec 2024 01:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ChDzB96v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD426893EC; Sun,  8 Dec 2024 01:21:26 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A62D893D1
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 01:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71ddeb7f85eso132770a34.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733617283; x=1734222083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jiCmhmcXsthYp0scSZafimf3HBulTX/uWaZSdo1OnxQ=;
 b=ChDzB96vMh7pjmyBvXJm/RPCQwDTJA7Jof9xbO/BI5WuKhTaHEDbVuUIGyIVpajC62
 3PhSyuUdN7QGcjWr3MMmGiD1C5EE8z17toVNEyGyuFJ8VyXyrswHl9A9B3m1szMbk74I
 jBuoLsgGeYForKVDwT9+t5OQHmwPSw05R/u4I4r2M4CGAnrRsHSeCeniSpSXnXVEMseS
 THPhbEotVRBI5QGOpkZZW5XTnEAdMMpRNNs3M3MTEOfI4FEb10Fg1zGOQ/0gMLq6S9N5
 mYpQzPe3ypW04dfxOsKolZ3zTCKt4eE0gf1HfLY9zWqtKDjVUX0LW7f589zbpHhy5cRM
 aEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733617283; x=1734222083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jiCmhmcXsthYp0scSZafimf3HBulTX/uWaZSdo1OnxQ=;
 b=df/NHaXCz70p65NuBUiQ2GVnjBm5Pr/nr37nwiCmf6KtmT2a4SAIUuJdej7aIvkKtH
 oDAlJUUS4bFFuK4CmyZDcntAiwYWphXmMZKEJCCkYMHe40ZklsWglISAx2Ppi3kXWZmC
 fyP0yTsOnWsqhLmdOxlqCDtxgpNqJnxFXjJZHXgYSRPPopAIs9uH+5k+VbRJ/z1BNre1
 85HKcVawS/+8udiqPxhVUuaB6QYY7cDif7LP4fj9X9tiYdEYukHq00V6LuobL9r9ITUY
 PgMuoKqjw/I7kPleEj9R/fo7zEfe3wTbrN435ZgLD63MzeGhOwpIqkNW3/SPYtVpgBgA
 Vwiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtYUG5oYw4B/o/AlHK9qFwI3aLsia5QJMSPu4C/J9RtM91Nil465l/z/aOaza/gWwrKVZDj+0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy13+p4cRXIUCAb6eOJ31dm7hNVq+ys1Q16opmHVtAHbYyMQzhi
 7KZtFqgeg5NbtGwvVRmO+bzLoydGri7Rx145CdvbSytJf6B0aJgQOzX4cZoLJKg=
X-Gm-Gg: ASbGncsoSDQaLK9J83R4GCI+8uV4jijRhlFPEjeyHPZaq+uHGjkO9dis/+2nuQKPZGs
 9fHrTV82gokH46e6O9q3CAgPGKyrZuIPMJoeUcoSCTomnXIFWOGMXXtz9ABUPVFdw0tzf2vlw9D
 TLyr2GVSRx2U7PFTu540S32XhzvD6TAgk2WGpuSZTqjn/5xRlxDJxeNerAM53rimIfHZslUv2rJ
 AHXYnYKIs10I8CqkNhV+X+jNpgZbKeJErlfCrsp/Nb4k75K0pbe9pw=
X-Google-Smtp-Source: AGHT+IG2iVtnIYwuG+AhpDm0iTrK6dAc2sK/73s7C1bAA0wd6GLdykdUeRYUWzdJmoeIpJV8G9wQLQ==
X-Received: by 2002:a05:6830:6112:b0:718:18d6:a447 with SMTP id
 46e09a7af769-71dcf544b83mr4126581a34.24.1733617283139; 
 Sat, 07 Dec 2024 16:21:23 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f27930470fsm1454491eaf.27.2024.12.07.16.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 16:21:22 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH 0/6] lmb: Fix reserving the same region multiple times
Date: Sat,  7 Dec 2024 18:21:15 -0600
Message-Id: <20241208002121.31887-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Since commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping
memory areas with !LMB_NONE") the lmb_add_region_flags() returns -1 when
the caller tries to add the already existing region with !LMB_NONE
flags (it was returning 0 before that patch). That causes
boot_fdt_reserve_region() function to print erroneous error messages
when it's called consequently more than one time.

Make lmb_add_region_flags() return -EEXIST when the already added region
with !LMB_NONE flags is being added, and then check that error code in
boot_fdt_reserve_region() to avoid printing the misleading error
messages.

I didn't want to change lmb_add_region_flags() behavior back to always
returning 0 on attempts to add already existing regions with !LMB_NONE
flags, as the unit tests in test/lib/lmb.c would break, and also
commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory
areas with !LMB_NONE") specifically states that behavior is expected and
required for efi_allocate_pages() calls with type=EFI_ALLOCATE_ADDRESS.

All unit tests pass in sandbox U-Boot, with a small test modification in
[PATCH 2/6]. I also made a bit of LMB cleanups in this series, while at
it. Only [PATCH 6/6] introduces an actual functional change.

Sam Protsenko (6):
  lmb: Fix flags data type in lmb_add_region_flags()
  lmb: Return -EEXIST in lmb_add_region_flags() if region already added
  lmb: Make const flag_str[] in lmb_print_region_flags() more const
  lmb: Improve coding style
  lmb: Improve kernel-doc comments
  boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()

 boot/image-fdt.c |   2 +-
 include/lmb.h    | 125 ++++++++++++++++++++++++++++-------------------
 lib/lmb.c        | 105 +++++++++++++--------------------------
 test/lib/lmb.c   |   2 +-
 4 files changed, 109 insertions(+), 125 deletions(-)

-- 
2.39.5

