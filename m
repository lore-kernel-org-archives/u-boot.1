Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A1606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vZ1HXNCB;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=s8yXN5/1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5552360642;
	Sat, 21 Nov 2026 17:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iT50gtnj6dov; Sat, 21 Nov 2026 17:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6540360672
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795281366;
	b=HzTIo3RvcIqDVVBJXQrHrfCWevKseObAl8A+uA4NWmm8v3NGI+gT3ZVicRMYtv1sEMSL
	 ck+8oGvHnirFxjmoohgVW0FKq7EiLwKr1fESHG1GwnEmU58j0CVdwBvob4JV1YSX/NmDm
	 YD4Vu8g3zLuuu6HUA2KAbQ7iFo1n+MvVHJxbljLBD1DODAUsDguTdu8Kqp8Umsh/woQmg
	 +MrWtRr63KTxldFYXGHBauE/vUZZI2TW3sva3pb1SEGI+nAWN9F5KokbRZg7VZclTLr2h
	 JQ0ZrLZw9CStUm5iSgW2BD+bjW/xFpNbAIzT7x32mMLOUyopLO56sFiC55UobyUuxlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795281366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FuQB1AE2PiWY5BLcmzJIn6AVrw2Q8lZVD8IwdH10rxc=;
	b=YiJA7DysI768i/n9kcMyxOdYOBv4bVLpyv97hg1hD+NTPf2COh36qTnH2iXGlIJ3ow8T
	 HSELxRD41mOiNPvL9zCm0fZPdGP+Xdm2vkPpz5uNT9Kv8su2WlwH/ujlCh9+NnuaFi+cg
	 V7DrCVS3Ec0r7QzURHi3OvjgoEGVuJOkn4GZVBP3cX6kaDQKTvFXpMxKQ7rmzHCowssuW
	 RM1jAWaIVJxPrF0MuXTH3H+lDZQq22YZBsf4Tt/E9toTNcsH6OeU7yrlwp6UcQxw/7UKt
	 T+MKN7la5/iWLyCYPN5vl/SwH/z1Zrx+bd7SFzdE2MmM9T9RANlwIMIw1Oyi/Er9M+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795281366;
	bh=FuQB1AE2PiWY5BLcmzJIn6AVrw2Q8lZVD8IwdH10rxc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vZ1HXNCB4CFtFBuC6fE5DTD5avt1uI0xt0NC/dAy/7YF7gIEiLFLhO23cHMWpC5Xf
	 ZgndBNhOBQuKAiDAfuv/tI+Gv1hcUNcnQ6cqNBsR1DovM69OkKbB16XF/hS2Fp2y0D
	 mg/f/EHX62sY7E0CKhYOPDzbdg5A6AArWrViI6FtHBkVON5CNRjtsN+1iXb8VHg/8Y
	 HaONksj+4BrWKJyuJHIMElMwxnIowxgJjUxKpuTrYERopQyVO1cCc634lWfpHbncOg
	 NlMF/35UJGsyKXzMfTzl9MBmLRMr0Kzmk7Ip210bvbvBAZq/45K9bdrfh2huXzeoub
	 vU9qGaeDcIhgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6540360672;
	Sat, 21 Nov 2026 17:16:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 359DE260
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BC4A40081
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EDPh9CyNt4LQ for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 17:16:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AB75140012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=s8yXN5/1
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB75140012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 17:16:03 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jWzPV5c5GzMlnn;
 Sat, 21 Nov 2026 18:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795281358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FuQB1AE2PiWY5BLcmzJIn6AVrw2Q8lZVD8IwdH10rxc=;
 b=s8yXN5/16Va4W6GLJlgolmLvRkxiIfACcfuNhLeAuaB9uYgjtaPqYEu9wH8E1nfQFVze31
 H9pUmtqCWYEHyUInP0a4mnpbAWhtEwQxv3RuTSM/i4KmMHK+5isP/RT0yJJF7ynB0CuiN1
 tOtGGO5UCsh6wQLMwZNPsR2wfaENAakWAsh1j1/MvI8lA8itnpsb0WaoSBOzWOoFPaesbc
 blePwM2/TLjrdGcUFFaPLWuz6IxKPOMXmsZs68PPW9iDu3TOkop3wJTWyWZvgwcgZYhor7
 1SyM9us28NMp0VdmzLAXG8wXQwEPzIyhWjrFv6BSp1LL/NXECh8O6G29va7cgA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/main
Date: Sat, 21 Nov 2026 18:15:29 +0100
Message-ID: <20261121171549.948391-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ea0ae93202e78cbe5b9
X-MBO-RS-META: 6d6ut5i3r3efbcjr4znpdo44ntxshmkb
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit c1958b5f6cce03956d309ce422b5d9f819955d4a:

  lmb: Check available space below the allocation limit (2026-11-19 09:44:39 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to 4726f0adcd0847b960a99ebf0c008c0ea4d85577:

  doc: board: renesas: Document Renesas R-Car Gen4 Cortex-A76 start (2026-11-20 09:01:02 +0100)

----------------------------------------------------------------
Marek Vasut (6):
      pci: pcie-rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes
      remoteproc: renesas: Set valid Cortex-R52 BAR flags only in .start callback
      doc: board: renesas: Document Renesas R-Car Gen4 Cortex-R52 start
      remoteproc: renesas: Rename Cortex-R52 specific functions
      remoteproc: renesas: Add Cortex-A76 management suppport
      doc: board: renesas: Document Renesas R-Car Gen4 Cortex-A76 start

 doc/board/renesas/rcar-gen4-sparrow-hawk.rst | 438 +++++++++++++++++++++++++++
 drivers/pci/pci-rcar-gen4.c                  | 111 +++++++
 drivers/remoteproc/renesas_apmu.c            | 371 +++++++++++++++++++----
 3 files changed, 866 insertions(+), 54 deletions(-)
