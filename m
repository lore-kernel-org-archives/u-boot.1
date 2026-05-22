Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B056CD5BAC
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 09:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC67E843B6;
	Fri, 22 May 2026 11:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="am5DeBHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0838460E; Fri, 22 May 2026 11:37:19 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E332841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxXgV561xLDyAw+DWF9mD10T+UitDQivGw1QOvae7xTC4MvGEzrdx2doGQlZjIawT6eTvApQcEVC0f7PZCXt4GJciM23+7GJvIAsWroyljkwXMaR9MhJ2fJqHp73SVsZXRWPruLw6Lyq/4B2raWWEHAxAI7uWwA17FuNXQmd25mNmOCXVIbh6qDLRRxIVKlFyLzOl8hpZuvutcZi+pEO2M85Q1pFVJGu1WcZKEmbCrF4VICvkOJB3uLa3/ysZdsHI3uD1kgL/D0GswYg2/X2gQmuOkfUQoiBhLMKZpa4QgQZTsbhyE9EU+GKJI6tcxcpETSyf26+wGNLR27S5mFKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMI1TSkIcwhy4sdMS5+dH+O9OGTFz+B0qMQl4LTgFSM=;
 b=PM7LI1mA/UkDL30rdXREx2jhwhOxxDA2c5anigkOzwd1b4MHIeB5neY0BqH4NH9+qaojpAPyseY3FuHFj8FtZfXlmUEvTkYihF7H0Grt5hVmdFsQ/0Y0Xan9ni65/SOlA5mTGX3Sw1JIV31C5u8SlHNI74Qe5onuOb1g7pVMMu8INmH5ce04DOzrXrhpmL4Gcq3XMwSLxXrPAqJdr5CRICaQ593QdvC7w2zKWSRi+EADGiKElDjD/izZwiQmFKtfFHTdtVegIBQV/JsJkODk9+3ITo43pBl53Z9zdGPMsHYAzDbkHsZFOGIosQt6ujepSlSRzSmVmAnTgP6II/4O/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMI1TSkIcwhy4sdMS5+dH+O9OGTFz+B0qMQl4LTgFSM=;
 b=am5DeBHzZVPu9r7VBbg+LAZ+1Bomxx5eOz19fyFas9efhk/kd01iDBvD/F9rZe7s5SNUKKWBHPdmKWp9Hh2GrzaeuT2imfPkVDUo5RPRCm0Tneylz3ZApO3dAouSRxCOhMlqey37HGEywfwW1jzqgGWVCFfVoD7+OvSsN+kjZf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:37:15 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:37:15 +0000
