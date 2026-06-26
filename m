Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C47C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 18:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A11E8404D;
	Fri, 26 Jun 2026 20:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WhBRcdP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB1E18460E; Fri, 26 Jun 2026 20:28:40 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3DE83FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 20:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVtVmt2uwXhqCUaiz0ZfEUJciuvA5kslNpFwHbE3yQnyfUM4bHZpGQI2fe6ix2H+cMJUHzTTtFr7M/ewTWzKs8xsMILNT8uFrwX4BeS0J36moGfz4LUslSLjC+wMR+yUfO/wwItg5Qov28k5cS2kL1AKKjJIU3z9488ktUBmoiOYqNWyxlCyjUa9RtlaB0sYILjN158J3yeblyDd6JX84a1l1Y7MyVjUWNuskd05wrGhwsb7EVehSCuNAoFyDmB2XNO8B5KELvbtQ+oNUOR15lCS9RgpqG+E8KlkwzbvXm4B6zCFUfhJq3ItyxXdtB7uLvfRM7AfhlJrub4pwE+HiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUpsCyIkI1324Kz3WazDjtGJl1yr4nJjkwlHJI/kjQU=;
 b=QIY8CdSXO7k37sQG+ake3XWzZE3jjlQCHiDCsPo/qYQqEeb3aj3E95HUWAjUkcq0rAjEXjRGNx3kwU9QYN6Cj+YXsx70lIcpG/q0mGpc0iyx9LFzVO+Nk81kUTDnNKfr/2uO2hgOWghLwARg2o+Niku/aBbJ6qIPiWPbO1aU0Z9IGgQEZAx7VPCVZbu4uOyn0ZzdPC61eXSxtFhKbfx7CGq/vpG+ja1g5yjX34EXNX8KvQlEUhVzc5SD7ec5OaG5Cuc1XnG0taxv6zSu9XpIHTvhL0zxlqwGls6YIO5weOR2HwZLyUPlDSL6iZP0/UI+Vj0chcbJsFP4aL81mU6tfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUpsCyIkI1324Kz3WazDjtGJl1yr4nJjkwlHJI/kjQU=;
 b=WhBRcdP7pbxI0UQntiQWQkEErbPucopupM7hwQBD/7DO4zLlHyB8MhWq/1XKF9Dhg0atwHiYf1lCc2UqRvsDZEQLomEfloSRqgsfwB0SqR7sSAVI+B9sg0HAsqSIKVTVfNLBNP9vBRgACmggitjOgd3Eq8b/ccTM7TE1QMIV3uA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 18:28:35 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 18:28:35 +0000
