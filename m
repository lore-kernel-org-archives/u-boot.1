Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92275CD6E64
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 08:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0244F848A2;
	Wed,  3 Jun 2026 10:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gUDkjcld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0198486A; Wed,  3 Jun 2026 10:13:53 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DFFE848B9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 10:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiXI4vxLMjDMVjpukCekW6PRQCEiJ39kuJbAWHZn5ImPw4sLiTxJVJl9Y/16Xayl5KU8zFbrpHqrH0ezvYNr6ylGFW/skGkqJ/hXuiGqu6gHNLOSJON7Jl/lert2zs8wbKk/6zaHIDv/VRMN1m0xYdqEmQpDBk5/vDGC92aECiaPkz8szf7YSk2ZodND/wk4dcPzN3XfGU3B11c++7b4KmZPO0yiRBhfxmnXcEPwNRNLHIyvlBjRriONt1XQhPKD/UFEyzALXo+q7Zk1NogezXTD4RYXwfmnP8uH4/WIhvc/9sQE7zKSUzu0wmlCG6M5Das/2C+7+Twx1ijwQG/Gvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omheS8L9okZbQ8iQJn0KpoAaM8fhcsulTFRT/pGG6bM=;
 b=VzeXW2EWtEUqSjg/whos9YoW0iE3eV3IvRx8Ll4clFy3M2N4Ni+5dmzwWxU93zVLvzl7oBKI+bCJYLaDP3Be083Ayqtshz8vq1MiLBeqXqJl3eSkZLXgJmAhYM0WV9ADaOe2HIGlgc+OUBwyI2o+uO1C0xVEYPpULhhUYef3XiX5tq+OHkBKmFRtMwBQSm3qj/Yhg/66IPLlWCQlUUX3OBjOMkO1xsT4QcEF22GmhPj14byk5lbiiNutEC4O6xH0WIixncQ/6Azu+7sWHWhRqMlVv19wrDfZ/sw3Yyn+DID6w9iDK6jnELUEWjJ7ThsJEeTSQZBwjtgKcVqhHeQ89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=synopsys.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omheS8L9okZbQ8iQJn0KpoAaM8fhcsulTFRT/pGG6bM=;
 b=gUDkjcldukmOl2iLrEGepZzh2vHEFsdATbO6Xfg2/Z3KNzmMqFRTqp1e4D1eBxIAPwGEcaReQTAsZ9LUZaYVtD/C3hE3kZiJLEptgykjL50ew4IvDuWRwWa4RHZbam5N3xg7cbwfUy1K4ObUqJzVfjZLnx+zk9UulrJQvFOlpLc=
