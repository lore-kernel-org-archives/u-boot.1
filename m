Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90614C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 22:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD2888842;
	Tue, 13 Aug 2024 00:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="xTkCDfev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF88888BF; Tue, 13 Aug 2024 00:07:45 +0200 (CEST)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [95.215.58.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6878D884C3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 00:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1723500461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sYOF0gTPcQTsvr8nntoTWlSulCbm/Z8bEsbiMPB4Y0M=;
 b=xTkCDfevhBVgbszg2URa3eHZaUTmR4v4vwurxb9SAvAneGwfHMqqvOP+thUt+YK60zYtJq
 IfEiVAh/HZeDDs8l1VhinjJIcSm6RW2r9FzvhMwvD0CxYRstuBAoO2jTD3arxWHvSA+OVX
 0qWvhQ+vckmGUfeDbHriKRN04e6JjM0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@xilinx.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/2] arm: zynqmp: Initialize some registers at boot
Date: Mon, 12 Aug 2024 18:07:33 -0400
Message-Id: <20240812220735.3602212-1-sean.anderson@linux.dev>
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


Sean Anderson (2):
  zynqmp: Disable secure access for boot devices
  arm: zynqmp: Enable non-invasive CCI-400 PMU debug

 arch/arm/mach-zynqmp/include/mach/hardware.h | 5 +++++
 board/xilinx/zynqmp/zynqmp.c                 | 8 ++++++++
 2 files changed, 13 insertions(+)

-- 
2.35.1.1320.gc452695387.dirty

