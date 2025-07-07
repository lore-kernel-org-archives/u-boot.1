Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2734FC8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 13:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6ABA830E4;
	Mon,  7 Jul 2025 15:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="pWw9NuFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A32830CA; Mon,  7 Jul 2025 15:06:57 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1381C8317B
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1751893615; x=1752152815;
 bh=quVM3K3D6UTI86D17uWBBRcUundGhq3v/8TDt3O/eNQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=pWw9NuFGQCmnNx5kfgdIQAAQF4cUmuFFi29LjQjFlng0Jp55RiN8iUTIFYl6ErMQb
 y7I7HNT0/sOA2rIndpNh6ryaq0QSd4gTecSJ/om8qpKWvOB450I7SKZ22bTsvmRHAm
 I2RkmbOZ/MtlwPnN3d96PDmW6lzcKGkj6eiAP58nITyPewIWyrw+7N0GcvBumBz8pE
 bO73XnHCRwKRTWMDXR84VDFDsG+wYZz4GT2CT4zD0hlhetc5M5SkMFR9uNjc7igaYt
 Md2x9aS5VO/zSz4GhOyMnb7yjB0JAYI9fVFy3qUVPRbhkAE4fQzfIYqxGP0lGcHeNT
 vpRziuSpzHprQ==
Date: Mon, 07 Jul 2025 13:06:50 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 4/4] README: remove obsolete note
Message-ID: <20250707150438.3016690-5-philip@philipmolloy.com>
In-Reply-To: <20250707150438.3016690-1-philip@philipmolloy.com>
References: <20250707150438.3016690-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 14d410279c2edca2ae995f537dd2e28ea2a0a0d2
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

Renaming SPL to XPL fixes the issue referenced in this note so the note
is no longer necessary

Fixes: 1d6132e2a2b ("global: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUI=
LD")

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---
 README | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/README b/README
index 40326ef3547..365ad33648d 100644
--- a/README
+++ b/README
@@ -1403,10 +1403,6 @@ Low Level (hardware related) configuration options:
 =09=09VPL. Code that needs phase-specific behaviour can check this,
 =09=09or (where possible) use xpl_phase() instead.
=20
-=09=09Note that CONFIG_XPL_BUILD *is* always defined when either
-=09=09of CONFIG_TPL_BUILD / CONFIG_VPL_BUILD is defined. This can be
-=09=09counter-intuitive and should perhaps be changed.
-
 - CONFIG_TPL_BUILD
 =09=09Set when the currently running compilation is for an artifact
 =09=09that will end up in the TPL build (as opposed to SPL, VPL or
--=20
2.50.0


