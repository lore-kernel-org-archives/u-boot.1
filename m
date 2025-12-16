Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE86D5E156
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 13:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5402C83971;
	Tue, 16 Dec 2025 14:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="IzJ6Yp2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0448283984; Tue, 16 Dec 2025 14:41:44 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF7983623
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 14:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso2040564f8f.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1765892501; x=1766497301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RHsrrDgrsoZfxNrBQgbIqzMshq6jFvaEuRrhOOrly00=;
 b=IzJ6Yp2g8RWuKtsLNxlPgDoSCLfWBPU/ZxYYCz60xbJboxHwL+v2E2gIxc+ftjUxfv
 UgsVbNL6SBZlL59CbmS71Jny93LOymCBWacxtVMAGrIP5MTsqEp69aE9Arj/gpAisFzB
 jZOyYSbmbFzyfhsrVQB1DQ/odmYC8ntWGIxtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765892501; x=1766497301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHsrrDgrsoZfxNrBQgbIqzMshq6jFvaEuRrhOOrly00=;
 b=HOULe13ALqrgN4pVYcxkCzDNy2FQIx3zGeNMZOgnu/vKPE4AwQp+WFyUnn8NWaFzAH
 gd+SkZtKBt9qijrO1Jv5gYpGnfPQN8u0VjMwVWp885agSUzoKUdIfV0HzCDCtci84sXb
 a4YrEAYUw8TiFA/UmP338nA5Xnp80zMMkWA5G/R/wX1c1bmPGc/HREbSkQYCOl5bPx+G
 YdMnuWauByXvaWwUefYpFjtDDhEHIYKJBsEHsUNCce0/zNKWthzlmZ+JhLMuapHA4rHj
 D3f9ksZsMiJtWJD+W3H3lOwAaCNx4W4/cUqhg9+3PSibIZCSkjIOTa1eKCLuEwqH96xV
 BGUg==
X-Gm-Message-State: AOJu0YzHGvsBSIgaZBBdTXRICm4hxKlgNA1VLm8S1bVv+jtgW6Aq452x
 K+wRZdbD1gHMu/kn7cRJ7DUuVyGfWvZ4KE4oIethBUFhy+gi3c6jjSmW698J3nc2UvB8rBbwtwD
 fIcwumWoAQA==
X-Gm-Gg: AY/fxX6pFdSN80ggnhaZ34mm0tKucsGUnYUug27gMEZIcrqnE1b769QpTg+mocRLVDJ
 ARsLgT0UgBg4DTrQRORB+oCA920JFkqoOD/gyixZ2Nlouhog3S2/EmxVHMKyNsVd8YYG1KNwHdR
 +1XEU2TlhcfmyOoXotRN7oL5oDtbPnYqivAbyFcJ7LUEvMIvrBckTIaya/mmc1qkpcuNCljxnjl
 6i+x1Fe0fc/DmeobI87LT74GgaT31rcCZl0v9VloeyYUEExNeMDdOqaBBu6jsQGl2W9qCw4+Izi
 haD3i4lMx8d9VQHLFjs+RS/xFcRzzTx5H8yTU0+dgFf82/+mqlaktozR23J6fK3xVuwJ3HpZXgi
 OhyYZH59wt/NKJrgyTua4FdqJZv3U5Hkr/7Qe8Md8VXtZ5wa5NRtyGQXUoV1ogCv8EqHFYJiCfp
 +O7HkNzwWBtCn+3bPj4OYGyt0Ki4FOM5PHnMu3imI652aQHsugvm8n
X-Google-Smtp-Source: AGHT+IEhLtNkFV4toVIMSLLI18lc6Av0xY9ak2R1Iqr01upOGmBL+hJGaV6fhscpuzEiGqf1zXidlw==
X-Received: by 2002:a05:6000:3108:b0:430:f255:14b2 with SMTP id
 ffacd0b85a97d-430f2551855mr12545647f8f.13.1765892500933; 
 Tue, 16 Dec 2025 05:41:40 -0800 (PST)
Received: from petersuti-sue.lan (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f4126477sm19694532f8f.10.2025.12.16.05.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 05:41:40 -0800 (PST)
From: Peter Suti <peter.suti@streamunlimited.com>
To: u-boot@lists.denx.de
Cc: Peter Suti <peter.suti@streamunlimited.com>
Subject: [PATCH 0/2] cmd: mtd: fix default read behavior and boundary checks
Date: Tue, 16 Dec 2025 14:40:40 +0100
Message-ID: <cover.1765891388.git.peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 14:42:57 +0100
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

This series addresses two issues in the 'mtd read' command regarding how
default read lengths are calculated and handled when no size argument is
provided.

The first patch fixes a failure when reading a full NAND partition that
contains bad blocks. Currently, skipping bad blocks increments the physical
offset without adjusting the remaining byte count, causing the read to
attempt accessing past the end of the partition. The fix ensures that
default full-partition reads are truncated gracefully at the physical
boundary rather than returning an error.
This behaviour is similar to the raw `nand` command which adjusts the size
of the read with adjust_size_for_badblocks().

The second patch fixes the default length calculation when a starting
offset is specified. Previously, the command defaulted to reading the
entire partition size ('mtd->size') starting from the offset, which
inevitably exceeds the partition bounds. The fix adjusts the default length
to 'mtd->size - offset'.

Peter Suti (2):
  cmd: mtd: fix read failure on default full partition read with bad
    blocks
  cmd: mtd: fix default length calculation when offset is specified

 cmd/mtd.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

-- 
2.43.0

