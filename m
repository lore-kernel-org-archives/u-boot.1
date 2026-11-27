Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77552606A699
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ffHB24Fh;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=I9nDZ1/F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 440D081255;
	Fri, 27 Nov 2026 10:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 90Erg9w-s91o; Fri, 27 Nov 2026 10:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8ECDF81257
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775676;
	b=KWkEsmBHfMMd1o/M0u0T6A+Q/X6gqf3N+vtq/OrO3+JTlxUQyadAa0tALAWZ0WP9eVwD
	 VJiNgneVFQgH7eIz9+zse2OMzumucTCyxHPBHxzfVjjcSKat2qE7/JpQtLGtB3rNd0chn
	 oWN6wdOmSdpnixEkTGHcn1EAYcZXvISk45cq9d1qaDoXypdBZrbsKd5EJfxlsE8HjvA+f
	 sJHByFKegAfNoIXY52ybF4drjyTfZFjoYNHQbTK3Bhiv7k/wRu/qSyU5UMqjEycRkZ0Gn
	 mGo1GMdVBwC374Q5c2iqSR8nszOe1IKeVjW8gf+aSKdOS5OFXP6k6bA5h40Ng3TvD3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vXTFXt1d1RQ1kIgaWpJkkZjOjdsXMd3LXePGBmjNC8c=;
	b=JHYP4WCUsCL7y6ewS1BRXBPM2BMF/i3CePUJ690xAWMTvtLJ4UEs+sFeETiRmTPARYbR
	 CSNmw1zH0RfZMJ0BOgGPLShUzPs6Z3e4mOs2UJLS6SqYXlnDFehhRC3ISSR1xbuvcvQ+L
	 W2ORxADSKw7eDViJzopdu2HSscAb2PjPjDr8/OXbbrmnGX+MLyAoEHHTwJ4d79+zamRQ4
	 vHmCjfH8A3TJGa/6oUX1aluUbNkzxOvIYUD4z2D1+uoQqAEOFDigaiLTob7PwPWXXMoFn
	 A0Lnhd9CSuRUfp38dZ9IFF92tEJQvXD8feBwNR7DFwHrVB5vc0EZgsQHGnDzOyQSf2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775676;
	bh=vXTFXt1d1RQ1kIgaWpJkkZjOjdsXMd3LXePGBmjNC8c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ffHB24FhuoeUT7mawmzF9niwfoogEWJIY4U0yq/8bgF3WDt+X07viblN8iZr5Hdp+
	 R+Cfv7xkMQR3Y/AZhrMl5WTgrD2KGytCYT7K4MqXERdYSKQJ3q5yGSWUao5bSBjCip
	 wTLJRHOZODpgXyeW2g3DnCULUWtWCouGQBVElODjgbos52HcOvo0CQ8bFialJc+bc0
	 R22K05hUeD7dagoth2+ziEw8sJqQUYFJrur5EImIAVRObKCniPF5ggSV5/G0t7XS36
	 CLmvthGrgaf1SM77vboxXMAEGIMvMLxjlWcHwiIZ+hVh/bEkBfx1o6rlrKodth0+oz
	 0daTeJmMUe69w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ECDF81257;
	Fri, 27 Nov 2026 10:34:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF4C266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75D014008B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s2Rt1tu4YhFs for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 962994004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=yannick.fertre@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=I9nDZ1/F
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 962994004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXTFXt1d1RQ1kIgaWpJkkZjOjdsXMd3LXePGBmjNC8c=;
 b=I9nDZ1/FskYaUtYWCLjorvAjKATI41BFcgrgbJakptv8WEPQyZpKNv9WYJK1O1RIAIln1CBUeFEHWDNx35LQWeow8R2UhkovKRj7L3MPBGBJc7TeBGYbDMDrv7xOPHnJucVt+afuVP8DJyIXRwo8SaB4jNO8Cicojh56vqfw3l8UuM8GglZc34qRmHalSFyzHlvqPkXhf9AN5pOKPUwiWtEJq6FmHImBgmCm+vrPr4NeUO3654Rsku/bboxZhVUMfDuup3NdSJ+P+QISpnXQGLPqd8wOzEjCxQyZrnmpsJ2nbyVNhmgcluI9uuq96ac3ROCq0kyOw1NlOPmMGZ4C7g==
