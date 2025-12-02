Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56167D1266C
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 19:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD84F83F14;
	Tue,  2 Dec 2025 20:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j9oEGcn4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KLc1sI43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B7783F15; Tue,  2 Dec 2025 20:59:19 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA9283F0A
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 20:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dLWnK2PYxz9tWy;
 Tue,  2 Dec 2025 20:59:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764705557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=se5GnR2ZnBUdF9ZL0ZK6yVcQw5o2PZa8TPfRIjYsw9s=;
 b=j9oEGcn4lUofJ/3uzgJ8+tXhzLd++gF4tCT8RB+nd2U+n19Erd0WMYAUu6KL/6vTcBLEWi
 H5JdriX8JJ12bZaFSm3fvb+RDlT0jUYkZQv4bqojPtx+nHUf2DjwkGxqwQQdz6zCShiMjJ
 epSXvChTDtT4IfYx69T+vuzaVgXzSXeYnPgvA84OOoUvtXiPKAonE8PSQJXIoR12D4SpaP
 HTRcuLCsVDnOSpv0Xe8wG1aRepsZ9tHgicMX5jb3Ll48AaFHuKswG+TAD6vLzT6cdoOHNP
 EYR6VqAJ1l9itDT4P9AoMzITmlsL58L0Xgjub4/9w8q7eKAXfh+jjr4HMkk58Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KLc1sI43;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764705555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=se5GnR2ZnBUdF9ZL0ZK6yVcQw5o2PZa8TPfRIjYsw9s=;
 b=KLc1sI43+YpWFZhpUd1YKOs/qkna7Ny/V2zVOFG+B8vPSvEC2z2+bXlkS/Ujo6eQh4KETN
 aBn5/8jPhyfl59abygKK5s1wJHO4Rj8m+gNUqtUuPAAOIG/Exub1YzJI6hLp4UoeQhJufF
 lPC4VYccQbZUXa2Pol7FxqkcRL9OAmR0JSWizb3/Qj9jGHM1xJs8tH0vg0/pHG7S1h1ZHf
 ICwGOqn4CZzOevVdGt1eYUjQonaFwhPXgqhc05ZswQfstRjJmo9HqKdBZDVnMiirjCT3sM
 3qBFjvKWbxeDpMBwBY8dcxZGN09vEw8W8nylAYnouC1868/Tg9XsIj3LDH5NXw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Tue,  2 Dec 2025 20:57:43 +0100
Message-ID: <20251202195904.151388-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 870c871bebc5188b34d
X-MBO-RS-META: xik4inzfwo3okhh5f133yxks656od4b5
X-Rspamd-Queue-Id: 4dLWnK2PYxz9tWy
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

Two fixes for R-Car Gen4 and CONFIG_ENV_OVERWRITE=n to always expect setenv -f
to be used when overwriting ethernet MAC on all R-Car.

The following changes since commit c6ee44b5573a90b0a3a36cf858954e04439ae632:

  Merge tag 'u-boot-socfpga-next-20251201' of https://source.denx.de/u-boot/custodians/u-boot-socfpga (2025-12-01 10:37:45 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 6ec94acd15e3a44700287c27ca8cf15488afd424:

  arm64: renesas: r8a779g3: Use redundant env on Retronix R-Car V4H Sparrow Hawk board (2025-12-02 19:25:17 +0100)

----------------------------------------------------------------
Marek Vasut (3):
      ARM: dts: renesas: Enable R8A779G0 V4H White Hawk RPC SPI DT node
      ARM: renesas: Disable CONFIG_ENV_OVERWRITE on all boards
      arm64: renesas: r8a779g3: Use redundant env on Retronix R-Car V4H Sparrow Hawk board

 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi | 2 --
 configs/r8a779g3_sparrowhawk_defconfig       | 1 +
 configs/renesas_rcar.config                  | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)
