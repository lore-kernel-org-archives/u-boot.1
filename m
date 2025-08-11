Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAFECA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 17:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5A8831B4;
	Mon, 11 Aug 2025 19:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QTjma1vN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6A183214; Mon, 11 Aug 2025 19:13:04 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7659183189
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 19:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqEGSCjA7+M5hBq7rIjU7jvV5BCEoJjiZf45oMeSmf2Xo1+WWfsjYM8KopBaLDPQbkF9wQmg89akIfxEfrBoiL374az8rIKqqIEuiruI/M0roTsIaZlQxJ5F8pA4XQTsb/h43Z2YPXfr8ZawkvX4a/rAPAebpcXf3IL1HGQyCFfWk7q5i3epdKe0mKEb7HiNYttKD5hUjbd/+GNhmuEkVlRLQzM4o/JlmlEJJlQRe+QtChBzkFZ3/M7e5aVwVHTrVd78nvatQHyOeeoi1cpwO1ZhHIc/1yoTxZFAVQGwiG1npymEDHibMRCU4HglIbq6c9w2gHKtG7guYT8Ryf6ONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLHFbgD0lcnfiyN89OzO5sotj23QpewCZGxagrex3T4=;
 b=Dfm7jcB+BR2oZ6yh0KLYye21b84WhvnTG6YF4fcbnRALtdNJme4CVij8wixq7eMvUT5U7/9mgjW1JOhDi/Lxei7UHwl/x2VN39MrsitYzFfAon++mpceZg1nPwyRqQ0aBixKyRY/Dqvly8o7OpiJTyO/pkTDNK4n2gR1t/abe/y7BF5gqlR4dViBEgDj61YLdzboPp9PRJIKvjL3ehLMJIbqXP+KhCzF+T3FkVy+ZTZUoFomCuvEi2goGeJ2zXEr99jR3pkF74NzY5JiQNAjuODsfe2ZxU5pow8FrNWfQxY+EU6BuIk7fcMSbSWzD5clscmAHBjb5AUmd+afB3YN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLHFbgD0lcnfiyN89OzO5sotj23QpewCZGxagrex3T4=;
 b=QTjma1vN+IdVKksTiKAMwCpDZ7g0hfQ8GMIzEAcUkwEAcx6R7XS88X2vAilvo85HI2SlQrlcLxYM/o+h666VAAuYoaJqCevjADtSIoFVRBNzUamVfRxjOk786OOGXabN4qyEqS9f6eTmR/4vz17Y6wpw5myziHOttCue64ZtFaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 17:12:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 17:12:58 +0000
