Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B64C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 22:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A78F78496E;
	Wed,  8 Jul 2026 00:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kvOLbumI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB05484979; Wed,  8 Jul 2026 00:03:02 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9419484942
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 00:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so59647a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783461779; x=1784066579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f9wRtEW0G8zo9C7TEvoBLWcpwDHzgg3SW5FANNS5/WQ=;
 b=kvOLbumIdIFdtt2WO2oiCiAQRC++KknGDxluOvCWsd+/+F8j/xaHLnYnIFZ7pf2Qi9
 CYxgB4wJescTPcKOfWqT4x+SGhOmW8EJHGGm3hYR8CtDvl0qy8zDXOABygbn6RInBtXy
 o6kliGpsKEn+HEO4nPJGnpuZqVleNj6e/vae0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783461779; x=1784066579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f9wRtEW0G8zo9C7TEvoBLWcpwDHzgg3SW5FANNS5/WQ=;
 b=nN6U1YNSQRAXqINOtQzYGfLcQ0wiMagC3G5UzF/5Wk1H7FrlZw+puvj40qlObG/GIz
 T7fOJ+3FRFvDMBUbJHpoIQSsqui8UnENxgTs17lLS4iNe100uXci5tNxiVV0eLyzPJV6
 9o3/NuvkPxHDZmHvUVU4rdNnsLaUXvYXcA55ijUW/nofv0rPcJJFCIc5GcpM3KPiiILa
 20nTLtYnUUJWgAD6XzBjCne6u5XdGqJLDqU91gbCunt6UKRHpGKyq9F5iiRoK/T9XQt5
 265gQyCmGMWquEunzdv1jV5gJR4c0bkKQJLUql+QlzYNNjubNI6bmF6LYx6OOfYZDlvn
 snqA==
X-Gm-Message-State: AOJu0Yxra6YS8ED/XZceDLBq/1Aui4ISLe32WGBRdUYWhgegWyJ97ybu
 VHn0u/v0tP/tYeqwI5XHXksfz+sa43EV5i0WTAaQIkQeaQd4XDl6dUQV+CT4v87yzxC9rkfP+1z
 L/MevvEI=
X-Gm-Gg: AfdE7cncv+f860PL2H09HawrQ92t/ph2eKfRLEgFTK2EdDpa/ysLOfYpkbo+M+GEWKs
 h3P/DxWfKZb88yPrNlwvwnsb/u1IT3GZhVBwM/Orev04YaAHq/x5GoEC1w1VW6fvC/bFtEMzeAr
 rjczGo1oAF9S3E62wIsahnKJewBgSTakZ+DUmxfrIwndGeyR6hDuHkq82iWGODjQIMhVByiIJ2V
 2fJHCSbHGOQf0HasLyIyXct4e/LjYRmFfBDrJlC2D2ur1gBjtRawvnUzYgY1AYn2fhY2x6aYfog
 QaA/YcN5iHA4pgY/Ss9pTuoLGifReZwvgKs9os/4T4b4qdX0HOAfZHDGGcB4RGQpFfidezq/yLW
 NMJHbxEvQq7wkxhI4Wyly+hL9hkHDfqNY7a0+4IQu1ryfRvcM/SjZbLm4dLrNehAMSapI2usazD
 Bd2jGMvny9/0vouDd5rTB1qVb4GiCkRQNQcPb2RRLUtd97gw0nLLpS4wiyBAW9ot8EUHbWLZkEW
 EswBqIXC7wVPQRTCKc0KOC6ja4bxkJ4WZ4NU1zP9rhC1ahjpbNCBoIxuFM5DQ==
X-Received: by 2002:a05:6830:6ae8:b0:7e6:deb1:485b with SMTP id
 46e09a7af769-7ebb23223b2mr4978994a34.16.1783461779276; 
 Tue, 07 Jul 2026 15:02:59 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2bd6c4sm423159a34.23.2026.07.07.15.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:02:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH] arm: qcom: Update ipq5424-rdp466-u-boot.dtsi for v7.1-dts
 changes
Date: Tue,  7 Jul 2026 16:02:57 -0600
Message-ID: <20260707220257.252911-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Once we move to the v7.0-dts tag, we get a failure to build of:
dts/upstream/src/arm64/qcom/ipq5424.dtsi:556.21-573.5: ERROR (phandle_references): /soc@0/mmc@7804000: Reference to non-existent node or label "sdc_default_state"

  also defined at arch/arm/dts/ipq5424-rdp466-u-boot.dtsi:20.8-39.4
ERROR: Input tree has errors, aborting (use -f to force output)

Looking over the changes, this appears to be what's required to keep the
platform functioning as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This file isn't covered by MAINTAINERS directly, so can someone please
follow-up and correct that? And, based on looking at the changes between
v7.0-dts and v7.1-dts, this would appear to be the right change, but I
don't know the platform.

Cc: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
CC: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
index 36640f31d616..56677cd6f6da 100644
--- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
+++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
@@ -24,7 +24,7 @@
 		mmc-hs200-1_8v;
 		max-frequency = <192000000>;
 		bus-width = <4>;
-		pinctrl-0 = <&sdc_default_state>;
+		pinctrl-0 = <&qpic_snand_default_state>;
 		pinctrl-names = "default";
 		non-removable;
 
-- 
2.43.0

