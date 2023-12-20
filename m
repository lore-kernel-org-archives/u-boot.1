Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D158C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 14:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB23D86D33;
	Wed, 20 Dec 2023 15:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tYT6B03s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B35F187509; Wed, 20 Dec 2023 15:43:49 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704798037B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 15:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZtRcQjeu95UMP+pfCefNL5IvQLwZA3zsn6k39yV4Gis0r7ET0o3JKtYDrDEjFHasEngnmj2Ch0fvAVHoe68fWn1IAwF1P3sa94kPigdlJ79foaHz7pna3pbGnFEVfIsZ7liev7iXGI1b9PUsQPXYcJUbGvDTgYowYiuj/Zp0iSzN+DeI7QHT4njcIkD7G8ylGDFWBFYpiL9QesLww+ZspJFwcXLdkSUyMQv7CQ1AQxG5auJVFwk9C/UHd6CuYU+Gn0tCzCCuJtZ7cEaTxuLig1bPpXrIL9Bd40DoE0MV/R9reHIjbz9hug7t/860m9UHg9uzD2tlqZ/zGfFb9BgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6aw75rOFNvEWgq49XmfNpp+5/R0hAPwSs0NktacQPM=;
 b=Pb+EjiDIIEfiyTH6UhwWkKJruANflJvw96j+ym/STFi86DTdwHIxm3x9GB9+cpTDlDPcEX+cHN5zOGSID26xd8L5fLoiGTmbYzVfHYW+9IJ2C16TjWUZUVerRG5/HIKk10MK/BLEa3K9rDwr5ZHgOv5Sue4bAKkSJNt5uvHzBvKFPE8k07gilYkBWxRgjg3hqVRQZPCMfGgDzHeK7sFQgSPAkw2HTH8TtADLDTYmDE83wkocDh4hidKWa9MWTpB0D1i3zYixlGl8Ku9Q8NNSZZiD0cOu0t5QNC7EurER7Ul/W5sTrPC0AoSMi5EvbzpB0Vfx+9u88BIOgqPBAmv6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6aw75rOFNvEWgq49XmfNpp+5/R0hAPwSs0NktacQPM=;
 b=tYT6B03s0ujeRM6OkYA2itW1PQZAWBKEmysgg4xFalbtNSWScCXkrRBsJBJM8s7nxuXMfFHhL4cHH6pYelalPQWERVanx3S/nC5Cx2iWTkCwA9A7GaBaMWnYwQzc4E0wt+VIbt6TqKlgR8HhE3EL1Z1btJUmIxvsyHXPDfWGC50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:43:44 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 14:43:44 +0000
