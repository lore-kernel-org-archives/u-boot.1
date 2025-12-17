Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3D8D64084
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71D883979;
	Wed, 17 Dec 2025 08:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ADxnJWwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39A283AA4; Wed, 17 Dec 2025 08:08:05 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A4183623
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1J2QtQ4YAuzEXaKIolsykcxlahP9mlpcSbMhtCKAhmwk+D+rbWPLWStLDSGRrZ3//KHVO+Zh6t1s/jtWIx+DVnTo9tLKPYDdMZg6ukmerPwpSkZc0hOrdb7/QrCBLXpFtCeJLQlD3L3sNNXcYu5QTUNUzw9BzG3y38JjRxm2OBhaYA1MZWMQg9wS9Autt4Q3Oy80bNbG6SlGoRwma40OaC0O/ehognFE7mmS5jnK24I5pBOXobRhTwHyEsWJbI/IlRlR7Hj1nMCvPbWPVDN7iXUq3aaFxLFn+hTVNfWe+GFMuQrhlhH36SY0bh7CaE9AOXn04SxNSsXMdemnQyIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIojMbI2cUBT4IEcA+GK0pWGa/l5dkvKLzu1Psx2rW4=;
 b=cxuubnAuRL7MCkUb7fuF1HCz2L+NUCBy9aMMtPJLvQGFU7U1mNi70PWOgO/aDOEoRDhT/6eidqw4U/S4DkYHGt6wH3qB1VN4/UXa6K7HmZgHdO7kDm4T7PNH70p24KphH7PBkcu7PsMTmflBOF3qV52thYNCkW8y24eRo0z3WWNQXAW3MdVK19Qq6b6jITEWqce7dt12Oq7JssgDiytpA2TP3BMAHcMfsY8SUQIvrYIaVo3PkXRM1TbdCpo/QjdkZpBHHNAcK8aVfENqvdVrXMouDOjRaxw3mq6yU4HYrrL3MR/u6jnv4teZ/TemoPLErMQLZD5n0Gnok7weEjSCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIojMbI2cUBT4IEcA+GK0pWGa/l5dkvKLzu1Psx2rW4=;
 b=ADxnJWwlslTyrHvh0Q71uy4pOmrAotZVJnv3h83kenFFg+RpVXpbHTy+LZl0Sd77qyd5fa0EqvWChC6vzKcjHTkiQu9H3ybSrXO6jbpDNEiZkhNO7zqYfBwviNBfpHy2VVaAM6XPsozNpi7MXN5JAhtPqop5zZ+5bopobTRf0hdC+p8QBmZ9L5aSN2FSep2Srqi/J2AqnHqVLQwCMsjno2GUNXWZAilVL/U2UdR+SQKsMhtjTf6IPf3IjDgHtmBhz2Qx0wzEME9b/tiRfKnl+QtiTQBSwBKnPVxGSAtd9mt87Xo5DfcOv2Lrgo98Zakbu9F5zXwt5FuCbu1ttBGc4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB6955.namprd03.prod.outlook.com (2603:10b6:510:172::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:07:54 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:07:54 +0000
Message-ID: <4a8b0891-a407-4716-bc07-4538c4ac76c4@altera.com>
Date: Wed, 17 Dec 2025 15:07:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] arm: dts: socfpga: agilex5: Upgrade SDHCI
 controller from SD4HC to SD6HC
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
 <20251215110117.19371-3-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251215110117.19371-3-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH0PR03MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a8ec32-7526-4d99-b91d-08de3d3aff99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGZtUnFqWE9MZzRBanlpUi85SFBtSWdmUEtEZG9sUVBmMEYzVXMrUytPdTRX?=
 =?utf-8?B?VnArRmdiQmlEaUtXbG9JUVRQRUZoVTRGMUx6Rjh2cjd6akkvcXk1cEtKVmE2?=
 =?utf-8?B?SUpMR21iU0RxUlZ5MzJYTk0ralp6UmcvNU5pNDhsZDczTUcwWUxMUURRd0xK?=
 =?utf-8?B?dmRLUU1oaWxYbjZLcUtUb09lbHN2S3dBNWpSUWRQSEluRlhHNmVwY0RzSmQz?=
 =?utf-8?B?MWI3cFhsWTFlSEhCWmxSNmNrTWNJRDlrVG5rbFNkSlVzc0xCWmxIQUh1bVh0?=
 =?utf-8?B?bDkrTDVsbEpnakZTNGlISXVQc25EOXNPaWg5Rjk4NFRWWDNoQmkycHJXUHhZ?=
 =?utf-8?B?ZEtYd3lpbTNJeE4ybjZNM3F1ajZPU2tTVDZDZ2tKTWFOR2V6Um4xYlBMZG52?=
 =?utf-8?B?OU1IT0lzYy9oQUhZUTF5UkhJVnpDZzZzN0xHNWlBKzVQRFFzRnZMeGpBaktF?=
 =?utf-8?B?S1kzVVh5Y3duQ2RSQkFHY2JTTkFpTmRvNkVkbWtkTkYvM080djNDajFCak9K?=
 =?utf-8?B?OVpMY1RrRWhkaytRNWlFNW5Kcmt5a0VDWWYzZkRIdmtYN3FWZ3JGN0tUakJN?=
 =?utf-8?B?RGc0Zkw4aXVvaFdtbFFLL3dXNlh2aUpmeVZrL1g5b1BrTGRQNFBzQm53Y01K?=
 =?utf-8?B?V3J1MDZDaUZkczNSUDVSam9FdGJidHRGNXFNRUlRVUFjdTlJZHpDd3psd1RM?=
 =?utf-8?B?YzZ3Zlk2TWVHR1FkbDl6T2liZVFFRk1MaXRyUzlGMldvWWhNb3k5UXRDU2JM?=
 =?utf-8?B?OEFrTmFMaFNtTW14QVdIRmk2a3NaendCWWxJNHo0NGx6bnFqSjlqRFN1dWM2?=
 =?utf-8?B?cCtxSklYU3lNQ3o4bkdSVGpqa0lmTC8xWS9XMjVwZ1ZPbG9jMVFPVkRhclk4?=
 =?utf-8?B?L0QrckcydytlNnN4UUU3RDUya05vT2JDVkpmRjN6ZzhTb2VpTy9ZdUtPTmpU?=
 =?utf-8?B?clh1ZEliLzhaMFprNytNUVZwS2VKRmJiOFZjZ1drZkxIUHZGd25TKzRON0Vq?=
 =?utf-8?B?WXZFQ3VlWHpVUnhDU3lSemtKUm9XVXY3Y0ZVdWN2ZFo3bzd6T0RtaGVwd2RW?=
 =?utf-8?B?UkdzUzBVdzhFc2ZtSHIzYURKNEREOVd0bEJtN01IM1JLOVRQOXh6TzZva00w?=
 =?utf-8?B?ZWJUWnQrS3NnZVZSdWw2MVk4QUx6N2RDSDQ3ekFURmpDVXd6dkJZWWRINk56?=
 =?utf-8?B?SWZzeSsvcWtwZy83ZklvYXQxcWl4cFRBTWV6T0pDVENjbFVhRmZjb2xxT1g0?=
 =?utf-8?B?MHZwc2ZTcmZXNHpoRzVLV2Z4NDdFTW1hMnNUUGJXWlNEeWMva1NxUUpaNjZR?=
 =?utf-8?B?TXp0bXN1Y1E3VytrL01UVFB4VytXTDlRV1B6WjRXenIzRGkzZ2haZGZlSWhR?=
 =?utf-8?B?b2J1WjVHYVBBUDFJbVR6RHJwbVEwZzgyZ0NCbHZ4SWJnYlg0MWd1NXN3OVl0?=
 =?utf-8?B?VlFhMlA3dUxqejJiSVVadkZEaURCbVRaWUNQMVVkdnpmd0JUQ2FKZFZ1Q2V3?=
 =?utf-8?B?OUNCMThrOFRQeUJDd0VyL2pQVW16TkxPUlIyait3YXo5N25nYllDWm1vd0Fy?=
 =?utf-8?B?TEZRemNYZWJ3VXJjS0hESHNWWjA1UzBqSDgwWFZUaVhGZ2ltS0NNQ2oxZ3V1?=
 =?utf-8?B?RDgrV0lTQmliSTVYNkRwKzg0OVlQVmRsTk0xeFFobnExQlBFSHNmQWJEUDV1?=
 =?utf-8?B?TjM3LzNaM3V3VmZTTjVSSDlHSk95bUMvSGsyNVUvbmthUkVuRktMbjI0THRT?=
 =?utf-8?B?YlVoZi9DdGs2TzF5R1NwRlJwQkZVRDBpUU12TWdNRUJOcTdTZkphTEtkMzhm?=
 =?utf-8?B?TUZFOGhGd3FqY0d0TjZQMGMxSGs4ZGFGYWJWSE12Yk1xSllZTlN4dld1dXBP?=
 =?utf-8?B?MUUxT2wvS2dJL2VEV3hNdEx0aStheDZmdHlWOFRwWVg4bFNGaHZUQXg4WFpB?=
 =?utf-8?Q?KXGSf7RDsMPEhNj0P4MfRqISxoUVm0qL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDFrZ2pvcnJRNXVBWThjTTdpTThvVnFibGJaTHEyWEZFQktuU01ZT3RwQlBq?=
 =?utf-8?B?ZDJIU0pUdm9yVXJaQjQraXY5ay9QZHlmdlRFYVdRZy9XcTZTQ1Z1dUswNHVr?=
 =?utf-8?B?V3BwTFhBVE5SUEJKQ0R4OFlxNFYwS0xxTnRndW1hc0F2NnI0MHI1M1I1eXNQ?=
 =?utf-8?B?YUlQRjNWelM3U3h6cUhOakQzM0d0TGdyZHFLeUtGUXJOODJuWEJzWGRDb1dG?=
 =?utf-8?B?cldtTkJHYVJyd2sxZmNYSEtkVVZwWUFFaGNrUkZnTUlXY0p5cG5RUnZVYXdx?=
 =?utf-8?B?eUwxSEZhVzZkU2hoayt6UDN2R05lL2xsUkptR3lneEcxSDlsaUN5Tk1EMXVh?=
 =?utf-8?B?Z0hkS0RMYW9kOUgxaWZGUlpvUS9UaHBDNTRGQlNBeWlPUWtYSkZXcnlxdXZ3?=
 =?utf-8?B?Ym56M1hXcjdlcmlCQWVKaFNLem04WkxKQnkyVE5tYXNWUFE2Zm1xMVFqMVBC?=
 =?utf-8?B?b2lUU3JxRjg3YVp4ZHBRNFVMeFJQNHlUbUticjJDUnNCNWNZTXVCTmpwdXU3?=
 =?utf-8?B?OXFHbXA2UEpOZU0xYjlId1BGSEhidmN6dGgvWUNTSmdxamxDaWlsZzFlNk14?=
 =?utf-8?B?OGlzNG93YXAvVEl5UE5kbEZCNGduTnFmajF2emhINDJwdWd3Q3czS2JMQTJP?=
 =?utf-8?B?Z1VuamRZQkpJQUJ0aXlYTzNNNGxOYm1JbFBWWG5meFBGNzdDZ2sxelBscnVp?=
 =?utf-8?B?VW1SajFDMnY0ZFpiVVNLZUthemRyb0tRRitTWHlrdlFUczg4allNdS9rVmZR?=
 =?utf-8?B?TGlhb2UwZEwzZzg2a1VYdWhHNEtPeVFOMFlTQ3o3VWs1RGlxbTF6M0w5OUUv?=
 =?utf-8?B?TVozZU5WZTJyWHAxNnlSTXNJYlR3aVRCcHU2bDlUdTlxeWJtc0xLaEFQNDU4?=
 =?utf-8?B?RVRQcHRadzAvd2treDYrTENrZ055NnE5VnVBZXFud2RRRDlBYlVhK2huVS9z?=
 =?utf-8?B?RTVvRXF0d1VDWHpVUDZUOEhzOEMwNTlBQ1JzL1NMK1lGTStLaEp5c0gxRDky?=
 =?utf-8?B?U2tkWjdsLzg1MmRHalR5bHB4S09DeXlYb3hXYk90c3d3c2JPaDdIMmNEcjBo?=
 =?utf-8?B?VVpOOHA3RkN2bEtiTnJqRTFPSXFBQUp3SUVrLzBXZ0I4NW1GbDdNRmJxcmwv?=
 =?utf-8?B?T2NsNk1VNEY1b1lhcE1LMHR3MUxPQTlWRGdjTlh1aXdGU1NQY01tenRMOFBN?=
 =?utf-8?B?eVBsQis2cXJwOU1rd054Tit6ekFyRCtSNXpKemtkWjZvMnE4bjNYZVd3NEhE?=
 =?utf-8?B?VnJ4eVczOHd2NXkwSlhZcm53TmdpMDVUQ0hVWWhQcWV1MTM3TlNTMmIyRDh4?=
 =?utf-8?B?OXlyWEJSSmpnZEd1Nm8rTXRmWGJkZk1OTVprNkU0c0FEbG5DOURvRmlnYytV?=
 =?utf-8?B?eXcvaFNRbzNpVFp1MzBRMVZQTVZ1ekg5VFl0dEtUNTBmUk5HY28yem1zQW1p?=
 =?utf-8?B?dWtxRUw3Vy9NdGJHUW9OZStPd0s4QmVaTzcvSWp0LzU0YnZkeVZaalE0cjlH?=
 =?utf-8?B?LzlseWptM1ZvZC9iYlpXaVAreWJRVVlOVU5QUlBCQUNLRVZYMWVXTVdaOXJ6?=
 =?utf-8?B?MklRMk00ZnlPK2habkJ1anBkQWpPVHZ4bnVlV0dMbUlrSDhXWEFQY3VyYlFl?=
 =?utf-8?B?STVBbU94MFZMTFZzMHVyZFYvalMrMmw0VHJkcGUxcUlZVWdsc3g3LzBzN0U5?=
 =?utf-8?B?amFyZXJCMnltZDNHNVZMNXNrNGJUZjExdFNQVjlkSllENW1PYm4zM2lMOGxO?=
 =?utf-8?B?OU5YamZBSGQzaVgrSm12M3hxOHpWTUxWSUtLeHBDSjB1MUQwQlhVZXR0S2Rw?=
 =?utf-8?B?bXNnd3VLK2twNGxidFRKajg4enN3V1pGOHptZjVneGRsdEIraTdmSUdMMjQ4?=
 =?utf-8?B?bjRZTjUySlFHTnlOdjJ5YkVqb0JRM2dwQ2ZkdzBFSlp1dm1JSHc2YWdOWWRl?=
 =?utf-8?B?WEl4L0IxOHBaUnptMGp3RVR3ZEMzdUZtRHpzaEd3R1M3VlB0UmdyeU1WVStO?=
 =?utf-8?B?KzZLWnBOUEhEZWZ0a1pDYWVVeHlZOUxPaTZaSThvUmlieDU5Rk1VK0Z1NGIw?=
 =?utf-8?B?NGRiS2h1N0FaWmVQUDBSWGp4R3BMbXo4Z0l0Q1NZeVZSNzVCR2lvOXZUemJB?=
 =?utf-8?B?dUE3SVlOalA5b3p5MmxkSGxwZndkSTNoQ2h6N21WVW8rRmMxUmNCVFVkRTJh?=
 =?utf-8?B?S1o4WXBWYlJHVW4wQzU0WURzbHNoTHc5SzZYR05YbXVFLy9UbGFlWjZ2NmZT?=
 =?utf-8?B?Vy9GM1F1cFNCd0NvZzBHWUpSc2NlU0Q4WExQUE1VUlZqNGZ6SFpicml1ZjI0?=
 =?utf-8?B?cVBRTXR4T3dWZmhPaVdvOWlpTmRMb2xTdVE4UW9LYUJ6OUZubERCR0k0T0NW?=
 =?utf-8?Q?PGWd0VWfH3WyJu3o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a8ec32-7526-4d99-b91d-08de3d3aff99
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:07:54.2723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuutRMZO8/u3IEAUJQQAlYroOKzvTbKvy0bdlcHq4+gezJt2f2+W4m8sl+lj6rhofr5yE0CxM3V4RrAXAE4cUxSnP2qGBBWQ+yTcjG+8Sow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6955
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


