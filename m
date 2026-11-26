Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F2606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lqp79kXY;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=R+4C2QZ4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 198584087D;
	Thu, 26 Nov 2026 12:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQILm78HcVv7; Thu, 26 Nov 2026 12:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DE9140893
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695881;
	b=a0ALT2GBGj7RAhzi5UCAusS1Zs5cw/190fKF6VSDHffJg6LX/FCiFdQV/z2PMi4t7w29
	 EQ+8W5kdAKY+tpM9Y5bYP9yJ9B7Rd1yPG76n+0EbRLYzFsBoep36gVRTEpEUGYc1hiNpy
	 5aRvNY+5jvvAZuC5RSBwLYFbzkA4M1YlCzKs+GTpOMordG2WNcYfo4mCPQobgXr5JpLlx
	 zAaK+wGui9ayWyM7lSoJhUyWLrxtstOxv72NchzUGS3A0t/PKEqzVC2mRpCObgOShMJ9+
	 MJRiXDhIcbKN3jUt9iNAMBKw+tkOcjJNQFmWaiPomaNRJyUBPBQKc4cE8ovFco1GYag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KCL/unXb5k2ERWHWzjXuCeQsSVzlu8LQ4lRPzbsdstY=;
	b=UPzyHBikPg6LUhkIjZmmi8GuuQhxxFlV+q0On7HkDeM1L2ZlcTetfgxvcXJkkJUGwYUO
	 r2uL6ueUiyPQX2rjRe5ZMmZZxNtBoCq+jJbmKfNda5pFfkPbxDcOp3x8w6p7w6wcdopil
	 /KcglsZYgx1ZrsEYcpYk0HLVr6iDb/TXLH1biNwC53h88Z7ymT9NEq3FXOzqrDfAVJkzO
	 24ppvm7JK1loIqRr0/ksrrEy0Jv+z+6l4EEFFxR/8hRtmqYXY1jbYtrR6Yy3gCeQCm/of
	 dXPN6OBKtrBsO7Yi3rlZs1y1PNmFg7iRVw0SDfddhcgKyOPh1kWQYQL9DwnsaV+kBAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695881;
	bh=KCL/unXb5k2ERWHWzjXuCeQsSVzlu8LQ4lRPzbsdstY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lqp79kXYj+1hYsXDQpylx8XWPbcfE6MY2H5AZz3JP2O47Ah34NhM6yMTOATa7b2Su
	 XCLoWsvrt4EnuUfwnPyl40xKdNGAI1jlDiDSlFRJC0481LIBZYLT38C1miOECmObJM
	 H1sOfkJ+LAX4VUciWbE1SaqYa77z31QsbtSjxA81HCggr0ddScMznkDBI0omf0Hd50
	 SgC1vnqbJn4YFvb04OH9Q68TDQNf2sa+B3HEV5jSZEWGrC8Sdshbzrhf8gHgXsojIW
	 SfZVCdppsIHTv1V3UMfgfjSoHNNQwngBlLDBoNgG4XD6GwGEOowh4L6K2KocwTHsV3
	 wU8WAmALc0zHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DE9140893;
	Thu, 26 Nov 2026 12:24:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CC093E9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F65C81122
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQ5R072ORgiR for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:24:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 389FF81101
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=R+4C2QZ4
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 389FF81101
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=KCL/unXb5k2ERWHWzjXuCeQsSVzlu8LQ4lRPzbsdstY=; b=R+4C2QZ4HFAYUg2XdNlhvT6z49
 emJQOQK5+hawNRlsdbAcziJ11tc20rVawuolAImAHsuF3AdCcHp9dw2t4yCUBUboiKVRcrLJ7o39c
 obVVoANMLec4pf8/nqixngZ2UXITm1r43czGWOrHViM8JJMmSStISQMJ2v2C8wZVJmXdTH1IPc9z9
 jGwtDYNcgNdPliTFaP9PwSm9jf51HmwzDk+trtN1T6YCEy1d9YSiwiT0O/agVQImq0OOUdoyjH/UA
 SkxfqIZQT4nkZ9R7xd2JA7Z4tM2iVO5y//zG+8NmU/6r1EJKF7iY8rB/AYt4C7gZpO/FUmwSphKqd
 8J2hv8rA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWe-000IB2-2L; Thu, 26 Nov 2026 13:24:32 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWd-0003gJ-1m; Thu, 26 Nov 2026 13:24:32 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 0/7] i.MX7D anatop regulator and GPCv2 PD support
Date: Thu, 26 Nov 2026 13:23:52 +0100
Message-ID: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These are the regulator and power domain parts of [1] to prepare for i.MX7D
USB HSIC support, split off into a separate series so it can go through the
appropriate tree.

The anatop and power domain drivers will be enabled in the TQMa7 defconfigs
in a follow-up series when the remaining USB HSIC support patches from [1]
have been reworked.

Changes since v2:

- Drop rename of imx8m-power-domain driver
- Rebase onto current next

Changes since v1:

- Split from USB subsystem changes
- Rebase onto current next

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637395.html

Nora Schiffer (7):
  regulator: anatop: fix probe without vin-supply
  regulator: anatop: add support for anatop-enable-bit
  power: domain: imx8m: update outdated Kconfig help text
  power: domain: imx8m: do not unconditionally select CONFIG_CLK
  power: domain: imx8m: set CPU domain mapping on probe
  power: domain: imx8m: add support for power-supply regulator
  power: domain: imx8m: add support for i.MX7D

 drivers/power/domain/Kconfig               |   8 +-
 drivers/power/domain/imx8m-power-domain.c  | 101 ++++++++++++++++++++-
 drivers/power/regulator/anatop_regulator.c |  42 ++++++++-
 3 files changed, 142 insertions(+), 9 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/
