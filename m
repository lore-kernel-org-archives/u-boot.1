Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FE0C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 23:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DC7884B5;
	Sat,  8 Jun 2024 01:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GSxaEf/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE4B8851A; Sat,  8 Jun 2024 01:53:27 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8C888496
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 01:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457NrE57078028;
 Fri, 7 Jun 2024 18:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717804394;
 bh=Yso/8jw15OzQZEK0ZbW9a0hH2xuodikFcu2Bgs3rsvU=;
 h=From:To:CC:Subject:Date;
 b=GSxaEf/yWfLyfPezh+WqcV7iU0XfZ0xStSTXUUtscRm29ZKBrUyWCL+omn8G5QE8O
 PDAS9WCCtC6FIYF+a2EeiZnwgHCD6ahv4IbAycckSJ2D3U+qWDqkDRmhUBEFZTfrxI
 udsdSSsFfuPI4Ad+aJAG9EEFbRmveFMAXZzSkGGo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457NrEKc008133
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 18:53:14 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 18:53:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 18:53:14 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457NrESU062879;
 Fri, 7 Jun 2024 18:53:14 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH] configs: k3: Enable capsule authentication
Date: Fri, 7 Jun 2024 18:53:12 -0500
Message-ID: <20240607235312.1992500-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Enable EFI capsule authentication and set the capsule public key
certificate file in the base TI K3 EFI Capsule config.

This will enable EFI capsule authentication on all boards that
include the base TI K3 EFI Capsule config file.

This patch is built upon the series enabling EFI capsule TI boards [0] as
well as using capsule certificates directly [1].

[0] https://lore.kernel.org/r/20240607223858.1971290-1-j-humphreys@ti.com
[1] https://lore.kernel.org/r/20240607225915.1985514-1-j-humphreys@ti.com

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 configs/k3_efi_capsule.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/k3_efi_capsule.config b/configs/k3_efi_capsule.config
index e31cea37269..8f8f63f672e 100644
--- a/configs/k3_efi_capsule.config
+++ b/configs/k3_efi_capsule.config
@@ -1,2 +1,4 @@
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_AUTHENTICATE=y
+CONFIG_EFI_CAPSULE_CRT_FILE="arch/arm/mach-k3/keys/custMpk.crt"
-- 
2.34.1