On 15/12/2025 7:01 pm, Tanmay Kathpalia wrote:
> Upgrade the SDHCI Cadence controller from SD4HC to SD6HC for Agilex5
> platform to support the newer controller version with enhanced features.
>
> Key changes:
> - Remove combophy0 node and associated references as SD6HC doesn't require
>    separate PHY configuration node
> - Upgrade MMC controller compatible from "cdns,sd4hc" to "cdns,sd6hc"
> - Add Agilex5-specific compatible string "altr,agilex5-sd6hc" for
>    platform-specific optimizations
>
> Hardware configuration updates:
> - Add voltage regulator support:
>    * sd_emmc_power: Fixed 3.3V regulator for card power supply
>    * sd_io_1v8_reg: GPIO-controlled regulator for 1.8V/3.3V I/O switching
> - Configure proper reset control with named resets including combophy
>    reset
> - Add GPIO control via portb pin 3 for voltage switching
>
> SD card operation:
> - Configure for SD card specific operation (no-mmc, cap-sd-highspeed)
> - Set maximum frequency to 200MHz
> - Configure timing parameters for SD modes:
>    * Default Speed (DS) and UHS-I SDR12 mode timing:
>    * High Speed and UHS-I SDR25 mode timing:
> - Add PHY timing delays for optimal signal integrity
>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |  3 +-
>   arch/arm/dts/socfpga_agilex5.dtsi             | 29 +++----
>   .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 77 +++++++++----------
>   drivers/mmc/sdhci-cadence.c                   |  1 +
>   4 files changed, 54 insertions(+), 56 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> index 35b198b79ef..0f0f457de54 100644
> --- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> @@ -698,7 +698,8 @@
>   };
>   
>   &mmc {
> -	resets = <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
> +	resets = <&rst COMBOPHY_RESET>, <&rst SDMMC_OCP_RESET>, <&rst SDMMC_RESET>;
> +	reset-names =  "combophy", "sdmmc-ocp", "sdhc-reset";
>   };
>   
>   &porta {
> diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agilex5.dtsi
> index 7f4266dd5f1..769678af31a 100644
> --- a/arch/arm/dts/socfpga_agilex5.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5.dtsi
> @@ -303,30 +303,33 @@
>   			status = "disabled";
>   		};
>   
> -		combophy0: combophy@0 {
> -			#phy-cells = <0>;
> -			phy-type = <1>;
> -			compatible = "cdns,combophy";
> -			reg = <0x10808000 0x1000>;
> -			resets = <&rst COMBOPHY_RESET>;
> -			reset-names = "reset";
> -			status = "disabled";
> +		sd_emmc_power: regulator-fixed-3p3v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "card-power";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		sd_io_1v8_reg: regulator-1p8v {
> +			compatible = "regulator-gpio";
> +			regulator-name = "sd-bus-io-power";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			states =	<1800000 0x1>,
> +						<3300000 0x0>;
>   		};
>   
>   		mmc: mmc0@10808000 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			compatible = "cdns,sd4hc";
> +			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
>   			reg = <0x10808000 0x1000>;
>   			interrupts = <0 96 4>;
> -			phys = <&combophy0>;
> -			phy-names = "combo-phy";
>   			clocks = <&clkmgr AGILEX5_L4_MP_CLK>,
>   				 <&clkmgr AGILEX5_SDMMC_CLK>;
>   			clock-names = "biu", "ciu";
>   			fifo-depth = <0x800>;
> -			resets = <&rst SDMMC_RESET>;
> -			reset-names = "reset";
>   			iommus = <&smmu 5>;
>   			status = "disabled";
>   		};
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> index 938ddb04c04..5a7aa5841e3 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -91,53 +91,46 @@
>   	bootph-all;
>   };
>   
> -&mmc {
> -	status = "okay";
> -	bus-width = <4>;
> -	sd-uhs-sdr50;
> -	cap-mmc-highspeed;
> +&gpio1 {
> +	portb: gpio-controller@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&sd_emmc_power {
>   	bootph-all;
>   };
>   
> -&combophy0 {
> +&sd_io_1v8_reg {
> +	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
> +	bootph-all;
> +};
> +
> +&mmc {
>   	status = "okay";
> +
> +	no-mmc;
> +	no-1-8-v;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	vmmc-supply = <&sd_emmc_power>;
> +	vqmmc-supply = <&sd_io_1v8_reg>;
> +	max-frequency = <200000000>;
> +
> +	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
> +	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
> +	cdns,phy-gate-lpbk_ctrl-delay-sd-ds = <0x81a40040>;
> +	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
> +	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
> +
> +	/* SD card high speed and UHS-I SDR25 mode timing configuration */
> +	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
> +	cdns,phy-gate-lpbk_ctrl-delay-sd-hs = <0x81a40040>;
> +	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
> +	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
> +	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
> +
>   	bootph-all;
> -	cdns,phy-use-ext-lpbk-dqs = <1>;
> -	cdns,phy-use-lpbk-dqs = <1>;
> -	cdns,phy-use-phony-dqs = <1>;
> -	cdns,phy-use-phony-dqs-cmd = <1>;
> -	cdns,phy-io-mask-always-on = <0>;
> -	cdns,phy-io-mask-end = <5>;
> -	cdns,phy-io-mask-start = <0>;
> -	cdns,phy-data-select-oe-end = <1>;
> -	cdns,phy-sync-method = <1>;
> -	cdns,phy-sw-half-cycle-shift = <0>;
> -	cdns,phy-rd-del-sel = <52>;
> -	cdns,phy-underrun-suppress = <1>;
> -	cdns,phy-gate-cfg-always-on = <1>;
> -	cdns,phy-param-dll-bypass-mode = <1>;
> -	cdns,phy-param-phase-detect-sel = <2>;
> -	cdns,phy-param-dll-start-point = <254>;
> -	cdns,phy-read-dqs-cmd-delay = <0>;
> -	cdns,phy-clk-wrdqs-delay = <0>;
> -	cdns,phy-clk-wr-delay = <0>;
> -	cdns,phy-read-dqs-delay = <0>;
> -	cdns,phy-phony-dqs-timing = <0>;
> -	cdns,hrs09-rddata-en = <1>;
> -	cdns,hrs09-rdcmd-en = <1>;
> -	cdns,hrs09-extended-wr-mode = <1>;
> -	cdns,hrs09-extended-rd-mode = <1>;
> -	cdns,hrs10-hcsdclkadj = <3>;
> -	cdns,hrs16-wrdata1-sdclk-dly = <0>;
> -	cdns,hrs16-wrdata0-sdclk-dly = <0>;
> -	cdns,hrs16-wrcmd1-sdclk-dly = <0>;
> -	cdns,hrs16-wrcmd0-sdclk-dly = <0>;
> -	cdns,hrs16-wrdata1-dly = <0>;
> -	cdns,hrs16-wrdata0-dly = <0>;
> -	cdns,hrs16-wrcmd1-dly = <0>;
> -	cdns,hrs16-wrcmd0-dly = <0>;
> -	cdns,hrs07-rw-compensate = <10>;
> -	cdns,hrs07-idelay-val = <0>;
>   };
>   
>   &qspi {
> diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
> index 7d169efa476..6cdb7f95cc5 100644
> --- a/drivers/mmc/sdhci-cadence.c
> +++ b/drivers/mmc/sdhci-cadence.c
> @@ -260,6 +260,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
>   static const struct udevice_id sdhci_cdns_match[] = {
>   	{ .compatible = "socionext,uniphier-sd4hc" },
>   	{ .compatible = "cdns,sd4hc" },
> +	{ .compatible = "altr,agilex5-sd6hc" },
>   	{ .compatible = "cdns,sd6hc" },
>   	{ /* sentinel */ }
>   };


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

