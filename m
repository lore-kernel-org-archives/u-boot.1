Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56925CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDFFC60B1C;
	Tue, 29 Sep 2026 12:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZzDXBq3pKDN; Tue, 29 Sep 2026 12:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A9CA6607C3
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790686384;
	b=iIlBVill5m7XsaSMrD16b+wprmY7asuYAQkYBfGa+2bKuSFCkxqymMdpUtelQ5LhTRZ8
	 1ND6EAknGP9Zzh9CkRrIjcbjUcAU2U+bbBwE9yFvcvY+7i4Tcfbnci2DI0X6cCmkvas2A
	 5eh0dDueRh8MplOhl0DfGgg+Zip1OzCA/rSlImbTY46e4pnd9zi18uXXvmRz6m75GsO+y
	 TI3getaoidEolzBsFXfgqDvpdUe+uuIvdUpGvKum8I0B4FnCbrrqjRugcP7bavn21m2Zz
	 pslSNCHA0esmzHyNFx/BuC1/Y3DUPHDTKf4CYKkpN46bjUfwrMKfMuvgdPcj4dM2kKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686384;
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
	bh=IxNO28oLqNXEQd06gjCU5n5TC1iId5CHiEgu8m/T5F8=;
	b=St50eFGKdQfvQEqW79UrZt/q58mrwEmzQKUHs+Rx+Yv9+4Nii7mu7FZO6DqtXrBjayO7
	 rha0cPP1QxhAOqwj2NThHKtb9nzVyUWt72rQQlrNc49KcZ2m9RV2CnyQ0yn7p2FJcX0Dc
	 7X7RzfNSw5Q+wGzX4weiOZC3OlHo4CGSS52+4eRcmh2O30cU0B+YcO30WextCHDx+W1mq
	 AUgux1+LhRx+GMhjpps6gIngwCbq4VdkFPt1IQ7BWihZRIRDTq86k/kQfwc8XB8RAHGC9
	 pCnQVxa4x11MAt+D4kEf27TtPH6pUNmUpTkRqLfQ33rR+PKSDL5/3ZRaKmrJKGMwOaQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686384;
	bh=IxNO28oLqNXEQd06gjCU5n5TC1iId5CHiEgu8m/T5F8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDNyxYrz3XZcCsAQ+6HjfW38ALGS+1FohXtJmfrehn+SskuujbEriSThnB/exG2/g
	 pAlTHXOTR4BhLDH4e9TJADQg/RFC/fp2eturmOLs+HxTor2YtppdndJ5jSeeQxuIob
	 2+okbbktZCA2owedltkFZa0whfgwVstp+5KAG0iARJ2zNdtI3zIch+KIUrimdz8v4q
	 cJcdN0jwHtDlVl/7xo0WEfNRDeQsC+nZMfwN/O99cawagtD2HReYOHM34iSuKnH80Q
	 FoaDnYRkLh7sLiCQgJ0AEX8rAnwQjdJULU/4w5dCMg0AsmW2vhrlYdNtB303VMY4oW
	 u+aJB4vMDUfow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9CA6607C3;
	Tue, 29 Sep 2026 12:53:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E96A961
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF2FA405A7
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTwSTggClOG9 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 10:29:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 95657405A6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790677786;
 b=iVrA+KEOacvA7Nu52Nfizv0w9oC1ZZEnaN6CVatRqRTlU6IX/BsWeLZdwb5QjaT2tLi8
 4PDJg2SBaxrQYgdl+bSge55PwdZMYSXXKEeMIrTLO0QgCD3zCHdEyALCXJll3W/DYHgDK
 f2M+KlDvqwFeclWb+uHXDtkiqY6n0CUzTG8BZWi3eVsOGrVgzIbtANXbOQGEvs0FliBqs
 EV4vZpKY42FjiybG7Aw2yTVNDdAySlvBNasLmRtICLzyXJaIhm6IBUVpdrEqrVhMn0plh
 RyvKcQ4OxqHifRL8KDN1Y9B2EkEEeBYeHrlh5CH515+VXgKLmDiULhqFb4vU12Waa9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790677786;
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
 bh=IxNO28oLqNXEQd06gjCU5n5TC1iId5CHiEgu8m/T5F8=;
 b=W32PBLWdguyyFIvG1DDaheEh3TYESGukBxW0kUJLHAgXjJstkkdvsxVoEHzMw7PDFc9Q
 ETxNmKlVd3gfaA6ePT6DN0mwHpFsNaAeDT/vS7nC8y0GZqTOnRXAC1Dqj6ZYnTMJrmo16
 r7oxQ4L5qgu2UE9RE1US1pCBBguoiu+UGsjvFGLAD1UdsPZP5q+BnnyxBMMRPMo7nYhFn
 8exc6L3Ic1DeD5P4fuNUefNhdTHoJbvf3VTa7RUnncahSIcv9r11T+bbqju0eaojXJJkM
 09/FeqNOx+meVm4VeV1NrxIP3h9womBgX86AtXQpfvJlZcJrp6MqeWH5IzOavops8IA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=SGj74ssq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=SGj74ssq
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95657405A6
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grNecVpyd+mQajt+rEMAtygFaMuwj4O+piSRjss9cs5PiDW6IXX2MEDSoKHUuG55ulON4WiPLc8gOasmKViBghHTLefQCsVC8yxsYR2PQeo+wUT7iJyxVp3WhKBseLUeeb7kKKPhqV6AvB3CfcQ5b09pRRKn/eundGYK0oEqngIwC6MORMvmMMN+bCB3t66oowYbh26TY/VA9Pv3Q6BQjJR2vnlVNwo/rPo0T3jdenILdRRFshwFNgi05u0sM1uNMPgusYX4KdYWY+QQrDm0bGboPgiYORR4A4A165MB7qbx0qWx8vH0db7x64heSxC499JQcWb0HJImFj7l6/Ln1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxNO28oLqNXEQd06gjCU5n5TC1iId5CHiEgu8m/T5F8=;
 b=AchjyGZP+KHa8WultbBTdurQqWMq8stSbtl2aWj9QkrVTzGM7nE9abUl0fHmiig1/nEFljMPwa/0q75zoKidJG7F6vy5YXM8Fw8tiw87lm1Kld/XhBnkLw5jOsoODTd5jdKJ5PJ1O6K/UEMxSL6ozZFf6F3gUkw3Szy0pqWpE9ziXtEIwCwuRB1aFB85juUlRsB0j9skp/UaCsASA0b+Ke5BR2mNGQXntEGW5Zv9l8uDbILI6betXBB5rgYDMhCSq0WGG6tQ0FZX/KXrCINpgdl5m5JXJtoq41alJhwg06pl1iO6gW5hBzIftrLhOn+M6WgmdZHc7eE3Ta/Baddvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxNO28oLqNXEQd06gjCU5n5TC1iId5CHiEgu8m/T5F8=;
 b=SGj74ssqCbsPzjYMMU3UOuSMHere5Seif4qR2fz4UmldXX/Z2i8VFkQ0eg5NBkgWVqEt4O3O+KSz6xOWD/UY4ZMg5Cq1GiKxPToooREPh4aep5lm6Vfnotal7gjyTFqK/oWP51rVd6NddOmv65YPAfJDMKErZiHFTG5Y6N+FKd8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7637.eurprd04.prod.outlook.com (2603:10a6:20b:29d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 10:29:39 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 10:29:39 +0000
Message-ID: <e7235ec1-dff2-44fa-8c02-9b6a1012bba6@cherry.de>
Date: Tue, 29 Sep 2026 12:29:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
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
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
 <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
 <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
 <CAKTNdwELO46dZ1Cy+-wpBbQNsP9XJyTgCjBYLQpE39YJ3XP0wg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwELO46dZ1Cy+-wpBbQNsP9XJyTgCjBYLQpE39YJ3XP0wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0102.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 6490aa06-0b79-4be0-2e65-08df1e1490fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|376014|7416014|1800799024|10067099003|5023799004|56012099006|11063799006|6133799003|3023799007|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t9isc36gnrx8nDLVbNbFo8mWzEdP7cz6R1z5feoAXiTW+u7rtz7kLfHSuL1AtL7gh0TggpkNqCktA8X/YofhGTeRjnw2sNHP/ErRN154/l+XXD3RoR83Yo4PYYyfJel4f0S2iVevdfdoR5PYg6GBa7bsAKY5HrsZOI0ZcsXGWToHhzfgq4atcZlmePeEjAhKdq6oibz7H5I7qjd3M73zFOLtq7T9ouwAIQvT4WdFKkv5nWRdCpSYVsUBshmcz+ehBjhb6aMmJeuj6oHIK3AToUt06riWPpyDa7siTHQqbRSNr3MINHGg+ws9FAAeJCH6YLzF/RfnJLxl1BZamHNuoIhTI7eSIZ9qwTi4YxiOa0pH++iR0aR8dkKEEgw0mBt1XKTKY5iCJg56p17TJO+an4CKQXIfV8hrcR9oDxnDzXsitcUjHgVHoc0pHc+1O4doDQ9uDjnbXny0xF9b/DneeFH7GR0fL8gRVFZoiUzkKL0zVPCFYoy/bPeUMu/DbBnF6l3vYDKQn52MfupHEIfRWuRIMmny6Au2ngNsKkdMwYSNz1UhK1FDp8XuX6JUMA5HDzvnJDp4CJS3EmJtF4/dbscm31n45qBg3lPQSkKrHYlThm0F1BunKKhafwRJ9cPXgcFzPXS5r4Z21KL8IE2JJwXPnZWOxJhrlj92mpZUp98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(7416014)(1800799024)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003)(3023799007)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnB1ZWxNZFVFbjZvK0VLd3pRTVFkSityV0NPdlhhSHhsdTVvYXNZQTNYcDlB?=
 =?utf-8?B?SER4RndTWFIrR1lTTmpaQVdzSUxlU0RWOE1JWmFqZXNTcHMwd29wUEhDRUtu?=
 =?utf-8?B?NEJJZFhSU3VzeDc1dy9SZDZpekZ6MkpKMFNpZFBMcDVxNllqUkFGUWI5TEZM?=
 =?utf-8?B?OXNkK0JScEpyVkFGQS9DeVorTzRzMHhxdHFqV2xxSFRLek1KK1dENTZQc3gx?=
 =?utf-8?B?RHZJUFpNKzBLdFFPNU15MXR6SGlEVzEyWW1EaWpieHFoQ3B2dVVXVVp1bnd4?=
 =?utf-8?B?UGI4MGtZYld2R3A4VjR5bXJzdmI1alBETUxNOEVGNWVpT1F3K2hhTTRWNHg3?=
 =?utf-8?B?eXdtSkhCT0FnS2tocVMySFhPLzRYZ2xxaElwcVp6b3ZuWXlEWkc0Qkp6QTNL?=
 =?utf-8?B?dDN6VWEwb3ZEZTlwbE8zbEd3VWFWQW9nUlBCSkxhem1tVjVNcFRDb2VpbHda?=
 =?utf-8?B?elR1Sms5YXhmRE9lRzFiQnVWaDU2MkxZd01lbEM0Y2NCVzdsemZJMTlRc085?=
 =?utf-8?B?TmlYbUVXVHAyU0xaRXc2QzNkSVZFUDZaSzNSUjhob2lNbWhRZWxDSU9SNEx6?=
 =?utf-8?B?M3RlS3VHZmZTNnNMQWQ1T00rNlJNSyt5UzJkK0RzNW1wVkV5UDd2eGRTQ3VI?=
 =?utf-8?B?a2E0VlZzclJlMWNHRmppQVRPMGl5VXB1OCtUM2NGZUgwcWg2b0Z6M2ZMaTFQ?=
 =?utf-8?B?NnRITyt4aklsUm5xR2NXeXpXb2RaZFhMYnkzcVhnN1k3L2VRM2I5b2kxb0pk?=
 =?utf-8?B?eTJnUHhaeGo4dW1wT3ZsbWNhUjlPR29LVTVoY3dldWVkUHBvRnR6T1hNeDN1?=
 =?utf-8?B?R1AxSWRGckppaCs5MmYzNlBvUGE0bEt0YnQvZExaWngrZWJwMElpOGRQWWpv?=
 =?utf-8?B?alA2TmZxYXRudFNTUTZwY0xxSkpnbHVTaXdiZDllOUhaY0QycHlpMDRsckw1?=
 =?utf-8?B?aU5EelFMRDhsNldzM09tU0F1a21lRVZiakI5d0drSDNJaUtxeTFaLzFIQzZM?=
 =?utf-8?B?MGs2bXVjdFlYcSt0b083RW1vaVIwL1I4dERaU1h6dTYwaTNieElqaWE3VFdC?=
 =?utf-8?B?VzRUTElYQnlCUnZlNDU1eSs0VDdxTmNpUUgwNVZRUDc2RFVtWXBkcUpoZDVH?=
 =?utf-8?B?T1pBbDA2dHBaNDBwMTVHUUpZd1o3U2VQSnpKWDR6eGFhZ0JGYmdxYXczYjlU?=
 =?utf-8?B?bWIxaC9CYW5ncm9xZFFGRDNOa3g3OUJ5OXdRdHBrNm1ORHpWMVAzTFhDL3FI?=
 =?utf-8?B?cXNpeSs1QUdHU204anJjb1pXWnpidFFwcjVrS1dib2thU1hGT0FrMjJMeUY3?=
 =?utf-8?B?T0VIdW9Nbm9VamhVNEtqOS9kL0JvU1JndjMwT0FsOEtoQzJHbXpHaTk0YWs3?=
 =?utf-8?B?K0lWcGI3Y2xyUFVYbnltQ1U0UVhzT01KMkNpczZ1YlJYWGRESWtQcmNheEU3?=
 =?utf-8?B?c0VxbVhDY3VKME14OHlPL1NUU0ZFRitCMzBURHNoUVpXQ2FTRDJtNnRzZnJC?=
 =?utf-8?B?cmJwVXZqVUFvWTJiemxZKzAyMExRNjhNbytxRmNxdjBvV2xnYWo5ZDZyWkEx?=
 =?utf-8?B?UE1mQjVCZmxKQlZyQ0U1ZW56V1pHMGRoZWpyWk5UOXZHeDFlUERMZTdJcXIz?=
 =?utf-8?B?a0RxQVRJcGZpS2RMZHAxMXNkbTZNcmRMc2JXRWNzZHVTaHBXK1FpNzBuVnlu?=
 =?utf-8?B?eUZSeWVLckJNSUpuQi9FWlhGSG5JaWpKK1haRisxbjB1YndLVXhNOFAveDZo?=
 =?utf-8?B?OU5IWXBlVzltWmEvN3JJcGk1TTRKRXNxZ0hjaWNNMmtScldFTk5NTGlKMnpD?=
 =?utf-8?B?MFdjdjNHSS85cjVMTlZZdHJVVzNlWUQ5RUQwQ2VERERIem8yWFRLQUttNW4r?=
 =?utf-8?B?Q1pGcFRxM2dDL1VtWFNpQ05pSnJsdUlYYmJvcEQxaFF1bEpNZmxYdFZtYm5P?=
 =?utf-8?B?L2NUbXhxSm1XbmsxUmtVRy9lZlRwbWNKb3ZDQk5HMzBFeHhCYVcvMVNnSU40?=
 =?utf-8?B?bkdacTNFK3hCb1ZtR0pLQUpiUWxNcmVRemJEeGthamRRZGZ0bTY2cHFEMVU3?=
 =?utf-8?B?RXp6MlhUYThHYU5TMVV6MVhxczZUTW80b1U2ZVV2WGdxY29OSW1JOTJ2NXJV?=
 =?utf-8?B?OWhmTlZHQXJ4QnRVL1lTQnBjNzRMNWEvM1o4TkU5RWFwbUErQVdGam5GaFN6?=
 =?utf-8?B?S0h5TmpHQlhXZFptcjRUY3F5bjRKUk5yNDZ1M2pLWEowQTZxYkpDY2MzU3hw?=
 =?utf-8?B?Z1JMMytNZ1hkMnh1anZtK0xTMWlrQmRBczNXaW90VUZiNVJXdmhSYjMzK0xG?=
 =?utf-8?B?ZTd1enpGRlgxdXFVQmhubU1MMkRYSzBqd09HdytEcXQ0bVFXeDl2Q2EvaWVZ?=
 =?utf-8?Q?GDMo+Q5n8kGbNkr7Ggsp/sI9myyt/cTPXxhU0ZCJQ6Y4m?=
