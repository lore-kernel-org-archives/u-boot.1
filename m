Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA238C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 02:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E464780BAE;
	Tue,  6 May 2025 04:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WJID/6L/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE2280F03; Tue,  6 May 2025 04:59:40 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4B2800D7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 04:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b061a775ac3so4836998a12.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 19:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746500377; x=1747105177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BTCTnGV27pgGuDPx9uSGtkSXgL25/5xhe7AIfQzCZXE=;
 b=WJID/6L/72bUCi8ExwOMZXeBFFJ0fJUS7jLaeRp2Jql/GhzpM6ZXkUL2NzHrnCv0q1
 bLfCHrT59dGIksOaxGu3ydhfJ9e8aAOgdAdwKgSehUB0yIHtkqCNZRPH24WnqQEFdfXL
 WDUNZBxpeKUo4n7iQ+rMkSc2iUZW4IYEI1Fjt8qCo4PxJpNjYvJpBkrTtXmAHTzu3q6k
 mlIssjVV1hYKDIWmyF4ebGv7yRJItUrB5ZA6j2CRtAsLtP8eOaM/pjfz/QG5V80ifWXP
 CUNq3/FBEUqewrzts2ydDfpnn6aa4rndgvSIdmI8aeXgI5pWAPMULAIGRt9Dc7lxbuEH
 q1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746500377; x=1747105177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BTCTnGV27pgGuDPx9uSGtkSXgL25/5xhe7AIfQzCZXE=;
 b=IQpsJs2ABeE598hyVqmkfNn5FQQkg141pSpXhFA9xhG0v9nRQtow670jG7XVLeqAz1
 lMww01TH3wt78/COI5s0DRVlrNUHisiEzM/dJclwFk0KFk+We7hSf7WbZXX8I8vX+jJG
 ID04XdaQ22ohs1APhVKM0jdSNzjQWgFgSDlFLVdPKx0b6eDfijB8wX0QG97uUXcCi1/P
 OtmNViXNQHSWgXp6DvFCKe7OBG7nrdgUbbWxwV7k5Drg5/cllKRuHxGd1GM1WjYLbWpt
 3muy1GDUw4Ny2eXE5a5zQbPIVYT+bbNmYaSIwKeN6FhUNr5eUObAbO5+HGWAkp6B27gY
 9K0A==
X-Gm-Message-State: AOJu0YwjpTqooCCs/MUEwd9U+4TrEWYlbptfd/AdC/kyRtbK3VfrL1Lo
 HiTKDIYoEa6yZ+3e4Ndl0IxpHhHAHTKne1BS69eSxcboVKwXdC1E
X-Gm-Gg: ASbGncuqKzpe62bntHdQeXMH+DmY03AhEhHSIoS7WHLeEdEhyxeE1OHsVOm5K9QDuWd
 5NiJnDnUE8FZafkN+RFGji013KkXHSx/8ZG9HlDUKiZ8nst39kvSbDWh84Fw4/lqmnUKmI7YTPW
 HaZnIiBayWfsojRdN91B4qDVdWOQm015QA7Zm4pr9pPePy/tfWFa3nN8/FpetoCl8KnWvaSOWgW
 KwAmUAzM/xH3bLqZrPxRrefjLy6G3vCgYCD21iYFGOVyGiV9BsOzF3hs/TfMSKGfFQj5mwkP8b4
 PLhEZCtHLTPwJk6LctZX/HkIppdaK1Cd7WmEzGaFXYS3Szol0I9k9xWSDVBs5lqauEK4sILpzae
 QcRiML1TVXpyB0ABW4VbzkO9rM3rT
X-Google-Smtp-Source: AGHT+IEpCZy8B8dtzv5Fw+daDCfNNSzgNeSVmKsNw8xf4qRtFVTr9ChzoDHZnFQ9OKHePuipEhsrZA==
X-Received: by 2002:a17:902:d490:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-22e328a0d71mr22690405ad.4.1746500376889; 
 Mon, 05 May 2025 19:59:36 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1521fa63sm63019285ad.123.2025.05.05.19.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 19:59:36 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>
Subject: [PATCH 0/2] Enable DM_SERIAL for Marvell Kirkwood Synology DS109.
Date: Mon,  5 May 2025 19:58:41 -0700
Message-Id: <20250506025843.11019-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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


Many Synology boards (Kirkwood, Armada 37x, and Armada 38x SoCs) use the
PIC16F1829 connecting to UART1 to provide certain functions. Mainly
for LEDs control, but it can also perform hard reset, power off, and
sending beeps.
See dts/upstream/src/arm/marvell/armada-385-synology-ds116.dts for
full description.

The Synology reset is not really needed in u-boot. In
several Synology board u-boots such as DS116, and out-of-tree DS211,
DS411, and DS112, the generic reset function provided by u-boot works fine
without any board specific implementation. So reset_misc() can safey
be removed


Tony Dinh (2):
  arm: kirkwood: Convert to DM_SERIAL for Synology DS109 board
  arm: kirkwood: Remove Synology DS109 board reset_misc

 arch/arm/mach-kirkwood/Kconfig |  1 +
 board/Synology/ds109/ds109.c   | 18 ------------------
 configs/ds109_defconfig        |  2 --
 3 files changed, 1 insertion(+), 20 deletions(-)

-- 
2.39.5

base-commit: 0a3d2bde55e521352771c1c347b89e7848ceb744
branch: master
