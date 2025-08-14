Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99570CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 11:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1FE6838C7;
	Thu, 14 Aug 2025 13:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="aReXeSHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AE3838CC; Thu, 14 Aug 2025 13:55:47 +0200 (CEST)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02496838C5
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 13:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail3; t=1755172544; x=1755431744;
 bh=tWSxkTyu9g8EZMr2V8Lff+mw+9WqhJedNO8MnpXGn7Y=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aReXeSHPkpnUw7chJRv6X2hZTNP0cDXR1iF5DgdA/HGVFAHF/Xw5pfQf+YcY53iDo
 l3AqnZc1rWSIGpgWpio+6V7qoJYizplNO7HigFGKs+5Yz3iaclNNev5OUhKiA3UEwS
 y9MB7ADQ1Zkjot+69g+X1FVu8xvRcWhO4d06ZZcIOs6HVwHrKhfVUOl4iwY9dI2fwk
 qi31BokEZBC+lKHgngPVgwJmuMx4Vs01ESZcefjYQh647uNO2AE+zbe2g6FlzhjwZL
 VTvyOkVy14dA9xKDuQnQYOQbs16HrMzqnIwOkaazA3UnAsM5pbPomTae6lG9JYuvh4
 j5DdNOIW+YbMg==
Date: Thu, 14 Aug 2025 11:55:36 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 adsp-linux@analog.com
Subject: [PATCH] mach-sc5xx: generate U-Boot proper in ADI ldr format
Message-ID: <20250814135456.2496908-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 31e082ec649f5aeff2701a63cd425b61662d2682
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

Generating an ldr boot stream containing U-Boot Proper was as never
added to U-Boot because it is done by the ADI Yocto layer. Add it to
U-Boot to support projects that do not use that layer.

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---
 arch/arm/mach-sc5xx/config.mk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sc5xx/config.mk b/arch/arm/mach-sc5xx/config.mk
index e7e4c9a1181..266d2e3a777 100644
--- a/arch/arm/mach-sc5xx/config.mk
+++ b/arch/arm/mach-sc5xx/config.mk
@@ -12,5 +12,7 @@ ifdef CONFIG_XPL_BUILD
 INPUTS-y +=3D $(obj)/u-boot-spl.ldr
 endif
=20
+INPUTS-y +=3D u-boot.ldr
+
 LDR_FLAGS +=3D --bcode=3D$(CONFIG_SC_BOOT_MODE)
 LDR_FLAGS +=3D --use-vmas
--=20
2.50.1


