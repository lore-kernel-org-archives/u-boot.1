Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C565CC61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3A21406E0;
	Fri, 28 Aug 2026 10:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zk7XZd3pxQWV; Fri, 28 Aug 2026 10:52:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914338;
	bh=TXTCjRXJc67r07BWfSIc0btz3KZIxiLW/VYIM/8Ybuc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uEI23o/kzDgTwdAVcpGvOeH5iLER2k24saDml8wBdEfljj3u9hHvohFe+dez0Rv5T
	 BSqXnY7FZD0JzaOBQyetUtRKipLotK5vlGnl10OUuq4xrtZWZNaRC9SKJOKEG3/ZCw
	 lIYPjXrTcCHLR0Uw8tnQCQWKjYC9m8aWg9TwgFHEnqobuZYRu3CszFXgtbmbrkwVaq
	 2kVfBjbfoOW14Kowpj7S/IsazIZZsPu6OdFvZuikRa2j1DBE3ulk9UhSnPx7f1wE3/
	 zj0/mJ8h1epaB+YY8j9rHYax4TIqh2rmFlnAsdlXyDX6p27V+stAwyB+TkHWTll2LF
	 jnyDuZtZRM5SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BD0240471;
	Fri, 28 Aug 2026 10:52:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96A67105
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 886C6606B0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S09wvrXX7h1t for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:52:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=frGS1L/e
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C373760663
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:15 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-482e5733a5aso521007f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 03:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787914333; x=1788519133;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TXTCjRXJc67r07BWfSIc0btz3KZIxiLW/VYIM/8Ybuc=;
 b=frGS1L/eEK27kRcYon4OAIhhKsH8GBDCN63C8bGhjX8+qho1EK/ijPEUQvVR16amcO
 9ZwQpXZgsMki1e1vcNge33ga9TueIu25nZQ83bZCVZ2DyoWZW/rLpVKe+Zk/BH+hF/gz
 PdCw/rLOUa6BPCjCl+isNd/EubAMSRVbovHHeFKV4Ereulg7SEcAPqswIc73dbm4jjm9
 JgoHCpINJws1n8cS0vb+MbfJGMq4dcsJ8w1o0WBua5ei+hi8YDzm7sFmFy2ziP0LBdzD
 10dv9F+o6PhvpkmANMRjj9inu+/4aQrSh7aJCFqoO5GVKopGSsMzG3XZWZX6te2wseHo
 S1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787914333; x=1788519133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TXTCjRXJc67r07BWfSIc0btz3KZIxiLW/VYIM/8Ybuc=;
 b=GPf80WzDNRqQXJV65D10NpiGwOHxRJtdCFkX610CdSPTVek7x8gwMId9n7Ufu9eBkj
 fjgDmfKBXndo4S7AMMbkkNwe40YFzjKk8qwz/Kn3e+88QCZ8fIQaiFJbBrSDpmEk8BX9
 DmBYjQtX292l6CQGENtWMM9au6f2W3ivxq3M+aZx+RiPggRPHoUHL3YChygGLZGd6mEZ
 r93c1Eg6ChmN4F5qKF4WSzG8xw9f7xCculKnRhhlQdfSdpBl4RmCfvQS8s3K0/ciO/KY
 6UNvWXGqSeHJBG0xV4DWQFXgtMX0TEZzxCW+0fMb7MlisW/bCcqMC0yqp3hLYqGSZuOS
 75xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS45OphTNjrKpqnorGrr5XaiPbm8W/2Ed7kx13jtxP8vAJnzSevOWEJYkWaxSsNmHczLz/yaM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lNbH+j+Zv3n/kqbaH9oIhBqrOKuFBtidJvFns3gvpE9aZ2lB5P
 /bl5Ytn8tIHJBFllDMA6PWvQkoDR0T4gGJi2gyHVdQGZOeGEtODLA8Gh
