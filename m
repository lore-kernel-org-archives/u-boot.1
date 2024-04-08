Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6540C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 21:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4EE288158;
	Mon,  8 Apr 2024 23:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EiAWd3np";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49333880DB; Mon,  8 Apr 2024 23:06:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D7F88134
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712610393; bh=ytWtXdA98X5cXn8z/Es4ZVRoMug2lhKpb6T6uJ2zF9I=;
 b=EiAWd3np0T0Cqdc1MT/0FHxLevjDqWPphIpjLr8beEBOLqM68/iM+ird0e0tAHzgKdyyM9NiK
 y7L/3NT7HWDfb59mLqErqG1SqMFCwkoEGQQl8z9wEFIW0NdT2jodbt2okNF/IfzYLanSSkW7Lmo
 t+fCia4zyTAIeoyo9PY4XvfHYFame/Gf+mh7SqKDvPJofnvJCRXnddwhUqZU2RO8qlOS+2L9w8E
 HtUbocPpMXJEZFBOzm9me7A7PdDvw1GsfFUP23+3Px0OQUJXsNYR4c+kWKEAvt+6bY3TpbRHtNj
 6QF+dkqmX9t5KhR24fiYCRWkuPvmV7f79+5wwtfR22Zg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH 2/2] mmc: Add support for the no-mmc-hs400 prop
Date: Mon,  8 Apr 2024 21:06:16 +0000
Message-ID: <20240408210619.3749231-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408210619.3749231-1-jonas@kwiboo.se>
References: <20240408210619.3749231-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66145c5758e14ec37d9cf1d0
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

The linux commit f722e650d965 ("mmc: core: add support for disabling
HS400 mode via DT") added support for a no-mmc-hs400 prop.

Add support for the no-mmc-hs400 prop to disable HS400 host caps.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/mmc/mmc-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 1349da72b102..1b454e8ec758 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -256,6 +256,9 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg)
 		cfg->host_caps |= MMC_CAP(MMC_HS_400) | MMC_CAP(MMC_HS_200);
 	if (dev_read_bool(dev, "mmc-hs400-enhanced-strobe"))
 		cfg->host_caps |= MMC_CAP(MMC_HS_400_ES);
+	if (dev_read_bool(dev, "no-mmc-hs400"))
+		cfg->host_caps &= ~(MMC_CAP(MMC_HS_400) |
+				    MMC_CAP(MMC_HS_400_ES));
 
 	if (dev_read_bool(dev, "non-removable")) {
 		cfg->host_caps |= MMC_CAP_NONREMOVABLE;
-- 
2.43.2

