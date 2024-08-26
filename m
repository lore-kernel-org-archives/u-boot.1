Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B40C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA988895B;
	Mon, 26 Aug 2024 14:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="Xoz7sRBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECAA5889C9; Mon, 26 Aug 2024 14:51:23 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA5C88001
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTvn+lNOu5MWx1cZylDbpMLgLG5GyiFdDNMWoD1s6k8YDNuCP6ioPnp3LilIbabD65AYM14Zz2yilPbBl2on00U3umuAAbtAfpQeQQuwJyOgGkiSheWSnyCeOLImanEDinB4F1SCM4whUT2U/z+HEsEje4t+dX2T9NsctczZCOrfjV+k1bXWFDnVyHd2mKsY/oMFTjG97MGdz9UUA+MpYNBsenCupDvpfWbD9Gg1KjDZyqyb/moH1EQM3eRMgeDNrEo3wtst2n4+89Pv6nlrDzxmZfmkt8sKYmUd8yOugA14ZQZzeNWQGYLt3bid+3aoDIgETLk/9Xzlm6iSQUILTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvCsq8PQ69TJ8vLooNb+NL/5ZfMCxNK4duxvZbSUDzQ=;
 b=NLq2fmVWFCQNFgwZmh5rKvIevjKZOQq5pXz3+DdbOvXj5riW4IZRoZTuEWLHrFSyJGZbiJMnrx+arfWbHXojx3Y3yCsY4Xs3t7qSqiCdLVtM5E7QDfRYgSgujnl6LK/EUgn/Skaq3JigDyFlE375NQyHs8eLYQyUSfBnfU+7PUtF+ycnb0AGbkED6tXBRqSUYu8g2kf+K9qs6Q2/8SVfsTYeV+x5/vcQgNrYgnUKfg8tFMwys4WZRTPs46/qTNiPj7lOcEuNls+/Chf2p4Y5NmZpt7uhLda8ztkWutcD8Ebk4As1eTtEeHPpsufsImLrMEcaCsGR9Ikd1S0Q32kvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvCsq8PQ69TJ8vLooNb+NL/5ZfMCxNK4duxvZbSUDzQ=;
 b=Xoz7sRBHX0O8HrvEuoxxIhO6j8IG9Kdy2bsbJWcaL6uHrEPv5KYYKTV83+2MHONvsdKSWwQJ9Rc7/7JXtI10oa0idCqX7H3uBxD904BKIMtS64Otn827S0TzDmyhKBQQb8zps3gkjihcIStJMJ/zTV2QonTwuhZmSqTlmfux1SrJYODPJgYwdzL9dJ297WE/RJukkwU+kLHWUYp+wnjJVz7yYYJS9oQ9TS7wseKdpFP3McqWStDbPu4N7xRB3dPjZDTibTtg+3FPkC4FMzVJXRfPohNbKq0okKQU8zqFUSYwbETrNCg9BgHpnvLOQLEQ0z5/yH0w36Q/VEwj67itUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB6534.eurprd08.prod.outlook.com (2603:10a6:20b:31c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 12:51:19 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%5]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 12:51:19 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 0/1] env: introduce variable value ranges
