Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB94606A33D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f1sh9lVl;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ocMahdfx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EF85811F7;
	Fri,  6 Nov 2026 10:00:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id siVNKzqMI_jI; Fri,  6 Nov 2026 10:00:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62DC0811EF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793959239;
	b=P5PppuEa7Nc0TrYZbzrna8dA614nEDH0VBzyrH3fEru4UnurVNOKybNwzEbmIy/ATM4P
	 YQ4LY9Rw2gHcmugkA0ZuOyssTFfAXe0K+gylJd5kK8Bd5CiGeY7MlKyPUPyWA5z0oLw6q
	 kjtVM6GblU5/Cj9zG5A+qSFr1MGEPqcplM0ipZGjIvd02eF8A8IUpDB+Bqj3iTntH9UOu
	 9RDeZZExLTDdDc0Vw6N76jhVhg5o5i9rekYz7CG4I7MN//A9TabpE82ITSQ6vXjxNz2uo
	 qZPxcjeuZuVa5xgBdPt666MbfqWi4f0BFkEFVuu5LDl+tvcJsuxxOSZK73veLXARMWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793959239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OqDD/GGqffbog3bSpG6DT86vuq0h3z4fX+IZkcffv2Y=;
	b=p+l5+OsnGeuu53tb08QbBxm4Pdp2PZKxHj0DSCAR2rKV+/94Pv3jwRhf6V7jaPBWANPb
	 /eXmzbKIX+fUSD6rk8RGdHD6EnNpbj8gb8qgg+L+TSOJEjv2t0PNXid716czME99SGg9d
	 JZfzTBwE90wrOBIWyWp+/ryaKDC9KGtbbxeHxMs8jDlBV290eqvATqGux8sGqQ4I98fyM
	 PNRaSiB7novP4FqGh/KkA2ZZu7Yv+/8+9a9eHJXp/RjfkRJG+XUBoa3QJLCSID7piutit
	 RLkHMYLJUVrd3W/bAbmAbkCoDVFOTXMNRa8TaAu6K0VKTJN5WDZ6CTRVmC+4YmLv1ig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ocMahdfx;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793959239;
	bh=OqDD/GGqffbog3bSpG6DT86vuq0h3z4fX+IZkcffv2Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f1sh9lVlBfaALrMYidYiOKEagfrbb1n0Hm+Jcdk/1wuUDGT2qO+ZIlSGw3PSnFrKW
	 C87NTgOpKODKrHwQZf5boYHK2B185Z4uTIAjSM6gaHODHd90icscN2ykxENcUTtAyE
	 4Btwrsx4T4Pcyh4OG5m9Uts7MfYZCbEz8FQMEl9gE0YxsECOvVYA7g/DZD+Gd3ihXm
	 Q8/j1Npp6dWJ2pqCnQJyfnpXkCWX/ySAQPWWE9IJ+fiCXy0/XaXseSRopCRDXXMryi
	 C8kqFo80pi9ra9SPnLMydNlmADhEmAedjh9wWhoPPyc1UZLMpFzlBCBQ8A+dENDPks
	 T9fqCu9MufrNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62DC0811EF;
	Fri,  6 Nov 2026 10:00:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D35AB1E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C53FE811EF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FvicElVTdvJA for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 10:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E63FF811DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ocMahdfx
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E63FF811DF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqDD/GGqffbog3bSpG6DT86vuq0h3z4fX+IZkcffv2Y=;
 b=ocMahdfxi8YpPN+QFuQ+grtUkNpiCgHq1BHgqPBbWx6SAQSsxSfD28ZLjq9NXROV/4YxWjO4HuhTvLc8PMUaqOeetTl70jy89M6jCimLP3GaZPg2ZBkLRpyJDnocHlG4L9/C9iezEOrI3/HfwsgxhTqF+8W/a8/WnITsuKY1q+qs9apMdUjNgHTd8xlIvYe81CBfCA4Te0UjutN/Z0CiSGQTsj/1iZxSOqdxlQLLuMvC1SAif3eUZU/OxeE1NoNgqhR41GdD/jTmDwTv2/CLwAW2yZ82JhB1pp3SfChxBiGHCfbItAwLOWf/PlS3I5zTrKoZiZ3EvMSlwvELAl1w4Q==