Message-ID: <c1fa8d82-8ca7-41bb-b90c-8bed4cebb967@cherry.de>
Date: Fri, 22 May 2026 11:37:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace Apple with N:
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Janne Grunau <j@jannau.net>, Mark Kettenis <kettenis@openbsd.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260521201712.43955-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260521201712.43955-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e4bc3c-98bb-40b1-919e-08deb7e5b558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7RI9z1+zrEQL/dxdCEm6VZbeUtlnp7kC5gqErlwyFrHxam34Ul6RZo4A/WYSDiuSFCIZq/h8BIOmIR7ZbDtsmEpvdP8kD/rEoQUAAOZxi4pXCxa/t27K7kjwLqWy324HOps7BfGLtLXWU5A3GbffPXZVI0oQz0CYIqdph5tyh9+dHmokJ0NS+g7TaGcbCq6f1nH3tF5BuaKapeXYSBSG6zSwxeL6hFZMW0AMmQVg1l9R60O4kkpgUdaCsWmZo3a7Ubhofcqi5wCRZyFXurPtWZ1CYpoQLgaWQp+CVL6qYs8C8k5+Png/LBE5hxdu+tzCu1e6L4kPeK9P+Yy/Z4GLKjj8hlJ9ZQtROWkFrRqeCV/6N1gw6XMSf8yRaYmeZUuxXy6N7ktSdgNJW3Pz31II+KTc8LSiazGnrp9cG3prUWg21HwgJGzXHaNG8uGMr+XQZEN/V69VUyFyBkNCaU4CWgQ92vVN1dLSik8LtGG7kncCJfr6KEiF9nNwvaGbh2+cqYDm8ZtricuwVyhFrONO5UyfnuY9p3IicAu+Rp28LMChhrSdHjaLJk9b6K8KvSDLPJnlAOFU78TBc+roqjfqKEH/4Vm6Dq2lH2hWf9snWug4ayska/MjMhpgjuTngLwJw1O2HvxHh6HSDgSkc232R+wVaOSkW/8ZjLv4QtCvGkjauP41xiffRg95HW7x7vi/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdPRVRGb3BkcDJ3QTAvaHVTWmpnY0NvWlRkZ21wZytYMDVrQTZ1dzFPY0oz?=
 =?utf-8?B?NTNiLzFpUGJpRnoyaGFEMERmeWdhd2pVQlZTWkhZS09OSVFqOG1XYllQalVi?=
 =?utf-8?B?dHFkV0wrME84Q3dORzNBU0N6YVI0L25FR0RTZTJiZ1h6VEtSVWNsY0VjcUhP?=
 =?utf-8?B?Tjh5cHgrS055RW1GTkxaMXVSRjE0THhnWG9vdXZSTTduclduZEFQZnlPdEFq?=
 =?utf-8?B?bnp0WTJmRDJYNnpwVitBeTFOUUhZVEtxdGRYcFF5NzVRbldaRGZUSTdCY0J0?=
 =?utf-8?B?SVlzRVNlS0JyTjJWdGI2NGt5Ujk2SXplYkNpSzNncG1mQk5mWmliQ1ZzSlM5?=
 =?utf-8?B?Vm4wMDd4ZERUY3NGM2U1Rk1mcGRlNW80YlFvUlNGWUcxZHZidml3dEFoSjBF?=
 =?utf-8?B?YWpXOVQ5V1RaSWpTTGtnaGJkR2JodlJGdlNNQm9mY3YzQTVBNmVuVXRORElD?=
 =?utf-8?B?NEFzRS9hZG9pdkZkTkoxZVgvUituUzVIaXgwZnI2KzdCckVRUmg4WEhvbDNO?=
 =?utf-8?B?WGdJR0dNVmw4ZFYvZ3BKcTVhVTNVL2lma0JrSXoxUWZMMU9Rdmp3SnJhS0FW?=
 =?utf-8?B?TXpvcnZvdUJBWGkxSlBRNmRQcU9ncjkwV0VjTkhURFB2S3REVkdURFJka0xx?=
 =?utf-8?B?cGk5RmljbEQzSU5xSmY5ZWxiTlVacmIyVUhqRlRkNWwvQUYvQUhwRGlHTUtp?=
 =?utf-8?B?NVJFZGNJd0VIQnJ5MkVZQTJ0ekxlcDF1THJJQWlIZHdIUzRpWTJlSE9aRVI4?=
 =?utf-8?B?MDV1SFFocFcyWWgyV2RRZDV2Yi92K1J6S01NbDhFSzdPbmhtbklPUlFyODBZ?=
 =?utf-8?B?bCtMbmFuQVMzQnl1a1VCcHRXbW1tMWZ5NU5FSC9XSG5qb3R1WEN4WnIzRDhJ?=
 =?utf-8?B?YWRLTy9XaTVTMlZraHlvbGdhZVVaNUF6YTlXMERrWGs0N25SVExhTUpDMTYy?=
 =?utf-8?B?V1lUUEVDT1dlc28zd2Q5aHU2YURIS0RkM1RNSk55Zno3NDZmUG01YzdXdDhU?=
 =?utf-8?B?VmVHMUFNR2h1S1FwM0gzNFdXNENhWTdVQW14MG9GR3hTMDE2SVY1K2JWU2JK?=
 =?utf-8?B?V3JiQzNiYnAxQjNVc1dOc1l6WGtzRVFCQU54RTZaNG90TktFNzRnK2k0Mzhh?=
 =?utf-8?B?V2cvYWc2cTVFQ09IejVvMlVrOTYvYUx4UmlNTEM2c2k0NHFMOUY4UVNTbDFW?=
 =?utf-8?B?UE5TcnZvbFdJMXRkcncwdFU3SVRKS1BBQXcxaGhxN2F0NlZBM1IvT1J6d1ln?=
 =?utf-8?B?R3dUVmhFSFZDQTVwalVmSXhuSFlKa2YzdHI3MXZpS1lFVDY5UERlMkoyNWlx?=
 =?utf-8?B?Q0hkcDFmQXJmL0dWT2d4NzcxUmhKL2R4WVBiL2xadnhiTUVocERueW03VFpk?=
 =?utf-8?B?OW1hNjNTRlorOWErUHhVZnp3QitVUTNlN1U4OFcwdjdnanNWWjBwZys0dlJ0?=
 =?utf-8?B?aGhFVENXK3ZtazhFb0JGZlVrQWtNeElmaCtKbzVLbkZ1WFd0c2FLa2lIaEUw?=
 =?utf-8?B?RWRJeVZSU2pLRzBUc1ByRjBEbFZnNVNiUStZYkZmdEhCZWJRK0xlQmNjTFA0?=
 =?utf-8?B?MkJBaEE2UkxvdjB4ejRnMTdjeCtRa1QvSFRqamYyZ2pmcU8xczFwMFRiYkN5?=
 =?utf-8?B?L3dHVHp2ZWVFU0ExRjdCeVByRXJEdDF1WEYzUEVyQ2xtVW9ZNm1weDVtaFZi?=
 =?utf-8?B?SURyNytneS9JaGJJdnNkaGtXQUc2ZUpURTZjZVZvYWVuSFRnRlNuNWVIdmdt?=
 =?utf-8?B?MGdoMHBPR29NSFdpRGI5aURwa0pjODlWdXllWVI3QjF4a1lkdzZ6Qk45WWN2?=
 =?utf-8?B?SnFpdnk4RWRTekhITXUzMWFESHJhTlc5cml2c09MMGF1elFxZWd1cklCK1gv?=
 =?utf-8?B?UFBTK1A3MFpRdDloZElLTDJicmN2QUhjNXdEdTcxNVkzNVNyQVJnTUFRMUxv?=
 =?utf-8?B?aXZYenVtYSszV3VQS2tzUnJzMTNmbG00Zm0xZU5tckdETTZnWFhVRFB5bGRz?=
 =?utf-8?B?OWR5WTdmVGJzeVpnc3piK2RrUUZ0NkcvTCt2UDRBa3AxNEo2dlNjQlg4WUQ0?=
 =?utf-8?B?YjhJd1g2MTN1bE9pYzVKWmx4V1d3eXRLcERMWjBmdG1GTzNwdktNOUlOTHhP?=
 =?utf-8?B?bEhzbStTUjg5ZmZQZUxQdmJvcXRsRkNJMUlLTWVia0dhY1BKM0praExLZ0Nv?=
 =?utf-8?B?VmY0THNFOERtUklWNjkyQW1XMW9UOUdLK21aT1lXeEFlR1ZoTmJnQS9qcGg5?=
 =?utf-8?B?aHlRYkNjd3hKVFJ2T3NoN0FEMkxXSEJMbk1HdEFWYzV4UjNZQm42Y25PTzYz?=
 =?utf-8?B?ZjJpY2tNRU9tbFhKS1BWRW1iYlU0QjhlVjUxU09DclVPTDVuTDFKQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e4bc3c-98bb-40b1-919e-08deb7e5b558
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:37:15.2971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh0W26zfAxS/SzWVPJii+VC/DjD5gi3BuXt9KZIFEBmE3qaNLbdmftwP+1ftk/ay0EglYRqI95bhMuDKuHhvjfI41ZW7Q9nYtyHXElo/0ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921
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

Hi Marek,

On 5/21/26 10:16 PM, Marek Vasut wrote:
> Use N: to match on all apple files, drop the large list of
> entries which represent the same set of relevant files and
> miss a few in the process.
> 

Note:

"""
         N: Files and directories with regex patterns.
[...]
            scripts/get_maintainer.pl has different behavior for files that
            match F: pattern and matches of N: patterns.  By default,
            get_maintainer will not look at git log history when an F: 
pattern
            match occurs.  When an N: match occurs, git log history is used
            to also notify the people that have git commit signatures.
"""

So more people may be added in Cc by get_maintainer.pl? I'm not sure 
it's a bad thing, but it may surprise people. I don't know pearl so 
cannot really say if what we use in e.g. .b4-config to generate the 
Cc/To recipients uses that default or not.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
