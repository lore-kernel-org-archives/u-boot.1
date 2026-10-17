Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABB7CCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 14:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 997DF8146B;
	Sat, 17 Oct 2026 14:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TeIl9vZ43PRU; Sat, 17 Oct 2026 14:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD56381423
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792247555;
	b=hD1DVq99Ds3tAmAbevrJCMpl50cSuCm7LAFdYe+I/rOPWZMAWF4lVsHwFolCUuRbTGVK
	 RQhpg87qqnxljSewW/pgxGbQd+MhTBOBK83AHrYxg1kshx2ZP4W3cpMCN3Kh3MSy2hrWf
	 d9awnWqs8+W8fC7z2dTrELeZl4qWjmqadH9Hkwtf2UJ8JLljK0NqknZAI2DmkqcjPyh+V
	 w3edVbqw1ITdgMBn3GzQj+n7zLabZKfuUjhRodmJ5OwNiR+v9t6Rlf/IFYDIGpVzsH2dz
	 MkVq9QvCC8OBwJ7b/xTL26idHQXJ1rAwJVUMWONwTf830hKw5u5mBPmU2LCvSdxfyJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792247555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=48YZCGSXLxb+jr6AWs0MQN2h9L+K+L1qznsw66bN3go=;
	b=IZUewWnQxNWeKm/ErQzt4ITvSOKWONYqA09KvkKpnPQYZgZZ0D3URNXrsTE2XdQ3pad8
	 HGpKX4TkerlYFNuqqsh7EoVMCCL1QJVUixTK3RF6aUK8+2ovoUIwSjPPCRZkmygiTc1HU
	 SmH4qohCXuV4x8xFBbRBN+c2H8GCHWNepDW47o7szcbI4ynAcbS4nEWuds4STdQHUJmum
	 x2RBfPOrTKglePRaCx08lZZHeUBsJa0/O8AD84Eu3ucI4n2dpyqPzTMSIB4OhaTuQVNi+
	 1ecszcSxg6/WfMWz0twgaZ6jzJLkJWrEDKqUstmYYfQfAjf2IiPAazhSqhzUVkMaOqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=gJLGIS8K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792247555;
	bh=48YZCGSXLxb+jr6AWs0MQN2h9L+K+L1qznsw66bN3go=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BNQS8vWpEfRP0UgOX4EMIovbx5BXjhXxwe2GN5KXUbnP/FgV7V1ZHj0oBJ7PrVHDE
	 IVZcPS3RITsw+jWTnvk4gkVMsj0VQvz8d71Vfy5FTY7O4bwzlB3GhQ96EK/vZtzmyq
	 3LHi5QMpbYm3AB4u4TOVlZQitsAkWqTDezObFnQMquHkHCRP7FhYRyy0wwDK8Gd2E2
	 3GUpsi7mARlN+4zjASOZUOm6I9bYLyiI0hiUALTUo2AHRhCGcTphKypwDJmAMmTrT7
	 m7RAZzqVeNIAx9kjmYbo1VaZUr7evbhbzZoL1MZU743UNSbBCp8RCB3Q5KTFyv+3SC
	 Y4SS4WDGURmOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD56381423;
	Sat, 17 Oct 2026 14:32:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EEC32A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 14:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80DD381423
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 14:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4BftkLAkSd2k for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 14:32:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66A4C813D0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792247552;
 b=n8O+s1E58U+ZcDZ6gcQbBnf5KSOESl40mKQqnpTLiRmfC3aF+1ujsuufBqHhbQXjOXmS
 Vmhzmw50hRjlwy0UhTO/RL7giO/Zhi9GTKQWeEoUPAVWkyEoGf0lwMRCwzs1tTIYOf4wG
 /nBMCcUU525RlrPLyQ/3JSDBBiD0U2HtwIe+8Ffrj3Jo6Arws2ErMccZPqGVzGfkpM5Jl
 1RtAowq03TX/FOy5qaZg84fFkSNDo/SGDic+k/q6e0F75H3idyBEQhiSZdVy6oQGMJAC5
 pwvM0OjhWBM3LwglvsowfhLnJ2sBQaA/PrA+cSXpjut/sA2TGW4nOmxtzjz2B/R8suA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792247552;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=48YZCGSXLxb+jr6AWs0MQN2h9L+K+L1qznsw66bN3go=;
 b=AGPlMsq3brS5pltYfLYVGbYWn5MbCE5YBlPBvOTRFFaKfhrzKIMr5B1FcpdLbLvQu7v9
 +DxGGm+1PijhqOhPLbr1lVtrPWe2Wx9kSIxyH9ItLWgzyryScph0FWZ5KQc66zPUC1IVi
 zm9zB75mHdxuMnsh7h8NnFqmDh3wtlFIjkoozT+DMF8WAlBsMG0rpY32bdW/hEXtE1ih3
 s3fux9F4yvycCsKxXbRH2yOj1a/rOYKSFD/N0mHJ3ljjCioP5v+kDQOGeuTY9OimyOjBJ
 BFQGyd+4kfTa93U3lgearRoZ9ydrsypq1OYMUTbHELEMUyOaXLUuZ+XRs7LMQArFZAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=gJLGIS8K; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+usb@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=gJLGIS8K
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66A4C813D0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 14:32:31 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j6PQx4QKYz8t2h;
 Sat, 17 Oct 2026 16:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792247545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=48YZCGSXLxb+jr6AWs0MQN2h9L+K+L1qznsw66bN3go=;
 b=gJLGIS8KrBUOmMZGnLw/L0stgB3wa35SnKVumNV6/STbHO5cOQ+3aV1AlLh6jBYy0Ts15E
 /AeEXx83Vfm649tWSSBrPQvC65qIH2hpS4vP7MczwHs8xkLyLXUVZ9bNtPnOtfUoYpo8+E
 MSbQuUOzySBwcGMKSpNE+X56ydJRvLQV/voTGLZ3JP7yI5ylyCF7ZL/bd+MCJ/6LyvICiw
 b3OZ0BWCui3ACIqLddvwJejaEOYkogdtmL/y0lZh3RUdWsqyXzXtgUgSt3pn+T6iq1CnWX
 yVHNQElGS0V6iqNc18HZXp8vB6+VRZImMT44IFdlcQrlRmNItjpHUfEhnuo5cw==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Bruno Banelli <bbanelli@gmail.com>, Ryoya Tsujita <tsuji.riya@gmail.com>
