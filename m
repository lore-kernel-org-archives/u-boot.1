Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C75C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590CB8063E;
	Sat, 18 Jan 2025 07:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wgn/zHof";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xSOvUqru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB6178070C; Sat, 18 Jan 2025 07:16:13 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB26A80077
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZmZM3bpGz9sjF;
 Sat, 18 Jan 2025 07:16:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737180971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f4//eqe3VY1W0LFvkhMb/Q0aFQKZtmPJ9CDVm4JBTTQ=;
 b=wgn/zHofbASszimaXar3ixiyIGhJKDAtVjp16+kcml50eGujSY6SFQSeryEE4d8G70BW+X
 MHg3tveuVNkNeTqqEeBFp5NGEUFGqH63WtAclReG6ewzJ8CVcrUEjgj4uODJvIoj9u2m4g
 MtcElPdUz6TjW+ATt7+ud9+NkRCyuEqkfmc4THkdTa8M7uTec6u9cdzs5M5p4T4itp9Vki
 H6mVoyupUicSYz6HzA5ttFxNawQ87DlZZeTU8zQ846RG4RD3sdp0KBPKrEIMASW0wAWSHR
 xg/sXc7PkmrD1EMKiQZbW1hSo1Ok2n2SNaBuICSFhXtHuE9tLs46pZ1JEPc5pg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737180969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f4//eqe3VY1W0LFvkhMb/Q0aFQKZtmPJ9CDVm4JBTTQ=;
 b=xSOvUqruD8CYtUQSALtITCDP4mZn6lUle1fgG/yFwncersh8g4bWnrsQoCQVbzsPIVbzm0
 84CJ5L86POtw/yp1egPSkfty8H/skmSv55uwzrf+ydjprgPj6ORTDmbB3KpmOmKEUwen/f
 m4YlJfyk7VkMTk4U/FnZXUYKnNdq1/JpKseOuJd3wd5ubGbp0VnmTe+zGxCGaGIbDmE8Tg
 FS7V6Oc35z4vNOhU74R6L36FFA+EQAu55nj+GzlFxgwyBeWUYB5TDsE9T67sYSYGrYwM5a
 X2988tvAFiVJnYEp/mUpBb5jRSwe1IvoyNJUMXfHKoaSUhp+qzYpkPAyhR18BA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: miiphybb: Fix short name length
Date: Sat, 18 Jan 2025 07:15:41 +0100
Message-ID: <20250118061558.124963-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qmgfj7h8mxyskkoe3ob9dq37ye5gkjtf
X-MBO-RS-ID: 2d3db5e6a6b5d4224ff
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

Multiple drivers copy MDIO name into struct bb_miiphy_bus name, but
these two name fields have different length, the bb_miiphy_bus one
is 16 bytes, the source one is 32 bytes. Make sure these two lengths
are always synchronized, use MDIO_NAME_LEN for both.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/miiphy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/miiphy.h b/include/miiphy.h
index 2bb4f62ea76..1e6c7041fdc 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -64,7 +64,7 @@ void mdio_list_devices(void);
 #define BB_MII_DEVNAME	"bb_miiphy"
 
 struct bb_miiphy_bus {
-	char name[16];
+	char name[MDIO_NAME_LEN];
 	int (*init)(struct bb_miiphy_bus *bus);
 	int (*mdio_active)(struct bb_miiphy_bus *bus);
 	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
-- 
2.45.2

