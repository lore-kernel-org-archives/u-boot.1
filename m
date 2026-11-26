Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53C606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L4u2ytM4;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=hOKxetJW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C12F860B67;
	Thu, 26 Nov 2026 13:34:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZLcgPhGFvfG; Thu, 26 Nov 2026 13:34:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0A3A60B50
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700054;
	b=K9r3B6L2HcrP4ufx3h68yoWLvXTFG4cpCzmpoyU9GPS4kCXDbXgAla/yC7z3z6H808nF
	 GGDUI/ZiHnDRJk/Y5uyqDrMhpKnfKYRUnAk3+TodUru3l+LfaiiCn2h6HSzrRM/uAf6xe
	 XTIyhPHvn5pLS5to2e8ky6PJ/D1BwGivk63fTIQkuRJJw6ZqpvDh8qLfELI9YwA161C6S
	 3XYrJqjiXhf3b/mxmBrEXHA2sSvq3+VfnCVctlu7/9/odB9+D7WfjBTwTl+oJyocusHCn
	 FD/xTtNFY08KnWgG2l5it2rtBHpm9WKf2V4Gwkxty0Eu25y8w5xz7Y1/oHyYx5ghTCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700054;
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
	bh=uFyXjs5saDS/UCCK1nhHe7HAbIaBgB6mqR9JrgZvz+g=;
	b=C5sbgvaijxkrhR7CasBJ4beWQYt7kye99HgQgQyVtYpzcjt7tfUEkEKt+sqPnPc6YwAN
	 9BMrD5bIG1HJsBwLW1SNpP77CQYI+94eIYJKFgr6pgS/EO3YsKdIEz4ntX+SBssUBgsf9
	 tuXgt23jwySPfpzs4+UBJrEOF4En//CS4RPbOFNOab/QaC5UgFv7NMxPMiU3bEH23aeB8
	 dqU2jiEPJOuK2HEZDHzCsGYNNdlKI2fq5HrR5NZ52dP3WMDElUb/3XFyG2LmaPFBfK6cE
	 dTxCcI7z46xcOeDIND7ZsmAFDABqPyuJNZlIzpw2uzVI0W+pbIl39j7PWdzsisdQWlg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=hOKxetJW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700054;
	bh=uFyXjs5saDS/UCCK1nhHe7HAbIaBgB6mqR9JrgZvz+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L4u2ytM4Lxjo4/Tl+tWCOnnj9Stvy3bGLvUa2UiT3h7ITfV1eQdNk5/GEwvdG9QCw
	 dXfFKGs+gqKwXUlLlY8umg/TIiv0+yDUhob3jgybQWV/lR1ZBAU0icJcU3zCQcjS6w
	 DEzXKDrdz9zY1Zc+lB7Sv99/3UWmMIeEyqrmfFubARAbixrtMU/tGbchxl/cEvv9+q
	 3/sUuF38C4zZXp+Cw9hk0X+KDGboF7TnMk4WeI/cyqzLEvDKFug59SvtMwWcLF/yBH
	 Zme1DmkMRZeCYnwkwyU1SSTv+aFYXd99mzAtGMtKczJbXd+GIKkwo7QaimZB7egidC
	 B22D8STzn5dIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0A3A60B50;
	Thu, 26 Nov 2026 13:34:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 06F8B371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E084360A55
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63y7cl_hjETu for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:25:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4076608E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hOKxetJW
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4076608E6
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFyXjs5saDS/UCCK1nhHe7HAbIaBgB6mqR9JrgZvz+g=;
 b=hOKxetJWjwFovzcXhLFak9v0BX+u2QS4umNxOt6afmNcxyxOS2bDTtgb6L5cPtRUVnRdz4u600lx0I94qOnFUB0l5OTuiXwt4BXKwQEvebXi9evFCbxlDAicZs64UFMILGdyjWr9Gb0jLRcAXZWGcmeYYQSQ+6UK3DU0Q7oSPds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:25:25 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 13:25:25 +0000
