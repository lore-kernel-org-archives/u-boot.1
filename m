Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E42CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9127C81281;
	Fri, 16 Oct 2026 12:23:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gmbKHGL7CjS; Fri, 16 Oct 2026 12:23:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9CD7813F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792153413;
	b=CQMFywVjYQal0iIFVGqdj19g0Z50W+shmjJ/98EZ0nbvwDQc2w5sDHW9rsoJneTbxrTY
	 BqFfBVkcSYSdNg4Dhb2Ct7C07y/eqbVQ8IAG0uHvPkpjHLy2CVVYsthhM1Jbon2uGUVfw
	 v4HvLoGJRkzGDlpo/Lf+ggLapMCDkiZR4cWqTGB6Y8j1MhI0El6DD+MfU0ALzYEm6KKJa
	 QfHW7Rs28UTRzhiwoTYR+EqTJOXxOkHDNFbsfRzXLuH4K6qnxsVGcXcitawPqGsJehU6t
	 HbLKY9+plrhbazbjSfzPvnV34qeb0KVeFYr/8gpfILv/J1rchqx2wrTUUrrR3nR+qlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792153413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qdjfIIZCym6bazSk4RbMEYGsuzY81NRzxM8jW5geif8=;
	b=ajOHz9e9JMnZqwqpzEC7us5D9SikieOOcwOhhhzK6rtX61fUfy4A66EiuhWlCgzHQQ7J
	 6GUOfpb8Kx+K5eqf+B9MWBfcTN3X47OFytD8FZldp9v8d2GXp9mRF1ph5HiK68ImO/l9o
	 VILjq5k1UzrGMv9ATki/v6wfE3NELpg4yIEWC404AzQcpDAzPRtwQ7o8isfAIH4kT4Gv+
	 aAwwmH3utLrtyFFOcXxoRLpUZX+JJFT68PvMPbaOOB5V5Q0zTSzFoTAhMrpdGiCRegSSI
	 Tiab/6ae4cFikVsxVXVDIVMfYQYLcDjVPJQQaWreXk65s0Dgm9nao0OJ3Vo7H8oBhvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792153413;
	bh=qdjfIIZCym6bazSk4RbMEYGsuzY81NRzxM8jW5geif8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owTC0GFCmrlLVdKSYYlonEch30BILcXwrdtVxqO+BRy7blhFOc9nYO69OMOw082Ac
	 zk0qDI+v9zLI21E5GOLHUBjAG/UA2BzYAUPfrVRZzfyJfsoCfmXw+jBujwoD6Ja435
	 PNOtCIRZuyoqOxIMVw38bbJgVHtxwc74/FFgBnPf2yXqoqrpdys7Pap0vPgRHZXINn
	 bzlDG8tKnI9IRWV+1ddfQh03JUvrVCS7B4U+Q3LWSARrFbOGUmKmKsNAF2pbS/BjZ+
	 uuge4o/k3E81D7bIlmqjL8ugVeBi4Y3P4P+rpuwSwwbIGjr/H7KXYMnTv8j3quCj1E
	 nQKO9ufZrYpZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9CD7813F8;
	Fri, 16 Oct 2026 12:23:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CD82109
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E650F40986
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:23:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B5uJFvTOwyhS for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F026040960
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792153411;
 b=CfDoO+GaBFJJgIVx0QxCR18JCDriJrx5El8MA7OYTLpc1BDNLdXSeH9j1RYxPbtfY4OU
 GCYXFdZKjViR+sNfbIe0LRlDH67TW8lsQiHz20BA9j9xFBc8tk/GkSM1qJr96bLKf5x73
 EJSXZPSN/j6Mw8II2RU3jxyfFT4jY1UEFpW/zntdDXfiYvpHAuQUGtyak5Wo3ulVtAOUY
 iRdVNaUOxolPcNnT2zpAHLYHdixawFynGihx+PjzESbQkvQzAlPX97C+MA/+ak/kjpwia
 zr9m3u5Khh9JeZIm92DXxEPGbMz8JBZ2s2G/eC7PMN7ERJcV9LSFlbHEv7Oh40tz0bQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792153411;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=qdjfIIZCym6bazSk4RbMEYGsuzY81NRzxM8jW5geif8=;
 b=BOIEyAc+bRoed2oHa6vw1w+Kd1EXjNf9ZRVSdT6UEJ0F0JG8PWM9UO42mAZ+EFR08dBB
 +cWvhyb2YYagknDYrcDNRel5EJQ5S9SQgGu4+5rLUFd/UmtiUECg/XAfaOjbrByZylonx
 18RF8pGNVif0pMWGgOoiqx/Yjo3grA2fRUOpI29+4olPe3wJ5fgIvL6ynUs72Byzrkl9i
 zpby8ZIKhp34PFiDbc2ta08pZFQ7qe4YOgK7Kds9FcnBYKm3G2gGEwvnqprCxPo5gP5eY
 MsN8VVB/NbGxfDGsCtEB6bQ7A/UGr8DVMa0YpV9mP+lwP1QLCZtOOC0QfrvM/qGTYZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="RuU/8QYY"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RuU/8QYY
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F026040960
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:23:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E22A600D4;
 Fri, 16 Oct 2026 12:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F421F000C4;
 Fri, 16 Oct 2026 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792153409;
 bh=qdjfIIZCym6bazSk4RbMEYGsuzY81NRzxM8jW5geif8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RuU/8QYYaWV5sBkOdrjb/M5Vm2keWMlmBm56JDyMjBIGjjCXZgS5td6at1VJHZurr
 gvdCPT8e+sNk8fYRu3wdpWrd3+zwss1b5tyE/zDYINq8ljomtWxsV35OCjrJveoENI
 a4+rHXrs1jK6l7nXGACCw4STwIfamPl8g5AyGRu/W8mtQafHP4I1UulIoAsmP+789K
 f0yA84hz8+oZRX2ybrkkKObXjqzCMrwW8wRuhUdZRW7nTrSyrnj8V4WnyEJU/Zc0AQ
 ceUli4bqDibDlrfOVMWFQZvplj+ZZ/JohFtyLVhcE7WeNioJdqX0p27DeSW8tp7kiX
 /hWZfuK2UTC3Q==
