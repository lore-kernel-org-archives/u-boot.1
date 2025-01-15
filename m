Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C07CC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 15:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFBE8060C;
	Wed, 15 Jan 2025 16:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="BRCtI2U0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D2080657; Wed, 15 Jan 2025 16:41:20 +0100 (CET)
Received: from 14.mo561.mail-out.ovh.net (14.mo561.mail-out.ovh.net
 [188.165.43.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0321A8033D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 16:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.9.56])
 by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4YY9Fn1k7nz1TfJ
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:41:17 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-5h5d8 (unknown [10.108.42.247])
 by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id AF1F31FEC0;
 Wed, 15 Jan 2025 15:41:16 +0000 (UTC)
Received: from armadeus.com ([37.59.142.101])
 by ghost-submission-5b5ff79f4f-5h5d8 with ESMTPSA
 id GHkDGxzXh2daZgAAwK9Y7A
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 15 Jan 2025 15:41:16 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004bbe8f67b-0613-4a9b-acc2-3cd5899593d8,
 38F691EED06ACBA27616AA52C5CB73E015FFD3CA)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 90.11.248.239
From: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Date: Wed, 15 Jan 2025 16:41:13 +0100
Subject: [PATCH] imx: fdt: fix cooling-device property corruption
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-imx93-boot-dtb-fixes-v1-1-1723b4216e71@armadeus.com>
X-B4-Tracking: v=1; b=H4sIABjXh2cC/x3LQQqAIBBA0avIrBtIy6iuEi2anGoWZWiEEN09a
 fn4/AciB+EIvXog8C1R/JGhCwXzNh0ro7hsMKWxpdY1yp66Csn7C91FuEjiiC25piHb1rYiyOs
 Z+A/5HMb3/QAhGg56ZgAAAA==
X-Change-ID: 20250114-imx93-boot-dtb-fixes-8bd66b58453b
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
X-Mailer: b4 0.14.2
X-Ovh-Tracer-Id: 15500545494702156785
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecuhfhrohhmpefurogsrghsthhivghnucfuiiihmhgrnhhskhhiuceoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeetudffuedugeffuddvhfefjedufeejleekgefhjeeuuedtvdegheeikefhleehgeenucfkphepuddvjedrtddrtddruddpledtrdduuddrvdegkedrvdefledpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehiedumgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=Tk6WuD7lPdYplB76MnAbEIKJb8qFEgLIpFxC533LMKI=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1736955677; v=1;
 b=BRCtI2U0ECEn5cpb68aHx2RzywuKh1RSvQ4Bnn2Y66qkJDn0JKaSL+TybFe9RbxgMKlgDj1g
 qUpNB3WQuhJJ4L/n8O4Dw+4IQz+4DTwm7TeVibmnupHco6MAIcQqBXfwBJcWcgTvbK2fz13JeMO
 +WUYQWrkwGqat5OF2VFVdDKK+N8CZxVITe5MaaO2pzvBAYzb+3w7wHdzLO9ao3gLWnAvgCA4oLH
 inqBpUrnRi9Ifv2WteVEGDAWst5UEXyWoUwhRNR/qu60vzKbS58msM2Z0IrBhcLARZmfC3ZPZkY
 Ilo13q0R9vD53aP84kq/F2ktbU9oN7F7QhzJsVtzRQOyA==
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

The function disable_thermal_cpu_nodes() corrupts the cooling-device
property.
For example, booting an i.MX93 devices with only one A55 core (IMX93x1)
with the cooling-device property set to:

$ dtc -I dtb foo.dtb | grep cooling-device
cooling-device = <0x08 0xffffffff 0xffffffff 0x09 0xffffffff 0xffffffff>;

Linux shows the following error at boot:

[    1.715189] OF: /thermal-zones/cpu-thermal/cooling-maps/map0: could not find phandle 1083699869
[    1.723977] thermal_sys: Add a cooling_device property with at least one device
[    1.731285] thermal thermal_zone0: binding zone cpu-thermal with cdev thermal-devfreq-0 failed:-2

because the cooling-device property in the device tree passed to the
kernel is

$ dtc -I dtb /sys/firmware/fdt | grep cooling-device
cooling-device = <0x4097f29d 0x00 0xb05aef9d>;

The issue is because the wrong variable type is passed to the function
fdt_setprop() called in the function disable_thermal_cpu_nodes(). With
the variable type fixed, the error at boot is gone and the property is
properly set:

$ dtc -I dtb /sys/firmware/fdt | grep cooling-device
cooling-device = <0x08 0xffffffff 0xffffffff>;

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/mach-imx/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
index 103c1fc5968afb46efc8e8ecf9038fd93af3cac1..f19ab9edce496606ba99c80f6a53ff45d596f00e 100644
--- a/arch/arm/mach-imx/fdt.c
+++ b/arch/arm/mach-imx/fdt.c
@@ -39,7 +39,7 @@ static void disable_thermal_cpu_nodes(void *blob, u32 num_disabled_cores, u32 ma
 		for (j = 0; j < cnt; j++)
 			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
 
-		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
+		ret = fdt_setprop(blob, nodeoff, "cooling-device", cooling_dev,
 				  sizeof(__le32) * (num_le32 - num_disabled_cores * 3));
 		if (ret < 0) {
 			printf("Warning: %s, cooling-device setprop failed %d\n",

---
base-commit: 6a0db9ee030f634731b792d864fc7a9df6cc6b80
change-id: 20250114-imx93-boot-dtb-fixes-8bd66b58453b

Best regards,
-- 
Sébastien Szymanski <sebastien.szymanski@armadeus.com>

