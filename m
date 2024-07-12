Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB74C3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 08:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8278688119;
	Fri, 12 Jul 2024 10:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BEiNXk//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBC48871F; Fri, 12 Jul 2024 10:14:27 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BBEF87FF7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HicnYgVrz/MThVZmP3lxlqIglfiAuKyZGYq5XgnSKYquHUqxlocCOYpQUbe2C2bXct0kAa+OXy3S09HWps7AF/CDuLpZ9Obn9VqiW4I6INa62c9gt8M7+tNFdT/KKQYXfQQ91V+pQujCVJAppCwXhlubFkStQfhoc6v7Woc40CZXNjmvo5zUm3Dfl2IXfGp8slRrhnS3ZQ76AGhuP5V6lL+tRyzI0CqSms+VcOonWOxB8vbDJQXmTMu9qzgsjZdHaQlTiw4o7pxCjiahDlH+WTdE+gT2LX2fUOCldxuTwaJBgNGKkK6XhMOl9O7KOk2SWSXDGutBmC2q51Vd+5MN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmK5FhDiX7JamjLteS6fL/oZVhLEv/zo9zZ6U8mQTII=;
 b=D9fc4YpmgCCncZsfjkjuZi47VT3cCrs/nM3yWBMRJOT5dCjTT7SzJbX+ZhFr+pSIgx/ULvkUsFPFOyuDyjmgH1CAVDDiKKTBXTHxbNX0D9D8UPWeJRc6byvcy8PpK+TTEy90lJxvPL5JbEZh9LVAx5sjvvB9/wOShtyilhWn9Jh9bX8tmR3JkAUpt/bpjXGUP2Pfl3QAixUlj/DApFfOiKqLGJ5NHEKKwOYCPeqv4UibZIKX3zWQqgFsdKXX5yVbcBLmcorOPKFBqNBMPTarjDo6BYOMOy4JlWlf0uLVEWfMKx/iAK6iYPwZU4iJRroSk1hl1+xpnToXHZW7D7Vl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmK5FhDiX7JamjLteS6fL/oZVhLEv/zo9zZ6U8mQTII=;
 b=BEiNXk//OMi5YXQVyaLfIrpckbNCYv5RHvMlHfLO5oVdG0x+pgmq1rorJ4xbpRtntXVAxhZZTLDjkUMbt+qyXotbQc/M7GbczHI5xepHAx4JOc9ebNfhRbcQ6MdhnzmhTgEN6R29QCr2oUwQvcSem5nfFuworsOY5sccRaes3Cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB8PR10MB3925.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 08:14:22 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Fri, 12 Jul 2024
 08:14:22 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  U-Boot Mailing List
 <u-boot@lists.denx.de>,  Phil Sutter <phil@nwl.cc>
