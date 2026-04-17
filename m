Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1A9F436B9
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 16:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8042D8429E;
	Fri, 17 Apr 2026 18:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QN7dbnqv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Nb6FAN7d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8218C842A4; Fri, 17 Apr 2026 18:08:49 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6158428C
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 18:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fy0DZ0LcXz9vHs;
 Fri, 17 Apr 2026 18:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776442126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D2YpeXYbc5YS1cFszMQHvvAmrpeh4h2Wonzmb32nTeo=;
 b=QN7dbnqvB3OnRXecXMB4y71Y1gMNRvjiTQV6drpNv2zy6zx9zcO3i+dnIhLTqLZLF5k+s4
 PvqpKsZJ19uwSQXLdeiuE4SwIoxofjX+wjnn4J8apBVUD8NFr568qy341OLEAfbzz4bEqg
 Z1DKTXqXAAoJDcfvA3k1AjxYfjDBS/G7MeNiYThI7xabyAqHpMDOC7sSuHj78pi9oPha+Z
 SR4j4dJv9/h4MkeNX/MV9IFlJAAVscfjjECR9Hdh6rPLHlPy/A2eGAGqH8b5ZaWPCFojLh
 7e5Kto/MTz1rDpEQT0rOJ3fzwRmkD7l8LkavNk8VpajzL8STAQWQ3NoUMVnG7w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Nb6FAN7d;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+usb@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+usb@mailbox.org
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776442124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D2YpeXYbc5YS1cFszMQHvvAmrpeh4h2Wonzmb32nTeo=;
 b=Nb6FAN7dYQXCD/D60aJnbyJ6/kee8adQMAJCd8yO2FboWqlCK9qGxo/aNazVZkUpuCBBO7
 xh0lAd471aVGQCSuJVb2GPTgfNQvHCyfuXn+/VjdQpAsgz70ZRnLzKF/EXf0wgGVjqe5MJ
 dF8Km63M8bqef9T2HJalbUXz44aqc1+0RKsUPd5WZlSVe/94Bzd2YgYrrqmBEf47CEYC1K
 DMS3mZ+KDzMEVCSZoWluUkR3Alx8GloYnvB5Pvh9LRAMJ3/smgEhdgmy3eEYY1uB6kyhwA
 H9PaQ4CaM/UraWrKJZJNLtRQQvklITwKswSKiKbo3HqyyRNT/4yTFPitTKwQrQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PULL] u-boot-usb/master
Date: Fri, 17 Apr 2026 18:08:23 +0200
Message-ID: <20260417160831.28486-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bf9a45953028168e7a5
X-MBO-RS-META: zncrmw1uj4hbskq3m5uujt5aueohpbse
X-Rspamd-Queue-Id: 4fy0DZ0LcXz9vHs
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

The following changes since commit 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac:

  x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288 (2026-04-14 14:21:55 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 884b10e86a0593db423ae14797c07785a69a8ca2:

  usb: dwc3: core: fix memory leaks in event buffer cleanup (2026-04-17 15:57:19 +0200)

----------------------------------------------------------------
Gurumoorthy Santhakumar (1):
      usb: dwc3: core: fix memory leaks in event buffer cleanup

 drivers/usb/dwc3/core.c | 3 +++
 1 file changed, 3 insertions(+)
