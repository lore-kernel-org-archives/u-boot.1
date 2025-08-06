Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FBDC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 01:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE2F83968;
	Wed,  6 Aug 2025 02:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xkyBjJF7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RnrBihzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9715A8129F; Wed,  6 Aug 2025 02:59:55 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1728397D
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 02:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bxX522q6lz9t8l;
 Wed,  6 Aug 2025 02:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754441990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FRtYg5Hph/wJsnqiV2qXqFw4TTE85kFdeLulrd0WzmA=;
 b=xkyBjJF7P+c/JYue8tCRhGWAhk9rGWJwo4vf2i9hrjFDXSyvOe9yoSOz1H3Vywk5xWhvuc
 H27HEoiIC7IPDKMTQTg5gH1ixd4q2eroAjPwghLuN1bbqcIbTVREgkBobaZoZTBHURkmmd
 l7JiGtAYj7R3MM7fwn8eBXQi0zT4YAkkY6PgHtghSq+E/PgFDtHMxBdJZFRszWgIkDH+Hx
 PimtqoFxxYS+0yMuIZKxfwnOt8B9jrZC55V1kFlJkU7r/8zP0w3Y46lh5OHighJhOtEOW+
 Y+xJ2FamCVJ9pa51DoXRiDXAp79dHMplx/Q6JIhvXRYtJZ8RhZSmQzFmMBP9jQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754441988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FRtYg5Hph/wJsnqiV2qXqFw4TTE85kFdeLulrd0WzmA=;
 b=RnrBihzodY6//ucBfJCx9faUtx7j2KgqBPLBOqQoH3ovQTMxqCY6hlu9Rqo0E/NyNKY9Jf
 F/IVXu0oXIK00RUrhEuAmVBIg2fmMR+XhETfsYbU1uElB1RHpfnEwwvp7Din0e44MdsSxi
 PT3v4IcDKnq3rRK3DRILUaXVwIyg4nvYbNTKGk41RCv4s3+cC13yLAUa05v13sZc7OZJZO
 WMVbdFzoWSQZOHaJasQMxRlpC8tAyx+yNuRYjCLQZbFLQeITHG2NpvqKid0sENDcpJIrKO
 I0tzFlMxuyMFmfglQ/Lq1A0G45TXQ3BYjHVPBMCTdx13bZk3PAH2dfS8/BO9vw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: r8a779g3: Invert microSD voltage
 selector on Retronix R-Car V4H Sparrow Hawk EVTB1
Date: Wed,  6 Aug 2025 02:59:20 +0200
Message-ID: <20250806005933.284462-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 76958b7241836d31650
X-MBO-RS-META: 1sii65u4yqe1ckuwfs17kzdz84t4rks1
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

Invert the polarity of microSD voltage selector on Retronix R-Car V4H
Sparrow Hawk board. The voltage selector was not populated on prototype
EVTA1 boards, and is implemented slightly different on EVTB1 boards. As
the EVTA1 boards are from a limited run and generally not available,
update the DT to make it compatible with EVTB1 microSD voltage selector.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
---
Matching kernel patch is at
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250727235905.290427-1-marek.vasut+renesas@mailbox.org/
---
 dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
index 58a146466e5..1b944532447 100644
--- a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
+++ b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
@@ -178,7 +178,7 @@
 		regulator-max-microvolt = <3300000>;
 		gpios = <&gpio8 13 GPIO_ACTIVE_HIGH>;
 		gpios-states = <1>;
-		states = <3300000 0>, <1800000 1>;
+		states = <1800000 0>, <3300000 1>;
 	};
 };
 
-- 
2.47.2

