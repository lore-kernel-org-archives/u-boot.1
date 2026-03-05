Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61191F33A7D
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DA483E81;
	Thu,  5 Mar 2026 15:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fyg5KxVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6B981E18; Thu,  5 Mar 2026 15:55:05 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792FB83E81
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovfCZ3vQaXCyne47EcxaSV/MaHHG1QCWtEpq05nJHAnpSlX9/uVh+yU5loyOtsEP7YuobqWTVHlPmOG36p8NzLBOy8Gt0mPvzx26F474eZwJEap3YncE4sIakUn8XxIIDSEmA3K2NCfMX9fo9eXaWJVVPZ47oRI1F03j4oSmSQbSxt4bv6tI1E+OhLMs/m+oLy6nBNkMLS2hWQi3ILpwRhYrklf/P33thsyzQHZQ2KGW4J+CVQF2WDAOzks5VxEI0sRvmA1xY+n1WRaH4iMqC4gcbAdegkJaH9x9LwAdsW/cWDuvMZg70J19G6ZJyM15gwVNTR8lgKm+Nwc9dnctVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTVWZaUj6fIKdd/fzKY+rRdGiqlyGS8hdSHX+jrppc8=;
 b=yw1Ib+PuQVoY+acGPO6DdRsanZD8mXHvQGza/DWjW5gwTpvPjJcHlmtkm9Q5+bDkGDo+/E7oCQKi6KA7xM1gz2KtI4K7AwRcO//HtM9CxNKd8zjPaXldnlnYHwy1qQcPvD/DprBEBMq74+vUVAmrN90iuFvkkUkeQ+SMDIPi67DlYBreEh+s2TfnsZ/aIsgKxGmP5aPBiVUpcYPR9EeHmP1dTqTBYyOElSCNtxWXKd/tsgjbhx/mDOATjN1y94FizgDEZtqW1HtDHypq+WwJ/PFR+8jy0Sg6X1jD3d84p+8chtgjJDVrRsfbGDFgbAdozC8ZhRlKEdyBxxXdKQmkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTVWZaUj6fIKdd/fzKY+rRdGiqlyGS8hdSHX+jrppc8=;
 b=Fyg5KxVP4LHujFDVc97+CLKm8w5iskfbTz3Sw7pfHBJFwxZRyhOkOMRMbzcaSV2Kapdmdnu77nHXQhs65IrusiM4ecq/oc7xG2FXOEC/SKPdCC5oxuGdFWbgQxKHAKQQGjMml2nCkqVdLy/RITuj3K/MZL2B4q788NyPSVuPRCk=
