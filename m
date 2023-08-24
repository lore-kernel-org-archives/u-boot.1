Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5AFC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6968656A;
	Thu, 24 Aug 2023 10:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q4YnTBjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D7586565; Thu, 24 Aug 2023 10:09:10 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C6480842
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fee87dd251so43968985e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692864547; x=1693469347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yvjKDvupkEmgCPvn1uRGTSoxcfRU0jhtaP4hUftZrVk=;
 b=q4YnTBjnVo2g5SvDYTlr7bQ804bHDk1aPZcSxj3L2DnNp2La99Ltqt0e0F0ptsGlAz
 yGDkegZymB6O8Z87wQlEM8LMSKGW3mWG6NYTh2Mv2gQuwoQdUAHPbwvodKyomPKcm4J/
 O2wikjcZgDMSgsIYzxRwHE045edraoMPsCdeQ7fg/7wabSiLe7j/fjOj5yJAiEgomPKC
 m878K0VaZ3ZOetHyzsL9ubjSJuxn3VqmUUtvnN7gvuysYspVewWmy+mtPtVL5DZ0lwvd
 x5buPDCsxpE8LhTLgrMShYlq/8EahBuDuCNx3WAlu4ZNjLOJD0QW5jz+SHDM7UUtEPXD
 Oxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692864547; x=1693469347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yvjKDvupkEmgCPvn1uRGTSoxcfRU0jhtaP4hUftZrVk=;
 b=YwiUgFp7F4ZGYA2FW9whS7tCOCocmrO+4MsmUEkTLXYefnlGNZLrVtIHGpD2EYNqki
 nnFXadINWP1NmPe5g30IaKxvsw5P573dvA+AAtrOCI60LKGpMMi+ylZtNahlq4U6GlYp
 0IPXaBtyZGPiLYgRE5aVwLDSr3I/GxD/Hd6MM6x53yqP+cYunFbufamUANep9AbUCe9D
 TxKoy1eilKH2TyEf6J2EhCUBbIiWlGCzVMb/688FRmu0srwkxl3hX51i3MVIYwyIp6Wj
 eLMDb6slb9rV6Ce4uEfDG0PuIB7Y75diD39zjUc+vJLQbLDj+wZB9ttOZwi1U7sypnoT
 cIlg==
X-Gm-Message-State: AOJu0YxMy6+KsQPqcJ/BBXK+rujgybSxwuXKHX7VBoHnvhXWKv416o/B
 zvquUa1phwtoqK3DrXLWcrtRfK0NbPIcrg==
X-Google-Smtp-Source: AGHT+IFW6dA9MgaoORdtvbW313rTeh+q818CN13G4TvyO2BI0GdJKLycWPfPBXXuI/pBqoHXaLDUcQ==
X-Received: by 2002:a5d:58cd:0:b0:318:7bb:e9af with SMTP id
 o13-20020a5d58cd000000b0031807bbe9afmr10626480wrf.55.1692864547118; 
 Thu, 24 Aug 2023 01:09:07 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:8b32:37a2:413:27e3])
 by smtp.gmail.com with ESMTPSA id
 n16-20020adfe790000000b0030ae53550f5sm21282602wrm.51.2023.08.24.01.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:09:06 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1 0/2] verdin-am62: add u-boot update wrappers and fix check
 for minimum memory size
Date: Thu, 24 Aug 2023 10:08:48 +0200
Message-Id: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

This series add boot update wrappers to Toradex Verdin AM62 SoM and 
fix the minimum memory size warning.
These wrappes allow flash all U-Boot binaries: 
R5 SPL, A53 SPL and A53 U-Boot proper.

Emanuele Ghidoli (2):
  verdin-am62: add u-boot update wrappers
  board: verdin-am62: fix check for minimum memory size

 board/toradex/verdin-am62/verdin-am62.c |  4 ++--
 include/configs/verdin-am62.h           | 12 +++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1