Message-ID: <eaac9c8b-cd95-40b5-967f-ff96ef1199e6@cherry.de>
Date: Mon, 11 Aug 2025 19:12:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250810222644.4095072-1-jonas@kwiboo.se>
 <20250810222644.4095072-2-jonas@kwiboo.se>
 <1b1ad33a-3004-480d-9d32-3ea05e7eaf63@cherry.de>
 <f4babfd9-53a5-4af8-8b0d-813c61697400@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f4babfd9-53a5-4af8-8b0d-813c61697400@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 6370f495-d67a-4bad-fa95-08ddd8fa51cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rng0SEFaUkxVM3dJcVZQZ3hwNmU4SmZWd2o3NnJ5TktocGxzenl3MEwrSUF4?=
 =?utf-8?B?em9HWlRQdDlJeEhCZHdqUGdQOU5xMFVCeTBoZ05uanFkOUsrVWwyckpIUzVN?=
 =?utf-8?B?MVZ4RDNnaUpJbm1zWW5MN0YvMGkyUGg4TUU0eUNLSmxNaGJWU0F4cEt2MDcv?=
 =?utf-8?B?dTVsczE5OVNBVjBVTzM2TFdLR3BCUjgwU1Q2NnpTUGQ5Ui83Y1FnYXl5WGxr?=
 =?utf-8?B?NDBJZ1hOTHJwRU1GQWoxNitRRmZFRTd5NUZRK3VhdVVmdFRxY3B6d0h1Y0t5?=
 =?utf-8?B?US9LcVdRdDl1ZVBmeTZ1K2JXc2NkK3FVVFdZYktBSHdydURvWjI0UlFMSTlJ?=
 =?utf-8?B?N015SEJETGluemdPZzdWNVBESS9lcldGclZxaEFzTTR6S0I3aDlxMDV1dGVD?=
 =?utf-8?B?aTVZSzFKU1V4QU5NNmdhV1NiOFFIVTlHTGdUbWdIMFpTY2U2NlpzWTVURHZW?=
 =?utf-8?B?VVd5N3htTlVXTHVIa3E3U2JwS0hWenRQaU9weHhMcDZjbFluM3pRQmhOUWdC?=
 =?utf-8?B?NHlYQWFjU3VUdkhwRnVKWEJsVUpFcUtEa2lNOFQ5UjhOeGg4eDBaSUlOL3pI?=
 =?utf-8?B?NTFUUGo4emVMWmxiYktoUWh6V09lTG9yM3hJVzQ0a2VuM1VGSS9xMEJqYXpI?=
 =?utf-8?B?VkxFRmFmbmpxSTRXV0Y5ekhqU1dTeGRGUE1Gc1U1ZjRxcmIrMzVTaEJLSDJ1?=
 =?utf-8?B?d0FUMHhQUjFuMktFUW5qTUd0Y3M1YzRyVzJJYThwZFhpYkU1eSs3Wi93SVhj?=
 =?utf-8?B?a1c4MWNFWXUwdEg3cjhGVWFjVkI1YmdXZlc4aUlvTHFMUkJSYS9WY1RFM3Ix?=
 =?utf-8?B?SElYdEFkbTh1cHFwSWFkQWZNNitBZnBYVUVudHRTYkN0WjI5TEI2REJYQ1Jp?=
 =?utf-8?B?eTZFY2thdkhKZVNRTlA5dU1HYk41cDhNbEl6dmJrcXBPajVxb1FLMXVCUS9a?=
 =?utf-8?B?NmZ5Y3NXM2lPUHRpQjhieFByYS9NT0tSVW5BTVVGR0dnK0NCbDZ5ZzZtMjQ0?=
 =?utf-8?B?QzZzYUFCL0ttb3F1WEozeFpzclQxQmUrRFBoN29WNGIxeHhQVFAzTFkwMUdU?=
 =?utf-8?B?dWtYRXZGTGdJMGdpYjY1bDYxWXNDMnpZVDRDcDU1Z2lOYWh1Y2FMbFZJcEx0?=
 =?utf-8?B?VHhDdm1SaWRib0VMZWh2Sm9RejFXay9TelFoYUtTOW5Dd3psYTJWb1JvdnE4?=
 =?utf-8?B?UVZzazdiWjlUZ2Q0UGVBWDVZWitzaks3T0ljU2VUSzluYW1rd3BHd0VxcmFx?=
 =?utf-8?B?aE9kbFdNSFdlOHFIU3NWdVdCMm13N1dsYm9pQnBGWEZVNCtVdzBOV2RrR2pS?=
 =?utf-8?B?a1EwNGNycGdldk1XK2lObmlKamgrWlEwWlh5N0huVkpBeXFCNllxaHJHRzJB?=
 =?utf-8?B?b1ptMFg1MXFhVE9wQkJjUVdvTWFRdzJ5RDM3KzVCN3d6TkF3SUMyUlBpdnVa?=
 =?utf-8?B?M0dNU3JBMmZKWEpxNk9adGxzMk1kVmo2VlNjNTZiSW9KUG93N3ZZQlpDNktj?=
 =?utf-8?B?U3hBQmpBVXhHdi9JbnFBTnBxUUhOWmlUQTBFSVpjT0tVZGhTZEk5MTlRdXRo?=
 =?utf-8?B?YXlCTjFiWVB5VnhMSUp3dnl3S1JrTmp2YlRsQmNnVjJpeUpmZXhWM0tnR0Nu?=
 =?utf-8?B?MjdZUWhDSnNNYXRhVU1UdFZlVG11R3lOWVo3bDVyNTJlNmF1NzBJU1pwZUhr?=
 =?utf-8?B?NFk2Sit1YmxWK2gwSDh2Vzdzd0czWnNwb3NTMG5YVmdQMDNyRk9PZzFCeWpt?=
 =?utf-8?B?cEcyaGRkV1VEaCtxaERxblpjeUNXQU4xZ0RaNEFuWFNxS2dPQWVCVkFTeXRp?=
 =?utf-8?B?YVRNVGhIZ1ZzNm5ybXdrQjhkZUNST0ZlWG9Bb1lrczdwb082MWtBY1Q2bTBx?=
 =?utf-8?B?b0VsMEphVXlvM0U5ekEwbEJEd3VITyswUmFwalcwbmo1UTlzWHhVajN1V0pT?=
 =?utf-8?Q?zdj+2kXKwfE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJycVZUZFo1Mm95Q1YyZ1hpR3BLRmJLVG5GWnhDTGZxbGc4aWJ2TDk5SVVB?=
 =?utf-8?B?OWZ4SlBJcGZKSkZScDRzTjRra2FEY0MrUUsyNG5sNmVtMnBQeDVkRzUvUng5?=
 =?utf-8?B?S1ZwU2xoNlNvRnRwQzdadVIyajN6SlFkbDhPZTU3eW16VlNwOFp4RmZJZUNL?=
 =?utf-8?B?M3NGNXZSalBZQmVrTUNNQnltVFQwajVldHRoUDdvck1uZE9nWkcrU3FpQUJH?=
 =?utf-8?B?S1NoQUNVTzFlclFud0d6cS9udzJMVkcrckFpNndYaVNMVWgzNGxtaWZocVdh?=
 =?utf-8?B?L0hwNXI3ZU5tTytSdkNwK0tMVmlwWEZWcWJtUEdYVDZ4RWdNdzlwY0RiMTJp?=
 =?utf-8?B?RXdoSldTMDFWSVc1VWFlejJVN3JDK0NzK21NVmROZEZ2WXBmazlTYXhTTTdk?=
 =?utf-8?B?SE42Mm5EZ1F6ZVNpWVM1RDRpKzlIY1YwOXp5d2lNK3VIeWlSS3luOFUwNFlp?=
 =?utf-8?B?M0JLUFY5ZlBxbFV0UnJmam1TOXdLUmdHQXoyL2ZJOVBjQS85RWRrS1dQUTk0?=
 =?utf-8?B?NDVGOTR1R29sdnR4TWpoTFB4VG4yZ01iOGhpUG81eWh2SWIrYzMrUE55Ni9C?=
 =?utf-8?B?YTRGUjZMQzg4ckhCUi9YUUY4U2ZPbnlIVVFONk5DbTgzTFU2VFJhcFErYk1V?=
 =?utf-8?B?NXpXR01xZ2VxbE9ISjc2TTNVNFM2TnBsQUlUM0tweU5LRUcxL1hQck9YMXVl?=
 =?utf-8?B?QVdrSlFoT2VTcHJQZnJua0UzVEZFRUZCWG1XM0NGYTZ0MXl0cERhV0dOQjVv?=
 =?utf-8?B?Q1JHTm9lZk8vL0I1NVYrc1FoSlZpUDJneWpSNDRrdklrM2huRUMyWmVRa3F5?=
 =?utf-8?B?RGdYZHhkQ2RrR0V5b3E0d2FQZ3AzUXhod2pnNmJBZWwyNzNOaFJPYVlsTWlt?=
 =?utf-8?B?Z2VMcldkY3FCNkpEaW51V3N1a3BaRk9NbzROMkNGTmtjQ2p2ajZYb0pDeldJ?=
 =?utf-8?B?U1hsdThkOFVFZzZJWDJleTFkd1hoeFVrcnR2Z1NCTVJZOUhzL2kya3gySDlN?=
 =?utf-8?B?L0dMdUxvdy9MTWtyRjNlckxKYndZblJobENJdDZ0RG5JeWpWVGVERTdXcHFF?=
 =?utf-8?B?Uk5Sd3FhREdzSHU0K0k1YjdhdFRiNVgxQ1FzMmhsc3A3WFdnTkJxUnRLQmVR?=
 =?utf-8?B?SkxFem82emhDM2MrZjFnZ28xVVVqcmI3eGZzQXlQQUxPeHVNSDg5NmU2ZWg5?=
 =?utf-8?B?VWNYajNsM1dYaUxhNVNXOFJrRVBiUUFHNWp2dEdzYkR6MnJaaHJsQ3pqeC9k?=
 =?utf-8?B?cDkxRVA4NkZDNzA3WE5ZRGxaekM5V0VLN2ZWWGdSbEljQU9hUXhuWTVYRDVj?=
 =?utf-8?B?R2tVdjBldjhxeWRVYTZVMUt5QTZLZHpkRVFmSmJUSnZZbWZYZW5XZngycHRD?=
 =?utf-8?B?dFF3VHZJbHp4cUYrL1UwNUIxN3JTTWk3bkNlcTFWMDIrWmJmcWVjNE9lL2g0?=
 =?utf-8?B?L1Nzekd6SkRpaThWeHJjTkJQMU9TRVhtV29ocWFtRThDb0xOL0xmRUY2blhn?=
 =?utf-8?B?UER2cjh3aDBlK2pVQTVwRkR4Mnd0eHVpUjNjVUZzRnlselUxN1gyeXNsam9a?=
 =?utf-8?B?eDNORXp5cE10MzRWYXVVY2wyRlRJM1ErT0lkMldWMUxFaDg2cVpNR1BPTElh?=
 =?utf-8?B?L3AxT0czbklkcE9PRkpGWkMyV1JIVkFiaTRYTnhKeFlUTTJmeUxmTndibWU5?=
 =?utf-8?B?U0hMQzhIRThnY2RDbmdXWGQ2a2VEQzdYNkNud3NjRHRmdFJVbUp6OFFvY21X?=
 =?utf-8?B?dk5tTWxNbHkvUTQzNDdsaUFLdnl2MDhXMDE1cXhPaEZtdW4yZExUM2xVcTl5?=
 =?utf-8?B?dDloTVF5K0VJVlM1N3JKSS9QUDV2dTZhWUVpNUxYUGdteGlKU1gvTGxaM0RC?=
 =?utf-8?B?VkRJek90cGJiOTNpVFFQN3hYTUdSQkNuSkprSjdIUzZ4LzJIdjlXa2wyNTBz?=
 =?utf-8?B?dTErSko4eGhPbTh6bmFqWENjYlQzWGN2MUJFdEVmZlJUM3Foa05Iblo4Nldz?=
 =?utf-8?B?QmluSit5bGpEMWQxdWZveXA1cUFNek5BL0dMaDBRaDZLS3l0SDJMdzYzdmNF?=
 =?utf-8?B?cnJvaGRBemVZWnNid1VzSFYzSVRhbWc4TjJ0STlBbXVYWWtHY1JnL3V0L3ls?=
 =?utf-8?B?QkN0OW1yYTc2cllFZnh3UDY0ejM1amhLSWpxTUdQL1J2emM4dnlMaWRtR0xQ?=
 =?utf-8?B?ekpqY0Q5eVUxbnV5dXFKRTYyc0duQVNxMmhUWVI4ek5WZjhhV1gwZ2o4dDdZ?=
 =?utf-8?B?MHlYMm40VmVYSGFWTXNhY1dBNkp3PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6370f495-d67a-4bad-fa95-08ddd8fa51cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 17:12:58.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2xDsojDkHarCPZaXoBKYTFUI+I1+yunlsZ3LnkLizcXSWr+3H6wJ3DAln2A3saEIbK0to3A/useB9McLdGOVg/A6QSMRHha7JWKWhCr3Xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7065
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

