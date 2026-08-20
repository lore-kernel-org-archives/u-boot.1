Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4552C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 608B380ACC;
	Thu, 20 Aug 2026 07:15:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YX04VKQxC3xu; Thu, 20 Aug 2026 07:15:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210144;
	bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dcdwnoqPWDGN5DXKL4VOIQJESGwWEGYuuAmT1zka4saB3RB5ZdQwFjhX2tWKrNe3e
	 zXV3rBNcswBCp9Y61kOlDoyDb8iXFFMfVD3ePYw9OL6DS5ADlbJoIlyq+i+2NGnw7C
	 MgkL5ig+VRmAvnb7Rr/XH0qkfR9DuIvXOpUnl8WqBfesrHrHBQHOROw4KR2lOhlyP1
	 U+Qc5yYw0GSQJo4aD5pVF+NSNKGEHrWYW6ejkZ8TN5aPSU49eL3DyoKLhAnPkmRtST
	 oXvYCpd2j7zUgCEPkQwElkw3kuNSx+SAzOH4raZAuFuZq5hdLne2D/y6mkJKZJ6wT6
	 wfU94rK/Jb5Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C9C580B84;
	Thu, 20 Aug 2026 07:15:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 44598334
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A4E680965
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1JsQCZvWTCs for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:15:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=OerZIeoH
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E6A680989
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:41 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49557167508so19755365e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210139; x=1787814939;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
 b=OerZIeoHxVBLVS+E+j2g5+5zZ5SeodxBIfR+mzr3WXPW+NpNWerH0ojvpulDmxkeqs
 VcpKEtXTZLAfqRxwld8OIQnWz3COVKkSPKTk8hiRYIzMa4RnP3l+XO+oBAeEq6n0o7sY
 3gqfZnvypwPAmn5Vp/2EAubbNxC4/RCvkUOWZUrRg1TAQJpaU6gJJiI4lG/ydHQGeLSK
 IxksWCSOiBsCEfC+M1ZawBXilM61uxhZjaHqlH4Bys6VVHu3ic4tRSHJ5TsRgvSnar+b
 fZ2HtcAyo75X6BKffXP4dWjEu4OcAMruVFGBpTv7/6xBonjqrdkUsPL/rsI7AG/QXh81
 j0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210139; x=1787814939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
 b=h6M7GVlpGCXutYO6O7IT60ScP+lIOD/FZfD7xHlhXqSPlgdYupv4+2LKezSYZu0MRf
 QjQJoeDtwjY7bHzwIB8muFR2nS7QlwwVjtL9pU36UQPX+zLOVV1lJhkIRvOM0smn6Da8
 MXnJ/OhpBm8S4oOGQD354+F8VjzPmEPGFT1AcCl3XT7q3d8RTffdv6we2PHUP5E1WWfs
 c9g3fnSxasoP0g2y9syZF8XNrxDEx+MDXHLaM/ad180XcFY6yq+sHFGj01XpLDl+176B
 4Iza0LZORyDA7OWgm98ZrfI1KKivR41KMYWLTmd4JgbkrLYI8pvaqGqGbRm6/ZIqneaB
 W3AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEAxu0JkD8+Xb/JNsvkS1mHLlLCvr9XsBxtgCHDljSUlTbJIKVkbPPSAYZJS08avTbRxv7rSI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwoP5oCeJacpwHLXZlUtxPcWHptwi/TY3k4g06YRBRV7Ez3W413
 zQXNFy9WPEDCL35+9O8T0DB1Ak3ttMdmK6Vkpu8U9EN165Usk6dEVFNt
