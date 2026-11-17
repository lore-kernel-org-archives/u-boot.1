Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8F606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PdDaJpQL;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ajgiDP5y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C29B8100C;
	Tue, 17 Nov 2026 06:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XINyY2CeBzxM; Tue, 17 Nov 2026 06:59:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5822680FB5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794898766;
	b=hhEHENii+hxvPFZQa+tEp9vFzMkTsFgo4aRoviLAhGnYsG35G7I8KFScHzIs0EKEEWpa
	 1wuYL8POKIn7Refb9g1EmNtA3SUk6eFP+afgc2b1wldM8aae2/DV134f/48K0hCobTTdP
	 lxLrJfDanQ2u4FNh/UISAeZEdIkGE68GUsodcHAWuojcBzK6y5Egy3dn9S/PocPg0dNd/
	 ZR9FlZvFU/TLjPdy3brra5e4tQzFehNlqi6LzV0WfG7LpnxqNrQcBb5Rr6yk8iyN1HHok
	 mFnH/oZexe7QWm/Q2BLrtdF6EUQ+fUg6hGDyspzRDQuOLzgtdb6NmSqM7fb0ym2GHuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794898766;
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
	bh=uPqY4cbNBscblPTvWK7nkefv5JjEfpVKq6+aD5GUPrY=;
	b=jgwBsuuj1V+DiOG9cPYXpefN4vr/J/+VmV4hHW4+PHWnvSyjk/ZhyrZpPTfBFkoPcQ/u
	 9cutMEqEaZitncTR+Hwf169mwPk4GkU1ssxN+tnyuUrxR65FhcT1yEoKY+5DHKTC48Shj
	 y5+qFL/LahMyFs4nKK4JjJrWbYd5iOBTlWoh8a5AFUlTfEtl14dunB1a6GVomuyUyG4zZ
	 yvlRxuyhssxvTrnnlX/+LD7Mu780b2q5iqET3CJdWa6JLK6WuCbm+47i8H2qzgiz85UK0
	 U5JspayDznWSazxB09LKdJmHvRqtHNvjRkCtQny+D1/fOyMMcC0CJWgiAtAG6Yuk1PA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794898766;
	bh=uPqY4cbNBscblPTvWK7nkefv5JjEfpVKq6+aD5GUPrY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PdDaJpQLTnVNzuHDmbDMDlYpsUmh4Wef+l54bObiL1CfDBjPJl0+jDynnRlVRht3G
	 QmThn0993QZp/NGFoE0w5qRFffHSDovZQRX5KtOkxjR0ChZSKTxSEtGf5m20txq9c1
	 oZHv09tBCvxKLS8t7MZ/Oh04jwZNMNRtFctjEAbeNqDn+9xBlPY/c9TlRLCoy5qKjm
	 v2RsDoyzAukCoFJbOBx90SlDOfrVcI4iBc4kciWSQluJ0XCbQRblpF3RUVMYl2wzEM
	 5+IBLK1g1FSjwydNSpfDaWZ5aYKRy+fIHOlUrnw/9WHkx4UpbFhbxysmX7mly+5TMX
	 DUD4yLmXi/I7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5822680FB5;
	Tue, 17 Nov 2026 06:59:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3938260
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B8CBF40433
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U3d-1SqELO1z for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B0E3403F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ajgiDP5y
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B0E3403F1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPqY4cbNBscblPTvWK7nkefv5JjEfpVKq6+aD5GUPrY=;
 b=ajgiDP5yvEwFZiMTmp+vR76hT4yCkF+wzd/DyGGLfwoGcKt/j7JbNgpp9SQRpTI7JjsAPje/TFc/FsdiiW2emYEO3X4bRB5et4uYdtgu4Bnms8Mh4FjD/r5OWgkx3Ck6UqTq558kcAgJOWZP310ztmSyBBD7rt0Sa1Q43mv21o7VbQ6p1zbHaP700X0o4GIoCexytFiChKmPBAbFv2fAnuFSg+LO3bfdZKOFwozojdy53ISqkv40LLFfjN5tRk+r6Jzyk8nvYf/2+JIiBslAQkkl3JakbWB8YmnHM6oWyHumKmWAgX3ZZqDbf5zXD1GzA2Kj19nfrtQrMUcp8lKYvA==
