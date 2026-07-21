Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A602C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C4D140911;
	Tue, 21 Jul 2026 15:23:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1S_K-I_m_DId; Tue, 21 Jul 2026 15:23:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5232D40874
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784647418;
	bh=Ll9p+qugrCBOePafBcxgAehK49dN8STaZAkLRNIAF6k=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KIjpGA2wjc7LtV1raVLXZbIqgCtQT0d1HsOV/HK5gi6c8zW9ICDRnSidSVTg2utw8
	 E/67SfEVZT0AbJyJSuKM4NBeWjuOHGzuOUSOTPkBwtGEsOSuMxsBDYLIcBoc+EhodA
	 u6D0VopCYURZGd+Mbu3RQQo2ZCzne7+2/EXdDcGborxZU4HcIoZDDjWx6N+hcNUh63
	 V0JizsK2x3dQnM3XiW+na1N/A8P2lu5lVDyipEaE4pTxW3Zd7O8Clc++KqX2cZCMy0
	 D0CJDMFo8fY8XvqMP89CQBkQF7BlF8CQEf2ANell7ia49laoQAq9Q0ITuO2pOCux40
	 RhWe2w+AXjfRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5232D40874;
	Tue, 21 Jul 2026 15:23:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DBA80EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1B5440164
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:23:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oml-tR75RnjB for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:23:35 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 41B1C40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41B1C40071
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41B1C40071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:23:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A0B846A4; Tue, 21 Jul 2026 17:23:33 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27030803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 17:23:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPsRkr9hvQFiL9hODsUYEc0s+Ooq89DkrR9w5dWXzN7B4gs2uPlwDcgufgEl+StE0H3Yc9vHMqc3T+QznsE7elz1rlgD2PpydN4GZfSVCZ3L2aJOCaKCaK/4lfRwx0TVqoNQ0KSXU5Wbed9eiY94ycNemx9RVrtED0kGzrD+WMTewx22FpJGKWcxZXGMS5+pPHqsiF7a2lBiWOYUFpFhYva5rXha1odfemedbO5yjNhc0KtZL0XtlHBpFaDzbFENlCtdBxy7gb5spBKrT5hRbbYtQJ5QpVUyf6x25Y0hG3q81tGxTPua0AWfxB5/MfcSvMoiGZQhVed/mIe28DmbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll9p+qugrCBOePafBcxgAehK49dN8STaZAkLRNIAF6k=;
 b=ToEO6Jm1oVgE1EoJlWUdgEx5EVwVrkpeHWEKsLwYbApk0F2aLb4IPs9tU3ezuLIHAkY3zhdIN+3oSmfi8KKORmlFyn/Zu4cfmRqJIINcVeSHA9WJYS2aM6KtCBejRndaAe8uHQiMm/VUsVbYWjaX0F91RnNrM3hTcr93YDPJpfDqzBgdvFPdINCnzhrvnnkZySbkVwvoBQdghafWxkVsvv1jK63QWMNfh32hjYAbTsBgQRwtqO208CZkZD4gF/w+y4qb8zaXmg0i+Z/Iz3Q/MaiWdLSYGWrG7KYZ/fN5+bu1l0gkVJgK7VS31y4vuICNzWYdjkObldCTYqMDqEKW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:23:27 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 15:23:27 +0000
Message-ID: <fd7c7076-568c-4186-b37b-0b3783f5de5c@cherry.de>
Date: Tue, 21 Jul 2026 17:23:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576: Properly handle USB controller takeover
 from BootROM
To: Alexey Charkov <alchark@flipper.net>, Anton Burticica <mouse@ya.ru>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
 <13650571778172129@c82c52a0-4efd-47b9-b2a9-5a9057476b1d>
 <CAKTNdwG-Keu5Gf9EA5TUw7mG-KGBLumOco54Gm=iRM2Oif-F7w@mail.gmail.com>
 <1e9104cd-2ccf-473d-a510-b1188aca5617@cherry.de>
