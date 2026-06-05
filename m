Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C56BCD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 16:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70EF484962;
	Fri,  5 Jun 2026 18:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="mSHQdjz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A3B84971; Fri,  5 Jun 2026 18:15:16 +0200 (CEST)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [IPv6:2001:41d0:203:375::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC348495B
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 18:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Fri, 05 Jun 2026 16:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1780676111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMYOauYXejbtmCXYwODquk4nkFDkC1HA5BzHocsd56Q=;
 b=mSHQdjz2mGHo2klnyejwc8SfqQYpRUWwRyUH1XoXJwzdJIZgi3wD+JrcSsgt400IaarpvM
 dejrPmK0D9A9qzkp6lWZgsUbw096mcnlhYaEVYK+xUh8PGcoHiqQYUOSqCNpNThg6LXdHg
 qgxVOqyjZZLYbEM12WS9Dnx8FANBXNjJKZPPLWNQnwh6A4hlb1GKaLuS4Ymso78kG6vWaR
 dtoEBJkIjaDJuZHqEivOmNQzL9gGWgq4rQU1zwWBp1Bh1mcSVRn/G2e8vE2Wn1jDDleCbL
 ai8OFGbmeHb3UXoAKiMrlkT3LYeLKw4vlbJzThNBphNPAG9GUuQvZGW8y9MPjw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-qcom@groups.io, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com, michal.simek@amd.com,
 luca.weiss@fairphone.com, adrian@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de
Cc: 
Subject: Re: [PATCH 3/4] arm: dts: ipq9650: Add override dtsi
References: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
 <20260605094801.4130128-4-badhrinath.s@oss.qualcomm.com>
In-Reply-To: <20260605094801.4130128-4-badhrinath.s@oss.qualcomm.com>
Message-ID: <tg62gv.1na72fsokrnbj@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

Hi, just a drive-by feedback:

On Fri, 05 Jun 2026 09:48, "Badhrinath S via groups.io" <badhrinath.s=oss.qualcomm.com@groups.io> wrote:
>Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
>This includes memory configuration and SDHCI reset configuration.
>
>Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
>---
> arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 29 +++++++++++++++++++++++++
> 1 file changed, 29 insertions(+)
> create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
>
>diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
>new file mode 100644
>index 000000000000..4454e56469d7
>--- /dev/null
>+++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
>@@ -0,0 +1,29 @@
>+// SPDX-License-Identifier: GPL-2.0

"GPL-2.0" SPDX id is deprecated as it is unclear. Is it GPL-2.0-only or GPL-2.0-or-later?

>+/*
>+ * IPQ9650 RDP488 board device tree source
>+ *
>+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>+ */
>+
>+/ {
>+	/* Will be removed when SMEM parsing is updated */
>+	memory@80000000 {
>+		device_type = "memory";
>+		reg = <0x0 0x80000000 0x0 0x20000000>;
>+	};
>+
>+};
>+
>+&sdhc {
>+	sdhci-caps-mask = <0x0 0x04000000>;
>+	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
>+
>+	/*
>+	 * This reset is needed to clear out the settings done by
>+	 * previous boot loader. Without this the SDHCI_RESET_ALL
>+	 * reset done sdhci_init() times out.
>+	 */
>+	resets = <&gcc GCC_SDCC_BCR>;
>+
>+	status = "okay";
>+};
>-- 
>2.34.1
>

Best regards,
Ferass
