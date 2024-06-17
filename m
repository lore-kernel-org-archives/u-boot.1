Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8809DC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A97786EB5;
	Mon, 17 Jun 2024 16:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e5IRjTj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CC9882BB; Mon, 17 Jun 2024 16:34:34 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D3A80E9A
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-632843cff4fso27928947b3.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718634870; x=1719239670;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=p6K75DkiJsAZ2WDAKJpl37RHbDpaIoZ1nWwYH5fumqg=;
 b=e5IRjTj8sRJ6SIlKBsArAgXpzaatEB2FiNy5WkNs/AN9O61SSo7qxqoJOe/9HZXByA
 Z8XnhkSq5bJ2II+OGzhGVPFHG8NNoC+bTk8U/6TvW4tG6eGwqDTqIos2KFf7PYJF+b+U
 bQEH9zQ98arGV3RSU0oOPVw2LKrOzMEnKr450=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718634870; x=1719239670;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p6K75DkiJsAZ2WDAKJpl37RHbDpaIoZ1nWwYH5fumqg=;
 b=w5ZHzwksx9BqLQgvDN+r+ZuwL+bsIFBG2Oxpo+ZgG57oMEM087PcDrggFa2I8AQrpT
 LEJYHXTfwtm74Q1jHukBp0DagCpnbzqAY9vCOtRokQ7T/pYhbenvWM1hBOIf+VjGeZGL
 X8LPQhHl5cA+fd0MZpecEqmWHI+hygGbgQX8Dv0dCTDgptfUoB1o2yXkjXRWs5w+bdW7
 Ebn0Ymo3aWF+B3iJAL/goDi/BasjTsgVenG1MS5ISEH2Jo1FB3okdxbvL3l8RaIbb1+s
 5KFcc786KenD5cOjYSIMrK18jL6v3D4dXJ3QlnsvkKCQIx13ohXaj6ogK8ws+39uwQbw
 YX9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlPirbst36wYRlU3kU1vuA5+b6se6yq5n1OTA4de+2yzuuJgl3wHy30bnG5CTmwJ7DwWmjJuf5wqWa8V97PLAJvaNdcQ==
X-Gm-Message-State: AOJu0YwQZtf06Gd0gLnQ9BXzL15ToSQELtRXGUSfsODsVFUHBID6k/u9
 IjmeWfvQXtkjn7yBtFg+LMcGKeQcFHjJ9XOVSnEWJXPqAB3DxPddneieOxhc+5eGNUWx/cCh3oh
 EwE9FvclN+bxZAVJ3qsPLZHCmq7TvvitV8ajCKTWvjxgWfEfsKyg=
X-Google-Smtp-Source: AGHT+IG7icaBmv+2J0mvYkF87jhk9nPUmqy7cxvaCrODlpiVaOiPi6SLzR3fwNAtepsyzEzK6AB7YjSTyskEeVeG3Yc=
X-Received: by 2002:a05:690c:6ac8:b0:62d:354:98ce with SMTP id
 00721157ae682-6322471101bmr105647807b3.51.1718634870549; Mon, 17 Jun 2024
 07:34:30 -0700 (PDT)
MIME-Version: 1.0
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 17 Jun 2024 16:34:19 +0200
Message-ID: <CABGWkvp+-3fQu=miT-g=MeJzd91kJegEO8azoa20WKz0j+W5CA@mail.gmail.com>
Subject: [PULL] Pull request for u-boot-nand-20240617
To: Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, John Watts <contact@jookia.org>,
 Ravi Minnikanti <rminnikanti@marvell.com>, U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hello Tom,

The following changes since commit 2248c96ea1cf0b65377040d9f87ce7d8cf534c63:

  Merge tag 'u-boot-stm32-20240614' of
https://source.denx.de/u-boot/custodians/u-boot-stm (2024-06-14
08:13:54 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
tags/u-boot-nand-20240617

for you to fetch changes up to aad8aa56d96b1305ae5a9708b604b2f2a4e97c4e:

  mtd: nand: pxa3xx: Incorrect bitflip return on page read (2024-06-17
09:43:45 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/21158
----------------------------------------------------------------
Pull request for u-boot-nand-20240617

The first patch is by Arseniy Krasnov and adds support for OTP area
access on MX30LFxG18AC chip series.

The second patch is by John Watts and adds MTD dependency in Kconfig
for UBI.

The last patch is by Ravi Minnikanti and fixes bitflip return value on
page read.

----------------------------------------------------------------
Arseniy Krasnov (1):
      mtd: rawnand: macronix: OTP access for MX30LFxG18AC

John Watts (1):
      ubi: Depend on MTD

Ravi Minnikanti (1):
      mtd: nand: pxa3xx: Incorrect bitflip return on page read

 drivers/mtd/nand/raw/nand_macronix.c | 170
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/pxa3xx_nand.c   |   5 +++
 drivers/mtd/ubi/Kconfig              |   1 +
 3 files changed, 176 insertions(+)

-- 
Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
