Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B20CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C60980DC4;
	Mon, 12 Oct 2026 14:39:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LlGvYECtf-A1; Mon, 12 Oct 2026 14:39:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA0AE809AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791815990;
	b=EkYEzYnUmCwAZ3kSzq+rmY4O+dK2kzgtur4M/91gzXjhoEyE+8hlzBoa9KR7tr0Wxrmv
	 ZwbMqauE9/VYUWOw/lMOIP0K2CarK65M0D9ewib3obSajWLdDn9Gxm58KxoAgOCpimDZx
	 PUIY3uIp+IqVs41imzynB1KXdHGmZzSLZUaFtIwTtLQTipXJCXa/FdhTljJVU4uvpQVyK
	 apMZVvXCaNbkVzlCmTykivuy1WQ2P9gqL1UyId6m8JqnMBRFuqAezSnWyttIKsmAj6DKR
	 8fk1ju6ZmvPZVyC84lcw19xH5NInPfT6LCGlG16oN2mzfDmOtbhWNme0bXM9fs1jlJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791815990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dj3+6KK6eG3HUQ2B5SDgeA5FCXjXgAfKZkCWsgIzLgo=;
	b=n4gbk56L5o8eg91emM4TBrch7MUTvDeK/jLuk9EpgDpuBo5CfSRuJTs9XmtTYR4C1bPL
	 f5N8OlW7+zR8Y0yCeuwf0aLBDkbyQ2EVWGQEi+OkoThIo3SvehnPZEz/8/sCwQp337tPT
	 YK42LLsoMvH2uwLg03GRfW93F4WrkwUoi2i9tgU+JA0dpAvKCi8liZZ+hCn44gFK2+2rq
	 WmfyJJWSKvXHmFYGtyeKVWGFlH9wX8DKE0ir6Sz7rCocYXtW8qFbAxwTk9UL6BQUKXx9U
	 fgFqP5eqYG6gEDF+0IA4ZnI6xNounvZddc/bNHOw4qTEFtoVHNSf7RFAybFBDLudlQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791815990;
	bh=Dj3+6KK6eG3HUQ2B5SDgeA5FCXjXgAfKZkCWsgIzLgo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d4oWQ7Wb2Af85avespl+k12L1cs5Vs9W+Y0llMNQXCw3yAA8TPyYqxheWdVMLs5jB
	 2x5ohYDTqmQOtUpE3m8Oa8lYBQcHnPjZ4m49z9+IoCxoMAEFUz0aI7+teVUEpSlwP/
	 kq9eQLAk1ct54koNHZ/Io8I06GeIyFyz+60X1lqmyrV8Fh9t1rdBwi9TxRLqnfaATW
	 p9w3GI0CwhEbmnkaiVi91NRiOTdtjpRWLMfZ0mMj02Su2HvsHORNXhvXTRQknZJSsX
	 xNI6jFLNP11QwW5tMcM+4dnrdiv8HqckJ6xwT7AuEeeMTV3tgQdNp00mIJhIqDNabY
	 xaR19J5acXmvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA0AE809AD;
	Mon, 12 Oct 2026 14:39:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CFF012E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C168C6066D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:39:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5GdErw3jmVr for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:39:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 067C7605F4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791815989;
 b=UCioEsQoWUcDfBDca0gehN/RLZxLjR0oErXO4Q4HJp0iyRwwRsrNLAMpkNEP5GRDRplO
 BmYTHAPwerz5diRWpmEYSGNpclPnGOMkFKjjV89/IsJ1D5BMn4V4MhN76Y2eqcdyhiPjN
 XvrG0y7Jd2XmFgs3nB8UO7YYEohVaUGMguYrnF7Jdp/lEPrxjOgyWOI86ixC89OEzejru
 xZwXLTq5J1ROnKp7c1jekYBb4GeIok/4dSV681yptZu33Rr3R38/EnXRQU2nZOKBAd5Za
 m/8l7lI44uLCSHpbC1ymAeOMk+i+uXHQq6TYbIrOjjRcSN7/VzdpZLWD5KXMjqnkfAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791815989;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type;
 bh=Dj3+6KK6eG3HUQ2B5SDgeA5FCXjXgAfKZkCWsgIzLgo=;
 b=nFb7b9ORBBAZ60pWHVpIQF4dDwtlN986dVtHKwhN8SBX521ho5fDrEzIBvTaSS9+6OUY
 nwY/22qEiNZ4b64kXdz5fXCGaxyp2WH4pMLGPKKmxU/S//RGOKflNOJzEWbHYXX4z32yg
 FzNrTUskj/L3LwBXcWcl8Db0HDh4/aIO2OQdEJnHjJyKaHsSgc7KxAzTDKtI47v5vjva9
 CB5RC87/W6oy76yqHNyk7HcdhekZnAYRAi1oYePCdz6YyDFklUwhnd+VY9tG+V1fsKygQ
 wZ3emHxoSMlMy1ntvNP5B8q/hpoRTyT0SuPBPnl3YqrPOxFvA+FnqBaeVrnGbZXASXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dnjsr2KG; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dnjsr2KG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 067C7605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:39:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DDCBC601FB;
 Mon, 12 Oct 2026 14:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2294D1F0089B;
 Mon, 12 Oct 2026 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791815985;
 bh=Dj3+6KK6eG3HUQ2B5SDgeA5FCXjXgAfKZkCWsgIzLgo=;
 h=From:To:Cc:Subject:Date;
 b=dnjsr2KGzRWKoyVyUUwouCb8ZaLLxslkYlQbe81L/cum4NFJy6zyXC79kIOzmDVb+
 L08u+p7iq7pE1yvCnezSDIr4ZYGNYchuICqY6LVwWK1GpyOjBJGY+51p6PO5NynxUp
 yE2r/Rwk8PMz3fbHj5cZX7ewtjmw9QV0UYEciKfDmETtsy0ETtaafL9frAIFpHoXS/
 pkrljbZ3yATuDME8wCdR0qAahZvgi8apO+eRwZJTpPS34oawyPM/Mqf0NKP5dHfbrY
 eRZIrDOjItIt0Fiaw1JJINu/HD1NARAL0j9WS2R8gyOkjWZqw+/tt3G2+98kkwN0DD
 urWIDKWiLr+7A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Carlo Caione <ccaione@baylibre.com>
