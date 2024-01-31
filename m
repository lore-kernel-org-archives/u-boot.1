Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE8FC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 06:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A08879AF;
	Wed, 31 Jan 2024 07:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YtMU+lxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 627B487887; Wed, 31 Jan 2024 07:57:44 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5248C8798B
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-510faac8c57so563250e87.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 22:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706684261; x=1707289061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RS0q6WSplq6RuYoN1yhOdO2g9PzXX3XH8usX+hN0WiI=;
 b=YtMU+lxfs23qTGQ51sEs8COyzBByAkW4gq7Jd/2d+vW+SD9YJUYPlzoLvHlJe5tBEw
 obN8MgOYkZgQGQLmW71rCKdwqaqZSWZ/IImbMfX4oeNIlMO1qitTgbtLLZxDN/D9eU2a
 BsoftcHf0pG40TFEDsQLsFeo6g8wVZmnjRmEICqSFc+nEkc64a4aiddV0ALMQPJhKrRF
 WQmsF1c94m5PvwuC3yaTEVhlL+clLjUqrRriWA1erb5lz/kcyXFeQHQdtxxVUACG9Hi5
 55x63wWih4EhhYRUp9ZM6OqDZvhom4+i9shVuxt3caxm8yBvTKQWhvpVFmgcMz7ZRa3J
 afSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684261; x=1707289061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RS0q6WSplq6RuYoN1yhOdO2g9PzXX3XH8usX+hN0WiI=;
 b=gUf2kO7fnTYBq7RIS3lxvYC31LYzvLRLrEmBddtSPWQQL6BcColmROE74YRPL6tgyY
 Fh7XZ6YzwzDxBBoK4jzm1buVW62lV7yxW7koTjV2msVWHeH0fMID8vh1Wqlb/bpwKGSO
 osYNndrP04jZh2RujrG0qfWm0DP36jHVPJKdf2vr82l2WiYD64e4PzMR1tA+7dxEMQRn
 TiPpwV6fC8umlSQcdd08HLnDkC8Cqeb+ySG9XX4Bs2pOcDOBCYjYr+JY6hBS0j8CFhCR
 nU7t6GPRi/nWUat8JmQpviw8l2joZIFQeqKOnCYzhNkkenuDN9p8UgLYL8M+qQx71iOS
 4MEQ==
X-Gm-Message-State: AOJu0Yw8hjzhqjkYqnRVl3BtHdqNe8R1g5Z2I7WBXK4x+u80nhgJ7lz7
 ncuXAovl3QUl8PpJZzoeZ58AgQeW9SMtoElCPNJPxynoc+P6hZIV
X-Google-Smtp-Source: AGHT+IHKKONbY1OC9vp4e5rznU2dQXm5zphpARLLzbSL0iVKswsYjtfDm2lVROVaU7hAf0i5udL6sQ==
X-Received: by 2002:a19:671c:0:b0:510:22af:2bfa with SMTP id
 b28-20020a19671c000000b0051022af2bfamr1329398lfc.6.1706684261338; 
 Tue, 30 Jan 2024 22:57:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWq+vWOajw8+B5CUzjYcrzyYZhsOzOMMmuuLi6SIOzgVwfNC97iehZssicajdnoF6kzKSuRnh/R8zSpqNDobi9PR9wc0y4HIaW7/mN3RBl5nv3NR8PNmVOa531RDgXSO4Ul4yQZeRoG57YftB9ZV5gOWew77BNtFG0np3n9pr9YSDLS7AB3Y5nuuNM3ILK22jH4EFYYbw==
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 s11-20020a19770b000000b0051023c2e95asm1760796lfc.209.2024.01.30.22.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 22:57:41 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/7] Tegra panel improvements
Date: Wed, 31 Jan 2024 08:57:14 +0200
Message-Id: <20240131065721.4245-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

The current patch set improves the logic of existing panels and
bridge used by Tegra 3 devices and brings support for additional
DSI panels used by Tegra 4 devices.

New and existing drivers are fully reusable, contain no device
specific parts, and are written according to existing datasheets.

---
Changes from v1:
- improved ssd2825 code style
- added TC358768 RGB to DSI bridge bringup commit (used by TF700T)
- added Parade DP501 transmitter bringup (used by Lenovo Ideapad Yoga 11)
---

Anton Bambura (1):
  video: panel: add Samsung LTL106HL02 MIPI DSI panel driver

Jonas Schwöbel (1):
  video: bridge: add basic support for the Parade DP501 transmitter

Svyatoslav Ryhel (5):
  video: panel: add LG LG070WX3 MIPI DSI panel driver
  video: bridge: add Toshiba TC358768 RGB to DSI bridge support
  video: endeavoru-panel: shift the init sequence by one step earlier
  video: bridge: ssd2825: shift the init sequence by one step earlier
  video: renesas: shift the init sequence by one step earlier

 drivers/video/Kconfig              |  17 +
 drivers/video/Makefile             |   2 +
 drivers/video/bridge/Kconfig       |  19 +
 drivers/video/bridge/Makefile      |   2 +
 drivers/video/bridge/dp501.c       | 579 +++++++++++++++++
 drivers/video/bridge/ssd2825.c     |  86 +--
 drivers/video/bridge/tc358768.c    | 985 +++++++++++++++++++++++++++++
 drivers/video/endeavoru-panel.c    | 128 ++--
 drivers/video/lg-ld070wx3.c        | 186 ++++++
 drivers/video/renesas-r61307.c     |  93 +--
 drivers/video/renesas-r69328.c     |  81 +--
 drivers/video/samsung-ltl106hl02.c | 157 +++++
 12 files changed, 2155 insertions(+), 180 deletions(-)
 create mode 100644 drivers/video/bridge/dp501.c
 create mode 100644 drivers/video/bridge/tc358768.c
 create mode 100644 drivers/video/lg-ld070wx3.c
 create mode 100644 drivers/video/samsung-ltl106hl02.c

-- 
2.40.1

