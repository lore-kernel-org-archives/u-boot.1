Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207EBD16819
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B4B84337;
	Fri,  9 Jan 2026 12:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="aqhkAIsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A043983F56; Fri,  9 Jan 2026 12:45:41 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDD38431C
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3bn2bD9RAbqzj0j4Je+Q+kqmkyyEOrcvqdxj+TjhxP3LAtvH9PFt8so2MoGHV4NWuLEdpfBX9TcqFPH+OdG6leRW3w1AiK5BYtliGCKH1lHvdgjTbS48ynXzWEJ7hMAL/hpsZwqHVyAQPPg//rJehF0oIiYaGNXb1T+LjrZ9hUHBZKKFyssnPCHkBPklnRNscmw6qi2rjfgxm9vsFxM2iInmEDjrl5xQcXG4oMXq6yAzf+kbMBZfl0aUsnFzNY57Vvbi+W48B4xE2uU3VBlnjXXZo37nMv4Y5YoVrEBCRifvua7fL0alOIa/T14RlFnoCy/jBUla1lVusdzRyigog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFIp24OQvq/CotHHZCnoCh1Cy4nUpMCjlf6Nm/K+9J0=;
 b=d4LvSj6XYKviP7kmfHJx7eBN4H6gr6ve2KjrpJtq3QUFEb0xXUe2ZiFrvB1oZlInPvs7vBsq526bdVXrZ7cLPT70LvdgTBuV/MrOql5yHz1HQ6rA59uREjiPVUbaYKZ+IjhJ9zXp+iLOV0V5B1D4Flxu64PYvI/mR0so2gaR1LLig05KbfW/uKHYc3zDCFTHslr7tr16g9s/ySqrPQDy27gI1td3E1pPs7HQHb7lOl71ZG35ZonazrNZrlQ6CSS9uHPuHKkV6Rr95vivPBNUPf8ev0Yb5dpQkKkPafsuaAauovvCbkB+cHQ06aabKurhVnGWHxdpI6pKlhcGt+4TFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFIp24OQvq/CotHHZCnoCh1Cy4nUpMCjlf6Nm/K+9J0=;
 b=aqhkAIsv+UbhWeA8I+4WNUdUQFLgbyGECXuTguIF+XjAUMfmhNZql8l4/mAbssLl/o9Qmymf4iaT7MzbEaQonfhYwUFrA4mY/d1q4o2b6yOcusJ3RQ3y5SGweRZojc6w+h+Vs2FpgayipoyaaTbn9bYZo2XMUb25ttqc7r4sn5pUJtyjoWqOVptK0+Fi4sfNWmQQmx4/vDO1yTOJhOmYuy6O4Q3WWLfIdbCWAURwXD7pbb0FmpQbBykREt7pA3lceZyqHjfzjjKPa8GFHDovJuLnlqtmgsGb17BhkXz3Brz4ElKhuIflnsxqthOBb5XhD6NxakxtEXUQ+C4MKD2Fig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 11:45:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 11:45:31 +0000
