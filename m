Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEA3CCD1BF
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 01:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA4F8352B;
	Wed, 29 Oct 2025 02:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kMM3oSpt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T/NmftO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF3E9836B4; Wed, 29 Oct 2025 02:32:13 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFECF82A9E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 02:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cx8qb3Fxvz9t8W;
 Wed, 29 Oct 2025 02:32:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761701531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=utO1vABeAtl/cucZqldfzHafWKd+AEQOKAmSXbU1jTA=;
 b=kMM3oSptU3nhNNpJ6T8A+R0oSSFy/vqvDmb7W0G40+GC1fJnuqx6pJ8bFaQuZ5Zj2YTMfu
 8NQbYPJc4UBjKVLvpbo33Bn9MAuaJCbHFO8nI/VYKEGlpG7kFicX5h+FooUO8X/mxgm6Ty
 nwIPAekVkzZYtsq3pCGDL0VzH+ByXwPHeN/T/ZvsHq8Jja09eN4XsTVUO/o49/H/u74WkA
 k8qYGwpaEmONQk/ni5s1je9ocxtnc8IS0uRyTtQs0RLMFxLw1CTU6rL2ImhTlCn5Es8xPw
 Z7GTML+6HTj7OPB+ayJt1iAVIhPuRCYDehM1giaXQ0ZGEYDeiZf78yQGKAFBMg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761701529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=utO1vABeAtl/cucZqldfzHafWKd+AEQOKAmSXbU1jTA=;
 b=T/NmftO508MythwDD5nSJkv9jB9miTgEitsGeGqDg+FHeFiczJmh3BkC2UJlpP6c/8vMEB
 sJWCPrjfo6e0XsJNGTTExOhqXS2W7bq27IGfGygFQr7q1y/U1jvwYzMKk4zOrBJWfPzBie
 Y/fyU7WSFNf96luQnccQNgq7P/LgpO83/ALfbRiMMCOnEdrLQ7SmcwKLIcJjQdv2mKK8Ib
 c+NnYSy2guj27tpM8fS2k3jqUzKAEJmq8nLnZaF18zChxyVzeZ3veyajnMtR2OAlheXL3w
 vKBehhdvI7aqtfMDOGZIIP6azfsUEFh/bFc1tVAC1m5AsG/sC6il126TCkp+Jg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Wed, 29 Oct 2025 02:31:40 +0100
Message-ID: <20251029013156.113902-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7612a73cf62317e138c
X-MBO-RS-META: 41tb89m3k3wtki65enfp6jhm6ateer4z
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

The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:

  Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 4c41735ecaacaf048771124e7eb3eda2122497ab:

  ARM: renesas: Drop 'imply MULTI_DTB_FIT_USER_DEFINED_AREA' lines (2025-10-28 18:35:29 +0100)

----------------------------------------------------------------
Tom Rini (1):
      ARM: renesas: Drop 'imply MULTI_DTB_FIT_USER_DEFINED_AREA' lines

 arch/arm/mach-renesas/Kconfig       | 1 -
 arch/arm/mach-renesas/Kconfig.rcar3 | 4 ----
 2 files changed, 5 deletions(-)
