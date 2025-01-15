Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C26C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 11:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9CE800C2;
	Wed, 15 Jan 2025 12:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="P0p3jq9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B624800C2; Wed, 15 Jan 2025 12:17:44 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8567B80040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYgSiXwkZ31wsVIuMcsekKi09bTltiH7fTWKUxQZvD3LsH9p8w5n9cVwXK6dTyyRXkqq3kbLPd9kFqpZlYif84yyKJhrozwyuq9GFT33dm91t65lUSxmhA19SfXp/x4Cm0rTfyPrhvx/qQaF44CHguVlps9XGX2Jc+/YWfsIlYQrRTJUF4tlTaqTseY08O+YhhMIRxWytQft/ur+OufVYGsXB5mXBXob3Uf4l+wIv5GrTdbwheBeCd10Tp/BRK8gsCEKrULIkdWDSxIKZiMyivvSQ74+zoZj7hfHz5diF3HAlujfjc7B5DkYywLH91BG+9MK92ii3dRNa+4ZbfPGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdDq12dVdqJ0NFdA0YcudOS+C/l+GD9EBKn6ire4LEY=;
 b=FbNkAn8ECJ3RGRwtRsdepv2MADcHibobnYQUiXr8Lps6VhNnyJ/A8ie4ozo0vDizDdK2NYQgqWXa8sxndZqA1E3aOhnYTompCzgYSskPz5YGdz5DYcHBgWVZZtH/3yAitkAxkBt5IMjX0V7yfMRuEpM9hsgkOsdme7lAOLHkCLxi+NIwyycAb7iJ/iXa8CCxHlR8OkkDUdzjNm0w89Es8+OKR5LmmnU/SyironPGBucJNZttzMnvHkvqTDWKFROGtzmvqFDY+ruksUqMwsAoSDDVoI+c2rmRvjqhNsjvFwFh2zxvNn7ydef7MSX1AILxKXa7Pluap32JWDZggBTEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdDq12dVdqJ0NFdA0YcudOS+C/l+GD9EBKn6ire4LEY=;
 b=P0p3jq9gY8KhaSdyZhx3NkzrqchW89GqqN8bJss9hOVHhTql/TfPXxdSBpuXgNlY+aEXD58EEcm1pfQqDEr37m2cc8S02tINn5gqqSXL4QoZv6w/VQRwEEuv6aluxPMHJZxL7qZYQN1NMoHPk591Joz55o/Tk7Mh8VMWWAhyWxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10902.eurprd04.prod.outlook.com (2603:10a6:800:26c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 11:17:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 11:17:38 +0000
Message-ID: <3e8a34a3-5925-4bb6-911f-f89c9c3bbae7@cherry.de>
Date: Wed, 15 Jan 2025 12:17:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <2b658c60-480f-4488-8c40-f781a849cb32@cherry.de>
 <5d2fb256-cd0a-4a94-ba9f-f13a928656ed@gmail.com>
 <5f42abef-4aad-4f57-8396-6d8d17a89285@cherry.de>
 <b0af95e7-1e4b-4630-8355-d4218896ace6@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <b0af95e7-1e4b-4630-8355-d4218896ace6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10902:EE_
X-MS-Office365-Filtering-Correlation-Id: 65217f31-a15b-4a42-ab7f-08dd35563828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUtBdUhHcUFiQW5mQ2JQL0JtYmYxajgyNEFHYU5MaUw3dzVMbEtKOU95N0tS?=
 =?utf-8?B?TTdlV0lyWTBGekhnOEZvY2lxNUtpRFhtTThIczcvb0V3cGMxYWhrNW5RQ1dl?=
 =?utf-8?B?Vy9ub1oxRTlGUVZ3RjB2ODBFUDhNdDJUY0FCNXBEc0ttOG5XVWZQM0drOU93?=
 =?utf-8?B?SUk4L0NQL2RMRndCY0pQOXc2K0JNUHpsTWtFSlk3MzFpQ05BM3dyRE96YTlZ?=
 =?utf-8?B?RGo2VnY3Z1dwWHhmY2RpR0xoMlZUbnFJMFVZM0RhTEdHYmdHaEhzdkJ2Q1py?=
 =?utf-8?B?Ky9YUGtzSk1XNklJWVRDTTc2U1BjamtLVGkrakcwMjFlaW9xNmpSWEh0UFNz?=
 =?utf-8?B?Y2VxZTVjVFpNOVR1NHBtcUtMWGpVcVRMZGdlb2dVYlhReE14S29yUklYS1hu?=
 =?utf-8?B?ZWZCUms2YUMwZnJVczVGY2xUU2NnOHV6bEhwOGVkN3A1LzhCOVZuc0VIMmUx?=
 =?utf-8?B?TXlCdlJJczNZYjd6enJ2Sld3eGJJdmlHcWxiSHA0enhWVGxTUTNrNy90elQw?=
 =?utf-8?B?MEYzSFlWdWpWS1h1NEw1SFU5L0Y0SFptYW55RzlmMkJjK3phOUpBYnIxcHh6?=
 =?utf-8?B?VEd2UFZ3ZndMZWJGdVpXTXBaUnZVVGF5U1AvOS8rZkF4OWJsRkFoNHpnYzIv?=
 =?utf-8?B?NjF3bklSaERVc1dRSVFyd1AzajNEY2FSQXBSVnh6NHJyc0krOWU0ZHJycitN?=
 =?utf-8?B?WmRXOGI4aDVSQ043VnZXazJFbzVwM05mcERPRzFySUhBLzRRWXQvOEg3bGNY?=
 =?utf-8?B?S3ppY3Z0R2JRdURsUWFnNVF0TmY1Q3hodXdLNWxYUHdvRmJTNHJlSlFMczZN?=
 =?utf-8?B?TUlVM1U5bzdQZ21iUHBOVHZyVkNNbGdPb1B1aGxVVTJJeTdsZE9WV0ViSzcy?=
 =?utf-8?B?SjErdjFIM2MwM0VjblFTUWFIY3lwZFJDeGJOVFhpSE83T1Z4R2dlMXNySVds?=
 =?utf-8?B?aVNSU0RtQ2Z5WTUxSzlFVnNGRlZ2R1dqNXQ0OFlRWkkyWnJseVMrT2ZsRUxp?=
 =?utf-8?B?THVha2hPaCtlb0FmMm90bjBKU0lqVzl4Z2dFV0ZVQVgvZWcyTUFXRk1tZ0lZ?=
 =?utf-8?B?WW14cWduQzFRV2xCV2hoazlqOGtTUEN1L09iUmZZSE14OWthWUpDK0ZpN08z?=
 =?utf-8?B?NnZHQW1mL1JGbVJmNTYxeDhOeWthcXBkejhvVHpMZXNMZzdBeXhpWFgvUmZK?=
 =?utf-8?B?dTN3eHE2NzczdUZZWXZKZHJjbVlBNnoyMnJZMVpqYzVZWE1ITit0bjY3UnVF?=
 =?utf-8?B?RGkzMk12ODl5SnZCMjgzNmRubk9PWWV6YkJGMmwzZkd2d1QxR3Zxb3RFRTRp?=
 =?utf-8?B?YWpNYWg2YzEyMFRKOFZrZ25QdEZvUzh4ZVJZa0JjWlFUa0dNK2V6TnFMeFBW?=
 =?utf-8?B?YlNDKzBEM0gya0xQMzBvUlVzbWxncnhuUHRwTUN4cnZqaHFlL2FaVmhNNmhQ?=
 =?utf-8?B?RkNyN1IvUW5Cakp2V0xnUTY1OXRsLzJhZUptL1pBS3RBWU51TVlWSEhWV2Z3?=
 =?utf-8?B?Wk5qTWtONUZreUdSWElQV1N1MUZ4WnFEZWdqTDBGZGNtbVphQys0MjBneGtN?=
 =?utf-8?B?Mi90dzFueVhGcFgyOTc3bFh0NXJxa3QrNzRnT2lWeHFKLysyNmYzMVkrUUhk?=
 =?utf-8?B?bW1TUXlTaVBSc1hDU2g0Z1FQL2pSVGlsblVnU0txMUN4K2czRlNIR1VVSmM0?=
 =?utf-8?B?U3BiMmFnV1FRaWlZSHdaRE14MWF0aFNDUlA0OFM5alRyVWMzSXYrd1dCZ0xs?=
 =?utf-8?Q?7DvWMP8qo/N7xjvc/PD9UpXk/kpiV2WTRoM48FH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjJQSjBFM2JZbmVRR3UzRThpL3E2ZWpVUE9Jek4rUk5nZUZtR0s4MTNtbDFF?=
 =?utf-8?B?d0EvMmtPL3JZWnhvcjJzdjM4WU9SMloxd0hMcmtYUUlvSzRlbnJ6YVY1Qm91?=
 =?utf-8?B?Ym5XV2JqN3pxSGRQR284QWdPdkFqdTN4VlpBdmtPWWNiZUpaRGhndEUxeWkv?=
 =?utf-8?B?R3daN2loSFMwMUJRUWRrcXZWMUJ3V3FzeGhLQXBXc2xxaWVHZnM3UEswMkF6?=
 =?utf-8?B?ZGRweC9mVmJ6WXpkWVl2TFZUaVpvYXE1VTBacHl1S05PS21aTTFxcnl6SzhK?=
 =?utf-8?B?ekN5Y2NObWpmdHZVM0xpWHBUZFA3bi81bmtGeUZ4ZWZ2RkZUUFFsTUFaSTM5?=
 =?utf-8?B?UEs0cDI0Nmh2UHBxS1NPWm9oTndBb1VxNGU5U0dhTFVNQzZ1TFM0VDRtS3dV?=
 =?utf-8?B?VytWKzJteWtoclFXdFpjUDRzQXpjZEJ4aG5DcHFVeTlJWi82VGtudndxTWVJ?=
 =?utf-8?B?dmUrOW42andxWVY3OVpzUU9NaXlvVkdOQUowRUh6ZHFzb1FjOW5RWGtIT2Vt?=
 =?utf-8?B?Z0VTK1ZRQVA2NGtlS1hmWWRkM2g3NjJLclA1VTFUME5VdFMxRGpXUUNXZ3Ix?=
 =?utf-8?B?NkxYcE1pQzlPaG5Ic3pSMVlTNUt2aVMyMjRyN05BODN4UnF6eGZhR25XTmh4?=
 =?utf-8?B?bURtd3JlRDh4emdqVTBOdERpRmhvcjRjSGpnQ2VXaW11ZjNOemx4N0NGZ0tM?=
 =?utf-8?B?eWt4R1R1NEtRZDVkUWtCdCtXdVAxTGN4TmlnRGNjWHdDM3Y3Y0pwdFJ0ejV5?=
 =?utf-8?B?YzZ2N2s3M21YekMwSWNkMWp3SHVmL1ZkM0FzTWk5UlN5ZlVVZUlxcDJ3enVV?=
 =?utf-8?B?TFAxbkc4ZldHYXk2MGgxMm1rRVdXOW1FN204RGpCQUtNdzEvWVFPd3dOeko2?=
 =?utf-8?B?RDZvTVJmaUpBMmVuSjZiKzJXeHlpbmY1cngveEJNVWUvOFZYdU5PaDdhSmFT?=
 =?utf-8?B?ckx1cjVYd0RudkdNMmw2aUZSZ2VQdmNlZjFaVWtIOE90V2p4ZHE3NzVrUzcy?=
 =?utf-8?B?WU5heDZtL1hnd05MeU9DZ1NKTU9oaFZjTEpJcVlYZVN2K2NqOVM2WEFpMi9O?=
 =?utf-8?B?M3kyV01JRjdwMno0RG1vOVNKSi9QODU4RE5keXNWaG9JLyt6QXpRV0FLTmoz?=
 =?utf-8?B?N3c5K21TZlNkM25nakFCU1U1T0g1YnlsNk9nRmhrb0hocXJUOTJvcHhnb0hF?=
 =?utf-8?B?MC95NUJTTmhMSW93Q3FZZ3Q5d2xtR3AwQkZWMk44emJmTXdqeVMzTU9LWmk0?=
 =?utf-8?B?QjB3emdreStqWlJxdVR2TGZQZmMrMStTenFROGdvUlVlQlU5S3NmYlZwWXpi?=
 =?utf-8?B?aWVZZnUzenVia1kyWHE2WHcvQkE0ekdaRUZxNHl4UjRZL2RTOFZOTnhIUHI1?=
 =?utf-8?B?WmtPaGpPdkxLbEt4Y0RoK1pOVUJHOUVjcjBXSVc2bjlXVUpWUENqTmhXZnlO?=
 =?utf-8?B?d3JjdXdEOHFnZWJzYkVKNnhuNWRvVkhXcnRzZDVhWGtHOWc4UUFMaEh5WkNR?=
 =?utf-8?B?SXdGY1kzTlMrYnluZndlQkdyRTRnNGZXVlc3YXdaTmNqeS9rWFVhRlpUeDJE?=
 =?utf-8?B?UXh5TUZhanJnaEdPYXc3a3ZzdWJMTDUvT3EwSHZxZW9pc2tuQnZvTkFZMkNT?=
 =?utf-8?B?VDFldGVzV09wTVVKUWJRS1lhd2UxeGxvc0ZpUkgwLzZyVVJRYW13eW9MajVE?=
 =?utf-8?B?dmVvdklxaE05eUxmTERuRnIrejA1YXJVaGNrcFNSQWhSNWthZ0hIV1BxdUI4?=
 =?utf-8?B?MVE5TEJ1cmZWZmJrRlpwYUhtL0lLTlRTcTgvNThBNFhBQlhDUndUTEI4MU9z?=
 =?utf-8?B?NDRjNUcrd1VYSFh5UHo1d2RKdEhnQlpyNVNWR1VEclJoaEc2SUVRdE1ONSt4?=
 =?utf-8?B?MEdXV0lrWDFmVU9RWnhOajU5QmljNUgrY2toanovV3J5ZStuWGZEVWJFWHl1?=
 =?utf-8?B?UmIyQWUxZEZtbGgrTVo2Z3g2Mkc0NVhYbXFFY0Ewb3BFaW9vWVRYdVdKK1Zz?=
 =?utf-8?B?Z2s1Rm4yTWhkMlFUVG5NR0JCbCtOVXdVVCtYbGdXd3Y1R1Q2c1pJUlRFL3Y1?=
 =?utf-8?B?a0xtQ05RNEtLSFAyTFZUZlZ5WHNOQ3VUeWZxU0NiNTZ2by8rYXowY1NtRGgr?=
 =?utf-8?B?aytJSFFVNzE2Tk5Nd1RtTWs3Zm1hTXgvL2xUWGtHT0RVamcvQjlYNENpMXd3?=
 =?utf-8?Q?6G5D9raPadcavZ6rKWUARYo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65217f31-a15b-4a42-ab7f-08dd35563828
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:17:38.3879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UulGAAnNiHlfTcNWDZdprnmIU9d7s4r8kisCzVecIUo0qHjbuH6bbr+mFTIizAQULwS6b6ZWZ1dSWpd7XSYyMJdFXIQ9yxtiFsnvLOKlHZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10902
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

Hi Tianling,

On 1/14/25 5:14 PM, Tianling Shen wrote:
> Hi Quentin,
> 
> On 2025/1/14 23:21, Quentin Schulz wrote:
>> Hi Tianling,
>>
>> On 1/14/25 3:49 PM, Tianling Shen wrote:
>>> Hi Quentin,
>>>
>>> On 2025/1/14 22:39, Quentin Schulz wrote:
>>>> Hi Tianling,
>>>>
>>>> On 12/26/24 10:20 AM, Tianling Shen wrote:
>>>>> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
>>>>> Ethernet ports designed and developed by FriendlyElec for IoT
>>>>> applications.
>>>>>
>>>>> Tianling Shen (7):
>>>>>    arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
>>>>>    arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
>>>>>    arm64: dts: rockchip: replace deprecated snps,reset props for 
>>>>> NanoPi
>>>>>      R3S
>>>>>    arm64: dts: rockchip: sort props in pmu_io_domains node for 
>>>>> NanoPi R3S
>>>>>    arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
>>>>>    arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
>>>>
>>>> How did you backport the above patches?
>>>>
>>>> ./tools/update-subtree.sh pick dts <commit>
>>>>
>>>> is the tool to be used, it should have added a
>>>>
>>>
>>> Thank you for the tip! I did not know there's such a script and
>>> I just copy&paste the commit message from linux tree manually.
>>>
>>
>> Mmmm, how did you apply the patch in your tree then? Trying to figure 
>> out how we can avoid this in the future.
> 
> I fetched the patches[1] as-is from kernel and applied them by `git am 
> -3` with path correction, then maually added the line "[ upstream 
> commit: xxxxxx ]" to commit message.
> 
> 1. https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fpatch%2F%3Fid%3D50decd493c8394c52d04561fe4ede34df27a46ba&data=05%7C02%7Cquentin.schulz%40cherry.de%7C72d5c95645ef4197c18908dd34b69565%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638724680973346196%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=urDrXWTzIt2NF%2BUrBSO1FnSTxjBO5Q4nYHFU9i%2BRII0%3D&reserved=0
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fpatch%2F%3Fid%3Db5bf84206a5c77528f9dd4cbca4e72caa063c102&data=05%7C02%7Cquentin.schulz%40cherry.de%7C72d5c95645ef4197c18908dd34b69565%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638724680973368900%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=x4CksM87w51QxzlrqNqjKvpQOJ6KKmSFQ01hoWmiCyg%3D&reserved=0
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fpatch%2F%3Fid%3D82b2868937883b65732da498b26366d34db61510&data=05%7C02%7Cquentin.schulz%40cherry.de%7C72d5c95645ef4197c18908dd34b69565%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638724680973382545%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=qyjod1yP7k%2F7bhjfHdZqn3LqettTPI41duikY0NRveg%3D&reserved=0
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fpatch%2F%3Fid%3D17e150fdd983c7e59b9240e34a166285f3c3fb39&data=05%7C02%7Cquentin.schulz%40cherry.de%7C72d5c95645ef4197c18908dd34b69565%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638724680973396320%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Zv7tjHe0VKKp%2FuIBFu5zrO%2BusEVjm%2F3lJ73jdaTmVuA%3D&reserved=0
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fpatch%2F%3Fid%3D1b5365034410f1ca21adadadd492b99bdf4f2c55&data=05%7C02%7Cquentin.schulz%40cherry.de%7C72d5c95645ef4197c18908dd34b69565%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638724680973413639%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2F3uw74TSfuoUpOFkfJPLWzKjoh331Y5RaPvEa4DrDs4%3D&reserved=0
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fpatch%2F%3Fid%3Db7cd1115456d312f8c5e60c80fdc35fd35ea6eab&data=05%7C02%7Cquentin.schulz%40cherry.de%7C72d5c95645ef4197c18908dd34b69565%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638724680973431321%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=pFych4CEp7BfolVm1KMGk828MIkCaMRNw8hCf7p2ldI%3D&reserved=0
> 