Message-ID: <f6dfa726-3b1b-448b-b4fb-8593ea97512f@amd.com>
Date: Wed, 20 Dec 2023 15:43:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] spi-nor: Add parallel and stacked memories support
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, git@xilinx.com
References: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0053.eurprd03.prod.outlook.com
 (2603:10a6:803:118::42) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d37ab81-1a41-4683-0747-08dc016a10db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRhOwL6kJJ0Pdcsf8EMRiLl69kEU+fBH6FCuYUcbE+3f4gIW+p9ltYuFn5Lqn4V0i5P0JdTiN0TmKTdR4jSFcAfdLq5S0sEocWoYZ8cQ/cUrQ8AOn/C81zbnVX1+S8XvXr02eXlYr0y1U7iPfx+FKkdAM01eN+4Ca/xwK/s9WZO0xomMo/XEOEygEr79w2fNoh7rHfYQhiayHKStcr8L1ZvyIzqCK7+bo9QUJvGZMeqnDJWu6iGprSS4h7VUcn0QYwDyQAMl+zq5vVwVqD0xOF6LBUZ+18f55jdkYUKuND4vYG2rbh4+wrBqzQsqAn+GdtcWAt98F3vQTTPGBsXRbBfjVyoENB/DIEUojTQ9/TpqiROmuRqQFbOX9H9HMsmV7ZrSGEOmpMFVV6mKfxHaVS4nWapSwu2QM60BTj30visU0PaSYaPHgwKL6t9TD/R0qmHJ67hCwzt0z/N4+PeERV6HJtQH0CHdgf4FaN9WBMyItd+nU6VUEcIhFCcyohRP4Lmba6IJ8qQvcK55hXj+Xe/ImjLBFtL710y3sIsD3EOlFHLNovX4+mEURWWn/tkBAB0z7H9+i0c08XjFULOL+xeGWybrlWRyRlE5lJeHwf2OP71Q9MorM749Em//YdSYZ5aWA2p2mj3k1XBLjdjkyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(26005)(6506007)(2616005)(6512007)(5660300002)(41300700001)(44832011)(4326008)(8676002)(8936002)(6486002)(53546011)(316002)(478600001)(66946007)(66476007)(66556008)(2906002)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVHUGIwUEc2MWNwSW44MzFaU2ZMT3FhWit2UU5aMHRuN1hYVmNZTzNleUJJ?=
 =?utf-8?B?cUdoczBESmhaODhHRDZhdWt5bXhybHc2d21LNWNoYXB2SFY2b3RMdmk3SWZT?=
 =?utf-8?B?MVBpQXd6SUFyOURBT0RFUHhwdlhkdWIyRk9GTk90dEkvNkVVRVIrWGYrZlVR?=
 =?utf-8?B?eUxuNzJsUWdWSUVhQVdFRWdPWXJndzZ0NjY3L2NnV2s0NzJhSDFKeXRCU1FZ?=
 =?utf-8?B?SVJSS2ZkQXF0NFQ0cmkvYjV0azZkOHJwZWljWVFoZGtWY2ZJSElDT2VSMzV2?=
 =?utf-8?B?OFBHbjhyZWhqOStSTVB6SW9GamEyVFZwOTBJTDh3VVc1amd0QzNnNThISGs3?=
 =?utf-8?B?QXRtMkxTTmN2dzZ6YXYzZDBQemcwV2hLMGszYXZvWHJVQ0JmRDFGR2s4aEZZ?=
 =?utf-8?B?ZWVldXBZUGdzakMwMmRZM1E2dXRyTDZQRmMwd29TVmZ6c01xeU9hTmdXL1Mx?=
 =?utf-8?B?ZmlOQUc0V2ZSNnhwaDVnY3o1WGdveTlMYkFndXdCOGtPZXVTdjBMY085WTkv?=
 =?utf-8?B?cEtjcW92Wkp4bFlidkF4RXhpZWVyNEEvWWJ3YkJRNFJrZHRaWFo3bHNpWUh1?=
 =?utf-8?B?aUhHZGl6SS9pUm51UnB3RFlQNWtla3RIWThFNW12L081TS9YWVZMM3dDdFJ5?=
 =?utf-8?B?Zms1L2hvd29YS3dVbnY1dHVtMzk5RjNQNU5EdlBHVHhsMWJqZDA1bUhSd043?=
 =?utf-8?B?dnVDV2xDc0RxQlJrNGk0ei9pM3FhUFpMTlFLbXJLWGRpSFg1MUFmdFdmSVZo?=
 =?utf-8?B?QkE2Z2tyRUZJNXdzZXEwWklic2JGWGJUQUdja21SSHlpMVBMemZ1V3BWK2Fx?=
 =?utf-8?B?cDczaGNMM2NFWmlVWTZNbkxuOVVKby9UZEpqNFRKQjR2OGlpSWV3aFZIbG95?=
 =?utf-8?B?OWJpcXQ0UW5tTmpFVDhzVlFSeHc4Yys2R3NoSzJJczl4Nkh2eTU5VnpZMnNh?=
 =?utf-8?B?c1ZKYTlkbEM5TWVaMjVsaWxBTW5QRnVOZVFzSDN5YWh2Y0FqdGcrNC9BN1l3?=
 =?utf-8?B?TlBqenY1dTQrRXRyaXRrZHh3WEYzZ0hRNkx4UkQ3ZmRBRjg4UUJhdmVueWdr?=
 =?utf-8?B?QjRBK1RSZHV6cEtvenJ2azI3RFRaNUc5ZkRUWlFXY0ZkVzdBcWZkSS9CYXpC?=
 =?utf-8?B?bzgrbHhFMURIS1VmRjhodHFJN2twUXZSSDlJZ0Z4S2I2U2pNc25ycC9LM1BH?=
 =?utf-8?B?a3FYbnBJZytqYnFob2RtTThLU25VWDRLUnhiOEt5Q3p1dTcxVFJuZmJETE9H?=
 =?utf-8?B?K3lCcStGSnFRZmo5UWFrYjN1LzV4d0ZWS3FpL3V5dXF1cHQ4d0dOT2MraHNJ?=
 =?utf-8?B?ZHFDL2V5bGI3Ykt6cE1vaVloNDBZbGlCa0pwUkZhNTV0Nm0wc2RzeTQ5N0dL?=
 =?utf-8?B?R1gxZ0tEcWxVSnlzdWJPS3cxOGN5TnJSVXI5Z21RakR2cHB0NXl2dGxYN212?=
 =?utf-8?B?cXdHbE5PKzZWZ3FMUklOZWVQZTlnMjg4MTVFT0hVVkVjdHp3Y2hWZlZ1VmYx?=
 =?utf-8?B?U3dMcTRQeTZmWU1YYjdZYnpCVHN6NW1jemk3SVlpRFhkbmZHcjYyQ0FDSmxH?=
 =?utf-8?B?czNnajhKNXltWUlFaEo3R0Mxa09VNFRSNEo4YWNrQW9rL3RyZVZDMGNHWm5O?=
 =?utf-8?B?WThZVkF2SjNQV1I0eXhEcmpRSFRBdG9lL2E3dkpuWjZQWDk5NTdsaHc0bVZC?=
 =?utf-8?B?VEZKdy9tL2hWTlRmR0RBUnEzMjU3bTBzcVJNbElQVStVZjdINDFiNmE0MDI4?=
 =?utf-8?B?WjlWck1heWFrNG1IVndlM0lVbk5CcHJRZS9vUjNFZkZVeFhEVzh2YS9aeVVF?=
 =?utf-8?B?a3h3bXlXeFN2RTVTcEU3UzdnU3BlVy96S08rSEU3QVlkbzVlZENZakpjaE1o?=
 =?utf-8?B?ZWptelFjZzdRUTB4UXZvNnhWdG00eE01dUJySm51UTRpY29OT09SeSs1N0ZC?=
 =?utf-8?B?ZFZIWFJmU0djVXFMSitTOFpFM215MDVBai9NYXRNSjVWckxVNG82WWtuQysw?=
 =?utf-8?B?T3VtWmJhWmJrVkl4VEdFOU1STzVkbkVpckhtb084bWR2QnBqKyt0ZnptVWRn?=
 =?utf-8?B?bEJONWlYYlF6em40cXBJNjExbnFodU9hVTZQTWNNbm1pemY0MmY5Q2Y5bWVn?=
 =?utf-8?Q?duENs73s9GYXgxGdVv+CDOSNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d37ab81-1a41-4683-0747-08dc016a10db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:43:44.3671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PpHTgGX74v3RymRWKNU6840RN4OCC1puYDARqCWyMUNzz3tHXxBVzu3dG+ra0Fx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613
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

