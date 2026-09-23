Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F422AC98312
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 02:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97F8840D94;
	Thu, 24 Sep 2026 02:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Swvbz6kNuDxk; Thu, 24 Sep 2026 02:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 66A5740DBB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790218570;
	b=HS7YAH03chYeEnO2HIhUFG7HsGcMf4SpAVeVNHoHxDkylCnpW6knhEXkrSo63rcHpcu4
	 oEbKbuj8sbbfu2aA683sKqp5SZgSjbHrHU8fTTdv61hwtJZ+hJ+U6s+Z8dfyipzrJbQ3n
	 NHtdhHcelUmFGmAm3+IbRLopdAIPSDcFm5MNT0jiZaieBR6CzbT9KQMtru4balXWTQrDu
	 DfUo09iin4mK1g/UXz4BFo5GiLeNesgWvz8MA76GIgCXYDdxmrPDD9iLSTaPJ8KJG6s/B
	 PHa5Bq/iA21e/cHseQaQ8jJS2MOh1Z7XE7/P3UibDKRtR1T36XRxRkMnEMyOr9r/h5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790218570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SkMQ7jv4DfggjO2d01/mePQzViIkrTiF6H98kkTXeKo=;
	b=Wkec6D1uOsB32Igv1T5SqWbSRIp+Y0Y64dmUxLvRLc00zMBnRouYdb4nJ9VSgTyHSI03
	 ++5xhKk74hO9d1+hiTQuIzmIgbFSEHXt9YD0v7+MDvfhqyN+Q9FNCDE4RwlU52T3bsW3a
	 kGtyQPKRId2UexfMIFzUwPqquaG85Q6Hvgr8/iJzvvRFbSs/WqX0fyPzBj/4EWOOpbLrA
	 dUYuF9EkrhFO/Lt4tr5melNWyQVXsQzEHfwYhqsvO7izIyfJtGHCSwVbjQuilIRMtlT3Y
	 AMe7zj20an9uTLFEbAw7cTAeYXdRL46z5XCzyXDD7C+q+uugxyF9tM39jEkyPD9Bssw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790218570;
	bh=SkMQ7jv4DfggjO2d01/mePQzViIkrTiF6H98kkTXeKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UwJr84RPPVyyjPnhGyCf1J6m6E31n1BKy+/XJkA2j5SKbshYDAhYUEeZ5+eEGsKJJ
	 9YPbjlBEeexmnuMQpzGHSq/ldqR4IaGY4DcLhr6/i/9nZvEN7M8j7fdwmzjAeTI0FO
	 meuBa5F9D4cnOP9qTkfdxosQOuRfVh3q86118wFFBZncNo5J+La5DB1/dFrzZVNZGm
	 aUBwtDg+bdWmEsAhdI1xtyrxuG/nweoP0M3Fs+5ivNRerWS53zgXCW8eOFdBQlUB44
	 rO8bFG+tM+qEs1VCJuscIuVZH2zrZdIXmwcYpwSMH5LvhPtz8voSOxVEkoM92/wm0l
	 hmh0Rvea4fZPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66A5740DBB;
	Thu, 24 Sep 2026 02:56:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 274A3334
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1901640270
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1KXW6oJCSMd for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:40:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A96A340390
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199649;
 b=Ek9PjajuzXaqbjdUuSQNmNeIS0QOuENgUEWukqQpzQmI0Rkg3FqQ6abjDqPDJCfNKEyw
 0OxR2nJLd57kF+TfuDQZaOez/PZtMIyNTkI16OYMuHyhjNqXElvprUs/nWrfuAffhDity
 Zos878sVsdyzObU3PrBQQHOnlr+PhRQJctC22W3KgzLHmhUPHV9c3rhYOJv2gjGWqqQEY
 EqcdnlrAqzGJ6TfvjWZ6R39ubcXzSCuDzCOaNFUqqk+JqzEQ94PlRzrsGuYWgdVDMdou5
 h5+6VwDmbjdEp6l1SI0w0pJV0DHtFEBQmaA/RXyELblr7ZSbQTiXnzVZDjOuTK74VEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199649;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=SkMQ7jv4DfggjO2d01/mePQzViIkrTiF6H98kkTXeKo=;
 b=SMgkKPk328/W8F/uMFteJZ1fEua+KTabA48yg9iJx96JDsKFikxEtoZ3cVN1ZjvOKqbQ
 a5R8W860MkbhDayPW8HQvLzwcGH8Wsdfvwn2Qt+R2IoB7BJqSRs1NCngQ+T0ptCZ4GIRW
 a5SSNs7UXVgBUiY6ShR3qIQof48MJIX2Klb8BI+XPzuz2i0O0MlQfNMaFGcjG3fneLNMZ
 0TDPv5Hzx9rcDWmdhvmi5oL93qbjaENEK68vosI/Ybdxg05equLoYDkANIM4s0DpRgNoE
 /iZtewmQr8ZeEtcpxhyZ6BeSKfjLpV+nLFTdaLsoV1inXjRdIgSlDLbDHNuiZs4Y1AA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SKtqG0Kx; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=joaofl@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SKtqG0Kx
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A96A340390
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:48 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4858bc96fabso1215188f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199646; x=1790804446;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SkMQ7jv4DfggjO2d01/mePQzViIkrTiF6H98kkTXeKo=;
 b=SKtqG0KxHAWa8J9rj9+6gFqLeQJJ8ZCi77fDEGI5H3BIWFpbkAW7iBBCq/XUYSf82f
 tw3Dcsq7MoLYEZXjm7Pao84lia9hA3dO5OCT6vX2JAJQZ7IKcjXjSOK+TZp1WQXoWjBC
 jCwSq5DAaMwSy1DFzawdLmHXq3IIe1nGEsj+l7H44hIuJeAdooTdgnv9T67jSlGX1Sso
 kvs/pk3veDZ+bQTPUJu28xZRVEj9sV4eW13vx5Yoz+eC61v+uIsBunt92yotiWHa+XJz
 z1CZH+KyZqUqAoI4ZsEHMrGYl71VcYJJjivqqC1vRKOed7G3YLiJwm8lDHCq9rLk0kg0
 NVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199646; x=1790804446;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SkMQ7jv4DfggjO2d01/mePQzViIkrTiF6H98kkTXeKo=;
 b=iLJqVKUTW+UhaEaFQ83JNQp/WmuxvnKzrlDU2Zao9M1HpDOaxlX8UQoZpzVOphBXmh
 QANH497OnWTe48vp+a2d3MU3mjKtSrHqMCQvlNZo7Y/dDCWJTixElYyaERtA+J6uk1aw
 cw3exMZ2E9Z/iuVf7zn4aH1dBNh5hHDW4WpfZh8jUdQ4NHbcTlUvto7QoxFQqR2MmWFh
 y6zCPg3RHAdVVkPWZsClCLnrWQbCRd5KTIAnBxN6nOu1D3ZqHpBf3wIYrgq4ft60unSN
 lPozVdMSgQwEFdzQMfOz/VW4JOWD8WsC5sSo7LQOfAgnfOnBzvY0W6SYZos2t2iXzui/
 4ccg==
