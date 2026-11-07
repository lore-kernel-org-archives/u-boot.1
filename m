Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A97606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i81lvsgT;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Rx4MoNQQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC697606BA;
	Sat,  7 Nov 2026 08:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQBRliEs9tgK; Sat,  7 Nov 2026 08:56:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD81560681
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794041796;
	b=G4jEACqhvWKLcM9Q51ajq+MRjCimPsxef0sXuZcGH0/YLnymt9jjT3ASCR7SNXax0FvF
	 BmwjrKg+OG9TCdvY1vaZ/PmsiBGVlv88rFejiQ9/oh/LTAeKwefhjbtx4VTDIMR4PAFGT
	 KYvS3yrAkhhkykABgjLckX0HH8GuQ1KvJB9s/6ro+Sk2ujtfcPbmM8MmedJ4pyKPG1j2t
	 A1uMBF1BSlLsSqRzjcfOSKHislO3T2Rop/OFuSNVxIHlSl3omSU62/1e7HfLiYyDNAK7D
	 G4TyxhSw+a589qKADiQHHcPuDuJz7qTgkYYW22Jx++gWjWTOv3hgRCcwXbaUqJcM/jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794041796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YRm46SCmIT4rHcDwqPoDLBYgDr9/La0puXGxrWWV9iY=;
	b=f/W6cPX4rBrjTflzntMhmJvSOaBVDUyZsIEi1E7wmleVlRlr1a2S+AAgec9n8r8tGyRg
	 o3I5FEOKh8DWjzogXYdvwy9a11gFRfSqTjFHiAfCeczwe1sQ0qIe4FFtl+dYwh75GUEB/
	 Sa/ToWaZXbN58u/8gbAl6/5tn52rLTJTz7b29lEDdvsvufW1QgMytiS9HpMvuiq1FyJNo
	 N4fN8GOTne4PltSK29XCwEedA3EKEMEdk9mSeWW0rjHAxnXPwPWsiPFIKPMgrhVJ96UfN
	 eEaqvlP4pED2PZiEkKwKobdYZXj817KtGD24oR4fpa8/slTXJ+eEyr4H4c7p/YW7sVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Rx4MoNQQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794041796;
	bh=YRm46SCmIT4rHcDwqPoDLBYgDr9/La0puXGxrWWV9iY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i81lvsgT/p3/GZ7q9IDqF9jfzIPukYSizovALOEyDiZyu6RzPfsNjLWsBFs1rsi+T
	 mS/PayBxEIiQVUy+kcFOKN7wwjGoRNLKw3tNr6T9/a0CWoQXxAM7fuEzp0quMQG+Tq
	 GxsHw4uuvROjL9f32A7d2cGAO2nbKjMCtmVSNL07QoNrq+JW9YajObi6zFRc/eJJky
	 ZjDXptqSfHseAMMRVlhe2Erhbb9WEhGrMWsp5s2VVqxTb2trd6ekqySG5O300yacDb
	 B7MVbqQ9McClDDSrCMMpaCVdkq/zxpKgzdrfEoomo74jbOFaQJBrdTk5v+e5kjuBD6
	 fFUxfGZRVkCqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD81560681;
	Sat,  7 Nov 2026 08:56:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 066F131F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBFF36069C
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:56:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dWABa8thaBy for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 08:56:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 918B16061F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Rx4MoNQQ
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 918B16061F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:56:31 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jM8zb5MTDz8v8x;
 Sat, 07 Nov 2026 09:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794041787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YRm46SCmIT4rHcDwqPoDLBYgDr9/La0puXGxrWWV9iY=;
 b=Rx4MoNQQqAyRJDgT/8jzqRIFGqdx+Na8D3hQJO65394SpV8B/R9hWTYKLEHOFP8uO1copF
 Q4hGYFMbohlKj3fXAcMqkJIWoJgifj1lcZPub5/eyEbqJeaoekPJdBIuDo6CUqC9HpiS7H
 DHqGgbWzaFBUe2UIsdOu8qtRB26Ke7RuEKZernSDwv+2kWKskw9YS/ob1laihZIQi3gNgq
 YeZUxQtOmbnd4Z+aOmryNR1Fzi0DYX9U3yIETsg9FiMdUJYDUCV9/NUhKDwWEjtuXyRWYa
 U7S59OXh+euWEmhPf9RQT0doUoVUJ2im5fekKoklZov3z5iof8Xf5cGGGhswuQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Please pull u-boot-watchdog/main
