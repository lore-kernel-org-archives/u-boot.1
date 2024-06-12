Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E5C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 11:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A6D883EB;
	Wed, 12 Jun 2024 13:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JBCD/vAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCE388411; Wed, 12 Jun 2024 13:18:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3A987DCA
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm0CSw+dJ5bR7pZ2P+Gh/qXjo37ZK8tAm/t63kEUiLT02B7zj219WN/55TpsToDEf9+7jWyUVB+0LLlD2SE1qeieCTlp0hmO2aGvycRNz9+fLDDGhc8tZLHrYFARdgHoo8780a2s7S0858WbZAUNpYfqucshdar2s6YOH66wY7pLUAM3aqmwEiE8l3MVeFV5wyKhDSRtTwzhM2UBoFGaO8/cMc6uiQFxp+B5I31quY3OVzrmj5OVydr6h1PAgH+1Bt5BiYNSlENy4kdFz6xaGtfSZBtMP8A8GeKDrm7T+UGakcRDTtM0UUSjHu1gPlv7AiQuAtpsnQHoDp/1p9s2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI3QnpJbyIIiqaGly72jCKnmuI9x3aNd6fregOhAvwQ=;
 b=FT9yavMyX5seqfPNmjP6AiuS75Ufxgy5+NfvUBJkn4porJXCOvUop0sL8pLwZ/UYg/rPvLOCLAeZIxX8StRjXg0ZYTT56iMPSBUCsLBuz2OuAKbEH8w0stXkHH8UNXjXPEtmvuQe20gFCT1W2kY7NjKDWH+M2Z3TXWF5pOysX6/euj+EIahFtFSNC0gX+xoKMQknvmEYS5uEeuBpDcGF3hMzXjU0HiiB1K/TESfRnFZaYqmA++gc1whPlYC0TPHByYRKlWl5xAtGAVOfbiDuTGjIRtzi4FOR3yZNYl7a7F9jdrcATFuifvP7127Gc0JdFr8B/Ayz2AISftb5PTbY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI3QnpJbyIIiqaGly72jCKnmuI9x3aNd6fregOhAvwQ=;
 b=JBCD/vApmwaq7cyRgg66uZSbBl6qPZAejY6+tDOxkanN29ZNyuRKLxtrFNj01GZQkCagVmhZT15EfEqX9bHnAmpKHyD98nsC+4ATwrC+Mi5ZZxQlt35Il8dm3PERT3WtwRioodhXr/hxtWVgzF/fquhO5j+2E3q+N3EG06C6FE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7000.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 11:18:16 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 11:18:16 +0000
Message-ID: <738ebfbc-aefd-478a-a49a-5763e2e24e71@prevas.dk>
Date: Wed, 12 Jun 2024 13:18:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Shutting down of the git-daemon (git protocol, https and ssh
 still remain)
