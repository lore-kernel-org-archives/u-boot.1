Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA575C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13AE388009;
	Thu,  6 Jun 2024 17:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nyt4oLKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A79CF881A1; Thu,  6 Jun 2024 17:13:13 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2602::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD2387F64
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfCQYNgXFGvpJ6mt8IxraJRpOMUJ9Sg0h5stGtRmPwqTfYc06zhFVvigp69nIjZqyY0RhHQt5XoqxHnU6Nrs+ITaH6Hw4LZ/oKTieaKSV0hFva50p+zW/+jtLhgC17wgA4hAi8tdcIqimF36x6qCFn5FpjEsJrXrKe/H2lMkHUXLhU70nJM5MiC8DtvilrcGwPBO+Lk0cyOdGWLVsvMq2nJLGYDMVcEsqWzW1lSTtG9M9+1tLkD3WaW2akHuH3JoZ9cIuTCADlwAfjE+TuJrHrNMjFA803fSuqka6l3uwdAN+ljcZRzoBXYkfR4YPHUqJgmKPGj+TWQ/BsmMRq2iHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SlJkUHVebvMhz4G2pDTD/lBQicJL1BPf5NZqb2udT8=;
 b=W+a/Xwr/lSMIxUwg5lg7wpFcOJESa8XPA8D+Y73Iy89nq0A/DJ2X1NR7w3EJc2039IkV0wwF0bpzM9jviGp5kPwGpvFuo+/4Osb8+10hsegE4CP4DXo7PsN46lys7KQLUEzs8so4BfgxYdqJeVk0X0gBXCwJPOfoVXWxKYgJa3jD8LBygIshKdnRWimO3WjkEtlp7Ugmv+adBMMqQVPBt4hj2KGJA/pj36k3Dn9hh7z4p6RC1fQdyqSoQ2CnhEaqHZ1tMaCe1DAhPhesSDmKib0Ghwelzb44cWiuNl9wejm6lo5zZF/aG5CiF1VPBb9szYZ627CdaNBS9iwVyYA/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SlJkUHVebvMhz4G2pDTD/lBQicJL1BPf5NZqb2udT8=;
 b=nyt4oLKtgbUv7Ev7g0eqS98LpE+AWgnzp6xU2tIq8KDDzwxKLrvNXGu8lTMDZCPxpQngqTJsepWe+HC0QRvQuKBu1vAa/uN5AzuWnz0dcpVRklasJrimiDF4sfOALfjHEio/C7wc81uuvSMGp/tTS0ENuzxK/HDZxjmI1LYJtxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 15:13:08 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 15:13:07 +0000
