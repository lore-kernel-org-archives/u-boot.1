Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0B4C2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0578829B;
	Mon, 17 Jun 2024 16:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="X0TILhOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4BF1882BB; Mon, 17 Jun 2024 16:03:55 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6211B8819D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bifT02TQlDHUf+VSkNe5blCvkRAa3UPrugbkLMr4SOnlHrVw9CVMox/H2EvRh4dFSwJBS+JSE/bPaYBGK/ltSflxVq2/w+sgs7wUCLkrq6GrcGQJmgn1Zqmlt4ptiKu/qjEmLFPV7zV71VS5nkxd9wmlwc2bwqd81tWdkXkmjt6oVJpcCS4sMw4CtgCjcwvHEm4eYi/Rq9DPz6DA0RRde+A8RxaIdVxphfJ2jqON8pqn+0IsDOdFW8I6of1xiqcppKGTEek7/Fy48mP1zuGCzMxGT/8c2ds209JVZLvh12tvaHONN66COlfj/ewwyykWT2MbU4dQ/aw5qRDKFLcsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6cAGXqQWl/Zfic6SLQQEMfp3L7iRP4+Q5QAg8+trWs=;
 b=lOBjBlmPWLWs8bNpxEDKnuYK1uV4CXIRkR6b9BaTXDEWgtqxBpvh3xw/1A2HHvORqqnAnGMaGSgwK8BTe5L5WExai3F+AiWpdc3mMygKR2Ag3fGKZ0NXTRnsy5X8WJDF0GDBKb1CIgntoC1dfnYfEqfEo/T4pbI1sMk9HoK1HADyKUWmiXCLwB3tQsqiX7vLh/t3QuMPM3gnaxBgRFQtfs+j8/OYbBgeR4UG27b0UiG9mNH4ZnTY47mdp8bFuYpQTzsXnb+eUIdWE6DpA0T/CRXt8mzGWINWrQRv7kQHNVxKdPtizXu2bkTP5RC59XBgHDV9qNEmBMuHiJmYkqhsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6cAGXqQWl/Zfic6SLQQEMfp3L7iRP4+Q5QAg8+trWs=;
 b=X0TILhORMfV3xGdUra63G4mpemXRqrIaA1b8GioxoqsruiCLFhDi4QAu+AngbWuxCyHdQOtCMCwQPJ/kBCmdVqdpH5sgYu2GQSR+0y09IlBHLjJ4vogPATCGYAkGRv5OtloZNsILAH1OILpPAHJrrOVd0TtjvBYN1XilZrmw3go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAXPR04MB8270.eurprd04.prod.outlook.com (2603:10a6:102:1c7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:03:50 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:03:50 +0000
Message-ID: <f2183ce9-d7c3-4952-a585-be5138cad9a5@cherry.de>
Date: Mon, 17 Jun 2024 16:03:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
 <233bf248-735a-4564-8559-236a10ea89be@kwiboo.se>
 <4a5cf733-68c5-405f-91df-f87583d9c6a5@cherry.de>
 <81133178-c476-49fb-ad49-dfc00d7a4adf@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <81133178-c476-49fb-ad49-dfc00d7a4adf@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0039.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::25) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAXPR04MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: a489e4aa-bb73-469a-6937-08dc8ed65085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlVqc0RyKzIvRlFWZ0xKSmYvS3IydWg1QTMyWFJNN2tnZGhFUjl6dEJyOFZV?=
 =?utf-8?B?ZHB6bE1XYkgvRkM2cDNEcWltUUo3alFEeFVwNUs4d1dSUjVGK2tRTGRqT3Ju?=
 =?utf-8?B?SWEyemdreEhJb2dFZ0o1QXRpRFVmM01LSVROQzdaUlFKeU5rU3ZGaWR0OUZF?=
 =?utf-8?B?NVV2N3VPTkF3MWJxYVhPTk1ESEFZcGdITnVXZ3NlNWpYUzRDZ0drcGpldU5z?=
 =?utf-8?B?bkw3a0hkSGQ5dXdqRUgybHdZbDF0YjBqNVZFbkQvNC9SNGUxUnByUE5ZeUsx?=
 =?utf-8?B?TXZxWmhGb1M0MWcyekFkUGZnQmYxY0ZzaE91NGNlZytMUVlGdmNadG41c2xH?=
 =?utf-8?B?ZjdIQzZMZmxiUDVLSnZWRTdHNkY0WkgvUnpobXpwdW10dGVqK1RRSGs4N0Rs?=
 =?utf-8?B?T280UEh4RkZ3ajBEazhvcFVuYWpHWUFlN0hsZG12M2cxSnV2MTRGZWVGOHNX?=
 =?utf-8?B?eSt3dURRSnRROEZTdU0vYVNHc0F5bGVZN2hQTXdqN2Y0RFVqMFNxZDV4ZlYr?=
 =?utf-8?B?QTBYRFd1S3VsVXZ1VnRYUVhDTko4bW5OMjZUeTBuMnhvazZtY1RBbTNXbzAx?=
 =?utf-8?B?eGFYWkNpaWlnUlNuenBEZGpESllmanJSN0NFUHZuNDBCMmVMUDFaZFZWOHBD?=
 =?utf-8?B?UW1aeDRGY1dublBjUzJZaDNFSzN5Nlp3NFRBS3B6amoyMnNiUzJKOWRLWktV?=
 =?utf-8?B?ZHAwWVZjanBQMUR1WUpyZk9lVGFrbUhMTmJBR3dUTGJrMnM3TWgycjJGc3Ns?=
 =?utf-8?B?NkcwYkw1TzJZOWFQVWpOTWxCWkUvSmdxczVGb21teHRpTzNoREJHSitFaHRi?=
 =?utf-8?B?ZGFJb2JiVU5BQUN2eWlndkVDbTV2REl6M1hDYTA0Y2NmdnFSR2FjKzBtMVlI?=
 =?utf-8?B?c2RmcTVLK0dzK0xCTmlhWk1JN3dERGxTUjNHN0xUR0FpQ2xEY3VoYjZrNkx4?=
 =?utf-8?B?V2I1TEYxeWNER1V3ek9tbm42WlBKaGg3dGJBSkRyYkZJd1JPZTcwdldPajJz?=
 =?utf-8?B?TWh0elNrbm4xVDJhZ0Y4ZC8yZklpdWg0MW56V3Irb0MwK0ZLQ0dEODJHVm9r?=
 =?utf-8?B?Q0o1NE14bVVMV0U2UGtJQ2ZaMFR5RjZYVUx2Nzk4RFVqeEhhbmVlWmN2azNT?=
 =?utf-8?B?TWpiSVZPSHJqNVdUd1M4eVY4M3hZUCtTVkhEcTRxUTROL1BxRWhmcEtiY1FL?=
 =?utf-8?B?QlVOeXJ6dzBhZjBFK3p1YU1ndHBlVGlQMEZjcXIydXlkUmQ5c3UzaDFycFMv?=
 =?utf-8?B?NmhWNG54SDFLL0RZVWJxVGhIMWtsTU9oTmg0OWQyeVZzaUdvR1d4TlRWVE9F?=
 =?utf-8?B?Y3FFU2tTK3pxaFlsNW5RWUQ1am81VjVCeVZXZVBkcitncGVudzQ1Rmhzc0ZO?=
 =?utf-8?B?a01MNXNlRE9uVVdBalJ5czJ3bEs5ZHlYRXd5aVNkOHN5OTV4UjgrZ01sbXlP?=
 =?utf-8?B?U2FqMExCaEJvZkJYckx3S2JPUmhCMVlMYVI0OHl1MHIvSDY4QWRxMFpqUG83?=
 =?utf-8?B?dVFtVkJHdlRxTTVXbUh4TExYNmRQaWtsdGNKOC9nY0IybWZoZTJqL3dsQlEr?=
 =?utf-8?B?MUFrNmIvMmtUeTZQWFNSbzE3blhLSlJBcnc0SFhEVXZRdi9ZSmJFRkVGMlFU?=
 =?utf-8?B?eTlLVFdaTUVkUkFROFY4c0Y5TDJuTnY3TVZjS0JrNzczQ2tWV3I4ckQyN3Q2?=
 =?utf-8?Q?wcWcqE8MicsJbWAWV0WB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFpR1Y5SzRIWlNlUXNMZFFqVWlzcytpbGlJbXdJKzVud2s4aUdVTy9ONXE2?=
 =?utf-8?B?c1BhWExrdEhUemI1dEQrNEpZOXhkSEtiK1ZLT1hnQ3pVbGViRGt5emdobFlz?=
 =?utf-8?B?bnN6Vm9scjV3ZzlFdWFrdmkyTjhSZXdNeEZOWGQxYUUzVHpoa2hUWG1lcUFG?=
 =?utf-8?B?R3ZMV0k4MXZ0NUhBY2V5ZHlNUnlwK1hmcmM5VjJSczRiT3ZKVk1XUkZqK0NX?=
 =?utf-8?B?VUxHUWF2bmdBcVArWWlmZlBOc2R5V2pEWVBtV3kwQXJWQmNicTQxQlFRbkdZ?=
 =?utf-8?B?ZnE2aHFxdWwvUHhUTTljYXROOHpYRjBWcFNabUg1ajNDNUxTNVJaU1BtQmpx?=
 =?utf-8?B?aUNKZWN1ZzNrS1dZUGJEOEt4U1VtdzFHME5VOXlDSnhkc2RZenZhdzRJQWhy?=
 =?utf-8?B?bWxoTGhTc3RkUjRTWnFlemxpM3VKYUIyenFkd1BJTkpZSTlDbXJVRFFCc2Nw?=
 =?utf-8?B?d3JOcG1aL0dtMUw0TDZqaTdJV0NJZlg0K3lGWHZEWlkrUy9ZYnM4SmhQM3RZ?=
 =?utf-8?B?bnRlekRNSko5aDhrc2thUTNnNElBRzB4amR0WkVGU0o3Zk9zS0M4MFNVQkFk?=
 =?utf-8?B?amE5K2Z1cjRVNVF3S05TTW0vNDlKYXU3V0hMOTd6NlFETnYwL0Z6eTlBOTh2?=
 =?utf-8?B?TCsxQ24wTSswL0trNjR1eTBTMjJSdkNHd3Z3YnF3QnFTdFRHM0JvSEdadzVY?=
 =?utf-8?B?blQ1S2tYSmlrNTlVZnRKVUpITjlMNDN2S0FENVJWQ1crYjJJWndvVkFjNnhO?=
 =?utf-8?B?RklzbVlmc0k2Nk1XdXJrZllYcTlPUVB6RndsTFVmRm5FWVZhY1VtMUljQ2x6?=
 =?utf-8?B?NE1KbktXNmw0SUhYdUUvR3UrZFFnTURaWnR6WEJIdzRvU2hUTjBtVUdaQ2h1?=
 =?utf-8?B?aFAwd2QwVFN3eDFjbjJzNjdtYXpUNWdwMFlTTjJzVFZKSXI3WWJPaFVudlRi?=
 =?utf-8?B?aWNBdGhWQkZFbS95NUpCNlVoc1g3eW5JRHJQSWZEV0FFVWV4QjhoNHg3b3VB?=
 =?utf-8?B?d0VlT2daNUFDaVdEWEVuRTJ3aVViTDh0eHhFRUlSNjVLWmw1MmxGWSsvUzVX?=
 =?utf-8?B?ZC8xaDdBVlpna0VGZk0wS0xVbFRscWtURnI5eUhITTBBWno5OGFLc01YZ2tx?=
 =?utf-8?B?N1J0L25naStPQ0lxN2IyQ2NxOWZJSCtUSnVtYzdjU3d4bFlTM2VPcXRzY1Bw?=
 =?utf-8?B?S0FLemgxWGh2d0JOZDNaeFVaaXFaL1BWNXFHYXYrVlNrNjFDYVRTYllyOVVG?=
 =?utf-8?B?Nkg3WGFhYjJ0UXovUCtuQS9wZUYrdEdYbVVZWEMyb3BHazJMMXJNRXZjUTRM?=
 =?utf-8?B?S1NsSFFzWFhtQ2ZOcjhTbVJ3WlRacFJEaE4xWUc5SytpWEowaS9CbDlqK3lm?=
 =?utf-8?B?bnJtWUU1TDhISUJaS0hXMm9kcnEzNXdIUU1FVE1kNGZKN1RwM1JuMWdGalIv?=
 =?utf-8?B?MDJldng4U0NTMEFyU3pZcUE5eUhHV3h6R3dYeHdHTE0yeUVUVUFOb0tQKzFH?=
 =?utf-8?B?Znh3Wk5DS2RXQ3hUUWNOWTRNR0ZBRmF4emg3TTAzM0krYjdteXIwZmdsenUv?=
 =?utf-8?B?eHJzMG5BbzVsUEI0WUQrNFVnb0lpaS8xRm55MytUMDBPWEZxNVhlMnBCR3VM?=
 =?utf-8?B?dzhmdGU0M0t6anE5c2paQnluRHlxdEtMOGhlWGxQbjdQTnpCNnhSTXE4K2Q1?=
 =?utf-8?B?TldtY1duSWdGOEd3K1RHdkZvUWlKRzBiVlUrL2JCdHRwUUp6d2N6NzcwV0VN?=
 =?utf-8?B?dHB6cEN4V21mVnErVGxBZ21JeTZPMTNMSTNXR2Yvb0p0dUx3QVB4ZnhkUVNY?=
 =?utf-8?B?SjBPUndLa1lPVFZyRTVQQTVhTGcyVkFJY1VxZjhONC9PYWUwUEtHUmVhUW9Z?=
 =?utf-8?B?WXA3Tm1hMUZRY0wzYTBacUxxaFRFZDMzYjYwbW9Zd240T3N2NFRXSVBhQng5?=
 =?utf-8?B?eElYS3BDSW5OcTA3MUFQaERBVVlQTjE4WDBmS2JrMmhNYWR0c1NrY3ZTajFs?=
 =?utf-8?B?bURzUWxQTjkyeEVGS3FXVWlhK2F3NGgybmdnK2FxRXBqU3FyUjE4dThiWG05?=
 =?utf-8?B?alUxQ1V0V3FPYkx4YW81eGJEcjRhYVBQZVZlMWQ3a0pLcjUvcXAzNkpnVm00?=
 =?utf-8?B?anc1NkdjZ1I0UFU1dStLbVhTaEIzV0xnZEdrckV6eHhURVE3UFBydFVoeC91?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a489e4aa-bb73-469a-6937-08dc8ed65085
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:03:50.5775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4pOIzh05322g92y5NDL24HBLl7tG3b27Ykn16HBJc/zkSB2EjuhIKEaA9c6hfyh75FI03YnATP88fywER9h6/DHTpP9eU88TjOkDmTSwk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8270
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

