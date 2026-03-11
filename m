Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B70B1062878
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 12:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5F683F2A;
	Wed, 11 Mar 2026 13:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T+KKGSNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471B883F14; Wed, 11 Mar 2026 13:11:00 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B2B83F53
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 13:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk/YyrnhFxlGepZVyaLZsWIn3hjX9HVUzwpyGOLcxJTpdyI4mBaWYF98XZlf0CTiiGB5ojZMlfWf0IE2gl+gJBcBOe4Yk92xNg0NRFIsuCViaTJDQUbXJWeDNz5hz1YG8+ydLOiBX+r/BSE0kdZ5KZBUbM8dCeyDDo0K1/L8I/gd3QjoK7yEg8ZAGfWU6TKE1PMoXRkfCc+tSTXOQuvhSKnjPkK33ucJOp/LvDKEunUrMN5e6AtnKRiCCNFKiNvUj807WnHbLZ4ykX9tGri6x3htoyAym4PHTZTkoREvgH6uV7LzKan/Y6MtVta9VciW+oduW0+sFxTn9NhcHig02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXWfuezwfSGkUdFRTmX2UUD6HxeNoVXHn2Oe2n+XJ1w=;
 b=vYaIFOFUtn7R8fIgoTBIRyvKguksogcvyNiHr6KeqtKDtd4ZMTANoQMBZkLD+lDJ13V46p/JeAH1Oz4WYN/2RqxGAMSFrcxWif7B7S64c2/LYsq9FphxULc/Idad6Y5e1nDMTFB7y8zBdoQl++fBvhGAAuhc2z46HGw5b2cG1prkj+DSs0pJxLWFCxfissZDMlXNYIA7ZcVSn2kfU0A3yymbjzgOOletVJBG8XW/IrtE46XcHZ7rf7wrRFFwLaRu5Jb5ou5DPX3wgKwn0i6ifCxStMYN4S4LptM1fe4+PWwkKij8KLgUHti3Fq9BLl0VD+igVTrUjGe/tjSdLerPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXWfuezwfSGkUdFRTmX2UUD6HxeNoVXHn2Oe2n+XJ1w=;
 b=T+KKGSNY5lG8WC/ZjASveUQ25QMKEcEFB8bTV+eogtyOxlYE6jqK8NH3a5u0kiSY3gEXxcw311sBo39dfpBWGXQoKZFAmvHlEVZEb/FrAKIql/wXa0ruE8SCuTOU6oCWE1DQL/G96KEJA6LLcNJMo3ifnlirvxNnpstM/mKvzCg=
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by MN2PR10MB4286.namprd10.prod.outlook.com (2603:10b6:208:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 12:10:53 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::4f) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 12:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 12:10:53 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 07:10:53 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 07:10:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 07:10:52 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62BCApd6296293;
 Wed, 11 Mar 2026 07:10:52 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Mar 2026 17:40:51 +0530
Message-ID: <DGZXY32XHWLI.1BMD59GMUJQ6Q@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Suhaas Joshi
 <s-joshi@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>, "Udit
 Kumar" <u-kumar1@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH next] arm: mach-k3: use Kconfig options for ATF/OPTEE size
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
 <20260311063454.GA9300@francesco-nb>
In-Reply-To: <20260311063454.GA9300@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|MN2PR10MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: dd278d5a-bbd5-471e-c637-08de7f673e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xZGSNejScUSSoYtp4Mz4JrddRqfKFLN1ZtS2erAfL1iMU25nM2pElHyOV2zt8cvljWahn6HCnFeCBA+MlfUs8YAqsUwmvkd+wIJAzphcRW0qjWrCzC1ZU4PRjd1hzrmcEOKXbau9FjThSnpHxlSxy0muVJgIBG3OkFVeHlZM6Sx21hlyYEskrDj7oLPHggxq/0h7mM9XdvlMEC0hNiCz1L7rgryPmuVrJMIkdnCMV8nFZBLohMX+F0hK1dYWB9d7/uW3+hKU27OZLiyZ20uWgsAZOWeQtsTeKkHwoBFYHxlfAIUHe9L3kuI4t1IFIZSYlyEZ9CkDSn1isYwF/XS7NoH9H12ODfOJS62FvUqBWmzs+CZ+sX6S8EV810g90JWlQFgE8UOjBamZBhzqT57XspLqPm+WWStcgZKzkhD7ERs9MPYd86yVV9UMmiAMhXSTPlu8UGEiK1NFIMrg4QNO6QVbg5tiyJcpxnKUI0/ugPBdD9NQTHfSnhT+aaeMIYnpto+jvVtPrShrUnenjxBerjgDjPXH8rJR4L1t6l5Bjalv1LmEskqkEpZnaXXo8dyyNVH/JwVzAYpy8KWzaLkRHJUU7MEM0NRagaOQSoDjPVW22G56rZb0wVUqXrN9fDTp9Job9YQl/4EO2pPW2tJxQYprhe0mUFYEcXkNl0HxF8k62P/DXs6+BverhloyxdWM6rr3FfDVZgSxz6lK6V5/WSdP81PXgP85ozkaGbCUnPw=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FnYJ1CY6jxVFmU6vwFTbq+ucI+LazkNdflk+XkgWbsP2MbA52DdLa7bdFumzIXOnLkFuIKpgsLFv4DRkDhxAnE3mDhimQdiky5miDh+a0XpahWLvogLG30QJaiXluYgBwc+Am85YOEaQtLG50ZTGn49nZGzKFetZNTdUtLlAGxC1DvoLg9DhHzhMuUfAk+ISSreXEjX4g4HCtoB8ZADA+zwHNbWw9KoXNhQUnOxPIcPPZJndaKci/ZVFP/drMZxp0mlj679Q5h0E0rGjx4BPZkPgyWqhP/1ad0G9w9qv4tn+OYSYQL8PwIozbkoTw1TjjjkDJKK5FBGpBdSCx5aZy9I5UfkpCJGF8jyJKkoYnt/OzmqTF/qbIvXwQk3N88dBbWhqD5KI91qDCe9DaEnimXYORS7P6qouTDF/Te0wDsyrm3DA98LmGYpZYmvDNmmH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:10:53.5731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd278d5a-bbd5-471e-c637-08de7f673e50
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4286
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

On Wed Mar 11, 2026 at 12:04 PM IST, Francesco Dolcini wrote:
> On Tue, Mar 10, 2026 at 02:36:27PM +0530, Anshul Dalal wrote:
>> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
>> devices, this patch replaces them with a Kconfig option allowing for
>> easier modifications.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> ...
>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 1b8c0b1eb96..ba1130a7996 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -130,6 +130,14 @@ config K3_ATF_LOAD_ADDR
>>  	  The load address for the ATF image. This value is used to build the
>>  	  FIT image header that places ATF in memory where it will run.
>> =20
>> +config K3_ATF_RESERVED_SIZE
>> +	hex "Reserved DDR size for ATF"
>> +	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || =
SOC_K3_J722S)
>> +	default 0x20000
>
> This means that J784S4 has 0x20000? Is this wanted?

As per the DT[1], J784S4 also has 0x20000 bytes reserved for TFA.

[1]: https://github.com/torvalds/linux/blob/b29fb8829bff243512bb8c8908fd394=
06f9fd4c3/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi#L36

>
> Francesco

