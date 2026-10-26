Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE9606A320
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vCTta129;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=WKCgMyzL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B99FF80970;
	Mon, 26 Oct 2026 21:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1dgpTCBCGGzr; Mon, 26 Oct 2026 21:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DBEDB80CBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050404;
	b=LJzWl3oA9cNzok0YO4XRFC/+zx2avsqWfBo+hrl59Lr0SKRiB8C8/fKnLzQSvc+ll9mZ
	 CsaqzNM0vzcfCl7I3yYDo9Y/Csa5R7hOa9XfhEtBT5AOqgBSnIOfAcSfSE1b1I/4cs68I
	 906bdWpNk4Cw0Pcaaa2GoafMU8+pYLXf5EjvseLGtPpJ0kDuXozldlkUC5BpujzaYnRlg
	 XK0b748xgv/6T/C4pXvNiM3pg5/OVbvRkje4HxLFMln7jnlEvOM5HMmZrwPUH4trqDf9E
	 Ohg992bOYbCu9Q+tIVaqoOuYfw1ZRTE4TEbQSrAhHB/DlMBg0mvaNp3mNPS/1wgPvmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7+wtmys40EXWTpPnchr8IDRkiZ1co8hodMPTFUjl2j0=;
	b=BGvWW077CyKs3PT2hOiY80R+GMtvPlaKX3bdIVxQn3RX3JzR6gnEI6ENqNEcvLFrTIhQ
	 hpH4hpwCMAtcMb1imngCJl5zhKEWY2XbrPoWdd9GP1+VUZxF7PgVTFBYEkK48Y71gYuM6
	 AyzJ+/9OABG7xP23aiJJS6apWx2YTcEEXnc9dEVFgb44Em+cmyDfrOEgCPS8azbkaPXRv
	 1NNxwF2U0L9bnczPHf9AwsIeop3FNPSNL/dxuOjO4T94cYU9i6N4LBKlkcdMY6T6bZQY1
	 hD5tv1WMc3ca8nYSKjSIrRAxbOUOckDIdkZcg0g0qkXp/EG3bCB3SUw6Gk48SPpObow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050404;
	bh=7+wtmys40EXWTpPnchr8IDRkiZ1co8hodMPTFUjl2j0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vCTta129XwXQKz6z2kdmOKplddWWJOKONmHtKNPWfWtzBNH71e+1z8SSl/WauJQBb
	 y4OqdEXu350IqWe5XQ9yrl9jqYU4/ltyVqI8DE+QELTXmot1g8xCVJSi+425DrM+6z
	 CDSTy5fpZj75twWT93X5DtSFFCrI2s0tSAzlfiAFdsj7xs3R48Fay9aKtDH6fX36L7
	 ObhACmB7tWz/7/foJ5Ox95ZcyJX7tYDF9MWvuoBq+pJPudiQCJoPGabgPO6+ZOcDoi
	 EnvpDPvB8N+a9cMNSujwAWAlqkzIN7oseuAkkylBY2nSjmFay0M7MFFiQ07ZI+cSBC
	 5bHF8XR8vgFsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBEDB80CBA;
	Mon, 26 Oct 2026 21:33:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B679380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D89A60607
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_bfoZjE8GR5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 375D3605EF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050401;
 b=JWPtehGIGsaO1xL7MBR/jqzTifm1L1OM2yFmHr6VphdN+H12ZGiE45Tuqlr+Ga+KIHs5
 Uv/DmNjaFBTIZBAD3AhhjxGsDCcT6y81IXrfitqzVjkzf+96vPfGcJTzNJU6dQsGWVO9S
 +rt38PU4ha/AAgiaN5POC3vW4/TOik+aAbyRlRzX/34OO61Sf/JQlqUbodC7PYmhJ92m+
 qn2JhtBVBasmLMjTDpVYYSZQPrPNUrWtU8gVEgqbTPwv+kKi5Vt1mq5SkfWo1PCtorVSk
 PuD9Xony0/ZRO3EIbUT3Ky0/a6jqVpxkGKirovmIv/hxNFdeSLRqpUIr4hXDm6h1+Pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050401;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=7+wtmys40EXWTpPnchr8IDRkiZ1co8hodMPTFUjl2j0=;
 b=GJ7KztiKAIYjqVeTfP/3U3gI4j7kNIoASdKDIuH2B7aw6xUjH5W4A49U/N8zP3TOPVOb
 90p2qshwln6tiseeT+s0N7ZDBsGKesb1kbsZqTTUqgBR1Y5asQOv16D1AuWHegRyZUwuC
 99p0en+vo+g40l8fAIuNoJCcmujNXCFTJhPjUtGsXE6/s07bi72W4pqTvxLBfFtj1U78r
 cpok0UaVwJKbv6TE7Wagqr8cYF7dB7Qnj1TiDz0qBWmA4mmoY6lvfU6k6uE9xBPboMB2T
 4va/whBNdysmC7YKM63wAxicpMAOO3RFKvrAEwPvrbNc0L692SoEzHz8P2to+YquEgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=WKCgMyzL; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=WKCgMyzL
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 375D3605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:33:20 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jD6LN6hgMzMlDH;
 Mon, 26 Oct 2026 22:33:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7+wtmys40EXWTpPnchr8IDRkiZ1co8hodMPTFUjl2j0=;
 b=WKCgMyzLyXJAfUyFzCReXwZwO6i0TFbIInR5hykRxuS6Cc7IwlH6+Rd78zIDljpBxFpXIL
 TSKqpETDvEf/qBicJqBtXzaeDk2rD19VA9yPJngKY47z+IzlFfMUYKduW5Ex9GNLDI7EKb
 vQtthtAv8aWqUyjD9fIhFAA9BVzbBx/NMqrKXzviW4u+gZrHjuINCXhOiyRr0ix6KaF7vF
 Ilcolw3Genp8OicR8+VooJ0iLWpYpkxX0bkccs7M3Si/AO5yvruRR+pyoeeiYNZ9cqD+Fx
 ScT54OOCNpwJoBeslg4RZHT6OYU5ZyRvzWm228rHVqMgwgsP5h60U1zW5DZYOA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/main
Date: Mon, 26 Oct 2026 22:32:26 +0100
Message-ID: <20261026213254.453482-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hcmcmjno1di4q35jc4uj8afwup5y7wct
X-MBO-RS-ID: 4dbdd5156f870617feb
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

The following changes since commit 8649a54d301a4d0ac526324c7a7ad2574939ff27:

  mtd: spinand: winbond: Clarify factory BBM offset in OOB layout (2026-10-24 08:24:15 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to ca2426c8ee6a05d18cbb68252aabd6281ebefd48:

  arm64: dts: renesas: r8a779g3: Remove reserved memory node on Retronix R-Car V4H Sparrow Hawk board (2026-10-25 21:36:14 +0100)

----------------------------------------------------------------
Marek Vasut (2):
      arm64: dts: renesas: ironhide: Align inline ECC carveout sizes with bootloader settings
      arm64: dts: renesas: r8a779g3: Remove reserved memory node on Retronix R-Car V4H Sparrow Hawk board

 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi |  4 ++++
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi     | 12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)
