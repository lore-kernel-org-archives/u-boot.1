Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E350FD8FCC
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 15:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708CA83D8A;
	Thu, 26 Feb 2026 16:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="kOUbyWtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C70DE83AA9; Thu, 26 Feb 2026 16:39:20 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E01683E83
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 16:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azpEWNvDZYYAptfdQWUWm2yqPwcA3QqbhVtXu+3iYl3u7XlQCb4MkTfZKo9WKzqmSIwHUnzx8daB9qvj5/t0CNt0yv1mbYBWBG+ffGG1sp0aioUYq75qwpje11Wfk6k+25kYhg1KcOOQy3QD/xeH4VLSX7L8mzAmik923qLJG9ywpATmGegfL0vuFnPD/iXHk1epgK+6jw6ZkrbdjVt10itgyiVfqDKJHkpRxOuVSBcU7kW2bKsy8fRZV97q+vIrOwQSZ0lCpOChq4MyKycZO3lm6X1A6nXCbl+rcQ29H+fGUVOPzc/6tHLPU/m3aUPk0hdrkowoetEKuNnH8URWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhA43ireom8MiSOM2Eo0p0yX4RHV5bd0RFC8ICSo2c8=;
 b=m3ZenZtE3u7m+tHM3iuf/ohszaIRpwQk8CtL/iIauSpuXJ+J+ypJ11MSaKHhmt6QaKVhXmXGQLqsXk+aZCpEpq1MwhmfOfWz22Px5+SYmIN25nVOIbYM0TeEmaR80ubJt+LFUJttCZGldQXh08fnPtqGUAKQrEo0i/XidZ94cwCU1eOlXnNmY1y+7fHm9Zuw1XQ8jElmp8HUkDLKYhc3RbsMIgGFn0jjM1ZLEZwO8kbf8KF+e3i5EeQ8xT0PffPY22+2TyFQd1JiSsBt3riEpIDvcgaopZ+KEqjPsCBQEESKBHZ5WhvjVsY8BxvaOGLHkZJhhcEMYnnsV1eDM7ps/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhA43ireom8MiSOM2Eo0p0yX4RHV5bd0RFC8ICSo2c8=;
 b=kOUbyWtlz27PdsF6eF8gwm0Uru4q3/J+DmxEm7Nerf6TuYkZ0FiNZoTFX1bisB7RNsL8LUIOCOVSZyzXrW9CThgqNvPml0Elbx19SYb/9MYy6br1r/LYXpBzmHn+rAFANtCqGDAvYUbmB2AMH1cGEbUyZYJtR02YXlwEVQNY5EPzYFVDRytqCmN4n6q67XsMvMGwCVqmmj2olAkTzJp0lKSNF26o8ylvvbJuFM2gmS/hVgJArWucEsFWhDXpBCiEnJK2VVwlUuz4sWw7phV2QY1amg+qeifh3S3ffVdPqInTZzwDe9Lmf1tiH3XuR+XqPgU867LCx2d85pU+mKPnTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com (2603:10a6:20b:578::22)
 by DB9PR08MB8505.eurprd08.prod.outlook.com (2603:10a6:10:3d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 15:39:17 +0000
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778]) by AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 15:39:17 +0000
Message-ID: <97990c53-054c-42fa-94c5-3ea3ceda2bf0@weidmueller.com>
Date: Thu, 26 Feb 2026 16:39:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] test: fs_helper: Drop the size_gran argument
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
References: <20260225162357.3449937-1-sjg@chromium.org>
 <20260225162357.3449937-4-sjg@chromium.org>