Subject: [PULL] u-boot-usb/main
Date: Sat, 17 Oct 2026 16:31:48 +0200
Message-ID: <20261017143216.157109-1-marek.vasut+usb@mailbox.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uzfoqtm5qnqh5d6nrwsx8i6ysqcmrzf1
X-MBO-RS-ID: 5cc7f98b6e133b9a652
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

The following changes since commit 8d534cec0cc0109a37c0ded8854da03f1526dc0e:

  Merge tag 'xilinx-for-v2027.01-rc1-v2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-amd (2026-10-16 08:42:42 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main

for you to fetch changes up to 00a4c487665d58b36bb82a310fc706a3f1d311a3:

  usb: xhci-mvebu: use dev_err() instead of printf() (2026-10-17 14:40:27 +0200)

----------------------------------------------------------------
Bruno Banelli (2):
      usb: xhci-mvebu: use regulator_set_enable_if_allowed()
      usb: xhci-mvebu: use dev_err() instead of printf()

Ryoya Tsujita (1):
      usb: kbd: Add 2024 Apple Magic Keyboard device IDs

 common/usb_kbd.c              | 15 +++++++++++++++
 drivers/usb/host/xhci-mvebu.c |  7 ++++---
 2 files changed, 19 insertions(+), 3 deletions(-)