Subject: Please pull u-boot-dfu-20261012 into main
Date: Mon, 12 Oct 2026 16:39:43 +0200
Message-ID: <xhkdb7bjn7zkg.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here is a PR for main with the following:

Fastboot:
* Add SPL support
* Make sparse-image phase aware

CI:
* https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1546

Thanks,
Mattijs

The following changes since commit 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363:

  Merge tag 'spacemit-main-20261010' of https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit (2026-10-10 08:30:11 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20261012

for you to fetch changes up to db0772ba608869fdf3ba68637bfa759957a032bb:

  fastboot: add SPL support (2026-10-12 09:58:47 +0200)

----------------------------------------------------------------
u-boot-dfu-20261012

Fastboot:
* Add SPL support
* Make sparse-image phase aware

----------------------------------------------------------------
Carlo Caione (5):
      fastboot: factor out the USB session runner
      fastboot: use the common handler for USB reboot
      fastboot: make shared configuration checks phase-aware
      image: sparse: add phase-aware SPL support
      fastboot: add SPL support

 cmd/fastboot.c                  |  53 ++------------------
 configs/sandbox_spl_defconfig   |   4 ++
 doc/android/fastboot.rst        |  48 +++++++++++++++++++
 drivers/Makefile                |   2 +-
 drivers/fastboot/Kconfig        | 104 ++++++++++++++++++++++++++++++++++++++--
 drivers/fastboot/Makefile       |   9 ++--
 drivers/fastboot/fb_block.c     |  11 +++--
 drivers/fastboot/fb_command.c   |  99 ++++++++++++++++++++++++++++++--------
 drivers/fastboot/fb_common.c    |  36 ++++++++++----
 drivers/fastboot/fb_getvar.c    |  30 +++++++-----
 drivers/fastboot/fb_mmc.c       |  49 +++++++++++--------
 drivers/fastboot/fb_nand.c      |   2 +-
 drivers/fastboot/fb_usb.c       |  67 ++++++++++++++++++++++++++
 drivers/usb/gadget/Makefile     |   2 +-
 drivers/usb/gadget/f_fastboot.c |   9 ++--
 include/fastboot.h              |  10 ++++
 lib/Kconfig                     |  13 +++++
 lib/Makefile                    |   2 +-
 lib/image-sparse.c              |   2 +-
 19 files changed, 422 insertions(+), 130 deletions(-)
 create mode 100644 drivers/fastboot/fb_usb.c
