Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D969CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BDAD61056;
	Fri, 16 Oct 2026 13:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sSW55SHHIbL9; Fri, 16 Oct 2026 13:24:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B130F6110D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792157077;
	b=gDn41wC+ApTKBZbUZE6+LnZ4Z8bQ3fcI93Q1uZ3kvKMKHejM5h6keRIaLxuHdZ1fRYSC
	 3Uikcxb7V5SrZGu/kkDiyF3U81Xub8Z5+A/XO2rPJdIzwPhKRaXgBWnJr2fs+NW1yRmP1
	 dmbr8DxSWyv9WxUzm8IkUEcSPMearERc9Qt/J0pAevqNl03WN6//ONugvwBmReo+kayzQ
	 RM4D285gBxNhS+ra1mkXbed6jEuhOpLA8Gp705K6/s7xsl0Ukq3vraDt6+4T9c7e5eGiQ
	 uIQOtTkY2bwZLWco5oI0KDBFk85M+aDBa8riDc9GEvuEPNDBcZZS/wp2lPJo933lYwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157077;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
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
	bh=3pkJWfmHEiMwkZgFysiBjoSeJQRitS6HqjNIjQ0ZJDg=;
	b=YluXJUS1TP4tQz9AQb9Fi16CSBDwrE65izoi+Tcm0F9AEZ4Z2MDW9+KGHG/pMPJz98u5
	 wVmtoljzU+7+JGYdxfKt1A54CseKUtPJa3fdUGLF1ZzyBMkBuKGPUsf+N5ETl7IL9TFxa
	 MxmjnYWseRxqo/G13kyoXJyIlFmlHDIzI2aHC+m1aBUgWXEE8j9Nj34QFvJbGCkvrU03A
	 u+ddemzA8jgl5JbcdlD/EHuKk6kKrN1NdH8rDhzfqff5CACtah1iAHT3A4Pa/QjJBHqbc
	 OSXiBmn55ekiniH6F1j9oT0xnqDRIPbHzVMLUwBqbb0ioFniifUtHlCd9Qfx2qL7kiw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=KZKFZWg4;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157077;
	bh=3pkJWfmHEiMwkZgFysiBjoSeJQRitS6HqjNIjQ0ZJDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=smfcY3UzpovM6Jeab4hP9sQJ2TrSDBl7DAXmiYYIb4+leKF/Cfu1Zu0PVkijPQsGw
	 0gyLP023pCmM4g5v7ZJ39oxsWnTm37om6L/9Owto9eUKRSUE9flxoA6rtx+i7z3thq
	 rV1AUfccXqaZbMQyWWnBzipSzLkxYWM2bB4gi52LmD0X6W6qTrx2w0ujWRxi0HlilK
	 gNRxIklGrMEX14d3zcqyXOAdITTMLj+/2wjp9803kx1qbFdKUhd3pZHNhuOajBSnhR
	 l5hIG1HXhlgQsDZiiU89Od/4qwvbqYFbLbfI605jJZ1tET0jjr8hojXnWyncTcbauf
	 s8K4/JnAWWtSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B130F6110D;
	Fri, 16 Oct 2026 13:24:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 017221DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E607B608D1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cebajb9WLdXB for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:52:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F0AC36060A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792144326;
 b=CuhvtHsz6Panul6dvGvzItct24oIL9peYuSFdEMFCiNrPer+bm1Qyb6dV16Zb+FdEYVr
 bPlIGgx8beO/D6CRfHtwhaehMSlMZp+GKx7EyhgySTtjKP1IvdAJK5SUFhVJvTXJHOgoD
 qWPag0/Iy7Cs3ubP2LW5vFZWIkqe8sYmxdYTV1b4z5dYP/G8IgKoBu2hT1BsmY5n7VSmT
 c7EcofrUiE0ZE2cSs6GM+3Pjz7dyCwFAOLkBbsf+iRQL7YHxC4wSjVc6A6FXJhi3Bavur
 MvkGMbGIRgIK7RZ4IRt4Z5GWOzk6ryGRgxNanZ0rHrNQtsZx315KijfantsJntZlZJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792144326;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=3pkJWfmHEiMwkZgFysiBjoSeJQRitS6HqjNIjQ0ZJDg=;
 b=eqeg3hKdz8DDNBkOB7iGoBRGAfm0T+rGSzBsnjSAAnmX1TGv/9oQ0Gl+Xwf4P01AVwcu
 DR+zo4DNF/lDJ/ItbsdNQojn9s4mNeAxus5OSWSxmY5aDGhw949veSKnDl4oOBi6CksLy
 Hit0GqFAqXyuCVv4lcneEdwaTmDbpLzYG/j0cd4wSEF7K7e7GF27Vfd4dUyVRNcdSDc1B
 XBsD37dL2SLZ+JGuqQsfhwV3oKRmlIsy78d17BLtgBsjlozQ/K+Npw64V1zjpVPVkxbgy
 vZFQRdzQnXJZMwYcNJofeWGxz2n1LAWhvXbIJWjn7RblURPxIUW6O2ptq3IDnox4kwA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=KZKFZWg4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=KZKFZWg4
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0AC36060A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb8edppCQ8UuBWIAZ7+cm34QbFy8Bx+OmQfQPqqwdqB5xbLKNg7qIp//CvFCyl6LuidNMZdxeLXVuP4SNARb5Nascp5fU+9UXRK4Mz/jpk+pFOcl1UNLNGgYGc3Vbb7ZjR+UK4pCwwyogHm4xncGgydpYCKXpaImyVI6wpNLIE97zDfXPj9FGugt9aPoq2QTGwXG13oGT8d+4DIbvgqFdyxu/DNb3Q3StzyzASiidwPCRb2kyXymxP00yntxDnQQM0hAXLtWETyFtbB2qY+1BKDgAXgtAurd+5M6uqXCN3F4sJZVmPLXe6JxHeWPdP6luO3+a4BRxlGVrs2/VPAOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pkJWfmHEiMwkZgFysiBjoSeJQRitS6HqjNIjQ0ZJDg=;
 b=SgQQP2L6obKLIhk5qNRG8VcPtQGHI+ZyDZA3A1l0qWTfnJiLjkmj4MOvLHnVuJQLdq08aeOP/lil5GZzsW/XHYnU8L1PsK8HeUpUdrIcE4uFoSBXwTJ5783mY26lwtcnzmdXueOrP5A7TeoNao9WKgMztR1m8lscsXXxf8jGEWa66Zdlt6qhuA4WGLnBumcXb1QMmu5Ddi8jndhILmm3Mj6nWuZiEGGp6uw+wTS1u/F/Eh73UmMZXYb7YMd6Bi2TFu2aIaOLI41bN+fHzs7Urhug8LhIrkThL1qD1cr5NGItNS4fOlKE0frnwHGnHNCeUciFazvzorYM9ZnLFExFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pkJWfmHEiMwkZgFysiBjoSeJQRitS6HqjNIjQ0ZJDg=;
 b=KZKFZWg46bBKSc9h0kD9qJOMsbhI+tpPJNx+23rRgMdHvYuOiVxmhSvE/3CNwO0InBC/jcF8UBvPbwro3jzx8v5ggnt6K4dZeoFkpu1NKEad03Nt+3GH+Z0LPuGg2gz7HcvL4FHAnILjxoabzYrQS/SJZA66wXLET0RSWeeGsmM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:51:59 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:51:59 +0000
