Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20D7C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 18:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A04A8873C;
	Thu, 30 May 2024 20:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fYxlD/89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9956788708; Thu, 30 May 2024 16:26:55 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25B9D8870D
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 16:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At0VvueQEefVA6lg8dCM+zWyLcpgt68TaAL98yQNAeyAT8aeubAuGy2vzKOWmabZLKellHpyFisP9REERVcRs6aJWsO65Zd1u4Pdm0QIL18GAOaqMLZB7xHf7CZ0d3j4KIzlDTArKXzKu3IUV01LfTcUZxW6nmnoV6od7vaz8Uz9tj/1B5Sc64+7RAV0IgPbVSpawnxv4H8rudfm98ug4my5XO1ZUuJN1KxCqS47CKtvPHdweYVJd1VV2P03bghnRRLUBDBEdlCBNQU5MP7cG4IcGzZxBbinHQLeJcnD7S1vccxbGiB4wjZExO00jngw/LGRXlo9x6UZ+wp4rSFD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awf9lizuUNXZaUsbjUBgH2Y1nrwR5WJF5SXSU1ppwrw=;
 b=JjMQf2+6kwuk0dxy7b1Ndfzq0R3dzfglM7vVCocBkuqrsDOftcODVfDprJu/Nq2BsJdj7MC+zkZgdHNpKBgLKWzxqNAPgPVT71e1zFO2BknsxPnPm9fVDxIQUNbWL7MRNrLwAUDQfWs4YnY2cbKu8A7qLHXhKQUrAUZY/UKo0iNCzU3Sc48OmGPKiRDyop6jiRPq1UiQW8DiEbQm5o/xQS1YYEn3gjnfwhog/R8xQ6Vya+EOtanxWkuaCZhgCgkrbkc/S+F77+NUgCRBetxecwsHxTIuh0AHp6tJAmN3BbioeZU+HHNMnrHQf0Oj1C/ciiTcUGACqouEQR2zy4WFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awf9lizuUNXZaUsbjUBgH2Y1nrwR5WJF5SXSU1ppwrw=;
 b=fYxlD/89Dhp+Dy1rcfcSjfJT8y6uBs4/BkCsvp+QClc2cSXvV4f+gnqkWLZP9X+zygDfs+EgYUAIvHVL/XhcEml+G9aZW6PgZ4SKGKlMN4IqZvliJSHT6zJLrJGC/DXaibGWV8ENcSXIbuAHS9DkCqATWFpc0CU3ZTsfvX5vsBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 14:26:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 14:26:47 +0000
Message-ID: <cc2f2d60-447d-445f-87f9-81b0eb4dbb35@amd.com>
Date: Thu, 30 May 2024 16:26:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: versal2: Add support for new AMD Versal Gen 2
 SoC
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Fabio Estevam
 <festevam@denx.de>, Hai Pham <hai.pham.ud@renesas.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Igor Prusov <IVPrusov@sberdevices.ru>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "Polak, Leszek" <LPolak@arri.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>
