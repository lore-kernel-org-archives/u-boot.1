Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275C9C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 11:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF11C8082C;
	Tue, 25 Aug 2026 11:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QO9SIA6hLRUI; Tue, 25 Aug 2026 11:21:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787656875;
	bh=LCydSFOpHJWt6OX+f2WVywZw2S7L0kZGU2/6B5AABrc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BNqMsXG5MqckJx/SHg2CIwOQkxuk4LixjNQIWMKkw84z62keI5h7VdAa1EZaoffGJ
	 FZqv3uvwYV0S4wOSugIlz+58sbVZbWBzipdfY3g/mcODlyhOATabsTd35srBxa2OWS
	 zUbDHbQgryEYYyUnVL65ydimlq1o6wogCahvgwfh77pmR1k7nfY8yvux+IlUPkzL8I
	 CLE9YCCCzNArT1Jb1BGo3JYytyuO9yGkO5RB2hTWKgOTl3VayX2LV/iGubQKcdf8Wv
	 l+pV9hEMNS1PktEKvcty2mZ3yLf0zpYRDYLHq3o2TnUzArvXOQKcLszWZYbunYAtVE
	 aUS3Eqc3n/hVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C862F8082F;
	Tue, 25 Aug 2026 11:21:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6BBC1EB4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9B5740074
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:21:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6oY7iFkI4Fhi for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 11:21:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Kq4nManb
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 937DD4005B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:21:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E91B911C27E; Tue, 25 Aug 2026 13:21:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787656867;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=LCydSFOpHJWt6OX+f2WVywZw2S7L0kZGU2/6B5AABrc=;
 b=Kq4nManb1PrEy1zd66Jg4IuWoET+vZrItLdYLQBSkyZ+em1CX7iVhoUNPOaa6/uRVNIkQn
 ZZMyfz2I8K78TWQsmGIGQBpHAFtmZ84sqJBNpGlb7zDa62QzzUc0w1pxfNFjvt40Hb4Q3X
 w9BaRZNeB0Oc/BqBLG7+a84USvR3e6ZnTyaDeJB/DhImsnjK00vrkSUJiVtQoJl7D/lyMs
 39LwECoRLYnTAGl8wNsnDQP+xqfviq74eTbVH3A1JRWw/2BiHEUZ35aeFa1Ssji6e5+niY
 IQFMTXAvD+5Nvydv8+mWahZA80VlnVmgFYn0Zbb98lt99eFuoTkDlkeRk+HhBQ==
From: Heiko Schocher <hs@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Please pull u-boot-i2c
Date: Tue, 25 Aug 2026 13:21:01 +0200
Message-ID: <20260825112101.4107921-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

please pull from

The following changes since commit 2d379a529c257606946831a6dac1c37de6a3f8c0:

  pinctrl: airoha: sync with linux-7.3 driver (2026-08-22 15:58:30 -0600)

are available in the Git repository at:

  git@git.u-boot-project.org:u-boot/custodians/hs/u-boot-i2c.git tags/i2c-updates-for-2026.10-next

for you to fetch changes up to 35c2947b5b217962e8d88e2a0b7f507a037a0676:

  clk: spacemit: k1: remove bus gate from TWSI functional clocks (2026-08-25 08:22:24 +0200)

----------------------------------------------------------------
i2c updates for 2026.10-next

- i2c/clk: spacemit: k1: fix I2C bus configuration and clock handling
  from Junhui

  Reviewed by Yao Zi and myself.

----------------------------------------------------------------
Junhui Liu (4):
      i2c: k1: fix wrong bus speed setting
      clk: spacemit: k1: add TWSI bus clocks to SPL
      i2c: k1: enable both functional and bus clocks
      clk: spacemit: k1: remove bus gate from TWSI functional clocks

 drivers/clk/spacemit/clk-k1.c | 41 +++++++++++++++++++++++++++++++++--------
 drivers/i2c/k1_i2c.c          | 27 ++++++++++++++++++---------
 2 files changed, 51 insertions(+), 17 deletions(-)


Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=211&view=results

Thanks!

bye,
Heiko
--
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