Message-ID: <5ebfc286-47e1-4151-a51f-2620031838ad@cherry.de>
Date: Fri, 16 Oct 2026 11:51:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Simon Glass <sjg@chromium.org>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
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
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
 <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
 <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
 <CAKTNdwELO46dZ1Cy+-wpBbQNsP9XJyTgCjBYLQpE39YJ3XP0wg@mail.gmail.com>
 <e7235ec1-dff2-44fa-8c02-9b6a1012bba6@cherry.de>
 <CAKTNdwEgVRZVFr+V8jCwQmJES7PO3WgdBa5es4EkkOy50xdkiw@mail.gmail.com>
 <1cc78fcf-bc97-42bb-ac67-792ad047adc0@cherry.de>
 <CAFLszTi_8=bK=gLEEadunTLumaGo8L8enYovxFadCyzPXorJiQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTi_8=bK=gLEEadunTLumaGo8L8enYovxFadCyzPXorJiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0058.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::47) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 1195b0c7-a4fe-4f8b-4c67-08df2b6b1ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|4143699003|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 3jbixtayXlYPdgzXNZpbqWtOYviNti9m2ftdKOShQseMIpcDXCJ9E8wq4eJgUuDrdVPpGVrqk+XOODGNOMpmUqzEGO2zPoYUjnxjEfc+9H8nNqYfLcYY5eWHzmGqHGLttgDVUI6khbxAXUZ7iC6lm29ZBQRJv57eYs50Rt3Ie69nCrOTqEpkUWPFBA2G1yqb83xt6NtAYpG77qfy3vswk1Ll+WpBAZKNVsee73F+i/dmzvRzSVGyNQYi/btCWuBjiva7PS6WOMjMqy+gC5os9fEAR0sCGjIXAcxCaFV03IkZcMAHyeDxKHPLlf0waCJvUHSwQMo9euvQcPVhNuhq6LqXGmEGr89nWz5SkLhXVYqZaVGcAI3Gi0VdhDdH0SButX/OB+hBTinht0W6M+gM1nv5YYbg2Wohel4AFaKocaRvLGFv2sMs9bqHizAamldVTOMVXfJHAwPWBMGfT6PRQ7Ktm89pra4DWtWQmAxDAlR6DQ7+jdee3zX4rHMSZh6+XLQPPSgagixkEPEESt/mTb498folFvknk7iY9IznTOeQ1+05oG0rQFJKB82K3gMd/KaFqpJtucMRKNdQF9NMO3ZZLpfQ99g6BkpTQq0jCsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWxQZXNpdml3b3JhbjdmUWx5WWZaek1yalZVTTFhaDZ3NWNBMkFINTdqQjAw?=
 =?utf-8?B?Y2Jab3hJZWlzZE0zV1BoZnNqSmtWaXRPdG1rTnJ1OWVOcmg1aFRpVWhkOHlz?=
 =?utf-8?B?QkxEWXBXTCs2NTArZ1NVQmJBUFpldE8rMlBnQ09qVC9GUzg2eWJBNGNFcWRs?=
 =?utf-8?B?VnNIaXUxbU5ialNBTVErKzZneHE1MkpITTVISXU0YnlkSDdMekVPdnBHZFJB?=
 =?utf-8?B?cXNxVE9XWUhKbmJIa1hrMVdDN0lOSGJxYVVpditQb2g3N0tzUGN0WDUvWElB?=
 =?utf-8?B?MzRXbFpBK3dQK20vUVRtMkZVREpMamQ1cHRpR1BFc2FGYmMyNno3Z3lJL0hL?=
 =?utf-8?B?R1FmNmhkYkdnOHBtd25lRDNMN2swdFFYY3dkcjRaSW82a1NTT25OSmJmaS9a?=
 =?utf-8?B?a0NKZFp3VHVpeXhkbTdDZWdXSnR5azY0bjFpRHdkaGl5S0VQRW1RTExvTGFP?=
 =?utf-8?B?UEFnUGVveVdpSmRtQTFsODU0clZFaENyK3Z2VEpURFB2ajg4dFp2RFBVVG5k?=
 =?utf-8?B?ZTIvQnpia0xvRzNDMi9JTVZEanlZc3R1ZmhWcnhYYnFwWktqODFwbGRTazJn?=
 =?utf-8?B?NGI2UmpJV1JjVEQ4Nyt1eHVDUFYvYk5LdE5PKzY5QS91TDZwVGExNi9jSFB4?=
 =?utf-8?B?RnJZdnBKTktjek9pVlhMQVhGcG0ycmVIM3M1WE4vSkx0NnJlKzlvZEJsUlpv?=
 =?utf-8?B?WWY2dGhjWDdTS1RJbzVSZW1UV1lLYkx4WURKc1JvSTJ2MU1ROXZmUmI0MGtS?=
 =?utf-8?B?OXFaY1luU0hFWGdHU0szeTFiOC91TFFrYlVtR2s5UW5rSTdBV3g1b1IxR2pI?=
 =?utf-8?B?YWJkTzFvcUt5ckRNR29PS2Z1WU9OU1pNKy9FKy9tT3NWTS9oSUxTUndJc1VX?=
 =?utf-8?B?VWdjL25wbEM1dG5oNmZ3bU1MWGpzVkhTQ3grc2E1QkFpdTBrVy9YcUZlSU1K?=
 =?utf-8?B?eW5ybjBGQU1CVkJBa2Y5VXExR3FVajZITWQvbGNabWdDbGdjTGNtM21iSW1D?=
 =?utf-8?B?VGNzckUzWDBMUXNaZFVQU1BaeTQ2VVpsUnExSmUwdmZLWlU2STJZSFd0YXpP?=
 =?utf-8?B?bFVpa2pZRXBkTWNOa1pJUlNkSTcwSWZaR0FjNlBzY1AydFREaGxGbXN2d2J1?=
 =?utf-8?B?aGlmU3R6Mm9GWGw3YWtwNzFmWEthazhOekRnSnhVQmovN25UelM1TWlrcXFz?=
 =?utf-8?B?NDI3S3h2YzBJa1pEZU94cTVzYUI3dkRXcXZGUkJpNFBxT3dwaW1pbldQSUdo?=
 =?utf-8?B?MlZJUnNsVVQvK1JpMjh4cmI4T1BiMkF4ZzBXTHlpemxFdHBJRmhEVFJtRDR3?=
 =?utf-8?B?NC9MWDZ5MjFJbW5Sa29Fd21RQkQyVDg5UEYxSnRSaGtseVFPQm5YK3BxeDJT?=
 =?utf-8?B?Y21oUFR0NW9HWldzblJCTXpvQldsQjJIVmZPUUs5RFQ4VnVUdGlRVkkyMENy?=
 =?utf-8?B?d1M1OEdPVFVzZGloRGxhd0JvcnRxSGFXWFZtc1NzRDN3M1p0azdCeUFDNFVH?=
 =?utf-8?B?b015cnl0WDNOU3Z2dGgwdE0vOU5yME9DemZrRXRZZXpnN0UvVFZWOFZqdlJ4?=
 =?utf-8?B?YWNFcittK0VldnlVaHlDMlErRUl5eFE2bmRRZjFrUnRSek1OWHhKdWRPaVpt?=
 =?utf-8?B?WUgzbjVKUDdlaWJSSFhPRDBTUFF3TDdTa1l6bVhMMDRFdjdRRUJ3UFpxcmNq?=
 =?utf-8?B?WGdSZDcyWEsyOGhrSnhEZnRyL1ZPYU5kalRLWnJkc2JwMkswQ0phVVo0b3Nq?=
 =?utf-8?B?OWM2QmRMdlBOWnEyQ2RrRWxCRjVIQTBvRXlmaTRpb2dyNG9OQWgvU0x1dFJM?=
 =?utf-8?B?Zktua3grcHJ5dlBVakM1QjQycEhtRHNvY3hWZHl5VDhFSm5vdk5xVllVQVVs?=
 =?utf-8?B?dVd5aFRZa3dIanJlZ0dFcCtmZTBxTnhWYnN6TkhkVms5MlhzanltcFhtR1cx?=
 =?utf-8?B?TjJJM1lLWHJJT1M0cDY5amdSVTNpQWRRMmthSE9qVUpSenJYdXBjaGE4Tmpu?=
 =?utf-8?B?K0RWSHUyKzIxSUtjQUxZS1czWkQ5YXZKVzBXeFNqZ2RlNVN4TWtLWWloTm56?=
 =?utf-8?B?eW1ueU0rRS9CUEN4eFlhSGtMK2F1ODUwUG5ZQmUvOFZ3S1kvc2NLbWYrV0N5?=
 =?utf-8?B?Q2pvMTJJT05MRGMvb3VWckc5ZWJtMXZRM0U2TEJvRUJaUm5YV29CSUp4K3Nj?=
 =?utf-8?B?Zmx2NzZwa1lGTTVrUzdNMWZJZkVaMTVJNTVYakY0RDJtL1NaclI2SG80aGF1?=
 =?utf-8?B?ajdFOWdQendqeCszc05iSFIzU0p1SERUcG5EQmNZM3c0UEl3QzJyeENNZzdr?=
 =?utf-8?B?akN5bWNyY0hqNFdxbU5YVmtXQlp2TStRdEJmYUlIcURIR3lmYTdHUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1195b0c7-a4fe-4f8b-4c67-08df2b6b1ef3
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:51:59.2325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN/ObjqnDJqMN8yJncq8x57T29L539UV7BqGYAI0/CLzuOdlui2RqHYE8+ggvISdNbNioEwZxBqFzF8LGdb4vE83iLkgq1Pta39xyC4OOlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