Content-Language: en-US
In-Reply-To: <1e9104cd-2ccf-473d-a510-b1188aca5617@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 06070d71-2f74-4ba7-0435-08dee73c0304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|13003099007|6133799003|56012099006|5023799004|11063799006|4143699003|10067099003|18002099003|22082099003|4133799003;
X-Microsoft-Antispam-Message-Info: 7f0lVeQ7m++w6n2MawQXoSl8+GIXE6v2+aKriMwlkHcavP7UqooAiBuO8X1HJH2NHx67uCtb6soL2Nt9Vl1aMX89eQWzLkD50U3xP+65zX5zSVya2AtQ5UqdvHCBdzTgM/CrVBke2Nzzcw7P/+s3E/Xuxw/aJZkIp4SNgQZNhHuKKbfBz7t9Oi3uMpWdS+WU2/lLALNJQkl4pwm6aAAl5Jaa0Gkl8zsOTB6mq36BYfFVMTzxn9zvkATrmKnIdU9RZb2JYmrvOEVBNm2WJqVj35gfBocxvnKgG/3q9+e35Sw/UOjljDaUGWpIRvRTIrq5sd77aEo5Lt6GYn+25zwPjzGKsPlV33Sy5wwBKRsaMMG0V+mBoQkKEcv84AY0ET/vOtnS4MKWZGZH9xtleHNH0az8FlZwrjP1BfFM79pUc8U1rp9tCKMUmcRwd0LvL26aEbWdURDBHxn2+RsXr8BKyLDI9VIATr2R+MYI2bp2baajWck4pVudnSaGAla5UHAZbjzZItlhwF5gOKzNB86H8RSQUbCD/ykIe3TdfpSmalWehm30mWatb9HaVif2oIj8G+kRf4djF8h3/Wq95AuWCO/Xjd2LV2kZ9CfSyKA7BXtlFOyI9xGeVVe9zAdPBetZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(13003099007)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnNYZHJ6YnEvQzJ2OU90aFRTZ2Q5Yld3REpjWG5sQlNpcTQwa1k4NHNCc2Nx?=
 =?utf-8?B?MDZjUFNCcS9rbmdYYVBXcHFVd1o3TEt3dE9kMk51bDNndHFVV3hHL3Fxd1FR?=
 =?utf-8?B?R01JY0xWTnFCR01DWUtWQXpmYzBMYUpHWm0vdm5BeDJWdTloazhMWVloV3Fs?=
 =?utf-8?B?N1dRclE2M0Jlb3NqS3k3emtiQTM0QjB5b2c5c2t0dTJLL0hYazRPcGlkSVpa?=
 =?utf-8?B?U1ZXUlZDUUhzYUFKQjFlZnJuaU9qZlZyNi9hVU9Baytsb1FIQ3JTZ3hwY0cz?=
 =?utf-8?B?Nlh1MDFlYXQrY2czSHBQd0ZKTDlyUmpQbVhHZ0dpdzV6cXhhU0dSamF6MFpG?=
 =?utf-8?B?c0x5VkRpUk9RVUdEOFNRTFJoaElBMDV6THgvYkNzQnhmZTBOc1RyWE9OZHIx?=
 =?utf-8?B?L3UwakdYWXVJNUl6U2FPVDU5Zlg2ZmM4bnNSb0FVNURpNm1CeWxaSzZ2SGFi?=
 =?utf-8?B?ekFmL2tzQUwzeTJMOHR3K0VaTDdCOEdHa3IzK2ZyaXlKNWxPMjlza1hmYWRk?=
 =?utf-8?B?T3FPUGxMNnZvUXVwamoyK3lMYmFXQTNudUcraVgxTjNVLzdrYnNoaGoyRkNZ?=
 =?utf-8?B?ZjFoYU51czUwMlNPRmJBeUMvTW1wNjZLdkVUV3NtQTVpL0l5TWFRakxXeWVR?=
 =?utf-8?B?NzV4aGFtRCsvNzVKNHpVMTNEaDdMTUE3ditJd0FmY2J1RC9MZVNkNVVkWlVD?=
 =?utf-8?B?WFBQZ25YUko2WTNEbnpiMU9pdDFpODhaUEFPOVRLdlAxT1NTMHJZTFhDUWJP?=
 =?utf-8?B?Yi9leWdtL3dJZ2RsOUpPYnRYRStISW9qR253MWZaN1d4WEI3KzhsZ05KcnJp?=
 =?utf-8?B?M1pOVlJRS0N4YnFBajNoR2pwMTBGY2dkRnl5NEFwWU04Ylp6Wk5rYVRvSkpD?=
 =?utf-8?B?RU1PbEY1Y1NIYjNyc2wxVWdvVElVdkdCY2RtcFNMdnhKMWg5QTkySEhZTUg4?=
 =?utf-8?B?TjNOQVFnL3R4ZTVGa3c0YW84R256QVd5eG1yc1ZENWRtMTUzaVFhZUVqOVR6?=
 =?utf-8?B?TlArcDlaR1c5L2oyM1Bnb2VDM3l5a0hEek43L2F3clUxUUp6ZWFkSVVTSEZX?=
 =?utf-8?B?QXhtY3RrMWY1MENHOEF3YjdtQkR4THF0MVdjNzJTeFp6dG9WNjZiREZXRzV3?=
 =?utf-8?B?akVXT0lVQVpNKzBJbG4yMzd5VlNRcUVmVWFrNFNvcG5McEZ2eC90RUFjNTVh?=
 =?utf-8?B?a1c2TVpZU00vYmhJcXFNL09GbXMvZFNWUm1zUU93Z1VOUDA2aVZIbWxmRGVZ?=
 =?utf-8?B?ZzRGbk5GOElVeGZDOWw2RHNsa3dMRUUrOHY0RDJlVC9HNEFQaDNxdkZHUnlI?=
 =?utf-8?B?WjR5R2Vob2JtNUJRZVpoU3NHRXkrSFA2dXpXSVNPNDhkYUJaeDlha0ExRTM4?=
 =?utf-8?B?c2V0OUNLM05taktwSFFsY0w2eDdUZjJ4b3BzZ2JlLzhwVkc2SGtGSm93TjBJ?=
 =?utf-8?B?T0xESmEvQTh4R0dTWFI5QnB3aWdSb1U1aXdOdFZnaVNwZTVCVC9sOEhyaHFh?=
 =?utf-8?B?cUg3QStKNTduRGw3UlhDZ3QyeHlNMmJSNVJxT2dtZmlCd1hvU3FTZ3U0ZWxY?=
 =?utf-8?B?YldhL1NFcFFGU2RSd1RTVFEzdUU0d1E2ZnRYbnRQQitPUExncFFXWnRteFpo?=
 =?utf-8?B?NnpYcnl2QmV2VWRjMEJHa0Ribm5ZSWtRak1uemlxWUF6SkI5TjBtN1N3aTlh?=
 =?utf-8?B?K2twb2ZhR1pjdXNTMjZDM0pFbDltZVFkSTZlSTRmTE1DQVdmVG5LdUxRSVJo?=
 =?utf-8?B?SUlNMVZZNUMrVXo2V0NJTFFuVm4vOFRSeTZSRWxDcVJkYTNOTEtkbTZyaDJy?=
 =?utf-8?B?Ymt1V0kvd3d1RjZBWjVrUCtQdjlRZEkzZy9GcmhkYzFtTWw3cDhlMjVvdTVk?=
 =?utf-8?B?WE5IV1pZZTdLNjE5eTQ4UTBORWdYWDh3YnczMytXYm9tSEpLRk9ja1Q1NTI1?=
 =?utf-8?B?cmFTVVpRMWpPT2FTNldLUUlDYnVsaWJMVWtYU2xSb1RyTklpcjdYblhSVENZ?=
 =?utf-8?B?NnViczg5eXdiU09zWWlvNW1hOUxqeUlDd2d3QW1GT0tYeUJlZDNvbmFRS1R2?=
 =?utf-8?B?ZVM4NUg3Y3RDajZtT3hkUFFIcXJ0V3RzZk9GM2tzRDliYUF1WXJaQ1BIYW11?=
 =?utf-8?B?aWJ0WkpmN2Rxb0FsQmY4NTMxU3Qyc3IrTXhCSVQxNStWdjNhUWlLbmROdGkx?=
 =?utf-8?B?aytVTFd3V1VyQVlJMFFIZzRBWjB1WTZMRHpwL2xNRlM5MUNyTkdjM0tqQVh2?=
 =?utf-8?B?dEEzazZrQ3hPd0RDTzNMRUIyRkRiemgxcnJXWXRoK3V3RnVIUVRFMURCNlU4?=
 =?utf-8?B?ek9oTTlVOVdiVSsvL25LOXVoLzZnTXdBKzZERzRnVE85YkRIMTBidz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 06070d71-2f74-4ba7-0435-08dee73c0304
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:23:27.2236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OatPznhnxieEgPqebimJYwap08ViKjGYmfgT4bMNenvU7mwPPEbVbNOwZ9sJiVc7uKeIBGWKaMT7rOzJlxAA39rvldz+wqBuumzpnJHrOms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll9p+qugrCBOePafBcxgAehK49dN8STaZAkLRNIAF6k=;
 b=Aq1DuDGZ7858GCtASw5agUlxZdkUmkkud0sOq3vOlQb4+lZTg9FRd5WXHdH4He9cjMasEQXpmycwYhyZuQOEkxpiBuYZ8r2UisWJOA66JyobbFpzYaxYO0SBoehfY8Bc+bLfWg/lATZ4srJP1L9yyEVycnPwHiy4i1jyX5X5QVc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Aq1DuDGZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="Aq1DuDGZ"; 
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

