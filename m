Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4F9CF256F
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 03:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7751083984;
	Wed, 19 Nov 2025 04:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Yaji30LB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 806AE8398D; Wed, 19 Nov 2025 04:31:02 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA70F8397A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 04:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZi8weO4SU3/giKT0AvBk7vqKpDp8FOdty2pHj3X4cRnd7RBnKg4TeQZsljE0OPGYibudTWPM38E9G2CqUkcFGm2f29bSwQK2JXMBQlanXdDAS1nJ+iZU36BhQ2kgjTXYsm2W6w+GNimmihFx4CdLhTzeunqvjAlbYnSiL0mnvnY1+ymIgm/OCtehbwr1ReL1E3wCuAM7sRgBQGyTL60/WVj+jFbMIZjOg1CxH7sQ2PnTHw7XLN2h4/zl/TLqqplgbW+dKAP6Sn3KSh1+njON+9hnB0VfWXOFxDS8y2ifvhIeCGL8EJICr5c2ZAcxGaSUtMbf4ZWC4uGdQ7tyNSYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCtXFe/JvujnMH80MJd8GtyfBMmbCLBb2mIlvqY1CwI=;
 b=eeJzz6aion6p8eB4odeudxw9HCnBNHapik3aMUVGu9HkpGzjXclO54OrpitjrwH9tOtQhwgOAbTYTxlX7l2qNsCE1ao4h0XcoEPwi9rUFAYgRZeaT9fCi9zxrMJjQZ1BtxOqQFnJZvhHVgt8ywUGreqUGYw6M0tHhao/L+C4lrEtEEYaGk1qp4rTAn0Nv5Lf1fkO/f2qQtxJ327vDQ3lautuJ1wouTywQ6psfiiADWy+CC2qD99kLZ9KsUDbmuLH+DAVn7iB74MEzU9rQ8oiHPcWtuA9tzp979GYPNph5T+vZav3FGSYM6NCFHRuEEyowWVoNxAuJktTdDKCCgarfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCtXFe/JvujnMH80MJd8GtyfBMmbCLBb2mIlvqY1CwI=;
 b=Yaji30LBfxXsVolG/9BmYY8FOsVdUnmqB3Wmd8K8plrmdDUrs3FstAdMftXxwUKcDO+OKKJ6vw3FNMYtQSral1JNoplxy5ZwFKmx9bL1yJcrkpJDdtxZAGzlSLMLSQrb2Dd+WdPWfo8vgeVLqGd6YHYNLTEtWAjGk/+hjZ39MiqIcsccn8ATaS4jSfFN12sa7rBqm7RDl4s7dVklzsdJZwjNbYoq6UKEIKvajUDmMDHbhn2b2jy5K1jZ/xm5NGZjOrG+Q2tSoFOZtaJk/cWKv+Y2fE8SkAAkhaVjEm8+48LXEQPB+PjoRf23dFqCM4hOsvbQPJzZ8eQIU8nlnQOJVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB7157.namprd03.prod.outlook.com (2603:10b6:510:295::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:30:56 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 03:30:56 +0000
Message-ID: <610e4623-90e3-40c4-be65-66c19bf6d7d5@altera.com>
Date: Wed, 19 Nov 2025 11:30:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nand: denali: enable SoC64 SPL NAND boot with proper
 Kconfig selection
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, david regan <dregan@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20251104171902.15039-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251104171902.15039-1-dinesh.maniyam@altera.com>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH0PR03MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ab6661-41b4-4511-015e-08de271c0c19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUNmL3dUQUhRK2d1V244eG5XcmZ6cFZZMjlmNlNlOWs1ZUxwdmM2d1NtYzRX?=
 =?utf-8?B?ZnlKUFhJaWljdWxkeHVGVjB4bzZ2YkdncEhjQWpMbnh0UEhkL0tvMkR5UmRU?=
 =?utf-8?B?cTFjUWVPd3J5RFA2dEx3eGxlSHNzVjd4TEMycWJ0UG9NRGpPY09BTldvRDNz?=
 =?utf-8?B?cWpYVm1vUFI2NnE5ckF1UkZZbm1mYnBUUkp1ZmxtaU8zNi9EK0pZK0cwKzZP?=
 =?utf-8?B?VHpFQTdDSjhLeWZvMmFOenZCRlJVdXFndklORm1XWmNNWUxJNGdHZ1IraFJ0?=
 =?utf-8?B?Qi8vOVJYbnlBajBmT2RyUzRnS3pnRlJKd2VlTkNSR1hENDlEKzdsRFhTMzBM?=
 =?utf-8?B?OEFGZDhCd1Fhc2RsSzdZZ3d0aktvVHg4S0pHS0xNa20xZmgzdHJKQVgxMU9Q?=
 =?utf-8?B?V0xpZmtSUlRmU2xWUzRXQTA2NGQxdVdEMHZVb2dQZW1WZGxGdWlaVDZnOURl?=
 =?utf-8?B?L0FLRHpzcUtwVjBHaWlGVU9DSkd3ditOK29YM0ZJTEpYUHFRaVhuc3R4bUxz?=
 =?utf-8?B?UW9teEM2bGFZbXlCNHNYa1psZGNwQXpLeVZ3azhBM2tJZXBzKzhsMWpKU0Nx?=
 =?utf-8?B?bDBYZ083ZWFQMXptWHFZNE1YOFNHaUx6c25HaFNaYkYrOW9sdFRpb3JOa2E1?=
 =?utf-8?B?N2pnMzdIY1RZdEF1UytBanN0OFFxTjRQbHltdUQ0dXNtell1UWJoWDAxR3F3?=
 =?utf-8?B?Mnp2bW9MbFVsdXJCYzZJUEp5eWhRNWlpeUw2MndaNHhmZVMwcDdKL0trYWg0?=
 =?utf-8?B?azF5SlpZdklDM1BmNERlWXdRVWNzS3Y2dDJGR3dRQUtoRG91bmpxSFk5TzND?=
 =?utf-8?B?RmNGRDFZUEMzNURub1BKRUpFSmp3aDl0TXdabHdhNDVCem5aaUlHUHA4OGRp?=
 =?utf-8?B?NXdoY0EwU003Y3dMamIwUzZwc3dKWkFlOGovZ3dseTBKcU40N1VnZnE1ZGhR?=
 =?utf-8?B?Q2w4dE1YbXhtSEdFWUZSY0dheC8rTVBKR09aeHRTUk5lRWFKMWthWnJmUEtM?=
 =?utf-8?B?MldsUmVBbTMwQTMrWnVZSFhYM3FzQ3k1d3JPZkVRbG5hVWtld3ZocDYxK2FS?=
 =?utf-8?B?dWh5N3N1OFpaalV1WE5JekNPQU5lWlFmeDIySUo2VXU1ZThXenBFQ0ZSOGxy?=
 =?utf-8?B?YzNEL1JDYkUwTlRpK1IrRTNOdi9TSWd1bEhCMUxVdUNwMjlnRXcxR2ZsWEs4?=
 =?utf-8?B?VkpoU3AzejVEdUlzZitTbW51cmc3bng1UmhmbmFIR1RnWmtZNkVQRFc2NXRw?=
 =?utf-8?B?ZWhJZVlWQ24xRXhDK0I4d1lwZDh1ZkZucHlIMmhDK0E5TmwrYjd1dllrK1Vq?=
 =?utf-8?B?RFhSRFFuQmJ6NitISWhEeERHZDBTaVlnY3ArYzk1MTJsTkJ1eTFINlpvLzFy?=
 =?utf-8?B?U2ppOVY3YzRYNFlCQjZvUWJnamhuZkM1a2hFaE5RWkJKcm84VjBva2t1T21J?=
 =?utf-8?B?Y1lLd2xkL3ROdjUrWmZhVWhKdFVuOC9Xd1pwK29hMmRYcjNYekxGZnYzeTFh?=
 =?utf-8?B?NyszTzAzeldTVzV1cCsxKzZ0V1BhejVIQXQ2a3BnMjJzVDZ2OWFML3A0cnpo?=
 =?utf-8?B?MGpzVHBZbFdOQmw4b2JvRWlVMVZub1I1ZGU2bmtCQi8wcEdTTXBLZld4d1NS?=
 =?utf-8?B?Q2xDanNxODErMTg1SFcwZnZkaHh4bkpHQURRL3N5SkNOcVhRTFNtSnlSL2da?=
 =?utf-8?B?ZjhHSzZ2a0Z0RDhXZGhxR1QwaTRDUkIydGJEM1ZuRFE3d1BmWkF3RHk4ZDN0?=
 =?utf-8?B?R1BZS3dlZ2ZMb0dOVnkzbE1PSnZzSVhjUWVrT0lzU1BSTnllUXo1SC9aMW5D?=
 =?utf-8?B?VTdidno2OFByVFZua2o3OVF0KzNoNjBIeUx1eFdvMzF5bFYrbk1zbGRyVkd2?=
 =?utf-8?B?LzVGeTVmWkdhaURvbDVOWVlaQWg2RVpLeTFzQnppczJmYlRiNzVxY0h3RmVk?=
 =?utf-8?Q?qjMNOz7zly44xLgBcFCh2omaGJyZefDq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNoVGxHb2dNL1Uyc3cwSmF3Z3dOVThDQThrZ2NiRVhNUFNsQmFJRjRMN0hU?=
 =?utf-8?B?OEZTZ25RUjVXQU1ZMmN0b0NIWjJtRkdJY0t1UmF6ZEJ5OW1uMnlYNjhFQzhB?=
 =?utf-8?B?VzcrL1h6OGNnMG5LVC84ekVZenBKaUpGRCtZQzZRQXhDTXAwWUp4WkhEZzJm?=
 =?utf-8?B?UElKTGl6WUg4TnM5Z0VzckVrVjYwVTI4V0lKM3RmY1hhMWNCU3h2T3JhZXBQ?=
 =?utf-8?B?VG90RGdwcGdSZ3RBcE9KeitzaktsNXVLU1NZbmlMZ3pDZW1aTUxEK01LVU10?=
 =?utf-8?B?b2tyYzNOanFQUFdNTHg2dUMyWlM4QTU1a01WY3doZUxPcUtFaHdPdFl1dFQ0?=
 =?utf-8?B?ODRrYVdIUjhGYU1mMnI4VXNydDFuK0JKNmUzVVhBUDJIUVhTNWE2aXpHYUEr?=
 =?utf-8?B?R2F5MmF2Vk5VRmdrR3FGVVpJTEJIMlk2RzMyaC9Ua01mdCtBRlJCZGh6MC9J?=
 =?utf-8?B?eWtYM2NRRk5qZHJIRHlLUndFYjBVeHY0MDVzbWU5dHJOaWlXRGVMOTFIMTlQ?=
 =?utf-8?B?VVZXcEdLSWRCbEdBVDlXT0d3T2xSZlUrVm81MDRTcW92bExxTHA1THI2ZHJs?=
 =?utf-8?B?ZmFCcGpYMm5CQTA2NER6TXVab1QyOFlMRWJMWnVOVURCWjZnbkVrS2puUU5r?=
 =?utf-8?B?RjRkclJ4S1V3cVNXL2U5SU5SVHJ5cEdJcTloc1dxQ3gzU3FPRW9ieEltM3pa?=
 =?utf-8?B?dDlxdStzTXMwTzNqMWZPMi9VOTV1WXYrQUtQaVJWRC9yR0VjU3pPNlFNSnk3?=
 =?utf-8?B?QXNQcjNMNXdhTGt5T0ZMVlp2aG1HTzFyUG5UNzlnK05SczNFMmdXc0poTzlP?=
 =?utf-8?B?UW5JOWJjYzNyWWxLQnZRbzV4anh1VHJaWWs2MktKOEh2aEJlZUpwdnV6clRS?=
 =?utf-8?B?Wlk2cGExN0hRbTdFNmtZckIwcmpuMDVHdjMyYnZkTWJxeGptWGRWbEI4Zk5o?=
 =?utf-8?B?MC9JZG1icWF4Rk12NVN0b1dnL0lvUzVpMU1BRFBMT01EbVdyTW9kYkNUUTdF?=
 =?utf-8?B?ZWxUODcxV2YvTUhtSGhIdS9CdUs0a1ZRU2YrbWZoL3RENEQwVGw4NlpIQUFv?=
 =?utf-8?B?WC9qTnQ3MmlCc0tZYzNKVnVROVJRMTR4czNtYlI1NTNIVkplRXREdGEwckFF?=
 =?utf-8?B?K2p4eGhaVTRmcVdLalFMZkVrdFlQKzNtbkkwZmJiZHhYcnFkR24yS3Q2cjdz?=
 =?utf-8?B?MDdMKzRKM0F2TTl2VythUlVhRlRYUkFGQ3RWNXNXb2hGNmZnNlVqTkZVUmVx?=
 =?utf-8?B?VzBucXAvZ01QWExaQkF0TW1RRjNqYUJHa0VhUDhwNmpIMmRnRW1LcGpCLzFw?=
 =?utf-8?B?cWtadTZDalhWc0t6czdZaWovMXUyeDJMbW0wUDVsaENVbjdRaFBqQlF1UHgz?=
 =?utf-8?B?enJNTmQ0V1NGSC9ObFgxczhaSmRHcWV5U3NLZkZ6cnRmdEtrWkJvNVlMckp4?=
 =?utf-8?B?VCtTRkVyWVJVcXhXMVpHczgyc2pRYWwxSDRvdm00NTBUbG5GaEJncTQ5UXFJ?=
 =?utf-8?B?WWVLNXBOLzAwUjNCQ3UrRU1OUTBXY1p2dWNOT1Y3ZlBSc2hFa2JjOEhQbUVq?=
 =?utf-8?B?MTlvaUgwMFNxOStJKzJsaDBXeElXNi9zUzdvaXZlYmRhTkEwU010dW54ZVJI?=
 =?utf-8?B?MU0xamFwT1dTVDdkemNNcktodGNWd2s5WVIwNkN3VEVtOHdWbkd3RUg4NW1X?=
 =?utf-8?B?bDFreW5zYncrVm9qVUl4VnFKVVdodFlDQlhqMG00TGQyNUkrbEIrcTNkTC82?=
 =?utf-8?B?VkpjYitGc0ViTXppU1lzenJkdzVPVStRSmRzUk9qZC94TzNhRXFuV0phaC82?=
 =?utf-8?B?NmgvRERac21tNm16ajduUHUvS0NQVlFxTEVYYUhPbmV6T29SdWxvdmE1MGtr?=
 =?utf-8?B?NzUxN1lJVG9xMGF1MkVwenlnS284Y09QbXlFQWYxMzNQSGxxbXZ2eWQ1YTM0?=
 =?utf-8?B?akhpWGpEVFFIZHVEN1FwUnovUys2alV6cmFNQUtpMHJVcGcrVXBYM1M0blZT?=
 =?utf-8?B?em9uMHdERk1TSHF4RExNZHhCdDFoNnlmQ0kwaXJxSzRkVDY3ZU5vUW92OEFY?=
 =?utf-8?B?Nm1BQ29rNnFYR3h5eWJSSWFsZmRvYzVxK0tvVGkxNTltQVEyV1RIcytIVWZo?=
 =?utf-8?B?Y0orTE9od1ZJb1FBY0Q2TUpnaitkeFRIVnBhZG0vVHRXcWRjY1YwSHJmZUIr?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ab6661-41b4-4511-015e-08de271c0c19
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:30:55.9250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3wfsKVC1lAMGCxyGFQPmhJooVo/fI4RQVIVYYjQZaaVeYcmtBHa4dhBuyw214L4+LXobj6uOy4rElRf6Bfqe9qROI+kuvHgjHiFHeMCMbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7157
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Dinesh,

On 5/11/2025 1:19 am, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>
> Add SoC64-specific NAND SPL load support in denali_spl.c and update the
> related Kconfig dependencies.
>
> This patch introduces new helper functions to enable NAND boot support
> for SoCFPGA SoC64 devices using the Denali NAND controller during the
> SPL stage:
>
> - nand_get_mtd(): safely retrieves the active NAND device instance.
> - nand_spl_load_image(): supports image loading with page alignment and
>    bad block skipping using nand_read_skip_bad().
> - Includes nand_util.c for required NAND utility helpers.
> - Wrapped under IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64) to limit
>    inclusion to SoC64 targets.
>
> In addition, the SPL_NAND_DENALI Kconfig entry has been updated to:
> - Select required NAND SPL components (BASE, DRIVERS, IDENT, INIT, ECC).
> - Exclude NAND_DENALI_SPARE_AREA_SKIP_BYTES from SoC64 builds, as SoC64
>    NAND handling no longer uses this configuration.
>
> These changes collectively enable functional NAND SPL image loading
> support for SoCFPGA SoC64 devices with Denali NAND.
>
> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
> ---
>   drivers/mtd/nand/raw/Kconfig      |  7 ++-
>   drivers/mtd/nand/raw/denali_spl.c | 73 +++++++++++++++++++++++++++++++
>   2 files changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 754b99bf3eb..5e567ca4993 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -781,6 +781,11 @@ config SPL_NAND_CADENCE
>   
>   config SPL_NAND_DENALI
>   	bool "Support Denali NAND controller for SPL"
> +	select SPL_NAND_BASE
> +	select SPL_NAND_DRIVERS
> +	select SPL_NAND_IDENT
> +	select SPL_NAND_INIT
> +	select SPL_NAND_ECC


