Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F8ACA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9715A80F03;
	Tue, 29 Sep 2026 12:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01tYTDCIzm8l; Tue, 29 Sep 2026 12:53:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6746B80EEA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790686381;
	b=VqQYujz0RWm9GfKldeOkSM47Rdgmp7Ri/3JZzyWvgcuWxHC16YD3n4aGdeNJTIRWykg7
	 qtzYHBOQkR8RVi4qVU7Wp8XTmllRx2+PMNJlfcRrqnN1x/bTdtNWUIpEP+5tDcUYwMZ2s
	 8iWZ7q5VK74Sze25DyzzSElrtFIjLlAg2MujUu+JkblJAhljGlDU5UKBjUAD2FQ1pWO5Y
	 kDRDec7pyJ24tYlt9ARlI25ozM3J+OjOqmd8Z5rQXLFRRbONGj8VNGMMct0XUw6j7H2RU
	 LvLX2yQdKHwjDQQeySr0ZlGExRP9qrt40kl+tfTehyvTud8ZT+xFwoD76T0PEDg6uaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vgB5QxUmaRCDUPUCDuUpY+7/jYysycz1FDqf59WQTYI=;
	b=rgjs3bConX1qmx5WsAGmeTYsdmYcQinV33jNx6y4fTRzvFtvJcognpx6xkW6IVpyKnub
	 k4CVYEETJAfwfqWq08hbkRR0tXwb7tWXG0shqnQtgmvv59I1Jrtc4AR9KaVva5c81IAoX
	 DaIDlKmcPkFA4VvNx/gvQrxkZe8nBSQmhvBNB/w1A4CVdKE18HCSYdMHNGIssuxdsI6Jv
	 twTI5set8NzNxMfkaWNPFgbSL//7vxfgx+YLYHV52I1S0tf/YgeydZBivTcjrJbGwHvx1
	 4UzuUaQRDYHL3ZfTIf8ZUUgPo4de5GGE6bEavR2+0RJUipsWxkhbPpCAfaVy3TohWfw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686381;
	bh=vgB5QxUmaRCDUPUCDuUpY+7/jYysycz1FDqf59WQTYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jlTe0sLEOiS/qB3FUIkVKxp2qj95OKHDKe75R+uIJBErNAu+G+aA33PgTey57YqvS
	 3CBsjCbJD23lWxWbI30lXk0JhVTipnAohMOEFZypIXqaWNomiFdC2SVNizR/GJ13U3
	 nIvr5t8jIuCex+sOJZJqxRh+r7rFt1B8mIzBWK5/YtbAzjTfCOWE6gqDR9S8eHerv6
	 LNjZIqywzOdyeRuiYySdn5EkXEzjcNgDhVYgoix8dJNYSr83QZMU3opkoyMDgdthyr
	 sAF93/SvRmdsg28hwD/1fdhdANP31/7mysFEkRBofYIIQRv9ZWKMvODA7bslvY09iN
	 +gOeQv6D4sO6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6746B80EEA;
	Tue, 29 Sep 2026 12:53:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33E84417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 255234027A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:04:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PnLYwNUxxmjb for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 09:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2989340270
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790672695;
 b=oM4kZCeC+TDpZHhfwWUCmE9VdeoP34ojx1GU/ICBtu5Ip2VCfY2M208uYUVTNne+kBrF
 dmM2EHl5FylEEnszsu8InQhh3gHeS5Ti0xvy1rs/2QkW8QdGI4IcmcF4U+XXIxNNGZXri
 Hptb2stBE2/giMdVGvQ/M0Kc50FlnEeEjQ4ocvbddiTnyZOv8KfOrw/U3WevEEqwPvZRp
 kj8biBUQ/NCsn/XXda4OmrUR+dXg8DYaF4MQAQDS+K9D5G9TFeh27MP7vdwb2ZERmFsJK
 pMEUqta3XqAuWWXjTZtW7RqTUtFr47O+TIcUIXF+JMXCt8zf/EK/+mTyDTVZ5Ao7nDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790672695;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=vgB5QxUmaRCDUPUCDuUpY+7/jYysycz1FDqf59WQTYI=;
 b=hiFsjeNMS2wCXpXz3VQ0abnfBqLleamHpplx8NUSDdvNVkW+2KqVAdmqgr1bdw9jIUCj
 gSidF10HnNnmS5T4Zd7q+jssmq6avi8xmP/+7Mshlm8cBv10JjNZwsnKaxEs/dbyIOxA0
 YRswxHqppiYLhFN5PKALtsdLMhXr6VIQqVfPhkQcIDYyr0OIdzu57InT8d9O8sRFxHAZw
 7h8y1HPO4Pli+ZfeG4nRDHkSjvRTKYldxCpwUJjxUMrVQk9Qh1EUjW+3ND49NoX6SunmB
 u3wN/ooOtWWYox4oKmZ1uQPFxGWaBj0x5GvI8FYVuMJihJacuT3J7a4LeIABFN67sPg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gD12zQzB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gD12zQzB
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2989340270
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMhEzSxcIWDu0IRaE6NmlRFDyufrjlpmDxGPt11Zi9BBFjkYJ+eMVCuDYWMT/1G0XmQ40eFoY3ZL88ZJGjwL6IHRuG5OzJ2nMSFW2cujICrh5ZsW3uwKODGLagJ+jmrIp660DJLMMIkKoT68igRhxF/0dNaid3jebYwL5P03yg+yMTneFcULwRC4hvu4sefdUuvmw9cOLJ17NezpZykheRRDLqIkYUhCOOkbZqEPl5YFp9tmpKRXYXsqIgDytiGaoPvyaMBQj0wx0UftXxog4C/XQ6yaNUPw9hbt9rqmoZ0YPNNkt2sQDFI53ThNMNfHC9/P3LG5VZq1dzQqpf+IVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgB5QxUmaRCDUPUCDuUpY+7/jYysycz1FDqf59WQTYI=;
 b=sCRU2z8WyHtLI+KPW3WTnEveOU8vFzzoU7X6KAQgBFl/T3A1Cz8yhIiid3QzLWPKkwQX4reHSg8wEhRSGk/vOqveKNkPRUVJMi6GOL/Ez8WO+tmNE7r7UIEBbRd3U79CWRPmkTPnPxjnF0uxsupRSPC1l0j5Z5KkHN9rfOnAojMTBXD2Q0k8F94RGAuCZujhxC5Cy+6b+rrYpS4OLbVCvxOyLkpjI0TBWGKzPLg5pBv1WNLA5RS1PI7uO/mFIy+E7fhJTlRQvwNaJBCp5MW0EUlKHJ0qKH1gXwUvreQOHuv8o73YFcAhaNUwAUU8IOnqJfVJiHdJHzxaKt37ZH/xiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgB5QxUmaRCDUPUCDuUpY+7/jYysycz1FDqf59WQTYI=;
 b=gD12zQzBkb8Th4pYpoqb64SamrC2R7uHnz8Z2vS8c2C0YttG2TZuDJeWFIJsFzNxzO/L4DdT7JNsBhK9speWvzbF94TzDwQVxAMr8AeClX9goxyCVWNW+cEZRU/riJcvZR81Q865YdU3cW+BCAJMqMKp4Kh26K81QsrIoPPbKis=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 09:04:46 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:04:46 +0000
