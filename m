Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF3C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB4A81F59;
	Tue,  1 Apr 2025 19:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bKio6DrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E3C81F6B; Tue,  1 Apr 2025 19:30:08 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B21A817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so92338a91.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528603; x=1744133403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gdaZzlScUAvwa8oP/I11ZJGcdV0sCH8JHMP0AYT0ZUc=;
 b=bKio6DrKcGilnaAvUR1W72rFcofZj7Faq7Yqb4D+ScJwfGGFyySE+AuRkN40+0SfAK
 wh3BCKXDvMiobkE+G9mbCiXHtRc8KhkJxB7Vn80yyGQFfM1AI1iGjTgI1wfOats+txGl
 DMc6WjPtalr0FOn4pKDjTQ0lcYI8oaHT09ILg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528603; x=1744133403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdaZzlScUAvwa8oP/I11ZJGcdV0sCH8JHMP0AYT0ZUc=;
 b=hC1ePOeJVRXpUBl5+WTEeDJhStwRKDeqTiLEYKA9RAFsRww3lS1++GvTbBSJHPWFSA
 dmacYJBez8V4OrWaCb9vAHXPC7MlG/htkXBvdsErafRSnCwS/rFyXem/eO+4/i06kRVE
 PpvakYuaY3qybZVOXaDbRJ8/JZuSHWid4ZljDLzj2NSgMLB60VOAMroV3mp8QvMyqN1F
 +slAlx5lsmJx0uqopMtOhpvwl79AAkpmS7eXCoTpiQjhZ3Zgtr/ECbmLK7P5w3/yLxN+
 FSfwarp74eBYGXDGzT49uNUzAaqERN7IIkrrUoAZgjJlNNds7CxoNqrOyE/kby/xWmty
 8/rw==
X-Gm-Message-State: AOJu0Yy6hP74Uu+5CCisg7mgl3yiV5jQ90Wg8uKrKeMFOZOlNinoOuGe
 wiEyHTu37SHpOT6dUlBND8XpkqvksIToBTM/MOMC+Pj6uICa3Jt5csNC5ly/dN8IpKKbkoQCM9b
 JFw==
X-Gm-Gg: ASbGncuxO/hnlwOc1jvY2TiRsvjxG0niEM1dG1T1J43SigD0s3szFTUTS6V/LTcNzvJ
 07O7BubauMBUwYkeqo87NVSce2NqV0D+rrWrMM3D3PU1gEHaCcGG0qht1NENmSHOBPrrcsoKW98
 skKHQBbRGah0i/mdKkeGLxByv+PRAp6nP/JJ4qPNteiV4iBbty7sphuA87sQBoov9sZx+q0m0X+
 lRUAXmnUdqT4QPN4rhV/Etp7ORqr4ukiC5Iiy0ZeN6VpouNGUZ+c/E+8XIG4YPBhlEYjxieqm7U
 znbVlTWBAPA1WKfyE4SDTAy+6jqECDMByleTPdgW6E0=
X-Google-Smtp-Source: AGHT+IHUa6zL9siKiLl0GUHnZLHeYIC3aDZSjkFVAV0oFOR7N5wvt2PC7Fgux5b7kXTV+Sf3olGq/w==
X-Received: by 2002:a17:90b:2317:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-3056b5f0ae4mr1027171a91.0.1743528603525; 
 Tue, 01 Apr 2025 10:30:03 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/13] video: Enhancements related to truetype and console
Date: Wed,  2 Apr 2025 06:29:31 +1300
Message-ID: <20250401172948.1236000-1-sjg@chromium.org>
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

This series includes some precursor patches needed for forthcoming expo
enhancements.

- truetype support for multiple lines
- make white-on-black a runtime option
- support drawing a rectangle

This series was split out from schd2


Simon Glass (13):
  console: Support a format string for stderr output
  video: Make white-on-black a video-device property
  sandbox: Select white-on-black
  video: Add a test for font measurement
  video: Begin support for measuring multiple lines of text
  video: truetype: Fill in the measured line
  video: truetype: Support newlines in the measured string
  video: truetype: Support a limit on the width of a line
  video: Add a way to write a partial string to the console
  test: video: Export the video-checking functions
  video: Allow console output to be silenced
  video: Add a function to draw a rectangle
  vidconsole: Avoid kerning against an unrelated character

 arch/sandbox/dts/test.dts         |   1 +
 boot/expo.c                       |   2 +-
 boot/scene.c                      |  10 +-
 common/console.c                  |  18 ++
 drivers/video/console_truetype.c  |  90 +++++++-
 drivers/video/vidconsole-uclass.c |  36 ++-
 drivers/video/video-uclass.c      |  52 ++++-
 include/console.h                 |  15 ++
 include/test/video.h              |  45 ++++
 include/video.h                   |  31 ++-
 include/video_console.h           |  83 +++++--
 test/dm/video.c                   | 352 +++++++++++++++++++++---------
 12 files changed, 594 insertions(+), 141 deletions(-)
 create mode 100644 include/test/video.h

-- 
2.43.0

base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
branch: schg
