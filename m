Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A11C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 701D040763;
	Tue, 22 Sep 2026 14:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOD-X7H2L3qZ; Tue, 22 Sep 2026 14:28:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8128F4071C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790087320;
	b=SM10cqUZ/jT0M/Elee53Y9AnPsT28Efmu6rMpoyPIxmnkYrvSYykv3h4sRHMoNd1/KK0
	 320iN4HAOV+pMBIPYYnKwIDVt7p+dT2dX8NTI9lronmTH2l88uLXyBs0U9KMb7Abbjwl2
	 YC/YA/m/ZRmNtWKwZwgqwiQ6MfkfSXhE1y1fgUSU9vSeLtFc8KxxVb0s85qYsXY709eWn
	 oGp4An+ZNXFHpjYClS5GL+IWgkrfHcih+5+F0uZp3MJ0AfWB975i+x6dQSwVoYIrP8LQI
	 fsNq8wI9mTxd7zbz7vHFZdOsmR9uqmDVOue87K1Ns+1jWQu+Fypv0QV7vHY1Mrv9h6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790087320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wA0JicLaTmu7WHDeXeK81gaedoPyAakwLevnok/okwc=;
	b=NyGwOgda8suqzLcELvep59OIGylP894nzJ+Dky8iiA0GaX3eDp3KYYZG4/Yh7LOwOLA+
	 xLDb1oM14ZHejcgsgzD4NnjXNhrsKEwy7IEQtuQa7HXm6lltGOgnUDYadv/oQ0KtCRG4D
	 fam2Ptr5Vu3GfJNfYtgWc7jPOAgvLRezvDFZPoQg6xQTfyvYRhU7+8913Ra2BeQsU0lbu
	 nSXXU44XQmlUEu5j5ZfoPWjQOujAakUpHvwP2FNSVJt/gxS+5cp2yREzi9Ab7TEXJzThQ
	 ZwA6yRqSivR9gQmlLpF10Ofzfqd5I6tWaz0UKRTE/iQ7/ldpCFCKUjejOW2FvnC5oLg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790087320;
	bh=wA0JicLaTmu7WHDeXeK81gaedoPyAakwLevnok/okwc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P/7a/dbVh01H1ZZ48qYA29omxupv3+LL5IqC35MCCpw+bpNFJh1Oc8Ne5rJh1Z4OC
	 ve+vJRcR1qxvwnZxz/CZHzSNgZULYvJG/VwOmCtw1/StmHuPY6CRaenVIiZtEp0jdl
	 HUAIBNJChhtSVr5C7u757r7WOXB5OUas9U0oAGklvDHGz36dmW1qfFGIsUAybDbMfG
	 oWfFH3oxEnutU6q6uT+mO5O2sMc1om8Z1BxL+SvI2FBTzg5Ehwk7jEXhqrlVgu34LX
	 HI1IJBTTxu+++r65jMahQCtdAqa50wVgOR0qQY6zxircmameJgr4TCTJgzrSkN/2PD
	 WH31cRAPUN6ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8128F4071C;
	Tue, 22 Sep 2026 14:28:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BEE429D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A14C9400B0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p_cpuJHUr8xL for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:16:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8CF534009E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790086611;
 b=azv+gj/5Uyz8aa2pyKQ76+9+wuL9Kb0IYYP214QLocTA1n0SrpPI4ajS/DL6tRQmA5v4
 9BDy2j4cngGEAfjWtTIGJn3fPBfGxvcYEEf7tNylCeNNSvTIiA2B7Jox5RQE961e0WMEX
 LCNrCXp04DqMM0/nDTbgUQe1c2n82u9Kwf6XXyli8YMZXUcfvW6QyKcUfmioAygStsq/q
 Cjv029pLbvIt0X0ennsjJV1QGppz4EQY2C5mgPM1tWslg/Oulcsc2rMqdqhvfOml69URR
 DE06RSFzHzMUW/uQhLRiWy8GLDRd3kZOuiqxX2+XwikHiUFcbMyjIOEoR+Gi1/JdpOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790086611;
 h=Received-SPF:DKIM-Signature:Received:X-QQ-mid:Message-ID:
 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=wA0JicLaTmu7WHDeXeK81gaedoPyAakwLevnok/okwc=;
 b=Lgg3LPC1G7yydI5nTWCNXcqa09bGDHWX3UttBpamxK8d/GvyzZb+bRd+VP/w5hcG4gvD
 Qz7bVIZfqDpSJGdAkjloxa1S6spTytOOe+TdbIaLxErBYypNOmYOBJI4pfw+Yn46/8L2k
 JQD0C/RxW3beFBDkWjL7/fyVTzLEs1EIfpUiH88wylZUigPpiq2vtB9FWvRV9lv8TcA4u
 oAthA+01KJm9Qrg3TSh0A7XST7VfD1b/1NyFY7uAlEhMA4y2WPkcIIGqUpj1ZgaIHxlTP
 fEAMSDKUn+O1K0jp+5VSVRzGkEsFNle5dKniRRLBW5Rjgi/wpogMt9e6YHIuhaSmIMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=qq.com; 
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b="mY/pE65f"; 
 arc=none smtp.remote-ip=162.62.57.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=162.62.57.137;
 helo=out162-62-57-137.mail.qq.com; envelope-from=3305708832@qq.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=mY/pE65f
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CF534009E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1790086604; bh=wA0JicLaTmu7WHDeXeK81gaedoPyAakwLevnok/okwc=;
 h=From:To:Cc:Subject:Date;
 b=mY/pE65fjf0plSKP36UeTuRa7mWglZJkkq7EFP11TuNp3nYp4ceKdymR7i+qxZEt4
 QcxDwN62NsFXc+L5pN4xBWtGNbKalH+nkzYTTkX8ppz3vzWeHzAtZaLqfskHvBGD9n
 0wMRVLwX2Yw4gT0wXYIOv4dwVE0BBGBYa8te4s6M=
