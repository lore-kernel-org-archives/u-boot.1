Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BBBC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93E787F19;
	Mon, 12 Aug 2024 12:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jPfKiEGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A00886BB; Mon, 12 Aug 2024 12:47:04 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1523874AC
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHQ2A39XMx34sK8pQrB1zn8Ru/G0cGXv9HIrtndGO33p8xc7AQSxMLTslfTAOgx++HnpT9kvFotxLCLsyiSUu43HO5XzmBV45ZAGhDfGvkF0l00p629AEzPB+wcUQeB2G+5ripbId1vwxShBSmlnJzNvLEcUjPyS5YA3cDgbToToGJ1J3zALucVTrgTANci70yWpB7TRdO5nP6DjXuZsQ2UDwqs+1PGtPKrzBXD/SYPPWs9aaTm9E2chiGU+of4gQ+4FeJEXclAK4aNPsFbvEcK5gAmr9Vfxznc6mbudXcLOoy5VIn+mjZI1olXrM2JyxkkypFCEp4TljWW0f2Dslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKf2zMa/VkmT50lyPURaDknDyQqx4S1NVTs6GsdMFKU=;
 b=b0KkH+beoTTy8mQ5O0WopoRMbbWpTdheqAxJ52oJ3QLeMh5C80U50XBfIWJWd8WkM6rQLqrM62MIX948NY6JyFx0s7DXSPVAxhiHFAYr91lQTZS+JA9y2qP15kVW3x5Ww1tknR2yWDHi4KDuegX/iNaorHuapGtoDZNHZrRu+RZbpXt3NoW6y7MkY28020VG05srnC0OhAjvV0BvfWxGFCuUWwLfSsNnb4FUlAVCp3LJozUmGLAk8f7hcQE193/65o7U7zWBH0hHH9VSbn+HzU7mWkFI8c5hfCWPh6voYgpZlLkKsL1gpW9jRW+l5TovwR3ZJfHt9iBRCZ2tL5vL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKf2zMa/VkmT50lyPURaDknDyQqx4S1NVTs6GsdMFKU=;
 b=jPfKiEGvX/18L0YBApvfCb1KOUwgiPEBsB+N8pGE++lEVJ/lLwLYwx0Es8IWPJiMRiTgJYIW9M61vwCcDZP93pHxZZ8QWKw7T58ZwwJNxVMt+1lPzxF9M3AG7onRYgPy5MX1nHU0EyLQpPvK0kdqBgo7RlLiZN/q9RF22OsW+c8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 10:47:00 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 10:47:00 +0000
Message-ID: <d01d1f50-77d9-4d3c-8494-15f16f9736ec@cherry.de>
Date: Mon, 12 Aug 2024 12:46:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] board: rockchip: Add support for rk3588 GenBook
To: Andy Yan <andyshrk@163.com>
Cc: Dragan Simic <dsimic@manjaro.org>, kever.yang@rock-chips.com,
 jonas@kwiboo.se, u-boot@lists.denx.de