Message-ID: <dc07cd01-51fd-48f7-af9e-6df5e58ec2d9@cherry.de>
Date: Thu, 26 Nov 2026 14:25:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/23] spl: fit: Report compressed data overlapping its
 load address
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>,
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-8-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-8-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000164.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::873) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB8PR04MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: b899fbaa-1034-42a3-95fc-08df4bc0babf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|5023799004|11063799006|4143699003|261022105027099003|261022115727099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003|3023799007|41080700001;
X-Microsoft-Antispam-Message-Info: kR91WRHvAdaslftv6fH9puZtzzt/wI294jjofzEiYTnr/B2PKGROg3MHEMMElJJ2VrWJlWhPQo0s6ydFlE8F+4vkxCK5ZKrTlsmDuOydYYHFZpBNd7kjwFR2NLDs7S+MuA/sBwxcecAQ0u7/Coza1W+cQDjzKm9t2ltLYCB4zXN3SQcy2Sw/kAh1WYRKWdki0wuI6mYN6y6u28UISlb00Auna3XG2A7ZFYjUmmI99lALLmtauuJGfG/gUovzLWfrfTHXxlrY+lMOdj6sKC01btlbZ/00pBT7i1h6QmDZDW+663G5fvtGjiS+3EHv5TMT+VR1AspfWC/Avyg7ZIT968ul7NL2wJ6NBHSLqj43ZansYEAceZCnZi4pP+CWFU/DvnOZ4xF53WchTdv2mzdwF5B4wa9ycdnfszZqj4K/Qh6VhDRYyUG5sP5PHYkV4zW485EfJ2O/4uUy13lfAaZ+RmIMWmuQ6YfmduOU2QS4lLp+Xv1vdc+C9QA+yLJde4oiUkNVQjlliVg4AAJJgR52y2Bfx47URdgdCpGkjSFAOsc+/C++JQ4S2uJukI8j5uOKajMy2rZ6n9wltKxUKxdkgh/SIyVFd2lHWzK81zKXE/Aym21/GZmWcDfcxsjXuNWcqwyo9XwRjXcWUPGtRkzivH2SI+e7ev1rOgxN51XAHbFOfdSFdhUNJS/He1CoVrWmasH6T45N3HvkWvebvYftWNhXUA9yXVmXRCF0iS1xgZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(261022105027099003)(261022115727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(3023799007)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnJOSVM0RmJFSlF6RG9Ua1hxbFNrTnVNQ0ZUa3JlWVB6bWRXK3dUa1Iwb2sr?=
 =?utf-8?B?c2RzV3VDOE5ObEdUeUNNNXVkNFpGSVFvUnpYU0FyQ1FIa2dVNUY5VlZ2OFdT?=
 =?utf-8?B?TlhOS1NRb0g1NTJWU3lmUDJYeENId0YxVnVZb2JLR1lVOU5odXBEeFNXQWxI?=
 =?utf-8?B?MlJoemZjWExqY2tNcUVPZm1IMEM5ZWtXR1lZWXo4dG95QTQ5aXhrMTVaVzY2?=
 =?utf-8?B?SDRNZ3hLTU1JQ1U2M25oUW5kRlBzTk9Fc3hmcFZZRjh6c05tSzE1ZGUyZ0lv?=
 =?utf-8?B?alF1c0M4UU0rMS9ueUlSMCs1dHdydnZIM0t4Y0hJbFBydm5ZUTFkWm1sSm01?=
 =?utf-8?B?b1YxWmhZV1pHZEZaekJTRlNwT3RnQ3dHOTlzSnVrblRTa1ZDMUpDcStmSTNF?=
 =?utf-8?B?NlNLdC9QQXNnSEtreUszZ1NqMW91VHliOUVraGM0Y2Q3UzBoMjY3T0xlTm9E?=
 =?utf-8?B?djRqMkx1VXlZckpSQ0JOQS9Rd0lVM2pYQjNwNjJ3clltaHFJOWJ4M3BsYS9W?=
 =?utf-8?B?b2ZNRlZRMmRUWGR6NU1rUDc0MFJTK2pYYlMrMlkwQU1FeGdLL0hDaDdNNVBX?=
 =?utf-8?B?S3o3NUhsOU93ckx2ekk0bDUyaTdLRUNxRnV1OGdzNnp2dmY3UWV6M3Zra2E2?=
 =?utf-8?B?NHlxLzBBaHlyWEN0WCtod1JsNEw2Z2hSajNGM1R3T1RJMlZnZlNpN1MzTXlX?=
 =?utf-8?B?Qkw2RWQ3VVV4Zko3cDBJMW1tcVhhSDZrUWxKSkQ0L1h2WVVIYmJVbWJ2cmFi?=
 =?utf-8?B?T3Q0ZC9ZZHI1d3k5KzhsOUd0Yk1kKytDUzRtNWcyTDhRRms3dU1jdEUvOW55?=
 =?utf-8?B?b2xXTVdTTmtFaXFKM0s3QWJwci9Nc0EvU0FwQU9YbFhYSzBSc2FvQlltcUJ0?=
 =?utf-8?B?dWVXSUxUQ2RLOXplcXovdWFwaFdsdUFIM2ZmVnBzSnh3eDg5NEpTOUJiUjg0?=
 =?utf-8?B?aHc2dmJVNEdDa0hSZW9OYkNrWUpWWHdCOVlJQzRoN09XcWlFajl0dzNhRmts?=
 =?utf-8?B?elA0NWhqQS9KVEpHemh1cVpaN0E2Z282YktVaUdUSndMQWJxUDRFV3NMTDRU?=
 =?utf-8?B?Y0tBMUcxMllaSitXUnNBUUt4cWRwcC9EbEI0S1EvT0R5U2RzandVOVB5UU1X?=
 =?utf-8?B?UExuTXdkY3MvNHVGMFRQY0ZDT1BsTVhlN09lWHZzQmJqV0FlS1Rad0hYQWFQ?=
 =?utf-8?B?N2ZaMUFlZkhheTlOU0Z4NGE3cVBYUjdZVUNHTlgyekI4N3lvTlQzTHBralpv?=
 =?utf-8?B?UTNYWHVVSjA1RFZXajIza2Y0VDl1dGEvNlVlS1pKbzN1V1M3dkd3N1l1djBu?=
 =?utf-8?B?bWlzMmdDN0RuV1F3cXBacHdaT3lGN0pnUVcxMC8reGF6UE5oWmNWc2daUDBN?=
 =?utf-8?B?b00vN3VUaFlrcDA5d1JaQjhOaEl6Q0dlb2h5OHhkRGtFUkloUkR6enhqejEz?=
 =?utf-8?B?QWV5OHBORURIOUxzSzl1L0ZQZWQ1dEZNelowSVF2R0Y0MnhPM05TVWxxZDNZ?=
 =?utf-8?B?WUIxNTBUc052dk5NWXJwdkNKcWhkYk9ManM4ZWZoYlNFcGJTOGQyd1RTT0tX?=
 =?utf-8?B?VVZDR1d5R0NSMTJRNjhZekRHZVVsTlkzYTNud2xsYTltNWhhK2hKODh3UWFG?=
 =?utf-8?B?dTBrQ3Q5bE5zK3hISGRjT1FOQ21tUDNGRWdtcUlaSXVjNDlNLzM2K2duRGdK?=
 =?utf-8?B?c3JTZXE5OEJtR3VpOE9RRWZjckhuM1pNRDRDNmhhSTNxSDhCN1g1WmJyTytv?=
 =?utf-8?B?blJqTEZEOHVkUUhxYWhHbkw3UUJOU0hzR0ZidVp5dG5Zcy9oK0dPbjdwQ3Jn?=
 =?utf-8?B?S09LY3dxNmYyT056QytFV1dObHBjdEZOYjl0akU5TU5MOEl0aHBjY0tjejF6?=
 =?utf-8?B?NnRKMFBmTlF1SG1wSWcrbEorS1F6dTExMFRMb3Z0eGQxclNuUGxRNmgySWpm?=
 =?utf-8?B?eWp4QzI4K0pVamNvd2NjRE0rcDRVa2tDUStsSVJza0RvcVExWW1scVB4Rnp2?=
 =?utf-8?B?ellib0xLMDQ5UkZJVnF5SzR0OC9qTnB0NGh4WmlsRnBIdGlBZTFGZi9vT1Aw?=
 =?utf-8?B?c0hGSEtqSEQxblB5NVF0YXd6eU9GOXF5U2JLZWloRmVqd0ZGTmdTZmdqVlgw?=
 =?utf-8?B?RWl3TlR6WFVmWDNMcWJpSGw0c0V1ajF0WlF4MDhJVC9ETDVia21TSTlKdllO?=
 =?utf-8?B?TkRkT3BudFlGakJCaENqRllRYVc5RVoyQnM1MUlvSForWnVaaEszZUw1MlBY?=
 =?utf-8?B?UGZ5d1h6ODhGYlRuZlM5K0hCOEd1QWtiK05xMHY0cnY3T3hzNVluVU5CN2c2?=
 =?utf-8?B?WGh4T25JOUE5VTJjSEFPWCs3NGN0ckxkWlFRZEZyZEV0V0tadVNtZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b899fbaa-1034-42a3-95fc-08df4bc0babf
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:25:25.0150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asqCq3qrydKxltLLlcL6HjJhQek26GuITCuQRJRRpoUs6UZbGjI0GWh67zEVzXv4hNaqgezN8fRtRScZh1haTidxNeDHE+Z0gjdM03QaSk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6795
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/26 6:40 PM, Alexey Charkov wrote:
> load_simple_fit() stages compressed external data at SYS_LOAD_ADDR and
> decompresses it from there to the image's load address. Plenty of boards
> keep SYS_LOAD_ADDR just above TEXT_BASE, so a compressed U-Boot proper
> there unpacks over its own input, and all the console shows is an error
> from inside the decompressor, with nothing pointing at the cause. Worse,
> a decompressor which keeps no checksum of its output may not notice at
> all, and the image's hash only covers the input.
> 
> Refuse input which reaches into the output, naming the addresses. The
> output size is only known once decompressed, so check against the input's
> length up front, which catches the common case before spending time on
> it, and against the whole output afterwards. This is conservative: input
> just above the output can survive when the output grows by less than the
> gap, but no layout is set up that way on purpose. If decompression fails
> outright, hint at an overlap the checks could not rule out.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   common/spl/spl_fit.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 50c4b269f700..e0ded9b9b3dc 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -272,6 +272,40 @@ static u8 spl_fit_image_get_comp(const void *fit, int noffset)
>   	return -1;
>   }
>   
> +/**
> + * decomp_overlaps() - Check whether decompressing may overwrite its input
> + * @in:		Start of the compressed input
> + * @in_len:	Length of the input
> + * @out:	Start of the output
> + * @out_len:	Length of the output, or as much of it as is known
> + *
> + * Return: true if the input and the output intersect
> + */
> +static bool decomp_overlaps(const void *in, ulong in_len, const void *out,
> +			    ulong out_len)
> +{
> +	uintptr_t from = (uintptr_t)in, to = (uintptr_t)out;
> +
> +	return from >= to ? from - to < out_len : to - from < in_len;
> +}