Message-ID: <73b5f060-5405-4857-b8fd-1160c09cfd41@siemens.com>
Date: Fri, 9 Jan 2026 12:45:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
To: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: pbrobinson@gmail.com, u-boot@lists.denx.de, trini@konsulko.com,
 simon.glass@canonical.com, adrianox@gmail.com, xypron.glpk@gmx.de,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 mkorpershoek@kernel.org, michal.simek@amd.com, ravi@prevas.dk,
 raymondmaoca@gmail.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 me@ziyao.cc, paul.liu@linaro.org
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
 <CALeDE9O-jkytOaioLBKr_vui0Q7TSAZGmTkNY6ssJ4EkZD_OtA@mail.gmail.com>
 <CAFLszTgtgYm67w2KmEo5nSZKuohD7sRNQKSrA0=mBxr9vd2gLQ@mail.gmail.com>
 <87jyxt9ps4.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTgUw=TdheWVUzKLO+2+YECQv=19cJk3tdkFfsUhtRfyAQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLszTgUw=TdheWVUzKLO+2+YECQv=19cJk3tdkFfsUhtRfyAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4cc509-43b5-47f5-bcc6-08de4f74977f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE5SdTRBUTErVHJTSEdRRDhPL25HZ0NrNTYvUCtnNFM0eERaeG1lVldxVXhF?=
 =?utf-8?B?Yk5mY2NNYkVrNVk5Wkh4V0ZNZ0MrbWhiZWhJUktiRDlicHpkREdhL2w2bGdk?=
 =?utf-8?B?Z1NUejJOdFpXWFFMcHZ0b3YyN3dTWlVvOHByV25uUCswMzB2c3U1eXlHNVlr?=
 =?utf-8?B?Y3oyRVBYVTF6aFN0UDkrTEJPYTBlUW9IbEMvS2Z0ejRZaGw0NkhCRTAwSWpr?=
 =?utf-8?B?NkVuazdNQ2Y3bVZWcVZIbU9JOUMyWGhoUEhzTkR2TlFTQm8yTHF6dDY5cnFj?=
 =?utf-8?B?WWIvN3lneG5FUXBpdERvY3BTd3p3eU43RXZ6bW5RV1N3NW5HQnQ4ODhEUnh5?=
 =?utf-8?B?RGtMM0t1RzJjR1hwSDdKaDN6OHpCUE5Ga0FQU24xb3gyWjhIMmxCVThSelRE?=
 =?utf-8?B?Qk9uU3FrdHJMNEtWZ0ljeUNqVzJrZ2g2b3FXVWZuUlAycWhST1VJbVI3MGph?=
 =?utf-8?B?TGp5b3NXc3h3cXRJUk9IQ2VMQkM2b0prSUxOeWUvUUk3enJGUWtPLzNsZkdx?=
 =?utf-8?B?TUkwU3RJR2o3SWRjSUlhUWp3Wk1mckpLdGYrR3BDOGxpdXk4WHExa0FKU0xm?=
 =?utf-8?B?WEI0Nitnam1saWhWZU9GMng4NVNINURDWmtLSU9KTzNHMkJjUFdNRmJQVGgx?=
 =?utf-8?B?YkNBeDhaTVZMbE94YmdNazNzMU5DSUR5Z2VZdFNndEcveXBDbjMrZ3pKaW5n?=
 =?utf-8?B?SVhzb2tqYUNMYUdMNEQrb0J3WWQ5eWVNUnJjT2lHeWdVbkxIUU1OVTdBaFhP?=
 =?utf-8?B?NDBzY2RDZG1mc25obU80SEFwUzAyWVhDdVhMLzk1MUh2NHd0RHlVWW43NjRz?=
 =?utf-8?B?ZFlReUhYczRpVWtTbVRSQkdwZGFyQ0MvbHNXQ1pCTnJOWnJNaENCSmMzTU5s?=
 =?utf-8?B?aEUwSGo3K2dNQUxaY0Z1OTA1b1c4S0FEWVM4cElRTWt0d1NNNUpXZHIvUGJ4?=
 =?utf-8?B?MHRLaERtNDFRVnNsQjZaRy9ISnBOY3p2dElqNCsvWGVzRzAzT3VZa0czVHV5?=
 =?utf-8?B?bHJPRUhrbWgrOTVVeWhxMU0yT2swZTM2c3YrSTc1VFNlYkxJYW4raS9RZWRZ?=
 =?utf-8?B?Yit6SXljUFp1ZlhmbTZIRXd2dGtNUW94UHc4anhUdFRSSmRPSjVXUWV5VjA0?=
 =?utf-8?B?VFlDTjNHdy90ejJRU0pnMlM1MmU5VnUrMjBZUDhmeCtNa3FhK21EOFc0dnox?=
 =?utf-8?B?eTRlbkpNMEdzaUhDOU1qWCtRK3B3dUVadVFrS2haSFE1THpVdm1iMS9QNFFy?=
 =?utf-8?B?aG5yYzdnQTQ0MGkwMjRTZlZvZ1BFdUVXWS9ja2tFbk5SZExKdkV2aTZuTit1?=
 =?utf-8?B?akNBd0dpQXlnTnBVMlowQk5rRm5WbFVDUlNFUnFhZzRKUU0vQklRSmVDQWJt?=
 =?utf-8?B?bDliZkMyOWI2bVI1SFY0cVN1THlHNnk5UnA2TFBIZnR2N1B4WkRValo4aDE3?=
 =?utf-8?B?VExOd3ViMzNOeDBoQ0J2SGpML0F5ZGgreGxmdkpDa0hDYk9YZ2lKQnVOQWlS?=
 =?utf-8?B?T003bktxUGZvVU9TZnllRitRMkxwOFFJdHN5cmxWT3pFYzdQb0RvWWs4a29X?=
 =?utf-8?B?ZWpjY0dpM1lqZUsrMTBwTU1HVTZGUmdMdVdqeXBQdkJYTFQxWCtqZ2hPd3Z6?=
 =?utf-8?B?Q05lYjZYYkVLMmJQMnhXTXEwWGFHTThUNWZXdWlyR0IzNGF5d2lCMjNWRmsr?=
 =?utf-8?B?MkNSelFPZWpaUlVwY0I5T3l2NUYxTENLV1NkMk5RckdvUGI2NThGU3RRM2lG?=
 =?utf-8?B?ZzRIT095QVp6S0U4MFY4alFsSDZSaGFFL3VuVTc3VllrbzBielBkYVVzM1Fk?=
 =?utf-8?B?aFNrTlh1N3RyVkFKRGhBRFZzYWZIRGJZQVlSckpXbDRiL2VNb1V6TGhUdG92?=
 =?utf-8?B?MXU2enNRWDl5b0NONTAvRVc1Umg0UWtQL05KemV4cTJhbjF3bGdZOEpWYS81?=
 =?utf-8?Q?sN5MU5pwK7loe2PY2lAldvTAMufSfeVb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0N6Q3gxOTdobVNBNC81UTgxTXlleGRnOW5oZWs0UDFVZFNoMlczUVdqZEVr?=
 =?utf-8?B?VFBkdHo2eGgvNk41a0o3UFoxS1lCVzdWY0lHZVovUGFqbnZkYWtuMWZncHUr?=
 =?utf-8?B?WVBJYjJMcDBMakkwQ0xzSjZyMmo2T25pYXpWYkpuNHFCdHJPbVNGdFk3Vzc4?=
 =?utf-8?B?eXMwYWYycXIwMlFuMFU5MFRQdDdIbmVTaHBlcUFwYVp5UEhMQ2t2dmFrUWor?=
 =?utf-8?B?YmxIcXE1YkgwNEVhdjFNK3hiWm9OTEkrZVJHTzdoMFBhc1NQZFVFQ2haZFRi?=
 =?utf-8?B?VlBGMUs0MUFRaTZSZERmQnFBcGpqNVR3MHdqa0NSdndlZHVTcXZKTkUzN292?=
 =?utf-8?B?Rkw0OGlRWW4yNWJLNFhhZk5pcS9nOHlmeUZ3anJWM2ZiendRRTU1am1pZTU5?=
 =?utf-8?B?d3pnaGltSEZkL25rWm9NbkQ1SkNrYWxoRi9NUGdqS25mSnJoSDZ4T0d2L3Nv?=
 =?utf-8?B?T1pHbnFhS0pvaUlxU2FMYXVYNllMQkt4eG1EdkMveHlBZjJMdEozTEVpK1p5?=
 =?utf-8?B?NGRGQkErcml6bG1ObU9oWHg2dUtGUGkyR2lnVTlRSUJIK3pwaUNZZHFpKytQ?=
 =?utf-8?B?T2lkUDErM0Y4Ny9zNi9wN2IrbEVtZEI2Q1A3TXAyUHV0VDJ1Q3hzeVA2ajNX?=
 =?utf-8?B?SXREbTVCeENoOXF6ZThZb2ZORDJTSXhPb2FqaU5aTkMzYUdQYnlCN1JqS3dH?=
 =?utf-8?B?WTJQcDNKZFByTzU1Qy85aUNqSGVPM1pyUnJGa0pZaXJkbzB1Tk9KTHZPMVBY?=
 =?utf-8?B?VDB0TnVYdnhTR2p3U0lmTEtaQ3V1aWJNc3UrdHBtamRzSCs3M09LaDZxQUxM?=
 =?utf-8?B?QWlOOStOY1c0ZkpEV1Y1NU9qM0xqR01IUHUzaURxeU1vQUp0VjE3YVlEd012?=
 =?utf-8?B?T1E4TC9ieWRPdGJ1YVFoWFBvYzVqeG9UYThyUWlQMm05SjV1QkQvWHZibHph?=
 =?utf-8?B?QmJraktod0FENTN3Zi9EVjVRWDZ3dWF3YVRheGsrREhlWVczYjNmSERrakF2?=
 =?utf-8?B?aXk0a0NYbTJuMzNaTnc5RCtyRERDaGI1TmpIemh0R2RCcmZzeENwMXJISENz?=
 =?utf-8?B?Q0tSaTE5K1Y4K1AwYnh4OTF4TW9YWFFHQ1puY01uem11N0c3L0hramdyTDdk?=
 =?utf-8?B?MThqdkVqRklWd2pmOGRqbmkxWjBNa3BRTzU5WW1XSk01QmNzRGdOSlAvWGNs?=
 =?utf-8?B?OS9MUFc0YS9za0hpQUxhNjFEdjgwNnJ4Zjl4YUtUaVUxTHlqTGN4ODFtcC9x?=
 =?utf-8?B?MFhleFVHclFVQVJHMCtoN08vbFk5YVNwZUxJNFBkVjdvNC9LQzZTT3UxaUs3?=
 =?utf-8?B?aDdZNUFMMWkzSVpNUTg5MG1pMHd6Nml1d09JWm44aTVpdWZTYVF0cnZxZy8y?=
 =?utf-8?B?eFVwWm5TV1ZBNmxmOUcvTGZVZ0xnazIyZy9NaE9Kc0x6bTI3QVoreDd2U3h1?=
 =?utf-8?B?U3lmZHY2aE1NelQwYUQwMytVQTcxUm9lTEpFNTNzQUNsZWdqSTBJY0EwUEdG?=
 =?utf-8?B?dXBnT3o0OXFpMkIzdFVFcDJrclFWQUFRZk9RZ0I5a1ZkR2hNTkYzUWR5M3Nn?=
 =?utf-8?B?SzFXTzk4N21Nd0tWa0RXbVRIVXNZZHI0eXVjcVNDYW41OFY2Q3B1WnBNdXpT?=
 =?utf-8?B?MlB5MzQyUndmc2MzUFgrMzBkY1JWQkV4WWk1MmxvbEZHOVRMZEpiQUs3ZUlv?=
 =?utf-8?B?WkRYSDI2d3pGWHcyS3Rvc0VHcW5CdnRxcFl4TytTSjlpNi9kS29SQm5QOGkw?=
 =?utf-8?B?czltbnd4Z1AwQXN0c3dOOFBMMTl3Rjc3L0Nkem1FL0pKME9KKzNWU2Y0bkVD?=
 =?utf-8?B?bE5CRHhRR1p1QzdBK2RFUENjQmlQYnJ2ZFJDanRiWXROSGdlV3pwcjFyS0Zi?=
 =?utf-8?B?bmNpUU8xck1zR1hheFBNdzV6WVl3NjJrM0EyWG1MTXdob29tVTlsd3pOOTdj?=
 =?utf-8?B?OXRkQjRHLzJsTXdjSU9PeFNJblVKRjA4SlB1RzRiRFBCMzJKcnhxa0p3cG1C?=
 =?utf-8?B?UGlUUXBXWmEvN21EKzRsZHpGK2hpUVNWaHVHdlR2S3V0MU9LMzkwYXh5cTZI?=
 =?utf-8?B?OTl5Q3pYKzhGd1E5NzFEekFURmlsT01XWDJlb05MK3czRHB2RC9WNmVMVnhJ?=
 =?utf-8?B?Rzl3R0R5a095b0ZRTThLdHNCUUxoeHBxNm9DRk1rWUVQQjBmbk9YTk1rOG9r?=
 =?utf-8?B?WENJdkc2REFkeXQ2V3JpLzR1SW8rSGtTMmtRdW5aUEJKbGdXZXhFdGNqN0xr?=
 =?utf-8?B?dmRXVmdpRTVvQnJSN0ZNbzdoSndrbXliZG5OeXlDNmptNTRIb3pzUVk3TllM?=
 =?utf-8?B?RDNmTEpCZUlxSyt2YndhUjN5U3RvVlZqY0hjRXIvT1o1V0hNdEFWUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4cc509-43b5-47f5-bcc6-08de4f74977f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:45:31.0712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC3yMtff3OsNtVojXGuTI/AsvuwJMylH9yvrFBpxt9w266Sbml2sm+8crtoCLr7czzBOfqfamti5r3tBgK/kag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8457
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

