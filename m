Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4979606A335
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x/b4WC2h;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abzW/8EN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF1128168A;
	Fri, 20 Nov 2026 13:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24wZWZ5D0vTc; Fri, 20 Nov 2026 13:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFEFB81681
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180879;
	b=C8m7lXDcTf52TjbATKWCr2lRajjWVQtvSaDcnDaDdl7JIOicBXT5jbpoQ3ai/r+XCDWa
	 /HP96f0hYd+OvP5217ETcNnT22uClhA53oZREHBpiUmByGkLGpF9AsT8GLov05Ib7bwiv
	 a7dFUK5DTSbIgfctixi1Zlf+5NuH4yIob77YOoQpQLvvUZgjK3A+7z+HEZwquegtryqQg
	 GH+Zvk7/onn2sbRw+j3Rm7cCgOA5slfRJVp6Z9CcNV5O/zveaY5ddAbLStuEhrB+opBJe
	 bTouFFaXNKS9flFlPgPhAsDP1hq4AnQOGpBrHzWFGHaN+WITscwvTCi+HHYgo4fYVhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Change-ID:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jNcTHi7jhlQexFcCvLheGz1s5Yi5Br9x9FLJtEa9L80=;
	b=X81REDZGUltCSB2fAhE9rESax6r5g8FiEW4e9dZYt4nUYaOca9Wmunb+0CAFZIwh2WPP
	 K9nmvEKz6pqvkT0E/i6Quo128XuogXeNMBN1ewpGXtZfDBZ7hdhRU9fg9a0DNOWYrA8vC
	 BSceX0OFIqVZQz0zoCS7M7wsBpCRJf9Anj9TUNm9kvPaEgMDm/Hbh8uwp1doxIbT+yYpX
	 fuvFYOUibo9OPzuhVFN1CC1EX4bRjVpZRPFZjZBj7ZTWB0Vd9NDaskBYP2t3sRd7PrX6m
	 L14JAke5FUKPlgc4fA4kDZ4pZrCdTY3iIODcOhuhM4m+F749fV+mTxKZay8it4Bip0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180879;
	bh=jNcTHi7jhlQexFcCvLheGz1s5Yi5Br9x9FLJtEa9L80=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=x/b4WC2hcq1t0xcoW1l12bnTEeGbUNwRvToP5YTJklMzRnKwlsyYw2O4jrLrhOFDS
	 P08o7Lx3a+A6pio/fj7H8iEXkwcyaMCOzbbnnNc++3kCEbQNIALX8Mi+d50niCQnaL
	 Jg8lRiBOBNQpXosqJ5lmt+k0HUrYonyDGy1J4hKkhMuZwTyxg3clZ0/dutG415B8ZR
	 Gxq//AZNG0UJr36fQ7cXvtv7hNlqUD5lIFqd45FAn62pt2G4qdcpwo6KxxMbTlmHr1
	 zXXcH/ED0F2s/H0tds7oFRR5Y624CDMWqfd6VzLiDBiBvgJcY/I0gTMSNaWMCRmCqS
	 2WsPwlXhPapPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFEFB81681;
	Fri, 20 Nov 2026 13:21:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DA4A169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FD81401FD
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:37:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tm-10DbY64tC for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 06:37:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3A428400D6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=abzW/8EN
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A428400D6
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:37:16 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cdb9f760337so954227a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795156636; x=1795761436;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jNcTHi7jhlQexFcCvLheGz1s5Yi5Br9x9FLJtEa9L80=;
 b=abzW/8ENgiKmVBF/QYBczXnq8gK/H/KZRJ1iTK/cw4R/fg472ASokPUTi1luVRUBpx
 +vYoDrkSydKoFMI0nRAiH3Qz5IIyUCZ9c9IbVb3sG3U07Y/eO30W01835S7z/QGLRxYR
 9lWyZ74iWQL16+eCUGLn6cLXIbO7XjcpKogDXkGGgc0ZDKbPe0ImkJns0tqjZ1KlS2U+
 aUx7ZQzjv9dphRgP7X8GGuLwnQr/XNkjWzPOKoQXlhj+DuOx0e53W4MUyDWb8GdLg7D5
 cinqHSlWH2e481MQqGKYHnRUpFbJl4H+VJJJZ90Nenv6YR6hZIEf2gewn4epl/olW0R6
 Za/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795156636; x=1795761436;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jNcTHi7jhlQexFcCvLheGz1s5Yi5Br9x9FLJtEa9L80=;
 b=E1Xh8a28BCUr4+Ga5RgGgAZEU4CB9MWvBybMlfSF/pR6WEU3DzpAfe5VKMPiHRuVeY
 Gt9NfjPbtGMZzWaRdRSPMpP3JtSumjynvEb0Gwk9aKtgfJ16o7rXCERFnQ3SQSKhyZtj
 z43p4fBm6Tr9/8x4pavhRcP13UN4W/n3ots7mAX3mAt8pBiitX4vbpZokddT3nYe1iOr
 aq8dzx/o6pAje7pmNHJKjSelw5dbXpxayc+SjvGPfhFCcQWHkw4R6hUleM9asSF2fWyE
 TmWYHiHZugrKCfid6HAwYBmu/GRLx50p9y1K4E997v7CH0uGivDLABSEVMJsvM4TdZqg
 X1Xw==
X-Gm-Message-State: APuU4Z+5+mLF1Tgn1R5aG3MSWRehhEX1DC9md2hQWd6v/yBX/7I91epa
 PGiSx3piYoZWRiq7bUOckcTeQ/RAhaP1f4fycg+yqc+1cdeB4uHukJ40WW6unMjCuIE=