Message-ID: <2958f55c-b435-4b95-9057-0b542eee8cf8@cherry.de>
Date: Tue, 29 Sep 2026 11:04:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?=
 <joaomarcos.costa@bootlin.com>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
 <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
 <CAKTNdwEQSwVBaa=aRpAkQc5tj3Gz1iLK7ftCvJH-2jNiRwrMvA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwEQSwVBaa=aRpAkQc5tj3Gz1iLK7ftCvJH-2jNiRwrMvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0149.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::33) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 271a971a-bc17-4690-f9a7-08df1e08b527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10070799003|4143699003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 57WVDauvki1sh7lwNJ4EBs1do1YxBIzkMNPiJd7RwUDx3io51IZyxiXjOX4uzszyLQIf96EUM6uUNF9wlI6nKf4wcU8liOAu5dHhdokuYiajDHDa5/x8HCI8QtWj4EdPhiUbrM/oASozTlMC0xSeswV2kWfX8cuKxUd6HNI7FcwmuFxfIJy4EcI0nzFbbAW0U3n/KV2sAgTUN/q8gFI/GVRgaaMKhKcFqojeoRe4TzqwKVghVFIme2J2qB2odl7trwNXFSx/cQv/D2Pq6KWYji/f+2wAjwwXqHnMaOzIOxEWFia9mEPFsVAwRRjXlT+oNKUWfHCElggi1oiZ0zGchTKv9MS5HFTBwHL//HDqs9bUVSRWpPz01nWm3hXirE60kBoFi/NG9tygMNja45PLsxBVjvSnMev4gPp7jhf/CtXlIgjY24H7N2MOy/zFQ3cWyUoasDoAZaqf7bRvwaWqnr2aFqtpqutfT0IzHDPAfmbubjbYnsP5wQKHTPkniv6lor73JzDp9UrIqE+T2IbjIrAT3J8Q7yWlL/S6lSUWQLJsSgcgf60EBI7ose8jjmk2ezYA5o2v0vpJQZmRtCSgL1+kFbPonnCYwrvYLbt7OtTG3gW9TY68I0Vj+VJYtHVB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10070799003)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVXRXlKSzQvTjhJbElnK0NoL0RQUlNSMmpVZmNxTitWOWhLQkk2K0R5QUth?=
 =?utf-8?B?ZG5XbFRPcXM2a1QxZHdHalNIR1pycFhEWjhTTWhVaDIzVXZjUjVpM290VHlt?=
 =?utf-8?B?QlV2NTEvQjdaZDdGU1ZxS3dvaWlNMWpsaitiZzhRbTJJWG9KQWFQNnBaZTJv?=
 =?utf-8?B?TDBzOVM3Tnl5T3VRem12MnJ1OUltc0IwUUdRcTljVXB6bE1wN09LZ2NSSlFp?=
 =?utf-8?B?ekZnWjBJSGhLSDlPajBmYzJzOXpXeVhrdWFYYTAyRHpDWmw2VzRXKzMrZDVx?=
 =?utf-8?B?WWFXUnhhT2l0S0p2Y1IvUnljV2lTYmdDSUV0UnRsS29OV1d2L1JNK1c2bkV6?=
 =?utf-8?B?bjgwRWpwc2pZSHErLzZsRVpaNHZrRHdhRmhQeUU5bi9VUmw1dzZxSHRpckND?=
 =?utf-8?B?SkZXYS95TXNsUlFMb3daYkNJMWZWQnIveVdiVGVUbDVmSGN3TXF1T3JJNWN0?=
 =?utf-8?B?cFpFd3FudXpvd3V5c3FPU2pXNVhQZmhhUFdHdXRpM0tVY1pGb2s4QWkvUlZl?=
 =?utf-8?B?QnBaSlhqSWo0NUkreVBKc3pRb3YwdG0wbHlvUFk2czU4QmNKNXZpL0FWTVBz?=
 =?utf-8?B?NjIyeDM2ZlZJeUsvM0JIUytZb3hQMGhHeWhEM3ZDWHhOR3ZFM3JadTNabkF4?=
 =?utf-8?B?amFxTVhnWjFjU3l0Q2U5WVZEamUyeWN4Nk8xQkt0ZEZ3dFhLaEo0RnNXNVk5?=
 =?utf-8?B?eEVyZ0xqU0lOS2h5ZTdZMFI0elM1Wnd2d1Y5UFBPbWhRWkVPYmFpMW5OM3NK?=
 =?utf-8?B?cHZNbzF6eXY5VUNyMWRlVkQ2SWpDUkd3WDh6Vmdpc09ZSE5wM0VSNWluOHN4?=
 =?utf-8?B?YVM2Q0EyRUtBWm9CSFZhZVVYcFJOdm1SWmlnVXBpajlLbHV0T2tBdUZEU1RW?=
 =?utf-8?B?dU9OVC9SYUM2cWJ3RG5Ec1ZFbEpQd3N2RFlyTkpnZGYwTSszdExORnY2STlX?=
 =?utf-8?B?eUIwcExRQ3pTTHM5Nkt4VXB0QWs4ZW9TcURNcjVEdjFzeGk2Ky9Id21mZ0tV?=
 =?utf-8?B?aVBEZmdyRFdMdmkrWmI2VG5TZ1hlZG9Fd1VqQ3M3cEtDSjFEcFlXczBPR2E1?=
 =?utf-8?B?dyt3TnhPUnBtWDZHNHd1RDU0U2Faa1RuemN6NEFQSWRpTW0wN3IvMWxSa3Zk?=
 =?utf-8?B?RXBPQ2RROFdUamJLN1VTaGxFUDNHTHdzcWJNMXdnUkhDTnRUYnZHQ2hiOGRJ?=
 =?utf-8?B?RGJLYTh4M2laWEVZUkFubmNCUmpuUmFRQkF2SWhCVDRSTHVnNWx6TGJ0Qlp0?=
 =?utf-8?B?NW5UZzY0U1g1U0JoY3hxRHFxQWJJVHhtODdTc0lzT1ZObExZWjRWWUtkWlk2?=
 =?utf-8?B?UUE0RC9oMm9SaWE3RHM0K2x4Y1NCdjRHRTFuQW5sWE9HMVNOQlRFdzNxR2FT?=
 =?utf-8?B?YS9tUjhReVNDUWZqYjk1WWtvYUVxS2pFOHNxNDVYQnF1NFVCZmwvU3VkRCsv?=
 =?utf-8?B?a2hzN2dHM09ETWt0aVR4S003WDZFQjdVNmhrYnk5YlhHRld3ZkIrbVZoUjB0?=
 =?utf-8?B?NnVQS09Kay9DdkJJdmlDQ2dOekNiYW9nVGlTT3FHemxqWjJ6QkJqU0JCOE8y?=
 =?utf-8?B?RW9iRlRQbWV1dXRodFRPSERsVmlOanVZZ0tqRURMVkt1RE9maU1RWnRZNUIz?=
 =?utf-8?B?cTBnSHZEOGRrQlhvT1JRMTR2RUlFZCtXa1dvMktwUlFGMHBDck1pMjVaSFhM?=
 =?utf-8?B?SStrVG9SakdYL3YyYlpZL2VUUWRZcys0b1M2V3UvdEtQcG9LSTZPZkhzVnJI?=
 =?utf-8?B?V0ZKcXFkaGF3aFh4NnIyVHd3RU1DWXgvTGpPNUxMZ3pXOEQ5K3o5YjE3d2hH?=
 =?utf-8?B?RmZlNG4zL2hPcktKd3VaUk9zMGZsRTliSDA5VUxrUjJQeXFpeDF1d3F2VU9V?=
 =?utf-8?B?QlE4eDN5V0l4Nm54QjdTR05RQUdIMWZyanBkRm9sSVdYTUJCSlBTR2pLbzZF?=
 =?utf-8?B?SHAvY0xyWWdrZ2ZrdHhYNlpoZGFpSUgxTDZCaXRxaWUwbUZlUXE0NVRuelk5?=
 =?utf-8?B?T0VYcGxBM05GUkZENHJJZVlER2habng5U3EzV0NSQitDN29wR0NCUWt0TG9O?=
 =?utf-8?B?Zmp5TE00UitYTzhSL0ZaMkN5d0lrRkZ0T0RlaTN2aURVV3pUeVlJdEx3ZFR0?=
 =?utf-8?B?TkMwZmdEWVFnK2FUeGNRTHdDRlVWTVZiaXBncTNiUXhMNWhFVmtjbmk3ejNh?=
 =?utf-8?B?enRvR1Z6Yzg0bjlub0ZFd3ZPVE9wQlpzS2tCUzNrYXhzM29iRUs3TWpqK3JE?=
 =?utf-8?B?NDdqZDBuckVYaW4xd2w4dXI5eTI4Q3ZGTC9OSm5hemN5UXdoSUczY2xYTmFV?=
 =?utf-8?B?eFRJZkF1c0dyOGFST3VtVVJaU0RqU3AzN2pUMm96SkVnempZTSt6cFR4ODlG?=
 =?utf-8?Q?KnTFJTBlYkoEutbm/VnAdV9pihXO68xHssN+sr9XGLxvk?=