X-Gm-Message-State: AFuF++mzqieGpRYZ2S+Y6ciDMb4cVAHjbUS0UlwrRk000PblEd7g9bxa
 Q8/8PccLBjdR4/Bii7heKABQnywhOSHNUa6x98mGyt5kYZodULPMEIw5A1DVdhS0wzM=
X-Gm-Gg: AYBFou1MlG0zn5RQyS33mILYKvcKIOsi6QmXCzMorHAgEzYXwMXnc7uBt9483m2Kh48
 L+Qac07jxA2PzwispvRMn5dEo85+u1v3yra30AC2NwXIFxjeS4syfhgTACHUH1BNsM8esfWm9mr
 swKSAWRRqKjI1TES4jErArV9hIwi+oxs86u4AwTkH2NQYD/9THzM1CSvYEfyhoA630lPXHCRU3i
 6rATo9wKMMZePv8usNYpmzhVqNsaKsSNeFHoV3XDqt/dtR0xDGdOVMQ54ndJ2TbFSDGYNIQAjND
 BKygfO2iCTjesDeKo5wi4NgQGiByDmz6EkofAI0zcjgDN2EF5lA988SN7aljecDWeVWTD0FYoI7
 eWd0FWSd+8delnmg9LNiC8U1QZYH7PLKKLlk1MZNFBBV/Jy0M4KxrDrkcO3Y/YmElbfNIE9T9ID
 VmudCF09rshWSHTdWwp23bPGlGN0DjqP0l9WdfPIo/KyvVn/CHenQURh1fizILsFzdnWHOjm1VG
 o6dRZdgOTDgNv56DkNzDXwYur3WNgwyZKZaascImV1u+0Ss/tth3ekG5v+Jfu9y67s30Q==
