Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38485606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D5XOTaev
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12A376083B;
	Tue, 20 Oct 2026 05:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gi4j-48Hii-N; Tue, 20 Oct 2026 05:49:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 593B0607FB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792475350;
	b=g1+tPqqZOzKlvst0+zC7rlt6NGFSZAhPRx68e69nIPX7jm7Fr/W9mCRXYEBu1b77A9ry
	 ErthxFYcZpw5QTgEqgoAchEF50zkRjLK2NviV08ZsuQLgL+fB2/9ALb23eJ+GlzmRT25U
	 6rivnSySaPEF+/73fQCeOzygCqJjRpiecb+7y2YNtQiie+fMXI85JyBBcKhlpxz6eVKkC
	 RVQo9XFtxoKeeS3Jmxe87iQqjW0dBPaK2Mpb+TMVsSkh0PZBMwR3tfFYNKL8lYd88o8Xm
	 IuEeBytgO1olwwP6dfJa9LlZVA8Celt5xrRzdHU6ZG/MSpnD4TiuRI/rUFF/ZwVZsAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792475350;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Virus-Scanned:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IWqiX0R4Ag1XeNVp2chYInzLgSkzI7DALz6Y1YtP2Ns=;
	b=H0G7d3bhQIXJwszlyCbgMLzlRCGzu/7nIrONh4cwFp03IgOL5fBL/ZyYBLC/KtsKKbzc
	 w64gdJe1y74TtUvZ5NlDjgD3Wkp+yNW6XzhosiL1y0Ckj8IKQW7ZlRiQr0ONoK0OFG+F8
	 P0Y84zDqvymkGJUUndOSoJw5j8TQf9m+SFNcK8QrggBp90E6BMPAiNGWzlUPMayxwonqo
	 1hFpH/NQCPWMU1minGvd3HFvB6lpFRcKKD6gN9qhOgXGBNygqur/xYacN2uL0Ap98IunK
	 ohJkYSZ+qnr4YB+lZOpnnzoKPrwe3bl+t9PBUpzcwZh6SW+Pe/g9pE9rXneUixoqfIw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792475350;
	bh=IWqiX0R4Ag1XeNVp2chYInzLgSkzI7DALz6Y1YtP2Ns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D5XOTaevvzNJWdvVBTE0N7e9Ud5mPHrfaZ+zBS5+NglYbvwXX6uVSLLdhHTo1aWR/
	 WZP5IMRXY3SuEZ+22RqHPZyCzr/LjPs0XrUtAb23zeZqCGhZgK2Cf+1kHQ9u1JC/He
	 hLRY9pSfYq2oYC4rgzZrp4RNfchS4rIpFgx3iE/QRr2R3d9evOgKP8YLzzRsmOvugn
	 SWsN72XfZGx2+Xi4m/4X/cvfcx1DCvfkHUKhEExFRYBwfZ+QqFLNvGOW2fVpEfHNT8
	 OKMTaFDzOhFjkryJ0A9UvupVuFNM3mTvBtSiZoOhNVAXo5EnHPnIt2xaDZeAP5eI9W
	 dhcjzs/rmxuog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 593B0607FB;
	Tue, 20 Oct 2026 05:49:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 766A712F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6879C810A2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tc9NhyCBGc5h for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 05:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8175A80DF6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792475080;
 b=Cq/ykd1dNJk25CkCI2fvSOrVnj9Dxdh+aX0km7MGONvW2smO/NL5DAQtTamc8CWZeunc
 msPBDfyXFJ5v1/z3LAU1tokXdTWblYe8tLOKyg7N3AYqGemgII5JQiIOtjajAxXaAENck
 jKglOHD+hsRhRrVw9JJiN3gCJFX+Cl01vuhDPlxPRrL1boaJr5aPMwdTbia9RFmTEEj1i
 FEbXcDGDm70jXyRpKOqWnkxtAXmtxm++JZmDQKlS5fu+eWoeTvDe0p1hinQT4a32kGNlL
 ciAIHs2jrIhQHisFqSlFR1kChWZ+km5AF495uUF43SNBGR7ZWWkVXi5085ZaT67XPqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792475080;
 h=Received-SPF:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Virus-Scanned;
 bh=IWqiX0R4Ag1XeNVp2chYInzLgSkzI7DALz6Y1YtP2Ns=;
 b=JGCTpbXho01qNWRCeX7pGgntKEiZxtEmBRQrPnuVauHg7vYBfXgQWFvzPZd30pLHIwhv
 oVHHoCL8XAFABhovDmPMYxZUU/bun8lvv9Gd42f0oGyvbuUPvMw0n7fHuhKaAi7MSVWtx
 wdvw9Y4YwPbf0H6GDTpc+oKyPt7TVttU0KG8IyrP3nLxIian5HR6DscYSGYibJiXASQR3
 REHVh5+K2Qen9SpY4bfBpkW7Yk3C3EyppCA45CZddTeFi2GhSSRMTKF7A9D04Ehgk16gK
 i29mubKqMwSWxml9+u0FZHxvQjye70POknhSC9lU7o5uzADPFIx8BvJuwdD1li7rRCA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 arc=none smtp.remote-ip=92.121.34.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.13;
 helo=inva020.nxp.com; envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8175A80DF6
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:40 +0000 (UTC)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 29BA51A007E;
 Tue, 20 Oct 2026 07:34:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E67BF1A007F;
 Tue, 20 Oct 2026 07:34:39 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ECAC718000B1;
 Tue, 20 Oct 2026 13:34:37 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Tue, 20 Oct 2026 12:25:10 +0900
Subject: [PATCH v2 3/4] imx95_frdm: Kconfig: rename board prompt to
 imx95_15x15_frdm
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-frdm-imx95-pro-v2-3-09b188f16738@nxp.com>
References: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
In-Reply-To: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lei Xu <lei.xu@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792474473; l=836;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=yIjLz5oQAuSF11dbx2L1dqoQRzmlWFw7ktgVXdZ0omk=;
 b=O2OMlKXtWHE48KTMh4OeOY0EaZoVMXFLMgCYp87BP4U/Khq2X/F1WXTI3aOE2BxP3bd4U6XMH
 3Sx1PDBQOsWCHhMbUc9GkyfxX5OlMulezA04ZgdvkjWTBq5tzW0m7Ss
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 20 Oct 2026 05:49:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rename the TARGET_IMX95_15X15_FRDM prompt string from imx95_frdm to
imx95_15x15_frdm to match the specific board variant naming, and to
distinguish it from other FRDM boards (e.g. imx95_19x19_frdm_pro).

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 5089f44c2473997f549709044b991800a284013c..d66d4193906f8bf4b84494f1e64428efda3acd75 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -185,7 +185,7 @@ config TARGET_IMX95_15X15_EVK
 	imply OF_UPSTREAM
 
 config TARGET_IMX95_15X15_FRDM
-	bool "imx95_frdm"
+	bool "imx95_15x15_frdm"
 	select OF_BOARD_FIXUP
 	select IMX95
 	imply BOOTSTD_FULL

-- 
2.34.1

