Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03E2CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3437B849A1;
	Thu, 18 Jun 2026 15:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="GLSr0OdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C5D849A4; Thu, 18 Jun 2026 15:11:51 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8266B8460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG7ld+MZbHLqNHEbYC670sS2UaTsOOjn3D5q3NQ0+NjHV0hI16ZSzt7nh7niEg2vbXeCbKJc2Uc8kESnphF8wWYMcG1A98GSYHwrUM+LLW6r9GlphbfGqoxSZ0vm7nuag8suS8fMdBIFAvWT4Kt2j+UlEcRSZRHcGAUNuI6OPnNX3NIfbbeOLZJQF26Db9yDeKmIG1/2IWjrJkkBtf8FToOyxnf2K+bqZY92U7OEzELPI1IsrwwKEV4MtWgPHgxtyB0alS60M8x40vvco955ZD6leDS4BH6J7sNY/VUYlW59aTddZf/gpWY1aOy0CsaONmN059A39mCJqlagUHc+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLOEG0RVuposcAkabfLJP2pulZxAS/SsoCKS9GpxcWg=;
 b=UvLb9rnOw6P5fUpbpfYpLucDdCRs2QcnJTEAGj9BRKMkNUELx/QUxMAkm/YtPjU+vBqXob2tv59G0d8JM6uSLqTurKnEgXc4N05ibSdcj63QyH9Q78mOI+O0JxWyHcWttaTyzjGWSPz5QlPpI+pCvcyUPUpixi18y3RcgaiWnBvYnQ9JZIqUYAXfnTuWon44Uihz+h0BSk1DeL84OkiG7sW4JLXmEVf49MrbkfGV+2OlFa794im20S+2JJf7ZlVfmQiZ1Eogm+oMGsk0KPyyZRtrdOhELzuZVgk8Mn0uUSVt8BWXTkX5O3SXJgyUMagebMsO2J4XvHbKdLVwcPojUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLOEG0RVuposcAkabfLJP2pulZxAS/SsoCKS9GpxcWg=;
 b=GLSr0OdFPW9Aq0+NhvZZxJ/99G8Q5Vj/ju3TjhT2dGirj1MG5V0av9EKdz7mQqPaznGaC1bJC+W6h7YuEbJVtiF21wuICJc0dydOm6WsruUbVOsVu95w/sdQVgJVpuFEYFK+PWlYqFmPwkj4fAigZOclBBvl9FpEbSuV4Le0HEy40veNLc1tj4RI8lY2yP2rJh2m9+l1S1kcCrhwzfCTdpWhHjG6DwB6tzoMAVHBybvNXk1KHJ/98fd/klZpFvBdQd2UTrSc9c9iLwM8q1ROrx+JSscNx4WcIinen208Z1OEm3kuWgHmzktW1Iyn+HGvKbYycexZdRPl87OTV4U4Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DB9PR10MB6667.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 13:11:47 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 13:11:47 +0000
