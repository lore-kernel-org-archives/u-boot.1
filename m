Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C6BCEFD0C
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 21:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D9383966;
	Tue,  6 Jan 2026 22:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="FnU/b6lC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41B983C4B; Tue,  6 Jan 2026 22:55:14 +0100 (CET)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872EF83759
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 22:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767736510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3NtZWrCDjxyvXkd8pGLCaKjBpx/rANuSWl+HZl0x8/8=;
 b=FnU/b6lCax6cxpBriS7DggJ9QDDN+BKigPuh6TF9JRSMbN8SIV1Yod27sRe/HC1/AsmbVk
 vvpCqNC5B9OhatiDyCFc0YVxCcou34BocsoQ4EooS/yNS7RHmAnxT8KLY73zwQ3RCMgTIY
 bjIk3hN8T1qrm1Z/wlSRTCznNDfUNrs=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Frantisek Bohacek <rutherther@ditigal.xyz>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/4] phy: zynqmp: Port several patches from Linux
Date: Tue,  6 Jan 2026 16:54:57 -0500
Message-Id: <20260106215501.727524-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

This series ports several patches/fixes from the Linux driver. In
general, I have left the commit message as-is, only added . The
exception is patch 2, where I have removed the original fixes tag and
added one appropriate to U-Boot.


Sean Anderson (4):
  phy: zynqmp: Allow variation in refclk rate
  phy: zynqmp: Enable reference clock correctly
  phy: zynqmp: Store instance instead of type
  phy: zynqmp: Only wait for PLL lock "primary" instances

 drivers/phy/phy-zynqmp.c | 178 ++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 113 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

base-commit: beab3fe49e1e9209dd32fe2791e7ac706038460f
branch: phy_zynqmp_backport