X-MS-Exchange-AntiSpam-MessageData-1: vpKwle4xiNzSaDSMAd+qBv6j4pKmxjNjgNI=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 271a971a-bc17-4690-f9a7-08df1e08b527
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:04:45.9071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orf/O0dV1t8jgWglz69pZF3zE2QN1LHYCNeYCnMnGjm9yWPE+5yWEOEXT5lSmIVxb0+rGbtWR6jTmGjV5eao48k0PbSk9aZ6eeC26a4VlMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:49 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 9/28/26 6:11 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Mon, Sep 28, 2026 at 7:14 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
>>> Modern Rockchip SoCs such as RK3576 require TF-A to be running to provide
>>> firmware services to the OS. To enable booting Linux in Falcon mode on
>>> such SoCs, add a binman template for generation of FIT images containing
>>> appropriately split TF-A and TEE binaries (as is currently done by binman
>>> for U-boot proper images), externally provided Linux kernel and optionally
>>> an initrd.
>>>
>>> Any FDTs provided to the generator will be pre-patched with a /chosen
>>> node containing an initrd load address and size (if an initrd is provided)
>>> and a bootargs property containing the kernel command line (if provided),
>>> so that the kernel can be booted directly without external preprocessing.
>>>
>>> A config fragment rockchip-falcon.config can be used to enable Falcon
>>> mode boot and the building of TF-A+Falcon with binman, e.g.:
>>>
>>>     make nanopi-m5-rk3576_defconfig \
>>>           rockchip-falcon.config
>>>
>>> This will produce a FIT image u-boot-rockchip-falcon.itb containing TF-A,
>>> TEE, Linux kernel and optionally an initrd, which can be flashed to UFS
>>> and booted in Falcon mode.
>>>
>>> This can also be combined with the existing rockchip-ramboot.config
>>> fragment to obtain images suitable for booting from RAM, e.g.:
>>>
>>>     make nanopi-m5-rk3576_defconfig \
>>>           rockchip-falcon.config \
>>>           rockchip-ramboot.config
>>>
>>> The resulting images can be uploaded directly to RAM via Maskrom with no
>>> storage or USB loader required, e.g.:
>>>
>>>     rockusb download-sram u-boot-rockchip-usb471.bin
>>>     rockusb download-ddr u-boot-rockchip-usb472-falcon.bin
>>>
>>
>> I'm sorry but I don't see the benefit for U-Boot to have this complexity in.
>>
>> I already find arch/arm/dts/rockchip-u-boot.dtsi difficult to parse, and
>> this is not helping.
>>
>> Moreover, this has almost nothing to do with U-Boot, except:
>> a) it uses U-Boot device trees,
>> b) it concatenates SPL with the Falcon FIT,
> 
> It's that and also the maskrom-ready loader images which I'm producing
> with binman [1] - though I haven't yet sent the respective etype for
> review.
> 

