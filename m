Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D117FF6E9A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4BE38419E;
	Wed, 18 Mar 2026 00:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C4VQgODJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6F7841B9; Wed, 18 Mar 2026 00:00:29 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0866A8410A
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67bb39a1122so3214030eaf.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773788425; x=1774393225;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RYkeWIjQFDc/WrEHMPkX5G4m62J+1eD1txmFyBvj7C0=;
 b=C4VQgODJ/UxAPRlB6JPNc2itBtO7UQHDO5+TxzrHhyB1d8riAz0YdRZmutk6x6C4QF
 lOgGT0TlrvTPZ4BA7YjjBzUZTpRzJCzfyYyk/wEFpRqW/iV4hUSqIzuu+ADwTrtYcbhY
 tVxFR4EXdqckMMKgrkzB1LpUCsFQP2v9TP9N1kIMeKV6LfRMJxysMx2GGCrrsWeUulqB
 DXb5z+BOPcBsJl/AoEd4UoRgZz1w61cu5D2l4SUvgSmrZwmswTcZbWtM16K/DA4DOPVU
 DaJqcEN+LAixeTO8TIZSSNoun9SIUsPCI60T0N3LxGrgxQVpG9M5tKPcjdQys2P3XLFC
 iXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773788425; x=1774393225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYkeWIjQFDc/WrEHMPkX5G4m62J+1eD1txmFyBvj7C0=;
 b=sqNnek6gdHeXl7E2K2WT/q2E30rgZ5eYkCUcNzJlGtv6YgMuibPF9TS8g3MgJ/Fo2H
 K5XemiszdnIr0p99nkT6XzFtDrWta1JnQrm2gTTrGmBWx5WqDEg+EN5X3fOALhDVKfym
 IwpTGPgVPyAwJcJKdTQSenBQKBwqhdb5FldtWNFR6bFPgdloeDYA1/tUf6aZsrnyooem
 umPVBDRnX29a/+PrrbhcQi0I1r+TqTKVicTdq3RSZHN7dYKH/K5P5V5hqZYuftzsBNsm
 vRSrbImm2R4KHEZIvqOCnTi0KhXMPRZwtXoG2QIzoo2H3dsTYtoRyY4JYE5I8v18Mlpt
 kCjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIySNEvXX7cAF2ZgFMtJaO0YfewizFt3GQMawjYjyp1eJ/AXtWc6BpY4hI7u8fPsvh5sNYhLM=@lists.denx.de
X-Gm-Message-State: AOJu0YwgS1BvaeE7OAbiSx6nbHP3/Qpg519TBhl8+9HCwHY6Ptas5CuB
 +D1RkEftYuHBsWK5TqbQxGuLQVW1PNWql8IxA1r4/0cem/j8rLEikWiZo1APjXsKbCc=
X-Gm-Gg: ATEYQzx0+hHASPh/hNY9oSbfJVCgqPTjbYM6ey7prpyT31SnfB2gQ0JO0oZpXXt5Ox9
 P173woNNBG0zd8833/2+lWw6Q3B58jj8xbykhA30FTL8b56K9iDxZQiOXyjpQXaXU3uqQCx/Swo
 kdTAZWhm0fqdhXU88khA2qzMnpQaunLR5H5GpAbi5JSpWxZ6neIrBIhKs7QjwSysYJV8aBRNBb4
 78gGk8xKNGGW9hFu3/q3p133HILAXwDm2HfMd7RqDXYae6xyAzLPKUyX42X+tXB/I05+CCi8ERn
 hIY9TWGHtOUpeN+uuOgI4USopmHQEMVkCMSntoqSaZGRYH3ulGbQdMhmSV2ErPWaJo/hDQkauka
 rO/TWo/y8GphYW+YuD5EfSb9yhn2Qf8qXMSnQr2WijQdXes0V7Gbyhdy2a3M4VTeS9nhmfwzZaZ
 +kOPntMnJloMipY9JjwXUKpSs=
X-Received: by 2002:a05:6820:80d:b0:67b:f12a:dfcb with SMTP id
 006d021491bc7-67c0db0d48fmr756963eaf.60.1773788424395; 
 Tue, 17 Mar 2026 16:00:24 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c0d7f7e65sm580577eaf.5.2026.03.17.16.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:00:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-master-2026-03-17 into master
Date: Tue, 17 Mar 2026 17:59:51 -0500
Message-ID: <20260317230020.903607-1-dlechner@baylibre.com>
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

The following changes since commit ba7bf918dafcd093ad733b07ba490baeb20cf5da:

  Prepare v2026.04-rc4 (2026-03-09 13:52:04 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-master-2026-03-17

for you to fetch changes up to 52d84fccfd7d8b99e91a70192eec8e0379d63b4b:

  clk: mediatek: mt7622: fix infracfg and pericfg clock operations (2026-03-17 13:51:45 -0500)

----------------------------------------------------------------
* A fix for mt7622 infracfg and pericfg clocks that were unusable.

----------------------------------------------------------------
Daniel Golle (1):
      clk: mediatek: mt7622: fix infracfg and pericfg clock operations

 drivers/clk/mediatek/clk-mt7622.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
