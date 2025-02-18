Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BC6C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DAED80ADF;
	Tue, 18 Feb 2025 03:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QQ1+LL33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5B580ADF; Tue, 18 Feb 2025 03:57:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD4080017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847453; x=1771383453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wwHuJd1rleswtVJSndeztXJj1Mx9cTKHNvQmskrEXLc=;
 b=QQ1+LL335JNmkQgkvv13G7Tnd+x5j9I1Iua7jTWoxTQbJJ4krG0QZKEV
 S0gGQyl5FoPYveUOAREQVS7rpaRhUBsfa89RCkAYqpvLsBcNpfYR6Islo
 aFqSy/7zm8qe/dhGBH8ifsycS/5UzKjZsh5PeIvOUR6q92Lgkvedg42E4
 HA6gs0Gcdd/jRftxOlx5sC8rpB/bbw7tLYZSfrZOibAj5TNQjp/LwF2LF
 1iPcw58/VUFAkf/p4LTV07P8aVdC85hC2F6PEAiaoOPLeqoSOdmmKDs8Q
 fuCWmCOT1CMi7lvR6/y3tk3QIk/2fPeLYFLpKIban9da2gYkw9RHvZxfo Q==;
X-CSE-ConnectionGUID: bsXAqf0vQM20Gw0/np6B9w==
X-CSE-MsgGUID: 3V5Kq2kET3iGi5I8XCBgjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174146"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174146"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:57:33 -0800
X-CSE-ConnectionGUID: 3Jl3r9GrQjOcYH/FbBSxDw==
X-CSE-MsgGUID: 7C2m2qxAQ7K642dZAfzuEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259260"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:57:27 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 02/10] drivers: i3c: Add new i3c uclass id
Date: Tue, 18 Feb 2025 10:56:57 +0800
Message-Id: <20250218025705.50051-3-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250218025705.50051-1-dinesh.maniyam@intel.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

Add i3c general uclass id.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 include/dm/uclass-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94..1d259b439f 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -78,6 +78,7 @@ enum uclass_id {
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
 	UCLASS_I2C_MUX,		/* I2C multiplexer */
 	UCLASS_I2S,		/* I2S bus */
+	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
 	UCLASS_IRQ,		/* Interrupt controller */
-- 
2.26.2

