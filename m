Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864B7C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04543885BF;
	Thu, 23 May 2024 17:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mcfGlJ6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E6A885DB; Thu, 23 May 2024 17:04:08 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C532885DD
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh2SaYRcnoch/Pl8JvAXC3ElIM13vXn0yhfGUCi+AQbdZkdjf/y9VGX+/2jpZU80ZCO3Qc6BwAob3zyiyngTHaNbdJk/axq/BWkTxX1o1Fp1hEavM5pAm3tA6MKlm3GVJdiBsRrLbB/qDi6j6cweSfGZHPzMzOmq5wjSwHC9eCY0wGZjTPIUN2I1zuNU509DgEkeb2tkP1qZfvAHqt9N67tFFQ2AALkyhypqrZ2gDaUMhYE+mDJoLNqUeF//xaPThr2fCZwrBk6RYaQSN1O95tMeEJ85AvfkWWpeJ5Jwf8GUEjH8E2i9DYoFPKJE/InQ3lVS2MFY3l5gN9ACfti9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHK/3dHEdXtVvF+Fig3nVle58x8nsB/PJt9/VYms/u4=;
 b=HqGRFzaqAWMkpUf5QgBS9TCZnfl2L4IPp0xZQiS2vkMNVLeCN/LUkiBmbeWom4rIjg5Rx1E7mrK5UCYi2ADWC+j+VFf3dhcMPOK4KaJq7H8knZUYGmwA2Sdh4CL9Y29Y9Nu7jTQSApMzhuAdgbRiX8kY+/owLnQGrNr3yMPQ52cwPcC3byci+1fPUfL42XlcQhie1xpja5M5vb6ApvBlwqr8wDOVgnEVp0knOXI8pR1i/+EN/N7DMuzSG7b5v/JZarZZqxPmKmc1/cGrKNzwvmA7IJ64U+VONh57yx9QFjsOgelGhAdhQGKzUxNWuipSkzoouELCfL1rblSIi2h9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHK/3dHEdXtVvF+Fig3nVle58x8nsB/PJt9/VYms/u4=;
 b=mcfGlJ6Bhek3iwqn/wfzSjuh84RKQwmEpS3NkFtwGXCkSs09xCSOlLDQruCD62xQ74AES9N3QOtEfmOzNfCEy2Mk9YK4wLf9pCrJsR30UxvpyOlk5fh0tC2fyaOfhqEZU3VrSVEnSxIt+ep0QecKj6nhINwUdM8NX1dJ5gyht9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 15:04:05 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 15:04:05 +0000
