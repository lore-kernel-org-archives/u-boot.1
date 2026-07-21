Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90403C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 09:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 407934086F;
	Tue, 21 Jul 2026 09:22:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TaNoUSotRkeT; Tue, 21 Jul 2026 09:22:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DD754083C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784625762;
	bh=A1QjenaKOMjws6VUStDCiFGGSjKvzVflDr5ZRGxqyuA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=E9cY25evAf5JCoVYR7g2TGs0NbrImlbEY1iPxB1icNRjcfq4Q017nO6815/ILn534
	 NV/J2sso60DhGiC4gxKDCIMKKZEgjPdTWx/B8tjxQceMIucPAs9YqJGoWUcW5MA+1a
	 cY/DMVbSt4xcigU5zIunNvhwlmyZw+TnZP6kEIIXxR5eRw45gUHdl76QWSiJQbfZiL
	 2Rq2o5bz775kDlFiNPXKYmCjzzXw39aPLkZRJ+F8Hf4GaEYBQB+aXuBKGxHfHvEFMl
	 rbG8ZrBzL1UusDWtcCixZJBT52x7iyg0hcGYWsDbFN1lGj8e1r3I4zwK8cSzRfiKiW
	 vehYsWxlhWVfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DD754083C;
	Tue, 21 Jul 2026 09:22:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83501FCE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6944F4083C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgUnFTEqBAbG for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 09:22:39 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5DE16407D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DE16407D1
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DE16407D1
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:22:38 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4E0844F6; Tue, 21 Jul 2026 11:22:37 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DFE803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 11:22:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSGwn9Znq2JpmPGpdjMSOZ4LHhGGZt0ypo7NVkutdjryfX6S1rHpJDCR59vI0WLvMCK+grNniKtizpgjVuuOMlVYG469QpE9/PCj8KzV9T3S9jZYeOQ/P8SgdSXHYj6s+XsoJUmfm9BRCz0jgXhS2qvyEHsxgemkljW3HUL1Z7WPVRUb9gaUIGZpmzOinjK/hUl853K1VWWKTcs6x2j7EcfQsUdUYHWrBp29UZfIF3Xh+EkWcyk8rgeEMl20ngmEiLmc6gs4yO9i5mH9tg6EuveWp8vcR6rQm5D+K4kE+8aSGt1pw7Z8VL2Hk/DFP4MTGx3RV2Xttjg0PM0EMmv20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1QjenaKOMjws6VUStDCiFGGSjKvzVflDr5ZRGxqyuA=;
 b=X6ev7ZHLXLKPK3/FlL6Hh9H5nLfugrmSeYCHYeD1Dz7IE1keppRQID0hpl6BrJ1oaWEGmx9c2zUkx1ipbZQxllkOwYGDxx07B4VkaQrVNwWQn1mzeys1HqcpffNgxMEqqZHELu841xGaI0QlTkweLUkVWCNjH2fJJbOLWZXpW5PEcYYO3WzvTfh2t9YwccY1pEwyaI109ombcmKo4gk/HmLJXumOa0oxpvuu8mybzxhqqCqukpAV2yZeSUw7nj96A7JqjNcHmH9gxFSskxXmjhJHz8hER3zMrmBNE6e3LUcpspM8jLjj5oJ9d2nvt9Zr6vMMkJ50PVzXN09hyGo2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB7843.eurprd04.prod.outlook.com (2603:10a6:20b:235::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 09:22:32 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 09:22:32 +0000
Message-ID: <689633e0-6d81-4ae7-a25f-b2ab29f972a4@cherry.de>
Date: Tue, 21 Jul 2026 11:22:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] Kconfig: Depend on correct xPL symbol
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-8-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260708220540.3368825-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B9D.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::635) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ef0997-b899-4fb7-3908-08dee70997dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: v7hYH/XtzJa8HLo41okQ+oCqwljmgyKr0jqjYWU08xjpkZb8MCfFDpzwO7QLC9Y7IREeqghNN0LR3eoDOKwovaDsUsAG+iED8HG/7V8zCRY7zsPmoip0yoQy66nlYt0QKk70n0QR2QTptINnyHzkQy3Uk48nbrfVawQfb5oyA67oRfwKpDfy+lyaQV8I5lJzlolrP+SvfGV89Q/g8YxKQwkjokPPwCk71U44CjT6Rkafxd3A1vBgoBRExjZ/BFvOG4veS3eukzHlWyE+S+FP5YtU80KwY0aHlxjzP8dcNGzdZ66JCXMy7GNEWLy1+LPie4h8t+nU/npqsXuufr4sHOhqQDaYbl8wYmqfvuQrK8cBOv1LQh1DqnweRssYAT5R8XbKTQKrUtIGWcpIObMq8b+QNtLdRK+Xt48lDagGAnP6/Izen1fBVf3cqdJmsacaflCN4k9qF0Kag7vTeZ4Eo/ifahZUHAi2dADX3Yt0TVgcKKeK3LbQ7cwkdzovKkmKkuANm/0UTuOSTIT0YmngZ5u5bfdjpb9yas0Te/7EM/cI5R02BgQ5YzSQvLEjkXyMXZk8G/ucNzoM8PVu2chxLw26UN9wU5Pz8qkl0wHqnOjcId/xrB0+opwoVra55NloDYY9yoUHJyKwAicSmE1fW5QQQVGa5t1AsJvahg7YZKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTNXNDFBVGo0MUZEQTJmaDRiYVFUQmtZVEtGMzNSZlhhcjdRSWptekMzSnBh?=
 =?utf-8?B?VVZlN1hUUHJyUmVYT1NiOUtkTG5SeTU5MStPUlFaZ1VzdGxVOHV5MzJNRzVa?=
 =?utf-8?B?cEo2MzM1TFZPVWNoN2R2TWZydWN5VzRqUVIydHZZYjZabFBNWG1wcVVIMXlp?=
 =?utf-8?B?em9TN21GS1BrRTdMMnlJTTBQa3E3OEdpU2hnN1hxOWFBWGVWNVNNOGN1aThV?=
 =?utf-8?B?QXhjTlB0eDBzbFdPVE45UnBzcjFaVUtndVRPYlNGR1hiNmlIL21GQmUrTFIy?=
 =?utf-8?B?MzlGUWhkbGFHRzNxRVArdlkyYnFVNjB0b0JnVDZFSGdLcGtrdlkyL3o2NXdn?=
 =?utf-8?B?MlltSzRiVXo3a3g3NlAxcUNweXFKQitDZk1YUEc5YVBNRHZNTlp6ZWpOYVcr?=
 =?utf-8?B?UnpOeWFENlJock45NUpMNnpmb1dvM0pMaVBXWWo2cnBIK0NRL2JHMmZRc0Vp?=
 =?utf-8?B?dUMxUnEyK3VyOUdub0daeTRlbDk5MjBlb0FSVFZEM2ZKU1pWUXFnUUQ2ZEVn?=
 =?utf-8?B?VExxeWFGUzh0REJzRTVDZ2tnVGVLTTJPRTdTano4clhSRTJCQisrTUxzNVlD?=
 =?utf-8?B?UXdRSitRbnl2NFhDQmJvbU1YYTNQRUlLKzArbUVOWW1oQTd2N0NtMVVPMHRn?=
 =?utf-8?B?ZDVNK29QbW5uNGxjZWtzQTl4TVF3V1FRUEdvVW5ob3Z2QjltK1dMMDVVMWxC?=
 =?utf-8?B?U29oemp6WUlNcDFWKy9nYTFQTDNveHd6QWNLNUtMekxxRkZsWHZ2UTBhbGpH?=
 =?utf-8?B?Vm9sV0VVYlhrS2k1TFg1bGMweHBsN1YzbW1hNjZOU0JGZENlT1V1Nmc3Rmtv?=
 =?utf-8?B?ZVJuelkrcWl1eWpsK0NXaVhoNjJnMnQ2eTFMMjI0TUNITzJnYUFlbEtJRVpL?=
 =?utf-8?B?eGdldE1nMzNYY0ZYSzhSd1I5dElwVjlpTVJobDEwdTNSM25vYnZDNjV0SDVL?=
 =?utf-8?B?RkU3ZnZQUzIwS05teDNwTDlrNitPWGxRN0JwT0FVclVOdUc2V1hJWVp0M0NG?=
 =?utf-8?B?OFg0UmEyMWk3K1VDZmtRMGdyNmRhanJ2QThPZ3pVb3hvc2RQQU5HS2swU0pM?=
 =?utf-8?B?c013WEg2SWE2OGdxYWdSTS81MGdxRjdmM21lVFpqazUxTFlId2Q5VUgwQ2Nt?=
 =?utf-8?B?c3FIUXJFcHBXSHdJa2pWU2c0ZG16aTY2M1JrcEhJbEdkS0RXWWV3NStYQjZ3?=
 =?utf-8?B?OFl1M1B5bGdyczNkS1QwcWd1dnNrRWlMaXRSSG5RM01sU0NHdU95cDNnd2tn?=
 =?utf-8?B?TDROMUdOUGlGUExWZXlaMnh5dWRKUHJMNjJOQjYxRTZ2SDEzWkx5N3I4WDcy?=
 =?utf-8?B?T3ZTM2FQT1ZzSlJCSk1pR2xYWXYvVlYrbGtwQ0VNeldzN1BGMFh1enFreWlu?=
 =?utf-8?B?VFZFNENJVExmaUxFeHhEaFMxYmMyMlU1UWg3SE8wOU5mdXJJbDZCK0hvWXVP?=
 =?utf-8?B?NTl5NUVOL1E2NWhZMlM5azNpOHBwclhjb1lZZFhxK0RUdFBaLzZOS0M0ajRj?=
 =?utf-8?B?cjgzMWRIaDArNW9uVWdqZFZLMS9QQ2kvZlBLNkVtcTZqbW4wUVlvRmpkWlpE?=
 =?utf-8?B?aVNkUmFUMTd1UTJid2VPRk5DTTFmNS83VWZ4TFU4MTdLQUNuR1BTOVZVMmps?=
 =?utf-8?B?VS9CMXpZTlFxaVU5dTAvdGlLeW1uMVFvaDVBRVFCSWRLdTFLVm5IY3d1ZU94?=
 =?utf-8?B?YW9ack5COHlBeUVrTjRKV1hOdUpucjNEZzdUaWoxamNjVzc2MmlNMmdRckRB?=
 =?utf-8?B?djVmR21yOG10ZDQrNC8yK0ZQcHBuaXFxblNxdVl3eWNEREZMaW1JcWlVQTdk?=
 =?utf-8?B?ek9OMTZIWXQ1OTU3NUdaeVhqNm5XWlFleEdsT0tINjZWcDB5eERLYW40a0lk?=
 =?utf-8?B?M3BMeFNRMmp3WC9LZlYwamtjMXBGaDNVblNhbWlocFpxT2ZOcGtBVWxoaVNH?=
 =?utf-8?B?Q284UjJ0ZE5QcEpDOThoQ21SQnBlVVk4QlJYRVQ0Q0ljc2dVQTRYdnpsNUtI?=
 =?utf-8?B?Z3R1MzNhaTNlcDlnczFjODBmdnpja3lyVnVKam9ZcllQSDRGeVFpZk5rbFJ6?=
 =?utf-8?B?ZmR4UFo1MDJSeXN5WnZ4RmtaV3lJVzlUS0VBVnQ5dkZNTXljTFFqSTNBTVJO?=
 =?utf-8?B?Y1c4T2tkMnhFYnV3OGJOWGp2aExQaUIxY1JsR3pmTEhCbFhRVG9ocTVsZnds?=
 =?utf-8?B?ZnhSQXpkc0JWQ2V2N3BEbXlhMHYvdFkvUm5IUDczSWQ3SXVCSGlGcHZIckNY?=
 =?utf-8?B?b1d6Tk1XTGRUWlVtemxRNG52M2xHSUpraUdZRUJ1RGczTmMzZVU2V3NsR0dj?=
 =?utf-8?B?a2h3TFI2RkFsRS9OTFI1YjJWcmhYWTBCK0RyVHB3ME9tclpQNzBsZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ef0997-b899-4fb7-3908-08dee70997dc
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:22:32.3629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQa4IsMl2B79ZRyGg6pqKRibGaYept5ZhslIO17EULLXwVMXk/G5KR/YnEV0FxXLpRkNp7aQ6OKD58BuRyUT1ipHaubuMdpDPtIE7u2Stqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7843
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1QjenaKOMjws6VUStDCiFGGSjKvzVflDr5ZRGxqyuA=;
 b=g2WTF1xfXzOT6GU+zYXu9ejFmEF1PEoheJRHSuA82uJrpx+/NEU5+IRGe2SC3o+Sb2mT5GSql5p/i3XK39c4ktLenB9XAWfSAUW8TI4Vt59ZTeGlZDNKtJC2nSVYxt8Sswekfn35QHDPg+J50xCliqzM8QcVyBt6o0D+H+JUvsc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=g2WTF1xf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="g2WTF1xf"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/9/26 12:05 AM, Jonas Karlman wrote:
> Change to depend on correct xPL symbol instead of a xPL symbol intended
> for a different phase to make affected symbols available for correct
> phase.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