I (and likely Jonas) would very much welcome this. If this is what I 
believe it is (a boot_merger equivalent), then it would also drastically 
simplify https://github.com/labgrid-project/labgrid/pull/1721 where we 
can get rid of a bunch of things that don't fit into labgrid model and 
finally get this merged/reviewed without me complaining too much :) This 
would really help for board farms also as remote controllable SD cards 
are *expensive* (for hobbyists, at lab-scale; c.f. 
https://linux-automation.com/en/products/usb-sd-mux-fast.html works, 
maybe https://www.badgerd.nl/sdwire3/ would too but not tested, anything 
else is unreliable with high speed SD cards and it's not easy to find 
slow SD cards and it's also not fun to have everything run super slow) 
and constantly writing to a permanent storage is not great for the life 
expectancy of the device (and once the onboard eMMC/NAND/NOR is dead, 
good luck replacing it).

> I must admit I'm not fully convinced this patch proposes the best
> setup. I'm facing the inverse of your concern: my build server
> needlessly rebuilds U-Boot for three flavours of Falcon Linux images,
> only to discard the resulting U-Boot binary and use only the FIT
> containing TF-A, Linux and initrd packed to U-Boot SPL's liking. It
> surely feels suboptimal, but I don't see a viable alternative while
> the U-Boot tree remains the upstream for binman and its templates.

We can always have an ifdef for the u-boot-rockchip.bin part and in that 
case you can simply unselect that new symbol and 
CONFIG_ROCKCHIP_SPI_IMAGE and only have CONFIG_ROCKCHIP_MASKROM_IMAGE 
selected. It should build less (though I think it may still want to 
build U-Boot proper, haven't tested to be honest). Is that something 
that would be useful to you?

I unfortunately haven't looked much into binman itself but there are a 
few oddities, for example: 
https://lore.kernel.org/u-boot/04fd00f4-1bb6-4a29-8e1e-83cdc1b03b74@cherry.de/.

> 
> [1] https://github.com/flipperdevices/u-boot/commit/316741fb254ad652ca8892d4fd52ec0ac628af69
> 
>> a) You should likely use the kernel Device Tree instead. Even though we
>> sync regularly, we still add our own stuff and may lag behind. The
>> Device Tree used for the kernel doesn't have to be linked to a given
>> version of U-Boot.
> 
> Yes, and I feel that pain by having to reimport all my Linux DTS
> changes on top of my U-Boot development branch to apply them. In a
> "stable" world the two should be the same though, because "DT is
> firmware" (or so they say :))
> 

Ideally, it should go even further than that and have U-Boot send its 
own FDT as kernel FDT. And in an even more ideal world, the FDT should 
be finalized before the device is even available and we can all enjoy 
the same device tree forever. But everybody's seen vendors' Device Trees 
so I'm not sure it's in our best interest to allow that (though I 
vaguely remember seeing some effort to get the FDT to be part of some 
actual firmware somewhere, possibly outside of anybody's control, I 
guess akin to ACPI but I know nothing on that side).

>> b) You can simply generate this image ad-hoc with a simple cat (taking
>> into account padding).
> 
> This would require splitting the TF-A ELF binary by section,
> extracting the load addresses, and reassembling everything in a way
> that doesn't deviate from what U-Boot SPL expects, including applying
> compression in ways SPL understands. In short: I need binman and its
> templates anyway.
> 