X-Gm-Gg: AR+sD11aJo6+s3ra7HE+Qs1+uJbyt19m473i51XirllFG/a6CVJRi+SbJlnxDt9nyyS
 PIvfBz9MApIFQtCmk2Uq5q0GdY6eTgNs4WQ0Q3AEwkkTOBmq9R/cKd2JqjW4C0m4qZj1SDl69WL
 cVH/2agSWeUSYwYMOT78pTxpzA3d1doFynI8H60rpOL9WidU+TfjXx2O2RLZeAhzwn9x3/IA5iJ
 jst2vhVLe6ngSCJvmxIhP2YNhACp8G9BMSgc9khMafI/tKwFvvTjJ2owDILI6Wa6YNAxxIel+/3
 Me8SZnDXW38n66P6tC7RrllQz5J3nB07TTWL/zJSGU0LTVhhqc9tnBI3dF9nk9r9zya5OQm1rkI
 VE32gTiEA5FZbPtr8nNtXxKS/4gORiNQyHhH6BHIz7wiLD60AQyo7EhFoZU0vQL3aejZVF+WUKU
 fiikEdYPa+y/4rfYYYJKdchL1Z12tCRWGlc8li7Likbj5NzJ5HOhizakU9BvNitPCWx95Xx/G7x
 huq
X-Received: by 2002:a05:6000:2205:b0:481:98d:b24 with SMTP id
 ffacd0b85a97d-482f7a25ca8mr9465871f8f.19.1787914333044; 
 Fri, 28 Aug 2026 03:52:13 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm3212202f8f.1.2026.08.28.03.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:52:12 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 0/4] dm: gpio: read GPIOs in of_to_plat(),
 request them in probe()
Date: Fri, 28 Aug 2026 12:52:06 +0200
Message-ID: <20260828105210.32664-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

This is the rework Simon asked for on "dm: core: read the device tree
into plat data after pinctrl" [1], which is withdrawn: moving the
of_to_plat() call around was the wrong fix, the real offender is
claiming GPIOs while platform data is being read.

The regulator drivers request their GPIOs from of_to_plat(), which
probes the GPIO controller and claims the pin before the consumer's
pinctrl state is applied. On SoCs where the pin direction lives in the
pad register - the output buffer enable on Vybrid is one - the pinctrl
then undoes the direction the early claim just set, and the USB VBUS
regulator of a Colibri VF50 powers nothing.

Patch 1 adds the missing tool: gpio_parse_by_name() reads a GPIO out of
the devicetree without touching any device, and gpio_request_parsed()
claims it later, from probe(). Patch 2 moves the regulator drivers to
the pair. Patch 3 writes the rule down in the driver model docs, and
patch 4 adds the sandbox test: a fixed regulator with an enable GPIO,
checking that after of_to_plat() the GPIO is still unclaimed and only
probe() requests it.

Tested on sandbox: the two new tests plus the full gpio and regulator
suites pass, and a full "ut dm" run shows no new failure against
origin/master. Tested on hardware: this series with the reworked
ehci-vf patches on top, flashed to a Colibri VF50 (plus a cherry-pick
of the TEXT_BASE restore from u-boot-imx/next, which master does not
carry yet). The VBUS pad at 0x4004814c reads 0x00000060 before
"usb start" and 0x000022ef after - the pinctrl no longer undoes the
claim - and a USB stick enumerates as a mass storage device on the
previously dead port. The board still boots its NAND rootfs.

The Colibri VF50 fix itself, "usb: ehci-vf: enable the vbus supply of
the port", will be rebased on top of this series.

[1] https://lore.kernel.org/all/20260819143543.427396-2-mehmet.fide@gmail.com/


Mehmet Fide (4):
  gpio: add a way to parse a GPIO now and request it later
  regulator: claim the enable GPIO at probe time, not in of_to_plat()
  doc: driver-model: state that of_to_plat() must not probe or claim
  test: dm: check the fixed regulator claims its GPIO at probe time

 arch/sandbox/dts/test.dts                  |  9 ++++
 doc/develop/driver-model/design.rst        |  9 ++++
 drivers/gpio/gpio-uclass.c                 | 33 ++++++++++++++
 drivers/power/regulator/fixed.c            | 11 +++++
 drivers/power/regulator/gpio-regulator.c   | 21 +++++++--
 drivers/power/regulator/regulator_common.c | 25 +++++++++--
 drivers/power/regulator/regulator_common.h |  3 ++
 include/asm-generic/gpio.h                 | 51 ++++++++++++++++++++++
 test/dm/gpio.c                             | 29 ++++++++++++
 test/dm/regulator.c                        | 29 ++++++++++++
 10 files changed, 213 insertions(+), 7 deletions(-)

-- 
2.54.0