Received: from kongchen-VMware-Virtual-Platform ([221.238.4.182])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 4298ECDB; Tue, 22 Sep 2026 22:16:41 +0800
X-QQ-mid: xmsmtpt1790086601tavbwdhnm
Message-ID: <tencent_D9A478AE09394DF76B20712DBC454967660A@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznchVJA9wNxv/4TZNH9EnX9nG/N53ac645cfMkBfygQ0ppS8yWvI
 iIw71cMywiNY3RAsjK4a1vRgrPmiqrjvOr0ErDPDNLR2j66eYWGeZgYJz05/pPdzUXnavKSwYV4p
 fmF+M/M/Gt/MYTw0VFRjIH8F2Ycto7uq7V+C7/1It+icVCXbe3/7K38hz+0D8QT+C+fjo5KMdV1Y
 0CWrhuPTA9mFO+kszZAnrDNJWyR3CwE4ZieXyN6SwTnfVkZfbVH/5Fa06Cw/6F42GzkGzwluTzmU
 97T6Qo9H7JpeAzsuUNgwmOynGZUHSTM9I94b90lz11cYpxmYMBzOwUevZfYa51QxqLQjj2oCebrZ
 MmAyeYxMHERlszYqu6IXHupQVxC4x5tqYiPWwJoeHX/dqBFjIxwpt5HajZVT17WA9/XgrAulD2zR
 xgHfhXIebV2VL6nMuPfd5YncqF/WOZsgH315Z2Bg39TFfpGQWHto/FntsTi1k9qOJj9cHPbXVyLd
 i+MwChHHaGKB8hjF5AFpl6YS407qBHuN03oE5e2aLojpIvJwjdChtFjNX7jSzjciWqElWc5FhHkI
 ihxa+kDh79nngghNrYU05mF7cuDB/m0gw2M6P60PIEREEPo8LIlJv7FpwsFvohwt5ThjLlDh09iK
 KBDlVF5ies0gwlzXaURGz1kG2aSn71NOusaClB8YvN9P7IB4+IjbGpN1NnAGbwftsH3AJqiU8WGz
 FjHkhASOzCHliwXJlDiR8Oti2nrtgo8GXVOwUGZOVEuczq1RW7nKwmHsefBtmPkNxfWwMLrNNOAl
 bgvqmFzIk0jtPhOOKnR/YcKAov0p1VTeIvPwZo5yg1Stw03WDIaeWYQrcGBGl87DdT0rxxDEGOzI
 LRVBGhJToJ5/h+tP6A2zlNw4LtWUekujcnOIiglQEUgdarVp2wkLxlUGiwFk+PonDGh7lI7dTl7B
 /F2RzfMbNLWkppEfJRLFYywmSXZn7V3UJiab2P4PV3e86ijM2c1GLyxxNTL14miUdKIkvFnt0TJL
 Uc0LL4MYj832zBU7RhVkwCcVx9PPxyQksAJRqPPi8ZCwqxfmlv
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: kongchen <3305708832@qq.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com,
	trini@konsulko.com,
	quentin.schulz@cherry.de
