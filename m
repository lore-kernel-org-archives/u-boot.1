Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA36C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 05:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2725488AE4;
	Thu,  1 Aug 2024 07:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QB4TF1Fc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F04D88ACA; Thu,  1 Aug 2024 07:48:27 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9348988A00
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 07:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so94871031fa.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 22:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722491304; x=1723096104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hZMQHjE+OHT8XXlwWeZS3x1o42j7zjHwEBCplDbFGFM=;
 b=QB4TF1FcdDkoGlAceyvzmrTIAndXRGmHs/j2UhvKDp95SQ55Srs2/dzdN4toir7DjE
 GYavJTQlzb5gB/ExjXL/1piNh/pqDwg97lb2aNGnNSgcD+5uS01KAGGWLyPwStSx8gpU
 RjqkENKSmYX3ZjjpCj6Cj9Rld0zCSCrkJoiewShNwFIg1kIPnVhX/mP6TlB1KkfarPgR
 QapNzf3emVEQTfw+78JymuJUQKZ/xvQquKFxe1zrffF0Plnr9scfBTtACPmHL8CquzpR
 psy/pEhpzrWxXHzZN/JSHfF6F3Fy+n6XGXAA05x/8i7HT4Alnrh/0+4VhtK7Ln93pc8M
 EFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722491304; x=1723096104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZMQHjE+OHT8XXlwWeZS3x1o42j7zjHwEBCplDbFGFM=;
 b=L63JQ6ZkFXmK3QRxGWXZT7lTgnYLryhpAukvjg7ASbx7JQDiIAsXw7IcILzYKInBEK
 sFWkSz4vhxwivdkiOepdJ3n/lqQOk/UymtgQvudwcPO5Hh1m/ehP+fCzoM48zX5k5M3f
 Why/B6Jnc8p/pShnWW7XzXEb7wlggcI7nBGki+P/Or/z1DpbLt1Dz9xtMPzmcCkT8wNp
 xPzGDk0cd1TwWBK2O+ZAQjF5BC2zUM4Grh0D6Wh3j04LdxbAr3zxUSsS6eBIYszBMS1F
 jll8dC+oz/x4hDZnlM4nKnbzFqTvu0BFE9WHQ+YeCgkaNOc5zT1CKEUWJ5b9u3Uk7qeZ
 yWIQ==
X-Gm-Message-State: AOJu0YxkXj+F2/g47hCCRfJ5NHbvL4MLzWd0unX1sylvmGcpBBYhmASo
 hZaVT4vWvr1BbrEjLAiR1HwxY+7gLcaTYiZPxkceEmWH0qoXBtjr
X-Google-Smtp-Source: AGHT+IEt7bQPNXlLOZvIMysL3lCkyGWG8qNPHmOh4wuvZodhqvtBcxbULR8kjVFIh09e1D4N+5sBsA==
X-Received: by 2002:a05:651c:168c:b0:2ef:2d3a:e700 with SMTP id
 38308e7fff4ca-2f1530ea574mr9922481fa.18.1722491303417; 
 Wed, 31 Jul 2024 22:48:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23125sm849823666b.1.2024.07.31.22.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:48:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] disk: add TegraPT support
Date: Thu,  1 Aug 2024 08:48:09 +0300
Message-ID: <20240801054810.7170-1-clamor95@gmail.com>
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

Production Tegra20/30/114/124/132 devices use Nvidia's own
partition table, which makes them a bit complicated to deal
with. Luckily, it is compatible with the existing EFI
partition already available in U-Boot, apart from the fact
that it cannot pass Protective MBR check.

In order to address this without unwanted code additions,
I have come up with this solution.

Svyatoslav Ryhel (1):
  disk: add TegraPT support

 disk/Kconfig    |  8 ++++++++
 disk/part_efi.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.43.0