Hi Alexey,

On 5/8/26 4:59 PM, Quentin Schulz wrote:
> Hi Alexey,
> 
> On 5/8/26 10:21 AM, Alexey Charkov wrote:
>> On Thu, May 7, 2026 at 8:48 PM Anton Burticica <mouse@ya.ru> wrote:
>>>
>>> The original idea was to _not_ disable USB3 OTG port when booted from 
>>> USB:
>>>
>>> https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fgithub.com%2Fflipperdevices%2Fu- 
>>> boot%2Fpull%2F20%2Fchanges&data=05%7C02%7Cquentin.schulz%40cherry.de%7C2646189b068342c152fe08dead126988%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639138491747796890%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=xX4POW%2Be7JMSMo1g2aYdZekD5qwLAuXTtSyRuD6QVlY%3D&reserved=0
>>
>> Hi Anton, thanks for the context!
>>
>> It seems, however, that the minimal change out of your original pull
>> request which fixes the observed initialization issue is just the
>> assertion of the reset line. The rest may be helpful but is apparently
>> not directly relevant to what I'm trying to fix here - thus the
>> significantly trimmed down patch body compared to your original
>> version (one change at a time).
>>
>>> There is a possibility that with already running analogue blocks, 
>>> disabling the port will leave the controller in some weird state and 
>>> it's not possible to fully reset it via exposed reset lanes without 
>>> full SoC reset.
>>
>> Could be. However, having a different initial hardware state by the
>> time the driver loads, depending on the original bootsource, sounds
>> like future pain.
>>
>> The Linux driver(s) also seem to be able to properly reinitialize the
>> relevant hardware blocks regardless of where the boot ROM and U-boot
>> left them, so I don't think we are dealing with a case of
>> "unrecoverable weird state requiring full SoC reset". We just need to
>> figure out what we are missing here, out of the substantial difference
>> between the two codebases.
>>
> 
> There's an attempt at synchronizing the codebase with Linux v6.16-rc7, 
> see https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2F20260507092843.358908-1- 
> jens.wiklander%40linaro.org%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C2646189b068342c152fe08dead126988%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639138491747835058%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=brdZsVC2x7KFqDMx5h476YybGJP0hEVubzQIixpSPjY%3D&reserved=0. Maybe this is something you could give a try and see if it makes things behave any different?
> 

Just to let you know I have marked this as "Changes requested" in 
patchwork. Please send a v2 once the DWC syncing has happened if the 
issue still happens (and maybe help with the effort if you can in some 
ways). I'll not monitor this patch here anymore.

Cheers,
Quentin