To: Claudius Heine <ch@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>
References: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf33895-c59e-43a2-ba60-08dc8ad15b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTRLVFVtYTZTZGVkQUkrRm1NdWxJSkhMV0VmTEtyc1BKbWpJRTk5Sld5WU1F?=
 =?utf-8?B?RWdFTHh1c2F1TXZFNkNhR2R5WGhxUVJFMkE0RUdQMlo5ak9tbjB1ZDRTT2lz?=
 =?utf-8?B?WFM5MmVOY3Z3eHV1ejF5bzZMRHFFUFdtS2FrSWF6RFJocjdyc3BjcEVYQ056?=
 =?utf-8?B?NmE5V2VDMmV4ODhBaHk0REJqNFdkNGtTTEN0azhQbk5ERGp5Y3Vmb3BOc0Q0?=
 =?utf-8?B?cVlJOWpCYldnekRiU2hvZXpTUTJ2QWNVZlFKMDBpYUpLcjc2WnowZ3pDdm5Q?=
 =?utf-8?B?c3p3MHRJZHNPTW13dmV0b0laQVdiMlhjQlJFaW9nb3BYbU5rQVl3RVV1bmNU?=
 =?utf-8?B?NGs5VHdnc2N6OHpKeCtNcEczTXdwUVJxdk05Q2J2cThxa0JBRkpWSUlabEI4?=
 =?utf-8?B?RWY0TmZ1QjBGMDk1RWN2eWgyZjVGQ2ZZTjV1SUpWYTFEOUUram5RNFBCZnA0?=
 =?utf-8?B?Q1JyU1hPUXB0ZWx2OWhsV0gySGFYWWZ6QW9TZVlrc3VFaGNnL3prK0taaU9W?=
 =?utf-8?B?em1YeHVJUzd5WmNqVjEwM0lqb0VWek4zNUVKR3gxMnVVUUhFSmJxNjhJRXpT?=
 =?utf-8?B?UC9NcXFUNndrVHdndHFWK3M2MGVrNTFnajFKN0FnS2UzbGM4ZzA5enJhQTUw?=
 =?utf-8?B?a0lSeWVEZ0VRSGNvdG51Ri9hK1gxVVBQRTVZNE10dm15NkJ4NjRYdGh5RFE3?=
 =?utf-8?B?cDR4bU5vQU9vZVlObWt2V2pvSFpNNmwxREdyWVFJOGdvMGlsTjVocVI2OEFE?=
 =?utf-8?B?dzF4Mm0vekRpWUVsZ3ltRkFEM21oOXNKZTdmWUQrZktHa2IvcEMvRXlaUTdr?=
 =?utf-8?B?TFNhNWFCcDRJTzhtV2pFbzI2UElWY2ZmVG8vc3pXUXJzSjZHUlY3a1VGRitj?=
 =?utf-8?B?eVZ4NUlLQmx0dCs4Qk0wS3ZmNzJYZjc2ZjNHNTAzeExEeEN1T3NZZW1odGlH?=
 =?utf-8?B?dkNhRTVpSWU2aVFQUWdsLzIzVjhHSlY1bHRXbEExYXhCVnRFQUxCZ05iTVhY?=
 =?utf-8?B?b2xyUDJwaWc3eC9LRFpzNG1VVVA2NmJGUGxZNVhneng1cGg0YnpLUVRDYXI2?=
 =?utf-8?B?bWswakQ3WlNUL3hTdzQrWnVUa3I0T21GeXMrSXRNbHhsZE40Y2plZ3IwQk5X?=
 =?utf-8?B?aEVSeUlpcVc4UXlRaTZ0Q3EzOFRlNkFwVEQxMURadkhtaXk0YXNTRjFkeldv?=
 =?utf-8?B?ZGZ6N3dhZUpLT1FlZ1cxOEJveVpwUFd0eTlWcVNqLzNhWEVtMDZWcE94RFFt?=
 =?utf-8?B?dG13dE5JUUs3S3huUzFIMWFWZTg2ZjF3bmIxM1FlaW9BRDdWVjBCVndYcTVZ?=
 =?utf-8?B?RjdKYUhPeG1vNVZjUXc0eXJCTStOcFlpTTQ1QTN0dXltUjhqdzJJQ2hDc1VI?=
 =?utf-8?B?VkttaVdCNmJPMnVnUnZxK2NabkdJRHNjTGoxT29uMmJXQWtnT3ZTQjAzNGM1?=
 =?utf-8?B?TExqcnJMK21IekZ0d0lyeXFSUmxMUGU5U0F5aTNkaGpQdXZGOE1JanBjRzRj?=
 =?utf-8?B?a3EvemkzNTBiZDFmeVp4aE0weS9vOWtBdjdiZko4VEFXRjc4SXI0UEhORm10?=
 =?utf-8?B?ZXgzVk0yMTRyd2J0UTFXTDRtK3lSU1VrZHRFM2ZQMVM2ejlyakpHRDhpWXpN?=
 =?utf-8?B?dHMxZC91dis4UG1RU2s3YVdZcmVoTU5hVWgwWmI3Y2RtRnZ1KzVpbG45UUFS?=
 =?utf-8?B?RHM4R1pvSEdVdG5GQ1R4bUx6L2pQeVp5a3BTZ1pWY21TSU10K3kvbGZORW9M?=
 =?utf-8?Q?xsagunitXjydxbYPBagWXbQ+DCxPvwz9nfJA0+a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230032)(1800799016)(366008)(376006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDlra2NmTUMxSTdGZzRIZllDaERtWWc0Tjc0WG5HY0NHNndCdFkvaFp2UzVk?=
 =?utf-8?B?cCtvMFJjZlV2VWcyVTR6emU3ZklubC81UVprT3c2SmRqdU1lUW9JeTJQOVRV?=
 =?utf-8?B?V1hGWTF6bU5mdyt6UzNwMHZnUzNLME5MbjVncnh1VjVmd2VVOEc0alRKWHlr?=
 =?utf-8?B?YkxQN1loVW5xZHM5QlpRTTREa0dsRHZEclIvUzhpOFpSTVZIbElFSnRsSDg0?=
 =?utf-8?B?OC82V3hvWUZNazRkSGEzNVpjZGFJd2JlbmR2TElGOTNEcjZna3B0dzg4bVFq?=
 =?utf-8?B?TkZFTW5lNnZQNCtNNzZ4WllFTWgvT3dkNmFxcUlTa0RVUFYyc1lza0FOVDZo?=
 =?utf-8?B?dXpYRlRqZUtBYlA4OU5KRG1LakF1eTdiSEp5N2s1T3hrUEgwTldEM2g2dVRN?=
 =?utf-8?B?ZStLdzFnbzNsbHk1NnlWbW5tWDRnanA2YUZ2Qlc4T0FZL1J0YmVxVTJMbGt6?=
 =?utf-8?B?QXczSC90NmxDeXdyY09DcTU4RExxNjZmR091MDJBOEZBbjFTMnJMcDJwUStS?=
 =?utf-8?B?N2hwVnVGV3dkYmE2UGlHK0pEYWwzcWVEdTRYREo5eWxXeXk1YVZoVEgyaE1O?=
 =?utf-8?B?ME9PRVpvNDIveU5NbjY2V0E3REJOa0pWcEdDcnlUc3h5ZkJwb1ZUeDdDSURk?=
 =?utf-8?B?Nk9zcUdIOVFPZjFra3pkaE5mamhZamt2dzFWK2paRlVZYWNpU0g4TXJPOHlt?=
 =?utf-8?B?Y2pIbEJjQXpaOTdSUHFrN2FzUGV6SUNBYWU1WTdpQ1Y3L0prNXNWZEtHMC92?=
 =?utf-8?B?aCtjdUdtNjFqRHlIQjNJU2lJcFhkSkdCSW5tTVNsNDcwNUt5eHU5OThxTEdl?=
 =?utf-8?B?RzJwZlRTalRZYkhNZWJ0ZFJxYVJvK1NuM0thVnl1d0ZIdTRHZVFHeHFHUWtT?=
 =?utf-8?B?SlZWcGI2R0swMEdKNkIvRlpiMTNvTWpjT0UvcDhNZnFCZEx3THRaOWZUajlM?=
 =?utf-8?B?R2pHSG56MUFrcnZhVER6MnIxcWhFUHhZcUY3Y1ZncU9XRjl6UWxXa2cxR3V5?=
 =?utf-8?B?alFZYnU0Uk5RMGNqQXJGNDNGa2hpbDBOVHhUZGdEL0xKY2hLL1BBRzBsc0Z2?=
 =?utf-8?B?aHNya0FpV1cxUHdBaVNrSWRGVXprUVBuY1BISHNOTTNtOUZHRFYvNXhvaFpa?=
 =?utf-8?B?S3QySFJJQ05uVnRDbXc1Y3Z1UVNacjB1dVNKVG1FVEE5dEg2NVlqdEx4cEJR?=
 =?utf-8?B?S1FGZ3dzTkYyendsVlVZTVRidlJBdXhPRHpOVVcvVHJvMTNjYU9zY0duWklW?=
 =?utf-8?B?eDBYUVZXbm14T2VSc21TaTlMYkZpeWd0MHZtMCtZdzBHcnlpQ3VIcVpka1JV?=
 =?utf-8?B?Y1hLcHpuR1EyaTdmalI0VW4xRnRtbVF1SXJWdFJwc2dwNnNUMlFUUmI5bVdC?=
 =?utf-8?B?QmhBeVpRRVV5U2FxbE1YNDJPSE9WMGtXRzJ4ZE1sbU92YlVJL0M5M1dpWlhw?=
 =?utf-8?B?aFlFaXlpY3BCSkxXM3lDUTFHYUhPckNXemJXekwwYUdyYmJEUFFTRk9rMldq?=
 =?utf-8?B?d0FqVDFSUml0cFlVdnlEek1jaVdVMVNwVnhPbDExWk5iWDJZTlRMT0kzejZ1?=
 =?utf-8?B?dU9UcG5Rd2hWLzVVR3A5bC95b2lBTXJLTkZRVUliOUNQa3Y0Vi9tUWpuaEh1?=
 =?utf-8?B?bXZmZjF6bUM4Y2dVakM3ZG5NL21DL3F1RzlxNWdvanJTSEZLdTlFcUJTekpI?=
 =?utf-8?B?WjlKcUJNQWxocW5FZldaNmtubUpEQ1hPWEdqaWJpTU1hQjZqK0pMTXJPQkRU?=
 =?utf-8?B?b0F1Q1hRVWlKb1FDVWhXVE90a3ZuTzMzbit6WjlUNlczWFRua3ZIa2toY1Jv?=
 =?utf-8?B?aWxiVHhFL2JMWDlFTDZiZms5UVhxUzREaDA1aW9xeHhVU1hzNy9hRUpTVkR1?=
 =?utf-8?B?Q2IzNTJEK3RUT3BUTFBkY3BJbWF6MExKdWFBSjZLLzdjRW5scmh3RFdWcGp1?=
 =?utf-8?B?NVB4L3Q0SVZ0VWFGRDRsWE9TMkd1UUx2VElhN3V4cExzTVR4a1Rkd2NNVE1u?=
 =?utf-8?B?M3gyOG40aE5tejlwNlFQWUVYTTQ5T0dvOHNUTENVZjhuR2ZMMnRYSEhkU3Fm?=
 =?utf-8?B?SldOQmU0OWYxK2ZnYjE1ZndjQUNRVTN5OUppRHpkTmZQK3RkTnI1WmtCYU90?=
 =?utf-8?B?N2ZaZEw1QjZBQzBKTllYK0dHdUp6cGRONWVyRlJRZUN6WUF2T3A2cHNkVFN4?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf33895-c59e-43a2-ba60-08dc8ad15b2a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 11:18:16.3475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpN5edXzRCPUS1C5R9m7Eq32bTROTPGPKxL7V/23YdTyOO1t/9/vBWLjWl/PGNeJa4tfrYpH83mb6tiXWJwUTuRRlHQdU52/nYy1/2GRh00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7000
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

On 12/06/2024 12.20, Claudius Heine wrote:
> Hi everyone,
> 
> in the past we used cgit, which provided cloning the u-boot repo via
> http, https, ssh and the git protocol.
> 
> When we migrated to gitlab, which doesn't support the git protocol, we
> implemented some additional service files to continue to support it for
> some of our git repositories.
> 
> We just noticed that cloning via the git protocol is currently broken,
> likely some changes in gitlab happened and we would need to recreate the
> symlinks on the server to point to the right repositories again.
> 
> Since that is another thing to maintain and keep up, we would like to
> just shut the git protocol down. AFAIK most projects moved to use https
> for cloning anyway, since there were not many reports of broken cloning.
> 
> What are your thoughts? Is it worth the effort to keep the git protocol up?

So I don't think you should necessarily keep the git:// working if it
means extra maintenance. I just checked a couple of my local copies of
u-boot.git (don't ask, it's many different customer projects) and it
seems to be more or less random if I added upstream with git:// or
https:// . I can certainly change those, and thanks for the heads up.

I'm just wondering if it's possible to have the server send some message
to the client when the git protocol is used, for some deprecation period
(6 months?), so a developer doing "git remote update" will get notified.
He would then also have a chance to propagate that to whatever local CI
he's responsible for, instead of only noticing when things do start
breaking.

Rasmus

