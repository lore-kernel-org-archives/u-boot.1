Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579F7D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 07:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E38C2839AC;
	Mon,  1 Dec 2025 08:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="M6HIDP/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DCCA83966; Mon,  1 Dec 2025 08:45:55 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9328183966
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 08:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suuvNHdOTgU8oKT8STV2RnZ/1ALzW/3+Lv4qt90k6reHZNdHu4kgNbADS+dkG4hwnyvRPc15R+44MOptbEIbJOjTSNVZnJfzugO9kmMk05/5arDgssv+OLoYbLkXMQwrJ5fY8sPgi1QlLVIutEq9opDhXa9cR1AOr4rKi/rj+vo0F5rVew029O7mTct/CdRKvUXHRLLnBd9M5kc9XIRB8BGQewErLdLURoNQFvKBAzd1G/ByGTj0+6ljtIMA+UjYl11fqeevE3Amz6mwSOC4wM5vrHpNKZ3w2Y/qcaSru/LO2evJHn+qsSN7Gey98/uJxNovifqBls0rUEAlNIfhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Umcfdny783XvulBVqSoDorpi3era7xQ+qEKsfyc/wKg=;
 b=FajFCr+z91hZeKqF9hJedxWxLbc4eguZrM7R3TxYSkBvfzVLm+Q8oyXK3F21O3+oxqzaXVvULsUeSjdIC5BMxEjGuxgyPgJ/RsFmmVxIn/nXRIgDe73CsXf29I42hlJech+jaXZvJdae8Gomtj9KH7T4h6tb4k5F3C7gwsnXnVIYkLhIY7B+OKDObISHFBvEHxd8Hxd/IIn7471sw5quoN63qOK7x55kkHQiKg5oRNJ7TMmJrVm7mT/GzENR8Zt6ZZOFhVbiflwxEFgbwSElEsreYI0pSeDPZN7rOAaPlrwcFmP544KxaM33uLuIXn3F8A6WqIPG1un0/TIcoR6WNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umcfdny783XvulBVqSoDorpi3era7xQ+qEKsfyc/wKg=;
 b=M6HIDP/aR3J0/w0eetrcKz96FCV/RrS5Co6wH0NkMliG6XtoU0WguKBBl14EIRMbdAuw6AqFuHoVYBH6IhsTc6hjMW5AEZDe6gGZdrPwlJwfgHS57DrVmdIZcdJnIYW1SmbC7FDgILwRQ2KP17W5VjMLy4j2FCURVOpzxaMds3IkE1cgJcQkFJ+u90qGMbU+NPxe5dNdMC9nPlAtv5IABKf2P5casgaRDb5mMlDYyRaEc/0gB2wESn1x5Gz8fv65iHnGRgj2spR9bswXXSa0VWkmJMTXK2mZa8cb7E/e9blDBX5kta4iJ/kfOaX5DOo8NwizItp9zgxoBHKTMctNeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB7950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 07:45:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 07:45:50 +0000
