Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9656C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2EEA88732;
	Tue,  2 Jul 2024 15:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="ezTNZ4lc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3882884DB; Tue,  2 Jul 2024 13:54:40 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC23880AE
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 13:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2O39YLPBqe6ivvpBjxzm76RMjzzX1JDudSZ+oznbwOnA4TiYnvKjNDSkhYWy2MhgHjgRP25jCEvHB6iNmxGIMljXyenyEv5daDk3V/Xxz534oxdUlnzTxOQzZhCj1HHMjwFUb85Mzsql1GqaBz+yTkhu2JaUeluB8Wj5fO1vdZROJ8DEv/41E/oL52Z4HPbpjh3IcaRWDinLQctp6Ib+KrawFihm8FsrGwdhzEW4aFaguAL3712/yzxMYJ5lhemWh9EhhXay0OZwoZkVqwoC40otsmKpo1UyCG5nzXVAPoEbdne3oLIIYLT7DAYHmc8RA0Wk/KaHIBLi7yUu5NZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTbTa/N+A2vGiubX15R41V9SdVqY9vuoIFaqZrFZz9I=;
 b=fiT3l7P6IllZDxTEznflcWjUzHAuj/kXPAuFN10y+dXqQbqemCa7xaNvurVxGKM7sCltdUkhTFiPqtBZr7mGAiRcrlj2nFnsg76O8YVR5aQBBKOOPRj7PxhJqrGPj/TUCY5N5BwZb/lnRsctGkuhiR4NqXXwHOL1wyLeqLUv5JlyK7pYwc55n6Ohyvzmya8M9+SNnrgI901cDKdDyeMZQy5xJZswm/y/8EsytO97wPCxVyUPLyomBr3lHt3R+NmMnTv/xhGwvv9FG16C/JL3+0W0MJOtKE2xFsJ6kOJfnXiF2TKHca1kQfQgxRdFJdQFAaprQ3AnIDorBhtq0CQWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTbTa/N+A2vGiubX15R41V9SdVqY9vuoIFaqZrFZz9I=;
 b=ezTNZ4lc8idr4ipOiYZgOWb7DWeGZZGn7oY57UyRWWTRC9enuZgdRFe8Y5ZBroFZf4Ne1gusUOGPfLFszZ6oA6fSqJqTn5mdMO7AKlvmVXYZFFNSi9F8Cjtf8t8i+jaBc/NzLMQKlFsRL7ypf0X9TNs5kp5wQTWrkVuCUD/uLo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB7789.eurprd08.prod.outlook.com (2603:10a6:20b:526::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 11:54:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 11:54:34 +0000
Message-ID: <fa0503e7-4f4e-457e-989b-c8c6115853dd@genexis.eu>
Date: Tue, 2 Jul 2024 14:54:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] led: Implement software led blinking
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
References: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTiQubBhXf5585htt9tJUNDxkJKmM3r3Kg8r1Zmrk8Rf0A@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszTiQubBhXf5585htt9tJUNDxkJKmM3r3Kg8r1Zmrk8Rf0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0457.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: d78279ee-cde2-4c8d-494b-08dc9a8dbd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWRJWTlia21rY2ovUkNSV3BoVWN1L1JybHl6K0xFK1o0SWdYb0E2Zi9ZcFo0?=
 =?utf-8?B?ZlhaamdBeGtLb3J3d1JTMnJiaDUzVDk1bHZONXE4VjlmVDdBUmRsRFl3WkhS?=
 =?utf-8?B?ZzVJdlljVit1OTRpZWhxbG9zeXJlRVRkWlVjT1ZzTG5VaTRhTTJuOEF2Wkxs?=
 =?utf-8?B?UCtNcG00NmgyREV0ZjlmV3UwaVRaWExURGZpVWVaZGJmalZNTFNsaUFNY0JJ?=
 =?utf-8?B?VUd4SnBlNzJJUmd6UHcyMjRiMjgzYVVXV2ZBSkxSWHUwV0l2Wnk5S1dzV2dv?=
 =?utf-8?B?d3k0TmRWSVNKOXNWMHdCZDZubS95V3IrR3VNb1l6RzkzUW5WTmMrdElpdUNM?=
 =?utf-8?B?eHp1N3JoT0ZKcllmeTkwb0VzVm80cURiYTZRZHJZV1VrVFBtSnJYdTduRzIy?=
 =?utf-8?B?aWJ4eHFBbnd0UGNndHdKVWpwa1BRdUp1emwySytUNkMzYkx0cjJjUGxpTjhu?=
 =?utf-8?B?d1lhbEwrWkExV0xqTDc5SHJhQStkdjR3SEloQWhQZ212bCt6Ry91a1dXdHd6?=
 =?utf-8?B?d2pEN1VFK01CRFdOQTJhS1lYUHYwZW1heU94OUY5cUxYSXoxODRFS2J0M3d5?=
 =?utf-8?B?NnVOQzMzYTFYU1FWVmFpUmMrK2kyaUhXWklybkRlWXl4UG9rT1VqL3lzZzRn?=
 =?utf-8?B?aHNUN0wvUVVjT2J4MHcyQ0xONlZJL2JIeGVsSUVMb1EweFVaUENicHN0TGFQ?=
 =?utf-8?B?VVZXRDNTcVExTmJOSDVoQjUvckxxQVpVQXVYUWg1UDJIQUtTK2l5eVk5R0lO?=
 =?utf-8?B?aHhQTjdncmlobDlXbVdsVmQ4NmI2ZTF5TjllaFJ4YkpybWVRazN1c3hKdkNV?=
 =?utf-8?B?VVJxVkxrZWhmNzlQY3N4djkzdzRKQ01kTXhLQlUwTXZrWm9MU1MzdjJXUzd1?=
 =?utf-8?B?NlVqTGFyQ2dEWjBxVm8yYkQ3WUdSak55VktIVTdtZFJPVnowVlV3VG9zZ29N?=
 =?utf-8?B?ZFV1STVYcW5hQlFzbXM4NzRNRWlsdnNvbjc4b3M3dFdONVVJbkx4aHZjYUJR?=
 =?utf-8?B?V2JmcGJiOXlNUGFscnpJajVHZXRNbUx4blNqWkJpUXhwVU1VODRzTzdub21Z?=
 =?utf-8?B?UXFWNk5mZFZrVHlqaWowSkpub2xqSzZSM1FlcHQ3a1RzUGNiYnYyWmFyV0Vm?=
 =?utf-8?B?TnhkdmdwNit2MHJ0M1lOei9ZSWttbWNVZkl0bERqQWtRT2lZenkvMzUxQjY4?=
 =?utf-8?B?NXN2WE1VSkNhcHdVU3NsZzV4MjVhNHY2aTlOTkRQN3RtOUEwY3RncS96alVX?=
 =?utf-8?B?d0QxUmVsZnQ1RWd5TDVKdTNwbWFNSFpiL2lQa2xJRkdqck5iR1MybEU3UlNX?=
 =?utf-8?B?am9MVFRlU1dFWmJyODQvaXYvOG1naUpuSHJXcmplMFRneVlVYXhyd0p1Skhx?=
 =?utf-8?B?emIycUpCT3dtRlFVK2UydU5JZWNKT1llSTVsTTBwY0NleDBwbG9Ob09aWThx?=
 =?utf-8?B?Z3BjSC9vVWYybkZmcFJKdlpiWWxtR28yVk9EWWdzOUhlckcxV1JiT3FXdFVI?=
 =?utf-8?B?VExiVFVJVUtUdGlOM3VpWEt4TDJUMTg2UzFwa0tpeTZXYTNCU3RVWmladElO?=
 =?utf-8?B?dFAycC9jd25ibk1xSFh4NHQ0VktxcXd6Zjh1eGxzZk5VRFJ6OHhUMlF3R2lT?=
 =?utf-8?B?S3VQd25JVS92eGlrZ0RqN3NQOUlEQmVvTUZCZFRjQ2gvRXVpNTRKaTZOdksr?=
 =?utf-8?B?YXdqQ1pjTmw0YjBKNEpINkN5TFVERnZmS1pjSThiWlpJUm5uci9hSmRGakVz?=
 =?utf-8?B?MWRGVTVyNy9OTTdqUmRIS1VDdk9JNGdsN3lwVEZERTlvU1YyRFhtMXRjcXpo?=
 =?utf-8?B?aDlIRTczYVFUTVh2MmpPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNLZFdvWlNLaktZTnNQZHZsWkdpTWhWbk12TkFXc0QvWmJjS1FYS1pNUDJX?=
 =?utf-8?B?dGxLWTJEV0M1amJZUnNlS1dQV2ZVQnUwM29sNmFDSnJLQ1gyUWs1VHFsd2hW?=
 =?utf-8?B?d0dXdkdpcHJyVjVDVUNLbHlmT24yTDBvOFVqeEYvRHJoOXBPeWpTNG5vSmMv?=
 =?utf-8?B?RER3U2RsNUowdkM3b1hpOUNCZEhscFZSZWt6empYeGQ5Q1FjRVlMaWxmVk9u?=
 =?utf-8?B?R3MyaXg3bDJVQ0RFU3lZbDZsbFA2bENZaU9Dc3drRmY1cytnVFc0M2lLRG1r?=
 =?utf-8?B?U0FBS1ZPdmRRVHY2Nmo5eUJwV2E3STRKM2ZZY3BSR1BRYlpzWEhHbTNxZlpI?=
 =?utf-8?B?djR5WHpZT0lCMnpqdkRnbXRUWVBhSU5rZnYzbCtUTkFad2JIbVJWWWZTei9u?=
 =?utf-8?B?bEs4M1VVNXFtRnpGY3hGUXQvVTNvcDhyVkh6Y3htUmQ5YnpsSmdySzd1NnJI?=
 =?utf-8?B?SFZEWm1yZHdaOFBJRlloajJzbURRMTVBdTcxNFRheUhMcWJOdUk5UGlqUXFZ?=
 =?utf-8?B?a0hPREhhQWFHSDc2Y1Rsd1RoN2htZVI2OUJyaTJGNFhqOEV4VU15ZlI4ejEx?=
 =?utf-8?B?K3JSdmZqNlVmS0VBa3k2QU9QMXlhUVdTVmJ6cWpmUUhmYkxtK1l3S2dYTDZj?=
 =?utf-8?B?R1hEYnpGNmwzOEF6SW85MEJodmR3SldaV2pOVUVySHVjd1NtcVVJWTc1bngr?=
 =?utf-8?B?VGFwWXNScmJjYUE5M0l1aExoVHVUYlJLeW5VTHUzM0dyYTlJTm94U3BqamFU?=
 =?utf-8?B?RVdPUUtWODREWTQ0RXBITVYxaDFTZjF0M0Y0VXFoalU2NWhzc1pERGNmVVZJ?=
 =?utf-8?B?T3BJM3g2ckp4TWFIWGVESTM2ckZtZGZhYitaZThkQ2ZwczJoM0xhakJWaDBT?=
 =?utf-8?B?YzZBS3VEZHlEUGwybnNWZWNjVFNnNUwyRmMweVNNL3RBZ3ZKdW9wM1d4NWVO?=
 =?utf-8?B?QXVQQlhlTlZPMGlqYmFudTUrRTI1RkxDekZ0QXJ4UDcyN0NGSGpxSmtudXBI?=
 =?utf-8?B?QmFzUUlCZHBIeXZ5U1dpZHdEV1B2K2pUeDVUYXdjSXQ5eEdVOHJvZDJ3NDVj?=
 =?utf-8?B?Z0UxRmR2Y2VCMVRFb2lkTVMvZnFNRDJFVEkzVlcwTFV4MEt1UG9LaGx5RzVL?=
 =?utf-8?B?LzdrRFBMVUl1Y1RweXVWWVEwemFmVlJENm5rTE1FaUNlVDNKV1VUYityQ0kw?=
 =?utf-8?B?UHVNK3RoT0lSOG1qdjdSYjNxUXFZelVIaURENWFvTUsrWGF3aXhoSkx1ZjFk?=
 =?utf-8?B?VXRRYVJGZ2E5dWpSUjI0YSs2WE4wTDBjakFFZUM5a09qUk8zbGQ5VUlucDU3?=
 =?utf-8?B?YkNjVUhaU3JseDdQMHoxcDVXdlJ5UnlhYXpLdExQMHR1d2tqNUl1VXE2U21N?=
 =?utf-8?B?OTBzcm9VSk1JWFluMkdLZjI0amtxaUFsTzRtR0UxTUN1TlhMUVZOR3dVdDUr?=
 =?utf-8?B?NXVSc2ZpaGMrOExnTWlERVZleFBVUGMxZFl2cmw4bmhMc3cyc1FDbXUyRWFk?=
 =?utf-8?B?ZStlbmtRSVhKOWl1WHgrd2dnYlhzZnZCQnU0WWMxWjYxT2hrZXpXQmdXL3ZI?=
 =?utf-8?B?OXBoRjd2RzF4OXppYmQwT3A0Zk1xRnRiUlh0SjZGbWV3ajh2bXhwdjdQdmtE?=
 =?utf-8?B?c1NPMmhkSFJzT2V6MThMNHdubitTWHRJallXQkdzRGFPQzFWVU1DRXpQWjFG?=
 =?utf-8?B?VlduNDJTbWsrbVlDQnQyVnhMNDU3M1FlWTlydGEzWFA3MkdYNElOaFY4dWxv?=
 =?utf-8?B?MVgyWVRTVDdRNjdtRVJQYXh4aUhJTlllTTBVZCtLZGU3dFBlbkhNSWJvU285?=
 =?utf-8?B?cHVrb2pPQmdIeW52MEFjMXo0UGRhejFEMGFCL01hTzBqa1NYenNrSEJET3Y2?=
 =?utf-8?B?QkxRdCtQYzY5RGlzNGJYTXp6cUp4SVpKMVRVdmZabDA0ai9CeHVndXJnOVFB?=
 =?utf-8?B?UlpWRGZWZ2lqZFZheENlMzJQeExJMGE0NXhrQWVXOU13ZHVjbzFPMUpqdlVz?=
 =?utf-8?B?MlFXbGtTbWQ4Tm15YkxPb1pPV1NRbW5hWVRyR0ZnT1hyaGhLaG1BNWRvcWJ1?=
 =?utf-8?B?aFBIVmpJdE5LU3VXY1p2NnhkTlRxWjB0TXhuNnhnSFlSbXZhQ1dvc25mUW01?=
 =?utf-8?B?RFN6T3RUN3E5YmUybkhqWU10dUE5dVlmMEh6VnMrUzloSjRuQnRXZDZhSUhR?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d78279ee-cde2-4c8d-494b-08dc9a8dbd43
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:54:33.8523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AoLOcQcO8dJD8e2YExFEfC0H5vNb2/O//+VjM3DF9GUrH24dVvxbVk3BbqAKDGAQf5sV9o3f2pEidZ7o0HeQCwResx+dRv7F9g/bdCLxic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7789
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:00:15 +0200
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


