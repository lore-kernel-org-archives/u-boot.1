Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8AACDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 07:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0943B87257;
	Fri, 20 Oct 2023 09:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="ma1/rb+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A190487254; Fri, 20 Oct 2023 09:16:19 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCF78725A
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 09:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=stefan.herbrechtsmeier-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SykzhiJ1mPFX0VTn5fPXMLUb2OLmYS51Vg0J5VHE2RqD6MSJTyjZz1SCFiq4yqvkRiDWgRfzk/nd7k40UWVg7LcuPQfoRWaMSGJdG724CaLFsPzWvlKMW8fNn5DT2Ekwh2l7pLhrnag4pC9t0jLxbXdaE6RzsFH0TUwHLe9Xaf/A95HkgK4rn76QVwdpE/2z55gx1nHMDggaH7B5+ge905Y1wx4fRBi+EdFRy+swgY9ZEK3oIu+cBz+r6vf0FwzzPSavkNBCcMZvEJfgEzg9GnXctV+AG1w7uo27zgsrOtwqPDOeQFnYG5rvMOXD9Er4T6ZtPdnyXSDuv5cTKAyttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGIgkiSaQGful9JN3I5k6MUp+sw42A2tJzu8+hsQ8Wc=;
 b=g4xiVJZFxIuFFNIw4MzKqhFJAlKNi1jOh5hG8NYGqClylvZBwC2yM9jgDLWDOp0R42FK+d1wyZYMIEZj3ZGa+lGcvxI4OeAmd67e0Wc4eOMHmD82762IbR8qQB7qnayNP082JFl2IhcrBGDVfWq8VpAV47cNptOPB+L1c7Tergsle1oLAh+58o6EZa0MZ5O4vUocGCxcH0ojAN156Um/U0MbLIdl4td1E6+hJd6qmdTapHjELrN3eXHFOJjfvjlDWnlRrHsZHmDcPLuUo608sqTVYqQiO5HTWQ/PGwOoVuz1aKC9HMD9vWhU+YJjVxgiG7ivwTG6r19dZaU6lnZBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGIgkiSaQGful9JN3I5k6MUp+sw42A2tJzu8+hsQ8Wc=;
 b=ma1/rb+cPfcRdrB5KJSZBRdlXZ1EtDjRHCM7d9ib6cfuX3Zt20JjJ4iCmyEnH/43ruOxEi5wzy9LiUuYTtr3D7INBZiLiiItLeuzSLjO8ONcjHwqABnhxbs2ylU16/b/RdOhsaYZePS/QYktorGNKO/GTTRO3LfX0CIzxL+82aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS2PR08MB10352.eurprd08.prod.outlook.com (2603:10a6:20b:578::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:16:15 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::995:f33:7bda:504d]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::995:f33:7bda:504d%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 07:16:15 +0000
