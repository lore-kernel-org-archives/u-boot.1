Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0CAFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 10:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D3A84841;
	Wed, 29 Apr 2026 12:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="WdzdQeLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669A484713; Wed, 29 Apr 2026 12:35:16 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 460E184713
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 12:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g5DG867tzzDR5;
 Wed, 29 Apr 2026 12:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777458912;
 bh=u8LPM1pFf6ya+h/qlsXQ0F0FSNA10nWkrZ4SU/DJlf4=;
 h=From:Subject:Date:To:Cc:From;
 b=WdzdQeLIYZXEFE0DMMUJSm4ZpMnTGI3fvwR5N4cAPE9Hf1zMmV2I3oHVdGo+4tPgi
 fIAOifFCikOkM3XfDoGzwqCtxYw+Yw5BQ7tGaYrXfdS/dHhP+rlJqe42d/shTouzdF
 UbLz8fDBzRwm9+R/KrQzY6lrFFkj86n+urT47i0CPLCWzXw3k/DudJOXfagSx3/qSq
 p3+RqFLcT14oQkD8a1tmHOcH9mfCz017nScHArSg7glx/XCCIVKEUm4lGkV5SgJ+pF
 HzAhl1ujeoMKdMSQvfkYGpLrekFO6GhNCpkmoFP3Qi2vStRamn577JDkxz3FrodhN2
 MWsB9bZ2vW5jQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g5DG70DfBzXK3; Wed, 29 Apr 2026 12:35:10 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH RFC next 0/5] net: guard SYS_RX_ETH_BUFFER with NET +
 required changes (ls1028a!) to make this happen
Date: Wed, 29 Apr 2026 12:35:00 +0200
Message-Id: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAvxL2bGAbiohXwQd4FQlpurHxsJXdV
 CKlfzfqcRhmVlCSTApHs4LQK2ueuUG3MxCnwHeyeWwMDt0ee3ew+lYv1VOZ/LCkRGJ5tkzFYoh
 dGh1inwK0/CmUcv2tr3A5nwxTLXD7G12GB8XyPcO2fQDqNO9/hgAAAA==
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
 net/Kconfig                      |  5 +++--
 6 files changed, 29 insertions(+), 23 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-sys_rx_eth_buffer-no-net-0ac1fd2004fa

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

