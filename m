Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEB9CD98CC
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 05:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2A7839A8;
	Fri, 12 Jun 2026 07:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bvFl1onO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45BAC83FF5; Fri, 12 Jun 2026 07:15:20 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C648005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 07:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtw1NpjN8t6GfgisgTCJTUZBsxf1SfW2CdfhbaTWKo/X0K9Jeb8k+3ou+4Emw3cLULYr8Su9lQAeMdMGgoIIcJ1hP6UcC8+zziFXygHr4WpmYwVZTWgERB1fCsKryQFJ1aySqgVT09B4WUAaAGklVtI2THHaRb38DffyiUaVd3sqH326Hk/AohJFeqFkJys2PwHA2AJ/7zUkBKujsXF8BHMbIizUL4kxej15k15qB6PXEdBWlr+LfsZBR8lLTkSosHLFhGSQC+BRe3xpSq/kWzc4GdKvc0aszVoIvKVLKLtW007U1xTIEMTHuH5fZXoF6pq1p8KBg44443rM1GRe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA2S6asyanKQ8FgjJ+rpDOrpTsDw4rmMXY7DJPiVvFU=;
 b=jYoYna+yBqYoeQrvAegew29U7DVgrgW90oiL02Iytz3338CEnXc1TzfwCEer14+5JzNRuVwqc2P2yw+wGU15yT2BTW2vrgEfQKkbP/5zedjW2DU8pCCItoSdMtyO+oEYUFPLIn2Bj6C2Kdl5p9YrEuuOAYTA4ShG6C9TjrhnMt8XlnkIDyUC13c5W/mB5U9WWe8EesS6v5f8Cdxd+LTSWnvdQq5xfJJaKqpC2Kfdkhh5zhsTs/Kl/8N/+kLjSZFTZVKRKacXSgpXqW8Y7Zey7Mv9J9KMJGePdKuy8ZL1W/zH0Gdn3RbfwmJF7THE8z/+wSi4hM1BRyFRwe6Bi44kiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA2S6asyanKQ8FgjJ+rpDOrpTsDw4rmMXY7DJPiVvFU=;
 b=bvFl1onOVHH3XOlDg0L66ahKy+dF56I8beXYXxXc1aDKhBUY774ZFgXOFzbrkTdv30bEwibZTYuuAdUjSLa7r6+rjsLDruiXD8P02wk7Eykv0rP0jSIwncjRkDVvrTSTfgnIT8fn4UkjMsrIbP0tKeL9Q7U/cnBdkq9P27PTyoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 05:15:12 +0000
