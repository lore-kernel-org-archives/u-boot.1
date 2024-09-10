Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3B5EDE996
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 01:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9728F88A74;
	Tue, 10 Sep 2024 03:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Og7QqT12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE78A8890D; Tue, 10 Sep 2024 03:56:58 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EB888EC0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 03:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-205659dc63aso49198805ad.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725933413; x=1726538213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tQpYWg1a3lRaYzjkkHC6129T9zVudlzs9vPdxfzRF1M=;
 b=Og7QqT12ZPo9hruCSl39QhlwE7K5Hg2dgF+meub7NEdzC7AX59Y64tKVqeWpKt22Z4
 Wqzw3wMq+QnnNet5V1uqQJ1OAJB79rj5V8uTEu01e3uiuO7/4J4vRWcDSZp5i3ucr7pp
 K6QRllB3kFKhtr9zTJJ6iT8JbYqQgipTLHk3w0CPHrX5O42oclJ39+pStIp7KdQMVE73
 bbJ7sWdIGPZKrWkneUCJ2YNvh0v1dc+dUjg2wdmeZ1sr9Ogq5oQPEq4C1QkBXLO61MXN
 DQaS/Bj9Yt/cbzm3NzV47Ofk6ICR9/oQq0eyAnpjmgS1TU/m5G+B7c21n4diFQOtruxd
 SlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725933413; x=1726538213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQpYWg1a3lRaYzjkkHC6129T9zVudlzs9vPdxfzRF1M=;
 b=JTCCIFuakCd6ieIhgv2J8MO1K4DburlBCaDLW8ybFp8Xnd2Ho8UbfVkpOgrTzVo7tX
 6i+rf/VhWy7KwrwBs1KEAAOQG3z4dNkpTG1zkoAkjwnQ7p6w38qmlz8DUZl1BGF09QBP
 rpytsNqpth2w469QJ9ofMFy1bW/2BvxZlApiiog3pM41VChVdO1DVBDA85Jfy9vyWc2h
 PcU2gjKP53bu3pVrhKENf0rQ908HwaCiEC+jfzi6qsapB1HqxVjGQI/v8VEeY6NejjFO
 9869iCLRzkLyfJTg8GsONR5OSeJKyKcFtypYKUzD91TXe8uEWljRG0smkshBJEYP7q9n
 xBxw==
X-Gm-Message-State: AOJu0YwEZiiSeRzAGrEJjBidJ5x0gxywA/r5eUSccofirqSC6X+nkpd6
 Y9RPGLDFLq926F7LAts9QPqSz5XDyiLxzc2GlPbELilEBI20bN15eW9TCw==
X-Google-Smtp-Source: AGHT+IG+1Oh3Qc/nihKRI6IsYbX2eyN6fX5aM9mxvNdUIP2GA2Ex5pYhs1pCVq88o7r2U+AW3zvGzQ==
X-Received: by 2002:a17:902:dac9:b0:205:753e:b496 with SMTP id
 d9443c01a7336-206f04c7606mr149773095ad.3.1725933413404; 
 Mon, 09 Sep 2024 18:56:53 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:953d:9fc6:a5e:5881])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e350f2sm39347045ad.68.2024.09.09.18.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 18:56:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240909
Date: Mon,  9 Sep 2024 22:56:48 -0300
Message-Id: <20240910015648.760641-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/master to fix a boot regression
on i.MX8MQ, thanks.

The following changes since commit 7b2d4ecd7f6593771dd3118c8bab525d727a91e0:

  Merge branch 'master-spi-fixes' of https://source.denx.de/u-boot/custodians/u-boot-sh (2024-09-09 13:54:10 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240909

for you to fetch changes up to 9d921355d942091f24269602ca464864cb0719f3:

  imx8mq-u-boot: Pass FIT offset to fix boot regression (2024-09-09 21:52:15 -0300)

u-boot-imx-master-20240909
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22289

- Fix a boot regression on i.MX8MQ.
----------------------------------------------------------------
Fabio Estevam (1):
      imx8mq-u-boot: Pass FIT offset to fix boot regression

 arch/arm/dts/imx8mq-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)
