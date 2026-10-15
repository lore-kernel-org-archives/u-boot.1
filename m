Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F67CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 996BF406CC;
	Thu, 15 Oct 2026 08:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJUFz_-bGwpw; Thu, 15 Oct 2026 08:27:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1E5B406CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052876;
	b=CdnHdZTSoLqIAS4f8R6w64IUk30NwmxVMNUGbPLuVE8+AnZmnKJwJoDutxI4zCRPZ4gM
	 wXzeshg1HZzTiM6oJp7XvlCSnWff88SgAD2CpPkIfuOdAYCn7j+zXbdi6mESxmjVkBKvT
	 XFa/yNncV0dIMUAMftGChkJ/irsVsKwJ4sN5itugI4YchF8np0vz/WJmTjIwL9172pFfz
	 RB1vWQn9VWq6/2f2Z+YrxIoKjPJHLbpKH9kyQJomYrKGFNRZ7ax92JuIuLt/PKgjPA9nP
	 ITgf49vKzc3tO18LVsY79/wR9MtmGLz+S73RKQRSiVX5rSRLYu5PU7y6ScJ5Yb3mekg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Virus-Scanned:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zUtWdCtvjfGN/m3IgSd3xIS1OFwAxbygtYDuSYkU9gA=;
	b=ROEVq19NiwpNCZLySsUniFMUCzPwnMnPFtY9CZRwYtSbdgea0wUzpOkYlFQ6ZT7/ESpM
	 +6XJfHQGofKBh50MrWGzuY7yZ8Ly4ux7Uv8/MN3qDKge9mHESRh3DAIOC0SuKkBxrKeNh
	 chOiP7540WIuGVyjdX36WCdVqHGUyRXk01ANoCxnzMlAIemaE0o+00ED4VXRjnmgfrAk0
	 BNb4Ck1YUyHL+NQvIXc0NKKhN/BzyIxyqAItfhJQrKyNqeVtQps/W4TE/OZpgYrmuo43q
	 LLvqo6BkwFfVgXzglVpPGgO2Pm2gWvNuUM3/HOqZHU9Et2GYxA/gLSssaPp99jXIVGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052876;
	bh=zUtWdCtvjfGN/m3IgSd3xIS1OFwAxbygtYDuSYkU9gA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hZjSjaVHOZ+UJ6YqI0+WXloLTI/RxhOQIoa0JcagZuyf6hkXw0GBMFf8aMAf1xoSX
	 gV2RUsf/x2pwch4Fqb+G4rfkw2lHfuLGhHI5Te3cDu76tLDMj4CdvmoOMpgy8KzBPk
	 SoH/or4rSE25xabsvZM3aj4iUhaeCI2Dz7sd0zr8EYetygwFWk1TilFH4BiFWugoWy
	 Hba3vyyusRVu1CEryOldmtCJd4JC2DP7GWrHmN9MMx07jqd5JZYnwgckZCbcLETsDA
	 L1dqwNpZ0zSqSpfA4L5WYSUuUATV6DgwgpwL1B/swALv83LeJGTMd/hAtdXQz6Kn15
	 2SMs1rP540ZSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1E5B406CE;
	Thu, 15 Oct 2026 08:27:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 54F2F2E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B69160904
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id waUR24jEzMuZ for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 05:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2562C608DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792043351;
 b=TbAKCDZ84eiV1ULtpJwMUWTxkNFRel+btp5xVjyR8JpKEWooCZAtXb0L8BLPT7bNB2YS
 lt+S21rcWK6ejyfzd99N4TjI5xnxnkBiKnWi/uWO/YKRmZJ1mvWhB9QqiDeRD0TZWuDWj
 +yj6Jb7wwrqFOSdGUL2MqbkEcA5800ijDSbClhLLj1wE2y0zHtjIcc252gSKKL7j+lNt5
 lnXtWbJEhkaL67Jr8Xjev5w4mjVPvt424oSJXMw0CNCM72pJTsvSfmFeCMpkbGxnws0Zo
 1WkmmIUvw6VHI4Zj2SHswMzGCt94VsSQLNd5sPGBHGfNMrc9TtnI0Ylf26TkagiTEig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792043351;
 h=Received-SPF:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Virus-Scanned;
 bh=zUtWdCtvjfGN/m3IgSd3xIS1OFwAxbygtYDuSYkU9gA=;
 b=EEcE6fHidGv30gTAixaL8v5riZavLS0AHh6G9vrGQ9bPlw5sOHsQxDqQU6Cqv6rVRgKq
 +gpDq8oHLiUi04h/sf4f8Es5MYa+rOejS3IaJhPgZgWJSuhAl1yooH/Y2ZLK4qW1+V0Cl
 MkRan7qk0fpLUiv2ughpFXvsVnxVM2Z+Z6hf9NgKOCxkmzJBRuWxlCIiM6R/O9RW+g9D3
 QZqkCOXbYaZXGGQgor0IoaoRW/Cu2Xy8XFKui09YVRBgZncrZeyfRD0IShdYnKpyvw6FN
 HgrcA2eQzNjaTN3B3yBNnIShgrWLy1q7rq3i64uUzuYPS6WukPUgxgQTkXpGEhVKtaw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.nxp.com;
 arc=none smtp.remote-ip=92.121.34.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.21;
 helo=inva021.nxp.com; envelope-from=qijian.guo@oss.nxp.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2562C608DA
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:10 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5FDCF200134;
 Thu, 15 Oct 2026 07:39:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A97E200053;
 Thu, 15 Oct 2026 07:39:53 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 257B418000B1;
 Thu, 15 Oct 2026 13:39:51 +0800 (+08)
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
Date: Thu, 15 Oct 2026 14:39:48 +0900
Subject: [PATCH 1/2] imx95_frdm: Kconfig: rename board prompt to
 imx95_15x15_frdm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-frdm-imx95-pro-v1-1-d354da03ca68@nxp.com>
References: <20261015-frdm-imx95-pro-v1-0-d354da03ca68@nxp.com>
In-Reply-To: <20261015-frdm-imx95-pro-v1-0-d354da03ca68@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792042789; l=836;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=yIjLz5oQAuSF11dbx2L1dqoQRzmlWFw7ktgVXdZ0omk=;
 b=no+27w+K8kXqIHYD8+91B/soxl47oJO49fwp6bOnf3h0BpTQbj+6uQx7xDnI4Zk2ntyBed2lK
 fPHO7hZP1UrDg30TKZLE+0of43mYGhH478+xECCeqiEtHy+WEIYK4HB
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:27:54 +0000
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

From: Joseph Guo <qijian.guo@nxp.com>

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

