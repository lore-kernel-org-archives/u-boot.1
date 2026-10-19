Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0227ACCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54B466067A;
	Mon, 19 Oct 2026 11:54:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cr4V3kWqfY06; Mon, 19 Oct 2026 11:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 866D4605F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792410860;
	b=ByL70t7t+uM+UV8PcmBR1OEijry75GmHXJLv73yG078VWL9wijv7UuiatX0DvW9twPyN
	 V4d93KndcSC5ZDbUZTjjApwRvtfxsBGGxdAXBoJcLkMfOzCqWo3ivAg0HE3xHV6hBZWx5
	 kK2GK7eCalKnPxX5UxPsbnKGEG/6vNFjRx6h+wV6kvAnne+Y1nnXQ+Iz753r7McWnLvg+
	 cNnZXROj38xJ7MJ0TXjWoty8JRkZeMY0BtPjl9FaIGQ8MVlmCnKuHiegf7LEyiDc4+WIO
	 Uxwa0o7ptms94q8bywZyiImxxid1Vcn51exwj39LuZwQsm/KNPMglvf5lwABiNeYF/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792410860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QVIV838+sqCJsA2kKQF3DVkjudZTQjNt9h0AbOnc7xw=;
	b=d8QFDxEVd1vL0s/81LqvA9pd1DRXOdCcMOHqEXQVkbZ9xDHq5yHW9crssEKj5Euy7S9R
	 ahCBmn9EceuzIgDe1ZmYqThlm+2MLWMhJtnt28Hl8ns+/HIJT2kaiL7shS5F6ibzmBNO6
	 e42dxClZPfZ+SULqZzhlF2cwKm0+ejNWKkMeS2Xg7nwpyWqlp+CAgvPdMSFclAiVHzIzu
	 mxw3RzyqTR8eYql9PtlZALP2V2Grens7xSaWWx6eaSEX0evwd3I/ac8UJJPxZNp8NXfjO
	 zaVPCUfVAJygjafEzu9iLsfyVxLVFmOsd9u4wCOBaJgyPrF18IUrsxfgtQPQGNQgJHw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792410860;
	bh=QVIV838+sqCJsA2kKQF3DVkjudZTQjNt9h0AbOnc7xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EecV7FNcrJaQx42I0QhvCiHljWA6ZWJoO7fXfo69n/IsdpxcLtT2bkUVo3y5oPCGX
	 ImN8/JUmEO9bxgRjG/QBN+MhyYtVkpfq88rjWC/OgjVrkuYhjlAoiMkRWDdeJJQlE6
	 4RmXp0+OfJJ7hnc+Pum5dnXjeAircQ5FA9nesV79jO2BXvVnX6cCt2RjyI+WggUMCh
	 iUJejUdFq2hxdFRXUR42A16jWYzURZGtWSM/bYEUFmuhBAyRqfb9NjywdQF79IELlc
	 xfZuJUgdgPvpd+rm8wqMkbNFjEsv1zo1fo09Tjq1HPQMtQfvoC1Vrq/3VUaTkcMf+o
	 7lbeFZGltbz1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 866D4605F8;
	Mon, 19 Oct 2026 11:54:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC9951DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE33440080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWNDqkYE3XA1 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:54:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F9A240079
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792410858;
 b=QX2frZZ98/m/IqaNqtdIrreeUfa19O82kQ/qfCB3sJPPC2B4yj+Jq8PCMk0sqXZePgt/
 arGeSNV5CQdXcbr2H31TwNYAhLBtRDxGBWGlAta+kmSqk07Ht9icNbSvgHIXRxf8GNGv8
 XW2cH6rR7Mq7vWS+V82U503UMKDup0spn/74Bi470Ju2mhwfwkreMQQoIF4xJW4s7F5Pc
 A0C9zNZsOtAfGEpeTdI9msv+BdFdqPUtjo4v87jvtTfGL5SLDdAha+NFKklxgy6oLJpq+
 AWkJ9yx/Wki78phyREoI0eeyZ44GPoCAwptWWteBdALMN6YtfWJ7tGruJNNy4PW6sQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792410858;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=QVIV838+sqCJsA2kKQF3DVkjudZTQjNt9h0AbOnc7xw=;
 b=APcaGxXEeA2Tx96IF6AFG5RkClb4WTCZQ6bi/oQxiqDytn3jzp+7LdhieP8ShRNp5wYI
 VfClPyKGm+b4omBJ+guSjJHb3O6G9YuOqutbkHUalqqIRrIdyY+1Xn4yQrmOYvHzSXXKu
 cOPqCGJPJeMQ0CksDz7+COYwyfHxluSwsHJPhEaBY+CevbcH807utcKZE6O9Ps9feMXrZ
 1EakndwygkMDdARu9+FvQAVOjkLQGrWDVQPKkVw4jj6oRxZFOIg+ccUJsjNUMsv3hMshx
 TG1FFn7rYci36a2p9+MQdT51L7vJf1r7jSB5WUotA91no5mDobAoDHn6uX6RsAz8FNQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="WyAV/sWx"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WyAV/sWx
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F9A240079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:54:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FA5560136;
 Mon, 19 Oct 2026 11:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD21D1F000C4;
 Mon, 19 Oct 2026 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792410853;
 bh=QVIV838+sqCJsA2kKQF3DVkjudZTQjNt9h0AbOnc7xw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WyAV/sWxn0aGZ/SEFxPrn4X2fSPz97RmKiPPJjRJxQAi8fDTwGKX8ag6B1Pl/VsSw
 02oYFIF8rmRlQsuasjmckDRDNOmYKP3WiMB37WeaIL6xf7cZQVyWOTGT7ft9Uu+dJz
 bm99lS4xgTzeP3s7+C5oR2OJWFaWstfkfCukJSP/h0T867KoAcDCDtKJC4hg7IQOu0
 z3Mi3Dm1Xc4V4pcFl329K2QY2YUWqgO5gIoXojsC1L48MNCARrKZ1i6oNp/3vBrf3j
 0f7laS6/17bHAIj7Ha7njAkf8n1za8K5tGOd3bhzrFmUkbEprjafqnAvxE3ZW4Z//T
 O0ibiM1K+Fzcg==
