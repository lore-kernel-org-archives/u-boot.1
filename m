Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B22BC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 10:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA3080EC0;
	Tue, 25 Feb 2025 11:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LlKCk/i6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB7D680F53; Tue, 25 Feb 2025 11:48:25 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDAEC805C3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 11:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP2azl7Zxua48/XNjW4bkhoXdcDEqhoWf5oa4w+89SxnHEvi8hLaD234fwx4SZ0h50kwmrRjVrH954sgYycDstzh9yzkyIyeaO/sTOqJOImEBAa5LvI1VxHkptgexQ25El792TSCmNxZRG2dGG2X9kltTeWsT1rz2qyCxyZwYrrLnuRwMUUQnJdoJQNS2uKYbqTogPM53sil5kRxZQK5ynFS95YqhJrCP9eepWzyofwPKq5qbr5DHgCcM2TdiLBoRKOx2A7jDuptDk53zhzg5u3z2kdLk1HGAMEfzBsm6FQMktgwBnMzqzT4c89+jFoRCIINyQS8/hJqwe1oy2G3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC6FvNkC2p9LVqdEsuYzLsstbFWhy3hehGkbCzIfSRg=;
 b=MmoGQZ4Fu6nn667sLGe3ZIgFGppgm318t9CXvYJdPhyJDZ6OxJEKSLV2wN9gX4Vc/JKJXp9cD9kwGL0EufdAM2/uuRs2SzrWDKfEeAuE5eGpYfZHFxyuIqmibsi1XjigO4ktCf5cd6QEhUCIBIOiTO1FBjS4qNXfKbL2tBbvZR5eM/A+bzplW2D6EF51AOKS41mT5Vx9MJZa4J/Z0b0/suBkb31uGIqvowgvAFtEvvFipHPFhmlbt8iv/ysOzYTwmZH/Tk3X0gR4n0MKXieGFf4J1wU5pnxvsXqi8GTbhXst3nGZCwFFEj2misJwcRN9KrH/ppmaYSZ3dg+hAEbhHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC6FvNkC2p9LVqdEsuYzLsstbFWhy3hehGkbCzIfSRg=;
 b=LlKCk/i6kLxbEAAHEktGxIUciJNJsYggd1u2GaQDb7/UxbapwmuxOicg1LcOtJbEe/xu3xVcTh4is4vOVvlDpBoxzm2+B0asFYMu7H/450ziQT7oMZVrQWtsALDCPujzCbrQt+6MVq80RF8HNjm/H8OOvpo0PYOaevYZKmZRSUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 10:48:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 10:48:22 +0000
