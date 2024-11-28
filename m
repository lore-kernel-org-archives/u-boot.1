Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E936D6D255
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 03:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166FF89840;
	Thu, 28 Nov 2024 04:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732764404;
	bh=kjBls/TcSmRagSvBC3eIQFlXCHAhDFAd0LVVh4nCFXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b2os1gcAHB0BYvcnSz/auE43SNZXBctTOBaN0aNsr9+AuT4GlGu0YFeRjkSN60xPU
	 zRV+s+DNSqxEXlvkUv7NbM05HSGrxkL3/LfIqrZqgt3mByM7fDaFD9kBnLyo1vn1Lf
	 Q5xb7irqk3Ai4RHU1oOQTld8RCLeD8lHJG9GgxWUXVhXpxMypafPmhq1Ekw+de1zoa
	 f1hBg3ceArHuhpqIQ6uo5ye0JH1KRYr0GhbMp+WNGsXrXtn+ESQJCddHH6h/bDlrYs
	 bX1PPCeWS0Ra8nTpErYQBNgWr+TJgTHbQtI3VJ7j15ns61jnSnRgozeqtcoLSmNoD2
	 xGG9gX95IXyjQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA97A892DE;
 Thu, 28 Nov 2024 04:26:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732764402;
 bh=kjBls/TcSmRagSvBC3eIQFlXCHAhDFAd0LVVh4nCFXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HwgLoaZUhX7sxlXtHhMlfXhNzVfphnqxItCpXLN8m++tzVbKHSE63TLp+aVxWQU8g
 ueLpPeJEL79ipXdrKVagZB7gPBseiaiKy1iBFHRDotc9nhYo9ucN1Yijct6ZEfmMPz
 qlVrtwFX4KUh5QF6ZN/2PxHKzRGJIVmvjnvpeG+zYN4Q+vr9rj5rkqJ9EKmw+xS4Xk
 oonqYlhq+wTFovDswsz4gjBj0f73F8omhISBU4NSI2DknrPOXI/I7XqZdij2rcBrCN
 twJGRI/p8rMBkC4lBipDffOBy6367DcywRuw+1W+19xIpJvalapmyzUzxMjBK7YiTV
 lm4352l5dek+w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] ARM: dts: imx: Pick safe DRAM size on failure on Data
 Modul i.MX8M Mini/Plus eDM SBC
Date: Thu, 28 Nov 2024 04:25:24 +0100
Message-ID: <20241128032623.269459-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128032623.269459-1-marex@denx.de>
References: <20241128032623.269459-1-marex@denx.de>
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

In case gpio_request_list_by_name_nodev() in board dmo_get_memcfg()
returns error code, pick a safe default DRAM configuration instead
of bailing out with some sort of hang() or panic(). The BIT(2)|BIT(0)
strap option is the lowest known option of 2 GiB , use that.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: For v2025.01
---
 board/data_modul/common/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/data_modul/common/common.c b/board/data_modul/common/common.c
index b5f83908771..9e35dc5d6cb 100644
--- a/board/data_modul/common/common.c
+++ b/board/data_modul/common/common.c
@@ -47,6 +47,9 @@ u8 dmo_get_memcfg(void)
 					      "dmo,ram-coding-gpios",
 					      gpio, ARRAY_SIZE(gpio),
 					      GPIOD_IS_IN);
+	if (ret < 0)
+		return BIT(2) | BIT(0);
+
 	for (i = 0; i < ret; i++)
 		memcfg |= !!dm_gpio_get_value(&(gpio[i])) << i;
 
-- 
2.45.2

