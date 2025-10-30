Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD90CCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1610F83893;
	Thu, 30 Oct 2025 06:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="toCIm8I7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27CDC838AB; Thu, 30 Oct 2025 06:08:37 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F0F83849
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+kklrN5sLdoslZtLqcUzr5cwHqfhjaMVT/T8k+l1jUAGwzNK5dafSqlfQ4wyHKbXEVtMeal1IN3dVU2ExYwVwWaB7lJP64MDYZOkXeANly3I0QuGQfm8BfBm/f5n1D6oFUa4SSe+yBQunmQ8qo8iI79mIiDAZxAHvUT8J03bOA9mkvgD6vfE6sDawQsxJn1d9DbFatBf1q4hBExIj/n9MbnxpZcrlSJ3W371btOWnd00n4r8cFwVMKuBGgHE4sdatG8cuOVdpyyF/puWQZJveYCX+Bl+S+ibqbfPclU8RGbbsjAqBJN9trukWsNZJlhI+QotXeh3XjqpcCk+HZFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU3XLUQvHQs/XnX7+aXHIFWwOEFNOpDc2iDSbfWH3FQ=;
 b=bmY9fipYy0oCyn5n886DWK8zSoQQkBclzeTFrQoaCw5FbC8u4rxpX5xdNfwOukA6DHVWbI5d+ydCpUur1CqNli76Ihy1qIBX04eZ/tQ9qjb52smqD0qPiIYtrN11X6quoldxXQwI0wEPq+wdYZzN8OQvIcu3j44QT4JNP5hBSPaMoqCy5B6ds5v3gNEAdwpho++OrEjp7aEEMUcx3b5ZRyIV+CzJDmtuo9oZj7mH6MTB9LDU9UwOGbWCqpa6qTciXyckS2ipQDYhunF3IaHIR+5kT9J61gkcXerl3xtVhUqiKo+jy65W9soG4G78WWKpeKTSCEL908wdCNUl1nwyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU3XLUQvHQs/XnX7+aXHIFWwOEFNOpDc2iDSbfWH3FQ=;
 b=toCIm8I7MtjTLl/NXXwX8e98Jp6Pf+bHV+FIqwt3+LEG0+187z4QWR2Z5AwcZXhQ2FBm6pUM9YaYCdlQyLtFq34Npp2Fk/+kDIO2+rQJLuJsDHcGhsRYqLPvBsr9yi80VAiiju6ZlQlN2oxvDmkQkgINURb0QlU02lvfRu25gYU=
