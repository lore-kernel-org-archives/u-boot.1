Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E63CCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 10:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E343184A97;
	Thu,  7 May 2026 12:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="ZY1akJKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC2484A7B; Thu,  7 May 2026 12:37:21 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::bc0b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2682684A72
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gB7ws5LdLzsbD;
 Thu,  7 May 2026 12:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778150237;
 bh=d8MpPaV+Kn3qWdtLP1ChB9m2MSfxP6RcXu6ngOWc6MM=;
 h=From:Subject:Date:To:Cc:From;
 b=ZY1akJKBlQC6A5auNi272YtFpe4sUWUpiovsRlZJbaMOUqP+fv3uG/TYyRwsVDGjQ
 uILJbHDyDNYcKiQalyZ4bCMNFUCRyIUo9ZLkF0XdoJksKEEq3zxoJFWZftXnl5Sah8
 aWqrJY36ul/mM6kfLpD48+4Ch+m5PEx+jXKbtlRxlHaRJvnzQXOAijAFhRvvzmNkSj
 HKzHzWtQSp8/Cxq65XQ7fgzrmZTHHQqtDWrifLT4i0OPun+02oOFDwskVWV/0qODhG
 tWN/m4oTGaoinscFH4h7+TnJSKgndb5W1uP7szU4DKD7fxanH9Ca28oa0RobP+X9K5
 U7QY4d7q6sGyQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gB7wr1KTpzSd8; Thu,  7 May 2026 12:37:16 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH RFC next v2 0/5] net: guard SYS_RX_ETH_BUFFER with NET +
 required changes (ls1028a!) to make this happen
Date: Thu, 07 May 2026 12:37:07 +0200
Message-Id: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwQ6CMBBEf4Xs2ZpSCIonExM/wKshpJatrYdid
 guBEP5dQK8eJzNvZiZgJI8Mp2QCwt6zb8Mi1C4B43R4ovDNokFJVchcHQWPXNNQY3T1o7MWSYR
 WBIxCapPaRkmZWw0L/ia0ftiq73C7XpKAQ4Tq63D3eKGJa/OadZ5jS+P2ok834jdY/h/sUyFFV
 hZos4PGMjNn45Bo3DcI1TzPHzT5TNLcAAAA
X-Change-ID: 20260428-sys_rx_eth_buffer-no-net-0ac1fd2004fa
To: u-boot@lists.denx.de
Cc: Tang Yuantian <andy.tang@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

Adding ls1028a to the mail subject so that maybe it triggers some filter
for maintainers/reviewers of those boards.

Follow-up to the NET->NET_LEGACY rename, where CONFIG_SYS_RX_ETH_BUFFER
was discovered[1] to be in net/Kconfig but not guarded by NET.

Move a few things around such that we can guard this symbol by NET.

It'd be nice if someone could check patch 2 works as intended on the
impacted platform(s), hence the RFC (and the ls1028a! in the mail
subject).

CI passed here: https://source.denx.de/u-boot/contributors/qschulz/u-boot/-/pipelines/29934

[1] https://lore.kernel.org/u-boot/3462e9ac-e882-4145-88d2-a553cd1c3cb2@cherry.de/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- added Rb from Simon,
- reindented SYS_RX_ETH_BUFFER to start with a tab instead of spaces,
- added multiple-of-8 limitation for FSL_ENETC nin the help text,

- Link to v1: https://patch.msgid.link/20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de

---
Quentin Schulz (5):
      ls1028a: only include drivers/net/fsl_enetc.h when driver is compiled
      arm: ls102xa: use platform data to check Ethernet interface is not SGMII
      net: tsec: make tsec_private a private structure
      net: guard SYS_RX_ETH_BUFFER with NET
      net: SYS_RX_ETH_BUFFER defaults to 8 when CONFIG_FSL_ENETC=y

 arch/arm/cpu/armv7/ls102xa/fdt.c |  7 +++----
 board/nxp/ls1028a/ls1028a.c      |  2 ++
 drivers/net/tsec.c               | 17 +++++++++++++++++
 include/net-common.h             |  4 ++++
 include/tsec.h                   | 17 -----------------
 net/Kconfig                      | 21 ++++++++++++---------
 6 files changed, 38 insertions(+), 30 deletions(-)
---
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
change-id: 20260428-sys_rx_eth_buffer-no-net-0ac1fd2004fa

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