Message-ID: <8265cbb3-0399-4b1a-ac17-1592603e1ce2@cherry.de>
Date: Thu, 6 Jun 2024 17:13:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] rockchip: veyron: Add logging for power init
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-4-sjg@chromium.org>
 <bfe289ff-eb98-477f-bda5-ab8559166ec3@cherry.de>
 <CAFLszTi6xr7QeaUafMgJDSb6jg9ip3A9MLsEK8HOS=DMnhyxfQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTi6xr7QeaUafMgJDSb6jg9ip3A9MLsEK8HOS=DMnhyxfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::10) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b7e648-adcf-4937-7b9e-08dc863b2b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1huN2txUTFaQXlmUm9oUkVQb0xGREhISWRscHRKRUhDR2RlWHhGOENCMXBZ?=
 =?utf-8?B?MDQ4a2xQdnU1dzdER09GZnJiRE9FTFZNK0wwL2s2ZUlvSzBqZ0F5MVQyOVhC?=
 =?utf-8?B?ZjFPNGs4RG9qbmdUNjJXQmwvclZVcEIzbnlYTWFveE0vMm9odHBxN2Qybm11?=
 =?utf-8?B?dnl3dlRXeEwxK2ZyRXJ2VjJGYTNnM3c3d01HbnU3ODlncDlOeUZvUzRzUjFE?=
 =?utf-8?B?Q2lNVndxWUVwL2ZiTzc3N0NhMVcrYy9waGNuLzYvNkxhbVR3WkVORW5pRGpl?=
 =?utf-8?B?bHhHT3dTblI2QXVMeWlVbWQ0all3bHdiU3B0V24yc0w4Y25EckZpOUFRbnRq?=
 =?utf-8?B?c3BFdktjK1dlajJaNzlscGxFVUJMVE0xdFZjM1NsNmhqVFRzNGI5MkpZUzBm?=
 =?utf-8?B?K1E0a3h5TDg5WGlzc3RaMG1xTnFjbHA2Z0taQWRQZFRTTGhWOHZlRnZEcFFj?=
 =?utf-8?B?VG1IREo2TUdUWEZKZyswckVMS205MGx6ZDFwejMrWkxQaTd0YlNIczRLMzlI?=
 =?utf-8?B?RUt0czl5eHNrWStubXhHRlcyaUVCM2FMVkg1dGhUTGx2MTFYVXJPVzhicmZm?=
 =?utf-8?B?Qkl1UkcyU3VuRW1PZzZGNnl5d1hOczludVpiWUxkUjEvTnBjZytqOFRNTWdP?=
 =?utf-8?B?WktLOUlKbjc3MHgzdzl4TFlZMUliTGVOY29ub2NqSlpuNHdmV0xFNVIweFQy?=
 =?utf-8?B?cXlJQ1lxZDQ4c25kdk9oS0tPM3RnWWJ5eWQrL2d1RE1TWlFWUXBmVGZrWWNX?=
 =?utf-8?B?NTR2UW9NWU5zL0JnTm43alVlY1h5SE9kVGlOUDZMTmgxL1ltN1pCTEZVWndY?=
 =?utf-8?B?ZGJ2OFBnSHVXMHo4bThaUFNCUDNRaDJpcmpDV1hrakNxZGFMbDFqTGl1b1hn?=
 =?utf-8?B?aWZ4MitaRG5hSm5ZT0psZW5OVXFneVQzdjdub0xTWksrOURScFlOM2lEQnFq?=
 =?utf-8?B?WERSbmxjcFFjN3VnN3hoc1FzS0l1Z2IyblRaaHMxSUd3bWNWWm9mdmlRWDF5?=
 =?utf-8?B?R0h0QnB5alJMdThuSnFTZkxRZFNOWWR5WEVkK1pRVTZ3cVdKbGpqT0RXOVJW?=
 =?utf-8?B?RlNWU1V0RWNqRk55c09taG0rZWJOR0RueE1lOC9iODFsUXY0dFMyckJobW9Y?=
 =?utf-8?B?SkVNbmw4Qis4bHlueFV0dGJaSTk1c1lQNUNHS0VGTzVSWUoxSnRsSXRqU1pX?=
 =?utf-8?B?ZDVoSS9kUnpJYkV5MnowdnRxU2dsVyt3ajVZUko3SmpXdkFicGNQbHhXTWtC?=
 =?utf-8?B?STNLeEhUSm81R1ppV0hYS1YyU1VyOUZkRG5INENMaWJxMGg5S2lhOVRmVU1n?=
 =?utf-8?B?UGp6MXdTVVdmSXpLbEFZOWhSeTZFMWgxNHNSSlREcjY1VDFQS3NmS0lSaTVE?=
 =?utf-8?B?UmlvclZCcWRNSEptdHlyNHdkOTNTU0FnWVo1akVFRURFemxBRjZKbzJDcHJE?=
 =?utf-8?B?aUxFMFM0UTE0ajZERFNTK0QvdFA5VTNoUkZkMEVuQTZLUnJEZlp2RmJlMGht?=
 =?utf-8?B?UmlqTk5VVyt3akh5bm92aDZZSVNsTU5sYmM0YUNkVC9lS2d6TzdsbXVJZzA4?=
 =?utf-8?B?ZFY3Y3J5V0dPT1c1RlpJT2h3Qm5BTXNrQTBYN3p5OG1sS3Z2elBSOUhERVgz?=
 =?utf-8?B?UUw4MWI0NHoyVklFSk5wcVpzUU1zV2xZWnptZGxJTGwxOGlTU2V3RDFIMHZt?=
 =?utf-8?B?N3liM2k5NGh1cnJnU1VadklSdG5EaERUbDVZM281cUgzUlFETWhZSWhKamo2?=
 =?utf-8?Q?Z+UMdJ34VGKlt82SgPopHPOzDMvnKgbmem7T2mO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajFLM013cUJsZG45cFJhS1NZL3ZRMklvZmo0TWM2K2d3TTR1Y2NYVDdoS3VD?=
 =?utf-8?B?S2ZrUGZrRU9pblNWRzh5WWpvUmJ6VzFIVXZGclc4dkE5azM4TUpob1dEMUVh?=
 =?utf-8?B?R0E1VHY5N0hZY3Q0a1c0Nm9VUVlRSmJibW5oM2ZYOGxsZzJNYmNwNXRIdHcv?=
 =?utf-8?B?eURQNWRtNE8razl4WUtFZHlXQVcrWmhuMk1rdExGMkNINVdBM2tibmVTZll2?=
 =?utf-8?B?RXp0VFRINkZMaDF4NE03Nkp5RFRJM29IeTNBSGRlWnZLUjhEM1NyNlJuaXRC?=
 =?utf-8?B?d0dFSkp2Y0RtYmpTZ2hOR0M4NlZudUk5bFI5NHFXRFo1elUyQ2h5TXFUa1Ev?=
 =?utf-8?B?amR4ZVBaT3hwazdBMUx4Zjg3emZ6VUZISjN6d3VObFk5ZTIyRkFtQkJsVEx2?=
 =?utf-8?B?czlJSkVCOE83eEQ2a1YrZC9NRmcvb1N0VVJZWXpUUlpWZEdwSU45ckhOMDNZ?=
 =?utf-8?B?dFN2d0FweTVVK0xOVlA3b296TUd3MTBqQTlXOTlNLzR3ZGFxR2RGNC85Y2hW?=
 =?utf-8?B?cUZjNzRXL2JYekltdGhEbCtFTkJweU1NdHZ1NzJWZEhNODFDRGw1Zk1pK0Rm?=
 =?utf-8?B?Z0laYnh0YjZ2aEZyNnUzSWxlZ2hQNFQzcUI1bWIva21DZnMwNWoxRitSb0FN?=
 =?utf-8?B?Zmk1REI2T0NqSER3YjgvdGN4NURUTGhVTkg5cjhkZ2NJYWQwcnFEVGxnNTU5?=
 =?utf-8?B?R292Sm0wd2Z5M25MMHZlTVJKMDB6dlpxSzI4Rk93cGF1enZ5ZEdpejN4VkVQ?=
 =?utf-8?B?U1YwUlBzYWJUZVVTdkl6KzgvN1lvZDQzRDFoNHljVzFKc0lxUFBMOHYzVUJP?=
 =?utf-8?B?UzZGNDVDVWZtTmFJNW0zbmthT2VNcmVLQXB0ODc2eHMrdEwrNHA3dUx6NWlM?=
 =?utf-8?B?cm5hLy8wQm1STGhPSEx3aHlVaEI4dXJSYkZ3ajlURGIrYnZ5L3BrUk5JcDFF?=
 =?utf-8?B?MXBVU25QMENhdXhOZ01KTHBTTWRaZjNjcWI5TEp5NjJSM2k0N21QREQ5c25u?=
 =?utf-8?B?UllWdnhuQXYzWVJ5Vnd4TTNnc0FBQUMxUFgxLytXVVVwZUhGSU9telRPNGNE?=
 =?utf-8?B?MHFVdDhxQ0xEUXduNHVqRG5yVURFZjZQa1VBaGlPaUJ6UXFMQnREcTNtcUo5?=
 =?utf-8?B?TlpSYSs1UjVnSk9qQytndXZYamdrU0l5WHo1eFRMZUYydEx3cG10cmliNmVL?=
 =?utf-8?B?b3JPVU4zazhqOExZN1NTOFNXZEdWblZJVmZ3R3hUK2E5bC8yZlVPL1ZXQWoy?=
 =?utf-8?B?UVpSZ1hkZUp3RXJ3Uk01T05uWEc0aTYvOHRCZEJqbnM2VUdKaW94ZExSVGRF?=
 =?utf-8?B?TEo3aExuejZtcDdub0xGRmRUWVJGalozUTZxdmRlTEpYQTZEWXdBWlpJV3U5?=
 =?utf-8?B?OFE5QmNJSk5seU0xcng4aFJQM3JGYmZBVkgrbllWckRXT1c3c0FnNkJkUkFN?=
 =?utf-8?B?dTRkcFRkQm94SGdUTmllV2E1SmVXbE42eGtzVmp2SzA4dDcxMEJUMGFBMmdI?=
 =?utf-8?B?RFpQaW9jbzlXZUNwSFNtbnlxQWFYbFc1QWE2RmE4NVZVY29nN3ZvUTlFalll?=
 =?utf-8?B?T1ZkK0dJa0QvOHJoYU54TEEwUEFFME1IbTBkRm5SWjZMQTJBYVpVbGcyZmxO?=
 =?utf-8?B?M0pyb3RyNW4xU2pmSTZlNzBZNVdqdCtHV2dObFRxMTI5T25pdXdlSGhoeEhu?=
 =?utf-8?B?MGo0NWc5T1dwL3djNUxKUGFFaXVpQXBVNE1uYTkyTzl6MVp1QjNibGdRd2Ft?=
 =?utf-8?B?WUF0VWViTUhwVERPQW4zU0xVU1p0YlVxSXVoYVRJNEtKVGdvTlgxZ1kvWUVQ?=
 =?utf-8?B?bDcxZ1FlQ0NseFBLempHNVA5SEFTeDVOam8vczhEb09McXBwWEpnTEVGV0h1?=
 =?utf-8?B?SnpXMnFDMWoxVnBkU1ZxdCtnVmRROURWaFlMNzA4ZlY3UDZ1T0pKR0ZYRm13?=
 =?utf-8?B?OVpBWVp6aFFpdEczbHpnR1VGMzBETVpjc1FNaWpVc1NlZHdsb3pHTk5FazJs?=
 =?utf-8?B?bWM4WWtyaUhmbVV0K1FzRFFUL1l0YnJzWUNDaStjQndTWDhZajlxYUt0cmxR?=
 =?utf-8?B?Wk5OZ1AwM1IvdVJEOVp2Y1o3NjQ5cWFmWjRnbUdIUXRCV1JMWkFlQUFRN25k?=
 =?utf-8?B?OUNWWEtwYVJWczZ4YVc3eWxPRFZxNmxCOU9uZHJwTUltMHRDTU5RajBJbHFF?=
 =?utf-8?Q?+he8X/3JFlVHTnYzDZNxdBA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b7e648-adcf-4937-7b9e-08dc863b2b9e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:13:07.3669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfvhkuWDrAKKbV0no6qaZr91lZhLioZgVvvTZEBKr8qtMVpvTrf/Nf6Visr9jhLH/BpntPZWLM+D+XJVxsZ4Ugz0hQAzbGT+uqeve3YOgdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304
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

