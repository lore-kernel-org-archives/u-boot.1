Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C4CEC8735
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 14:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C6E86863;
	Thu,  7 Sep 2023 16:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="IXlThFju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5946E86722; Thu,  7 Sep 2023 16:52:13 +0200 (CEST)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C16D7869BB
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rknecht@pm.me
Date: Thu, 07 Sep 2023 14:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1694098330; x=1694357530;
 bh=5CWWP35BmimW6WoR1W5gAN/7Ma861C9v4GskAfnbKFM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=IXlThFjua/aLe0zIV+eUcyYzoeuKjGrH7njt+tB6I5/unP0iZAQWrCtlq2sXZlc3d
 2jZUGQX/QMkl/05Dr1V0IS2teXFB3PejTsMf+BK2ZAiV4eztNJ2SEe1iR4IGNP0B6y
 tgmG/kODWqgzsPw/oUI/XqWNBpC4fu76rkwCV48LoDVFRzU+6Sm+gRFtIdxOxpqlgZ
 RXLUXyabY2oRv+O1ZieOmCHPLYiLmdPHRGQq7Rr5Yc4/Kq+RtsW1dnGbSKpKClPBTP
 mhymuBMcwnjZjA5Tj3bAEcB2gvgPKDPa6DXmlwVF3WfyzSIHOU4i7VezJglyTVh7NR
 OUNGmDZM0J8CA==
To: u-boot@lists.denx.de
From: Roger Knecht <rknecht@pm.me>
Cc: Simon Glass <sjg@chromium.org>, Roger Knecht <rknecht@pm.me>
Subject: [PATCH] cmd: xxd: move xxd into shell commands
Message-ID: <20230907144950.653-1-rknecht@pm.me>
Feedback-ID: 8957232:user:proton
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

Move xxd into shell command section.

Signed-off-by: Roger Knecht <rknecht@pm.me>
---
 cmd/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43ca10f69c..51706e1d39 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -500,11 +500,6 @@ config CMD_XIMG
 =09help
 =09  Extract a part of a multi-image.
=20
-config CMD_XXD
-=09bool "xxd"
-=09help
-=09  Print file as hexdump to standard output
-
 config CMD_SPL
 =09bool "spl export - Export boot information for Falcon boot"
 =09depends on SPL
@@ -1666,6 +1661,11 @@ config CMD_SETEXPR_FMT
 =09  Evaluate format string expression and store result in an environment
 =09    variable.
=20
+config CMD_XXD
+=09bool "xxd"
+=09help
+=09  Print file as hexdump to standard output
+
 endmenu
=20
 menu "Android support commands"
--=20
2.39.2


