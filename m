Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3750EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 15:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F598700C;
	Sat, 19 Aug 2023 17:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J3M67ZO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6AD87013; Sat, 19 Aug 2023 17:06:42 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1798186EE6
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 17:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so247604266b.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692457599; x=1693062399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dhd5ReF8q6F7EwXrJBrz9LotFeT73v/kQYMb3orLTF4=;
 b=J3M67ZO+kki5SXWMutxo1TNA7YvKCGcZTbE2PSGE/F7J99uqiyd1RUBWY533pdMvuN
 +fM5tnG2Uoj8LzZBFycmkZL21bmr2EcN04nD+zRHjwt5uqcgUHK64TZaOUqxsCe+1t8H
 0l7gm2/jnCyl+Hro/uf/OP/ChpOcylSlcEHePzylMY+LA7PzjiMBAPjCbtcQDKTWwhdC
 s2qsEkk9y73aHw8mWe4YmcNwotIdNEo/5QAExWS0kua5LFdOsKnBeYwqMML5Iy+co90X
 rdIYamE/Je2bnxBPKtWVImxFI6sqv3ZsP4pX9PDc7wtP8eVMn9wOVMvIvVbsIZww094G
 n95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692457599; x=1693062399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dhd5ReF8q6F7EwXrJBrz9LotFeT73v/kQYMb3orLTF4=;
 b=DASprFS0MjFu8sGgpHfu54ScXpObnLM99fz/UcDvGmzVrg71EVYoxFepiD6+BPbVVQ
 Oxh1dYBJWAjCd4MRRutM8JzXPXAssSBDdVHpUdtKbAQS1YPW3uPektH27CZprvZqIjuE
 YlTX3/jz+5pQZfEVyu6qTm2LrLCfb8bQZENRUkbB8LmEPm/57amqW5wmWQ2+kbxAoL11
 nrGT0yWfB/mWHYBQrz6Rtz4fMsmE2IMgZ3ktgi0lkUk0amsacfNeeg8gIu02WpiPVjeo
 tMyAv+G5NHBygvZ5XEiOW8pfR/eX//ig3m6fDRE5qYo6kC2LX/Kju3SXT46/5dNTW3qX
 oE4g==
X-Gm-Message-State: AOJu0YxqxbccqpO8lnYshK6Iag/g0miT1VuMaq5U3CDDSvJ2DK1Kzt2h
 LzKeoRKgxNFYjeK1cM6/E0Y=
X-Google-Smtp-Source: AGHT+IEjrFZkZNPly6iZUS9byxdzVD4OKqR49J/njQ/cVDt3xV9AGqu6zr9C+IFAPruFT6A0ID1teg==
X-Received: by 2002:a17:906:5daa:b0:99d:d4ec:6c5d with SMTP id
 n10-20020a1709065daa00b0099dd4ec6c5dmr1486586ejv.73.1692457599259; 
 Sat, 19 Aug 2023 08:06:39 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 l20-20020a17090615d400b009930308425csm2856873ejd.31.2023.08.19.08.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 08:06:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] tegra-usb: support dts based xcvr setup
Date: Sat, 19 Aug 2023 18:06:18 +0300
Message-Id: <20230819150619.76455-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This patch makes tegra usb driver a bit more flexible by passing
xcvr setup values from device tree.

In most cases default setup of USB works perfectly fine, but for some
devices (like ASUS TF201) fuses used for xcvr setup are quite different
which brakes some usb lines (in TF201 case dock USB port). To fix this
xcvr-setup value can be passed from device tree.

Svyatoslav Ryhel (1):
  usb: host: tegra: implement dts based xcvr setup

 drivers/usb/host/ehci-tegra.c | 53 +++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 5 deletions(-)

-- 
2.39.2

