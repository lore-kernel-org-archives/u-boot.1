Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29103E748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 05:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9128709C;
	Sun,  1 Oct 2023 07:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AUIb8Obk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0CF38709D; Sun,  1 Oct 2023 07:40:56 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8778709A
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 07:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ADF5F3F6F3; 
 Sun,  1 Oct 2023 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696138853;
 bh=cw9PZC9aUbw0ikm/OjWGhOz0dgq+sJTvO2vCWqWHXU8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=AUIb8ObkMxJuuFziPEyqu2f2BmLYbyCa04unTJpvTzv1OVAr4CRt32yiPIy14w8lK
 WiEfwFJ9Ofrcb1wjEKArWh92kQuPCpKfiK7oa6MxJA8zjQf6o3beSy7HPNhgt6lV37
 w9ywsq6Qz78qRhGoEUEK2ZoIKq6CUM2kP8RqLD/RBA3piQt7flHSJ9FQqBC3aoXhBC
 IaDIxhfv1kkQLwveyxP92BUA8yVFaiAP/CCHnWMQ/NOerWE1BLF7r8o0+tJ+5PUILc
 JQMFdWzCw8eDMMOI6/1JUz5kI6J22DS4SqYHC5mPpGv6wCRANpVQbkwrdwjk3CJQ0I
 xTJTVekGIdzTQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: sifive: enable poweroff command on Unmatched
Date: Sun,  1 Oct 2023 07:40:47 +0200
Message-Id: <20231001054047.9054-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Powering off the SiFive HiFive Unmatched board is supported both via the
SBI and GPIO sysreset drivers. See device-tree entry

    compatible = "gpio-poweroff".

Enable the poweroff command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/sifive_unmatched_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 867611b6b4..71c0fb3932 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -47,6 +47,7 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 CONFIG_ENV_SPI_BUS=1
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-- 
2.40.1

