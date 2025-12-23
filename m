Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD08E6FE24
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 16:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C8C9840CC;
	Tue, 23 Dec 2025 17:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y+KnUv9F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kbI3HQ36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA75840DF; Tue, 23 Dec 2025 17:55:11 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D95883CB9
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 17:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dbLj92Dmpz9sl9;
 Tue, 23 Dec 2025 17:55:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766508909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IIXsT96aQB1OLJ0bhtyP+ZuEtPQsYxjtjcbVe12+gIM=;
 b=Y+KnUv9F95UGKkn8hmERiMn3KKmJUfga9uU4v0UeIh2RZ2B+TI2wmzzp+V/K6r+x+TwzYG
 cE+13yrjoU157TU4pbzfig8ipRkd+bqerBsYWhn+wY6SlNOL+fP3IvTFVEdRUBmtye0IX3
 OCSn50m7GaluQoDAmyxUT56ZTiC6sj1oSEk4sE1yrUf7+7gFh9+RzQBTkcQmtSZfEgbah9
 FOHxBdd0qVChp+6RBF8sd43BQbn+GaMgbyOCs828R8ZAXST1YHeAdGSnW7caSkwfAZ82mc
 lqKmza1jkpiKsI4GHAedLyoaQ5VI4lZHHN/3Y6hgoKI/E3zcN2tOVacmnS/O9w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kbI3HQ36;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766508907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IIXsT96aQB1OLJ0bhtyP+ZuEtPQsYxjtjcbVe12+gIM=;
 b=kbI3HQ36I2X4X9PNiqLfImxF9z+EPoXVhlxIlELlFuVmq5+zBizktQhXx97SamuHJgzISf
 RB5l7hF66U3wnL+vVGuD5v6WtoSc30EKpyOENbLi2ayyFNHv+0YbNX/ap4q13p5KSrGkwX
 IkD+lywaZWhNSHvR3OumRee+20egFbmf9++GMOracPpGtPrROwxsLMEvLG6+4cLDTJ9VuW
 RnninxJvUUZA0088U/XDjuR27GeAtSrcwTeV5Cr00y1AvEpHs8N0/ZgUXQoUlM0digV6pN
 CXURMksn6XJmPnHSHWDCCpQ5Js3ll+wRFtTRtLTlpExq7n6cBLuRnCrp1P1ZnQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mathieu Othacehe <othacehe@gnu.org>
Subject: [PULL] u-boot-sh/master
Date: Tue, 23 Dec 2025 17:54:35 +0100
Message-ID: <20251223165456.34899-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f8f3ff63ac07ba4f9a4
X-MBO-RS-META: bf4ex9bsjtjnt7ca6wn6ucccruimigjz
X-Rspamd-Queue-Id: 4dbLj92Dmpz9sl9
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

The following changes since commit 0f6ff53d55ba254de8a995c2a2f5a313acd40ac7:

  Prepare v2026.01-rc5 (2025-12-22 16:26:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 0c230a3a8ef46f76a730324f44da96c713088825:

  net: ravb: Configure CXR31 and CXR35 on rzg2l (2025-12-23 15:35:34 +0100)

----------------------------------------------------------------
Mathieu Othacehe (1):
      net: ravb: Configure CXR31 and CXR35 on rzg2l

 drivers/net/ravb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