thought: surprised we don't have an existing function for this

Would have thought we need to check this in other places.

question: do we need to care about memory wrapping?

I.e. from + out_len wrapping around once reaching the end of DRAM for 
example and overlapping with to?

> +
> +/**
> + * report_overlap() - Report compressed data overlapping its load address
> + * @src:	Start of the compressed data
> + * @load_addr:	Address it is decompressed to
> + * @external:	true if SPL staged the data at CONFIG_SYS_LOAD_ADDR
> + *
> + * Return: -EINVAL
> + */
> +static int report_overlap(const void *src, ulong load_addr, bool external)
> +{
> +	log_err("Compressed data at %lx overlaps load address %lx%s\n",
> +		(ulong)map_to_sysmem(src), load_addr,
> +		external ? ", move CONFIG_SYS_LOAD_ADDR" : "");

thought: don't like the external -> CONFIG_SYS_LOAD_ADDR shortcut

This is only true because compressed external (so doesn't apply to 
uncompressed but external) data is currently loaded at 
CONFIG_SYS_LOAD_ADDR but nothing forces us to and then we have different 
places in the code that don't need to be in sync for things to work or 
be correctly reported. I think a comment in the right places would be 
enough and less likely to be out-of-sync, or if so, not too misleading 
to the user if we ever decide on another loadaddr. I don't have anything 
better to suggest.

> +
> +	return -EINVAL;
> +}
> +

question: why a separate function?

I don't understand the benefit.

Looks ok to me otherwise.

Cheers,
Quentin
