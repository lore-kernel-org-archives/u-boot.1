Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D536EC531CF
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83B1C6080B;
	Thu, 23 Jul 2026 13:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xO8XAqYsRQtE; Thu, 23 Jul 2026 13:48:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A42F1608F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784814535;
	bh=dMg33hAXnTNlzFvI83iqNY8EpZi+zxyZueytL2TRhwo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=x5IrWl1cjiKqjeVr2VGMnHI08eGl59Vg4Y2maezcsiJDaQdgIGouMh8rSDtfqfsuM
	 so40zLqXFaMhMJqZMt1ueDfoMkNQ22ljqKKKBAnp2/hImJnLsod+kJuuL0q82hm3kM
	 JpK2toKLGN99CrQzofi2kqhouUltWcr1yD7Vr1VYHI0glFjXpDiofugauSN+urJGg5
	 y6aBkrWxni3ScCzApRa4WtcXTFcqwjpJdzmdJZXJrvJo44LOw2QTmbbJ2FqTYIjwnX
	 dFxuYioOI0ybOwkCgXD0WWXYKDGbUAqSgqQ6FompkvoxIPydcs6ffampxj7ZFj0R7/
	 qE7yRNroVdnMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A42F1608F0;
	Thu, 23 Jul 2026 13:48:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B07542E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1E8A608F0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l4gJAAWS5c_E for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:48:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.92.25.143;
 helo=mail-d14.seohost-mail.eu; envelope-from=krzysztof@kd-solutions.pl;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EF7576080B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF7576080B
Received: from mail-d14.seohost-mail.eu (mail-d14.seohost-mail.eu
 [153.92.25.143])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF7576080B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:48:50 +0000 (UTC)
Received: from 83-168-76-203.static.ipv4.korbank.pl ([83.168.76.203]
 helo=krzysztof-drobinski-HP-EliteBook-660-16-inch-G11-Notebook-PC.lan)
 by h74.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <krzysztof@kd-solutions.pl>)
 id 1wmtn6-00000007jrj-2COJ; Thu, 23 Jul 2026 15:48:48 +0200
From: =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Subject: [PATCH 0/2] Add PMIC PF9453 support
Date: Thu, 23 Jul 2026 15:21:55 +0200
Message-ID: <20260723134051.452817-1-krzysztof@kd-solutions.pl>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: krzysztof@kd-solutions.pl
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=kd-solutions.pl; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dMg33hAXnTNlzFvI83iqNY8EpZi+zxyZueytL2TRhwo=; b=GyIX4AzvvJp8iUl9avKB/CyIHX
 PUNS0HyTwThCx9JutM53thex7ZsJWkY+ty9aXSkFciubsXS0Q+ChOETHxW3VrK50dUjEyITt9ZxYk
 Y2udSQrQJ49Dm8v+bqDuevt+5GdPOWhT5jzoAKRncxqI6xfb/bf4egDu78p0TP/dLSJ/X/MJ8uu+c
 Wgg8weJ6RtCp1H+5tbxsbrIKQgysPRwZ6yzKl+9HHQGeM95uDgDXwbPwUk+eKgjvMjRWftGiivUuk
 QTaqULNLpv7d3mOq+HMIXXp0Fp+B9eIqrqB7cqKYxMSwH2dj6ZT4WTOWmCzKtTQkOIkCoZW6guvz5
 jdvnhRXw==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kd-solutions.pl
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kd-solutions.pl header.i=@kd-solutions.pl
 header.a=rsa-sha256 header.s=x header.b=GyIX4Azv
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This is patch series adding support for PMIC PF9453. Patches rebased on main
branch. Original patch series is present on [1].

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240930035531.27079-1-peng.fan@oss.nxp.com/

Joy Zou (2):
  power: pmic: ADD PMIC PF9453 support
  power: regulator: ADD PMIC PF9453 support

 drivers/power/pmic/Kconfig       |  15 ++
 drivers/power/pmic/Makefile      |   1 +
 drivers/power/pmic/pf9453.c      | 170 ++++++++++++++++++++
 drivers/power/regulator/Kconfig  |  15 ++
 drivers/power/regulator/Makefile |   1 +
 drivers/power/regulator/pf9453.c | 256 +++++++++++++++++++++++++++++++
 include/power/pf9453.h           |  71 +++++++++
 7 files changed, 529 insertions(+)
 create mode 100644 drivers/power/pmic/pf9453.c
 create mode 100644 drivers/power/regulator/pf9453.c
 create mode 100644 include/power/pf9453.h

-- 
2.53.0

