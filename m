Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEDECDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 09:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E1B8744E;
	Fri, 20 Oct 2023 11:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697792669;
	bh=T4vVtn3psVkL2GJ724fl+SQaF6fHSrQkuXCtLZ2eUzw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BeqrXN49l+nwCqg2oZfp4rAxfsuUV0GmGhBX95o+MGkTGJ1DD37KQU/WpaqKyyswG
	 Fm9g01+TVTbUxgtHYvfjDQAgaIrifB0NFrkVkJjL8Jx6Gfy/gY9V6kHLDyE0V/wg7E
	 ALjRvX25YH6EgGJPxI/5B9JNdYDIQy1gkagO/DJ/mPdYToV68Z+FbEL7fAAfL/C1FM
	 /4X/Cr8bj5StUUrhVFnpxP90H2INq+vt1IVOUmA2YCGibbE+P3Eh44eAASTGbyuSCO
	 2yAILwGbMRBfu1TT8bR+MwEDuTgi1AH9908Ju+vXym25ERwLlanIFkEh4uTGykwU+U
	 NYYQw69tZ501w==
Received: from localhost (lfbn-poi-1-1121-43.w83-200.abo.wanadoo.fr
 [83.200.224.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F117C86FD9;
 Fri, 20 Oct 2023 11:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697792666;
 bh=T4vVtn3psVkL2GJ724fl+SQaF6fHSrQkuXCtLZ2eUzw=;
 h=From:To:Cc:Subject:Date:From;
 b=hTL8h1xNtgegkZEv2DahvKPD9gQq04KqCnhB/0wUh6CYHnrnaog7Fg2c0zS+2RnUv
 IgV0zfDTAIRy2h0Vs2vQwFzjudxukfms8NiuLpabHi2+bL+ksgnKaqB0+nAkBYTUEU
 pYh49R5sa/7SZux/aJwCqjQannAEWJr+sZ9U/V0BzWdcB74kn8c2fMJBciRbUOBeea
 Eiiv1IjX40IvwozvcPt+5Q1rZz806TpKsAb5OxZmSIuy6EZHjadpxLaH3cZ1/3i5NT
 vRjHZ63Un8KEJEOCq1OszXB6QJsg0/zxmOGhB0wlMdktnVPUtMmVz435FGUaZ00gkL
 SgI/mUmqCVxtA==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH v2 0/3] bootcount: Replace I2C legacy implementation by driver
 model
Date: Fri, 20 Oct 2023 11:02:24 +0200
Message-ID: <20231020090227.16634-1-pro@denx.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The generic I2C bootcounter driver does not yet adhere to driver model.
This patchset intends to replace the legacy implementation.

There are currently no upstream boards using the driver, so it should be
safe to just remove it. For downstream users it should be straighforward to
switch to the new implementation.


Changes in v2:
- Improved device tree handling by replacing address property with phandle
- Addition of a generic i2c helper function

In v1 there has been some discussion on how to smoothly bind and probe the i2c
device. The hereby proposed solution may not fullfill all the requirements
stated there, but it is the only variant I actually got to work. Furthermore it
is not as concise as I would have liked it to be. Ideas on how to improve it
are welcome :)


Philip Richard Oberfichtner (3):
  bootcount: Remove legacy I2C driver
  i2c: Implement i2c_get_chip_by_phandle()
  bootcount: Add driver model I2C driver

 drivers/bootcount/Kconfig            |  34 ++++-----
 drivers/bootcount/Makefile           |   2 +-
 drivers/bootcount/bootcount_dm_i2c.c | 103 +++++++++++++++++++++++++++
 drivers/bootcount/bootcount_i2c.c    |  43 -----------
 drivers/i2c/i2c-uclass.c             |  75 +++++++++++++++++++
 include/i2c.h                        |  12 ++++
 6 files changed, 204 insertions(+), 65 deletions(-)
 create mode 100644 drivers/bootcount/bootcount_dm_i2c.c
 delete mode 100644 drivers/bootcount/bootcount_i2c.c

-- 
2.42.0

