Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0D8C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 11:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB42B80658;
	Tue, 14 Jan 2025 12:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="b0ilMo5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D10A80690; Tue, 14 Jan 2025 12:04:42 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB7F8060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 12:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6vPngoShWnwpIYNIgA9AuAeZoEP9/dzOrA+W539Yg966rwBvdcpeLUtuOE0artBasT3nvDSyAJrLrHNPqehqUxabovvMGPcOOwAlFxOYjFVjfDLHPHFHBFC5Wo+z0zCbbKG7TLn+xkjOSFlKvih7HWfaEJjXq8u2c6cEEpdv8AVjVzWn6X0QU3jjafCc7DBEuWsgt/pu6Vqhja3p1oylPjkikz4DlHAgTWpoDYZwYMxVpjKlrRrk55Ri6azedzpRffOJt5m6IxXY7YNjmVvRmmtofRxee4MXrR/VZhfQ6m2NmA+AqK6rpaaeFuxwysSbH/oF9AG0jDPzaU6I2hv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ruI/hM7Pc+zLUH2O90ns8uO+a7xXDH/FRMWz5x5Fo=;
 b=IaEq5C79kzwiMhAwan+pk41jAUZ2cOsignbCp6IX3e0NrOwjYbpZbeWWClN3vfdtoF3FKth1cHtcz1tp72FQo1qDnle3BqJXioiz8aWIm3jzIJEYkzEWpdPIvhqZ6mM4PgTukmv00eXynQdOCXuFst/lVnMaI+SJ4dCZQfhCd1fG3IcjyFzIAyjPapkhZs2/yQGiwq0d79PziAfEUHr+iyAYZEJqONr9OomEKV+Yz06UbIoa1RFRkU0WDdpGA6WRwC0lGlcb2e3XNbWHNxiMa+PM2OzxzMsnLTZ/t0Tn8AJ8AL4n/vS7FUjltUdkxItTUVrRc3CYw2BeVr+LCSzFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ruI/hM7Pc+zLUH2O90ns8uO+a7xXDH/FRMWz5x5Fo=;
 b=b0ilMo5r0eru5zjRUYhuD/x/GNfDqV9v/oxKacpeIxiEdH1W6xo9qJjJS8/hbSt8BwxTjC1jyBxUFL0/GsQkRnfTe6U4AeKtfH+QLwbhtNNR6G75GlMdpfH54KxksOw0ShL3snW0H8+L4GhXqYkG8SN817ah5WqNoMAbf133Cjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7478.eurprd04.prod.outlook.com (2603:10a6:10:1b3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 11:04:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 11:04:35 +0000
Message-ID: <8875f80c-48e3-4ad9-8c9e-4cbec49070ec@cherry.de>
Date: Tue, 14 Jan 2025 12:04:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] image: apply FDTOs on FDT image node without a load
 property
