Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5ECEDE99A
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 16:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3C889059;
	Tue, 10 Sep 2024 18:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="X3+0tjsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6102C890B9; Tue, 10 Sep 2024 18:46:34 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB14B88F6F
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 18:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUGKlliDW0Kt3Hd60R9qR5A2yXZ2NsoV7bVuaEz5JexgAmdLFFqRxIBTivC5RVFlCjd/ZIi1PbSHFeBQ/wPgcmzCuAwZHUT777OQvFtmyN+kgVhepShaIFlVHErOJttMGobCcDJ+b9N945VutDcA0HUvh1kMkMGuCmai64kfnBXE1vP/JjAFFJWSmOijo3OHHFSAC1T4ehZ4mEGUWspk6YOgTaSmmUbrGiE/Vze+EUr8iLe83fLQFd4WEDYzw2sgXpUWwbqVhcYZOhrkZynWBrbcG0oEnRT7faD1lX7SeIuwbQctMXbfL6+8F+nXuKUikwbrEvAOLmnXCAwL0cfDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e122+cn2BwaiZqBKOCHfkDgHnYlqFLX+NaDtbhpXfSs=;
 b=dk7OTgL1N2OUOdIq7NvEwQQZ1kwLz9I+LdoSTZrEFaWYNDMHiW5aWSYK7u4bTdDdbqiGCk0SI2whrhPbTKOB2T5Nhbmpa2Ix/OVwpYJMuGLkrB/+m5iZ8QzfPEN4h+YZCsjp9zEYLYcD0PIGZiHdkqjMUoCHzWOiNSGYOFavP/WbgZDRnFqOimGpK7hKVSavuXzDHg5ZEDO2lS1A6hqU7ZhRegobgO5/b0Oo2ouw+d4tvJq/6ZI50fbTlQjUOIgWyDV8wPoH9QoHWYW3+ubXlvgbDqHq6Y0g7F7yMVVgqCgT0IvEBAO4ilC69yzqixxlAay5CSTscseQKCD9PxNfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e122+cn2BwaiZqBKOCHfkDgHnYlqFLX+NaDtbhpXfSs=;
 b=X3+0tjsZSib0HbxUMu2YA/NSDTwVfINiZN8rXrdO7Zfe0JleCWnCdGwb5ENwjTcQYvbXZCrbS+o4BVcz2x2oyt2qUM9JIlsrDWvu7prGUldWoXeOKn+V2WiPeRSMA10LmWqmNs8rhlvZCI4RLU8dpWpagbF117OraBLx+kqZ7Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 16:46:26 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 16:46:26 +0000
Message-ID: <4bec0ca0-ef89-44ea-ab90-b07d1c0578f5@cherry.de>
Date: Tue, 10 Sep 2024 18:46:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ram: rockchip: Add separate RAM_ROCKCHIP_DEBUG
 config for TPL/SPL
