Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F4ACAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 13:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E858082C84;
	Fri, 19 Sep 2025 15:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F3C83071; Fri, 19 Sep 2025 15:43:22 +0200 (CEST)
Received: from xe-s-netms01z.xe.abb.com (inet10.abb.com [138.225.1.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7E681E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 15:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
Received: from brsmtp01.br-automation.co.at (unknown [10.43.60.20])
 by xe-s-netms01z.xe.abb.com (Postfix) with ESMTPS id 0177540D76F;
 Fri, 19 Sep 2025 15:43:19 +0200 (CEST)
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.5)
 with ESMTP id 2025091915431889-26777 ;
 Fri, 19 Sep 2025 15:43:18 +0200 
Received: from ATEGGE4852.br-automation.co.at ([10.43.64.79])
 by extmail.br-automation.com (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025091915431961-12526 ;
 Fri, 19 Sep 2025 15:43:19 +0200 
From: "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Michal Simek" <michal.simek@amd.com>, "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 0/3] Drop ATAGS for B&R boards
Date: Fri, 19 Sep 2025 15:42:59 +0200
Message-ID: <20250919134308.122437-1-wolfgang.wallner@br-automation.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Release
 14.0FP3 HF8|December 13, 2024) at 09/19/2025 03:43:19 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Release 14.0FP3 HF8|December
 13, 2024) at 09/19/2025 03:43:19 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 09/19/2025 03:43:18 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.5|June 06,
 2025) at 09/19/2025 03:43:19 PM,
 Serialize complete at 09/19/2025 03:43:19 PM
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


There was recently a discussion on which boards need ATAGS support.
The B&R boards which have this support enabled actualyl don't need it.
This patch series drops the settings from the relevant defconfigs.



Wolfgang Wallner (3):
  configs: brcp1: Drop CONFIG=5FSUPPORT=5FPASSING=5FATAGS
  configs: brcp150: Drop CONFIG=5FSUPPORT=5FPASSING=5FATAGS
  configs: brcp170: Drop CONFIG=5FSUPPORT=5FPASSING=5FATAGS

 configs/brcp150=5Fdefconfig         | 2 --
 configs/brcp170=5Fdefconfig         | 2 --
 configs/brcp1=5F1r=5Fdefconfig        | 2 --
 configs/brcp1=5F1r=5Fswitch=5Fdefconfig | 2 --
 configs/brcp1=5F2r=5Fdefconfig        | 2 --
 5 files changed, 10 deletions(-)

--=20
2.51.0

base-commit: b82fa9d752b025d3b5305b5b07debe6808a5d027
branch: us/drop=5Fatags
