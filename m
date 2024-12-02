Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E26D78316
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 12:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63843890BC;
	Mon,  2 Dec 2024 13:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J/6Jhnfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A23089100; Mon,  2 Dec 2024 13:53:42 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B83688FED
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 13:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MW/ZmXvBEbnM7AtixOEHXrFXIUWATZAn1Zx2DfRJNM7jKBkgcjix8EHHjc0FdkSSqtpOCv8aZxfart8XcXll6Hiv1QTarGeRevPSh2blsJpTlt/PMrSfd2IFeZo8yM4HXNNamnFlRfPDSBFOzljO5YsJe+RACCNTVFdQxBg+q297x/pS4dQ98OmGI5k9mbA/fdRzFDqZq6GlDd/ZyaWgLgFtPEI9MgSB47HP3PkGYnjifMwmTt/0Qm4poG+NF2VggJwot7ZKM62lOKApfmAvRRNYk/2aU6duwPEOKN6UJ1gF+olL9WBV1qjAXoE81YDG0d3HIJqRhYfujsTm1FzB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPKhGbccg83kFyrqrh6bKSaW5ZbkNMOB2kEJyRAVKgQ=;
 b=qKydnPxd9a6Ii1JVLSTRYj7/cetEtSaTCzPAe1sSTCPXs+GoancgKkW4FHu33rv9Y8uYxJjWHmto/HlvMk5J60H+XSaLVYgYiGaNZgRovD+9bjfrEjXKXHdWFr502uT88UJguJpngTKKbvI+dpu6xGQ35f7genGnn+BdhpMLf9c0k4eDB6hzt4kD/2z0AV4v7Z/QsuWAzjn29BRLkbd4tPDUIqTCWP4oljDvCyoNtOMy3L6pz32+sWaQTCHceajbdkt+RDpPyeMb5YXK2JCIh74L3p2sgoqI+cCPQtYzUKjCUEOFkN9vgjlXFOKcrrs91p7kLzup+xZsD9+Ea7O5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPKhGbccg83kFyrqrh6bKSaW5ZbkNMOB2kEJyRAVKgQ=;
 b=J/6Jhnfq7+tUIT7CaScRrRhbmVI9XtKMupqieQxrsqBnmkMOY5jYYOkfSSObdz8yHw42hR83qFg2Bn7ZXSaBZSfs6oHvSKsa0t7u4DuLKB3ZQJpNp3Ldano4j8ASP7dn3iCCo2rN2AFuuPdwOGqlpyiLpc1h0+BTprq5DchyDow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VE1PR04MB7326.eurprd04.prod.outlook.com (2603:10a6:800:1b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 12:53:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 12:53:32 +0000
Message-ID: <a38319c5-7981-447b-9075-d56151bd8c71@cherry.de>
Date: Mon, 2 Dec 2024 13:53:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: coolpi: Fix document style
To: Andy Yan <andyshrk@163.com>, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de
References: <20241202120355.1132320-1-andyshrk@163.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241202120355.1132320-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VE1PR04MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bf437f-f0f9-4d07-0939-08dd12d053ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWEvUGF4N1NWNHdmd0YzbENma29wd3d6TGYvazJkNlFIaTZSblR5NnJuc2pl?=
 =?utf-8?B?aFN2WWVwMVpibllyVTZwMVp5aDkxbmVLZFo2QURYTG9sVXZISHBmYlFGQm9Z?=
 =?utf-8?B?eUp4MXljeHRmMExJQ1Y5SGQxUWFuSFdoK3QzNlN0MzN6S2VDcXNDUk12a2Fu?=
 =?utf-8?B?RnRhUXdrTlZOb3drM1R2ZVNHbEQrTWxqaU9EdWVtdVFwUFM2Y3h1OWFBS3BF?=
 =?utf-8?B?NUR0V0lFclJMQ01PdmZVcXNGekhEanJkcEV2a0pSQUUvSTBoajAzVGRxY09M?=
 =?utf-8?B?dTBUT2ZXRk5NR3hSUGZISS9obE04QjZjSWhrWDMzdUEzcmJwV2hZd253TUNk?=
 =?utf-8?B?RDJmcTlkRDZXQ3RPYWtiWEF0Z2xhQmwwQ3hTa2kwU1dXb0ViekFjdXkrQ3pz?=
 =?utf-8?B?UGI4cHVSQkZoTXYrY0dCYmpCcHc1K1N2Q0pNeFhNSmFqSzkxWXhmVkxhNTZT?=
 =?utf-8?B?NzB0dFVjdXUvOUdkYW1PTXU0anNhZ0JyWGs0ZFFQSmZ3ZXJ0ajFZVUhMaVlL?=
 =?utf-8?B?T1ZsclRzV0wzcHRFN1hpNEdMcTA3SkhiczRuSWRXUzdPVEV3eHJEemVDUndz?=
 =?utf-8?B?RENIb1l3UHpBanczNnBySURzSTVMblA4bkxPZTF0dTQrdzFiMnRLOTBmeVp1?=
 =?utf-8?B?Y0s1cHhhWGhVYVpQZDNGZEx1OFNHbzM0dmtIZkczdmthTU1odEtxWU1YTVYw?=
 =?utf-8?B?Q3QxUGw4UTBSRTQ0U1V3UEtjYlpMYmczWFRiY3M3cXhoN2t4MHdqMENPM0Mx?=
 =?utf-8?B?WjRqR3pSN3dPZUdzbk9FcFBlU1Q4eU5NTytVcEo1MUttKzNFa1kvenFNL3dn?=
 =?utf-8?B?b3htYU9BZmlVUjZWd1Nyc2VveE1rQ0IvSGhaRk5wNXNIMkhFRkg0ek1tUCsw?=
 =?utf-8?B?NS83RitaUXllOTRjOXl1SC9CK2RBM0hVQXZoQkdVUjBXRWNReG9TdGNReEx1?=
 =?utf-8?B?d2RyZU1VYjlRbzBLbitPcXd2MXFrdDZhcDlra2FlUU05bGNkZWVkZ0tJU1FJ?=
 =?utf-8?B?SHAwV0YrZmY4ZCtOWjJSTnBYSW8zRWtCdVZzdnQ5dEpSK2VkTGZORGt5RkEw?=
 =?utf-8?B?N0JHRWh2Wi9SbDdiUzZwZFRiTVF2ZzFvVTFMN2l1N2YvaXYzNTVQVXdGZ09C?=
 =?utf-8?B?bDVBZkUrL1ZEamE1NWhSV0prTVpxS2VhNmNjY1JiRnpvdlJ6bjNKbkxNa1pz?=
 =?utf-8?B?a3N4ek1mUllpL1g4eDVsUmkrQlZCdlQzcGVHK0E3dlU5M2pqUUZUUi9tVUJR?=
 =?utf-8?B?dUk0MWlkMXMzYWhxb3BpalNXRlYzaCtHdHM2Q1NjZi80SmRmVFAwSUprcUJF?=
 =?utf-8?B?MEN3R1Z2aE9VNTJldE1QckRHaFRYNXo3YytwaU1WY3hSd0lhN25ZZ0l4M21M?=
 =?utf-8?B?dythaklEQ05OL3ZwNzQzdjdGYjFkcWJFN1FxZWRYUUd3NFlzZjhJc2FtSE9p?=
 =?utf-8?B?cnRIR05VMVlNZWxGWWxYMmtaQVBTUnYvWU1XU0NYcCtQTFpoSXZONTBtUTEz?=
 =?utf-8?B?cHgrR09XRWMxRVNNMFp3ZGN1S2sxWUlXMVMwYzV5UlpBSmFLOENQTERlMUpz?=
 =?utf-8?B?TGVhM2ZDbEVyOWpHbllETldDbmtaUnJGbnQ5NDhQTDJrZlVIc292d2FPVEZt?=
 =?utf-8?B?a0p2TFdwdGx6dkQwYWtjL1pCQjBJNVlYYjN0dDRqcEtHQ3c4K1ZPUThGL2N6?=
 =?utf-8?B?UVlvczdkdnFjdGpqSEZieHlqeGFFSTFxbWpObzlEb1RZRWdLcmhXNGpDbVlW?=
 =?utf-8?B?WGlJTktlU2I3Y3hxTklDR21YVExkM0xGTHpZTys5YjlOVkdGN011aUtqdVBG?=
 =?utf-8?B?a0czUUVyT3RjOUtiMk4zUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm9tNit2dnhCVkFCRUNOeXNETzE4NGg3Z0FCRzZrTW1CZS8xdEU5a1FYZ1pH?=
 =?utf-8?B?LytmdXp3QkIrMmg5eUxReXRFUi9pbXdjOXV5RTVLVi8vYXpqYnFZaXJsNjkw?=
 =?utf-8?B?bnc5dE9lTUpNa3ZNN3JDVytQMERSbXBIY1c2c0xMclJvak9iYzFvME41dWpN?=
 =?utf-8?B?S0xBbG9CWWU4Z1ZxRXBvbFFkWWhvT0RoSVNYbzJwdGRNd3kxZXFjRTJacWJ2?=
 =?utf-8?B?SzAwdzI4WkpzRDl0N2EyQm9EMmZ5dU5RajVIKzc5N0tFeWR1L2xaL3hFMjZI?=
 =?utf-8?B?VVMvN0dkZVM0Sng1N2hJTlhESWxMOHdtRVdBTHh0T2dvMlduZG4wU2NrdTVV?=
 =?utf-8?B?Qm9SVDRCMVl5cUN2dFFUYVd3dTkxeEEzeVF5bEtzY1h3SFpUUWtyOVZ0VTc1?=
 =?utf-8?B?RXBHSmNjNzRjZllqZGpha1hFdnVBRUI0dUEyb1V6N1IrWXJOVDJLQjZZZjJ6?=
 =?utf-8?B?Skx1elJ6UWMrWUFQUmhBZkYrL2x2YzViNVpyRVVXTzRqbXMrNFg5YUN3cUtX?=
 =?utf-8?B?VDNLQ2Z6MndIelMvclBFUUxOWXBiakdqREhPSDI1bGVuK28wcUFGOWgyNTZt?=
 =?utf-8?B?L1dmc1k2SHU1Ymk4MEZnd1lXVTBRS2JScXNOUStxeEJwSkgrQmF2V1ZLK0dO?=
 =?utf-8?B?dUlQUmZ1RWdCV1JrS2wrYVJQaytXQllkclR4a0p1MHZtaXdSZUlmV3BTTnpr?=
 =?utf-8?B?QlVpTWY3aE9MK284NTFXcForMisra3hhMFEzRWliMy9qRlVFR0t4TmFZS0Zu?=
 =?utf-8?B?Mks4QWd0d1NsU0hBcnptQjVDMHRrV0ZPaHZsWE4vbG5QYnFRL0UzbExXS0Rq?=
 =?utf-8?B?cnZ6Y3pMNDBFK0VCa1p1b2o4OUN6ZXdna0QvMWZ1aHhsTXhSUlhvTGpHaVJa?=
 =?utf-8?B?bWx3cEpiM3BhbUt2K0ZFUDhlSTZHclA1OXE1RllOWVFvVWtmNXhzR3ZmZGFo?=
 =?utf-8?B?UnNmS2l2dEw5VlVZcURSWGF5dlc3OUI1NGFJdjVIYzhGYUZSN0c3a1hGNlIv?=
 =?utf-8?B?VUFFMHlxbDRsSGVFNnd1RmdvNjRIRmJpK0EzVTMwS0c2U3VOYTBpcENPRzkz?=
 =?utf-8?B?TERpMDRjRW1CVnZZUDdmUHFtVm5Dckx6TDNpWGI3dkFXREJoSmtzcVVHc0lR?=
 =?utf-8?B?dzNDTE91VWp1UWZSRFJKUUM0V2Z4clJiSzFwRjA0Si9LdCs1c2xwVi9CWXE0?=
 =?utf-8?B?dFpEQ0ZwSkd4enJDaEZYcGIvaEREMkc2aHpNZnNuY1J0NVpwR2kvUjF2STNm?=
 =?utf-8?B?NVZUcThBYkc1dzZQU1c3NW81dk0xU1loWXF2WWdOTTF5MlluemtjZHhDbDcv?=
 =?utf-8?B?MDRxbGVvaGpza1MvQ2JqdkkxTWYvcmpqeWp4RjdGVmdpN1Q4amlXYW5CQ0Nn?=
 =?utf-8?B?UWM4ZGhMYzJPSEpZaDFyVnIzcmpKbmhrd1NZeG1jZ3RvRnU2OFpFZ1JDS1pv?=
 =?utf-8?B?aGRFYU9GMFE2Ym5xMTU2NHB1MFZVT2oxUDF0NytJZzNFWUlKYVRseXE1Qk5P?=
 =?utf-8?B?eUxidUdiM1laQzhnRVlJcDhmUzBLMzl0UFZ0VDR4ODA5NVl1Y2dLdlAxbmQ2?=
 =?utf-8?B?eDR3V0l5WmloRmpHYTZxcHNZUGlPbHZiZjk5dUwwWE5Ha3Boblp5TlplYjVE?=
 =?utf-8?B?aWNCb1dvSEdQV1ZkYVk5YzhuOTRaQThwUExmQ3dleUJCZnErcEl1Vm5xQjUr?=
 =?utf-8?B?ODJIR1I2ZnllUHZrQTlTd1dHNEp5SUppRnhCdUJPSkpJcXMvZVVvdW92akgw?=
 =?utf-8?B?N1lqOXlhNnpIU0pSYzF4UDlpdzQ1cFB3Y0pkS1JueVRoU0FIck1wazBicENo?=
 =?utf-8?B?bU8wZXpLdDFQTHFFNTVGWk5IRVVlUnptc1doajd0aU9OcnJ0QjlycnI3U1Ft?=
 =?utf-8?B?RkxSMTdOVndEVlhiU0EwajRCK1RFaUM4aS9aTmQxMi9zZXBlczh4WldVUW81?=
 =?utf-8?B?T1dxQWFqRjRtWjhmTHlLL2lURGZNK2xyYUtVVGx5MUh6cWFCQ21xT3FWVFJO?=
 =?utf-8?B?akF1dXg2ejBVcDFEbEJWLzY0VWQxUnBWTnRRL1A1V0lKMlI0TkwzY0NEbWhF?=
 =?utf-8?B?SXRWK1E2Qmo1YzRvZjFGSi8zNjE3NGErcnlIdVBmalA4d2lSYWpzMFNHV2R4?=
 =?utf-8?B?MHlldnZDTng1azVJVXNGU3hIUmRnbm5ucWJ3a2xsVG5DRGNwamlQODBOVGg1?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bf437f-f0f9-4d07-0939-08dd12d053ca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 12:53:32.6428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyGMhcMs8Ovd2nFSTdc5Q9mktMgTL4kXKDBmUwhJT7jgBLYgf2FsHruWu+T0tbxrLfOEjQqYkf+rhKZr9RgC0q10cF67+E63tMcZ78GCnAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7326
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

Hi Andy,

On 12/2/24 1:03 PM, Andy Yan wrote:
> Add a blank line after title "Specification:" to
> make it render correctly html.
> 
> And also remove the useless > in bash code block.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