Received: from MN2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:208:23b::29)
 by MW6PR10MB7657.namprd10.prod.outlook.com (2603:10b6:303:247::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Thu, 5 Mar
 2026 14:54:56 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::db) by MN2PR11CA0024.outlook.office365.com
 (2603:10b6:208:23b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 14:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 14:54:54 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 08:54:34 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 08:54:34 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 08:54:34 -0600
Received: from [10.249.139.123] ([10.249.139.123])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 625EsW4l2028994;
 Thu, 5 Mar 2026 08:54:32 -0600
Message-ID: <5256ee0a-a927-46de-b9c7-3bb52403dc0c@ti.com>
Date: Thu, 5 Mar 2026 20:24:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: spl: spl_dfu.c: Fix warning associated with PCI
 subclass_code
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
CC: <trini@konsulko.com>, <lukma@denx.de>, <u-boot@lists.denx.de>,
 <srk@ti.com>, <s-vadapalli@ti.com>
References: <20260305103815.999886-1-s-vadapalli@ti.com>
 <87h5qumnjl.fsf@kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <87h5qumnjl.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MW6PR10MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c532205-83e4-464b-09d5-08de7ac7298c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: HLCO25WXMvwUZTKiMI+QsZiI9h1w04Qf/UDCaYiIXtVmeiiE3Jb9vr5h8ejAYHobRuAoOgm+615VrDGIR00Q4zCgPrVvs+UJNa58WdAO2zW8epX3I6hd+TXNxNwLc0NEq4VFBhgTO/cOLeZuGUsO+44wlMNMDGI4PUDyU+M1VTHov6WnmZhK6hrDN1sagCYZj+wC2K2qQM+AlYpDjQOF5BQ7uJLCmloHRx4Vt/E14gQo4gJFa0SeyMG+haAIJFo+nGbZ0IXGBt9sLu2P4Yy7HDB5Ccbi8sZb4QCTHiyRqbFTsJ8+J4bUPlBYDod95LC0IYWbCfxn2OvKFFGWOu495CMtr1xy0/+WiC/4E3kQARGWKLXgAtikcX3FZ/Ve24NGVICl5WQPJZ0nOpcfeiuvHuffErzbGcmQ9Pr3v9JH7BgT5ggN/k6FbsvYCjNpoLxKVB3fNwQvRZWGUJZ0iif4jOm7oWawWg1NtP2Tk/DkLV1Knz2uDbrxqkmRx74o5g8cG6iyANPoIQcdeO85wTMqMNzUgWP/UrI2qhVEWZBK9nvSEPjFWnxQvYP0v/q2eql/dMMCeZrUHL3duWF9Vu95DCrCig0/lO6tIb2hkEHsdhSlGG6vEQ8VekZzyQLXfSEmmM1eBj8mdqyWr8eflVwismofh4XFoBW0zw87DN+gPCSB7LnjL35zAZppobcPKvW9IzUVoDFrMYzobvZxleQrzOxLUrSxk5nd1+3gpFTag+cw42aaz7BzgMIXSYirtuInMzMabariJ5USGryeWyKX4g==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(376014)(82310400026)(1800799024)(36860700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IgwsLFcoJgL93+dJmmEY0MMW6xYmpRMjygoW6hBIGgejTQxkNrAPzlMlk1P5ohEUHXGeSx6Mu1xoHpKtmpNIYqysxjS6AzIEC7tr2aEWzkvlQx2oiqqTAtEt7q7Y/be8NA565k7dFE8ELMxqmi/1oR2mXtztTDnvs4ciayUscIvtNHGIxpg6+YfKMqutHV+82R0QbApvNnWrzLmlngd0Tr3LDkwoIqNppSptXQcZ2Y9L7AaXK8+KiWASWlqr+Z5wX49LwzwG20BBjS0Sqy/vs36fQCDqjHLRMeaH7mK+VU5i8M5wrqMDlvg0/f36L/Xzw1dMVV/IrfESk8RfqTygO/tuJyzzYjJAjKYSyPiB6hXHHZM+JssIc0rxErNJKd/tCHDt89qwrt65AZRlUz905x0HeAhVNrqESJI40HbBmnuYFVBhodkrHHM6Y0b0oCYl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:54:54.6186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c532205-83e4-464b-09d5-08de7ac7298c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7657
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

On 05/03/26 6:38 PM, Mattijs Korpershoek wrote:
> Hi Siddharth,
> 
> Thank you for the patch.
> 
> On Thu, Mar 05, 2026 at 16:08, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> 
>> The subclass_code member of the pci_ep_header structure is a 1-byte
>> field. The macro PCI_CLASS_MEMORY_RAM is a concetation of baseclass_code
>> and subclass_code as follows:
>> 	PCI_BASE_CLASS_MEMORY: 0x05
>> 	Subclass Code for RAM: 0x00
>> 	PCI_CLASS_MEMORY_RAM:  0x0500
>> Hence, instead of extracting it via an implicity type conversion from int
>> to u8 which throws a warning, explicitly mask the bits to extract the
> 
> What's the exact warning string? With which compiler version?

u-boot/common/spl/spl_dfu.c: In function ‘dfu_over_pcie’:
u-boot/include/pci_ids.h:48:41: warning: unsigned conversion from ‘int’ 
to ‘u8’ {aka ‘unsigned char’} changes value from ‘1280’ to ‘0’ [-Woverflow]
    48 | #define PCI_CLASS_MEMORY_RAM            0x0500
       |                                         ^~~~~~
u-boot/common/spl/spl_dfu.c:67:29: note: in expansion of macro 
‘PCI_CLASS_MEMORY_RAM’
    67 |         hdr.subclass_code = PCI_CLASS_MEMORY_RAM;
       |                             ^~~~~~~~~~~~~~~~~~~~

> 
> Is there an example defconfig that I can use to reproduce this?

CONFIG_SPL_PCI_DFU needs to be enabled for the warning to be displayed 
and will be seen in the context of PCIe Boot.

Regards,
Siddharth.
