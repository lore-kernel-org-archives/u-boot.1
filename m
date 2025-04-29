Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EDCC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59CC8283E;
	Tue, 29 Apr 2025 15:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aOMqI0C0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7454C8288D; Tue, 29 Apr 2025 15:44:03 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702B38272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fA73OAohh9rQArInmX9F06Rgw7ITmmWsyXht6d4uXh9tkJD+uQ6SdnuOt6jqKBAYcXfCJ0MN9B8tAKTeN5AwFIZui2bwuVh6/HaT/Me3LRr6NM257whRJAG+jco+XRow6Ae7qf8yHcZsBzS54uRTsvq3fsyUc3ON1y11+bhAg5UrUWj6KHoYfE3vHgfNaqdSIjHQJbnl3LNfQfT0JPweKdukIg0cKXV+4jbTGMc8t+Jni9DdrfBJimgJs6OeE9DQpsTFZF1lLwP2YhtxfO+voEkGgMixd+3i51/Dv4/frmngxS0MfgWH65VH0BmWktHadiR9naad9gGvKMPpS+hVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaG1xTr2Qmjx5iXA8g9kC5oGlUkPWVDN0gG0f2hoEvc=;
 b=k1iDhrW3M6636QEMkTEtdZi+pOkVGwvZJMyYmBAi4SZQWeIRoU09ernnuOMQZXfAiNeRAnaSnHnPCq3RnBJsV4Hh6xySyhZHUlBcX0amwspaW1ETD0SKuR9wmPBq49BYxLX1ioPTqCAHpoHV3SLI+HZzuYfKUxQtAkWTgHKqgg65tIO3X5Yf/kLZncZQAsp0rQOT/TbWiFFAV4RqmJP2rIE0h6VRo8zjaH8h8db3NWALohtganhZw6wD1qqi9DfmlAwL+xNaSjbX5/sSkPhassjyNhIbOKvzcGC+TNMd8CBRcVCywNS8QPHYIzT88U96o7KTtLUfEwvE/F80/kEpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaG1xTr2Qmjx5iXA8g9kC5oGlUkPWVDN0gG0f2hoEvc=;
 b=aOMqI0C0OQSRpkIZBUCy49Tx1JYFTfOQDC8J0YNSeZyjg7OZ9bpyE1sRVTPn4vsxZfZZfme3GqN2XM0+Gmwd/4JoTQvzreSpiI7TqH+Z4EAzRx61Z/8PDf87m2nzD7+pJeqpKRpj9bi/GtUP5XQzynIn/1hr3z+U5wc/21Zvn7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 13:43:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 13:43:59 +0000
