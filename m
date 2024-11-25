Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ACAD59D72
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 21:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7932892C6;
	Mon, 25 Nov 2024 22:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=dominik.wernberger@gmx.de header.b="ojqYKJfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71D789757; Mon, 25 Nov 2024 22:22:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7992B896AC
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dominik.wernberger@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732569731; x=1733174531;
 i=dominik.wernberger@gmx.de;
 bh=Dtw3jKnFWTScq+bEtPQXeq5v5Gi8TBhEXHx7bMz4898=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ojqYKJfEmWWc+4Bf34mBbPui1GI9pSy2xiw0V5zwqtSVRIoxEgkBajBRCKO5X/02
 WbKok0rkbaa/KAjHjaKrsJgSGlqmPD8M9JqgtPipi4BUvF+Qng17OcpwkO2RG3dBb
 Ry9FpE9w2DW1OH0sfa2uHnQi3dL+fBC/u2lCl8d5vwjPvaUyFauYXGBSJ2YVG1wtw
 ozU4xB4WStkryyHBkJr9ePRSORPOkAxr0mO+zG4SNSL827kA6Y9/h9Y3lmEi2aR12
 dAJLLEePh3iePAVrVKR+tzA3LstyjI/D/pjqQng0OKhfiRkDZEJuNlk09/WLhPW/o
 lWoZ8rYy/zM5khEhfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from doms-pc.fritz.box ([91.51.57.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1t8hbw37pH-00Pp92; Mon, 25
 Nov 2024 22:22:11 +0100
From: Dominik Wernberger <dominik.wernberger@gmx.de>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, jagan@amarulasolutions.com,
 michal.simek@amd.com, tudor.ambarus@linaro.org, venkatesh.abbarapu@amd.com,
 Dominik Wernberger <dominik.wernberger@gmx.de>
Subject: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
Date: Mon, 25 Nov 2024 22:21:52 +0100
Message-Id: <20241125212152.29397-1-dominik.wernberger@gmx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D2lslVrHwFikwDOXtpTueYS8mM4rf/5tM7wzjc+8MXxSaTf5KCD
 ia4ej1+WU8Jpyk+TFYid3WEA6TQodFzv6NhWQwQK3et4w5fnPwnl0GaoXirf7UdT5EhUUYz
 xtiKYscT3crgdxu4sPtM/9zVL+PD6dedazo9mDZ6MKX1G6r85uYTVLycT7DTYtn7ztpTKpw
 +eqn/AZYX56cWvarktR1g==
UI-OutboundReport: notjunk:1;M01:P0:0JkXQfR/8Kk=;qvRk0D0XX2rESp2CTarTS3ODTi1
 662CiicCJCJx8vVtPHfURRAuNKGuOt15cdB0XEVCLmp1IKAvhsHh50OSAAe3PtvonWc6pzDl1
 jqsJtLEGU+WEpUkiOmaPxZmmLuhDXhKsmw+VBXwvS4IJashPnzoGw5nDozmMfGBWXw9+cUFrN
 rHikFzFhEY+7QwNnPVPSRjpe/x8q8FqXFP0CAVId6zhGPvZbxuzn+h2jeTIiBxV2oCG1yjipb
 urGEazH7/EuLRWfndgv4A62mXPwVehpSx3iS4QVaGN2r6cVFdqNBcaHopLKEe0AY2GzYpirXR
 YUXj29cA4q0ZoO98UIk5FdZiLjzOiCUfjsELZHrlPaqyhdli/0eXAtwBaPa/j4yPxtBB2wEp1
 42/j2zfitNaMovs1T3TcPUgcjUKQM4/meO5roPfpZlqnK5fofg5lD5nNUPU3yUJFi6fTznEsv
 BuPCAMxSGTcZ8VqGdPmoK3BgZZXw6CpgVHywLlPv8h8sFMZSHELpkde+xHnV97+g7PJkBkxL3
 Z2YsqLd084NG18xjU9k+6Iy+Y1GGSLrPVmxfsOupNyRiRJX97cesajzJnA363/rt1AwqEG1tT
 EthIUWFSQcoIvoBkCQ3kZqU22MwRH+hVfEhWXjLcBSiI9gxVrK5bnuetRuwmcUe1elxt+DNPp
 B2guggLlpk+3xHxvVireN9NK6NpAs0V61pHw5Lppp+ajRPYsb4kOLveb3S7XKXoUGppXCs8Nk
 lmvzGUm+6YC+msc+MxdR8WdzepOioF4ttgXrVbIurP7s8VSLNbGRL8/pl+42Zsa290pmjxXYo
 FphKj7jM0TB4T9Ewz/avADco3SFG7mbwj9u55iix8IVinjT9YhyG36XFCRhRVLX2zOiByESv+
 tUKPNaWsukLmWt/VrYQ8DCBH9gzTCWABeY53mZ7cbemJgHnIPx+DKswiaWYM2cK0lb68L5+a9
 KRxMimcNppm2den79nITb2TXWBi7UJXjj4Z4hadejY3QoL1swMxXq1FPcysqTd2rAjaRZaJib
 OkcBeSyHoEQ8FYumJsQzn0Ad8/SRNZhUfegH4R5WCJYvlObVzgs6ILyrJYMsV9zivr0nRBHPD
 wf1rf6ZPbvtUyad0FcXeHYusd/cZxd
X-Mailman-Approved-At: Mon, 25 Nov 2024 22:25:14 +0100
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

Fix missed rename from SPI_ADVANCE to SPI_STACKED_PARALLEL. This fixes an issue encountered while testing the Zynq-7000 QSPI parallel Flash implementation.

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

Another approach to get the commit message right. In case there are still some issues
feel free to fix them up. I'm obviously not yet used to the Linux mailing list which
will hopefully change soon. Until then I don't want to annoy you with too many mails.

Thanks for your help! :)

BR Dominik
