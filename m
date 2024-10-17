Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370CBD3C530
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 20:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C234C890BB;
	Thu, 17 Oct 2024 22:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UYswwxVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34CE890BD; Thu, 17 Oct 2024 22:01:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C87890BF
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a54c=RO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1729195268; bh=0vyJMaazi7wdpu0uLDUeCuPHieVXgU4pCvQ2NH/XqtI=;
 b=UYswwxVcVN0dERQA0ABFovFVM+WKoWaarl8toZUumT3/5SCwjggQpXsWmRO3c3juL/iXBLr27
 twDNQJ8c/iy1jqFVMFL5wUV7Q6yetdkqRn8aSR1naj2gHWxlxKG67xAMuKpvp27dC4H0jMcTj3P
 TTnHTwyqtzOFzE0LXoxdRy108MJUL43Jj09mHf0p2plWczDkfCzfZYbp28ZoJhVwFe+dZfyTOuB
 WG7Ieruj13lyN3wOoSTa3huHd6VoI3HutJN4vWgxU9h+kxFWdxUT5MOzzZloMSxci1iRixmoLRq
 tZTNd1+Q2OeYPF5lIqYNcC3fpvJE2eU3Jp4SbE6Uj1Ow==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 6/8] adc: Allow use of adc with DM_REGULATOR disabled
Date: Thu, 17 Oct 2024 20:00:25 +0000
Message-ID: <20241017200039.1235524-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67116d026385e073f5ab1406
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

When DM_REGULATOR=n is used the device_get_supply_regulator() function
always return -ENOSYS.

Change to treat missing support for regulators as a missing optional
vdd/vss-supply regulator to reduce error messages being logged.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/adc/adc-uclass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/adc/adc-uclass.c b/drivers/adc/adc-uclass.c
index 16600be821c9..b02430eb7d7f 100644
--- a/drivers/adc/adc-uclass.c
+++ b/drivers/adc/adc-uclass.c
@@ -382,7 +382,7 @@ static int adc_vdd_plat_set(struct udevice *dev)
 	if (!ret)
 		return adc_vdd_plat_update(dev);
 
-	if (ret != -ENOENT)
+	if (ret != -ENOSYS && ret != -ENOENT)
 		return ret;
 
 	/* No vdd-supply phandle. */
@@ -406,7 +406,7 @@ static int adc_vss_plat_set(struct udevice *dev)
 	if (!ret)
 		return adc_vss_plat_update(dev);
 
-	if (ret != -ENOENT)
+	if (ret != -ENOSYS && ret != -ENOENT)
 		return ret;
 
 	/* No vss-supply phandle. */
-- 
2.46.2