Are these strictly required for all Denali users?
If these are only needed for SoC64, it would be better to move them into:

arch/arm/Kconfig under SOCFPGA / SOC64, or the SoC64 defconfig


>   	depends on SPL_NAND_SUPPORT
>   	help
>   	  This is a small implementation of the Denali NAND controller
> @@ -788,7 +793,7 @@ config SPL_NAND_DENALI
>   
>   config NAND_DENALI_SPARE_AREA_SKIP_BYTES
>   	int "Number of bytes skipped in OOB area"
> -	depends on SPL_NAND_DENALI
> +	depends on SPL_NAND_DENALI && !TARGET_SOCFPGA_SOC64


This should not be added here in the common Kconfig.
If SoC64 does not require this option, simply disable it in:

SoC64 defconfig, or arch/arm/Kconfig under SOCFPGA

The common Denali code should not embed SoCFPGA-specific constraints.

>   	range 0 63
>   	help
>   	  This option specifies the number of bytes to skip from the beginning
> diff --git a/drivers/mtd/nand/raw/denali_spl.c b/drivers/mtd/nand/raw/denali_spl.c
> index b1e2c9d8161..78cdab51a5a 100644
> --- a/drivers/mtd/nand/raw/denali_spl.c
> +++ b/drivers/mtd/nand/raw/denali_spl.c
> @@ -5,13 +5,84 @@
>    */
>   
>   #include <config.h>
> +#include <hang.h>
>   #include <log.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <nand.h>
> +#include <system-constants.h>
>   #include <asm/io.h>
>   #include <asm/unaligned.h>
>   #include <linux/delay.h>
>   #include <linux/mtd/rawnand.h>
>   #include "denali.h"
>   
> +/* Only compile this code for SoCFPGA SoC64 targets */
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)