X-Gm-Gg: AZFdTZdjdLTerKqFannUx8y/f4poxE1/9rzUlkoC7ZMD2F1fubY7CE8VTVZJzQh4FMG
 ZpoqFiY/urn5WGI8A309Mx+IT8zAavZbluPmKpto1X7MRh0yGnmvf+ULaKTPLLajOcpkLnld816
 gj6suqTvmC+uVmObTv6zomJRFk6GNJlJmWMwUYi7sR/DNOpFLmiECwuLyUUwQmbPYIOOblywC5R
 6z3Gka2JX4iXfpaa6SrOlMJE/0VCYHZIpCu3M5C157xJu6TUuVHKUijtw22ZYWn1G4TI8nbPEtF
 QZvXeLNlCyeMgJzFbP3jIR8ND8qYmlkR2n3E6lgwyUe8WgP/QEDUhBAgU3vr4/ddBjnNKpx4R0f
 MeeJjWMnXyX9EisqdDHdiegNLjGvn645/nHKiL2U5x9qJgIv8znGFz++31svp2SHhfdmL1ccNIg
 DM21e9a6rvzPqklCbsvNS29LfcnstgyAxGAfiST6MNj1tlt2rTfR5bEJfDky5OFeyS0u6aga3ql
 ybZKNo+3OiwDl8BIVdR7yTzPc0oVp9AS1V9EaxqvJy6TIJFCLzICrvyAP5/FlhMzdkEqx6NQU6A
 /qrUiTy6VWuUUUO4kM2HU3vOB+7x9lpr5uMPwkV+Tisu
X-Received: by 2002:a17:90a:e70c:b0:3a0:d7f2:5a58 with SMTP id
 98e67ed59e1d1-3b41c7bc5a5mr1432976a91.3.1795156636116; 
 Thu, 19 Nov 2026 22:37:16 -0800 (PST)
Received: from morise.tail.syca.top ([20.89.104.82])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41adcfe16sm2894325a91.17.2026.11.19.22.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:37:15 -0800 (PST)
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: u-boot@lists.u-boot-project.org,
	u-boot-spacemit@groups.io
Cc: Zixian Zeng <sycamoremoon376@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, E Shattow <e@freeshell.de>,
 Dave Klotz <DaveWK225@protonmail.com>
Subject: [PATCH v3 0/2] net: add SpacemiT K1 EMAC support
Date: Fri, 20 Nov 2026 14:35:55 +0800
Message-ID: <20261120-b4-k1-emac-v3-0-120679f97b45@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260926-b4-k1-emac-fa5f2b146f38
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795156534; l=2080;
 i=sycamoremoon376@gmail.com; s=20260926; h=from:subject:message-id;
 bh=ouLFxgjp6FQMcPWwr8kgCLfNh3XrWPkIGRxaWNe1s2k=;
 b=TJY8wZfU4RwCVuXgcpLknac/rXo5oATUjHR6MZBHtvhqNdQQdbMXnhNJID1qixdb5d00N8OZE
 bGfP4sN0EnpAJ4p95dSdobCpKjE67uzqGt+d2OBdCwDJ52S/PPR2n/D
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=xO+BwE3DuX3uCUVEo06fonjJtjMp0vUdCPuPP450qO4=
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the Ethernet MACs integrated in
the SpacemiT K1 SoC, which includes adding a k1_emac driver with
MDIO and PHYLIB support for RGMII and RMII operation, enabling it
in the k1 defconfig.

The k1_emac driver in series draws upon Vivian Wang's work [1]. To make it
simple and working, driver which using small ring-buffers operates primarily
on polling and only implements basic functions.

Tested on both Banana Pi F3 Ethernet ports with RTL8211F PHYs
at 1000 Mbps full duplex, and tested command: dhcp, ping, tftp, etc.

[1]: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v3:
- Add the "spacemit" keyword in both patch subjects.
- Patch 1: Remove PHY_GIGE dependency of SPACEMIT_K1_EMAC (suggested by
  Yixun Lan).
- Patch 1: Add Tested-by from Yixun Lan.
- Patch 2: Enable CONFIG_PHY_GIGE explicitly.
- Link to v2: https://patch.msgid.link/cc2ffcb6-167d-4e61-bd46-d16ff0319917@gmail.com

Changes in v2:
- Patch 1: Validate the full DMA range, not only the start address, in
  k1_emac_dma32() (suggested by Dave Klotz)
- Patch 1: Add Tested-by from Dave Klotz
- Drop the MAINTAINERS patch, as the top-level "RISC-V SPACEMIT" entry
  already covers the driver via its N:/K: patterns (suggested by Yixun Lan)
- Link to v1: https://patch.msgid.link/20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com

---
Zixian Zeng (2):
      net: spacemit: k1: add Ethernet MAC driver
      configs: spacemit: k1: enable Ethernet support

 configs/spacemit_k1_defconfig  |   7 +
 drivers/net/Kconfig            |   1 +
 drivers/net/Makefile           |   1 +
 drivers/net/spacemit/Kconfig   |  14 +
 drivers/net/spacemit/Makefile  |   3 +
 drivers/net/spacemit/k1_emac.c | 957 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 983 insertions(+)
---
base-commit: ffdf122644c936510b74a26390b694ed4cdfa1c6
change-id: 20260926-b4-k1-emac-fa5f2b146f38

Best regards,
--  
Zixian Zeng <sycamoremoon376@gmail.com>

