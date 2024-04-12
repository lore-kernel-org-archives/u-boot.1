Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23792C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B46D2881FB;
	Fri, 12 Apr 2024 22:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="NPNE4Rl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB066881D6; Fri, 12 Apr 2024 22:26:27 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B59387DDE
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20240412202623c900ff5265a8ebfd83 for <u-boot@lists.denx.de>;
 Fri, 12 Apr 2024 22:26:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZkzeVIkxwPjiFpt61NJrHhrMnDXGAWGqKC/CE4tnJEg=;
 b=NPNE4Rl82bXg2QH65oNN5H+UoJcv9GRv5THPYWqQb1vN01Zii/v4cw45mcGNV+32COPOaK
 HE3iULWV3uJHg8Xe0dzECrUfF6VDVxB/x6Ie1Eueq/mjLYXrJt6EfnT9GB342ECMTrNlUVRO
 kWwLCfqL0B8rHZKfnNudcPZZ69R0I=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Marek Vasut <marex@denx.de>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon <nm@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Janusz Dziedzic <januszx.dziedzic@intel.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 5/6] usb: dwc3: gadget: properly check ep cmd
Date: Fri, 12 Apr 2024 22:26:05 +0200
Message-ID: <20240412202611.3565052-6-alexander.sverdlin@siemens.com>
In-Reply-To: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Felipe Balbi <felipe.balbi@linux.intel.com>

Upstream Linux commit 5999914f227b.

The cmd argument we pass to
dwc3_send_gadget_ep_cmd() could contain extra
arguments embedded. When checking for StartTransfer
command, we need to make sure to match only lower 4
bits which contain the actual command and ignore the
rest.

Reported-by: Janusz Dziedzic <januszx.dziedzic@intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[A. Sverdlin: cherry-picked only DWC3_DEPCMD_CMD() define]
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/usb/dwc3/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1e7eda89a34c9..7709ab793f36d 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -405,6 +405,8 @@
 #define DWC3_DEPCMD_SETTRANSFRESOURCE	(0x02 << 0)
 #define DWC3_DEPCMD_SETEPCONFIG		(0x01 << 0)
 
+#define DWC3_DEPCMD_CMD(x)		((x) & 0xf)
+
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
 #define DWC3_DALEPENA_EP(n)		(1 << n)
 
-- 
2.44.0

