Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15137606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U7h4Yd2G;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=Jokb8wsC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F7CA409E3;
	Wed, 18 Nov 2026 14:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9TMalZpu_P6; Wed, 18 Nov 2026 14:30:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F202A407CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795012249;
	b=KBC7qyJJl90DqSPQb5VAd+Zu6VjGTZCrcTcFZ3XwpOuKMJgytvJ6eqBfQik/4TUZ1WvC
	 ft/53YX1wQ+jkm/Xlgajw8eP+ffH9edn6b+8UTibcMK2hdhjPJggzcoCdYw4X707vbAsM
	 HcErOxyntyOlWG/aKObA0QUDS2Gj05Gx0M/znGiBRber0UYq5ADnrvCq0Kg//HITHrw/H
	 gfTIhzMiL8/rq/lFFc2K2h5HzkajfuKSG6ga0WOxoUy4NdcHqVTDnUNOQlXLEw5h0lQcZ
	 n9/kikK6XOhq2HWG6pYDb2dkzZh1aYw3KkU17AndryjmRLTgQB0xqDNClAdNYYDuuRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795012249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hzFzFqZRs855o24j9QnQ+CLjqGn6B2M6IPCNEMM0eFU=;
	b=iqWkwSVm3TlV2NbfMTE5xwGCB3wrPvjb2WkJaFNTHCcUmrozBvpT4XosaMyFpjxxZrFH
	 vzivRCXZLt0L0SNF1sCnyYCYrriIQ587kCKHTZl2BL4aDKsRX0gottqlw+O6FVFiqaAVy
	 UxT03fjE7hOm263hE1KNsN66NGqD6dqyjTxMwjybiifM2JOMZ1Af7ujC47YPgoU9Wctqv
	 dDBXshoPfjE0IQvFnm8R63PfhmHO5Z/Iz+ok+ib1kXqsJd+VGDrvHDSZgNwZykFGog99N
	 rzbisoG+MNru9VVh3reiu4HlXgT/QKyKmlBWOZZd/jQexQxN/j0rXW2vk7ZsSlq7Czg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795012249;
	bh=hzFzFqZRs855o24j9QnQ+CLjqGn6B2M6IPCNEMM0eFU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U7h4Yd2GF0wBE3imwzOgJKbpNj6sv8i/htls5SFnpQvIgdBjMW/b4QYFLBM3qmDWk
	 3NeZZu027VEiJWtawkvlfnMwteHEfNO+Vp0R0xzrCnULhcigZfn3smtgKRHz7SZIQG
	 wUtYH1fmnXm+Jyk9kC/lDN/kXZoBhpCXiSmUYzeMxLqcwwgPHaA2DE0BMbtZhZzqXk
	 LdvxmeAJkZN3O1lbPJMLVcGCMK7cbcRSukc799rE3t3vidAY7KOMhgXoDNmv19Krkz
	 4YxBP3+5rStGmIYBlmIA+f79cAhPyZcFiQX70f0dClq+tGmmE4OqCevWFYJBTUejPP
	 hSiLmEWQk6tfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F202A407CE;
	Wed, 18 Nov 2026 14:30:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23B4E49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 213F181247
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l1EVbIQAiZpz for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 14:30:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D25781240
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=Jokb8wsC
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D25781240
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:30:45 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 7FDAA1F9FF;
 Wed, 18 Nov 2026 15:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1795012243;
 bh=hzFzFqZRs855o24j9QnQ+CLjqGn6B2M6IPCNEMM0eFU=; h=From:To:Subject;
 b=Jokb8wsCCc8lrXVF70PQ0fLsEQOsQp1OfoZ0jgqXQXGBHTXhYTjyo6zGhxDNMJpCA
 a8xHAJ1K6/dgIOMbb2snxTGh40tIb5NA7CspgxjjPkCB8zloDxXV8KQqiNcSfwvtvh
 Faw9M/2Z6vd1xyATvGJh1yPBbKVpePHVCqlUexAC53xNGEPfhn+2459066IEEjoto0
 7++eZQvDaXFKMaNtE47gRVrjsSHU5TaFKIG5h303CuEEQR1TTq9G56BT+6B0gDSRHx
 0vdk4pXdb5JjqeOhP+GROMDP1qgTWDb4dIzFLsMUruUikdiSLQj+eFEWkOpcQDdSsw
 sDHOXTfYTrIzQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1] arm: dts: imx95-{toradex-smarc,
 verdin}: remove lpuart1 clocks override
Date: Wed, 18 Nov 2026 15:30:34 +0100
Message-ID: <20261118143035.424557-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The i.MX95 lpuart is matched as "fsl,imx7ulp-lpuart", for which the
driver uses only the "ipg" clock, already provided by imx95.dtsi. The
"per" clock added in the U-Boot device tree is never looked up.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi | 2 --
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi   | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
index e4eda61e5c47..0d71f9dbf906 100644
--- a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
@@ -18,8 +18,6 @@
 };
 
 &lpuart1 {
-	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
-	clock-names = "ipg", "per";
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
index 8ab70cf7399a..cab08a710cb5 100644
--- a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
@@ -49,8 +49,6 @@
 };
 
 &lpuart1 {
-	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
-	clock-names = "ipg", "per";
 	bootph-pre-ram;
 };
 
-- 
2.47.3

