Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E532C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 16:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C11F80879;
	Mon,  3 Aug 2026 16:29:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YF6dZNsp9bOh; Mon,  3 Aug 2026 16:29:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A23C80882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785774550;
	bh=9WsnX1nlUO2iKg+CBqeBHQQnDOZsHsOuhpdCbxNSkTI=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=MY0Qz7YzgE4QkDEG08n5bQvuV4hU+S5snVNuq0RFTE4O2vGQH4aQcPZ2PuD7Enow/
	 R2OFbDdAu0Emz1Sv80qTKzqKYivsd26ERDfEiFgLIFpz9u/yjkwEjwMU3QHzxbi+Ws
	 616+HMVc5eFUJ3OmGQMEFfcX+fLXAsn5Jzk3Ck2m5LrbT16ZJ620wmSY+PxJKGPdLp
	 UhuF31QHZTI2kHw86m3AutVWA6lt+7IspasVN9+Q9dMg/QD9uK//SvKSJSbcuNfiyr
	 MkTl4TDdCWmV8SNTrsf+MjNrCUTa1s6UyA/hjN0Y+W8ePqXPUK4ivOqqxbeaVNd+fh
	 frFsqY1QY2+ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A23C80882;
	Mon,  3 Aug 2026 16:29:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E42A218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C00F40541
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ciK9N-5GERD7 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 16:29:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5021740536
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5021740536
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5021740536
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:29:08 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hDMZ85MvfzKnCh;
 Mon, 03 Aug 2026 18:29:04 +0200 (CEST)
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Please pull u-boot-watchdog/main
Date: Mon,  3 Aug 2026 18:28:55 +0200
Message-ID: <20260803162903.3214106-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ght84dbgq9aarcopjx8xfjm19o5wtqns
X-MBO-RS-ID: f0f1976c4da54abee74
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785774544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9WsnX1nlUO2iKg+CBqeBHQQnDOZsHsOuhpdCbxNSkTI=;
 b=WZO6h0B3pFpmL7ENDYYN0Oxw8QMLFkDwl4XonHlURySlucEoRuA/2GA3jA+iBhiH3Ltb2Y
 N8QFI3Xg55NwaZTnopAZn1feNCR8my84jW1UgC38vmbW+Ox5ROM3tvZrofEQLjvjCT5dTs
 Wj5VcFANqSg6afdk4p8VkwaQFdG0W+Eu7R8SEKGmq3b0t6OEvptSBP1VgXW2oHdwxz1ZZ6
 qepGrbOTZECG36IOo50XNfNmYAXjIwoNtrzxrMWc8o0wSwbs0SsxR/y7W8W2BGHUvH0Wtx
 q6dGzLhClQ8mbmPdHu57GASOOPBoSoJWpaGbh5QkvBr7DmzVBqmyOf4fgqModA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=WZO6h0B3
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

please pull the following watchdog changes for the main branch:

- cyclic: get rid of cyclic_get_list() helper (Rasmus)
- cyclic: return early from cyclic_run() if the list is empty (Rasmus)
- watchdog: ast2600: add AST2700 support (Ryan)

CI (GitLab world build) is passing:
https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog/-/pipelines/867

Thanks,
Stefan

The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:

  Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog.git tags/u-boot-watchdog-20260803

for you to fetch changes up to d9ce7ed30571ae01cdcb5fdfd2991e4a7be93c9f:

  watchdog: ast2600: add AST2700 support (2026-08-03 15:00:33 +0200)

----------------------------------------------------------------
u-boot-watchdog changes 2026-08-03

----------------------------------------------------------------
Rasmus Villemoes (2):
      cyclic: get rid of cyclic_get_list() helper
      cyclic: return early from cyclic_run() if the list is empty

Ryan Chen (1):
      watchdog: ast2600: add AST2700 support

 cmd/cyclic.c                   |  5 ++++-
 common/cyclic.c                | 27 +++++++++++++++++----------
 drivers/watchdog/Kconfig       |  6 +++---
 drivers/watchdog/ast2600_wdt.c |  1 +
 include/cyclic.h               |  9 ---------
 5 files changed, 25 insertions(+), 23 deletions(-)