Hi,



On 12/19/23 05:15, Venkatesh Yadav Abbarapu wrote:
> This series adds support for Xilinx qspi parallel and stacked memeories.
> 
> In parallel mode, the current implementation assumes that a maximum of two flashes are connected. The QSPI controller splits the data evenly between both the flashes so, both the flashes that are connected in parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
> 
> In stacked mode the current implementation assumes that a maximum of two flashes are connected and both the flashes are of same make but can differ in sizes. So, except the sizes all other flash parameters of both the flashes are identical.
> 
> Spi-nor will pass on the appropriate flash select flag to low level driver, and it will select pass all the data to that particular flash.
> 
> Write operation in parallel mode are performed in page size * 2 chunks as each write operation results in writing both the flashes. For doubling the address space each operation is performed at addr/2 flash offset, where addr is the address specified by the user.
> 
> Similarly for read and erase operations it will read from both flashes, so size and offset are divided by 2 and send to flash.

There are much less errors which is good sign but still
imx28_xea_defconfig shows this.

.../arm-xilinx-linux-gnueabi-ld.bfd.real: drivers/core/ofnode.o: in function 
`ofnode_get_property':
/mnt/disk/u-boot/drivers/core/ofnode.c:1185: undefined reference to `fdt_getprop'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1


And SPL is bigger for taurus_defconfig and axm_defconfig.

And can you please rebase it on the top of next branch?

Thanks,
Michal
