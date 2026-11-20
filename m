Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9C7606C8B4
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xWgALNEO;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=RiTm6rwp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69F6460623;
	Fri, 20 Nov 2026 15:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xaxn4WhFnWK0; Fri, 20 Nov 2026 15:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 508DF606E3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795190126;
	b=SERg8FaJP7WUveKGUd9YZz/3YCNVPOclbxwvMeHrBJPx1M3YLF7Jr2l/jfSBQpenqKkG
	 cgH+SGmeUo+z/EyRxcwXX070V60utV2MGx61tTBYh+JVBuxjR0Xsrba7+dPe1JfJGsCx2
	 oH8AyIvBKJF7UraKgBcpON25jK+AfQc3HnRmgjwCpp/a3r45nJ40KqraMWXNWnP1UOtOZ
	 mJBLK0Hxv3mcXnM8ukxdeFIB/Cg6TtMXnLWVx3VDfokydEv6xgwbt42n3MFxqHxE0f0X5
	 dLEpPQjqbCoP6ApERGH7f5tGPu/ZCvFWYHw4SOKtHBWZ58uqsSDHveysPyNrSLbzHGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795190126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iTkLhNGWuKUAt1Sb34utlpbDXsq5iOITzYtaRFVZy8k=;
	b=jfvh1v5Bria9u9tPT0zIyfpEPqfneT6cky6XOZsbIsAL3cVjxQqGwUTNllZgjwSdmQkl
	 KoURE1JUHwAHUQbsoYf8TzQfntuBnnI4eFo0KOoHT0yOOucZ7A3Ah9EF/GP569k4zwsPU
	 rAdqo7Uyf9l/0a4GldesfSTRUseGcMP1ERbETo/Gfzkhz5SsnVYrq5AiFsiftAerDUHOF
	 5WySisPPts11L4oNYOfnvjMa4G0OeZjAVa1CWiBy1eSMPNHjlD+MPT4aVJGGprc0rd58V
	 H2Y+eJ1JQCg/FNAd7Ui3g/5aDFrSewlPKXulKh3pI2yMX34k1VSks9z766Kw4Vt4iwQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795190126;
	bh=iTkLhNGWuKUAt1Sb34utlpbDXsq5iOITzYtaRFVZy8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xWgALNEOkzM5h9S+4b6zwHH+lgYng3p5GAfkJvp/y+1gzCg2Qcq1utNyshytVF0gW
	 U1wL1bCLPA5Syy2PfsIUVrCRPItfXpR21n3T/iGHszVLNnegWxge+Xz59wdFvPa437
	 mjsxvwpfgRVgRuvRiy5EDuzPWSl8eFWKmmvMugXFCOs45FT2v72MFqxB19i7PbeFcY
	 jaTWXi6DHcBhJU+flMJl4PG3mjMs5oGX4//aHZFaN7KxiLvJwswIq/cGdi5LySrTOj
	 ZhX8FMNoK9jPmzyPcgNSKI9jN2sfMGC6JFjEDHD1/zCDbxRxBjr2a+iIKYYZNvIBOR
	 2zxiFD8F32u9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 508DF606E3;
	Fri, 20 Nov 2026 15:55:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B03CFE5E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 970A140176
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJm7rxtejpdR for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7C95540111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::8fae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::8fae; helo=smtp-8fae.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=RiTm6rwp
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::8fae])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C95540111
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:20 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jWKft2X82zqjD;
 Fri, 20 Nov 2026 16:55:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795190118;
 bh=iTkLhNGWuKUAt1Sb34utlpbDXsq5iOITzYtaRFVZy8k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RiTm6rwpVVcgYjszTa9hTKuSQ7Dk+fGVXidLGrdQlyZjOehWEk4a3kSUamCLZq3WH
 ou89IfR+QKinITe0Clnubyde+XyY4WIOUzmxfgJ7gK5/j4x3ri0eUwC4DUPi7VGboG
 mfWyVLlvmbXwRcWTRc+++p4Eoe/HO8QmgR4wbdck+1oBAKH+EgIFewd254TcjQhhQ9
 FO9TOdfjEc3M9q/ZY9t7YW3UnYuHnEVIxz1wEIT/4AkqajjV0ByOKVzDNQ0Hrje04J
 j7360OSXav9je8lrvSgVgbUJn8h6X4IouF0Dudh8jsq7ygYYs7s0rhq/zuaxu1FjUZ
 7C/X/W2+GCE+g==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jWKfs1sgQzN4W; Fri, 20 Nov 2026 16:55:17 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 20 Nov 2026 16:55:01 +0100
Subject: [PATCH next 2/2] board: rockchip: rk3588s-orange-pi-5-pro: remove
 now upstream work-around
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-orange-pi-5-dts-sync-v1-2-bf749974a410@cherry.de>
References: <20261120-orange-pi-5-dts-sync-v1-0-bf749974a410@cherry.de>
In-Reply-To: <20261120-orange-pi-5-dts-sync-v1-0-bf749974a410@cherry.de>
To: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Cc: Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>, 
 Dennis Gilmore <dennis@ausil.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

With the previous commit now incorporating upstream changes to the
Device Tree, drop the now unnecessary U-Boot-specific work-around.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
index 142db4a0fcff..853ed58cfe58 100644
--- a/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
@@ -1,25 +1,3 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include "rk3588s-u-boot.dtsi"
-
-&pcie2x1l1 {
-	pinctrl-0 = <&pcie2x1l1_reset_h>, <&pcie30x1m1_1_clkreqn>,
-		    <&pcie30x1m1_1_waken>;
-};
-
-&pcie2x1l2 {
-	pinctrl-0 = <&pcie2x1l2_reset_h>, <&pcie20x1m0_clkreqn>,
-		    <&pcie20x1m0_waken>;
-};
-
-&pinctrl {
-	pcie {
-		pcie2x1l1_reset_h: pcie2x1l1-reset-h {
-			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		pcie2x1l2_reset_h: pcie2x1l2-reset-h {
-			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};

-- 
2.56.1