Date: Mon, 26 Aug 2024 14:51:10 +0200
Message-Id: <20240826125111.1332215-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 893c62b3-a64f-497e-3739-08dcc5cdc795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?skyERZ3mLPcx06ODeO2K+4+TnlpvGyfsUJ+BzA7tjfzL+HfyrY5A845tnaEU?=
 =?us-ascii?Q?Py9hu4sAgC3iaTECFfRCXzJpBZUcQ7Ba2rCr/KS2kYuz5i7xB7xtYm7liMTr?=
 =?us-ascii?Q?CCfDD3hYz27QRTBBlU02HCHbS/NC56ImH8dnu7OPItpNC98rq2jI+DMB5WUb?=
 =?us-ascii?Q?JbHYTqM5p1q1kCMBOD+qSTXZQZIFO0hlehZQimFLrjfiHwe7yxgkJW+03nzy?=
 =?us-ascii?Q?AYiVUoJa/WocYgRQSGZFhjZAxBKym/Lfc8l5ltkFvqfhQZKtuOwtom0MuZlE?=
 =?us-ascii?Q?mDPYdg3gvDjLnb3RUFsjCtt3z2p/J0V5TBcy7CMMS3b3DJuVE44UH0p9Db6W?=
 =?us-ascii?Q?2dFsoND8w/hUqEXY1Rl77Y9rYZyxiSWmWeUuikT1TYUvB8i9VX88DfOjsq7N?=
 =?us-ascii?Q?wAo7VKaNaauRhULFzO+c7GGRbsympATISLwL/v1MxioutjJ1bZmjHxFaYdrw?=
 =?us-ascii?Q?u+0z+a0VR5rH4mlPupWErgySjzxWLLiQ6l3+HaRPiSSdcv2WLOhD1Rk7ZYhv?=
 =?us-ascii?Q?n9ZbK41zhQxJIEu2fXQcK3aZQhOZitVKVhbIH2pVNVmoxosKZL2R/EIXoq5Y?=
 =?us-ascii?Q?S+vItigiCkzlJl4wMIn8U8VR3ReC0xJHYbDCbJnJRtrcGQJKQ35vRxcsEhHg?=
 =?us-ascii?Q?ASC921gveuumraQa3j7/CWCa7t96RvVYbqAdaemhDjiMiqkmRmj8r97yLM/T?=
 =?us-ascii?Q?W6nJ3L1qZFkMKHOHyypDiPR+wwRLmrSwMq/PE4MGLG5fOnp0UUHqT/bNfJ97?=
 =?us-ascii?Q?u0lTQWS6qMzxC/sAilx9ObOw4D1l+KqDQXzNUAXFO22XoZGnUBPi9l3a353t?=
 =?us-ascii?Q?HhwtSy8t+Ddg595svd/qwYhFbzCUaCi69Xk1Uv/f8r50aSdPrx/VcPsJ6fDL?=
 =?us-ascii?Q?LG8bYqDXG9kWxyzxdONnsDqxCB1Ezd4SeRetgE3k+QNsb/LjFEOGlTBwT8UR?=
 =?us-ascii?Q?dkZBnsOfePYTtcIT+YfwB2BpedMGIe/Q6Gu1HdOTlIe8ohJjskHutKO7Ca6l?=
 =?us-ascii?Q?tafreSj5BYs61wbj60GU1cu3mDf0MUs/vybGkbRp0S6cEz+APgurAdKbZbRk?=
 =?us-ascii?Q?6O0GBsN9capP+oknL6N3aij/Paa04mZRm3Je9alAXtyCuCIYNnI4s8FEbxOe?=
 =?us-ascii?Q?4dHjCR1O7oxdUP36hlQQyKCdKbBMAOkPN0xCCcVdRy7E6XFEDRv01M1MdMn+?=
 =?us-ascii?Q?DXFsn7uVf2+YbkxG2TwEhh/nZoNtcjdXmKKr1MPRGlvhLHIYoQG8ZEJyMluf?=
 =?us-ascii?Q?5ovgBfjOSPkxiNGC64q/QXD3PurplsKl0gZjuwHXuSnDvUvbJwtmjPjpZn1P?=
 =?us-ascii?Q?9EeFwo6r8rFgbDPogjm0/2tKnhN5lgZNIb2UFjV2+JMH3Bh45A1Ew8HqATI/?=
 =?us-ascii?Q?Jk2wRjdimsB59BNNhFU3YWd3dcH8A0mO0Hi5e2+zZ8r3uRPhzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eE33zHX24XPgpL3nWy5Ay4J7Za3VeoBqLDoVP9zeDauvkkeltVS6Zs2QfjE6?=
 =?us-ascii?Q?XnB6rzaqy36G2/wrJsbh8uc7ks6xKyV109bZ0TJgolX59r7ReBBJua8ZXwVi?=
 =?us-ascii?Q?x+B4gB18kozPHR7AK6dRKLNtyB8Ws3m3pTKEBoL1GpyB7WNFQ1NthmcgVkoS?=
 =?us-ascii?Q?0rAg78V/ygSb//SHGC4E4o6uUpnVTYhHGCYyeJdw6vvNLv2QK4lMqrNDzsu1?=
 =?us-ascii?Q?Dyv4V1ESCF9eOPBvxSaup+T3etiMOp9Bci1JUtiVZQq+MUqJpI+UuV4AROcP?=
 =?us-ascii?Q?KATLHxMyiqwMEbW643SYbQTxV4seEKgjeBjlMpnKVwtxS4EwWFIbjF6/kGff?=
 =?us-ascii?Q?7PzgEYWNeuzpiVOvuVA4/6uCDI+NFkoI8zNDSa6oeVXGmD/V3VD/Z/XniWWi?=
 =?us-ascii?Q?qmnHXYXkblxGwL0uZ+CD+HeRN2al0r3AiaDGU52EzUxAJzsVlA05jeTZU3xZ?=
 =?us-ascii?Q?eBSOS9ui4c64SjKkOzNa0N0IzJGbhLRlLh2kRVmc8wdvLAdKloZgM+syTnJr?=
 =?us-ascii?Q?k5dSVvW9ghUtMOvpmyYXIArzwWHuEOHlO4N1IHavuCVudUb6eOR+slAqyPyA?=
 =?us-ascii?Q?1UcaueLs0zoxnwsrSmrW7DQ0HFDBfYVHnuEAqxzn6cYaXlkgW4+EQAPWCxRf?=
 =?us-ascii?Q?r9YDrVCNuAxUJH2n64lo62PzKq8rmdvbBO+FfeQEeZ/NeK/mouwSjejDMojI?=
 =?us-ascii?Q?GsgptlPE+1QNfO1KCgry+ML7NXkdOr+McxP0cd0EZxLzc4K9qxT3YOdzjABl?=
 =?us-ascii?Q?CjY4+EZ6hcvUi06TRmTxzrH95b6G38PB7z2yLD6YvrjhKDzG4Zh7+XGMoedN?=
 =?us-ascii?Q?EjeoIkGFYG8MTsuJBHHLydz/l/sY/ZVM0oqBac8l9fCEBMdY2vO3wp2uwRhn?=
 =?us-ascii?Q?rZPaRll+Y3zokdiLPPoFZXsBX+Jil2y7ha2crVekt2/rNc6pmeQiprlu4oCE?=
 =?us-ascii?Q?n2bgqM5PqwIJYn5rc0UHUZqt3cw2kgfy9XIRf1dIDjZYAapsTkcw6jZn4s/5?=
 =?us-ascii?Q?SXReyteYNOF6OAsIq2zZpFZDi2PyNamBV+SkOWW9/x8cb2H4DnklsYICIuFF?=
 =?us-ascii?Q?lUBsJq40SDLSHVl2D2xkqYP7GRjbrleyVOA+fb//98mX3twjzbxGsLPVBTuq?=
 =?us-ascii?Q?S1tDD3ZvR2k2a+0SwLCrhRmfrXry/Ry6MFqDJitK040dq5OnuJuR6FHPxl1J?=
 =?us-ascii?Q?OwBhyMX0axMu3eTkYavLeyFW0pGWxVnLh3X/X4/IpWvwM+Mlt3BSkNhyatbR?=
 =?us-ascii?Q?SLAvyAHIeoXUULyi3j7j+Q2cK4g5YUR38EGNd7RiUbM7pMk4eqbHAoph7gJ9?=
 =?us-ascii?Q?5HdPOpM69S6sRvNYlxZ0LrPfxKg4qyN3duvzg8175oyP28lDqoGiSP/Z7Svv?=
 =?us-ascii?Q?Z77qY4hrG4MzhAbQGlnq8BaZBVXeJvMFUZGZzZC+9LTwSQPwshhv2ixqz7XG?=
 =?us-ascii?Q?Dr4leO/MC9CGrG5jBwKBEbTO6KksG5ITOBJniJ27am2ioWUP6RD4tcfj0ax3?=
 =?us-ascii?Q?13KPIaDWoeOm20puSzaZf3N7lniuB09ByHyBwIQYwTMbu1cAmEWwkdbbAcol?=
 =?us-ascii?Q?s+08syDM225Y2/sAZxDO28ifR7NbtjTFPg9aNbvN4sEdioq85qc4t2R3RT5X?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893c62b3-a64f-497e-3739-08dcc5cdc795
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:51:18.8521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLSre2s2OAdRO2a3w22Dt3tFDuTHYh0QTrOKpOsp049vgTicvVC3ENoo3XbuCL2hmC+hD/7nLtrN3SAPsyFg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6534
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series extends the flags-variable with ranges for environment
variables. The range is appended to the variable flags using
the '@'-character. A range can be decimal (min/max), bitmask or regular
expression (64 byte).

Value ranges for variables can be used to make the environment more
robust against faults such as invalid user input or attacks.

Decimal-range:  foo:da@<min>-<max>
Hexadecimal-range(bitmask): bar:xa@0xdeadbeed
Regex-range: mystring:sa@r"klaus|haus|maus"

Example:

	"decimalvalue:dw@100-200,"
    ...

=> env set decimalvalue 1
1 < 100 || 1 > 200
=> env set decimalvalue 150
=>



Lukas Funke (1):
  env: introduce variable ranges

 cmd/nvedit.c              |  30 +++---
 env/flags.c               | 217 +++++++++++++++++++++++++++++++++++++-
 include/configs/sandbox.h |   5 +
 include/env_flags.h       |  27 ++++-
 include/search.h          |   1 +
 test/env/Makefile         |   1 +
 test/env/range.c          | 113 ++++++++++++++++++++
 7 files changed, 377 insertions(+), 17 deletions(-)
 create mode 100644 test/env/range.c

-- 
2.30.2

