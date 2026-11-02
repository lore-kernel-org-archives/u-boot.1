Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B160A8873
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q0YfKMz7;
	dkim=temperror header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=EEwMITdx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D517607AE;
	Mon,  2 Nov 2026 15:38:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Omf52I5U-osw; Mon,  2 Nov 2026 15:38:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A18560661
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793633881;
	b=DqFDge1QLk8+hbZbtk1klfryQ208NxPLLBC4irVlkD8IfyRi1Q62LD5QMNIJXdwdg3dC
	 rbIW05yoZiMehWNvAhri8ylr91LeaDzGVkiTP5tFLR3+Jt6FSVorfeClakNsEL7KIQMaY
	 ojN8JCNoDr7HWS5O3rNW3EOdh1znlCUo44bKAf8a9GLpA1G4t6vxEOemiMI+zRw9Ayt3F
	 IfzsM1GQlNucYZU5ZvR1rqrKPZX4obAySWx9RNomAhAjPvAC4zi0u2ai0uhBmqivf2x8i
	 YUELua8Gw9nkLak0bslwdZCh1xWQB147Wz3KpjGqQq9ta5nVkYQaa9STEqex8pErkcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633881;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CV3SjzKb6fcin6CxtwILXd6IB6d/UxjUAzuLfjJqh3s=;
	b=lDQGrGMSi0PzOkeRbDaLFRm3Cyo3XPzWqm95jz+IWfMvQevIehFL/NUyL0GnnxurDCWX
	 33WXWZIVWaQGLkGu/WAoatNcI2nkNkCCh39QRdrjJxdgkAOxBqcKPVnNksVjD4T500TDY
	 KA+dZZ8O7ABowPrstxJXcdGNs1ZilYvGhaLLEqAibqn1PsfbQaKrM9P/ZuVQSceDEi3GM
	 OePtuX7WnHPJQ62Iwxne9AoSJdOyrO6NjZdZpNByWuhaoSL/eD3+x8HLV2yBbXHadI77Q
	 A9qSanQL/ethsHV/2+CQylGLr+ASlwzVH+8LAaLpbvFPx3CacQRJ8CKJdP4mK0Ub66A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793633881;
	bh=CV3SjzKb6fcin6CxtwILXd6IB6d/UxjUAzuLfjJqh3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q0YfKMz7U+gy5+w1Z1Nf/+6i4hqf8gu4p5d+vaadR60duqw2SwxER0Pp6SGzrakBw
	 l7PjCugUpfpH+/PC3QalZV9NBWpwcsl3kob8Rbq87IKeiI0AGgw32gVptlXONZdAaj
	 vUkEMwQ0YuzVvS/AuGcT9d3B0N5Eta5vvuWLDAeMj+LGmKpFkziPsSO53nUsa7EU/a
	 AKBNTNrQkcL3uakrxWJdyRX99JqyqQayuTzPDXlRM3qUHWF1XM3nXqwhDjDTbQ47rH
	 yl/c6t+LPwnioEPJe6kY6LEyWmoZSOx5ItGnX5Fzi/wwWCRnKR/Iy8dTWBMs9W1WBu
	 UXAdRoJ0/N4NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A18560661;
	Mon,  2 Nov 2026 15:38:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90C30411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7677E406CE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:37:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bc4cn9aXb4u6 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA17C406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633878;
 b=ajqPkhbcvDZQVpSNzeOpHLHqFtaoRRxP8pPTPaRuki6orLJrYIkDNb9qH4lcECKweQMX
 vN9m+XmGuwjrzXOPHQ8YxbU0+nkUZji2G9t7INaHD1e4yZcJGaFTLp+cBu26tllQ9KjfF
 fhC2Wa8GZurCB+UiHYkthaHCTbog2thboBnmPOgscgD2KXjvgGtyph05p16OScM/7Ho+u
 Wrst5yQNU63SHuBQPXynMm0425PF6nMOhE5w9GFjthQVsiHwSCDazSfHakcWwxJ52DPGj
 F2WAxu8Rm3staXjxDQTaZAEl0DwBfXHbF8762FP8chwQkspXDMcvtJeD5EXqLCOkB4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633878;
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
 bh=CV3SjzKb6fcin6CxtwILXd6IB6d/UxjUAzuLfjJqh3s=;
 b=te13YE+4n06qDs6EpGiKbcUSQ6M3cZc0BSDwHtxKgJYLS7GSqRcC4oB9CP58Fm5KQ0Ih
 OdEFt3EGrIYsOvE9syX8EKGpheZWC1SqJKskBXwt5JSojA8xqshCeo+DaqSdHjjaW2ExZ
 Nt83mK6HT1tbLyt4O6BAet2o2DYeWRuSFiqLjEM1JQAf3Kgo4kGQ8iGFtwWOvZRFqaSFJ
 Zc5ktGqTALH5jZTVE6by8jiSjyc00vaySxiINwMnx/Gya3vDg/s87EbqGFZphr3hfP4ib
 XHWh0WpdryUqjSDLiU9a2svkWKuzICz1TeNc8FJOOR0I+nqEs5lDjJ+3cGJf+kUw5Gg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=EEwMITdx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=EEwMITdx
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA17C406C4
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGa6+ESvQ+Q4pt+RLmYdQhAISpow48IXRh+MCihe90eEzH3lOaYT+3jZrsiehgi9ccCoq3p3qZpyoev+IeJTSZuG3BsCLQbVZAEsKljKWL/hgeoiyTFEyV4ARTKVK+dMVnQDJRfuzEIW13w2VjebbZtSoSSYHpzQSTwbdTYLbfFLiFOFv6cNieuQjBxY+zODCX4MuqoEKjtDGwbOTOhZ7U2XATo1fiB8oJG/+RT9Nw236OnB9xl4TwtcPI+YJw0y9H49Vl/NvK5jbVOXu30kz+JNUdbuaJYG6Ypnjg592BQ4s188hfc6BavdUomqpRgsQerFkBMJsgew6j5Dd7YeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV3SjzKb6fcin6CxtwILXd6IB6d/UxjUAzuLfjJqh3s=;
 b=Xz0nyVtUhHRALKa2UyUCYVM5sXPSuUmyq/V0P6V7Dy0ZVeLVzO9rnJRZbBzcdn0Y3zesKzz3GXyLVqqhR1nLCirCDyQVRnndow0+DCWgeSDp6Wq2nWCwtVLYRhKc/Z4v6GLBKaACMMaIx2Ixwy9+6ab0wqFZKxWaIVwNNdTkgPJ6Y9kbMvJIgOWW3yr6ahtD8R8J+XQ2OFshjvFtLmCSN0wH43sb9OVcUo2rb9o61E1etJFSw3V0vr24JepueWGmTyriOZdjIktU3dj5JVd0P6MAdQxMpngsmnPoDKpTYl1MSElwda1NG/bNh4DhjYoBjRi4w180Hlye6ihU9bCF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV3SjzKb6fcin6CxtwILXd6IB6d/UxjUAzuLfjJqh3s=;
 b=EEwMITdxxyufvuV9Mecwp1KdsdSmVY8gdGmUKG3YG4VdPlWZ0DOmME0TVjiHAiX/UaPek7RmUTF9WKRaEfn6ZQCwXlqr+khSG4Yd3kI+rKDVlYBYXJV+9Ii1CcBKclTMRQ1+QjPmb77UFSFNvkk/tDcSML9t1DPAyYzea5yT89ZD/PUIM+S9VoKWF0fDIWM272oDBF+5uQO47Im4WIxxeyJ8Ep0n7spv8GFUWJhkCnltwxsC0rBFQDaXZ1VqiyhJ3UrWhzfPZVP2380oR8mZlue3aqIduE2Mk80SqPyxWfgGb7NsveEBUsvBZcSMyF1BBhG847x6cRuRSZmPXaMfvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GVXPR10MB5814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 15:37:49 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 15:37:49 +0000
