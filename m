Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA98BC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 04:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A93380FE1;
	Thu, 27 Feb 2025 05:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DL+Krexk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B708780FE2; Thu, 27 Feb 2025 05:09:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF33807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 05:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740629351; x=1772165351;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oBCmB5Cc3x7kjbJjauPVLKNgvMzOLDxvCbongrBgSbY=;
 b=DL+KrexkzbbQvbEgA5QRNTltKES02b+vc6E8bOfcy338rC7NNyStXRTC
 yEgjWddVTxK9pbr2gvi9MS0OY2+5+GGv2De/hcd8GAT2yIXDjvAm+zypx
 3DMllfVCiGQ47EN5inFp7DFP5jBV3YeLTuLaOmkDmYQL1Guv+r4lzv0kR
 QZAZhoc2Fw+Yghu1h+RahxuOMaQshSLKJ1jVUteoDQQ8RzLYyY/mC67GX
 JKXQYQ8pUHhbjh+444tvO5S1HE8LzSL1Upi+hmEEs1su3mZa7AL1rnFs7
 TaolprlSUmDjguOHtW43ha1NKhJRRqkigUpV5E2LWHnlImEQNKOEk0MlO Q==;
X-CSE-ConnectionGUID: QQuHyR+jQKee6GdWq8GmrA==
X-CSE-MsgGUID: lEg7TDV5SlWFG2Fs0lesRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41206625"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="41206625"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 20:09:09 -0800
X-CSE-ConnectionGUID: VNcOq7FOScqWxqIBtt81GQ==
X-CSE-MsgGUID: +AZg8zENQmWyf3NivFqMvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="121028438"
Received: from apgcp0f581303.png.altera.com ([10.244.73.189])
 by fmviesa003.fm.intel.com with ESMTP; 26 Feb 2025 20:09:07 -0800
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: tien.fong.chee@altera.com,
	Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH] MAINTAINERS, git-mailrc: socfpga: Update email to Altera
Date: Thu, 27 Feb 2025 12:09:04 +0800
Message-Id: <20250227040904.18714-1-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Altera officially split off from Intel, the email need be updated to ensure
uninterrupted support and communication

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 doc/git-mailrc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/git-mailrc b/doc/git-mailrc
index 1177e42df2f..c15c8e30b46 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -47,7 +47,7 @@ alias simongoldschmidt Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 alias sjg            Simon Glass <sjg@chromium.org>
 alias smcnutt        Scott McNutt <smcnutt@psyent.com>
 alias stroese        Stefan Roese <sr@denx.de>
-alias tienfong       Tien Fong Chee <tien.fong.chee@intel.com>
+alias tienfong       Tien Fong Chee <tien.fong.chee@altera.com>
 alias trini          Tom Rini <trini@konsulko.com>
 alias wd             Wolfgang Denk <wd@denx.de>
 alias priyankajain   Priyanka Jain <priyanka.jain@nxp.com>
-- 
2.25.1