From: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
In-Reply-To: <20260225162357.3449937-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To AS2PR08MB9199.eurprd08.prod.outlook.com
 (2603:10a6:20b:578::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB9199:EE_|DB9PR08MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c7416c-a703-4be9-df30-08de754d3368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: gABMPQNOHx/XLDoSOWCU+Po+PuKYv5n7lZLQeP/zQBwMASAoGc/IIIxF7u3eKhc04uxtik31IqB3rvi1sWuqIHxjNlWr92tTvfzGfMHxoX9mjC4NlzSDeZaSy8ISFqTThkvxrQ8486/6sDYGk++B64o12GskTAyti6RVLN0xAqphMAxgyD7nWg/9J7ydnUugf4YZEEk6lBaEQkhb0sXZBr9JF3MSdmovVYtYxxHumT+e7T94j2zMUze5SedPc1Tb8De3LA/iJ8ZbTG0+pH3Ic0U7QvBFiO0vU9DerL6d4ep2V0oNf4kkr/mAI1ZAvrjYsp4DAbLiXRhAt99WkAjsK5pxUe1IfrNdSxmaoBoNDRr39nesoZeapusuYGhO8PQm3nB83gSkPfayMx4HakNDD/e2uwhI2qzGCBeCQUDAXOLcRfqCvRCGqxc+cAcX9HyGZnDUKCEMWk+eHvtBav6kinelnzEn19eypoWwsb2CFj35OU7aPYU+p4QmACO8cWc2nQZ9bmnphJ6m+F5W9IqgZO9Jsmoz5ra0RQ0YJYnDR1qce4tpYGEpefqTtJI/lyUiDP0k7U/Qmy8RYA08qlTw0ztE3sfD7EQrJvoK3KATHRkPvd7XcdGoPj35Q0Hg7xKkV/qpbE9YE07r+nP793EO9wETU/EvFmIQggSGRrMG1BUoGe9krUH+9ImSWiVYiqfUVH39NoeUzdvhrKH8V/8p86wF/STsE2fUJQADcoqXwO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB9199.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2d4bHdCU3lXdzJGajdZaXFxZ3ZhYk94NFNlRjV3WnZmcUozVEZDZlhHRzcz?=
 =?utf-8?B?V0VLeUdhZXZEMG5CazNkLzVPWGswWjZMMStXK0p1UVQvZE5UNWhLV1RIMkJy?=
 =?utf-8?B?a3N5RjFPSFZ2ZzJHRklOZlFBald2Z0dwL2JCTFV3WWorMHJsL3hRckxoN1hX?=
 =?utf-8?B?Q1FlaUpBNTJmcHNOTzdVYTVnQ3d5R0xGZzlLVFlXSXh1dVNmSmltVVEzaENF?=
 =?utf-8?B?QmJDcUYyZWhNdmpPZm1FR0RYTEZTRC9CTVd0NURMTVlmbXNGZkpPb0FDKzkr?=
 =?utf-8?B?akFUL2ZPNFlBQXdxLzR6QzNFQzdOaGVQSFhFbjJCUkhkZmY2VHN6MHdmZU0z?=
 =?utf-8?B?RGhjSU5CQ3VKWC9wSmliUTF0U0hsaDlhT01ZSFF0SC9qNmNmTkFxSEhXaGRJ?=
 =?utf-8?B?NHJuMGZPUTkrK2daanZKVWRUOWtVNnRabG0ycnZUcHd2Ykg1QXJoRlVmYjJk?=
 =?utf-8?B?b0ZPalVGV2kydENabVhRMGlCQkZzemZaSWxJdEgvSkd0c2FTSEFsSjgyN005?=
 =?utf-8?B?MlUyeG9NOERRVnJEbG1wOXU3RGJsc2NjcHNXNmpyc0RKaVc2SUVYK0tCOXl5?=
 =?utf-8?B?Wmo4Q211QVA4K2hPeWVRcFVPSURVVHk0bGJSZ2tGeitXMERRQTEwQ1FsN0pK?=
 =?utf-8?B?dTFqZHFRZ2tSSmNaUk1wYmVwZURlc0xxWW5sdHowZVRBOGV6RDVxMFZrRzVh?=
 =?utf-8?B?TFZDbmVxQ2xaRGY4b1RScGE4VHJRNkIzODBmM3Z1TWdpTDJENE8yRnRqSmFm?=
 =?utf-8?B?RlhPbUlndnRaS3lRZU55anpjUkR4MjVUanNRUTJPMDZDTXpubGpGQ1NwTnAr?=
 =?utf-8?B?Q1N0WHQ1b0NZTjB4cjJxanNoOTZtV1R0WEJWRC9vVVl4QlRhUnZtL012amNU?=
 =?utf-8?B?U3pqT2VTQ0doYnU3UGV2ZkhlbTFKSlovREZnK1FOK2I5b2RZMklKb1BkYmpp?=
 =?utf-8?B?ckdtdnFtTzJKRkR6eHN3YWdBZXJPVGR2STlRNmY3dXRkai9VazAvYTN4QjJn?=
 =?utf-8?B?SnFFWWc2RGdSdEVtSWI5OVg2L1NBdjlML2EvU28zUytuWENvSGRNWUllUWVP?=
 =?utf-8?B?WS9nSEpHZlJ3YXlrd1VxbmlPbEpneThYUlkrQjE1SzVPNnlobksxWnpqa25n?=
 =?utf-8?B?WlA5TU9ZU1dLY3lrWlJCSkZtdDZHZmsrMEhZbkJQUDAwRkVUS3BhdHZ4dVV1?=
 =?utf-8?B?bEhjRmRjZzRocW1sWDhuNUpNWXdiNnEwWU00M1dZOFBoSlA0VnphK05zM1BG?=
 =?utf-8?B?U1hZNlFFVWJwZ0dWL2xDVDVyZmpZZmJKbERLS0hMR0srSFZZQmRXTFJ0WE50?=
 =?utf-8?B?S3RWK3pwdzJkSTZJYTI1YTQ4QkVKRUFSS08zRkowQjhjcEtBZ2ZKTUhNTEZl?=
 =?utf-8?B?YjF4Z01HbGlEOVBtaDR4TS8yb1ljVzc5TlBkNmkxOXNLNmVlaTRIV3pDQnN3?=
 =?utf-8?B?ZHkrdlhJR3JZa09oZDd4bjZ1Z0U1RlNaSXB2OHhnYnptdHZoZldhYWg1TXBE?=
 =?utf-8?B?bGdQbDdScDVjcWUxTVZldmN4UVA5Q2NlbDV5QlJpbzZnOHdKUVVlZlFYUjhp?=
 =?utf-8?B?cHB2MWFKeDh5MG1FK25IZVNCK3B5a1NuRi9TRGt0TUtJZ1NmWEpGTGhiNk02?=
 =?utf-8?B?UFdEa3ZXNkpXRmlFRDgrUFluUjNRaUd1bjVEVEQyV25vdXRlamZremwycDQ3?=
 =?utf-8?B?MTN6eEEzOE9DL3ppei9aRk5CWmV4Y2dJa3JvcnVwMGNVNmdSMHNVenBxSkFh?=
 =?utf-8?B?YWNLckhqUDZNYnZ5eWw5SFBzTXU2amNlV0ZXZktFVzBnYTFyQTN2Z2V4RGFq?=
 =?utf-8?B?Y0hZc3EvMDVKS0F6ZEJJT2UyaHYvRlA0YUd1VSsvUUl3amdsV09rQS9CYzJM?=
 =?utf-8?B?am93TEVqSTBpdWt0elF3ZGxZUStzNmhyd090Qy9vcitQdDZtUVUycjFlNFFy?=
 =?utf-8?B?NSs3dHJNaU1kanJEOXhpREtENzF4L2RoTHovcENpT21oaTVjTzU1SjB2QU1C?=
 =?utf-8?B?REx6UFBnb1VhTmNLaTV3TEU5UTRpaEY5c0tkS2loalAwRG04N3pKSjJGRE14?=
 =?utf-8?B?UXE5OVYxQ2tBRTlNNW4yMVQrNnRvRWlTQk9JQTVLTVFLc2dmUXVjOTB0WFFL?=
 =?utf-8?B?Z3ZLQUMrdzcwV0k3SGptRkdTYmRHM3daWDdEdHJuR25FQ3Z4OEVFeWF1MVUv?=
 =?utf-8?B?T0MrQ3hiUnB3d1hBaUY2cVFhWklnUDUzOE9iV3F1dEV6QUZOdkhQeHZnVTJp?=
 =?utf-8?B?TzZqOHVQaDBuY2JDSWh5R213eGt5VTVkZXFGa3lXRXBjMGwrbE4vREhJVkN4?=
 =?utf-8?B?VHdpNlVHTEc4RWxMTUtJWG95c1pIYVQzSHhMTGxXS0hUVHYwelBURzMwdGJQ?=
 =?utf-8?Q?SEM+hjFT/pbmjw2bglWRWMUpkO0+Y6aRI5daf?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c7416c-a703-4be9-df30-08de754d3368
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9199.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:39:16.9846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/M/o9lorB4MWYtHHyT5yNcutA3+DnkEXL37W+5jPRvZ0ozd1gY/zSUfnuspTUQE57ZUZbUmESccMFb3QLYWuCNwQUfNGRHn/Og6WA39gOpOO7kQd7sozgmJSBTTlOs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8505
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



On 2/25/2026 5:23 PM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Nothing uses this argument, so make it a constant for now.
> 
> Also fix a pylint warning when checking for vfat/exfat.
> 
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Christian Taedcke <christian.taedcke@weidmueller.com>

-- 
Christian Taedcke