X-MS-Exchange-AntiSpam-MessageData-1: RiHikv81xMwLzlLKq3ivlCAer7sQX9HaQBI=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6490aa06-0b79-4be0-2e65-08df1e1490fa
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:29:39.1521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/w0kg5qaTpyxQEKOtr3NktLMl15iGGb3XM8WMhOb4tMWr6CRhDL49IivEXfBZpQg3FWwzvCF1UPmEUgQpyO3tr5aYkaVwf7ciTpgkhB8WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7637
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

On 9/28/26 6:44 PM, Alexey Charkov wrote:
> On Mon, Sep 28, 2026 at 7:53 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>>
>>
>> On 9/28/26 4:03 PM, Alexey Charkov wrote:
>>> Hi Quentin,
>>>
>>> On Mon, Sep 28, 2026 at 5:26 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Alexey,
>>>>
>>>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
>>>>> When a generated FIT is used to boot Linux directly, bypassing U-Boot
>>>>> proper (Falcon mode), there is no runtime code to discover the kernel
>>>>> command line and (optional) initrd location and include them in a FDT.
>>>>>
>>>>> To facilitate easier preparation of a ready-to-boot FIT, add support for
>>>>> pre-patching the FDTs in a FIT with a preconfigured /chosen node including
>>>>> the bootargs and initrd location.
>>>>>
>>>>
>>>> This sounds wrong to me. Why should we hardcode those at build time? We
>>>> already do DT fixups in U-Boot proper *at runtime*, so we should
>>>> probably do the same in xPL when booting in Falcon mode instead of
>>>> hardcoding stuff. Since you're aware of this, I'm guessing you decided
>>>> against, but you don't tell us why. I'm a bit worried going with the
>>>> suggested implementation means we'll eventually have a binman node
>>>> property for each DT node/property we want to write/override.
>>>
>>> The "regular" Falcon way of doing things (i.e. the one not involving
>>> TF-A) has so far been: "capture what U-Boot patches into the args to
>>> be passed to the kernel, package it into a fixed binary, and boot only
>>> that". No runtime fixups. So I more or less followed that pattern, but
>>> tried to make it a bit more accessible by eliminating the "capture
>>> something at runtime and save it somehow somewhere" step, which I find
>>> unnecessarily painful.
>>>
>>> Maybe runtime fixups could be brought into xPL, but they are
>>> excruciatingly slow, whereas speed is the main reason for wanting
>>> Falcon mode boot in the first place. Right now with Falcon mode on
>>> RK3576 I'm getting 2.5 seconds from applying power to _userspace_
>>> (i.e. full graphical UI drawn on the screen), whereas the best I could
>>> get with U-Boot is just over 3s to its boot menu, much of that time
>>> spent going over the flat devicetree before relocation in O(n^2)
>>> passes. And those 3s are after stripping the massive pinctrl node with
>>> hundreds of its always-present children from the pre-relocation DT,
>>> which alone saves ~0.4s.
>>>
>>
>> Are they always present, even with /omit-if-no-ref/ instruction? Or
>> maybe you're building the device trees with -@? Trying to figure out if
>> somehow we have a bug in dtc (or in our scripts making use of it).
> 
> The problem is that there are a lot of `status = "disabled";` device
> nodes referencing pinctrl nodes, which keep dtc from dropping them
> altogether, so a lot of unused pin configs end up in the binary -
> enough to be noticeable in boot time.
> 

