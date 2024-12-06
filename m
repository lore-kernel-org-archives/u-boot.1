Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F6DE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 10:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B9F895AE;
	Fri,  6 Dec 2024 11:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="LZ7pX5E3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB1F8959E; Fri,  6 Dec 2024 11:10:07 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 293E289639
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  6 Dec 2024 11:10:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQyWJNBxds0pShv7ySR5T43fvm1DFWgugkJ56XcHC0RguwkDLzjU/DHtbBsiLY2b9B3UjDcGFFzDaIkIcPmpkKObRftjDH9BRPuQ1o8CBL5Q+6xNa2xOj5IsAD4pUncX+N8gsN9OFbflPP7vQX03VW0thCbMtjwPLRmwqmQHUKHUpOm608bAM5vOqyBE2bauSW5btUlG3IZHz+rBCUETCcut8gaabGQwvox4olbas7/infe7smyoD8OZZUZBAFRlmDDfQKLfymr4MXvl3kye0VxTi3/e5JH+vzw5MBoidWZiYDtHkPZD4jL1JnUtGbLT9Bx9mfDaFiAehyz6urIs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRjnemkeTBIc2nPLfBb1J565g/xKCDHeKFFIqsmd13U=;
 b=OgBiV/dhzK/w62yROa+dNmU8bd2T94fL/FLJuAOXhRXrwg6scScG/m/H6eSy9j2LzdmKzGnsHI4gmmJx5ydf066wPhVvgmzFTN83KinlrbOdF7CpoHAcpg7YTUHDczHgno0Z4+T/BDq5R0HtwvUyfmZJb/JK5tFkA+X+1o1RzDIJ0+tjqvetCBQa7wd38pUiyGwJc536k7fl0hTOU/CyFoKh6aClN/c4JkT186l1sf0HaNjQEX8RXD1B1pgjJ4qX4Ir5oqYFZu+fODI6nevdQ310Wrn0bjTrid9bd2cGpsy6bE3mQjSE3vUEpg6weydAnMHKvnu501IF7AxAyNSHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRjnemkeTBIc2nPLfBb1J565g/xKCDHeKFFIqsmd13U=;
 b=LZ7pX5E3q8p+YKRoEzEGM7GgL8sAn2JsxEYwNPRE9WWrLzSDYW1euPy3PHuwIqCMFim+0D/tKmNNyIaQ+m9uYz8XtxTXBViQwRa+MVG9G4c4OkLJ2by+0dl2F4+jFuVOCIc9Ut6qOqOYyRbbT8Dp2fB8gWNPsmnx82hQiACVoOo5wA7NfJWYNGBz0pl0znqXguvqMmtCt07btsBBgdBRwb7q51hVN/uiJ3a6b7Sj2c8AWv0obLa7plqjHNB5gTLjPY55UITJLfo9GH5diyMfrWLF21KUP0I/El91cghBHS8lwyTO6WZx5ehwGTo/iLdkZQyKJyPGzuZZR6YWt6DDUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR1PPF13CFA81D0.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::289) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 6 Dec
 2024 10:10:01 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 10:10:01 +0000
Message-ID: <8c1496c6-7cac-43af-b273-35a2902eca62@softathome.com>
Date: Fri, 6 Dec 2024 11:10:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mbedtls: enable support of hkdf
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-2-philippe.reynes@softathome.com>
 <CAEfUkULsAXFeN1ALR4Cpipx17NXS2yj55+meZdzGjySM9_GX6Q@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkULsAXFeN1ALR4Cpipx17NXS2yj55+meZdzGjySM9_GX6Q@mail.gmail.com>