Message-ID: <6359ffb0-804d-4241-ba70-941ed36a4f20@cherry.de>
Date: Fri, 26 Jun 2026 20:28:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
References: <20260622224344.GF382693@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260622224344.GF382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0144.eurprd07.prod.outlook.com
 (2603:10a6:802:16::31) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d998f3-d4ce-41bd-0691-08ded3b0bc0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dGexGqwwirw5pi55fQlZH+7VmefO2oyqekHBd01hpRDlExyyCg8XbrYWmyZU9sR7ffGFt7RJy1mjuYHO36ArI+vI7JroHm9mewrMAb3t1N6ebuWFEDzHo4C0od5CEI/nOhTs7KgxECt+640jBBioNFB8J0l9jGc3YrrU/E+JTkbED7YD2oGS875cRjL7Vb8spx5XEmf5Yp6ofIFfXlYFt6oNGD19WueyGELNGOot9aHEwZ/RElgBySWzh1xD2gDnBUZDHJU+kzPj8cLMlNt6wlXwiG0xBcqZZgWXjShbpCBoKNeKmpRC0N+jx1LOZ+uFu98zz1YEn4Zxt+744CNbnVOkM4gXjQIYIB0lohOUXNQ0lolWpyHel1XAOd3Uvjx+I8eTC+XMtX9Yt+1H5nsC39qzQOlErYWyPJ0bLTpIaBLslRqSpA95lUwS2MHB6oQ0MdGFFebzXePWFxJ42hotIMes0D2w0sFfcWSCGaSq/8VswnsMAcgCHr6o/tefZMzuCbFMjDujsPB9LKZ4/B028MP7I1SjFF4EhMmc0g2/GTaL++i+Obgl5rMiM6qRhS4mRuYh1ZR0AICOBl70DG8508vemZLRWetPhlRceL2lvV72/OhtQ6y2H2oY6MFWzLPquhIFkDzCrMFpy+d64F2zjgWXTjWoNK8Momzo7m0O4HI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzRQaUlYRFY0TnczY0cyZ1hwUmF3MTNOLzFzU09GTDRLZjJmazhqRTBESy9p?=
 =?utf-8?B?ZHBydnRmaTdENjlXUjV2QUFISGRoR2hVMEFpakRaYmdTUEZrMWo2Z25VcHdm?=
 =?utf-8?B?SDMrYnAxWStyZ2d2YXorSDVPN2J6N1VVb01ieG5oNzBVeW9aaDZ1eDFHdFNl?=
 =?utf-8?B?Sitad1ozN05WeXZ0UGU3OWU5U1NrQWlBSE1Rbmp0dndiMW5NVDV4Tm1kNldR?=
 =?utf-8?B?TzYvbTNieWpJMXB2MmdhbUZaaDUvSUZSQUR6YmtiUjBvekx5TjIvTllOdEF1?=
 =?utf-8?B?ODA2N1dvT1ZIaXkrMi8rM2xkdm9kUTFLR0JDaGNuTVZDY2F2MmdrS0ZjVFUz?=
 =?utf-8?B?ZGJ3Yk4yVGlGVFZWWTRadzhhblRzMUZFMUpjOUYwV0w2T3VOc3pvQWJVTVY3?=
 =?utf-8?B?RFAveXlGRW5WYkhTUEpuNyt1ZXdKSzBHUVRtenEyL1J3MkVyZ1NhSkxSZVZy?=
 =?utf-8?B?aHgyT0E1QTh0WUU3b0VaeE5uOWNBYzVueTJkbzUzdk10MldtNE4rNHFITTBs?=
 =?utf-8?B?aGlZT3NyQkZUZ2RPTWpteVdyRUxYVlNwYzY5TnpFQlpGRmZhZmZMWjNoL3dZ?=
 =?utf-8?B?bTh2SDI4QmpFOGdhVDdBQXU0NlhPM09sb2RJcmZvVk1rbWJFNG5qZ3poaFJr?=
 =?utf-8?B?bXdsOTd2dEVJemszY0h0MjZIblMwcDZsdWNyUUx2VW03RkZpdnRsYmEzeVlQ?=
 =?utf-8?B?OVhXdjdRbFp6cjBuS0xUeG5JQkU4bkZKSWRwTGRHRitQTThCeVpSeCtZRkFw?=
 =?utf-8?B?Z01QMzdmMUxEUkJYbC9MdU56R29hYjlDV0R5RnRCSitoMzlRNU95K2FiS2lP?=
 =?utf-8?B?OWFMcWxTMFQ3S1pGblZLZm12NWpVZmRjTXNQRzhPL2JhUXMyYzdJNlpmWURC?=
 =?utf-8?B?UGRhenU3TlFwUTFGdGpyR2VpUEZKT3ROV2VHL1NoOTdnSmx6NmU3eTdRWHBV?=
 =?utf-8?B?MjNWQm1JdnpuN3hTNmoyRjV5TzFHSVpiemI1bEZsY2tlMHAwdGU2dkFadDR0?=
 =?utf-8?B?a2pXUFBqemw3SjhmWDFqNmQ4UmN0S1p1c1psaG5LOElMZDkzZjNvVE04VHB4?=
 =?utf-8?B?dzZoeDVWSmN1YTRyOHgzOVMvVWhnbVphMHZQQXdWMVNqdUtGY3FrN0gzMGZN?=
 =?utf-8?B?TEZCS2libDJsN2lQN2NRai9XbnZYZTc4aTY4SGZZY2NMcUlLaXlyeUlWeFFI?=
 =?utf-8?B?NlF2TGs5RkVVKzh6ZFJtdTQxVFFTOWhBaFNZSHd6N3hzYy9Qa1JtSUFqaWtO?=
 =?utf-8?B?Q2RQRU9iM3FIbExrS1N2NzB3c0gwWldMREJmN2xHcHJnM2JmL2tNcHFHMm0x?=
 =?utf-8?B?NlEwNkpCL21zS1JaNzZkV1FnNzhWbXNOckJGbXVnakl6bnBTRnNENXphdWla?=
 =?utf-8?B?YXU4cmsvd3B5aTZXelBZSllMOEQ3NHRjMjRwVThkUjhVRkxjcUFFRHNjb1Ev?=
 =?utf-8?B?SXVDQzJXSlBYRWVQOVgycUNLdHV6eHY3blNNZis0UHVEYnFUeXRkUTVKdVli?=
 =?utf-8?B?WnMzbHpCT3BGM1dlNVlxOGgvWUNTUUlGZFRCbm5zT090Q0dmN09NYVpaZmEv?=
 =?utf-8?B?SlY5M1lHWXZSNUhodVZNV3NiY1k5ZHFOK1YveDRLdUYyNjRIOHI5WmRlT1lq?=
 =?utf-8?B?QTZVOUlTTUZRNFFWcjRwM1ZvVVhwZmJLSWhHUFVVMEZYZUpLZzJKZjVmbjZS?=
 =?utf-8?B?cFk0czdkazFnRXgweXNvd3pDUjdTVmUwNEdSemprVHZzY0lIR21vdzF0YXZY?=
 =?utf-8?B?VUszRFloRG14WTVhMDV1cVp4cmJWYmxWRmVMbExodnBpNUU2empnL2o3Szdl?=
 =?utf-8?B?OE82VEhpSDArcGFhZ0tRZDd6OStta3Q1U1BGNUJEdzVtVk1GYTluM2RjeUh3?=
 =?utf-8?B?U0g3SFZaTk9tWEMvK1lvVzVWNEt0NjFQTmRhZ0cyb05IUlljZ2dHY041ZG5F?=
 =?utf-8?B?NGhUV2s1OVZvRm5LVEVSOXZEbnBSU0lJMmJodFRyK1hveUduUVNEeHl6UEFm?=
 =?utf-8?B?bTFBMGUzZmJFZXdpcEV3M2ZaTjFOVWx2YklVUkFmM0hBVGJVZHpuVER1UDk0?=
 =?utf-8?B?TjNmeHgzL1RpU2hibThSeWpJMEMzcFZ3ak1IVHdmWG9lRjBUR2ZaQlFDMWxR?=
 =?utf-8?B?Y2tNdE90T1FWY3hFeTkyU25wVFMyM2I3SzM2K3hmS296YjZDa21pTGgxTk5u?=
 =?utf-8?B?UzZaQnlxZmFRN2JNeDVzN3Z2bnR5bThQemVVZ1pkNG1hL2ZCNm9RNHB5OGZp?=
 =?utf-8?B?WGlNUnZtTlM1bGVJTG11OHl1VjJWemJFNXJIZW44ZzkwTnVUbjd3MGhQeFRE?=
 =?utf-8?B?MFlVZlJmZFM5YUhZSHJjaE1jZnAyMFNUZE9sd3NWRXNEOWd6UWFMZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d998f3-d4ce-41bd-0691-08ded3b0bc0c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 18:28:35.7025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fbURsPbWjArJuSNBpFdJzuewyj4E1871xF8kp9QBTzA5ury69e/me6Ble4Tn3BFQKPfQNY7hAIBQCaX2WmkagUko7Y+OBPtfHas9XI3OLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144
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

