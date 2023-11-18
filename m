Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9BBC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1EC686FE4;
	Sat, 18 Nov 2023 23:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="LMwTM5yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510A48708B; Sat, 18 Nov 2023 23:04:27 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5DC86F40
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso5155485e9.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 14:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700345064; x=1700949864;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oRIPkhsN94ZgyjMiDIVE0LIGYFnN5MCzaVc0DGyxUAs=;
 b=LMwTM5yuUPceisfTpDjI1VvY9H8nb+6YU735MoEZjK3+HMnQ0lRH2UQz1jbjzJxU2x
 ngABJ5v1+TRVLM7FcHmg2jidnbm149gQJc5E12ScmcR+R2pB0lBw51O6YNHqtFAkxrna
 Ao9TjikMaFGOXYyrHPeZkPhNtFfU/icg2Yjua0TaudWlXUsOxyAnwJUQqFWuJjYPpTMf
 /jHzGMZ4DALE57tcidsgs+cNdIHgo0qrqqJc4mw6MUHO23q6yFC81KdgEmfofFU8I879
 B1Y9Xt34E0LDwnw4BoXY8dFutYLuIPDKnzT5ISzaJu+25pTSZchih2HdbWhjM6vDKt+1
 96dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700345064; x=1700949864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oRIPkhsN94ZgyjMiDIVE0LIGYFnN5MCzaVc0DGyxUAs=;
 b=e+z8eN552Y4larMYYbtisr84spw1jN27KRcaBF4VzKiQDc/tTr+IUyulDCpG2KqthT
 rD89v/64LgLo/PIYcSm0UV4IhMiV8lrhvzGlnewH7KtZB1vmgPukZ5ofs7e3WzcsvNgl
 Fwh+HVAa3qLDHw/miEzCA4O1tSAPh6cKco14AxMjDunBCo2k0vEVqSFH8HiP7RbIo2xy
 /5RtZ7ic6FWpBdrXuA0MavojcFhtnW+AudOSe/flCeQ79EumWkuw9QVCEDUQtV1Wt9A6
 0D9jK9l17Rqc68Wm3MWC2nNAqbcnpsECHW3K4SDL/I5EscpG84wM9jhk7klFUPwr6Nxt
 HN8w==
X-Gm-Message-State: AOJu0Ywj8I7EF+4WBhw6zjQnwU5V5WOBFvYWhIW95u6hWgFJvOikhHXP
 Ioe3U1Y09361fKtunIaPwerGExcAQvt6xItY5e/V9P7n
X-Google-Smtp-Source: AGHT+IGEJaBvkdhJGj2qRSE9UX6Ftga3Y1IMxvs3FBn18PyNhPxNluyNFz51p5w/Wu403Hz1mxOHew==
X-Received: by 2002:a05:600c:1d04:b0:40a:28b1:70fc with SMTP id
 l4-20020a05600c1d0400b0040a28b170fcmr2557961wms.8.1700345064479; 
 Sat, 18 Nov 2023 14:04:24 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 fc16-20020a05600c525000b004054dcbf92asm7776118wmb.20.2023.11.18.14.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 14:04:24 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v3 0/4] bootflow: bootmeth_efi: Fix network efi boot.
Date: Sat, 18 Nov 2023 22:03:12 +0000
Message-Id: <20231118220313.1271556-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

Currently bootmeth_efi crashes while doing a network (dhcp) boot.
This patch series fixes issues and both network and disk boot works.

Shantur Rathore (4):
  bootflow: bootmeth_efi: Set bootp_arch as hex
  bootflow: bootmeth_efi: set bflow->fname from bootfile name
  bootflow: bootmeth_efi: Handle fdt not available.
  bootflow: bootmeth_efi: don't free buffer

 boot/bootmeth_efi.c | 36 +++++++++++++++++++++++++++---------
 include/bootflow.h  |  2 ++
 2 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.40.1

