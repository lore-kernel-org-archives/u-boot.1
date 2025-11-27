Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66975D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C06198437F;
	Thu, 27 Nov 2025 15:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ntVymUQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4B8843C6; Thu, 27 Nov 2025 15:02:18 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30E58437E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dx4iiaPv4zhdclFGZq3xKGQooKukkXKuzIsXqcD4jSLXr8f8a+JViIVtGcXv8Mikhxts4pF03WRHmqsu2jOnWxVavQBhrgAqrUnrHiuUEtdut7u3FSk9wnwz69sHDTZW8wWk1wnlrnyc6qada/KRxcRqPakKvHnPAyvphlbY3QmFVgDOk0hY3uIRFTKVLTc/ncWZV6SoZm5afA0QlkvZMNuNofhOJifL9CuiIKCVTzBRqXkSo+us7KkwdsSEPlnEuQvxZpcRcQHh4Q4JtP4g7rbANR+8AGb5GRVbPc51TUn6ei293uF7ZtydZJEdK5sSTFO8/6nTThiwE4QSXAQBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0ta96uwFG0joPAv7BHxbRPaZEn8zaZ4qxrBtOAemMM=;
 b=cisaLJUiFpJQ7PzxqApxj2r9jMecyYTTZlXRxI1mauybVEEFt0mORD+LbuN1e2kZIY7lRsIe3JXozQ21JhQqmu4HhF/yeywbCAaCu+C4ntW0Z/cwtBg/jwY78rzfIhTBR2w9J2VMS9T238ChBm3OKvQHdvOcii59PaaJ47+82m1WvkVArqQVSVUMbQNBCZCc+ik40pPVV6z3SkDPluQyXq87P28OWldL6hFC/bJFXKLBBVeAvkpmywk3s+pA2iv8V/Dgo6RMFxzL8AdjIYdc6nh+fiTBCTWZ4zWTUMyPrjUaZwY20DVIhOuVuRXEeJoNubgNMsFDnwasdte3UAP68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0ta96uwFG0joPAv7BHxbRPaZEn8zaZ4qxrBtOAemMM=;
 b=ntVymUQW2AW3hRJuJOUqznY1O6wzPyWJYCaHUdID5VOhya7Lq0KH/9+FyuPglup603TLmaNG+5pc5HqOiqEWF7++8sng7GcvtjaPgXqPZ6WIUshcZ7PNGuILd2DWdVsDWv/dmvT4c9s/NZ3UCHeEU7d0TlVUKe/RuKCMyq69HQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA6PR04MB11988.eurprd04.prod.outlook.com (2603:10a6:102:51c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:02:13 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 14:02:13 +0000
Message-ID: <007d72bd-89a6-41d3-8d48-88d2e145364a@cherry.de>
Date: Thu, 27 Nov 2025 15:01:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Anand Moon <linux.amoon@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner <heiko@sntech.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0033.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA6PR04MB11988:EE_
X-MS-Office365-Filtering-Correlation-Id: 103a7f45-e389-406f-6a6b-08de2dbd9095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0hMcktMd0pLSVlhTzlrN1VFY1BUTWJxTmVPcU5DYXpOZFhOdzhzZkF5bnRr?=
 =?utf-8?B?WmVjTXFxZGs4MkFabTYvZzU0VDdua1A4cit4ZTg5dzlMUDh6TlRQWGdwaWFu?=
 =?utf-8?B?TFFCZm9KVEFkL09meVBNNFRmYmIwRlJFQ3plVnNra3BHL2QyUjdDVGhPaUhs?=
 =?utf-8?B?ZUtRT2c0WG4xY1YrdjNRdUxjZks3eWtQYmdOTnFFVnhKNkdCWTRrTFRrMXVq?=
 =?utf-8?B?azRLdEsybTZicHJyN2UvTkZ5OGFWWmdtNnN3QnNMbUNlYjFTY1RZZXNEUGI2?=
 =?utf-8?B?K2VqM2R5b05BMVNhTGQ2TGtKS1JHeHF3aDlPc051VVlQQVB0ZFp3WENiOGlo?=
 =?utf-8?B?RTQ5SFd5bXIxMzRUTXcxNml1R1NnQ3hkQVp3VVl5cnlYWWduVHFmWU5VYURz?=
 =?utf-8?B?dFZGU0hnM1pPZEdDbk9GTHB3M3MyaUhrNFRrRWZ0UEtzajVYbkJKQlVlbGdk?=
 =?utf-8?B?Q1JwOUJNbDZYeW5lRWhWaVkrd3RxUldWUXp3anJnZzgxSFMxZ3V4OHVPU0tE?=
 =?utf-8?B?WXBaWEwvZlhNQzkrTlAzenJ5d0QwTlhvU2ZMTGJpN3JDRDFobTl4cUNickxY?=
 =?utf-8?B?WUtmand1WlNKRG9MTG9WM3RzZGJMdTVWQXZha1M1YVRoeCtRVVlGaVNVc1Fx?=
 =?utf-8?B?TTBrMHA2ZCtHRkY4Yjh2cWtrVWJsVG9ucGZaYVgvcUJMUDVjMzVURDJhZmMw?=
 =?utf-8?B?OEh2N3FsMnhQNFlWSjJybmpaQ0I0UEFzUDNrS1duaHRiWUtpcE5VU1A0b003?=
 =?utf-8?B?SFZSbHdOSDdhTmJKTnZvM2J0RjRQOU5YUkdtbU9JYkdiSG1XNUV1c090aWp2?=
 =?utf-8?B?Q3dtUVdjUEJGZElubDZIKzR0YmtUTXAvTDlGVHgyelU4K1FBRnRFTzB4TEVn?=
 =?utf-8?B?c1pxVi8yOGNGWlNuWUxKQ2FQd0NHSGlBcVV6Ym9BUlBkUDZkWVpIVGV1YXVs?=
 =?utf-8?B?OFltKzE4WFViTHpRZUNXQXdFL2dSWFVHSnlJZEtwb0NPaC9jaUpSZUJEV3Zz?=
 =?utf-8?B?bHFJYitia3NGa2Ivdms3OERjOExGVnJyUGdpcWlZelFsamlodkFHRUt1NXUw?=
 =?utf-8?B?MmJHUUJrekMvSmtOVnozaDRKbnpSN0F1a1FxSWFYdjRaaHV6ODVOeUVKdExM?=
 =?utf-8?B?U3RnZ0tUSkhsMXBXdFQ0L1Q0OEVobTE0SkxibHkyY3NRZXZFcy8waklsd28y?=
 =?utf-8?B?d3EwT2tMS1RTZnVlcVl0U3hpTlpwWFllb2lwQ1QvL3QxTjBROEpJSlNrd1NC?=
 =?utf-8?B?TS9uUHFmQnZZb2dLeEZRNy9Dc2MxWXBvVWg1ajZkcGJsNlZzSUVsckRuZklB?=
 =?utf-8?B?M2R0ZVdheCtGNWdEUGF3K3hqblNZVUM2bVNlZ2FURVRQVWgxYVBMaXdCMTVq?=
 =?utf-8?B?a0JNMXlGb294UkFUdDM2cTR3bjF5WC9QbVlDYzFHRm5sNzFWR25qaHRQeEFD?=
 =?utf-8?B?ckVoQ29nNzZQR1EvWktiL0pueFhQdkxKTG9xcjI0WklUTXdpS1JhWUNnZUIw?=
 =?utf-8?B?Sk9YakQrOVpINVM0VjJYWlBxTDcvQXRZc2lCNDNlY2czazdZbEI2QzRxWENU?=
 =?utf-8?B?RjZPV0tjZllRSkppenluOEN3Y3FVS1dtZG9aVitSUHVMMlV2M3lwTHYyb3Vs?=
 =?utf-8?B?ZXpHMDFubWxBM0cxK1JYOUlqT0VSZVlIRysxN21PVHF2WWRQYmt4U0FwQlc3?=
 =?utf-8?B?cVN0UHBERWFwVkFJaUNIQXV5ZWM2L0IyZHdpZWRQT041aEhFWGlUVkNOMmpr?=
 =?utf-8?B?TEk1QnJ2azdKaS81YXVTeEE5Z1lZVFhPeWsyWXhqZG4wcGdUYUw5VnZMSXNr?=
 =?utf-8?B?Y1U3cHdCTExnRXZrTndpSzhmREczN0JEcW95aTNRaDZ0R1ZLK1A5S29rUzZW?=
 =?utf-8?B?NGh2NzBmRllITWRicDdQYzA0c2RUUlN0WkgxcW84WHhuMDlvOFJPdWNIcTN3?=
 =?utf-8?B?V3lCQURkeHFoa3dZSWYvelVxVlZZQUtyN1BmanpKa1VJb2ZrU1pqYVdCU3B1?=
 =?utf-8?B?akF6bEFOSU93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRyY3piZy9pVFpTVHlYelBvL1ZMWVZEclNyUDM2aG5WbFZXODhpZm1LdHBw?=
 =?utf-8?B?djZ6aFgxdTViTTFuMFlXdUZrRXNXZXpFSjUvcXVJQU1GbnVRaUVZOXhLWUhQ?=
 =?utf-8?B?Q0dYVG1vTlB0anhWZjQ5T0ptNkxXUmgvR2x0OWQ0bERNNHpNS1I2K1RlUkQw?=
 =?utf-8?B?R0FhelMvZ0JBWHJJQytmTkM4eW9HQ0lBdWlrK20za2dTR3Uzd1BFdjhOSTNH?=
 =?utf-8?B?VSsxTVFPYUV6M2FKbm1JVHNNZkRXYjRzbWhmbTJnQmhoQ1RTSWIvaFF5dkYy?=
 =?utf-8?B?ZUpScDMwaklqUHRLRUcrQXlkTytqQ2hhZ1M5cEFzTVZqQStrNVk2RXBOY3Bq?=
 =?utf-8?B?Y0dPdzR2U29mMTJqN09BZ3FwbWNLSzBrSXNiQUF6TXBLcS9BQWxZTnBJSEVi?=
 =?utf-8?B?NmliZmJkbGxBT1FTL3d4TG5yVjRVMU5SQkdETHFJK1J1UXl6ZzJId2hrdXF4?=
 =?utf-8?B?RWQwTWR5Q21jNEE2TG1wZXdFcVlOWFJXZ0t5RGVzdEhnZndON2NBU3MrUWhF?=
 =?utf-8?B?VWJyWFlDUVV4eithRzFKbkEwY2RGeFpjNzNvdE1RMy9NZEwzMkZVcUZWNmFP?=
 =?utf-8?B?SUJCWFZNajFCamIzbXZqN2FaLzBFRGNLYkxuakM3cmFCZit1clNUVHhnN0ta?=
 =?utf-8?B?MVEwRE5KWTVzUTFlLzFGY1NRTkQ3bWcwbXJlVUhOakVudWcyY0FNQmtFUFdh?=
 =?utf-8?B?UEtqbUUxbGFxSDRoZDR6OUhJWEE3aWoyYnQrM3dqbWU0Q2pmaU5ZMGhocU1G?=
 =?utf-8?B?dmQ1NXJvWU00UFU1ZFo0TkxYQ2NzOW40Uzl5eUNSd2NCSEwxaE91Vkc0RDdB?=
 =?utf-8?B?aXo5TkhCSnBNQUtxRTlCYzY4SzIzVkk5b3pQUjlqenJmaFV0TEUwQ2hNWE1p?=
 =?utf-8?B?OGoyMGZkZHJseVhrREptaHJJMmRmSUdzWlFXZzJvblBGY1VjWEE0d3VOY1Z0?=
 =?utf-8?B?WnF4MWNmZ1FOSW9sb3dzNnFYMUFmV2dKR1JGNzR0aXBIRk1IMmdQM291UXRL?=
 =?utf-8?B?dXg0c1dUbWRNR0VYeXM3S3U5cEdXWEN3WExaWU02eCtSbGdKTUxnV0phVXhy?=
 =?utf-8?B?bDNKdDl6d3ZZSk9mMitqbU1LNWdHNGxXQ0FUV0cvWjhKbW94N1JGRi9pYklE?=
 =?utf-8?B?U1BMSXJGN3dPTWVObHJBTG9kUmNlOHlOVmdxL1FhK1AzWnRybzhaVjFmOW5M?=
 =?utf-8?B?R3l1S0tJZ0k0RE90R0ZPWnhGQ2xMS3JHczF6QWhndzcrUkh1cExjZ1RyTlhQ?=
 =?utf-8?B?cG4rdVpBaGM4dGdJdnJYdldzSndOTXVYbVlrQitHZjVqQlhtTk9pbTkzbktH?=
 =?utf-8?B?VEgzamlxQTFmdlNBVnh6S1ZQa1VnWTByUHBTODQ5empscEt3bVJrQUdZeUNr?=
 =?utf-8?B?eEQvV3dtV3BrMUZZelZOS24wcklnQ0hmOGhaQ2Y3WUVoM0tlc2gvWHZYNDVG?=
 =?utf-8?B?Nk1yekpKcmVaOUEvOEl0VENSL2hRa3hyc3UyNVhsSFg1V3pPeEVEQlZWVmx0?=
 =?utf-8?B?aUtkODU1QnM3anFhdGVMQ09DZU5MaXYvcDd3bGJKRHFYYlZlN2NObzl6SzVF?=
 =?utf-8?B?TXpiSUVlNWVIWVdhZDRwZXd6ZnM0R0tZUlFMMDFPWDBlaUx4TVM3VkJ3T1RP?=
 =?utf-8?B?RmZNby9tUG9uTUxudzlZc2tBTjRGK0huZWJLaUxxaFJhQkVvb05ScE9JV3d4?=
 =?utf-8?B?REZ3TjVFR2xhTkRYamtwam56STcrczJqRDFiMkJRYW5uTEhVa1liRVhQbnBN?=
 =?utf-8?B?dEVBejNpYklUUFJuMHd1YXJIR1JXRlZJam9JVWtTaDhqek5TNmFKbDNrOGtI?=
 =?utf-8?B?S01TUmdzU003bW81NW5DbmQ4ckd3TGRpMmxHWk4zNVEyQ0V0RHJNOFhWNUtS?=
 =?utf-8?B?a1BsWmFKbEtkS2NiV2VtdnBHK1BEa2xDZ3I2d0t0Ui9tRzJucHRmRFZZUG1p?=
 =?utf-8?B?c2JkZEZQWUtncUlnRlZhMTg2dHFpU05FdjlMK3hjS253NUVJdmxYcHU4d3A1?=
 =?utf-8?B?L01CQWpxTlpaUVJQRWIvK0FFV3pwRko2bkZFM3N1L1B2bGpPV2hLOUltR0pH?=
 =?utf-8?B?THJjTlFzYVFPaVhrcCtZYVlHWm1WdDgvZ08vMStwRTVqcUhoQUtZRkhqY2xn?=
 =?utf-8?B?bWE2bkdlc2E1UU9FMkdrTkRPOHE2d255aVQ1L3BoT281ZEhUVmMwSUYxTlM1?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 103a7f45-e389-406f-6a6b-08de2dbd9095
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:02:13.2414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAbHcVFKPFhvmdh9+iR/aY0MtT5TxliyI6w9v2NQtm2HLWwzHtx/EaPaKGF0iovzdMTS15zMYXxYt1AeMDx77wq3hMGxso38u44zxcpcbSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11988
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

Hi Anand,

On 11/27/25 2:01 PM, Anand Moon wrote:
> Hi Quentin,
> 
> On Thu, 27 Nov 2025 at 16:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> On 11/27/25 11:35 AM, Quentin Schulz wrote:
>>> Hi Heinrich,
>>>
>>> On 11/26/25 5:46 PM, Heinrich Schuchardt wrote:
>>>> On 11/26/25 16:00, Quentin Schulz wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On 11/25/25 7:02 PM, Heinrich Schuchardt wrote:
>>>>>> Hello Jagan, hello Heiko,
>>>>>>
>>>>>> When testing U-Boot origin/master on my Raxda Rock Pi 4A serial
>>>>>> console output stops after "PMIC:  RK808". The same can be observed
>>>>>> with v2025.01.
>>>>>>
>>>>>> The serial console works as expected if I disable
>>>>>> CONFIG_ROCKCHIP_IODOMAIN.
>>>>>>
>>>>>
>>>>> It is I believe implied here but asking for confirmation. The board
>>>>> doesn't actually boot right? It's not that the serial console is
>>>>> gone, it's that the device is stuck?
>>>>
>>>> Hello Quentin,
>>>>
>>>> Thank you for looking into this.
>>>>
>>>> The device boots I. But the serial console output becomes mute and I
>>>> cannot send keystrokes via the serial console.
>>>>
>>>
>>> Uh. That is *weird*.
>>>
>>>>>
>>>>>> The problem seems to be specifically related to the bt656-supply.
>>>>>> Removing the line below also fixes serial console output:
>>>>>>
>>>>>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/
>>>>>> rockchip- io-domain.c
>>>>>> index a0573c52193..b0d78f2d4b4 100644
>>>>>> --- a/drivers/misc/rockchip-io-domain.c
>>>>>> +++ b/drivers/misc/rockchip-io-domain.c
>>>>>> @@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data
>>>>>> soc_data_rk3328 = {
>>>>>>    static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
>>>>>>           .grf_offset = 0xe640,
>>>>>>           .supply_names = {
>>>>>> -               "bt656-supply",         /* APIO2_VDD */
>>>
>>> Reading the code and this diff again, this you shouldn't do at all. The
>>> offset in the array is the bit offset for the IO domain setting in the
>>> GRF at offset 0xe640. So by removing this line, you configured APIO2 IO
>>> domain with APIO5 settings (audio-supply).
>>>
>>> It would be better to write NULL instead, so that the others are tried
>>> and we can pinpoint the faulty one.
>>>
>>>>>>
>>>>>
>>>>> The UART2 (which I assume is the serial you're using for the console)
>>>>> isn't on that IO domain. And there doesn't seem to be anything
>>>>> important to booting on APIO2 domain according to Rock 4A schematics[1].
>>>>>
>>>>> bt656-supply also doesn't seem to be anything special. LDO5 (vcc_3v0)
>>>>> on RK808, which is using VCC10 (vcc10-supply) which is a fixed
>>>>> regulator whose parent supply is also a fixed regulator. So I am not
>>>>> sure what could be going wrong there.
>>>>
>>>> In the schema LD05 on the RK808 is connected to VCC_1V5.
>>>>
>>>
>>> Sorry, I meant to say LDO8.
>>>
>>>> With any of the following values I can enter commands via serial
>>>> console but still get no output. So none of the voltages seems to be
>>>> the correct one.
>>>>
>>>> diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi b/
>>>> dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> index 046dbe32901..f15b5b63815 100644
>>>> --- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> +++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> @@ -517,7 +517,7 @@
>>>>
>>>>    &io_domains {
>>>>           audio-supply = <&vcca1v8_codec>;
>>>> -       bt656-supply = <&vcc_3v0>;
>>>> +       bt656-supply = <&vcc_1v5>;
>>>> or
>>>> +       bt656-supply = <&vcc_0v9>;
>>>> or
>>>> +       bt656-supply = <&vcc_1v8>;
>>>>
>>>>>
>>>>> RK3399 Puma and RockPro64 have APIO2 set to 1.8V vs 3.0V for Radxa
>>>>> Rock 4A. Puma boots master reaches U-Boot CLI with the IO domain
>>>>> driver compiled in.
>>>>>
>>>>> Can you check the error paths (all the ones with a continue;) in
>>>>> rockchip_iodomain_probe()? Which ones do you enter for which supply?
>>>>>
>>>>> Not sure where to start debugging tbh.
>>>>
>>>> I found the driver by setting CONFIG_LOG=y and log level 7.
>>>>
>>>> Here is how the console output ends. Do you have access to a board or
>>>> do you need further debug output?
>>>>
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:
>>>> regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:
>>>> regulator-min-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:
>>>> regulator-max-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:
>>>> regulator-init-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:
>>>> regulator-min-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:
>>>> regulator-max-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:
>>>> regulator-ramp-delay: (not found)
>>>> ofnode_read_bool: regulator-force-boot-off: false
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:
>>>> regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:
>>>> regulator-min-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:
>>>> regulator-max-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:
>>>> regulator-init-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:
>>>> regulator-min-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:
>>>> regulator-max-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:
>>>> regulator-ramp-delay: (not found)
>>>> ofnode_read_bool: regulator-force-boot-off: false
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:
>>>> regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: bt656-supply: of_read_u32_index: bt656-supply:
>>>> 0x7a (122)
>>>> rockchip_iodomain io-domains: bt656-supply: Regulator LDO_REG8 at
>>>> 3000000 uV
>>>> ofnode_read_u32_index: audio-supply: of_read_u32_index: audio-supply:
>>>> 0x91 (145)
>>>> rockchip_iodomain io-domains: audio-supply: Regulator LDO_REG1 at
>>>> 1800000 uV
>>>> ofnode_read_u32_index: sdmmc-supply: of_read_u32_@L@@p0b@HHb```Hp0 p0   $
>>>>
>>>
>>> This seems to highlight the issue is rather audio-supply.
>>>
>>> And indeed, audio-supply should be vcc_3v0 and not vcca1v8_codec.
>>>
>>
>> Mmmmmm, upstream kernel has 8240e87f16d1 ("arm64: dts: rockchip: fix
>> audio-supply for Rock Pi 4"). So it seems it "fixed" something.
>>
>> So before I send a revert to the kernel and start an endless thread, can
>> you test locally that the following indeed fixes it?
>>
>> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> index 4861574636e..dccc469a507 100644
>> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> @@ -14,6 +14,10 @@
>>          };
>>    };
>>
>> +&io_domains {
>> +       audio-supply = <&vcc_3v0>;
>> +};
>> +
>>    &sdhci {
>>          cap-mmc-highspeed;
>>          mmc-ddr-1_8v;
>>
> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
> 
> But I am booting from SPI flash, so I cannot stop this board in the
> U-Boot prompt.
> 

Not sure why booting from SPI flash means you cannot stop the board in 
U-Boot?

> Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin image
> in the user space to spi flash? using dd coammnd

flashcp u-boot-rockchip-spi.bin /dev/mtdX

I believe?

> 
>  From the schematics, it has W25Q64FWZPIG
> 
> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
> 
> I have tried to enable SPI flash, but it is not getting detected on
> the board in userspace.

Are you sure you have the driver for the SPI controller, MTD, 
MTD_SPI_NOR, ... available?

You can check from a running system by looking at /proc/config or 
/proc/config.gz

(you can grep in config.gz with zgrep)

> 
> $ git diff arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> index 9c741d1a3047..d18b59ddaa1d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> @@ -42,6 +42,16 @@ &sound {
>          hp-det-gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
>   };
> 
> +&spi1 {
> +       status = "okay";
> +
> +       flash@0 {
> +               compatible = "winbond,w25q64", "jedec,spi-nor";
> +               reg = <0>;
> +               spi-max-frequency = <108000000>;
> +       };
> +};
> +
>   &uart0 {
>          status = "okay";
> 
> Can you share some input on how to resolve this issue?
> 

Looks ok to me.

Cheers,
Quentin