To: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
 <20240903163858.1155218-4-lukasz.czechowski@thaumatec.com>
 <b67d7193-7cda-461b-92fe-e07faa55017e@rock-chips.com>
 <CABd623sqBjcVyK8Ht2q30Rjvv=DXR-nOwB9dadg0VZSG4SZp5g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABd623sqBjcVyK8Ht2q30Rjvv=DXR-nOwB9dadg0VZSG4SZp5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::23) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PAWPR04MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: 91111a3b-1375-45e6-5ce3-08dcd1b81c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCs5Y1cvcmlERmp3dDBIZk9ZRVZGMkUrRDQ1TlRTeVdGUGE4Zy9ERHkvajRz?=
 =?utf-8?B?a3ZoY0dsR0JZNmJXSDQxM1lOd0V0TTdQWlQ5SU8xYzd6aVM2MHhidlRBb0pO?=
 =?utf-8?B?Q1gvQUV2YTR5RDVkWnFVTHpRVkxuTnlxaGJ0NEF3UjdONkY0ZzZvS3RsYnov?=
 =?utf-8?B?S2RTa2M5QlFHQnFPZE51bXJ4Q2NISXN6c3FYc3piQ0pYaE9HaXBZQTdrbnFS?=
 =?utf-8?B?NVgrRjlYRXF0RGZJNVNxNjFMVWpZWWxva2xSZXNQSUd0ZWF3UWZwMUoxS09n?=
 =?utf-8?B?WkE2Kys1SzBzSktBb21OeEJYclhwbVRaNnAveVRPUE56eTI4QlA3ay9mU25W?=
 =?utf-8?B?QnhQWWVPeVlObVlQOXhKTjhwNnExMjluR09JQW1QKzNxS1dHUkFlbW5uWk91?=
 =?utf-8?B?Rmp4Yk1LS21NaWVpcEdQTTVKTFFnY2V1RmtjRm9uRUlIbytXTjR2TDlncDNa?=
 =?utf-8?B?cWpBUUh2bVl3RWRBQnZmR09EaGZFN3pXdXRWQkczUXc0S2Y5emNybUJTSjRO?=
 =?utf-8?B?ZzY2UlZFdXdtbzJzV0VJY2piQTlya0hhelJGTEVGQ2hOanloRzgva05xOUdC?=
 =?utf-8?B?N0U3UUpZV2toZW1BcFJVQXFOVVpjbXA0OXMwN2QydnBWbmZYalB0N3dHRUJH?=
 =?utf-8?B?MkRjSmJiTnF0RDBwRXZ1Z1I2cFpxUWNla1BFbUhOYy8wU0hNc1FwWm9OWkFX?=
 =?utf-8?B?NG91WXJuME9ld1BTc0Rza1ErMkFUeXo5djBrYm9hS3YzRXJzeXRkU0x3alB3?=
 =?utf-8?B?NW9CT1lsdTZiUUM1cVUrWVVrUnpOdmFmdGZJQkgrYXkvMk1GMTNwRXJFNVNh?=
 =?utf-8?B?ZlhTY3lCcGhSaXpvNW4xNDlVeWlOaEtaMk9UVUorakFWd3dZamJybVdudU84?=
 =?utf-8?B?QXpWTmozYnVjM2JDeVVtUDFnMVM3RTgweURRdU54Z0J4NWRWdStWL3RvYnI4?=
 =?utf-8?B?OWI1ZGZxNTRyd3BkQWprWXI4eTNzMHNNRFZQK2FuOVVST0gxSjNHQkhPamJC?=
 =?utf-8?B?RTl3VFE1eUZnamsxcjFBaWp2eFg5Y3ZrMFZEdExCNFowUGdWZmJ6M1J2TDl2?=
 =?utf-8?B?VjNsR2ZmK2FLL0N6OE11b1E4eFNQQmEwNm9LVlc5cHM2aEdOMFVEK1hyQTBn?=
 =?utf-8?B?dnFFalB3dDluT04wQ1NRNkVMd3Y2Wm56bG1Sc1Q1NnhkeW43dkYrSEUwb1Qr?=
 =?utf-8?B?NGZ1REhxRitZZWVQRGZSeG95aTVVTDk4N2s5Yk1tQmI3Wm1ocXRENTBUU3Rk?=
 =?utf-8?B?ZjFCMEthMEh1R2h2MG1Ha3FuMlphekVoVlJobjhVazg2Mng1TnBtU0ViV1hY?=
 =?utf-8?B?VWRPazdnVnBaVFhVZVVzdWQ3Z0JpSGV2aVRNVHpBaCtoMUpqU3g0UWdjMUVR?=
 =?utf-8?B?aXVEVkk2VXRrQ1RrQ2djWUtFVW9ScHBsdUw2ZFJZQlRGVHZDL1JPTkJrNnlV?=
 =?utf-8?B?UlBhcS9kanJNTG82OVFpSG5EOTF1cW53NzNpL1ZtWjU1TFRGL3lueDFQNXg0?=
 =?utf-8?B?bVI0Y09rQTFSdE9ra1FHOWI5eUdENTQ2dktHM290TDVqVHhQT1NhdXBFd2JI?=
 =?utf-8?B?OXl0Nkp0Q2xwdEcxSS9FYVZhL0hEQlhUL2VrNTlDdDlsUVh2c25vcjI2MEd1?=
 =?utf-8?B?M0RqWUxiTDBNZXVJMlhDN1JDYmNMSjg4UlBiUGt5a3NKSDFyZzhaMkJ1Tjc0?=
 =?utf-8?B?aVREM0hFTWpkaUVtK0JTblpkbFBQdEc2a1Zoa3g0aXpoRDMwQ0gyZG4yOVZk?=
 =?utf-8?Q?MnrAnB8wANniuvRhAo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0Z4czZNVGZFSjQ4QnNkb0l4OHRmNHRxNXlTUkdLbGwxTjJ6VjNycjhqczNq?=
 =?utf-8?B?SkJEVWdIbVJIaXVJWVljNEFqby8wZWN1MlJxWEp0akRBN2dVYVhuN0p6UVVw?=
 =?utf-8?B?RytKSjBoQnhjR05Hc0kvTWplMlBkbSsrVEhNelJWZitUdm5OL2pPVkIvcnFu?=
 =?utf-8?B?TElCTzk1MkV4c2NkVFh4TmQwV2xSRTN6NEFTVzNhOFFYZXlPa0hDNG1rYWRm?=
 =?utf-8?B?YnRoakZvNXhrbDcraHBiUUpWWnJVaStjN1hZMTdFeHE4Zk9pTEdmcUFFOGlQ?=
 =?utf-8?B?aHpDbndNQkd2MUtIbERrTkhrT0oraVVjL2tQMkgxU3N1cTNNcTV3cXNpU3U4?=
 =?utf-8?B?d0taeStaNEx4TnlIcjZSMFBCVkhKV3h0a3BVSjlUcmhDN0RaUysvUnY4TG9R?=
 =?utf-8?B?SGN5TFRndEpXYTNnUlFVY0VIaU9ZY2ZzMTFQbmNLSW5qMEp6TWM2UlNKWWEv?=
 =?utf-8?B?ZmpvN1g2RlJ3ZTRIaENVenZYa2VHVDJ3aHVOMzJQWE9sRDdmUVFLZnJkYUgx?=
 =?utf-8?B?YVVDYnY2SC9WcEhEWHRUaEl1V05jUDBHNko4SVZoR25Oc2pMYkNyOGl2V1g1?=
 =?utf-8?B?bW5nS0NvSGoyR2k2WTZnUmtUS2JDY3BDVm9TVkFpZVdoU0RzUWIyTWpkeUlr?=
 =?utf-8?B?NU5OSXFhczE4WUdwa3pwQlZxY0M0UTA5VVNjNFl4S2Y1UmhwaDlycDlqTisy?=
 =?utf-8?B?cEgreXFVZHpFR0x4c1QrTWx6S2lMeFFNUFcyZmM1WE95STg2cmM0SGt3SXht?=
 =?utf-8?B?K3FPWGFzdmxmalJSU1VrT0ZFakFYSlEyck93dWhkWnE4U3RBcUJIWVB2THpS?=
 =?utf-8?B?aXZ3Y1Q2RHpVMWlCS2JxSnAxbUdRMzk2Zkc2M014cnViLzUwak01ZFJjeWZT?=
 =?utf-8?B?NmY2TkthREtPWTNxeVR6VG9rMHpmanBPck81MWljK2VDTU44b2RjSXdXSzRS?=
 =?utf-8?B?U0Q4SlBkcUk1Q01xOWk0djdYYTN5aVpPLzlCV0oxRis4VjdZd3VFNllPSDFl?=
 =?utf-8?B?djM4UE1mYUdGWHR0SkMrUVlHRjdzaWJtSEVDRnRhWThuU3gwbEpwSEV5UFgz?=
 =?utf-8?B?ZjlPbXdLUitXYTk4eFBiUXBwbTZKUytaMGhpcG1ETWpnYUE1VFFNS3A2VzBF?=
 =?utf-8?B?YWkvdG1DbnF5YTdaZWlDOXZ5ekF1eEhuanBSQncvSEFmeER3VTh5d0tXTUFj?=
 =?utf-8?B?SHVzSUJXbFVreTJtcnlUT3o0M2ZqSzhiRXdOeExNazNPSjk2TkZsallFSnVY?=
 =?utf-8?B?eGYzTE9PWVJ2czhMeFZIWm84ZFhQeTBGOWVwQ0FCaTczSDNHN2laTUkxbjNl?=
 =?utf-8?B?aTVqcU5nbXhkUks0cjNyMVVZb1QrV0s2YWV2OVYycUdFdHdPOGxIY01DOE55?=
 =?utf-8?B?ajJPZEVXM3ZBTmN1Y0VlamJoOXNsZ3FFZWpjaFV0Q29leGhHelc2ZktDVGFO?=
 =?utf-8?B?OEFHYWNzYWFTWnl2Wkxiam5oWUdwMFE2NUtqNEJTY0JkQ0RUL0NuL0hjZEFF?=
 =?utf-8?B?ZnpCRStVdDRpSkw3T1ltbkd2VDYxWDhoZkZhV3hIV0h4QWR6K0pJeHlTcUlO?=
 =?utf-8?B?WnRrOHZhUURPelZKbS9EMVp3SHlVanRuTDFGS1Iya2J4SVNLZzdrUHNiQnJ5?=
 =?utf-8?B?UVNaeVJEN2drSzY1Z0h5b0FwQzBGMTlGdU4vdkFYSjRzMmxFYkI0RDJ6dldx?=
 =?utf-8?B?NmNrUFpvM01ha29tekwwQlh1ZFJNYlNwTTVlRk5QS1YzendjallRYm14Wk9L?=
 =?utf-8?B?dkxtV1pKVTNkdmt1VGNObXFtR1U4dUFnOEQ2bzRqalIxWkxYVHEyanEvVEhj?=
 =?utf-8?B?RTVNMUpmdGJ1aUNzZDlmM1YrY2dvYkVOUjJRSHkrOEJKeUtqQk01cmxkZWQv?=
 =?utf-8?B?M1BkNVlYU2JCOEM4b0QwK21ia3dLd29VanRvVGJtdG02WVJCZ1I1QUZXdlhT?=
 =?utf-8?B?NHI2cjFzSTh4N2VQekJTbGxOQVVUV0Z3RlpLQkN0L0NGWmJCU0tqcXpOWHNv?=
 =?utf-8?B?SUxVMzhxU0QwWGRTS3pYc1VoSXhDZ2dqR0VDeXdrMWVTRStvdU40YXBVNnV1?=
 =?utf-8?B?ZCtjdXBDTS9vVUpCSEtGTDVjZFhDeXZScS9sMEdlNkJHL1hqYTVGcjZ4azdn?=
 =?utf-8?B?eHdZeWVldCs1cHFKd0NCeU0xRHAzU2dMeTBTZGlXMkJSeG9lT1RkQmZDZ0V2?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91111a3b-1375-45e6-5ce3-08dcd1b81c71
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 16:46:26.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqXmuagbL4+U4WRGOGX9b1SvvXzv03v44SyFRzwb4itfZ1Brp94cnQhJuw/wQDOeQE79cd8zOScobS5kgyn9lLEyj3CY+dmsuoASdWsgsd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9910
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

