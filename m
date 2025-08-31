Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFC0CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 05:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A804B8391B;
	Sun, 31 Aug 2025 07:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="ofw1vCtg";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="y7aFvvqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659BA836AB; Sun, 31 Aug 2025 02:54:30 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A9683487
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 02:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrian@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756601182; bh=izFMXtstyGv8nvozTbVvvZ0
 ESzuduZ1wLsCy4cmHtvs=; b=ofw1vCtgt3H9Oco9SCytrv1IIeBNwICbfFLMgxjgt28atVHhjg
 d/fqz+nYmM0mT4TRg+GyZ4qoQW1D7ooY/tFKlAJ4P7xStwskVNQIJZXFFF07OBjmd6zrVmZBxiM
 YA4xY0VkfQRIwtFGuuho8Ghnob9dY3Jc6Rcx/b0nbddertzkU/p0wU3XI7kQG4+2wk1mQkLtHyB
 TzVEmWBRhSqb34SPY8vve0le9+YYDXUnNQab/+p0EJdMuWKjWEQGSNQdxNOtF4vx/mXBNVz++TF
 7WO9mwoBSXcpgSPnCRCkqKp3daE185M/OfYy4Bz64C+9d6F+5gXek+PnanEj+jZ+O5A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1756601182; bh=izFMXtstyGv8nvozTbVvvZ0
 ESzuduZ1wLsCy4cmHtvs=; b=y7aFvvqVNfVN1A041zP8moCQq9qXAse8l4R8KNHqZKpC14tzxE
 iO/GANWWaig6DJDzap5hWU2/NHxiD4cZBnDw==;
From: Jens Reidel <adrian@mainlining.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Luca Weiss <luca@lucaweiss.eu>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Jens Reidel <adrian@mainlining.org>
Subject: [PATCH 4/4] configs: qcom_defconfig: Enable SM7150 GCC and Pinctrl
Date: Sun, 31 Aug 2025 02:46:02 +0200
Message-ID: <20250831004602.699953-5-adrian@mainlining.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831004602.699953-1-adrian@mainlining.org>
References: <20250831004602.699953-1-adrian@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Aug 2025 07:09:14 +0200
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

From: Danila Tikhonov <danila@jiaxyga.com>

Enable the necessary drivers so that SM7150 devices can boot with
qcom_defconfig.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Jens Reidel <adrian@mainlining.org>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e77..42a25b4a18a 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -60,6 +60,7 @@ CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
+CONFIG_CLK_QCOM_SM7150=y
 CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
@@ -112,6 +113,7 @@ CONFIG_PINCTRL_QCOM_SA8775P=y
 CONFIG_PINCTRL_QCOM_SC7280=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_PINCTRL_QCOM_SM6115=y
+CONFIG_PINCTRL_QCOM_SM7150=y
 CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_PINCTRL_QCOM_SM8550=y
-- 
2.51.0