X-Received: by 2002:a05:6000:144d:b0:487:6ef:86b8 with SMTP id
 ffacd0b85a97d-4887170e8a2mr650795f8f.49.1790199646457; 
 Wed, 23 Sep 2026 14:40:46 -0700 (PDT)
Received: from rrouwprlc0373.. ([81.172.79.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c119sm10309950f8f.15.2026.09.23.14.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:40:45 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v6 3/3] sandbox: spi: Add SPI EEPROM emulator and DM test
Date: Wed, 23 Sep 2026 23:40:30 +0200
Message-ID: <c21882037efc87057b1750afd3fbf12042beef61.1790198142.git.joaofl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790198142.git.joaofl@gmail.com>
References: <cover.1790198142.git.joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 02:56:02 +0000
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

Add a sandbox emulator for an AT25-style SPI EEPROM so the new SPI
EEPROM uclass can be exercised without real hardware.

The sandbox SPI controller previously always bound the SPI flash
emulator for every chip select. Allow a slave node to select its own
emulator through a sandbox,emul phandle (mirroring the sandbox I2C
bus), falling back to the SPI flash emulator when none is given so that
existing behaviour is preserved.

A test EEPROM is wired up on chip select 3 of the sandbox SPI bus and a
test/dm test verifies size reporting, patterned reads, out-of-bounds
rejection and the unimplemented write path. The node follows the
atmel,at25 binding: it carries the "atmel,at25" fallback compatible and
the required size, pagesize and address-width properties.

Signed-off-by: João Loureiro <joaofl@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # sandbox
---
Changes in v6:
- Build the emulator only in U-Boot proper, inside the existing
  "ifndef CONFIG_XPL_BUILD" block, so it is no longer linked into
  TPL/VPL/SPL. This fixes the sandbox_vpl CI failure.

 MAINTAINERS                    |   2 +
 arch/sandbox/dts/test.dts      |  16 +++-
 drivers/misc/Makefile          |   1 +
 drivers/misc/spi_eeprom_emul.c | 130 +++++++++++++++++++++++++++++++++
 drivers/spi/sandbox_spi.c      |  37 +++++++++-
 test/dm/Makefile               |   1 +
 test/dm/spi_eeprom.c           |  46 ++++++++++++
 7 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/spi_eeprom_emul.c
 create mode 100644 test/dm/spi_eeprom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c45c47000c0..47f04166879 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1712,8 +1712,10 @@ SPI EEPROM
 M:	João Loureiro <joaofl@gmail.com>
 S:	Maintained
 F:	drivers/misc/spi_eeprom.c
+F:	drivers/misc/spi_eeprom_emul.c
 F:	drivers/misc/spi_eeprom_priv.h
 F:	include/spi_eeprom.h
+F:	test/dm/spi_eeprom.c
 
 SPI NAND
 M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index d24feec5422..7d7f0376348 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1618,7 +1618,7 @@
 		#size-cells = <0>;
 		reg = <0 1>;
 		compatible = "sandbox,spi";
-		cs-gpios = <0>, <0>, <&gpio_a 0>;
+		cs-gpios = <0>, <0>, <&gpio_a 0>, <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinmux_spi0_pins>;
 
@@ -1636,6 +1636,20 @@
 			spi-cpol;
 			spi-cpha;
 		};
+		eeprom@3 {
+			reg = <3>;
+			compatible = "microchip,at25160bn", "atmel,at25";
+			spi-max-frequency = <1000000>;
+			size = <2048>;
+			pagesize = <32>;
+			address-width = <16>;
+			sandbox,emul = <&spi_eeprom_emul>;
+		};
+	};
+
+	spi_eeprom_emul: spi-eeprom-emul {
+		compatible = "sandbox,spi-eeprom";
+		sandbox,size = <2048>;
 	};
 
 	syscon0: syscon@0 {
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 8c9f8eb9cfa..201055d89e0 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CROS_EC_I2C) += cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_SPI) += cros_ec_spi.o
 obj-$(CONFIG_SANDBOX) += p2sb_sandbox.o p2sb_emul.o
 obj-$(CONFIG_SANDBOX) += swap_case.o