Message-ID: <f1503afd-e299-4320-a60b-0eb2c57799c9@cherry.de>
Date: Tue, 25 Feb 2025 11:48:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: hs@denx.de, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250225023913.GK1233568@bill-the-cat>
 <176357bb-258b-2523-66e9-d94a51064f17@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <176357bb-258b-2523-66e9-d94a51064f17@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c2a528-f193-43ae-0362-08dd5589ec2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzdIUDg1dkFwSUVPUWtwWmlaZjhWYVdxM2lTZG95STV4L2ozdk1BcDFoeGww?=
 =?utf-8?B?SEF3NkMzYk84NkFGV1ZWYmtpY2MvdHZaQlJPWU9MSnE3ZlIrSDlTYnkvc3VD?=
 =?utf-8?B?OHZiWGMwZklDcUdxVjk5L3dxRmJoekRhRTBuNjVsOFc2UC85ZVFUeTZGM05m?=
 =?utf-8?B?NTUxbjFKbUQrODhRTndoNXRWZEQ3VmkrOFVPVWtrNjgrTHdQOVFQelVNSE44?=
 =?utf-8?B?NkF6ZTZkUUlTWVd1UmdrRW9ueGhPdkFja0JpYTNHWWM1YkVQTjNVOFVWRUhL?=
 =?utf-8?B?UzFDdGpZRFJnSVk5Uzhvc3ZpMVRidHdmV01CdklmTGhZVUg5WVNvSTM4MlpB?=
 =?utf-8?B?blY2TWliMHExckhGVENiWkhmTmJRajV2by92M3FtWDNQM3BzYUhYVWJRMlNw?=
 =?utf-8?B?ZkFqbW1KR2xCWUdqbE54QXRpYmR1RG9HcGhOQ1FyN3FDY3ZrYTZQekRuN0tk?=
 =?utf-8?B?VUlzWXJ2cC95L0JvL2N6azdlWENzYW5BV2JITUdXeFFtN3JWY3hPM1BaS3NB?=
 =?utf-8?B?RTg2ZzJSaFBzL3VBNHFHUHVvVUFVbXEvZlhRODVQczdCTDJoQm01YTIyTnM0?=
 =?utf-8?B?VGxQZGFWb1JtQ2FtNisydEhFcTAxRW1ILzFYQ0hJeEdPMWtGbnA5SEsrRUFK?=
 =?utf-8?B?bmpmOHR2bktTMVJ4Wm1GaHlFczZRMS9WL09teTJic1hnblpZYXJOWlBOWjg4?=
 =?utf-8?B?eW43bmF2bUpqS3lpTWMwREg2ZHZxU1VaZEtJYW9pNjkvUjBRaDVnczZDUmV4?=
 =?utf-8?B?MXBFeHlwdDczRnpoazRabk5DQjZSU2dXRnhNRXIwa0w1NU8zeTZqUkcyTDBW?=
 =?utf-8?B?VDNoRXZYRkEyYkQvVkhXWG03YVQ3NDlxVDdoQ005RkNNc005ZERQZ29Ta0hE?=
 =?utf-8?B?QTIvQjJ4UzdmdDRLeXNMRDV3ajJJWjFkby9Sa2VvLzJDZUxNd0F6a1hqQUpZ?=
 =?utf-8?B?V0R5elFwaXdrdUFhajl3dTlWcDByeG93LythNzZhMkJxLysvMHlMQVI4a0lr?=
 =?utf-8?B?Tnc2aG9mUXhOUjNXZndDdVNSc2xLUUk3ZEhUOHgvZHZwQ2IvNGl2dkYwQTM3?=
 =?utf-8?B?cGcxdG55djFKaEEvYzJhMlk1NjE1Ync0R1NLeHpieDNOQ3ZYQjlyeGFPRHRC?=
 =?utf-8?B?NnBOWURLM2JMNDRkWFNsNVdORysxYXZaTGMvUDRrc1A4STk4bHlXa25aZVJz?=
 =?utf-8?B?OXZZYUFzSnhjd3VOaUNQbmYzTUdqRVp4eGJac1ZPbGMwSjVhanFrcnVlc0FU?=
 =?utf-8?B?Y251QnVvS3UybVl0VnJNY1NLa245SnpNTWs5NTdHZ3ZCR0QvejVxZ2JVVnhG?=
 =?utf-8?B?bjByUlJZOUFvdVI0cGp5a1RiMzQyd1hHaEltdlUvRldSbzIrRjBMZks2VWNN?=
 =?utf-8?B?VTlaSGxVWU5ZOXJ1Rk1qR0Z0OVJ0aXcya0Y3dW56bUlUVnVFOXBOMWFkMzAv?=
 =?utf-8?B?M2tDOTR6ays5cS9WMVJNMU9pZFpWbmlDMldRSzZ0VHZkVUdGRTEwQWEydER5?=
 =?utf-8?B?Rm5SbzNSYk41QnNUaHFFNjdkZDYzbUg1VDZYMWg3T0FjV3FoZEM5WU9aZ25i?=
 =?utf-8?B?RmFkL1YrUWd3K25hU3NNdUdvcmJUSDdQOTI0SFIxalJwR0tMMGZrOU9kQ09k?=
 =?utf-8?B?UENxVDJhT3owNFVLL3NZV1M1YlZMVG1kUDFlWUJXNmVmL0FiS2RPWTdLekRI?=
 =?utf-8?B?VXd4RmNld1BteFY1THVUUURlS3poSkRKQlhMbEdyWFZtbkdwdEV3Z2FodFhG?=
 =?utf-8?B?N3gwNVptNWZkL2NXVUlBUGtqMkw5MEdrOE1CL3ZCN2pTRFIxV3FkWDBsWkha?=
 =?utf-8?B?c3FkdllNdlY4aThDU2w4L0FZcHJ6VlJoTXRlSzFoS3B0eEp5YzV6R2JVWm1R?=
 =?utf-8?Q?9k6LRht2D056c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGxERkJmWkZkdEZlOXp4Rzgva01FL1R0empaMXpVYnRqMXlia0FXblFBM1Bq?=
 =?utf-8?B?cmhNVjBSWVBYVWFkbjBOV291dERlcWFJL3IwbjJiYlRZKzdGYU85QStnZFpm?=
 =?utf-8?B?S3dvTEtvbzZtMVJPMzVDWGpqL0ZTeFZSZjhidUVhTndraVRMUXI1Yk45YXpk?=
 =?utf-8?B?dERiTmhvcWdMdU1ocHBWNlEyazZXM25DTTY0emlaZU5kT2lPUmxKcVNtYm12?=
 =?utf-8?B?emZyTnFRazh6WC9oUGp2dUp5WDVsWEQ0WFhpWDc1dkxvSGZnMmovL2o0Z1lO?=
 =?utf-8?B?L1RwNFh2ZGc1NW9CWTNZdmZwYzVCcGZvdjhjSGlZV0kyWENWd0hUdnF2aE1v?=
 =?utf-8?B?YVhjYzdHWmxSaVA4d3Vyd2hJMU96VGZjUGJxeVhqT082WWtkOGxHTmVaZXdv?=
 =?utf-8?B?VHdCYXd0NXZqWkw5dklmWEthcW1VWlpERDZGUWtUaHpEd1VOeXhVNFljMG1y?=
 =?utf-8?B?VkgrSXA0c3BVc0VDbDJFSlBFVVJScGlCRFpOM0cwam1sNktFd3VxNXYwWW5K?=
 =?utf-8?B?dzM5RDRaWmlPa1FMN2UrQVZVcnExMklEak44L01ZME40Z3B4b1NPZUhVbUhr?=
 =?utf-8?B?WU5aT3ltUmRpd3Z4a0d4d0F2dEVWbEtDd2FNRXBoa1kzTVdSb2ltQnJnL2R1?=
 =?utf-8?B?L3pEZElDdkxkemc3V0xRQ0RvYnBPRTdYKzNUZjAxMnFHT3p3N0FmaC9xUW9u?=
 =?utf-8?B?bVZFbk93MXo4cWNqa0tNYmd4cmREM1hNOWhrY2lqYmNwSkNDd2REZVdTWEpX?=
 =?utf-8?B?dmViRmNpOTdzTmZJUElTWllocXJvRExGZFRYN0NTUHdkc1dRM2hCSjRNZkYz?=
 =?utf-8?B?eFJtWDRYY2UwK2s0dWY5Mm0yNlZVVnQ1Mk42RllZU2NoRTcrWGZUR2lHQlNz?=
 =?utf-8?B?eW5QMGRFZ2o1c0tLVFdTVGhXeWhtOHpwY1pyZ3NaaEpiZmJla2FOQWR6dTVa?=
 =?utf-8?B?OVFaRkg1VTkySHNVL3Npd3pFY1ozZnIvMUo5QkRNSmh4dlByRWg2YkxlWmFJ?=
 =?utf-8?B?cVRIODdhM3JONVcyTDgvaFVVaVZ0WE9zUjZOSkhvaVlKZkNvMTRxdHRDNnZq?=
 =?utf-8?B?ZzFjVEwwNXRKeUFoZ1FFUUtQeU9UZ0dYampGVXN3enRoU2tWV05BcWMxRHg2?=
 =?utf-8?B?ZnlNUnRTRjRMQVc2RUs0UkdwdTBFbUsvVXpmdE4xWldMWlFkUUdDS0FPdVN5?=
 =?utf-8?B?MDRvTXBzQWRGbk45TTc3M3dld0xGZGtEU3BGYU5TMDlGUDFYSVBPVW0ySjBH?=
 =?utf-8?B?cEtrVWd3NVJCUlJLNVR3V0srUW1Gd3J3dUVnUjRJTDBLMVNVN1AxWjRsVEk2?=
 =?utf-8?B?QnBoVU5WZlc2MktUUXVsN3pCMUZMOHBJU3htUndNTmhObkVaellxZTRLODZh?=
 =?utf-8?B?dEhVRk4rbWtCejZGbDRGU3hQV0NienR5a1pIUi9JWU4vQW56ZWZYc2VqeDVQ?=
 =?utf-8?B?eFZQS0tQenQ4UFJ1RHBGQTExdVBUcDlOZGV6N2RxM1VVYmZLUUZQaS8zcnZ1?=
 =?utf-8?B?VmkwOE55bnNXR3VJd0RUNFU0eTlKanEzUWJJQTBPZTUvU05NNkE5QjUxYVJM?=
 =?utf-8?B?UnB5dVpJdkZyN1RoeCszVkZTaXZ5UG00RXpSMTd3c3BhbDZDeGVMcUxucUI5?=
 =?utf-8?B?S3lkMWVycjJhR0dGR2ZrYzFZTjdheW5qbWxaOEJrL3ppNGVqaDExR1hKV1M0?=
 =?utf-8?B?YklYaTR2OEJHYWRTZkRMZElKSGltR1p1c1lOQnZvdGo1ZXdRSzZDSkt1Nmx2?=
 =?utf-8?B?THhGUW5yTEU2VzJIbGhwNVNBR2dTckZqdmlRQTdiV3YxQ0FNUEJSWHkzazBj?=
 =?utf-8?B?SW4zSHE5eEJzRzBuTWlqbGZoQjlyeE9CS1ZncllmbmUzQkYyTURDdnU1c2tL?=
 =?utf-8?B?aHlDTVJpOVVSOG5pYTAyZlExeVE4Y0Q4cmh0N3lXZHlmS2lCRUU2TXJMNVFq?=
 =?utf-8?B?MHdhWXBXK1VwSGU1aEd4NWkzUkxnRGVieUxsY1VueEpaZzhHeVVQYjc4MUNl?=
 =?utf-8?B?eE1SUFdwak9aNTl3bGtiVWlwaThWVGRjWHUrMHdnei9NanAyWVVVTXVCYW9i?=
 =?utf-8?B?bjN6aXV4dXlzVjhtZUtTcWgvZU5CV1ZRU1VOMm5uSFFlWGFjYXcyMkN6V0hX?=
 =?utf-8?B?ZWx0WHcwdEZCZ210YkpsdWhHb1BXQVkzUzh6TVh6dVBEYXBaRGt4U0hqZVh3?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c2a528-f193-43ae-0362-08dd5589ec2a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:48:21.9608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+tGz4t1hyxjPKozs1ayv6tISnsNuf5w2wy47yEQP+M5bdzTX9n4YOHo3LBxawkiuTgKLJfBQO2PIb2D/wP/ajcxsEMuTWzSikc+2piUbDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862
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

