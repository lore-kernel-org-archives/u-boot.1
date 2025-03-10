Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C1AC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 11:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C68A811C1;
	Mon, 10 Mar 2025 12:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="T9NmuVGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E99A6811DF; Mon, 10 Mar 2025 12:17:32 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CCC4811B2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 12:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJLxjcz2MIKwyn/CDjD3mWw+uNfzV59p104ch1G5RedFidemf021iiCyjlmBWfgSV0Ylay8yzaMEHl5WOAElzpnNnOQp1VOK3QA8odP65fUW+/wjKrcGuxHlngRIu47LYXHtnFV+wOxTZRg1JpcDp9XJcA91YdN42vncGrFEscolBROHsXOzjmP9UN0sa/h6IMSItEUwb+d1mAjsvvam2dYxsYFUtW+c65ZWlGcTAx5fdSR0EdM5gy8ZEVmYVmMgcjN86hKskwpS+UkOUDyX06M/PD8f3SJuQBdaQQzTxURpUtxXQXuBcPsnZWzbvHp5vfFLATkGgFbX6WS7ctDJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGmAIyHCSOxNhdfdu/g3WCAaQcJ8LyPNZqYxdCJknTQ=;
 b=kKGGXJsrgFvM7FMJ5BQtHt1rFmY0aF1xsGF6DE7XSnOZUQVWIpl9q5sAbkPv25Px4qKF+yrwGwQcLx+L39WOhu83kPwDf9ZlCZOqnD5Q2BgcmGH8RddwcPTVc/h3X+bERy25YzuB/20Yg14feQMo2ZFdY2OUbw8X0FyGc+DVQ6LYZFuaHJkr+48/NvozQ+B1Qicy7kidxz3WWS7L6yyh6GSU9pCPGbZ0MiDYzpjxASjIfbNXQ7MUcOoUO6qpPcu5V62xtAAWgWoKSimXPhBewc2N1dsMMwv8biEIj+7x2+yk/lQWFMtzB5PfE7KXC7qlgPHP5D4dxPZgbHHdVfY62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGmAIyHCSOxNhdfdu/g3WCAaQcJ8LyPNZqYxdCJknTQ=;
 b=T9NmuVGPQ38CrAtOldzj6cQ8Inr9+c4JY4I807osgZryiYC3P3vqW5qI09uNV1Nyw6nHuSskT1Brmc2IAQpKIt86LJo6GJg4sC8AiJoZApIN4qntua06Lw3HJzX8rYvkOCSRJhir4E3gjzJMHKNNvH3mFGLgny2MmJRV6WTEwP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 11:17:28 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 11:17:28 +0000
