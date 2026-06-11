Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92D4CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25A5B841C2;
	Thu, 11 Jun 2026 14:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A/VAHS6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D674A8484A; Thu, 11 Jun 2026 14:55:18 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AFBD83FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9wm0ctfLhGLsUBIOPSErvtRLC/z4qTULPBChc2HgJ5o1+2sPpbpptcrN3OvYfGpnF+DYFESM1wcsD2NVZvwszKzrevv7ZXDDL8GJdBAIWOdcumPS5Oc4K7znU8xHRXhgWvsQ69zMrLhrtdlK0doVmIowpvlJ2SFjLb9prZAspL8Oy1+6pLmaesB837Ya5OFllkZrxWUs2B/teKJ+Z65gKhZHBmW5/pV4QR6eV+/qchdt+NxDbiXONygSw081O3BlCAUvoS3IKfnztKMKc0aAwbNAiEUk0SK2A134CoOWE+1E5jS7mPwPqEHRr/fhmfVy6cN1ALwAm/VfdPZSIlCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9gg6YKwgirArT1qBHhksKAA9paSQrqJBaLHHNE8znc=;
 b=KVlgp+GKprCTcJFQXDDWjf593N8C85zWj6p9DKrFC0Aha1Bis9Mqp8akgs/leIbt3UjhGo+cgWcWriOgB1Q288AmKf/6+EfoaDet0ZqQzk6c5lDOhULlXL5IvlADeDQIqViLbS0V+Co122Y+wCeTvgZXZ9XRg+Ed4NvrJc2iQvscoLvcEOH8dbgz8++LltuTfrxV7fZWgq9XKiNmHkSNvw88PMjOdB95kxSi8RjrVozAOx88XJD1/3CNcBO4LRjUqvDntBtKXfZAK0PYA6ewvPzELeN4OJzz2BJ7GRoYOOmMejD5m5fPSEnSncdNBGF9bcCjV0cWFuAJi3dJVyDagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9gg6YKwgirArT1qBHhksKAA9paSQrqJBaLHHNE8znc=;
 b=A/VAHS6lvprtDa+rscRmGdKs3nq2EzZin8LiJGmPfEFX46VYs3PkMXUsS1lXJoELi7eg6pmT6w3sLbwvOTIElijPvpyz5X0V7Xx5+142voQdPPbdeWTbJL/bYyPrsSAp0nOMKIryWKhFQxmpSQlv0xh6p/au/+Jzu2dYOE6oKDI=