Message-ID: <d2984f4e-0105-466a-8645-60ba30dfebba@siemens.com>
Date: Mon, 1 Dec 2025 08:45:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
To: Brian Sune <briansune@gmail.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251129064818.1587-1-briansune@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251129064818.1587-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: fefe7ad0-21de-41fa-46c2-08de30ada5da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmtyYzRxTVhVTk1TRVcxTG1nSUsxbFlrWEl1N01pNC82WXQ3WjlDcVVMeW1B?=
 =?utf-8?B?UlRJNkorcXVyNFJRSjEvQXQ0emVOMDZwMlFDM2tvb25GV3dzbGsyRFpJT3p4?=
 =?utf-8?B?S2RaMXFxcm5vREdoQmVMK1c4cENlbTJGNkRWTHF5Vkkvc3hGVU1NWkhhaW9x?=
 =?utf-8?B?T21xRXZnZnpYQUFNVDdTNTRKc0JzemtoUmRuejViNkxiS1hGK0ZjU0RWVEVr?=
 =?utf-8?B?dFZNM1ZEcFJ4VUk3czZoM0c3dlZTcFV6a0haQm9TcEZVVUsvUFM0RjBqYyt2?=
 =?utf-8?B?UWpoQ1pkZXF5bXArdlVBTmsxdDl6c1pLd3Vxc1dWQ0RXalJ1ZTVqUTQwbHhN?=
 =?utf-8?B?eEZYK29reXYxVXcwNGJtWWtRbE9aaE5oMXNRZzNjLzVLMzdHaWxNRDU3RW9h?=
 =?utf-8?B?N1p3VVRXUWNxaXBQOGJBTDR3eUNyYTRXd09laVA0d2Y0NU9UNDBOUDRaN0du?=
 =?utf-8?B?NW5nQ0dsRG9ySTFmdnVKaGY3WDI1UVNzeUdjaDdMQ3djd202cE90TzJCRGtK?=
 =?utf-8?B?enNUblpDeVVHanJUODNFcFJtdThNSk1CV3FoN0xXNktWMmkxNVhHZjh4M3Vn?=
 =?utf-8?B?ZWlTVm4yQXpia0pRdXR5dWxTMVh2a1RKZ29NNy9hSCtLQjV0Q09nQUdnWEk3?=
 =?utf-8?B?RnE2ZFludlE3S3I5L0tRNytQM3Q4ZlJnMGxRd2VQRG1LeFRzTWZvSTNIRi8r?=
 =?utf-8?B?M0FVT2lDQmxWUTNqclBKSEE2b2xQNzl2VTZmTHpCNzdsZS9wWUFtVFFjRlUz?=
 =?utf-8?B?Q3FaTS9FOXlncUI3RVhsYzhkbndNZ2JUM2JVUlZjN0J0NE85c0poSGF5Nnky?=
 =?utf-8?B?NlArVDFZS1dFckFlZHN5Y2pQTDBaeGZCQ3g5R0lrM2FFOE8yTWp3bG5IRXlT?=
 =?utf-8?B?UGF5QVIyRjg0eEdoOGRrVmFEUm1NN2Y2VitCeEhDQ3BxNjJlbXBDQmdBN1I4?=
 =?utf-8?B?Y3BiczRxT0FXOUJuU05pZWM0Vkc2UWNOaXptak05bmtrSWlzL1psRzl0b1A3?=
 =?utf-8?B?REg3V2JiVlBxVEtiamNHeVU0M292RGFFMmFGWmFqdWI5aDVNcEl4Y2Nyd25p?=
 =?utf-8?B?dEh2Szg1SVJ5cTlFekNNbWhrb21meFR5L1Y1WHF3alFMWWhvcXY3QThwajdN?=
 =?utf-8?B?dGJqNXJ1SndLaXF3U3BVMGNVNzFMdnJ6VGZOK2k4eW82U1JiRHhaS212UWhP?=
 =?utf-8?B?bm0rWUFCKzFMODFOVCtBK010UlNnR0tFT0gzR3oraDg1NktBM05hNTJNWDll?=
 =?utf-8?B?Mm5xNmVVcXI4SElScnFmV1RvTVcwL3VpZE54Zys3K3FMZENrRERHem83bnlB?=
 =?utf-8?B?TDJoaXVnelNYd1hJc3gxWmxJZVp0Y0dJcHdNTkFPV25aUldaY09YaVEwVW51?=
 =?utf-8?B?R2JOcEVid1BkYUlGeUJLZVo4ajJnRjA2SDdyUmVidy9uWEhUbTJ4Z3c0bmxO?=
 =?utf-8?B?M0w1NnRwN0pmaDM4aDQxZEkrb21NL2EwRForemlibGVnaUdDR1NMa1NZNjRD?=
 =?utf-8?B?b05jSG1tSXFPdGtKeHlhYzl4RGQwK0ZwbnZQQmE5eG50WjBEbkdHVnAxWEVL?=
 =?utf-8?B?ZGo3UE9uS0JVM0Q3RFY5V3dBQmt1NTlUaXVCVC9Hdm9SSk9lTmt0NTJvQ3do?=
 =?utf-8?B?QkhtMmEvZHc0bWNzR2Y3amk1OU5EOFRSWWoyRlFIdWZUWTBBMnY2MW9MOUFY?=
 =?utf-8?B?L2lMNDVKc3FoWjliL3hubzhHMWR0TmRTRlYyc29LWjRoY3l3ZjYyK1lsWUVy?=
 =?utf-8?B?b3BseitreEhDaG82U0wwVGpjTEZVWjVFZllqend0WC9YSEFzVmhBQ0xveWlZ?=
 =?utf-8?B?cDIzZmtmMFlCWnpmTSttSWo1ZklPSm1jQ0dRQWxjcTlndkdid1V2QkIrQ0xC?=
 =?utf-8?B?RHc0TUxvelFpS1hFV1BhcEN3bkM1MkFHbmRnVFR6cW5aQ2pFWS9zQUs3cGx0?=
 =?utf-8?B?OXBrRytYL1QrMUEzNzlqZk1oRXJxK29NS2VwdGNXeXJJYms1S3VUcXMyUWNX?=
 =?utf-8?B?VlQvb2ZQRlZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENVbEljTFo2TFlzV3ZVUjZzenV6SkdYSUlESFMwSVB4Tks3cUZWMlVadUNx?=
 =?utf-8?B?T2ZOdklSd0ZhbWVBaWZwVENzdnRyL0pqdDR0cGZIazFNdnkwZkhSdTcrRDZx?=
 =?utf-8?B?OXM0dkFZUkhhWWR5UUFUTitYS1k0T0dGNm4rbTRneXVSY1htaFMyVndnUU5S?=
 =?utf-8?B?dVlrZUNBajNQaEhwQSsxaWJqWTdFM0xNRi9rNEZuZHg2eHF4QUlhMU1nMEta?=
 =?utf-8?B?YXVsY0J2MGlTTHdQQmFnR3BlZGFpUWJBYXkyRllmWlRaekMrSTgrZkEvdnNY?=
 =?utf-8?B?VWhVdUxtN2p6WlZseFB5T2Zka3VyMDBhRzJhR0pEcWovTVVRMlhXMWZ5RW9k?=
 =?utf-8?B?ZmgvKzQrOEl3TTBxWEJnZWVRZ3h3N0lZMzdpQ0FlM1dnelRHcytJU0l6cTJT?=
 =?utf-8?B?amlUZis3c3RWRDhJd2xwNGVHNXFOaXAwMW4zbk1SZmNvNmdxOVg5VUZRaGNU?=
 =?utf-8?B?VzFtNE5LM3MxZUVMN0tVVk5pMExDSDNNNHNMVEVPcHgzdlNWcmZYNm9maURQ?=
 =?utf-8?B?eXZidmVLa0NtOHd1UnNMYWxqM1B3Z2JQbkFhaTBkWTVHMXdLZm1yYmthbGg5?=
 =?utf-8?B?NFF2WWF5S1VCWDZhay9jOU4xQWl4bzQrOE9tRVVBdTJtRi8rQ3dzMHVmZHg5?=
 =?utf-8?B?YkQ2cEt1S2FHTHUyRjVDeFRFMTZtVERiYXhySlRHRjdibmxadm1QZjkwU2xY?=
 =?utf-8?B?clhQVW03THFveDBlUUEwTUIxSjhiUExIdGhzaUY3dGRiNGRxcmt1Nml1RWwy?=
 =?utf-8?B?Mm9QN2IzYjYwN3BIQUE2UE50QWZaNlpDeUZZZzR3dVllaDJKT1RDRW5lNG5t?=
 =?utf-8?B?Tnd4M2Nrc1dIT01zcGZEM3pBeHgwMXNNY0pYOEg5RUtOVTBkZFZKSzI0K1FB?=
 =?utf-8?B?SzdTek9xTUR6SGd3bGZYeDFJK2pxVXJSeUpXc2xYdXZ4NzRnZlMySGVEc0NX?=
 =?utf-8?B?NWMya3lhTXRFdUREaDF0WXlUNCtqT3hHaitXUk5UK3kxTW9YdFBIWjZ1cWc5?=
 =?utf-8?B?b21HMEVtNlJSSFU0RjFjMlowQkdadVgvTkhjNTIyMGFWZVJKSm9JYlhIaUhM?=
 =?utf-8?B?dm1CbitCK0xkNk5hZ0ZmSU5ONk5RKzk1NDZiYXMwTTZYdzNlbm53anZ0eEgx?=
 =?utf-8?B?OXBmaThpZXcreCtydlRnc1ExcDhld29TY050WC9pUjAxQmw3LzNIMVNEdEVs?=
 =?utf-8?B?MnE0aEF0VHlyMjZ0dWlzVHV1SGtSNkE2eFJ2QVcvemxGUUFibGFxaDdCYkxV?=
 =?utf-8?B?VitQaFkyT3ZQcXl3aUV3VTNSNHA2UGZKeHhtdlo3bWVFaUF5ZHEycGhXQU5L?=
 =?utf-8?B?TXExOFR3UGhBamtvZGNta1RFcTMwQWdTeC9EK2t4WUNRRGFyRm1CR0pLRHBk?=
 =?utf-8?B?UnMybHBsOExRN21EaEt3dVJDaXdiZUJGMDVJNldncTlodi85dE1vZ1htMjk2?=
 =?utf-8?B?TXFsM1ZTYm43RUJMODU4NDlzd2NjN1dyTWRiZzB0K1NUNC84bG5NRXo2T28v?=
 =?utf-8?B?TzU1c3RIQVl5OFI3N2htNERPNWl1d01xSTdBQmx5am1HTzB1emptMzY1aFFQ?=
 =?utf-8?B?aDhaalQ4NjI4dXZSZk9lQUJoVHpZczdEMUREWU1Td0dLSGltK3VsVlk3di90?=
 =?utf-8?B?WFdEa1BOVTQzN095VTk4WTFvenR3MDhrTkI2R2Y4NVRnQVRQYk1CY1oxeHps?=
 =?utf-8?B?OFI5bEY5cmpzKy8xZ0orRWJOYWtUNTNTS3RlbzZRekx0c1VnOGx0T3FyNVl5?=
 =?utf-8?B?VlhrUTQ2YXNNeXV0OWZyM0tSKyt0Mld2cHV5OFpIMmErVDVmc0R1eEFXbmZv?=
 =?utf-8?B?ZFoxYUYyS2MxUVJBOGx6MXdLdFVyUGhTQWtET05PTnFpVjFiRVlTVWFBZ1p1?=
 =?utf-8?B?WGN5RE84azU0NHViUDQ4YWF3dFBUUTdBWDRRc2tGbVEyalpSekNsUFVoSEJF?=
 =?utf-8?B?Z3NqWDRNVXJmRG5jVU8xTFVZN2pBc0lHa0JlQVkrL2I0R1NGeFN1by94aE82?=
 =?utf-8?B?SUFlcGVpM0ZiNWVoV0haWFJHZjF6cEE5dG1NeFZHV2hMdUdzL0xxQ0pvMUJO?=
 =?utf-8?B?RGlZeUV0Y1hCbXVxek9ZOXVXcUZlRXlRYThGdThxNjJVOCs5WnFkcllnT1lv?=
 =?utf-8?Q?cDLbSPf3W8NdN2sz3fxxREzMR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefe7ad0-21de-41fa-46c2-08de30ada5da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 07:45:50.6022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz6FtTsb9kLAcjH5hNoGfVVtKe/o7p9KYL5Fksuf8bCGXI2j6lAz04HjRUk7cm/HCinOUgGgieZBHH/2o4zxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7950
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

