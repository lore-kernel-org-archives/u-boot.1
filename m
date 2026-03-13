Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF954107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA0684358;
	Fri, 13 Mar 2026 22:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iA3yE0ID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E737684358; Fri, 13 Mar 2026 22:00:16 +0100 (CET)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F49883DA7
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-56adf76631cso982985e0c.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773435613; x=1774040413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aQmCgT6z2qTUn/L4kOJMAylm63Qvr8ZCWO/zX+W0zF4=;
 b=iA3yE0IDmANJ3uj/wQB81sjd37tfSqTHpN7/t0YKRGRAEVABu19H7m610mesndOX04
 mw3U/RGW4+P7Td0Er/X09sUVqSnOTnfW0piccKBXlAigjQMEJrFHcUvyFkpaa6MtKbot
 PlTE6Hrjg82Kq1uCzG5NqBnGJfWMQDVvy9GIqA/1zNVA9sTwaHzTwp8oQSNCt+8m5VTh
 2uRh3pfXAVxAAaEsAiM9wWG9tuMT7MlzM5ToPCgZxoWEvlNm2W5SxNXGrbUUiYobwGwP
 QDuFAkUpC8F3Wlrskr3FLkhQQ1Azav//x0YD5QoWvphg+EJpxHJteUXisgP+RKS4Vk4e
 b16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435613; x=1774040413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQmCgT6z2qTUn/L4kOJMAylm63Qvr8ZCWO/zX+W0zF4=;
 b=DGnjwrEEZS9/sFNVfv8NI7q858tvsExzJYdPuF/MvDEceUu+cJuh/m55SoOQIDvatM
 hW4krP6a5ECA6PpM9DtIm3Fslx1O16FrVZiXYslQWsBsNiyysm8GsDJzMlVwkmqYSeCv
 eqSfMzxdDlBSD0D+XpzrDwzNAFQdw+QnSJN2yE17ZISmPuczjY0DE5QzfOa5trTk+MmS
 ltwngiP7I3tU7HwMnp5iwhlg/x199DmdSF52zZYhfQW9ALOCaUsQ/jEgnPt4UV/msSot
 K82AIgiFuWJbSC8bOqH147jCjOFFgetIO7p9WkVUU60WnjJVrWtNaLB3F6w26Ccj4Zom
 /eJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdAUZFz9dn64i0tAmtRoJ2CkkUCobgRwoQGMSfreJO3sEutlvmX8XiXFRcmwBzwhj2mQvINCQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyWI1GNHMhJmjG2+RmVVA96CsXXH6bMdkjvKws2aPwqDOmrZc8u
 pAaXa0PGqhee9XSvrmTc8Y1E40Z2RA+sKwPy73JDOJbzdzLfYwTPIAqk
X-Gm-Gg: ATEYQzxh7tDx9+DRgzG5OPWi+wsrl+xP3Lk64lGW1oEKjNm6iJskpis0hW1C+niulKV
 5bYPMqYayNxILFhziF6oQcdJi5GpfmTTp1h9pRjjzgBoO9BHmCu2Ccf7Xn6TO3CoECteHFp8w0O
 tx6Hoimz1/fbrm/bR/nwm8i6uoPn1SDRuITcFV2TbvzYnwpGvOEVkOJgI46UPuPDfJlk+z/sURr
 eH8aUBmQV/YKCGIaegwmjxp8QqyKXe58USZsqcYfz2aGkZ02USWxBzH1jGjVN02CPCJgWTcOSTV
 1Mjf1SOLKt5zB+ql9hS58IDC8w/eK3GbXLNk+nITxvZWCL++WA2DnAp0LfuDBzEXo8840E9VhRw
 2nhCbzzrHfrvzXffvaWZ1FA38O2S9GV9tM/xzLfAxK84h4c+Qk7rl7a7rB+gWCrD1Bhcemmn0vX
 Ka5i+R68LsJToPtOuZv9vtCnTZxRD9/L5RbFzjARWVeeluFMCDnIC9B31sf3bYUAUh78gPdw==
X-Received: by 2002:a05:6122:45a8:b0:567:5a54:5443 with SMTP id
 71dfb90a1353d-56b62905595mr2036712e0c.11.1773435612946; 
 Fri, 13 Mar 2026 14:00:12 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a803:148f:efd2:3409:d560:acc5])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56b4648dd38sm4466066e0c.14.2026.03.13.14.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:00:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, marex@nabladev.com,
 trini@konsulko.com, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 1/2] doc: imx95_evk: Update Arm GNU toolchain version to 14.2
Date: Fri, 13 Mar 2026 18:00:04 -0300
Message-ID: <20260313210005.781958-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Fabio Estevam <festevam@nabladev.com>

The imx-oei and imx-sm build systems defaults to:

  TC_VERSION ?= 14.2.rel1

but the documentation still instructs users to download the 13.3 toolchain.
This causes the build to fail because the expected directory name does
not exist.

Update the documentation to reference the 14.2 toolchain to match the build
system default.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 doc/board/nxp/imx95_evk.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index b8c3f4bed500..e87d7e27b618 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -60,8 +60,8 @@ branch: master
 .. code-block:: bash
 
    $ sudo apt -y install make gcc g++-multilib srecord
-   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
-   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-oei.git
    $ cd imx-oei
@@ -100,8 +100,8 @@ branch: master
 .. code-block:: bash
 
    $ sudo apt -y install make gcc g++-multilib srecord
-   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
-   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-sm.git
    $ cd imx-sm
-- 
2.43.0