Hi Simon,

On 6/6/24 5:04 PM, Simon Glass wrote:
> HI Quentin,
> 
> On Wed, 5 Jun 2024 at 02:36, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 6/5/24 5:25 AM, Simon Glass wrote:
>>> Add better logging for power init so that CONFIG_LOG_ERROR_RETURN can
>>> be enabled.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>    board/google/veyron/veyron.c | 27 ++++++++++++---------------
>>>    1 file changed, 12 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
>>> index 32dbcdc4d10..23fe8bf088c 100644
>>> --- a/board/google/veyron/veyron.c
>>> +++ b/board/google/veyron/veyron.c
>>> @@ -29,44 +29,41 @@ static int veyron_init(void)
>>>        int ret;
>>>
>>>        ret = regulator_get_by_platname("vdd_arm", &dev);
>>> -     if (ret) {
>>> -             debug("Cannot set regulator name\n");
>>> -             return ret;
>>> -     }
>>> +     if (ret)
>>> +             return log_msg_ret("vdd", ret);
>>>
>>
>> Those log messages aren't for code in SPL as far as I could tell, is
>> there any reason to make them that small/cryptic?
> 
> Oh yes, it happens early in U-Boot proper before any messages which is
> probably what confused me.
> 
> Re size, they just need to support searching the code base. Long
> strings mean that many boards fail to boot / hit their limits when
> CONFIG_LOG_ERROR_RETURN is enabled. So I try to keep them to 3
> characters.
> 

