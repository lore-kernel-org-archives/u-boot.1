Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00DBC02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 08:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4308780562;
	Thu,  6 Feb 2025 09:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GZ6OujNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759CA807B3; Thu,  6 Feb 2025 09:25:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C2F80104
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 09:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738830350; x=1770366350;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pN2ufhgMPwvsvMNXuz132iIMhv/djDso8a21s3YAXCA=;
 b=GZ6OujNVX0FCp84l6HkFJHoU+3UrlPkBkLhoL2NEveWcNRsf8ZJ4JgSY
 Mn6l0P1AtmGsmuzZN3lGV7/TRk5JuN5HT0i0X28OZVW9HWPPaoA2UXp8h
 evFHbap10DZCMeA8oDR5ZwMjkXs+YAtDOroxu3SLUXGLRDsaFyon3chxB
 yJc7wLXD9y7vNb8H3MNG1Im/VJGksqWPjRXVr3C8NKVhRw9yut32zmm7I
 YDim80Wc1gj9fIiR0r2iDVKHFB4C/LvZNGkIw82u8vcLR0TxnsMCemWY3
 LdgzPc/to1ERal+6RRvCTCsq2z820p9N5nIZjiNIOnKwpmWejp5psrNMV A==;
X-CSE-ConnectionGUID: tI/Arx42Sp2kOxkopfEpLw==
X-CSE-MsgGUID: gPeRLcClS76Z3CGGRldL2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38623164"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="38623164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 00:25:48 -0800
X-CSE-ConnectionGUID: Wl1EIXx5SQKrAdmsXrzZIw==
X-CSE-MsgGUID: NFI/NXERQCeDM5P1MwzJiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="142031890"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by orviesa002.jf.intel.com with ESMTP; 06 Feb 2025 00:25:45 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] arch: arm: dts: agilex5: Enable I2C3
Date: Thu,  6 Feb 2025 16:25:11 +0800
Message-Id: <20250206082511.1531-1-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.26.2
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Enable i2c3 node in Agilex5 device tree

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 852e1e5ae3c..ca87e99f9fa 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -62,6 +62,10 @@
 	status = "okay";
 };
 
+&i2c3 {
+	status = "okay";
+};
+
 &i3c0 {
 	status = "okay";
 };
-- 
2.26.2

