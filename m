Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EED606A336
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HbNbJ152;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=eTIzKr3x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0F2B808C1;
	Mon, 16 Nov 2026 03:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGKRGJ7_iIzu; Mon, 16 Nov 2026 03:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F263B8085F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794799393;
	b=X67pSiWWnYWFxNxKGlnqaNhTZWD9OLeKjNJzSWvqZORygm1b8VRvAs1txl1x4R0lLOC/
	 fXDfuxOFw1Wu9wqNdSht04Ep81uFD8apQWkk1RQGsZxY5r0vEYSf+7iv8cWU3R2kNpSbO
	 NHzktEROOJ28mjYKE0GdLQN0vmX9xQMNxIJ6D25FgONWFEJPxAyVAnr6P9ijA95XCLE7e
	 GK0J/sFHs/hooZav9ZoYNfXioXVA1oKAJ2QCaerkwlWmNH9oV95KPP8aFSA5dRQNa34j+
	 SdsQG1X4aTwSQ4jJubgV0c8XKHCe9Dbzsh15zHbmc8ktZl09vJ+GObtDQGFL4DhEIFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794799393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Cm5GrRxEOaFEGOlFSwgeRZSGDeJjCS0iPY+gxrVdJlA=;
	b=QYazwHyHNZsyLZuYeoDm/KCeWbthWRZnlJf7o79z1IUiibCyqnwxKlDrcUq0UP30XEVh
	 W1Ay4oMJ7xybYLqz8Ki3QV0oWg4q7nnTLof58INi+yGrDSwt5KyEp4zC47VOwyNXce5xu
	 hJr7kogl5cUAV5nrZTc8vSs+zBN70v/CnpHhfPT8D/IfsuQ+JSNtqQau0KgLA1bvJfX3n
	 4Aatqau8AliGqEOdz3JiTB6SaJHuB/KBcyQdY1Qb8san/0D2KWGLmkUzUC0EihKiDBlQP
	 E4bX7fLSFF7OzV5xVIxX5Nb9rh4SwNIxvlyC5tmXkpg2sQe8LF/ojG95tpDLo4Kbv0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794799393;
	bh=Cm5GrRxEOaFEGOlFSwgeRZSGDeJjCS0iPY+gxrVdJlA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HbNbJ152b31nCuHZWiy8YeMN4fbxkBt/eQY2poxr0Z11VuH56/neWxCK0skuGTDXc
	 hBv7j9EX7nMPgKEDv2GN7V/qR8QMmQYH8zOJkwV9ZDKM8zCAMpb0/L/T2YiLs+4Fw+
	 kCZ6yM6Opu5Hizgk51lVA3WlJHcarpXn+3Y+/2tBfiDYpNcG9eouDkRNyxn8I+cBaB
	 rSMeV4xudt6Y8XB72iQCxa+xIyvOmDO6JFXLfSPok80fJA59Lw2qEHX7FLWkUXiX3c
	 xehdVSYOaGOjbO0jgLOqOwtyTM+rEWrDAFL8MgCIHTLVB4wml87779StpJhcY02VZE
	 UjckWLyK1/L3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F263B8085F;
	Mon, 16 Nov 2026 03:23:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12E56D7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0CEA04008B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:23:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mhzC1k-NZDgD for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 03:23:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 91F5F40012
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+usb@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=eTIzKr3x
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91F5F40012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:23:09 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSY8n3c2YzMltT;
 Mon, 16 Nov 2026 04:23:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794799385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cm5GrRxEOaFEGOlFSwgeRZSGDeJjCS0iPY+gxrVdJlA=;
 b=eTIzKr3x+sVCXVo/W0suigNFCHMR5it8ZS8ASl30ySBtPwJJ/L6h0Fls6aioKzGuMmZrCN
 5dWpdKZPGrcMdPHbgPYif5y5/bEun0PPdlwXB6RqHmqqa9Xecd/lHPnodU3TjATNmdbizx
 cEwFzGrObqj/tJxJH9jb024XWxyb4NTZ9aJikG2I4uj8IK34Cq2XAPIdqbx/WP8PxrnArC
 SHTL8IjcLogwRT9mkIkeDtuwB3Cq7+d+gLF/XHgmz65XZo8mxdDbaCf3xWB/4OnJEVXGOW
 OPhlwUQHUvY4GShJhCEyN06p2ArqJDJlBXsNgWnkBtc7cQQ9O6zDmMKQqBz+3A==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, khaliforce <kforce@gmail.com>
Subject: [PULL] u-boot-usb/main
Date: Mon, 16 Nov 2026 04:22:25 +0100
Message-ID: <20261116032257.3144430-1-marek.vasut+usb@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a9673fb916f1216f1b3
X-MBO-RS-META: cmdbbcogwtaq8dkgssbgmuibow6qw771
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 6487c50b8a40f2668ab98a892b9300ad5c181f38:

  .gitlab-ci.yml: remove Simon's lab from CI (2026-11-13 09:09:28 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main

for you to fetch changes up to 224a453538eb93292f7e2fae1db4962a86829d4d:

  usb: ehci-vf: enable the vbus supply of the port (2026-11-16 01:42:50 +0100)

----------------------------------------------------------------
Mehmet Fide (9):
      fdtdec: match an alias to its stem only when the number follows it
      usb: ehci-vf: take the controller index from the device tree
      usb: ehci-vf: remove the code path for a build without DM_USB
      usb: ehci-vf: drop the empty bind hook
      usb: ehci-vf: use usb_get_dr_mode()
      usb: ehci-vf: request the ID detect gpio through the device
      usb: ehci-vf: take the register bases from the device tree
      usb: ehci-vf: sort the includes
      usb: ehci-vf: enable the vbus supply of the port

khaliforce (1):
      usb: stop generic OHCI and EHCI at OS handoff

 drivers/usb/host/ehci-generic.c |   2 +-
 drivers/usb/host/ehci-vf.c      | 322 ++++++++++++++++++++--------------------
 drivers/usb/host/ohci-generic.c |   3 +-
 lib/fdtdec.c                    |  43 ++++--
 test/dm/fdtdec.c                |  35 +++++
 5 files changed, 232 insertions(+), 173 deletions(-)
