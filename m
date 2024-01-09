Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0F0C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 06:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11CB487859;
	Tue,  9 Jan 2024 07:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xk1YRTQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB397876FF; Tue,  9 Jan 2024 07:04:52 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4C78785F
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 07:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEcMN30ebPNHhLk9Y20JMIdkBWLCV1ItlkWP0KOBTQbAMQLJoKjoSfBh1ysya0TTZYw36JYvlk7QVoGJPULQM0BwEAPyioz+i5nOM3XDSxHzuDHj02t0Kg/R4AY6Q77mkn4Y6u4xHESo5AIizt+qn6zfwHoMTdEtd6ycYbVORQS2u7smlQS2+5VZgy6ftKlNVHOqMpLLILiGxJ5h6JewqynsAs+Hn5oRoL2ozT/TpEKflaURHEhIexOnEEteH+BRAx8KevgG9Kp99GiOz8b9kq/ISQxX8FBVrVeYYxcD6vuCqx0f8hF64ytPeXXfHA10SqseEdOOe8atpNra4fuOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wlUFnLxMCPvY0hKqLGn3QOol1x1VYXstFvKoedIH74=;
 b=Aqs5B8tOprNStCQTIhKXn4PK6FTupr8CueQrE8OdEY4IPA4JgHWRD/H/3/OzuQf2OkK5le2lHDFbCc8vnPlNocnKvaVanEBLDwndRQlFS1a7vfOleQm212n4aEXjUOsmJcEv2mF043FgxlNOMbKFtvIzLh4e4mQQFvekRqXJbTwTxYbr6LvG1szxtkT7e5V8+hswFRh84g/fM4Tohwgs/M/FEPk2YzyrLBKu2YBetrXWPd17fLW2Ghp68KULM3SllvHZWbS8WBEcxneK7exQhWOPKY/PvHfmt/7PJj8VXRoOoVhEh20KrbvALXdJ8Hus6W3Zm6WUfO2kTVKwY3VGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wlUFnLxMCPvY0hKqLGn3QOol1x1VYXstFvKoedIH74=;
 b=Xk1YRTQV7V9vm0o6xFKAUj72+ccEgvO5X4t5Svuytd+KM2rOr/YTonOJui9AvGOkK+76QtqwbzZi4Wbj5EcLL/I1byN7Svn8JBo5w20tU9IragOosWKXGFUD3EDtOBOxPhzTtgCNtrIRSCnezQv04aG36MEaJ3iT8NzoUEDlEpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:04:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:04:48 +0000
