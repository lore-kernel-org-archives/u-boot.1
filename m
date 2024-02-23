Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E1DC54E49
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 11:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE854875AF;
	Fri, 23 Feb 2024 12:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 472D68781D; Fri, 23 Feb 2024 12:28:13 +0100 (CET)
Received: from 19.mo550.mail-out.ovh.net (19.mo550.mail-out.ovh.net
 [178.32.97.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8954186FC9
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 12:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.140.39])
 by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4Th76f06P6z1JHd
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 11:28:09 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-h9dhd (unknown [10.110.168.38])
 by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 4AEDB1FE76;
 Fri, 23 Feb 2024 11:28:09 +0000 (UTC)
Received: from armadeus.com ([37.59.142.98])
 by ghost-submission-6684bf9d7b-h9dhd with ESMTPSA
 id FIKMDUmB2GXNPgQAmvfgWw
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Fri, 23 Feb 2024 11:28:09 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002ba74d231-cdf9-47a3-bbc0-73a8a5c9c150,
 BC4D5BFA97CC3CA13122104BDCDC28DE7890766D)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/1] opos6uldev: Convert to watchdog driver model
Date: Fri, 23 Feb 2024 12:28:04 +0100
Message-ID: <20240223112804.15559-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9315977305020558315
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepffeufffgveeiffelteelgfetjeffueffuefhffeikefhkefghfejjeeufeduteegnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht
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

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.

Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/dts/imx6ul-opos6ul-u-boot.dtsi | 10 ++++++++++
 configs/opos6uldev_defconfig            |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/imx6ul-opos6ul-u-boot.dtsi b/arch/arm/dts/imx6ul-opos6ul-u-boot.dtsi
index ebfb95dcdf4b..e65eeb8d8ceb 100644
--- a/arch/arm/dts/imx6ul-opos6ul-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-opos6ul-u-boot.dtsi
@@ -9,6 +9,12 @@
 	soc {
 		bootph-pre-ram;
 	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
 };
 
 &aips2 {
@@ -26,3 +32,7 @@
 &usdhc1 {
 	bootph-pre-ram;
 };
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index ac4170d2e49a..e1884df9dd23 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -102,6 +102,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_STORAGE=y
@@ -123,4 +125,5 @@ CONFIG_SPLASH_SOURCE=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_IMX_WATCHDOG=y
 # CONFIG_EFI_LOADER is not set
-- 
2.43.0

