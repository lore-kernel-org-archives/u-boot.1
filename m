Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A2C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 06:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E141B80C2A;
	Thu, 20 Aug 2026 06:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GicrkR8Kd-CM; Thu, 20 Aug 2026 06:35:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787207714;
	bh=DvuhklTBK+9j+kNuc7SmO5+NQYjZTktL//3ytU0xPsY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lNIG1fyzlfBdaRWWRe3JHqQo4/SMwTJB3xlXuuRRC1eRkzeCe4VbaUHNurUFbUyzW
	 sd/NCRwACw8wt45fu8FfqJ4wcO6ihlv0TsZicM4HDN8Xi9W5ouZF/ZPsN8wn3CtKoW
	 U8EPZIxv6ah+ZQkbN/xmbTCfcrKdjVcCiM9jmw0F1bUoJfiq215b6sOn/lUz0MGL7v
	 BwgsjZjH6zUQt5CH2PBcnqEC4sT+YITM8kz7FP64RxE76TuDrfLDw2+uGzJzSQ2IqG
	 u0AzeoT3h/+gCE46sY6nh6yarDgdqusfW8k6jKodDZV6in6AmiJhiwXliyDVW8IdEz
	 0x2jN+8Vs2OQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CD0C80C1C;
	Thu, 20 Aug 2026 06:35:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CFC52FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0056402EC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cfWNftr71w0n for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 06:35:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=CXk5mItw
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3AD3402E9
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTVHgq+D+gmLV6Yb75HskLya6YLltNaDrlbKM6VkaMNDtPSLqf3HdlzRKwWcKrTTmDe3Zww7cXG7+YZhkiswvekqUvhffq7zghJxPhyqpafZMUlk82t8CuD1PsLUdEvZXr0nShCYZelp9drJ8HOIyZ7/u9boFEenLw3Dguf5JmA2z4MWLvrI9EZPyVimzwQ/8qS2JYkn0C8gR/vFlpFWP1KLF8FBo/b+yZCjYBVWlHNHIvpKnC0ZLd99aG+hbN4i8GE8ayJd+N1WjlL+W9/PXCVgBzUseIYnqlPV5ntyQ5WXZiQksa58zjUfGCOBXoqGeRpBz+i+h8R/BZM6LrMDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvuhklTBK+9j+kNuc7SmO5+NQYjZTktL//3ytU0xPsY=;
 b=ab+SyeSHnRJg2UXhE5QCuRU795iz5j3WozdzGdhjz1E3fI8iYlp02ODmmAmbogj71vNJ/HbUh55rqmNJSoR1ztdSgprZf5UnEjcFCKcm0X07rrIlrpqF/D67pAmPEm8XAvFbffh0HfIf9j6AfhrGGCDhh4fVNBUIm/GCOG89hcVRPmrwGytE/pf9nJr3iatR9/eXEqnWE9ueAdNaWhq1aAL0R99O11g3H3CTMSbN0E3fbjHEt9fEAzDRbyXwmiU/bA1/nZ3vNZnLZmlyp4bgZkGNoebBvFixvMHLIO9heAxZpN03EIm/LNqf+ySJUlTTmCGkRWXwGMlxQCqmEIiKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvuhklTBK+9j+kNuc7SmO5+NQYjZTktL//3ytU0xPsY=;
 b=CXk5mItw1wBsxhovT0URh2jJxeP9AVNVYM50auSUxk2Za0Lp5HS7oe6vxNBJWgDKxgUKfdJoOsBfw1QTyrq1Ry1f8WTGU0NV4ML+/o+Up46tlc5IMEBl/8bI99anBwk1p7Ub/rC32wB27SYel+w9nGMg8Bb8TTOSQpt2cFK2ZREdpfYnqTSchcRl8EeAtKKc+CA8DH09k/IRPrOeZ16ECAaRjHed6IWlSTPUbot3/NjEuy3MSOwhcCuRQK0B01t9c2fN0BGXGscXnNTj9aweV7/E3ELdST7LrJnT0zmsJYViGjibcsIgOlUl21CBzIFaeoaobCKAP5Q8X+nRhLJ/KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV2PR10MB6139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:77::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 06:34:58 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 06:34:58 +0000
