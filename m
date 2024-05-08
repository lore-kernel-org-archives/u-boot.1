Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5260C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 08:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1244E88456;
	Wed,  8 May 2024 10:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ipnR+mjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2E8884E5; Wed,  8 May 2024 10:35:57 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F647882C8
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 10:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbukwNCHp+LG1Tw23n3tLRMi06l1jYCNWc27JtCw4RWHnmzKZVRtpO3mY+j2bK+6OXkZ3Vlza0ZlGv1XckEnIKvdb2pc1sBZcQSRVQ5MqQdZtizcV6BmKz0vGML2TdmOWvFJ+6DCjEIgG6UK7Z+VobUXiNYcXtSwiNZOKe3qIH9NwVuDJZeK3CcXVY3wu0LgJBfmVOkwJGv/y6Xd9tR5GSbj3zL0HaENARmS9b+JD5IttFHBpVwcbt4zhKS6KbBtyFjUEVFFXUIW0yA4v5Wug4micQGMAhhS8cuWDe4CkidahcofYbn2fZxVE2NxvN+EIcPHpVv4ZsXly4NEZpw0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBdnqXjhpd8Dn+CMonSN3UxAyBio2yHyLIegDqg7XhY=;
 b=T3atTEFAHlRVeKXEG5xRwKFnC+XQbnWszzMmm4peF83lhQp1h7j216tALzhfvVQ83TWwBTBK5tU949QefCMm8/yewwRXBd8dE52Tyg5xNeUHQnuTEV4UeEqbrmhnQGviklqM3joSKBDgkPCq/5kULcldAb6i2i7sFV3XxHvvodkvbKjIQXWwCHBcu4QZqVl7UBY+8VBNBZ00GXZ0Op99F/n2xcqclCQJBIIfN10ugYhmbM+PiD3ngvAWtanNhC1eqdavfl4GwZ2CMBiEHm+lsjyrZJPie/Mh0t1YYNN0eff7pwzsY5KjF7qptcZ5v5zRA40iK7l870bxo+lTB2oXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBdnqXjhpd8Dn+CMonSN3UxAyBio2yHyLIegDqg7XhY=;
 b=ipnR+mjFoR0901qzAn5cGzBV2Ak3zIWF2PQlUA4Tb6PsLv7EoeehOX9kE+/xhkloKyf67KQV8S09TLcq+QW3S/ER6X7/Y9DNocOn46GgfSjYAC6IFMdK5g3UUStff17COwpksXE7hy525U4ND8leQeQgPUN+pZ37rjpEHM83S34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Wed, 8 May
 2024 08:35:53 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 08:35:52 +0000
