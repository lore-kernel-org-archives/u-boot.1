Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677A606A331
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E/jWgyQC;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=PzDvTUEz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82EC08110A;
	Sat,  7 Nov 2026 10:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmRtw5TBdht0; Sat,  7 Nov 2026 10:05:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC299810AA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794045927;
	b=TcX85t9qOm/7SBJj5UdEYaI7R//52DjQyeujfvpA9pfDDkeKSp1pUuASCQ9Mv6WYCuTc
	 eY0w0E24C/1ykAH7vhh58mD9GKU0MXF8O61yusvg9+lSFV6fqxnc8hCMCaCUm02qauPT4
	 PViJdNEOUZoqN6hy//6vqDzqDfvu2gbda/wn6dixkmeyodPCuZZazROq6fRwPD4rgSf5/
	 YFmGBER5Cxlelx4iRvTepfjEpsn6CW7DE6HuRL5obZzrrgUhSIUI237CRMMTuum3nk+nN
	 UuHyhLGeZv8a9NEMqVgJIFlOydP29Rv1cou7Do3kiAWIqjTcr1EHHVLaWQjQRJvBXBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794045927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YuOxO+KKrF0mCBH8GajTxFLh0dsjGF68rhDwOLjMXoM=;
	b=RzXAlTLg8xrtvDi7v4apqdu+rHhARk9GNayBn6hqBl3hL80PrQSvh9Nuy1B2jKJ03C3M
	 3uXjAHeF2nzYtGZB2qK3IcJ4xj/VN/6GU1PyZ1DfLHyZVcwj3cZrnFQeLXZ0p9Ee+Aq0z
	 2Hi9PToirHO5ldNGcGrfZKe9tgtnQBxRSjH7MfIRo36X+vCb0MWWWHOoDJ02NmMDi59wq
	 S1I1MDqgVippIph4vImwVqsSJbEvrCM3zLFsP1KIn3UuuPzoYj6cVdUN3VFGGaS57IWJ+
	 Bg/7dRxxgnTRZqjaAeCgqzecGnDfRWffhwuXOb/QnjIN+++nmCCDhG39EUKFtT14mzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794045927;
	bh=YuOxO+KKrF0mCBH8GajTxFLh0dsjGF68rhDwOLjMXoM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E/jWgyQCXjyQBjENOubNwt4WkfKIfLXH5pz978h9kBGlHLsftImzu6OHXVDJPVmOY
	 Z1sMAZY95bApMm1S8tqlmQ7591CMNyyJMGVxwBQ7jbwWqYdXEwamVKxXOz9w3QRaxx
	 v89jywK+eEsdEaalc8iG0l2TWSFDApa9roBf9EvfbnWHniyGv1HiOPhqBDuna1iY8e
	 9pPnU306Wg62Z/myCDh3IGDaz2UlnHmU6udMq1Yh/z/3mCdHzFI+078XaEs9LYx2Bb
	 u1fdKC7elqsYLsV0K7GButSbmoYSW6qDuSqieJQoc38lilT1mhrLXvHk62BAIdDX+D
	 WrRkntq4QuTqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC299810AA;
	Sat,  7 Nov 2026 10:05:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 564862E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BB4740704
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vxm0eH6rbmQy for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 10:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 64E27406F0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PzDvTUEz
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64E27406F0
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:05:24 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jMBW52LmFzMlNx;
 Sat, 07 Nov 2026 11:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794045921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YuOxO+KKrF0mCBH8GajTxFLh0dsjGF68rhDwOLjMXoM=;
 b=PzDvTUEziQKnwenauZdhui1fBDI1hYMGa4hkntn8ZEHbN+WSVGnQFEpTlRMi25mwJAwSNY
 UUmU9HXExLWQDPAlNmqaXD5tBPOf7fm0lrMBeG6hkpNvS7AyQXPCCwllPSGHzlU5NFNAnk
 kVhyYOnSOuZ1T0D3SJrNQn/H3HBtNhmaDmECjQkVDFeyqD908deJPkhStFkFbjqfD0myjD
 DDwCq6cewWqxnPJD64Fqj9ESDpYPjsurDY6lTSIEFbUQri5z4BCS5JhqEVuH3LNj8JHoAx
 v08oq4fqXkXxmJejyEwPhL9VhR1uYLgUmGnoMcHh9mO8/9PgaqlGMW7/OIQc9Q==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Please pull u-boot-marvell/main
Date: Sat,  7 Nov 2026 11:05:19 +0100
Message-ID: <20261107100520.2092641-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: du5minpkkmjq3pdasd64cn4k54mtwrky
X-MBO-RS-ID: 3d18526914b868e3e26
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

please pull the following marvell changes for the main branch:

- ata: ahci_generic: pass the AHCI device to board_ahci_enable() (Igor)
- arm: mvebu: set up the AHCI controller that is being probed (Igor)

CI (GitLab world build) is passing:
https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell/-/pipelines/1871

Thanks,
Stefan

The following changes since commit 709a97a05df66e394f40d249105d0baade46f107:

  Merge tag 'efi-2027-01-rc2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-11-05 07:58:42 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git tags/u-boot-marvell-20261107

for you to fetch changes up to 4dc4ce9042124e277ef6c6fdbc47b021673902d3:

  arm: mvebu: set up the AHCI controller that is being probed (2026-11-06 16:36:38 +0100)

----------------------------------------------------------------
u-boot-marvell changes 2026-11-07

----------------------------------------------------------------
Igor Velkov (2):
      ata: ahci_generic: pass the AHCI device to board_ahci_enable()
      arm: mvebu: set up the AHCI controller that is being probed

 arch/arm/mach-mvebu/cpu.c               |  9 ++++++---
 arch/arm/mach-mvebu/include/mach/soc.h  |  1 -
 arch/mips/mach-octeon/cpu.c             |  3 ++-
 board/Marvell/mvebu_armada-37xx/board.c |  3 ++-
 drivers/ata/ahci_generic.c              |  4 ++--
 include/ahci.h                          | 10 ++++++++++
 6 files changed, 22 insertions(+), 8 deletions(-)
