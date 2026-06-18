Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2165ACD98E2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 09:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F2C84874;
	Thu, 18 Jun 2026 11:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="yjxfSZ0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CC9848EB; Thu, 18 Jun 2026 11:16:28 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16306847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 11:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmZME0U6Ym4YH56JaXndf6o7i7k+OAl1xX6K6FjqoKh8RYPH49tsU4xlJIioxaGa3BHexUowjUV4D3a+rqBmlOxp8vhblmXz5UH3r5GTopmqm6snKfUEEzuZiQj8JLBjvzdfnABnicvpBBC/5bGjE1E5jnmlI9nA9mdCtI0/Ir1y1gSOW7VMEe3Y9/FSprjkfSPKlEJzUhEVel5ugkj4zgxb77hZW2kjaw/P970NiDK76yeMCCDHSutLUw6PjYfMYBA7ihkpZwAP2JrbfKZeVUZOQzMyqEAcKtAsx9rcPxiBXN8xshB9xUDZrcxr8QTrqSG37TI4cFf/amnwEIoE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zn2tmnUnymRAt+BVBDLsV7KYVQauGsxgPF/vq0w4S0=;
 b=DAc7MgDXYKGyXfs21sEuykNrgITpDOioTQJUhVaOwWvq/WUbDbn1nwxjAUQceLtJy1ubWs3cpfcAQJ8aS2afuClScflAE2wwdOC3H2BoFfxAkMrDbKgNgtYxoCLNHrq5Fb3moIXAVmtYw9z7nPOiPACu6wUnP0UeWyF0RmNW4prA22vySNUIdAI7Uw2uROW3dcss35oUTKRC0LYLSa3jxx9RQ1OtZNvLTq4dLm6W9AKAObinsKj0CqQDvSqFjoUnrzaIaaAQrNFE+/Tlt5hMcCZI/QPDHdBWKtiXnH2w7eEben2O3arP5dXSZxWHDS+Mouxmwu7QnajgWff295Vc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zn2tmnUnymRAt+BVBDLsV7KYVQauGsxgPF/vq0w4S0=;
 b=yjxfSZ0GQIqXN/+okNDTTTbmKMLGnI9V1ivh5kgFVpq7/t0jj4WxaFcI9rw00P6q9yYJVhahzRc3noPTECQ0bRJ9TLUaUc586wZcftzeBlPhYeMGnVHNYyO/5USmIxhQ9b6OBsCsHesWrGIyjDnbZWzkpbwJndu/lqy4oDq/3ot2N2esjJfzcfGWdUEIabq6BzSiBdwQfABKHNF7z0pCXVDqY5ZB9yBPCjeptj1dLaa7Ljs5WWxFtp8RprcpyXgqCRFoa4YwJkctaOxL4wyJEJvOT0+uc/5x9DZhZCea3RlU/0SA4+re7G7vxfH1p4od4bGQPfuygGjaONDMsp1pgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by VI0PR10MB9466.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 09:16:21 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 09:16:21 +0000
