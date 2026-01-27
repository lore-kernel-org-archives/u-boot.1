Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F7CD2FEE7
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 22:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB85841B9;
	Tue, 27 Jan 2026 23:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sVqPqVfD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JUDZX83M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED695841CF; Tue, 27 Jan 2026 23:02:00 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B4984172
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 23:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f0zs22jhHz9tkC;
 Tue, 27 Jan 2026 23:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769551318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=68UDY1iB11bCOBGTGEscfGbHHg7n/tL8OS5oMXI89yI=;
 b=sVqPqVfDzyg/yx9BM4YQiblRuLEXyV+Wo4Pl/4Fe+3gip9+UFkctqXHq7//v/3LKxU/u84
 Jt/ow321ozERwnRPsQJjEOPHjPBJ2J1Sly2T1Tl3tGm+yjaoftsKnKk9BRp2HFiQik9dW5
 CMdE9cBzH1LkI5QaiC9aQHd9wHuVEHvZNc5DJu0a7gsjIwztPSW5GmqnhK6Qtc4SE6mF8Y
 y+d9qDZje7lKBeNM5QOprxWeLQc/iGzXrzHTtwyU294pknrQAC/K4GybQUjfGKzSvNV7yN
 r8rJMM5JDvLR4plA7FUoiWJZQdFiL4HhBFpx01al5NbDSLMGtz/qpzS7uTfinQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=JUDZX83M;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769551316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=68UDY1iB11bCOBGTGEscfGbHHg7n/tL8OS5oMXI89yI=;
 b=JUDZX83MaDA0r9dD1MpCFDX5R5d5bxXZoq6smi3VXd3ImesOVFTsp5SzSaMBMHkPHx+ahR
 Gtb2v/FibKsEEiBXgg+xjiH9S11X1+yz1uTKQXbaGn5lJdmywNsUUlFqUCTdDMy6GdaM0G
 GFVlD5ie6ZILj0XQ3TFlQAWte7E2tz2vv1zZDBdRzWJJBLxkIllL3WGmY5zZaJrG+/eqw9
 tbrW+kxm32TpePU6MQp1TFHk9ONSVeF1cfBYTcbI1mdpK61fECwnhapjCzRQW7NmGZ3ByH
 ALGUCGfdxkKucZM/xae8lZZoSiZQbSGnjmo0mlNy5k5P+WiHw7Ck15Dlviy13g==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Tue, 27 Jan 2026 23:01:24 +0100
Message-ID: <20260127220140.1370724-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0299d18d0b02ec0961e
X-MBO-RS-META: jfcd5t5gzkox6jo78gj3ktf5g9fxc3xu
X-Rspamd-Queue-Id: 4f0zs22jhHz9tkC
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

The following changes since commit 431f1ce46bbffff0db8f03437a34400b11b30175:

  Revert a number of incorrect commits (2026-01-27 09:29:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to bd07aa1aa6c3c868dcffad0b4c21dfaa89232658:

  scsi: ufs: renesas: Add reusable functions (2026-01-27 21:46:44 +0100)

----------------------------------------------------------------
Yoshihiro Shimoda (5):
      scsi: ufs: renesas: Replace init data by init code
      scsi: ufs: renesas: Add register read to remove save/set/restore
      scsi: ufs: renesas: Remove register control helper function
      scsi: ufs: renesas: Refactor 0x10ad/0x10af PHY settings
      scsi: ufs: renesas: Add reusable functions

 drivers/ufs/ufs-renesas.c | 525 +++++++++++++++++++++-------------------------
 1 file changed, 240 insertions(+), 285 deletions(-)