Received: from AM9P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::28)
 by PAXPR10MB5158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 10:00:26 +0000
Received: from AM1PEPF000C1ADB.eurprd02.prod.outlook.com
 (2603:10a6:20b:21c:cafe::99) by AM9P250CA0023.outlook.office365.com
 (2603:10a6:20b:21c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 10:00:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000C1ADB.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 10:00:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 11:00:55 +0100
Received: from [10.252.31.114] (10.252.31.114) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 11:00:24 +0100
Message-ID: <c68f3957-3d23-480b-b7ef-428f5dde2546@foss.st.com>
Date: Fri, 6 Nov 2026 11:00:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] Add Engicam MicroGEA-STM32MP257D-RMM board support
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <linux-amarula@amarulasolutions.com>, <michael@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, David Lechner <dlechner@baylibre.com>, "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Lukasz Majewski <lukma@nabladev.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Sumit Garg
 <sumit.garg@kernel.org>, Yannick Fertre <yannick.fertre@foss.st.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104192118.GD1164024@bill-the-cat>
 <CABGWkvqisJBzV=tRQrhZ87evgF6mTff+dJvO1LVwVQC-YX=DpA@mail.gmail.com>
 <20261105144835.GM1164024@bill-the-cat>
 <CABGWkvqoNBvjynykG-Y7V8BP5OTP4TOq4zwkAwSQ_P+e8-6JPQ@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CABGWkvqoNBvjynykG-Y7V8BP5OTP4TOq4zwkAwSQ_P+e8-6JPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1ADB:EE_|PAXPR10MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: d42dd7de-c347-42c1-ca10-08df3becc7d9
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|36860700016|1800799024|23010399003|6133799003|22082099003|18002099003|3023799007|10067099003|4143699003|11063799006|261026121527099003|261009223027099003|261026140227099003|261028144727099003|261021121427099003|261102123227099003|56012099006|261022105027099003;
X-Microsoft-Antispam-Message-Info: zBMKP/+SGmblLGdWfDTHTOfVxNoxK6ws6d65B3utitJCweitPr++TVV3sAKBbvBK/UliOjXj6d3YPyv3QFtgYATXo+97Hm/jg6HI83vXC2Bgc2WMWm14b95Zt2QeghGM6OGZ1benCd9j32akBESu3MHBftx2f4zWTLUADEl0wl2htp1T3aBC5EQFk0+b7ECX446HPSCDcmYLgHYRFNqXxKGWxQA7ay6nm/OCYXExPRmUosyrYeVfzNCcvWj/u48khlvoWqOBFEhzUsgPAeRRGoS3A2LIva5AOwms1eTB5Il9//bU814Y9nM5yg4S+YDv+HJqJSKA5JpNVlKOfl6nPe66HrlL9UyLXKJYkmaCaqL8PUEU6nO121OqKNvU/ok12thdm3tB0PPWwi29FXpqT/yRiCa9gcTAm/0eCRIyepDXujSwpeveuZQ40YKwCVpK3epeievOJdUhq0lrpwWDEW5kZOEXFnoKZ3hu2OtJ+ZKcFQmf4lRk2ygLDYWxi/vF5t+kez0gykxaUs10mUfAp9xZRLoecTIWPFZQdqZ2PkFAFeOw4RKV5Aaqs2L49tvVGIWmMFVF4LcPtPykL+qelvKFAg7i+n+tUK7UtruBHJou+peUudvIdUlCdXn/FPwmTcdEcyt5Sb+cTDPBtTGutqbfPsu66SwSbsgfA2mAWao=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(4143699003)(11063799006)(261026121527099003)(261009223027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(56012099006)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EmaYzzzlbbyUG6t2qZBCPjYE/+I/6Tf3Kl6vAae+zQHvLbicDxWDMQAhSf25KUEbe5NiXJMYJvoPA7ksZFztAgPgemH1JBIrFbOoAUqrgxdl6pv83hpHcqjQrffSi/GJBfPizTpZb406lrz3LUM0BHmm+YAL0xKGkm/Lm/OMAhLcxV4EyM5NY4sZH01eOgw4DUcxZEE64GPuHv2QWIBUMyUsM6irUpOiYGxZAmRV+Z0DWnZja7XNPSU24YCyBvSZdgltqsM/yAYNG7wCEbmDANSxrelhml6ifxyKctktTZm352cfnXei/0SPavBo8COAITecPywcMRhqPwxfXP+qDDtoeHoK3l0zaXubN2NI9eo1lPcOP8iHrxw09HlmhntHywv6DKeQsLehLfvgpIgIqmLZhadfssQWfwU2s1u7hgTmPIfffDP03NDuyV9H6mpA
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:00:26.0239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42dd7de-c347-42c1-ca10-08df3becc7d9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1ADB.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5158
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/5/26 16:39, Dario Binacchi wrote:
> Hi Tom,
> 
> On Thu, Nov 5, 2026 at 3:48 PM Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Nov 05, 2026 at 08:12:07AM +0100, Dario Binacchi wrote:
>>> Hi Tom,
>>>
>>> On Wed, Nov 4, 2026 at 8:21 PM Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Wed, Nov 04, 2026 at 09:49:33AM +0100, Dario Binacchi wrote:
>>>>
>>>>> This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
>>>>> board, with its RGB and LVDS displays and the FWU A/B update.
>>>>>
>>>>> The first patches pick the board devicetrees, merged for Linux v7.4,
>>>>> from devicetree-rebasing. They can be dropped if dts/upstream is synced
>>>>> with v7.4-dts first. Then come the fixes, the refactors moving the
>>>>> STM32MP2 environment and FWU support to the SoC code, and the board
>>>>> support.
>>>>
>>>> What's the status on upstreaming all of the changes you're putting in
>>>> the -u-boot.dtsi files? Thanks.
>>>
>>> The -u-boot.dtsi contains:
>>>
>>> - U-Boot specific nodes and properties: the environment partition, the
>>>   FWU metadata and the bootph-all properties.
>>
>> bootph is to be upstreamed,  I don't recall where the FWU stuff ended
>> up, and I'd need to double check the specific environment binding you're
>> referring to.
> 
> I added the bootph-all properties to the -u-boot.dtsi because I saw
> the same in the other STM32MP25 boards, e.g. the stm32mp257f-ev1. If
> they should go to Linux instead, I will send them for this board.
> 