On 09.01.26 12:34, Simon Glass wrote:
> Hi Mark,
> 
> On Wed, 7 Jan 2026 at 12:38, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>
>>> From: Simon Glass <sjg@chromium.org>
>>> Date: Wed, 7 Jan 2026 12:02:27 -0700
>>>
>>> On Tue, 6 Jan 2026 at 19:42, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>
>>>> On Wed, 7 Jan 2026 at 00:33, Simon Glass <sjg@chromium.org> wrote:
>>>>>
>>>>> From: Simon Glass <sjg@chromium.org>
>>>>>
>>>>> This work-around dates from 2019 and grub 2.04 which is quite old. New
>>>>> builds of grub don't have the problem and old boards presumably use an
>>>>> older U-Boot, so don't need this.
>>>>>
>>>>> Drop it.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>>>>> ---
>>>>>
>>>>>  configs/mt7623n_bpir2_defconfig |  1 -
>>>>>  lib/efi_loader/Kconfig          | 10 ----------
>>>>>  lib/efi_loader/efi_boottime.c   | 26 --------------------------
>>>>>  3 files changed, 37 deletions(-)
>>>>>
>>>>> diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
>>>>> index 404380558f2..d75168a72ed 100644
>>>>> --- a/configs/mt7623n_bpir2_defconfig
>>>>> +++ b/configs/mt7623n_bpir2_defconfig
>>>>> @@ -13,7 +13,6 @@ CONFIG_DEFAULT_DEVICE_TREE="mt7623n-bananapi-bpi-r2"
>>>>>  CONFIG_TARGET_MT7623=y
>>>>>  CONFIG_SYS_BOOTM_LEN=0x4000000
>>>>>  CONFIG_SYS_LOAD_ADDR=0x84000000
>>>>> -# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
>>>>>  CONFIG_FIT=y
>>>>>  CONFIG_FIT_VERBOSE=y
>>>>>  CONFIG_DISTRO_DEFAULTS=y
>>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>>>> index 13e44be1d06..5585c841c27 100644
>>>>> --- a/lib/efi_loader/Kconfig
>>>>> +++ b/lib/efi_loader/Kconfig
>>>>> @@ -505,16 +505,6 @@ config EFI_LOADER_BOUNCE_BUFFER
>>>>>           hardware we can create a bounce buffer so that payloads don't have to
>>>>>           worry about platform details.
>>>>>
>>>>> -config EFI_GRUB_ARM32_WORKAROUND
>>>>> -       bool "Workaround for GRUB on 32bit ARM"
>>>>> -       default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
>>>>> -       default y
>>>>> -       depends on ARM && !ARM64
>>>>> -       help
>>>>> -         GRUB prior to version 2.04 requires U-Boot to disable caches. This
>>>>> -         workaround currently is also needed on systems with caches that
>>>>> -         cannot be managed via CP15.
>>>>
>>>> This also states that it's needed for systems that can't be managed by
>>>> CP15, what systems are they, how are those platforms addressed?
>>>
>>> I'm guessing that some systems have level2 caches with their own
>>> software interface. I certainly have seen this with Tegra2/3, for
>>> example.
>>
>> This is already being discussed in another thread on the mailing list
>> started by Jan Kiszka:
>>
>>   https://lists.denx.de/pipermail/u-boot/2026-January/606817.html
>>
>> My suggestion would be to drop this patch from your set and let that
>> thread run its course.
> 
> Yes I did see that and I was pleased to see that someone else was
> interested in this topic.
> 
> Still, that thread does not actually include a patch. So let's see how
> it pans out.
> 

I'm played with turning off the workaround on a socfpga target, and that
apparently causes troubles:
https://lore.kernel.org/cip-dev/ba08992d-17f5-4689-b05c-93af612e4539@siemens.com/

I'm inclined now to keep cache disabling by default, only enable caches
on known-good boards. If someone has a hint how to reliable identify
targets that have architected CR15 cache control, I would use that as
input. Otherwise, we need to maintain a positive list in Kconfig.

Along that, the control may need renaming because the original reason -
broken bootloaders - is really history.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
