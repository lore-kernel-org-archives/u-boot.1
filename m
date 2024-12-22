Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE85E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 22:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E60680642;
	Sun, 22 Dec 2024 23:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mA2PaByd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="unxVl1pP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E0B80654; Sun, 22 Dec 2024 23:45:22 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CA78805FE
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YGbp81Sjwz9scM;
 Sun, 22 Dec 2024 23:45:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734907520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2cg6cGj+CAULmhqGdN6ZElqcQupy2GFDgLhwQz+xmOY=;
 b=mA2PaBydoD5ZW3NCKjgSGTQA4UAZMYIfB79sYUoFggyPT+EQ+0vgb3WVzSYLiymXrg2Iwn
 yuIVMHUVKiGTjhBDuKB9B/hlGOoyGA6eXwre+XODDbI9cVcReiObnadw92Z0j2kpv46osn
 iiaqqbfXblQrXIk6jChg1LypKuqDsZVSe4JyYo66E/pHL4vkh7FiD7RqZe0XrdZasSfcZ1
 BxUd/0ZbWiMwvcAssQc+2RxAd+dJM5HdN02le134xVaXnkYxRnJyxGkmupwrHSK9+LAAvP
 GxCfjdj1gIGgw69lRuN8jhsxF/GaeVelvJzJYWGoamPrt0QnXd9qoWZsA0wLGQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734907518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2cg6cGj+CAULmhqGdN6ZElqcQupy2GFDgLhwQz+xmOY=;
 b=unxVl1pPm7xqviMN9k9h3cK5v/ZLlqLxnqXFSJOl3BUNKtt9TLxxK+dOAWPZep0+NdT3Co
 2qytpB0KgHmTr4yIyh4n4XWz1CjDd8WZZ564yqFhRmneNp8xGECTMTZIWI1TsbjXm217Vs
 xeHTLv+IgrXb1m6qVUahXzNEjezzy3xp7M49XVdd1IO+q0oEeptAIchK1zspzG4jTk9n7T
 jW6UD7XkIZsHD12v0PjoGmw/MD/BK9XLaIkALwsMMFLjlRMKysdxR7ZfXGdniRJd8Ws2Jx
 95j7wHbdGH18u+s3JV/FwcovdNB7h6PdoH+nDphhfWczgiE20HfXLDoOlwrzxQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sun, 22 Dec 2024 23:44:52 +0100
Message-ID: <20241222224506.237322-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wzpzo9yz741opsirwusm1hwkojngx43u
X-MBO-RS-ID: 730785553ba2a7d5308
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

The following changes since commit cfe57427c28763fd94e5bdcf89de9dabca4b1684:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2024-12-21 09:45:30 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 70da4f28592d0a2296b27a9126da97cc3b30891e:

  net: rswitch: Do not register disabled ports as ethernet devices (2024-12-22 22:34:32 +0100)

----------------------------------------------------------------
Marek Vasut (2):
      ARM: renesas: Consistently enable ENV_OVERWRITE on Renesas R-Car
      net: rswitch: Do not register disabled ports as ethernet devices

 configs/renesas_rcar.config  | 1 +
 configs/renesas_rcar2.config | 1 -
 configs/renesas_rcar3.config | 1 -
 drivers/net/rswitch.c        | 3 +++
 4 files changed, 4 insertions(+), 2 deletions(-)