Hi

Currently bootph properties are in -u-boot.dtsi for STM32MP platform, but 
it must be upstream in kernel DT. 
The bootph properties migration from -u-boot.dtsi files to kernel DT is on-going [1]
but need some rework (stm32f4/f7/h7 MCU support has been removed [2])

[1] https://lore.kernel.org/linux-arm-kernel/20260526-upstream_uboot_properties-v7-0-e17cd424d5db@foss.st.com/
[2] https://lore.kernel.org/linux-arm-kernel/2afd5f78-0174-4955-8c1b-be18aea3800b@app.fastmail.com/

Thanks
Patrice

> The FWU metadata node and the environment partition use bindings which
> are only in U-Boot: doc/device-tree-bindings/firmware/fwu-mdata-gpt.yaml
> and u-boot,mmc-env-partition in doc/device-tree-bindings/config.txt.
> They are not in dt-schema yet. Both are also used in the -u-boot.dtsi
> of the other STM32MP boards.
> 
>>
>>> - The RGB and LVDS panels, with the LTDC and LVDS endpoints. These are
>>>   already upstream in Linux, but in two devicetree overlays, one per
>>>   display. Since the display is selected by the "display" environment
>>>   variable, which is stored in the eMMC/SD and is not available yet
>>>   when the U-Boot control devicetree is set up, both displays are
>>>   described here and the board code keeps only the selected one.
>>
>> You can't detect and apply the overlay instead?
> 
> No, the displays can't be detected. There is no EEPROM or other ID on
> the board or on the displays indicating which one is connected. That is
> why the selection is left to the user, by the "display" environment
> variable. Since the environment is in the eMMC/SD, it is only loaded
> after relocation, when the devices are already bound. Is there a way
> to apply an overlay to the control devicetree at that point that I
> missed?
> 
> Thanks and regards,
> Dario
> 
>>
>>> - The LTDC "lcd" clock for the RGB output. This is not upstream yet:
>>>   I sent it in an RFC series [1], and Gabriel is reworking the STM32MP25
>>>   SYSCFG pixel clock support, which should cover it. I will drop it once
>>>   it is merged in Linux.
>>
>> OK, thanks.
>>
>> --
>> Tom
> 
> 
> 

