Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2D6EE49A3
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 01:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210FF8634D;
	Sun, 20 Aug 2023 03:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NKn8Sm5z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pFsv6QuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D510686C9E; Sun, 20 Aug 2023 03:43:51 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF49586C1C
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 03:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RSz0h4DP4z9sWt;
 Sun, 20 Aug 2023 03:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692495828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m2dfVYnv8VrZAohxtqYy7HVkiXGhZHe6NL8gn5Pbbsg=;
 b=NKn8Sm5z9eRORaT3sblKdn/9n4y/XTUTMzJer5zcCo/cgNS0qaSImI28vgpNdxinIxCiGL
 fmk5Mn62xF3uckyYM86xRW3c7NsjvvFFL6N8FfmwsL7O+3h62L9JDH5swbtSm8p4oXBk4E
 vQh8MpuaKpCvFX+fxu8LZNb+J9gB5+vQz8KhoYioeoZo2d9ROd6cqhJtJ69glJvnqjXzhR
 O1YmEF/um2r8BPmTe0kXFyzJbTW8HgHcW6K3ASam55/FNncTMGw01jLbJ+c650k1SjFsRm
 136GnT4GAf4HnkXJDtX8G3TNZ6SykFWTYB3eezA5fFR+k/9a2jfRwD2coypGyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692495825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m2dfVYnv8VrZAohxtqYy7HVkiXGhZHe6NL8gn5Pbbsg=;
 b=pFsv6QuMzuwTBPJAI9xv9IMPvrwc0+lrr659z0ycT4iay95WZXS4zV/GVMzvitKpPxBpbn
 5fyUXHzBxoXFlLJoI8hVXF6ewTcK61iYWHxXw9azczax6Em6X81BigXEKYxgY2ALPRXRIR
 2HQaPpqzBlJu7Nm3yFlr0JGzmDJ8fpmQtEoRzS8lrg2vcDs1X4CI7vzrVhHk8rTE+qm+Uc
 vLfeqI/Pf/f9Gb7ro0Th+EzVwVMMSVDcPloLkEqdQJ3T5WAzLcl0JmFdKW9GRR8dktCA19
 yvjgPoHN1NpcA7JFmZnJvK1MVll/VurMrNHux67yc51oL9CppXub1bkxc1pO3A==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sun, 20 Aug 2023 03:43:28 +0200
Message-Id: <20230820014328.779175-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b4ea364244afff1c46f
X-MBO-RS-META: gigctmbas3m7ojjcju7eh5fcbbngfw9i
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

The following changes since commit a5899cc69a99379f01e8e2f9f98e0e09b24f1656:

  Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog (2023-08-10 11:40:09 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to dbada49554edd16da39134815635fd0015725c9e:

  arm: rmobile: Fix off-by-one error in cpuinfo (2023-08-19 16:34:41 +0200)

----------------------------------------------------------------
Hai Pham (1):
      ARM: rmobile: Update little‐endian byte order option in srec_cat command

Marek Vasut (1):
      clk: renesas: Tear clock controller down last before booting OS

Paul Barker (1):
      arm: rmobile: Fix off-by-one error in cpuinfo

 arch/arm/mach-rmobile/Makefile      | 55 +++++++++++++++++++++----------------
 arch/arm/mach-rmobile/cpu_info.c    |  2 +-
 drivers/clk/renesas/clk-rcar-gen3.c |  2 ++
 3 files changed, 34 insertions(+), 25 deletions(-)