git grep vcc/vdd is going to return a lot of matches :)

This is for one board, so there isn't much reason to argue about this, 
so fine :)

>>
>>>        /* Slowly raise to max CPU voltage to prevent overshoot */
>>>        ret = regulator_set_value(dev, 1200000);
>>>        if (ret)
>>> -             return ret;
>>> +             return log_msg_ret("s12", ret);
>>>        udelay(175); /* Must wait for voltage to stabilize, 2mV/us */
>>>        ret = regulator_set_value(dev, 1400000);
>>>        if (ret)
>>> -             return ret;
>>> +             return log_msg_ret("s14", ret);
>>>        udelay(100); /* Must wait for voltage to stabilize, 2mV/us */
>>>
>>>        ret = rockchip_get_clk(&clk.dev);
>>>        if (ret)
>>> -             return ret;
>>> +             return log_msg_ret("clk", ret);
>>>        clk.id = PLL_APLL;
>>>        ret = clk_set_rate(&clk, 1800000000);
>>>        if (IS_ERR_VALUE(ret))
>>> -             return ret;
>>> +             return log_msg_ret("s18", ret);
>>>
>>>        ret = regulator_get_by_platname("vcc33_sd", &dev);
>>>        if (ret) {
>>>                debug("Cannot get regulator name\n");
>>> -             return ret;
>>> +             if (ret)
>>> +                     return log_msg_ret("vcc", ret);
>>
>> I think you can just merge the debug and log_msg_ret here?
> 
> They are actually different. The debug message is how I actually found
> this problem.
> 

I meant:

"""
if (ret) {
     debug("Cannot get regulator name\n");
     if (ret)
         return log_msg_ret("vcc", ret);
}
"""

Nothing changes ret before the third line, so at the very least we could 
have:

"""
if (ret) {
     debug("Cannot get regulator name\n");
     return log_msg_ret("vcc", ret);
}
"""

But i was also suggesting we merge this into:

"""
if (ret)
     return log_msg_ret("Cannot get vcc regulator name", ret);
"""

But since you seem to want to keep only a few characters, then just 
removing the debug entirely? Or what's the plan with it? (I see 
log_msg_ret as a debug message, but I'm probably wrong here?).

Cheers,
Quentin