Message-ID: <d648f265-5b86-48f4-980d-0064c7ce0028@weidmueller.com>
Date: Fri, 20 Oct 2023 09:16:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] spi: zynq_qspi: Add parallel memories support in
 QSPI driver
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 git@xilinx.com
References: <20231020031817.267959-1-venkatesh.abbarapu@amd.com>
 <20231020031817.267959-7-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20231020031817.267959-7-venkatesh.abbarapu@amd.com>
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS2PR08MB10352:EE_
X-MS-Office365-Filtering-Correlation-Id: c560c28e-1497-45fb-6fe7-08dbd13c723f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZgyIX1kj3pZBqS0sSXdI2/Ie2DTV7NC8RT+GtGjSBSKAwlIP15tN1m0Gtpi03V/wm6kREvV0JOui7gdjJWKdwSZiFHFHHmDoakMpsgm2BKdrCjlW1ELolbINfj3MF5jD0awFIhrEw2uzR8nQfwVEajVfOAJ0ZsQwz9iC+Yho+Wjwl6XJhhWTI4m4G6trx0WVH0OUutkmg8hFcoaLdeHghIoOrdMTv2bmorhe+6zd8XWu/rBJRAySz1eaei5Bdg4CeW2kGhAd2J32TfDcGdhjD+hFUdm8VYA1mXwlbQ9XHS7L4K4Hdwa4cRAmrSyXGiGPVlDYAsLfV/EuWetkEtwL/N7b58V7uZG1t6ZfX4EObmgDgQzWbDcxjkiZxV7W0BQVar8K8VlCiwuaiDo5Jd4cbe9qGbSFtu7rRPy64/kkwkr8tAwngYoeprZ5HhuIo/UzD6FTUenXF67KVpo1IdZSEphzHjJAVQH5SJ2PSxbnZQ9sZAqHHNnPqHQHwvpzyN2eNwnsFcDElimjevgyxsFjNaZjt9MCPMH5/4yKaW4hjz1pGarUZDxg29iL+uWzb033FqIcNjAEmiPLb/ISIVkok5isJD4em+RuWb+jUwkJGtnW8kywx3NNJlZe/0K/dxKKu6nl18A8atpK6Cg8H0xcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6969.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31696002)(33964004)(6506007)(6486002)(478600001)(4326008)(8936002)(8676002)(5660300002)(41300700001)(2906002)(66476007)(66946007)(66556008)(316002)(83380400001)(38100700002)(36756003)(26005)(31686004)(86362001)(2616005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXkzOHE4aEtRTzNGUEtkWjRnbXlZSFRxRXQ3bzRuZXNkZ01MWVVOaGxxZEwz?=
 =?utf-8?B?cDYyQk1NMmxVV0h0K0E1NGgzN085bzRWeUxKODRWdTF1S2NiaHdzWE0yZ1FC?=
 =?utf-8?B?NFJ0UVBQQ3R1dHhmYTJ4dC85dTdBK1pWaXNsNVRHblJRV1lkOW9uTXBQSXF5?=
 =?utf-8?B?dWo5MitNOVRwYzcwaXhxbzBoU2l2aDluZk1Na0dUZG93VlBiR1dMdG8xL09W?=
 =?utf-8?B?NDdqbVhTWGZSMk1UTk1EZzNaQklFTW9SaXAreFlvOWV2b1F1bkYwZWZvUDRX?=
 =?utf-8?B?OHhVVG0vZXFzT0ZJcjFqQXd0dDZLaE44Wm1tQjQ1bjdwQVBoZlRMV2x3L0s5?=
 =?utf-8?B?bUJDOTh5cUd3TVUra2dGRVJQY2ZZOHFYMWRRUmUyWXc1UUhvbXQ2OGxzQVVx?=
 =?utf-8?B?WnNHd2hwWmpvUzVpeHZUY0ppYWt2OSsvSjVJTzBtK3k1OHFuanBmNnpVTHFn?=
 =?utf-8?B?ckdjMlNCbEN3dFJTYWQrdFhtc0NhM1lRVU8zUEtteDdSSDh2K0laY2ZHcGlI?=
 =?utf-8?B?b0ROa2ZRRnJjSFlibURzVHZCbUpsN3djT0ZPMTdsUk01dFkvSmxtRkpzUS9n?=
 =?utf-8?B?ZmhkekF4Tm85WldQZnNLVVlld0NVWTY3UE9lK3VML3NRNGMwWVBveHp6Vy91?=
 =?utf-8?B?cHZBdGUwNDZ2VXpHclh3cUN5c0dMWEorRVV4UVFPc3ZLMGhNRWl1YmRxUUoy?=
 =?utf-8?B?d3JHT2l4bU9vVExmY0FqWVc4ck15a3FvL0UzNmFFQ3BocUlVSWdvRlIrSWYz?=
 =?utf-8?B?WkVKYk54dThIR1huMmRIY1ZtaEVMc0ZNUXhObktOOGhOSXQwZnNlQ1RGUVkw?=
 =?utf-8?B?TkdvN1g5T3Y0MVlQRUMzdFU4SjE4QytSei82SEVqSm4xQloyQzhIdXErWm9M?=
 =?utf-8?B?NW1rT2h4ZFhBMFhXb3N4emFjVmE0SFJmQlZDQXFzaC9nK3dyc2plbzVzL1Fp?=
 =?utf-8?B?NEc0a1hhdDRpcXlkZGU5WHFjTStKSU1DTytSYzJlYmxXOFBrZzk1YkJyNkty?=
 =?utf-8?B?ckRHQ2Z4VlJOOEwxVURXMi9NTkVsenNBbDJkK2FKUmNoWUxiRGM4UGZpLzla?=
 =?utf-8?B?MjVYRzZCckdxU09pN1V4UWFaVWVZV2xoU1RGbWlQTmJoNEZFMzV0anRyZ1VS?=
 =?utf-8?B?N3lpb1Z4T0FFalFoYStjRGVyQ2dqZlFqdlFYWksxRzQwSjcrK1VJUGVORXpJ?=
 =?utf-8?B?KzIwSi85ekhsYWJxak55NlZodXZYVGcycHVvZzRoNVBrZFhUTTdCV2NSMUoz?=
 =?utf-8?B?VjkwMnFwK05lVmZPYXloS3RZSkhESjh0VG4rdzhDalY3eWlLWkxZZWEwVHZa?=
 =?utf-8?B?R2NYdHdsSGh5dUE3a0lBaktTSDdMVWhaRXdWdXVGUGxZREE2TUdOZjZsK2dm?=
 =?utf-8?B?dkliY0NiL2FxT1lCR3RDbzRmOWU3bkllMWNwWkhpTXFhREUzYkliQkVGdU50?=
 =?utf-8?B?Uk5zMUQrYWdLLzlYdlJiNm1YT1YvdEtyMUJLd1RQc0pwdGE5NkVzbkY1ODUy?=
 =?utf-8?B?UnRyVmxxODNlV2p4SFJNTWdyOXJsQlBIbGM0Umw2Rkt4b2duSkY4Nzg2TlZj?=
 =?utf-8?B?M0NKYmszODdZVHRtWFFVUUJ3WmQ1eVgxMmRkbmZkZW9uM0ZZWFdLMCt1bCtO?=
 =?utf-8?B?QmJRN1pBSTFabzUwU0Z6Q3NGUjdlM1F3N0RvQ1BBWk1DUndVdVJXMDExV0M4?=
 =?utf-8?B?WkVwQVhSQzRyOTlxekxJWGRDRHJpL1RNWGU0Qk1QUVdzTW1aMVZwNTc2bjBL?=
 =?utf-8?B?WlROYTluRE9Fbzk5UzZ0Um5rSUtOWUlITFgrakd6QXFMMVpIbmtEMzVaYW5v?=
 =?utf-8?B?T3RkZkRpT2hDMHo3bjB1L0J5NDlxUkJDbmVlSlM4R3h2MXdHN044RW5WQWJ3?=
 =?utf-8?B?NVRnTWlpVzFGUVllWVA5SHNYQkJ2TUNKOTZxTHB6TG5RdWdzK3FyNlk1K1Va?=
 =?utf-8?B?eDF0MWJDRnpSSFVRcGhJOGJOclhDLzEzZ3lwVFA0YlRVL0RhejliWCsyVXJh?=
 =?utf-8?B?QloxNVlKMFJyMkRpajRlRThJc01CU3BNUlhkUUltZWdCZ2VOMU1zTndvcFVk?=
 =?utf-8?B?blZxSWgxRGJvWlh1a1lhV1JBSzgvaUJXT1MvZy9pNlRPRW5OdjJGSXZkN05h?=
 =?utf-8?B?MUNqa2dYaGtUQ1RJUXJta3RXQlhpcWFzcEVKSjBIYWd5dE5iTmtxM2VaeHdr?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c560c28e-1497-45fb-6fe7-08dbd13c723f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:16:14.8929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTVvVxQnSTX3/RffxJKZoWgikps+nC7x+yvojTUkcdIEhs4m0ghqhp1XaK4i1Z7B9m97KR7SibFZIaQvnzVF2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10352
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

Hi,

Am 20.10.2023 um 05:18 schrieb Venkatesh Yadav Abbarapu:
> Add support for parallel memories in zynq_qspi.c driver. In case of
> parallel memories STRIPE bit is set and sent to the qspi ip, which will
> send data bits to both the flashes in parallel. However for few commands
> we should not use stripe, instead send same data to both the flashes.
> Those commands are exclueded by using zynqmp_qspi_update_stripe().
>
> Also update copyright info for this file.
>
> Signed-off-by: Ashok Reddy Soma<ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu<venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/zynq_qspi.c | 140 ++++++++++++++++++++++++++++++++++++----
>   include/spi.h           |   4 ++
>   2 files changed, 131 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
> index 069d2a77de..3471c301bf 100644
> --- a/drivers/spi/zynq_qspi.c
> +++ b/drivers/spi/zynq_qspi.c

[snip]


> @@ -112,7 +136,6 @@ static int zynq_qspi_of_to_plat(struct udevice *bus)
>   
>   	plat->regs = (struct zynq_qspi_regs *)fdtdec_get_addr(blob,
>   							      node, "reg");
> -

Unrelated?

>   	return 0;
>   }
>   