Hi Simon,

On 10/1/26 6:13 PM, Simon Glass wrote:
> Hi,
> 
> On Tue, 29 Sept 2026 at 13:03, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>>
>>
>> On 9/29/26 1:03 PM, Alexey Charkov wrote:
>>> On Tue, Sep 29, 2026 at 2:29 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Alexey,
>>>>
>>>> On 9/28/26 6:44 PM, Alexey Charkov wrote:
>>>>> On Mon, Sep 28, 2026 at 7:53 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/28/26 4:03 PM, Alexey Charkov wrote:
>>>>>>> Hi Quentin,
>>>>>>>
>>>>>>> On Mon, Sep 28, 2026 at 5:26 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>>>
>>>>>>>> Hi Alexey,
>>>>>>>>
>>>>>>>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
>>>>>>>>> When a generated FIT is used to boot Linux directly, bypassing U-Boot
>>>>>>>>> proper (Falcon mode), there is no runtime code to discover the kernel
>>>>>>>>> command line and (optional) initrd location and include them in a FDT.
>>>>>>>>>
>>>>>>>>> To facilitate easier preparation of a ready-to-boot FIT, add support for
>>>>>>>>> pre-patching the FDTs in a FIT with a preconfigured /chosen node including
>>>>>>>>> the bootargs and initrd location.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This sounds wrong to me. Why should we hardcode those at build time? We
>>>>>>>> already do DT fixups in U-Boot proper *at runtime*, so we should
>>>>>>>> probably do the same in xPL when booting in Falcon mode instead of
>>>>>>>> hardcoding stuff. Since you're aware of this, I'm guessing you decided
>>>>>>>> against, but you don't tell us why. I'm a bit worried going with the
>>>>>>>> suggested implementation means we'll eventually have a binman node
>>>>>>>> property for each DT node/property we want to write/override.
>>>>>>>
>>>>>>> The "regular" Falcon way of doing things (i.e. the one not involving
>>>>>>> TF-A) has so far been: "capture what U-Boot patches into the args to
>>>>>>> be passed to the kernel, package it into a fixed binary, and boot only
>>>>>>> that". No runtime fixups. So I more or less followed that pattern, but
>>>>>>> tried to make it a bit more accessible by eliminating the "capture
>>>>>>> something at runtime and save it somehow somewhere" step, which I find
>>>>>>> unnecessarily painful.
>>>>>>>
>>>>>>> Maybe runtime fixups could be brought into xPL, but they are
>>>>>>> excruciatingly slow, whereas speed is the main reason for wanting
>>>>>>> Falcon mode boot in the first place. Right now with Falcon mode on
>>>>>>> RK3576 I'm getting 2.5 seconds from applying power to _userspace_
>>>>>>> (i.e. full graphical UI drawn on the screen), whereas the best I could
>>>>>>> get with U-Boot is just over 3s to its boot menu, much of that time
>>>>>>> spent going over the flat devicetree before relocation in O(n^2)
>>>>>>> passes. And those 3s are after stripping the massive pinctrl node with
>>>>>>> hundreds of its always-present children from the pre-relocation DT,
>>>>>>> which alone saves ~0.4s.
>>>>>>>
>>>>>>
>>>>>> Are they always present, even with /omit-if-no-ref/ instruction? Or
>>>>>> maybe you're building the device trees with -@? Trying to figure out if
>>>>>> somehow we have a bug in dtc (or in our scripts making use of it).
>>>>>
>>>>> The problem is that there are a lot of `status = "disabled";` device
>>>>> nodes referencing pinctrl nodes, which keep dtc from dropping them
>>>>> altogether, so a lot of unused pin configs end up in the binary -
>>>>> enough to be noticeable in boot time.
>>>>>
>>>>
>>>> And we cannot really get rid of the status = "disabled" nodes as they
>>>> may be switched to "enabled" for some reason at runtime by e.g. U-Boot I
>>>> guess? I'm wondering if this (stripping all nodes which are disabled) is
>>>> something we could still allow (e.g. gated by a Kconfig symbol).
>>>
>>> Yes, stripping those entirely would break DT overlays and runtime
>>
>> Base DT for overlays need to be compiled with -@ so you have all symbols
>> available, this is something we could detect (presence of /__symbols__
>> node IIRC) and bail out...
>>
>>> board fixups (e.g. what I do for the Flipper One to switch between
>>> SATA/PCIe pin modes based on the M.2 key B config pins strapping).
>>>
>>
>> but that would also prevent that kind of things and since you actually
>> are already impacted by this, the hack I suggested isn't appealing anyway.
>>
>>>   From what I understood while investigating those boot delays, it's the
>>> linear FDT representation in (uncached) pre-relocation memory what
>>> kills performance when the count of nodes grows to real-world numbers.
>>> Having a more efficient data structure to hold the tree
>>> pre-relocation, or enabling D-cache pre-relocation, would both speed
>>> it up considerably - perhaps more so than trimming the tree itself.
>>> But going down that road sounds a bit scary.
>>>
>>
>> No experience with cache so big scary word to me indeed ;)
>>
>>>>>> Don't we have FDT and DM in SPL anyway as that's how we probe drivers in
>>>>>> that stage (not counting the few SPL-only boards we have)?
>>>>>
>>>>> SPL's DTB is tiny due to bootph-* markup (it was just 27 nodes last
>>>>> time I counted for my RK3576 use case). Making SPL parse the whole
>>>>> OS-oriented device tree, along with all the relocations required to
>>>>> insert stuff at runtime, will hurt.
>>>>>
>>>>
>>>> Ah yes, missed that.
>>>>
>>>>>> I don't have anything better to suggest, I'm just really worried about
>>>>>> the potential ballooning of properties we need to mirror in binman.
>>>>>>
>>>>>>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>>>>>>>> ---
>>>>>>>>>       tools/binman/entry.py     |   8 ++++
>>>>>>>>>       tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>       2 files changed, 111 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
>>>>>>>>> index ce7ef28e94b1..e0dea8bf3a49 100644
>>>>>>>>> --- a/tools/binman/entry.py
>>>>>>>>> +++ b/tools/binman/entry.py
>>>>>>>>> @@ -636,6 +636,14 @@ class Entry(object):
>>>>>>>>>               self.Detail('GetData: size %s' % to_hex_size(self.data))
>>>>>>>>>               return self.data
>>>>>>>>>
>>>>>>>>> +    def GetNode(self):
>>>>>>>>> +        """Get the devicetree node which describes this entry
>>>>>>>>> +
>>>>>>>>> +        Returns:
>>>>>>>>> +            Node: Node for this entry
>>>>>>>>> +        """
>>>>>>>>> +        return self._node
>>>>>>>>> +
>>>>>>>>>           def GetPaddedData(self, data=None):
>>>>>>>>>               """Get the data for an entry including any padding
>>>>>>>>>
>>>>>>>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>>>>>>>>> index 32caa03a7e16..750ff5b47ed5 100644
>>>>>>>>> --- a/tools/binman/etype/fit.py
>>>>>>>>> +++ b/tools/binman/etype/fit.py
>>>>>>>>> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
>>>>>>>>>
>>>>>>>>>           See :ref:`fdtgrep_filter` for more information.
>>>>>>>>>
>>>>>>>>> +    Patching /chosen into the generated device trees
>>>>>>>>> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>>> +
>>>>>>>>> +    When the OS is booted directly from this FIT (e.g. Falcon mode) U-Boot
>>>>>>>>> +    proper never runs, so its usual runtime /chosen fixups do not happen. Two
>>>>>>>>> +    optional properties on the `@fdt-SEQ` node make binman patch each generated
>>>>>>>>> +    device tree at build time:
>>>>>>>>> +
>>>>>>>>> +    fit,bootargs
>>>>>>>>> +        A string written to /chosen/bootargs of every generated device tree
>>>>>>>>> +        (any existing value is overwritten). Typically set to `CONFIG_BOOTARGS`
>>>>>>>>> +        via the preprocessed devicetree source.
>>>>>>>>> +
>>>>>>>>> +    fit,initrd
>>>>>>>>> +        The image name of a loadable (e.g. "ramdisk") to use as the initramfs.
>>>>>>>>> +        Its `load` address and packed size are written to
>>>>>>>>> +        /chosen/linux,initrd-start and /chosen/linux,initrd-end (at the width of
>>>>>>>>> +        the device tree's root #address-cells) and reserved in the FDT
>>>>>>>>> +        memory-reservation map, mirroring fdt_initrd(). If the referenced image
>>>>>>>>> +        is absent or empty (e.g. an optional initramfs that was not supplied)
>>>>>>>>> +        the initrd properties are omitted.
>>>>>>>>> +
>>>>>>>>
>>>>>>>> This sounds wrong, why would the FDT image node need to know about which
>>>>>>>> ramdisk may be used? Shouldn't we rather have a ramdisk property in a
>>>>>>>> configuration node, and then patch the FDT based on that information?
>>>>>>>
>>>>>>> Falcon mode boot where these are useful is for a fixed-configuration
>>>>>>> boot flow anyway, where one wouldn't have a way to select among
>>>>>>
>>>>>> How do you plan on doing A/B with Falcon boot? How do you know from
>>>>>> which partition the kernel you booted originated so you don't upgrade on
>>>>>> the currently booted partition? There must be some way for U-Boot SPL to
>>>>>> tell the kernel at runtime where it came from?
>>>>>
>>>>> I don't currently do A/B with Falcon; instead, I rely on the fallback
>>>>> to U-Boot, and U-Boot in turn loads from a UFS boot W-LU (which is A/B
>>>>> native). Making A/B work with Falcon would be a nice follow-up, but I
>>>>
>>>> This means supporting two completely different boot flows with potential
>>>> side effects (U-Boot proper probing/breaking stuff while Falcon mode
>>>> doesn't).
>>>
>>> Yep, not ideal. It's all heavy work in progress, so I might still
>>> rethink the whole approach more than once :)
>>>
>>>>> believe it will require some external metadata to choose the active
>>>>> boot source anyway - and then the same external metadata can be used
>>>>> for the upgrade. Such as the UFS device attributes, or whatever people
>>>>> use for RAUC and such.
>>>>>
>>>>
>>>> I guess you could use a U-Boot environment for that or some more secure
>>>> location (via OP-TEE/TPM, etc...).
>>>
>>> RPMB with the key managed via OP-TEE backed by hardware secure OTP and
>>> on-chip crypto would have been great, but it's a mighty detour from
>>> where we currently stand, so I'm leaving that for desserts :)
>>>
>>>>>>> several ramdisks to go with the kernel image. So putting this
>>>>>>> information directly where the user (i.e. the kernel) will find it
>>>>>>> cuts out intermediate steps, which in turn improves speed and reduces
>>>>>>> complexity.
>>>>>>
>>>>>> You already have:
>>>>>>
>>>>>> fit,firmware = "atf-1", "kernel", "ramdisk";
>>>>>> fdt = "fdt-SEQ";
>>>>>>
>>>>>> in the configuration node. So simply have binman derive from
>>>>>> fit,firmware which node is included of type "ramdisk" and fixup the
>>>>>> device trees in fdt-SEQ based on that info? Less user-prone IMO.
>>>>>
>>>>> Ah, I thought you were referring to runtime FDT fixups based on the
>>>>> selected configuration. Patching it in using binman based on the
>>>>> configuration node contents should work, too, but what's the practical
>>>>> benefit? It would still use the same ramdisk node, just written in a
>>>>> different place - or am I missing something?
>>>>>
>>>>
>>>> Not written in a different place, written in the only place it already
>>>> is, removing the need for duplicating the info which the user shouldn't
>>>> have to do.
>>>
>>> I think I start getting what you mean, let me see if I can indeed make
>>> binman infer which "ramdisk" should go for "ramdisk" and write the
>>> attributes based on that :)
>>>
>>
>> I'll try to be more concise/explicit next time. Trying to review too
>> many things for different projects at once at the moment so I sometimes
>> just do "brain to fingers" without putting much more thoughts into it.
>>
>>>> Re: fit,bootargs, can't you simply have the property included in your
>>>> -u-boot.dtsi directly, so we don't have to have yet another binman
>>>> option? I understand this won't work well if we separate binman from
>>>> U-Boot like talked in a different thread, but we are not there yet.
>>>
>>> That would mean rewriting the .dtsi every time the bootargs need to
>>> change, which in this setup is just an (already existing) Kconfig
>>> option. The property is also not useful for U-Boot proper, which would
>>> inherit it via -u-boot.dtsi. Plus, I'd rather not make the whole
>>> Falcon thing too board-specific, as then it makes trying it out on a
>>> different board way more pain than strictly necessary.
>>>
>>
>> You could reuse the Kconfig option in the dtsi. But ACK, no perfect
>> solution it seems so far.
> 
> A few vague thoughts:
> 
> 1. If binman finds the ramdisk from the configuration, note that an
> FDT image can be shared by several configurations with different
> ramdisks (or none). In that case there is no single correct /chosen,
> so binman should probably raise an error rather than letting the last
> one win.
> 

Mmmm... true. Thinking out loud but maybe generate a Device Tree overlay 
per configuration then? Maybe a "bit" overengineered though.

syslinux/extlinux "standard" supports[1] multiple initramfs at once, 
does FIT as well? This makes things "slightly" hairier.

Cheers,
Quentin

[1] 
https://wiki.syslinux.org/wiki/index.php?title=SYSLINUX#INITRD_initrd_file