Message-ID: <46c79851-47c5-45b7-b0f1-93068bd3d562@cherry.de>
Date: Thu, 23 May 2024 17:03:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/42] mmc: dw_mmc: Improve coding style
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-16-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-16-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 66668e52-4027-49b9-ac1a-08dc7b3994b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFlyUXZYU1Q2cm5rTzlWRitYT2dlYVdTUmFnYnQySWtUTVNWWm1qZ1d2Z3Fj?=
 =?utf-8?B?RmpJeVlrKzl4c1NSaGxpUjhQUWQyVjZlUEtsekpsZEhyZUxxTzFWcWF1T0VI?=
 =?utf-8?B?MkJMd1RSbzZ6bTJ1M2huanhqZU84QzQ1NDVuQ2drT2c2WWtudzBEQngrOHBN?=
 =?utf-8?B?cUMxaEgyVDFQdDBkd1JPVzQwa2ZpN0VvTHI3NEVIZ3RXWkQxYjcyMUZMdUFO?=
 =?utf-8?B?MjMxcERGK2dHSXBXSW4zRzB1SzhQcnpZcnVOb2FMWWpDM09PNmxYSlR4d2xP?=
 =?utf-8?B?WjYvSGEzSm93ZzhsakU0TzF3cWY3N0dqalRJbktpbExFeEVRNGtNdjRyeUcr?=
 =?utf-8?B?T2pDUkNQSXVMcXd3N3V1K2kyV3l1aXBhVDRYdkJFVDVzcE13VklYV0p1NVFV?=
 =?utf-8?B?SWo5WnAvY3doVVM1WUtzanNaY1l2amdUOWFTMG10dC81dWlqMjZNeUV0bWVy?=
 =?utf-8?B?QXY5UEhOSU1PV2srdnZaR2RkR1A4dzJkZVNSL1VLN1RXYnplSzZBMWd5bllK?=
 =?utf-8?B?OU4xM24rSlZFRWNqNmF6cGRtcnNZc041YmREQnIyN0dkZGN2U3M3QXQxMGFr?=
 =?utf-8?B?bzFXaGV4L3VTdjdEUStyeGlFWFIwSDVSNEhCakZoUFpjcHg2RzN3cytzK3dK?=
 =?utf-8?B?QWN1NXMyaE9DZU9ZOFRVZVhvNTk4R3MyL25mRXZoVGQ0SG4xZHdHUTJ2RkhM?=
 =?utf-8?B?djNLTEo4cDVTKzFPT3JpQ2E3Tkg0aVVrUjR3TkdmaVArMSswV0lTMXVIN1A4?=
 =?utf-8?B?WWh1cm5NajEzRURYV2tZQmg0eE5ENXZ1eEV5L2cwV09HemZEaWxLZWlNSHky?=
 =?utf-8?B?U0pmb204eTJwSlMrSnhkWU43NTk1UFZnTHUvbkdIUmhaem1zaExNSHplWXhv?=
 =?utf-8?B?Z3ZxTFZuZmtiaGhtKzVpby90elQzMHlIWXNtYzBnaE81a2E4VG5CZnI0VDJo?=
 =?utf-8?B?eFZiQWpnK29lbmxIOVJvUmdPOVhGSmlaV2dvbkJqNHp0WTBnUVkyOFNmZ2Fk?=
 =?utf-8?B?YndsV1kvVTZydjk0ZzQxVDQ4T25JN0FuUGNJdllTVkl3YUdqNlI4OXBCNm1H?=
 =?utf-8?B?SXpnNDN4MmFtaUVTYktjcTJ4Ym9LZkRpczNFMHdyeUpvdjFrY0M0Ky9kMUdG?=
 =?utf-8?B?ejFGbkx0bVVTRTMyNExIb2NzbDNmYmFjbTdxRzZiREVxNEEwa2xUb3EzK0cr?=
 =?utf-8?B?cThkbHlhTThCcE1reDZxYlhsUkxpalRMNm5YWExleU42VVFoWFhrSFRaZDZv?=
 =?utf-8?B?Y0tpSWdlcHdSTmhVUllmU2lYYkduUWpscWhySE9Mc1NQalJYM2NTNmtxWGZa?=
 =?utf-8?B?WFdKZExwam4xckpJeTN4SC9OWFR2NU9YbFhsUFJhSDNscmEzQjJFVjZkK0J5?=
 =?utf-8?B?Z1ZBZldmQW9yT2k5YmE4T2VYTXpBb0lzamNhb0NHdXJndDJOeGpGNXZ0Z2V1?=
 =?utf-8?B?RHpFS2twL0pUZkY3UDVXOWtGbGhiVWR6SmdFUkJENWdPakRYMEIrc01uL2F2?=
 =?utf-8?B?cFR0TU00dXBnSGF5c3IvTFVyVzQvNU1RTklFNWkwNlhjM0NFYndFM2p4Q1Z2?=
 =?utf-8?B?eTBoSzE4M0YyVGNZbFE5MnUvdis3TlJYKzVJeTY4bmhJbStaVzNBbGVScjl5?=
 =?utf-8?B?bXROYlRVZ1RBM280Q1BHaDQ5NHRhS2Z1d0hlaTNna1FKTC8xQ2tYLzIyeEpD?=
 =?utf-8?B?cWdZdWFQcWJaVXVyRjZYREJ5bGRqTzRjcm9NNGt5UjNkcm9md1J5N1dBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDVDYzE4UU95NllCRzkzbDBoUzVIbm9uVDl1VE5udDRYaWxSeFVYV3YzRkhC?=
 =?utf-8?B?ajRxN3FVUnNFZ2lZMk41Q0NFcjZjaUU2a0xyQlFoMk9KdUhoN2JwQnQ0K3M2?=
 =?utf-8?B?VG92T2NKaE9NN05rRnFNK0gwYXcrMkhxZnoxNkpHakNOa1N6NjRxdXJESWh1?=
 =?utf-8?B?OVVVWElpeXdZQjVJNTBPVmN5WUt0QkFjZGNUQXdRUVltbCtyZWFmSzlmLzN3?=
 =?utf-8?B?NTJESzYvN3JWZElqcDNKMkt4S0Q3OW56ZG9tR2VPSW5RbURnZHpGclE2b3Jm?=
 =?utf-8?B?U2xGVDVqbXJ0bTE1UW50b1AyWXFzblRKTytDU3BnNytXMytEN2E3eVBXQWpG?=
 =?utf-8?B?TXpUcC92Tlo2Y0VXbjJpdWliWTRjRnJNaWhEVHViQUZTeGU0OWJ3SlJESThE?=
 =?utf-8?B?NFBWVGd2V0tYQVFBZk1sQXJEaU16V1hnOVFuMlVxaXQ2TUFkby90djdJNktu?=
 =?utf-8?B?TnR2a2crZ1NwaktocXNxTjlsK1pFeXhXakJ4OG11aWlEclNuVzdYUjlUOXQ0?=
 =?utf-8?B?U3Rzbk9UYkdTcGtEeDJ4Z01KZGt0VVBXTnZodURKWHNtS3JqTUF5Umk4RnNW?=
 =?utf-8?B?Y09lK283Zmo1SWhHVnlVYnRzV2FMbFBHTjRzaVEvRjlSa3l5QlpYaGdqZjRL?=
 =?utf-8?B?bzVqS2ZmZ1U5R08vT3ZBZ05PUlZvb21wUTlqamtVbWNBMXVpcmZXU2tVS3Jx?=
 =?utf-8?B?R2NlakJaeUREc3M0MSs5VytCVDZaN1VWeFI1OFNwUFYyTTNMbmdhbTdxTi93?=
 =?utf-8?B?YVpsbzVnZnIvdncwcDhFa1dERFZOdVRiaXpVWVF1UWdybEtadEhvNUF6UUhE?=
 =?utf-8?B?YWVGSERCMVFHOVJVbno5ODMreXVtK21leTJXeWtxVjdWVDUwRXJwVEtvem5F?=
 =?utf-8?B?SFdmMFBBRDA2SnpmcGlCZmFjTU1mZFp0VHh0MXBFaUhZR2M2KzZRMVYxWmNN?=
 =?utf-8?B?Y3l1U0IyeFpCUUIvRGMrQjdZREFFcmcxb2hRb2pJbjZYd0RRaDZFQ3RjV2dl?=
 =?utf-8?B?eWtzcVNxZVRzS1JjemhkdTgwcHdleUM1eUV4dm0wQU9tbmRwYW1mUXRmdklC?=
 =?utf-8?B?eXpjaUcxc2V2a3YvTm1lR0JGaFM3VEdZY3VmdURvZmZZTXRZUXVBV2xwejJj?=
 =?utf-8?B?ZEhIYU5oVmFTdWZGWlQyc2VSVWVVbzFVOVhEU2Uwd0wyQ3JOek5QYnlCdzE3?=
 =?utf-8?B?Tmg3Z01hWjU3MjQwVFdZRHUwd3JhSGI1T0phNWF0VGdkaGxTV2pzbzVmODMw?=
 =?utf-8?B?dlFkcTdmUC94Yi9CT1Z6c09xbW5QTHpmdmo4N3hKT3dMb2txbDN1d2hDTGlO?=
 =?utf-8?B?RHNRUlE2SnhVcnB3Y2c0WGk4VStoUlNmQ0dHTkxpbGZ5RG53RGhnYnAxNTMw?=
 =?utf-8?B?WVlUemJGekpkN3VLOXRFc2xvNXdyblRTaCtiVjFLTUo4UkZuUnZ5M2ZuclY1?=
 =?utf-8?B?MWRBTXo3UXZ3U3Zxbm1nM1V1ZW50Vkx2a0w0VFp4d3Q4UFpGTkk2Z3BFSzJn?=
 =?utf-8?B?R3J6aHZibTVZNnUwTXYyR2xJVUVxeTg5eXlORlJRT20zZXk0d0wxaENKQTM3?=
 =?utf-8?B?clJFTndOTDlkYzVCeWRaOS9HS1Z0aEQ1dWNKMEYyY2xnZFZsU3hrakVadnNB?=
 =?utf-8?B?WWtGY0VmNUJacjdwQU42eXVtcmZkaWVzV1Z4YjM0ZzlBTjZvVlZmV3NIdXVQ?=
 =?utf-8?B?eklHblZXRVVKZlV0OUdQY0g1d0FqZitRSlorQ3pyRmI0Zmw1ZTZYYUlkZUkz?=
 =?utf-8?B?N3VQanFMcGp2ak42S2Y4MjZJaFFvQ2hHNExqQ2hBdDhySGVma2NrMFZ6Vk8w?=
 =?utf-8?B?TDY4dk85a1hTL3hDTEd1L2pBQ1hlS2xEaHpxZlA3REcxT2dyakQ0eEVmc0Z3?=
 =?utf-8?B?NTBNMzAzSGhlcDQ1amJqazdsMmNZUkZhWG9CdlgxUnd3ODRLZ3ZDajJvY0RI?=
 =?utf-8?B?bUtYNHhMQUh3VnRWRnNTemRQOFVBM1VLOGlDeTBLOTVNR01UWDRLNFkrYlBI?=
 =?utf-8?B?NUFJRys1Sk9tM0JkcGJXZ1M2Slkva2RUSHc3OGo1bzI3clNLdjRMY1JKTHN5?=
 =?utf-8?B?WUFDZEFYR3NVZHpkaHlRQ1c0c1grNUpMNVpzQ3dKRHRuZzRtSDl0SWM1WmRK?=
 =?utf-8?B?Qm5mdk1mb1ZtSEtjSzZzb1FkL0ZqeWcvcmp0d2phQzdrTE5iYmwwd2IyRUsx?=
 =?utf-8?Q?pxddgtm3BaEpS2BR+Vx3hbk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 66668e52-4027-49b9-ac1a-08dc7b3994b6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:04:05.4607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvdIWoQu+w3nAgoSLmXEg91y6cBv1QWCs+J2aC7hMtPzakyN2dZ8znlbk1RmCmt43jvU58CwOLgZlRLW8xVR+8qmPEMEZ+UeqXMzWz/k63A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423
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

Hi Sam,

On 5/23/24 1:31 AM, Sam Protsenko wrote:
> Fix most of checkpatch warnings and other obvious style issues.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
