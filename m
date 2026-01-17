Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68444C98312
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 07:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D718833C6;
	Sat, 17 Jan 2026 08:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rHRMo20c";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GnRcJ4J6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6169836AC; Sat, 17 Jan 2026 02:24:18 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F072383015
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 02:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dtJsW2nmbz9vDX;
 Sat, 17 Jan 2026 02:24:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768613055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J0Aa8ArZYJVg7MTwNEQDk2stu58cO1rvokjkcINj4UE=;
 b=rHRMo20cpui1AmXU4z24S1r6WWc8jvFeCUjd24XI6j8Zrw198Z4Lhk+FVbPbu6hAwFXLdV
 1U/Luu/QVUiGRgM0WcRGJvJnX6SauBeoCT6S86DxfXI/f2fs9+9A0/n/gx3AJ5LzP5mGg5
 Wpc6H/YWlBUMSg4hAIdMqLVmjQ7lMAJPFWvbOIUsgcos1sF7Exno1PimcfWUH8DHvC3TJW
 ZS6f2KGxX9Ng6YoAm9wMWlDbQF/jhRoJtZGtHbXeAtfsbMagW/MBrcarYeIq0XmwqzhnOj
 V+DUZKu0n/cStj01jLua4+24ejyCR3KIwqnutGUlcedTlNKx0OHcLmAWPmhFhQ==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768613053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J0Aa8ArZYJVg7MTwNEQDk2stu58cO1rvokjkcINj4UE=;
 b=GnRcJ4J6R2hNEX5sOv3JukCxHyald8PUxvFlt8D0pwnjg6OjhF9Br/uC0K9niD+roZvpQ6
 cnxKpRCoxOaa7AAE/RagtrtbOcb1Jz8m0u+zi+qKsk41yVjC5wSaKaO9FfE24x79/XzX93
 HkYBoP2q1VeV14jXFo9Ck1EI5KBbR/nGpzmxE0kshu45p3nJzwBrF8uWmKuf8ijGNCi+c/
 mTyvtU+v51y5E33j9F0q7/D0du4/mreQkHRfe8Y4mVSG9B1GY3wUQ7vQhfDrRsPTi3mITE
 MEJsLJSM/UrFj2LhqcXVn6LLVs9HTaxIGG8/RaGVYDz+SybYWdZkQBPWwCccog==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Janne Grunau <j@jannau.net>
Subject: [PULL] u-boot-usb/master
Date: Sat, 17 Jan 2026 02:23:40 +0100
Message-ID: <20260117012404.187685-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: oimtobh5g3tnhzu4uzx34pek9fs9de4b
X-MBO-RS-ID: e847f65fb190f0b1b5b
X-Mailman-Approved-At: Sat, 17 Jan 2026 08:34:30 +0100
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

The following changes since commit 5665d1f4e7cfd6895417d199dd7db73500c5d36c:

  Merge tag 'net-20260115' of https://source.denx.de/u-boot/custodians/u-boot-net (2026-01-15 08:50:53 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 81e8c5315cee83d2599fbc570cf1933cc80e170f:

  usb: xhci-dwc3: Add "apple,t8103-dwc3" compatible (2026-01-16 15:03:51 +0100)

----------------------------------------------------------------
Janne Grunau (1):
      usb: xhci-dwc3: Add "apple,t8103-dwc3" compatible

 drivers/usb/host/xhci-dwc3.c | 1 +
 1 file changed, 1 insertion(+)
