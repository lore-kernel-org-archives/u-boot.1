Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173DCCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 21:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D647836C8;
	Wed, 13 Aug 2025 23:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ezcx9giw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EzqHtIFd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5AE83741; Wed, 13 Aug 2025 23:26:58 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F77182A53
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 23:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c2Lzh1YgGz9sqd;
 Wed, 13 Aug 2025 23:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755120416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qr4U3HWSoN4g0VniMzcwZSyptBPTGGZMYpSxg9oI3yI=;
 b=ezcx9giwOQ2FI9sqpsZWh+M+XSNx9WbPVKfUa1AHbfXJrxMhZa/JO1i8pIdLG/pqaOCnAI
 +4n6lLb9nIc6nBTxyj1eqTOQ140WwE1ZsH/PLu5fHXNToSUChYNuGDFPPtj5L320IUqBv7
 Q8a5vZ2CKL+9p+jJN4GB0KOo4730e/dygSUTvpnkM7qRciKSWe6+Ns8zGCjZqYC9v9opft
 +kxb9goZ4X8BfoMjxXTJ1Zf8RN4dlteLMJcoEu/zPJDn7YcArrdUN1at6Cp2CHGwd9Ptv/
 H+lY269OhFyJkRQaRsfjsIxnwIxDLFuX66ezoj6+bMKdUyZC+AomkE3INNXqGA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EzqHtIFd;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755120414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qr4U3HWSoN4g0VniMzcwZSyptBPTGGZMYpSxg9oI3yI=;
 b=EzqHtIFduYC/Y1B3oStmogFnqt2OtR9ICDEcpRUFVSneSJ6GXfTPXCGOBTjJI5oZ3uoNGb
 lKagLa01Gpb0Z9EqUCpr9rXNp8x2dbQ7gAMO8weqDmrzJ2kiKbAODdLg3bMtxNYU4uYuhd
 jZ4VELI2q8ty8ZjIq1uzhT7xO1rh+XUYI/h63eIooo31aEJaFLoeaiU71FqZhjdM31lTAc
 Zx6ldaSc9LWGG+rX3BpB35o1aXoBlR24E4ZBSgrPY9FdOpAp6fbganer9G+hL+cEWa/cq5
 L7kI1E/zqKyqEpFjCdorJreyexzO8GFvL/dWaFOBtwzHHfhPnkfHy2kQREqQgw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm64: dts: renesas: r8a779g3: Invert microSD voltage
 selector on Retronix R-Car V4H Sparrow Hawk EVTB1
Date: Wed, 13 Aug 2025 23:26:27 +0200
Message-ID: <20250813212644.112831-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7aepsf95uda8ie3mm7k66ya88irkdjkm
X-MBO-RS-ID: 4c8876e78a208b3ec8f
X-Rspamd-Queue-Id: 4c2Lzh1YgGz9sqd
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
V2: Move DT change to arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
    until the same fix lands in mainline Linux
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index 3210360ebe2..b5f226f2f2a 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -53,3 +53,7 @@
 		spi-rx-bus-width = <1>;
 	};
 };
+
+&vcc_sdhi {
+	states = <1800000 0>, <3300000 1>;
+};
-- 
2.47.2