References: <cover.1716994063.git.michal.simek@amd.com>
 <20240529161316.GP2568172@bill-the-cat>
 <990b73c8-b33c-4ae9-b100-bfeb2f2c184d@amd.com>
 <20240530140826.GM3714513@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240530140826.GM3714513@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c065baa-edf3-4588-cc48-08dc80b48987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGlES0dTNlh2SHJIV2w1WUFINjI0akt3VW4xZWpFcHRTd1JTN3RSaGF1bWN4?=
 =?utf-8?B?SzJSYUNTSUcxd0Vpayt2SVBGZ3FibjRxOEpNSjR5SElDZVlSUXBnTDdwNTJt?=
 =?utf-8?B?Y05lTitnbW1GOGQ0YTRZNkhXMmNxbUFxQXZFUGNJZzRKbFhZdDdaVGJCbUUx?=
 =?utf-8?B?L0I4aHJuYTFkaXEyamR4SkNTYUU5ejNrSDZ5MENaWWNrUkhGR2p6Qit1STdM?=
 =?utf-8?B?citUYzBVTlU5aEpVbW9KNHRjRWEwbnBDTGE0L3NrWnRvU0dkL2xwNmMvMWVn?=
 =?utf-8?B?OUxDdTFoZ0txS0J6MnR6RENJbE54S3ZqLy8rajFBd0RTVG9YMjNsY2paaDlu?=
 =?utf-8?B?cVo3U1NwTUtxcHNoQm5IMFNpVkswZElJS2ZwNEp6RFRMcUZ6b2VuNmRFWUp0?=
 =?utf-8?B?UFJlV3dMQ2NXeTd2UzQ2VkdIRlZLQ1FEQ0JhTjlxYXYwVmxuVzhTL1VYSmJn?=
 =?utf-8?B?a3dvd3J0ZHFsWUFpVTZVZlFPa0RMbzVKYXhnSk5WYnUzTjc0NDBBNVhpUk9O?=
 =?utf-8?B?Q3Nobk9tVnVYMktIRnN3TExFWGM1Vmh3cWFOeFNyaXd4Q2pRNWRud1NJMUtY?=
 =?utf-8?B?K3BSeTJQNmxLUFY5c2E1M0pmdDZvMXArbm9lenVicFdLUUp4UWVLSlpvSXhr?=
 =?utf-8?B?OXl1ak5ZSVJIVW9sRERWNUcwdEt5S2E1M0x5Z0tqY2txY0R4VUtUWGYzMTdJ?=
 =?utf-8?B?dEF3UUlOVjF1bWk1WGR0UFZVcWdrcFhkV1FZUklYWGtJZ3JHeFd0L2UwcUdM?=
 =?utf-8?B?OE1GZk5EMERIbGJmdFArNnNwemRKZnovN2crN1VWRTgwRThmdWRtdlFVL2hv?=
 =?utf-8?B?US9rYldmbmYxUHhWUU1oSmxSdk5STVhYNHlaVklsQU5lV1laQ2d5UUtpTWdP?=
 =?utf-8?B?Rys3UWFOSTRHYUU1VDlvZ1dldnRGZDNpelNPWFhja1ZzZGNaekx0Y1M2dVRL?=
 =?utf-8?B?UU1DRG5BZWFxWVg4WjBheGRsbnhQMjNoVnVhVXpQZ3ZGSFZ0UDZscmxuYVF6?=
 =?utf-8?B?QXF5MGNjRXJVb2JPdjdLODBQaStKUG5JOGhiUXI1eHJvOEw4cld3NVpGM05s?=
 =?utf-8?B?ZkMveFZOUGlxdlA4cFB0aWllMFJWQ3RXdGdFNWwzS0FKcmNBYS9IRUlBNk9x?=
 =?utf-8?B?aldoNEdPdGdDQm9rUm5tQjdvSmNaZitpMFdsR0g5SndsYlRsOFhpYWtpSzZ2?=
 =?utf-8?B?RTVwNVhLaThWN1RObXhOc2NVQ0pRdkNocG5xZTZHYkVQd1VsK1hTRzR4OUdj?=
 =?utf-8?B?K01DdlVCd0pDK0x5a3FnVlVkUFhQZzJUK2VIY040ejluNTJoQzBQWmtrZ3k1?=
 =?utf-8?B?UmlLQ3BmS0pTTk1EcGpabThmNFo4emNYQzF2VUxGQnlhaW9ndkZsMTQzQll2?=
 =?utf-8?B?NElLMkExVVYvdlRXOGJ0VkxvVzhlOXRqeWYwZzl0ejUvZm1WdmhCVTllWjlL?=
 =?utf-8?B?c010KzBQTWRXRDY1aXljS3RWY2xLVDF2ekpxeXRSSkwvbU9HTk1Ha0kvaTZv?=
 =?utf-8?B?YWU2R2FUNldvSDJUYTNINTBwR2RNYXFieTM5S2t0bWhyZGtHVlFSbTBBM3Zl?=
 =?utf-8?B?T0lKeEdVUGszZmJZSUE3V1g1Rys1aVhubk1LYUVGVTNzd21qTGlYM042VitJ?=
 =?utf-8?Q?nY92irDYNDBDOn6862fuAh6Oy9dqgAI3oanUFFuk9GIw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjdpTXllZS91ZGFadWJiamdyUTJ0SXkvQVI3Q0FvNERZeXpBWjNaSy8xM3dm?=
 =?utf-8?B?VndQRUw2ajlYQktON3BKblhzelh2QnZ6OFZNUmdueFFKcTBtRDk1OEJldm1p?=
 =?utf-8?B?dE41ZmVUQkM5dmZOSVpDcy9WY1NJdGVkY2I3OXJ4bjJJS3dvYktLaWI2Y2FU?=
 =?utf-8?B?Mk1WYmVreENPL2UzaGRmOGtoemZLQnRwdW1TcG5WM3hhTjBjWFBta2tJSGc4?=
 =?utf-8?B?eWtQSWgzNUhwazV0cmlxQ0JxaGduTXo3NjY1enoybmlobHpJZDVTQTVicDEw?=
 =?utf-8?B?WDI1V3lNcXc5SDM1QlR0bCt5ZTRsOEpxWkNSaEZQbVFRclZodTFiM0VFenpG?=
 =?utf-8?B?YitydE5wTi95ZXBVT09ZVHVVUXpqcDRQL0dFd202WlV4OTRPN1JmSzdWUTJu?=
 =?utf-8?B?Qi9BZmZuYUVJUTRGRUE2ZzNPMHpEMThuT1JiTEIza3gyUXNyaDZhUWREald3?=
 =?utf-8?B?Sm9BenZpUXQ2UEtZUkU4Tjc0RVNGTFRJVE01OEZhL21nMUdqRHZSUVRweWZh?=
 =?utf-8?B?cWdCYzNOK3JWZ25OamhEWlVyeU1VOEE4ZXVYQno4U0gvOGJWdGtaUG0vNWVL?=
 =?utf-8?B?SXcrWWNVa1RiT1dxWmU1Sk40R2dXOWtMeFlQaUdCZEVpbDBiS2Rhak1Od0hX?=
 =?utf-8?B?TUxCZkFQMWllWk0xTkh0b0lHRnltaFdkY1poa2lqM1pobC9Cb0UxWExTSWl3?=
 =?utf-8?B?QlphZFgvb28vOG1TMzlyWVk5TmhZK1ZGbnZMYWh5dEZKckVtQ0tlMjFiak5D?=
 =?utf-8?B?UHF3Tll5NklZeEh1d3lYeWNQaE1mUjczRi92cTFlOGFlNmxzRzloQ3ErNHBF?=
 =?utf-8?B?cGVhcXdLYzlITkZxYmR2cUdQTHVMdmtLOXgrMGFFVTd0Ykt4eXY5dHBoVlc2?=
 =?utf-8?B?RWZJVGwyWEQrK1ZUL1YxQWkxTitGNUZoWDFpTkhhc05uaGVxNjNTN2FoRG9K?=
 =?utf-8?B?VE45c0FmaVRHT0p1OERFRnlETmxoYWdWWFJOcUIydXJvS3R5NGFKUVhvcW1a?=
 =?utf-8?B?TTgrQTd6Q3dZSVNCc0taUDlhTms1NzhGYnB6L3FVQk4rRjE5U2lZdjczR2t2?=
 =?utf-8?B?MmlCSmJYTFNXTDhNOCtWaElFZnNIRlRyalRCMmVpN3FIOGd2QlVrL3RzRXZO?=
 =?utf-8?B?dUhjcys1d3NGY01FUzBGRWpxZFlMaHZaSjlGZy9LQkRjSW45a1pjblVvcytT?=
 =?utf-8?B?OTh3Sm5pZzhkZVhGNUVHUnpXMUR3SW13VFJNbzE3MUJMYjUyTDhRVUYwT0tN?=
 =?utf-8?B?cTVPeTlMUmJBVmFxcCtPL3MxQXM0MzRMeXhOQ1hRQ3EvMUJMOEd3NjFPb0Z5?=
 =?utf-8?B?dG1lOXUzMHUwZHNmTmVsYi9qQWcxTGlFRFdVQk9rc0RzUGtXRTI0V3lhTnFE?=
 =?utf-8?B?d0ordzlCVnRFRytnQ09PVzNiQmhFZUdiTEVLTXlJRS85dGNISkRYUGEyUytT?=
 =?utf-8?B?cFgwNkIzcG92TU5kOFdDbWk2YzdFR2NrM1VSaG5Ia1dmZUdneWJjcFVPWUNM?=
 =?utf-8?B?WlNJcXh5bk04VFhvYXJoOERJWDlZclB3YkJOaUg3UzdXM1BDODdZNzFMdWho?=
 =?utf-8?B?TTI0Ynk2K2x2bEsrUVkxOFJoVDVodm00QVkrdi85WFdoY2dZbWxOWEp4dEw3?=
 =?utf-8?B?MzhnK1JlZWUvcGJleUlqU0d0S3NBQWVVd2oxdWhMb2VMRm50RE0xenc5OS9p?=
 =?utf-8?B?bGp0U2VZUkVNN3dIYlBWVnJMdXhmUUVIUmVaT0NleHJZU3Z4enJvcVdPSWM1?=
 =?utf-8?B?QlVMbS8xbVgzaGhZRFlrTHFZRXppK3RCbk1JWWF1ZVhaSitXQ0lYYmlwTENi?=
 =?utf-8?B?cm11YmJIME41Y1RJYzdzam1DMkxNalpsajNKR1Uza0psek90aDdmbHJXRlkw?=
 =?utf-8?B?d3BzY3dsN0doU2JrWk1zNFhKVHhhL3UwdGE5Ty9hY0N1Nk5HdlB5dzhqcmsr?=
 =?utf-8?B?UmJoQ0NWU0VnVnBoZ3pZRitXZGtBV1V6T1lVSGlvakJUVkpSWU9pc0QzTWh3?=
 =?utf-8?B?UmxFVlFFSFhlUVlWRmZoc1ZQRllSUFZqenZIUjJtMUNObzFtLzJiZTF1dWMr?=
 =?utf-8?B?Q0czbC9pU2EzWCtCSlN3V1FYYXUrZjdUV3BXT0pMSkJsM0M0WkE4YmZxb2hB?=
 =?utf-8?Q?IT08jtVnj931BO7jOQFfavJPc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c065baa-edf3-4588-cc48-08dc80b48987
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:26:47.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQ7fzGpq+4Eeb/weWsiNXytwpSF/+qJxM670LY5mobGo6H5ACCm7Zfr3Qgrxsl3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
X-Mailman-Approved-At: Thu, 30 May 2024 20:01:25 +0200
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



