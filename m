Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78807C4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939AE87AB9;
	Wed, 10 Jan 2024 15:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704898172;
	bh=auYbq0c8NL/10dZW1uiGSyz073JQfjAdDqq4zDHpHHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VSazVrb/ej4XkdzbxAdmBFMTOzh60qvOE6Bjp51q77f5Swo3JAWTn7n+ha1sTB9V9
	 +FjzvmomwQuvjAgs5wvCQEa4k/eB1lYTuXfXjWRieQJWdh2MNRytKn6158BSgZWyIS
	 Jwqj/ut0DJn8JcVLHi+2Jval+Rc820KAboqj9RLUw8M7om0DE7KkGk20JYlrPwRxX8
	 znCNGPwTPuZEAjW6lCqK7bIdzo3SJhntXREGBRDwqr5tsZc/8bCowOD2/ZTXRfNWHS
	 VTR1F3Bp5k3UkcXco7dDoQOYNtvmsu+etOtWgc7g0hebzkh2wUCRgIR/54mou3UlUN
	 WHEpGKyfaksVQ==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3B66387906;
 Wed, 10 Jan 2024 15:49:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704898166;
 bh=auYbq0c8NL/10dZW1uiGSyz073JQfjAdDqq4zDHpHHI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aqYs39uAneHlHom5R4HFUfT3wpSP+80MtSGJG1Y/SVuddMg5sqDX6MdZNn6/pUpO9
 XVK4TRzR8V/z/k58K1KMUKho8UqXYvTVWvN2S55tPKJXi/YrZgvB71db/kuLo0lkTG
 RwhUeIV/HECZkpSL+zGoPdTBzFVNzyeE5FctoVclX4/FY2uZ9FhB2vrPV61q/mcrbR
 F/apNL5VXRYFzEKVeCbVF8Pmvau/b3QUW4Lqn0KdZV9E3hawJy3VJyzzj72PDd/O3c
 c2d6gYuVCUFERszQOrosHQA/xsyceSEdO/E6zNHsNx8i7whpYY/21WB2qGWc8htPqV
 yUK6mUtxDZFxA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 NXP u-boot <uboot-imx@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 2/3] arm: config: Enable CRC8 support in SPL on imx287 XEA
 board
Date: Wed, 10 Jan 2024 15:48:48 +0100
Message-Id: <20240110144849.1783122-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110144849.1783122-1-lukma@denx.de>
References: <20240110144849.1783122-1-lukma@denx.de>
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

The boot0/1 feature uses simple CRC8 to check (in SPL) if
SPI-NOR content is not corrupted, hence the need to enable
it.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 configs/imx28_xea_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index c1b0487f7e..64a0561a34 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -123,4 +123,5 @@ CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MXS_SPI=y
+CONFIG_SPL_CRC8=y
 # CONFIG_SPL_OF_LIBFDT is not set
-- 
2.39.2