X-ClientProxiedBy: PR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::11) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR1PPF13CFA81D0:EE_
X-MS-Office365-Filtering-Correlation-Id: 26401781-3b7e-4220-9352-08dd15de258a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEFma2I3MUZsTVkwc0pUNkxWaGN4ak5nLzhwWkIwMEZId1VPMmVTTTFpNjRv?=
 =?utf-8?B?aUF2UkR1dVRmSCtkdlAwYjFXWC82NnVNb0xMVFZlT08yMnpKS29Iano3RWY3?=
 =?utf-8?B?cUhjNS9rakMwUitLcXl6VzFDL2J1d3lzU2x1aElQZmZhYllMbjdYQllPZGZZ?=
 =?utf-8?B?TUVpdGthYlp0NEg4TUVjTFZlUW83aDNnMEVGS0kvL2xLbUVCUHlIR2VuQmc0?=
 =?utf-8?B?Nm41RUtmTEdESGVrWi8zd1Z1NnU5bjZCbWdBVDJCMDdOSnl3K2NaZWdzVFRt?=
 =?utf-8?B?RzBZS29TUi80OVkvV0o2eGZlM3ZEYnBMRmdnOHVQTUN4ZWNHL0FmYkE3SjBT?=
 =?utf-8?B?YnlqTzZPYjVCNXI5VTgzYy9RMVVkSkgraGRjRXBFQVM1cDFQcURCYmhaNlhY?=
 =?utf-8?B?RjJXclFVTlFWUEx0b0RaUkEyUUpLc2Z6S1o3RnRrQ1FvMVNHMnd2Qnhtck1p?=
 =?utf-8?B?VE14SG1FcjZwMXdwdXpEVXVSM016QkFzRmd2OXR4RmV2RTh4eSs5bVpDbnBw?=
 =?utf-8?B?bG52TWFsZ24vRWhYWVpTZUQ2WHNqTEQ2ck13d2xmNytrd2x0QXZMUmk4NjF0?=
 =?utf-8?B?K2dKMkV2UHVwZ0haNlBMR3RsVzVRcFJoU0RkSC96LzhRYjVPR2JlL1V2aGJH?=
 =?utf-8?B?UUh5Y2JwNXVYTUhaYUd2V1pFaUQwS0F6OUVwcm9oV0Zhd3hkZUZZR2lDcHRh?=
 =?utf-8?B?MHNNVXNhZ2dOSnhTSmROWjFYaU5IRnRkNkpDZVJHa1kvUjllOThEWEJlM0hG?=
 =?utf-8?B?UkwvYzF0UlBiTU9pM3RRLzhFOU5mTXRBV0dnOUlTNFZhYlBSdnRhelNidldG?=
 =?utf-8?B?ck5GUU9QWGRvNHdQN2YrWHFKS1FHMzBjVi9yeFpORVJPclRNUlJ2b3Y1aTV0?=
 =?utf-8?B?N3MxRzNIY280aUM5L3YySTFTaEl3NkVET3l6cHJPaW5jU3FFb0xaMloweDlQ?=
 =?utf-8?B?ejU3VEdsMW1KemlTd2w0dW5SNjRWZm1obTlPaUJxa1FRZXJYRkw0dENYQVV2?=
 =?utf-8?B?a0o0R0VKb1BURkZKc2g1T2N2NzhTRmttVlhWSW9ZMFQ3ZzQrVGZRSUJyVjha?=
 =?utf-8?B?c3ZnekhXQ3pFbWRHdDhBTGRRUWNwRFA5cjAvdnhJVGdZRGRsb3pLRXJ2MVRr?=
 =?utf-8?B?YXVwMVVUanJoUGo1REhvdVd6U0dxYWZCYThXUVE2OEtBbmpYaWowaTFUdXVa?=
 =?utf-8?B?Rk5XM3lBUFRhbittVGNBV0d5TFQ3d0hvbFpWZVRRRzJlWlpFbjgwS2JTbVFN?=
 =?utf-8?B?Z3hrZ0pMY3ZIcER1cjJJTUo1NjY2c0g5R1RIUFQwQ2Z1Vyt0RldzRzRvZDBK?=
 =?utf-8?B?Z04wN2prOExXalVaK3d0cWozcXd4bkduajdWSW9XUHdJMHB3SXVaTjdzOVlu?=
 =?utf-8?B?VkV3Y0ZlL0d5QTVoWGJhOFFlbUh5UitxZXl0cXd1RGF6V2o2RjhESTBVY04z?=
 =?utf-8?B?ZVVzc0tBQzkzck9hTUs1YkRNNjFaSHRiK3pESWJBSlpGU080QSt1MDZVNFZl?=
 =?utf-8?B?ZzZoRWZIWXlJRXMyWmtBRUU2M2JQMTVvd25RZkwzaG5uMTRDM29zQm9rbHhQ?=
 =?utf-8?B?Y3F1a0d6Z3gzSlMzMS93QXBEL3dqLzJiMnpEbHpucUx4RkUyTld1Y2UvdzBy?=
 =?utf-8?B?M0d5Q0R2ait5ZzNMVjd6bEFWb1phNTZwSEo1R29adjVCQUJoRldDUmhoR1pD?=
 =?utf-8?B?MmJnekJQdC94VHNGVGZUaUNiWGpuNXlPVVJjSGtPa0FMWU9SRHBDaGdMdFky?=
 =?utf-8?B?cmR5MFg0QXg0emZDMFVQWDE0a0R0T0pHaysxRTRLQWMxWFZMQmR5cEU4Zlhu?=
 =?utf-8?B?N29uQVo5RTdDeitOM1lxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNxZkhaRExOS08yck1ndFpCdkNkMEZsRkFRMm11VGkrMi9xcXgxOE85ZW43?=
 =?utf-8?B?eGN4eUFLWGJBTFRLY01IbldmQ1BDblVuT1RsclFZd0NuVjQvdTkzV2pac3pV?=
 =?utf-8?B?Sm92VWdXQXdQNE0vd2VNbHlubk1hQmw5cHdacWFnWFJxNTlhOUVNaTRtam1m?=
 =?utf-8?B?UVNvcWV1SFR0SkhSTjhwNndDNnFMWGQ3TlFBc2Z1VlJaUnE1MXM4bVgvOFRP?=
 =?utf-8?B?QzVrTENXWXBBa1NzbTN5STN5bDZEV3VBQzJPQXVFVmVhNjVwaExwNFZ3NHpm?=
 =?utf-8?B?cWxMRXhLQUhwOEFNRHRkRG40b252YWxDT0hFKy9wa1VFcFczNEV3OGtLVzJ1?=
 =?utf-8?B?VUlPTks2ZWxpMUpwYkkwS3h0QUtINWhtR2xUdHpuMERYTVVzVE9nUE45bGhi?=
 =?utf-8?B?TWora1RHeWJpakdteDI5ZUR0V0ROV3hDK29HWGJiV1U0ODZiOXFqdkd0YUZp?=
 =?utf-8?B?d0hXZy9HcHFtTkRac2hsTU1CRjhXV0ExL2FwNUVPZUN3S0wxUmtUb0hIaXQz?=
 =?utf-8?B?OXE4NFROVU5rb05wZzFka05PS05BcDkybUZrajk0Z3Fxbm5kTFFtMGFUN0Ji?=
 =?utf-8?B?U0pnQlNwUjFnYkFCTXRnMlFkMTVlZjZSWTFyNGlhbXRXaXEvVm9qMlBFSm16?=
 =?utf-8?B?cTc2OHZkZGp3ZGZPZjBCaGxXQnlDUC85bDcxRXdEZEEzam5zb0hWT0pJU2Jm?=
 =?utf-8?B?MG1ibWdBQ3ZTQ1F0NmROZXJONUE4Sy91dGptRkgzS21xV1o2d2FYTkdJbUwz?=
 =?utf-8?B?ZmQ5U25QVXV4a1ZVdHFhMFgrckdxZWF6ay92RU5oMlc2TzJqeEZBc1ZoWnM0?=
 =?utf-8?B?M3Q4anJSOWlQdUxSZm5lKy9yZVQ2TFlMQlBZcWVkOXFrVml1djd4RTNsV0Zs?=
 =?utf-8?B?QnZUTUFsZWxtenhBbVYvVjBuVCtES3MzU1ZUL2UvOVpobGRiREFEcStuL3U0?=
 =?utf-8?B?cklUQXBUNGpUOVNXYUliVURKR2JzNG05UDJybG5tRk1wVE55dnBqeTN3cUI2?=
 =?utf-8?B?OHdYbDcyWUNHYTk2bnZiQmVLcXBCOUtqK2xkRmhrenZSSkJBeGJ4Z0UxSm5V?=
 =?utf-8?B?R3U1WDNBU1doVzFKS250bHVSd3lyZHNDTmhzSnU2YTlIeUtpeldNNjdPNVVR?=
 =?utf-8?B?Zkh0WmdPdXVHWEZhL2ZJNlRxZy9Gdzg2Z1ZXS0t2VmZ3dHZIN21YKzZFMVRo?=
 =?utf-8?B?ZkFOamJxMGNud0JPR0NOdDVJYVpkeUlTY0plS0ZaUURrYm1SUk1MVnowNVBs?=
 =?utf-8?B?K2FCcm5jeXVHNUVjTEx3TWM0cXg1WHlSMXh5WnQ0SERRekhBQ1RTOVpuck0y?=
 =?utf-8?B?WlpDM3pvTGpzUEN3YVZJVm9TMUw4UWxKbk8zY1YwbFRkTTB2MGYwMG84czdQ?=
 =?utf-8?B?Z0VsS0cxZXNjTU1GTDVxYncweWZOMUJUNDlKTXhRUExoazQwTnhUZWVsUmtw?=
 =?utf-8?B?ODluRkt6S202eUdmSkE3d1loTFpUS0tJR1ZIOWo2LzU1UFZHVHU2aTNselRq?=
 =?utf-8?B?RjltVVY1YlpCZFVGWldtNnpxZXRYZUo0QjQyMG9sQ3VXVHdXR3VBd0NiTWlu?=
 =?utf-8?B?b1ZUTU94NDgwNEVpNmExY3hneTd3cVNjYzBrSG9sWUlOc3Y3SUtkTUEvdUo2?=
 =?utf-8?B?U2xtVlBOTnBlNEt1d2tlVUZUQ0hwOGliOTEvK0xSaVJiZ1VwZmo1dTJROEcz?=
 =?utf-8?B?L213eXdtekhnc2JEcFAzOFkvVFVZdytmaGR3bEN6SEZvaGpuSnR4STRSci9M?=
 =?utf-8?B?cGNPdDczU0x4OW9rSEVtQXNOSWcydDBRMkh1WStZOGNYV0RMcTBkemVtdFpT?=
 =?utf-8?B?S0N6eHBtZVlGNGxYenIrNXEwN0xNb3d3bFZDeTNSNmJmbm5FQndoUTg1T2Mr?=
 =?utf-8?B?d3k0YkRJNyttZTNVS0c1NGN5ZUpQZkthRml6UUFzcXNaWVVad2daS0Z2eFFW?=
 =?utf-8?B?T3UvNVBmV3pHZ2NhdVhlYXZOVm1aZVV1aXdjVzhCSkVyTmw0TmFPRy9ucHdU?=
 =?utf-8?B?d1Z4R1ZXWk4rVnBDcHFFbzVkNElJNEgraFc1a1lzSGhGVHdFcGMvOG5XZVBi?=
 =?utf-8?B?VnZNUHVFNzRNM3NmTWdKUlN6dDRSY0ptZVlTNHpvUGw2TkpPWE5TSXFzL3p6?=
 =?utf-8?B?TTZhMUVlTEdmVW5tTHdHdlo5YXlKcUdzd1ZmSDFMQmhJeTRMeEdsZ1dab2cz?=
 =?utf-8?B?RUFYenFLR0NuQ1RyNzFkZ2Rickp2Y0JoTDhENG1Wd2dYQkJkUEUwRnR4ZFc5?=
 =?utf-8?B?cWEzSndkcTFlUzdDNzB0NllhdlNRPT0=?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26401781-3b7e-4220-9352-08dd15de258a
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 10:10:01.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sLGTd751QqB33NrWGT5+5mBeRpWbxYFHdLqIFiTYzvTU+FGFJxXZnl6yJ/XXq/Nd2ejq56e8ELaAYv7a8JvHgT5cQ+4sj1ghBqOcO5TLYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF13CFA81D0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,