To: Marek Vasut <marex@denx.de>, Quentin Schulz <foss+uboot@0leil.net>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20241219-extlinux-relocate-dtb-when-dtbo-v1-1-fe5eeb8fd4f1@cherry.de>
 <fd67183b-c1a6-4e93-9b07-ac5fb8196d2b@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <fd67183b-c1a6-4e93-9b07-ac5fb8196d2b@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: ef41dbe8-0c0d-4262-758d-08dd348b3b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azQ0UUthUXJ3RklvOXZFUkdjR2dqWHdsVVZjd1VUdk52VkJwT28rZUptNGpo?=
 =?utf-8?B?bGVCcXlmRGptRHVGVWF0QVJwajBpenlndHZhVzZUbkpOQk1uZ2laRFI5VDk3?=
 =?utf-8?B?RXhoQVdSRnVvWkt0bHBCckluK2I4cVNNMWFCSjRGVVJmc2pFSVVnc3lCcjhl?=
 =?utf-8?B?b0Q1TUUwTlR3bmpTK250cnNmTGJ5eXB1elJvQ29OTjJJbDBXNHUycklMd3Iy?=
 =?utf-8?B?R0lpSTNrYktGcmp6Nmx1ZHYwVitYOC9ueERaSXRSRm1wZUNtN2k1OG5tNGhm?=
 =?utf-8?B?V3BqREVGRWY0UnVmT3M5TkZnVUJxWnNtVmE1V09Wdkh4MU12MUFvNUVZUi9s?=
 =?utf-8?B?Tmhqa3BJNGNOV1VMbGJOZW5HVkxVbVdPalkwRlBLZmx3Z0syemxWMGQ5QzhU?=
 =?utf-8?B?Wjh6VnFQa0VybVdvUG1ZQU9nQ1pQbDN0MzZ0QU9QSDVqOURWcGo5bFdEblVS?=
 =?utf-8?B?dnF1clp4SXYxSlMrQWkwUndNMWZDUlNJQUFJdHkrUUpZM0RIZFdtRDZBTXdW?=
 =?utf-8?B?d25KM2lSZVVoRUZuVmZ6RnpNS2k4bnBXa0dJaDkzQnVqaW5GY3lFcXRBdCsx?=
 =?utf-8?B?WWtiSCtuZFdVRm1xMWo3dFBYYzQ0M0RUYTl4elM3ZDJkYlcrRjV5TXRCTmsv?=
 =?utf-8?B?ZmxSZnpLNWRhMDR1WS9hS29GVnhuQkpwSk9icG9oMnJBSTJxdXU1QzMyay8v?=
 =?utf-8?B?a25WY2NtbHNCSmI1bFJodWpNeGtVZ29uaURPdmhrUTFHUXREN3dodms5Qjc0?=
 =?utf-8?B?KzJPMGlkajI2R2x1azFuc3hsM2VZRzRWZE9XOXh1VXpNVE9BY2MyQU5nZ1Vy?=
 =?utf-8?B?dExTbVhza2ZTeHZvYTdmS3pmRXNsTm94T0pPc3hxTG9JTzFVaUtqWWt2dWFJ?=
 =?utf-8?B?NWR3L2JRN1dQMGtSdVZ6L0lCQlk3a1UvNTJ5ZmdDNUlKSWR5Y3FFNCtiM2Vz?=
 =?utf-8?B?N0I0UVBmYVVkdU5CRGFnWjMwWDgrbTlFdnZXZWFYMWV3Q2xINkVFNGtEUVRV?=
 =?utf-8?B?V0cyOXU5eHZBL3pKeGQvM0REelp2ajhDZmI5bDRoOEV2eTR3aGFIWXlXaEgy?=
 =?utf-8?B?c0ZtYTZRRnZwT2JpWVpFY3RaOHZzOUxkRUE1SkdWYnpMNTg5ZGR4dGJYR0pL?=
 =?utf-8?B?OC84anYxWkJQTlNHRnV1c3dSTHJRU2VhK3BXMmpkVkVtajNIRnNabjNCV3Vp?=
 =?utf-8?B?Q2s1OEhKUW83OTEvakZyS2dRbWZ4cmdwVS9uSEhMWGFuK210eXpBMnJjQ2lC?=
 =?utf-8?B?ZDY5Q1dZUE9DdVUwK0w5WDNtZzJGK0JrYVVNVUd1MEhKMXNtc1RNL1ZKSHV6?=
 =?utf-8?B?aDFCdkE3c2Y4bmd2dEtLempHb1dkbUdjTGJxOS8yY2lJcDNjMXZrbjFPdThZ?=
 =?utf-8?B?YkZ2ODkzT2didE9WalR0K3AvVTdvWUNaMjNadUpuTE5QdHhOZWQvR2x3M2cy?=
 =?utf-8?B?aE5admxNMGxOZmNZN3c0U2NNYUh6VWx0TmtYZXFjbTgrQ1Vod2xaWGNoQkwv?=
 =?utf-8?B?Q0VZR2lvQjVkUmNIZW54N2o1TVcyTmZ2a1JFYytFNXNHeitDdERpbHk5enoy?=
 =?utf-8?B?ZmU0ZFZSMFNkQ2xqUG1FOERiUjBJaUg4SVVBdWFCK3lLSU5yc2ROL1Focnd5?=
 =?utf-8?B?QWRxTUw4L2l0eGErNXh5dXZMTGNwVTdNQ1BJRWZiL2NWYWRnNmVXT3Q4QUQ2?=
 =?utf-8?B?ZTVueW42czh4U2N0TVBHV0JoSlFMYzVmSWdOVFV6dkNFVXp1eERXMldWV2ha?=
 =?utf-8?B?TEtZVUlVM0RCTVZOZitNSGZkd0tqbHY0TXhjU3NqV3RtUXBza1U4ZHVucTlK?=
 =?utf-8?B?bEEvbzNvUWZNQXR5Si9sdFF1Ulc2M3hGMUVDeHBzMG9iVVRrcDJ4UmtmcGo2?=
 =?utf-8?Q?9VIuu6mRcmd6z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxsN1VNZFZ3MzJPbmRmVXgzNmk2bGNNcUlIZU55bHZVNTNMdWpMVEJCWnhr?=
 =?utf-8?B?NmJsTFR2RVF1cWQ3T2ZKSzlQWUtCVks2d2dXQnFKRHViMG11WE5iQmlIYTVY?=
 =?utf-8?B?ck54cVQwOWxLdmFlRDBYaE9TSTJxbXBvRUZ2UXZvM0hvQTIzUklqNXZqamV4?=
 =?utf-8?B?MHhqSUQwS1NDSzI0NWNuTjlrODhuMjlmSm0va1k5YlRpZ3FhdFVTUzR1RUlS?=
 =?utf-8?B?V2NPSWN1VTVjMmo1bHhEa2FtN2U5cFhsVno1UTllTU9WQ2JYZ2VaUlRvN0ZS?=
 =?utf-8?B?czdlZy9OS2FnT2hHRnU2NXdzRmNjamwvOUMyQmJTNU1GcEUzU1BYTjJsRzBu?=
 =?utf-8?B?WGtkbmpVWmxYRjh2VUg3ZG90NXltNExSNWlJYm01bitLNTNSRjN2bVdMNVlT?=
 =?utf-8?B?cXROUkQ5RU5KTTRFWHdYRkRPdzZEVUZJT0swNDhDZWhsRC9mRU1KbjBoU2FU?=
 =?utf-8?B?MDBZdGl6cmpFVUhGSTZwVXFrMTFrTUpsTHZzdjFpQ1FpWWpjcHhOcmZqVkts?=
 =?utf-8?B?NElVZ2ZoRkxjZlJXcTdRV2ZCdVVncGxaSUpGdWU5Ulk4OEdvUzA2YXZybGJV?=
 =?utf-8?B?QnlKK1k3WHduc3JJMzJsZVN0TFZmKzV0SnBWTG8zb0JMN1pGN0d3SC9ZUG8r?=
 =?utf-8?B?Rmd4ZmtlSXZTcHczZ3F4R0JzVFRkMGgxejk5N0l6RW1OeE9mWnNKVWZGSlQv?=
 =?utf-8?B?RTZHSzc4RWg5MFNEaE1RNnpoNUw5dEhiNWJZVElrREhtejBDbzlVRDl6VmRK?=
 =?utf-8?B?MnNpS1NUUnp3c0JjWTNMbmFzSTB5WXRrTmJBWmN5REV1NlpZMnZjVTBXR3ZJ?=
 =?utf-8?B?bHRqdkluL1kzWnAzVklyUlNQVGQvOFA3RWwxVWFhTVhlTXUyRm9aQUszeTlQ?=
 =?utf-8?B?a3dWUnBFZFRXZiszYUs2MGJYZUIvL3YxSnVSYUo1cENIWk1vUnJXYTB3all2?=
 =?utf-8?B?MWlmd0EzREtkRzI4ZnQ3NUZpNWN2Mnp1ZUh0enF3L0E5ekNsVzNLeEtNbE5W?=
 =?utf-8?B?NCsyM1dHUmdOTmtqcWMzdld2V056NFA3TnkxcnZFMm1ZMkF6dGNMeWczOG1M?=
 =?utf-8?B?R2tjdHN2Y3VBVVZMK1d6aFJWZ2pUVUxuMGFyT3dvWDRBVHJMeHhDTDUrTXZi?=
 =?utf-8?B?ZVBMVjBCYnovc3dVSDZoNTRSQjNZeWEyNlZGRnVucXNyZzIzaExBV05PTFgy?=
 =?utf-8?B?VlUxYUhwVFo0TXJYWmMvTTBwQldCTnZEaXdhWE5PWW1UelVkYnArdWxFdmR3?=
 =?utf-8?B?RGREMG5meUpPUUdEa2UxR1Zsd1hzNytWR2ozRlJ3Zjk3ZVZwcUREOG1QRUhM?=
 =?utf-8?B?Z2N0eDRiejc0S2xJV1YxSDdvR2RBOHZvalNqUU1QeGNkL2RDOE84RjlLOEdn?=
 =?utf-8?B?cklhT1FOYmFvZ3VadUdFeVFtTkM3endwMHhpU2VrUDJtcksvM0QwOGFuUVc5?=
 =?utf-8?B?TjdNOGxCTjFId1lhVHUxZi9YVVhYQkI2NlJHcSt1UDh5Ly9NbmtIVmRuMlo4?=
 =?utf-8?B?Z2t4UmdzTnErUGxGUGE4ai8vT01pTEZXcHZTSzdoZTltbjZKVE01ZTUxOENP?=
 =?utf-8?B?RWt3dW5sdDIxRjEzYll6bG5VR3hZWmcyTWlwSFBReEhmTUd3OFJHM0oySGlO?=
 =?utf-8?B?YXIwdU5KNGthcjlJTEhDL0FpYjNGaEt4cFh2dHJRNm03V3Ivd2locVVjbXZk?=
 =?utf-8?B?Z3pVazlCdEVNbXJwOTFhcllEbStGOXgva21UaDdaWTlwaGM1S2lxQzZqOU5K?=
 =?utf-8?B?c1ZMZ1hQOFVCVjdTMWNncW1MMGIyaEVlM090ZmcxQUt2eVAyVHgzTE9tN0JD?=
 =?utf-8?B?WnVsSXVSU3ZGVDVocFpRV0MyNkZ1NFhqVXJXYTE2cEx3ZnhzRlZsUmVxazRV?=
 =?utf-8?B?dG95bW80RnZDV0MwVUh5b0c3aTZ5bm9kRkZ3cy85TGNEWkY0Yndwd3o2YVZt?=
 =?utf-8?B?N2lXdFhTZ1hUTCtXRkwrTjBKOWI3eDNFanR5VHVEYmp3Ri9FRGhnMkNmeFlt?=
 =?utf-8?B?MDhSUis3aUFiUloySHliWXpZSzJsR0owRU9tZXQ3QVdYNEVTUllETU1xVHBW?=
 =?utf-8?B?TFRUTVNjc3pzdVFQZ0FldkNWRmpla0hQTDI2MEtFNC9LOVV3Zy9UM014R1RE?=
 =?utf-8?B?VXJSZ0cyME5wa2pLVVYvNTBjaURvK3h4MHEwZVEvaDlCR2x4SExTWHptMWdL?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef41dbe8-0c0d-4262-758d-08dd348b3b29
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 11:04:35.5443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM83MohOshp4YghHyq4zJid9nRCYy+4WtRdY+HqISBNqVoXVOMA2cHVF2HocIxCDj4lCQrl3KuxtFzsFQA39WMPPyVKNxsJPrcPfQIlotvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7478
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

