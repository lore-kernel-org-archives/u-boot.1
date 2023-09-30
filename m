Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EE1E77372
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 12:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D22E87019;
	Sat, 30 Sep 2023 14:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="h2Uwop0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C43578702C; Sat, 30 Sep 2023 14:02:24 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32A486FD3
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 14:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8351B440AA; 
 Sat, 30 Sep 2023 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696075340;
 bh=9hrCWFhS+DQT72CYzcY7UANA/8KwkJFkLWnc857HsUQ=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=h2Uwop0vSODb42/1kZiDN7+odVsyrOwNhBuz+zM6DgCYiQzmBXai8FU1RNdFORaug
 O/b+DsaW6OT8fN5boGa+dhugDQqFnCm/8GT4R7VL9/HCUdIYJIWRsZbvIrNRlRMmJT
 Ej5ksYD+xXjGsVEiZYnzRAzQfl1Jc/GGxicljGbyXR13sljtqxelS4AMySL5jlRwoN
 +z06+52UiQc7PMGM+BWkYpczbPIHVwy1GCpWoz+WcfuFQex0Q4jmNJcLO00nxU3tDp
 P3btnfiVp54sgvh8CZPn5MDMocOasjl6mumMjXcVBZIiezs01A/nbKoxWcDycQmhhN
 rkzsvJ4kBYm0A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/6] eeprom: starfive: raw dump if unsupported data version
Date: Sat, 30 Sep 2023 14:01:46 +0200
Message-Id: <20230930120147.59482-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
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

If the data version field of the EEPROM is not supported, provide a hexdump
of the data.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 8d99249279..329fbf6644 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -190,6 +190,7 @@ static void show_eeprom(void)
 		       pbuf.eeprom.atom4.data.mac1_addr[4], pbuf.eeprom.atom4.data.mac1_addr[5]);
 	} else {
 		printf("Custom data v%d is not Supported\n", pbuf.eeprom.atom4.data.version);
+		dump_raw_eeprom();
 	}
 	printf("--------EEPROM INFO--------\n\n");
 }
-- 
2.40.1

