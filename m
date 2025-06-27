Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E67C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 10:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEFB82EA5;
	Fri, 27 Jun 2025 12:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vzrx6Xis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C7B82E9A; Fri, 27 Jun 2025 11:22:45 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C9282E35
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55R9MVSs2725085;
 Fri, 27 Jun 2025 04:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751016151;
 bh=97b/bquYOahVHmbvFer28Q/FsQBVI97P5latNjMyl2Y=;
 h=From:To:CC:Subject:Date;
 b=Vzrx6Xis1Lf5tyvAtgrn5ooDSYejVB478QrvJsxby3GX9MZa7lzE3tKBAbsMKV9n4
 K0YzNqqV3yhH1MEVYtghYYFaq16bEVkEar9REneUKd4kpD7aWwESabVEH3tVUf1lih
 QENhjuqRWFmBkfQHxZbWmRI5QEhQv/F77UJgH0CI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55R9MUVa2836451
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 27 Jun 2025 04:22:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 04:22:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 04:22:30 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.72.138])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55R9MQWs2835580;
 Fri, 27 Jun 2025 04:22:27 -0500
From: Gokul <g-praveen@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <casey.connolly@linaro.org>,
 <tien.fong.chee@altera.com>, <sjg@chromium.org>,
 <patrick.rudolph@9elements.com>
CC: <1425075683@qq.com>, <Oliver.Gaskell@analog.com>, <u-boot@lists.denx.de>, 
 Gokul Praveen <g-praveen@ti.com>
Subject: [PATCH 0/1] configs: KASLR OPTEE RNG support
Date: Fri, 27 Jun 2025 14:52:23 +0530
Message-ID: <20250627092224.36325-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 27 Jun 2025 12:51:18 +0200
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

From: Gokul Praveen <g-praveen@ti.com>

KASLR, or Kernel Address Space Layout Randomization, is a security 
feature in the Linux kernel that randomizes the memory location 
where the kernel is loaded during boot.

OP-TEE RNG is a Random Number Generator (RNG) component within the 
Open Portable Trusted Execution Environment (OP-TEE) which provides 
a random number to U-BOOT and U-BOOT provides this random number 
as seed value to the LINUX kernel for KASLR.

To support this feature,the required configs has been enabled 
across K3 devices.

Boot logs Link :

https://gist.github.com/GOKU-THUG/44aa8c0962438c12ffc55e6ed67742e5

Gokul Praveen (1):
  PENDING: configs: KASLR OPTEE RNG support for K3 devices

 arch/arm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.34.1