On 27.06.2024 22:05, Simon Glass wrote:
> Hi Mikhail,
>
> On Thu, 27 Jun 2024 at 12:31, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>>
>> If hardware (or driver) doesn't support leds blinking, it's
>> now possible to use software implementation of blinking instead.
>> This relies on cyclic functions.
>>
>> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/led/Kconfig      |   9 ++
>>  drivers/led/led-uclass.c | 190 ++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 195 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
>> index 9837960198d..4330f014239 100644
>> --- a/drivers/led/Kconfig
>> +++ b/drivers/led/Kconfig
>> @@ -73,6 +73,15 @@ config LED_BLINK
>>           This option enables support for this which adds slightly to the
>>           code size.
>>
>> +config LED_SW_BLINK
>> +       bool "Support software LED blinking"
>> +       depends on LED_BLINK
>> +       select CYCLIC
>> +       help
>> +         Turns on led blinking implemented in the software, useful when
>> +         the hardware doesn't support led blinking. Does nothing if
>> +         driver supports blinking.
> Can you talk about the blinking p[eriod / API?

Could you clarify what do you mean?

>> +
>>  config SPL_LED
>>         bool "Enable LED support in SPL"
>>         depends on SPL_DM
>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>> index a4be56fc258..b35964f2e99 100644
>> --- a/drivers/led/led-uclass.c
>> +++ b/drivers/led/led-uclass.c
>> @@ -15,6 +15,10 @@
>>  #include <dm/root.h>
>>  #include <dm/uclass-internal.h>
>>
>> +#ifdef CONFIG_LED_SW_BLINK
>> +#include <malloc.h>
>> +#endif
> You should not need to #ifdef include files
will fix
>> +
>>  int led_bind_generic(struct udevice *parent, const char *driver_name)
>>  {
>>         struct udevice *dev;
>> @@ -41,6 +45,7 @@ int led_get_by_label(const char *label, struct udevice **devp)
>>         ret = uclass_get(UCLASS_LED, &uc);
>>         if (ret)
>>                 return ret;
>> +
>>         uclass_foreach_dev(dev, uc) {
>>                 struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>>
>> @@ -52,14 +57,180 @@ int led_get_by_label(const char *label, struct udevice **devp)
>>         return -ENODEV;
>>  }
>>
>> -int led_set_state(struct udevice *dev, enum led_state_t state)
>> +#ifdef CONFIG_LED_SW_BLINK
>> +
>> +enum led_sw_blink_state_t {
>> +       LED_SW_BLINK_ST_OFF = 0,
>> +       LED_SW_BLINK_ST_ON = 1,
>> +       LED_SW_BLINK_ST_NONE = 2,
>> +};
>> +
>> +struct sw_blink_state {
>> +       struct udevice *dev;
>> +       enum led_sw_blink_state_t cur_blink_state;
>> +};
>> +
>> +static bool led_driver_supports_hw_blinking(const struct udevice *dev)
>> +{
>> +       struct led_ops *ops = led_get_ops(dev);
>> +
>> +       /*
>> +        * We assume that if driver supports set_period, then it correctly
>> +        * handles all other requests, for example, that
>> +        * led_set_state(LEDST_BLINK) works correctly.
>> +        */
>> +       return ops->set_period != NULL;
>> +}
>> +
>> +static const char *led_sw_label_to_cyclic_func_name(const char *label)
>> +{
>> +#define MAX_NAME_LEN 50
>> +       static char cyclic_func_name[MAX_NAME_LEN] = {0};
>> +
>> +       snprintf(cyclic_func_name, MAX_NAME_LEN, "sw_blink_%s", label);
>> +       return cyclic_func_name;
>> +#undef MAX_NAME_LEN
>> +}
>> +
>> +static struct cyclic_info *led_sw_find_blinking_led(const char *label)
>> +{
>> +       struct cyclic_info *cyclic;
>> +       const char *cyclic_name;
>> +
>> +       cyclic_name = led_sw_label_to_cyclic_func_name(label);
>> +
>> +       hlist_for_each_entry(cyclic, cyclic_get_list(), list) {
>> +               if (strcmp(cyclic->name, cyclic_name) == 0)
>> +                       return cyclic;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static bool led_sw_is_blinking(struct udevice *dev)
>> +{
>> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +       struct cyclic_info *cyclic = led_sw_find_blinking_led(uc_plat->label);
>> +
>> +       if (cyclic != NULL) {
> if (cyclic) {

will fix

>
>> +               struct sw_blink_state *state;
>> +
>> +               state = (struct sw_blink_state *)cyclic->ctx;
>> +               return state->cur_blink_state != LED_SW_BLINK_ST_NONE;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>> +static void led_sw_blink(void *void_state)
>> +{
>> +       struct sw_blink_state *state = (struct sw_blink_state *)void_state;
> You should not need that cast
will fix
>
>> +       struct udevice *dev = state->dev;
>> +       struct led_ops *ops = led_get_ops(dev);
>> +
>> +       switch (state->cur_blink_state) {
>> +       case LED_SW_BLINK_ST_OFF:
>> +               state->cur_blink_state = LED_SW_BLINK_ST_ON;
>> +               ops->set_state(dev, LEDST_ON);
>> +               break;
>> +       case LED_SW_BLINK_ST_ON:
>> +               state->cur_blink_state = LED_SW_BLINK_ST_OFF;
>> +               ops->set_state(dev, LEDST_OFF);
>> +               break;
>> +       case LED_SW_BLINK_ST_NONE:
>> +               /*
>> +                * led_set_period has been called, but
>> +                * led_set_state(LDST_BLINK) has not yet,
>> +                * so doing nothing
>> +                */
>> +               break;
>> +       }
>> +}
>> +
>> +static void led_sw_free_cyclic(struct cyclic_info *cyclic)
>> +{
>> +       free(cyclic->ctx);
>> +       cyclic_unregister(cyclic);
>> +}
>> +
>> +static int led_sw_set_period(struct udevice *dev, int period_ms)
>> +{
>> +       struct cyclic_info *cyclic;
>> +       struct sw_blink_state *state;
>> +       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +       const char *cyclic_func_name;
>> +
>> +       state = malloc(sizeof(struct sw_blink_state));
>> +       if (state == NULL) {
>> +               printf("Allocating memory for sw_blink_state for %s failed\n",
>> +                      uc_plat->label);
>> +               return -ENOMEM;
>> +       }
> I think it would be better to put struct sw_blink_state fields inside
> uc_plat. After all, it is pretty tiny. We try not to malloc() data for
> devices.
>
>> +
>> +       state->cur_blink_state = LED_SW_BLINK_ST_NONE;
>> +       state->dev = dev;
>> +
>> +       /*
>> +        * Make sure that there is no cyclic function already
>> +        * registered for this label
>> +        */
>> +       cyclic = led_sw_find_blinking_led(uc_plat->label);
>> +       if (cyclic != NULL)
> if (cyclic)
>
> please fix globally
>
>> +               led_sw_free_cyclic(cyclic);
>> +
>> +       cyclic_func_name = led_sw_label_to_cyclic_func_name(uc_plat->label);
>> +
>> +       cyclic = cyclic_register(led_sw_blink, period_ms * 1000,
>> +                                cyclic_func_name, (void *)state);
>> +       if (cyclic == NULL) {
>> +               printf("Registering of blinking function for %s failed\n",
>> +                      uc_plat->label);
> log_err()
>
>> +               free(state);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +#endif
>> +
>> +int led_set_state(struct udevice *dev, enum led_state_t new_state)
>>  {
>>         struct led_ops *ops = led_get_ops(dev);
>>
>>         if (!ops->set_state)
>>                 return -ENOSYS;
>>
>> -       return ops->set_state(dev, state);
>> +#ifdef CONFIG_LED_SW_BLINK
> if (IS_ENABLED(CONFIG_LED_SW_BLINK))
>
>> +       if (!led_driver_supports_hw_blinking(dev)) {
>> +               struct cyclic_info *cyclic;
>> +               struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +
>> +               cyclic = led_sw_find_blinking_led(uc_plat->label);
>> +
>> +               if (cyclic != NULL) {
>> +                       if (new_state == LEDST_BLINK) {
>> +                               struct sw_blink_state *cur_st;
>> +
>> +                               cur_st = (struct sw_blink_state *)cyclic->ctx;
>> +
>> +                               /*
>> +                                * Next call to led_sw_blink will start blinking
>> +                                */
>> +                               cur_st->cur_blink_state = LED_SW_BLINK_ST_OFF;
>> +                               return 0;
>> +                       }
>> +
>> +                       /*
>> +                        * Changing current blinking state to
>> +                        * something else
>> +                        */
>> +                       led_sw_free_cyclic(cyclic);
>> +               }
>> +       }
>> +#endif
>> +
>> +       return ops->set_state(dev, new_state);
>>  }
>>
>>  enum led_state_t led_get_state(struct udevice *dev)
>> @@ -69,19 +240,31 @@ enum led_state_t led_get_state(struct udevice *dev)
>>         if (!ops->get_state)
>>                 return -ENOSYS;
>>
>> +#ifdef CONFIG_LED_SW_BLINK
>> +       if (!led_driver_supports_hw_blinking(dev) && led_sw_is_blinking(dev))
>> +               return LEDST_BLINK;
>> +#endif
>> +
>>         return ops->get_state(dev);
>>  }
>>
>>  #ifdef CONFIG_LED_BLINK
>> +
>>  int led_set_period(struct udevice *dev, int period_ms)
>>  {
>>         struct led_ops *ops = led_get_ops(dev);
>>
>> -       if (!ops->set_period)
>> +       if (!ops->set_period) {
>> +#ifdef CONFIG_LED_SW_BLINK
>> +               return led_sw_set_period(dev, period_ms);
>> +#else
>>                 return -ENOSYS;
>> +#endif
>> +       }
> This is a bit strange...you are in effect creating a default implementation?
>
>>         return ops->set_period(dev, period_ms);
>>  }
>> +
>>  #endif
>>
>>  static int led_post_bind(struct udevice *dev)
>> @@ -113,7 +296,6 @@ static int led_post_bind(struct udevice *dev)
>>          * probe() to configure its default state during startup.
>>          */
>>         dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>> -
> Unrelated change (we use a blank line before the final return in each function)
>
>>         return 0;
>>  }
>>
>> --
>> 2.43.0
>>
> Regards,
> Simon
