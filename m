Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BF9FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65ADD84661;
	Tue, 28 Apr 2026 12:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qxDFnSij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB5684666; Tue, 28 Apr 2026 12:58:45 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF1B8460B
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwpBqCFG4wq9N2jxrpuVKy2G7esQUUPOdWOSBWyG7oQ1MPtof7WnCrb1/NqDcBd7HrzTDbX6+LgJJqkcYxpWqIJ+7laXfoPN2lVkDS4A4KtPbuAvscGX2HCFSi+arfvU/C3SxJ74yorWQoPCLblywCiko8V8Mf0dPlLVn+093uR3Ah0h9i4Ij55a+0Y+/f/O2/RzC+8o169c3SnOE0wgUuqQxZSFMMxDuhckxo7ibq5aTPrkElWqiXUdox2+QsmbvO/N4G+/S02nl+Jk+4wpvTJdrXhRuVrYY5FMJFhvyPAO0bHCauPEzO09MsZeGPFhTPmORsYt8R75QGM2jYDang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWnNWbn+k26S/+kP8rUFSFhI/NV1MdGQm9qBdwi9wCE=;
 b=am/mNtu2cyfMb+jYkvc3JjAwocGu8xJjm9TCap+blnyEbqzw5uCOfkTyqWeTm3d1awLPcw1DHdv0pQFnHAQkqbP03gTG4E2/BqVhiEHgG2lEFJio89zuLWpKZRgANKkL4HzxJhBOG3qzSZkuILlJh7HkRaNGpo/lnUT5a6BFqkZiH6msrFJjTIkwOzJcYuRjHCazxi6BkcRqZ5Sc6j9oWnXh54W39m8ymk6F6qrhgjQodelN8sulGtQJAySrmkk/PM6R+A6pnYu45mgATWI6LqfURglSaKzSRNpOyqt1nhHDMifY+q8jiL7c71mA04OZVc1hyavOM7Cs8wtHKZmBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWnNWbn+k26S/+kP8rUFSFhI/NV1MdGQm9qBdwi9wCE=;
 b=qxDFnSij7qj/uZ+SbgQ38VOn4D6dbJN07tLS8pb95hyAUKpfj6MlcSzZ4SG2rbB4wSK3HexVhWG8gVpuCFhZ6cNp3TYnXwYfdp+lki5t53VBQGw7R5tVihMtmkNnA6l8Ka8ZzuI6z3unBGBDXDjqBYjZu+SYmTQbg1Vm93qlkJU=
Received: from DM6PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:333::31)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 10:58:40 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::26) by DM6PR03CA0098.outlook.office365.com
 (2603:10b6:5:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:58:40 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 05:58:39 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 05:58:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 05:58:39 -0500
Received: from [10.24.50.162] (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63SAwako811038;
 Tue, 28 Apr 2026 05:58:37 -0500
Message-ID: <eeb5672e-7e6d-4137-88ec-5a4a14ed2880@ti.com>
Date: Tue, 28 Apr 2026 16:28:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] arm: dts: k3-binman: Add template for packing
 HSM firmware
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>,
 <hnagalla@ti.com>, <jm@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-6-b-padhi@ti.com>
 <177736597530.3159199.3152523537066588953.b4-review@b4>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <177736597530.3159199.3152523537066588953.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 821bfc34-283c-4a32-ce66-08dea5151b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: CTF6PA81T0NIEjKJgwbvqyNiuv8Q2chh9GRuOLkx2NZsRIXqg3fes78i97WhxjYOMbXZAFJ2/+dDkn9Jn06YW71ulP3lhsr2dV1ds3/7sz/g+Rjl/qQKUFCtBdL5Ku0SWvuwv1Yus3CK7cdKafpLpWfEqczFmbn168a2I5zo4T7lP2ObiBgpRwj8HdXX7KxyFQi9hNTKhrc61ruui8GnpetkNmcBxQ9Og8S1E6dKeIG4FVs1EBruuHrZjf71FN6VEEh6ZXpg6tvQ8wkdctdX0odGRCFtxjwGsaDsjsS2RahPVcnm9qjlJFsKYsw62EXayfmzXCv1vbivvUjxtGDn7ps3Jif38yQIG5LCQsurapvygtBjFaR7a2lZK0mRhMSrany3hTGJJD0+UnUoWNJokRgE7akNk2WN3fueJtv6vA/IQjSOcdjt7mqKtLx+H//rXlN5W6R//ZZv7Cg3ksZK6fqJZt3s7ZvHd7DE/QhmJ5GVytmrV4reAiaKQnN/J04WNduHErOu+7ySi+hgOOmyu1uM1YeRLhJ40wt5dOtj6kjddaPetLA+V2xqBKzxItS5myXAS50n8WrkRlVfOgdNUpsD0sw24pCRNlU40JZPEx0mXBG+RLX8u+wbYvf07TRapMYK7Ddv+8lRX5lE9rb/CQYli2kxddbwFFSlnBfEpyEZq/aRs4j9KkgvQDwYyC/MshVI3Hw1xyztl1Ho/NTEsHnYQ9naWA+0eQXn5l40zFuYJEUPV09tdS0W2y7vEYUSi9xgaDzMjxfoX3qv2D0IVw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R7QB717VDFp5O51oEefIWN4Bgvz6LsoKkM6k6xokzQlA6Hw3QJKxHCBMtzyk+sCGC2Fp9xnt5ZYhES4nIbVxrsVb16N+ihY0Khl9EjTP0DzRI9TxokLK7zx9E8BoC2Q5BSdoWK1DQNioV1ICX+71TFiaecQyYIvg6CPkfOnEhDsY9/16a/MclhUv6mrb4ctwBuemW1WvFhMWTM9CzLlPpqo8ZU/SqSyMu+qC7/mEekPHLFhLJaiEGzGvViW1qP/rMJyyTZHsiiPrQ5Gbd2vTB2gFjqCrYyVTD34NTnV4JUEp0V2AuVWoCGBOgSMsaaZTfjLTKYUceu6hitakkDdyAbnZdXjRGk52Dd2gx23BajyqoZ0Kxz7vJmCZFgwyP0W4xSlwFTI2ecss241cTF19IDxkAlu6aF38d1CgSfqxC0D+wAQYmOmBHjtQBO6Mm/1F
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:58:40.1591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821bfc34-283c-4a32-ce66-08dea5151b30
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
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


On 28/04/26 14:16, Neha Malcom Francis wrote:
> On Sat, 25 Apr 2026 09:07:36 +0530, Beleswar Padhi <b-padhi@ti.com> wrote:
>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>> index ad127663d03..e6bb05a0bb8 100644
>> --- a/arch/arm/dts/k3-binman.dtsi
>> +++ b/arch/arm/dts/k3-binman.dtsi
>> @@ -297,6 +297,26 @@
>>  					};
>>  				};
>>  
>> +#ifdef CONFIG_K3_HSM_FW
>> +				hsm {
>> +					description = "HSM binary";
>> +					type = "standalone";
>> +					compression = "none";
>> +					os = "hsm";
>> +
>> +					ti-secure {
>> +						content = <&hsm_fw>;
> This breaks bisectability as hsm_fw is introduced later in the commits


Thanks for catching this, will squash both commits in revision.

Thanks,
Beleswar

