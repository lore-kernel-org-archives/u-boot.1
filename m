Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A1BC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 203DB874A1;
	Fri, 17 Nov 2023 22:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="SUstE7Er";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77ABE874E5; Fri, 17 Nov 2023 22:21:50 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3F38708C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f7c80ab33so1595948f8f.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700256108; x=1700860908;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L/17yf0WfChqLZFLeOaBcXiVVtCf846dDzavD1CwuLs=;
 b=SUstE7ErM+DWU1I24d+wWMLXmloqFjJGYgGL5XNJ7L4C44dha2NRwCaBKNbw0ZWoSC
 dM7SOJBkyxgO0B9MRKOWj2A3XJzX0XIOGiZveWam8dYzaOf3FYa7zi0XsVGns9VpB5U4
 JvdO84AqujST9hVVTDfHG50oOyP1vvEa+cLqfJqqiLjFsEcfaC4XefUcZurhJB7L651+
 KnhRKaO9rvyOUeo1sbVmV+8F4ZW0YBT8tBva3zR4WZQWYw1VjGt5QfOQwBfrFBzcKIZj
 7gavP1z3rC5qNBGsjIhqyvDC6xtZGk585iKsFLTDOGRDMivLvCiyIXrehJU87ofexI67
 SilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700256108; x=1700860908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/17yf0WfChqLZFLeOaBcXiVVtCf846dDzavD1CwuLs=;
 b=jzuV4WmAaZQnFAe2DjG0NN1Tmnlc8YuJhzizk3WntLNm3xdBLPQB6pasbokg9NxLs0
 Tl7zpQKYmZCMv77AMVpgFtxy0SKqFz9zsNycS0ouAPl7dqcmIDh84lp6SkOkTWgsYuCW
 J2vyQMJfweJnkl5fy8pnvci7lgcP8iUVZ9BlW/pxnn/lr2w29byY3D4O6Xoc09YepW9K
 GTXoRtYooqW7skcrXM7Vyqzo/US6qi2fxWMTAPSXNfbvX0g/UDkbMexZl4KDbR2EYr2H
 eDTvWSOX6j7YKnBiugCqet1GnuK8WDPVXtbq6fTnjhpFasUlYDf8QfrSHA9s2asn55I4
 KT/g==
X-Gm-Message-State: AOJu0YzPDSOo/WDGZxX9vYk39o2j3+Sf4L98yo3QTkfdXnYK2G+/Lape
 7l2GSO7vRW4vR1zo5LpoWaDyPOTh6i0d8PC1CCiKfnN8Oxs=
X-Google-Smtp-Source: AGHT+IHS6FjbmWjxP2uaEvZZ3JQam7ehxxFfl/hcG2L9Lf4z1lOgczhdbQUQ7SVLjmbXq+aEF3luQg==
X-Received: by 2002:a5d:4fd0:0:b0:32d:a369:1820 with SMTP id
 h16-20020a5d4fd0000000b0032da3691820mr115119wrw.64.1700256107673; 
 Fri, 17 Nov 2023 13:21:47 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 t6-20020adff046000000b0032d9a1f2ec3sm3393540wro.27.2023.11.17.13.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:21:47 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 0/4] bootflow: bootmeth_efi: Fix network eif boot.
Date: Fri, 17 Nov 2023 21:20:35 +0000
Message-Id: <20231117212039.1210784-1-i@shantur.com>
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
  bootflow: bootmeth_efi: Don't set bootdev again
  bootflow: bootmeth_efi: Handle fdt not available.
  bootflow: bootmeth_efi: don't free buffer

 boot/bootmeth_efi.c | 22 ++++++++++++++++------
 include/bootflow.h  |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.40.1

