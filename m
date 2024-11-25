Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B90D59D6B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 21:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08F088E87;
	Mon, 25 Nov 2024 22:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=dominik.wernberger@gmx.de header.b="mmd1Xki9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D76B389A60; Mon, 25 Nov 2024 21:53:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975F6895D2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dominik.wernberger@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732568030; x=1733172830;
 i=dominik.wernberger@gmx.de;
 bh=7YO9qIwF0Ih+vBj0jYaXizptOi4PUCG2Ci5IxMth/ho=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mmd1Xki99Mlvzr0ru2dexGBRuc5P+t4CxC3QbEGupPcSLM1fyV68EQ1rp2RQIoSO
 dqnKse74Be817W8UUemtNLkSUVIiGE2Tk13GlxxGXLCni7m1n0bUFTGL5R/flgjKq
 sXvUSGZ62je5CwFYMUqMlFnBgzkNec/PWYXq3o2gBHiXaKY4sWImFReGsyXhoJWV8
 Kq12cZ4rdKmUVq6aEAWThuMHIdmk4FNsdLim0/iB7b15/OeJ3LynyC4SJnkbl/iiw
 qCECcB2Q+m9dfBt9uMJcOw15FbVPEYDFQvf1r6zTNV1kPCuHC84eape0NpjQ/JzqA
 kvntVJVAncc7ywUs5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from doms-pc.fritz.box ([91.51.57.47]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1u2C3r2gCn-00hW4B; Mon, 25
 Nov 2024 21:53:50 +0100
From: Dominik Wernberger <dominik.wernberger@gmx.de>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, jagan@amarulasolutions.com,
 michal.simek@amd.com, tudor.ambarus@linaro.org, venkatesh.abbarapu@amd.com,
 Dominik Wernberger <dominik.wernberger@gmx.de>
Subject: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
Date: Mon, 25 Nov 2024 21:53:22 +0100
Message-Id: <20241125205322.15894-1-dominik.wernberger@gmx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c5BlviDCXyes5TH7FRwx4bg0iIx+EUBhVS2xdbTNQd2u71irQ2t
 oe2vQe5pVkRYe+gPJJpDF5UA3JUXtL9mI08D5zLU8HMxZ8ZcJ8m1rXyw00rWfaxsVm0HcJi
 YlFrTeV2yxDhzckR82sIcNckmC3/WLSdIcmDB7gSms7/1LCD97JsMXMqdo2zaIlja4BtHyX
 mk77/D/+zlPpA8LZ/i9XA==
UI-OutboundReport: notjunk:1;M01:P0:6paLMzXGh38=;slVIqtjJQAc0hLHQ4y7QhsYp5Hl
 /5xfTQdBxcx2xHf6/ilMWjsw95d+XAp208r64vWGgZv3lgZ31DvB0FoSyIxnNR7686FPzI6kq
 3lqxAXqH3X4BDohqFUIsDtj+jYYIVVMeVWJ4VJ1wMuSGg1QuElo16wYw8PxHLZShplYRwoV0L
 dkBUJGppOaSUFwY/92oKKWdY6ibzs8MieoQOZIa2K9q+V0kPwsfvVNpGWISyFVf+obcmocHP/
 F5q3sIe7Dw5irPp2vS/7jhjcdtSA6XnAQyJ5e7Np9ajZcQM8sCZv0M1HATUwoq2lVpRVONvyu
 e2839VZHDwvSnBuDjXE5JpLhNk7cYY3N1HcTv+qhy/i/kefkmQwzUKfKjf/ODeBYZbWvIfIve
 hJ/5tS7kHHiMQ9pxrUKDEF10tYFoAoCfexo2P5HzcJZgkGjYlsqv+XtPejB/o110P50BF7Dnp
 lhTSmqE6aSL309+HJfQa+TJEcu4BAbqa1fnp1nBoeNB7pYvHuRjeN1E1FxYA1JqCc6sesRnPN
 h4LCfw57xa1XGVp/Po4fT9hF4unRYVF5zKxMkwPexJbgqqB/krMakzGVNA1WQAKEr1/kQJpwk
 kpQvPHBRdy58aF4wGRJl4t5ylPCu2e5rXWJsvH9H8pHGtRhTOjykL0KcwT8YBENm3DWPFiu1J
 SuGeW0BDbv4QSjVVNxhXIbNpqUbcTrKBvJtqhYp0J1CW5B4h6fbzS89l2uWCDvAO+UXARd6yv
 YWnZQ90DcOk8Fi0M+7X9bTfH2898VnXCZr5fM0IUgwVn0NA3/1FLf62XZH9WalY72Eh6tZ2BC
 CDc1M7bsHb/1UyCDJkEXTbosYMsim3rM9TF1gnKb+LPv7cZgpLbvT6khwQkmsGPGnZFH8geYw
 /vr3BOz9au7AMeRlx3gkjqIIPgnsvxMV0ZthgRAAmC5/H/lZVV/QnzE+ufxOYtkerKxgHNFQT
 VVniNKI/kMv9qJ+PC6tzL+E14JqXeAN5zeOcStn3BABwvdrDZ6+KDenzj1opf40pWQnmTj4Bh
 vH7aad9aH9yvOgY3dJvmiYx4X/uYk+BqobUM7En9exrVspnXdDWu5RXF1zG+CZ65doc351LAn
 MZi6cuFqKzHEip2OZAUj5uojbNt7H1
X-Mailman-Approved-At: Mon, 25 Nov 2024 22:04:54 +0100
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

Signed-off-by: Dominik Wernberger <dominik.wernberger@gmx.de>
---
 drivers/spi/spi-uclass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 36b7d383aa..d604975374 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -446,7 +446,7 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 	slave = dev_get_parent_priv(dev);
 	bus_data = dev_get_uclass_priv(bus);

-#if CONFIG_IS_ENABLED(SPI_ADVANCE)
+#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
 	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) {
 		dev_err(dev, "controller doesn't support multi CS\n");
 		return -EINVAL;
@@ -515,7 +515,7 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
 	int mode = 0;
 	int value;

-#if CONFIG_IS_ENABLED(SPI_ADVANCE)
+#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
 	int ret;

 	ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
--
2.34.1

---

Moved the URL from the commit message here into the annotation section.

Original renaming was performed in
https://lore.kernel.org/u-boot/20241026201741.171073-8-marek.vasut+renesas@mailbox.org/

I encountered this issue while testing the Zynq-7000 QSPI parallel Flash implementation
but there is no corresponding issue in the bug tracker that I'm aware of.
