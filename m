Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4B1C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 13:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 835A88119F;
	Sat,  5 Sep 2026 13:02:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgswqo-snrZx; Sat,  5 Sep 2026 13:02:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD1758118F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788613332;
	b=f5uoAAcnjGioF27ihWx3w9j7uhAyFhI2LOE64qg3sPRNERjI68SnsUWFKNwh1XfQr+yy
	 ue3rEn6+MCDahOaiSEafR0YCdvZunKoDwr2XtdxUwp7MjglWCtT7SLB9cj2xfwZYBfE0M
	 NORgtG9wbjr39W4c2b2v3oE3J6JdUeospNyWCVUartJdh/z0b/CZcNMK0w7H3LXDCd1+r
	 KTTjFhsf0Vo1YJRWPa8k/4RI7LwfKeZDXyuIlODBRtEIcQx5bq0KpxSxik3PNnUrLx8BA
	 tSHYoHnal/ExY7yZjBW3oMJvbV2PVE5av0t5rRl40vBfxhTPfkfFSmN0xZlIy1+jcxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788613332;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4nhLVZ73LDmLopIxg3LQs3CLNj6nYQ12cgHF8PUKMvE=;
	b=XfMmtSGmCwNG1/7DymKhTStnHM4dc8s/K4//SEYAZwDflsh1VIRzIwruuqMUlqFk/PXu
	 vbEOD0gDidiRkP7UkwY7+EKg+hraOmtOQOb5i/I7zUz+tWulNqVwqukHoU/5Et0eWUGdr
	 /PmLl1qDDZQRxV4Qqi6uvOhb+bth1+uy2PLyU18aivfn7pfNKxecJFhSVCy1gCwl5cV2i
	 lvpAhnGtWg5oJDoVukk3GCjq/8ftlCzGpnyIOULmVmg6+uuba/t5NbxufvO31d4/tvWNt
	 7C7piy8DHze0aEqfOTczGPPfRrLp/b8ohMcHsBCxa/WSqNfqXsUmFtUgHy56ZRBzOMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788613332;
	bh=4nhLVZ73LDmLopIxg3LQs3CLNj6nYQ12cgHF8PUKMvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0uJtxG4+sRX/0HbKMWQBjNLhylx1v1NfSu3hsFwhlM+Dc0TrBB66YayB0wIWZSeKW
	 580zED9jXt+cDz70V2DR2rIjW6mHwmD9q6Lpln1hKoqqPgOh/vU5iEXLBVcjz1Ttyk
	 X5mvDCN/6WekhibIC17iCH6+yufvorcQOueXjiuiq3pZ1+g9+z9mroXHNnKcPmbDur
	 9/Wl6dEw1N6jqqUrhaqHA5mqnyAnu0NyA4gc5j5Kj/YYnBfquRS9nzQiRQn/YNpmts
	 WIfiIXRE+rd/QEDp1/+ZFQuBDxGHmsmynU3VdOu9U+sCAe2yyWIvDmei5JHxvbLOG2
	 0R7+XexqZuQhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD1758118F;
	Sat,  5 Sep 2026 13:02:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E956C388
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE8AE40073
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzFGW7V65sAz for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 10:24:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8C79040024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788603899;
 b=g6/ir6Pzm5mtvw355lP7AYd8owig+Z0po4xCVNec/RIXV0xEOWspIAjmnxaECm/yh4YE
 6ilIkGN+7mlq+nHPBmE6TZAfrSeGs5fGvl2aOKLbVM5EJvRsY0yfEYTrmuARTh2d1JUmz
 OOPoaFiszS2XrHLjpuchdrWL2MkkGBx5DUxDvO7pg+p3VGsRRRUMFwe13aXlDwEwKQiKz
 tPD+QZUHNITb10EN5BbT6Okf8If0y4utKWNxjaHiDcFM/AZfqxJq4cDDELEqtOv+hX/QU
 Ik8Bl0CqLhFmXTU1YTrvhCmHj6WqKyU0qhPvmNgGq6gT1MY4yKaCuj36cXrzgVhT2Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788603899;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=4nhLVZ73LDmLopIxg3LQs3CLNj6nYQ12cgHF8PUKMvE=;
 b=Ysejk/HoHu/+odd6h1lRvOL/JpgcvxGqdtZOrRfstoRbD3lAYoEpGLYDsz/sOZYtgbwR
 qTFyUnIMQj/PwFqaQvz7xZny+HDJ766LCpc6lC4M5eP3kz2PZsX1mCO1VvvXm8hH0StXK
 dnShPy9f7Y/eElXkLMkqWBp5RV31Qa9NZ/HO/PKFJWXQmUfink0MfVMPe19+VIBEXQhWh
 DMuQx9jnnbv+lfIVzcemuUhEDkyaaK7sAy8TRv+aj1ezSh6kfjppaxuoZkNWtR3MC+1Ea
 Htd0wvbwveU610g1zSPKaVKPNlGEU4wAzzJZlwGjFRW0CUgrOnjAkpT3R1lLkStQkNg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rEspQp6c; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rEspQp6c
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C79040024
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:58 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so16167305e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 03:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788603896; x=1789208696;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4nhLVZ73LDmLopIxg3LQs3CLNj6nYQ12cgHF8PUKMvE=;
 b=rEspQp6cjfGQUBxkYr7o9mEM2K0fsxih4puZg6QteHWnYYCXu3KJF5VDQwdeKekSUs
 4+n5UW0hn0W1iDYlSabCIvKa0dh8K2Q50pevku7lHu9q7oPz3AX3o9P3uKuFIuuhKPdO
 d8AxS370lrJbu1wXQnb6hW6tL0wqOYkSEgpfTDAMiXTDrXBjojEHj/+LTGPfWMwRV3h/
 3rPpXq4TeCi/D3zv2kvLpKNGpKRxU3jkzvZlDTCgHiO2EtP8rxqd8sOSv8zfdlbAmwJL
 ag36HORvESU2q5krxIrP7mtYmf9nqLbybXtjQehI3aVTg+5Pt6voGYfdp0rnUDoxDJDi
 UP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788603896; x=1789208696;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4nhLVZ73LDmLopIxg3LQs3CLNj6nYQ12cgHF8PUKMvE=;
 b=Ijdvn2lc38UFRoOMUeokeSnD7UM10zE4CEww3Ya1qihj2OCTu1sBK5ofgkT4VOnb8+
 inAt3csYPkw78joDdaqWBVI/6IxI5iWoFqhy8d6Bmpuam2pGxtn5dXhCZxGwOaCVaO4Q
 XwPdv9mROmKZdcgVfV5HW6qLZEiKLDZCZQZad3N89lGKAcujVrMxVAqMN1dQPrvk65nn
 kU8ycFckgiI9wQS21630lonFVhzDsRStz31MhIuSUr4SUOCOl6hNS93BoU51JLR/cT9a
 qvXWWsiX2cpcHOPFwErwEJ/R69ZCre2Ke75JYD1sXg3b32KUguJ5XqJdUqQt+mC0ulKc
 JdlA==
