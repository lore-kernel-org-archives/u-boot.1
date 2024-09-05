Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCC2CD6E74
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 17:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2164988BBC;
	Thu,  5 Sep 2024 19:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="vDmWTO0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81ACC88CBF; Thu,  5 Sep 2024 19:18:48 +0200 (CEST)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E86B8865D
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 19:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1725556725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6lFghGzyh/BYg5B9knG1WH2D95KF1NAuzdLZXjLoHu4=;
 b=vDmWTO0gRWVkzRiZUvAU5THALbj8THTzJHg8bZ/4LUY5ZhfR9ZU8IpITd5O6DEKywEJyM7
 ReDdjnLJXK2Urqk9UtTwGTrI82V3lwQvMR87GLygzkMe+ATxkI32VMlGywBF8w139UvUw5
 9iV54r77bRjPLhQ5WPA5LGqhlYFBLrc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@xilinx.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 0/2] arm: zynqmp: Initialize some registers at boot
Date: Thu,  5 Sep 2024 13:18:31 -0400
Message-Id: <20240905171833.325548-1-sean.anderson@linux.dev>
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

These patches are independent in intent, but they modify adjacent
lines so I have sent them as a series.

Changes in v2:
- Don't set reserved bits in AXI_RPRTCN, since QSPI doesn't use ARPROT

Sean Anderson (2):
  zynqmp: Disable secure access for boot devices
  arm: zynqmp: Enable non-invasive CCI-400 PMU debug

 arch/arm/mach-zynqmp/include/mach/hardware.h | 5 +++++
 board/xilinx/zynqmp/zynqmp.c                 | 8 ++++++++
 2 files changed, 13 insertions(+)

-- 
2.35.1.1320.gc452695387.dirty

