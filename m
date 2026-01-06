Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ADBCEFD03
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 19:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC7F83FC1;
	Tue,  6 Jan 2026 20:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="DvwsYx6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E2B83FDC; Tue,  6 Jan 2026 20:53:35 +0100 (CET)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF18483FDA
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 20:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767729208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x0+LYQdPyEFahoirPSdOom9KBUei6HrmppO2uXTXsKA=;
 b=DvwsYx6mP795pSEohwV2AonqWB3J0IlRWLI0tmHbQNDZYiuVqVoOJYrrIAQHX10ViNjTUS
 MCTcjzeYki1GyQMYKolI9ZmRw6N3kMi7pyZguzktfiDn7/5B05T/EPF9f3owtWeIoPv/6g
 x1JKEDma9CB94R7b6ZovUm4Nv2yxNX8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tom Rini <trini@konsulko.com>, Adam Ford <aford173@gmail.com>,
 u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/2] clk: versaclock: Fix clock parentage issues
Date: Tue,  6 Jan 2026 14:53:20 -0500
Message-Id: <20260106195322.657150-1-sean.anderson@linux.dev>
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

Fix two issues I found while adding 5P49V6975 support.


Sean Anderson (2):
  clk: versaclock: Fix clk_get_rate
  clk: versaclock: Fix internal crystal clock

 drivers/clk/clk_versaclock.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

base-commit: 1d59479362c7f6a681a2b3c14e97edff7c0f5a7c
branch: versaclk_fix
