Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349DFCD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A850848A1;
	Tue,  2 Jun 2026 10:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rassv+bY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1BB284884; Tue,  2 Jun 2026 10:45:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2EAE8488F
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 10:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1885441ACC;
 Tue,  2 Jun 2026 08:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E08E8C2BCB4;
 Tue,  2 Jun 2026 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780389948;
 bh=iaRIsY33Ndd9v8P2Thk9pCPOpGrkJAVRITfOvq9GnVI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=rassv+bY3MZwWl1h72ruFvwzK4zR9REG3GjoXJszT+CQUDJDh4cpAT9o8vL6dTxuo
 JAmx5Q/ZPpXvjpPz4ZiDm5YTeDtBTd8BoySh3H2IhvwRVldyvnTnQwwCvKYrXWElQr
 Z9E4fXjm6v1a1Vian3QJ+9TSwwFCtrhML9Z7R6eBomWSJweIcx/i5FugQ9H9JyoGPL
 rE3sHLZSrP9TyGka587W7V3JOBUsevoyoFCICkExv8WhBPoFRzml7kAGl0MEuTH31l
 EP7QAi8lUL89gM/VrGdM3e2eC67haBpLn7/FR4eZy/RuPytJjNS2vdaSa35XDy6jpV
 DoO23ALB/PBxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D0125CD6E57;
 Tue,  2 Jun 2026 08:45:47 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Subject: [PATCH 0/2] Fastboot abort key support
Date: Tue, 02 Jun 2026 18:45:45 +1000
Message-Id: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBG4avErBswCYOuEi1M/2oIMlSiiO6et
 PwW7z2UEAWJ+uqhiFOShL2gqStyq90XsPhi0kobZZTm2aY8hZDZTiFm3nDDc6NMC+dM13lQSY+
 IWa5/O4zv+wGi5dQDZgAAAA==
X-Change-ID: 20260602-fastboot-abort-keyed-1064ecc677de
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780389946; l=1019;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=iaRIsY33Ndd9v8P2Thk9pCPOpGrkJAVRITfOvq9GnVI=;
 b=qh6aeuYYBLHbxvLfRsocQdbLMLlcbuCm3/5jInncObnmKqacdRIso4oi34vRyIxnNKSlvj3Mx
 8J/IR1OFRXtBYtAJFlDff2JHyiHfAzAotvi3hqCVhW3OTTmUYPj5xZi
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

UMS already offers CONFIG_CMD_UMS_ABORT_KEYED, which makes it possible
to bail out of that mode by pressing any button, rather than only
responding to ctrl-c. This is particularly useful for phones, where it's
not possible (yet... hmmmmm...) to send a ctrl-c command with the
available phone buttons.

This simple patch series introduces equivalent behaviour for fastboot,
and enables it in the qcom-phone.config fragment where it's most useful.

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (2):
      cmd: fastboot: Add keyed abort option
      board: qualcomm: phone: enable CMD_FASTBOOT_ABORT_KEYED

 board/qualcomm/qcom-phone.config | 1 +
 board/qualcomm/qcom-phone.env    | 2 +-
 cmd/Kconfig                      | 6 ++++++
 cmd/fastboot.c                   | 9 ++++++++-
 4 files changed, 16 insertions(+), 2 deletions(-)
---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260602-fastboot-abort-keyed-1064ecc677de

Best regards,
-- 
Sam Day <me@samcday.com>


