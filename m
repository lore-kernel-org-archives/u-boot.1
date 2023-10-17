Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D912CCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 06:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DED86484;
	Tue, 17 Oct 2023 08:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="bq7T53tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1329E86C47; Tue, 17 Oct 2023 08:38:01 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2787985DE0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 08:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=stefan.herbrechtsmeier-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRB3DsafIOImTj5WL051G/lh7RCk1mFc6OEgBQarN9KsW5h3t+HWHwOcKZrrks+UOnCqsIVeiol1ExKS33caCRK+r0SOFFSxc630nvq5g++JEvkVHD/VzQMDw0LBA/F2SEH+hsJMXlLXrqrXvFMBOT2ziygTaGMIY07GLuz//jXpQ9Edglv45O65bUJiylBTtiSGxufxdwwgCtL9XnCY5sF+e5FHAxRG8R5e90Tq8cTldChAprHey1fSbCQStE9mWTPctj4iRaJJDilAq0xuiePRB8mvfUm8qDCvZZ3GEFa2WHdMgwDeph972AtvG0g/3xmQoux8vuFY2UeVoKqkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKsPpc+F+lk+sMa3m/Nhznndp0JFKWvSWRzcEoMyigY=;
 b=gEzVEandVR7i6bnVGTNyokgAArVVdfsDWjgcf/4YSe+aKbiokjWC/7cK7SCjfmMdTGuLVPWkajcBcvc151fPCY6qzn8HfH0Iv0gQBTuvL4x7oqIGndSUU2wg5Ql6E6qAvPC6STaeOptZQ0JHTY1Yjiokw9ym8GB7vTI5IHTynBS0EOAFLgRANDgQYvaIbHt5pINWLXWfojenwYg1StInum+x7HpGfazqSa1Q6Milisw+aPRPl52aEey3QEsudcf3gsGpNGf5EMN2GynLsUEaBD0L0WAPhTALy4Omunqm95SyUBwwmhnt0EfJ8F0Dvl6y12XNja6IBLSGYrg79QnAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKsPpc+F+lk+sMa3m/Nhznndp0JFKWvSWRzcEoMyigY=;
 b=bq7T53txJzyqSz7+lWYU5TkKQgiYQJ5u2vhbDB47p3axMq4eMYsOg+WZ9O01LsKDKDa9s7xXemymXQnJ7WhNEJGs/oNX6pFAZ30ZYm30HoXhdeDoeL5qWoSjC2J/WanAS4DkPt3IOk16NtSQzxPGURCg5dpLscnc8lMofUg660A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 06:37:57 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::995:f33:7bda:504d]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::995:f33:7bda:504d%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 06:37:57 +0000
