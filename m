Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB7606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KLpREPgg;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oASmuS+d
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A88DC406CF;
	Sat, 14 Nov 2026 17:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e071V2Af5qHu; Sat, 14 Nov 2026 17:30:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0CE14069D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794677413;
	b=iNyUbmU0u/Cy3g8rrcsvqRy9U2oOxps9irrc83iD4J5c3am3t2l2QEJ7FigpwMcYtg8E
	 KU/cWgvhO4mtdRIsNw8pMRhllKN05U2j+jSOxcUkMh99ZmEpPbY7J9esAGXQ3wL7kil1+
	 8bofGdTl0ZBArZ3xBYpTTv5KVACN7OKH4778UwMDHTbuaACyDi5BKQV9Jyv864MCACfBa
	 Aue/f/xRCfcBHEZqfdyeSrbamoRpPbI9vIpCW3fC44D9j7Vt8ybVqkyCF6HG16XwicTH7
	 GgvnduQQANnfJVori1syO577EsYSGXBN0Y6U+jhGg9MlzN8V76mFABdq4fO9aRJWWig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794677413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/z6F/Y/2YhJNOuC9nWOlPv5MbxDxJcq1diHLOhO0LVE=;
	b=UsQeHs0SzbtJRGQgvPvEsVHHfg9XQ78ep7hx8P3qWr07yi8uGf3H0kp2ZgoXjXmanBV/
	 i26L/I5IB55Vj1OMqu/dvj5zBJg5hxpTPW6cJgh6XzVdSKTZ6oK0x3V6F8YvCdwo2Wee/
	 WetMv10qTuzGW+bx08PdT9ul/1rZRu8g2tUKtxKmj2HLbYO1tuY2PR0aImOK7lfOf+xMT
	 bJ5ZfDgpJBK5Bf9x1/zaXzYAvVDhJXEjvtZuLUH3c9aGuGEHg/u5q/7ecAUz2yf/hjSHZ
	 31yU8ikNHg5x/jbnJ4zvo1liCCa0BguFnYUNO/7aoQWLH265R/gJctAR9VW1nqVJPJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794677412;
	bh=/z6F/Y/2YhJNOuC9nWOlPv5MbxDxJcq1diHLOhO0LVE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KLpREPgg5DlvK+L+F8XuMVm/OXdg2kWc/GfnYq0hebBAAExHWgg34eMsynHDHAt4i
	 eu9zq5p0VUPz1KMLQ+YP5lt1zTd+UAs2h4lWEaA1PjrW6HYQ7bEMfEHFIxTUQvTsWk
	 ytimBl5UXBHVOlElj51zEi4lYCr0Xksk9U44G5gjDSGQ7KvSIjkTy/GmhfqFvDSDiC
	 v8lSoNSkA0axNtO+6oYvWfZiRDTo0X1oCfmbfkLhDz1JExiqfh9ukKB51xsf2qY+Xj
	 ler94Q1IrHDw8/u9J2WeUOKj80U1y7vxdDaITO19BcE4gdu1666A7Saei4Pn+L4cnE
	 6K9SH5SGUxERQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0CE14069D;
	Sat, 14 Nov 2026 17:30:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB16C1A6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 17:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B96C3812D8
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 17:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0IbBJm0tDxmh for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 17:30:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6AD681274
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=oASmuS+d
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6AD681274
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 17:30:10 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jRh32116pzKvgs;
 Sat, 14 Nov 2026 18:30:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794677406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/z6F/Y/2YhJNOuC9nWOlPv5MbxDxJcq1diHLOhO0LVE=;
 b=oASmuS+dJu/PGHjijvgIkwqNBxxIOTKePkRrMkSkafIZIq+BiXv6hlm4L1oe69YQI8BzwV
 AqajWQ/Nq+0cgfcxZlOFnXR/L/koJY+0m0GUbqMiCuYctvQBCnCEad7qWyuIb4x+L24Mtd
 s0oO/6IJYm6U9RJmXWPPwonFyurY45zXEUugpDmmIhkwtBFTBv/bEDvxxYD17jP2NplMP+
 pdTNA+ZwNrtycnE1M3s1fnwbELS1pqDCSJVE+25C0Uq8BtdPHTDJ4rgBuW3IHxLCWRIow9
 Ia4ZnQeIsUrxJjkAaFQ4gHkCJyTCjXCTJeN86/01AxY50lKM8RCWNxmjIpxGhA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/main
Date: Sat, 14 Nov 2026 18:29:04 +0100
Message-ID: <20261114172953.732309-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: so6seqwzk365xkbpasb5beujn97byfry
X-MBO-RS-ID: 0e7b64a4aa05222b21a
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reduce R-Car Gen3 size a bit and finally enable LwIP on all R-Car.

The following changes since commit 6487c50b8a40f2668ab98a892b9300ad5c181f38:

  .gitlab-ci.yml: remove Simon's lab from CI (2026-11-13 09:09:28 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to d612c290fdf6f662f033c6670075440bef64686c:

  arm64: dts: renesas: Remove unused IPMMU nodes from R-Car H3/M3-W/M3-W+/M3-N (2026-11-14 14:27:07 +0100)

----------------------------------------------------------------
Marek Vasut (5):
      arm: renesas: Switch all R-Car systems to LWIP based network stack
      arm64: renesas: Switch to GZIP compressed DTs on Renesas R-Car Gen3 Salvator-X(S)
      arm64: dts: renesas: Sort I2C4 node in R-Car M3-W/M3-W+/M3-N U-Boot extra DT
      arm64: dts: renesas: Use soc phandle in R-Car M3-W/M3-W+/M3-N U-Boot extra DT
      arm64: dts: renesas: Remove unused IPMMU nodes from R-Car H3/M3-W/M3-W+/M3-N

 arch/arm/dts/r8a77951-u-boot.dtsi  | 61 ++++++++++++++++++++++++++++
 arch/arm/dts/r8a77960-u-boot.dtsi  | 81 ++++++++++++++++++++++++++++++--------
 arch/arm/dts/r8a77965-u-boot.dtsi  | 80 ++++++++++++++++++++++++++++++-------
 configs/rcar3_salvator-x_defconfig |  3 +-
 configs/renesas_rcar.config        |  1 +
 5 files changed, 195 insertions(+), 31 deletions(-)
