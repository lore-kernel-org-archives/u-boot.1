Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AE4FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 11:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B519847C6;
	Wed, 29 Apr 2026 13:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="GoGvMFVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC27B847C4; Wed, 29 Apr 2026 13:43:10 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C123F84715
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 13:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202604291143074a8ba6bf56000207eb for <u-boot@lists.denx.de>;
 Wed, 29 Apr 2026 13:43:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=dvyG2Sk6pzVgnao8E75mlczw4+77ScXYTCtSGRjUEFs=;
 b=GoGvMFVeR04qqSN8MwNRQCszKHKV6bzVN5b09U0SfaE98EMuEKZGKZML7ODex71Uizm/en
 lV0vssm08X3JPrVl8uaRio+YU4gWCy6T1P6Uj/pe1ffT4XpbJyIZyQyrLpZZlf56PDylR1Ab
 ETAQRQPQR2YbeLtjrDSIo8N83/RfYM0wpVPM8abblZonJgiRvsdYo8EqTQQHJGV3crQqEBQM
 KbVJ2coXmK74/0QdBIgzL8D9Lg+VTLhk3wx4c9nFMtrhrNQehRLlk1W0FM/A10vKeLPQg8f0
 aY6nh5GsWt14DYvnSYphBxj+/wXpklMoLWovmtff5SWNAqjk84rBbtMA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Aristo Chen <jj251510319013@gmail.com>,
 Benjamin ROBIN <dev@benjarobin.fr>, George Chan <gchan9527@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] Improve U-Boot's TPM handling in the non-EFI case
Date: Wed, 29 Apr 2026 13:41:40 +0200
Message-ID: <20260429114250.791663-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

U-Boot might be the first component to start the event log, eg when
used in qemu. So allocate and attach the TPM event log to the TPM
device if not initialized yet. The address is copied into the device
tree for the kernel so the event log is accessible from Linux
userspace too.

I am not sure the allocation is the right way to do it for stuff
that gets passed to the kernel though. Advice welcome.



Ludwig Nussel (3):
  test: include mapmem.h explicitly
  tpm: make pcr_read command more useful
  tpm: allocate tpm event log if missing

 boot/Kconfig            |   1 +
 boot/bootm.c            |  18 +++----
 boot/image-fdt.c        |  67 ++++++++++++++++++++++++++
 cmd/tpm-v2.c            |  54 ++++++++++++++-------
 include/tpm-common.h    |   1 +
 include/tpm_tcg2.h      |   9 ++--
 lib/tpm_tcg2.c          | 101 +++++++++++++++++++++++++++++++---------
 test/boot/measurement.c |   1 +
 8 files changed, 197 insertions(+), 55 deletions(-)

-- 
2.43.0

base-commit: 70cb0b8232246c5157802cc26536258a1a446603
branch: us-tpm
