Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C346DCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D6486B23;
	Sun, 17 Sep 2023 16:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AL13oXqv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GD94/UjX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07CE086B34; Sun, 17 Sep 2023 16:14:00 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA3C86B05
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVKK6HQKz9sQ8
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0mGs2OKFlvdqXXyv272WIkJOZ3jhr9MDkaG6EyKag8=;
 b=AL13oXqvYk+8sBPCJXF+y3rIcWVcgHKdlkOBd4FKuyK9spUlbCMHrH7l560c7RXs41Y5y2
 kVUpzckWpJrO4WGTEEO/evw8quSbH+IKa8BllKJZn436cGRSnSzjMVTl2YfJ+dfdX631hK
 yiNDKFzXrlI5LCkK3FMWt+/aHAeQXa/dMTUkpjmz5dq8tlDLLbi4vbQt2+GaLZFBzvvExJ
 aO7gYXOOYFgIUi61kRqd6+LlmxHAcalEyQ1Om1JXrtcVH3sMpfBWeniNfwM5FS/S4U/xn9
 G2LNxPNQeio2s12UcGqCqclgHjE2q1Vu0u/UaoXOB1KF51QKHxm/UnzCTYjxCw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0mGs2OKFlvdqXXyv272WIkJOZ3jhr9MDkaG6EyKag8=;
 b=GD94/UjXDySfdR1SekNY9cPW0EMGGKni54QNeHTT9XEA9JhGT6JfPI4uBYaMF96amvHGra
 D08XuotsQUHLMENTnFydOleSQ3IZa9gVVZrJ+02wFh0/qQV13XT4E9APXeAl9g6ooU93cM
 Z5k4x4giIiWNQWY7WhcVp7tz+3D6EFVvB9FQoXi95l1EohnfV9NXzl2QxR0Mi1dzWt8dC2
 2O8x34TRXVLIpajKyNpCcHVmzBgyYFctVrphcA81fyVjyC9uxLnTFje24QGDX37aU+aPpW
 rWELruZLBjRPaur++vTeFTyYpLrOQ7GohP4eZyKqSLfkQvtYl5YQl/fdE61iNw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/19] ARM: dts: renesas: Synchronize R-Car R8A77995 D3 DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:10 +0200
Message-Id: <20230917141319.379939-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 963c8d94f414272a64d
X-MBO-RS-META: ukyoaoaro8cu99rr5yamhz4yf9u6w1t1
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

Synchronize R-Car R8A77995 D3 DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a77995.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/r8a77995.dtsi b/arch/arm/dts/r8a77995.dtsi
index f040d03e0a8..e25024a7b66 100644
--- a/arch/arm/dts/r8a77995.dtsi
+++ b/arch/arm/dts/r8a77995.dtsi
@@ -1037,7 +1037,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
-- 
2.40.1