Message-ID: <2b359cb3-be59-41f2-8730-8dbbbd292e86@siemens.com>
Date: Thu, 18 Jun 2026 15:11:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] qemu-arm64: merge built-in DT
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260608130924.112831-1-ludwig.nussel@siemens.com>
 <20260608150852.v6.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
 <20260617170720.GA1942927@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20260617170720.GA1942927@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0325.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::20) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DB9PR10MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f064c0-cef6-4991-f3c8-08decd3b269d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|18002099003|22082099003|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info: S3h+vb9BfcxYAWn9TvwmTEIsaxMD0sB4cwUfxdsAiCkoks58SbD05pDxkbQUUub63jyuJ3RmZtHvCRtEiw1dcWvXermHZtTz7I9EuT3eJesbnH16Nq+vtEkb2cO1z30MU8KN87EQj6/uvrU79hIk4I+K0f4xW9YFQq4KeHaU5KXJj8vbSJstjH5s7uZAAzXhocmMoGJRk6zzOj6wOhAKUkMZ1Ph8mghdc0qTKFgqUqwYbLr+AulXMJbHCtr4/aLFOua2oM7L5rrhvMhkHl5U0dyUsV+QfrolAJLaX6kwyLezZdmq2ixHKYl0caynjHXFvMrW6hrHuwuFcAD8RMUSDRCWF/zMnmvpKO1TP6gnN9/3WVF9UizAL2MZqYYAlpP1SuQLdHYi35GPdV3A4cKEM8ubVhGxRDo+3E7SV5XeZKd3VK7yNCoo71C4n+MeAUn+lJWWp256ydVvbPlso9hu82hwtj6bfdKbnTs1Jf8Mne7bYAUyqnDl8JeLjJwTL6xe6EbM5KgHdSo1rQ8H4vq6lhxuADkS1/bSxZGCf29MyDJcV3B/vudMsRLm+fvCHtrHyVDLBV9726veJwpBi9ttrGhUQoX2dPSYsqDBW6Me+/6e1W0Gi8tYRwjEuzE8d6kydQz/4G/sir9MmLERwqGJqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRvVTZUVmlxUStvS2VlZWlhVGFnK2RvdklWUCtiRmwvbWRKR0wvT2FQRHRJ?=
 =?utf-8?B?aGRJeFFPNFRDZVp0eGtycDRiZUlMaVhXRGd2U2FzU2loSmxhNWxLNEtKdmxS?=
 =?utf-8?B?QmxZNnlORUttMUpyalFLYzJoS0lOeTE5ckEzVUhIYW5NUm5Fa3BEMDJnMXZk?=
 =?utf-8?B?Y1RPQWE0WmRGOFBUNXZuZHQ5ZzRhU1V5QnQ4U2lFOGpGTUtuQzZEa3EzakdV?=
 =?utf-8?B?dDZtRFNrSTdQS05SSVlPV21QdVpxRnMvWEU2dkw3THBJaWh5TUdTYnp0R3Rp?=
 =?utf-8?B?YlUxTXpreUk4U2Jra3VtMStndjlzNnE4SVhKcGtRQUhBV0sxTUdIazlHeHhk?=
 =?utf-8?B?OXpYRVhiVXoycmpJdFh4U1ZKYVpWc3k4TFNBMnRkbm00aG1Rdkx0VlFzTm1m?=
 =?utf-8?B?U2RGQjlTT2dTaW1wMWh2K3RianJ0VENLaHZma1NIVGNrYlFLcmdLTlNxV25Q?=
 =?utf-8?B?RDY0QXVDdFlZZ1pFSHk1Z21EVitscHRMTXV1aUN0am9PTWh3TEFjSmVQeEhq?=
 =?utf-8?B?SGF2Q2E0YlJRZ3BZN0NrQU9lbitVUUwxUytCM3FvQXAydEhaSkpsdmRCWWVx?=
 =?utf-8?B?cXI0RzNBZnE1YVRrM3BsV0o2YmxLUWxhQkpTdEtrbEhuZXc4NDFQck9NeWcv?=
 =?utf-8?B?dG0yMHhPcEd1WGlKRmJ1SGtLcnJaQzFxQ05LM2ZjOSsxWEJIZ1pKbXkrM2sz?=
 =?utf-8?B?WmV6NVhLSk95OHBlSTdPV1R0M3NxaCtMcUZ5eHVGQWRkcUZXcjZ3Zk1rYndn?=
 =?utf-8?B?VkRJNUIzMk0raU4vV05wYTRQRzdPQ3pRanlDbzNHd3pQblQ1Zyt2VUZhSUNE?=
 =?utf-8?B?OHJreCtEQUU5V1ljNGd5RE9TT3ZlQ2plczVzUXprVEZYRFNrTGx4d2F5aGVj?=
 =?utf-8?B?V0FNUWdwSUpUYnU1aDd6ek1iaDF4OWVFMjNyOFVPUGNzVTI4cVo5YURXa20z?=
 =?utf-8?B?NEVDWTY5RHBOeVFOcko3SVpYckZrUVlQcHVjTmZhR3RydWdTd3lObFNVemhR?=
 =?utf-8?B?UGkxVWFTd3VMZ1JacEVMSGs1QXlKTEw0bDMvKzhKT29zbTRnSi9XOU5hSE5V?=
 =?utf-8?B?eUg2MlVLNXpJcGhBdlNvYWl1U2RvbHFpZFFSbnIvak9jcFVYeUtpL3hlMDdR?=
 =?utf-8?B?OFozWlNVNnFjVFZOM0lCbEtJeENBd2EzRC84SEZBSFlFUllkMEZiRVBDazBP?=
 =?utf-8?B?bE13YUZwRVV0WDFzT25TcXE2UlpEOGd3WkhxbnJhdFBnZktsWi96K2FobWJE?=
 =?utf-8?B?MGpYZU13R2M1Z291eWZSYW5wRU5keHhsRkRFQ2MwSGljV3FhNGVKMUhxSVJ4?=
 =?utf-8?B?dWVGRHFTY2FiYllJNmYzMWh1UXVuYUd1SjRmMzJKa2daSzlLL2lWWHRuNmxx?=
 =?utf-8?B?TzhlWU40T3A3TE56eHptUmhJSUpaaDR4ZlljaUh1VTRKNUIzdkxjMHBLRi9t?=
 =?utf-8?B?Y0hlMWUyU1dmZDg0aGo3TGlTUmhRYjc3NmRwTVRGNEdHb1g5Rm5OTVJCeExs?=
 =?utf-8?B?UG84Mm1KYVB4dCtNbVIrTHRwYkJmWWlYdHo0UDBNdXl5K2ZoeDRpUlZrRlJB?=
 =?utf-8?B?aGxabXo0SjQrY1p1NHYyU1B3Y0pxaUZPWjVnc2Uxazgyalg2aWIzeEpqeDJS?=
 =?utf-8?B?NzFpRFc3amJHMVkvTVpaVTMyaUFXeC9IWG5yOTFRanhQbXVQN3M0V2xXak5l?=
 =?utf-8?B?VjlPUHdTOUNYdFZTTUhDMUNQdi9qMld1alFXL3VXeU04bUVOUjVoUFlBK0tr?=
 =?utf-8?B?SXF6S0xBWW9WSmlNRFYxQVBSZk94YWZDQWk3dmFDTEloMVV2VzZvcEpyaTNT?=
 =?utf-8?B?YlRKZzVXanA1Rm04b1hacE1tT0VwN2xJMW9WekxzZHlPcU5nNUd1SU5Bb0dH?=
 =?utf-8?B?L3JwVml1dkFkUkkraE9kNXJUOVg2eVMyK3cwRjZHWEpseVRZRkM2MkttQlpo?=
 =?utf-8?B?N1hKUm9FQ2UyMHoyWjA2b0xOcVJGWEdUWUJ5M1h4aUVraTQvamF4VHhCNEJo?=
 =?utf-8?B?OWEvUmVwK1lvNG5aK043ZjFTUVVuMUVoVnVEMmFJbHI1eXd1RzhoU0VwTjF3?=
 =?utf-8?B?aVNzM3l3bFFkK3JGdnpnSUZ2b1NrNmRvbFhBZXlaaHN5RXJ1SGNTK0YyTFFW?=
 =?utf-8?B?bS8vRDB2dThsTS92akN4U2FDcVBXUWtQWHkyYWpDaDFHK3BXWGxMTXhQaGl3?=
 =?utf-8?B?ZC9VMDBhak1jQ3lTazFLeXMrRSs5R0pnVEVVYzJKamsvbVloMlduNUI4UVY2?=
 =?utf-8?B?dzVEbXlSQ1lqNVhrWGdlQTl1RU1pQTNOQzNOSzNrUjBNUTFCQ2F0cXdUNEZ4?=
 =?utf-8?B?MUVzeWdzdEd0V2psdFJ5U3hPUUl0YTE1WlI0bCtLNkc3MlVjRTF0QUcyQklq?=
 =?utf-8?Q?Ed7TQ36H55EL7+3w=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f064c0-cef6-4991-f3c8-08decd3b269d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:11:47.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3SkligiweRAqxg2W2V6APQusem0TMlwPbI53620tJzDa7vqzf8qMz6hdPAphtWxR7DWeHl+M8osrNBJ1Rdvu5l1XgT1fHmA43lztsx6jvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6667
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

On 6/17/26 19:07, Tom Rini wrote:
> On Mon, Jun 08, 2026 at 03:08:47PM +0200, Ludwig Nussel wrote:
> 
>> The keys trusted for FIT signature verification are supposed to be
>> embedded in the device tree built into u-boot. When running in Qemu it's
>> convenient to use the device tree provided by the VM which doesn't know
>> about signatures though. So merge both device trees at startup.
>>
>> Make sure CONFIG_OF_OMIT_DTB is not set in qemu_arm64_defconfig to take
>> advantage of the feature by default.
>>
>> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> This leads to failure to build on qemu_arm and qemu_arm64 in CI. Please
> see https://docs.u-boot-project.org/en/latest/develop/ci_testing.html
> and resubmit, thanks.

I've found two issues with the github ci. I forgot to include the 
mapmem.h patch I included in the tpm submission and also had to add 
check check for overlay support in qemu-arm. Resubmitted as v7.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
