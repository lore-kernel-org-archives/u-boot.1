Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3478CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D18839B9;
	Mon, 27 Oct 2025 18:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ABaakPYx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Upe3UW4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3509839D7; Mon, 27 Oct 2025 18:08:47 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD8988393C
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwKj94mc1z9sqN;
 Mon, 27 Oct 2025 18:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cWdsUdTjePKFaLIx4cgGT8FdFtFSuLh4P04J02uZDRs=;
 b=ABaakPYxvhryURXxJeNWpvDZmKHB3BKAK/etxcs/Go+QMJZZ/+djE6TZDdplj19uatZwQI
 2hs7LB/8TlOoy78PPRVy0sMtFZnaY5fTdLLEF/liTUJ/ouSp+ROggONjF0KYfcLiav15qz
 2IKABGW4gdGNW7s+R+f1SZrYzRbRzEkJHT0YVQeWo6GLWQl3/xrCEPpxonw2KQm+tnVpHm
 YDHqst7Zs4/8P0pwzCB3Ijl/XjZfXOBoHUljh312bMexHgF4Ja0rl6nxZgmUUwT2TeJf/Z
 0WrhfFVX4RavyLV35ZSkeiqJSW4kp4wPPcVk7sgfJqmTONEQkEGoCzHao00nqw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Upe3UW4x;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cWdsUdTjePKFaLIx4cgGT8FdFtFSuLh4P04J02uZDRs=;
 b=Upe3UW4x8s7JZq9aHEUBypzaAZJ7o5uh622pVubKk6weaD4YHl636JAp3AD83irRa9csdT
 6FW0a3+OMk+J8zhLBi2YF8VGV1lyRZGK8Ztn3kyo/eUaFHlYSF2MXQJAD1kL465tN/CEB+
 Sy4MNE0wYgMmdgUL38/E4eRuN6jXFKEphLKmcQeP0JXi9kJJ6RHNht6WlLwXobBIzh9TR3
 7G1WUyo4TthndKvnixMkogAUHsZzLiwjL09XlihRWSuNjm/OZDHFZSMaUdqu13Pkg1JeVo
 KtHGQBAZggK7YjOPfaJg7oubJiEZuf4538+v8hiQnMlsNC5WFkmjUlVeQ9djDA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Drop encoded file name from R-Car Gen3/Gen4
 header
Date: Mon, 27 Oct 2025 18:08:33 +0100
Message-ID: <20251027170840.29445-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dbf4404b7911462c317
X-MBO-RS-META: cuz3h3ir3r5mow71sg7m1kpiu4p8tcxn
X-Rspamd-Queue-Id: 4cwKj94mc1z9sqN
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

Checkpatch warns that it's generally not useful to have
the filename in the file. The warning is valid, drop the
encoded file name. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/include/mach/rcar-gen3-base.h | 2 --
 arch/arm/mach-renesas/include/mach/rcar-gen4-base.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
index 0b1fd017f04..741fb8b7041 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * ./arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
- *
  * Copyright (C) 2015 Renesas Electronics Corporation
  */
 
diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
index f34473db35a..403054e4a7e 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * ./arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
- *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-- 
2.51.0