On 29.11.25 07:48, Brian Sune wrote:
> Thanks to Jan Kiszka had provided info on
> u-boot is not able to boot by u-boot-with-spl.sfp.
> 
> All three TYPE, NUM, OFFSET mode methods
> are nonfunctional on combined raw boot.
> 
> The major cause is spl+u-boot structure is
> defined as 4x[spl+zero_pad] + u-boot.img.
> Deal to this configuration since GEN5 is used,
> the spl would require to seek by an offset
> on top of the spl offset. This means for
> each spl=0x10000 the offset is 0x40000.
> 
> However latest u-boot do not consider this
> major structure on GEN5 socfpga.
> Meanwhile, the default include file as Jan
> pointed out is completely wrong syntax and
> caused issue.
> 
> Combining both concepts, the minimum fix
> patch is provide as follows.
> 
> 1) Offset is control and default set to a
> proper offset under:
> SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
> 
> 2) Only GEN5 socfpga will be affected and
> minimized contamination on other devices.
> 
> 3) Only one compuatation adjustment is made
> on spl_mmc_load. And simply introduce the
> offset adding by the kconfig offset control.
> It should be 0 by default and gate as well.
> So no possible harm should be done.
> 
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  common/spl/Kconfig   |  8 +++++++-
>  common/spl/spl_mmc.c | 19 ++++++++++++++-----
>  include/part.h       |  4 +++-
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 8dade2b501e..554509146d8 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -574,6 +574,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>  config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>  	bool "MMC raw mode: by partition type"
>  	depends on DOS_PARTITION
> +	select SPL_LOAD_BLOCK
>  	help
>  	  Use partition type for specifying U-Boot partition on MMC/SD in
>  	  raw mode. U-Boot will be loaded from the first partition of this