Hi Jonas,

On 8/11/25 7:09 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/11/2025 5:44 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/11/25 12:26 AM, Jonas Karlman wrote:
>>> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
>>> What blocks are disabled/non-working is indicated by ip-state in OTP.
>>>
>>> This add initial support for RK3582 by using ft_system_setup() to mark
>>> any cpu and/or vdec/venc node with status=fail as indicated by ip-state.
>>>
>>> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
>>> cores and one vdec/venc core is always failed/disabled.
>>>
>>> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
>>> the required DT fixups for RK3582 board variants.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> Changes in v3:
>>> - Apply same policy for RK3582/RK3583 to match vendor U-Boot
>>>     linux-6.1-stan-rkr6 tag, allow use of the GPU and one vdec core.
>>
>> Isn't the GPU supposed to be possibly non-fonctional on RK3582/RK3583?
>> If we don't disable it in the DT, how will the system actually behave?
> 
> Not sure about this, I was also wondering what happened to the GPU, but
> this matches the updated policy [1] in vendor U-Boot and I do not want to
> deviate from the vendor policy:
> 
> [1] https://github.com/Kwiboo/u-boot-rockchip/commit/5566d7d920d20932d2188c0cec57cb9036a9eefd
> 

Fair enough.

>>
>> @Kever may have more official info on that?
>>
>> See remarks on v2 otherwise, most of them still apply.
>>
>>> - Update rkvdec node name to match latest mainling Linux DT patches.
>>
>> Should we rather wait for the patches to be actually merged before
>> trying to patch the device tree nodes that do not exist yet?
> 
> This is what I did for v1, however Kever mentioned:
> 
> "it would better to follow the vendor U-Boot as-is to handle the dts, eg.
> seems you have skip the dts handle for rkvenc/rkvdec".
> 
> So for v2+ I tried to anticipate those node names, and have also sent
> multiple reviews [2] to Linux ML for the rkvdec nodes to ensure the
> names matches. However, the latest DT patch [3] changed the reg order
> and thus the node name changed once again.
> 
> We could drop the rkvdec/rkvenc handling and add it later once nodes
> have finally landed, or keep the handling and just patch U-Boot in
> case the node names ends up being changed before merge.
> 

I just don't want to have to support patching multiple addresses if they 
change again before beign merged in linux :)

But Kever is the maintainer here and I don't have a strong opinion on 
this, so I would go with what Kever said.

Cheers,
Quentin
