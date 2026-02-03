Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED26E8784A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C4E83B5E;
	Tue,  3 Feb 2026 17:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VwZcBd6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E7E83B9D; Tue,  3 Feb 2026 17:42:17 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E619C83B55
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJr50UaREIvxEb/vTKWaopFGQtvJy8RWWbJG0sjJsWFAfKOuB7Rgs6B0hWPtIuEfYKMjD2243ZIQGcKJa/6rWAB3CwagBbAtM/g5lwzdvvJem8VzA3ZJ1R9ygviHjTmyqx25RNbDVGXgCxYzOt66OC/DyRtTb9XnFc7OBDXCbktvPaCBg+eiCj+aZkVh0qlACCAR8sT06aXh9Qje4mBxoF5nvT/WKJ/2wmVvlxGXJo6i4BI66imjUWMswzvgXKTgrP6q6qobkMWBfT3ByLidCz9H1tiOKxYJXAAj028/cBeYdVKFgJmx31UcybbAVeeGrb8hG7LZ3JzqMRmNLoNRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSpjXsoJ2n+T4FrF9psdMjmuDqJkNBdEQ4ju2SQqsNM=;
 b=qoxxx2Mw08HjTXBrrenJhZJzVRsv2xz0hfFCQhKU8INYojZ7iSsA4Ph6WTcxKK+RnP4nPlYrH/x0v+PpaXAhjhIe/Ll86bUrpVoGhkkXN/K9b2WSVYhUzR12myw602d72lfR93xWwypDXFHy26wa0sUJSFjhPmZgfwxAb+L4hu4FqBy2Vh0fnEbPp9WXB15OK4R/Y7qu/L2uxtA+hClA+xCCsxPvyrx2IWU69kPUUtAUz4NWWK+IsONfXqENVfJ5IzTtSPzKwDbW5px3CgG+kZ7AQejq/sJH/RZa6EKMrr1pQe9qw0CJumG8ZKTH25FQSsG57+yMc9c1W9PIsxarAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSpjXsoJ2n+T4FrF9psdMjmuDqJkNBdEQ4ju2SQqsNM=;
 b=VwZcBd6ws02eOPSy0q/6pKpbjPYJIMeXTk9RgBLc6X+qbmQ08TQAdc5V/g+2BuW7cLPOnesFn4wOk9MYhulFw+e09NS/bIfpsZ8IHJVnFys9zibw8NUCmtVJ+qhmgMyJ7vjNwNcyVxqPpP7CTcE3m+4PGTnxmB3QoldVtEJ9PEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10256.eurprd04.prod.outlook.com (2603:10a6:800:241::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 16:42:11 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:42:11 +0000
Message-ID: <560423a5-fc7a-48c9-9880-c68f9db6ac04@cherry.de>
Date: Tue, 3 Feb 2026 17:42:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Backward compatibility to U-Boot v2020.04
To: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10256:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a486980-d7cd-4e52-e71f-08de63432dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUVvYWdNMnAzUzJOa2l3WkJETUViRDJDVE1welIrSlhQSVhldVVEL0FNWnBv?=
 =?utf-8?B?ZmoxdFJPZzBxZWhCSnAxNEE4cVZFd2cySng4YVFuMTMrbitBMnc0U3YxYUlE?=
 =?utf-8?B?cUg5dXgvbXhiK3cwSEZ5OGNhZVRpZGlzak43ZHd5ekVhOGZnMlNyK05xc3lO?=
 =?utf-8?B?bVpKK0d5Mm9ENS9MNEtYOTJWSHo2b1oySStFZlFjMmpnNjdzdGJoc2VFTXkx?=
 =?utf-8?B?VVI5OS8yZDUvallZbEk4Uk5uY0F3MzNaWU1keERJMXlrTVJzWnRHRVducERh?=
 =?utf-8?B?MTFFQ1A0anoyOW5YVHhTV2U0Y1YyZlZ2TzJPekFCcENja3BvaDY1STJHMWEz?=
 =?utf-8?B?aDlVemN6cHVLVStid256ZmlpeDRHNjRudnhlTTVONnhpd2JhSHlWS29pNjRC?=
 =?utf-8?B?bFdsSUxjMzRzUUhaU0diWWIzOWtwL3dub1JSRnZDTE1RWGhONTZWNzVWQnRN?=
 =?utf-8?B?SWdrRVhuTmJxdnNkZEphclZkVTNrUmIvMWdhQVRoQmx2MFpEd1gwbFZKaTkr?=
 =?utf-8?B?WGc3cmwzdmRsT1o2am5SQSthYzF5TDZ2SGpUM3NBT09QdWswbWxDQXh5VlBy?=
 =?utf-8?B?Qit4c0hOTnZVQ2lBSGtwS0tWNWVkZkU1QzlJVHl5TUlHV1FReXI4T0xGVUxt?=
 =?utf-8?B?Lzk2VGpJZ3RlZFFPSHlybzhsdFMwOFJTZTVwckdGUGpnTFpTOEx0VDJ0ZkUx?=
 =?utf-8?B?bDdoU1hQM25YdGhlVTRtdjhMZWEzTXI0SEEzNUxpdlJkT25Zb3hFWUtEVDBy?=
 =?utf-8?B?L1gzdUNSdXRHZVQ5YzdaVmNxdTlqeHNUM3pBM0E1anNPcmVlMGFkK0RERHRp?=
 =?utf-8?B?ZnV3ZXRtS01WclArc2tlZmlwTElYNmF1T1M4dXBEanUwME1ha2hteFp4VUo0?=
 =?utf-8?B?MHVyTUwyakVaNEprWTBGYkJhOGNmMjZOOElNaVBKcWtMT1lxQ1hQL25CSWxn?=
 =?utf-8?B?ekcyYUxkdmpnU2EwK3dWWlJQbTNaNndvQ09GZzFEdU1uNnV5Mm1ndmJxb1ZV?=
 =?utf-8?B?cE84Y0MwMUUvZ1ZoT0tiR2VURTZTZnBFUkNSWXZFUHRnNVY3WmVRMmpTS3Iw?=
 =?utf-8?B?c3JTUmVLbWx2RjQwYVZpTFliU01VbEZnc2pOckVCQkxNYTJ6R1JTcjdmVGpy?=
 =?utf-8?B?MzMwclBuV1VTTlRrUzBUL2JHbTJsZTYwV1d3dnc5dmllK0JyUjVRYXVkU1U2?=
 =?utf-8?B?YkJnWVZmNEQwNmFXNDQvWjJWeXZ0RkVXYVU1TTNyVkdiV3hSS2pZMnB5WHlM?=
 =?utf-8?B?SWZCRzFlSS9xcFpBZHhJTVg5NW16V0gyaXhwSUZKS3RHcTFNYkNXWG5rM0pQ?=
 =?utf-8?B?MlI0M3FhWDJCdHdrVEEzK2c1S1NEdzJqRmtadXNZSGxudS9BdytIRW8wQzAr?=
 =?utf-8?B?MkdFVVJwMk1JQ2ExRERoZ2Foc251NTJZY01PZVg5MGVqNkdvNjBqS2MvVEVQ?=
 =?utf-8?B?cFdpQldBb3pCQzVncXY5YmQyL3FoY0dtOGtKMW5DZDJueUlSb3R3NjV5dlIr?=
 =?utf-8?B?c1RIMy9XS21yTVlHMElwb0lpSTQxMmEvL1VEMnRiL2ZzVkxEbURvN29SYkQw?=
 =?utf-8?B?ZDZ6WWVaY0VlV1ZWTWw1dHgySmw4R3I0L28rUWVvRFpCVW02cUI0V25CdEFo?=
 =?utf-8?B?N2xod09YZEF1YjJTN2JleEN5bnZjUVp0YytLRElyK1h0SnZYZ1J5UHIzSVlv?=
 =?utf-8?B?MjBxM2FKK3BYeGJ3azgyUlp2YUQ4NGhETDJVU1dFRU5FRkExM2hRVkVEZjRv?=
 =?utf-8?B?RmtTYWl2S3JFQ2RXUTRtT2tJdVdReU1FaU9PbFJBTEYwcmtHTy92T3lmY3li?=
 =?utf-8?B?aVZTZ0c3Z2VURm5mbkc1TFJBL1E5YXlOS0pGM2dHUlptY3pCcUtjWVQyYlVm?=
 =?utf-8?B?bWE5S0s4am1zQ1lsMVg4ZEdtUU9TbEt1U24vaDlVOUJBa1RMY2JWdFNPaWF5?=
 =?utf-8?B?WklON1ZPMDY4KzBlc1hMVXY2Ry9HT01zSm94L1dvSjcxdVBSMmJnQk1iUkln?=
 =?utf-8?B?a3g3b1Q2SFJNVlpKNWF4SmE0Z1ZtY2NsVVA5RUtWRkM5MVI0VUFKMUY2WTdR?=
 =?utf-8?B?ZFhSVkt1bHBMLytsd3l2RmhveUZIcXNib2dhU3dOaFNVWEIxTzFBK2RPc01N?=
 =?utf-8?Q?Hd48=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNBVkYyUEFyakZPU1FiOHpFTFFsUXI5c01qMGllU05yNklFdCt3NnlnR2hC?=
 =?utf-8?B?UnNmODBpalcrVHkxd1lpWVV5dUhJZjV5TWt4d0t3cmFDTTZMYTN1dDB6TlNa?=
 =?utf-8?B?RDBGQVBSeDZjK01PekhGelJKTWhVOGxza0RTcHY1N0cxQ2toeW1ZM3lqc0p3?=
 =?utf-8?B?bHZYVFhDZlhDRmtVRVlXYkx0NklLSGJlWEE3WG1FWWVpZEoybGRPdXdJOEUr?=
 =?utf-8?B?UVFseU5scnV1ZnVVSWJHTHZWVWJrVmRWUlplRmg3djBaMDFlZWpBQ05DMzly?=
 =?utf-8?B?ZEhaUy83WElNMmhQbXdvRHB5cWVaODJORzZHK1l0UStod0QxaXlrU3J1V3VK?=
 =?utf-8?B?Q1kwWW1jbkZaRERrYU9qbmlYbFBFeS9SUkVxcFp4emc1aVFFUkpFcllocERD?=
 =?utf-8?B?ZEdGQktPYjZwOWNVdk1GR3ZGZTJ6THRWbEh4R3VNQldJRGtWOEdqS0QvRElp?=
 =?utf-8?B?b25tQzFNcytzVnJNam9aMGNIVDR3ZklqQUF2S01SbTdtU3J4cWdKRTczUG9Z?=
 =?utf-8?B?cFJwcXdzTEk0N2srWnA0WUZqY050ZUNXakdueU9wRlRPMDRlNE8vRDNwUlVy?=
 =?utf-8?B?WkNiQUVtaDlERDhQczVXdm92Sng4bE1JZjRZTXEyL29ZaHRxRmZUdzNSelJ6?=
 =?utf-8?B?NmN1RWJkaUNwYktpWWNBTFJ2TVFKVVorWm0yejgwR20va0pzMFNYaEZNeG5a?=
 =?utf-8?B?emFzS2h6c2dBd0lOcFZmTUp6bUVaSFRGVUNOUkJKTUE5ZDFBeHJuaE5wdTBl?=
 =?utf-8?B?ZlF4QXJ4b2N1dWN5Wi9CeW0yRmxaRVdHdGhicWRTN3FHUks4M0FrZ21vK2Fo?=
 =?utf-8?B?Ty8zRVViVmZlZmF1VVJmK25sL0kwR2ljczdkdU1OQWxtbzRWYkx5T1Q0aEQr?=
 =?utf-8?B?R0lWcll3OVJpT1NqTnloSnR2TFdSWWM3eUl6Q0tsdnhDOER4STZicngxVGll?=
 =?utf-8?B?SWxTQWFkREgwS1crL3B1d3d3QWQzeWs1d1Y3eGQvZlFqbUZ0UzR3TVdSZ3ZY?=
 =?utf-8?B?bStZUFF2Y2IrZnJPTlZKb2QrUkV3SFY5MnFWWXI3cU94ekcrbFUyZW1mTkRq?=
 =?utf-8?B?K1l1dVZvQWdrWFJzSXhBTEc5a0tQVW9vVUlhSU9lTSsvNVpVbU02MU1pai9k?=
 =?utf-8?B?MFc1VTlUSkxqUXpmVWFTc1pUblhRN1V2RldiK3U3aXVTR3ZkMmIyYVI2cUpk?=
 =?utf-8?B?WW03M0FqY0czejB1bUthWjFTbGVaRVIyRDhtZ2R5S2N4YmZsb1Z2WjdmTTZl?=
 =?utf-8?B?dFViRkxERGpRNVNCdmRVc2NSS3hYS0Z3ZDdsdHYwUk1GYnNTV0F1MU04WndH?=
 =?utf-8?B?SW5yNlZKbUJiOC9nbG1FZzhtWm1kK2Q3N1Q0d1ZkQTVab3dMMWdMcWdEb2VK?=
 =?utf-8?B?WGo3QnU3b1V4d3NBZ1ZtbjIzQ1dPUVE1REh6QytETk1PeHkva2RpQUNPNlZI?=
 =?utf-8?B?UDZmQy9rWGJZb0pBU2hnZkpWNzFYL1pKQzdLVmUyaUNaMmRkalU0SHBGSzh5?=
 =?utf-8?B?UzJKVEZMb2tiQm52UzN5cXYwd0IrZFBVRUxFSUw5RVovb0M4QUVrb3l5WThI?=
 =?utf-8?B?MkFhVVRUV0RiWDRIazMvbDgyZE5YYjIvTjhnWjdUT0tPMWVFL0xScDhQZlF2?=
 =?utf-8?B?WngyU2xUUFJXdm42bE1sc1FDNVIyV3NpWGp5U2ljRUVKaE9DSnF5YmM2SHV5?=
 =?utf-8?B?VU1qTHBkV0tBUXFVM3BySktTM3pyaTQ3L1NnSm83Slc3N0JKY01td3pVS2VZ?=
 =?utf-8?B?T2tscjlydHlDYW5vVHdKOVhWK1loTk1wS3cyM2E5YXQrZnhJTGtoQ010TFBm?=
 =?utf-8?B?cGtnSnU5d0FzQ0pkOHBhUTBjdjRoWE0vSUREVXlQenQ5ZHAxQ1l2dFBicXFs?=
 =?utf-8?B?NE5NR1BuSitSZzlBNlRnQUdTTDBMOUtLUE56YkJkQlVFa2lEVWNZTjJySlZQ?=
 =?utf-8?B?THBwcDcrRE5kY1dnV2NqbFhVSHNRM25HQVkyWWVObmxEQmlBMUpoTzF2cld4?=
 =?utf-8?B?R2l0b0ExK3RkcmZZYTgzY0duY25kQ3lTeFRHTlgwWGZnSHBML2dSYU1YZFo5?=
 =?utf-8?B?YXNmNTlUa2tLQmdGRitwUU1PTS9HWHpxN2NPRGFVUnNWclRwWEhsS1FCdXJx?=
 =?utf-8?B?RnJxWnRUNmpyeWZXTUxZa1A3RHUvbXJSR29vem91TExvT3U4ckR1MUFTcU1j?=
 =?utf-8?B?bTVOenQyNnFpNG5CdkQzaEUxeHhyN1MvY2F2TnBCc1cyY0ZmQmx2a3RBM2ti?=
 =?utf-8?B?czNRZlVLYWpZWDhJRDRlTElxcUs2NHUwWE12a3BTUUpUdmtOb01tTTEzU3M5?=
 =?utf-8?B?cWxyWVdvRXVlNEt4cmpWQkZlTElhNzlBR3JQbWIzbUJINmI5UXRLSFpxeml4?=
 =?utf-8?Q?JvzQv0iUN+jGQ5pITqb+xX2Pb4YsdhlnroWCU?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a486980-d7cd-4e52-e71f-08de63432dce
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:42:11.6701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89pRQsEMNK8J+1HCsSDn8EpVs6zsIWeBJIuiOjGnhKhUXLkMgFFD1i1cfcTNvdsDgtcgp6dCEuomfSzuxN4hOA9xxZ//aWAtuoQglsbOHu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10256
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

Hi Dorde,

On 2/3/26 4:41 PM, Dorde Stojicevic wrote:
> [You don't often get email from dorde.stojicevic@rohde-schwarz.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
>  From ae3f90922f5c31bd6198deb149edb9476ecfe4ef Mon Sep 17 00:00:00 2001
> From: Dorde Stojicevic dorde.stojicevic@rohde-schwarz.com<mailto:dorde.stojicevic@rohde-schwarz.com>
> Date: Tue, 3 Feb 2026 14:48:36 +0100
> Subject: [PATCH] arm: Backward compatibility to U-Boot v2020.04 Series-to: u-boot@lists.denx.de<mailto:u-boot@lists.denx.de> Series-version: 1
> Signed-off-by: Dorde Stojicevic dorde.stojicevic@rohde-schwarz.com<mailto:dorde.stojicevic@rohde-schwarz.com>
> 
> Cover-letter:
> Backward compatibility with U-Boot v2020.04
> Needed in order to boot LynxSecure Hypervisor, otherwise
> U-Boot will fail at this position and reset the controller
> END
> Commit-notes:
> Backward compatibility with U-Boot v2020.04
> Needed in order to boot LynxSecure Hypervisor, otherwise
> U-Boot will fail at this position and reset the controller
> END

Signed-off-by after the commit log.

Also, this isn't a good enough justification. Why is this actually 
required for booting this hypervisor? Because all this does is...

> ---
> boot/bootm.c | 27 ++++++++++++---------------
> 1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 4bdca22ea8c..c90c36a6988 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -684,22 +684,19 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>                  int ret;
> 
>                  ret = booti_setup(load, &relocated_addr, &image_size, false);
> -               if (ret) {
> -                       printf("Failed to prep arm64 kernel (err=%d)\n", ret);
> -                       return BOOTM_ERR_RESET;

... remove the check on a bad return value, which I'm pretty sure is 
something we don't want to do with such a vague commit log.

So please investigate a bit more and provide more info. Which part of 
booti_setup() call stack actually fails, why? Is there something we can 
or need to do to fix a specific corner case and only that corner case 
without breaking others?

Cheers,
Quentin
