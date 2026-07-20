Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376EDC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 11:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EBF838D7;
	Mon, 20 Jul 2026 13:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="IURjVKun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00BB983E76; Mon, 20 Jul 2026 13:54:31 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD0580517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 13:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDtZac3ml+f+rOs7vaAic1cC8HKhFdVPD67QyLKjpRUSNzeW4uqayeJzonkVQoSS764EIul0wmnO3rPlrcYJzZ8f2jPh1Zrlrm/PNJUo/HdV5pnNd7+sfbw7ozWVzPyIZhG8Df2MVfl8vQ6Iy2CQSCpMK7WWA4m6PW+lIU3OODrp174fBG7nlXOnMVfOw2Xd8eVhXnxSfo7TA2+A2MLJ0lpZEMTR+oGj3lifDG59eOi3FqBQZPeR4/HaOBZrJLVzMh57B3LmuOCUZY0l+pJPjmYL1gTBtUANi/5TwceKcUuSj4dk+y1dcb+RMBokEYTX3EFwYbeRivtcYb2tp4GzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=234Rr2gO07OyzF4GDu7qz8M2PSMg8/dHgowghzIn5yY=;
 b=B4k31DYEWvh10uGLNORy8lmsN+tNedkMFCGqzns4aRfMtCzr7HDBVySu8ZkUGQBdnDs8JetNtQBGj1hs2B1c8zweFFgqGF/LBFZSA0qRyseAWpm39MJWdmV1h8yXYq+tt2Z7wW5XhpSMEsiPl5f9IwYxlrht7U9wpD0laK9ubKBn7iHpXR6ZBLFVUpERIYNGw9hzMOJdMhtGN2QPeqKtuaDmjK9GxoIiTrgseppxvGOrMWjKb+tv+tGRN/as0bO156KZVa2uoDeEe937k4qS9hMKkhLMapApceckad9sM8R+ob2L2aBhuKmwkSvKg9ciDbGYtjqAdRV5x/D9FHm4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=234Rr2gO07OyzF4GDu7qz8M2PSMg8/dHgowghzIn5yY=;
 b=IURjVKunTCVy6S1w6gHnDLD4Ll0YInMocj0ZhGHV4PXCJQhrQrvE4Z5ghYYK47y5iU+XZ9Fxd/9B9ScmRCMI3bgdUQmxMesKAAjbJdFJ0I+oz8B6Cb5OP8fFtX56/IMqJEVJvJfX1pWcqhU8xIxAqcVoSGtECeCRue/DA32g0wjpm/xIP1sarZR1jVHUJkj+mObo5tPFSUkZyNSWi4SyHSKz2GAM5seAVbWGvANzsYiGHzuzZ6bYTZz9rh9FKc/bSkJ2SJ7QsOXaDYYg9zH7Cj+uyt9vgTX6wkjBwyk2emL23HQAQ5xkz0z9p2Vedh8hWbhNIdCJWHKLVvQVXUs/UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SAWPR03MB989623.namprd03.prod.outlook.com (2603:10b6:806:55b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 11:54:25 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 11:54:25 +0000
Message-ID: <00b07af7-36ec-4750-ad5d-326767eafc23@altera.com>
Date: Mon, 20 Jul 2026 17:24:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] mmc: enable CMD23 for multi-block transfers
To: Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>,
 Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Johan Jonker
 <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-3-dbd01185f911@riscstar.com> <al0Fk8JyfYhu5b9y@pie>
 <CAH22mJyDMK1-TyaZierfaF88NtgVvKF2Ac3yARBVcgobGQO0-w@mail.gmail.com>
 <CAH22mJx2f1V3JE0Lt4SJY4qh-T9i2i1jGFs3CK1Sbc7H3SxP3g@mail.gmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <CAH22mJx2f1V3JE0Lt4SJY4qh-T9i2i1jGFs3CK1Sbc7H3SxP3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0265.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SAWPR03MB989623:EE_
