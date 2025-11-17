Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D917CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 09:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 835BF83B0B;
	Mon, 17 Nov 2025 10:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MVgk/uwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A86283B5D; Mon, 17 Nov 2025 10:08:38 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF42F83B0A
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfrAykYim7k5xQksQdFnExWotXVcpf9Q7IdZkVcKwKz5pGabwvggs7SgWqYKVsM4dBecxewG2tqYyu7VhwxPxqi7kVqxVOa8O65heSRQjr7JO5HRPvkTwbFd9fco8hPTYcaO45yYAX62mzLhmOmJXlIwculXqqBThb2qX4GEaqaI77Wq3NK/anw8+vF7zVuTMDd1nmOzt9mRNaaapm6fhLAVvInejY3OUV0RMqpcsBP/+E9/F8Xs1bXE43YX4uTRfYYXmwLB/sRfm24cgF9ifQf/3T1jC6wSMcMDreGYLd2kk7Aue/6LPNdaiFwun4v85OjhoHq1DrB1H24J0Bt4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNt4oHupFYuV6zNl43RoZxB53X/LmHEUH2EsEAkMp5A=;
 b=l0ROvPgAvCmaSJ7JScbdUn1jf4tjh4uD/LiMaSVO1cQWL7IdEcQLHxedjUJXiXU9UDbkB9kRf/N8HgLxrYXdPdsG7iLMAawVcvnRK2vNAMgpq4gmBJXYpTlvB6bNCH4D3evy+LTZKMgjTZ7qsMzXMDg0OFY0ykAqvVNIPqJJYsPgGTrpG54+7PbjOPLNox+l4+vz9DB0zjOl1RqJuJczK7lSOw+OxvhtQPD9kC+w98Qa5LtBlD+msi0Woz+SkZpJptDsA/rE9P4sok0z1U+sX2VvbyjeM6XiTxgxcb34d2vnYi4rCshXXy5y50y6IniJzsGfxHcFpzUKKrLfIF1DMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNt4oHupFYuV6zNl43RoZxB53X/LmHEUH2EsEAkMp5A=;
 b=MVgk/uwFm5DGbfXyBlPKqkMhegz8fOJKnO1nNcbrOFk/M+gpsgoXekc1RTIkR75r/oPXFOSLQzN/EEtmKohMQkp1lbdXISGd/3Szrrl0tyE1t7WE5cUqsgaBpr6hYJtKEyKVc2yD6H3SDj4y9DKvUq2QDhx/QKuPEtjWClSo60ZTuObTCYr59SV1zlFjXKh5PsLehBzXlLlmqQM9mqFuyIDPRrHjKBx/W3CAPEo4VY34c4k/efl5kS329mDavQk5p409ccgYjETdtWXGVbQIUAlX+niz3eLa58pDxTJsBeIeNuE8zJrLWmqfQlYO+0XbAgSnf4YUgxAZhNrnzM5nXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MW4PR03MB6395.namprd03.prod.outlook.com (2603:10b6:303:122::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 09:08:31 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 09:08:31 +0000
Message-ID: <ecfed982-60f3-4427-be07-94e014e34965@altera.com>
Date: Mon, 17 Nov 2025 17:08:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sync socfpga common u-boot dts
To: Brian Sune <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251110050040.183-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251110050040.183-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MW4PR03MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 21dc934a-dfcb-4c3e-6dda-08de25b8e0be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THc0VmtZSTJZdHZ6TWoyTENuV1NPc3NNNVU5ZnlWVVVIVUtXQkJCTmI5QXMw?=
 =?utf-8?B?NHdST25SUVB0VC9QcW5tMWw2Z2FVOWwrcHhpR25QNnhaYWtORVU0SWVwakRH?=
 =?utf-8?B?NEoxQTdwNlh4ZDZlSEVSS21TaUhDVmdhNUFXTmRDVUhqYmNsTVlpM1lZendI?=
 =?utf-8?B?eit2N1psQXl6b3ZvZndtUGs2OFQ3L1VPS3ZJaXNVSzVRQXhoWnU1ZHpwM2lU?=
 =?utf-8?B?Y3dYcEd3eGhIWkY5WUJFWHl6bHRzRnQybkpxZVpHakY1dEFndmVsc0dzcS9Q?=
 =?utf-8?B?YmVzNUVYVGFCTmExbm5DYnBEcmZwelRsdHAzaVhoR1ZrMytiR2NvR1h5bWdS?=
 =?utf-8?B?UkRoZ280THdiU1lrZjQwbWRLM0d1VlFIQndMZXpoSk1Gb1piNk91cUtYWVMx?=
 =?utf-8?B?VE90THBIQ2VTNTVRajFuUzUxVnV4QTJwb3dLanJLL09KNlZyS1UxUjJGaFFL?=
 =?utf-8?B?bE4xUzBzY0Q4MUNjZVJ1TS9hTWhpZm0vdCtqQXVNbUx1dVRyRHFscldWZWE5?=
 =?utf-8?B?N1NKbStrMmFqUFlzN0doZU4xODN0YlVoTnROa05JQS9VcmRFNUhmTWswUFVo?=
 =?utf-8?B?SkFka2xPcHpXeFdJOWU4eC9uWHBxT0RsNWc2djVwUGpHNUV1Ylp5V2U5S0R0?=
 =?utf-8?B?cjJpSmZVeWxhekhBaUZjK294YUhDeDBVditpSzIrbnBTVzFmZGMvY3dGSDFP?=
 =?utf-8?B?RFBxVHZmK1JWRS94YW44M2Jod3Bub0lwcTREOTdnaEJvSVNuUmxWZ092clpx?=
 =?utf-8?B?U2M1Q0R2TnNwWnlYNmdjaEJsY3kxUE9uYmZDaTlaN3FzeFpLUmM4c3dpSC9o?=
 =?utf-8?B?bFBscTgvMEMwMHEremhROWwzNm41SGhodDEya3VRdGdzc0w5T01ZWXlJK25T?=
 =?utf-8?B?UzM1UERpOFdTbXlMb1dFclp1R21FY3lHOHZRcGRPRzY5OFBGU1R3NjFhem90?=
 =?utf-8?B?OWhEbWtVTHEzWnJsazhmK2gxalhsZFlROE5lRnlxSUZpUFJKRldaZUcyKysv?=
 =?utf-8?B?ekNGOFlFUnpCK0xiMCtTTERaT09qYjVOZmswWS85Wk1uTXp6R3JnNHlpTEpZ?=
 =?utf-8?B?SVZzK0J4Tmp0RDRhdzR5eDF5RDJqYmN1M0ZIRTRFVUg2eFZLUVFwcnYwcDVO?=
 =?utf-8?B?WFJWYnhNaFAyMVpBSjA4c2MreEFaWnlYbFdDSWVlKytWYlJOR2JFeGNINExH?=
 =?utf-8?B?Nm1FbWJYODFkVTZsU0NHWWNsRkszMUtzNXZFVlBxMFZKYTFtRzU3SWlmREE5?=
 =?utf-8?B?RHBZbUMwaUgxS0FPY1U4ZURJdGREd1BIdkxpdWhjNDVlMjc1ZjdBb1BabjAv?=
 =?utf-8?B?Wk9sZzMyNkRjSnFJRlI0WU1VOHRGSXNJelVFckN1SkczSjczQ01Xd0xsMXBV?=
 =?utf-8?B?YldkdXljTjR0TExPUTI3am9KNVZVd2hhemMwYTYza0Y4cE1mdXI4NWduRFFV?=
 =?utf-8?B?cDhyQzRTZXd5WlZVYUZQRk1kQS9iL0tIa1hsMmdUREM1R0o4NUY4cUMxbGRI?=
 =?utf-8?B?b1RpU25CUENqYlBxTjJ6OE1NU2tmYXNZVFBJNVpCSWJoaFpaQTN6Q2gzNGhr?=
 =?utf-8?B?NGtUZFJWRHFaelpYc1htbHBsODlSa3V0UGFmV05DSjVaa21iRXJMVGcyMFFx?=
 =?utf-8?B?dlBoSEhKUStobVpIeU40aW83Z2YwQ2NNdTBsWkorL0pSNHpYVnZ2TmdIQkRY?=
 =?utf-8?B?L0Rjd1c0cDRqMlo5L0FGV25OL2loNmdqNElJdjdJOEpydC85WGhHaWh3NVFy?=
 =?utf-8?B?V2tGUmFMczFNbGYzckk3b1Jac0lPUTZLUjJuTCs3ZTdscmhuS09aVUlKNXhX?=
 =?utf-8?B?L2pPa2NtOU5LaTdpaGlCQzRPM2ZndHM5OThWRXpkVGVmNE9mQ1RRV3E5ZG8x?=
 =?utf-8?B?cS83cUZ0WDFPeFl1cUI0Z21Hd3J2R2lWSkNWNmg4NVVtVzdnd3BqVCtGNFlF?=
 =?utf-8?Q?oh84wpKVLj3W1O//PMAxHc+iTFbenG1I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNQdE02cWQvS3lXN05mVUdGUWFJZG4vaWhrYlhSWGNwcGRST2tVOXQveXBP?=
 =?utf-8?B?T2pHTXVVcWswbTU5eDdJSGZFSjN2MWRZbmNhai9oaWVzVWtqV3UrcDBuZ2pU?=
 =?utf-8?B?dFZLdjVOWGJYbHRXLzY2WmtFdnJNcnhSNlZsYU1jWmE2ZjdWY2lFQVIxNjZ3?=
 =?utf-8?B?VGxDdk1aZHF1L1V4VU9LVGFzdEpnQ3hZL1Z5NmpxL285YjBTdThDMWYyME85?=
 =?utf-8?B?N1ZXRm5SK05mRklBU3kzVmpBOEpNZzVYbmQ5OG9hRGNkYnRhcU9HREppR2FW?=
 =?utf-8?B?bDVGSEJFOWQ5TEJVUzExTkwxRTJoOTI4c3VFbWl2Y08yRExnZlpQZ1hjVGkz?=
 =?utf-8?B?U1RUUGE4b0NWeVp5bnBLT2Zla0h5RnVzM2tIemJ4T1pFYWNXbHo1NUNqSWZr?=
 =?utf-8?B?MmIvZURuamMxYTNCVm9FdDR6dlFQTHJoV1VKSHJQMWoxeGlCdm1RS00yM0tD?=
 =?utf-8?B?OUZhRWU3aFFMUUpVaVhjTVVVcVJuV2l1RE9hL3hLWHFhTjRUTEFMWHRiSS9B?=
 =?utf-8?B?aXFQODI1clVSS3hsN2VzRnNEa2dTM0JZNXpRMHkvVHVTdlIyK0pyYlpNdjFM?=
 =?utf-8?B?aWxvK2tDU1hFaUhaQk9wKzlMUzFTQ09PRktqK0F0UG9MYXJkWWRWS3NoUGZz?=
 =?utf-8?B?UkM2aVVJRmdqeEtoWDRBZG5ENDQ2Y1ZXN0hqZHVQQWRSR3U1YmdCTXFJd3hS?=
 =?utf-8?B?M2V1TlhQdEdLeDlWMW5FcFBJaFFUdFZTVnhCaXZoTVJiTGtRTmtmcTZzbVAz?=
 =?utf-8?B?NHdUOXN0Y3BqSkVhN05jaW9RcmV2eW9sSDdoS25RUU5BcVB2aERPV25WdURl?=
 =?utf-8?B?OTVPRTZiRzhhclZtcFdIWXFmVC9UbFd4aEp2ODdGVnZueHBNRGJ3SE1UYkhI?=
 =?utf-8?B?WExnUTJPaHdWbFhjSS8yU1RqWTkyam1WTGZMWDMveld0YzB3TGFXN2V3b1Yr?=
 =?utf-8?B?Ny95TCtKVitqc28rQWRkeGRZY0RpZ3ZFN1gxcGQ4T1NwL1ZYR1V3Y1IzTVNm?=
 =?utf-8?B?ckhXVHovYXlOaXRUTWFMV1ZDeE5DNGNVVkJmbjRYb0NZaXh4Vnhyc29Icmlh?=
 =?utf-8?B?Nk5aT0lrRHowWldSc25IVUhLamdJMFFmbHEydm5SNjJVeE9vTjQzSEM5NnBM?=
 =?utf-8?B?dDJhOHF5d2JodFNaTEduL1Vzd01Belh3VFM2aUlJM3RJUFRTRjIyWVBZbGtJ?=
 =?utf-8?B?S3paVjR3eDc4YXpXeWRaSGJrWUZLU3UxZDduMWZ3U3p6RDJkdkFhTC9zQXhz?=
 =?utf-8?B?KzdIUDBRaVU4THAzK0dqQjkvcWRYbHV4L2NPeVVKREFWSkRxbW1PMUZYUzJ2?=
 =?utf-8?B?MnIzcys3UUQ2NVZ2eU9EdVJIQXdDc3BPb051UkxrT1E5Mi9lcDdvakFLeTE1?=
 =?utf-8?B?ZXhWd05wUkFxcDBoV1ZQWjZ3VXMzTHZzZ1ErNFNrVGZBSHp4RTlxaUJibHpz?=
 =?utf-8?B?VjUwYU5XRVROQ2g1WVBxTG54c3MvbGhhSWRvSHN5Y0Z1dnlXelQyVUUvemtP?=
 =?utf-8?B?Q1VHQTZhbzVxUGJIcEQvMHFMNTZJZklDL1JQMUZmR2h4WXEzMW16SWsvb3pW?=
 =?utf-8?B?SGhQcDZCOTdQbHp6OTV3SmZySmovZjlTQUJRTXg4SkdUUVUvZVNYVmkxb3d0?=
 =?utf-8?B?WjVZRXU0QnQxZ1E2NWZTUGk4dkZNSW80Y1k3VnlsN0JFRG5qU2xnbEVNbUx4?=
 =?utf-8?B?Z0QwdlZySmhxWlhNNjlmTXJjYjhHanJmK1pQRzU1VjJxVlY4ckJaQkdRYUhs?=
 =?utf-8?B?MXpqRm1qcnFrNWxmbHhscFE2U09QREtnQ1oxR0I1Wlo5THZaS0Q5WmYzeHk0?=
 =?utf-8?B?cUdQcjFlVHZKdTFQcnZWbFlneENsUnNZcUU0bmtJTmNnVExIWVpsRnZnMmFH?=
 =?utf-8?B?MGZoK0R3Tkt1Z0FMaEtZVGVVcWNXLzhvN3N5UENpNGVGQ0QrUXVmbVoxMFBX?=
 =?utf-8?B?TFV0ZWJOYzVSUWhhVy8rSGtOaEhraEpLMHBRaG1oc0tDWWowd083TjluajlS?=
 =?utf-8?B?eFNRZkhiZFYwcnd2TDk5TVVhUENZbW40NUsycW9lY212anB0MVVrS2wrODVX?=
 =?utf-8?B?WHpMcXgwSmFJSEkxTEhWTzZDRnVrdng5RzdtVE5MMWdHZVoyQnoyaUdnWjEr?=
 =?utf-8?B?UnlSZ0xNNGxwM2puKzhRZXNmUE9KTXFHV3dWbW5LRjhtczh1NU1qVnZvSHBo?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dc934a-dfcb-4c3e-6dda-08de25b8e0be
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:08:31.1278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaPJLWmOHkS6v8GRPdiTtTeJgk07vk/yRs6Sq6sLAfauNwkMPt1fHm1kAd+6SZHxX3EVg9z41DVfVWUL6LK9yf7rle/yVzH3GsXFnKwOsDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6395
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


On 10/11/2025 1:00 pm, Brian Sune wrote:
> The dtsi for socfpga common should
> turn on L2 and memory and no reason not
> to do so
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/dts/socfpga-common-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/socfpga-common-u-boot.dtsi b/arch/arm/dts/socfpga-common-u-boot.dtsi
> index eb3d1039314..ff9da15665f 100644
> --- a/arch/arm/dts/socfpga-common-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga-common-u-boot.dtsi
> @@ -5,6 +5,10 @@
>    * Copyright (c) 2019 Simon Goldschmidt
>    */
>   /{
> +	memory {
> +		bootph-all;
> +	};
> +
>   	soc {
>   		bootph-all;
>   	};
> @@ -14,6 +18,10 @@
>   	bootph-all;
>   };
>   
> +&L2 {
> +	bootph-all;
> +};
> +
>   &rst {
>   	bootph-all;
>   };


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