Received: from PH7PR12MB7380.namprd12.prod.outlook.com
 ([fe80::28ed:346e:a324:acd1]) by PH7PR12MB7380.namprd12.prod.outlook.com
 ([fe80::28ed:346e:a324:acd1%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 05:15:12 +0000
Message-ID: <d8771451-d817-4e5e-913a-f5ffb0a28879@amd.com>
Date: Fri, 12 Jun 2026 10:45:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mtd: rawnand: zynq: Fixes and software ECC support
To: Michal Simek <michal.simek@amd.com>,
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>
References: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
 <d3ff1c38-1348-4916-821e-bf2825d94960@amd.com>
Content-Language: en-US
From: "Kumar, Love" <love.kumar@amd.com>
In-Reply-To: <d3ff1c38-1348-4916-821e-bf2825d94960@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::12) To PH7PR12MB7380.namprd12.prod.outlook.com
 (2603:10b6:510:20f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7380:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed60ecd-6ab9-4c83-897d-08dec8419453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: HhWv6p9RcAnvFszAllwcD1mtz4HnAhwTbHrNesy7xD/YlBxikfHkONvVFBESTmBWxIKr+yMIDKyIe9iWpTS6Hwgf0w4GyiRIXDRLmE1KzqdDue2fd87MOGFIuqtdkPzyfeGEu6Fl1+U5YucneyNnd5ymgVs7VDCJI/y2kdkF0dz5J0L+0H6SrGfbbH2zsvsqyqfoh+Z+CQzlS4ewP+vBStOcRZCQiu82kUH6uuAlHuEPhsnINnSnF7a5ZyHGnb3DAHHs43xzo/R2VXm8t9UqeMFE4Qo+66eICiSU5EffDTmB9VXPUZB04YDW5L8W/fftf5K08MHJTho05mo9iMZTCHwW0VEgisC9Su0mx5JeYRYZxvMvQF2n9Y6tdMxiswpW0XS4Eeq41pDWzajUjz6R9554/Buk4PJdyrwEovam7+QSd2MPx31oTHchQ3hoI0IF6UoPG5TDIB5YlZnW6CxbdCE3QmuheZfMrv5YGqMj015U64THN0vP9GJbEQnRfCQ3+ynM2deo4bVRH4h+xleRNK3q8wQrayn5i8oMO3oQaOXxryYg28qB6D73BzpzaM0EHNSSoeSbd1/JePOQtrr0RRVeD8seFe6jw5g0MQFk4SBy6xIwfmxuFNN572WgBY3FXxO7Q0Ftt/+aICzYErI5MLfinQdrNX6t/etjdzFehWokW15+zQfRJPEN0IZoTpZqRFhBxHy3rxVn8Kzvz4iwhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7380.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJkMTRJMVFKZUpUc05semVOekNRTW8zbTZhOThOcUp2RWxSNkg1R0c3d3ZR?=
 =?utf-8?B?eW9SYUJSNUl1bGEzMHRLKy9uYk9hYVJrcjQyTk1wYURIVk9sMTB3Tks0ZGhB?=
 =?utf-8?B?QmtCQjc4TGpVUW1IVHhVK0kvaUs3cUNna0huWER5NXEzdFZiQmpSYmFQUUZw?=
 =?utf-8?B?TWZaMzNvNWxHMnBEK2dsVld4OHh3VGlQblVJM3lBLy9QSi81b1QxWUd6RVBh?=
 =?utf-8?B?clZlTXdJbzB5ZkkxVXo4TE4wK3pya0trTHVZMUZnM3JYNjY2ZHF1V3hFTnUv?=
 =?utf-8?B?Z1cwbHVLQkVCcTQreDZubHRwRnVXV0dGcHh0RldNd0IxQVNyMW1JR0lrUFVu?=
 =?utf-8?B?eXl6TWNsbFJGV1pSWnpML3krOVZuTVZiZ3hSMFdMUTM3OStVN1hlaWNEbkJN?=
 =?utf-8?B?N0RFU3VyaEl0WlVjb2NVS29OTUIxVmJ4enFocElwRUw0WWIwOHZqZG9uS3Jk?=
 =?utf-8?B?ZWdmbCtyTldSVDl0SGZkaHpRZzRpMm9VK2w2WGp4dTVkVDQxbXNQcTZnU1lQ?=
 =?utf-8?B?U1M3NlZCTkd4c05rdFRsYkhhYWROSUZOczk5aHhuUDBIb0tUMjU3SWpVRWdy?=
 =?utf-8?B?akxVZ3N2dTZoVDR2SnNGSTZNR3JPMzdDeHJ1aFJ1R1RiNExYSHZjd2NtdDVk?=
 =?utf-8?B?UTVkM29ZQTFtVDgwblFsR0tOMUgwdFZwNXkrbEQ5cGF2dUQzY1VhMi82WldS?=
 =?utf-8?B?RHkyR1dCLzFsZ0RnZjJnSEVHWGNNRXQ4MUJnK2J3clgvQ2FqSWZFNGFKS2pN?=
 =?utf-8?B?STNBSEtVdFpjU0o1MnRpSGN5cTczY2FEN1psMUdtMEJaaUN1anNaSjlxV2sw?=
 =?utf-8?B?Z2VDUzBhbGVGcVF6UmhNb3NJN0pIR0NiaWp0SHo3UmtmMlJ0Zk1zYXRGelFO?=
 =?utf-8?B?bTZENlIzUVNLVUFJU0ZBQUNEdWtva1lGYkY0QTRWVCtWUzZvZUtzWVpzVHk0?=
 =?utf-8?B?OTVzNnVSWVVpbEo1bS9kSW5nb3lhV0JMdFNZTlJtd05OWlltZWxEcjQvTU9V?=
 =?utf-8?B?UExRZUgxRzVLYjZXeXR1WXFzV3NGc0h2Z05od04xTGVaNGo5ZWdXS3RTV2Fi?=
 =?utf-8?B?Vy9ZVHlnV0VJTmFWQUs3VjJmbDkrRXNYL3lPalM2bUdtbWNCdnRSWVNaTlkw?=
 =?utf-8?B?SW0wTkg5Zk5XRGJ3bG5ELytZQlFOT2dCOXdNZ0wrTnc5am42MW9FRnBqdnhP?=
 =?utf-8?B?dFUxeStIM3g5RTVua3d6SktVMC95dStJRGVzNS8xaHNoOXRTTzF0dU1kVFdl?=
 =?utf-8?B?NmxKZEhNa3NMMzAveUcyTlAxbmxmYUs4dWRTdUt0V0pwaE9YWnU2ekdzcW40?=
 =?utf-8?B?Wk9FRDZRbjdqODQ1RTJLUWZrRW5wSGpzYW9BSEk1ZGluQlhpTlZiVnFpSmNT?=
 =?utf-8?B?VjVUSElrKzAyNFR3eHBFT3ZvVk9PYkRDOE1admNwRGlmemtLYXp4cHlNT1ov?=
 =?utf-8?B?d201UENXZHpib25BZFV4TjFtak12VHZuald1TkNDczIxM1E1U21LdXdXRjhv?=
 =?utf-8?B?V3JFVFhwK2xFZDhrMUJXOUlTQ1B4bVI1RENQa25pZ3JOTU1OYzlzQ21KeFVY?=
 =?utf-8?B?ZHgrVVlrNFQ3SWRDeFV2VFNjUXdMZDNwV0c3SHJ5SUZqQThCRlhxSzRlcWdD?=
 =?utf-8?B?WU53eFV0RS9jajNrT2dRWGQwbFp5TEhEaUJDR3NOd1lFUXh4MWFaMDZtVU1m?=
 =?utf-8?B?Y1c2bnFiOWhXdG5rWVRTODFMckpxRFFLYUQrVkthdDh4cStKdnpYUGFYOXlW?=
 =?utf-8?B?M09wV1dDSUVKWmYzYW81Y1B6L2pjTUE4NEg5d0dhUXVWUDRIL1c5UWwxSmNz?=
 =?utf-8?B?S3Yzb0pmdUJFTjNYVlA1VlRZTm5QQmNpZEdnaHVORWN3YW5BL1JzZzkvdmt2?=
 =?utf-8?B?MEpwSVpMb25zUm5FTVB0cVlPTFdtOENodXdnaHBpZjdRc0N6RFpsUWVzaWpN?=
 =?utf-8?B?cFEwTWZyTTY2QndwNHhCQ0dxeUhYaC93N3J5RUxSMUNwdTZISDl1dVVrME03?=
 =?utf-8?B?QkN2bk9ySGx0TW4yZUxUUHJiZm1rNFNScjVJeG1WU1lNS2JhMnBsVmJzVEZh?=
 =?utf-8?B?Z1ZCT1B6aWdSZ29GY2VIenJaaUhpTnRYWmU5UVRpTW5oa3hvdXB6UFY3L0lt?=
 =?utf-8?B?UXVjcXlmT2tMQ0lwN21UcUs5cWMyaUZrcms2eVN3V3Q5NkttS3BTaWx3REsz?=
 =?utf-8?B?UlZ0OU5zNUk2NVJmSDNNaGQ4SXFwY2FGTURXRlJzL1VoZWxqcnpzUlU3UDRQ?=
 =?utf-8?B?WGZBa0dLajc2STd0d3ZySWl5dzVSNy84N21RZzJTeUN4MnFJZkxvM29CV0s1?=
 =?utf-8?Q?K1SmjDA1qGwmZlhwYF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed60ecd-6ab9-4c83-897d-08dec8419453
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:15:12.3913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55rGLxYvTWfrZCIEpOOjPqcgbDjBmhtoXkvBTYSONqrUaa77zOrskDLDaBNJBjr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675
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

Hi Miquel,

On 6/3/2026 2:12 PM, Michal Simek wrote:
> Hi Love,
> 
> On 6/2/26 12:28, Miquel Raynal (DAVE.eu) wrote:
>> This driver is deeply broken in many ways. I've tried to clean it up by:
>> - flagging the most hideous parts (where Micron on-die ECC support is
>>    hardcoded)
>> - enabling DT support, eg. for reading the ECC configuration
>> - fixing software ECC support
>> - aligning the software ECC OOB layout to the rest of the world and
>>    allow a working interoperability in Linux.
>>
>> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
>> ---
>> Changes in v2:
>> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
>> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
>>
>> ---
>> Miquel Raynal (DAVE.eu) (5):
>>        mtd: rawnand: zynq: Align the layout structures with the driver namespace
>>        mtd: rawnand: zynq: Add comments about very bad practices
>>        mtd: rawnand: zynq: Make sure an of node is attached
>>        mtd: rawnand: zynq: Do not fail the probe for no reason
>>        mtd: rawnand: zynq: Fix Software ECC engine support
>>
>>   drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>>   1 file changed, 28 insertions(+), 87 deletions(-)
>> ---
>> base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
>> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
>>
>> Best regards,
> 
> can you please test this and provide results?
> 
> Thanks,
> Michal

We are seeing issue with zynq-zc770-xm011 board with NAND write.

Below is the log snippet:

"""
U-Boot 2026.07-rc4-00024-gbc44b6a0aeb0 (Jun 10 2026 - 20:00:05 +0530)
 
CPU:   Zynq 7z020
Silicon: v3.1
Model: Xilinx ZC770 XM011 board
DRAM:  ECC disabled 1 GiB
Core:  20 devices, 15 uclasses, devicetree: board
Flash: 0 Bytes
NAND:  128 MiB
MMC:
Loading Environment from nowhere... OK
In:    serial@e0001000
Out:   serial@e0001000
Err:   serial@e0001000
Net:   No ethernet found.
U-Boot 2026.07-rc4-00024-gbc44b6a0aeb0 (Jun 10 2026 - 20:00:05 +0530)CPU:   Zynq 7z020Silicon: v3.1Model: Xilinx ZC770 XM011 boardDRAM:  ECC disabled 1 GiBCore:  20 devices, 15 uclasses, devicetree: boardFlash: 0 BytesNAND:  128 MiBMMC:   Loading Environment from nowhere... OKIn:    serial@e0001000Out:   serial@e0001000Err:   serial@e0001000Net:   No ethernet found.
Hit any key to stop autoboot: 2
Hit any key to stop autoboot: 0
Zynq> nand info
nand info
 
Device 0: nand0, sector size 128 KiB
  Page size         2048 b
  OOB size            64 b
  Erase size      131072 b
  ecc strength         0 bits
  ecc step size     2048 b
  subpagesize       2048 b
  options       0x00000000
Device 0: nand0, sector size 128 KiB  Page size         2048 b  OOB size            64 b  Erase size      131072 b  ecc strength         0 bits  ecc step size     2048 b  subpagesize       2048 b  options       0x00000000  bbt options   0x00028000
Zynq> nand erase.spread 0 0x2000000
NAND erase.spread: device 0 offset 0x0, size 0x2000000
Erasing at 0x1fa0000 --  99% complete.
Erasing at 0x1fe0000 -- 100% complete.
OK
Zynq> nand write 0x80000 0 0x2000000
 
NAND write: device 0 offset 0x0, size 0x2000000
NAND write to offset 0 failed -5
"""

Please have a look.

Thanks,
Love Kumar


