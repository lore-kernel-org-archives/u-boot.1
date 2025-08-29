Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86904CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 20:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED04C83741;
	Fri, 29 Aug 2025 22:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jwCRwfIp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M9LiSiyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C58836D3; Fri, 29 Aug 2025 22:52:27 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28029835FE
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 22:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cD9ST033sz9tjX;
 Fri, 29 Aug 2025 22:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756500745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uX8JHXCvdubFrqG/NOTEOkXVfBL0VL2qUqSTgtbmHjI=;
 b=jwCRwfIpn1dWoix2MpKP0etIMXyan2qAqC0MXGSg3Nk1MvGB1sFsfswxTdW7Hx8+c602cf
 KcMVyMySYvG15NEsLzIU05txdivzNvecyYtMH79r5FOI/LhDrYt8G3AmaJ7EDZ0yUtpwgr
 lPwwdnl6t44dYSTXIKz1g49gDJkoC72fAH3lbz0u5PLuXp5/ERDhrtO7I+ZHoswaUs4f6H
 2FBosSkV7AwmPALA5t/M7qRUSUy2EC+TY3icm/keStWQReCMDaK6iA6VA1wCy+M8tqMl8/
 7bKWyItOBiE3/76/d70iZOwgGhOBbKeToRruWjLCWiF9P99ZIWLFJkl53uG8aw==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756500742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uX8JHXCvdubFrqG/NOTEOkXVfBL0VL2qUqSTgtbmHjI=;
 b=M9LiSiyk5ga4iEDkWvDgaos5R/oub4GsywK6m9sZpIcxYA38/A0V4V8Q3zk+io2DC4+hp5
 NQwz+eeX43rqP3mfiUCYgoOaecMdhfjdOSHQkirWcGMG1lK4kL6YAyO7qwjhx/+LL5IbO6
 z17ozULYk3puHLYbsUpUil2xP+mdx8kaHEhrzjpWHFFqJuFYRu82YjrHazCxU7z4R3jMev
 r9/yzAv5jLBgLXhI8Pjkgqm140VL8/WLTwgi/9Z+P9ABuDSZreDo23x2VdKnhZZGZtzRH7
 xIF2/XAQSa2DGp+2zUL6QnfCGSOYW4H1xhetnDaW00j/tENjC4wCYWOJZpIfoA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PULL] u-boot-usb/master
Date: Fri, 29 Aug 2025 22:51:46 +0200
Message-ID: <20250829205203.281150-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a5239e291b28aa2c37f
X-MBO-RS-META: irds6mw3nnd4p8uaxiz75x6mom946rc5
X-Mailman-Approved-At: Fri, 29 Aug 2025 22:55:28 +0200
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

The following changes since commit 3dc5e9a0108bb114175b6362f9cb22367402f624:

  Merge tag 'u-boot-stm32-20250825' of https://source.denx.de/u-boot/custodians/u-boot-stm (2025-08-26 08:33:10 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to ae2cd1b52d4ded22ac2359964c5682b5a5c1cc28:

  usb: cdns3: Do not access memory after free (2025-08-29 13:12:41 +0200)

----------------------------------------------------------------
Andrew Goodbody (1):
      usb: cdns3: Do not access memory after free

 drivers/usb/cdns3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