[snip]

> @@ -688,6 +788,11 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
>   	}
>   
>   	op_len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> +	if (op->dummy.nbytes) {
> +		op_len = op->cmd.nbytes + op->addr.nbytes +
> +			 op->dummy.nbytes / op->dummy.buswidth;
> +		dummy_bytes = op->dummy.nbytes / op->dummy.buswidth;
> +	}

This is wrong because the core already divide the dummy.nbytes by the 
bus width:

(nor->read_dummy * op.dummy.buswidth) / 8


>   
>   	u8 op_buf[op_len];
>   
> @@ -701,8 +806,11 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
>   		pos += op->addr.nbytes;
>   	}
>   
> -	if (op->dummy.nbytes)
> -		memset(op_buf + pos, 0xff, op->dummy.nbytes);
> +	if (dummy_bytes)
> +		memset(op_buf + pos, 0xff, dummy_bytes);
> +
> +	if (slave->flags & SPI_XFER_U_PAGE)
> +		flag |= SPI_XFER_U_PAGE;
>   
>   	/* 1st transfer: opcode + address + dummy cycles */
>   	/* Make sure to set END bit if no tx or rx data messages follow */
> @@ -714,6 +822,9 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
>   	if (ret)
>   		return ret;
>   
> +	slave->dummy_bytes = 0;