Cannot add the platform specific change here in the common driver.

The Denali SPL driver is shared across platforms, so we should not add 
SoCFPGA-specific logic here.

The function:

int nand_spl_load_image(...)


should be moved to platform-specific code, e.g.:

arch/arm/mach-socfpga/misc_soc64.c


Similarly, helper functions such as:

nand_get_mtd()
nand_spl_load_image()
#include "nand_util.c"


> +
> +struct mtd_info *nand_get_mtd(void)
> +{
> +	struct mtd_info *mtd;
> +
> +	mtd = get_nand_dev_by_index(nand_curr_device);
> +	if (!mtd)
> +		hang();
> +
> +	return mtd;
> +}
> +
> +int nand_spl_load_image(u32 offset, u32 len, void *dst)
> +{
> +	size_t count = len, actual = 0, page_align_overhead = 0;
> +	u32 page_align_offset = 0;
> +	u8 *page_buffer;
> +	int err = 0;
> +	struct mtd_info *mtd;
> +
> +	if (!len || !dst)
> +		return -EINVAL;
> +
> +	mtd = nand_get_mtd();
> +
> +	if ((offset & (mtd->writesize - 1)) != 0) {
> +		page_buffer = malloc_cache_aligned(mtd->writesize);
> +		if (!page_buffer) {
> +			debug("Error: allocating buffer\n");
> +			return -ENOMEM;
> +		}
> +
> +		page_align_overhead = offset % mtd->writesize;
> +		page_align_offset = (offset / mtd->writesize) * mtd->writesize;
> +		count = mtd->writesize;
> +
> +		err = nand_read_skip_bad(mtd, page_align_offset, &count,
> +					 &actual, mtd->size, page_buffer);
> +
> +		if (err)
> +			return err;
> +
> +		count -= page_align_overhead;
> +		count = min((size_t)len, count);
> +		memcpy(dst, page_buffer + page_align_overhead, count);
> +		free(page_buffer);
> +
> +		len -= count;
> +		if (!len)
> +			return err;
> +
> +		offset += count;
> +		dst += count;
> +		count = len;
> +	}
> +
> +	return nand_read_skip_bad(mtd, offset, &count, &actual, mtd->size, dst);
> +}
> +
> +void nand_deselect(void) {}
> +#include "nand_util.c"
> +
> +#else
> +
>   #define DENALI_MAP01		(1 << 26)	/* read/write pages in PIO */
>   #define DENALI_MAP10		(2 << 26)	/* high-level control plane */
>   
> @@ -240,3 +311,5 @@ unsigned int nand_page_size(void)
>   }
>   
>   void nand_deselect(void) {}
> +#endif
> +

Thanks.

Tien Fong
