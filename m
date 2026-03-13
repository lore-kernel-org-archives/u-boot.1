Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3A7106FD9D
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 08:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5813B8420D;
	Fri, 13 Mar 2026 09:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c2zIeg1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA69A84221; Fri, 13 Mar 2026 09:38:31 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456178420C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 09:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7IubQOoCMrGZSMvc813u8XkAzu4W6hXi+56nC2MIPXqgQ3Wes9+HkLLBeaAPx2GyZIkhIBDIBGN1I6XVMAQmfsoiE5rKiE3dt01bU8R+j5NXF4SJfSVSpxOD7Y/zon1X3qBtTtvn00QngcTYb+Dvq4OziXmTSRcrmxnLJBRvjsgPhVK6e4SmJtLM9yy4eihzA5/xdAinZrGtdp38rqgChxxcufuhc/AjhAEzzrld48klGKiFj9CyOgiosWXUN6iVZ1fvD3IACcqOt0JFyYK2KV7tNRnZlsaOG5qCLtqGafY8TAQv+muYIXEMZfMTyYn2PsXIwbqWn1t9Z7e11Bf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li5lPeTAtBkXEOsWHhiRrkkkS2vp5affi1tHgKAMhaY=;
 b=Qwme2h3pN135VGMlszTq0rJnKTihCfupETa+q58ScUgVj1pG3DmsOv3LlTjZGr/c8STfX6EpHGYLhFUoEwcyJJYs6SS+dkQqwH1+Dm8PE78RDeKfK6zBW/GF3+ZVeIoBuc8tlvm91vGFSutuU/Nvlen+40RCwdbQu1MOMZSCV4Rhx86u0iSFAfR4RNxXkwQ+PkWoDwvwVIfH0+DieRXuUx50iOdmuhIF4kFxX5tg05+cFh4zAV0HIPeTXAeK/j55v5dP8umg5j8DViOvUb2rhLJpObljwxrdTDVT7ja1CU1H98cJwy7U5rG5RteLnXV/mD9UlTKA89xIF7LeRT9A5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li5lPeTAtBkXEOsWHhiRrkkkS2vp5affi1tHgKAMhaY=;
 b=c2zIeg1uSGGOh3omhiTM0SE3yobv4R2L1ZgjKUwediNRhQUuU97kzBrQ/R+eFg7xNu6FWCtFMBm1OOL+6hI1cr1Fi8vNm+2u4ePDX60Loj8W/8KhyWytGnJyOrO2wvUYyg9IIjJqiGwLfi8FqHkOYbJxn/bnad1+epnD4LiNHSw=
Received: from BL0PR1501CA0032.namprd15.prod.outlook.com
 (2603:10b6:207:17::45) by IA1PR10MB6856.namprd10.prod.outlook.com
 (2603:10b6:208:423::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 08:38:26 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::ab) by BL0PR1501CA0032.outlook.office365.com
 (2603:10b6:207:17::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 08:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 08:38:25 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 03:38:22 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 03:38:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 03:38:22 -0500
Received: from [10.24.50.71]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62D8cJmt234930;
 Fri, 13 Mar 2026 03:38:20 -0500
Message-ID: <6a62fbd9-2a0f-4783-8529-1e42c6ec496d@ti.com>
Date: Fri, 13 Mar 2026 14:08:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/2] k3_*: Add config fragments for inline ECC
 and BIST
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>
References: <20260226122508.2269682-1-n-francis@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20260226122508.2269682-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|IA1PR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd6f2d9-62d9-4627-c383-08de80dbe4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: uCzyoO2NBwk2QZcjk3mvvqFP635pwvJTPvgtd9Qp0UBymCfkKQySbdrSC3xFyK3vfY9qmpiQOcvhsGoo3sAA8brCnQD5XwJXnUPfn1yOgYbRMx9GYGb9MN9O5Wq1E0eOOHbFm2Q/YXqEb90tdSpi6Y9cV/ThfoW5Ub4ksWKuhWLz/XCdZIKOjD9S+bs+ooDF3ciEfn3jceVofY1lPvm7w5gihBrYSpr2dWXSa5zaiRHs7HxMUZDfwliWnOWf1WRVt0iAgmP0RYRNg1XpHU7UNVKmD8JnshrdkgopTIN+Xwh9x7JcnLlfc7Geh/JeXvoBClDdj2990w48xwAKNB/MnYdhW8vcYyfuJgO/67FI2hnjPy+gpYBA9dXFN7JjKBxTN/w6l0P5C/YHC5Vn55ZFQwSBfgtveCdANVOHJQFf9UCgbia9zkbtYNxOU+rEcKY4rW6WrhdI8G6nEIRl17xYUbM2bLf9Vi1kLPRroEiuJH7uZDgtS2/zk3to2+UF/somUfcazYcgn+OkAfCp1RFl5C5Oui2an+7uUDEib7/iyGaMw0V/mNH5gg6IFzhFZlh0S9zf6s071timZw2pXHvoV8w0C7DMkRPcGkUlDfnq/4dDv3QChsr994BbYRNn/iIdDr63qc7oLIx7dJQGG1uywDG4PElRzW22/WcuvmfL52LRW3KVKRHeKTRiFIE3zdHCDzbHB1hfd0wIMjM4yr6qrsfQdN7J2epJGzA5JsLLeLDG9MD5OCQar2onmag9N8muxoODHaaU5YSEUo88PC6auQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tJdy2by+rcWsHTaoXVy60xy+/jYgJ1FBVlBHW2C4Ng465SxVjV/H5zo1BMKuikit5VLqb+gQcssqpXc1oooAfat2k5s3WBu4oEhMX2KqprbBT0tSF5uk1ncpIIn5gfsItwb2Q9BsS8NvmgCNxyY+YvK7zhaXkA3L5QRIXAD5FD+yz0ZaONQsSLe3h85tRdfRHsraWeGfjwdw8mu3YZ/gtbUQyJvvWBsoR0ctOY1YVlQfqigPIcJMWY5qpnyHr6hLLOSlz6dMz2gGC/Lc+4B0tQ6JRG3dQbB5eBjonrllDOmtRLc426HPW2QdOt4K5mkPnweuerkoQlsaPHJZxGulIYiSlXcxOR0Yo4GJlNWDQMD5TE/u5F32agalQGrEYOLS4Z8FCTdjN0atOPLzCbuLD1FIUEWDR1f/SfTUIoJ2o5Hl4AdcKQOUwiRF45nGS5RY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:38:25.8095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd6f2d9-62d9-4627-c383-08de80dbe4e0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6856
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

Hi Tom

On 26/02/26 17:55, Neha Malcom Francis wrote:
> Typically we do not enable these configs by default but would still like to
> have the option to start building them in our default build flow for
> testing. Also there is the added advantage of users being able to see what
> is needed in case they choose to enable these features.
> 
> Changes since v1:
> https://lore.kernel.org/u-boot/20260220091532.3584771-1-n-francis@ti.com/
> - move fragments to board/ti/common (Tom)
> - add doc patch (Tom)
> 
> Neha Malcom Francis (2):
>   configs: k3_*: Add config fragments for enabling inline ECC and/or
>     BIST
>   doc: board: ti: Add support for config fragment builds
> 
>  board/ti/common/k3_bist.config       |  1 +
>  board/ti/common/k3_inline_ecc.config |  1 +
>  doc/board/ti/k3.rst                  | 66 ++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
>  create mode 100644 board/ti/common/k3_bist.config
>  create mode 100644 board/ti/common/k3_inline_ecc.config
> 

Any rework or so needed on this or is it good to go?

-- 
Thanking You
Neha Malcom Francis