Message-ID: <393a7b06-402a-48b0-8ed4-5dcaa7ab9383@cherry.de>
Date: Mon, 10 Mar 2025 12:17:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] fs: exfat: Fix conversion overflow errors
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-9-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250308201533.1315951-9-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdfaff1-bdc7-49db-ce22-08dd5fc5245d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEFhRFBnVmRXTitiUkJoTlpKTlQ0L1ZDUHV1T1Z1M1grUGtRUnJUWkZKbVha?=
 =?utf-8?B?WStENXE0NU5JREdVSTI4bStFamR1U1c3clUwZGhicTc5NVJmL2VvOGhSanlT?=
 =?utf-8?B?K2IrK24yTVRZOXlMVWpsc2twTkNGclJ2bjl5WHBLWlNtYVdXQ1RQb3kyV2c2?=
 =?utf-8?B?RTFjZUU0cEtTR3UyRjRoNXc1bW9ITnl3TitKdXhoclFqSFBKZG81QmF0S2pl?=
 =?utf-8?B?eERMdERZVmtIQlJBaURKWnlaM2prWjdJNEJERWdnMUVQOXR0ekhadU8xN0Ey?=
 =?utf-8?B?MTBRTmVQMG9IRTQrdCtGZnlRRHVEQ1FUMFVGcWxJcDFGTmVaeCtuTkw1T1VL?=
 =?utf-8?B?eFhyT3RVUjFjWkhMbXRjNmdJaytFb2NsMXp1dzhmTmprUzJOWUtUcVZSMUpy?=
 =?utf-8?B?QU9JZDI4dVpOOFJwUXIwR0dQeWkySVNtZk5sODRBK05obUM5T3pkeDloamVX?=
 =?utf-8?B?azJQdTg5OTJWUHNWNndoaG1CNHQ3VGl5QXVXcFFtZHl2UHpRa0lreGFzVlY0?=
 =?utf-8?B?YURuajVJOEpUODAzSlEwQi9Sa0xjZGY5cFpjQ0Y4cnBsVUdET016VDJ1Rkp6?=
 =?utf-8?B?Z2xFc3QvaFNUUlZMT25Yc1g3NEJWUjhqRnJacCt5Nnhxb2x6ajN4TFg0a1ha?=
 =?utf-8?B?Y1FEMVpjMDJoQnpTSlhzdWVkS1VOYzVuSU9vVC9uV0ZuYU5EWjNxL0NZQzRB?=
 =?utf-8?B?bW1rM2xtVVE2SFN1eGNQOUpXdFlIay81bW0wd2h4NXFzeFc2UjErVTFGOUFI?=
 =?utf-8?B?eW1kOFJTWUk4ZFFCN2hyekFWTTAvZjhNbkpSaUwyVW5QYlAwNmFOOGJhSmFE?=
 =?utf-8?B?eDJhUTVTejFqeURMaFJkNHJkdHpWWlVITmVwQkE5Z09oY2lIclRnaXZxSmZK?=
 =?utf-8?B?T2NqS2NXOGtWc0hoQ3dzZlhHdUlQSmQxZmZyRFcxbC9TUEdlSDdKaEwzK21p?=
 =?utf-8?B?ZXoxZEl2cHJLcGkyNS9hbnZwUmZIc3Q1QkdTQzZzSkp1RTFvWFFlbHJaNmFh?=
 =?utf-8?B?dkhvb0RuWHR6TmR3V3E4b1BBL1Q2akFuSmFMR0cxSGx1SGdseC9UMHUybUhQ?=
 =?utf-8?B?c2RWRUNJMmJ5TkpLaisyVCtuYXliOGxNZDV5RElwRnZjckdrcnROdnBWcmI2?=
 =?utf-8?B?OHRFRUV2UGoxdGRxOWdIQ1pKVVFDc3lHTTBITmM1a1lsNEExb0V6SUxlOUdF?=
 =?utf-8?B?NFA5R2tEb0YyQzB2SjFHV2tiOVM3eHRid3VqK0dQaDloMUVvd2U0dFFMRzhF?=
 =?utf-8?B?SFBzYlZHeEs3dERwaDhJUHNMd2xSMmJCRmNNWmFSV3B0bi9pWktpbVRGYUhT?=
 =?utf-8?B?M3Y5OC9pYkNzMVc0bUFHSGxGc1NwZTdBVzBnSVdiL1A0S2J3d3FCZUhVS1lo?=
 =?utf-8?B?TFIwelhMSjluYmFMWnl6aWNBV1VNa3NUS0NQazVXWXZuVlpLQUxQN0hwdWhK?=
 =?utf-8?B?a2dxNkRNeGRMWjNGbklPZkYzT1hBV29jOUFveW5BOTQxbzl3ODJHeW96L1cy?=
 =?utf-8?B?WC9ZU2dPRXJjekpTaDcvcjl2YW9jR2R2bE9oa3ZOOWRKSjVnOGU4QmpFelBG?=
 =?utf-8?B?U2daL1Z6QUtIZnNaaEZ5aURpZUtTcDRWYjZIM0FzSC9qOUJkYUhMaWJNK3hw?=
 =?utf-8?B?NUFyRVFIYVhaUGF2eWdNSkdrZWQ3bXNYTnUyT1ZQRDdoaGEvTUhtNGg4THpI?=
 =?utf-8?B?MGw1WlZ5cVFvakxUVTBRQ0t4VGx3QU0xSEh5SnNvLzhKVEpBYzFMZlY1M3dx?=
 =?utf-8?B?MUhWSERQVGVVdFJqdHRXWFcyeE5kYWZqT05aanhDUGNCUW5laURRNVpyNmxa?=
 =?utf-8?B?K0hNUTU3WUQ5MXE4Yy9Rcjh0UXF3em90VnJhdzBiR2hTVEk2QjFtdGYwY1N3?=
 =?utf-8?Q?oMQaPpkJlt+vQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVVYVU5rMU1UQUhWTy91ZWxrSTRKa1BrdjlMN25CK2d1QWV4dXhuV1dBQUVo?=
 =?utf-8?B?TEllVUY4TUtqSlVITVZHK1I3c3pPbldSUjNmR1dOb1F1clN3RzlyN0kxMDEw?=
 =?utf-8?B?V1E5MHBGbmlZVjBIaXFJMEg0OUxUdVpPUHByeWZZOE53TWsxZ2ZFaEJNOWlE?=
 =?utf-8?B?WmlGOTVjcGtLMGE3UWZJMWJLTDB1RkYxL090c3c5TXlRQTNXV2VldFJmN3RU?=
 =?utf-8?B?TURrZi96aEJ0RGpRSGdsTWNoa2h6ZEhkMTE2MDVJRkdPakJja0M2NEIwL1Fr?=
 =?utf-8?B?blhXS3l5M29YYTVqbi8ydHJUa1MwTEF1T1VJSWVlU1YyeitQV1piM0lHVk0r?=
 =?utf-8?B?YkswcUpBbUpFMGhFak1JTXgrYnhHdVNSR0dXdTl6NXFaUTlIZDNqSm5qb0VJ?=
 =?utf-8?B?QUx2SW55bXZCTjBqRC9HWlZhdVlTSnRkRjRYRGo4eVkrNFBTSG1PbzNHeld1?=
 =?utf-8?B?eVRjMU1ZUmg0dklBdHUrMGJDc3BISUFXeE9Mell4Y3RXcjgvOUd3YVVBc3k1?=
 =?utf-8?B?b0t6aGlsT0FWM3hzd0JYODlQZGJxaUVSTzlnMVpzOVhMR2pMSmVNcUhJOXlo?=
 =?utf-8?B?YmszVm9FcnoxNVdacFFjWTdzYVltVHZTenhTbitRREh6dHhEampsNU9NNDFI?=
 =?utf-8?B?UTNTRmhZWDE3NlhDRlZ4ODVxdk9rd01KT0FPb3pacHZDbDdFOTNUYzZMT0pr?=
 =?utf-8?B?U3lKK2gzVytMMTgra2xNdFBjZWEyZWp2ZGFIYk5kbXNURUp5YWEzaUhHZW1C?=
 =?utf-8?B?c1VUWVFsdkY3WXhodzhyUnVHQ3FjY1lkK0I3cnJDM0dPaGllOWNUOXF2dFFW?=
 =?utf-8?B?am5sQlhIbnlCKzlybWdncW42ZHcvK1JLQmNiTDdsUEpBREc1T0xNV2NlUFNE?=
 =?utf-8?B?VmFvUDMrR3JIVmkvSFhIdmUwZFY1Vk0vMmhOUU9jK1hCbDY1YWdaaldHTE1M?=
 =?utf-8?B?djB0L1VhNjVIcUNzVHY4M2xTd0FObDNSNEdvMGRGVTQrdWVIcmZUR29tZ1d3?=
 =?utf-8?B?SXNhMnBTSVR1RmhnZ1plc09NamF2RnM5RGNtS0paMkVVdExpYWJZYTBIeHZG?=
 =?utf-8?B?U3l6M3FnUFpITmJuNk1SaTYwblNNMXIzQ2NZN2JhbEdSNndEb0Y0blNjWjlS?=
 =?utf-8?B?K3JZbEhSaFBGeWVMb0x4UU1nSENsUWQxRUNyaFRYMUV2dlNrV3VvSVJ4L3BD?=
 =?utf-8?B?UnltUzJxQlZ4NmZpSGovYWlrMFBCaVZNZjRZb01iOXNIc0ZZV0JkU1dwc0Vu?=
 =?utf-8?B?Z25kQWRTWHhNLzRJZTcrdlg1YjlhUlhzK2s1VXpMTkMzeGdHaDN0V1BpaFRi?=
 =?utf-8?B?d3p4czZlWWx4d0VmWStiUEJEaWZmUHkza2Z0WVdITm16S2dyNXRSNWIwY2hB?=
 =?utf-8?B?bzVWZTlnakVHLytRS3lmWE9sWnQ2S1o0K0JycVZQRlp1dXQyQnRYU2RXQ0ZF?=
 =?utf-8?B?Y1ZLUzlUL1hRR3hIVy9mZE5weFRJU3Noemt6MDR5akxYb2tvaFBMOTBHaDZq?=
 =?utf-8?B?dHgxN1JCQzlSYXpYVnJweVI5VllqdlVZenVReWh5WWxSaGdXNFFEU2dXcGZQ?=
 =?utf-8?B?UnFUNnY2U0Rzekw5eE9FeG1sYWtnM2RMajU3WmJHeU1RbXRhSmtYdVpNSzdk?=
 =?utf-8?B?aUN1TEJYdWFDS252VFNCcXk3QnNRMllpYStOY0FCNTVXdE04cC8vZDdBUkVJ?=
 =?utf-8?B?TzZSZFFBTTNqMnFvenEzWDY0citnanpBUzN5K2F1dzZ4c1JuMlRxYUhqL1Ir?=
 =?utf-8?B?aG9tbmQwQ2l0TUhjeFBnQ29GM0tmVFAzZnBzc20wVjFDYldTTTNjS2IwSGxR?=
 =?utf-8?B?K05yUitFRTAyRG9WYU10NGovOUxnZ1FLSUFNUk9wR2NRVjVlb3RrUlFXMmY0?=
 =?utf-8?B?QzF1alI0RTJuNEs0SFpEYUw1NVpIQmpOcEIzTE1CN1M2bDVaRFc1Sk1yTU9o?=
 =?utf-8?B?dDZrblVqdTdxTU1DUzNlYzE3djhQTmYvVEFNUXdYU0cweVQrNi9ObTA3VUhZ?=
 =?utf-8?B?L0t0ZndzZ0VCQ2ZjTlQvNlUzbGxIVjBmNUdObnVkenlrNWhpeGhyekkyODRU?=
 =?utf-8?B?aU9nNjhBZngrTk1yYXVGMWpYQ01NK2RiYnJGV1ppTmpCRVB3R2E2ZTYxMmUx?=
 =?utf-8?B?YWt4UUs5RHdObW5rT2JoeEZWSFZzTHpjZnV4R2M0ZW4rRFNwUGVwejdFVXFR?=
 =?utf-8?Q?OUD94XcqzAltSZlwYG/hFy8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdfaff1-bdc7-49db-ce22-08dd5fc5245d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 11:17:28.1558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrIjS+FYaoPS5vgOcaXUd6QxnxOu5ke5xbOchB9g8psERN+iBJ3ZcAUJiDlyqVSJLIxzXa/HKQYVPgv/+eJfjYXMSlt2IhQ1HsTOWjX3Y8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422
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