Proposed as separate patch in [1] as requested my Marek.

> @@ -600,8 +601,13 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
>  
>  config SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
>  	hex "U-Boot main hardware partition image offset"
> -	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> +	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR || \
> +	(SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION && \
> +	(TARGET_SOCFPGA_CYCLONE5 || TARGET_SOCFPGA_ARRIA5)) || \
> +	(SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE && \
> +	(TARGET_SOCFPGA_CYCLONE5 || TARGET_SOCFPGA_ARRIA5))
>  	default 0x10 if ARCH_SUNXI
> +	default 0x200 if TARGET_SOCFPGA_CYCLONE5 || TARGET_SOCFPGA_ARRIA5
>  	default 0x0
>  	help
>  	  On some platforms SPL location depends on hardware partition. The ROM
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index d8ce3a84614..6904ea3edb7 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -5,6 +5,7 @@
>   *
>   * Aneesh V <aneesh@ti.com>
>   */
> +
>  #include <dm.h>
>  #include <log.h>
>  #include <part.h>
> @@ -28,7 +29,9 @@ static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
>  
>  static __maybe_unused unsigned long spl_mmc_raw_uboot_offset(int part)
>  {
> -#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR)
> +#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR) || \
> +    IS_ENABLED(CONFIG_TARGET_SOCFPGA_CYCLONE5) || \
> +    IS_ENABLED(CONFIG_TARGET_SOCFPGA_ARRIA5)
>  	if (part == 0)
>  		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET;
>  #endif
> @@ -106,7 +109,9 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> +    (defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) && \
> +    (defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || defined(CONFIG_TARGET_SOCFPGA_ARRIA5)))
>  static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>  					struct spl_boot_device *bootdev,
>  					struct mmc *mmc, int partition,
> @@ -136,7 +141,9 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>  		return ret;
>  	}
>  
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR) || \
> +    defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || \
> +    defined(CONFIG_TARGET_SOCFPGA_ARRIA5)
>  	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start + sector);
>  #else
>  	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start);
> @@ -419,10 +426,12 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>  
>  		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
>  
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> +    (defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) && \
> +    (defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || defined(CONFIG_TARGET_SOCFPGA_ARRIA5)))
>  		ret = mmc_load_image_raw_partition(spl_image, bootdev,
>  						   mmc, raw_part,
> -						   raw_sect);
> +						   raw_sect + spl_mmc_raw_uboot_offset(part));
>  		if (!ret)
>  			return 0;
>  #endif
> diff --git a/include/part.h b/include/part.h
> index 6caaa6526aa..91e49012e2f 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -461,7 +461,9 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
>  #ifdef CONFIG_XPL_BUILD
>  # define part_print_ptr(x)	NULL
>  # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
> -	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION)
> +     defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION) || \
> +     (defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) && \
> +     (defined(CONFIG_TARGET_SOCFPGA_CYCLONE5) || defined(CONFIG_TARGET_SOCFPGA_ARRIA5)))
>  #  define part_get_info_ptr(x)	x
>  # else
>  #  define part_get_info_ptr(x)	NULL

Two issues:
 - fixes for CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE mangled
   with socfpga changes
 - a lot if ugly board-specific ifdefs - my approach in [2] does not
   need that

Jan

[1]
https://patchwork.ozlabs.org/project/uboot/patch/db6aa161176dfcc4d2764e9411b4d195c9c3208c.1764574369.git.jan.kiszka@siemens.com/
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=483978

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