On 5/30/24 16:08, Tom Rini wrote:
> On Thu, May 30, 2024 at 08:04:07AM +0200, Michal Simek wrote:
>> Hi Tom,
>>
>> On 5/29/24 18:13, Tom Rini wrote:
>>> On Wed, May 29, 2024 at 04:47:57PM +0200, Michal Simek wrote:
>>>
>>>> Hi,
>>>>
>>>> I am sending patches for adding initial support for new AMD Versal Gen 2
>>>> SoC. If you want to find out more information please take a look at this
>>>> page:
>>>> https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>>
>>>> Michal Simek (4):
>>>>     arm64: versal2: Add support for AMD Versal Gen 2
>>>>     soc: versal2: Add SoC driver for AMD Versal Gen 2
>>>>     mmc: versal2: Update zynq_sdhci driver to support AMD Versal Gen 2
>>>>     spi: versal2: Enable spi drivers for Versal Gen 2
>>>
>>> My only concerns are name-related and not-blocking. First, should we
>>> perhaps instead have arch/arm/mach-versal/{gen2,net}/ (and presumably
>>> gen2-net down the line)?
>>
>> There are completely 3 different SOCs only names are similar
>> Versal is 2 cores a72
>> Versal NET 16 cores a78
>> Versal Gen 2 8 cores a78
>> with different features.
> 
> That's good to know.
> 
>> Creating subfolders under current mach-versal would be very confusing.
>> We can definitely try to make it as small as possible but still they are
>> separated families.
> 
> Again, I'm not nak'ing things based on the names but I'll point out that
> arch/arm/mach-k3/{am*,j7*}/ contain a good number of A53 and A72
> platforms of varying numbers of cores. But on the other hand, at some
> level they're all part of the "Keystone 3" generation / family, which is
> not how the Versal parts are handled.