Message-ID: <b7c415d3-488f-d106-3fa0-05f75ef91be5@oss.nxp.com>
Date: Tue, 9 Jan 2024 14:04:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] imx8m: Select BINMAN at SoC level
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: m.othacehe@gmail.com, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20240108211140.3270595-1-festevam@gmail.com>
 <20240108211140.3270595-3-festevam@gmail.com>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20240108211140.3270595-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: e6562cfd-19ec-4b86-df47-08dc10d8e273
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5K+GwSkjyuMp45LLnKgEXYQFmTjnbgnGfI3w6ppMFojOm2Ju9bti8ioRYZxAZqQcEJ+SiPNbrai7sQQJoceuUR4mgnyXJ2VsNEaC2rn8zzpXTE+ioM871AJApp4mUQdJ+c1AlYyvH5L65YldnMJVHmOLQYDL89zqadDKoVcwVCErcM/TJs6vbec+sbaPtiA+C64s/AntbZRSRs1G/DAA++9DUY5UR4IAVLbg4ObjcE+uE3LpQsG1ydKKKGm6n6ov5mlO2Pn6KTwdrm/85jH2zffcLoFuEPne7shrvynbAZ16/15hyFfypKxq2w6fNT0ezanwuSSoA/HMgGG4qvSfIH3m9gzRXakW5JSTGQwcs2cRow60mjQQiJ76El/3zbOTrpro9RIR4IlZTwqhBbhKGGUR9KgAwivUPXgvf9fU7b8z6j5cQdALJsWP2vR08lokfjW2y2MGjydnjwG4PiR6XwKKryWvbvC/Uv/AK4JbkvJ2T7HrqjNq3TLprz8RrfijUhQ2dnhQ8MeL0Qs06aoY+3IdaGJSO2t3GJ4odtwSplkMNAZ2BaIXcy5TTeJqD49vyhG6HR1GvUX/Bp347tsT84wZfK1fkCMgLU8yANsLvrqAjci7SI9H7JfABxiKIBqo+3jbvgq7ewAc9EWl/IVFRnWwIxdjEANopzE6j1IJp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(66556008)(53546011)(66476007)(478600001)(66946007)(86362001)(31696002)(6486002)(26005)(2616005)(5660300002)(2906002)(4744005)(6506007)(6512007)(6666004)(44832011)(38100700002)(41300700001)(316002)(8676002)(8936002)(4326008)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVNqT3ZTemd4T3NjQjQ1Sjh4clJpY1VSSjlkRGtUcjNjUUdCQkJIbFhKcUFG?=
 =?utf-8?B?T1dqbWppRmxsbG1mV2k2NEliZWlFNmxpNC9VS010dlhZa3BjVXVRRjdxblF4?=
 =?utf-8?B?Y2wvQWl6b0dFeDRmOW52ZjZyT0dlVnZnWWIybzZ5NGhDZklWak1rOSs1SGdJ?=
 =?utf-8?B?VHp3bFlQN2Y2bmtsWURzV09Nc2IybFE3MWNLRDlNNVRpUjU5d3dPZ1N4b3M4?=
 =?utf-8?B?VVRoRGdaMjhjVk9tN2ExL3JpRVJDNm1nQW9KUHZsN01sdjlpVUlKTUg5RnFX?=
 =?utf-8?B?blhibU9UWW9yYTdBYml1ZHpqS01hWjd4V2dab3F0Z2RETy9Xa1lnQStiL09z?=
 =?utf-8?B?bUk1VjM3djErYU5CTUJ4TkhTMU1OdStXd2VVNDF2ZEJ2Q20rckZKRzJ4Z3JM?=
 =?utf-8?B?QVVaZUxuV1ozYUxqbDNxSXdGQlY0VFV2bUdhU0dieENLVzFVVEdXRUdtRGRT?=
 =?utf-8?B?WHQ3bnZiOFk5VFJpNXc2d0cwK1BmNHhQbXlqd2NiVlo2ZG94Q1ZQdjYySlp6?=
 =?utf-8?B?Y2RTa0NyekR5UmlMV2tJMlBMR0liOTJEaWN0RkhoRWMzYmVsZ3hGZitlbldS?=
 =?utf-8?B?WnRPcjk0ckdvZTFyVnRyWlgrNVQraXR5ZENLRWNCRWgwS2g5aWwwMEdEWUk4?=
 =?utf-8?B?VndHSU9sZWJ3dnJFdkU5QXBtaXIxRXR2ZEs1ckg1enU1OW9sbVZxblJoUzls?=
 =?utf-8?B?NTVZUWYrdWRVUEloZWxJYStJSUZjdDJGUTB4eVhLcnRhd2RCV0V0eVBMREph?=
 =?utf-8?B?bGpGTWtra3Y1Sm83eU9WV2hZYlQzN0YzbEZkcFZFdjRBS0JZU2NuWm90WnhE?=
 =?utf-8?B?L1BkL1VrQWlwd01lT0FTZFNJQURKY2RCVkNrOUlkV3FQQ1l0QlNvcEV1OXBv?=
 =?utf-8?B?ZFRWS1laamN1WDhJUk4yb0Rrb05maVlsaFJQQVJDNTZSUHpNSDdUTjFUNzkr?=
 =?utf-8?B?RktlS2ZIRUx0bFFnNmVzRGh2TDE4Y3QzbEtjV2paekExcE1Bb05MK3dWbTlk?=
 =?utf-8?B?S3pTVVNFTWhOTXFuL3doTFZ5L05tUEttQStnSXo4Ly9TdXhlQ1grTWhCZ2lS?=
 =?utf-8?B?dkU5aThIS3VWaS9HVXRvUTlkTHFYTWxmcG9MTHZVWlZXOU90RjEyVyszcFVz?=
 =?utf-8?B?bW8yQk9pTmF5YTVpN2Y2cUhsQVdYdkNVWHV2bW9oMXhyRUJLcit0VmNVdlRm?=
 =?utf-8?B?cnFYSzdteXhhMEUyVkl6OFRUSHgzTDRlMFhxY05sWjhJT0l2UzcwcWZRdnI5?=
 =?utf-8?B?dGJ0MXBJYmY5anFQQjhEUDlDbTBadVd6UnZBWDMwUGFXTmV3K29Nc2hFYXZt?=
 =?utf-8?B?bFNOSm9HdkZCMGlHV0JZYmx3MGdjVTJRSDdKcTVUVVJqbWpoN1dzMGYycUdW?=
 =?utf-8?B?Mk5rVHo4Y0p3YUxvM3FLRy9MYVBOT1pGb0tsUXBwRGNHQTdDQkd4RDNVS05l?=
 =?utf-8?B?c3Z5bEZRaHhYeW5qWXM3bWtJN09KaFRIZWgxQllkNXNWWlBlbFlZNzBwT0h2?=
 =?utf-8?B?TXF2aEZGbXIyUDVURXNRejNJNWhobTVQZlJmbHppYVFwK0c1S1FFKzhqWTkr?=
 =?utf-8?B?UGVwN1dpbitVMzNEc01wa0xKN1hiMUJwc2tLazVWRWc1Ym95a1NZNFFyeGZL?=
 =?utf-8?B?dnRhUGxEZlBRUnpWTXFwa00zOHRSVnpxZ3E5ZEVXYjJ3c3QwTnlTcEs1ek9T?=
 =?utf-8?B?K2UxSVZ2RG9qSXdLdmkvNVlmaEMyK25PVk1TNTRJbW5uRHJPWHlYc09EWnVW?=
 =?utf-8?B?QnU1OU9kTG1SR3ZzVW8reGN6QXMwU1pOUFdTNVhxVUJIOGU3QlV1QU1lUTll?=
 =?utf-8?B?anZ3OTZwWlQxRnAxcWw2MlNYRFo1cTBzNTVsZnl0Y2ZKMEo1bTI1VVJxQnBY?=
 =?utf-8?B?dG5nTVZLMzRsWHVVSTVlc3d1M2lNRWlPY1RTNWpzNWdLMGtHMWJoRkdPVlA4?=
 =?utf-8?B?WVpkdjVWRkpOM2xZUXJqOFdNbWhZNGVTbWRCTXRFeWlmdVoyUWx5ZXZoSVZ3?=
 =?utf-8?B?WkNmeStqRUlPeUErellHeHFEUzJTZk9ZK1ptOW9XY0VCSy9adUVSbHo1Y09S?=
 =?utf-8?B?SFhhcVdzS3d0S0Q2RXlSc2pyNkl4SlZITStoZTFnWXlTQUplT1orZHdtdGdP?=
 =?utf-8?Q?HS+iZyK/nbfnlueG6YP61VgnT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6562cfd-19ec-4b86-df47-08dc10d8e273
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:04:48.1305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7zH50Q0DUwn5zREJxrQvE2lyjEhJ2zwnqaC+P5RDdRwblZF3XLZ5OjuGLxUGAzRyo1WaTnewveTKZehxl+H7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694
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



On 1/9/2024 5:11 AM, Fabio Estevam wrote:
> From: Fabio Estevam<festevam@denx.de>
> 
> All i.MX8M targets rely on using binman to generate the U-Boot
> binary.
> 
> Select it at the SoC level instead of per board.
> 
> Signed-off-by: Fabio Estevam<festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
