Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721D0EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 15:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C98EB86E54;
	Mon, 11 Sep 2023 17:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JBAtoUE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485FC86759; Mon, 11 Sep 2023 17:34:36 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B698B86E52
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 17:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jamipkettunen@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bcb0b973a5so74577601fa.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694446471; x=1695051271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5WBCFLjAu4dqGV8N+r+BNvytA3LguZF2X6pbZIGGKxY=;
 b=JBAtoUE7jDSISumhG2oukupfroT6LxLext8gmdmm7DsCIYyXfLZLZ08IG5JWc0q35H
 Lel5zCB+oUdSJz/O/IMGi6oUwT3stjB3cjhp7lnujKY5YkaMVHHlw0Pt3M9F6nqISIhW
 mrcu+a21h6Lep3L3uhQ9QG7Ut7WaeFiMW16kx+DkKmfOBUht8v1DKL0Z2xH9mg1dQa0x
 W5FTBlqwaWomWT/cSLtkMKIdBn7oqk+I0KYhtuPuVnGA82hoLyjgxwc11d0jaTI7Xsac
 GBwM814/C93TYppICZj4+Y5Dk76iHhmJKLEhCxSaVwoHfXkRJn9r3Rtu8CjvJTw/ftfb
 7QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446471; x=1695051271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5WBCFLjAu4dqGV8N+r+BNvytA3LguZF2X6pbZIGGKxY=;
 b=uJYCQIX+pMpMeKfjTowVtS+jvHbEw5H9jPTYHquhfCkSniSp3CDu9d/8hvoojSAH+S
 Mr8ivXlOOSbJfLkdsZn3hqnErC1nycODnAmQ6zAQG8Vk/PIWLPgvg0OpecC1MQu3aKpi
 m09fp8T3OUwItyrnlvVBOXMtyCm5yy1ZcKuHkhDX5yfndhcPcDTWQe4vXwIBs+ED2tG3
 o7n1H0e6G9ZXubW+z3bPIZMQZcUFF7WXpUTHn4+1mQb+IGDG9//lbgm9S+OqVt+lkSE3
 uAbJZBS6EZvrbDDAaLXnWUEQi42XKha21Bke608bTrvWXnRj5lfEDEisEwatP1Isb6cn
 GHZw==
X-Gm-Message-State: AOJu0Yy0CEIINOMynfwJkEeILSsC35RLKDoMKipjI5oTIt+tyFs57kuP
 kR/p3Y04Bi0ndKwAFmzAtE078Jk9ZOSH6g==
X-Google-Smtp-Source: AGHT+IE8wt7WmUEdTRUi/HtrgS2er6/qS/g/yC/wizzykIn/eWRpgRt3Y9zyo/z7WD8IS7RP85bulQ==
X-Received: by 2002:a2e:8016:0:b0:2bd:1f81:fc47 with SMTP id
 j22-20020a2e8016000000b002bd1f81fc47mr8348280ljg.22.1694446470738; 
 Mon, 11 Sep 2023 08:34:30 -0700 (PDT)
Received: from localhost.localdomain (62-78-201-188.bb.dnainternet.fi.
 [62.78.201.188]) by smtp.gmail.com with ESMTPSA id
 x20-20020a05651c105400b002bcebc7713bsm1572280ljm.120.2023.09.11.08.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 08:34:30 -0700 (PDT)
From: Jami Kettunen <jamipkettunen@gmail.com>
To: u-boot@lists.denx.de
Cc: Mason Huo <mason.huo@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Shengyu Qu <wiagn233@outlook.com>, Jami Kettunen <jamipkettunen@gmail.com>,
 Jami Kettunen <jami.kettunen@protonmail.com>
Subject: [PATCH RFC 0/2] board: visionfive2: Select fdtfile based on revision
Date: Mon, 11 Sep 2023 18:32:34 +0300
Message-ID: <20230911153253.20701-1-jamipkettunen@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Sep 2023 17:46:53 +0200
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

From: Jami Kettunen <jami.kettunen@protonmail.com>

Currently booting a mainline Linux kernel via extlinux with fdtdir set
doesn't load a proper DTB but passes on the U-Boot one to the kernel
which as far as I know is very incorrect and prevents user (normally
distro) provided DTB usage in a sensible/generic way.

A uEnv.txt or similar manual environment changes were not used and
should not be required to boot the board as per:
https://u-boot.readthedocs.io/en/latest/develop/distro.html

This also currently needs a kernel patch[1] for my board to have the
full 8GB of memory available to Linux instead of just 4GB it shows with
these patches alone.

[1] https://gitlab.alpinelinux.org/nmeum/alpine-visionfive/-/blob/main/starfive/linux-starfive/set-8GB-RAM.patch

Jami Kettunen (2):
  board: visionfive2: Select fdtfile based on revision
  configs: visionfive2: Enable MISC_INIT_R

 .../visionfive2/starfive_visionfive2.c        | 25 +++++++++++++++++++
 configs/starfive_visionfive2_defconfig        |  1 +
 2 files changed, 26 insertions(+)

-- 
2.42.0