Hi Marek,

On 3/8/25 9:12 PM, Marek Vasut wrote:
> Fix the following conversion overflow errors. The input field is already
> limited to 3/2/1 bits using the bitwise and, move the parenthesis around
> to avoid the bogus warning:
> 
> "
> fs/exfat/utf.c: In function ‘utf8_to_wchar’:
> fs/exfat/utf.c:165:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 18 & 1835008’ to ‘0’ [-Woverflow]
>    165 |                 *wc = ((wchar_t) input[0] & 0x07) << 18;
>        |                       ^
> fs/exfat/utf.c:170:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 24 & 50331648’ to ‘0’ [-Woverflow]
>    170 |                 *wc = ((wchar_t) input[0] & 0x03) << 24;
>        |                       ^
> fs/exfat/utf.c:175:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 30 & 1073741824’ to ‘0’ [-Woverflow]
>    175 |                 *wc = ((wchar_t) input[0] & 0x01) << 30;
>        |                       ^
> "
> 

Since this doesn't seem to be U-Boot-specific, any chance to open a Pull 
Request on the project so we may be able to not carry this patch when 
upgrading (yes, the last commit in the branch was two years ago, but it 
seems the maintainer is still active on issues).

Considering that wchar_t is an unsigned short int and that USHRT_MAX is 
0xffff (so 2B or 16b)...

> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Nam Cao <namcao@linutronix.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   fs/exfat/utf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exfat/utf.c b/fs/exfat/utf.c
> index b1d09e76478..5be8dcc2170 100644
> --- a/fs/exfat/utf.c
> +++ b/fs/exfat/utf.c
> @@ -162,17 +162,17 @@ static const char* utf8_to_wchar(const char* input, wchar_t* wc,
>   	}
>   	else if ((input[0] & 0xf8) == 0xf0)
>   	{
> -		*wc = ((wchar_t) input[0] & 0x07) << 18;
> +		*wc = (wchar_t)((input[0] & 0x07) << 18);
>   		size = 4;
>   	}
>   	else if ((input[0] & 0xfc) == 0xf8)
>   	{
> -		*wc = ((wchar_t) input[0] & 0x03) << 24;
> +		*wc = (wchar_t)((input[0] & 0x03) << 24);
>   		size = 5;
>   	}
>   	else if ((input[0] & 0xfe) == 0xfc)
>   	{
> -		*wc = ((wchar_t) input[0] & 0x01) << 30;
> +		*wc = (wchar_t)((input[0] & 0x01) << 30);

... wouldn't those still overflow? I assume unsigned short int like int 
may have an architecture-dependent size, but seems to be at least 2B, 
which wouldn't be enough to store all that?

Cheers,
Quentin