For us it is completely new generation. There are some sub variants which can be 
handled like that. https://docs.amd.com/v/u/en-US/versal-ai-edge-gen2-psg

AI Edge, AI Core, Prime, Premium, HBM but we trying to handle it via 
common/shared target. If there is a difference we are trying to handle via DT 
and enable all drivers via generic defconfig.

We can definitely take a look if make sense to create mach-xilinx or mach-amd.
It would be best if we can pretty much get rid of all these folders but I don't 
think we get there anytime soon.


>> We tried to reuse existing platforms but it is hard to keep it in sync
>> that's why new platform is better way to go.
>> But as you know we are trying to reuse for example board/xilinx/common/
>> folder as much as possible that we don't have code duplication.
> 
> That's also good and reasonable.
> 
>>> Second, and I see I can't say we should follow
>>> the Linux kernel since there's no versal dts files upstream, should we
>>> still be "xilinx" and not "amd" ? I do see the kernel shoves all the
>>> imx8 (as an example of a modern part) stuff under
>>> arch/arm64/boot/dts/freescale/ and if nothing else we should be
>>> consistent between projects whenever possible. Thanks.
>>
>> I am not going to send DTSes to U-Boot and just push them to Linux kernel at
>> right time. And target is arch/arm64/boot/dts/amd which already exists for
>> old amd socs and elba (pensando). Versal Gen 2 should go there.
>>
>> It means Versal and Versal NET will be branded under Xilinx and Versal Gen 2
>> will be branded under AMD. Also we are going to stop to use xlnx, dt
>> prefixes for new IPs and will start to use amd, prefix.
> 
> My real only concern here is that we're consistent with whatever Linux
> Kernel people demand. It's bikeshedding I'm really not inclined to argue
> myself. :)

What we looked in past was if we can put together platforms with gicv2 and gicv3 
because there is low level GIC initialization when you run in EL3 but we didn't 
finish it.
I think the first step would be to get rid of include/configs/ files and then we 
can look at other parts.

Thanks,
Michal

