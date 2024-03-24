Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F0ACD11DD
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 15:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B93E487BF1;
	Sun, 24 Mar 2024 16:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y3WFqmTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B71087D2F; Sun, 24 Mar 2024 16:19:13 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A680F8718A
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 16:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d4360ab3daso60260201fa.3
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711293550; x=1711898350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ovYQFvlq3mePJe6rO637zUtVNkzpO6QrO028yw8E5bM=;
 b=Y3WFqmTczx5dJfaXaezyr1IM1Jl3Nhe+9cOdkm/AISDezEprV+/SEo4PZjlRSHUkb6
 oQnk3uz5gmCDJVa/7mC2kZgEio+gFLrp5IbO6YVby7CqCtVrfcVrZSNfQz7TsUTYYS1b
 kaSDEGCnNzheUmcGhZgENnjZD86jhSlovKeSN1Z7cbpQ127qiszYSd4esyR7QdtZPlZF
 u0S6mLF1kjGaC0J+1Dep4ZHg5Vl5fN1vWf7P7xyHLIfgW6Vyw7gDHKbRWrq9GzGKFKVP
 frGqT6UZKkBwTs6oukSCnAkE6MTNcOSbY3k/xB2sPL/6aGkVI3+E/I9zuR1326V8ADEr
 9bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711293550; x=1711898350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovYQFvlq3mePJe6rO637zUtVNkzpO6QrO028yw8E5bM=;
 b=rEl4Q91cTidT9hbgK5QLZB4cmXgyvPzE4dA0jU8OlWe0IwWoIqdu4eCEL0HYpr1Qxb
 u/o7Zihia48stbiFHLYgdDJGO0jBbmMiaP49d+tph9W4p+xnT2oKvs8+FdnWoYVUiaOr
 pg8XBe6z6NzIcRTqaKVmFRfoSSqhElDZx3GLtbBS9g+oFndYEFEXuYcJjzPptPVIvpUH
 UI3kVOBXvQzmz6J/bcYWcVlTxYl0IjLl895hM4H8bs7uc24MvRpYMB3gO/Z1HGl3p/oP
 ZRxaFK7FAcX4sIMcxUHjUvABQ8xTTDpEtkI8RU1iYsWFDHqqQ6yOfUyX/7jGp1vUDm7c
 x3uw==
X-Gm-Message-State: AOJu0YxDxXm3loEwRv9qSMB+N6zfcqLZPr8bdDVQ7923oek3F8KVtoNx
 K5jdIArTtSohENBRhoIfc2x8QGRjedz5jPvRGDRlLculepXGS73hhBGSiNPLIgs=
X-Google-Smtp-Source: AGHT+IHvxG9SMUjnncSUNvSs9rktVG4jV639ZxavzgSpTs/MknCviYzx9CPubScE1BGDThkrdOLmYA==
X-Received: by 2002:a2e:bc1e:0:b0:2d2:eeda:c019 with SMTP id
 b30-20020a2ebc1e000000b002d2eedac019mr3566205ljf.28.1711293549955; 
 Sun, 24 Mar 2024 08:19:09 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 o26-20020aa7c7da000000b0056bf34d656dsm1996114eds.29.2024.03.24.08.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 08:19:09 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/2] ARM: dts: fix Ethernet and random MAC's on WeTek
 Hub/Play2
Date: Sun, 24 Mar 2024 15:19:03 +0000
Message-Id: <20240324151905.3817732-1-christianshewitt@gmail.com>
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

In submitting the original patches for WeTek Hub/Play2 I appear to have
squashed an experimental change to place the u-boot.dtsi file on the common
board dtsi, but this was incorrect and results in broken Ethernet. Patch 1
creates per-board u-boot.dtsi files to fix that. However, while the NIC is
now probed correctly the current p200.c board file doesn't find the MAC in
efuse and we get random MAC addresses. Patch 2 adds a fallback method for
generating a MAC from the CPU serial.

Changes from v1:
- Simplified p200.c changes
- Drop patch 3

Christian Hewitt (2):
  ARM: dts: fix Ethernet on WeTek Hub/Play2
  board: amlogic: add meson_generate_serial_ethaddr fallback to p200

 ...u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} |  0
 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi     | 13 +++++++++++++
 board/amlogic/p200/p200.c                           |  2 ++
 3 files changed, 15 insertions(+)
 rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi

-- 
2.34.1

