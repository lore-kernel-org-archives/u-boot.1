Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C0ECAC5B8
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 15:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF71809A5;
	Sun,  5 Oct 2025 17:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KX7VQNSU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SOe06K1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD6C8206E; Sun,  5 Oct 2025 15:00:35 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF52807C0
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 15:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cfjDw29YJz9v6t;
 Sun,  5 Oct 2025 15:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759669232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=it3U39oLOvwDVagCFGxdoXjOT1fDxhhisxMbxeXM/9Y=;
 b=KX7VQNSU6Qpx3Z2YuhrzY4UgIDJRYKHzc9sHZ0PnA14dEH0TSpHMS/1vE1ijNB7D2TDVaS
 ZlChz7o2CF3kwomC67dZEZo/PYueF2Bi8vTuaBqXfEJLQHZ3a84UbE+iFEqvdd1oHbXtJD
 +sh0+MiIkaq6KfeBh/Q7kuobTE7cYK4p1MgQGZZ76n3kNwKRTJy16l2j3GR0ysyebGzTJ0
 BOyAHdJgBDqh9xy50mimgSqqI9AemYLRKM2ImBYpwYRCqLywrwHDXHS+3t27SWg0cY3ZJj
 EgF+IogSNXSN+u/tLjH7fIr22RkKhYVBYn16VyDFxO3QQUkHDDvqQ6mzPDaj4A==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759669230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=it3U39oLOvwDVagCFGxdoXjOT1fDxhhisxMbxeXM/9Y=;
 b=SOe06K1UcoXwouWgFmmtoR5cyKy9SjIecLTfFPrI9/bJ09SYYaN9hArgwNHUPjBB26FS/k
 yGEI6N/oGVnMM+OlQdYgUTcgMrLYw7KuXsTGgQdny612Myye24COh/siB59qRQBQJYKEs3
 UUJ3cc0Xys4JMSl22V99gbUeV/BumdbM7HeI8P/n6XGZmEBzz7LG3VX0qe8c+vhwr7oqch
 EzjkVPDo/6gTZ7q1heN2KJ58h3EFS+6bOb/+h1X3v33bCcasg5t5dcFwz/wCqMv8qY8kT3
 VP3pDWLzkyxd53EEfq/6xTNHa3/LhpTQoAROOAcBlqP16poPqRA0tQdMb3ms+w==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PULL] u-boot-usb/next
Date: Sun,  5 Oct 2025 14:59:51 +0200
Message-ID: <20251005130014.5562-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 17zccuhpadkgrd9xm95framf81ebxz3e
X-MBO-RS-ID: 8134168dbe10b6774a2
X-Mailman-Approved-At: Sun, 05 Oct 2025 17:48:18 +0200
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

The following changes since commit eede1fccec4d0adf1934d9a6f51ae6d3675351e7:

  Merge patch series "Drop ATAGS for B&R boards" (2025-10-03 16:55:44 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git next

for you to fetch changes up to f4dd112a3822c86175d091362f5cce1029f0523b:

  usb: onboard-hub: Make i2c-bus optional (2025-10-05 06:11:44 +0200)

----------------------------------------------------------------
Michal Simek (1):
      usb: onboard-hub: Make i2c-bus optional

 common/usb_onboard_hub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
