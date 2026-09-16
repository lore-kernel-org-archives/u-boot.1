Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88250C88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B9F1406E6;
	Wed, 16 Sep 2026 09:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMFLlgD-zxuU; Wed, 16 Sep 2026 09:37:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7AECF406E4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551469;
	b=HRJRcYftqwdYhjSiNvNQkBvjC4nWtzuluhoXZd/lTKOxCuPqPtqhGyqKgFgIWUhUHkh9
	 g9E6SvgMAZzRZwCNWNkxTmJ8y+TcN8DQs183CtMAN5CXzQVB9OnBQgYIaK2W4O9cYidx8
	 1gwrvVWCxXjOHr50wD7LPIJRxhPkc07sF0jP7KhEclDryfTeyE8WeuFbS8ewJee5IIqjg
	 Wr6fqqP/o/NpIqvIC7uMo51v9HIKwMXnNu9TZ2dbFNTyClbJZa5tTpk2Z9g7YxY0xHZUY
	 Ay/fw340FSaYn5UYN1BRyPrkh3yO62bf9PCvSBCg7dLLk8GK52DZ9mkiSnoPOdwmzZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=U8jTo9nEKuClz2m4y3I4Q0FTCv6sKXeKp6VyNSRmF4o=;
	b=o08WRdlMiDD0yQvSK3T8NnS+MyvVYB8y5vABb+5bYc7FNoGgbdg9P4/XMOux1R0Rvi1O
	 VNE3OMKS2xZPP/vBk7tHvAvZv1meyDK2Yb7Vc9HxfKad10yGxLfCeyULbsrbm1XkojTPb
	 9052AzQAzUaaBnKkoF8YjHeadEDAoWvYUGwTmfkfNWnNnGU6vcTYV89+l0dbVmaIKUvCI
	 z8/iQTlYlwbc2H6h64O6jRDbgia7Zhnfsej66+AXKpOI/pkXD+EmDUsLjhAmbi7rq/oV3
	 EF2gFjcM7/iv2kXN+dbmM9ZB3GI7woypFGjujjJQPRiMHSnjWu2JwitZ9Pt712usOZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551469;
	bh=U8jTo9nEKuClz2m4y3I4Q0FTCv6sKXeKp6VyNSRmF4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SFXE6bXtQjsmdkMjdPPy66Ohu56ju4Afje98YbbyAD2k4LpmeONnwQhdbnAiSSta+
	 170BTGwnBRgH5ZfWYVakHMf/AIVcpY9lBG1fXamC+zfXDsEKugFboP5Rppsi14qVkZ
	 YzC0UyLRClnhr93Xo5IL90KWjfpVUajj5LWD0Qluh9xzQlIMgCmVwHMhHu2qtfGkLs
	 Xd/0xiRsBLiZJlm/giC8yrdNe/SCx7W6Brn0r+rcrAyHFv7A1oLiA4Ns9zE/KdVw/l
	 r21rI+rpZPtqs/Zc1tn1SZLO2j5BOMx3mrVH+sEZPeSf4K0mkN9j/m5bzHsiWecJpP
	 AYWZaxLsNGkxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AECF406E4;
	Wed, 16 Sep 2026 09:37:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 790F33AF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 769BF4028D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qaEUTGl32v_A for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8A4C740288
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551467;
 b=IIfrN7tfKWeleBWasPrNb+pjGD+J7Td/s0eAvUGPoewlJkXdDu0sPNZn94vxZdzfji12
 B0YyqMuNXJU9FUwKUAwF4ge9lmkhtT6UBjtj2i1/X/RmEfBN6bMPknPk6V8ZgJEf31cNd
 4Pht3yvsoNrKhpYy8Uy0Am0scnBhmvvV/RBlOrf6+IhjZyzGkMsGUQs2JUMDNtfeIFMjM
 huDy22C8gmwwSuWqjBXvdNu79aR1ozZV3qNoD3LSSOQukPdMmMu3kZyR/ctO/n0f2KauZ
 sO/qj2ARZDcNpMwisvnZ+VndvWeGfWEHk47gbW1bUjibRgL6siTNiHOb7bQ2S++KYlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551467;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=U8jTo9nEKuClz2m4y3I4Q0FTCv6sKXeKp6VyNSRmF4o=;
 b=EQuOIl0cw+FFXRn1aKUlBZBe48j5yQW6Toj5oGULWQjgxD0+BpfLKG27Nl+5BMe2Goc3
 wgFTlosYxF3jnBGc+6sjyA1Vui2vem6z3IxvxrNAm57nV06htnCmEN97FGMqZPgOJXg4c
 dTNZkDIDbd5ROBzpQg/wxkN4cksEgMrNVJKj5G/LT0CEIYNnnsTJk+LCOd+wvVHtIf1rS
 WdPCsyhcanv69QTxdSk3GbzIt91SQkt76qXNjbKnFsqQz5o9y8f4aWTJbP2BbVbpArovd
 NsuJIpznSi82rAfKRUPhhYvSLTL5gL9UmhKnSCiIpplf5efnM+o3JkALA6PcAT0TxgA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PSadMvpa; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PSadMvpa
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A4C740288
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AC6B602D0;
 Wed, 16 Sep 2026 09:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FA21F000FF;
 Wed, 16 Sep 2026 09:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551465;
 bh=U8jTo9nEKuClz2m4y3I4Q0FTCv6sKXeKp6VyNSRmF4o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PSadMvpaZdbUuPZhHOXxFbkUO/03kNcrtn2QKfUNw8a0Krsnk9WCU9cTXqw2iROaS
 4U17XrzVQJZDc/nQiE/kkOcFJb6jcJ/zdIC+c1jbu8nFHwn8hb0KbDY+mfVwwtX+zR
 lIWnG/m4SYqonnfTw7IBqz8WcMz9/gOmIQmvPrrqJ6bbZOBLLDGNRUos3Wk3VjcfCH
 9COfZQ5boZHsZJe+q3eTec10TrlWuIaFP+KjTr0LJaiIbuI1yGiopxZBL0lgfeig/J
 bOqPbeVbv0QPWY0Qckw+6ToBC3/e8RW7NdgkAo1wJjmHpIS5dW9fPbfo31wqlP3Nvc
 iNUl7uc0MLIWA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 11:37:36 +0200