Message-ID: <8290023b-329a-40a5-ae75-f41c11ba3c2c@cherry.de>
Date: Tue, 29 Apr 2025 15:43:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/make_pip.sh: Use debian packages instead of pip
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20250429131515.244061-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250429131515.244061-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: 60de9b61-25bf-4a85-5a5b-08dd8723e4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjduVTNLM0hhb0ROQnNOQjIraGdMRk9QUkZzd1VodVpkR05zNldJYjRPZmdq?=
 =?utf-8?B?U2p2ZE0yZ01jcVpmb1ZXbnd3SmRKZXlYcjFValZrd2NZRjV4K3RrRDFjZGcx?=
 =?utf-8?B?NCt6R1l4VGo1YVh5US9rb1pqV0RCOEdLczBGT1QxZUUxZGZMcmIxcCt2K3lJ?=
 =?utf-8?B?dDJtV09EVnU5d2tlUUtleGI0VVZ5dExzajNKSGxraXFKMVpIdExxemxTbUpa?=
 =?utf-8?B?YVVadTBTMjB1YmZWd3R2eWlTeEV2dWZqODZSYXVFRkJZOXAyeVFwZGEyWTlw?=
 =?utf-8?B?NlA5WE0rdUg3UUF6UHdscU0zZjg4Y0R6Snk4ZXNRQ2loWFhnTCtlRloyVDN4?=
 =?utf-8?B?SFhENjJmNU5NZTA0VFNTWE1xM1c3NjVtOHlORUpuR1NBS2Rvc3EwWXY4anN1?=
 =?utf-8?B?UU9HbU16WW9kcGUxN2tWTTJFblFNQi9wRndKdTVweFJ5dTAzdlJvSy82S09O?=
 =?utf-8?B?M1hYTmRMQndNeGJXOURWbCtSYmd2bi9hWmRLbVp5NXJ2akF5cXhLZTZ2M3Nw?=
 =?utf-8?B?UUpjRTVpUVd1RmU0U0Nqc0pzSjBuT1hPOU1mSEQzREQyaTJ4WU9pRjdaUDds?=
 =?utf-8?B?dnEzcGpkTVpYNEkrb3A3aDJKa1F3NVNOOWdHd1cvbENqeEl4elFVMVJoYXJT?=
 =?utf-8?B?N3JaRnBtcE5OdWhJZFhmWXdvUlpBbVVMcDFuQnJ5MW8yQTJqZVU3MWE0aEtY?=
 =?utf-8?B?MGNFdndCd1FLTVBlQ3RoNmI2dlZlYTNteldiZnE2U1ljck1VOGpvekVraUpG?=
 =?utf-8?B?WkhQUnBmRUtreWtxeGJteFkzak1zSGhzbXZiQnJMK1J2Y2k0K09xNDB4UVln?=
 =?utf-8?B?aGFqTS9uYXl5NkdLTVpmZStZNmM4a056VFNBK09qSFJrYTB3VndwZ3R3OFhP?=
 =?utf-8?B?ekQ3VllUaVFzeUJ6d0VYSTVuRGFFSDdrUW1oTFI2REdjbDdsRWc3aGRHelpO?=
 =?utf-8?B?ZURYYTB3WTE0K1BMa3k2VkVvT2o5cU1lL29zb0lSeXc1MWkzbHdQVHR2TmtY?=
 =?utf-8?B?NnJzMmIrUVF4L3dJNmF4aXRUc2QxanRLcU1RUjBKa2J5RjczcDUycXl0OUlR?=
 =?utf-8?B?eHBmeVlHaWpkUkZwTUdHQlBzK1kzWk1zWlJHR2xHUllqeVQ5SWQ2eGdBQitG?=
 =?utf-8?B?RzJhak53a2R6M09wZEJSVXVzT2ZoeUt4bUQvd0kwWXFUWVpmay9oMjZScEFk?=
 =?utf-8?B?Umg1Nzc2QmxQbENSMEpQLzJiVGZtNllLRVhSMkUrSFJRNUFEUGNIVGs5UUQ4?=
 =?utf-8?B?aVJJYWwrZmxxTlFSOFdjbEptYzgxcXo1K1lianc1MzVuYm5pbDlkdjh5SVZV?=
 =?utf-8?B?N1NUZmhqemNtR0tOYWh3Njg5RWtoaTR0b3g0NlNKNVd3NEFZUmtIMnFjNDVx?=
 =?utf-8?B?bzNmRXVCbUFEK1MwSE1pTmF3cXNrOGNvdi9qRTA1Ui8yS1B5UGhlaTJ0dk5U?=
 =?utf-8?B?WVhaU2U0MThLYTVONUIvbWV3SVg3SDIxS1RJNEFta1ZabkJlci9OZ3BkdWhy?=
 =?utf-8?B?SFlzSjVIWmxDM2ZmY01qdS8vbVh6eHdodzV5cS9BTERmeGFwckEwZDhhbnQv?=
 =?utf-8?B?SnpYQzhUdkFEVVd4SDUrWm1JOHJpVWVXWTZvaGhRZzgwejkyMkhCeGc0QVlU?=
 =?utf-8?B?eTBLZkFramo1U3hSaWdPOEVYTFpIaWlTY2M4L1BhaDVoQTNqcENseFBxaE5B?=
 =?utf-8?B?U3RLdkJXM0pMVVJkT3BRZjRpby8yNDBtUVo2dzBOR0hiazJiNHFDc0JvK2c2?=
 =?utf-8?B?dHVtVitVQlZweEhkOUE0cmpsejRYdmM5TGVCbTJsK0ttRkV2ek9pemtNWndE?=
 =?utf-8?B?Nm9QR2UzNFJJR1ZIYzhOb1Y0bDJSZjRTUng2bmlaL0ZUR2xLUElyL2ZwNmJZ?=
 =?utf-8?B?aVpKTkxQNEJJc1FSRStFL1hGWSsxZ3FZRnJLK2JWYVZQd2llSFgzZ1h1aDRL?=
 =?utf-8?Q?m/Lblkq3PCQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlhFclJXM2R3bGRjN1lhSlJCV3BvTTdUQnB3SzVEaUFWSk1MLzNmbHRLWEpJ?=
 =?utf-8?B?TjVRU0FFclR6a1NBMUljS0xlL3Nia2w0N0p4OVpISzY3bVdqajllLzVVTnY3?=
 =?utf-8?B?YXl5NXJZYWRGcGJoUUFNM1FCc2Q4OE9qTjY5SzdyejhxamNGOEpsQlBDdktj?=
 =?utf-8?B?R2d3all3L1FMS0RyME5BRjJ4d0xxQXFSVkhFTWxGd2JWa1hObjZwY1NaMVZj?=
 =?utf-8?B?a3ZVaFRienF3Z215T0xRSUMzdENkYkZ1cHRwM2FocG9nSlRTK0NQcXRSTzYr?=
 =?utf-8?B?UVExWTgyMW1WVmdmNkxDZDg3ZXhpeTduYkExVG0rQjkrQ0FaUWZPZWl4d0oy?=
 =?utf-8?B?cFlXQ09iQkVXK29xZWM1aW80d0JCSUlCK2JhQkR3ZHI2WDhYMlFKRHpJTW80?=
 =?utf-8?B?bWppbjZlR29iWEpDc0IvelpuS1BaNzVZTXo4cTVOZ2cwVU5rRUxEL0hTWWcy?=
 =?utf-8?B?V1FPOWJNeXpaWm5vWm9LbldEUjNGb1JuRjRRbjIwUTZ3YU11L3d6Z1M3cVJ3?=
 =?utf-8?B?U1FvQzUxWVQzQ2FMVkIzb28ySHBkTGNLcTlnK05Xa21FMUNKYkpiWVlHS2xQ?=
 =?utf-8?B?aHZsU2QxOHZvRVhZQk05aVhuRE1MemU0ZmxneDJnNVlqT0MxOUFSOVcvZ3hY?=
 =?utf-8?B?UWdlMXFCa0N2c3dmVlE2QVdvbm9INiszczd1QXZlZVlCa0E2bmZCVStOWVR5?=
 =?utf-8?B?dFpVRWNzcDdkTllud01QUVBNejRxdmhmMVNCNStHbmR5NkFIcGVxN0RnSmxj?=
 =?utf-8?B?T3FHQUU5QlZkeGpTWk13TStEMDhRL1FNSGVhbHVVV29xU2ZJbmtPOVpUNlNz?=
 =?utf-8?B?VkdNdlRoRG5yOFQyZlRwSVlHeGoyYkZFV1ZCVVNBVVFSaU5wRFdCMjl2enRJ?=
 =?utf-8?B?bU1ZbHJsK29lK3hrdkRYeGxOM000UGRvZDh6dm12bDZadDhiY3Y2OUxkQytq?=
 =?utf-8?B?RG1ubFhGejNWS0FuMmQ1d2VCaGpSc2RrdzM5cG84enREQWgzOWp4YXExY1Zl?=
 =?utf-8?B?cS9zWk1maEJ0anZpRXN0RUVnMDVCT2dSU0RLbm1LQS83QmZZRlFTZTdobS9h?=
 =?utf-8?B?WDJNZDNxdTZWSEV5VTVIZkRlekVGWlV0dnpINU1NZG1Uc29mMUFBN1ZBWHhj?=
 =?utf-8?B?MU44Z1habkx1b2xtQk14MGQyUk04SlFVR0hnajltU3pqZktZOEJHc08vMXZw?=
 =?utf-8?B?TWhWN3BnblBTSTFIc3dNcGdweGllUTZ5QnYwSFNYY3VUN05CSVptL2tUNmlz?=
 =?utf-8?B?N3c2QUsrTFZnTk1hYW1uRHVnREpLb1N0VVdyNG1BdTNDaUhYUzZzQVRXL1pR?=
 =?utf-8?B?bmY0VlQ1WlY0bWdUOStxV09tT25tMThFWTQxQTVBcmU2VDUrdHJwMkEwQVZK?=
 =?utf-8?B?Yk1mRnRRUGVnUEtNRWJhYjFiMHNkeE85SHI2bjhheGFkcEhBeFZiY1lQQXQr?=
 =?utf-8?B?T3o4aHh5SFdPTDgxampzYjNIOVFyeWg0dUZMZEVQR0NtMi9aSmtCMEJtaWFP?=
 =?utf-8?B?OTFVQVpFMG5PS3JVSmtCUWp4VXhCRk1LZ1pDTm9xaWNKYlc4ZlFjL2pCTklK?=
 =?utf-8?B?M0NTc21vM2ZFSXFFNDVXNGR1WjBmMklzeE53K1VtVEluNFVWMXlXVVRGdlIy?=
 =?utf-8?B?czJYRm5tVXhKS2tyWEMyWldSWGQ5OXYxTVJ3M2xuVmF4V1BIdEJzbndsWndz?=
 =?utf-8?B?bnhDVTArN1lWMUROQXdyL29oRjNyczlXOTF0d0FCSW5QZjg3cjVIb083UHhU?=
 =?utf-8?B?TC9mbS9EQ3drMWZybzB2T0F0VkloY2ZMNlNRREQxVkpwemhBU2VKTWRaZmhm?=
 =?utf-8?B?MXJNcEVoak5IRVU1REkrWDBzdGxCRGhWa21GbkRmTDRsYXh1NTk1UjJ0QXg5?=
 =?utf-8?B?blhXb3ArVlZRVjFJdnpHZGZtNm1uN3NNeDFVYVVERnE1VzJYMUpIeHhrZURr?=
 =?utf-8?B?Y0xzQmJMTEE5SlVBeGhsTUpwUWoxYUJ6VjJ1N0JLUStIL3BIVGR5bGdIQ2Ix?=
 =?utf-8?B?Z08zdlg2dWFIWEd5NXJURktaL1BtQjMvUndta3NQczBuZFc4bkFMbFB3NXlv?=
 =?utf-8?B?RXppMU9TK3hLOTVBRWs3WW1zbHlXNk9XYmZIbUVPZ05wUUR3dGVtS2xWY2JV?=
 =?utf-8?B?c3NqbEw3MlFEZXJhcEllcWZjWHlmZXRCbU5aS1RIdmdjOTNLWWVvbFhtQ3px?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60de9b61-25bf-4a85-5a5b-08dd8723e4e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:43:59.2173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYlZ3+zGX2yF/nVbFSzfLom7kI51B+sST29SdPGjauNX250H/AXC6kMhLivsvbgyIQRBrI+lb+RlJLxDu+EIlAZJgI2Pekqubd/0D8gd9wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865
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

Hi Simon,

On 4/29/25 3:15 PM, Simon Glass wrote:
> Recent distros complain about using 'pip install'. Adjust the script to
> use 'apt get' instead where possible/required (e.g. with Ubuntu 24.04).
> 

I believe this should already be handled by 9d3f1ebaf875 
("tools/make_pip: Use venv when invoking pip")?

Cheers,
Quentin
