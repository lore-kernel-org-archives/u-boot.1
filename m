Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D327ACED276
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 07:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD89288E1B;
	Tue,  8 Oct 2024 09:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="NrIVvsrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA21688E2D; Tue,  8 Oct 2024 09:54:44 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC1E8889FC
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 09:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37ccdc0d7f6so3406321f8f.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1728374081; x=1728978881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZssWG2yCMgfZayTNxVwxK33Z1f3GzxU76tMnI8P4LlA=;
 b=NrIVvsrA9no6lB2d3FUV5zlVrHbzpbn1fTkIbNmaOu+rwcKRgUy5P1wGyUKBxyRPO7
 ++R7HoSKe7V2/mv6X8kA2ivGTzMVcW5slGn877WiS8LI0KMPR7iNTuNA+lX4atK5CYlm
 80VZ64E4FyTLcdsjMDMMmjWa3slci1+nKPQyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728374081; x=1728978881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZssWG2yCMgfZayTNxVwxK33Z1f3GzxU76tMnI8P4LlA=;
 b=N01XxZ/2HvAy5KPIW4Qcpj+FQ5Vg0X6YwSO/bctnhq11u6QFr9yVpCiASAxuCHQqdV
 xl5ZhceNuy19gYdHYognnrl0HSNnSb8GkVXF4IKybOYwRdxTMRACQ0Ctw31ZnjhcA5yC
 NnA/VGw7xqzLJ/BIUKXw9tIniKnB88LjB+p5pbik3Dk0RnS5mjZyjE/aWYY7I94PmcYp
 FU3Sonw1stsbU226eQR0X3EAu0UZ+FBPkyRGiXCvk3TZDTByzadC18T8mbPyJ/9qfnNz
 8KrJAMsGWM0mWuR8yBvEd7t5g1uXd8qey4htUuxfRXwxEV0pHdTQBKM8ckRhR7QlTbWJ
 CF7A==
X-Gm-Message-State: AOJu0Ywv9zAwAmE4NlLrivpw6fvN9cRdhjMm15zLWhW+QnMsdb2LDhdH
 2T5hO2KH03H3CrFvkWtmxuGztqjAUctNOfrl2M9/q/pkR0wVBQG6QIK7GNY8HQ4b4NPPnv4pNq8
 U
X-Google-Smtp-Source: AGHT+IEtt4VaLWzG3BK/Zb2ipl2KBVWnN5mWSKfCIC9PMx2rkyOojcwLBpIMoPTws6SkK0lIppVJ+Q==
X-Received: by 2002:a5d:56d2:0:b0:37c:cfb6:37b with SMTP id
 ffacd0b85a97d-37d0e6cae8amr8891353f8f.7.1728374081015; 
 Tue, 08 Oct 2024 00:54:41 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr.
 [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920195sm7403328f8f.50.2024.10.08.00.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 00:54:40 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 0/9] net: ksz9477: add support for KSZ GbE switches using SPI
 bus
Date: Tue,  8 Oct 2024 09:54:23 +0200
Message-ID: <20241008075435.1572727-1-romain.naour@smile.fr>
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

Hello,

We are using a custom board where an ethernet switch device KSZ9896 is
available. This family of devices can use several types of serial bus
as management interface: mdio, i2c or SPI. Due to board design
constraints and because we initially planned to use this device only
from Linux, the SPI bus was used.

Luckily we are using a recent enough u-boot release where KSZ9477
driver is available... but only for the i2c interface. Indeed, unlike
the kernel driver, the KSZ9477 driver doesn't use the regmap API to
access the underlying bus since the regmap API is limited to direct
memory access [1].

Until regmap API with bus support is available in U-boot, we introduced
struct ksz_phy_ops to store low-level ksz bus operations (I2C or SPI).

This series has been tested on the current master branch (after v2024.10
release).

[1] https://source.denx.de/u-boot/u-boot/-/blob/v2024.10-rc5/drivers/core/Kconfig?ref_type=tags#L188

Best regards,
Romain

Romain Naour (9):
  net: ksz9477: move struct ksz_dsa_priv *priv declaration
  net: ksz9477: remove dev_set_parent_priv() call
  net: ksz9477: add KSZ9896 switch support
  net: ksz9477: rename udevice_id tab to ksz_ids
  net: ksz9477: set i2c bus offset length only when needed
  net: ksz9477: store ksz bus operations functions
  net: ksz9477: rename ksz_i2c_probe() to ksz_probe()
  net: ksz9477: prepare ksz9477 without I2C support
  net: ksz9477: add support for KSZ GbE switches using SPI bus

 drivers/net/Kconfig   |   6 +-
 drivers/net/ksz9477.c | 241 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 223 insertions(+), 24 deletions(-)

-- 
2.45.0

