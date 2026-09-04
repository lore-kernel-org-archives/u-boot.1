Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4BCC61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4965B605AC;
	Fri,  4 Sep 2026 13:02:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5Vb9hJydttq; Fri,  4 Sep 2026 13:02:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 72F5060BEC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788526942;
	b=BCEhrbkLfZqfS5BQihFlJK65qkzZ6yx7uSZ/uvypY/gWTtJsDEb49YGzLTwW4pWHSQVo
	 r2kROK3E9PXMJK9leSMTF4dwN/UoVHFV1O0ACDpcFUmCoKUfpooZdwzwp93QjODeiSgTa
	 T1IOipv07eJE1vxJr/tCFYHkNA8sOxh7HANRjjdx1+cWgl3zWCmZp+PYCThznBQXjb/s3
	 TCIkcA+UT/nWOxVuUUKp6c4OzwcZfhL1V7TjpOllThDRnHpCRWiEXX4XhCoJz1C7fxkk1
	 /h1x1KUxripi9dcNiH6glAydR+oPVYS1BSVTol8Gh1/pbjEZWVx84MoPjVwuLdDonZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788526942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Flowmailer-Platform:
	 Feedback-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OCCRHwJcJ6VpQd+cFd2Mbb0znruol09H0mEvnxzBxk0=;
	b=M/gDxmVEhIl4qcNv/Q2EpR89jn1XU9HmjSAbr8aug6lt2Sp9tC77XQDflGA97UzQxIEe
	 f2USJOZjzCVgRVvoP4Y8+d1D+3ds5zHlTu0aWttKMEs6I4VTo9fvVqn72EbWDTN01SK87
	 wBEIrVUn7YS3oWMcuT2ewpG8OWn1vtQppqTssYi+P6uutY7yqEpIGVe02jtkgNHLefdgv
	 esADnOCXtBC9vx3yTeMc2mcCENIADVxHc898vK9ICd4oWguenJXKGYcS4kWHzXDMISjK4
	 eFNeC9E6L0427LIiGzvDtTnWJnggeKqgWMWPR15AZ7Xh3R67ncCA3R/5W8WU3Y31ojQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788526942;
	bh=OCCRHwJcJ6VpQd+cFd2Mbb0znruol09H0mEvnxzBxk0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=knskyUC0e7b31rUw6iybKFoH+NMtJzfaDJgvACXf2uB6lBDkztfj7uWfLEVRqQJKF
	 NNRuNMo2PsV7nfpjB5n7uZNenYnRHmgZdHv7aGZXz+7Dzzmo37sQWtedvJn74xNPhD
	 FOLtV94PXZ9DczW/IsgcrH3vi7l1gkMb8UhMbws92D0+Lrlw4z8m6NJviZ3CIOLzQf
	 9/3M9Kx4H+2E/G4IR3kJBUVD1Wjx7H+EH9+X7wmCVCpqeXBFxVibpXwbaKpObUiUZe
	 q7MIVO+5MvgtBL6TniKYPNoEHqR/jvUq5OeOTJgPIhhkclRkyjeWG3rW5ojGUZ0Y8/
	 m2W4of8XWutBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72F5060BEC;
	Fri,  4 Sep 2026 13:02:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4330CF14
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2987640BBF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8j0mXrTdjK1o for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:02:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5FA3840BAA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788526939;
 b=cVgd1kOoNVLZRBC8viJg15UGpC5C2/8+AEYZPrxS27Hetoafq1mXSRHci5RzphjsbcpB
 H0N68y5P2lvQMx4TXUt394SZMF5SgXK+AHZo9oZyYGA3i9qx1RAV+VtZ4Zwxmjvl/2aCB
 3fzw6QCvBy/ak8RKMEbSzs4VDmlmtyLQADYIWc/HqqFPPN1gu/RARSwO62yeVd916lnUj
 XhqvMmQYPfMmWSpY0WKFn+n5VqIMG6xx33YbUcVJqLoT0vFG4onKFLp+1UsPogOEiT7nr
 atECAsVNGUAICC1yqgSIe7nBDNbTDbWEJ+IsEfhRrb+gBZHIypuWtk77yFREdXTFeiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788526939;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID;
 bh=OCCRHwJcJ6VpQd+cFd2Mbb0znruol09H0mEvnxzBxk0=;
 b=bK4UEN4S9m5r3HAcn1IV/3rN2+u/iCz44VUrdg3k/zhVhMrCdDis28Tyonf2MONq3nV7
 Fhm0GRdWCyeMkZBwDgApYZCxvYMOHaef2sCgwjsn7bOhyWFn3lmBOoxwubrLXPs3hSfa1
 tmUbZM9jzEyQ4xRByhqAb2ygPfhfy2kpj/SkaEOPI755N0GHemTWLT4pBQBCU9uUNzykA
 vXAzH4dGUV/9sT4Jfg8ICVEcCS3lHHZFa6ScHC1+3Kwjt64JTgCKTAbAMSmF9PfxJEydY
 qL/pqpREs0Ecen4LcUeg5yhmPoq4vkWzZFxSVUiUZ/qTCBBMA+4AQ0jD5LZE7pO/OMA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=F9sTaUjd; 
 arc=none smtp.remote-ip=185.136.64.225
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 04 Sep 2026 13:02:18 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=F9sTaUjd
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-294854-20260904130111361ad35ddb000207e8-htssqn@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FA3840BAA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:18 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20260904130111361ad35ddb000207e8
 for <u-boot@lists.u-boot-project.org>;
 Fri, 04 Sep 2026 15:01:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=OCCRHwJcJ6VpQd+cFd2Mbb0znruol09H0mEvnxzBxk0=;
 b=F9sTaUjdDvGy/NrJiNGyAXWmQo1cFnBfA5IzeYe4EeVWplXlO04ZfzoPnuSaOtxVXXiX1o
 W4rezck9P7fcFoFz86i/N3bP9fIkFJHMKByNY+I2ylIsEehrcGDSo2qeOpPBUL1YY7B1oXyM
 bxafUG+osjcVtZxtkmJCSFeNsVLJ6jt8n3pe4oFJHgy/3+wuILKAu3d+8EmY1vYJ6X3vIXhe
 tbF3rysBEPcXIZQHcI9cvp4xCLDdvF4t8tl3FWSMVkeKVTjhCQq/lUNC8eh2WxFBHW8S2Khm
 v5BBB2XX4yzWYVoa2KRo8J6pesfPNBr+txOZjSwoIjOF5MTYQ0QDeqZA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 0/2] Watchdog support for qemu arm and riscv
Date: Fri,  4 Sep 2026 15:01:02 +0200
Message-ID: <cover.1788526864.git.jan.kiszka@siemens.com>
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

Changes in v2:
 - fix a compilation issue of the driver on riscv
 - add late probing to qemu

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core

Jan Kiszka (2):
  watchdog: Add support for i6300esb
  board: qemu: arm/riscv: Probe watchdogs late

 board/emulation/qemu-arm/qemu-arm.c     |   5 +
 board/emulation/qemu-riscv/qemu-riscv.c |   5 +
 drivers/watchdog/Kconfig                |   9 ++
 drivers/watchdog/Makefile               |   1 +
 drivers/watchdog/i6300esb-wdt.c         | 147 ++++++++++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 drivers/watchdog/i6300esb-wdt.c

-- 
2.47.3