What is the purpose of this variable?

> +	priv->is_strip = update_stripe(op);
> +
>   	/* 2nd transfer: rx or tx data path */
>   	if (tx_buf || rx_buf) {
>   		ret = zynq_qspi_xfer(slave->dev, op->data.nbytes * 8, tx_buf,
> @@ -722,6 +833,9 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
>   			return ret;
>   	}
>   
> +	priv->is_parallel = false;
> +	priv->is_stacked = false;
> +	slave->flags &= ~SPI_XFER_MASK;
>   	spi_release_bus(slave);
>   
>   	return 0;
> diff --git a/include/spi.h b/include/spi.h
> index c33acd9eac..0c5f4c1739 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -42,6 +42,8 @@
>   #define SPI_3BYTE_MODE 0x0
>   #define SPI_4BYTE_MODE 0x1
>   
> +#define SF_DUALIO_FLASH        0x1
> +
>   /* SPI transfer flags */
>   #define SPI_XFER_STRIPE	(1 << 6)
>   #define SPI_XFER_MASK	(3 << 8)
> @@ -172,6 +174,8 @@ struct spi_slave {
>   #define SPI_XFER_U_PAGE		BIT(4)
>   #define SPI_XFER_STACKED	BIT(5)
>   
> +	u8 dio;
> +	u8 dummy_bytes;

What is the purpose of this variables?

>   	u32 bytemode;
>   
>   	/*