Received: from BN9PR03CA0419.namprd03.prod.outlook.com (2603:10b6:408:111::34)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:13:47 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:111:cafe::3) by BN9PR03CA0419.outlook.office365.com
 (2603:10b6:408:111::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 08:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 08:13:47 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 03:13:46 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 03:13:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 3 Jun 2026 03:13:46 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6538DeWS1334960;
 Wed, 3 Jun 2026 03:13:41 -0500
Message-ID: <cc92d937-1e80-46e4-a936-21e9612a4231@ti.com>
Date: Wed, 3 Jun 2026 13:43:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
To: Simona Toaca <simona.toaca@oss.nxp.com>
CC: <uboot-imx@nxp.com>, <u-boot@lists.denx.de>, Stefano Babic
 <sbabic@nabladev.com>, <festevam@gmail.com>, <peng.fan@nxp.com>,
 <alice.guo@nxp.com>, <ye.li@nxp.com>, <simona.toaca@nxp.com>,
 <viorel.suman@nxp.com>, <fedor.ross@ifm.com>, <marex@nabladev.com>,
 <joao.goncalves@toradex.com>, <ravi@prevas.dk>, <ping.bai@nxp.com>,
 <ji.luo@nxp.com>, <qijian.guo@nxp.com>, "Francis, Neha" <n-francis@ti.com>,
 <Siddhant.Kumar@synopsys.com>, <u-kumar1@ti.com>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <b3d0d4aa-9058-4d2f-bc1c-bfb51fa4ad04@ti.com>
 <istftwxw7nnvk2q6ef4zsfuhsemupbd6fyjwwso3pqf2nagdqw@m4qujx6w4noy>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <istftwxw7nnvk2q6ef4zsfuhsemupbd6fyjwwso3pqf2nagdqw@m4qujx6w4noy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0fac50-77b2-4e34-18fb-08dec1480957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|56012099006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: urm1fMwNhCfcJwpxqTG4HalL5/K+xR1M2NSQx2X9RQCJCO6bxmxR4l9U/jrF1oxRpffc+7LhX49Thdh0Qh0UR+3skgecfmQvXQ4YOe1cjc8/d+GBwLwGnUrb0M6cvZU8Rr2RoGXtQQs/17t5Dntf1y3qSpEbTuCfgfYXLf1UwO4xRunTJzj11P6CDTmPy5UvyCBBjme338TGa1C1GoexsakPjnq6bDvQ3zj650TtJO8epUM4+PDJIVEBDLIGhFI4ULeDXtqt7CN+gY7Fn6W+FC1pAuibcu2YJkNSZmSV7oU+2G3g1kj2komrmROibM+3ynk8hk6EsV8bG2Xo8w9Sxwrj8gzuygauak11t3VIed9uiGvYu2bAhAgz590Tzrl3QFEzCuy8h0qXCZb2DYPs1qm80i2TwEkE63zcs1JcRCGqPxXzm5BD5cc/mj072koUnfEY4YW76VrRewoRcMCaO/u1hgO07+v0lja9fvdCkxt0POYjyzADufGfQQPe4uR+ANNQ8e7rdG1PQqXBP/cX+2bO1tARAu/2DrPFAIUB6SEj/UDNIttPhiSdlIJaSWNKQWtm8/zseYkm0r2RlQiy4aYvYOQLrBZY7NSAR3Op5SkMMuRTISL8L4JdEQyDdCmyaov6THvsmtKHfgCWUyh29eBu+j4CBei2neKisvh5jPwAfGQZOZxqOJlRLJGycM0WYA/3CDHi09Vt1Gd4uXz+I4M653WT+NYa5Aomao/XL8M=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z0OlcMkjI6F9eNJaieZqhRGr9lgbqd+D1QlnO7xUOvKouLQoIFEIVxUqU69XaDFO2i3E4fETU/QW4tpkRnqYN4oeq7baF92L4z6ZKRx5QfJOIT/31J78sGnsa56Mc4LRIGX15cbI6uzNQUDNccsnltRksl7fJJAsUdQihDMwWb4UANi9TPMJ3mvdisaC0ii57Ym92p5MjfN7hwsIlc7j3Vqan9f3uU7xW8zc5IRAlOudwVNVDr9OjRkhk2rLRKsP6Eqi9OrelaMNUjR+thRamXQYkBpYmbo1LFf4xB9UrX2583pGCIOAjUbULIM+C4Zd/87E6XxVxu/EkBFAm1W8q7NyLLFDpO2myus1BW6AagndzR9oOffxglg8+/ysJGrc74Q0Ioy2jLLbnsa9IqHybpMEsspi+dYeg4VUFpKrjWg7oToQSbzq7QVuRAuFGaVT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:13:47.0439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0fac50-77b2-4e34-18fb-08dec1480957
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
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

Hi Simona,

On 6/2/2026 4:29 PM, Simona Toaca wrote:
> Hello Kumar,
> 
> On Thu, May 28, 2026 at 10:55:23AM +0530, Kumar, Udit wrote:
>>
>>
>> On 4/30/2026 2:03 PM, Simona Toaca (OSS) wrote:
>>> From: Simona Toaca <simona.toaca@nxp.com>
>>>
>>> DDR training data can be saved to NVM and be available
>>> to OEI at boot time, which will trigger QuickBoot flow.
>>>
>>> U-Boot only checks for data integrity (CRC32), while
>>> OEI is in charge of authentication when it tries to
>>> load the data from NVM.
>>>
>>>  
> [...]
>>> +#define DDRPHY_QB_PSTATES	0
>>> +#define DDRPHY_QB_PST_SIZE	(DDRPHY_QB_PSTATES * 4 * 1024)
>>
>> [..]
>> Sorry for basic question, in case OEI layer changes format due to one of
>> other reason then how you are making sure, struct ddrphy_qb_state is
>> aligned
>>
>> + * This structure needs to be aligned with the one in OEI.
>>
> For now, the structure is stable. If anything changes, I will take care
> to update U-Boot accordingly.

Hmm, you might break backward compatibility in case of change in struct.
Or you can think of some abstracted struct, which will take care of
changes in OEI.
Something like
struct {
   qb_version;
   qb_data_pointer;
   qb_data_size; 	
}
 >>
>> [..]
>>> +
>>> +bool imx_qb_check(void)
>>> +{
>>> +	struct ddrphy_qb_state *qb_state;
>>> +	u32 size, crc;
>>> +
>>> +	/**
>>> +	 * Ensure CRC is not empty, the reason is that
>>> +	 * the data is invalidated after first save run
>>> +	 * or after it is overwritten.
>>> +	 */
>>
>> In case OEI layer using saved DDR training data, then will
>> passed CRC will be zero ?
>>
> No, the data in DRAM isn't guaranteed to be 0 after 'qb save' and
> then reset. It is 0 only immediately after a successful 'qb save'.

Ok then then you are making sure, if boot is from qb firmware then
u-boot has a way to detect this ?
> 
>>> +	qb_state = (struct ddrphy_qb_state *)CONFIG_QB_SAVED_STATE_BASE;
>>
>> If yes then you can return from here, if no CRC found instead of doing
>> crc calculation.
> Agreed, but the CRC32 doesn't add significant overhead and, more often than
> not, the data will not be 0, but something else.

you can think to remove this, it may save few nS or uS in boot.

>>
>>> +	size = sizeof(struct ddrphy_qb_state) - sizeof(qb_state->crc);
>>> +	crc = crc32(0, (u8 *)qb_state->mac, size);
>>> +
>>> +	if (!qb_state->crc || crc != qb_state->crc)
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>>> +
>> [..]
>>> +
>>> +void spl_imx_qb_save(void)
>>> +{
>>> +	/* Save QB data on current boot device */
>>> +	if (imx_qb("auto", "", true))
>>> +		printf("QB save failed\n");
>>
>> In case, of 3rd boot or so, there is no need to save training data,
>> whereas you will return error, in case this feature is auto enabled.
>>
> There is no way to tell from U-Boot if Quickboot flow was run or not,
> so that is why 'qb save' is tried everytime. The data in DRAM can be
> invalid for 2 reasons:
> - it was saved by Training flow, but it got corrupted/got saved wrong
> - Quickboot flow was run so no data was saved - this doesn't mean that the
> data in DRAM will be 0
> 

No further comments on this, As long as, you are making sure, above
print will come only if QB save really failed.

>>> +}
>> [..]
> 
> Best regards,
> Simona