References: <20240811100255.1664095-1-andyshrk@163.com>
 <20240811100255.1664095-2-andyshrk@163.com>
 <04ce9048d54f6d68a46967485c6ccb0e@manjaro.org>
 <6d73380c-d554-4c33-841d-1f6c0c025b7e@cherry.de>
 <20861389.8bc6.19146089e81.Coremail.andyshrk@163.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20861389.8bc6.19146089e81.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb1203c-fdfe-44b4-c145-08dcbabc1811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2VDVEtqaFZ3S1J5SG5QK1I2c0VKb1d6QTZJdHhvancvMVFtcXEyWVVIOWl0?=
 =?utf-8?B?Sm9IZ2Rld1h5VGFZVVlmTjhvSzVBNkpwbzIyejhVNWhWbGF0cnBVTGhFNDVD?=
 =?utf-8?B?REJFdkJESW10K1JpRjRVb0hKZ2VCWFNOZmRYNnI4UHd5SldVZmpYbWhkRWpz?=
 =?utf-8?B?YjVybUZCaTlsbkhVOS9HSUVyOE1TQVRIenpjamd5UGFkV1VPaGFVUHpyeHB5?=
 =?utf-8?B?S2dpRVVmWmpjay8ybmlkaXQzaVhYckJuYWJ6N1Q5UjRoMGtqL1Vsa3dMbGdV?=
 =?utf-8?B?d3hHNTEwY2dvUmU4UWM5S1V3eEYySnpaUDFFVnRoOGR4VVhkOWsyeHlSMyt3?=
 =?utf-8?B?Rytjekc5RGhNbDlrdTZSV3NGSHN2aWM1WUVuMGREOHUrR0graHUzT1p5L2hD?=
 =?utf-8?B?U0hjTWdNTG9raWErU1BrM05UcWl6ZmNYRXk4cnFFekZZUG9FTFhqT3VNSlU2?=
 =?utf-8?B?MENHQVdONGRoTjhkcStYa1lMa0svd2tCZEl1YlZBTkk3UzZKU2o1eEVzSDlP?=
 =?utf-8?B?WXhGSFlLTnRPbUNyUEtSakN4SlZxTU9pN1JwYzJ3Qm90RDVCckx3SHo4RTFo?=
 =?utf-8?B?WmlWc3lWczlWY0hYaXphNjU2MlhJdkMyejVTRkowWnFxK2JOcU9pZnh1dW1I?=
 =?utf-8?B?SHVhVFpWVitlMGttSkRmS3ZpaTlKSXV4V1MvMVB2NVh4TlpubWhBa3lHVTRP?=
 =?utf-8?B?MG51cC9tc3NuMUo3UXdudlUzNSs3ajVDekFIN2Z0UW45UzQ1ODV4cnR4cnJs?=
 =?utf-8?B?R2xnU1kwemh5WVphWGd3V0xoZzhPdkZva3dVbjR3b0V0dSsyYkJtVlhlclFq?=
 =?utf-8?B?TEo4ZXZuZkJxSjhqSUZWUkp6bUtPK1I3UThSalg3elVvRkpxNlErT1pyamFX?=
 =?utf-8?B?UVlhdFVkMkQxZnlEdjlMUHloeUNzLzRyNkVqVGdTZnlDcE9MQUxOVElHMHBv?=
 =?utf-8?B?UU4rRXRSb2I2TVhQRisvbjNFUzlBL0hHWmFrdWRZWWU4UnZMSmdPVXJ4UXRj?=
 =?utf-8?B?amFxNTdDSG0yL3drQ2wrak1GT21HWHpZRDVuWWNNdVFDcDFwdWdBaGM5WGo3?=
 =?utf-8?B?Q2ZUYzJzQUVGaWE0TGJ2Q2ZRZzJYcWNXNFA5M0pJNjRUMXIrN20rd1QycGVU?=
 =?utf-8?B?eTRsbFlsL0Q1Z3oxOVhRRDNZWjBBV1RNNHVHbHZEL1ZBL2VEeXZDbVRsZ05G?=
 =?utf-8?B?MjZreWFxWW1JTk1NMkY3Y1hVd0cxYVdWaXFJSUhMb2NZTmsyc2Z4WEFyS1RD?=
 =?utf-8?B?ZGpEOG5wMENiNEtRSnE0ZzN1NjJ5eDR0UldRTkd2OEZjT0NaQnIzMU9BVnRm?=
 =?utf-8?B?WC85Z1k2d2dJRzNodDhla2E2Q1B6TjNlZHVFRTA2UjNOOWcxcmk3czB5MnJ5?=
 =?utf-8?B?Q0M4dTFWeUFIaWdCYkkrOFFkbFRaQmRMdzRKNDhIMmUvbnBwS240Um56Tm9U?=
 =?utf-8?B?Tm1nYnJRVUlLZU1FMHJybnlVejgwd2xrK2lIT3BsMGJKU3U0amdJOURNMFBZ?=
 =?utf-8?B?bVp5ZFdlZDhLUU5WRlZZQk5MbUoyWDZzMnprZVN0anJ0cjgvU3pxQ25Kbzdk?=
 =?utf-8?B?QUlKSmJNcDB1SFpjeGw0NzludGh4cDFxazNnV1FoVjBwVENlcStJbDRibXhZ?=
 =?utf-8?B?dk44R0dFVk1qM2RHQ25FQkJxZ3F1d0hab1VIdThmRmJ0YzZZcnhTcVFxSzlC?=
 =?utf-8?B?RGV3ZTFjYzdPRjB2SmF0eFBYVEU0YVc4bmoxUzF3a29BQXVPN1RvaFJOOXd5?=
 =?utf-8?Q?+sVhBdJxzHt5u1h8Qk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmw5ZnNUOTRrZmRscko2R1IzdEhyRXd6Z2NKTDdYVHg5ZkRqdnhwbVpnbDF6?=
 =?utf-8?B?VmFsdnc2eks2Z2RsTTFOQU1DTUFicGtLTURUYW8xUVQyMU1VQmlxVlJzeFFa?=
 =?utf-8?B?SnZNUm9BUkhmS2NIQkM3cEZ1REtmbVZsTEwxQ0MvaTFmVDEwL2diUllBSFhy?=
 =?utf-8?B?b3plc2dqb25lZkJZaGZwZWxYWFhFaXQ4TXN0Nmd6MU5SWmw3VWtNeFVNYVl1?=
 =?utf-8?B?bHkvNkpqS2VzQ1phVHlPblVHa0RpQWZUNGo1dzlxb2o0ZExLWEdjd3M4RWtv?=
 =?utf-8?B?VkhrSS8xeTRWRU0ra0NXY3g1SS9mK0s3SnZxTFRYR3NXOWhZYTdKNkYzUUQw?=
 =?utf-8?B?a3VibFhoN2FqNVJTbG5HdWdYTjNPbldoVjI3Ky9HSE1XWEQ3eXBaM0lHbnNq?=
 =?utf-8?B?ZEdUdUduUldyYVdtUWhkV1NiQURUTWs5UUM2UEtVQnNoT2N6Z2d1ZGQ0MmI1?=
 =?utf-8?B?VzJRazJGbzVJNmpWRGpoMXp1SmVwVy9qdTR1VHk1OGU3cVJxWXRmT2VxYURT?=
 =?utf-8?B?dEcyUFZJZmY4RU9Ma0lqL1lCQXhkVWtFSjJpSjVrcHVuYmpGbjVVMUhrMFFa?=
 =?utf-8?B?TWQwUmJWVWR3Y1dDTjdTQlVMR2VYa25ST2tWRkxIN0xiNHVmZ2FDbTRrbjhk?=
 =?utf-8?B?eXphQ0NIUTFwV2VDd3dGVGxJSm15cURCZUZYU3BuRWU3K1hJSnlGVkxyZWJJ?=
 =?utf-8?B?TnBCaWprUmhFSmxFem1CM3FaNEszUmZRMXM0U2UrR2hCUnhESmkwNDYxZk44?=
 =?utf-8?B?dE9ZM2RhSGEwR2loUFNoWWpSaGw5ZTFDSHM5UWYyQmZHSGZ6V1l5ZzZLcTJn?=
 =?utf-8?B?a2xLL3JlTERyZDJ2NFBjMFdHUVI5TWJTYTRtTlA4K1p3VDM1VDRVdGd0YStF?=
 =?utf-8?B?b2tENS9zMnZzVTB0ZkRpZlFYUGFuZm1aZ0Z1RzdFRWxtMk9GZGszb2pGemxo?=
 =?utf-8?B?Z0dEN3ZFdGNocDBIQStpQ09zaC8wVFFWZ0h5Q0F3SFZGTUZ6eDJCcVN1czdw?=
 =?utf-8?B?WEtDY3FYNzJVSFBZZHQwTXc4a0hSSVVwcEhaRmhVWUMydzFSSGJ2dlZCc3hk?=
 =?utf-8?B?bEM4aHk4N2dIejdPSmRwS0g4SE9jKzdIVSszbEphbDVHQlRIOEtKY0hDVDVi?=
 =?utf-8?B?QWxFNC9QeDVBTjc0WG9KSGlGaVFkVW1keWZEQm9WNk1XYVgwWVJJUkVjZ0w1?=
 =?utf-8?B?TWVYcmtSYzh6c0xkcGlFWkZiaU8zbUJKTmY2aklTSm5GOHZQMjVqSzNxeGlY?=
 =?utf-8?B?Z0JrVC8ySVQxalAyblMrUDF4MW9nZTJ5eGxMcGo1eWxjRUxnNE93MmFPZ0E1?=
 =?utf-8?B?eWlxcnVkRTFMV2hOWTJNejNyNHlOY2JqbU1wU3lqZXcrcGk1VHp6ZzNhMnFx?=
 =?utf-8?B?Qll1cWppakdZa3BBckZnMFlEbHVCOS90RW5HRmNiNWVxcTBhT0JEVzg3YnRK?=
 =?utf-8?B?THRIeGFUS054YnpjL2lLYzRPT1BsbXVjWW82UXIzdjlBQm9MelU4RTRlZ29E?=
 =?utf-8?B?a1lORjhlQWdzMXdOU212RWh4R3VEbmtIRlFpQ21JQ3F5dFBVeWV3aVNzWU1u?=
 =?utf-8?B?U1hSeXZYQTBoM3BpLzAxL081UkZMby8zbm1CaENKc05aZmExbGdKV25jdHRz?=
 =?utf-8?B?cGxDbitIT1l1TlhDVEs5MzlOSFZHU3h6MFMwWndhUVdoVEc2Uk5XSUM4QTQ0?=
 =?utf-8?B?OXk4bVVpTmtndmZLcTJZdDV0ZjBOa05vV0xtR2EvTzllSHZqRnNCbEgvOC8y?=
 =?utf-8?B?MEJUcVlybTFyWThsRDRYdFdJVnVDRThvQTJWQTRrZHVVdFpOVGliRnI1Rkln?=
 =?utf-8?B?WEY3Q2NMLzBkY0VXcDNKNnlxa3ZIMkw3QyszaUNVZkJDQnc4NGRWakFSN2pP?=
 =?utf-8?B?aG41S3NSSDc1ZndMUk9qV2RCaXdtMjV3ZmN2ZnVrMlNJekNiZzZaUzdGTUY3?=
 =?utf-8?B?emVsY210MERvbXg4NUQxVjZnVXF6SHJxNWN2THlkNCtZb2gwZDFtVjMrNkV3?=
 =?utf-8?B?VkpiVGZsV2F3bGpLcHBBZHJ4K2NSdmJzWXgwVHlkbTdIaXdNbjdzV1ZhZ25u?=
 =?utf-8?B?bmZtTFkyUVdQV2drNmxncU9tdUxlOG5GNWZaQy8yYmxrL2dNQm9mekV0TlVL?=
 =?utf-8?B?Lzd6STYwVkxzdGtHVStFN0FCdEVsbEs2WFJrcHZRU0FrZHVMQVM2dXNCaWV6?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb1203c-fdfe-44b4-c145-08dcbabc1811
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:47:00.1077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1qXhm4cp3W0pY2/D/O+iuCUxL0xhxeSmkzJVJRg6Y4jka6bP3vBMruX41NvIcLtYR+fl0Ei8CmRJ/NRHB9BSd5+yV2F1Q2oIfjo9iNO8A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
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

