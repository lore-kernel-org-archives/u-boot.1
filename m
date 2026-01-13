Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636C4D2F32A
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 15:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDFC800AE;
	Tue, 13 Jan 2026 16:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Po0jQMQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9AA80B98; Tue, 13 Jan 2026 16:16:24 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38DE800AE
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 16:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 936EC6000A;
 Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ABB8C116C6;
 Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768317381;
 bh=rY4/JV3DaI9fBaAujMH30v69WA47tqdcDAHu7tVKel8=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Po0jQMQO6DPRkQudN2fxuMoTTxMgaUniYkH7caEUV58TYeN5qpATLls7P183wt9NY
 NWB5dDDDjq/o9SucqjzoEORAAeq4WPfh8Mgtrjc98/HjV2jDYkPOi0V8mkPjElNdQt
 zx2pcd+0kPBA4YSCBa0+IRcnqfb7P6h5RVDrglMtK0Oniq7HXcBfkR4tz+g7TF49c+
 XTQXGAabyPnB0JsSxwkqi3QK78Jp4sVKWQvLPBfy/Rv1miGCvCvOeGm7PlpkGm9cPA
 Uj/coTAYj+WaP277zFsZk61WMtVkRCoTu4gU6JdUAVsSlhJmA35uWScmNe5CXU3xpn
 0Mt9UHRcB51Lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC3AD2F32B;
 Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/2] net: dwmac_meson8b: Fix incorrect ETH0 register
 assignment
Date: Tue, 13 Jan 2026 23:16:14 +0800
Message-Id: <20260113-aml_eth-v1-0-3dd74db37c4f@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL5hZmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Nj3cTcnPjUkgzdNAPT1DTz5DRzAwMzJaDqgqLUtMwKsEnRSkFuzkq
 xtbUAeZIjgF4AAAA=
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768317381; l=720;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rY4/JV3DaI9fBaAujMH30v69WA47tqdcDAHu7tVKel8=;
 b=ElkdPBF9JYECe41/gCUZ8cqRaN2eiEfTr+wH2wZXkhsZhsmUcaVXh6Lz5PUb1yLAuU9hczS3V
 gnlw3/81b3VC5ncOJ+MPIOXTRLF5Wo1XGXUfTlgVP0l8almpfh+DAr7
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The currnet logic for setting ETH0 reg seems broken. It does not conform
to the datasheet and the Linux driver code.

Fix two bugs here:
1. replace setbits() with clrsetbits()
2. set tx radio to 2 rather than 4.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (2):
      net: dwmac_meson8b: replace setbits() with clrsetbits()
      net: dwmac_meson8b: Fix incorrect clock divider setting

 drivers/net/dwmac_meson8b.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)
---
base-commit: 711150fc6fe7a125cc1133841acc802570478007
change-id: 20260113-aml_eth-f05ef7cf7006

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


