Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D48CAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 13:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3666E832DA;
	Fri, 19 Sep 2025 15:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B4581E13; Fri, 19 Sep 2025 15:43:27 +0200 (CEST)
Received: from xe-s-netms01z.xe.abb.com (inet10.abb.com [138.225.1.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F0CA832DA
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 15:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms01z.xe.abb.com (Postfix) with ESMTPS id DA77640D77E;
 Fri, 19 Sep 2025 15:43:23 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025091915432292-26780 ;
 Fri, 19 Sep 2025 15:43:22 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025091915432364-12529 ;
 Fri, 19 Sep 2025 15:43:23 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Michal Simek" <michal.simek@amd.com>, "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 3/3] configs: brcp170: Drop CONFIG_SUPPORT_PASSING_ATAGS
Date: Fri, 19 Sep 2025 15:43:02 +0200
Message-ID: <20250919134308.122437-4-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919134308.122437-1-wolfgang.wallner@br-automation.com>
References: <20250919134308.122437-1-wolfgang.wallner@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 09/19/2025 03:43:23 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 09/19/2025 03:43:23 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 09/19/2025 03:43:22 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 09/19/2025 03:43:23 PM,
 Serialize complete at 09/19/2025 03:43:23 PM
X-TNEFEvaluated: 1
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

CONFIG=5FSUPPORT=5FPASSING=5FATAGS is not needed for this board.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---

 configs/brcp170=5Fdefconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/brcp170=5Fdefconfig b/configs/brcp170=5Fdefconfig
index 44460c510f1..f8e17ece276 100644
--- a/configs/brcp170=5Fdefconfig
+++ b/configs/brcp170=5Fdefconfig
@@ -3,8 +3,6 @@ CONFIG=5FSYS=5FVENDOR=3D"BuR"
 CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
 CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
 CONFIG=5FARCH=5FZYNQ=3Dy
-CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
-CONFIG=5FINITRD=5FTAG=3Dy
 CONFIG=5FTEXT=5FBASE=3D0x4000000
 CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
 CONFIG=5FSPL=5FGPIO=3Dy
--=20
2.51.0

