Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F45CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F01E83849;
	Mon, 20 Oct 2025 19:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="odTWcrH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F8D82E34; Mon, 20 Oct 2025 18:24:35 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B6D683631
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E0C9144795;
 Mon, 20 Oct 2025 16:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB5F9C4CEFE;
 Mon, 20 Oct 2025 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760977469;
 bh=rRdl5D5O+xYI2mdluE1GksWK6UhkW/zDEvGtV5sZRtM=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=odTWcrH6RwfC4YiZ5+Zli3q/WE+ENT3hzlYWi3ct/P5FkHHRAdbeGlT+6NAN+cXgW
 m9kWvu+tiHLXhcDpeW4umuhn02YxwQTiGzScf3+Y49Bo/mgVzsvO/vKmS7U17TcWKS
 xZXeDL/OH8jfqSbAHvHortI/UYOyzrUSf/i1cKFgZajl1BT1WGe4yUEiaCKBNeXNUH
 UpD2V7XCHIbexDsQVJZbW/d82UL3Q4ca/FApennA6mebtnC5XGhc5IuoULa5LdpuTq
 H+jKvAF1TUf6ZPEnbqnuhgSouuJxG77IHAKHd+ju+pAr7vxSZNKFAFqGioHMtm9cUl
 x8d1Ky6P5GFxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD9CCD19F;
 Mon, 20 Oct 2025 16:24:29 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Subject: [PATCH 0/2] Minor fixes for QCOM sc7180 soc
Date: Tue, 21 Oct 2025 00:23:57 +0800
Message-Id: <20251021-sc7180-minor-v1-0-9fe33c73365e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1i9mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMD3eJkc0MLA93czLz8Il0zixRLkxRjA2MzgyQloJaCotS0zAqwcdG
 xtbUAXPf2sF4AAAA=
To: u-boot@lists.denx.de
Cc: George Chan <gchan9527@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760977468; l=563;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=rRdl5D5O+xYI2mdluE1GksWK6UhkW/zDEvGtV5sZRtM=;
 b=1q2xIX2oLSymu9aIW2grcn34H+h/ufE3gf4st2oLlkEzBBFmJLi7otqh9sG/DGtH9KHE2YUOK
 dVeDEpgtcLRBNSMfPyzfIXW/khw+3l58DsHR/zo+3K+vqvizMDnvBK7
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 20 Oct 2025 19:17:28 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Exclusively 2 minor patches for sc7180 splited from another series.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
George Chan (2):
      iommu: qcom-smmu: Introduce sc7180 compatible string
      usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM

 drivers/iommu/qcom-hyp-smmu.c | 1 +
 drivers/usb/gadget/Kconfig    | 2 ++
 2 files changed, 3 insertions(+)
---
base-commit: 4e4a9de31de2a5f395ee25c59e4026422fbcb27e
change-id: 20251020-sc7180-minor-68d94d30360b

Best regards,
-- 
George Chan <gchan9527@gmail.com>