And we cannot really get rid of the status = "disabled" nodes as they 
may be switched to "enabled" for some reason at runtime by e.g. U-Boot I 
guess? I'm wondering if this (stripping all nodes which are disabled) is 
something we could still allow (e.g. gated by a Kconfig symbol).

>> Don't we have FDT and DM in SPL anyway as that's how we probe drivers in
>> that stage (not counting the few SPL-only boards we have)?
> 
> SPL's DTB is tiny due to bootph-* markup (it was just 27 nodes last
> time I counted for my RK3576 use case). Making SPL parse the whole
> OS-oriented device tree, along with all the relocations required to
> insert stuff at runtime, will hurt.
> 

Ah yes, missed that.

>> I don't have anything better to suggest, I'm just really worried about
>> the potential ballooning of properties we need to mirror in binman.
>>
>>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>>>> ---
>>>>>     tools/binman/entry.py     |   8 ++++
>>>>>     tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>     2 files changed, 111 insertions(+)
>>>>>
>>>>> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
>>>>> index ce7ef28e94b1..e0dea8bf3a49 100644
>>>>> --- a/tools/binman/entry.py
>>>>> +++ b/tools/binman/entry.py
>>>>> @@ -636,6 +636,14 @@ class Entry(object):
>>>>>             self.Detail('GetData: size %s' % to_hex_size(self.data))
>>>>>             return self.data
>>>>>
>>>>> +    def GetNode(self):
>>>>> +        """Get the devicetree node which describes this entry
>>>>> +
>>>>> +        Returns:
>>>>> +            Node: Node for this entry
>>>>> +        """
>>>>> +        return self._node
>>>>> +
>>>>>         def GetPaddedData(self, data=None):
>>>>>             """Get the data for an entry including any padding
>>>>>
>>>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>>>>> index 32caa03a7e16..750ff5b47ed5 100644
>>>>> --- a/tools/binman/etype/fit.py
>>>>> +++ b/tools/binman/etype/fit.py
>>>>> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
>>>>>
>>>>>         See :ref:`fdtgrep_filter` for more information.
>>>>>
>>>>> +    Patching /chosen into the generated device trees
>>>>> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>> +
>>>>> +    When the OS is booted directly from this FIT (e.g. Falcon mode) U-Boot
>>>>> +    proper never runs, so its usual runtime /chosen fixups do not happen. Two
>>>>> +    optional properties on the `@fdt-SEQ` node make binman patch each generated
>>>>> +    device tree at build time:
>>>>> +
>>>>> +    fit,bootargs
>>>>> +        A string written to /chosen/bootargs of every generated device tree
>>>>> +        (any existing value is overwritten). Typically set to `CONFIG_BOOTARGS`
>>>>> +        via the preprocessed devicetree source.
>>>>> +
>>>>> +    fit,initrd
>>>>> +        The image name of a loadable (e.g. "ramdisk") to use as the initramfs.
>>>>> +        Its `load` address and packed size are written to
>>>>> +        /chosen/linux,initrd-start and /chosen/linux,initrd-end (at the width of
>>>>> +        the device tree's root #address-cells) and reserved in the FDT
>>>>> +        memory-reservation map, mirroring fdt_initrd(). If the referenced image
>>>>> +        is absent or empty (e.g. an optional initramfs that was not supplied)
>>>>> +        the initrd properties are omitted.
>>>>> +
>>>>
>>>> This sounds wrong, why would the FDT image node need to know about which
>>>> ramdisk may be used? Shouldn't we rather have a ramdisk property in a
>>>> configuration node, and then patch the FDT based on that information?
>>>
>>> Falcon mode boot where these are useful is for a fixed-configuration
>>> boot flow anyway, where one wouldn't have a way to select among
>>
>> How do you plan on doing A/B with Falcon boot? How do you know from
>> which partition the kernel you booted originated so you don't upgrade on
>> the currently booted partition? There must be some way for U-Boot SPL to
>> tell the kernel at runtime where it came from?
> 
> I don't currently do A/B with Falcon; instead, I rely on the fallback
> to U-Boot, and U-Boot in turn loads from a UFS boot W-LU (which is A/B
> native). Making A/B work with Falcon would be a nice follow-up, but I

This means supporting two completely different boot flows with potential 
side effects (U-Boot proper probing/breaking stuff while Falcon mode 
doesn't).

> believe it will require some external metadata to choose the active
> boot source anyway - and then the same external metadata can be used
> for the upgrade. Such as the UFS device attributes, or whatever people
> use for RAUC and such.
> 

I guess you could use a U-Boot environment for that or some more secure 
location (via OP-TEE/TPM, etc...).

>>> several ramdisks to go with the kernel image. So putting this
>>> information directly where the user (i.e. the kernel) will find it
>>> cuts out intermediate steps, which in turn improves speed and reduces
>>> complexity.
>>
>> You already have:
>>
>> fit,firmware = "atf-1", "kernel", "ramdisk";
>> fdt = "fdt-SEQ";
>>
>> in the configuration node. So simply have binman derive from
>> fit,firmware which node is included of type "ramdisk" and fixup the
>> device trees in fdt-SEQ based on that info? Less user-prone IMO.
> 
> Ah, I thought you were referring to runtime FDT fixups based on the
> selected configuration. Patching it in using binman based on the
> configuration node contents should work, too, but what's the practical
> benefit? It would still use the same ramdisk node, just written in a
> different place - or am I missing something?
> 

Not written in a different place, written in the only place it already 
is, removing the need for duplicating the info which the user shouldn't 
have to do.

Re: fit,bootargs, can't you simply have the property included in your 
-u-boot.dtsi directly, so we don't have to have yet another binman 
option? I understand this won't work well if we separate binman from 
U-Boot like talked in a different thread, but we are not there yet.

Cheers,
Quentin