+obj-$(CONFIG_SANDBOX) += spi_eeprom_emul.o
 endif
 
 ifdef CONFIG_$(PHASE_)DM_I2C
diff --git a/drivers/misc/spi_eeprom_emul.c b/drivers/misc/spi_eeprom_emul.c
new file mode 100644
index 00000000000..397e73cf0cd
--- /dev/null
+++ b/drivers/misc/spi_eeprom_emul.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sandbox emulation of an AT25-style SPI EEPROM.
+ *
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ * Copyright (c) 2026 João Loureiro <joaofl@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_SPI_EMUL
+
+#include <dm.h>
+#include <malloc.h>
+#include <spi.h>
+#include <linux/err.h>
+
+#include "spi_eeprom_priv.h"
+
+#define SANDBOX_SPI_EEPROM_SIZE		2048
+
+/**
+ * struct sandbox_spi_eeprom - state of the emulated EEPROM
+ *
+ * @data:	Backing store for the memory array
+ * @size:	Size of the memory array in bytes
+ * @cmd:	Opcode of the command currently being processed
+ * @cmd_len:	Number of command/address bytes consumed so far
+ * @addr:	Byte address decoded from the command
+ */
+struct sandbox_spi_eeprom {
+	u8 *data;
+	uint size;
+	u8 cmd;
+	uint cmd_len;
+	uint addr;
+};
+
+static int sandbox_spi_eeprom_xfer(struct udevice *dev, uint bitlen,
+				   const void *dout, void *din, ulong flags)
+{
+	struct sandbox_spi_eeprom *priv = dev_get_priv(dev);
+	const u8 *tx = dout;
+	u8 *rx = din;
+	uint bytes = bitlen / 8;
+	uint i;
+
+	if (bitlen % 8)
+		return -EINVAL;
+
+	/* A new transaction starts with the command/address phase */
+	if (flags & SPI_XFER_BEGIN) {
+		priv->cmd = 0;
+		priv->cmd_len = 0;
+		priv->addr = 0;
+	}
+
+	for (i = 0; i < bytes; i++) {
+		if (tx) {
+			/* Command phase: first byte is the opcode */
+			if (priv->cmd_len == 0)
+				priv->cmd = tx[i];
+			else if (priv->cmd == AT25_CMD_READ_DATA)
+				priv->addr = (priv->addr << 8) | tx[i];
+			priv->cmd_len++;
+		} else if (rx) {
+			/* Data phase: serve the requested register/array */
+			switch (priv->cmd) {
+			case AT25_CMD_READ_STATUS:
+				/* Ready, write disabled, not protected */
+				rx[i] = 0x00;
+				break;
+			case AT25_CMD_READ_DATA:
+				rx[i] = priv->addr < priv->size ?
+					priv->data[priv->addr] : 0xff;
+				priv->addr++;
+				break;
+			default:
+				rx[i] = 0xff;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int sandbox_spi_eeprom_probe(struct udevice *dev)
+{
+	struct sandbox_spi_eeprom *priv = dev_get_priv(dev);
+	uint i;
+
+	priv->size = dev_read_u32_default(dev, "sandbox,size",
+					  SANDBOX_SPI_EEPROM_SIZE);
+	priv->data = calloc(1, priv->size);
+	if (!priv->data)
+		return -ENOMEM;
+
+	/* Fill with a known pattern so reads can be verified */
+	for (i = 0; i < priv->size; i++)
+		priv->data[i] = i & 0xff;
+
+	return 0;
+}
+
+static int sandbox_spi_eeprom_remove(struct udevice *dev)
+{
+	struct sandbox_spi_eeprom *priv = dev_get_priv(dev);
+
+	free(priv->data);
+
+	return 0;
+}
+
+static const struct dm_spi_emul_ops sandbox_spi_eeprom_ops = {
+	.xfer	= sandbox_spi_eeprom_xfer,
+};
+
+static const struct udevice_id sandbox_spi_eeprom_ids[] = {
+	{ .compatible = "sandbox,spi-eeprom" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_spi_eeprom) = {
+	.name		= "sandbox_spi_eeprom",
+	.id		= UCLASS_SPI_EMUL,
+	.of_match	= sandbox_spi_eeprom_ids,
+	.probe		= sandbox_spi_eeprom_probe,
+	.remove		= sandbox_spi_eeprom_remove,
+	.priv_auto	= sizeof(struct sandbox_spi_eeprom),
+	.ops		= &sandbox_spi_eeprom_ops,
+};
diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
index 3ee97d67f4a..aa4edcf64b2 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -77,6 +77,41 @@ static int sandbox_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
 	return 0;
 }
 
+/**
+ * sandbox_spi_emul_get() - find the emulator for a SPI slave
+ *
+ * A slave can name a dedicated emulator through a "sandbox,emul" phandle (for
+ * example an SPI EEPROM). When no such phandle is present we fall back to the
+ * built-in SPI flash emulator, preserving the previous behaviour.
+ *
+ * @state: Sandbox state, used to cache the bound emulator per chip select
+ * @bus: SPI bus the slave is attached to
+ * @slave: SPI slave to find the emulator for
+ * @emulp: Returns the emulator device on success
+ * Return: 0 if OK, -ve on error
+ */
+static int sandbox_spi_emul_get(struct sandbox_state *state, struct udevice *bus,
+				struct udevice *slave, struct udevice **emulp)
+{
+	struct sandbox_spi_info *info;
+	int ret;
+
+	info = &state->spi[dev_seq(bus)][spi_chip_select(slave)];
+	if (info->emul) {
+		*emulp = info->emul;
+		return 0;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_SPI_EMUL, slave, "sandbox,emul",
+					   emulp);
+	if (!ret) {
+		info->emul = *emulp;
+		return 0;
+	}
+
+	return sandbox_spi_get_emul(state, bus, slave, emulp);
+}
+
 static int sandbox_spi_xfer(struct udevice *slave, unsigned int bitlen,
 			    const void *dout, void *din, unsigned long flags)
 {
@@ -106,7 +141,7 @@ static int sandbox_spi_xfer(struct udevice *slave, unsigned int bitlen,
 		       busnum, cs);
 		return -ENOENT;
 	}
-	ret = sandbox_spi_get_emul(state, bus, slave, &emul);
+	ret = sandbox_spi_emul_get(state, bus, slave, &emul);
 	if (ret) {
 		printf("%s: busnum=%u, cs=%u: no emulation available (err=%d)\n",
 		       __func__, busnum, cs, ret);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index cc51fd33079..51ee02ea873 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_SMEM) += smem.o
 obj-$(CONFIG_SOC_DEVICE) += soc.o
 obj-$(CONFIG_SOUND) += sound.o
 obj-$(CONFIG_DM_SPI) += spi.o
+obj-$(CONFIG_SPI_EEPROM) += spi_eeprom.o
 obj-$(CONFIG_SPMI) += spmi.o
 obj-y += syscon.o
 obj-$(CONFIG_RESET_SYSCON) += syscon-reset.o
diff --git a/test/dm/spi_eeprom.c b/test/dm/spi_eeprom.c
new file mode 100644
index 00000000000..b943ada0035
--- /dev/null
+++ b/test/dm/spi_eeprom.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Tests for the SPI EEPROM uclass
+ *
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ * Copyright (c) 2026 João Loureiro <joaofl@gmail.com>
+ */
+
+#include <dm.h>
+#include <spi_eeprom.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Read from the emulated SPI EEPROM and check the uclass operations */
+static int dm_test_spi_eeprom(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 buf[16];
+	int i;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_SPI_EEPROM, "eeprom@3",
+					      &dev));
+
+	/* The emulator advertises a 2 KiB array */
+	ut_asserteq(2048, spi_eeprom_size(dev));
+
+	/* The backing store is filled with a (addr & 0xff) pattern */
+	ut_assertok(spi_eeprom_read(dev, 0, buf, sizeof(buf)));
+	for (i = 0; i < sizeof(buf); i++)
+		ut_asserteq(i & 0xff, buf[i]);
+
+	/* Reads honour the requested offset */
+	ut_assertok(spi_eeprom_read(dev, 0x100, buf, sizeof(buf)));
+	for (i = 0; i < sizeof(buf); i++)
+		ut_asserteq((0x100 + i) & 0xff, buf[i]);
+
+	/* Reads past the end of the array are rejected */
+	ut_asserteq(-EINVAL, spi_eeprom_read(dev, 2040, buf, sizeof(buf)));
+
+	/* Writing is not implemented yet */
+	ut_asserteq(-ENOSYS, spi_eeprom_write(dev, 0, buf, 1));
+
+	return 0;
+}
+DM_TEST(dm_test_spi_eeprom, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0

