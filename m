Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED5BEE0ADA
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 12:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367EC83693;
	Sat,  7 Feb 2026 13:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Sy8buV0E";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xNpgaEu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D9083A64; Sat,  7 Feb 2026 13:00:37 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55A683642
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 13:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f7V0235phz9thp;
 Sat,  7 Feb 2026 13:00:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770465634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/k4sVwijkKsdbr/6esC/R7TKKXBqnVimxdavaSPmtM=;
 b=Sy8buV0EYAsYpteDX2no6BlkM7M+3ya/qJAiL4peD+XmxiiKCTg/CeUKimswsf9xPSjgjz
 9OxGiXNFr3dvQq+VEVDAKAJbflBrjwk7MyyrAR2+Rw+IQsRSb8lVG4emJRAj1CdOYJ2V62
 tQ23ycFp/y0ztzdoJAu/2mO8RfE85VIE2CoCjJSPVolq2XAa+vB8/lrW73mEmMqDHgWUwW
 HR+DgIoqdeguggxQ8tnjWgKyy/S7PJ+zAkEodkSr5x9XYF5m+/M2IteevoV1IjRHsculPJ
 EEe7dNL1mfXwuyj8Cv854pvvKUFp2NeO41pAECi1yjsKyLaVLsBDYANwBDeQlg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xNpgaEu+;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770465632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/k4sVwijkKsdbr/6esC/R7TKKXBqnVimxdavaSPmtM=;
 b=xNpgaEu+KA3Puq/PEzIdDpCDwQs/1+Dog72Q6vIDqnQlAf14QeUwtzXcw7e6qj5wV+EC5N
 RTit90iq6zDbNtKmkjzFjf1Uad1v1x5PnW44UEbOHHBBf0yx0s3ihUadC1fy9CMsR6EDQE
 teJe2zOpbHUMR5Sw3JyfZZhdf64Bn7HacNlaJmiReSv74RNIit0xQ87SQjXU7Y8tVy+xhS
 iGSQx55vOezzUekMQuHoefnGWcFl6QJdAFLjT2Mo5wmBJGaYgxbe9MNrSm7T6v9043UJEc
 pCFyXb+KfnEiy/ZSc8+DI7g89JJ3/ipL0NNiIIy2Nr5FRcRn12RmOHMCsYqjXA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sat,  7 Feb 2026 13:00:08 +0100
Message-ID: <20260207120017.6415-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b7drom7tysb16j4ib367a4m85n3yejzm
X-MBO-RS-ID: 13e2d66d54810d2ecf5
X-Rspamd-Queue-Id: 4f7V0235phz9thp
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

The following changes since commit a54d613baf742a95b6deb7a016ef6262737d1918:

  CI: Update to using grub-2.14 for our tests (2026-02-06 09:29:58 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 0cd81619bb25b0bcb768b9e30a603d37170476e6:

  arm: renesas: Enable wget command and TCP on all R-Car systems (2026-02-06 20:23:12 +0100)

----------------------------------------------------------------
Marek Vasut (1):
      arm: renesas: Enable wget command and TCP on all R-Car systems

 configs/renesas_rcar.config | 3 +++
 1 file changed, 3 insertions(+)
