Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2873DC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47525887D8;
	Fri, 31 May 2024 17:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="yPcI8BoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB7688076; Fri, 31 May 2024 16:34:12 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A02CE887A7
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.schramm@manjaro.org
From: Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717166050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OcvcsZYSxuqwI2g8hYVsJFE+7p8Xg+uYkooK89wITKQ=;
 b=yPcI8BoUx6PQiAXTU/MTpDaG44KY3RKV4qidTKwm4PGEGHtCfCBYBCdPRSBmnG5UuoT7r0
 /7AssZWy7OzcvXadVMYcGi03gsd2kDcA4uN1ycVPwlrVcPnRoizMMJ7ZeoSBUzyxTSq1yv
 SqS6Y1U/PnS0BHGVyN7MUhTRpasTBE5ytz9zLvN2B0piebZx+iAI68DWHeioPy2WW2PzIY
 U/Z/8NNA7uRSqfvqMORHDMNswbR1qQNj9/zfg4uNY/sq6WugWT384B/bMyVDn3AH4Mxv17
 vxP91kjPUgKoSJp79tnM3cMuohbkt8LLKw9q/Vd4bPAFojTa9nmcsXgX4DApiQ==
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 0/2] sunxi: add support for Ethernet on V3s-based SoCs
Date: Fri, 31 May 2024 16:33:48 +0200
Message-ID: <20240531143350.14855-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
X-Mailman-Approved-At: Fri, 31 May 2024 17:13:20 +0200
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

This patchset adds support for Ethernet on V3s-based SoCs, adding in
required clock gates, resets to the CCU driver and finally a matching
configuration for the sun8i_emac driver.

Tobias Schramm (2):
  clk: sunxi: support Ethernet clock gates and resets on V3s-based SoCs
  net: sun8i_emac: add support for EMAC on V3s-based SoCs

 drivers/clk/sunxi/clk_v3s.c | 6 ++++++
 drivers/net/sun8i_emac.c    | 7 +++++++
 2 files changed, 13 insertions(+)

-- 
2.30.2