Le 05/12/2024 à 18:08, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Wed, 4 Dec 2024 at 12:54, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds the support of key derivation using
>     the scheme hkdf.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      lib/mbedtls/Kconfig              | 14 ++++++++++++++
>      lib/mbedtls/Makefile             |  2 ++
>      lib/mbedtls/mbedtls_def_config.h |  4 ++++
>      3 files changed, 20 insertions(+)
>
>     diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
>     index 78167ffa252..aa82336ef14 100644
>     --- a/lib/mbedtls/Kconfig
>     +++ b/lib/mbedtls/Kconfig
>     @@ -297,6 +297,13 @@ config MD5_MBEDTLS
>               This option enables support of hashing using MD5 algorithm
>               with MbedTLS crypto library.
>
>     +config HKDF_MBEDTLS
>     +       bool "Enable HKDF support with MbedTLS crypto library"
>     +       depends on MBEDTLS_LIB_CRYPTO
>     +       help
>     +         This option enables support of key derivation using HKDF
>     algorithm
>     +         with MbedTLS crypto library.
>     +
>      if SPL
>
>      config SPL_SHA1_MBEDTLS
>     @@ -335,6 +342,13 @@ config SPL_MD5_MBEDTLS
>               This option enables support of hashing using MD5 algorithm
>               with MbedTLS crypto library.
>
>     +config SPL_HKDF_MBEDTLS
>     +       bool "Enable HKDF support in SPL with MbedTLS crypto library"
>     +       depends on MBEDTLS_LIB_CRYPTO
>     +       help
>     +         This option enables support of key derivation using HKDF
>     algorithm
>     +         with MbedTLS crypto library.
>     +
>      endif # SPL
>
>      endif # MBEDTLS_LIB_CRYPTO
>     diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
>     index ce0a61e4054..e66c2018d97 100644
>     --- a/lib/mbedtls/Makefile
>     +++ b/lib/mbedtls/Makefile
>     @@ -33,6 +33,8 @@
>     mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
>             $(MBEDTLS_LIB_DIR)/sha256.o
>      mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
>             $(MBEDTLS_LIB_DIR)/sha512.o
>     +mbedtls_lib_crypto-$(CONFIG_$(SPL_)HKDF_MBEDTLS) += \
>     +       $(MBEDTLS_LIB_DIR)/hkdf.o
>
> lib/mbedtls/hkdf.c does not exist in your patch series.


I think I have to keep to line because

The definition of MBEDTLS_LIB_DIR is:

MBEDTLS_LIB_DIR = external/mbedtls/library

So $(MBEDTLS_LIB_DIR)/hkdf.o reference the file:

lib/mbedtls/external/mbedtls/library/hkdf.c

and not the file lib/mbedtls//hkdf.c (that don't exist).


>      # MbedTLS X509 library
>      obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
>     diff --git a/lib/mbedtls/mbedtls_def_config.h
>     b/lib/mbedtls/mbedtls_def_config.h
>     index d27f017d084..cce0134d527 100644
>     --- a/lib/mbedtls/mbedtls_def_config.h
>     +++ b/lib/mbedtls/mbedtls_def_config.h
>     @@ -56,6 +56,10 @@
>      #endif
>      #endif
>
>     +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
>     +#define MBEDTLS_HKDF_C
>     +#endif
>     +
>      #if defined CONFIG_MBEDTLS_LIB_X509
>
>      #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
>     -- 
>     2.25.1
>
>
> Regards,
> Raymond

Regards,

Philippe