Subject: [PATCH 0/2] Add Ethernet support for Maxio MAE0621A PHYs on EQOS MACs
Date: Tue, 22 Sep 2026 22:16:39 +0800
X-OQ-MSGID: <20260922141641.8624-1-3305708832@qq.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 14:28:39 +0000
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

I brought up the two GMACs on a Rockchip RK3568 board that uses
Maxio MAE0621A PHYs and ran into a deadlock in eqos_start(): the
driver waits for DMA_MODE.SWR to self-clear, but with these PHYs the
bit never does.  The patches below fix that and add the missing PHY
driver.

Some background, since this PHY is not exactly mainstream.  SWR only
completes once every clock domain of the MAC is running, and in RGMII
the RX clock is not generated by the MAC at all -- the PHY drives RXC
back to the MAC.  Out of reset the MAE0621A still answers MDIO reads,
but it does not start its RGMII interface: no link, no RXC.  The
vendor's out-of-tree Linux driver carries a mandatory init sequence
(a clock-mode register selecting crystal operation, plus about twenty
analog tuning writes); only after that does the interface come up.
So the old code sat waiting for a clock that nothing would ever
start, because the code starting it ran after the wait.  Bumping the
timeout just makes it fail slower.

Patch 1 moves the SWR to after the PHY is connected, configured and
up; us_tic_counter follows it, since it must be written after a
completed reset.  This is the same order Linux stmmac_open() uses
(stmmac_init_phy() before stmmac_hw_setup()).  One caveat: I have no
i.MX8M Plus hardware, so I could not test the GPR[1] latching there
myself.  As far as I can tell the GPR is written at probe time and
phy_connect()/phy_config() never touch the interface mode, so the
reorder should be safe -- please review that part with extra care.

Patch 2 ports the vendor init sequence into a U-Boot PHY driver.
Two quirks of this PHY worth knowing about: it reports link before
its autoneg-complete bit settles (the vendor driver works around the
same thing), and on my board PHY ID1 reads 0xffff where the vendor
kernel sees 0x7b74, so the driver matches on the low 16 ID bits.

Tested on the RK3568 board: ping works on both GMACs with both
patches applied.  Reverting patch 1 brings "EQOS_DMA_MODE_SWR stuck"
right back; with patch 2 reverted the PHY has no driver and autoneg
never completes.  Board support for my board is not part of this
series.

Base: v2026.10-rc4 (211de43d0f9).

checkpatch flags "does MAINTAINERS need updating?" on patch 2, but
drivers/net/ is already covered by the NETWORK entry.

kongchen (2):
  net: dwc_eth_qos: bring PHY up before triggering DMA soft reset
  net: phy: add support for Maxio MAE0621A Ethernet PHYs

 drivers/net/dwc_eth_qos.c |  51 +++++----
 drivers/net/phy/Kconfig   |   8 ++
 drivers/net/phy/Makefile  |   1 +
 drivers/net/phy/maxio.c   | 228 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 267 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/phy/maxio.c

-- 
2.55.0


