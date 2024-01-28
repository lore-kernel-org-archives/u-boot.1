Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25483C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 19:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39477879F3;
	Sun, 28 Jan 2024 20:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZmwZDGt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783E787B13; Sun, 28 Jan 2024 20:23:37 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E74879ED
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 20:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tekieli.lukasz@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so181723066b.1
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706469815; x=1707074615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GP4u4YshRIVXdR9PyPfJdODv2yI7kCWt050WFm9uXGI=;
 b=ZmwZDGt66w2MBmO/ViukaaC0/NStZ15VmhUmnqxa2F2cWFU5TaXw9DIjp4czqTAG83
 2vrfDEhqC6zZVdw8KX1LWTa5PgCMczxxso4lggLrchi3K+018UwgqjVCxO9BuhfXxxUP
 rVcVcsNqzkmZx5f9M33P+VsLwnVbJpZHpPEY1ePe3j9IdqRBBMFoa8ShM9PrmaZmamwy
 xIttz2glMeZjOXqEuGIVkcdgfMQJ8ikjnhjJjgcNyO+W4KqOyUxNP/5/azcQupJerCAZ
 XDT5XI1/fk1VEM9S6RmkkkcPcwt2nZUOckEiE4NcoY1WkCR70WFLICOgfLlxAAyU/oi2
 3iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706469815; x=1707074615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GP4u4YshRIVXdR9PyPfJdODv2yI7kCWt050WFm9uXGI=;
 b=XlDiZhJU3Rzq4ISMN//AYus1LBTAU0nIDGitrQeOWM9E7WbgJ5hGncYEkwd3RYL+FV
 YN9bnTp5i+2f109cnqXosz/ZIYJjn/0uMBI/kjvcaLX5NDSVkzUAycnYqVkL5L94ifpr
 Dma8X+qUMlAMJr2WQMvQqrJEhAD4fzTZiSVSpZU52kCA8xroXW+c05MU/ZVbA8Uy6qx0
 lFOMqhypZePRzZlHfwxiXZsCRiVHky1pDrFtQggVpppP039R3t+Q02rhbzHlwU6V3GEJ
 veIqVXtoasKySN0eA9zy66RJZlQSXgJIY1adTbWyNLHxCkVx+QAoijRsyMLQaSo1Rqif
 NT7w==
X-Gm-Message-State: AOJu0YwP1j/y7uP3pxe3LhCQuxTcM0s0tMm+sX3ENavGEV9K1pRZxOP9
 uUQKd2dzEx+HCjBiwxI9dFs3PiZkmPCEVH2U8nLzy8wxx/X+P5hN
X-Google-Smtp-Source: AGHT+IE0O7ismJ3QSUEb1cKXNenqqjYOphKnscjpfR9jXA2bYVxMFVrnCKk588VXXkArvEwJaII9cA==
X-Received: by 2002:a17:906:3c59:b0:a35:2841:2aaf with SMTP id
 i25-20020a1709063c5900b00a3528412aafmr3193906ejg.38.1706469814816; 
 Sun, 28 Jan 2024 11:23:34 -0800 (PST)
Received: from yoga7.fritz.box (ip5f5bff47.dynamic.kabel-deutschland.de.
 [95.91.255.71]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1709061c5100b00a3472da6696sm3107999ejg.159.2024.01.28.11.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 11:23:34 -0800 (PST)
From: Lukasz Tekieli <tekieli.lukasz@gmail.com>
To: yanhong.wang@starfivetech.com, trini@konsulko.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com
Cc: ycliang@andestech.com, sjg@chromium.org, chanho61.park@samsung.com,
 frattaroli.nicolas@gmail.com, u-boot@lists.denx.de,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>
Subject: [PATCH 0/2] board: visionfive2: add pad drive strength config
Date: Sun, 28 Jan 2024 20:22:46 +0100
Message-Id: <20240128192248.64407-1-tekieli.lukasz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jan 2024 20:35:18 +0100
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

gmac0 does not work correctly with the default settings of the pad
drive strength. 100Mbit link does not work at all. This series fixes
the issue by porting the pad drive strength register configuration
from the Linux driver from commit
67a8976780858461b3c2d0dc501d207452543c53.

Lukasz Tekieli (2):
  net: phy: motorcomm: configure pad drive strength register
  board: visionfive2: configure PHY pad drive strength

 board/starfive/visionfive2/spl.c |   8 ++
 drivers/net/phy/motorcomm.c      | 130 +++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

--
2.39.2