Message-ID: <6e83756f-5ed4-4f89-85b2-1a65419e9ac4@siemens.com>
Date: Thu, 18 Jun 2026 11:16:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
 <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
 <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
 <CAC_iWjL2f6oHSfGYtiDy2rPUzpDKRdwR7RvEJUQaNqxO0rc70Q@mail.gmail.com>
 <35833068-3d06-4661-b98a-1633a6afbbb7@siemens.com>
 <CAC_iWjJ-dMsT3W5fSZ8KUFZeUz8djPw4gs2WHZsfhOjZ6jktGw@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjJ-dMsT3W5fSZ8KUFZeUz8djPw4gs2WHZsfhOjZ6jktGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0291.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::26) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|VI0PR10MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e689236-5511-4b3b-38af-08decd1a42f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|23010399003|55112099003|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: kYu4A3Knd7aCogRC3D8WxNMXeT/mxGuErq8N502DqK6d4mCUJ96sRkLCsYznscBuET0xD8mM7iDLSOAK8z3HxZ829mS2DLrS5GTcULIoUDMtqDCAA3g29wBMtgUvqPbD5ANUAbvqS4E7jhL5nVRC6Mfwl0a4796kX8nca3Fa4xcDs75Q4DUm4bxnvPu/y+3Ri1nhf+hRauf/OIS4/YVH0yg+xqSp+Ixf3doFDEfr7hPjNAl1lh0Vpap7sKdnKD1Vv3UElgXuB4SWxNxMPmRXNCxbE5taa9zWdUeC31ccRxrtQnQgotyAaC7csPCW0N+qBJIKXuk6A+kCvnz6WH/vNy7pUFFjcIY1FAnGSAj8uBYSxo/vSYAu/SWcr6iafakFWU5rGe7Qlij7d65VAbbJriwiRNbJTZpVTMddfqRxHlL4Tin8NEOYvpiOMNnZSvwJkr7p7JJN7BOhGG60UA6Yok6nPu+BtcdoIgqpCU8g0TQvxYIrMsQi5GTxKyUxwr87uF89wCHQPSwMdiziJEcu1LVN4CjkIqsZmoCwtB7PAV0GzRp+DL1NFIzxNGNYYDAzo41sF+7fQx6hgI3HWID5enJjDizjxVw/8NujzVXF/KWpYqweDACquVNxJovE/Wh3IuPsmrHYegv4IfPURrgYdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(55112099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUtlN3dTZzRLV25odDlXdkEwL3VxUXhlbzV4S21YbXBqT2MvVUNHRmczY2Ey?=
 =?utf-8?B?UWFqVkhXTXlma2ZsTFhUZStHV1pWN0pqbHpOcnJxMjU1ZHYzZ0Q4WFVyY0pp?=
 =?utf-8?B?emVnVFNCVVloU2QwbEkzYmRzUG44cHVLUUI2MUgrNlFqdTVZajB5ZnlhQS9H?=
 =?utf-8?B?RHFsS2VJcERmMWpRbmhzVFJMWVY0ZWxxOVVBaUh5K2o5SFZadERoTEd1WUhu?=
 =?utf-8?B?SGpkRWdVVXpGNTRKd3VzVEFIU09aNUY5MFNmZFNKNjZtWG56V3l2WDd1YzRq?=
 =?utf-8?B?ajNIZWh5T1ZJSm5YZ0VYUXRFQ002Y05iYXJnR3NET2pDd25NQ0hDbzYySkg0?=
 =?utf-8?B?U1YyUlhIUnBybXJ6MGZvaWZzQlM4N2o5N0dvcG9EOVMzeUZMUWI4SEFYdVU4?=
 =?utf-8?B?a09DcGkxRUpicjBuRm1MRjEvZWUvREJFRkc3REwzcW4wYnZPbjhpMVBBUTVk?=
 =?utf-8?B?VlJqeXNHWDNBVEJKL29GcEU2eE1UQ2F5N0RKRjF5WVVkMXduU1hqRWdsdkhP?=
 =?utf-8?B?WDJmVnFSZGE1ZEV1U0pUMlZjVlQ0TCtheE9VRVhkT1pLTzFXR01WMk5SYXNQ?=
 =?utf-8?B?c25UNGxoTDl5cnNxc2N2UzltTXo1cHV6aHVrd0pyRmZnTmNMNSt2eWpKVWhq?=
 =?utf-8?B?QXVqZ0xXWFkvVXI3dHJ6OHZaYlVmT2tkNFErelRBWWl3eEdSOHNaWEFXbTla?=
 =?utf-8?B?dHlpOWJwSzZBWVAvSHFKc1o2YzVkalNPa2FBS1lqZG9DNitEcTZpbTJiTVdF?=
 =?utf-8?B?RnBqYmN5RGIwMjJsRWdiaUI4b0w5MnhZN2FkMm82aEh0UTlqZDduMmN4V21L?=
 =?utf-8?B?ckhxOU5tNTc3VDRZc09IUmd2VXFyb1FrLzNlTEs4VXcrMzdGSWtEeHVjOEhr?=
 =?utf-8?B?MlZROUg2REVaaUsxbXh6VkRHT3RVL05zNmhsdUY4aEVjN2ducHVSNllvSDFy?=
 =?utf-8?B?V1IwaVd4WjN3YzduQi8wdTVoUjF1SkF5TjlVa3UrN3JHZWN5VTNmalVWTktt?=
 =?utf-8?B?ZVUrZDY3UVgxRlJFNVZWUDJsODdKMDZ6cnVlVDFIMlJIZHJEbUUxNVVoRDE4?=
 =?utf-8?B?OWpmTDJkYzFSZzM3MWJyaVdDMFM0YkpMa29mam9YRDFjeWRIOGo3WWQ0MUR1?=
 =?utf-8?B?eVJzaGx5MTNpdXZ5TDRtWnJLNDFQazA5WGJxcmxUMzYvaXQxRmpWNnk3UkFG?=
 =?utf-8?B?RHk1Vk5lQ0RVU2xVOWhPWEFmMnJibUg1bVFtWUJNL0NIaXhqMFR2S0xRN2M4?=
 =?utf-8?B?bTZOeFducFhBTXRMMGR4bGJBaTJNZS9vZUsrUytQMFhoMFF1R2p1UWF0dGJk?=
 =?utf-8?B?OXJycDhreVdSOW5nRHIrOGE2TmdtUUd3Z2NKYVNhbDRPREpPUnhqVDVGcmRC?=
 =?utf-8?B?aDF6ckE4T3ZhRWl0VUtESW5vREljQjI1bDRFMFY4SHpOZGtLbEovRk92cTVm?=
 =?utf-8?B?R2wwNTFmcjBvVUlIVUxZSlg0dkhIVndxVTYwMVRWVFZxeGxXNVZ5a1VMWHJU?=
 =?utf-8?B?ckVpa0ZTQVRRUWNYTkREME1WWVRHR2VCR2p3c3VuVi9TdW9IN0plaWovMERF?=
 =?utf-8?B?ZTBXSG5WelFObHFKQlhNMXBLODBjSGg2R056L3RXODNGbXg2TmVqVzlTV1NH?=
 =?utf-8?B?ZXMwaW95UDBWaTM0TTdBQm1WNWwyclEwVGZhaDBjN29YZ0t3b2J2KzVid0Nk?=
 =?utf-8?B?a0Mzckg1aXJ5V24rVVJCeVRGYnJKQ3N5TDJrOFIweTBDVFEvalZzcEV4V1F3?=
 =?utf-8?B?VDZCY3RacFdMMzc5bmM0UkVJTTBEM2UyRmZGOG1TUG84Um5DWDc2U3p6WUxI?=
 =?utf-8?B?aFF4K1NqaEFMKzVDZGZJRzQ4aURKZ1NLOFYwUWI5K2RwVlo2M0NNZUhEN0Rv?=
 =?utf-8?B?SjBKZmRlWHdxNFd1NVZrOHZOMFN1N2x3Ky8yQzdNc1JtSFZnampTYit4eEx3?=
 =?utf-8?B?WGZnaFJvZ3VlSVdjMWZmT0U4SWVvdVBIelgxbXdtRnJYVk1LUmIzS1huUTVv?=
 =?utf-8?B?ZGxtc0RhVDB2UzhCcGUvYXpCcVNuOUozalVldys2MUxEOERDanBOa0doMlY0?=
 =?utf-8?B?YVR1VzA1bkh5MUJaVFhQcUYwVnlmbzFtRzZHMmJMZFk1YzhzK240alowMmpB?=
 =?utf-8?B?UzIvdEZwc3Vud0Jwc1NyWHlRcG5JYjNKemI3MGRybUJLNEVOeE5OQXNVQksr?=
 =?utf-8?B?VFhwQ2dKRjlpV2NiMWpqYThPbWZkZkVwRlQ4WDlSQ2ZEK1ZMVzVmUWlHTWJI?=
 =?utf-8?B?NVF1ZGdOTldFZU83ZHZVN1d4R1cyVUtBQXQ0ZktJYTdGU0hqVjd6Q0swY0c3?=
 =?utf-8?B?SElaVVVzT1RWYjgydDJSQmkvVUJkMkJnTFFObytBamtiSUhXbXdaQXdiczBu?=
 =?utf-8?Q?osacfxn/i0GjizDw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e689236-5511-4b3b-38af-08decd1a42f7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:16:21.2002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kaZW5zJyypNP0W4d1VXE/lCzDZZz36OFh+ZQiyM5FM6LX4Y4ixSmfLPuhvDsiiIeXhkZSwIskei6ifoDrZZNqX5GNdI2ENEmqzJkoeWqJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9466
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

On 6/16/26 13:46, Ilias Apalodimas wrote:
>> [...]
>> Anyway, do you want me to submit your two patches as part of the series
>> or you want to follow up yourself?
> 
> Carry them over imho, they were rotting in my branches for 1+ years,
> but I never had the chance to send them. Your patches were a good
> reason to rebase and revive them and they fit right in as can only
> rely on tcg2_measurement_init now.  I'll test/check the v4. I haven't
> gone through your changes in depth but they seemed reasonable, so I
> think this is fairly close on getting in

With the patches on top the testsuite weirdly fails in platforms 
xilinx_versal_virt:
https://github.com/u-boot/u-boot/pull/987

Works without:
https://github.com/u-boot/u-boot/pull/989

I can't figure out why though. While investigating I noticed that I need 
to re-introduce the elog parameter to the measurement functions so the 
integration actually has a chance for now, short of using dev->priv->log 
always.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