X-Gm-Message-State: AFuF++mjkBqvQLYl/3AWe7qMAf+EA082kvM2iogc0Zp7wocDuNM7SusT
 pP5C2zvNpvU6cb4NKrYfOmLvNHaG4CoZ6xw5sF5+OrF1MwRj/Vpj/jQdNnVgOA==
X-Gm-Gg: AYBFou1oYZxQ//ZHXEpQ79fK3SZ42LJByAHbhiG4qqjG8rqQd2hFZue4nJbm4wMQrtO
 na/jzQYKUImvBDQsWBK1SkV7fiDvPk4G5FE0d6ireyyBx6Mg+MB0bY8EV3rU1AedFjUnMe26lJG
 hVaNwSyR326rSQoq/QmWMNUy8CwCvZUScmbjHJxNhlscoqMnNUYideKtGhEKK2bD7A47PTyTbO2
 EuVVUk6GSC55pWoM6+Rup85ABJOgjUmncRG99AXjHxthPRqYPmkNMHWE0PEV5d9YD3yXuMOSSQM
 Ux6e9f4jR6uJRhxR1KhsTAuDgDEBPkJBBOfq4O3bUo+vidcaRkrfxVno4p3mH1vb+hTUra80wFW
 xuDAQaCRRtHrA98GoL6SPMjUiXdunahlp6wKX0nEdFLzWYn+8cwK63s4JlF3eU8vb0yogmLKRpQ
 aE2wUz87ivXgh5MnLjnn5ssmswQI6rQ1BK5G0Nd3EXodGztGp5Xg0E8cJeEl3LM9qyGRQcXiwCf
 1bzI181IQKfxursP5u0M6DoiXKyeuvcHMfHMvfOy/u5M6id/9gXykZ/gi4QgMrseT/MuoC8P67Z
 r0dudKg=
X-Received: by 2002:a05:600c:3105:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49cf82bea15mr99161545e9.1.1788603896036; 
 Sat, 05 Sep 2026 03:24:56 -0700 (PDT)
Received: from lap.lan (xcpe-178-82-236-193.dyn.res.sunrise.net.
 [178.82.236.193]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm164424635e9.10.2026.09.05.03.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 03:24:55 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v5 3/3] sandbox: spi: Add SPI EEPROM emulator and DM test
Date: Sat,  5 Sep 2026 12:24:31 +0200
Message-ID: <20260905102431.426747-4-joaofl@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260615175118.53720-1-joaofl@gmail.com>
References: <20260615175118.53720-1-joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 13:02:04 +0000
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
Simon: I have kept your Tested-by, but please do re-test rather than
rely on it. The v4 tree segfaulted on a full "ut dm" - test/dm/sf.c
took the first UCLASS_SPI_EMUL device as the flash emulator, which the
emulator added here displaces, so sandbox_sf_set_block_protect() wrote
past the end of the wrong private struct. Running "ut dm spi_eeprom"
alone passes and hides it. Patch 1 fixes the test.

Also changed since v4: the DT node now carries the "atmel,at25"
fallback compatible with the required size/pagesize/address-width, and
the emulator includes drivers/misc/spi_eeprom_priv.h.
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
index 893cf421378..92e26829e1a 100644
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
index 8c9f8eb9cfa..8fa0fe75b53 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_IRQ) += irq-uclass.o
 obj-$(CONFIG_SANDBOX) += irq_sandbox.o irq_sandbox_test.o
 obj-$(CONFIG_$(PHASE_)I2C_EEPROM) += i2c_eeprom.o
 obj-$(CONFIG_$(PHASE_)SPI_EEPROM) += spi_eeprom.o
+obj-$(CONFIG_SANDBOX) += spi_eeprom_emul.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
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
index fb3e6a7008f..3a8599d6bc2 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_SMEM) += smem.o
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
2.55.0