Date: Fri, 16 Oct 2026 17:53:23 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v2] phy: qcom: qmp-combo: honor USB-C orientation for
 port select
Message-ID: <atIXO9NJTpxWXmev@sumit-xelite>
References: <20261013-ss-orientation-v2-1-8daddb44447e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261013-ss-orientation-v2-1-8daddb44447e@oss.qualcomm.com>
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

On Tue, 13 Oct 2026 at 22:38:09 +0530, Balaji Selvanathan wrote:
>The TypeC port-select mux was always programmed with SW_PORTSELECT_MUX
>set and SW_PORTSELECT_VAL left clear, regardless of which way the
>USB-C cable was inserted. On a board where the cable goes in reversed,
>the SuperSpeed/DP lanes end up routed to the wrong side of the
>connector, so USB3/DP never comes up correctly.
>
>Cable orientation is reported by a GPIO on the qcom,pmic-glink node
>("orientation-gpios"), and is now sampled each time the PHY is
>enabled to check for the orientation.
>
>Taken from Linux commit 815891eee668 ("phy: qcom-qmp-combo: Introduce
>orientation variable").
>
>Tested on QCS6490 RB3 Gen2 board.
>
>Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>---
>Changes in v2:
>- Instead of reading the orientation at probe, read it only during the PHY init
>- Updated the commit message to better explain why this change is required
>- Link to v1: https://lore.kernel.org/u-boot/20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com/
>---
> drivers/phy/qcom/phy-qcom-qmp-combo.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
>index 0d63e482ee4..65141489d51 100644
>--- a/drivers/phy/qcom/phy-qcom-qmp-combo.c
>+++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
>@@ -7,10 +7,12 @@
> #include <dm.h>
> #include <dm/device_compat.h>
> #include <dm/devres.h>
>+#include <dm/ofnode.h>
> #include <generic-phy.h>
> #include <reset.h>
> #include <power/regulator.h>
> #include <asm/io.h>
>+#include <asm-generic/gpio.h>
> #include <linux/bitops.h>
> #include <linux/compat.h>
> #include <linux/delay.h>
>@@ -39,6 +41,7 @@
> #define DP_MODE                                 BIT(1) /* enables DP mode */
>
> /* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
>+#define SW_PORTSELECT_VAL                       BIT(0)
> #define SW_PORTSELECT_MUX                       BIT(1)
>
> /* PHY slot identifiers for device tree phandle arguments */
>@@ -283,6 +286,27 @@ static int qmp_combo_com_exit(struct qmp_combo *qmp)
> 	return 0;
> }
>
>+static bool qmp_combo_read_orientation(void)
>+{
>+	ofnode node;
>+	struct gpio_desc desc;
>+	int ret, val;
>+
>+	node = ofnode_by_compatible(ofnode_null(), "qcom,pmic-glink");
>+	if (!ofnode_valid(node))
>+		return false;
>+
>+	ret = gpio_request_by_name_nodev(node, "orientation-gpios", 0,
>+					 &desc, GPIOD_IS_IN);
>+	if (ret)
>+		return false;
>+
>+	val = dm_gpio_get_value(&desc);
>+	dm_gpio_free(desc.dev, &desc);
>+
>+	return val > 0;
>+}
>+
> static int qmp_combo_com_init(struct qmp_combo *qmp)
> {
> 	void __iomem *com = qmp->com;
>@@ -333,6 +357,8 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
> 		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>
> 	val = SW_PORTSELECT_MUX;
>+	if (qmp_combo_read_orientation())
>+		val |= SW_PORTSELECT_VAL;
> 	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
>
> 	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>
>---
>base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
>change-id: 20261013-ss-orientation-d85a156e806a
>
>Best regards,
>-- 
>Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