Hi Marek,

On 12/19/24 7:26 PM, Marek Vasut wrote:
> On 12/19/24 4:03 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> A FIT image which is NOT using -E when created by mkimage - that is with
>> image data within the FIT - will fail to apply FDTO if the base FDT
>> image node does not specify a load property (which points to an address
>> in DRAM). This is because we check that the FDT address we want to apply
>> overlay to (i.e. modify and likely increase in size) is not inside the
>> FIT and give up otherwise. This is assumed necessary because we may then
>> overwrite other data when applying in-place.
>>
>> However, we can do better than giving up: relocating the FDT in another
>> place in DRAM where it's safe to increase its size and apply FDTOs.
>>
>> Suggested-by: Marek Vasut <marex@denx.de>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Tested with extlinux with:
>> - conf node with multiple fdt entries
>> - conf node with base fdt + conf node with fdto (stored in fdt property)
>> - FDT image node with load property (behavior unchanged)
>> - FDT image node without load property
>>
>> I'll be frank, I don't really know what I'm doing here and I'm on
>> holidays for a month in a few hours, so take this with a bigger grain of
>> salt than usual (hence the RFC). It works (tm) for now.
>>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> ---
>>   boot/image-fit.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> index 
>> 7d56f0b5e6ed39a75e029b09dc95d605835c0f91..088482c4d5d2e194cce66f10b0acd9e586f826b2 100644
>> --- a/boot/image-fit.c
>> +++ b/boot/image-fit.c
>> @@ -2392,13 +2392,18 @@ int boot_get_fdt_fit(struct bootm_headers 
>> *images, ulong addr,
>>       image_end = addr + fit_get_size(fit);
>>       /* verify that relocation took place by load address not being 
>> in fit */
>>       if (load >= image_start && load < image_end) {
> 
> This has to be updated to handle the mkimage -E case too. Basically, if 
> the FDT is outside of the fitImage tree area, but still in the trailing 
> blob area at the end of fitImage generated with mkimage -E, then any 
> modification to the DT which would result in resize may either fail or 
> corrupt the surrounding blobs.
> 
> The safe but heavy handed option would be to relocate unconditionally .
> 

Will do.

>> -        /* check is simplified; fit load checks for overlaps */
>> -        printf("Overlayed FDT requires relocation\n");
>> -        fdt_noffset = -EBADF;
>> -        goto out;
>> -    }
>> +        /* Cannot overlay an FDT stored inside the fitImage, so let's 
>> relocate */
>> +        char *of_flat_tree = map_sysmem(load, len);
>> -    base = map_sysmem(load, len);
>> +        len = ALIGN(fdt_totalsize(load), SZ_4K);
>> +        if (boot_relocate_fdt(&of_flat_tree, &len)) {
> 
> Please print the error value in case of failure here, it is useful for 
> debugging.
> 

The function returns 0 on success, 1 on any error, not sure it's that 
useful as it'll always be 1. Do we want to anticipate this function 
being updated to have other error codes in the future?

Cheers,
Quentin
