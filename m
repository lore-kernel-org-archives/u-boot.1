Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35F5C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CA588376;
	Mon, 22 Apr 2024 08:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hex3hqTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93DB988329; Mon, 22 Apr 2024 08:30:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94ACB8837A
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767442; bh=cH7K1ilyv/ZLaFRKROcgLxJiCTU6tJDYrrQHVy2HPPk=;
 b=hex3hqTY9Czy0aID70dF4gFM06XsWa/zRL4sQQyOkojpBL70gTmtk0jsVrsbWMq963ouEBpkO
 P8lFiYD/n7KMnOjazolY3Y/VwxhMuw9O/szxwoXYtKKjlbIJnVd+Ncn6zZG4q+UhYwz5UyX1MCT
 c16zYCRDd3munDb67FBz0K7EU2SiB/OswCej7PaIYHfiH314Pi2HWv44uJs5fbCqB2nmp5FE38v
 NqbuSIMo/k/KNCJsw32UCvPPTk1UUM15bQmLk4UUKFSMF6ya3+/Ys+sKzQ7WwUJZ1JaYmoLdC4L
 iX/DgTXtGkC4tgjEVcqR6eW3Ouk8aQG+afDyWieh8xsQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 17/28] rockchip: rk3588-coolpi: Add boards to documentation
Date: Mon, 22 Apr 2024 06:28:54 +0000
Message-ID: <20240422062936.681359-18-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6626041234ba165ad44743cf
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

Add the CoolPi 4 Model B and CoolPi CM5 EVB board to the documentation.

Fixes: 3e15dee38d45 ("board: rockchip: Add support for rk3588 based Cool Pi CM5 EVB")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
v3: Split Makefile change to a separate patch
v3: Collect r-b tag
v2: No change
---
 doc/board/rockchip/rockchip.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 5dd5ea7f1e29..9a726e9cde63 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -131,6 +131,8 @@ List of mainline supported Rockchip boards:
      - Turing Machines RK1 (turing-rk1-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
+     - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
+     - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
 
 * rv1108
      - Rockchip Evb-rv1108 (evb-rv1108)
-- 
2.43.2