Message-ID: <1ff5f541-89f8-43d4-864a-bd6a626b2bfe@weidmueller.com>
Date: Tue, 17 Oct 2023 08:37:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] spi: zynq_qspi: Add parallel memories support in
 QSPI driver
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 git@xilinx.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20231017033158.27740-1-venkatesh.abbarapu@amd.com>
 <20231017033158.27740-7-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20231017033158.27740-7-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 475f6551-3903-44e7-2faa-08dbcedb9965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Emc7VQacp/6gVopAYAq4rU3Z00214KmiJIUvEb8lw1luKfUenVFKjKaHevO1Jzbv7reiFKyoaovLfFXasjayWhagG/eWlOZaBrphSMg7nb7CJ77gD5A7QVMRGfFHq1r00FVjJpDCQOKK6khYxRhIFr1Tzzsj+3fF8doQdu6FSTpVbgBK11qBHIbJmsZhZAT68mkFzdLCQCNBE45H6o9s0NVnBx2VqNrtUOVTMaDeIaJd3Go9gHWxUlUw6pL4aPcNbExqFhxIgz0pQ007juTXOhjY9NZ6UtKDCVZ+j6Q4pEVkTg8lu8xpwXBWnkbgyUlQjmNGBtx6eF9MNmNAwtFAGKmf4s6IH/P52//NhY3S15BNFF9sNEt8L7LxtpqG+jP+bW/1eZEEW6Nl5WwgO27hJgWF7EtZHdpjzB0S+pDbd5ighIrqYu4m6RTAsb8ilcO8IBBaqxS09i+6U2i0LJGqbwnTmQyL7lE4tlqEAP0f2+x5HO0LnmsUEtn8ukEDRRwi4d5xfjSR4uwt6azdtpIqnAZC+GVHyPT2rykhh/44dgEKSoUObv31S9QavzQow5tupr5IKXpLhKQa9aLy9bI+FBYEAkBPvDe98R+IMEuchvT+qFkVmLIKEcnq5PmCG9lRjLc/NawEuBIeOirvm/O16A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6969.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(316002)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(6512007)(38100700002)(2616005)(6486002)(478600001)(6506007)(83380400001)(26005)(36756003)(2906002)(5660300002)(86362001)(41300700001)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JlWXphakwzZmo4Q0hqSGFWYThZMFUzZzlHQ1hHS1Ezd0Mzc3BUbGNSWTlP?=
 =?utf-8?B?dkg2dGdDVWFidFcwZHNJY3JTZUJFMFJ6eDV6WU96ZmcvaDZzdGhwUkRNZjA3?=
 =?utf-8?B?WUEvZEtRMkJBMitreDhkYXVBRTRodVRFcTBkRFZwTEE1bGgrVEZXczdTR1Vi?=
 =?utf-8?B?T1ZHTm1OSlc3blVrVTFHZVJmKzF3UlE5WndWdVByQWFTUzAyeTBDRC9uUFMv?=
 =?utf-8?B?Rm9CRTVsUG9rZ1U1Mms4NEFMMmtsS1ZJeHVsTExBNGUxdzZKS25rZ2R2U240?=
 =?utf-8?B?Z3ZndC9TbFJRYU4xM2VHTFFFeDBvRFZOWjFDdXk1MEtTZU1JVTI2OHN0VzZV?=
 =?utf-8?B?Y2hJeHFRWk05dnB4UGhldmtDL3hoaXN2SGxwWVE0T3A1clAxcDNzS09LUTAv?=
 =?utf-8?B?T04wSGpyNUQvc1piYUdad0htaDJnK2t6ejJXVnVNTTJPY21WVElaaG5KdWJm?=
 =?utf-8?B?VSs2SGZoNTQ2WXFleGVmVE9UenN0eXRkbW1LUjc0bFdOblUya0RwV3FTbktV?=
 =?utf-8?B?VnZPbmVNRTlMaHdpbENhRFZUdGlUbEx3aER5QWhLRzhodkM2UWxUTmZ2YnN3?=
 =?utf-8?B?UnNXNjZiQkdpcGoxYkRuVzludHF0eVlZRS9iQ0hYNVRJM3FvSDhab25VSzBN?=
 =?utf-8?B?VmdOTzd2VWVOL0h2aE4yNnpNckVMelY4OStaUGVEMzU3Uzh2dVpCbkhWYTkr?=
 =?utf-8?B?RUFLQXBocXNVbkN3dWNTaDJPMExvekhLTC9ZZkt0M1NXbmpPcUxUQ2dzWEVo?=
 =?utf-8?B?OGVuSEdEamZUSUdjL3FOWEJwYXc5VE1UTlBCaEMxQ044RGU0R0p2L0dHSWFq?=
 =?utf-8?B?dmplRmhCZHJuRXlMN2dHYWw0VTlSLzJWdjRGY09jNUVUVFZEWWV1TXFLcjlt?=
 =?utf-8?B?ck9ybllnNmpRQ2NYK1M2ZlNpb2E3am9DSm9lR1lVWVBCQ3UwWXNXSzNML0hJ?=
 =?utf-8?B?WjRPenhBYkJlcDFqRGMySWRIQzhqNjdONnc1L0tIUjdIYXZRUnQ3R0FpSUZu?=
 =?utf-8?B?SjFUeG1yakI2bTNOR001TVRBbWltbDZrYUFPMzNINnFqUjhKaGN1MWlIYnlR?=
 =?utf-8?B?WDhLNGxRZEtXZElYQXpSQ1A3RTNPTG40T1M5WFc5dVorOEpiNnJJeXJ3OEho?=
 =?utf-8?B?aVBjY2RGdE0zL0NhTFNqWGxQWlRtclUzemJwRS9SRTZvQXE3bFdtWUd1RjJE?=
 =?utf-8?B?NDlheENWVzlJY1d2RVdJNm0ycEZieTBCOU9YbC9obzd1bHB1MkdaOGNJUVBG?=
 =?utf-8?B?VmgwdklCNlBZTzNuWlBad2RnTWFJUEQ2S3phTW1ZVnkrcVd0cFRnRjdmRzQ1?=
 =?utf-8?B?NGRoS1dBZUpCWlVxbkhGSWt3VGNrUWFWNHlGQXFDODB3MEF1djlOWGZTU0tG?=
 =?utf-8?B?emRja2t6Ty9hUVkxNnE1THQxZXIzNnVWWGpINTVHTjdJNWVoVnBoSmxCOXg5?=
 =?utf-8?B?MENuaXUrWDkwdzhyUGpSVUVVOUFHQS9MVk1ObnA0WnluVnZKUXJaVlQxQjNL?=
 =?utf-8?B?QS9JT3plbW04dFdVNWo1OEtTOTFsNFBRZUszWmd4WEFVVVZkMTJuUzdqNE5O?=
 =?utf-8?B?Smx0c1dDQUt3bzZxSjZIWW00aWhHRWRUWHZkRy9oL2xydmZXaXpKUTEyRjNr?=
 =?utf-8?B?bGNOeUR5V1pSZ0puWWtCT0RXdEQvNVZ5cGdIZmY5OVdwUGI1RmMvdWNGRGw4?=
 =?utf-8?B?dG1uT0FRV3AvbStGVDVTUGJKcHdqZUc4OWp4b2cyR2tCZ2gyLzQ5U25kRWpp?=
 =?utf-8?B?SGRaekZzK2dLai9VT2plMW1jclNFd1RXc29TR3Z4dHFqRURyRWVMSTgxaERl?=
 =?utf-8?B?ZHB5cUQyaU1lUTZCcU5oL1JENVJ3QkIvTVpZVTVFYmZveWc3ZmJpUi8wWEEy?=
 =?utf-8?B?Z1RWSkJETS85QjFuQlhxQzRoQS9tNlNKWVI4aHJLWmQ4QytvTFV3V1VrS0Iz?=
 =?utf-8?B?WDI4em1rS2lZSE96SXkvT1RkRmdqcjBoUmxNSldxYTZkY1dlVkVBb3ZobE95?=
 =?utf-8?B?ckdqMEtGT2c0Y3NkTGJydTBxSitvTC9KL3hSZENLM3Y1QVh4cCsvQnlTS3l3?=
 =?utf-8?B?dktycnc3blhjUkRUcCtOTDVGZzI5TE1BaE15cXdnbUpNUWVXRUhOYW5VK1Ey?=
 =?utf-8?B?OVRoMkhpT1cyaVhEZ3o3c0N1SWZUOW52RHpOMzZzYjhxSXhVUGNJTm9ZazBk?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475f6551-3903-44e7-2faa-08dbcedb9965
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 06:37:57.0862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfD/p9mXXMxehp4sV56uQSdkCneJz7pZx5hTCpokAEqB2tEeotObdavZpnsG+bhqZxiJDhurXriNiS1IWXcmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
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

Am 17.10.2023 um 05:31 schrieb Venkatesh Yadav Abbarapu:

> Add support for parallel memories in zynq_qspi.c driver. In case of
> parallel memories STRIPE bit is set and sent to the qspi ip, which will
> send data bits to both the flashes in parallel. However for few commands
> we should not use stripe, instead send same data to both the flashes.
> Those commands are exclueded by using zynqmp_qspi_update_stripe().
>
> Also update copyright info for this file.
>
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

> @@ -688,6 +788,11 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
>   	}
>   
>   	op_len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> +	if (op->dummy.nbytes) {
> +		op_len = op->cmd.nbytes + op->addr.nbytes +
> +			 op->dummy.nbytes / op->dummy.buswidth;
> +		dummy_bytes = op->dummy.nbytes / op->dummy.buswidth;
> +	}
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

This changes look unrelated and were reverted the last time because they 
were wrong.

Regards
   Stefan