Received: from BN9PR03CA0399.namprd03.prod.outlook.com (2603:10b6:408:111::14)
 by CH2PR10MB4216.namprd10.prod.outlook.com (2603:10b6:610:7d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 11 Jun
 2026 12:55:12 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::7d) by BN9PR03CA0399.outlook.office365.com
 (2603:10b6:408:111::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 12:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 12:55:11 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 07:55:10 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 07:55:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 07:55:09 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65BCt6cG1342062;
 Thu, 11 Jun 2026 07:55:07 -0500
Message-ID: <61f602b3-8ee4-4c70-a9e7-96a7c61873fb@ti.com>
Date: Thu, 11 Jun 2026 18:27:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <jerome.forissier@arm.com>, <trini@konsulko.com>, <c-vankar@ti.com>,
 <andrew.goodbody@linaro.org>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <srk@ti.com>, <u-boot@ew.tq-group.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config() for
 speed
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
 <5257419be0ef387d85b7d3192ec03ca855bae95d.camel@ew.tq-group.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <5257419be0ef387d85b7d3192ec03ca855bae95d.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH2PR10MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a1979c-5592-4770-56cf-08dec7b8ac60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|6133799003|56012099006|5023799004|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: /DevpIth/lHmNH5tIHMKNfbmXA4/Qaa9+y2J0Fhj/1cLziMziqCqEndTqx7MduE3EA57BqCv3iAQQmVVgezrGtS2kXPCNxGbV3j86afI77NsO5evtXwT3SGzfA9wWnWg5zTp1ta/WE3mi24pJPhLGFbIjcPul79ei4mHtHkLsIqO8Q9FwPOt/iJwl5AIKcdjRH+JPxYWUp0+W8ZhVy26CiKjFFg4mnTCcTk3PDLoo7C797QFCPrQu/ZWIrSb2F1vUhsLfgo3KySBSJkIzhw82l0ucw2yK9tjg/xTeUaP3D1iBoxptIn4sEHXQ6FXJMu5by8UqqW6RXUw8WuQTyNiIZfSYa+/ZbfvMFaH5EVooyHHBJwXhyRh5fQLYMV5dQok+rYEbS3aKAWU6PBXh/Y+oHeXqJhk/LfRl2TJqvrHci4Gb6PrLoIvt/51LbN+JhHzDyr+n0WrbqHzg38Uij3lzbJRueQZCK4s2e+UEP+J1BYHtgKrN6ZoA1JZAiv+/xYfYmEZ9zDY7LWvUoLFebrxM3g3g/qpgNmYUADvtWwaz/HT0b7ux1spLyD+wCUSJAP/xT/G059Nrbk6Pn0l++HHrutqDphDnONsEjXpfQM7Q/++B7IATmUpnP3LmK20V7+p1myqHZDbuoiI2kLoCdfqIGPdUd+8DJwnl0YJ6ZrzSM5axG2JGZ8aI5HTcXCvx90OsnS8SxK/Padrr85Sxn6xayRsH1y/8HEng0rgXxv5aMU=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(6133799003)(56012099006)(5023799004)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o65U5lBJdboU3fOUEvFZeL/LYHPYFn8PkSQsQV25UTzcQltImSCPbI7v6V2NSsyoNGqa5y4FrKaySP5xqGBxwjeKu2wUBlJ4M2eHjJgd8aI7Jv4+Tagrn/9oauFyOfrh3fNGRDbSI91izc1nQcZ6SHCMpWzr7tfhOkYUnKS4XHdnEUukB+pR117tU4EdR1FEOzyZlgMuXcZpMnTiywdvYG8poCOFugdTA8sn5gW8/A7lR4HmjBQvXu8wa1S2j6RjrSOkVD3lb/qIe1uluJcCGYeuRQJqT1n0ec9xVWnwIxU7m6SQpza4oZFacE5aqqYLoOwlI7T8XNNBdEq7YHPqIifZ4cggCuMYTl930XjYBTT0PkCgfJARz8dj89czDwQWMJmfw0NEz3qHwltoqryro5Q5yQre2lF+g3jdn9TnJKRtI/W3DMI7e4XimXvaAXlc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:55:11.1953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a1979c-5592-4770-56cf-08dec7b8ac60
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4216
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

On 11/06/26 18:07, Nora Schiffer wrote:

Hello Nora,

> On Thu, 2026-06-11 at 17:36 +0530, Siddharth Vadapalli wrote:
>> Currently, phy_config() is invoked every time during am65_cpsw_start()
>> which guarantees robustness and also allows recovering from link
>> failures by resetting the Ethernet PHY. While this is beneficial for
>> system stability, for use-cases where speed is prioritized over
>> robustness, the existing implementation is insufficient.
> 
> Hi Siddharth,
> 
> I wonder if making this configurable is actually the best approach, and if we
> can't find a way to make phy_config a no-op when there is already a valid link.
> Is phy_config() actually needed to recover at all? I would expect regular

We have automated tests running frequently on a daily basis which rely on 
Ethernet to transfer Images. We have seen intermittent failures due to link 
stability (frequency is roughly once every two weeks with hundreds of tests 
running daily). With an unconditional invocation of phy_config() 
independent of the link status, the failures fell down drastically (close 
to none if I may say so).

> Ethernet PHYs to reestablish the link by themselves - I guess 1000BASE-T1
> Single-Pair Ethernet might need this?
> 
> Some background:
> 
> In our vendor branch of U-Boot, we have reverted commit 05dc050059d2 ("net: ti:
> am65-cpsw-nuss: invoke phy_config() in driver's .start callback") because it
> made PXE boot with U-Boot's default config path selection pretty much unusable:
> U-Boot would try a long list of TFTP paths based on different identifiers like
> IP addresses, each time using a new TFTP context, thus resetting the PHY and
> reestablishing the link dozens of times before arriving at the correct path.
> 
> Another solution for the PXE problem might be to refactor the code not to
> shutdown and startup the Ethernet for each attempt, but that would not help
> scripts that use separate tftp commands or similar for a sequence of file
> transfers.

My interpretation of the above makes me believe that the current patch is 
exactly what you need so that you no longer need to revert the commit 
quoted in your response. The symptom that you have described (thus 
resetting the PHY and reestablishing the link dozens of times) is prevented 
by setting 'am65_cpsw_phy_config_once' environment variable to 'y' with the 
current patch applied.

Please test it out and let me know.

Regards,
Siddharth.