Date: Mon, 19 Oct 2026 17:24:05 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 2/7] clk: qcom: qcs8300: Extend GCC clock driver to
 full gate/RCG coverage
Message-ID: <atYE3Q0ivbXv3tiV@sumit-xelite>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
 <20260812-b4-monaco-v2-2-865d288c0be6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812-b4-monaco-v2-2-865d288c0be6@oss.qualcomm.com>
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

On Wed, 12 Aug 2026 at 06:42:00 +0530, Balaji Selvanathan wrote:
>Extend the QCS8300 GCC driver with the remaining RCGs (USB2/USB3,
>UFS PHY, SDCC1, QUPv3 wrap0/wrap1/wrap3 SE clocks, GP1-5, PDM2,
>EMAC0, PCIe0/1) and their gate clocks.
>
>Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>---
> drivers/clk/qcom/clock-qcs8300.c | 545 +++++++++++++++++++++++++++++++++++++--
> 1 file changed, 525 insertions(+), 20 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
>index cd8aecdf788..cd47b384f1f 100644
>--- a/drivers/clk/qcom/clock-qcs8300.c
>+++ b/drivers/clk/qcom/clock-qcs8300.c
>@@ -14,12 +14,210 @@
> #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
> #include "clock-qcom.h"
>
>-#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
>-#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
>+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
>+#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
>+#define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
>+#define USB20_MASTER_CLK_CMD_RCGR		0x1c028
>+#define USB20_MOCK_UTMI_CLK_CMD_RCGR		0x1c040
>+
>+#define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
>+#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
>+#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x830a8
>+#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x8308c
>+
>+#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
>+#define SDCC1_ICE_CORE_CLK_CMD_RCGR		0x2002c
>+
>+#define QUPV3_WRAP0_S0_CLK_CMD_RCGR		0x23154
>+#define QUPV3_WRAP0_S1_CLK_CMD_RCGR		0x23288
>+#define QUPV3_WRAP0_S2_CLK_CMD_RCGR		0x233bc
>+#define QUPV3_WRAP0_S3_CLK_CMD_RCGR		0x234f0
>+#define QUPV3_WRAP0_S4_CLK_CMD_RCGR		0x23624
>+#define QUPV3_WRAP0_S5_CLK_CMD_RCGR		0x23758
>+#define QUPV3_WRAP0_S6_CLK_CMD_RCGR		0x2388c
>+#define QUPV3_WRAP0_S7_CLK_CMD_RCGR		0x239c0
>+#define QUPV3_WRAP1_S0_CLK_CMD_RCGR		0x24154
>+#define QUPV3_WRAP1_S1_CLK_CMD_RCGR		0x24288
>+#define QUPV3_WRAP1_S2_CLK_CMD_RCGR		0x243bc
>+#define QUPV3_WRAP1_S3_CLK_CMD_RCGR		0x244f0
>+#define QUPV3_WRAP1_S4_CLK_CMD_RCGR		0x24624
>+#define QUPV3_WRAP1_S5_CLK_CMD_RCGR		0x24758
>+#define QUPV3_WRAP1_S6_CLK_CMD_RCGR		0x2488c
>+#define QUPV3_WRAP1_S7_CLK_CMD_RCGR		0x249c0
>+#define QUPV3_WRAP3_S0_CLK_CMD_RCGR		0xc4158
>+
>+#define GP1_CLK_CMD_RCGR			0x70004
>+#define GP2_CLK_CMD_RCGR			0x71004
>+#define GP3_CLK_CMD_RCGR			0x62004
>+#define GP4_CLK_CMD_RCGR			0x1e004
>+#define GP5_CLK_CMD_RCGR			0x1f004
>+
>+#define PDM2_CLK_CMD_RCGR			0x3f010
>+
>+#define EMAC0_PHY_AUX_CLK_CMD_RCGR		0xb6028
>+#define EMAC0_PTP_CLK_CMD_RCGR			0xb6060
>+#define EMAC0_RGMII_CLK_CMD_RCGR		0xb6048
>+
>+#define PCIE_0_AUX_CLK_CMD_RCGR			0xa9078
>+#define PCIE_0_PHY_RCHNG_CLK_CMD_RCGR		0xa9054
>+#define PCIE_1_AUX_CLK_CMD_RCGR			0x77078
>+#define PCIE_1_PHY_RCHNG_CLK_CMD_RCGR		0x77054
>+
>+#define CFG_CLK_SRC_GPLL4_UFS_ICE_CORE		(3 << 8)
>+#define CFG_CLK_SRC_GPLL7_EMAC0			(2 << 8)
>+
>+static struct pll_vote_clk gpll4_vote_clk = {
>+	.status = 0x4000,
>+	.status_bit = BIT(31),
>+	.ena_vote = 0x4b028,
>+	.vote_bit = BIT(4),
>+};
>+
>+static struct pll_vote_clk gpll7_vote_clk = {
>+	.status = 0x7000,
>+	.status_bit = BIT(31),
>+	.ena_vote = 0x4b028,
>+	.vote_bit = BIT(7),
>+};
>+
>+static struct pll_vote_clk gpll9_vote_clk = {
>+	.status = 0x9000,
>+	.status_bit = BIT(31),
>+	.ena_vote = 0x4b028,
>+	.vote_bit = BIT(9),
>+};
>+
>+static const struct freq_tbl ftbl_gcc_qupv3_wrap_s0_clk_src[] = {
>+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
>+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
>+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
>+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
>+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
>+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
>+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
>+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_qupv3_wrap_s2_clk_src[] = {
>+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
>+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
>+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
>+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
>+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
>+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
>+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
>+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
>+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
>+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
>+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
>+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
>+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
>+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
>+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
>+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
>+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
>+	F(403200000, CFG_CLK_SRC_GPLL4, 2, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_gp_clk_src[] = {
>+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
>+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
>+	F(60000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_emac0_ptp_clk_src[] = {
>+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
>+	F(230400000, CFG_CLK_SRC_GPLL4, 3.5, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_emac0_rgmii_clk_src[] = {
>+	F(5000000, CFG_CLK_SRC_GPLL0_EVEN, 10, 1, 6),
>+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
>+	F(125000000, CFG_CLK_SRC_GPLL7_EMAC0, 8, 0, 0),
>+	F(250000000, CFG_CLK_SRC_GPLL7_EMAC0, 4, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
>+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
>+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
>+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
>+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>+	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
>+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
>+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
>+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
>+	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
>+	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_sdcc1_ice_core_clk_src[] = {
>+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
>+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
>+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
>+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
>+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
>+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
>+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
>+	F(201600000, CFG_CLK_SRC_GPLL4_UFS_ICE_CORE, 4, 0, 0),
>+	F(403200000, CFG_CLK_SRC_GPLL4_UFS_ICE_CORE, 2, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
>+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
>+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
>+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
>+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
>+	{ }
>+};
>+
>+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
>+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
>+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
>+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
>+	{ }
>+};
>
> static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
> {
> 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>+	const struct freq_tbl *freq;
>
> 	if (clk->id < priv->data->num_clks)
> 		debug("%s: %s, requested rate=%ld\n",
>@@ -31,28 +229,315 @@ static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
> 		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> 		return rate;
> 	case GCC_USB30_PRIM_MASTER_CLK:
>-		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
>+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
> 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
>-				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
>-		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
>+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>+		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>+		return freq->freq;
>+	case GCC_USB20_MASTER_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_usb20_master_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, USB20_MASTER_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>+		return freq->freq;
>+	case GCC_USB20_MOCK_UTMI_CLK:
>+		WARN(rate != 19200000, "Unexpected rate for USB20_MOCK_UTMI_CLK: %lu\n", rate);
>+		clk_rcg_set_rate(priv->base, USB20_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> 		return rate;
>+	case GCC_UFS_PHY_AXI_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>+		return freq->freq;
>+	case GCC_UFS_PHY_UNIPRO_CORE_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_unipro_core_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
>+				 freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_UFS_PHY_ICE_CORE_CLK:
>+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
>+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_ice_core_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, UFS_PHY_ICE_CORE_CLK_CMD_RCGR,
>+				 freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_UFS_PHY_PHY_AUX_CLK:
>+		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
>+		return 19200000;
>+	case GCC_SDCC1_APPS_CLK:
>+		clk_enable_gpll0(priv->base, &gpll9_vote_clk);
>+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>+		return freq->freq;
>+	case GCC_SDCC1_ICE_CORE_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_sdcc1_ice_core_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, SDCC1_ICE_CORE_CLK_CMD_RCGR,
>+				 freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP0_S0_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S0_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP0_S1_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S1_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP0_S2_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S2_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP0_S3_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S3_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP0_S4_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S4_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP0_S5_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S5_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP0_S6_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S6_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP0_S7_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S7_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP1_S0_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S0_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP1_S1_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s0_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S1_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP1_S2_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S2_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP1_S3_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S3_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP1_S4_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S4_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP1_S5_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S5_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP1_S6_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S6_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP1_S7_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap_s2_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP1_S7_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_QUPV3_WRAP3_S0_CLK:
>+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
>+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_GP1_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, GP1_CLK_CMD_RCGR, freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_GP2_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, GP2_CLK_CMD_RCGR, freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_GP3_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, GP3_CLK_CMD_RCGR, freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_GP4_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, GP4_CLK_CMD_RCGR, freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_GP5_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_gp_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, GP5_CLK_CMD_RCGR, freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_PDM2_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_pdm2_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, PDM2_CLK_CMD_RCGR, freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_EMAC0_PHY_AUX_CLK:
>+		clk_rcg_set_rate(priv->base, EMAC0_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
>+		return 19200000;
>+	case GCC_EMAC0_PTP_CLK:
>+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
>+		clk_enable_gpll0(priv->base, &gpll4_vote_clk);
>+		freq = qcom_find_freq(ftbl_gcc_emac0_ptp_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, EMAC0_PTP_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_EMAC0_RGMII_CLK:
>+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
>+		freq = qcom_find_freq(ftbl_gcc_emac0_rgmii_clk_src, rate);
>+		clk_rcg_set_rate_mnd(priv->base, EMAC0_RGMII_CLK_CMD_RCGR,
>+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
>+		return freq->freq;
>+	case GCC_PCIE_0_AUX_CLK:
>+		clk_rcg_set_rate(priv->base, PCIE_0_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
>+		return 19200000;
>+	case GCC_PCIE_0_PHY_RCHNG_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, PCIE_0_PHY_RCHNG_CLK_CMD_RCGR,
>+				 freq->pre_div, freq->src);
>+		return freq->freq;
>+	case GCC_PCIE_1_AUX_CLK:
>+		clk_rcg_set_rate(priv->base, PCIE_1_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
>+		return 19200000;
>+	case GCC_PCIE_1_PHY_RCHNG_CLK:
>+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
>+		clk_rcg_set_rate(priv->base, PCIE_1_PHY_RCHNG_CLK_CMD_RCGR,
>+				 freq->pre_div, freq->src);
>+		return freq->freq;
> 	default:
> 		return 0;
> 	}
> }
>
> static const struct gate_clk qcs8300_clks[] = {
>-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0)),
>-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0)),
>-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0)),
>-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0)),
>-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0)),
>-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0)),
>-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0)),
>-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0)),
>-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0)),
>-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0)),
>-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0)),
>+	GATE_CLK_POLLED(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, BIT(28), 0x8e200),
>+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0), 0x830d4),
>+	GATE_CLK_POLLED(GCC_AGGRE_USB2_PRIM_AXI_CLK, 0x1c05c, BIT(0), 0x1c05c),
>+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0), 0x1b084),
>+	GATE_CLK_POLLED(GCC_AHB2PHY0_CLK, 0x76004, BIT(0), 0x76004),
>+	GATE_CLK_POLLED(GCC_AHB2PHY2_CLK, 0x76008, BIT(0), 0x76008),
>+	GATE_CLK_POLLED(GCC_AHB2PHY3_CLK, 0x7600c, BIT(0), 0x7600c),
>+	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK, 0x4b000, BIT(10), 0x44004),
>+	GATE_CLK(GCC_CAMERA_HF_AXI_CLK, 0x32010, BIT(0)),
>+	GATE_CLK(GCC_CAMERA_SF_AXI_CLK, 0x32018, BIT(0)),
>+	GATE_CLK_POLLED(GCC_CAMERA_THROTTLE_XO_CLK, 0x32024, BIT(0), 0x32024),
>+	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x1c060, BIT(0), 0x1c060),
>+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0), 0x1b088),
>+	GATE_CLK_POLLED(GCC_DDRSS_GPU_AXI_CLK, 0x7d164, BIT(0), 0x7d164),
>+	GATE_CLK_POLLED(GCC_DISP_HF_AXI_CLK, 0x33010, BIT(0), 0x33010),
>+	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0)),
>+	GATE_CLK_POLLED(GCC_EMAC0_AXI_CLK, 0xb6018, BIT(0), 0xb6018),
>+	GATE_CLK_POLLED(GCC_EMAC0_PHY_AUX_CLK, 0xb6024, BIT(0), 0xb6024),
>+	GATE_CLK_POLLED(GCC_EMAC0_PTP_CLK, 0xb6040, BIT(0), 0xb6040),
>+	GATE_CLK_POLLED(GCC_EMAC0_RGMII_CLK, 0xb6044, BIT(0), 0xb6044),
>+	GATE_CLK_POLLED(GCC_EMAC0_SLV_AHB_CLK, 0xb6020, BIT(0), 0xb6020),
>+	GATE_CLK_POLLED(GCC_GP1_CLK, 0x70000, BIT(0), 0x70000),
>+	GATE_CLK_POLLED(GCC_GP2_CLK, 0x71000, BIT(0), 0x71000),
>+	GATE_CLK_POLLED(GCC_GP3_CLK, 0x62000, BIT(0), 0x62000),
>+	GATE_CLK_POLLED(GCC_GP4_CLK, 0x1e000, BIT(0), 0x1e000),
>+	GATE_CLK_POLLED(GCC_GP5_CLK, 0x1f000, BIT(0), 0x1f000),
>+	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC, 0x4b000, BIT(15)),
>+	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC, 0x4b000, BIT(16)),
>+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CENTER_PIPELINE_CLK, 0x7d160, BIT(0), 0x7d160),
>+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CLK, 0x7d010, BIT(0), 0x7d010),
>+	GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK, 0x7d01c, BIT(0)),
>+	GATE_CLK_POLLED(GCC_GPU_TCU_THROTTLE_AHB_CLK, 0x7d008, BIT(0), 0x7d008),
>+	GATE_CLK_POLLED(GCC_GPU_TCU_THROTTLE_CLK, 0x7d014, BIT(0), 0x7d014),
>+	GATE_CLK_POLLED(GCC_PCIE_0_AUX_CLK, 0x4b010, BIT(16), 0xa9038),
>+	GATE_CLK_POLLED(GCC_PCIE_0_CFG_AHB_CLK, 0x4b010, BIT(12), 0xa902c),
>+	GATE_CLK_POLLED(GCC_PCIE_0_MSTR_AXI_CLK, 0x4b010, BIT(11), 0xa9024),
>+	GATE_CLK_POLLED(GCC_PCIE_0_PHY_AUX_CLK, 0x4b010, BIT(13), 0xa9030),
>+	GATE_CLK_POLLED(GCC_PCIE_0_PHY_RCHNG_CLK, 0x4b010, BIT(15), 0xa9050),
>+	GATE_CLK(GCC_PCIE_0_PIPE_CLK, 0x4b010, BIT(14)),
>+	GATE_CLK(GCC_PCIE_0_PIPEDIV2_CLK, 0x4b018, BIT(22)),
>+	GATE_CLK_POLLED(GCC_PCIE_0_SLV_AXI_CLK, 0x4b010, BIT(10), 0xa901c),
>+	GATE_CLK_POLLED(GCC_PCIE_0_SLV_Q2A_AXI_CLK, 0x4b018, BIT(12), 0xa9018),
>+	GATE_CLK_POLLED(GCC_PCIE_1_AUX_CLK, 0x4b000, BIT(31), 0x77038),
>+	GATE_CLK_POLLED(GCC_PCIE_1_CFG_AHB_CLK, 0x4b008, BIT(2), 0x7702c),
>+	GATE_CLK_POLLED(GCC_PCIE_1_MSTR_AXI_CLK, 0x4b008, BIT(1), 0x77024),
>+	GATE_CLK_POLLED(GCC_PCIE_1_PHY_AUX_CLK, 0x4b008, BIT(3), 0x77030),
>+	GATE_CLK_POLLED(GCC_PCIE_1_PHY_RCHNG_CLK, 0x4b000, BIT(22), 0x77050),
>+	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x4b008, BIT(4)),
>+	GATE_CLK(GCC_PCIE_1_PIPEDIV2_CLK, 0x4b018, BIT(16)),
>+	GATE_CLK_POLLED(GCC_PCIE_1_SLV_AXI_CLK, 0x4b008, BIT(0), 0x7701c),
>+	GATE_CLK_POLLED(GCC_PCIE_1_SLV_Q2A_AXI_CLK, 0x4b008, BIT(5), 0x77018),
>+	GATE_CLK(GCC_PCIE_CLKREF_EN, 0x9746c, BIT(0)),
>+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_CFG_CLK, 0x4b020, BIT(15), 0xb2034),
>+	GATE_CLK_POLLED(GCC_PDM2_CLK, 0x3f00c, BIT(0), 0x3f00c),
>+	GATE_CLK_POLLED(GCC_PDM_AHB_CLK, 0x3f004, BIT(0), 0x3f004),
>+	GATE_CLK_POLLED(GCC_PDM_XO4_CLK, 0x3f008, BIT(0), 0x3f008),
>+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x32008, BIT(0), 0x32008),
>+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x3200c, BIT(0), 0x3200c),
>+	GATE_CLK_POLLED(GCC_QMIP_DISP_AHB_CLK, 0x33008, BIT(0), 0x33008),
>+	GATE_CLK_POLLED(GCC_QMIP_DISP_ROT_AHB_CLK, 0x3300c, BIT(0), 0x3300c),
>+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_CVP_AHB_CLK, 0x34008, BIT(0), 0x34008),
>+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x3400c, BIT(0), 0x3400c),
>+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCPU_AHB_CLK, 0x34010, BIT(0), 0x34010),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x4b008, BIT(9), 0x23018),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x4b008, BIT(8), 0x2300c),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, BIT(10), 0x2314c),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x4b008, BIT(11), 0x23280),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x4b008, BIT(12), 0x233b4),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x4b008, BIT(13), 0x234e8),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x4b008, BIT(14), 0x2361c),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x4b008, BIT(15), 0x23750),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x4b008, BIT(16), 0x23884),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x4b008, BIT(17), 0x239b8),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x4b008, BIT(18), 0x24018),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_CORE_CLK, 0x4b008, BIT(19), 0x2400c),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S0_CLK, 0x4b008, BIT(22), 0x2414c),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S1_CLK, 0x4b008, BIT(23), 0x24280),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S2_CLK, 0x4b008, BIT(24), 0x243b4),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S3_CLK, 0x4b008, BIT(25), 0x244e8),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S4_CLK, 0x4b008, BIT(26), 0x2461c),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S5_CLK, 0x4b008, BIT(27), 0x24750),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S6_CLK, 0x4b018, BIT(27), 0x24884),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP1_S7_CLK, 0x4b018, BIT(28), 0x249b8),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x4b000, BIT(24), 0xc4018),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK, 0x4b000, BIT(23), 0xc400c),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, BIT(26), 0xc4284),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, BIT(25), 0xc4150),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x4b008, BIT(6), 0x23004),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x4b008, BIT(7), 0x23008),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x4b008, BIT(20), 0x24004),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x4b008, BIT(21), 0x24008),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, BIT(27), 0xc4004),
>+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, BIT(20), 0xc4008),
>+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0), 0x2000c),
>+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0), 0x20004),
>+	GATE_CLK_POLLED(GCC_SDCC1_ICE_CORE_CLK, 0x20044, BIT(0), 0x20044),
>+	GATE_CLK(GCC_SGMI_CLKREF_EN, 0x97034, BIT(0)),
>+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0), 0x83020),
>+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
>+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
>+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
>+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, BIT(0)),
>+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, BIT(0)),
>+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, BIT(0)),
>+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0), 0x83064),
>+	GATE_CLK_POLLED(GCC_USB20_MASTER_CLK, 0x1c018, BIT(0), 0x1c018),
>+	GATE_CLK_POLLED(GCC_USB20_MOCK_UTMI_CLK, 0x1c024, BIT(0), 0x1c024),
>+	GATE_CLK_POLLED(GCC_USB20_SLEEP_CLK, 0x1c020, BIT(0), 0x1c020),
>+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0), 0x1b018),
>+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0), 0x1b024),
>+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0), 0x1b020),
>+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0), 0x1b05c),
>+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0), 0x1b060),
>+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, BIT(0)),
>+	GATE_CLK(GCC_USB_CLKREF_EN, 0x97468, BIT(0)),
>+	GATE_CLK_POLLED(GCC_VIDEO_AXI0_CLK, 0x34014, BIT(0), 0x34014),
>+	GATE_CLK_POLLED(GCC_VIDEO_AXI1_CLK, 0x3401c, BIT(0), 0x3401c),
> };
>
> static int qcs8300_enable(struct clk *clk)
>@@ -74,11 +559,27 @@ static int qcs8300_enable(struct clk *clk)
> 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
> 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> 		break;
>+	case GCC_QUPV3_WRAP0_S0_CLK ... GCC_QUPV3_WRAP0_S7_CLK:
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_0_M_AHB_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_0_S_AHB_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
>+		break;
>+	case GCC_QUPV3_WRAP1_S0_CLK ... GCC_QUPV3_WRAP1_S7_CLK:
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_1_M_AHB_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_1_S_AHB_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP1_CORE_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP1_CORE_2X_CLK);
>+		break;
>+	case GCC_QUPV3_WRAP3_S0_CLK:
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_3_M_AHB_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP_3_S_AHB_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_CORE_CLK);
>+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_CORE_2X_CLK);
>+		break;
> 	}
>
>-	qcom_gate_clk_en(priv, clk->id);
>-
>-	return 0;
>+	return qcom_gate_clk_en(priv, clk->id);
> }
>
> static const struct qcom_reset_map qcs8300_gcc_resets[] = {
>@@ -112,8 +613,12 @@ static const struct qcom_reset_map qcs8300_gcc_resets[] = {
> };
>
> static const struct qcom_power_map qcs8300_gdscs[] = {
>+	[GCC_EMAC0_GDSC] = { 0xb6004 },
>+	[GCC_PCIE_0_GDSC] = { 0xa9004 },
>+	[GCC_PCIE_1_GDSC] = { 0x77004 },
> 	[GCC_UFS_PHY_GDSC] = { 0x83004 },
>-	[GCC_USB30_PRIM_GDSC] = { 0x1B004 },
>+	[GCC_USB20_PRIM_GDSC] = { 0x1c004 },
>+	[GCC_USB30_PRIM_GDSC] = { 0x1b004 },
> };
>
> static struct msm_clk_data qcs8300_gcc_data = {
>
>-- 
>2.34.1
>
