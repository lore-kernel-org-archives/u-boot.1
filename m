Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3A7CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B4BE84B1E;
	Fri,  8 May 2026 14:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dCaX8+d9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCCD84BBD; Fri,  8 May 2026 14:01:41 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A1584A75
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=equpJxmA/C5mM367KT9rrArgsxO2OjdyAs5bf40E27E/X222Vi4lacVcR8gzxa0pJf7iHwHNFS57lRfodx2Cp3CALiexHgTFlG8NcAIaF2SZnubPjUyqczYu6nXTG15XvF4jscsNISyln7rL7z6UiT/dBRcnBBF0eCiuBM8iZeLu/gbKH56x2I3AWJ39n7Pggvw2mJ29VAvgf8u4bF7VFQ8Lp1zNAyYbsSaBJYODDXHpjEBu2qDhZQSuRTomFfeFasjduJAqKs0ITin5OzCApAT2jJDue34OaTMiYsUMfYCXTLRSEzsEFv1A+JxbIjCYFQL4FYL+3YR76l4D999iwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YutQPyOCYqjjTLBHpATG4TViUn5o7vsV1GJ5M0/7Hxc=;
 b=nJwO2C80yYiOiHlNtBd9BW9R/kPoiuSyATX8yj3eEqPnNQmpjnsd5eCY8KencawEyfY5RfAhs2WsqgW02gGdE1RpvbnwU+NmSUCHdeB2OEUMqa5QvTyRWS10LH9UGZr7wVdOfaLB3mTLSZoNo561ppTU+EdO1h51k2KvIaRLUvkyk8y/4JQjG05eHl/6sbbL2xx5FvlETK8eAv8SmDNi2MJaDqThy8IUdAm5h5UkBVCMlwQsR/BKJA6kEf/5Dy4cLGwTJ49UfpgQp5xIRoqHAfPbKXJ/PyKNYHxl3Nb54hL9DdA7dQhEvP9GTx3+mcAzTGHNwmmpqpfxr2D/YpsiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YutQPyOCYqjjTLBHpATG4TViUn5o7vsV1GJ5M0/7Hxc=;
 b=dCaX8+d9Omm7OyaqB6VlcNv/SHFRCCw6MikccoXcoawy0rVgMbyBoMEmAITZT4/2n2x9FsEsyPed0jIe0v9hF8K9HCy7C8jsKGDjoSdE+wWXPOj0Ne8EbhKgAAbV5ivuO3Arpd5lN0Qg1T0dJZKxH3ksTR3Xfv7NlZbaAkEfnG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VE1PR04MB7406.eurprd04.prod.outlook.com (2603:10a6:800:1ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 12:01:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 12:01:34 +0000
Message-ID: <67e673f2-8bc6-4461-8fb0-95c59f5573ca@cherry.de>
Date: Fri, 8 May 2026 14:01:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] binman: Tidy up some missing bintool docs
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260505181300.223439-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260505181300.223439-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VE1PR04MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c4e345-2029-4b5a-d66f-08deacf98cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mGKwGtn2u+cnhXQl5WH71PGujAO3/nW5SaDtFwPaY+lDXjQD7/m3iUcuPXvo4MXu5ert52rmqVepk4TBcGObJGDy2xWjyVcK7LCULJnG5xJnrOJZK1vJTqIAXBuqjJPcZNwLIIQxGcNz0b6AqLQAkJz+5I2vWnOuxiSBk1WlhiPsY15P91dwT9Nzykzim5bVJ8xBNXGzV+ZNIZXRcQeMy7vv8onmPeMjtPur3nMdRPec9495zToZWUdIXciD5CzG2mxL0Em/fDGSsPEwwsE0ccK4ZgNDmtZRURAP7+4tRfdgwNs0iYWQoZL1o2UAJHL+Xd33LslpJ8xw/7Yhd4ln1hDcLTz7VcvkfBezrnJP7/f2eFXNh9/PkX/x2tlo3i2Tm9qT9KEdJObuFmheqM7+yaREoI7cAeZx2JUwEbvhNoItZIFKJlvl5wOIed0ITp3SYNL2EdGbtbV53s7vAAorjChEndAQ2hasNl51fny26aqrjjTyg4gSAWTsX8EJGs20iGvpPOv8T6m16CxWCfI4q+zhn8ymHkOwZxrg0rwogI9lseYN0FQ7IHemCqRCO6//4liD7SLliAdPls/WhuuNhkEcSYqjkSTCvxI3JXy5NmCN8MupXusu1zPQ5iW1KbKHNY0/VoDslL84TFk0paLTEB08nTOgYpm4y1V9nDur+V0QGr3JjEyVL4HsAXeFUEK5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(3023799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUdFZFZzYVh4QWdFRk1WNU93RklyYmdEOVE2Qjd1OEtQSGZscHlnNkxiN1F4?=
 =?utf-8?B?cVc5bjdZQ1ZwemFvR0s1OGlHSTBNSkgxWk82c1RuT1FvRS9MdElSNyt1VGNK?=
 =?utf-8?B?RVhkbVhISzdzRy9XZW93TEVWMnpPdDhMb1A5RkQrN3RuMExwcnJzUnZuSGNX?=
 =?utf-8?B?VFJkT0hOd2hLOUYzSDFVeGhDSERUOUJuU3BWbDVIRmpOZzIvRHZ0eW5WejdM?=
 =?utf-8?B?MG5vb2ZtWGJKaDZOci9OeFcycjBveTMwa0t1dFBna05TbnJ2RnpsN2EyS1Zk?=
 =?utf-8?B?WC8vWkpVN2hXd1BSYU9nVEN3UG9sUzBmSWFTbDJkUHVBeGZQWERuSXJzMkNU?=
 =?utf-8?B?bjRYV280aEx4ZlkreHpNRFBSY0lxSHdNRFdwQXFsaWZRaDhPekk0L1AwKzFp?=
 =?utf-8?B?SzJ3eC9HZkQrekVndVF2eU12TjZwSElVd1dvdDZ5RWxsc0VnalE0VEs5WUlJ?=
 =?utf-8?B?VjM4OThOcFhxdlNsWGdRWWNGTnpIOUE4YmNBQkJxcWxpZGVzYndabHVkWFU2?=
 =?utf-8?B?dWpVVURXSkdnNGpWN3M3NDgrMVdZTXcvYU1oalBXejVEUW54eXRMMllhemFF?=
 =?utf-8?B?RFZJTDhxRll6c1E5ZUE4N2VjZzdYOUV2WlV2dEhBNkM5MWRNY2NzOGpJVC9Y?=
 =?utf-8?B?QlZYZ281T1ZHZGNMa2FGV1paWnAxeWdDOG02SnduaWNodkFyemlrL25aRW5a?=
 =?utf-8?B?eVFqTXZrRzRqZVVFTzQ1aFFOdkFhOFNMaXBJNUR0R1k5NEg3N3lWTEtqTXZu?=
 =?utf-8?B?eUVDb3JTZHdlbnVtRlhvUkNwQloxT2t4N3Z3TW9rUmNIcWNPOEJWQmZCcEl4?=
 =?utf-8?B?c2ZLWEdCR1JFMnlwTTlSSUNmZGRlSi9oRnI4MTI0eW5TSDgvcGsyaUU0dUFi?=
 =?utf-8?B?VzhUVWN2ckVIZ21zU09BZW9ycVhlQ2MybHlmUGVJUE1QcFFLVnI3Wm1qOVZi?=
 =?utf-8?B?K3VNUmp3bUIrekVIMU1PT1Q0cXY0elIrOU9zZjM2TFB3bXkxNmtPMzBPcjR1?=
 =?utf-8?B?TEVyKzNHWUd3eUlMemlrSGV2REtpLzNJeFVXMTQ0QXpYRmpBRlB0ektoTnBO?=
 =?utf-8?B?WGxwc1hUNWxaWGFvR1pvU0ZieXcvN0NSU1FXM1RZUERmWWVpWTFBcjJLTFhy?=
 =?utf-8?B?bEgzRmdoSFl4NUVhMkxmRXVJN2IzaVVKNWFpMWI2U3pGcTNDL1BGWHpBRWhy?=
 =?utf-8?B?RDllYUJKRUdtU0FpS3Z3K1FHVGdQMzJ6Sm9oVmtTeGYyNkt4c3EyZVoyVGRh?=
 =?utf-8?B?YkEwU05WeGh6YlBLYVpjK3cydHN0a1VUYXJWb3h0c09TQzZRZ2JjMzVOOXNU?=
 =?utf-8?B?UTJ4RGtBa3A5ZzBBT0J3bUc4bm9SVDg1TzZpZTVxdjhHNy9NekpsZ3ZadEw1?=
 =?utf-8?B?R3FTYm5pQ2Y4MHpZU2hnNWJFQlIrQ3IrVFJDbnZ2eExoOXBOOXVuNlJuRDUy?=
 =?utf-8?B?ak1sU2QzbUMyQi9YeEVuaUd6YVQvTFo0UWZ1QVZOS3ppOThEV2x5eVB1cjcw?=
 =?utf-8?B?eG43RUN2S0NXMmpZME9rRmlOVGhSZDdWV0NyYkdPZlRRMU82UWdPeHMydFZq?=
 =?utf-8?B?WVFEYXgzcnovWUtVUEZtalN5MUU4Y1AwSlhnU2M4bHJvcXFkdkZSOXo4YXdy?=
 =?utf-8?B?UHB4MHUrMFRhMkphYiswbjJ2ck5IUWJiYUNZRis2VFZreXQ2Wk5OMUwweVc2?=
 =?utf-8?B?dTF2VExIMFZzUWpKV2d0TmNkaDlRU3lQUzNuRDFGTWJZUHg1N1JENjh0V3pR?=
 =?utf-8?B?ZUpvSGxlVEFZY3E1RkJnTHhlYVpyQjVxMjN3OGhpVlJxS1hmMllPdHVsM0xY?=
 =?utf-8?B?QXZLd1I5c2dkaENMMk5vODdqMGVFdFFtaFE3Yno1VTZBeE5Rc01zTTFrUGFs?=
 =?utf-8?B?bm9MRHpzTE43b1BFUGwwam4yb3NXcHRNTFRBUDJpellacWs0Smhjdkg5dGJY?=
 =?utf-8?B?cG5lSkZOMENzK0NGZUJjT0NMYzZSZlFqWTdTdzRmYkxsOGJValhIVm5qdkxx?=
 =?utf-8?B?WlZzNlVCSlhkb3ZFMzBLZ0FLY1R6NjYrb2dnZVFObTFHU2dEa3FOaHVFMW9I?=
 =?utf-8?B?TTNnVG0yaFpoYmZCS2JCSTI5OE9DMUNYK2ZZbGRwd283ZGhST1RHWjR0QnNU?=
 =?utf-8?B?TXVuaURjTzhPbnoraVl5ZFYxRWt0anZnQlJwYjBhK1Q3SmxTb0Q5SmdHQlJq?=
 =?utf-8?B?WjRIdlZ1UDEreUlGUjNQYy9TbW9zaTI0aHp5YjdVKzUrTU9lSG1IeGY1eU4y?=
 =?utf-8?B?dlVtU0dZSnJ2UnlFVnZpTkl0RHNBbHV1VkdXbFZSaGxhaEVrYUN0ajE3Z3Iv?=
 =?utf-8?B?MzB0MUZWZkZsbitvOXRqK2o1aEZrbWYxSzVSbU54WlZMNG5qMjZmZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c4e345-2029-4b5a-d66f-08deacf98cce
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 12:01:34.4540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZGV44sRTb3C9GZN5FyUJ1WnPDQwHieiSg5wfR5/5nYoYgJnyVgHJ6MGZNxLfJLSaDO66dL7GPTfoWim6/EwCoTHFharw5ZlTcxCkHj6NC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7406
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