Received: from AM6PR10CA0042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::33)
 by DU4PR10MB9141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 10:34:26 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:209:8c:cafe::1e) by AM6PR10CA0042.outlook.office365.com
 (2603:10a6:209:8c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 10:34:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 10:34:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 11:35:08 +0100
Received: from [10.48.87.178] (10.48.87.178) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 11:34:00 +0100
Message-ID: <5991bfad-6b8a-410c-8a03-fe4f9af8ae73@foss.st.com>
Date: Fri, 27 Nov 2026 11:34:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: stm32mp25: enable the LVDS panel of the
 STM32MP257F-EV1
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <linux-amarula@amarulasolutions.com>, <michael@amarulasolutions.com>, "Tom
 Rini" <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261113172541.473641-1-dario.binacchi@amarulasolutions.com>
 <20261113172541.473641-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20261113172541.473641-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|DU4PR10MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: bccb2441-31e8-42c5-a795-08df4c7202b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|4143699003|261009223027099003|22082099003|18002099003|10067099003|56012099006|261102123227099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: GrDSoJBkXcNMiZmSOAT+cfPpbKAP9cT+nslerZ11t7rWy9BP7AFp01CRl9OV3jiK1jHdsE0J7V/Rf48a0gtJAroy3kl4jlVk4PicUfIxbE9jS3hL/rDWvbp6pezSeQ7Bary94Tbj9Vla+5GCwnsEC3Ci9005h9RSDid0UAcFL8oeZ4CCzD43hsnIUHs+b0Iq//OfxfE5HGke94T442OEWYG+mtbnWePpmckMCpFIgqckK1wmiWFDh8cyp44zlMYbevP9U5NALX/Agh4fn8kupSV6/GTtFq7iyACgqu2GC+WymTWz5nRdOMrXt803wUORvSF3A5PMDG0YeXxjEhqfZRPQJsq6Ke9EJ9BPeOUTNKZ4dR7zyr1BKQN+nF64en3f4DcHbrdn4dQMZ3KErqHKKpo84rBCXD8CN0F5PALnKMmZ5+3DAo9EI/p8QoFjO3MDy/4tH7+CTOtpSbrbL9jOxzSExB0OyWvKDymgOUaJM4TBXPUqKkhRYgoC7I42WujqgGIBHe69stWhaYFN8LSWAVEUSY1Zp+PkNZhUHKegp75wVWE5UdX3/C5w+YtREVZcQ2Y7xFIQq5xapB6nYZFaLzml0o1IGsVuBWpAfQ5BrmsNyoHXkBBDSJYqMGhHf1f88Z2mZhIFne89jtfMW3nHnznV4TGXvTCLSsC8XgBPKwfBE+GN4+aIQ/pnQK4Rz1rCUB9Jk+5KQN7IHEe98lCJcA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C/qyvvFpFYOoDbdyjihpR0Ted35HXd9NijhCldGv83d0cQ2FCayzLDt4wSjVIidzU2TFffuPudi+tF+0AKiffFRGCYSs3vlzr34OHGIy7mAwQTC2Nw/IkXfU/SJ5Dw4XDXxzOpgY/I7TXsTs9iaW4cYG+sTqr171FsbVepwWJCQXSpCYHVnzqvVM3nIYAgi806hItIvZCCf8QiN3RT+soknJYiRyn5fGNRDmW5FbAr9QLanfdSiicOScRuJq33EZw1FHvNVWUS+/dnRbPSm9E/2b3ckX7BRGad3v64jE4dY1c5HK6tFUDffMozM581aQQO3W2EYPXM9WrLf3YblkcGJLLvNKfyDTTcySbbLKRtQXVKuQTnH6I+5+2jfuHPheo/y76P0vlZvxh3lgdSTZhIls/hMZyCpvkdtRE/avlHJcBXLbuB5px7usqObfIFxL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:34:26.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bccb2441-31e8-42c5-a795-08df4c7202b4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9141
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dario,

Please don't the resolution to 1024x600. The display controller supports 
1920x1080.

This resolution is used by others boards & this config is common to all 
MP25 board.


On 11/13/26 18:25, Dario Binacchi wrote:
> The LVDS panel of the STM32MP257F-EV1 has a GPIO backlight. Without its
> driver the panel fails to probe, and so does the LVDS bridge:
>
>    stm32-display-lvds lvds@48060000: panel device error -19
>
> Enable it, and raise the maximum framebuffer resolution to 1024x600,
> the resolution of the panel, from the default 640x480.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>   configs/stm32mp25_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index e55ca2e3f0f5..02e5efd1f48a 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -95,8 +95,11 @@ CONFIG_DM_SPI=y
>   CONFIG_STM32_OSPI=y
>   # CONFIG_OPTEE_TA_AVB is not set
>   CONFIG_VIDEO=y
> +CONFIG_BACKLIGHT_GPIO=y
>   CONFIG_VIDEO_STM32=y
>   CONFIG_VIDEO_STM32_LVDS=y
> +CONFIG_VIDEO_STM32_MAX_XRES=1024
> +CONFIG_VIDEO_STM32_MAX_YRES=600
>   CONFIG_WDT=y
>   CONFIG_WDT_STM32MP=y
>   CONFIG_WDT_ARM_SMC=y
