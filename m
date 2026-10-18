Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92BFCCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 10:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FC9160659;
	Sun, 18 Oct 2026 10:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FzSeyw91r3g5; Sun, 18 Oct 2026 10:53:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E47D5606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792320829;
	b=YAVYKszoW9geNl60FeNHjpp9fG1yeOZ3V+EHt0R3xJpPdAVSTs4MSoSjA1SunLIdX8Nv
	 0lTu8V/ERBSfxCeqUt7eMxnES0e9Fg2TShD+7gSf77z8UHXfBPtbR1WM8/o0hWBwZ4Iy5
	 E+8krQ07J6511r9w+Y0botnR2fgZ4K/nWth+E7igqUfPUznJ0u8AyHkTLyPJluHeADIP2
	 yrcOmsacLFD/wMpMwCsgyaE1LAppT+FsL/5A/vsMGf7QA4BBVQyBiGH3bysHHhEUlgAPY
	 FhUya6bdgEpng0IIbSOTvJhBnD2wqWc1mXqEjXYm4zYot3hc7vetHHUdWE63Kn1EjUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792320829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Flowmailer-Platform:
	 Feedback-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TFrM+xPDe2GWb1xBoR9xNCok+D2tOrOm+Rg5Zzf2N/c=;
	b=fizHmQqtPu/hAahCh+xfmSKJrHZ+H3ZKB4gV8Vz1JmpRICUbgy0ohfEr3ykh4Jp9cGRn
	 SkvShNYPtVbB95JnqcgwioPFUCkH5AFmA+x0jOJ2//uxXAgwgaz4e/gCy7P1XD803soPB
	 kXQ0fXDt8Nch90vLgpMl88J702T2wUI+CrwEwbY+14fkLtH7Mx0AFS3kAUQF5k3G0mn7+
	 b3QcpogrzaWpbDSGL0olX5n/1hGNaiHiPsjK8bssilelCqdgBbpMb3YcXwMBKOn7szOBb
	 p3egYVqX6dysIwdixt51idHq+32LCZyz9001NPJHWJ27BhWchBqrrFjS5e+seHsjv6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792320829;
	bh=TFrM+xPDe2GWb1xBoR9xNCok+D2tOrOm+Rg5Zzf2N/c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MeqUUQWACgAhiELP5XepUALlMk4TSthlOtnMrily/52522fOjbX52wvw7ftDB71mc
	 4gk1aw2tRpcsbLuL7UW4i/1EqzTcCdpTU4lRZp28qLJEd/Kkvfnfb72sWifkWuTVmd
	 ZInDtAT+zDsNPl3exCMGkb/AAsu2YzJXg2K0WjYSgdpDaGiSUxYT0cjxLIclVZ6Gx4
	 PlMBeRYnxDOsexb+gKQqx5ggyOqATjv3CIScaDjMvcEUDQWyq3K5cEHYBO2JRjjTN6
	 0qJ6Q3i7KepAC2ckwaJVoOSYExhbRuK1s4sQPGWUWIe5LjdmKzm7Ye7ADny4/ARYed
	 54gq9lM6nUVnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E47D5606FD;
	Sun, 18 Oct 2026 10:53:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05FF0255
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E059780B80
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CnvFYrnD6nUQ for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 10:53:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA1F580ADA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792320825;
 b=NrrWebXiRrB36Asm1BnTvQav80QCvW/pp7HzsOqlCMusfiLPbAFvWwjc8Lz7f4q90pCg
 bpxgEUTmDcMUgxX/9072hItik70wwW89G9DQjRYH/wlrJ7Pl3NFTzPsrtmBXBuJs5HVfU
 pWCBn2BDS+Pz2q2rYMvAnJK+KUMIn2V3tUebWMhI/GVKBkE1YTEIxXA2IUJFj5dsBUm9J
 wYHjBMERNIIx4v8TAnN8WoghElQpLcLFK3Op7pBLccGUbRHYT2BURiIzbUDtihT/UPeZM
 18e1Lv8fW7u/r00HrrPPCAX2H/NoBUglaZ0mOShTeo92x5de6Rnsx+ks8uEFQ9xMWbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792320825;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID;
 bh=TFrM+xPDe2GWb1xBoR9xNCok+D2tOrOm+Rg5Zzf2N/c=;
 b=RTI2nmE2T5j+JNx1uIyOpccn80sXw6xw3GrdKMl1xLy1pdDFbWBypYgKfwVJ4gEc0AMg
 Du1Q1ph1b6adSKp2nIPgxSRZbB99qFbKgD/aH7tUO8ipLWxEnreNGWwihw8+HGyhr//+A
 6zsQ3gUXZ2rIGydLxhAxZYHE1bDiuFj2pbQPdPAoNlOOTWagfkjbV1RQzlbQcxvgcVxRV
 ksMVXPhfUTTQTBpEVEZXCDeMgOSW/m0y/puYFoAmMkpgouu9NLyXlNBeKniS9ctaAGVLd
 H5eG8+Rx/HNL7bpi9iwjvbrOAQO1cQRSGWdqrs0zEV2GvNeHqYEM0Uus3Wm/hCwvdSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=KIcasatQ; 
 arc=none smtp.remote-ip=185.136.65.226
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 18 Oct 2026 10:53:44 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=KIcasatQ
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.226;
 helo=mta-65-226.siemens.flowmailer.net;
 envelope-from=fm-294854-202610181052384f9e88ad2600020702-vvpmmf@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA1F580ADA
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:53:44 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202610181052384f9e88ad2600020702
 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 12:52:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=TFrM+xPDe2GWb1xBoR9xNCok+D2tOrOm+Rg5Zzf2N/c=;
 b=KIcasatQk3vj+y3r6lGR6ox6bu+JOKxUH+P+Yekf9yWvgfuelwKya/TjRxEw/eoy6pNpyb
 l2z9qYHTKyCQ0izZCbc5PR+CXXCnH5Vwy8vrN5T8dh9uWEK4f18Pn+eoBCA4/Hu4FoWWvHOO
 er2kt+rAya9CNHgln3N6CcRiGdrlcmxGWGwoRubsn4VwyBFr7Z2OmeXGsD0FnEjK6XHFplyB
 qnv1gP5DC0MEHk8c91DSpJkInVZyBAwaCfnUI2kOqrq0QtpJBo2t34HdDm3tiJmxst620CS0
 3P9Y0+mynmyrFctjQ+LSRP7sEC29EXM8N/g+dMi/r8xdycAu5boa2bUA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH v4 0/3] Watchdog support for qemu arm and riscv