Hi Kever, Lukasz,

On 9/10/24 5:17 PM, Łukasz Czechowski wrote:
> Hi Kever,
> Thanks for the review.
> This patch is indeed intended to disallow enabling RAM_ROCKCHIP_DEBUG
> when SILENT_CONSOLE is enabled and control what is printed on the
> debug console more independently. Patch was created in response to
> review of patchset v1, and implements change suggested by Quentin
> Schulz <quentin.schulz@cherry.de>. The additional complexity with new
> TPL/SPL symbols had been added because we couldn't simply add i.e.
> `depends on !TPL_SILENT_CONSOLE if TPL` and  `depends on
> !SPL_SILENT_CONSOLE if SPL`.
> @Quentin, is it fine with you that we can drop this change?
> 
> Best regards,
> Lukasz
> 

@Lukasz, please use interleaved style instead of top posting.

c.f. 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions 
and https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

You also may want to look into your mail client as Kever's answer is now 
at the same level as your original patch instead of a quote within a 
quote making it harder to know who wrote what and when.

> 
> wt., 10 wrz 2024 o 11:51 Kever Yang <kever.yang@rock-chips.com> napisał(a):
>>
>> Hi Lukasz,
>>
>> On 2024/9/4 00:38, Lukasz Czechowski wrote:
>>
>> Introduce new config symbols TPL_RAM_ROCKCHIP_DEBUG and
>> SPL_RAM_ROCKCHIP_DEBUG to allow for better dependencies control
>> of RAM driver debugging configuration.
>>
>> The RAM_ROCKCHIP_DEBUG should enough because this only happen when ram driver
>>
>> running the initialization, and this init process always only run only once for all SoCs.
>>
>> RAM_ROCKCHIP_DEBUG depends on DEBUG_UART is the correct and no need to add more
>>
>> other dependency.
>>
>> Add negative dependencies to TPL_SILENT_CONSOLE and
>> SPL_SILENT_CONSOLE, respectively.
>>
>> I believe this is he main target, you want to control the UART output by SILENT_CONTROL,
>>
>> but the RAM_DEBUG should follow the DEBUG_UART.
>>
>> So I think this patch is no need, please drop it.
>>

I have this gut feeling we shouldn't drop this patch but I couldn't find 
anything that would either confirm or contradict this gut feeling in the 
hour I looked.

I assume one wouldn't enable DEBUG_UART when one wants a silent console 
in the first stage (TPL or SPL, whatever that is) which is usually where 
DRAM happens (that may change with VBE I believe? but we're not entirely 
there yet). So I guess the dependency on DEBUG_UART is actually 
"stronger" than a dependency on TPL/SPL_SILENT_CONSOLE and therefore we 
should be able to drop this patch.

Cheers,
Quentin
