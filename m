Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19082C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 06:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB42D80F59;
	Fri, 31 Jul 2026 06:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O66AGri1U6KU; Fri, 31 Jul 2026 06:35:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C837A80F41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785479755;
	bh=vUp63iVOKKFs/xFe6WtvxCiCe/wCIs1fR/qAO8KsxTc=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HcCkN3IQuL04LWaMwaSXIuHCfaQ/Ls+EPvqw+AqRZehbNHoUo1HjuKGLS9oHNyb9r
	 vyBDlOggekcM4IC2o7hyFEp7xQOyx9oh9KYtpCgoSSkrOmSobKXasPqUZE5J0apiC+
	 0XD+NmME5Daj5XfDNZrIz4bsAev+5j70gXLyG0u7FAJHbifE2lX6MrGogA0FkMBQ5E
	 Xrm178EMfnf29GxCN3ozgRN/JLr0pp5cXI5jKv+Fi9SQooeLqOpMgE9EDpgSv0lu9G
	 MoCRfAmjZqEGi+ws1ISX4OVlUwJVwmkC3+MkHjMZMTKz3Ly9VD+D/zMRDlWuX2Nuv5
	 Kbt7L3r2iiIUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C837A80F41;
	Fri, 31 Jul 2026 06:35:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A7F669
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6874E40EBE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IL4uRRy_-Dod for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 06:35:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5E82140EB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E82140EB9
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E82140EB9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:53 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hBGY119yWzMl15;
 Fri, 31 Jul 2026 08:35:49 +0200 (CEST)
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Please pull u-boot-marvell/main
Date: Fri, 31 Jul 2026 08:35:44 +0200
Message-ID: <20260731063548.1915557-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f1f990abdf8d6633841
X-MBO-RS-META: ct19mh9hk9qfcyi646daagtaqg9h4nbt
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785479749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vUp63iVOKKFs/xFe6WtvxCiCe/wCIs1fR/qAO8KsxTc=;
 b=S7eBjL75AjfceK9epmb2WD1DV0yHpgzyo7n9kG4jzqi8fAWQFVZiYa84M+pgWZXDAV9E36
 ciLFbtNfUTpsrVF/3YEx9UTlgkuhpzM7QTt62wyMSrsJZNdeEjGp2MTk+X5CRLz07ZxvTF
 Y4aJ7ciUOsY6BtNjaqlRPoH+LsBFiDTwNfCiKym0gMfuYiyOBQoZ7+inqiSIYNBOSAaBoy
 1VL1Apdbac6HwiLlYhVlI7qrus6+ubUarNTRo5oUR6TpFdFrKp+8BxDiY/jlTQZXIfL8R8
 Fkw6Em7qDBCfUzikmF1S4gN9jWZUtuR+4t/Fefkp1on9p37kFmzJ8N5Gn9+vXw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=S7eBjL75
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
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

please pull the following marvell changes for the main branch:

- arm64: a37xx: pinctrl: fix info->dev used but never set (Quentin)
- arm: mach-mvebu: Add more AC3 & PC3 variants (Chris)
- arm: mvebu: Update docs for Allied Telesis x220 (Chris)
- arm: mvebu: Add Allied Telesis x960 board (Chris)

CI (GitLab world build) is passing:
https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell/-/pipelines/834

Thanks,
Stefan

The following changes since commit 100e12ea78c73071b9710f08b32fd4590019266f:

  Merge tag 'mmc-for-2026.10-rc2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc (2026-07-30 08:50:13 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git tags/u-boot-marvell-20260731

for you to fetch changes up to 57f382db43241217886d10755a555ef33e36d732:

  arm: mvebu: Add Allied Telesis x960 board (2026-07-30 22:06:23 +0200)

----------------------------------------------------------------
u-boot-marvell changes 2026-07-31

----------------------------------------------------------------
Chris Packham (3):
      arm: mach-mvebu: Add more AC3 & PC3 variants
      arm: mvebu: Update docs for Allied Telesis x220
      arm: mvebu: Add Allied Telesis x960 board

Quentin Schulz (1):
      arm64: a37xx: pinctrl: fix info->dev used but never set

 arch/arm/dts/Makefile                       |   3 +-
 arch/arm/dts/cn9130-atl-x960-28ysq.dts      | 313 ++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig                 |   8 +
 arch/arm/mach-mvebu/cpu.c                   |  24 +++
 arch/arm/mach-mvebu/include/mach/soc.h      |   6 +
 board/alliedtelesis/x960/MAINTAINERS        |   7 +
 board/alliedtelesis/x960/Makefile           |   6 +
 board/alliedtelesis/x960/x960.c             |  19 ++
 configs/x960_defconfig                      | 104 +++++++++
 doc/board/alliedtelesis/x220.rst            |   6 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |   2 +
 include/configs/x960.h                      |  28 +++
 12 files changed, 523 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/cn9130-atl-x960-28ysq.dts
 create mode 100644 board/alliedtelesis/x960/MAINTAINERS
 create mode 100644 board/alliedtelesis/x960/Makefile
 create mode 100644 board/alliedtelesis/x960/x960.c
 create mode 100644 configs/x960_defconfig
 create mode 100644 include/configs/x960.h