Message-ID: <59c3ee19-f1c5-425d-912d-d418c7a2990b@cherry.de>
Date: Wed, 8 May 2024 10:34:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de
References: <20240423-tiger-v2-1-4a3fa0a01b5e@theobroma-systems.com>
 <0c9b591b-71a6-4a76-89b1-46a48f0183cf@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0c9b591b-71a6-4a76-89b1-46a48f0183cf@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|DU2PR04MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f2c380-60a9-4103-a8e6-08dc6f39dec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUJrSDZDSm5yVEZwWXhiMVBTc0VKTm5rMGtNYk5nZXNGcktobVhiaUEzanN0?=
 =?utf-8?B?aGFkZjVRZnBYWFhZM2laRVQ2NjVCWlh4UkhNSTV0RkJ3RGxlQWFoNlY2aUxK?=
 =?utf-8?B?L3FjSjJhNndkbUthMVB5UDZmL2FRUHIrekpSeEFsVGg1SFJkNHA3VEo3YVZn?=
 =?utf-8?B?ekMzdk91ZG1CbWhQR1V5YU1sNk9Ga3ZDWE04SFhTNVdEajArOHRkZlJ3Q2Y5?=
 =?utf-8?B?YzNoNTQyRWRJOXdXT0xqcThPR2RJb3g3RUxpaWxRUkZFMTBoMXB5eTdBSjBZ?=
 =?utf-8?B?VmdRN0JYd3hSYzM4UGZMQU92MHdzR2s1SlZ6SkFiNW5QL2Rxc2ZXUTJKMEFI?=
 =?utf-8?B?RXVxRmV3YUprRko3a0xVN2pxZU1XdURkQmY4ZGxmRHJlL2tSaG5KaGZ2eFYv?=
 =?utf-8?B?S1U4LzR3TjBRMXdhQS9vM1JudTFhQjBmOVBSbjJIcEhjdVNNRFR5dmUvalB0?=
 =?utf-8?B?NUNKSnVyaCtQdGhEZHhXR0VVTlpNbXc1Tmg4STNXeFp2NzJlakdURkVkWS8x?=
 =?utf-8?B?UFp4RFdwWDBMRmxpeEJDL3l1eGd3TVRjckZFa1V5bU54SFgyQTN1NDBGQ3Fy?=
 =?utf-8?B?d0JFWkZSZnk3SWdBNG12TXltMG5VS1liTFZTakFLV2VaV2lBOGUveVRjdnVh?=
 =?utf-8?B?ZHZnV0FWSFJYSHVsVVdMaE9SeCtSTW94bVB2SDI3NCs3WjRkeVFaK29Lb0gw?=
 =?utf-8?B?TElNblhWc25CMC9HVyt4OGwyWFNicklMMFNZeC9WTXM5aU5kb0FXMHhxL2FG?=
 =?utf-8?B?aG5JMFFFQTFOSm9yQ1J5MEg5ODhsWEVTY2JBVkJwR2Zzd2UyOWpsNTV2VFB3?=
 =?utf-8?B?djN4RkZ2cFZOQUtZcXdCNU9XNmJ5UDhTZktVMFdXbVZKZWdjdXYySmwwcXd6?=
 =?utf-8?B?dnQrZ2l1STY3VzBINGt2eXBBTVhUVS9lNFduMWJzRzllOXArUmt5c3d3djFM?=
 =?utf-8?B?amVpRmJxSjcwSVFEYkpKZ09PYTNxZURCeWsrYWF2WFYzRUwrWVF0SmRGM0lm?=
 =?utf-8?B?SndHbkU5WDRzNjVaUEpEVlFRcVkrcEpTYVYweTg2SktWdml5Z2tFaXVIZHgy?=
 =?utf-8?B?VlZPUDRLUkhmeTNBSW45dlo0UFUxcWJrVktlK3dWYTNoQVpkUXpYTGZiNk95?=
 =?utf-8?B?dGpsdFJkY0d0eTBaeDNGQWxIa1ZlVXludHRxWjZ6ekc2TkE4VEFEciswQWJ1?=
 =?utf-8?B?NHNPSUs2VTlkTXVsOWk2RTZFaUFQWE5nRDJBWEQ3OFh6dDNvUnQvclNLWTB0?=
 =?utf-8?B?eEV1VXlSTG9qQ0xyTS8valcwOEg5MmZFQ0xyRWdZWUNab3BWU0ZiYU9QT2Nq?=
 =?utf-8?B?dUpSVCs0WEtVdkNHcTU3RjBwek1xUGo5aTZLdjJyOW9YbTA0UnpYWGNyUEZV?=
 =?utf-8?B?VFEzZVJRWDRmTW9EWXpNeFhZa1VXU296Nm1mdHozbi8wdWlaSUxSUnRjRURP?=
 =?utf-8?B?TGllQkUvMmdrdUlUZDNTcEFLVG5yZGhQdDVYd3pOL3ozZE81b2poUzd6OHRt?=
 =?utf-8?B?M3MybE1oWXlkV0MzT0NtWXQ5b3QxYk5vNGpLZG44em83dWVOQnBHZFVYYi9B?=
 =?utf-8?B?RGZWMXlOMHZPUXpVRlh2eVdDK3BkdmtzTWExbmdHQ3U2R3NoTnlQVjdUTGFF?=
 =?utf-8?B?QlpiQ0tjOUhHa0ptVVhXNE0yUmQ4K2pxb2tpNWt2Zzdnc3hDaTZDUWFtTjgz?=
 =?utf-8?B?UlMwY3NuMXJveUZZamxpN0Y0RzJmMEY1WHFxc09kMnNjU0Z0STBUS3NRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnN6ckdUTTNuOHhpSFM1UUxRaXlpLzBXN3dTZHM1YllTUjVEMDBSa01VVG11?=
 =?utf-8?B?UmF5WS9LQzRGTXlCeWhzWjRMNGtKNldCc3E3RXV6eG9ObEVOQzc1WEdXajNt?=
 =?utf-8?B?UmxNNVhBUHMydERkT2hTcHk0RnlzM3hlZWFNeGYvWjNCNUpONFF5aVNNOHZs?=
 =?utf-8?B?alN6Q1pwYnFpNVo5ZzJ0QlJHbTVGdms1Y3lCZVF6dCtIYUYyZVdINzIydmJL?=
 =?utf-8?B?cktDTTBQT1JxWUhpeWUyb2RUaEo5Z1dJYmNhNENMWlJsUXdFbzlQUWN1eCtK?=
 =?utf-8?B?UWRGa1N4YzRCMXFkWlRCRVN1amptSktuSG5Dd0grOVA3Q3QrR2hwUTRUV05I?=
 =?utf-8?B?ZEU4ZVZwN2JaaklYREo3blJlOHlKK2p1UTFTRll0NkJVTSttM2RhdjZsQXZv?=
 =?utf-8?B?UzNzaHF6Tnp5bndmZDhRN0hudUxBajEybFJsUjl6NTcxc1N4N0t2alFuTVRu?=
 =?utf-8?B?dnF1NGZuYWtVMnhSclZld3AwcGtXTzdSdWtHaUZKUksrLy9tVlVDV2xNYkdp?=
 =?utf-8?B?QnpIa3ZWZ0VVUU4zcmFCRVdqR0VJWUxVb0xJWXczM1YxQm01Tm02L1NSSWNU?=
 =?utf-8?B?RHIzaEZQQVFtZ3dUdU9BZGZaNDN5S2dhSGZ2N2g1YmIrZjBvZWRBS2ExWDhn?=
 =?utf-8?B?ZzVCSXgvb084S1pJRlZKdmFTdUw3Ym51YmtJbU1kNStYR3FCb1pUU20vWXJV?=
 =?utf-8?B?SVJoU3JaVnIzbWpFQWVaR3VqMG1lejRkaWJETlNBTW1XU21hL2ErNW1FaXo3?=
 =?utf-8?B?ZkNrRjQ5U3prYVBoaTBkUWpHdmlMY053QXhjK3VheWh2bExlRmVWKzZnaUJZ?=
 =?utf-8?B?a0ltalFMQUxzZ1FjVkdyNlBhdHFaSmJJSGVEbFpKTGxWMnJIUmEyOFVXTERR?=
 =?utf-8?B?ZFBoUk1NQTJUWXFORnpQbkZta0gwdnFiU3ZoZTlxanV4amp5MXptK3U1cVE4?=
 =?utf-8?B?L2c3UytDS0JLT3I2djRseVZFYmxuYkpyMVBGTDIvb1Z0YnlseVpnbG1QRDdu?=
 =?utf-8?B?K2xvczRoMW9HbFZsT21oVWZuV0ZBRVpScTBRMXNMU2t3VUhEVTFkYVd2TklK?=
 =?utf-8?B?d0pYbHVDaExXSHBROCtSZWxpWXdDaTFRTVlKMnhTY0dNZlhWRTBtd2hZYzVK?=
 =?utf-8?B?aVlmbDRFazZOYnFpMDhWVm50M0VScmY2ZGYxNUxvdW9Ma1RxeFlqY3FrK0l3?=
 =?utf-8?B?MG82SlhlUXBRKzdXY1RlS1JxL3FkdGVkclBDODh0THBqd1N2MFlSdisxVHZj?=
 =?utf-8?B?U085NUxEaWk1eEJPNWNzaUF1V041VzF0ZmFRL2x6bzltS01sdytaL1pOdU5W?=
 =?utf-8?B?aWRmWmMzUElabHFyNHhLdVBoc0d3R3hkSnZtd3FRL0ZjYVhVQXNIdytiTkJI?=
 =?utf-8?B?WE5EZVh1Y0JwOGM4MDlBTjhJUmRFaWQ2RXo5SUZNNmVWMzFpSWVldXRvTm0w?=
 =?utf-8?B?TGh4K3MwanM4dXpJbzVGNFdGOXFVcDlIRG96QU9ONFpYWnJuQ2N0Q01aTTU5?=
 =?utf-8?B?bHpvK0c4M3Rya0RwQW1Dem1VZGtlLzAxTWlWWDBuTE1BODZRUktwV3RMRUJT?=
 =?utf-8?B?MFZ1dUVWbG5hNzVDV0pKZE9OR0F0NGVyY29tenF1OTNqb1hhOVRyeWM4YjU2?=
 =?utf-8?B?d0E4anVWTklXWnpkMEQvTmRvOFg1Rm1pSHRMRmZ3d2Q2aFg1Tnpab0drUXdD?=
 =?utf-8?B?bnJKMlhZUXFSNUNrMlUwQzg1KzRIcDJqaTRZMEl1L2kvTmtiUGozL1ZtMm1y?=
 =?utf-8?B?M1ZYVXh5Wm1VNjkxZHpQVEtJcTVGclpQZUkrT0FZTTVPWUFaWko5NUZoMWVR?=
 =?utf-8?B?VENkc1BuNU54N0tpdkNJU3ZEeGtRT0xrTkpyVUJSMWp1N1hyamsrVzJ5SjdU?=
 =?utf-8?B?L05MYm5XaXE3Vm9FVUErTVJ6L0F5NjV3Ym9HYkZlazBKQVRGa0diOWNSV2g0?=
 =?utf-8?B?S29VRktFR3NXTlZDeUtaRFhGbml6YUpGU3U2a2JBaStUV0Nic0pxaXp0RnlS?=
 =?utf-8?B?b2RzcGtRdlBCMTNnYXlEU2hCd0FReWhUTDgrTjkzeHk3UzU2a3dQUGRDSjVY?=
 =?utf-8?B?VjVXd3h5WitrempNc2hIYnYxL1Uya1E4cVVTK21LQ1NwZEdQQnRiNjRiWDNQ?=
 =?utf-8?B?TVdhOFdFWWQ4MDZ4Q3Zzc1VuVG1SN0hWSjYyaVF0azFzUDdHZGszUTllbXRj?=
 =?utf-8?Q?KrGkFjUKUikS0UKRtXVK46A=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f2c380-60a9-4103-a8e6-08dc6f39dec8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 08:35:52.8841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHTmHBKa6W9wSUnZQZ+rUHOuzzSwdnqcQUYCQhhFzK8GMcPK1uLERqkKUs1nWnx7LtJCxB1dHpgsY0IjaoQzghgOJVNCNilHqDGG1w3lnEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8774
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

Hi Kever,

On 5/8/24 4:42 AM, Kever Yang wrote:
> Hi Quentin,
> 
>      Could you please update this patch with OF_UPSTREAM support?
> 

No, I cannot yet :/

Tiger is only available in Linux kernel v6.9-rcX and dts/ in U-Boot is 
currently at v6.8.

What are we supposed to do for this then?

Would bumping dts/ to an -rc tag be ok for U-Boot? After all, those are 
rc and not "stable" branches. Do we need to wait for the actual kernel 
release before bumping dts/ (so wait for up to 2 months before 
supporting a board in U-Boot)? Should we have an intermediate solution 
where we use the "old" model (NOT OF_UPSTREAM) until we bump dts/ to the 
latest kernel release and the DTS is available through OF_UPSTREAM?

Cheers,
Quentin