Hi Andy,

On 8/12/24 12:00 PM, Andy Yan wrote:
> 
> 
> Hi Quetin，
> 在 2024-08-12 16:23:06，"Quentin Schulz" <quentin.schulz@cherry.de> 写道：
>> Hi Andy,
>>
>>>> @@ -323,5 +329,6 @@ source "board/rockchip/evb_rk3588/Kconfig"
>>>>   source "board/rockchip/toybrick_rk3588/Kconfig"
>>>>   source "board/theobroma-systems/jaguar_rk3588/Kconfig"
>>>>   source "board/theobroma-systems/tiger_rk3588/Kconfig"
>>>> +source "board/coolpi/genbook/Kconfig"
>>>
>>
>> Order alphabetically here.
>>
>>>> diff --git a/board/coolpi/genbook/README b/board/coolpi/genbook/README
>>>> new file mode 100644
>>>> index 00000000000..ba165953154
>>>> --- /dev/null
>>>> +++ b/board/coolpi/genbook/README
>>>
>>
>> We've moved the READMEs to doc/board/ so please do this as well.
>>
>> You may only want to add your board to doc/board/rockchip/rockchip.rst
>> if the instructions in that file are good enough for you. Consider
>> extending the content if it doesn't, and if it's too much work, then
>> creating your own readme in doc/board/ similar to how Theobroma Systems
>> boards are documented would do just fine.
>>
>> Note that those are in reStructuredText format (rST/Sphinx).
>>
>>>> diff --git
>>>> a/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
>>>> b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
>>>> new file mode 100644
>>>> index 00000000000..6418286efe4
>>>> --- /dev/null
>>>> +++ b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
>>>
>>> I believe this should be turned into a separate commit, as a cherry-pick
>>> of an upstream DT commit.
>>>
>>
>> Yes, as a hint, you should be using tools/update-subtree.sh pick dts
>> <commit> as documented here:
>> https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
>>
>> You may need to pick more than one commit, that is fine.
>>
>> The commit id comes from
>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/.
> 
> The dts just landing linux-rockchip a few days agao，so it's not in the devicetree-rebasing repo，
> Does that mean  I should wait before it landing devicetree-rebasing repo ？
> 

Unfortunately, I believe this is the policy we have right now yes. For 
sure we do not allow to manually modify anything in dts/ directory, so 
the other option would be to have it temporarily in arch/arm/dts/ 
instead until it's available in that repo. It depends on Kever for that 
(if he agrees to have this temporarily) and also if you're really "in a 
hurry" to get this board supported.

Cheers,
Quentin
