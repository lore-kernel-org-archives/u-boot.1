Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A25C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 17:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AD5849B1;
	Tue,  7 Jul 2026 19:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Q1m4b431";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A41849BA; Tue,  7 Jul 2026 19:57:46 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF9B849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 19:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVY3O4f2hoMn8+tvUGxc+tqAHdQ8P9nBLpDKt3y2XqBNt523FMTeGDhWq2BaQsgfYs+WFJxo0O518fKKewxjHBWsZteks2qOgJlEGNDpncS6trZPsaha/A4fYNXvnAiPoRmiVNT1K9u6V68/tsU7ghRzK46LuJORo9aHYcFpnIE77qeRbyLwG5G7xZUzxVOCRFhjD5RRBg+YYgrcCG0Hich0RBduajWHHgFVg6xGCTMXeZ3D0+JcpQJF8bCryd+o0hjzFqk1ASDTADlHGEjHRiUl186pt3zqcKH+MQpGDypGaPfA7DkZ/9JKhs9VxwOMv5DtX6vfbngfHHUgPTSQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg6nxXCUFryRBS8qFvoeaIheSSPwDMm1D7yJM8QaEiM=;
 b=SeXvon6sQp465ejfACFeO/QfGdJR+SiByEhfh791zNSrXRFx/iXtMNJd1kn7XdN1lyAWW9Gg1jTgWGUxpSN7nLU0eoBYtGwMLVe/Tu4JMtc+bMrwvE2MX/XCSXTkjX9pPIJITZVL6Jt7ZEugVc9kJQ7hPhcZuPRQ+6MDNYmD3GTKRhEFIufrbmMpRc+ufs6HQYS8TOKjUJt+8TJgGHM67FYbLa4wnzQUCmL0ZB4taf43iQxgwDMM3iH5KQARdAKl1j38ntwG+m+p9ghm5XwCEfR3qmcI1aG25DNVZLHrK0FxoeCQ1J/0zYHHZ+jd+OCwLW+3qU5tEvlO6E3QpGCGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg6nxXCUFryRBS8qFvoeaIheSSPwDMm1D7yJM8QaEiM=;
 b=Q1m4b431A13ZHOJLlmaLWrrLZ9HoSnM55uvhqSLr/oxkxtfuyBbVTZs8xvpENg/yQMLEHkNGLg87Vj31gS45/c5QMQj7HzVXrzdF+c/Mhw6QTWIxlYze+sDfourOFvO6+5BTtxzqivyclm6AaEQdPiDHow7OyLrGAb400brnwqRAWYH8wRCGoNgGOMfdESBfVpqFJjen3reMttVPwBrXHxNglA23qnuIWvtI+uKZN9n94APmj7DrGb6CBCuRAb8JNSg2FpcirRoJoOz9omQGBC0D8tb9XDkyZv+lydkuCtxXekkB5UIxvmVlVrruOUJMOT6XrwmuT9aGw5FCprtczA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB6454.namprd03.prod.outlook.com (2603:10b6:a03:396::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:57:40 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 17:57:40 +0000
Message-ID: <6d83721c-9df5-4897-8de1-711b57d6cb46@altera.com>
Date: Tue, 7 Jul 2026 23:27:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: detect illegal command response in SPI mode
To: Peng Fan <peng.fan@oss.nxp.com>, Mart?? Alonso <martialonso11@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Han Xu <han.xu@nxp.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, Tom Rini
 <trini@konsulko.com>, Yanir Levin <yanir.levin@tandemg.com>
References: <20260614000543.2098992-1-martialonso11@gmail.com>
 <aktKeg8HrpWjhyRT@nxa18884-linux-1.ap.freescale.net>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <aktKeg8HrpWjhyRT@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd48eed-d3aa-46bc-60b2-08dedc513c80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|56012099006|22082099003|11063799006|18002099003|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info: GstSPt68km0xviBB+IDEJTYDAYhQkwQUaJ03UZnj4Bv8fwY3zQVefzUOIVO9Sx+NnqgktIaC3+gHWTTWmps7cSvFLXxoMlGLCh9xYw6eDJj74Az3qZ9+tR/RKjhi6HsvA2cD2xu3F0u9QvvOB5P8iCXl3n8l1sDs0XSiAe+e19uUVmuV5fvYuNLMkd7FQiSXtANGsamTEQxrtG0K6gyqAqatrDcTgAUKbKLUNdbrkDadumgq4bLrvzVFLhU7X7HDMycpErt2I2QogKye15sGdEj3zE2bPdyq0Z4MM7sJB0n/foml46U5XqnRwfuki93EtFUHrQ2C6w4IQv5XcjT+Vff1vpV6IA+ubKN30cgPlFsaSFfFa4Njl1W8aZrAdIGry5wGo4S0KJIcdUyYIpNW9Gk5RDY+lvMBbN6GlrWxdkaj44WqzQLitvpDrVxtDtELeryCpRsdHuei5VxW3LASpYG0U22U7AWvGSC43FBZUV8aB9qUaARicRolLH8JSovvKNXCon4cwXS2c7XiIxQCxv+OkuIoons05KmaXWZBeD9DSTRvvs0FoylEQLfo6QWSvQ4TWcw4Omb4B1L7BrdCNDL/I7kFBc3K1HP35xtRbMdEMJuTzAzZZTyObfMlxmzS/3p8eNCP5l6r83eoe2iYbNysjjr/TzSXutwx8H9gbPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(22082099003)(11063799006)(18002099003)(4143699003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGxKd0RjQ0xnb1p0d0ZRdURvaEFCQmVVVjV3ZHdPeC9mTmF6UTZyZm9rdlpr?=
 =?utf-8?B?bWVnUlZQM2ZDTExsemZnUXR3a2FLNDNSd1p4bkc3TTRQT1ZhbCthckl3WVRO?=
 =?utf-8?B?L25qSDdJMWlxZVg1VVRSYUFQL2tTeDduWXArSVBXNkJrd2hLQnVrRVVvTC84?=
 =?utf-8?B?NkJ4NXFKOHZubWduZGRXdUlxVTR6NHMvMDJHYjlHRGtjNXBVaStQZGd3a0Iw?=
 =?utf-8?B?MkpwNjdvTVRLVTBVWEo0dzlFL2szVWtWYVpQL0VTV0pzc2NISnl3OW9pYlBy?=
 =?utf-8?B?S1JpK0RlbHRudVliMmlZa29LcUJWNTJZQWdkbTlib0dwVzRjTm85a1ZuN1ZO?=
 =?utf-8?B?VE84UnhBNmlZV0FHRXpsQ3ZNeUZyWDUzYnZwUStOelhFNzFMRE1YanBPU0ZF?=
 =?utf-8?B?TGhyS1AvM0Y4bGR6SjdzeGtZeUFWUmk0aU5IcFpUL1hwem02NEQ4ZGdTRTZ0?=
 =?utf-8?B?MWpTUFIyQmx1bW1RWkNpbnptblNiYW9JY0hzdVdUNnhJRXA5d2hYNENiTnAr?=
 =?utf-8?B?NkhEdStPNHM1ZjM3MzZIaU5jUWx1c3l0WCtsWFliem9zOHBaV3ZkVnRkS2M1?=
 =?utf-8?B?TGpVdVUxNDZHRjFWRnZ6WTV6TkRsVmRhZmZiUVFNQkN3OFQwUjJyRVMzODVI?=
 =?utf-8?B?bjAzQ01lakMyR05za01LcEVweW5Rb2lMMjdwS3hFa0JSREp1OW51Visrc2c5?=
 =?utf-8?B?dktrWklkOWJ5K1NObldyRE1SaXZvZkRGVDZlZXFhZlgxWStFakFvN2xLclBX?=
 =?utf-8?B?d3Q3QUFTOE4wWW44azhTdmhJMUw4UGlnOFhsbkYrckZGd1o5cnZjRVdnL1c0?=
 =?utf-8?B?TDNMWTl1T1ZtK09CMjh1M1JhMUVBR3lGdTJJU1hEVCtLS29vQ1UzdzJ3Yitj?=
 =?utf-8?B?WGhkSlZ1QjdpMVJRYnZlUG16bjhVQUlsZ2M5WmQvdUhwbmNJcWZ5ejMyMmQr?=
 =?utf-8?B?cUNLT2JNVlRLNG84SmhsVEJHei8xVVQ1SnBmenYvTGpkdmdEdVh5SXp2c2w5?=
 =?utf-8?B?a2FiaHRmZFY3M3dHS1lab0YyYTdzcGppZDhhbTBXcDRtZWlHb2VYVHBTczRz?=
 =?utf-8?B?VGVxNjdwY2JHbGJPYlVTMXQ3VlVZZnVVblN4R0VPa2xZcFM5MHZ0OVB0anoz?=
 =?utf-8?B?aVRGNncxSjZPSWh4SVBzdGZHVitlOVBLaWNXeEVPSUNNVGo2YStMMWx5cllz?=
 =?utf-8?B?S1NhSnhBV0x5cHZWOU40M28wcmNaM0FFcWRpcHRJZUxRWjMweHgyQkpUaG1X?=
 =?utf-8?B?alBFTjBnbTFuRmREN3o5TFRjbWRLTk12UTNjenpoTGs3WDkwME5FdlozZHRp?=
 =?utf-8?B?NDBlU05LZ1JIczZDZEZ6ckk1UWJkeThXbVoyRUY2cTBFWkVEaU5ROFhEeW9O?=
 =?utf-8?B?WThQbTl0SVhCRTU1WUJlc0puWEFBeitTZWZUSUFidm1pc3krTy8rT2gvOG5r?=
 =?utf-8?B?Nnl5WUNOM24vcWZQVStDSlZuMnVNdkFMWjdqQWlNZ2xJNW1vTVhQRFNVTUt4?=
 =?utf-8?B?bXdONGZMRkVIbTBjSzNXQVdYNHd2U2I3QnN2VGF0b0I3bkkrRDVxS0ttcmJD?=
 =?utf-8?B?Ylc0NkZyN2tvL0dlL3p2aHplL3pyL1FSZk1jRmRMNXFJZUxhMEhrajIwK2NW?=
 =?utf-8?B?Wmd3T0ROcHNVZmRFSC9qaTJTS1N5K241ZW1sVm5QMEswU3ova2FWYXJ0bnV6?=
 =?utf-8?B?Q1pDYnI5dXpyam9lNGhrRWZFc0s5UUphMjA0WW5TSTBqaVVoNDZlNXV3RjVh?=
 =?utf-8?B?NUpla3JKeENLT2VoL0FBZUpKN2VKcmRkaDZicWRSTElqRWwvMDVOQVk2VzBV?=
 =?utf-8?B?djZvVm90dUpLd2pRNG13NkxBV0dVR3I1VE9PeXplSnlBbXhwSDdNbm5XZ1dS?=
 =?utf-8?B?ZjR3Y2hGT0JPbmJNcTJEbUdtTGFFNWlwOXBIa0FIMldDenBqajk2TnZSVTU4?=
 =?utf-8?B?OEZNcEM0Vy82N2dzZDlVOEtsZDNHdHFXQXdjRWNNdWpkbktSK0M3NXUyMUpL?=
 =?utf-8?B?dW5HUDJCSHRDeDRRWU91eFZlZVFXR0Zrald4TTdZY0JIRVJKVC9xZkpuWXZN?=
 =?utf-8?B?MjdsbE1IeU14WHBLNElHeGxpWFV3VGdCVXJmUlJXc3NHemhZNU5aTnprbHFn?=
 =?utf-8?B?RjRqbU5yYUk0U2FzUXdxVm1WUVdROG1IWFNBNk9uRkNBUWtFUDJRa1F2OWNL?=
 =?utf-8?B?LzdiRGNVaTEybCtKUE1PazY3OUlOSHJEQVQ3WFV5cWNJR1NVV0RFQ0RZaWJX?=
 =?utf-8?B?bUliS2hvVHo0M0g5UEhFdCtXaVBxNHVPTnNPZ0RrK1ZSVHREeWludGZ0U2lC?=
 =?utf-8?B?OW92bHhxQ3VFNzhSeUxpMmprMURSbzJLaTVNbGNKVHI1YUdFUWRvZ3N0RTc0?=
 =?utf-8?Q?kVug38QnkMRzkjpM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd48eed-d3aa-46bc-60b2-08dedc513c80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:57:40.2535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W12zQgNstuHRxs6c1SgKk0GnuEAVkkWGW66CZcSGnyOpaBCgtKLv76H3Am/ZrE3i3tXwXhu7rRYYiBA1lg4rlRigCamA/Aog8xtTustmoFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6454
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


On 7/6/2026 11:56 AM, Peng Fan wrote:
> On Sun, Jun 14, 2026 at 02:04:37AM +0200, Mart?? Alonso wrote:
>> At idle state, prior initialization, MMC cards (not SD) will respond
>> with illegal command to anything other than CMD1 (MMC_SEND_OP_COND) and
>> CMD58 (MMC_READ_OCR). The MMC driver initially sends CMD8
>> (SD_SEND_IF_COND) to check for an SD card, but this needs to return an
>> error, if not an SD card, so it can later check for an MMC card with
>> CMD1 (MMC_SEND_OP_COND).
> CMD8 is supported in SD 2.0+, so this might break SD 1.0.
>
>> Additionally, CMD55 + ACMD41 (SD_APP_SEND_OP_COND) can be skipped if
>> CMD8 (SD_SEND_IF_COND) already failed.
>>
Peng is correct. CMD8 was introduced in SD spec v2.0, so SD v1.x cards
return an illegal command response to it - identical to MMC. CMD8 failure
alone cannot distinguish between SD v1.x and MMC.

ACMD41 is the correct discriminator: SD cards (v1.x and v2.0+) respond to
it; MMC cards do not. Only an ACMD41 timeout means the card is not SD.
The existing code handles this correctly by always attempting ACMD41
regardless of CMD8's result. See section 4.2.3 "Card Initialization and
Identification" of the SD Physical Layer Simplified Specification.

Regards,
Tanmay Kathpalia