Subject: Re: env: CONFIG_DEFAULT_ENV_FILE and CFG_EXTRA_ENV_SETTINGS
In-Reply-To: <CAJaLiFzx140yJxPs=x+1Rm0+j+xT3cXBN8svqaq6XW9_D1CHyw@mail.gmail.com>
 (Tony Dinh's message of "Thu, 11 Jul 2024 13:31:34 -0700")
References: <CAJaLiFzx140yJxPs=x+1Rm0+j+xT3cXBN8svqaq6XW9_D1CHyw@mail.gmail.com>
Date: Fri, 12 Jul 2024 10:14:27 +0200
Message-ID: <87o773m3h8.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0093.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB8PR10MB3925:EE_
X-MS-Office365-Filtering-Correlation-Id: 0398eef7-e7f4-452d-1bb7-08dca24aa2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s5OaTlAUhNOpm9KDm6MBHbYKKsIVBXv7jgTlRdlF8aFlpRjDtgKvYx7Pi8YN?=
 =?us-ascii?Q?0rIgugVwFuL1z/1L4d4Pcoh4f7l4i2cnxosWmV//Zmwu4DHw2B2exXYceUd4?=
 =?us-ascii?Q?A/988G6wewrHBtVGlrtA0AyicEtiZSigPExwAz/FQuwVU+SC3bX5dLWsMjK1?=
 =?us-ascii?Q?bKvDrxIAXFQrVBhlD/eynyEHK32dAdBX0K9sZ2VZkYESl7EzMhyQ8V5btkAR?=
 =?us-ascii?Q?i2mbRZOVp+MtmZYoBV2F5F72ypl3m4yEjrP2XH3MD7oaCQdjpgb+dTU/AdP8?=
 =?us-ascii?Q?iUoUp/QyeNHxcjX7jyOijTjfLuJTX1y9u3G7WBXII9BvFQtOYYwjQ6AmYTV3?=
 =?us-ascii?Q?NhSezSEiAU+BewrM4+cOGg7ULxcAad0751uExLfOL2rchnQI+1U4rV0P1MgU?=
 =?us-ascii?Q?Y2Izjuk/SOS7ErD/zKjwbeBGtIw05p4Lxr0huAwh4BOVOASHXpSlo+lVpVMG?=
 =?us-ascii?Q?Z4Kxd7g3v9Zyop68HBj8lHeDakc394EtGru3mw7qxzqz9+OU8v1JsLMKmNau?=
 =?us-ascii?Q?uiPe5Il1Y5v5HyApLtoMy9pye2Q/Sqdd4jBq+B+BW2I736ybAzcMeRvDRqLQ?=
 =?us-ascii?Q?cmT9EVbHJgAn8u0+BaNipBTR4B+Sa9phW47fwE5Z33p2HtWxSPOoRo1GR98F?=
 =?us-ascii?Q?XQFrXcLRwVNJrpLvtWQFRchYwHuM5xnGuTWYu92DYgJlFzkqu9J5MvUzPwY2?=
 =?us-ascii?Q?fw7SAoYazaUNr1xKdu1jutkrl2ff5jhdvYdGUPcOLyxXiYVsgya9ksbTHboa?=
 =?us-ascii?Q?Ky8KaUsPT3mON1Y915QIUbyaDIDYpLKFZmFHnc9kqV4b0zpEDJ9nDP/CPAJR?=
 =?us-ascii?Q?/oFNQFFz6opwIlREc8HAWKci/ZJf3du5ay9eO1Df5fdb9eGRH51TFWm9N5FO?=
 =?us-ascii?Q?WW0g7+BckyUu0EwoiJACvd/3nDtrHUUMz2nJnWgQLQRAKhQj+owU2c3z17WA?=
 =?us-ascii?Q?opPrnDMSUceLpaR4ZbUmtcrEijLsPNNfO15Vn3Ax8AVUwhc3OyXTG5bTf5E2?=
 =?us-ascii?Q?CyXbnBS/xetjhLodqFUMq3SgDYwPbNJmiLc5XTiopdatzF3mXjM4jEa6CTZJ?=
 =?us-ascii?Q?mN7YMkVdcG9kuGVKflL9+Ml33zgqukss5aaWBvv5lIAY6tE50NNWJIiS6e63?=
 =?us-ascii?Q?PG8ryCCulUi/r0QmHxdzHI09KwhiKkElNUIfMYAN4stlnYv+nfNuFkVzyFfu?=
 =?us-ascii?Q?S6yJWRzNZ4zJx75Cp7vGJWbn+VEmz8hWCd3RJF1iUIWqDkOwp7GszlUaVSw8?=
 =?us-ascii?Q?CUQmjfXnW87lVIqjwjfgTp618Ge0Rmeqr+XfDTShjpeqRySUxamxYorsQyES?=
 =?us-ascii?Q?ChwIW7Fw5hIFjWR6QLbgZB5B4URj8YlbkBNfrxuvC4vBWLovkAKbXI1ZY4vL?=
 =?us-ascii?Q?RDiekN8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBprCspUpgZxRUzbBmCidjbQ+bDsWfVFcFgBqsbNCi+VN8pTUnY+tR7/+aU+?=
 =?us-ascii?Q?bv+YyVxArTr+oZW9wcv6mVcfYX8E46wpyWWlFtuXiZAdDd2Uh5xu1YHJevIq?=
 =?us-ascii?Q?CVhSVYq+0k/8Y1Mp0eHmrfjQDBZiZ6fmSp7/R/He/vnZAFRtCJ6WxRGqSpbf?=
 =?us-ascii?Q?tsOFzkv3n9LalTrCVYi3EBcuGCHTK84WugI/U75MNqHaQdgUsMRF+an5xiSk?=
 =?us-ascii?Q?ecyRE6yE8EZahwc2DY7TCaNwkBpUoJWkKnRyhgZHnBlfajqbcqzbNuPKND6h?=
 =?us-ascii?Q?7pT/cXeJhMOdCLjh42CyHq5C4a/lcCSwx5QbtvhcRA2ypgwNzJ9uLM1sDnkV?=
 =?us-ascii?Q?AkLKQEqsU3fQGQl64bjYyEjMfjaf2yGGQeMC6OB+xowIXS3GDE7z935HpfiK?=
 =?us-ascii?Q?KUg27gVQQBVS+O009VmufKhexkuDelLugu9wwaIwWqZOcJVTOMpesDZhGME7?=
 =?us-ascii?Q?e32JD/ONn2/MQn5d0bFME3dAlZvxisF0+V130I6oY3Y/18TDppa/UAJ9stLg?=
 =?us-ascii?Q?EpMVhVOswYxOIVAforS1kmjGm/gONRjBf0jFb8M2cU1lQH9T5c0SDbcVOEFz?=
 =?us-ascii?Q?DAYXqQEg4abj7uyWe1QNhSLaiRmDWoZoskXIJbxKzYtRiTplfxnqxhK6POtx?=
 =?us-ascii?Q?Ls78XPpTCA55PW/hiWYgjufUXRxOae/kmVIstmyb56lq1ooSuTDRe7RHwaEw?=
 =?us-ascii?Q?YPJUZnztL9u5PVRvSdartXzx9vVN7sw+WmO31gYoX9CqjYBQp9E0v3MdeGqk?=
 =?us-ascii?Q?nntEwWd9c3GQSwMG0IkBOYyzr+GYsuCqJl1iWzMGymiM/wmw0i95V2Ty/10C?=
 =?us-ascii?Q?AHfYn6Sb7sJuSFuJcABupCKkRpW7fhiQRVJNUYFDK8jQwizZbTgEQ8D7IW16?=
 =?us-ascii?Q?S09LhX9UvK82o24GdUxuDzSbYSkEDIz2+Vz9FEPjwN7XgCIFQ9ObRKx51A8W?=
 =?us-ascii?Q?/UrK24g1SF0gH4Bwt/XL1KdeOyf4/izltwCUAXolN0xpyQyczwWbtUWgWxFX?=
 =?us-ascii?Q?nwgLoTDbf6xYpHOkSfGdMXEM0YQ0oSFR3QgvybZ3cZ72Ruhx8RY7X/z2s4FU?=
 =?us-ascii?Q?rFNVqFYtR7I96u018XxALSeoyMEwoyDvZr/QqoycSd7wriTWV7Qoz3+F3SF2?=
 =?us-ascii?Q?kXJH2y6qM+SzC4IK4xzE21B0/At+tQvGRQJAXJXyKHdgEvHuM0vZ19UhvVnG?=
 =?us-ascii?Q?IBOKMHD7wrzhHzTgZ/LYX4RQeScw6m42JefZJUE+217vSW+UGxWU1As9lb7e?=
 =?us-ascii?Q?7ckaTDkFRwkfd2bMRodLUfi1Qt+s9ALTikO8UvK7KSVZymGbUYAzrp1Hx273?=
 =?us-ascii?Q?vYmGRODL1PQWTeEkl2768c3tPYMlWLtf6tIvPzqFJj1eTvAEW/MUJ7KpiZZl?=
 =?us-ascii?Q?O1HBvwoPRQlGQn49u2XMqGzOHccG36Ij1P/CPoVnXuVcbi1QDGqlgtfu+Juo?=
 =?us-ascii?Q?PoN4VUrOuOHKodyvVSoa1dGVcVWUWufo7+bOwak9X99Ff2gidVeYpPzTsR+m?=
 =?us-ascii?Q?OB4DkhXTTm4nJGQnQeQ1ZXq3yp2YCToKtBKPdPRh+UcpfdqFjiRNUsX/do+Q?=
 =?us-ascii?Q?/5D9mbXVoLZYgFQZqI15O65+/TddCN7dnPgpDEiRGNqJMxq37Z8snH2bBeiY?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0398eef7-e7f4-452d-1bb7-08dca24aa2e5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:14:22.6174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjYV5USyOXKQD4QDQ1oUV0u7oqJnOg6Ij7n9CQEXDrAiSv5FeatD1qh0NBhKcHXlgkXenqyPQLagVjdi14LH/0u4MiA9dInPD1LWe5C2dgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3925
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

Tony Dinh <mibodhi@gmail.com> writes:

> Hi Tom,
>
> I'm trying to move some envs from a board header file to the default
> env file. I recall that the envs in CONFIG_DEFAULT_ENV_FILE are
> appended to the envs in CFG_EXTRA_ENV_SETTINGS. As you mentioned here
> before:
>
> https://lore.kernel.org/all/20220810170439.GJ1146598@bill-the-cat/
>
> But it looks like envs in CFG_EXTRA_ENV_SETTINGS are completely
> erased, and then the envs are populated with what's in
> CONFIG_DEFAULT_ENV_FILE.
>

Author of CONFIG_DEFAULT_ENV_FILE here.

Yes, the point of that option is that you supply the entire and full
intended default environment in that file. No U-Boot CONFIG_ options of
CFG_* defines or anything else affects what goes into the default env
when that option is used. [At run-time, U-Boot probably injects/sets a
few env vars, but that's true regardless of how the default env came to
be].

I think there may be some confusion with the much newer
CONFIG_ENV_SOURCE_FILE, which is another mechanism entirely. In that
case the pointed-to source file is sent through cpp, thus allowing some
u-boot config stuff to be used/referenced, and I think some further
bells-and-whistles also exist. I don't know if CFG_EXTRA_ENV_SETTINGS
are taken into account in that case or not.

Rasmus