Received: from MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) by
 CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Thu, 30 Oct 2025 05:08:29 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::f1) by MN2PR01CA0023.outlook.office365.com
 (2603:10b6:208:10c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 05:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:08:28 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:08:14 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:08:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:08:13 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U58C5j1390705;
 Thu, 30 Oct 2025 00:08:13 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Oct 2025 10:38:12 +0530
Message-ID: <DDVEAKLT0K9F.26406SBEB79LS@ti.com>
CC: <b-liu@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: Re: [PATCH v8 8/8] doc: ti: document R5 falcon mode for AM62 platforms
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251027130004.2156121-1-anshuld@ti.com>
 <20251027130004.2156121-9-anshuld@ti.com>
 <f31edd75-97a4-46b7-acf9-6513a9125a4e@ti.com>
In-Reply-To: <f31edd75-97a4-46b7-acf9-6513a9125a4e@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbdca06-fe57-43af-248e-08de17725cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|34020700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWt2Vi9VdFdNcFpxeTVxdUdNaHRxUi8xN3REb20rcmdoaVhSWGNFUGlBSCtO?=
 =?utf-8?B?dVVyalVnSHBnOEtPSHAzb1g0Vk5PaUhOUkNlZlNyanYvSWlrMk1vQ3hYK0dW?=
 =?utf-8?B?bzdtUi9WWGVNWHdMVy9tZW5LWXhnbWdaVHV2SnExUURsWjFuTnJTVGlrN2hp?=
 =?utf-8?B?SjhwaFpKYVZabkpaQ3dxVW5wNDczckR1ZHNmTy9jUzZCdE5nUFJ1cUpXY05M?=
 =?utf-8?B?VWExdkFQLzVTSjJGcENQRmkyVEx3T09xcHhoZnoxZmx1ZEdyYkRydnVqRGk3?=
 =?utf-8?B?dTRPWDhPakRSR2NHMWovQkdyMmY4VUd1K1FueVRxVVlkVUJNUitQM0RNSmJX?=
 =?utf-8?B?bFFIZURlUHhSTzJIdVIwd0ZtemdJMmVQVXB6UWZ1eG0yVGZNVkxVQThqT2ZT?=
 =?utf-8?B?blVxNGlQdEJPUnBxbXF3WGJmSDM1cWMyaVhRT0NlcjVrQUpELzFiaFIydGhQ?=
 =?utf-8?B?TU5WREhjZmdqVnc4RCtLa1ZDTUxnVnlpMThJUjlNRWVUb3U0WEtCcmJHWVNj?=
 =?utf-8?B?SGVMMHMyNngwMXBOT3MyYjJSa1Y2T0wzdk9zYWJLclFwQTBzSDBxcVZ2M2J0?=
 =?utf-8?B?S09EOVJUdENweHlHUnA0d2MyS0o2aEZ6US9oMmVhM1BvbG1UVGsxdXk0RmU1?=
 =?utf-8?B?MTVZTko3aURMd29GenVBVlZOeEZNeEJIRXd4M3A4bGR4TmFNQWlCSEg3Tktv?=
 =?utf-8?B?MVBsRUI5NzVGcWJwME9HcEFCQXE5MFVuY3FiZklxQ1FLc1oyS0djYzQwSVhu?=
 =?utf-8?B?QW42c2p2UGJTREx1bHB4TC9JSkRIdS91YnFOWmhVcW5uOUtGc1ZDd0pWOW9q?=
 =?utf-8?B?NW5lSldJdGJYSlNPOWpYMTdZS3h0ZUxBOHp3eXluRmpFUWdub0kwc0ZadStS?=
 =?utf-8?B?TjZGR1o0aWM2Q2FQVGVxb29iSHF0bE9xV3Y4SFFHckJTYmtXVG5rWjdvd0pK?=
 =?utf-8?B?OFd0U2QxWlV5ZGZrbVhZYlBlazRacWVoWjVXRjJxUXlKeWtNTm9FSnFnN2pw?=
 =?utf-8?B?UklkcWx0Vnd4amJqdk53S2dCNHF0UHV2T3RRSjR4NUVGak9SWENYM0F4eU1J?=
 =?utf-8?B?MFU2NjJRS2RnR25KMWRaY3IyVWxmN3RSeVNiQ0dFbGx1ekc5UThqOURVanZx?=
 =?utf-8?B?TWZhWVZKMWdIVHVFK3BlSHRvZzBja1dSMnJkY3M5N1FqTDZUNWJ0dHkzQ1p0?=
 =?utf-8?B?QWI4SjdRRDV6WVpPY2p3YTJZNEd4K1ZlSTVIQkdIeklQYXkvYVo4a0ZpbHBQ?=
 =?utf-8?B?eHR3dVBoejZCRzdDdVE3Ym5SMUh5c2ZnNzZoSHBuMDJXTGFTNkFDVTljb1RK?=
 =?utf-8?B?Yk9BelpZWk1OK2NaMERNK295aExTUk5LSHp5YmxuWTFUTWNmRHZ2MXkwSk1H?=
 =?utf-8?B?cU5ZUUJBaEpNUjZmQkdmR0EzeHZiY3d4UVpFYXBJZ2tGaExORE1ibjNXSGE1?=
 =?utf-8?B?c0dPSktyTjNiZnk2WXYxS3FDc1o1Vi9ENWFzUzM4NTdJdHpTdHMxeFdraWZv?=
 =?utf-8?B?L2JLOHlNT21WdklRTDZkTTRxdHpTeUxwdHRGK2pJTWgyYjFBeFIxL2NxU2J0?=
 =?utf-8?B?VHFYZFFoMS9lSlRGbGM4QWlnSkxkUDFUSXZKL2ZFNEptbkJicDE5RE5ISS83?=
 =?utf-8?B?dU9qemwzMnlpbXBWbFYyWXBGbHRVMmgvaC9kRzMxTlltbjNEUktZcXo5M2h3?=
 =?utf-8?B?VnJIVlIrUzREMkJndk5KZllvbnRxa0I2MFpsTnozY0JHQlV3NVlUa3oxQzdP?=
 =?utf-8?B?eGN0WnhsNUNhc0lISjNRRWJyeGRZeVZFZUpDWXRYNE9abTFyTXBvQkgrdzk5?=
 =?utf-8?B?YUc3d2Z4WDN4aTluaERnVEdZck5yeTBjQm1DTkt3cnM4eEh4Z040bURPbUYz?=
 =?utf-8?B?UmNnZFRUTHdYZkEwYUdUSEkrWDhtazZZcVoyVWRHZ0dEVU1Vd0ptelZFOTkw?=
 =?utf-8?B?VllEbHF4ampEYzVqbDRvZ3hxbFAvdXY5amZkdnJJbGMzN1B2SVpqMi9VMDBD?=
 =?utf-8?B?VVpXQzlwWVkyY1BKT1NVUGlLL2l6aS9GL0pBYmM2UWZOTStQRUZKcE5pWHRG?=
 =?utf-8?B?NE9RUjZDeXd6OEdSakZicDcwWkhKRnN4b0o3OHdydUlWUEszRmRiZHM4MVY1?=
 =?utf-8?Q?O20I=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(34020700016)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:08:28.3982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbdca06-fe57-43af-248e-08de17725cdb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
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

On Wed Oct 29, 2025 at 11:46 PM IST, Andrew Davis wrote:
> On 10/27/25 8:00 AM, Anshul Dalal wrote:
>> This patch adds user documentation for falcon boot for AM62 platforms.
>> The main section is added to am62x_sk.rst and other documents just
>> include the section. Steps to build falcon support, usage and the
>> modified R5 memory map have been documented.
>>=20
>> Two svg images have also been added for reference, one for the modified
>> tifalcon.bin and other for the falcon specific fitImage format.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>   doc/board/ti/am62ax_sk.rst                    |  35 ++
>>   doc/board/ti/am62px_sk.rst                    |  35 ++
>>   doc/board/ti/am62x_sk.rst                     | 303 ++++++++++++++++++
>>   doc/board/ti/img/fitImage_falcon.svg          | 180 +++++++++++
>>   doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg | 285 ++++++++++++++++
>>   5 files changed, 838 insertions(+)
>>   create mode 100644 doc/board/ti/img/fitImage_falcon.svg
>>   create mode 100644 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg
>>=20
>> diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
>> index 4dd998bcce9..45992ec304b 100644
>> --- a/doc/board/ti/am62ax_sk.rst
>> +++ b/doc/board/ti/am62ax_sk.rst
>> @@ -187,6 +187,41 @@ https://www.ti.com/lit/pdf/spruj16 under the `Boot =
Mode Pins` section.
>>  =20
>>   For SW2 and SW1, the switch state in the "ON" position =3D 1.
>>  =20
>> +Falcon Mode
>> +-----------
>> +
>> +Falcon Mode on AM62ax platforms bypasses the A53 SPL and U-Boot with th=
e overall
>> +boot flow as below:
>> +
>> +**Normal boot flow:**
>> +
>> +* R5 SPL -> TFA -> OP-TEE -> A53 SPL -> U-Boot -> Kernel
>
> It might be good to point out that the TFA and after is on a different
> core than the R5 SPL, it might be obvious to us based on names, but
> never hurts to make flow graph match, and also in some way show the
> file names that contain the different parts, maybe somehting like:
>
>
>
>          | tiboot3.bin |          tispl.bin       |  u-boot.img  |  Image=
  |
>          |             |                          |              |       =
  |
> R5 Core      SPL
> -------         \
> A53 Core          -- -> TFA -> OP-TEE -> A53 SPL  --> U-Boot  -->  Kernel
>

That is indeed more clear, I will incorporate it in the next revision.

>
> Also if this section is the same for all these boards, could it also
> be factored out into am62x_sk.rst?
>

Yeah, we can reuse it as well.

Regards,
Anshul