Received: from MA2P292CA0027.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::16) by
 AM7PR10MB3590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 06:59:17 +0000
Received: from MAD0EPF000008C0.eurprd05.prod.outlook.com
 (2603:10a6:250:0:cafe::25) by MA2P292CA0027.outlook.office365.com
 (2603:10a6:250::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 06:59:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008C0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 06:59:17 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 08:00:01 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:59:15 +0100
Message-ID: <6e272937-fcf7-43f1-8944-b33204ac7529@foss.st.com>
Date: Tue, 17 Nov 2026 07:59:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram: Constify driver ops
To: Bradley Morgan <bradley.morgan@linux.dev>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Aspeed BMC SW team
 <BMC-SW@aspeedtech.com>, Bin Liu <b-liu@ti.com>, Chia-Wei Wang
 <chiawei_wang@aspeedtech.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>, Fabio Estevam <festevam@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Hal Feng
 <hal.feng@starfivetech.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Joel Stanley <joel@jms.id.au>,
 Julien Stephan <jstephan@baylibre.com>, Mario Six <mario.six@gdsys.cc>,
 "Minda Chen" <minda.chen@starfivetech.com>, Neha Malcom Francis
 <n-francis@ti.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Ryan
 Chen <ryan_chen@aspeedtech.com>, Ryder Lee <ryder.lee@mediatek.com>, Stefano
 Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, Weijie Gao
 <weijie.gao@mediatek.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261116174226.3488225-1-marek.vasut+renesas@mailbox.org>
 <D69AE280-3918-487B-B782-7A22247010A3@linux.dev>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <D69AE280-3918-487B-B782-7A22247010A3@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C0:EE_|AM7PR10MB3590:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fde2b3-94e1-4636-c9fe-08df44784c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|261009223027099003|18002099003|260925021911599003|260925022911599003|260925021311599003|22082099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261102123227099003|261028144727099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: lUICwVxonMo7tcrnAf3blakA27YKOO9AaYLKU0SFnQQj2J6pXj96bFXP19M2zkJhAOjRgPg3WZR4oAL74KqDvhq8AHPiISDYJixMUuLYd99nVNFjRpsfEuFx99YJgCVgLQfAseeZKd/OkcU6QCJSlrZRzYUSgyfVt77HK/6+PHFPYNbtDtKrXp0xawq/MaugWwjkZJICv1mIiB3r/zxGYVa2WGI1xv0+f3ICxP7EWl1dVt/f/CIBMXkYsjzJA5ruLcRg/CabiDHedQyGp6CdBUZgFssjQ9lPJxCbd4fkNTO2gpzsChFcctZN0jjG2by4NkKTBdnBXXOhMwri9qNu5Opb4kzgQNfX4v222sdzAebjTXDZtk/mXeWXd5WmsPtDRPGa59X1o+Yl2YQcSo0OE5Rq9BSA+hzasq8nut/IYCJeCrHB/mkg/10Hs9dbb9RBR5oPob/PRBtdaPxGNKyor04yvPXMK+vVRT1klmXbOQovJijmyliDNdGWnBOxQJ1WVBdt/SCqx3rVbyMEIh0rPakCPYmR0Lw1QcfLWtdjrStMGh5ghBjM01wpIy7u94T5n0DgkVojVp+YmB7omE/VIvGM2bqGAseu89Jrx0ESaUZpF764bFY1ta8X5wRrnhr3MsuhahUJPtXS7d5WnLPUF3qaeZ1zqXjXmxzbBToAeq5pASfVSrlDHMqVU0vQdV6YhG6FTa/Dus9tt9eQ/JGxLw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(261009223027099003)(18002099003)(260925021911599003)(260925022911599003)(260925021311599003)(22082099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /bw8CcdsN++rMPNMJtjDyH3tS9sHoCB7XUdoQeuYenUasWhuXQXIT+muQgD+mFIyw4MG0VXrSVgDDy6RRRsypMBJw9rQbsESXaNZkHq8JHFpkhJS9+pkBJmcEJ0erRbdjbXHQiHUBusyAl1LLGzp702GuomWe/+rMFNK7NWogMAxer8Ynz/FTif/yNBV6FAfWuxGfA58pIdWg9hD4tvFnmJHnDj2uddBarvSjs/gpyZHi+YX1MPiMm8ldWmxlO8ynRfEAmBlLQUYLc+krJMiDSJTDKIU/bBktY7f7o2dAn3O7lzIiyNDPg7No6rOycUi1r0kO+yq2/VIXqQkJBGkzs76xgplidbXLveOQutJoEYDvDFpzrZIJyoA9ErixEXYvtSD2SEbZ6i8Z1aLfgSOOATNzsDg1szs7SeLpJTCgASbBwRH31OsxqoiLvIszjYM
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:59:17.2560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fde2b3-94e1-4636-c9fe-08df44784c1c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3590
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 18:49, Bradley Morgan wrote:
> On 16 November 2026 17:42:19 GMT, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>> Set the ops structure as static const. The structure is not accessible
>>from outside of this driver and is not going to be modified at runtime.
> 
> Acked-by: Bradley Morgan <bradley.morgan@linux.dev> # PowerPC
> 
> 
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
>> Cc: Bin Liu <b-liu@ti.com>
>> Cc: Bradley Morgan <bradley.morgan@linux.dev>
>> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
>> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> Cc: David Lechner <dlechner@baylibre.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
>> Cc: Hal Feng <hal.feng@starfivetech.com>
>> Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Cc: Julien Stephan <jstephan@baylibre.com>
>> Cc: Mario Six <mario.six@gdsys.cc>
>> Cc: Minda Chen <minda.chen@starfivetech.com>
>> Cc: Neha Malcom Francis <n-francis@ti.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
>> Cc: Ryder Lee <ryder.lee@mediatek.com>
>> Cc: Stefano Babic <sbabic@nabladev.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Weijie Gao <weijie.gao@mediatek.com>
>> Cc: u-boot@lists.u-boot-project.org
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>> drivers/ram/aspeed/sdram_ast2500.c   | 2 +-
>> drivers/ram/aspeed/sdram_ast2600.c   | 2 +-
>> drivers/ram/aspeed/sdram_ast2700.c   | 2 +-
>> drivers/ram/imxrt_sdram.c            | 2 +-
>> drivers/ram/k3-am654-ddrss.c         | 2 +-
>> drivers/ram/k3-ddrss/k3-ddrss.c      | 2 +-
>> drivers/ram/mediatek/ddr3-mt7629.c   | 2 +-
>> drivers/ram/mpc83xx_sdram.c          | 2 +-
>> drivers/ram/octeon/octeon_ddr.c      | 2 +-
>> drivers/ram/renesas/rzn1/ddr_async.c | 2 +-
>> drivers/ram/sifive/sifive_ddr.c      | 2 +-
>> drivers/ram/starfive/starfive_ddr.c  | 2 +-
>> drivers/ram/stm32_sdram.c            | 2 +-
>> drivers/ram/stm32mp1/stm32mp1_ram.c  | 2 +-
>> drivers/ram/sunxi/dram_sun20i_d1.c   | 2 +-
>> 15 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/ram/aspeed/sdram_ast2500.c b/drivers/ram/aspeed/sdram_ast2500.c
>> index 0d6ab79f96f..6a63b72a8f8 100644
>> --- a/drivers/ram/aspeed/sdram_ast2500.c
>> +++ b/drivers/ram/aspeed/sdram_ast2500.c
>> @@ -420,7 +420,7 @@ static int ast2500_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops ast2500_sdrammc_ops = {
>> +static const struct ram_ops ast2500_sdrammc_ops = {
>> 	.get_info = ast2500_sdrammc_get_info,
>> };
>>
>> diff --git a/drivers/ram/aspeed/sdram_ast2600.c b/drivers/ram/aspeed/sdram_ast2600.c
>> index 2cf9296468d..5bd3ed8c4ea 100644
>> --- a/drivers/ram/aspeed/sdram_ast2600.c
>> +++ b/drivers/ram/aspeed/sdram_ast2600.c
>> @@ -1158,7 +1158,7 @@ static int ast2600_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops ast2600_sdrammc_ops = {
>> +static const struct ram_ops ast2600_sdrammc_ops = {
>> 	.get_info = ast2600_sdrammc_get_info,
>> };
>>
>> diff --git a/drivers/ram/aspeed/sdram_ast2700.c b/drivers/ram/aspeed/sdram_ast2700.c
>> index 8605a92abb2..b8c2f5336b2 100644
>> --- a/drivers/ram/aspeed/sdram_ast2700.c
>> +++ b/drivers/ram/aspeed/sdram_ast2700.c
>> @@ -1021,7 +1021,7 @@ static int ast2700_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops ast2700_sdrammc_ops = {
>> +static const struct ram_ops ast2700_sdrammc_ops = {
>> 	.get_info = ast2700_sdrammc_get_info,
>> };
>>
>> diff --git a/drivers/ram/imxrt_sdram.c b/drivers/ram/imxrt_sdram.c
>> index 3df106c9b79..f5a1e5e60e0 100644
>> --- a/drivers/ram/imxrt_sdram.c
>> +++ b/drivers/ram/imxrt_sdram.c
>> @@ -434,7 +434,7 @@ static int imxrt_semc_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops imxrt_semc_ops = {
>> +static const struct ram_ops imxrt_semc_ops = {
>> 	.get_info = imxrt_semc_get_info,
>> };
>>
>> diff --git a/drivers/ram/k3-am654-ddrss.c b/drivers/ram/k3-am654-ddrss.c
>> index 21ff9d761e1..13a11f0626a 100644
>> --- a/drivers/ram/k3-am654-ddrss.c
>> +++ b/drivers/ram/k3-am654-ddrss.c
>> @@ -1078,7 +1078,7 @@ static int am654_ddrss_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops am654_ddrss_ops = {
>> +static const struct ram_ops am654_ddrss_ops = {
>> 	.get_info = am654_ddrss_get_info,
>> };
>>
>> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
>> index c406998b20a..4595ef47b9a 100644
>> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
>> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
>> @@ -1011,7 +1011,7 @@ static int k3_ddrss_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops k3_ddrss_ops = {
>> +static const struct ram_ops k3_ddrss_ops = {
>> 	.get_info = k3_ddrss_get_info,
>> };
>>
>> diff --git a/drivers/ram/mediatek/ddr3-mt7629.c b/drivers/ram/mediatek/ddr3-mt7629.c
>> index e9791697066..597f9e51ad3 100644
>> --- a/drivers/ram/mediatek/ddr3-mt7629.c
>> +++ b/drivers/ram/mediatek/ddr3-mt7629.c
>> @@ -750,7 +750,7 @@ static int mtk_ddr3_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops mtk_ddr3_ops = {
>> +static const struct ram_ops mtk_ddr3_ops = {
>> 	.get_info = mtk_ddr3_get_info,
>> };
>>
>> diff --git a/drivers/ram/mpc83xx_sdram.c b/drivers/ram/mpc83xx_sdram.c
>> index 28a663289a2..9003febd7d1 100644
>> --- a/drivers/ram/mpc83xx_sdram.c
>> +++ b/drivers/ram/mpc83xx_sdram.c
>> @@ -1074,7 +1074,7 @@ static int mpc83xx_sdram_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops mpc83xx_sdram_ops = {
>> +static const struct ram_ops mpc83xx_sdram_ops = {
>> 	.get_info = mpc83xx_sdram_get_info,
>> };
>>
>> diff --git a/drivers/ram/octeon/octeon_ddr.c b/drivers/ram/octeon/octeon_ddr.c
>> index ff2899d7484..23a36fc32ae 100644
>> --- a/drivers/ram/octeon/octeon_ddr.c
>> +++ b/drivers/ram/octeon/octeon_ddr.c
>> @@ -2710,7 +2710,7 @@ static int octeon_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops octeon_ops = {
>> +static const struct ram_ops octeon_ops = {
>> 	.get_info = octeon_get_info,
>> };
>>
>> diff --git a/drivers/ram/renesas/rzn1/ddr_async.c b/drivers/ram/renesas/rzn1/ddr_async.c
>> index 4d470aae191..306193f8678 100644
>> --- a/drivers/ram/renesas/rzn1/ddr_async.c
>> +++ b/drivers/ram/renesas/rzn1/ddr_async.c
>> @@ -250,7 +250,7 @@ static int cadence_ddr_get_info(struct udevice *udev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops cadence_ddr_ops = {
>> +static const struct ram_ops cadence_ddr_ops = {
>> 	.get_info = cadence_ddr_get_info,
>> };
>>
>> diff --git a/drivers/ram/sifive/sifive_ddr.c b/drivers/ram/sifive/sifive_ddr.c
>> index c555d2af2d0..007989c4f16 100644
>> --- a/drivers/ram/sifive/sifive_ddr.c
>> +++ b/drivers/ram/sifive/sifive_ddr.c
>> @@ -387,7 +387,7 @@ static int sifive_ddr_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops sifive_ddr_ops = {
>> +static const struct ram_ops sifive_ddr_ops = {
>> 	.get_info = sifive_ddr_get_info,
>> };
>>
>> diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/starfive_ddr.c
>> index e151179398f..9083f421b41 100644
>> --- a/drivers/ram/starfive/starfive_ddr.c
>> +++ b/drivers/ram/starfive/starfive_ddr.c
>> @@ -138,7 +138,7 @@ static int starfive_ddr_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops starfive_ddr_ops = {
>> +static const struct ram_ops starfive_ddr_ops = {
>> 	.get_info = starfive_ddr_get_info,
>> };
>>
>> diff --git a/drivers/ram/stm32_sdram.c b/drivers/ram/stm32_sdram.c
>> index 954995c499c..533892582d6 100644
>> --- a/drivers/ram/stm32_sdram.c
>> +++ b/drivers/ram/stm32_sdram.c
>> @@ -395,7 +395,7 @@ static int stm32_fmc_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops stm32_fmc_ops = {
>> +static const struct ram_ops stm32_fmc_ops = {
>> 	.get_info = stm32_fmc_get_info,
>> };
>>
>> diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
>> index 5f9b91d50e4..1c50e3164f8 100644
>> --- a/drivers/ram/stm32mp1/stm32mp1_ram.c
>> +++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
>> @@ -397,7 +397,7 @@ static int stm32mp1_ddr_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops stm32mp1_ddr_ops = {
>> +static const struct ram_ops stm32mp1_ddr_ops = {
>> 	.get_info = stm32mp1_ddr_get_info,
>> };
>>
>> diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
>> index 79cf0a51e47..ae2b421e1cc 100644
>> --- a/drivers/ram/sunxi/dram_sun20i_d1.c
>> +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
>> @@ -1431,7 +1431,7 @@ static int sunxi_ram_get_info(struct udevice *dev, struct ram_info *info)
>> 	return 0;
>> }
>>
>> -static struct ram_ops sunxi_ram_ops = {
>> +static const struct ram_ops sunxi_ram_ops = {
>> 	.get_info = sunxi_ram_get_info,
>> };
>>
>>
> 
> --- Thanks!
Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