Yes, but that's not U-Boot :) It's done by binman which is currently in 
U-Boot, I get that, but that's not U-Boot per-se.

>> Also, this doesn't take into account boards for
>> which there's only an SPL, in which case 0x471 binary should be SPL and
>> not TPL. While that is already an issue with the current code (which
>> would generate an empty 0x471 as far as I understood), it doesn't
>> improve the situation. I'm worried about the increased test matrix
>> needed for this, how do we actually make sure this still works and we
>> don't regress? We would need a gold kernel binary and initrd on a
>> supported board and test that.
> 
> Golden kernel binary and initrd don't sound particularly scary - but a

For the 1604 (ever growing) boards? At scale, it gets hard. But having 
one example board tested would be better than nothing (then the question 
is where to host the blobs, so that it's reliably accessible by our CI, 
so unfortunately github.com is now out (and mostly everybody else :) ). 
Wondering if we could have a falcon boot on qemu for example, that would 
be a good start!

> CI farm with all sorts of Rockchip boards supported by U-Boot would be
> great regardless of my dirty little edits here. Not sure how to
> approach that one, though.
> 

Jonas has one running labgrid, with many boards in it. I have some 
hacked-together-held-by-duct-tape labgrid lab at <work> but I would like 
to have one myself, possibly accessible to the U-Boot project but I'm 
kinda overwhelmed by how much there's to research hardware-wise to set 
one up (mind you, I did one 10 years ago at <work> based on LAVA with 
40-60 boards). Especially on the "need to remotely control wall warts" 
part. I don't want to go the WiFi controllable route as it won't scale. 
Professional switched PDUs are prohibitively expensive for hobbyists and 
the ones easy to find are usually for server racks which aren't really 
working with typical wall warts. Ideally the cheap (but electrically 
safe :) ) WiFi controllable kind, just Ethernet/Serial/USB instead, 
ideally with multiple sockets to lower cost :) If anyone has anything to 
recommend, feel free to share :)

Cheers,
Quentin