Date: Sat,  7 Nov 2026 09:56:24 +0100
Message-ID: <20261107085626.2007788-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ftwg9u7fjdcdg9z9xoc6cqa9zcgstk9o
X-MBO-RS-ID: e5ab43eeda391ca955f
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

Hi Tom,

please pull the following watchdog changes for the main branch:

- watchdog: wdt-uclass: add get_timeout operation and helper (Juuso)
- watchdog: warn if timeout not longer than servicing interval (Juuso)
- cmd: wdt: store the device sequence number instead of a pointer (Juuso)
- cmd: wdt: add gettimeout command (Juuso)
- watchdog: designware_wdt: add get_timeout operation (Juuso)
- watchdog: max6370_wdt: use a lookup table for timeout selection (Juuso)
- watchdog: max6370_wdt: add get_timeout operation (Juuso)
- watchdog: sandbox_wdt: add get_timeout operation (Juuso)
- test: wdt: add tests for get_timeout support (Juuso)
- watchdog: Add support for i6300esb (Jan)
- watchdog: add support to call initr_watchdog multiple times (Jan)
- board: qemu: arm/riscv: Probe watchdogs late (Jan)

CI (GitLab world build) is passing:
https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog/-/pipelines/1870

Thanks,
Stefan

The following changes since commit 709a97a05df66e394f40d249105d0baade46f107:

  Merge tag 'efi-2027-01-rc2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-11-05 07:58:42 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog.git tags/u-boot-watchdog-20261107

for you to fetch changes up to d01cea876ff676a053f0be4e35494f932e8a9c19:

  board: qemu: arm/riscv: Probe watchdogs late (2026-11-06 17:22:00 +0100)

----------------------------------------------------------------
u-boot-watchdog changes 2026-11-07

----------------------------------------------------------------
Jan Kiszka (3):
      watchdog: Add support for i6300esb
      watchdog: add support to call initr_watchdog multiple times
      board: qemu: arm/riscv: Probe watchdogs late

Juuso Rinta (9):
      watchdog: wdt-uclass: add get_timeout operation and helper
      watchdog: warn if timeout not longer than servicing interval
      cmd: wdt: store the device sequence number instead of a pointer
      cmd: wdt: add gettimeout command
      watchdog: designware_wdt: add get_timeout operation
      watchdog: max6370_wdt: use a lookup table for timeout selection
      watchdog: max6370_wdt: add get_timeout operation
      watchdog: sandbox_wdt: add get_timeout operation
      test: wdt: add tests for get_timeout support

 board/emulation/qemu-arm/qemu-arm.c     |   5 ++
 board/emulation/qemu-riscv/qemu-riscv.c |   5 ++
 cmd/wdt.c                               |  66 ++++++++++----
 doc/usage/cmd/wdt.rst                   |  12 ++-
 drivers/watchdog/Kconfig                |   9 ++
 drivers/watchdog/Makefile               |   1 +
 drivers/watchdog/designware_wdt.c       |  23 ++++-
 drivers/watchdog/i6300esb-wdt.c         | 153 ++++++++++++++++++++++++++++++++
 drivers/watchdog/max6370_wdt.c          |  49 +++++++---
 drivers/watchdog/sandbox_wdt.c          |  17 +++-
 drivers/watchdog/wdt-uclass.c           |  31 ++++++-
 include/wdt.h                           |  22 +++++
 test/cmd/Makefile                       |   3 +
 test/cmd/wdt.c                          |  60 +++++++++++++
 test/dm/wdt.c                           |  72 ++++++++++++++-
 15 files changed, 487 insertions(+), 41 deletions(-)
 create mode 100644 drivers/watchdog/i6300esb-wdt.c
 create mode 100644 test/cmd/wdt.c