Hi Jonas,

On 6/17/24 3:44 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-06-17 15:29, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 6/17/24 3:26 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 2024-06-17 15:10, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> In commit 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card
>>>> when booting from eMMC"), the spi1 bootph properties were mistakenly
>>>> removed meaning, so re-add them back to fix SPI-NOR flash not being
>>>> found in U-Boot pre-reloc as required for RK3399 Puma.
>>>
>>> Good catch, for TPL/SPL the bootph props is propagated, something that
>>> is not done for pre-reloc.
>>>
>>
>> Can you tell us a bit more about this? I know that the pinctrl nodes
>> marked for pre-reloc recursively apply the same to their parent, but
>> couldn't find anything similar for other subsystems for example. What
>> did I miss in my 5m search?
> 
> v2024.04-rc1 added support to propagate bootph props using fdtgrep for
> the u-boot-tpl/spl.dtb files, however pre-reloc the main u-boot.dtb (or
> possible the FDT included in FIT) that is not processed by fdtgrep.
> 
> fdtgrep: Allow propagating properties up to supernodes
> https://source.denx.de/u-boot/u-boot/-/commit/7a06cc2027c0169c462da63a68fa269c0d59a950
> 
> Makefile: Use the fdtgrep -u flag
> https://source.denx.de/u-boot/u-boot/-/commit/aca95282c1b72c41d8e72984b1dceb15f396b2f8
> 

Thanks for the pointers!

I'm wondering if we shouldn't do the same for U-Boot proper DTB as well?

i.e.

cmd_fdt_rm_props = cat $< | $(objtree)/tools/fdtgrep -r -O dtb - -o $@

to

cmd_fdt_rm_props = $(objtree)/tools/fdtgrep $(fdtgrep_props) -u  $< | 
$(objtree)/tools/fdtgrep -r -O dtb - -o $@

I assume we need to add a bunch more options though.

But that would make sense to me, the fact that there's a pre-reloc stage 
in U-Boot proper is already a bit odd (to me), but if we have something 
that behaves differently than the pre-reloc stage in earlier stages... 
I'm not sure this is a good idea?

While at it, I'm wondering if we didn't miss the removal of 
bootph-some-ram in cmd_fdtgrep for the VPL/SPL/TPL?

Additionally, we should be able to remove bootph-pre-sram and 
bootph-pre-ram in U-Boot proper DT since those only apply to non-U-Boot 
proper stages, don't you think?

Cheers,
Quentin