Message-ID: <db292ec3-6706-482c-a12a-c69e1663488e@kontron.de>
Date: Mon, 2 Nov 2026 16:37:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] test: boot: Test the RAUC partition name check
To: Simon Glass <sjg@chromium.org>, frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-9-b5a878627107@kontron.de>
 <CAFLszTgQH1PQuF56qtxi4M9DUpQjBnF1n1mLGhqKbN-dj9ogHg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAFLszTgQH1PQuF56qtxi4M9DUpQjBnF1n1mLGhqKbN-dj9ogHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GVXPR10MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aafb374-bdd3-4bc1-40f1-08df38f74026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|261102123227099003|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006|261026121527099003|261022115727099003|261022105027099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: tvo8jM6B+I/DpgCUZYXySQh4aBoSyPZvQ/mGRP54LjsOHMzoGA+/5UOpqi0bwo0qVBp5Vya78YUU+Xd9QtdNuRiW1qeAfGPqV5JFap1e2NbpwmgWe4KrtMN71t1jO/HSaNa/lqspQdj5KQ+zV0LFRl2N9iRuxPeWL4WDhvtsw8FLjBFro5VYVxMEPgxUju4Wwi04bx1JyXv/JH0zX1qGVj6rLKhhp74UEob/xwQwfHbvWVgQCi2ZfgWjc5mBZamYL7lTmW5L4LmAyG1lQ3pHLOO6pxdbTo8LBEgbh/363+LQu73n/qnMelTrAzYQYMP0b2Dg4ChYiOJKhfasopzi+TCNT0cEh0/ErTAFFFT7gyMw/kjNbPBW4Skj9o+TXT1R0VilVhoq+riD+7j+n5QUgbgIRV/YRx1bzO4tj8b5BoUCVWds4MvluBRqH37k1Br16I1iHfzU306GdcfftXaRp8KJvQJJVzGPiLrPxS8DHcHtjRYeddv3hoxwhmLBiMcn+XNvvIPmby0NbgvgKY54QzvnLvWyMjFPkBckArfZoAswTnNvyvwBwBjG96r6fJcyLy/80+ndXNnyj16ryczIt/De1vF3b2Bjy2lE/kaDlYQDJ1DZ7FXmn1sykxFiMxqmi8OxBwxzD2wUXEaqpaGzugW5VBmju4MAw4RYZwkQ4A4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(261102123227099003)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261022115727099003)(261022105027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTF1dHVnRWdveUhZa1l6NkhPbkQ4Sk8wcmdua0FzL1NBblgzQWo3Q2E3K243?=
 =?utf-8?B?bFk4Y0RsQUNZcEIrS2E0NjVHTmMzcWdNbHExK3F5bGNXT0t0cmJQSEhrVVhS?=
 =?utf-8?B?bDdMcUd6M1UvdlJscXJiMWhKeVZlcXU3UTdPN3JZKzNoeWJNTXNCc3g1UFVK?=
 =?utf-8?B?UnppN3NxcWhsRjAvdXlOWnR4elJNY0ZXTkxYQkFtWEZhdWNSZk81bW00ZEpv?=
 =?utf-8?B?QUxCNm80SG0wSzhqOHVHc2FsdHpEZWFQTmkyNzZoRTB1M1hiWWwxdHdPWjQ3?=
 =?utf-8?B?bUxvTC9FbzFsM2pIRjZUdVNsbk9jb2IxbzNlM1p1TUk2Y1B4WmozYjVFOXhV?=
 =?utf-8?B?MXYxbGcwTUh2dWU0eEwyMjB6YWFVV1NkVHBWN25jYlc3TWZxNGIvQVYwMlRm?=
 =?utf-8?B?NktXdkhTWCsxNjlaSjNndXhJVDNXdGQ1bDRhaUNEaStUM3RDQTkvVHd3S21B?=
 =?utf-8?B?NEJuWFFmNnRYcmsxYW12dHA1bnU1a2J5VkxyMWQ0S1hNenpBYjN2TzRWY2da?=
 =?utf-8?B?MmNxZGhPSDU1eEF0YXI2RlV3VGdLU0VsM3RENEhyeWE4ZEFCbUc2UVZoTjRC?=
 =?utf-8?B?cDFKVUE1a2trakN4Njd2Q1prQUZzbmI5MS9PSlg3Vm1tMTQ0dkNuQ0plZS9r?=
 =?utf-8?B?OXFldXlFbFErMEVKK3dER2Zhb3lUUEFlaC90Tjd3VkxOT0N5QkQvZE1wcENX?=
 =?utf-8?B?ZWxBTVpjQUpHTXY0bmNSWmxRMzFWU2JoQWI3dWdUQ0I4cE9HeW54SU1zbS94?=
 =?utf-8?B?WHdxU3hISmJybExoemM3UUU2SGMvaWhpMGx3YjB0OTF2ekFxa0JzclVpeEJN?=
 =?utf-8?B?YXJNZTljMTdjVGNzUHhvV1pOSnMwOXZlSmxnKzhPOVEyU2djWHVDbUZhOFhM?=
 =?utf-8?B?WU5tenIvMHdyRnpBaXh5RmpnVm0yWTVmZmFNRmU1T3lyNEdoaFdhMS9vNlYw?=
 =?utf-8?B?ekRKaE43ek5BM2lpY0tlMjZYRy9URTBlWTFZNURkQlNyUzJvRWh3SHlBZTZk?=
 =?utf-8?B?U3dUT24rb1dSLzE1SUdRaWtSTWtNYzgvNFBUTmt2ei96Z2psa1F0eDhDelFG?=
 =?utf-8?B?MkxNcUozbkR6MENLaUZsbGxnc1kvWllpZGdjMVdPZG9iTWhseVNlWmxDRTIy?=
 =?utf-8?B?T0pvbS9GVG9ZSXk4ZFUvNVBXYUw4VFg3alQvWkZLcEpKSTh5eEtheitkekFv?=
 =?utf-8?B?MDV1VEpUVXpDM2g1ZFZNcWdqS290UUN1UmFTZDVrcXJYdEEyQ2VjaTJzUUJv?=
 =?utf-8?B?cFZQeTJITWg0cktFY0V0YlNCN0lPeTdEU0ZGNlUyeG8wR1hYbWZyMXpjRk02?=
 =?utf-8?B?cS9zMTUzRzFZOXJsVTY2SDUvOXlDNjFzRE9PN2tRTVFQQS9OaFRjVUJNMFdn?=
 =?utf-8?B?cGJQSlBCb05KV1p5REc1NUlxVms2bE9jOERvK1FsTlJaeE1tblMyUHpCQmVT?=
 =?utf-8?B?NzVjZ09BNk5HNEVoeStZRkc3M0dKVEQ1b1hTOTAyRGEvYW9KaTE5NkhXUFVL?=
 =?utf-8?B?am1zZ1RsVmZBdTNHdE1sV1BYRm00WnIrVHhlb2ZrUGtEQ2Y4YTlsaHFWdmU3?=
 =?utf-8?B?RlVBMk4zK3RUU3NEWlhveUo0VVQxcXdMQkxjS2lybnlXVGVmZ2dtU1M0bGov?=
 =?utf-8?B?V2REbm9YbU0rZFBqaStqUGVtWG54WG5mYjY2c1RMWm11ZGtmT3ZtcUhVLzNS?=
 =?utf-8?B?bHlLMDh5K3hFU3lxdlBiUi9PS3Z3Wk1HYWxHZ3VOTVd4a2k1TWdCeEF1Ukpr?=
 =?utf-8?B?elpyL1R4TzZtRFpTZk52L1QyN1NWanNQaW9hM1ptS1hQSjZMU3VKbWdUSUUx?=
 =?utf-8?B?SHdJb1BXb3hzd3ZFK0N3MzJJTjhZUS9EbGRrbGN1WXZGU0FZS2lDWjRVeVpS?=
 =?utf-8?B?MTZXWjFXRnMrUTh2V0p3RkxySys4ZGNBUGFuUGN1OWxxVVcvRVdMS2NXTEFH?=
 =?utf-8?B?VEFDYzNJZmp1b1ZJZDkzaEp5cVlGTTJ1RmlnUUovL1JKRzhMclVaY1NtVHNM?=
 =?utf-8?B?YS8zZFVsQXRHMHdpQ2VWZlluRDZJYkZtMHMvMGFjcFZLYlJPRjFoN0JTcXZo?=
 =?utf-8?B?T2ExcUNMWVphZWl4Mm10NEF0V2pJZ2IwMU1vemhrZEViT01QcmpyYXNhOUEw?=
 =?utf-8?B?RS9uaW82VkdLaEtsdzF2eStOSGRTUGRVdkpDZkdEdHpYRWdOUzQ0cUt3NlRS?=
 =?utf-8?B?OHlnMEMrSGJFVm5Eb1pCcE5RMnk2c1VYWW8yZ29SWlVRVFRVbU5HNnNwUHhw?=
 =?utf-8?B?YUFtbmEzVG9JWUMyazYzaW9PWFNxMm9PYXZNclNENlFHMFd4OGZudGduRTVP?=
 =?utf-8?B?RmdMWUwzbm54T2JDWHpPbUVPQWdxMGkwVktaTWdBdnhXNEJWTFFyTlZDZGN5?=
 =?utf-8?Q?f6yB7qO97kJUpMx0=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aafb374-bdd3-4bc1-40f1-08df38f74026
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:37:49.5000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG8DtlsllaaFXYnpFuL0UAH7nLJuQqiNR3OL0J+l7pMAnrPdTapi3AQwQvsp+p2gfSmOhEf/stAKmNcoVtsjhdD0YxH74RfC8L+0tV31tEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5814
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 31.10.26 15:06, Simon Glass wrote:
> Hi Frieder,
> 
> On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
>> test: boot: Test the RAUC partition name check
>>
>> Set CONFIG_BOOTMETH_RAUC_PART_NAMES on sandbox and give the
>> partitions of the RAUC test image (mmc10) matching names. As only GPT
>> has partition names, DiskHelper now creates the image with GPT instead
>> of MBR. The existing test passes with or without the option, as the
>> names match.
>>
>> Add a second image (mmc13) with the same layout but other names, and
>> a test that the RAUC bootmeth finds no bootflow on it. The test is
>> skipped if the option is empty. It needs an #ifdef, since the string
>> option does not exist without BOOTMETH_RAUC and IS_ENABLED() cannot
>> check a string.
>>
>> Assisted-by: LLM
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>>  arch/sandbox/dts/test.dts |  8 ++++++++
>>  configs/sandbox_defconfig |  1 +
>>  test/boot/bootflow.c      | 27 +++++++++++++++++++++++++++
>>  test/py/tests/test_ut.py  | 26 +++++++++++++++++---------
>>  4 files changed, 53 insertions(+), 9 deletions(-)
> 
>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>> @@ -1824,6 +1824,33 @@ static int bootflow_bls_prefix(struct unit_test_state *uts)
>> +static int bootflow_rauc_part_names_check(struct unit_test_state *uts)
>> +{
>> +	ut_assertok(run_command("bootflow scan", 0));
>> +	ut_assert_nextline("No bootflows found; try again with -l");
>> +	ut_assert_console_end();
> 
> 'No bootflows found' doesn't tell us much here. The test also passes
> if mmc13.img is missing or empty (e.g. 'ut bootstd' run without
> test_ut_dm_init_bootstd first), or if BOOT_ORDER still holds an
> unknown slot: bootflow_rauc_check() leaves "A B rescue" in place if it
> fails partway through, and get_slot() then fails the same way. Please
> can you set BOOT_ORDER at the start and check that mmc13 really has
> the expected layout, e.g. by asserting the partition names with
> part_get_info() or 'part list mmc 13'? Then the only thing that can
> make the scan fail is the name check.

V2 will clear the variables for each scan and then check if they are
still unset afterwards. I will also do a positive scan first before each
negative scan. This will make sure that the partition layout is actually
correct without adding a separate check.

> 
> It would also be worth checking the environment after the scan: clear
> the variables first and assert afterwards that env_get() returns NULL
> for them. This would show the env_set() problem I mentioned on patch
> 6.

Yes, I will handle this in v2.

> 
>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>> @@ -1824,6 +1824,33 @@ static int bootflow_bls_prefix(struct unit_test_state *uts)
>> +/* Test that the RAUC bootmeth ignores a device with other partition names */
>> +static int bootflow_rauc_part_names(struct unit_test_state *uts)
> 
> Please can you put this next to bootflow_rauc(), rather than after the
> BLS tests, so the RAUC tests stay together?
Sure.