Date: Sun, 18 Oct 2026 12:52:33 +0200
Message-ID: <cover.1792320756.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

On non-x86, QEMU only offers a watchdog via the PCI-attached Intel 6300
ESB. Add a driver for it and make sure it is probed during board init.

Background for adding this feature is testing complex system
integrations that include watchdog-monitored OTA OS updates, e.g. [1].

Changes in v4:
 - use lldiv64
 - style fix

Changes in v3:
 - reload after timer preload setting
 - initialize max_timeout_ms
 - null-check register base
 - code de-duplication *** BLURB HERE *** style fixes
 - prevent reprobing of already activated devices

Changes in v2:
 - fix a compilation issue of the driver on riscv
 - add late probing to qemu

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core

Jan Kiszka (3):
  watchdog: Add support for i6300esb
  watchdog: add support to call initr_watchdog multiple times
  board: qemu: arm/riscv: Probe watchdogs late

 board/emulation/qemu-arm/qemu-arm.c     |   5 +
 board/emulation/qemu-riscv/qemu-riscv.c |   5 +
 drivers/watchdog/Kconfig                |   9 ++
 drivers/watchdog/Makefile               |   1 +
 drivers/watchdog/i6300esb-wdt.c         | 153 ++++++++++++++++++++++++
 drivers/watchdog/wdt-uclass.c           |   7 ++
 6 files changed, 180 insertions(+)
 create mode 100644 drivers/watchdog/i6300esb-wdt.c

-- 
2.47.3

