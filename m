Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA5EE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88DF0805CD;
	Tue, 14 Jan 2025 15:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ga0QZNM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4B28060C; Tue, 14 Jan 2025 15:04:41 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E1F8022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewJvkQV+jIhBPsuwdAt/80greVHiNPB+MRxCg1gzzzz4rWBQqJxf/BJEOEP5rF36vaNYMBeqQOLo5cw6+w+R52ZWyLlJoMXOBgq9Pf6/RW5H/MtNwmKyhfI3/dfZBv+J2CA7HBg8R937Mt5n0K53kP9oKVL7dtG2phftteE76ItFJfisVvc4L9gqVEpdplAyR/21ID3PFdZ95OAW6cuhG/tgV3A/4eFM3Qi0/V3uKMJir3JLA46SIuxv1R9UyBv5pvdNVGvaNeaToqihI/6EDifwf6azgyLjZDVW6KiqzRCTp3kvZ5PJbV35VUMuJLrj0gy/bcybaLU220y1Ubif8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rEYiu14WplZrqPakrzsy34R6ntBhkSU6x0PwSCabQw=;
 b=ALW9hpv/RjQ3LSbv3qq1lfUp+dHkU/XtZ100iY8hMscQhQKclnqdYeu8mfQuwZFY845cFj6vkQYwtYq1WgvSWiSwON4y8Ca1KMfhPzgcnbEqT7txLHygWlC5rsCXvK84WMnoqo5HVpKg1pmBuUiZxoD0EwummVbW0wtsIXo2FKSl6EK5/zdhYwxl1oLF0azES3x8o14wrOhXfinpvP6ar4UnURvt0VO+DBkfAdCLnEDP19rv0wf2X3LXoxzuAtF7LPoP5VrED/89D4p2Q78VDN5T1BNB+WWtrk4vpxuOXYmxoVCJVbl+weRil2A1T1vzVUytyxq5mmkAbmPce58HNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rEYiu14WplZrqPakrzsy34R6ntBhkSU6x0PwSCabQw=;
 b=Ga0QZNM2M2K0gR9sDqZvMhav0K85dgh5jkbpDarP/PP0um5mZqIqsZleNYc/Tmx6RFJrYAne0DVCb5XyCq2qcQn75ANmO3yjVZk2vWa6euBy7F/9dFfhsoU9IjUMbcbKBFpbmxr164xhv+irwlbEahC55Ng7ef1yzvznVFeh9NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7106.eurprd04.prod.outlook.com (2603:10a6:208:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 14:04:37 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 14:04:37 +0000
Message-ID: <9771ea4f-f492-47da-a829-048a763f2902@cherry.de>
Date: Tue, 14 Jan 2025 15:04:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rpi: Compute Module 5 doesn't autoboot without debug UART
To: Gijs Peskens <gijs.peskens@munisense.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <cd71682e-33c9-4e38-829a-a540a53bacad@munisense.com>
 <CALeDE9P45GvLagdkkC-8FuT5Ee3ZWpMPa4+F_eizoPHFtJFSjA@mail.gmail.com>
 <42465da7-7616-4e31-a610-3d127ff1141c@munisense.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <42465da7-7616-4e31-a610-3d127ff1141c@munisense.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: def1ddea-68b7-413c-27bf-08dd34a4619d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enpJdjMwME40U0V5QldITFQ2Y0REZERZOE5iQVVsZU1ZVkt6aUpsLzREZEVF?=
 =?utf-8?B?N3dpaEZRVnlZRkNRR1dDM1RhWDlBQ3ZWWG5vZTZpM3hrRm9VVWdBK2NFVXZx?=
 =?utf-8?B?UWMvT1BIcy96Q1FISGU4UUNBbkd2NkVOdndkaStTaHkxWk9XOCs2ZmpQRUxP?=
 =?utf-8?B?VEdGMkVCaDE4Zkw0b0VrZ1dTdlB0azlYRHJUK1o0cVd1T3hOVUpkSXlJdWxX?=
 =?utf-8?B?cUtpekl4SjNCWGFCNitEQXZIUFNhNGpRMzB2ZmpXZDdUNGRKUUVyeTA0Skls?=
 =?utf-8?B?YzlJbXA1MDY2di9HTnBWdnB4QlZGTC9IVmd0cDJTYnpGaVdNbFk4VjZqVDNn?=
 =?utf-8?B?NG9Fc1QwYzFZcklYVjZFSVRuT2QzdWRmV3BCSGltV1N1L3hwYVNXdHNkbGFr?=
 =?utf-8?B?TWp0NldNaEx3eU1qaUFXb0lQU2VneDBsT0oyZEhObnd4a0ZoS1BwT1ZZODR5?=
 =?utf-8?B?amFlMW5xdTMwRlBnSjFkMHU0SW9zZU1XcnBEY3hMRGJlWXVPOFBUSkdkakVm?=
 =?utf-8?B?K1Y2RzJhczFQcTZtQy9yREp3WndrNU1zZXlCQmVSTFJidDRXNjlHUHlHdnNv?=
 =?utf-8?B?amNKMmxDelhocWpLeGs3UHdMNkxGQUhyc0lGcHpzWi9MTXl4U2hrcmFGbkhk?=
 =?utf-8?B?Wk9xdHBRZTNwQUlHVzduR3lyZTMyb2VqSlFpQ3NIc0FnWStLV1VZQVRHNHN6?=
 =?utf-8?B?K0o1V3lNbkZkWTlBdmFKbjZMWVd1Z2FMd2lYMUxLTHVFVTBxeGpuZlFCRzNG?=
 =?utf-8?B?OXFIRkx0ekY3d1gvMndRZDNTVTFVSjZPNjg0dDRDVkY1RThIdVpRTlJPT09E?=
 =?utf-8?B?a0xYQlhQYVJidUlxSDFPZzQ0YlJmV3FBYkkwQ3h5dmExVEJiK3I5cnJrRndT?=
 =?utf-8?B?TTFjbTJLVEI4M29Pck1vbHdBMWtqUFEvc0NMWW90WVFUTko0YkxxL3JjL0F1?=
 =?utf-8?B?aGlSclcybnpSZHhKekF5VVVPVlRpeEY1V0RqSjBxMG0zR09LRk5rU1RTTW9C?=
 =?utf-8?B?c3FOelliRGIvQWEzQlhyM015aHBWQ0VtV1dQb09DanZ4UFlYTFRVN2ZhNzRS?=
 =?utf-8?B?WFVEQWxyZmhsdVpQeWpTK0VMazZseFlNV1BGSnY1eFNxVHRvMEd6b0c3K2hx?=
 =?utf-8?B?Y0lMOWxEcCtuR09ZeGtEdEdiVVRaYzV2RElZendFS0F0ZnhUOHRIZUdNbG9M?=
 =?utf-8?B?Y05BeU91VnE4Rm9PMXFVSGFOeXpjazFQbUdLa0lMdDRRSmZNQUVybzA1WkJO?=
 =?utf-8?B?amc0cWRWTUlMd2RVN2VkU21abkNzSTBVN1FVQXErZmZjNjU2NmR6eG5sWitG?=
 =?utf-8?B?RFJ2VWhyand5VVE2RDM0UjNlNk9oMHhPT1FGeEl5MjJiT05xYmVzLy9WbTRP?=
 =?utf-8?B?eWpyaFBuNysxNzl5L0lWTzlBVG9BUE5HUXlTL3VQRFB2ODd3WkpEbXJOOGs1?=
 =?utf-8?B?SmVvVjRwVnNkZUJhdEJiUHAwUjhPT3JvR1d5UGNFU3hQZXlKNDNNYWVOZUpq?=
 =?utf-8?B?YTBLR0FDYk1GZjgzOUphb1RhTFlZZDVZMEdtZ2prMHk3aUNGTkdjL2RydlQv?=
 =?utf-8?B?NmhmZEh3bUlWUHo2cFZzcTBicGdCb1ppNlI5cG1PM1JsQkpXamRKN243MElO?=
 =?utf-8?B?KytSTDF2Vlo0M05DbTBDcktiQUU1SWxoSTdBZnp6ZFUxT0k3bjdZUzRYaUFk?=
 =?utf-8?B?bnc3dzBDeU5VWUI2YVlSYy84MkRRbGk5Y2ZaZEZEeG1vRkFzNVdRc1lmeEFC?=
 =?utf-8?Q?qJHbjcrZxHxgD99/oUixvVb/gvK31iifUtcHIXh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlVmVndvYmlySmE1VEhUaUZDNmFSWkxFczBzd01icjl2bm8wdWhCL2kxM3Zh?=
 =?utf-8?B?czFZNmhIT20xMlUzampTSTVxUXg0R0o5eXRPN3dpek1YSDVLeDVlNThwaHI0?=
 =?utf-8?B?Uk5XMENZM0paRFhsUWVzTVJKK0pRSEV0bVhDNnFIMzBHNEhGSTlzamZrNG9t?=
 =?utf-8?B?R1pZUW1CU25iVDQzWkhTYzdUbngzNTFDWDVGRXJtYldMT0lITDZLb0pxQWh3?=
 =?utf-8?B?LzR6eXU0SUhuZUZkNTRlS2ovWjE4RHBRQnVtaGRxL2QyNWZFMjBHbUNBRWRE?=
 =?utf-8?B?V2lObG8wcG03MnFsOHNGelVVSEF0SHlFNURnemJLZEQ3Wno3eDBCenB4WUha?=
 =?utf-8?B?c0kwQ0hzMW94WitRWEdvWFhFZ0RiazZ0Y1ZSVFR4cmxqSy92NG9uNktIYUhJ?=
 =?utf-8?B?UHhjdnJkeElqZEJQYjllOFVabTRQT3pUNG1JbnVlaHFQVW5URGNRdHpPN0dL?=
 =?utf-8?B?ODNwMDFmdDZsSXZlaGJ0by9WVnJOczcwdzlSYklLTi8yK0kyOXd2ZzBhZ2xT?=
 =?utf-8?B?RDhrcWtPWkh4K0tCbmpMS0dRMTdqaVBmYS9uYXBYaitVK1pxdkVMSXc5RXJv?=
 =?utf-8?B?TVZLQkQ4L0VoM1oyMzFrVkpTMDRuRlR2ZVU4MDNaeTdhRUpac2tkdklXS3NY?=
 =?utf-8?B?VThKNk9zS0MvU2w4RGd5ODgvcXd6UWtXTzBQMmQydHFwNVNGZEpSQXZwTWxS?=
 =?utf-8?B?eEhac0lFSHU0OGhrNVhZT00yb0szUXZ3aEllZW0wYWhGZThtczczajFlWnAr?=
 =?utf-8?B?WGVZMmFDeDNUWDk1NVcrQis2WTliK0NtY09DMTVxWEV2bkhZWngrbVRjWTJU?=
 =?utf-8?B?ZkprcldqbVlzTk02SzdpTmkwNURvdnl2NVdOYTQ3ekYxcTB0VG5mK0tvVXpn?=
 =?utf-8?B?dndHeDBsUExQbFB5VThrV3hpdUoxV09SZUE0SjFCVEVhZSt5cU1oQi9Bazdm?=
 =?utf-8?B?bmNQclZ6dzAwbDkrODBkT005RVB1Zktpa3FVdW56Q0JKeUFya2YvbWdVblFY?=
 =?utf-8?B?UmtUTi9LUnlLbzdOSnRFaHc1ejk5aEV2OWN0ajVCallXNWxqUzZGa1VyUHlS?=
 =?utf-8?B?NWVSeHVMT05YbEZHL3k1S2JmYWdWaXVweTR3UDdPQjdrVFBkRnhyTS90U09Q?=
 =?utf-8?B?VzRMblpuZ0J3NDFXdGZDbzI1ZHNybzJBcytkalMzcnF1eXoxbVhiL2dheXpL?=
 =?utf-8?B?d1Z4cUtxTjlpQjVtTXdYMmRuUWFwZXBuL3BxbEllNXBwcUI1Uk05VEJxd0I4?=
 =?utf-8?B?UTdkK0dHQ1Y3aHFnc3k3Y21IN0EwaGxrV09vTk80SWpLdzJ0RUswNFhZYWpC?=
 =?utf-8?B?YjJQN3hmMHlUVFM3NDZFcEp0T0NhMDF3eUR3YkJ3amN0anZUSHNYRkN0bUk4?=
 =?utf-8?B?YnA3Ymc0OFc3V2cvMXJ4emVlQnZEQzRITlhyaWVFWTIvTUdRbFpjMHZFMzVz?=
 =?utf-8?B?TGtzM1cwUjdVZi90SVFIZGxETlIvcy9hbWhXblVraytleWpMQ05xMzVqUGt6?=
 =?utf-8?B?eE1HTkFxODZ2SXZDei9Kdkh0OXp6a1RxcElPcGdHemVHM3ZCQnFNOTlVVitU?=
 =?utf-8?B?NnlFWE9CZVRKWVpYVDRqbDkzRUYwVUJxZTBCeFdud2IzUWRUZEFlaWZVdjdO?=
 =?utf-8?B?S0J6SHdSNjlhdFRFdnRxQktacGpXODBublpzQ0dIdTRVTG55WkVORHpydkZt?=
 =?utf-8?B?OXg0QjdGZzNTamtqOUpyaDV5bm54OUJqV0FqSG1jSHlqYk5RUmY5L1lweXFx?=
 =?utf-8?B?ZEFIWWdOQlgzTHZKQldKdkJHaFdta3VzYlFDUWZHY3dHL01MNnVHSlJKSjRR?=
 =?utf-8?B?Y0ZRVXZZWitYY0VpUnFLUFk5UGdmaG44U2V0Z0dMbHJuamYxcGYwNis3MXRM?=
 =?utf-8?B?eTJIWkpjNmNyZVRjSTB3NXFoYkowVURkNTA2aGlrMmRvY0NVc2t2VWVOSmdv?=
 =?utf-8?B?bzZNeWx1SzlBeTNSMzBGUjJpNkNwbUlIYlEvdC9zQld3K0hPTDA2bHdtV1B2?=
 =?utf-8?B?dmd0NTFRZjE5UExuNEl4dElLQVZVQW15RTNhQjVIMTc0TEJjSXBMZGoxck1L?=
 =?utf-8?B?c3pDNE01OVNUWVF4ajZEMDBOOXRlcFZHQU14WTVQVzA1VDhreHBIQVlRa1Zi?=
 =?utf-8?B?Uk1IdTBhNVVDK1RpaUFhNFFhb3A3Mk03OXdOTWVDNU1JYzBtVUhlcnc2ZVZX?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: def1ddea-68b7-413c-27bf-08dd34a4619d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:04:37.5415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Pp29vV50lXCo8cEsvgdcpap3U+hpEY4djdkLyIXuZ5dIR76P4Hob9S+63BsPeI3vRjRFKyNC7vk/B2XfBEuA6an61JK/VT6Mm9885T5fBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7106
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

Hi Gijs,

On 1/2/25 3:07 PM, Gijs Peskens wrote:
> [You don't often get email from gijs.peskens@munisense.com. Learn why 
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 12/31/24 15:53, Peter Robinson wrote:
>>
>>
>> On Tue, 24 Dec 2024 at 14:00, Gijs Peskens
>> <gijs.peskens@munisense.com> wrote:
>>
>>     I'm working on getting a compute module working with Yocto using
>>     U-Boot
>>     as bootloader, which mostly works thanks to previous work to get
>>     RPi 5
>>     working.
>>     However I'm running into a strange issue: if I turn on the CM5
>>     without
>>     the debug UART (which requires soldering a header onto the CM5)
>>     attached, the Pi doesn't boot beyond showing the submarine splash
>>     screen, if I boot it with the console attached it autoboots 
>> correctly.
>>     If I attach the UART after the boot halted and press enter I get a
>>     U-Boot console, and giving the boot command boots it normally.
>>     And setting bootdelay=-2 in the env allows it to correctly boot.
>>
>>     Which leads me to believe there is perhaps a spurious input
>>     registered
>>     by U-Boot which interrupts autobooting.
>>
>>     Is there a command that allows me to extract why U-Boot didn't
>>     continue
>>     autobooting?
>>
>>     And anyone have a hint how this could perhaps be fixed in a more
>>     elegant
>>     way (allowing interruptable autoboot).
>>
>>     The hardware I'm testing on is the CM5 devkit, I needed to make small
>>     changes to yocto to get it working:
>>     https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Fagherzan%2Fmeta- 
>> raspberrypi%2Fpull%2F1397&data=05%7C02%7Cquentin.schulz%40cherry.de%7C7761da6784444fc601c708dd2b36dc7d%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638714236816045296%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=lvd6ywVVIfRlzcOYxKoMBrimT20rumG9hWD3VWZDkbE%3D&reserved=0
>>
>>
>> I don't think this is unique to the CM5, I've seen it on other RPi
>> models, I have a RPi4 8Gb model that exhibits the same behavior, yet
>> other RPi4s I have don't exhibit the behavious. In the case of the 8Gb
>> I have a USB serial TTL on it, it boots if the USB is plugged in,
>> doesn't if not. I have other v4s, both with and without the TTL and
>> they boot fine, I've never been able to get to the bottom of why.
> Can you try by setting the bootdelay to -2? That did fix it for me,
> though autoboot is no longer interruptable.
> 

I'm wondering if this couldn't be fixed by configuring the pinconf of 
the UART pins so that a floating line is in a stable state? e.g. a small 
pull-up/pull-down? Is this possible with the way UART generally works 
(i.e. is this going to work whether a console is connected or not?).

> As stated, I suspect my CM5 is generating spurious signals on the debug
> uart when it's not connected. Is there a config option that changes
> autoboot interruption to only happen on a specific key combination? i.e.
> control+c ?
> That might fix it sufficiently for me.
> 

You are looking for AUTOBOOT_KEYED I believe.

Cheers,
Quentin