Hi Tom,

On 6/23/26 12:43 AM, Tom Rini wrote:
> Hey all,
> 
> Coverity is back up finally and so here's the result of changes for the
> last three RCs.
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Jun 22, 2026 at 4:40 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
> 
>     - *New Defects Found:* 1
>     - 4 defect(s), reported by Coverity Scan earlier, were marked fixed in
>     the recent build analyzed by Coverity Scan.
>     - *Defects Shown:* Showing 1 of 1 defect(s)
> 
> Defect Details
> 
> ** CID 646439:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/cmd/part.c: 53           in setup_gpt_partitions()
> 
> 
> _____________________________________________________________________________________________
> *** CID 646439:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/cmd/part.c: 53             in setup_gpt_partitions()
> 47     	snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
> 48
> 49     	ret = blk_get_device_by_str("mmc", dev_str, &mmc_dev_desc);
> 50     	if (ret == -ENODEV)
> 51     		return -EAGAIN;
> 52
>>>>      CID 646439:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -22, overflows the type of "_val2", which is type "unsigned int".
> 53     	ut_asserteq(mmc_dev_num, ret);
> 54

Does Coverity complain if we do:

ut_assert(ret >= 0);
ut_asserteq(mmc_dev_num, ret);

?

We also use the same ut_asserteq() check in many oher places with the 
return value of blk_get_device_by_str() so I'm surprised it doesn't 
complain about those and why.

Cheers,
Quentin
