Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4A9CCD194
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 07:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 813D3835FD;
	Thu, 16 Oct 2025 09:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="VdW5Z+pZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBB7835FE; Thu, 16 Oct 2025 09:55:04 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0029C807B1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 09:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2384ce2140=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6w8UI001485;
 Thu, 16 Oct 2025 09:55:01 +0200
Received: from pa4pr04cu001.outbound.protection.outlook.com
 (mail-francecentralazon11013019.outbound.protection.outlook.com
 [40.107.162.19])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49qfavec1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 09:55:01 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9QuhLvvT+WVPLRKV92mEtAFDn2rTI0YAmR8OXtQZ0jobPb54/lZgFrHAF4A3T8tAanizW4hm0SQXZ0dvzRGtQkQvhrPtX3N2MjxA8QXRNGqOsn5IQQ9kZgnCBBHNlumJjhhHcGp2nIgU7sLRYBRFYciDCONqyp/ZblV6iUrUzMzLu+j9zSMjrbyN4Hw1iqCb9XxtBrEIs0P0U7DP0hBzElWa6zH1T9idK1Ku2rgKkx+899QGN7DEDxRH9WBmqjwJewFg2iLJF9MwU+qM504wYuvxUe8mo2Yhywc4JzJDpAAFRN9iZwbq/ifW22WYfhmwl6nTvJFX2P6WprKXM5Jfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzvM243hByYziV+wcDjHae9RtXtyO8U2OEq4Kt57/WY=;
 b=wOC8faaf6qUHIsIHvSafKpcURZrs3mgRQfvFd5+Mo4lD7RebEFVguiMCy/g/T2vBl9ukcKmViersALaD1ORbfYfzrN7s2AN8R5JYJ9fkqNTi5yc2OfdggFZ2rrKEl5VuDWCUl5nlZHy1IVn7EgB+bzs5VQiORKXcglASRaV6sk9B9trxoW0G8ZAa7cfBdd6zQD80V0UjsgmRfkNqsU2CSFOt5CdjkOkyKxIVcb5DWVIiBpNI48/nQ5uPaBhe+3WZJDJ0ulMt3/EwsrEHhVKqusEEiweFLOc0n5QBTotloVJzEKi0z3jW1zBfRwQ3oBWxoQjdxKfeSoYUW8CefpUrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.40) smtp.rcpttodomain=googlemail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzvM243hByYziV+wcDjHae9RtXtyO8U2OEq4Kt57/WY=;
 b=VdW5Z+pZGXvSkx+/W4GpLWtrPkjt7pcYvAbrnxLicjOBhLhjFYcny1vC0h6F75Wd4NFDbANK7mb+feB/DPaW1W7vhgyGyGjGbfAaAq6AnAUK6t0prI1ZawpbH4HvAkVaZd3NGsMqoRWojL4kplEmksRTEeE5r4ZHHtfZ3phFvq1sD52xgwanIefUBtQNO7fSrJpA1Jscz26hmcScBn3tCFt2LvebXGfki6amISGAes20PZ5VwVx+QNpjap6AK6h4iyVkI6Q+J9YfmHJxIi9QKZkrxe+noACn1HE5npzWpkQkIJ3tEacbiyMZCFMaMwt+vQbmodvoMiGhUbTRU0nIQg==
Received: from DUZPR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::7) by DU4PR10MB8854.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:55d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 07:55:00 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::43) by DUZPR01CA0076.outlook.office365.com
 (2603:10a6:10:46a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 07:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.40)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.40 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.40; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.40) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 07:54:59 +0000
