Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC02CD98F2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 14:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37633848EB;
	Mon, 22 Jun 2026 16:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xbKXvikF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l8uopJ/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B3584931; Mon, 22 Jun 2026 16:06:29 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E59D84866
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 16:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gkVNy6lSYz9vGR;
 Mon, 22 Jun 2026 16:06:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782137187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zvQH/TUNM9aYCahA1GBkp2r0TZCPoarha27oxWg5DXc=;
 b=xbKXvikFs/flADSHuAtcGp3gAqB4UYNaRlevWlQUzn2P81IOmcabWb7XG1Iqg/izcki3sM
 7Enma3uwzSxFEttPnPBGg1/ENTpyPL4YQd4tCa0fAhsEjsYHkjC8silJ5zk7tJR9N5OkF1
 4eK5T+MpsFO/e0YCwlIVEdGcLuXQ5fXias9i0XJF6eBWgrRbMFpVlHUw3fhOmD1S4/iHSx
 De9XsFcpWJ5FpFyQwVLFO5ITNfdduP4/mHLzDgaPbP7MOriGZNZ+UfN9EzJZsBtfoVbsym
 beSMXeoN3wl6USo6X2UK7u9UAuFp3l5qW4F6NUJSJExlzsbt+bwu6qwSykcHig==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="l8uopJ/n";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782137184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zvQH/TUNM9aYCahA1GBkp2r0TZCPoarha27oxWg5DXc=;
 b=l8uopJ/n9rIF4RO70o266ty+EnRo6Ru+LqpkrJDLkZVWauJDVKbU7MzZm520v8OV3Ejz2X
 +qh2Tsm/7lx1kueAHrGURWhrL55+9d+CxFMG/HO2hFjMUPCqePrFZFNSJbSWQaHXpkElYB
 G5bMzKrJrmI/Yw/Szfn/FU5vyxdNYZ3IP70HNiHgtmaYXB3ne4eScxUWVCdF5YtxiyGvhh
 EFRqEQbIG7Iw7lHQk3tOVdsNwzGX82C5zGardJFoEctusj5iqG2ZW8tbbVJXg2zQ2/sgRJ
 VcEurMrvipCe0M3bJb7kGq39L6MX1tC4ejsABKUrra+9Ky3KXCIpxhQ5mIlN+w==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francois Berder <fberder@outlook.fr>
Subject: [PULL] u-boot-sh/master
Date: Mon, 22 Jun 2026 16:06:06 +0200
Message-ID: <20260622140616.12182-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 16k5jwxyoqiuys91doyq159n5fy4mx76
X-MBO-RS-ID: 845e52b6849876487ef
X-Rspamd-Queue-Id: 4gkVNy6lSYz9vGR
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

The following changes since commit d57ea0d9edf5e5babffd280f7352f23a33a00948:

  Merge tag 'efi-2026-07-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi (2026-06-21 09:27:12 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 661413904212a8ac96f13278a627ab3a38e54780:

  serial: sh: Fix dev_read_addr error check (2026-06-22 06:34:09 +0200)

----------------------------------------------------------------
Francois Berder (1):
      serial: sh: Fix dev_read_addr error check

 drivers/serial/serial_sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
