Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A596CD8C85
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 09:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BEFE8405A;
	Sat,  6 Jun 2026 11:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ntT+atk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A260840ED; Sat,  6 Jun 2026 11:52:09 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E9083EF9
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 11:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1N2aIDhxn9UdMHtQkbiMaQjj8sQ0GuoRcZqhxhdv/v6dKdBNVNfrkH1nhyuCSXwap3FC6tDDgo3rteUnKUOHJVcLH0jjk+QVNoth61ti8w2p/0i7rt9005Jku+eeXQ9Z49hhuY352G8wCLcRHBnr5xxMfDKNBwlNXQzb31UDQO6YEnSAnA0zYRjhtlu04ZIapSgIndt6BQ9lF5d3vjTedkbc4bRanacj+VsBdBXK6wWK8i1tOKUhgFwXYzNsxgYoEgUDiMjV/31q3UdFyKz9A3w3GANvLZhd5DXCvW8jcSqaiG5KA2HGuIfugxL1XU30gOY8TsfaGlvEtgfi7Hx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Llsgw4EgXMs5A0eFfmkn+qjWkGeYdqicJlJXJTDKhw=;
 b=yfkh6RarJDQY9MBtrxi6CUlRMdidqQXm0p1A31y8i5dIOTTCRPME/AfCSLVUbkqcA7Uu/cJlrSRhlTJ3lmEdc3ZfgZSva5uwIBgvjgOFsUFRAW3y6/YkK8TAKnDCO+l4zp0H4+IlmwzvopgXmJe0peOFuOeCDTqPHjDRbkvtR9U0UAAAsSoH+0ONspUCIVrk9SxNPqC1K5g18RyeIbBuwm/QNttkPwb0VEjfkJhijty+ujf8K9bqWPWv+P92HQhe4VZ6U4If03fbscJkgDsUEs6eyz0n65ISh84K2SDWGJhiRHzU8SOR0lIPTNqWwiSKToIoe+39mccfm+pJt43ZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Llsgw4EgXMs5A0eFfmkn+qjWkGeYdqicJlJXJTDKhw=;
 b=ntT+atk3S/bpUf+NjHAMUWgbki9PU2ulhk3n1Hdk4lVcsXFdslkMqJNWoL2ou5oke/WlmpXUSxT5NZWqPO4C+dG3D8DzFgXovRKcY7jr409kVtKCu5bdMMRIOOL67M76G9EexesjTiOlNdRA2qtOik63x6kWr+9RIaUkFmehgN2PtPWYOZdPigbEjAEtmacdaJ0NqB1CNImKxy3GvzvIIWhq95rZdH947zUok59TBHutGWAtoyoGCXJAZB17mn77uEMM5085Tr/W0XGQxYYBbFnw6YLrr7fgxU+RfERFsQKrrGYF902z4eCCuRbO63T60whWlJ1DUxPzAQi/FyjJHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BN8PR03MB5028.namprd03.prod.outlook.com (2603:10b6:408:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sat, 6 Jun 2026
 09:51:59 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0092.007; Sat, 6 Jun 2026
 09:51:58 +0000
Message-ID: <d26fab48-1a6d-4e6a-9ccb-02e788670b7d@altera.com>
Date: Sat, 6 Jun 2026 15:21:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-cadence: trigger tuning for SD HS mode on
 SD6HC (v6) PHY
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
To: Peng Fan <peng.fan@oss.nxp.com>, tze.yee.ng@altera.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>, rolando.santoyo.rincon@altera.com
References: <f385cf516e8a75fff5c90aa9e54f8e54044f0dd9.1777947009.git.tze.yee.ng@altera.com>
 <afqkA0gI773LcIqx@nxa18884-linux.ap.freescale.net>
 <eef968b9-c861-4c56-82c0-fb750d5e128a@altera.com>
Content-Language: en-US
In-Reply-To: <eef968b9-c861-4c56-82c0-fb750d5e128a@altera.com>
X-ClientProxiedBy: MA5PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BN8PR03MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: cb501dc2-f146-429d-2df1-08dec3b13ff1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006|8096899003|55112099003;
X-Microsoft-Antispam-Message-Info: y40ONoPhZ+DNf8Fngja07iVJU7iythPjnwPNTB/45nAHI6qU4M8gUZ+mr8Nlf0dxlON6pqh+62DLC6+yScjuKpPoMKhT5J7YFRh59scwKLrtPTwcVCVz1f2fPdRsrRh63MV/CHmlmRWiLgUvaZUaixQ4fSq4AO6eqo/uh0uTHwMiGd2od19bF1pnC6ok3PYarm0Sd8/4bbhQWkiwwhQ5AuBX9ki/LtLFRWYRdYZUIipE+ipEDDwUNeK5SIJuPGhcFHXkQxpxAU1oknOOhUuU18Ucso2NRh6P8X25wmvmiiPDBWbwqNCzkut33nXoez4O9TwMDRZ0O0E2x3c4bhq2dSjHrTJODBgU2dng9hO2xYVkwbMZ4lwc7pWtTvp9CoDdijeW2oA9ik3PvDpEEW1CE8MtTlLvvqVNpJ+WAEYXI+RtoM3jXucJGrWIwK4KddngRhayFl0T+T4U3XVN9ApP43rUu7KxweVIw72tiP4L9+Zw82STjxs2c0gW8Xg/vTRaBGhbxz/p8PZAzkC33VbJwfc/LA8JrPTi6jgLu8OVMJPpVfsr4oFQKVOXluFuzAK4gVSAcj9ll/xZtD+l43wsikPBfkLfkogdlXwHQDPBPfUi4Y4rQnM+D6UjZyJCp7DUehVMaQFv/r6VevVDJH8Ps3DBnilxEmSGzK53PwfazzX46HrX1rqAFgqWoigkh6Ef
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006)(8096899003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRpbE9nWEVHZy9JMnZkc204RnBEYnFwd1hIYStCT1BnY1RicDYxdnpDNWhB?=
 =?utf-8?B?RFZyTkswaXJ2bXQ2NXgvZjNONVNvdmJadUNiUTUzcVRYMTlTY1Jjeit2K0dY?=
 =?utf-8?B?eGVUb0tYeXFWaGhWSjRBYllCTW9YNGFNQnNGanBNcTlhU0ZEdFd1RU1zWmpM?=
 =?utf-8?B?b2tRbHZib0RZOUh4VkJjZ2JmdldkdURUWmRQcGV6cjRFZFZCYlBOZnBSeERu?=
 =?utf-8?B?bk41a3QwcXZ4RzkvNGZjWmVIWXhUWFVWdWlCUzNnTHRnbzhzR2pmTU9tM2dS?=
 =?utf-8?B?dXRKZVVSL3hONWdCNGw2ZkJHc1lpQW53eGU4RVg4TjAySmJ0bkFhSndkWWxM?=
 =?utf-8?B?UGJwazBFSmpxcERoSERyMHUxNW1LcWYwbndnYmpIYWo0ZHloQ0syZmNxYmJh?=
 =?utf-8?B?cStJV0Z1Zit1VC82WHEwYTErVTFld0pkdHE3Szc4akZYM2dRdURHeEZxMEN3?=
 =?utf-8?B?TnBxczBsZFpybStlYUpjbXFKRTE3a2hGd1FBOW03WVJhUHFVb1F6MVFndWNV?=
 =?utf-8?B?NnVEdmhxRnBHM1h5V1BLMFVUbWtwdWVOMGRhRjFUTDFGU05VSE94N1k3SFVN?=
 =?utf-8?B?cW9qRFd3ZW9GN1B1SnFBVzlmQ3g0SndLSERwb3laaWZmbW0vaGJkclZSZTJF?=
 =?utf-8?B?TmhiaDBaNVprL3lIMFFUSVF5Vk1QeTRMdXQvWXNVQ0IxaFFpNWpZRHQyV3dr?=
 =?utf-8?B?VEF1M25GejdwVGsyL0lDdXV5YjIxUEZRaW1tL3NoSXY4U0RUdGwzMmt0T3B0?=
 =?utf-8?B?bVNEMm5TQWhHNHJVamlNMFdLK2ljTkh4VG0yL1A0T0VOOVNFdC94ZGx0NTlK?=
 =?utf-8?B?S2NjK21ZamREczNtOU15eDhSaUVTQWJmbm44NzBpV00yVzdVdHZ4QXZiaTdO?=
 =?utf-8?B?VVBWRFRyZFhYV0Y4Z3ZNUmFwQ01yOHVYTldLUlBqMlZYRngxVGp2WU9VeXVI?=
 =?utf-8?B?bUx2WklQaFQrUFUyY1V3Q2h3alQ5ZE0vZDFTR0xwN05LMDk0NThHWjVJdmQ2?=
 =?utf-8?B?bFoyQlZyOTBweTlSMEtQRUJXL2RLR21WcWNQNmFXSG94RG5BU01ERTVXUllj?=
 =?utf-8?B?cFY4eE9oWTdMMHpPZDVhYjN6VVVBS0xkU1JvQlFkUTJtNGFVM0thNFZCUkdZ?=
 =?utf-8?B?L1ByeDg0NWhmZ0lvb0VnWWdPODUrNlowRVg5MVpvWHY0aThxTzZ6a0ZIL1hn?=
 =?utf-8?B?aVdVV1dZbUxoczNGalpVdjE0Yi9NTVYzSlY1WUZKa3R3VWtXRlJ4d1REYzVL?=
 =?utf-8?B?Qm5MN1Z1Y29OTW93RXUvUE1XMjdSNTFNY0RjbCtVVWdheS8ySnJhaVc5Z0VH?=
 =?utf-8?B?YlVkOUVEYnJiNVNkMEF6U0h6dHd5RGZ5UXlOVk1tNW9ZVDVLeklKWWZhQkh5?=
 =?utf-8?B?Z2RUNnA5bE41bURud3dPaFI3S2hFSThCQmx0TGMwSGhFRnNWTHJFbE5QTlBv?=
 =?utf-8?B?SnVpbG5YenF3L1FNZWs2bExQeEdBRHdJZkpoVW1MZE5VVFpGNkQ5ZHByY1ZM?=
 =?utf-8?B?Y0VnaWRBVzhBQVYybUhwK1NnY2w0N25GZTg0cUJuLyt0aXA0VW16MitsRW5O?=
 =?utf-8?B?ZHhiTWtMeGFoQzFwclljdmZZZTF3QmRDNENKd3JGZ0xXUUt6Q1lOclVpTHJP?=
 =?utf-8?B?ZDRpaUlZU29OOG1nNUJGWHVrRnh5dTRrcmRLaXByZkR2REd6Y3A2Y255TWor?=
 =?utf-8?B?b21XeGFpQ1M4ZTlOY1JCa0IrbzZQdFlLdVFSOUdnQ1BTbWlMWTFCM3Njd0s0?=
 =?utf-8?B?Yjdnd3dlYytlSDh3TStTSjNmUnEwTGUwQU9uNi9BcXN3dmtsdlUrMG5RZElw?=
 =?utf-8?B?V2ViWFMxZTlJY2tITjZmTUNOWXVvOEhkcUtUbWU2OTNmK1hLdE5yYUEwdkRF?=
 =?utf-8?B?MGdTcE4vU3AvekhBbDVQNnNhOGJ6NjRtZ3RNZUsvdWorS0xXTmRlam42TUVt?=
 =?utf-8?B?cWpTOTAxbms2SHptTjhSVEdtNUp0SWNQRkJuei9QQzhXa0pDRFJhZXhqdlJq?=
 =?utf-8?B?M0h1ODRiRTlFOWxJMU45WWRGcWtYcDBFd3o3VnA5eXBUemdGcW5zK1ppQ096?=
 =?utf-8?B?VXdMd0F1MGJEeEdtUitKejVxeHNJZ1FmVmxxVHBWbndSM3Q3K0VwT2tyYUta?=
 =?utf-8?B?S3g5a0t0TnI4cER1bk1ScTdXV2VUMEdsSmdpL01KRFYxcGN4ME9YQ0tOVWRE?=
 =?utf-8?B?Z0hIcjdIUVhYeDdyb1Y1VEI4QWFSYjkxY1EwQzNXbmNYL3docjlzQU5HcVVF?=
 =?utf-8?B?R0k5MlFRaGJHems4UDh3VzlpR1B4MUNXNERFb1RkSVRYY2hCMzlvL1JIWWlX?=
 =?utf-8?B?NWxYTSthVWVYYXlsR0U1SmxxajRzZzc0QTB6UjJHNWxVOXBtV242RUxPNENM?=
 =?utf-8?Q?OYiYwPruEhsefkcg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb501dc2-f146-429d-2df1-08dec3b13ff1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 09:51:58.8024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0oR52U48cdhIPv35aX8DvrMxFEtrlSHTGhs/dL+WrBnsnArfyibghbWKhDGZnlnv5C6bSZyw5guS5aO5nIJijDJsDwYtl5CCcfIorzbTuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5028
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


On 5/12/2026 3:15 PM, Kathpalia, Tanmay wrote:
> Hi Tze,
>
> On 5/6/2026 7:44 AM, Peng Fan wrote:
>> On Mon, May 04, 2026 at 07:36:03PM -0700, tze.yee.ng@altera.com wrote:
>>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>>
>>> The Cadence SD6HC (SDHCI spec v4.20+) controller uses a soft PHY whose
>>> DLL delay characteristics vary with PVT (Process, Voltage, Temperature)
>>> and board-level trace routing.
>>>
>>> A static delay value programmed via device tree for SD High Speed 
>>> mode is
>>> insufficient because the optimal sampling point varies per board, SD 
>>> card,
>>> and operating conditions. Runtime calibration is required.
>>>
>>> While the SD Physical Layer Specification does not mandate tuning for
>>> SD HS mode (only for UHS-I SDR50/SDR104), the Cadence SD6HC PHY
>>> requires runtime calibration of its receive data delay line to find a
>>> valid sampling window under constrained clock conditions.
> This characterization is incorrect. The SD Physical Layer Simplified
> Specification v9.00 Section 4.2.4.5 explicitly states:
>
> "CMD19 can be executed in transfer state of 1.8V signaling mode
> while the card is unlocked. The other case, CMD19 is treated as
> illegal command."
>
> SD High Speed operates at 3.3V signaling. Issuing CMD19 in SD HS mode
> would cause a spec-compliant SD card to return an ILLEGAL_COMMAND error.
> The spec does not merely "not mandate" tuning for SD HS — it actively
> forbids CMD19 outside of 1.8V signaling mode.
>>>
>>> The tuning is triggered from the set_ios_post callback because at that
>>> moment hardware has committed the new bus width, clock frequency, 
>>> and speed
>>> mode to the controller registers. This ensuring the tuning sequence 
>>> runs
>>> at the correct SD HS operating conditions.
>>>
>>> The tuning is gated by a device tree property "cdns,sd-hs-tuning" so
>>> that only boards requiring runtime calibration opt in. When enabled,
>>> the driver performs a 40-tap DLL sweep using CMD19 to find the largest
>>> consecutive passing window, then programs the midpoint into
>>> PHY_DLL_SLAVE_CTRL_REG.
>>>
>>> To enable on a board, add to the MMC node in device tree:
>>>
>>>     &mmc {
>>>         cdns,sd-hs-tuning;
>> Has this property been accepted by Linux Upstream?
>>
>> Regards
>> Peng
>>
>>>     };
>>>

Hi All,

I would like to revisit this change as I believe the earlier review concerns
raised by Peng and myself remain unresolved.

The patch enables tuning for SD High Speed (HS) mode. However:

  * SD tuning is defined for UHS modes and is not part of the standard HS
    mode operation.
  * The Cadence SD6HC User Guide, Section 7.5.2 ("Tuning"), describes
    tuning for SDR104 mode and does not indicate that tuning should be
    performed in HS mode.
  * The current implementation therefore appears inconsistent with both
    the SD specification and the Cadence SD6HC documentation.

Since this patch modifies the SD6HC tuning flow, could someone clarify the
technical justification for performing tuning in HS mode?

Regards,
Tanmay

