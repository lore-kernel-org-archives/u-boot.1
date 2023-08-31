Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E083EE49B2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 22:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9135C86680;
	Fri,  1 Sep 2023 00:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="MZHMONRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2CF867B6; Fri,  1 Sep 2023 00:16:41 +0200 (CEST)
Received: from s.wfbtzhsv.outbound-mail.sendgrid.net
 (s.wfbtzhsv.outbound-mail.sendgrid.net [159.183.224.104])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA87866D4
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 00:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=6BHmK/W9pUdXGeyJS/palVX5ectVQQz0hJaBSnRbj48=;
 b=MZHMONRgnyfOr42aSeSJcjdnrfxjTPIDMVZyKrXLRWRGGQQW3kjGz6VJuz+tpVUfx6sZ
 vDEkaZPxraidSsT/G3NwyW0v3fFwEFljryM06cc2i2+L45ujJGCvSfU8MSMbDa0ACJF4mR
 ITrOhsOwjcWAxB0Y9YLBjuj2x3kvgKsyY9xlbvtF52m0L/9VMyk6m1RNRH4xRZYAg9ZwIK
 auoOT26jlTgnIJrlq1qtbTcWz/Xps3G0n80dvzFP6gPn5+Xl12WS+BUuZFX/v5Us690pHK
 iNH0MU1z8qYQpkCkiZdhP2dqHMeM5SzkGcPK2v6gV3ZBjVyyzi4C0iueVo8XayfA==
Received: by filterdrecv-7765c6879f-kx8nr with SMTP id
 filterdrecv-7765c6879f-kx8nr-1-64F11143-2C
 2023-08-31 22:16:36.011821799 +0000 UTC m=+1839260.555387837
Received: from bionic.localdomain (unknown) by geopod-ismtpd-5 (SG) with ESMTP
 id CwQmS9dNRKOgkCDQuYlFag Thu, 31 Aug 2023 22:16:35.781 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/6] usb: dwc3: Use generic_phy_valid() helper
Date: Thu, 31 Aug 2023 22:16:36 +0000 (UTC)
Message-ID: <20230831221629.1027552-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831221629.1027552-1-jonas@kwiboo.se>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h16m=2Fe1lcIXrFZuo1?=
 =?us-ascii?Q?HlFbXffLtJbfcIrAr5VA5aD3rM4uEwr0oBOU+u5?=
 =?us-ascii?Q?HpqcFO9e8EPNtozlfL47VoQmcIyGFITtSZBPIAx?=
 =?us-ascii?Q?IMbmQPvk4RGwiBZ+RsAaPjnLGoVfqYzzg+I4FyL?=
 =?us-ascii?Q?hwFx+pd6h2Jb6bef=2FhlMKK5qZTd+ODb8XPhbVS?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Michal Simek
 <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

The documentation for struct phy state that "The content of the
structure is managed solely by the PHY API and PHY drivers".

Change to use the generic_phy_valid() helper to check if phy is valid.
Also remove setting phy->dev to NULL now that generic_phy_get_by_name()
properly initialize phy->dev to NULL.

Fixes: 142d50fbce7c ("usb: dwc3: Add support for usb3-phy PHY configuration")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/dwc3/dwc3-generic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 7f0af05855ab..3997b9dbff43 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -541,8 +541,6 @@ int dwc3_glue_probe(struct udevice *dev)
 	} else if (ret != -ENOENT && ret != -ENODATA) {
 		debug("could not get phy (err %d)\n", ret);
 		return ret;
-	} else {
-		phy.dev = NULL;
 	}
 
 	glue->regs = dev_read_addr_size_index(dev, 0, &glue->size);
@@ -555,7 +553,7 @@ int dwc3_glue_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (phy.dev) {
+	if (generic_phy_valid(&phy)) {
 		ret = generic_phy_power_on(&phy);
 		if (ret)
 			return ret;
-- 
2.42.0