Subject: [PATCH 4/8] mmc: arm_pl180: Set initial supply voltages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mmc-pl180-improvements-v1-4-5d7670c3bb32@kernel.org>
References: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
In-Reply-To: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Obtain the optional vmmc and vqmmc regulators and configure them for
the normal SD voltage range before card initialization.

Request the standard 3.3 V target within the allowed 2.7-3.6 V range.
The regulator clamp operation lets regulators with discrete selectors
choose the closest supported voltage. This selects 2.91 V on AB8500 and
3.05 V on AB8505.

Ignore the unsupported set-value operation for fixed regulators; their
voltage is already described by their fixed constraints. Compile the
supply handling only when regulator support is enabled, matching the
conditional supply fields in struct mmc.

Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 528612359789..8627196a8050 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -16,6 +16,9 @@
 #include <log.h>
 #include <malloc.h>
 #include <mmc.h>
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+#include <power/regulator.h>
+#endif
 #include <dm/device_compat.h>
 #include <dm.h>
 
@@ -28,11 +31,25 @@
 #define MMC_CLOCK_MAX	48000000
 #define MMC_CLOCK_MIN	400000
 
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+#define SD_VOLTAGE_MIN_UV	2700000
+#define SD_VOLTAGE_UV		3300000
+#define SD_VOLTAGE_MAX_UV	3600000
+#endif
+
 struct arm_pl180_mmc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 };
 
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+static int arm_pl180_set_supply_voltage(struct udevice *supply)
+{
+	return regulator_set_value_clamp(supply, SD_VOLTAGE_MIN_UV,
+					 SD_VOLTAGE_UV, SD_VOLTAGE_MAX_UV);
+}
+#endif
+
 static int wait_for_command_end(struct mmc *dev, struct mmc_cmd *cmd)
 {
 	u32 hoststatus, statusmask;
@@ -445,6 +462,24 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	if (dev_read_bool(dev, "st,sig-pin-fbclk"))
 		host->pwr_init |= SDI_PWR_FBCLKEN;
 
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	ret = device_get_supply_regulator(dev, "vmmc-supply",
+					  &mmc->vmmc_supply);
+	if (!ret) {
+		ret = arm_pl180_set_supply_voltage(mmc->vmmc_supply);
+		if (ret && ret != -ENOSYS)
+			return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vqmmc-supply",
+					  &mmc->vqmmc_supply);
+	if (!ret) {
+		ret = arm_pl180_set_supply_voltage(mmc->vqmmc_supply);
+		if (ret && ret != -ENOSYS)
+			return ret;
+	}
+#endif
+
 	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
 
 	ret = mmc_of_parse(dev, cfg);

-- 
2.55.0

