Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94246EFB810
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 08:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E27583642;
	Tue, 24 Feb 2026 09:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fTHawAk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B492983BC9; Tue, 24 Feb 2026 09:14:42 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D0A80050
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 09:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4/Lt4XcXffa0fcdOHo0Qk3bcK6iSeSnbT08+NTwOkv1v1ZeY43alaUhG+vl1uP2AiNRffNoGXgZ3e73OppNPZknLkA9hF5W7Z9Ag2dvDtb1AIR9A5j22WuSi6n3pjzdni5jHunn9givUNXKVTbYg4aV5YRV3G0WEISxOQli2Bcbk6CkyWKqgWUC8zT0ojU+eesqdCr5GIm0ge1lfwAmdiXIN/9MBDhGBwjHb5WODY6Ou+w2kB0Q33WJK/iCEV6zUB6RauKbuhwcj7A0AffAripmjKWlkwHgGPGrqydICvGpiTjp3kK4PqeamWHK2xb4eFNUprCslqV4mpwfqW5RGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOYIAK1T6dvSpc1FqO1+H06g3wZ9Q3OjZZF/YxyOQwg=;
 b=bpzU77uuBytbZcKVzNPMXQzDYG1hy1Mjvu7eE3IqRa/BjGS/3Eg4CI59xh8O81d/xBZJ7JGTXmYDKmMIoMHiE6Y4DAgxt+oLG+QJHmpwx77uIndGlTnbV5dYpMOvQVBrpBU8AoFuNEzJxF6xNKwyIcwqle5vS7xUKp8+UES5PJHUecRkzzNh052yivnF1sNqogIoY3ut20R8VE8Kgj7phWSOk/LvHijWpdwfeiC3qdO85fxDXT5fHkOeqXkQy7ECrinZWpbQuNI8MK8KOqQXFuos2MgCZKN27QIj4nhApjJKl6YBi+6QGHpdhwBvbQp6hl67ppmvexhAjaVW6FIziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOYIAK1T6dvSpc1FqO1+H06g3wZ9Q3OjZZF/YxyOQwg=;
 b=fTHawAk4N/WYKUMQRAvnvi1fBZzMsNiBtHpjrI7XBxnJp/ZP8wjcsopVwJeMWxHlQHKkbVZ74bkTY3Jdh2sZk3wF6/2wkP+oH0o6sZa7fZQZNVRyu9KJ2zaY6rhnTqhWNmdk/aWCL/N68amD3rk2GyyR4ozXcVzSxDdzvnHV9KXGKIMMW9GU7/at5rztaAyB+TZutAG/bl6b40J5GKolTJOhxwzKlb9+V1ikQOnf815JCRJ+aXeXpZbJ4yAqxwgYMOw5VA2fFnt2qu+NPa5cfuMpLCb693uYDDHm3PC54mW2IzyUl7FmbxQzqjDCJGq9JL3VxzdRy/kfIwZ9z+i4Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB7054.namprd03.prod.outlook.com (2603:10b6:806:33e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:14:35 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:14:35 +0000
Message-ID: <4d3e22e1-3f7f-4c19-a529-157eac6d0f61@altera.com>
Date: Tue, 24 Feb 2026 16:14:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: socfpga: Add call to
 socfpga_sdram_apply_static_cfg()
To: Sune Brian <briansune@gmail.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
 <b25f6c14-7db2-4517-a3ab-e2c55a52818c@altera.com>
 <CAN7C2SCC9L30S2BNYUzRE1jRJeQ2H1d6fq_Hgsu7uPge_QgsYw@mail.gmail.com>
 <CAN7C2SAOLdokAaVcuMPWMTS4HsY-4d2dhnkwLadqsGS2qAsKaw@mail.gmail.com>
 <4b6327d1-681d-46a4-b672-6d53fbfa1e89@altera.com>
 <CAN7C2SCbyuBz4d8QmqGUNFBGjhGaSFyZD-J3GcYy9r3DGNSjvA@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <CAN7C2SCbyuBz4d8QmqGUNFBGjhGaSFyZD-J3GcYy9r3DGNSjvA@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 232fa255-ffae-4841-8e1a-08de737cbdd8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW9PRzd5NlQ0NTlKcGlhMnhHT0oyMzJEV3lJY2tvVjZ1bllyQm81dmVUZUVG?=
 =?utf-8?B?OUk3ZmtGVSs0TUZ1OFlmWTFIeENZc05aR1RQMzFRWndDZlUxQkpZZGc0cG0z?=
 =?utf-8?B?MU5sT3lPMVNvZnIwQTBTbkVaZmpWcldlajhVaFZienZwZGZFTlhKT1UzV1ZG?=
 =?utf-8?B?OEYvVmU3WGkzbFlCRVo3eWVuS1IxTmtrb2ZYYy9pSmdlQ3NqY29Vd2JhQzdn?=
 =?utf-8?B?YTBXcG1KckVhWVoyaUVNekNUcjlSV1RnZVdZNDRuZ29jYmRLV3ZvSUlNMENy?=
 =?utf-8?B?V295bzNpdzRPMlRmcmx6NCtFd3BJWDlVaEc3ZjNtblpkYk14clJxcDVsbm5k?=
 =?utf-8?B?T3ZWMGZjRjhlLzNselYvZnRvdVFNaFdhS2cxQWl0QlpqbkJjcHRkRUJVc2Rz?=
 =?utf-8?B?N1QweXNydGc1T1Fvc1d4RUdVNWJLMFRocEU5T1ZpR0VKcnFrL0R3cWN6Y0g5?=
 =?utf-8?B?aC9qZWdSZFRHemNvc3ZJYW42dGN1NzJTNnRnMFZEeUY1VnNhbW40TGRYdmlY?=
 =?utf-8?B?TWRyRW5rZDhhUW9VcjBGcEI2SGtCRkFGNUx0OEdvd1o5VUtKT05SdGJzT1hV?=
 =?utf-8?B?K2JnRFFKcUljVC9LbnhiRnFGMFF2d2RSMDM0Q3QwV2pPZVVTc0lnNTl0bnJ6?=
 =?utf-8?B?UGRJSEFNRU1zcHY5QkFWUTRmQnA3UEVaWGk2WVFKZVNFNE55eTdJd1FQWldS?=
 =?utf-8?B?OVVzKzlKRUJrdHI5QllIT0U2YkFyTjlpR1d4aTFMUXNLTWZwNHVMZEdFOE1Q?=
 =?utf-8?B?MVFsOVNnRDZIdWNJdng2NGh5VGZuL1dvQUxoMEpBYmRVcTFOMktUK3BPMS9D?=
 =?utf-8?B?c29ZalIwMmdrRld5L3VqQng3NXluNHAvMnlId0hPSHRZaXB2WXhDYlhQUkpT?=
 =?utf-8?B?TmRqSmQ2SFVaOEFqR3lhOFRQaW1lamYwZHdCN1RZRDI4VHppMzM0NFgraE9u?=
 =?utf-8?B?cEp1VkpRQm8xU1NJemV0bGJJMUpKTTFaaWFVRDRaN3VVV2E3VzBIYklha1NV?=
 =?utf-8?B?dVFCUWlmQURiK01CSXRHRUUwaXhyME5QK3B5aG5JYmRBbVZhVzhtNlFuL1VS?=
 =?utf-8?B?OWgzL2ZpNXRuN2VtQzErUEN4SjVwMzl2WWM0MVFibzV0MWhzNTgxMVc1Ylly?=
 =?utf-8?B?U3I0SXBTdTUvTTB6RFhMbHh6d3JMUzEzeHlRTENtOVVYbzFDYXhMb1M3WVRS?=
 =?utf-8?B?RysxSU5sUjhmYWtKU0lrVk5nSDRrc3o3a2c5WFpGV2VrSTZUam84UXQwT2Z0?=
 =?utf-8?B?T3NZcGg4UlBKaUtOR2lWYlNpZzJrenZ6OXB2ZVdVc2xBSy9nbnExbUNxbWhn?=
 =?utf-8?B?dG5zMCtvYlFRSENhbDBOOCtqWkc4WmFDOTlBQTJsc3pWRG5JZmU4d0VpSzVz?=
 =?utf-8?B?ZmNYekdOQ3I2OGphc2dyL0ZyMDZHVHZWVE9ySS9mWFJkVkhZNWdrR281Y1Aw?=
 =?utf-8?B?dlpsSzBQeTc3aWszT0c4bEpHQW01OVZ2VmEwVFc5NmpXSi9hb1Jrb3R3ODVa?=
 =?utf-8?B?TmNXbzhLcWNDdndqYTJQekl2VTBGQTRRYW1mS1JHRmVMSmpTYmlBdmNuMFA5?=
 =?utf-8?B?ZDd2cllEZmpKaXZLRjBJZlUzbG85djVLQnp4Sm1va0tGUTB3cFE2MmtYdTZC?=
 =?utf-8?B?ZWhLYmVrWXdmZjFLampmZmE5a0I3TU5qV004Mkdpb3JrNm94VktHTGRwTDlp?=
 =?utf-8?B?bXE4WnNIcE9oMGMwR21tUWJBN2RKYUdqYkxMeHVEZElyVnJGd2YyenBma3l6?=
 =?utf-8?B?TVJBOTkyWnFrTHY2Y2Q1MVd2ZVRKWFFramdSdloxVTYxQit5aWJZVkg5dDhv?=
 =?utf-8?B?bjhMTHBQMUw4anhOWW1lZEprZnN1NkpxRHBFSU5TRGZCZE9la2JpTHdPNWw4?=
 =?utf-8?B?WjJJNGw0UU91enlwTUI2MjZDMksxeW1ORHZHMDlQQ2w4WGRnQ0ExSTlYSExl?=
 =?utf-8?B?UXVaYng0cllWMFRDaVVtMlA5aFYrZGNiVFg2SVlFMjVrbGVJeGJrNk0reVJt?=
 =?utf-8?B?ZWVtUktkMy9hK1ZKN04weGprVE1zUTlrYTBRNElpckU5Z2NaRk1wMzJoMmRM?=
 =?utf-8?B?ak5zeHpOeWgyM3hTMzRyYlNBMTJKK3hCVDR6WUxXUThicFA3ZmtXWGl1Mm1G?=
 =?utf-8?Q?EnzZ3MiZ7mLQuXBFvzs+TnKj2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JDRnBBcnhDaTJObmUxSzUrcWhSK1JNTkkyMHV6TCs5Sk10dkNSTVlaSGNp?=
 =?utf-8?B?UnIveTFhOEI2dnBCcnVHdEtrNDQ5eXN0SE0vRXVDUThOTlAxT2FhZGI4bXpL?=
 =?utf-8?B?TDdZRVQ4QWhXQWszcmdqMGpsdGlWWjhSNFRreWhlNStZQ1RkbHhtVTY5SGVY?=
 =?utf-8?B?dnRHbDJUd0lDMHRYRWlXd0s1S05adk5pVmRtR0w1NlZxWDZnR0ZYc05vRnox?=
 =?utf-8?B?dCtBcnl6dTlidGZ0RU9xbzdvNFR3dFpyMDRsQnBjSjFLbVIvMUV1ckpQbXVX?=
 =?utf-8?B?eXpRM2hja2ZZZnhoaTJBZnk3cDNueERqZnBrODAwOFFCYXpPRVNqWWZPQzVG?=
 =?utf-8?B?cHNDUkhPeStaRkFHTHlnbTRNbGNsd2pqVDR2RVptaFlxRDhnMTlYV29oWm4x?=
 =?utf-8?B?MnBMaUR4NWREdGpMemhQa0k1T3lqR0JhMXdPeHc0SGZwelMrdklMVDE3YUNw?=
 =?utf-8?B?UFk3NHhuVzVaU2cwb09VY3lhNTlzdWlWSmN5Y1U1dENsTzVmU3hkS0gyb3lF?=
 =?utf-8?B?dDNLcTcwL1VGSG9WRWxtbmJ3U3QwUlBmUFVTU3lEZ0FINnVxMEs2QmFXcDBw?=
 =?utf-8?B?YUFkMHZoQkVNTSs4WjBVODgvRXB6WWR1WW9SeThrR2RJeEw3blJxWVBhK29X?=
 =?utf-8?B?TVpUWUU1bXpiMHRGbzlza0o4RjhsQllIOXFBSHExSXgxV3VhYUhGekt2ck1I?=
 =?utf-8?B?b0VPWkQyZ3k3ZThpcjFkTm4rNUhTd3o4RnIyRHJhK0R4UFhGM2ZKa1ZscTBH?=
 =?utf-8?B?NGNrTDY4VUZRQkloUzVndFJQbVJzc2xmUEJPSkdFMlZIKzVQRXB1SDZtSi9q?=
 =?utf-8?B?dkc4TnVybitJdCtOTkthMnh0N1p0eUZoYTRQQ3dXMThLSnh0QlFKZjlwMk0z?=
 =?utf-8?B?ZmlYWWtiTlAwRlFCbXd1bkplTzJsbHJBRmFjT0RuQTFqWjVzazY2b2ZlQWRz?=
 =?utf-8?B?NDl6Vy9Ma0RQZncydjl2RnJSMGdxREw5RndwV294RFpUbWQya21zK3RDTWZy?=
 =?utf-8?B?U3o4SXpNNjU3SDJhR1pueVNueVNHcGhnNm96LzNXaVlnTlNHN09ERjB1RmRy?=
 =?utf-8?B?UnZQTDhUeGdyeXpDMU51YWI0Z2kxYndKdEVvd3NGSElUSE53bXl0akdmT01Y?=
 =?utf-8?B?NVFYNzZVYnl4VU12dnZHNzJqR0hZMEZNeEN6ckhsUmlKQ3RrOVpFS0drdktG?=
 =?utf-8?B?U05sN0JTejI0SkJ2RStHKyt2aldzdnJqZkU5eHdjZ3pQT1BFcE5mdFZPcTJK?=
 =?utf-8?B?eWkxODRXSGFiRDJ2bFdoRnpRZmFMSWJqMGlPV2ZWd1p4T3lScU80MHgyZmhG?=
 =?utf-8?B?dXRDaW9VWGIxL1hIa1ZOZGEyOFZoZE1od3htVWp4OG91TGtVQkxUVkFxcFBp?=
 =?utf-8?B?RlhyYVdFWWpRNjllVE01NC9jTGljdDBYaGRHTlFaQ25KTG10ZTFDa2tISjlk?=
 =?utf-8?B?SEFpTWJqUzlHckluRWhnenlsdXp2YU9VemtMWmxCcUszWlp6Z1JKYUFyTDdi?=
 =?utf-8?B?Q09DSVV5TlVMcjRUZXg2clc5ZWk1dUxtSjNGbng5ZTZjTWM3eGYwSnpIclVi?=
 =?utf-8?B?c3hMRU1UU0FXOHhGNW5tYWUreFlrV3NjdDg1d0d6c3BrbFFidktnUW84alFt?=
 =?utf-8?B?YnFtd0NwSm11OEFMUHNORVNXVGlXSll0NFd3ZUtGTUJVeUdKODRFZVdZcFh0?=
 =?utf-8?B?Y0xaNUlHQ1htZzhuSW9CWUo2Umwxa1gwWkl1bVl1bU8xaTlNZ3U2WTRpZzYz?=
 =?utf-8?B?RWVFU2ZDZGNrV3lROGFXSW1ZZ0xsa3l4ZytUd0VzMzdtNUN2RE02MnkybmRD?=
 =?utf-8?B?UTJESFNaaVlWYTk0OU8wdXdQWGNXRlhIMzBHL1RuRlZJS08zeTlWS09aTTYv?=
 =?utf-8?B?R2FQblZhQmQ0bXJKZlFobEI3UG5tR1dPRzhKQmI5UTFveWFrUDI2cVZueDZT?=
 =?utf-8?B?UXVzYUJ2OElTTGdYWnNqWnk4VzIvazl0aEphRTlGS2x5QVp2c0drbGltTGpY?=
 =?utf-8?B?dTBuT1lXcVFsb3NPemlQZzhmQ0JLa1h2bE1BampabXBUR1BrL05oZk9TUzRG?=
 =?utf-8?B?U2lJc3ZkZEcyRW9xR083cnJhSlFxNmhEL0xMcnFFc0g4Mm5vcTAzai9RMzBq?=
 =?utf-8?B?dWt1eUJNaDllWi9tSmlVaVhDTjdFYitmTzJMODdsL21EUk9vSUt6ZkUvcVQr?=
 =?utf-8?B?UGN3eUNlVExmdkhvcVNyOS9TdExydnBFbUFTeXVTaDIxem9KekVjaDIxRGtK?=
 =?utf-8?B?V3prR1VOamZROEUvREdSc0JpN0NvOHFsVHk1NjhvdmJUSXdhTURSdXk0MVdn?=
 =?utf-8?B?ZU41cytZaUMwSVcyVmowbWNkREYrbWVCZUdpK2lQVmpuWlRybHdMSHNBOXFr?=
 =?utf-8?Q?D4jNM9RzCjJ4tkto=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232fa255-ffae-4841-8e1a-08de737cbdd8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:14:35.0188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUr2Rk/1nyhswGEM74hvAPbC0q6j8+0Q3fcCX5I7QAM2O+IAeWP7FlxM/9wHdMAMkpHWrvonray1YE9laaTGZ0Ou5ObJ6DR7EoSHGuXS0KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7054
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Alif,

On 19/2/2026 10:21 am, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On Thu, Feb 19, 2026 at 8:18 AM Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com> wrote:
>>
>> On 13/2/2026 5:00 pm, Sune Brian wrote:
>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>
>>> On Fri, Feb 13, 2026 at 4:44 PM Sune Brian<briansune@gmail.com> wrote:
>>>> On Fri, Feb 13, 2026 at 3:18 PM Yuslaimi, Alif Zakuan
>>>> <alif.zakuan.yuslaimi@altera.com> wrote:
>>>>> Hi Brian,
>>>>>
>>>>> On 6/2/2026 11:09 pm, Sune Brian wrote:
>>>>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>>>>
>>>>>> Hi Alif,
>>>>>>
>>>>>> Since 2025.05 to the latest master.
>>>>>> I do not have any issue as you mentioned in this patch.
>>>>>> Both RD/WR are used on the FPGA2SDRAM SDRAM2FPGA.
>>>>>> I tested 256 AXI3 or split 128 AXI3 x2 which is the maximum
>>>>>> that GEN5 Cyclone can support.
>>>>>>
>>>>>> Not too sure what is missing from first place?
>>>>>>
>>>>>> Thanks,
>>>>>> Brian
>>>>> Based on the CycloneV address map which can be found here -
>>>>> https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hps.html#sfo1411577374877.html.
>>>>>
>>>>> Bit 3 of staticcfg register has to be set to apply all the settings
>>>>> loaded in SDR registers to the memory interface, in this case the patch
>>>>> ensures the SDRAM controller applies the latest configuration after
>>>>> disabling FPGA SDRAM access.
>>>>>
>>>>> This is a safety and correctness fix for re-initializing the memory
>>>>> controller in the proper sequence during FPGA reconfiguration.
>>>>>
>>>> Hi Alif,
>>>>
>>>> Before I plan to undergo a test we got to understand why w/o this patch
>>>> SDRAM2FPGA works properly w/o issue.
>>>>
>>>>> If you have the time, can you help to test this patch with your setup?
>>>>> Although unlikely, we want to be sure that this patch will not break any
>>>>> existing GEN5 boards out there.
>>>> I might be wrong, I think static cfg has been done already?
>>>> Does the code here if not wrongly understood already finished that static cfg?
>>>>
>>>> ---> Quote start
>>>> void socfpga_sdram_apply_static_cfg(void)
>>>> {
>>>> const u32 applymask = 0x8;
>>>> u32 val = readl(&sdr_ctrl->static_cfg) | applymask;
>>>>
>>>> /*
>>>> * SDRAM staticcfg register specific:
>>>> * When applying the register setting, the CPU must not access
>>>> * SDRAM. Luckily for us, we can use i-cache here to help us
>>>> * circumvent the SDRAM access issue. The idea is to make sure
>>>> * that the code is in one full i-cache line by branching past
>>>> * it and back. Once it is in the i-cache, we execute the core
>>>> * of the code and apply the register settings.
>>>> *
>>>> * The code below uses 7 instructions, while the Cortex-A9 has
>>>> * 32-byte cachelines, thus the limit is 8 instructions total.
>>>> */
>>>> asm volatile(".align 5 \n"
>>>>        " b 2f \n"
>>>>        "1: str %0, [%1] \n"
>>>>        " dsb \n"
>>>>        " isb \n"
>>>>        " b 3f \n"
>>>>        "2: b 1b \n"
>>>>        "3: nop \n"
>>>>       : : "r"(val), "r"(&sdr_ctrl->static_cfg) : "memory", "cc");
>>>> }
>>>> Quote end<---
>>>>
>>> I forgot to quote the func call location:
>>>
>>> void do_bridge_reset(int enable, unsigned int mask)
>>>
>>> During boot users are supposed to use bridge enable to
>>> control the needs of the HPS <-> SDRAM or H2F F2H LW etc.
>>> When calls if I am not wrongly understand it will reset and
>>> simply do that static cfg and simply do not require additional
>>> calls.
>>>
>> Thanks for pointing this out, Brian.
>>
> Hi Alif,
>
> Pic by pic.
>
>> I understand that you saw potential redundancy in this patch's explicit
>> re-application of the SDRAM static configuration, which may already be
>> handled by the existing call to socfpga_sdram_apply_static_cfg() during
>> bridge reset.
> This is following the old boot flow to the latest and not having issues
> under boot.scr with "bridge enable" and sub-bit bridge setup.
>
>> I would imagine your current flow works as the current code already
>> applies SDRAM configuration changes at the correct time during boot or
>> bridge reset. However, there are some cases or sequences where this
>> apply step could be missed - such as during partial reconfiguration.
> Not too understand this case even if you PR the bridge enable MUST
> be done after the reconfiguration phase aka "bridge enable".
> And PR itself has nothing to do with turning on F2H SDRAM the first time.
> One is the FPGA manager and the other is the HPS register unless it auto
> reset all bridge registers.
> I can also reload full bit during boot again and again and boot to linux w/o
> f2h issue.
>
>> This patch would then be needed as an extra safeguard in cases where SDR
>> registers are updated manually or outside the typical bridge reset sequence.
> If the user doesn't use f2h then turning on this bit for what purpose?
> As "bridge
> enable" under boot.scr have good control.


NAK as the TRM’s staticcfg.applycfg (bit 3) applies SDRAM-controller 
configuration to the memory interface (burst length membl, ECC/data 
width, timings, etc.).

It does not gate fpgaportrst.portrstn. The claim “after write to any SDR 
register” is too broad.

fpgaportrst.portrstn[13:0] is a live reset control for the FPGA ports.  
Writing 0 stretches reset, writing 1 releases reset. Its effect is 
immediate and independent of applycfg.

Thanks.

Best regards,

Tien Fong


