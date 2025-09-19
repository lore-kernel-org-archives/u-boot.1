Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B054CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 13:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E1128329B;
	Fri, 19 Sep 2025 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE008331F; Fri, 19 Sep 2025 15:43:25 +0200 (CEST)
Received: from xe-s-netms01z.xe.abb.com (inet10.abb.com [138.225.1.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C477A83071
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 15:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms01z.xe.abb.com (Postfix) with ESMTPS id 53CED40D773;
 Fri, 19 Sep 2025 15:43:23 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025091915432227-26778 ;
 Fri, 19 Sep 2025 15:43:22 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025091915432291-12527 ;
 Fri, 19 Sep 2025 15:43:22 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Michal Simek" <michal.simek@amd.com>, "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 1/3] configs: brcp1: Drop CONFIG_SUPPORT_PASSING_ATAGS
Date: Fri, 19 Sep 2025 15:43:00 +0200
Message-ID: <20250919134308.122437-2-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919134308.122437-1-wolfgang.wallner@br-automation.com>
References: <20250919134308.122437-1-wolfgang.wallner@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 09/19/2025 03:43:22 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 09/19/2025 03:43:23 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 09/19/2025 03:43:22 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 09/19/2025 03:43:22 PM,
 Serialize complete at 09/19/2025 03:43:22 PM
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

CONFIG=5FSUPPORT=5FPASSING=5FATAGS is not needed for these boards.

Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>

---

 configs/brcp1=5F1r=5Fdefconfig        | 2 --
 configs/brcp1=5F1r=5Fswitch=5Fdefconfig | 2 --
 configs/brcp1=5F2r=5Fdefconfig        | 2 --
 3 files changed, 6 deletions(-)

diff --git a/configs/brcp1=5F1r=5Fdefconfig b/configs/brcp1=5F1r=5Fdefconfig
index 684800228ef..568313d4860 100644
--- a/configs/brcp1=5F1r=5Fdefconfig
+++ b/configs/brcp1=5F1r=5Fdefconfig
@@ -3,8 +3,6 @@ CONFIG=5FSYS=5FVENDOR=3D"BuR"
 CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
 CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
 CONFIG=5FARCH=5FZYNQ=3Dy
-CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
-CONFIG=5FINITRD=5FTAG=3Dy
 CONFIG=5FTEXT=5FBASE=3D0x4000000
 CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
 CONFIG=5FSPL=5FGPIO=3Dy
diff --git a/configs/brcp1=5F1r=5Fswitch=5Fdefconfig b/configs/brcp1=5F1r=
=5Fswitch=5Fdefconfig
index 9b45961ef8e..805de796df6 100644
--- a/configs/brcp1=5F1r=5Fswitch=5Fdefconfig
+++ b/configs/brcp1=5F1r=5Fswitch=5Fdefconfig
@@ -3,8 +3,6 @@ CONFIG=5FSYS=5FVENDOR=3D"BuR"
 CONFIG=5FSYS=5FCONFIG=5FNAME=3D"brzynq"
 CONFIG=5FSYS=5FL2CACHE=5FOFF=3Dy
 CONFIG=5FARCH=5FZYNQ=3Dy
-CONFIG=5FSUPPORT=5FPASSING=5FATAGS=3Dy
-CONFIG=5FINITRD=5FTAG=3Dy
 CONFIG=5FTEXT=5FBASE=3D0x4000000
 CONFIG=5FSYS=5FMALLOC=5FF=5FLEN=3D0x1000
 CONFIG=5FSPL=5FGPIO=3Dy
diff --git a/configs/brcp1=5F2r=5Fdefconfig b/configs/brcp1=5F2r=5Fdefconfig
index 357eef38601..e92d8381bbb 100644
--- a/configs/brcp1=5F2r=5Fdefconfig
+++ b/configs/brcp1=5F2r=5Fdefconfig
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

