Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4818C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4D887FC1;
	Mon,  4 Mar 2024 16:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TrnxEz5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97AE187FBF; Mon,  4 Mar 2024 16:21:57 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F7486FCE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 773F1CE139E;
 Mon,  4 Mar 2024 15:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42FDC433F1;
 Mon,  4 Mar 2024 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709565712;
 bh=mzNK9iwMYxMjc2X5ZE8Ay+VZoaFkDzOYGM6WQEb+rDw=;
 h=From:To:Cc:Subject:Date:From;
 b=TrnxEz5aXIIlqUvVAGRbj+S1SVYNtA6kvYv/GlPM6TDAXH7I7bVk2dskutzenWPl0
 /a5b9QT0f+x66O/9qbRPkfWI2frcSNj3m5F76XmDklQ3h1l87Pok28+rSMatcbPQ2h
 VskjtvsfYHsT3BAd3ti0AkNtP3unIlvEhuA+WjL3CBgl5lLiBBOGXtKJaw1XhD/Gix
 UeRRt2NfdpVzYRUWeNuWT1NkGUNKlgnSaRxXj0gi2m1jMtdR/mddTui1KICE0bF2Nv
 D1oZnhonzv64kPDMjw3HJinBOpShgROlj/e81tChBbFEgFm3SGItpb71GDxbqRaeHU
 m2+HTJMfaDY0Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 0/4] Turris Omnia - New board revision support
Date: Mon,  4 Mar 2024 16:21:44 +0100
Message-ID: <20240304152148.3847-1-kabel@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Stefan,

a new board revision of Omnia is coming. In this new revision the board
information (serial number, MAC address) and board cryptography is
implemented by the microcontroller. The ATSHA204A cryptochip is not
present on this new revision.

Here are some changes regarding this.

Marek

Marek Behún (4):
  arm: mvebu: turris_omnia: Refactor MCU status and features reading
  arm: mvebu: turris_omnia: Implement getting board information from MCU
  arm: mvebu: turris_omnia: Print board ECDSA public key if available
  arm: mvebu: turris_omnia: Disable Atmel SHA node if not present

 board/CZ.NIC/turris_atsha_otp.c          |  27 +--
 board/CZ.NIC/turris_common.c             |  42 +++++
 board/CZ.NIC/turris_common.h             |  10 +
 board/CZ.NIC/turris_omnia/Makefile       |   2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c | 229 +++++++++++++++++++----
 5 files changed, 252 insertions(+), 58 deletions(-)
 create mode 100644 board/CZ.NIC/turris_common.c
 create mode 100644 board/CZ.NIC/turris_common.h

-- 
2.43.0