Message-ID: <c81db5f1-600c-41a1-91d3-7638fc4d3d58@kontron.de>
Date: Thu, 20 Aug 2026 08:34:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Marek Vasut <marex@nabladev.com>, Frieder Schrempf <frieder@fris.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Simona Toaca <simona.toaca@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
 <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
 <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
 <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV2PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 020b9073-1562-40f2-639c-08defe8527c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vt3/dV+N3N47D4GkSuBmEzw89+9PUknRUlpY5rwiXiOSYPRnj3bieEeYxYpC9OBu08tJWza8d7EIPn3WMQIdepq/ZgUscyjWZvkYnU2RkPDfxJfc92mn/DINVnS62mhBUKup1v9w6J1l9KlgKHk86wIaNamqTOEUL6lLxj+G+z2y1ztHqpDeVN2fJA3O3sjvOMRbOFWFZKfQbdzJsNtgHCqJZ2raXGJKBT29X2y5Aq3CUCwm183X/fHNwHUieNOrym9vEJV5Z3R2ehrfUJrog0XtKx1EqgY0wGLscFzxPFKWXjG1mZUDN84IqDKIy14jDqE+EbpCnN0BdekBXihxZWkO3tOBBZFCyBfuDbms2yjma7UoG1XNtfM0Fw0/xRIaCXerNARTgxJmrxCIGXD14krWMUuogJojkSEDOZAxiQOo63HetripVhOnqosD27yVn+UiCx1GqNDbLZrJY3looP9tpWhgJxeqhrpiIKHwypyaQ1R9X/75ka2eFcEAoJniV3wWEJ7a+vCCbEopt7u8xELrqnWmM2POTARsYS3IjtsLak4IzrVLpqbQWJboPp665Pec7Unlwbc0/bGw1R7NWEMgnnBZENp1ILFA6wMWfpVRnOwY1aI2nABH0kdXIRABarIN8MJlYFtNPh1vzOK2LLFwRZIOTvddjifcUz5GFTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhIbnpiZG11VjFERE1jcmRRNm9pS2NPUWJwWHNaN0F6aEplS1lEdjRyWXRT?=
 =?utf-8?B?OGJvNmhMckZGZFN2Y1NrTm5VcWpvSVV3QmZXVnZyM1hNaW5lMU0rSnlvWG1i?=
 =?utf-8?B?eGtzcERaZS9wTnlNMFl3QVNqUW4wREhnRTZncDczQjQxbGVIbUc3S2o2cGhX?=
 =?utf-8?B?VjFxbjhWY3JheU5DMWVjS1lacG8rTXNpTUdkSmRZTDBEbjNMZ2NDelE2eUJw?=
 =?utf-8?B?clp1YkJnd1BVWlpIRHBFSXdOL0RXaTVlOFdTN1NDVTBjSk53MDU2cTZrQ2RF?=
 =?utf-8?B?aUd2eEg0Ykh5MnNvTnFXQkdyVERVQVI3TkMzbm12M1Y1OUZQdDFsaVJCdEJh?=
 =?utf-8?B?dXNXWVFSQzVmd1lPMzZTMU13bjhib0ZUSnZDV1lXWHVGZDQ1OUI2bEtDbTdC?=
 =?utf-8?B?ZHJ1S3hVcjlGckJlSzdUYmpJY1ROS09pRWYybGJBNDZLSFZxdlloWERRd1kx?=
 =?utf-8?B?TTAzbzZETk5TbEtKNzFDdFdUZ1VTOUhaRVlwOEJsWXBUUU1yMUVnOHFCRXlj?=
 =?utf-8?B?YzVFRGJoMFRGMDh1UDk0VGtEUU8xL05zYWZVTkhaaktzTHh1RU5OYmJXbXpL?=
 =?utf-8?B?VGlHUDZydVdVVmdnZHBkaENZenlLK3ZLMDVWYVVCSlZMdDJoUXYzME1UL3U1?=
 =?utf-8?B?L09RaTl1a2VKWTlyQlNMbUZHYjBYamE1Snh5NW56bEp3VU9iUjJkVitYdjZj?=
 =?utf-8?B?ZVRlTlJFREVIRU9nVkY5dzJITmFuK0Mzd1kwMzRtejIzYlh5NWhRQ2lHOXpB?=
 =?utf-8?B?aW9jd3ZxOXRDclc2b3pJeERCaFgvV0hVK25IQXRveVp4ZGJmbXA3NlhsVUZK?=
 =?utf-8?B?UW5XdnB6cFllNlRITVh2M0ZVYnVxbFlNQ2p4d1JvVk9GeE5XdmVGbjRvTUZY?=
 =?utf-8?B?TTdLZ1ZrSXdLeWwyL2h3bi8rb01BU2U3cGJYZTcxZHlscDRHU1JzN09BR3kz?=
 =?utf-8?B?RWx5WnRZSEl3TUlrbE0vOWxhZ3dKL3ZkT0Vzcmc0anhVK1RMK1dVUTduMGN1?=
 =?utf-8?B?eHd6V1BYeDUzb1FRYzZlbnEwS3lITFhMb2lubmlWK0p4MDZIbmc3Q0tXb29w?=
 =?utf-8?B?c1BUWWx3dVhKWUpSMU8xaENPbThuTnZRenlzRlg0OU1ReDBONW5DUDI0bFQv?=
 =?utf-8?B?cVJnWkdYTDZhSEJZeDJTZG5XeTNhMUpHRlF2c25tdzZhM2QzVmh6NkFFTVA3?=
 =?utf-8?B?M2lqY3c3ZDBFenJoKzVnSVdna2g3Ti8rOFZTbG5aazdXQmROQ05BMHI5V1Jo?=
 =?utf-8?B?Ry9Pd2dTdXUxQ2xSczJBRmh5UmRldEtrTUs5NDFKQzdCMUgvL3h6Q0E0dWhO?=
 =?utf-8?B?emxJOElUWWhnaGZQY3l2QTZHaHJ6TTN2MlV5SFo4WE9CQTg0N3N1OXBCSWVQ?=
 =?utf-8?B?dmM0OFZkWUN4SVlDTDIvekJKMFZEWHNHZHoxVXgrYSsvY1NOSHdEaEN3amhn?=
 =?utf-8?B?VTRQR2Y3d0JLeC9qZzBIWTBDQmc0Qm9rRUpKZ0VDK0dPNER5UERlaTl5YUJy?=
 =?utf-8?B?K25JRExDb3JjdnBiWHBNRXRSMDVSZW5lWXZ1bXJwUjZGVGxPdU9US1pvU0dL?=
 =?utf-8?B?cXdaS3kwVmcxMzNiYUV4VUVmcFArWERtSnRjVGpla25WNFJPRGVuOHhOWVc3?=
 =?utf-8?B?L2R2UUdBSEEvQ0NMbUk1Y29ZdjZrcnVFb0FsZEd0YUFoMnMydzhwQUpHUDJ0?=
 =?utf-8?B?UHZBUVVLN0xHY1JLYXY1c3h5SDlzUkkvYzVNZ2c5V3V6RnFZWkdjRndNckpS?=
 =?utf-8?B?bTRYQW9GR1Jib3VZT05YNEhpanB5dzQ5WG5lNzVQRlUrbGxiS0hHWmVLcW9w?=
 =?utf-8?B?S2ZqUzZLVlduTGN0SEhlVU16NFFuRXNTU093b3JlSk45NUFpcXA3eWVsUGtP?=
 =?utf-8?B?b0p5ZTZTRXVieFVxNmJiNHhndHJGbmgxY2plNnNaQlc4S2lWdDdnNUlWTjlk?=
 =?utf-8?B?NG1ZdVNqS2JRMWxHcE9TTGZ6Q1NBZ3JyUURDRld0YVc3aTlMVnVnUmxObC9k?=
 =?utf-8?B?WkpXL3BNbTFDZUg3L2J6V1V3SU1CbVk3OGlqdC9GY1l0cm05TVEwYmRHWCtQ?=
 =?utf-8?B?MElYZkRVenFJUGdrTVV1NEozUTNEbW9hVmFrTmNEdEVwYkgwOGg0Q0gxVFpl?=
 =?utf-8?B?ZFJCM1lPbStqeS9iRVJSZGJralJ1d1B6NEU2bWRqZDFUbzFTdHN6V2xxS29q?=
 =?utf-8?B?NVNQNElkcnZhVEpjN29iWnNXV0NzT1JmeG1US3RLck1EMzNjTWZZTEtRYytB?=
 =?utf-8?B?WWJHZ0hEcmhvOENTN1hTSDhXZ0tkTExraVJEMUc2aUszNExxSHk2QnR3K21l?=
 =?utf-8?B?V2g1N3gxbndwNkNwUEljMmtGcmJVMzdOV29rU3h1UUZhSk9vNzBvUFhRRVpa?=
 =?utf-8?Q?J1fhSfKO6oEsgMMQ=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 020b9073-1562-40f2-639c-08defe8527c7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 06:34:58.6059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiUpuSTMdVMgcLJTEB2MprP7gFnt5uh0frz/hy/uiPoncr3u1IQSP2WCYRpTnZE5QoA4js7ovSqPh8uDMxip7hm/b3AHnU1LbCri1Viodwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6139
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 19.08.26 14:47, Marek Vasut wrote:
> On 8/19/26 12:10 PM, Frieder Schrempf wrote:
>> On 19.08.26 12:04, Marek Vasut wrote:
>>> On 8/19/26 9:07 AM, Frieder Schrempf wrote:
>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>
>>>> In some cases we need to call ddr_init() multiple times to try
>>>> different configurations.
>>>
>>> What different configurations ? Details please ?
>>
>> The detection of different DDR types/sizes on our SoMs has always been
>> based on trying the init and seeing if it succeeds, falling back to the
>> smaller sizes on failure. See here [1].
> Could you maybe bring the interface up in some minimal 400 MTps or 100
> MTps configuration and then read out the MR ID registers from the DRAM
> to discern which DRAM configuration is present on your SoM? This would
> be the ideal generic way of doing this, and it would be reliable since
> the IDs are stable and surely indicate which DRAM chip and how big it is.

No, unfortunately this doesn't work. We already tried. The MR ID can't
be used as we have single and dual rank setups that report the same ID.
We have no way of knowing how many dies are connected unless we try it.