X-Gm-Gg: AR+sD11aeYp2oJprymZi0tKoCAZ3liyo1t7L3jtPxGzmGflq8/dle6onODyJhmnoxA+
 3qJ/2s0+d8iOewW0lPAFIekmDPrNHYqs+2MH+5BuPb1HTmT20Aoq32M6KF9NLwNwxpCRSfRog3k
 gr0Fdm6EQyMOQVcMtvesV4akpgwiwAAmKoKOlHkz9qjXMWJxc4SJKjtz7mluBk7xN/yRFcJLPpX
 /kRa3j/x/6qEDrkry0q9zP/3/F41hGWAHNHRVyLDDzcUG81oaZ7A99jtx1N3Mx42BmE76XDkPr/
 Zyl24S31MlTmOpXVugq9Ea0NgCx3JMlqtrbv8ia9DWRpkxak7a9Y8ou5szqaMKnePIxHhul9LRG
 ePYix5ocOkqI/+XTPhTF7/zV4z1ut8/FiLKnhCX74scD/GVcp7j6jhNQB6WWzFpNKAXsONUQauf
 mlvFpw8a4Zyxc1aeR+EsehdiRTdgXpKdTYbdrvWuoyXKPoe0a0M1wsKucL2jAuM0rSv0I=
X-Received: by 2002:a05:600c:4f52:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499aa1fdfb3mr158935955e9.13.1787210138959; 
 Thu, 20 Aug 2026 00:15:38 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b23a00sm19197705e9.3.2026.08.20.00.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:15:38 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 1/2] dm: core: read the device tree into plat data after
 pinctrl
Date: Thu, 20 Aug 2026 09:15:35 +0200
Message-ID: <20260820071536.1036898-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820071536.1036898-1-mehmet.fide@gmail.com>
References: <20260820071536.1036898-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

device_probe() calls device_of_to_plat() before it applies the "default"
pinctrl state of the device, so a driver that acquires resources there
sees them undone by the pinctrl state that follows.

It has not always been that way. When the pinctrl uclass arrived in
commit d90a5a30dec1 ("pinctrl: add pin control uclass support") the
state was selected before ->ofdata_to_platdata() was called, and it
stayed that way for four years. Commit 29f7d05a347a ("dm: core: Move
ofdata_to_platdata() call earlier") then moved the call up so that the
platform data would be read before the device is probed, which is
reasonable in itself, but it also moved it above the pinctrl state,
which nothing asked for.

GPIOs are where this hurts. On most SoCs the direction of a pin lives in
the GPIO block, so a pinctrl state cannot disturb it, but on Vybrid the
output buffer enable is a bit of the pad register that pinctrl writes as
well. A fixed regulator asks for its enable GPIO in of_to_plat(), so the
pin is configured as an output and the pinctrl state of the same device
then turns it back into an input. The USB host VBUS regulator of a
Colibri VF50 is one of those: its pad reads 0x22ed once the regulator
has been probed, the value from the device tree, output buffer disabled,
and no USB device is ever powered.

Move the call back below the pinctrl step. That is also the order Linux
uses, and the order the board code of these boards used before the
driver model: set the pin muxing up first, then take the pin. The
pinctrl step itself cannot move up instead, because it relies on
DM_FLAG_ACTIVATED having been set to break the recursion described above
it.

Nothing between the two positions needs plat data: the parent probe, the
power domain and the pinctrl call all work off the device tree.

Tested with test/py on sandbox, before and after: 11 failed, 414 passed,
210 skipped, 1 xfailed, 20 errors, the same failures both times, all of
them from tools and images missing in my environment.

Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
NAND: the pad of the VBUS pin reads 0x22ef after "usb start" instead of
0x22ed, a USB stick in the host port enumerates, and Linux still boots
with Ethernet, SD card and USB working.

Fixes: 29f7d05a347a ("dm: core: Move ofdata_to_platdata() call earlier")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/core/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 6024534ff93..ccdf0ab9220 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -500,10 +500,6 @@ int device_probe(struct udevice *dev)
 	drv = dev->driver;
 	assert(drv);
 
-	ret = device_of_to_plat(dev);
-	if (ret)
-		goto fail;
-
 	/* Ensure all parents are probed */
 	if (dev->parent) {
 		ret = device_probe(dev->parent);
@@ -552,6 +548,10 @@ int device_probe(struct udevice *dev)
 				  dev->name, ret, errno_str(ret));
 	}
 
+	ret = device_of_to_plat(dev);
+	if (ret)
+		goto fail;
+
 	if (CONFIG_IS_ENABLED(IOMMU) && dev->parent &&
 	    (device_get_uclass_id(dev) != UCLASS_IOMMU)) {
 		ret = dev_iommu_enable(dev);
-- 
2.54.0