Received: from EQNDAG1NODE4.st.com (10.75.129.133) by smtpO365.st.com
 (10.250.44.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 16 Oct
 2025 09:55:02 +0200
Received: from [10.48.87.93] (10.48.87.93) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 16 Oct
 2025 09:54:52 +0200
Message-ID: <39927c93-7835-4b83-a881-1cc0a893269f@foss.st.com>
Date: Thu, 16 Oct 2025 09:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitignore: ignore more image files
To: <yegorslists@googlemail.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>
References: <20251014091717.309468-1-yegorslists@googlemail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251014091717.309468-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|DU4PR10MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a9d087-fcf8-4e9f-0ae2-08de0c894e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3ZNUmx5TTNZOXdsSVhRRUt0V202YWdicUwwcUVhQ3dFSzMzUWRsWGZESTJz?=
 =?utf-8?B?Y0x3S21EWk5ZelpTUlFPcHVoMktEYUo5cjJ1MW9PdzFRQVNEN2ZWUjAxc1hB?=
 =?utf-8?B?ZGo3R25uTS8zREk4dEE0MnN2UE9LTlZpOWlTMUlSN0RUdkYrbVI2Y0JnRUVE?=
 =?utf-8?B?T0s4U2hTMTVWSGR1RGhEa3JIM1VCMk9DWWFaRmxiSW1VZndDam85WkxObUpW?=
 =?utf-8?B?aXM4ZHRHZlplS2ZFZEFYMEJQQkwzSnJZMXlQQzBCWHJwM2VxWGhrYmRpZDgv?=
 =?utf-8?B?cXE2WnpiRW1OM2wzZzNEdTZxMVhxZCtGbXVDQ0VyQ092UGpyUDdKMHk5cFF4?=
 =?utf-8?B?NVZFRzhHY1ZyeFN5UjJYVWJ1cFhZS3RrUFVQbjN1bFk0dnNHSlFHeXp3Vkxn?=
 =?utf-8?B?em9oSnJZZENsMGtjS1d1WmlxZWx1ZVJuRGdoZ0hKVjJDWDYwWTFJbEFJMlJH?=
 =?utf-8?B?cXV3YTA3T1VRVDIrblFETHVVVndmNFA3dGhCb01VQ200blAzUXliK1pnV1cw?=
 =?utf-8?B?VVlsMFJGWmcvbHFxTEhDc3daTmpCMWRSZ1JwaWN5YXFQcHZ0SS83eFJlbFlt?=
 =?utf-8?B?c0tyNnoyK1NzM0NkTndCSmx4Y0R2YW5QSFhHclVCdWg2aTNmQm5XOTdxdFRh?=
 =?utf-8?B?MExkb0RlQW5BTTJOVEJTQzJ2c1RwN0FtSWw2bDRNVkFHRmI3d09MeFcxbUFY?=
 =?utf-8?B?bTFiUDh6aDRpL2FIMk5vLzdOT1ZIWFl4cjhIaUZaaGlsM2Z3SVQ3QTY1VElE?=
 =?utf-8?B?dWl4Y3NnOHkwOElCOHpRRVhHSmQ3MDFUd0pJdGpCeHh4YnNicHVLSkViY1RH?=
 =?utf-8?B?ejdQbFQ5V1FGZ3ZLZ2VOWjR2QkRsNlNXSFJjaU5BVGd2cE9XU3IzZHBnMW5S?=
 =?utf-8?B?b0xoMFBmdWVhRFJuOU5PQ0hHQ2NqZVZvK1pTeFVVRlhLaTlDczNBaEh2cE1z?=
 =?utf-8?B?RTZQSkluYjJ1RkVINk1qSmRTNm5MUmxSMGpTUnJXYUJ2eHI0RDk3d21INldQ?=
 =?utf-8?B?R21KTmtHOXJFYklLM25FaWt5bWdpT1JjbmtmZjZUaG9KK2NGTGNGaHNDVkZz?=
 =?utf-8?B?SzgrbFZHZTJzMlVtN2cxZ2UvTWdXUVVUSXRDREhIRmFSNjd6bDJwZUdpckFL?=
 =?utf-8?B?b1FMY0ZtdG9VcnRGSWpIczAxK1RlaFJzR2MzaDZnYXJZR3ZGMHdIc1FuRmZw?=
 =?utf-8?B?eHRVamhoU25qekpUYWxjNXB2K1lUUFVhMjJ2TUlQZTVyKzFTNUxRcGtCUzVV?=
 =?utf-8?B?MTlpaTlra0NiWDFtUlF5UTFtVGtiRlBnd04wK3FuVW1SdnRtbU5HOENMNXN1?=
 =?utf-8?B?WTJpK0FBNWliUUgyM1k4anFTRFhEaVBPV3VzcGl4cTQrV1E5UlNVOTNkRk1H?=
 =?utf-8?B?cWZaZVdZUmphbDE3SGgyaUtJU1hPT1ZlKzBtZjFXc1FZVys4cSt3YXZiY05M?=
 =?utf-8?B?MVhvT2ozVC9qRW5MUDYyYnhWa3VhS211Q1hJQTVENkxROWtRc0VYRW1zeEZB?=
 =?utf-8?B?alIrSm5tSFdrYklvSFdsL1prZlk2Snd1bjdHQXVOOTMxbVZlVU45YVY3YVJj?=
 =?utf-8?B?VEc0bTI5aDZDMXptNWNCMm10Sk40YVhreDNYaWszSG1LY0JDbEJBRWN6OHdu?=
 =?utf-8?B?S0hZRG9UbTRQQndGc1RpSC8rcG9RNldvOXpMQ1p4Q2M3TDVUK21POXdBaUxX?=
 =?utf-8?B?VXNBbjhSM0JORmxUUkVmUUh4b1AzVzhIakRtclBFL2lnajFqMnFYREpGaDZr?=
 =?utf-8?B?NjBsQ0x3ZVZ2S29TNnlIZW9qMlRqbjd3VWxhQ1lkWFlGZ1FWTDFPMWdkUHZN?=
 =?utf-8?B?TFpIZDhwV0JIVTJuVjhPQnA5dENJL0duQjJ4WFlNcVNtWmJSNlppenF5VjJB?=
 =?utf-8?B?NzZaZm8wL3FiU2JHUnhSODR1a2xrekFtN1JzTmFGNjBLVFYyYVNpTDloTE5y?=
 =?utf-8?B?UDlobWdXN0tzVE01UXVJY09HeXhraDN2YVIxN2VVaFIzdVM2V1kxTTVCWXhp?=
 =?utf-8?B?SzM0KzBJVDBrNXUxaWhaNUVqT1JRenJFY1IwekZIdmM1dnZXVFRRV1FEa1Rk?=
 =?utf-8?B?N3ZURGVNSWJQUldrRGRub3BSb1hmQzA1VTh1amNSZHpVTzloejBGakEwY2lQ?=
 =?utf-8?Q?pnkM=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.40; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 07:54:59.2545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a9d087-fcf8-4e9f-0ae2-08de0c894e1c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.40];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8854
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX/1OPHbZPCC45
 8u8AHnanKxtd5wkJVNXxRZ7HYhCOtcbVOk8IyI9t+pQnbMFWDWrWvYqv/Cpij/9k/e0XkoVxpTS
 9GU77x8NvvA4bgvc8OtWpdcZ40U5FHxaMfL3He9w8qs6hHfmltv4dgdZSQCdrOWxDrd2kWTld29
 OhrBRsNn8/8OjG13g9CR0zJr7Z6sa7z+RS0EmsVq+soQNCDCgEb+rq5DCbFBwB3pE906L4Zk1Pg
 3LuHPvzICoX2yglJlAFz87oPbEem17o1awaHjr0iVvXpfN6SWShzbrf7+t+TV/RYEKaJSGWiLyB
 FN42A7jhc8KWzUhC8hhwmTxIM7PI37GBaR3Q7/FkEFR8NJVNfWln53+l0tj9TxBQbyqiljag5EL
 I6ssDfbqTTCAT1AZVqxHQ6thm7uVAg==
X-Authority-Analysis: v=2.4 cv=Ne7rFmD4 c=1 sm=1 tr=0 ts=68f0a4d5 cx=c_pps
 a=sj2/heZCLu5foRNZovSYRQ==:117 a=HHWmdgNZ66UcX3Fjl3KRHg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mK_AVkanAAAA:8 a=8b9GpE9nAAAA:8
 a=ugrdwQj0y67I5hbtl8IA:9 a=QEXdDO2ut3YA:10 a=3gWm3jAn84ENXaBijsEo:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: ZTd_2eeaXa22pEXpPBxlSa01kS9LWUOj
X-Proofpoint-GUID: ZTd_2eeaXa22pEXpPBxlSa01kS9LWUOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017
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



On 10/14/25 11:17, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This expression covers various images files like, for example:
> 
> mkimage-out.spl-stm32.mkimage
> mkimage.spl-stm32.mkimage
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index fa2db08dead..1ac737d2718 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -50,6 +50,7 @@ fit-dtb.blob*
>  /SPL*
>  /System.map
>  /boards.cfg
> +/mkimage*mkimage
>  /mkimage-in-simple-bin*
>  /simple-bin*
>  /u-boot*


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
