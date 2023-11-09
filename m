Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6027C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 16:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E61D486F7E;
	Thu,  9 Nov 2023 17:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hS6xtOFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA258723E; Thu,  9 Nov 2023 17:25:10 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5839686F73
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 17:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so958239b3a.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699547106; x=1700151906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i9IH4VkZ6p8R4U0ERpbqnj02uWVnOc5045zatZEv2qE=;
 b=hS6xtOFTe16D2hk+6CpBrt6HC3OIvRdo+PdfQI2knyWksnyL3qQySQ9DLTOOMkM5v6
 2Wo4aDofbpg9aC59CiNSPDHe2mdw8uE5zOpPtAI5AnVp5+kJAGt+pxijwjpZaXxTw1tL
 bDio7mDAYBiq3Win5VWCfd/mHmvM0V9BBNdRLMJQzVfN2dHYSVmoiLh1gifMrpaXxcbx
 tCLqLjmHQ8H7oism794W6P2v3Np6hLfIK4WTH7j4qwtVBTlMEznB2HVqdytgmBZBYJ95
 AAA7CB9BNw63+pYDFZ43tNXFY9HNCnzmU9bQdI9JSN7atcGQd9vl61N9+K+ljnief39X
 OUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699547106; x=1700151906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9IH4VkZ6p8R4U0ERpbqnj02uWVnOc5045zatZEv2qE=;
 b=tYcoTkDmRT5Tjfww8lneOi+d7THMDvj9LxiPWVEJryeZztSU6y2IYHbQQKfcdSqZgM
 Rkr8tVHvguT5TKLLHYqrOQxhZKq9aWt8ecZ3y3B9/HeNWzsjA04wKNgsPtBwmY4Q1w8K
 5xnTp+gXFOFQTQ5CTZLvoFJyG5bXl2y+iTJ7dzHqEn92Hal3ZUkilm7Wfgthr7M6aniA
 Ml+OGGfH/5OJ8oFkVZSUPEUX/VrDYdveb6Wu/OUl4L2vowyszV+ODuqbptGkeMXyQKnx
 FZqNic3IMH37Dr9SqB1eZJnGeG9YDkFjxyxX/cvJMbwD0c/StS4aBbIJ6xQQHvjFF5ix
 k8Jw==
X-Gm-Message-State: AOJu0YyvZ63cz5mmnDAls2l/Qrox/1TM1Aq25VzmyhmrBwFUw4EV1fyI
 o1MDLGZUYWtBD0gFH5Y0Ux4=
X-Google-Smtp-Source: AGHT+IECIjK3dgYZIwtis4l3dPR7yjBrfn0mrzmOZFchL0XRczfAhIv7B1POWUVImw+NMlD5b0qmTA==
X-Received: by 2002:a05:6a20:daa5:b0:181:b87a:b8ba with SMTP id
 iy37-20020a056a20daa500b00181b87ab8bamr6451220pzb.53.1699547106281; 
 Thu, 09 Nov 2023 08:25:06 -0800 (PST)
Received: from debianfranco.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056a0015ce00b006c345e192cfsm10908304pfu.119.2023.11.09.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 08:25:05 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
X-Google-Original-From: Hiago De Franco <hiago.franco@toradex.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: u-boot@lists.denx.de,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH 0/2] apalis/colibri imx6/imx6ull/imx7: Add fastboot supp
Date: Thu,  9 Nov 2023 13:23:59 -0300
Message-ID: <20231109162401.38941-1-hiago.franco@toradex.com>
X-Mailer: git-send-email 2.42.0
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

This patch series introduces Fastboot support on all Apalis iMX6,
Colibri iMX6, Colibri iMX6ULL and Colibri iMX7 machines. It includes the
necessary configurations in their respective defconfig files and
implements logic in the boards files to determine whether SDP or Fastboot
will be utilized.

Hiago De Franco (2):
  apalis/colibri imx6/imx6ull/imx7: defconfig: Enable fastboot support
  board: apalis/colibri imx6/imx6ull/imx7: Add fastboot bootcmd support

 board/toradex/apalis_imx6/apalis_imx6.c         | 13 ++++++++-----
 board/toradex/colibri-imx6ull/colibri-imx6ull.c | 13 ++++++++-----
 board/toradex/colibri_imx6/colibri_imx6.c       | 13 ++++++++-----
 board/toradex/colibri_imx7/colibri_imx7.c       | 14 +++++++++-----
 configs/apalis_imx6_defconfig                   |  3 +++
 configs/colibri-imx6ull-emmc_defconfig          |  3 +++
 configs/colibri-imx6ull_defconfig               |  3 +++
 configs/colibri_imx6_defconfig                  |  3 +++
 configs/colibri_imx7_defconfig                  |  3 +++
 configs/colibri_imx7_emmc_defconfig             |  4 ++--
 10 files changed, 50 insertions(+), 22 deletions(-)

-- 
2.42.0

