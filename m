Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A020CFD377
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 03:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E9383F4C;
	Tue, 25 Nov 2025 04:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fkhikvQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B38283F50; Tue, 25 Nov 2025 04:58:50 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A2783F4C
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kV9/XNWERqxI4+9fZGWRsOO9l3DetKEq9qltKDptcRzGpHkiyl9ZP2WW6p4OX9LsJAlML8rg0YucXjoXYj8eQJBF+F909HnAI1Sa65nXIihvtraUK3nxZMtHT6RPEJ88AeHb0V3kTiynwBqphfWw0QwawbwzR0ymd3qxGrmGP+vx0KsVCrSfPW7yzksnsBl8qUOZugApTBSX51nXkWbkZBP0/0pDh2nYkBTvB21Axfltc1TbYpOzd9riBlRSqQ8+/9jjMO7C7KobJR2jZ33GBlt0+Ev6epUpP2MF1vVTDGpppa9cklLLX4RpMAHOApu7gp1Yu7ypqKytH4KeVaJAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYrPXBHmI9r/kk3DK8luZmruK6tZn92EaT6nhwyBtyc=;
 b=LImYie24tQjdAjHtCTfkwhPg5jY7bDpEAmwqb8sf2J0/IO0euLgWlgQoJlctMKuGHkF9z0NyfRuyfbOpmxxyuRJXAiCM+f6VC28BGIeyG29SHIBOY0OvoiZb5vo1+82O4STfN4vVg5+INsAvarr+SW22ZEraZQOZLAz2juESP39uOK1mxEdASl293RlLn+BN79Mw6VNv+EvpFpDjWK/7Hr3aovOyCA+fpsGe0BszfOzfgzB4WcT08fM/iIbMDsOpy3E1PD43c32SHtmXS+/laxG4t/Lm7X9wdNB4nqUn4p1Rk6MVXBfXZ5ihV6RC/afInetQ/Li9OFTRWiYsuN7CaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYrPXBHmI9r/kk3DK8luZmruK6tZn92EaT6nhwyBtyc=;
 b=fkhikvQDk0Q4038Si8W6r1g/gIq/QsbFOTWxntqrjDA7zoW0gOlHa9ytey4CZ82ov0rNKvl7ARTQYkm88jsY+oienqBLWdPgAHJsYG2tc8MBSJ3JIXz92SmITHb0I8f8gWYgwPt4r8vz8CDr2BIBzB4G21Z5E/5ghPsM4eB/8xjQgFwK9fWon1n7kER+itNYQ2js4j5I3VJlmzZRqNR4yeWI0tbhp5hytuWByLpQZi7YQwzuWiI2dVTsJY31yHpWmFCEVe/gHfRTW82t4Dlyl1OKW4LjnMm1rPulDE6QR4qqTNogTOTbZ8LxKI6TROXF33MBeRJQfimOCfyOGR7vYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB4973.namprd03.prod.outlook.com (2603:10b6:208:1b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 25 Nov
 2025 03:58:38 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 03:58:38 +0000
Message-ID: <93c1f877-ac83-4802-bfc4-4338658d8e5e@altera.com>
Date: Tue, 25 Nov 2025 11:58:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <2a3e21ea1dd00565857793228cf1a0ee27d550db.1763140421.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <2a3e21ea1dd00565857793228cf1a0ee27d550db.1763140421.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN2PR03MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c05e64-f191-4e55-63ff-08de2bd6ea28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clhJSWpoKzZtTVNOKyt5TU9qUFRqc1lpaysvU2hQUnI3WVh1Y2hjdWpTcFpp?=
 =?utf-8?B?SnhzNUVaZzhOMkNySWtmdFhHUlYycTFadXhDZFVYZ053UEV4RTF3TDcremhz?=
 =?utf-8?B?K0pVTnpmdGV0V3Q3bEx2Yi9rZTNra1hwOEs1aDhhM0dXV2RCaS9TbjRKbUF3?=
 =?utf-8?B?SFM3Q2YwenVRSXlBaXYvZkFCVHVJWHdhVWxoMHRUUTRqelptb2ZUWld6czda?=
 =?utf-8?B?VWhibXlBZURkNWkvaWQ1Qk5mcGtrTEpvNlpDdStmWlQwVE1zdjhiTUVZejZU?=
 =?utf-8?B?RVVHS3UzdlFwMkxycVg2Z1dMcEd1MlI3WWFybTZvUXo5cGxSMFRuUUdFcHl1?=
 =?utf-8?B?M2hZR1BwbVBHYXNNSVBXSkRJbW1yZlIrUzdHbGlVNThYUHJFd1g0T2wvRkpt?=
 =?utf-8?B?dzV3OXdZWm9uME1lalFSYzBjc092OWJLU2I3UlJMcmNvdzZaaXJReEtqODBZ?=
 =?utf-8?B?M05lRHl1dlEvSmIxMEpnbVorZEUwa0tLT0ZKMFl6a3J4LzZySUplY3duTEty?=
 =?utf-8?B?YkdDaHM3cHNuN3JKaDM5QWlwNWJsRXJYU01pWWZLUXRpbHZueEE5NnMwb2Zq?=
 =?utf-8?B?S0JVSmJkT1NScFRHSkY3RVV3QTBoSXIrRG41QWhwY2VCUUdMR3BISTRaM1dK?=
 =?utf-8?B?VFVtaDlYaXBiWU15SmhhdTEwdjZ5azJvTDNPM2ZPamwyK0JmYWFvOGk0WTgz?=
 =?utf-8?B?SHo4WjZsTkJvVjBlKytVblIvaWZ1S2JDTnZEeDg1OU04ZlNVTURYbmpWeGJP?=
 =?utf-8?B?VHZSMHR4cHhmUUpYVVVLdzVCZGxVdU5NRXBFRHVRcmpTRUxFL3g2bkZycHZl?=
 =?utf-8?B?YSs1ajdYWjVZUGU1MVdMaG9DdGZrVEhnZEErOHkxVXdvT0pNZ2JWMHdHd3RK?=
 =?utf-8?B?bHgzWXc1dm04OCtDUk1FWjYwZkFpZ2VWUTJKREdLaHZFb2FTTXo2cGlrSWl1?=
 =?utf-8?B?VkxMMUp5RUVXUTRmUmpCUWpJbmpJS2o5QkRkSlp2eVZ4ZFpkVE14azVETGhQ?=
 =?utf-8?B?WmZRaUdKRk1PTXRsK2ViTklhaXR6WGVqWGhoR05raGM0VlZMbVpiK1QvZFJC?=
 =?utf-8?B?eXc4K0NnYUl5L0pnSDl6d3BuamVFVWNnbVJWeGpIbklwOHdxR041NURheTVJ?=
 =?utf-8?B?b00wRCtKaXNjTVNySGw5ZWV5c1hXU2xCUTJIOXBrSTk2c3MrM0Mxc0RHakxP?=
 =?utf-8?B?ek1ERGJqUXdoZWVQRVpTUTB5RnBGa29QM2lXemRDWmliQlpJUUwyQldNQjhu?=
 =?utf-8?B?QjhIeHFiRDJNRmhoRlpVcUFKTGl3d3R3YW9UOUladWxpUytMV0hCbXdyTnU0?=
 =?utf-8?B?ZlBsQXhJTmdtVzdhL0lCSnhWZ1hsRndGbjFIS2hPdko2N1VJSmRrbXJHQ3ZZ?=
 =?utf-8?B?Z2l6TE1wcno0emFXeEsxTHl6MzJWcXlwOGNUMXYyRkdrL2YxRWRYTFdJdlJJ?=
 =?utf-8?B?TklZYXJFa1NpOFRZY0R0TmhxNUxKN3FqYlBWc0xPc0IrL2xRYndRb0tGVEs3?=
 =?utf-8?B?QWJOUFR6OG1uazRqd25ZcFkwZlpWUWlGUkJwWmVWa0FOTU8ydE1QaTFramxL?=
 =?utf-8?B?WmJlbzVUMUFQdWlEa1BqMnhRRnBpaStpd3owV3kySlZ5UmJPK3Z2YmpYR29i?=
 =?utf-8?B?MUFTTnRWSWFPNjVsVVMybkVycFVQUHJwN1BnRzZ3YlVMWFBhQjNXQ0grSEx2?=
 =?utf-8?B?bGZnVUF2SGYwQ1ZuSlFIai9CclRmcFQzUnNIUXhnVlBLS3QyV0hhUThXcWdt?=
 =?utf-8?B?Yi9udWtDZDRMUlB5VWxpT2JmQUhEeFl2UThTYTR1WnBkMlAvdTQvV0NVWnpH?=
 =?utf-8?B?cWJCbnZEdXd1MWNITTc1UkIreFlSbERicjkvL09LWlFiN3JRcFQwQjRjb2I2?=
 =?utf-8?B?NHBnOXQ2WEEycEZQY3A5Vy81bUlYTDhvM2hqc2JMMGhoN2lCUUt1aC9SVFU2?=
 =?utf-8?Q?+y9siwNxAyLNpMucDV+//rlXbuPqlEEP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNNa2l2VWFsUGNUd0VJT1pDd3ZaK0h2S011QjJhRkk4NFArZnhrb0h3UUJS?=
 =?utf-8?B?bnBWckhPNEd4ZmpQUmVhNytLT08zYUFsQUVIbWVFaUtDbzhlTHdIMU9RdDll?=
 =?utf-8?B?UmRTWDF2eHpFOFY0a0ZudVhYdkJNb0psVFNTdUVPTklUc2NacSszL0YwbUJu?=
 =?utf-8?B?d0VscS81cy9ZOVFRL3kzQzBsL1U3d0FsbmV3eFcwbEl0VWc3K1JOZE1iM0dr?=
 =?utf-8?B?a21VeWhadjc3YXplZGRuNjUwNFZ6ZmRMZ0pxR3EwK2hCL1lnQU54bGljMUJE?=
 =?utf-8?B?L3pTMlZiL0VLZ2V3d3FER2djRy9ZUGFYOTh2UFF1OThGUS9nT2NyTWpjYUtX?=
 =?utf-8?B?TFlueUlyRWg2eUNLa2hoQXNwcGpGS2NsT3pORkNBcVFPZjhkS2V4UDdnenE3?=
 =?utf-8?B?RUlJMnNrWlAxdXZNckw4NVR6Q0JFZnhJZTdxaURBK25FUmRnR1NLMXhoaG5z?=
 =?utf-8?B?OUJkTUdCNmh4MDhNSCtMVTRtbmJ6Qm1IUVpDWmZKNW0rUU9ZRzVsKytVZ1Uy?=
 =?utf-8?B?M1lQOVhEZzlNZ042Q25lZjF0THl0dWFib1M5STF6ditJaWJxMXFsdUdPR3NM?=
 =?utf-8?B?L3FacTM0UHpVUWlKNHBWMHhmaTJLZ3pkZXVpQ1RBNFVnQm53a1V1R3ZsOGxF?=
 =?utf-8?B?M3NmSWF3QlFpY2J4eFVBeXVLSlNyQ0VKUk1rRXdjd1JhTXM4dUV6TklFbnlQ?=
 =?utf-8?B?SWJXMkYzemlJanllSXdlVWFHdmVicTAwbGtFY2VVMEZPeUxVcFpmbGh2RWVX?=
 =?utf-8?B?MWZiSGljOXBTVVdVdzAxSWhNS0xSWmNTK1ppNWJPaHBlMTc1bW9hTm5xUHRV?=
 =?utf-8?B?THdXRll4d0ppVGVTbFlkVE9sOWkvVERvWCtVQklmdVgvV1VobHE0cCt0VVZW?=
 =?utf-8?B?SGxxai9xZHg3dytCYjJhYkllYSs4Nk1RbmJMU1NReXdIUlU5L0orSzNFQWpK?=
 =?utf-8?B?b1IwVllYazdIS3hJMVZuTXQvTElVaVNuZTUwYlZMQzVlVE5zMG5VRUFBdXdO?=
 =?utf-8?B?RytTaW1tVVhnSE1vTDFacEM2M0kxM25TQUUwbDlhYkREd3lERE1qdndQaTl2?=
 =?utf-8?B?VzdFY3E2ak1Oc3phMm5oZng4UG1SUkJGblBtWGJQUi9Gc2laV1BjZnAvd3d4?=
 =?utf-8?B?R1FESk1pNmwzVjFqaFRQOXRIa3RvWW1HVjVBZ1k1NFBTbFVONEwxT05WOVNL?=
 =?utf-8?B?VVp5WXU4R3ZVOFR6QzVVSnRUSFpuQXJWeWhVaFZKQmxKUEtsTDROcHBmc2hr?=
 =?utf-8?B?K21ob1RiRTRPQkVXUXlkaG1xdmZLRWlwMXVCd0RPWGJYODVoeGZKM25oVWJh?=
 =?utf-8?B?ZjBtM1VhTzY0cFdacVg2L0E1ZzRIQ3ViQVlCbitTQTZZc08vYUQ3b1dsRzBx?=
 =?utf-8?B?RXhMNDRtWlRhY1lKTitOMUhPSDFRaXF3Yk5wSGs4c2RuWnJyejNoTi9RWDUr?=
 =?utf-8?B?WUlmdDZOVmtYNmhES21tMHB2dk05d2FBVnV4MDhaK3ZvNHZxOC9WbVBkNG1w?=
 =?utf-8?B?V1M1OFUydlJBcklBRUhISWlSNFJucnlnc2YveFE4YkJCMG9EaHBHcnpkN2R4?=
 =?utf-8?B?bUVnRlJ1MDBQK1lndlR3cUhzcFZuZ3IySXY4ejFYOXZPWGprSHdLQTdqeUNE?=
 =?utf-8?B?Z29VYXlrMjZYclNpTVZCaFhWdStNdVl5L014NW16M25SWEh0RnQvbDQwRFEx?=
 =?utf-8?B?VW5MTjc5YldyYXljWUtyZklGYk1mUURRUUlpQkd1T0VzeVlzLzA1Z3c5cVZD?=
 =?utf-8?B?L002TldXa3pYV2ZBaGdhUUVscWs4b056TVVrL0pkWGVVcjZRbGhKSk05YUpv?=
 =?utf-8?B?cW5tRmRvMERURENlR2NrZUdhQ1pHV1BERm1nTmJtaXUrWURRZGtkWTFISjl5?=
 =?utf-8?B?d096QmlPWlZiSVJKS1FQT3UzY3owMXZlZEtzamNNMk9hdWJONW9VNEo0d1o4?=
 =?utf-8?B?Q0JlOGFHSmV2VEpmZDd4YTVrSms4VzZhTEVORURqVDBSTndMR0RLTVh1OE90?=
 =?utf-8?B?VjdpWHJWYlppQ2E2em5jTkp0cVlyVDREZzhZdGx4aStaWlpMZW0vaUlEY1pL?=
 =?utf-8?B?dEJoMXlZbWxQeDlseGRFenhtQ2orNm9vUEZaNzFMUDBUVkErODNJeXlOWmJ4?=
 =?utf-8?B?WnlFT3o1ZW90VkFaZmo4LzRRWTRGMjB4Qk1DN291OS81YlJ6Q2p3Qk5Caitk?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c05e64-f191-4e55-63ff-08de2bd6ea28
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 03:58:38.6326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAKy9i64GbwfEUDJpXJR4rec0vwZ2KweCu/D/K77dM4SP4S9aqpPwyWyPnVs6CV63+1OQMwm75UQitQvoE/+O44GZqhOWLNwPNLab0MfRbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4973
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

Hi Jan,

On 15/11/2025 1:13 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
> far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
> by chance as both options were enabled.
>
> We also need to explicitly select SPL_LOAD_BLOCK when UES_PARTITION_TYPE
> is enabled, just like the other choices do.
>
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   common/spl/Kconfig   |  1 +
>   common/spl/spl_mmc.c | 16 ++++++++--------
>   include/part.h       |  3 ++-
>   3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 8dade2b501e..d24466b0c66 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -573,6 +573,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>
>   config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>          bool "MMC raw mode: by partition type"
> +       select SPL_LOAD_BLOCK
>          depends on DOS_PARTITION
>          help
>            Use partition type for specifying U-Boot partition on MMC/SD in
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 467114f8d9a..09e881c464c 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>          return 0;
>   }
>
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
> +    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>   static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>                                          struct spl_boot_device *bootdev,
>                                          struct mmc *mmc, int partition,
> @@ -415,19 +416,18 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>
>                  raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
>
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> -               ret = mmc_load_image_raw_partition(spl_image, bootdev,
> -                                                  mmc, raw_part,
> -                                                  raw_sect);
> -               if (!ret)
> -                       return 0;
> -#endif
>   #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>                  ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
>                                                  raw_sect +
>                                                  spl_mmc_raw_uboot_offset(part));
>                  if (!ret)
>                          return 0;
> +#else


There is a build issue when CONFIG_SYS_MMCSD_RAW_MODE is disabled.


common/spl/spl_mmc.c: In function ‘spl_mmc_load’: 
common/spl/spl_mmc.c:426:9: error: implicit declaration of function 
‘mmc_load_image_raw_partition’; did you mean 
‘mmc_load_image_raw_sector’? [-Werror=implicit-function-declaration] ret 
= mmc_load_image_raw_partition(spl_image, bootdev, 
^~~~~~~~~~~~~~~~~~~~~~~~~~~~ mmc_load_image_raw_sector cc1: some 
warnings being treated as errors make[2]: *** 
[scripts/Makefile.build:297: spl/common/spl/spl_mmc.o] Error 1 make[2]: 
*** Waiting for unfinished jobs....



In spl_mmc.c, the block currently guarded by #else should instead be:


#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
       defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)

Otherwise, mmc_load_image_raw_partition() becomes visible only in that 
branch, leading to:


error: implicit declaration of function ‘mmc_load_image_raw_partition’

This happens when both USE_SECTOR and USE_PARTITION{,_TYPE} are turned off.

Correcting the #else to #elif resolves the compilation error.

Thanks,
Tien Fong