On 5/5/26 8:12 PM, Simon Glass wrote:
> Some of the bintools are missing documentation. This series adds the
> missing pieces to bring things up to scratch.
> 
> Changes in v2:
> - Add patch to route PKCS#11 test fixtures through the bintools
> - New patch in v2 (per Quentin's review): replace tools.run() of
>    softhsm2-util, pkcs11-tool and p11-kit in ftest.py with the
>    Bintool.run_cmd() wrapper that already exists
> - Reword the docstring per Quentin's review: binman uses this bintool
>    only as an availability check, not for runtime PKCS#11 operations
> 
> Simon Glass (4):
>    binman: Flesh out the p11-kit bintool docstring
>    binman: Flesh out the pkcs11-tool bintool docstring
>    binman: Flesh out the softhsm2-util bintool docstring
>    binman: Use bintool wrappers for PKCS#11 tools in tests
> 
>   tools/binman/btool/p11_kit.py       | 11 ++++++-
>   tools/binman/btool/pkcs11_tool.py   | 11 ++++++-
>   tools/binman/btool/softhsm2_util.py | 12 +++++++-
>   tools/binman/ftest.py               | 46 ++++++++++++++---------------
>   4 files changed, 54 insertions(+), 26 deletions(-)
> 

Technically the docstring in patch 1 to 3 is incorrect now that we have 
patch 4 and we use the bintool to call commands on the wrapped binaries.

It's a detail and I don't have anything else to suggest for rephrasing.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