Thanks for explaining!

>>
>> I'm wondering if we shouldn't have tooling in place to detect when 
>> things aren't done the proper way (for maintainers I mean). We 
>> **really** want to have dts/upstream be upstream + some patches that 
>> were already merged in devicetree-rebasing tree. I don't know enough 
>> about subtree merges that Tom does when updating to a new tagged 
>> release to know if it's actually safe or if the possible mistake made 
>> when applying a commit by hand can persist without us noticing. I 
>> guess a mistake made in a manually applied patch would be caught by 
>> Tom during the merge from the next release with a merge conflict, but 
>> then that's pain for him to debug.
> 
> I'm really sorry for that. All of those commits were already landed on 
> devicetree-rebasing tree so hope everything would be fine.
> 

Nothing to feel sorry for, we should have caught that before merging the 
patches, so the blame is rather on reviewers/maintainers :) If someone 
made the mistake once, it'll happen a second time. I'm glad it was 
caught now, so at least we're aware it's a possibility and we should 
either be more vigilant or write tooling for that.

For what it's worth, the documentation is here on how to cherry pick 
device tree changes: 
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

I'm not too sure if there's tooling we could write to check that the 
patches to dts/upstream, were done the proper way. I'm not sure anyone 
wants to touch the checkpatch Perl script and that would still not 
necessarily be run by the maintainer(s) when merging (don't know what's 
the process there). If merge requests are always coming from a GitLab 
tree, maybe there's something we could do from GitLab CI for any change 
made in dts/upstream/ subtree? (like remove the commit, reapply the 
patch on its parent with ./tools/update-subtree.sh pick dts pick <> and 
see if the commit log and content is the same?).

+Cc Tom for at least awareness, hope you don't mind.

Maybe I'm also making this a bigger problem than it is as I am no 
maintainer :)

Cheers,
Quentin