X-MS-Office365-Filtering-Correlation-Id: 8367ffe9-c926-497a-5502-08dee655a39e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|18002099003|55112099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: IO3IMYzk1OW1KbiwWnvce8Ox3UDQt1AC0doO6UBCe/klTGdbiB1+ucrJPIq4CoKucOnTvPoMcb9bhxgtRjyx4fQrTVnzb3DG3X6deY6iTBbv7laUgqbiD4Q4m7Ntk2PIBeoqKPSXGefZg3CUQ1W5p0uo8nLeZgxN/YwtZ8IaU1P3KsiCayRU4h7ngea/xay1SqbR+H2nPyfepGS0058TCKlTk6y3oKWq+TxBG/AEEad4ZbB7E1JZfA/3BTFyZq6iyBoPwcQ2W0bKXxxxNB9rO8HXaZyNKlC6wcvpVd3dtnP6H2FloNpKn3Jb1UiDCSeUSiAfl6JB+1CpZ1Y8qDo4OzLuSNd3EsS7lUAS4LmuiXKFNuvs75Yxd/BHUrk7eZiHBoC9YLG4wTrDcPZEA0wbZ9JOHnOx8+MczR1zOczPzne+AGDpk15pLExsvPGx+kDVpOfWPEKWnxxxK+ZigWPIlMx5N+345bdPYmHa6m0TG5CfbLfYUenOLW/pJP8a6ZpmtDU9hW9/ndH+bdSC9Co89QVLTkQlT3GrQ8wW/FNAf3565oN+kTKEqlpSEEpa7VOUNjp81+q2kdzoBJKcxnC2iMbbfIK5rzsCA7evikYiP85G+f8Orj6Kj474/1UHBMsoDH1foh4DMsyiK+pzVNNqyHTXXq5gdQvQWRUVWGVkQe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(18002099003)(55112099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjIwajZ2d3d4UVlsRVh6WE90WjNHeUdtcmhVZlJhUjFLeWJhSWhzMzJCb3JR?=
 =?utf-8?B?MGxackg2Uk5UalJsWkJDU1FJOHZ4TFdMcWJnVnprOHdRWU55S0gyYy9lQUo2?=
 =?utf-8?B?Q1JteFV3b2d2NGxld3hzS1BRbDRxanF3WFp2RXhrL2tKK1BuM3VoT1BkR3Az?=
 =?utf-8?B?Y1BjdDNaT2NiS0wrUGwzS3diZS84WUlpS2dsbFZkRWhnUTVtZEJIbGxac2pz?=
 =?utf-8?B?S0RRUENlZDlRRi8xSERnekl0T3FRVU9UY1pMUUNydTUycFpnNldEVFlqdGhQ?=
 =?utf-8?B?aEZXcjVETHRlR05SZHY4Yk9OeUZ6eVdOY2xXUE5YRzNEeFVDdVZKYVhSMHQ0?=
 =?utf-8?B?bjdzNWV0Y3JncG9YRFhDQWRpNWQwc0dUWE15TXVlMGl5dnpOYTcrZXFSSTVR?=
 =?utf-8?B?Mi9CQ2ZWazh3cFpZZzdSSlVlRFdMeXJpMW1scmEyWStwcG5sNnZRYjRoamxW?=
 =?utf-8?B?dzhhRi8vQi9oMmJ1dGljVkcycFFmdWxlVCszc2dsODYySmhwam5ISmVlR2tD?=
 =?utf-8?B?b0wrMWl2a3FBMVhhaENVOFpwY1lEcU44bytYYUlIa2pSSk5TSGlaaHZQcDM4?=
 =?utf-8?B?NTNqeldXS0xuSnBaVmdySjFPdlArZCtITmNPNmpGWXo3RXhDeDJEcU9DT0Jq?=
 =?utf-8?B?MHJVOExna2cyWlZmUVhTNVBEK1lVN1BoU0lKZVBORHVheXB0Zis1Z3pwWFNR?=
 =?utf-8?B?cnhmSkJ5WDFucThNcnludjVnNm5vN1lBa2FwNUFUTzBwbzJqTWJjc1J6Y09G?=
 =?utf-8?B?WXY5MEY3bnl1K0tSTFphK3hYalVFWFZxdkYwMXhtNEFObnFCUGRNK2tOY1BH?=
 =?utf-8?B?Q0preUFLUmo0WmtxVWRCK1dNeXdPU3p6VnlsR3NvU0hmUW5Oa3dhSTcyTnJn?=
 =?utf-8?B?YmZ1WGRoWTRaMWRUWnlWbFBaYnBweUdsYndXOHFHT0pJWlpkS1Z5NmduUjFW?=
 =?utf-8?B?RWlaVllSQmpHMllPbWo0eEFmbTdkWUMzWGV6RHM1OWRYZGkrZHF2ampNZTJG?=
 =?utf-8?B?UThqMGl6UFVDR0ZZT2duUzZvNWdzYzR5WitSZFZEQ1pCVzlYTTZIVXhOM0lQ?=
 =?utf-8?B?TlRjanJKRFJBMDV4ZTE1MkgzUTJOd0laNC83amhSQjR5eUFJOFVYNVAveDJp?=
 =?utf-8?B?cklObDA1OGpQSjdxMUpUblZBUGpIZDd3OFlza0ZhWE1WYjE0RWJvWWwyN2Z6?=
 =?utf-8?B?MDBaVW9nSUd0OU8wSUpBQWpZU3FpOWM1Q1hCaXZkcEY1OUVVWFN0UldiUEFZ?=
 =?utf-8?B?L1ZWcmhiSnlOZUpTZ3RYaDROczhyVkVxc1NIMDRxdEhUR3FWTjE5dFVlTkxX?=
 =?utf-8?B?L1FrYis4MWhqVUNvZnV5cGRWZ1QvaDRXMGdJRnJxZnJodXVZRC9LUUU0a05V?=
 =?utf-8?B?Z21MQWNLeFZMSVpjejZzY2lhVWEzNmlnYVBaaGZhYXpKQ3NwQlZiVzltcFpV?=
 =?utf-8?B?UDNrVlo5c21zZDVOOVpuaEdzQ1k5c05zam9MTkE2ME41OXppeGVrVlhqRVV5?=
 =?utf-8?B?NklnS2xPNTFJcHIvenpZSDFvODB5MktLZ0pOSkQzRUhEdEwyRjVxbWlWWitM?=
 =?utf-8?B?dmhKcEJDVE1sU2VKM1FUNnRoR2p5UzBtaXdUdXpwUmNVUWJpNjRYd0RLTUJ3?=
 =?utf-8?B?ZFB5VUdvTk16ZVNMcTdBN211TjBUUzI3U2trUUdjSTk0K2I4bmVoWGdYK3pt?=
 =?utf-8?B?QmczNXkrc2ZJSVJUV1J2dUFpRi9ZZHkxU1FKOHc2RXFibDcrNlJkQVgwOHNN?=
 =?utf-8?B?Tm9OcmNBR2xxbTUwNlBsRzQ5SEZjQk8vLytzTC9TNDlEMmhQTC82Nlc4SGp0?=
 =?utf-8?B?WjNFai9CdmQ3VVQ0TTZMRHlJSnFmMXlOc0NxQ2N5V1hlNlFPc2FEVlNBZGYy?=
 =?utf-8?B?UGNGU1dZbGFMYTd3WXRENjdEUWRmbm5RbHE3U1JNelNFNEZVKzBSNHZ0VlEr?=
 =?utf-8?B?UEEvOU5TS2JQbE9LL21qU2lvdnFmYkdoS05mRTRubzUwczhBb3VsYTF2ckMx?=
 =?utf-8?B?UFl5NnhGeXFsRDZ5TFptYkpaSWJQbzM4Rlo4RkRUT1RxRG9ZTXFDaU95V3ZR?=
 =?utf-8?B?aXlGdjREN1NQemFnaGNFM0grdEd2SU11T0E2NE8yeTlUbnIyUlFiV1FQM0Jk?=
 =?utf-8?B?NmFGb1ZvWnFwSDZRU2JQaG1OZUx5WHp3c0cvb0I3R0wxTTF5OU4wS2l0OC9y?=
 =?utf-8?B?b1ZKUG15Z1VaTEJ5dUZCdy9yZFR4WFBSb1dEbmRlMU45a2N0ZHhRa3pDa09T?=
 =?utf-8?B?VjBHMlhOWk1URUpsd3FmbkZieUJFRzd3Sm5ZclUrUG5DVVFETTZnR2M5Zmtv?=
 =?utf-8?B?RjA3Zys4cHJkNWlSWVZxZW1kZTR5UHN0eU44WW1DSjBQL1FlWDd6N1dGT3o4?=
 =?utf-8?Q?//cU4/ZFWw2uMZSM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8367ffe9-c926-497a-5502-08dee655a39e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 11:54:25.3620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPgAm0pynKdtSatEwu8HhZerqKM6vn6XSuiAtAe4fpP/CLOwL8HiNyGP/TrcPM6WbHXIkzbMA+avDz27/11U8AquFlzJ7Q7Dpji8Kuniyxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989623
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

Hi Eric,

On 7/20/2026 4:14 PM, Eric Chung wrote:
> On Mon, Jul 20, 2026 at 6:42 PM Eric Chung <eric.chung@riscstar.com> wrote:
>> On Mon, Jul 20, 2026 at 1:13 AM Yao Zi <me@ziyao.cc> wrote:
>>> On Tue, Jul 07, 2026 at 11:21:44PM +0800, Eric Chung wrote:
>>>> Enable the support for the CMD23 (SET_BLOCK_COUNT) command to
>>>> manage multi-block read/write operations. This allows the MMC
>>>> core to use CMD23 in preference to the legacy CMD18/CMD25 plus
>>>> CMD12 sequence, reducing command overhead and improving I/O
>>>> performance on multi-block transfers.
>>>  From the description, it seems CMD23 support isn't essential for MMC
>>> support on SpacemiT K1? If so, it might be helpful to separate MMC
>>> core changes into another series, and focus on basic support only. A
>>> smaller series is easier to track and review.
>>>
>> Actually CMD23 is necessary for Spacemit K1. So I can't split it from
>> this series.
>>
> If I use ADMA mode, CMD23 is required. If I'm using PIO mode, CMD23 isn't
> required. So I prefer it go through this series.
>
> If the reason isn't solid, I can split it into another patch set.
>
Both CMD23 and CMD12 are valid mechanisms to terminate a
multi-block transfer: CMD23 (SET_BLOCK_COUNT) is issued before
the transfer so the card auto-terminates, while CMD12
(STOP_TRANSMISSION) is issued after the last block. The u-boot
MMC core already has CMD12 support in place, so multi-block
transfers work today without CMD23.

Given that, I agree with Yao Zi's suggestion - splitting the CMD23
changes into a separate series would make both series easier to review
and merge.

That said, Is there a specific hardware issue on the K1 board where
CMD12 does not work correctly?
