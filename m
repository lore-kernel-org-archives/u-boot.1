Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F87CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FBC8824B;
	Wed,  3 Apr 2024 14:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uudJX4n8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C71882E4; Wed,  3 Apr 2024 14:03:39 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82DB88237
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433C3Xj6053232;
 Wed, 3 Apr 2024 07:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712145813;
 bh=w+8NoHTyZHtcmChqBe03RofUSK89wael8JNjJe/f1SI=;
 h=From:To:CC:Subject:Date;
 b=uudJX4n8SjG1v7QxBz1XIJYNT7hakU0uDF2ULfRSAM8kYLSD/KlnFkyuEyNyBG2sk
 r+3+WbFoTRxz1zeporkiswOmUHUSPT61o4auui66RvHl0wL95Wf2ZrpkLW46v4S3Rw
 K1EoJVD9QX+oKPeqjtT23LSmjRUxMWcntJMS5JLo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433C3X1p033528
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 07:03:33 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 07:03:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 07:03:32 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433C3T4h128691;
 Wed, 3 Apr 2024 07:03:30 -0500
From: Dhruva Gole <d-gole@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vibhore Vardhan <vibhore@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>
Subject: [PATCH 0/2] Add TIFS Stub support in AM62x
Date: Wed, 3 Apr 2024 17:33:08 +0530
Message-ID: <20240403120309.4026170-1-d-gole@ti.com>
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

Add support for signing, detection and loading of TIFSSTUB images for
for HSSE, HSFS and GP AM62x devices.

Boot tested and Deepsleep entry exist tested with ti-linux:
https://gist.github.com/DhruvaG2000/036010f6ae75aa6443fc77f61fd74893

Patches are based on top of tag: v2024.04

Cc: Tom Rini <trini@konsulko.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>
Cc: Akashdeep Kaur <a-kaur@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>

Kamlesh Gurudasani (2):
  arm: mach-k3: add support for detecting TIFSSTUB images
  arm: dts: k3: binman: am625: add support for signing TIFSSTUB Images

 arch/arm/dts/k3-am625-sk-binman.dtsi | 141 ++++++++++++++++++++++++++-
 arch/arm/mach-k3/r5/common.c         |  24 +++++
 2 files changed, 163 insertions(+), 2 deletions(-)

-- 
2.34.1

