Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F941C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 13:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBEE886596;
	Tue,  5 Sep 2023 15:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uk3Y3qlh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kb0oAsjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ABC98690B; Tue,  5 Sep 2023 15:49:31 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2948586580
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 15:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Rg6Lb6kGKz9ssT;
 Tue,  5 Sep 2023 15:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693921767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qNHsYt/Yq4wGD+Jr/fn9szNqr96096FmQRe4vEeG3aI=;
 b=uk3Y3qlhm0x8I9coqWAb8zshVZCaCezd79gTTz4VIx3c0XUUaZYAXf2zz3u+kuXTtTeSVS
 5X2XqreNxrrAOKXR6p4/w3dMTNp9wcxK0FnqMF1ytZK9grqQO+p+6KXRUxOtZUJdaPCHnv
 XTFc3qG4yc7rCM4CSPGfctUM2Hl41otTYCD/P0QJ2xUavTLlByaMa77dU/1zzzDv2ULX3q
 wKr/CdLZH9WCgXS62Ad+KadX4JrteBS5P+/SW8mYvZ0yJJCkrUu++wq5JJAsRE3Qet+QvD
 udQ9ngTf+LKMH1BEnFbV4paLwHNk+5KXW6bVTkTMYmy0AwnhP+BOeTwZAmGb6g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693921765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qNHsYt/Yq4wGD+Jr/fn9szNqr96096FmQRe4vEeG3aI=;
 b=kb0oAsjCWBAceOQRNezbkSdDQRha/9bmlr5TYp5UAMUBeq38WkrQEDyGJYAGN2VOUaX6lh
 rkm6HWbkoc8hVCuh21ZSwy2Oeu1zqhGqN4ec8ahvBeCagkFzloBzd3cMspp+yhyP2QAmxT
 nWRInjc4nE+bkUWmlCf8ibIF5YfU6k5ryNwNSKrlc87Lhggu2rdFm4cvZE8wKMDa/5urjG
 Mw1O/3ckdHQFEbCKxBD+bpXHGo0GocUtKRS/wyP0LQR4II/UMqltze5laUjUkm9tZs9Bkw
 TCxpb6jiEjm9VLEI7KfGAa+U/v1qy03m/3gn4DPAjiubt/Ge2KC0YyKqyP6Hng==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next
Date: Tue,  5 Sep 2023 15:49:15 +0200
Message-Id: <20230905134915.15105-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bjgms6j1rhah8rjubo85jwfg561ihm6a
X-MBO-RS-ID: d90f3e2f645d48ebdfa
X-Rspamd-Queue-Id: 4Rg6Lb6kGKz9ssT
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

The following changes since commit b53ab97150314674edc25508f4fc528be2baa73f:

  event.h: Documented some newly added portions better (2023-09-04 11:19:50 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next

for you to fetch changes up to 733fab7177ea3c0402bab9db07422d5dce495139:

  ARM: rmobile: Clean up rmobile_cpuinfo_idx() (2023-09-05 01:13:35 +0200)

----------------------------------------------------------------
Marek Vasut (1):
      ARM: rmobile: Clean up rmobile_cpuinfo_idx()

 arch/arm/mach-rmobile/cpu_info.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
