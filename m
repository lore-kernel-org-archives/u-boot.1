Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE87C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 07:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E1687698;
	Wed,  1 Nov 2023 08:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ict42.de header.i=@ict42.de header.b="RPPCkWZb";
	dkim=permerror (0-bit key) header.d=ict42.de header.i=@ict42.de header.b="Hfm8QWig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C238767B; Wed,  1 Nov 2023 08:28:41 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1903C87676
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 08:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ludwig.kormann@ict42.de
ARC-Seal: i=1; a=rsa-sha256; t=1698823716; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=LEwafgbu1F+27uIWWdfqUVy63nnofCes76N3XtAXToEPYN08JTQtuaO5jvI6Md9evU
 jnavUfBn1txr+OYY1xEZ7Ecft/5IF3Pe9PsCx9xttOsCrPwwAFu5LijLkLd4f0cGraEt
 YxBGYjxFdvBkl5B8beoZJeMR6fjcBHH3p5I9MaT1G9ugkhVpaykXultAniHlLsqv1rhC
 hLR/XDmJVJu4e/kNsda4We7xg09xGzKCix6KYVmILpkUj8CTAEf6JqOYetxLli6+GA4/
 nHAjd3s9jkAxnncTfMNJuksZN8FggfM/WQD3QBotUV8pWgsEZP6dUVZ9bWV6yDq8qDV6
 /llA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698823716;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=w2iGod8687TIjg1bn13hybhqJ5KuFjk6A4yHFUamqM0=;
 b=Zn9N5HGDzt3SXq3jAIhX23cSvcxgptvKIppO27AhmnWz4MILgiZBKeiNWWHA4rjJJq
 xkZL4ShLJ2rX2W1RfaTu0IzzIbznKg/T77nN/1Ad1SACPadhjcp7fDGwSnZK2KyjnLev
 F/GF/cPCBPpHlcyiGnMjDjUHvGS8Y3NrLQUEXpS/Nk8dpIrCFT2y4lDddWE8J/PMbc68
 ljTQKAdbebNlTHmza18nQdBHFRvB4jvHtCypmyZr7EVsytCeixzThge3k65Kw/lFUtPU
 o701ihkJN388tImerZG5rVKllgg5Th1KU8I/mUB5Z8E7ThBqxKBjxvRQz+WvIIR/3E20
 RAQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698823716;
 s=strato-dkim-0002; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=w2iGod8687TIjg1bn13hybhqJ5KuFjk6A4yHFUamqM0=;
 b=RPPCkWZbI19/6Nyy7/8qql5TlVK3sZcvFBF+uXHIpk2emn/exVcc2Hp+Tggb9RM0cT
 Bcwh0ojkN+qwurHYvlxc0uikY3EYRPtNvIHKY8+WmXMnvnJ5qsIIRKwnkUxndTD6BRIc
 nWRrZ5r4hYlpD4GltR65gnvf3T42E58SD9pD7qJCVISwDwwsJYOfUSPPyKX5iF9N9tCr
 nLUPCK9++aQq1TcjfyyXvIjKyeV93KS7l7Zv7oeVR3KkolKjrfCA2y9PpMNLj81FVHPp
 rD3EZa6yN49O3j8X7DhVEgGp/9+wMdvTOa7s8JYVaE9zG5CgBpXCEGtO+M21VyNziK4j
 HgcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698823716;
 s=strato-dkim-0003; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=w2iGod8687TIjg1bn13hybhqJ5KuFjk6A4yHFUamqM0=;
 b=Hfm8QWigQelcoS9xnFtTNz4PuAuTEhpMzFcQiWYyFDNnEkuCT5DKvY5SqK05jngiuy
 kG9kwPPZQNeiKmJudTAA==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0KglxDI1B7BeEcdPLARTmoNew8LrcPHYUsIG7vXY="
Received: from debian-test.local.in-circuit.de
 by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
 with ESMTPSA id w61ae2zA17SaaMP
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 1 Nov 2023 08:28:36 +0100 (CET)
From: Ludwig Kormann <ludwig.kormann@ict42.de>
To: hdegoede@redhat.com,
	jagan@amarulasolutions.com,
	andre.przywara@arm.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 1/1] arm: dts: icnova-a20-adb4006: Add board support
Date: Wed,  1 Nov 2023 08:28:32 +0100
Message-Id: <20231101072832.2748412-1-ludwig.kormann@ict42.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add board support for ICnova A20 SomPi compute module on
ICnova ADB4006 development board.

Specification:
SoM
- Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
- 512MB DDR3 RAM
- Fast Ethernet (Phy: Realtek RTL8201CP)
ADB4006
- I2C
- 2x USB 2.0
- 1x Fast Ethernet port
- 1x SATA
- 2x buttons (PWRON, Boot)
- 2x LEDS
- serial console
- HDMI
- µSD-Card slot
- Audio Line-In / Line-Out
- GPIO pinheaders

https://wiki.in-circuit.de/index.php5?title=ICnova_ADB4006
https://wiki.in-circuit.de/index.php5?title=ICnova_A20_SODIMM

devicetree upstreamed with linux 6.5

Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
---
changes in v4:
- rebase on master
- add CONFIG_SYS_64BIT_LBA
- drop dts from patch, already upstreamed

changes in v3:
- rebase on v2023.10

changes in v2:
- rebase on v2023.07-rc2
- remove pin defines from defconfig
- get dts reviewed on the linux mailing list and
  scheduled for kernel 6.5 [1]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
commit de2bdfb7f79d5c655eb056d459e02be2c7f13c8b

---
 arch/arm/dts/Makefile                |  1 +
 board/sunxi/MAINTAINERS              |  5 +++++
 configs/icnova-a20-adb4006_defconfig | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 configs/icnova-a20-adb4006_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 55aceb51cd..d947b8de56 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -693,6 +693,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-haoyu-marsboard.dtb \
 	sun7i-a20-hummingbird.dtb \
 	sun7i-a20-i12-tvbox.dtb \
+	sun7i-a20-icnova-a20-adb4006.dtb \
 	sun7i-a20-icnova-swac.dtb \
 	sun7i-a20-itead-ibox.dtb \
 	sun7i-a20-lamobo-r1.dtb \
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 4bbe3f62fa..0061437211 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -236,6 +236,11 @@ M:	Stefan Roese <sr@denx.de>
 S:	Maintained
 F:	configs/icnova-a20-swac_defconfig
 
+ICnova-A20-ADB4006 BOARD
+M:	Ludwig Kormann <ludwig.kormann@ict42.de>
+S:	Maintained
+F:	configs/icnova-a20-adb4006_defconfig
+
 ITEAD IBOX BOARD
 M:	Marcus Cooper <codekipper@gmail.com>
 S:	Maintained
diff --git a/configs/icnova-a20-adb4006_defconfig b/configs/icnova-a20-adb4006_defconfig
new file mode 100644
index 0000000000..22cbb612e3
--- /dev/null
+++ b/configs/icnova-a20-adb4006_defconfig
@@ -0,0 +1,21 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-icnova-a20-adb4006"
+CONFIG_SPL=y
+CONFIG_MACH_SUN7I=y
+CONFIG_DRAM_CLK=384
+CONFIG_AHCI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SCSI_AHCI=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MII=y
+CONFIG_SUN7I_GMAC=y
+CONFIG_AXP_ALDO4_VOLT=2800
+CONFIG_SCSI=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.30.2

