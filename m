Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DF8C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 407E781E8C;
	Wed, 19 Mar 2025 16:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GO9Nc2sT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA3DA81ECD; Wed, 19 Mar 2025 16:31:26 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CA68141E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8qNasqgfOUOKAG2I+0H2bnRuAjpbCd78Jz3zhFu/FxgaBPgcxqx7AEFDVPGGuJp4grFaHNde5WPPw68e1HI6BLHkNwGZVPlsVvviWnaPdwBM6IHdi0AzIoc4NB6Nfqa/QdiywGUNSHDsNjDPSSt+4+5ELym65vaaNu6feagVla+U8H5DfdvdOuaFxEF9Fujs3QeFLPywsX9ENMGzrHKCJw5fM4AwWhRYOxv70IHiXhhszf/6k1aKc5U80ZUudPCD/GmAfUHT3BU6BcENj1OIXF2RkeWjGDXsFFG7k+Oe7LeOFjn3LrMNMazGISeYzJojM/kleFWx2RrrSB6DNj8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf/eHlWccaEnLSkprFTiKQAiIijEkAxK/Px5J3Gn2cQ=;
 b=cotTFDQnuxhiYuEEX8r8qWGWVAPXCuKQIjYuA7SC0w5rZbd5UGkDY1TnL764O6ZODd1kdCcJKCp+GxW4VYs2H1M890BBCoM3duH5vGLnshvf4e3aBHMe+6nRDfqrcoLyxBF34xTtpSku8g1rqqyFp/S0sxTrZ+S+gkibuZudVcIOQ+KrwI0cF8NjiHMzbdsCva7AEN4aCwoSyXkZMttpm99CA3UyVj5jo5PdTUpxM42tTentnG7VDkxcSRw/D6huo2vUKJtUeOw9HXiahSEzpNCF55Ib8W9MV0gtViusEyPvzcAaeuxNnHLi/Phy+uCHTkTDbpyNAN8Jon2rZCtxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf/eHlWccaEnLSkprFTiKQAiIijEkAxK/Px5J3Gn2cQ=;
 b=GO9Nc2sTzGwzj1aJ3nFmO1kdN0yCtM8rPjiPmxfpw+OK9UpHbJdh3bXaBAGj3oD6WtTsshW0V3v0VUYWwE6xWbR1cqKKJ6dH3NjE5S4EgI44fhrfbaGCP6PCti/Wb96eqoAW/qkvxDOxF3gArE+88misPYtfTAoC6JpmeweEC54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8730.eurprd04.prod.outlook.com (2603:10a6:20b:43d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 15:31:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 15:31:22 +0000
Message-ID: <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
Date: Wed, 19 Mar 2025 16:31:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4265c5-2a45-45e1-adf5-08dd66fb1ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnpDUVlqL2xLcmdDbWtnL3JQbzBzMkI4M29GTXdJR3diVVBHeGhaTzVQbk5h?=
 =?utf-8?B?S0pQdjU4RXFnb1dGcld4Nk0raFJmaFhHVGxHYUZvek1RUy83dVJuYm01ZUZY?=
 =?utf-8?B?Z2dlNkdTd2piWVoxSEpyeWhiUUgySzJLSXZsTEdEUnprdjdVUHhCclRkTU1l?=
 =?utf-8?B?azlVRFRONXNNTFlPWDlSck9GdDZPazZMNG9xcmZTbktVTWpITFhURUhjNjdT?=
 =?utf-8?B?WWNGSWZtQ0JtNGNaRHg4ajJLVks5RnNlYTNxd3JUMFkzOGh0QXVSQ3p0R0Uw?=
 =?utf-8?B?cDZQY1A0RWJmbUdhQVhoRmErUENpL2F1Wi9QZG5QUnd4RWxRMWNxamlIK0VE?=
 =?utf-8?B?S1p2ZjJtd1hVYXkrMWFmSjB3L3RQM0pnWnQrVU1kckpvdGlrTVpoYjRjZlBp?=
 =?utf-8?B?b3Rrb3hpWktxejBXNG1DQ0VIUGhrMldYeHFmbDBVa1hLNE9MWkJscHhwVHZI?=
 =?utf-8?B?VStOLzhOVHZUYngvQktQZVpQU1FCNU96MXphWmJjbm41WGVPL2tqWWdnaTkz?=
 =?utf-8?B?U2cxajVjaGdJZk9DTldPRXdPRW9NR0dEZDJpTGF6UktVdTZFR3dvblFSQzZD?=
 =?utf-8?B?c2JZM1ArYmhVbUVGelJ2S09UaU92U3FBOWprTWlMRVNXM0UvVDk0Q0dxTnBE?=
 =?utf-8?B?K05IRUYwNmEyUUxOYXZBT1k0bVk1ZnFLRVZ2K2MxL0NYdWFoTFJxUHUveXBo?=
 =?utf-8?B?K1NLT0tkNDZGcUpxSUhick5uN1NWTlYrZmp1RTNsWUJxc2I1aEVDdVBZYUxG?=
 =?utf-8?B?Mm5xU3Qyc0VMY0dRN2VvS0FRQUtVdkpMYUs3WURCdGUvSllWdDlURytxOVdW?=
 =?utf-8?B?eFdvMzJmUkt3RDBCV2psVS9nbjg5YUIvRXVBUEMraHBHblVTdCtERzlXL0Z5?=
 =?utf-8?B?WThaclkxa3RNdVNXTjFPeHdZSXhhc1ZGOXhGMmRFOXhaTTJlMVJmZkdDZEZL?=
 =?utf-8?B?RU43OXpvOUcvQi9yWkhFTHd5OUdRWFVLMCtEYnRrL1prRm1HZHJPLy9EVlV4?=
 =?utf-8?B?N21QNWNGZG1DSXJSRWF0NDZVUU1rSFIxSlU5YnNWVVN1UUplVmZEWVIvdjRK?=
 =?utf-8?B?RW4xVGppTUVEb05MMEtZcUJpYXZZaUFRQzRIUldYQko0UEp1eXhXbm9ZcS9i?=
 =?utf-8?B?YlN5eGhoQkxxY1JZcC80dXh5YWU5dmhNSkFHYWdSRm1LMGhOdm9jUlhlS2ZP?=
 =?utf-8?B?U2hlQ2VXZVFESHlSZ2h4aFY4R0I1TE9ENWhtZjFyWHJXSkExZG42WnBIa2RP?=
 =?utf-8?B?YlByWFVaUVFYMHJmTnQ3TlJPKzJMLzFuN05hUXlqd2dNekxPSlNsVWpIYTNU?=
 =?utf-8?B?YmRadlFSUmZBQ0l3SlZXR3R6d0FjVjdqRjZJMDM3MFBzUmxabzdJQVNTUUZV?=
 =?utf-8?B?S1dSbk1tbXZaaVFIVFdkci9ZcXRVUW95Z1hKOGY4WFdSeGlIQkJiQkx1ZlNF?=
 =?utf-8?B?UENiY0RqdkdBeFl6NDZ5bElBRlRadXJrZkJEeUlrQlo5eDN6VjM1eVRocG95?=
 =?utf-8?B?bTdBMWJGcWM3UWRqZy9qOWU2UVYrOEVyTWM2cWZoMy9USkQzTXUzdW9qcTBF?=
 =?utf-8?B?SjNHSCtad1lyNWRrWTh2b2FtVE92VThlZVFYaDNZS3lzUjN4UzRVdGtXRjNU?=
 =?utf-8?B?K1VWT2VuTGgvOFlIQWFlT1dWTmtIRXhaYnRkYTJUdU02UjhsUWJGOXY2dlNG?=
 =?utf-8?B?RlhNWWt6Tkh0WVNWV3Q3ZWg5aytyRGNaZ3RFNUxGbldYMDR1N2lCZ3JBVHUr?=
 =?utf-8?B?MTROMlowSDY0eUQwMjN2Yy9TcXVBYk50b3ZNR05WN0h5eFdIbG9qV1NlMkVB?=
 =?utf-8?B?WnRFNVpnSzRJcU42NlJ0V3FQTHhoeG1NYnpkN2VMUURPNHRMVEVKUjBST08r?=
 =?utf-8?Q?ju0KA/r2ktQGE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElIRnpydm9jZWs4ODQrend1bDNhcm50NENxVUh2Tjdra3Q4enhKc2g4b1do?=
 =?utf-8?B?emwzRnROTGVLZjVuREhLdzRFNUk1VUI4UzdtSkpCMm9rL2F4RVlRbU9Dai85?=
 =?utf-8?B?TVl1VFUwa3I3bjQ1Z3REWFhWKzluODc4UWZhejNRK2NKcFJKWVBteThtQWFt?=
 =?utf-8?B?ZG1GMjFTWWhjWktRU3pVRjkybjZMOERDVjRwdnd0YjZPbzhVaE1ZKzNqbHda?=
 =?utf-8?B?MjJrclVuVVhGVDl0NDFuSUhzT21kZFF5dUU4VnpOcHlCNlNyZ2JOckZlck5G?=
 =?utf-8?B?dVYxais2TldkUjhmdVhkR2RTOGVIdk83M0tOWFJGM1hmVnozZFNFSUhzN3kv?=
 =?utf-8?B?Q3owSTQzc2QxTitJRjR0c1lSdEJ4TUxzckZ1TGNneGp2OW5SWWVnZjhLaG1T?=
 =?utf-8?B?M2VvWHpmZjZrNWJyYnBUenpsdm14MjJvVHpjVkNBZSswbkF4N0twc2xZaTlK?=
 =?utf-8?B?RWE5YUxyaFhGNktYNGJ0SWw1bHh4OUlxdHFETlNrTTdZMmFTZGNtWGg3ZVVr?=
 =?utf-8?B?RUZ5eFN5bHlpU2UvbWhkWldHSWx1VDJGckpqMVordnBJWkp5OVBSNmNoRXpT?=
 =?utf-8?B?L0VkQU1QZUVNZDBWSGVRSy9QN290eVlkRWtKRURIM01CL1AxejJQRUk0VFR2?=
 =?utf-8?B?cmpiM1NhenBQZ0NaVWVybU5ya2ovYzMyekJIZGRmM1QvL2NGZ1VxUk0wOENi?=
 =?utf-8?B?dmxBc3huVm1SQW5aeHZMSi9zRWllTlNmSjVpTmJNZHorcm9TUEZnZkpxTFNH?=
 =?utf-8?B?T0dSL21mUUx3SmUzYTE2Z2ZEZ1dPSnVETXJwWGlqMGRBVlFtUlpnYUNxdEY3?=
 =?utf-8?B?cW5vTXp5ZVB2ZFA3djlkWkdDcWN2dXplYnN4Z3ZTVVVTS0FqQlJpTHZqUGlO?=
 =?utf-8?B?OGVqZ3NIQWhRL0NDZ1JUVUdjQWFxQ1RsK0FxUGVtb054cnpiZEFGZmM0WVlV?=
 =?utf-8?B?Y25xMTNtVGNXUEFRb2xBeFpqa1RVN2NKYmlVWFJ3MXlEU29KUzRXTE9lYjRW?=
 =?utf-8?B?cWhOVStEdHQ1NVBDTXRUR24rMDJQdXJUb01oVXdINGE0SmFVaHVwMWhiTXhJ?=
 =?utf-8?B?eVpDZElsMXdROWJIelN5WHNkR1FpNUpEYjRLa1RNeVJTK1BYM1NHajBQdnVx?=
 =?utf-8?B?MlM1akl1Q201cHhyYnR4Wmwwckd0ZllIeDJnME55MmMrTlYvRVdJL0pNWTRR?=
 =?utf-8?B?ZnVpN2grOTBUbFN2bkx6VlNISGlxdVFpaTFVaVJPYXlZVFROVEVXSVBvaitr?=
 =?utf-8?B?eUlPK3pmUlNJemZKcmxSWHV2andWMmhLK1VmYnVrNXhnWTd3ZUk0UisvY2lR?=
 =?utf-8?B?RVZJM3U1L0dycUhvNTRQbnFHdjVnUkh4Rkt3Q2xhQ0RBQW9yNHNVY21ualBU?=
 =?utf-8?B?Ny9vcThFUGtPcVFZenhveXF3MU9ET0NqVHFhKzV1dE5nQWNvYlpoMkhCeCtC?=
 =?utf-8?B?bkpOSCtrTEdaZjY4dG5Ib3p4Qyt3eTVDbkFSMUNETXFkWGh6dTYvb0UvcGlD?=
 =?utf-8?B?VmNhTFJiMzRibXpuTTlaME81L0RXOHpGaUVVdDJ4TFN2TjgwMFU5empVSUJt?=
 =?utf-8?B?TjU4UktmYWNBaTEyNFZ2aHhTUHJUSEl3cUVIZGZ1aEhHWWdRZGxSQzNNVmZW?=
 =?utf-8?B?Q2xXZnFJdmc2OThCZDFsUzRXVnl2bTlIaFhXdXZDT1Y2S1NuSTU0dEVzTHhI?=
 =?utf-8?B?ZzVwYXR0a1NydFZ5RzE2UWQ5dE5jVVNzRmp2QnFIUkFTQ2xYeHB1NE0yMHBu?=
 =?utf-8?B?WWJ3TERJVSt3bDhtV05KRUYxMTdvN05aY2VOT1lwbjFzbmZaWDFIVzA4ZHR6?=
 =?utf-8?B?VVNmOFZFYUJiRmdMakIrcUlxTE50VVY0RjF2ZloxZTRhZ1Z6T3hLWkNLMHhJ?=
 =?utf-8?B?V00wSFBSVmRCYjlIZjlhd1VYUnR6RFMzRmE5NnpYdmV1UHRlMEdrOUJ4cEI4?=
 =?utf-8?B?Z01GYk1VMGZPd2pQaDdTa0pDaUR0SXhpZjRKNFdkVzZaaUdSUlRXTG1hZmZH?=
 =?utf-8?B?b1NBbE5kMDJCK1p0emJnOWNJSFVnS0NoQjA5MCtJTENUSGtUY3orR25Fd2VF?=
 =?utf-8?B?citPZVA5bEMxNnMvSDd2SnpGZWZac2JvKzd3WVptVm92RXk4Rld5a3FXd3pE?=
 =?utf-8?B?NnRab0RrNTU1SzFpZGM0Tnh1d3ZsQ1Q2N2dJSkl1WnlLcE9Fd3RVSzg3ZlpG?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4265c5-2a45-45e1-adf5-08dd66fb1ab6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 15:31:22.8917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFGUGou31GGON19IGdsE3KrZG/qOIk42nvSrewS3B6p6GhA9gbtY4dlJVBhcOHiM2pHMY3pK7Yh+pPYlemcw41OnU4mkxIS/b56WIDLIg5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8730
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

Hi Simon

On 3/19/25 4:03 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 3/19/25 12:49 PM, Simon Glass wrote:
>>> Logging of function return-values is used very frequently in U-Boot now.
>>> Add a few helper macros to make it less verbose to use.
>>>
>>> It turns out that the log_ret() variants are not so useful, since it is
>>> not obviously where the error is coming from. So only the log_msg_ret()
>>> variants are worthy of these macros.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>    include/log.h | 26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/include/log.h b/include/log.h
>>> index 4f6d6a2c2cf..bdda7af570c 100644
>>> --- a/include/log.h
>>> +++ b/include/log.h
>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
>>>    #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
>>>    #endif
>>>
>>> +/*
>>> + * LOGR() - helper macro for calling a function and logging error returns
>>> + *
>>> + * Logs if the function returns a negative value
>>> + *
>>> + * Usage:   LOGR("abc", my_function(...));
>>> + */
>>> +#define LOGR(_msg, _expr)    do {            \
>>> +     int _ret = _expr;                       \
>>> +     if (_ret < 0)                           \
>>> +             return log_msg_ret(_msg, _ret); \
>>> +     } while (0)
>>> +
>>> +/*
>>> + * LOGZ() - helper macro for calling a function and logging error returns
>>> + *
>>> + * Logs if the function returns a non-zero value
>>> + *
>>> + * Usage:   LOGZ("abc", my_function(...));
>>> + */
>>> +#define LOGZ(_msg, _expr)    do {            \
>>> +     int _ret = _expr;                       \
>>> +     if (_ret)                               \
>>> +             return log_msg_retz(_msg, _ret);        \
>>> +     } while (0)
>>> +
>>
>> Mmmm not sure this forced return call is a good idea, this would forbid
>> us from performing some unwinding for example.
> 
> Yes, it is really only for simple cases. Without the return, there
> isn't much value and you may as well not use this macro.
> 
>>
>> I don't really see how that is better than simply calling
>>
>> return log_msg_retz("abc", my_function());
> 
> That's not the intention. It actually replaces:
> 
> ret = my_function();
> if (ret)
>      return_log_msg_ret("abc", ret);
> 
> I use this a lot in my code. You can't always just return, since there
> may not be an error.
> 

I see, I read too fast again. Only return if it's an error.

>>
>> ?
>>
>> If we were to keep this, I would recommend to rename the macro and fix
>> the docstring because it does not only log if the function returns a
>> non-zero value. It does actually return.
>>
>> So something like
>>
>> LOGZ_AND_RETURN(_msg, _expr)
>>
>> maybe?
> 
> Sure, longer names are easier to learn, but then it is so long I doubt
> anyone would use it.
> 
> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
> log_ret() and log_retz(), which I am actually thinking of deleting.
> 
> I would like the shortest possible name to avoid spilling functions
> onto the next line all the time.
> 

It should be absolutely obvious from the macro name that this can in 
fact return because missing to unwind code is among the things 
developers typically easily miss already, so with this macro it'll be 
even easier to forget about undoing things.

I'm not sure this downside outweighs the benefits to be honest, but I 
also don't write a lot of code these days so /me shrugs

Cheers,
Quentin