Hi Heiko,

On 2/25/25 7:06 AM, Heiko Schocher wrote:
> Hello Tom,
> 
> On 25.02.25 03:39, Tom Rini wrote:
>> Here's the latest report. Getting closer with the led change. I do wish
>> it was easier to test fixes here.
> 
> Yes...
> 
>> ---------- Forwarded message ---------
>> From: <scan-admin@coverity.com>
>> Date: Mon, Feb 24, 2025, 5:05 PM
>> Subject: New Defects reported by Coverity Scan for Das U-Boot
>> To: <tom.rini@gmail.com>
>>
>>
>> Hi,
>>
>> Please find the latest report on new defect(s) introduced to Das U-Boot
>> found with Coverity Scan.
>>
>> 1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
>> 2 defect(s), reported by Coverity Scan earlier, were marked fixed in the
>> recent build analyzed by Coverity Scan.
>>
>> New defect(s) Reported-by: Coverity Scan
>> Showing 1 of 1 defect(s)
>>
>>
>> ** CID 542488:  Control flow issues  (NO_EFFECT)
>> /drivers/led/led-uclass.c: 277 in led_get_function_name()
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 542488:  Control flow issues  (NO_EFFECT)
>> /drivers/led/led-uclass.c: 277 in led_get_function_name()
>> 271                     return uc_plat->label;
>> 272
>> 273             /* Now try to detect function label name */
>> 274             func = dev_read_string(dev, "function");
>> 275             cp = dev_read_u32(dev, "color", &color);
>> 276             // prevent coverity scan error CID 541279: 
>> (TAINTED_SCALAR)
>>>>>      CID 542488:  Control flow issues  (NO_EFFECT)
>>>>>      This less-than-zero comparison of an unsigned value is never 
>>>>> true.
>> "color < 0U".
>> 277             if (color < LED_COLOR_ID_WHITE || color >= 
>> LED_COLOR_ID_MAX)
>> 278                     cp = -EINVAL;
> 
> So I simply remove this check ... and add a comment that LED_COLOR_ID_WHITE
> must be 0...
> 

It's part of the binding from the kernel, I assume it's safe to assume 
it'll be 0?

Also, this is guaranteed by the fact color is a u32 in 
led_get_function_name, so it cannot be < 0.

Cheers,
Quentin
