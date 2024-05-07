Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B802C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 10:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A021188737;
	Tue,  7 May 2024 12:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="O/+xkN4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D8D88748; Tue,  7 May 2024 12:04:37 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D420887572
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 12:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51f3761c96aso3810774e87.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715076274; x=1715681074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ooyOghp55MQvUrIhVr/XF6IdycWGZKqgwcNWa8CpQsg=;
 b=O/+xkN4FXCM1ImSAw8fjgFTpK58TWGy4SjiisWnXEyCvcNYC4Jcec3j73nWTLVt/6J
 XlaRNymMrTJ1/VUSIEDB6V2xrKz5KNRmiZ6P3KhWqIBxGW42qDFBMjtk23t68wKp0su8
 Vy8BNFEQR8LOyAV+KVJK2vqTddmACFwja9J+tvkTI/lX2pWh5KRkTRdUJiE8CWQDnVL3
 fckAnJJxltuMTA2YuU+ohlCii/86eUGGyjB50mgq6NV4Z8Ka/n4w/SQ2CKgjWhgJREC2
 02LIAf5hW4z6ezOiWoLir+hrxFdLLQGTZwKJxBVXh3nh8Zr0IXAn4oe1seXVblsJnUE8
 6sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076274; x=1715681074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ooyOghp55MQvUrIhVr/XF6IdycWGZKqgwcNWa8CpQsg=;
 b=G+WbOiHdCkeuiFlyCVsNZ3lIm5vUy0eSTDTl50smCt+9gbMxK7NgbjyCemXgzkSQoW
 nIPhulTm2EXLYJ7NhRdNz1wrbqaHCtT7n4FEpxTK62XvcYebxoWhBdZDLVZIseq1oB9Y
 zPE0BuKiYMOdh1OdwtMxmgjV75P7yaI/HV+XhLdTa1AgrMsI4JXWAI1DcbgicYfPQjWJ
 Tv9q9qhVZv6adhx7fU2rXQQDg0kyHGWP2tLtzBydRS7hWnRfL+P8vr0OuNyrrKa1t43G
 xYAVc21zzjH2qEm8YgXvT4X8+8X/uHMXrAGM/SXpVJAB5qGqX+LRcJT5KtZREshYQWrX
 0N4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNZkXgoU1VJN4MpuL6SKANvhnAm3BOKTMzpWkKHMW5kwmfrxt8Fa/+uG1IJ0+IOE9YGsK3Rhuf/odkVBKHGHVdTv6J3g==
X-Gm-Message-State: AOJu0Yx7XP6pKbb3aRPQx6AI7Cu3LC95Adli0qSiqr13fvrcGYjTr0la
 VDTTXF8hdQetlfR1IzcmRAH3Qy3DddwmEDs98WYy9Wsi7BDVFhwCywtCCuFTriY=
X-Google-Smtp-Source: AGHT+IHMBQtTq2lIPr94JO5XWkKP7mftuaSyozsK8iBQ0umUVJf7WEaz5gHqjP5iTVJSfV6d1hEfDg==
X-Received: by 2002:a05:6512:130f:b0:51b:1e76:4ea9 with SMTP id
 x15-20020a056512130f00b0051b1e764ea9mr12593961lfu.4.1715076274035; 
 Tue, 07 May 2024 03:04:34 -0700 (PDT)
Received: from fedora.. (cpe-188-129-46-59.dynamic.amis.hr. [188.129.46.59])
 by smtp.googlemail.com with ESMTPSA id
 s20-20020a170906455400b00a59c4a16e4asm2878350ejq.120.2024.05.07.03.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:04:33 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sjg@chromium.org, trini@konsulko.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [RFC PATCH 0/5] Implement exiting 4-byte adressing mode before reset
Date: Tue,  7 May 2024 12:03:48 +0200
Message-ID: <20240507100431.206670-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.0
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

This fixes the issue with 4-byte adressing mode being left enabled on
board reset.
That is an issue on Qualcomm IPQ4019 boards since the CPU expects flash
to be in 3-byte adressing mode and will just hang otherwise.

Note that this does not fix a case where you remove the power while U-Boot
is still running and in that case it will still be stuck in 4-byte mode.

Robert Marko (5):
  dm: core: add on_reset method
  dm: core: introduce uclass_id_on_reset()
  mtd: spi-nor: rename and export 4-byte adressing mode function
  mtd: spi: sf: implement .on_reset method
  sysreset: call .on_reset for UCLASS_SPI_FLASH before reset request

 drivers/core/uclass.c              | 13 +++++++++++++
 drivers/mtd/spi/sf_probe.c         | 10 ++++++++++
 drivers/mtd/spi/spi-nor-core.c     |  7 +++----
 drivers/sysreset/sysreset-uclass.c |  7 +++++++
 include/dm/device.h                |  2 ++
 include/dm/uclass.h                |  8 ++++++++
 include/linux/mtd/spi-nor.h        | 10 ++++++++++
 7 files changed, 53 insertions(+), 4 deletions(-)

-- 
2.45.0

