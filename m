Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F3606ABA1
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j0LNd/Rt;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oOSR9oLu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2B278114E;
	Mon,  2 Nov 2026 16:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1IvrDQaviEu7; Mon,  2 Nov 2026 16:22:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0456081098
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793636565;
	b=j1nVswkfpaqkrkQhxFj4Numfopfdaoaa4/zXG69O+G+XBO5wjVycIFZDTLvc2CksWngA
	 612PiiLTcsaLIQpwl0bucSxJJ+exShwrleeuBrVYLdsYrS+Wp8aQnCh5/WySX3b95Nese
	 aYFuAVumMXMDT/Bsf/3snVjqXmysLri8S5gH6cffo0NUPh2fGi/TaZsiCatFSTsYLIZrd
	 JH5xr237GmGJJ/fUI9rrOxwTLKEv6cm7rwqIE0y16WZpLcc26WTOPxSf1S2NkwnDkJGq+
	 a61oqkwEXXHaz33bQphDHziGp5+Vrdbl0s0BtG8Lfa41Fwp42Nfp6hlS/mFsbUUVgFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=W6YDAK6uRgM8FLaOrJZ8k3Ma3ceoaZIogKK9vvvM97Q=;
	b=fVL1X7OtLT1EJznaZniyPTkOjseGCt/u2e7KduEmqZPKqQpUyR0DZO+b5qw7DCcZpPbU
	 86kPFGyExhrh2kIvHrfsagpjibuQ6nRwu+Zfl03g4irszQpBP0Gv4jbv9v17MzjP6DW0Y
	 MAqnbaexJIWnNRsk1IGJnk9QPncPKdkzkaLc9Cr+X09TH1Qy5uIBL161kyHfOjMGmWT3/
	 g7cu1sfTCY1JScCem2PBOt7rc6xuSEZ1ci71BzyHzACfgEZLI7VRow/62H2Yg7rlTquK4
	 8SURVp+DpF7cmF4pVp5F5CSZ4UNq0vJElgqTdtmPLv3n3ydTFR4nwWxZ3/KhUVW2lLg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636565;
	bh=W6YDAK6uRgM8FLaOrJZ8k3Ma3ceoaZIogKK9vvvM97Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0LNd/RtUioX9HRabMY9zeF46mLNVm2s/3DWuHL5jsigX1cUCW92jqxKvWoLNH++q
	 P95fWLbaW9NyuoyzDg0z570V3zyfRTmmfCQMIjuysDpNHXWfRmRz15BRn2mwyiNGSf
	 AYm736F2TrbC/vS8goIGPibU7FALhqajyXbrusP9rKdW3TyDPNfHdiz4uqUPLBnNxP
	 xuL/NZtCLiqS47Jt68vqF+FAMKF2hsB4q2HhqGHpNfwNKyNvKv0OVjRrCbOG5fJmo3
	 tKLMz76FMPfn4/1snVXxuR2/AnuQ/tOYTTF95/CPCb57hR4rTldlZO9qK5U81UlADL
	 7RFRzNhcY9eXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0456081098;
	Mon,  2 Nov 2026 16:22:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 659BA323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BB564006F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5JlOVCohjVO for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 13:44:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5A13E40050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793627087;
 b=Du2sxHr2ikFEVtAQkRi9vIpJyDkgpcDtHF1mLNpI+fYaHWImzo5PEjCOTAHhpyha8Wju
 zzN8J46mMUoONZbn3bZgy4a1qMwoqLh9w94yd1YP997JKPRR746iQFHnfvcz5BiBqHKhk
 mvmLx7EVsbr0ouCiavv8pz4rkCTCEWvYwO38vacuHCm3AvhM9S6BKAdwnlzgiy+BvpRdW
 Df9GKqkKQnU37aOprYJEmI6uMKHiBl9r/0nCNK3m2Hosz6akiP9C0M+dtNbmTQtzOWou+
 WX0TlHJFK+BKyIRxCYmHvs7zxQFIg3UlhHnC5bIzzH1e+OisM9h1zLPKStKQPEH9HwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793627087;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=W6YDAK6uRgM8FLaOrJZ8k3Ma3ceoaZIogKK9vvvM97Q=;
 b=tgxlJofzB7RWf3+eo0f0DB4+9k7iEx9FYhOvD1I9ccsharB2vb5wq2+yTG5GPdJNi6z8
 lFM6cAp8PN6S0SizyFmaSu2NiqKLrWGHZsBFE43vJx14Lm3Bz6GCg5Cxd6TiKqNG4u1ui
 Q31CV/nl/jN5AEocMgmuGEYnXgFc4QNpINqDluUfDExS1Is9a5efZ4oUEWs+Rn7JoRgm1
 urYTL+Obz7HaEmyfJBxzByHfu4VO9tA/6o70H3cwHUNDrzEF9BvZjJVzAJOXohzedz2G1
 19zCGZOitU1GVUkS/hiNh/lAkzwNzCYk//5Mt/Tq5Rs/2eT5ziJSkqq6JcEdm5e2sfw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oOSR9oLu;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=marouene.boubakri@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oOSR9oLu
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A13E40050
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2dvmXC2KW2r5h5ULlhnFXcTWT3jzH1CRKslfjcPrSY/bbRGX1Gj7RShdWPOFBOyTDOwzYja6aYnHZspPF7t6XD0s6CxHO17Y8oGwnRt9QXIxp68OEG8jR5vfu8Rh2t32WZvrc3hI7WjlDejGKnduNcjEdL7eChFfq8EW5LHJhP5PlDR3JEAQLABlUkiq0HOPtAKSB8B0lilqDY56+/FBuOiXGUwky8k2VXTF0zJBqzCytag4gXaHBUAC08l77Assd0JcB8E1YF6V6MR2BlBp836cabPewce11EaIQKwxiQMe1Xk8PnSeT8lVoPFDJAl8DzhKBvzS+BHUP3RPB+fUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6YDAK6uRgM8FLaOrJZ8k3Ma3ceoaZIogKK9vvvM97Q=;
 b=yUQtWnov7+W8ed84SUpYj4kCn0UtW2RuzfqmxJc6/EgkzaH2c7NEhIiOSzTmy5mYi4D6PI2kniJ/RtYtfaOuq0IIHj+3aBAdILcTbvbbmNS6cQ8OY9HzjVNG9BEhzR3eQhwfifH0dL1z5LPInOMqVxkj7WS1huqNP00sQHo08WbIfZNb8A+RFONEbk5Vq9/7JKMGl30NqoCbwTCpnQh5lgbZM5L+383HF1iIIyNcXdSUMuMkQ3AedXwzOsq+rD3hZ5PshboqJjUzG4rEBxNv8+eDlARbEIAVbu6IAh5yb8fwJtE0qCCOteqEGKI0THCrzYiMQ1bIpGPPXNgtJGshmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6YDAK6uRgM8FLaOrJZ8k3Ma3ceoaZIogKK9vvvM97Q=;
 b=oOSR9oLuNuQdSd4grjJmMZOqKHffPzYXWBS0hmu3V7uE2Yt46f6MtuAUEuDMi/VEkobtDi11kq8LewjQUvbmUHMAO7WNZPP9XlXtd2uMV6F+bDKy4P7Ygh2tSv0eObBQuAYpGn9sEGsWW3WN/A4vpo6GrPda0Q3SrppOJqt1fHsepTYCGTNRPoyRjgdVxqe5NLTpuOodbU/evN8ukBQ305qskn9qB+cNzh7qK2uNHqwIGJ9dY5ePH7U5DXdquhlaB/WVjQlYcL+hznU2OpxO7yUxALGSmbFvXKsAddNzDofiaQqfoIhBmoSZMWEJAy3FOkvYwYnIeAtoNpj+mDkjsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by DU2PR04MB8728.eurprd04.prod.outlook.com
 (2603:10a6:10:2df::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:44:41 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:44:40 +0000
From: marouene.boubakri@oss.nxp.com
To: u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Guodong Xu <guodong@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>,
 Marouene Boubakri <marouene.boubakri@oss.nxp.com>
Subject: [PATCH 1/2] riscv: add OpenHW Group CVA6 APU on Digilent Genesys 2
 board support
Date: Mon,  2 Nov 2026 14:58:19 +0100
Message-Id: <20261102135820.640652-2-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102135820.640652-1-marouene.boubakri@oss.nxp.com>
References: <20261102135820.640652-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0173.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::6) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|DU2PR04MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ed27e7-07a7-421e-d609-08df38e77190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|1800799024|23010399003|366016|3023799007|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|261026121527099003|261021121427099003|261022115727099003|261022075727099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: +aZW6fvSIZp447/ibKhLXO+87O7tHRn5uE5uPYrL7PZishqD8Gq5Do7WZ6k7/EmHMNskthOF3wSY9eRtV8PuT1PT8Byl7P56XOz7ZSUevEDZ3J9t5UxNg9F55ITdVNv6AuiKmwXhBJW2GWFYJyQRJj/BcGysgOIJoEYUI5J7N6JAhuCChxMucNrDicF4r+8oC9abPV17foDWjqg93zE82dQ2PHrLFnqg25Pas06Ewiq1azQvtnVrdaqTqM+KSspnpVWbX8jVuDAPwhW5V7hc+96yPpsuVpEV+QgZzr/KVSinVpt7yvdqfqcLo5hgYFTyqlaYhoWCriaU5QP45g4wwJPIXrBxKs5gjHeZ/rEuHEesoeuE53hg+Th8Mw3eL1DtMRhrgXAZQhLgsO81/rHCO+zGzmaMrqMf9M+Oh7tYb4bD3qFfd4LtpYfh4ZBwOV7jt136XK+VIqYlLfbKchCfjzlR6z7dQNg4g9+5ZIr9hYunNWc1Ydq8oGnApoRVWyfUQsohK3eHWYztAQyybHGp45tcuF4DKsKi/F0ulkY09oqRK1etkUWjFNfPZ+o8aBTwbFPoIIpddL+S2y1PEVrUkzNpTzfgH63Wji85+i4nlccSemE9fnHvVM52w5lg/ZNEC87F6PBc0qWtqoxum2PYKMWwdFHFxQ5zYROdEgDdH2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11203.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(23010399003)(366016)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261026121527099003)(261021121427099003)(261022115727099003)(261022075727099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BfCc0EkOuEIwWkdHDDxkigTnjXJ02xll18fg1YOgrUl84I9Qfnx65PBslijS?=
 =?us-ascii?Q?9lT4hPYfPalVi8+KdIV7MbV6dg6fxEOlx7+BFt308v5PjBes/OrduQ629M02?=
 =?us-ascii?Q?oSMGfgoopaaloi0iuOezfZE1MRAuI9IFYwE80glO5ZmAS1DhEKqBhZ2/XbuQ?=
 =?us-ascii?Q?De2GwE0p8sXa2/INa2aKObfJnku8TQswwheV9ex2lb0ycgbMtx27LX0Lv4xq?=
 =?us-ascii?Q?CEJ5/tDKZXVWjsUZuoBmMvfKOXCwQ6vg8L4DTPpAxog+oQ0/PJdxy7lnluBe?=
 =?us-ascii?Q?z1Fc52TUy8VgoRVSj4CLZWzONufd0EYIDwuqaJgzK5OwDiwytseTtELfWXcC?=
 =?us-ascii?Q?Jdrr5OfiYCktgTArideDmbgne0qm0SG0G8b5xCiAz4Exy4IuU0i2f/NIzuX6?=
 =?us-ascii?Q?cAJ88rMQD0ruDdZdCdh3WPrrm1yTpIJMRuEg2KYkj+k/A5QnMunkDnez9c7b?=
 =?us-ascii?Q?QqfUl4j20zkUiK6Vl3l/h4QUnXpXDYB7HfU+kLG/4gU4pwj3mTcpYlEAMFjN?=
 =?us-ascii?Q?pnNxRfbR4/pJOQeDvdPQTviz2RGzNlfK6naQnlGd2R2x9aV97niusF5yQDOe?=
 =?us-ascii?Q?sk+IY4teg3v4qxNrq34fPxcBIlahGdmc6djmj8iF4IHKgP6ivFdzPpg/N6Cs?=
 =?us-ascii?Q?h2l6MxO9nSq687JvUJCMlUdXsKjBQtnFM3sd94WUbKeizaIxdWQjphw1GnuV?=
 =?us-ascii?Q?ezfzadpjxD7WekRaJxsk6wBhvgB+K95TWq2n3fLei4KSfG9zKD7MTdx+7X+t?=
 =?us-ascii?Q?qB6nBFnVVi9qGICgaOdkqY6e3SR4xiUPf4Jqv0nbiFZ7Q9n+xuWuImsLXc0I?=
 =?us-ascii?Q?AofoSmVjB96tGwCvXzMVEzbaSYSNsNYj19jyzM6ANAkHejRT671lHsm/aS8h?=
 =?us-ascii?Q?IS3kOzjMTrbZbFuwc1RIxmh3Xcgj1w1G5HnjsPqj1sJWgIJmyZ01sg4NbxSC?=
 =?us-ascii?Q?Kcsrshf12SK7IWkua6N4ym/OF/BzDDHlYn7EgIjITA7sCkvzv5AeFqPas10F?=
 =?us-ascii?Q?CrX/c5mZ4QzgQVNM6z0+Jp7Rhr84NTX/a68ezgFwMl7tgPIkvOIPDjJFsyrV?=
 =?us-ascii?Q?HR2v75NvWjc31yNjQYHGu3PN75UCwYU8cHWO3WZVrer/xrPOR7/FTa9NLKS2?=
 =?us-ascii?Q?CpQiZTYpeh0jLR6hJhhwviPNIxRb8CZbeA6YEeSK+AbTKtkm10jB6xA7f+ox?=
 =?us-ascii?Q?S71lxhttoc/kyVqfgBNH4T3mcjteXKUne1SPM6nDnAPPeW0vgtKhnYJcZK0N?=
 =?us-ascii?Q?HaOlBmiq2DW4fqHF4sggW/BZrrLhx3lQXEqOMhm1QzMLBNRwmhJiADDCiwNW?=
 =?us-ascii?Q?IVjf3CO6n+c6TsoosfyvpS0M0fIUhVezVByFvgtaDaFRE1uE8FDQSkLFzg8B?=
 =?us-ascii?Q?vzB2tCNwaDpkW7dUQfcs6JT/jTaxKZUXXD5I9hHQlt+WqlLBm1WddUraXr7b?=
 =?us-ascii?Q?uF8eeXs7ZxKjus/jU2gdJfyyEk7VffbFOFJihj/PC/5aOHj8FpyuVZtlAXvB?=
 =?us-ascii?Q?6MWDGG/BzMsuaWNzSENGxpxua5zCZrbEqyIIJhho9+1U55W4Bc+K0gO7SMot?=
 =?us-ascii?Q?1/0FuiPrfy4Ty54/KgA09+nYgwVEsxsHYSEkmmnsKS/dD2nrBEzR0T+WiNDg?=
 =?us-ascii?Q?XSLeDaqhh9xoTy0S6+oSNDFJpGYM02WDRIwCNX2R0dQR7D3KSr1yI2OR2KuC?=
 =?us-ascii?Q?PiOz+czRcoC4/fa8DsK4uQ55DlyxsbEils/Z5BUxkPS466psOc6wwCTK2vzZ?=
 =?us-ascii?Q?GGiVjz+WV6Lclk7cDlalF7esigmW7OCzfT9sfAM/32/zbHZOnsk7ECjmz9i3?=
X-MS-Exchange-AntiSpam-MessageData-1: ccHIOSzma3C6jA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ed27e7-07a7-421e-d609-08df38e77190
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:44:40.6583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92F45mhZhrDYhnhhn5RaKHkJ2VP88iqVXc3fRoWSRSW4K3WNXwZ9tKdNelcq7a6+/8fnImxdvw68oy09uDdlUW0TQ1E4QsS5m3diNKSaXq1CpDo/qcLTS6nOjhzM+X5e5vPC4R0Ae37VX5Rpqqv2FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8728
X-Mailman-Approved-At: Mon, 02 Nov 2026 16:22:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	T_SPF_PERMERROR,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

The CVA6 APU is the FPGA SoC built around the OpenHW Group CVA6 core in
the CVA6 repository (corev_apu/fpga, release v5.3.0). It targets the
Digilent Genesys 2 board and provides a CLINT, a PLIC, a 16550 UART, a
Xilinx SPI controller connected to the SD card slot, a Xilinx GPIO
block for the LEDs and a lowRISC Ethernet controller.

Describe the SoC in cva6-genesys2.dtsi, shared by the two configurations
of the core that the FPGA platform builds, and add a board device tree
for each of them:

  - cv64a6: rv64imafdc with the B, Zcb, Zicond and Zkn extensions,
    Sv39, 1 GiB of DDR3
  - cv32a6: rv32ima, Sv32, 128 MiB of DDR3

The ISA extensions follow the core configurations of CVA6 v5.3.0 and
match the Linux device trees for the board.

The root compatible string "eth,ariane-bare-dev" and the "riscv,clint0"
and "riscv,plic0" fallbacks are the ones the OpenSBI generic platform
matches to recognize this SoC, so they are kept behind the compatible
strings used by the Linux device trees for the board.

Add the CVA6 CPU support in arch/riscv/cpu/cva6: the core has 16-byte
cache lines, the DDR controller is set up by the FPGA design and the
memory layout comes from the device tree. Add the board support and two
defconfigs for each core, following the pattern of the QEMU and
OpenPiton boards.

The boot ROM parses the GPT of the SD card, copies the first partition
to 0x80000000 and jumps to it.

The *_spl_defconfig variants put the U-Boot SPL there and follow the
standard RISC-V boot flow:

  Boot ROM -> U-Boot SPL (M-mode) -> OpenSBI -> U-Boot (S-mode)

The SPL loads u-boot.itb from the FAT file system on the second
partition. The FIT image is generated by binman from
cva6-genesys2-u-boot.dtsi and carries OpenSBI fw_dynamic (0x80100000),
U-Boot proper (0x80400000) and the device tree. The SPL BSS and malloc
pool live at 0x81000000, out of the way of the images loaded from the
FIT. The CVA6 is single hart, so SMP support is disabled in the SPL.

The plain *_defconfig variants build U-Boot proper alone, to be embedded
in OpenSBI fw_payload placed in the first partition. U-Boot then runs
from 0x80200000 (cv64a6) or 0x80400000 (cv32a6) and takes the device
tree handed over by OpenSBI.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
 arch/riscv/Kconfig                            |   5 +
 arch/riscv/cpu/cva6/Kconfig                   |  21 +++
 arch/riscv/cpu/cva6/Makefile                  |   5 +
 arch/riscv/cpu/cva6/dram.c                    |  20 +++
 arch/riscv/dts/Makefile                       |   1 +
 arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi    |   6 +
 arch/riscv/dts/cv32a6-genesys2.dts            |  30 ++++
 arch/riscv/dts/cv64a6-genesys2-u-boot.dtsi    |   6 +
 arch/riscv/dts/cv64a6-genesys2.dts            |  32 ++++
 arch/riscv/dts/cva6-genesys2-u-boot.dtsi      |  47 +++++
 arch/riscv/dts/cva6-genesys2.dtsi             | 166 ++++++++++++++++++
 board/openhwgroup/cva6_genesys2/Kconfig       |  60 +++++++
 board/openhwgroup/cva6_genesys2/MAINTAINERS   |  12 ++
 board/openhwgroup/cva6_genesys2/Makefile      |   5 +
 .../openhwgroup/cva6_genesys2/cva6_genesys2.c |  24 +++
 configs/openhwgroup_cv32a6_genesys2_defconfig |  18 ++
 .../openhwgroup_cv32a6_genesys2_spl_defconfig |  24 +++
 configs/openhwgroup_cv64a6_genesys2_defconfig |  16 ++
 .../openhwgroup_cv64a6_genesys2_spl_defconfig |  22 +++
 include/configs/openhwgroup_cva6_genesys2.h   |  25 +++
 20 files changed, 545 insertions(+)
 create mode 100644 arch/riscv/cpu/cva6/Kconfig
 create mode 100644 arch/riscv/cpu/cva6/Makefile
 create mode 100644 arch/riscv/cpu/cva6/dram.c
 create mode 100644 arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/cv32a6-genesys2.dts
 create mode 100644 arch/riscv/dts/cv64a6-genesys2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/cv64a6-genesys2.dts
 create mode 100644 arch/riscv/dts/cva6-genesys2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/cva6-genesys2.dtsi
 create mode 100644 board/openhwgroup/cva6_genesys2/Kconfig
 create mode 100644 board/openhwgroup/cva6_genesys2/MAINTAINERS
 create mode 100644 board/openhwgroup/cva6_genesys2/Makefile
 create mode 100644 board/openhwgroup/cva6_genesys2/cva6_genesys2.c
 create mode 100644 configs/openhwgroup_cv32a6_genesys2_defconfig
 create mode 100644 configs/openhwgroup_cv32a6_genesys2_spl_defconfig
 create mode 100644 configs/openhwgroup_cv64a6_genesys2_defconfig
 create mode 100644 configs/openhwgroup_cv64a6_genesys2_spl_defconfig
 create mode 100644 include/configs/openhwgroup_cva6_genesys2.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c1b2890f1..2ecac88d5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,9 @@ config TARGET_MILKV_DUO
 config TARGET_MILKV_DUO_256M
 	bool "Support Milk-V Duo 256M Board"
 
+config TARGET_OPENHWGROUP_CVA6_GENESYS2
+	bool "Support OpenHW Group CVA6 APU on Digilent Genesys 2"
+
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
@@ -116,6 +119,7 @@ source "board/beagle/beaglev_fire/Kconfig"
 source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
 source "board/microchip/mpfs_generic/Kconfig"
+source "board/openhwgroup/cva6_genesys2/Kconfig"
 source "board/openpiton/riscv64/Kconfig"
 source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
@@ -131,6 +135,7 @@ source "board/xilinx/mbv/Kconfig"
 # platform-specific options below
 source "arch/riscv/cpu/andes/Kconfig"
 source "arch/riscv/cpu/cv1800b/Kconfig"
+source "arch/riscv/cpu/cva6/Kconfig"
 source "arch/riscv/cpu/fu540/Kconfig"
 source "arch/riscv/cpu/fu740/Kconfig"
 source "arch/riscv/cpu/ast2700/Kconfig"
diff --git a/arch/riscv/cpu/cva6/Kconfig b/arch/riscv/cpu/cva6/Kconfig
new file mode 100644
index 000000000..0a999a55f
--- /dev/null
+++ b/arch/riscv/cpu/cva6/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2026 NXP
+
+config OPENHWGROUP_CVA6
+	bool
+	select ARCH_EARLY_INIT_R
+	select BINMAN if SPL
+	select SYS_CACHE_SHIFT_4
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
+	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
+	imply CMD_CPU
+	imply SPL_CPU
+	imply SPL_OPENSBI
+	imply SPL_LOAD_FIT
+	help
+	  OpenHW Group CVA6 application class RISC-V core, as integrated in
+	  the CVA6 APU FPGA platform. The instruction and data caches use
+	  128-bit (16-byte) lines.
diff --git a/arch/riscv/cpu/cva6/Makefile b/arch/riscv/cpu/cva6/Makefile
new file mode 100644
index 000000000..745306276
--- /dev/null
+++ b/arch/riscv/cpu/cva6/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2026 NXP
+
+obj-y += dram.o
diff --git a/arch/riscv/cpu/cva6/dram.c b/arch/riscv/cpu/cva6/dram.c
new file mode 100644
index 000000000..8a0bc132c
--- /dev/null
+++ b/arch/riscv/cpu/cva6/dram.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ *
+ * The DDR controller of the CVA6 APU is set up by the FPGA design, the
+ * memory layout is taken from the device tree.
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8ba75fdb9..0a3f17632 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO_256M) += sg2002-milkv-duo256m.dtb
 dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
+dtb-$(CONFIG_TARGET_OPENHWGROUP_CVA6_GENESYS2) += cv32a6-genesys2.dtb cv64a6-genesys2.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
diff --git a/arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi b/arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi
new file mode 100644
index 000000000..0ec9ec3c8
--- /dev/null
+++ b/arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "cva6-genesys2-u-boot.dtsi"
diff --git a/arch/riscv/dts/cv32a6-genesys2.dts b/arch/riscv/dts/cv32a6-genesys2.dts
new file mode 100644
index 000000000..607cd33b0
--- /dev/null
+++ b/arch/riscv/dts/cv32a6-genesys2.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * OpenHW Group CVA6 APU, 32-bit core (cv32a6), on the Digilent Genesys 2.
+ */
+
+/dts-v1/;
+
+#include "cva6-genesys2.dtsi"
+
+/ {
+	model = "OpenHW Group CVA6 cv32a6 on Digilent Genesys 2";
+	compatible = "openhwgroup,cv32a6-genesys2", "openhwgroup,cva6-apu",
+		     "eth,ariane-bare-dev";
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 128 MiB of DDR3, as configured for this core by the FPGA build */
+		reg = <0x0 0x80000000 0x0 0x08000000>;
+	};
+};
+
+&cpu0 {
+	compatible = "openhwgroup,cv32a6", "riscv";
+	riscv,isa-base = "rv32i";
+	riscv,isa-extensions = "i", "m", "a", "zicntr", "zicsr", "zifencei",
+			       "zihpm";
+	mmu-type = "riscv,sv32";
+};
diff --git a/arch/riscv/dts/cv64a6-genesys2-u-boot.dtsi b/arch/riscv/dts/cv64a6-genesys2-u-boot.dtsi
new file mode 100644
index 000000000..0ec9ec3c8
--- /dev/null
+++ b/arch/riscv/dts/cv64a6-genesys2-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "cva6-genesys2-u-boot.dtsi"
diff --git a/arch/riscv/dts/cv64a6-genesys2.dts b/arch/riscv/dts/cv64a6-genesys2.dts
new file mode 100644
index 000000000..b9ae9921e
--- /dev/null
+++ b/arch/riscv/dts/cv64a6-genesys2.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * OpenHW Group CVA6 APU, 64-bit core (cv64a6), on the Digilent Genesys 2.
+ */
+
+/dts-v1/;
+
+#include "cva6-genesys2.dtsi"
+
+/ {
+	model = "OpenHW Group CVA6 cv64a6 on Digilent Genesys 2";
+	compatible = "openhwgroup,cv64a6-genesys2", "openhwgroup,cva6-apu",
+		     "eth,ariane-bare-dev";
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 1 GiB of DDR3, as configured for this core by the FPGA build */
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+	};
+};
+
+&cpu0 {
+	compatible = "openhwgroup,cv64a6", "riscv";
+	riscv,isa-base = "rv64i";
+	riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "zba",
+			       "zbb", "zbc", "zbkb", "zbkc", "zbkx", "zbs",
+			       "zca", "zcb", "zcd", "zicntr", "zicond", "zicsr",
+			       "zifencei", "zihpm", "zknd", "zkne", "zknh";
+	mmu-type = "riscv,sv39";
+};
diff --git a/arch/riscv/dts/cva6-genesys2-u-boot.dtsi b/arch/riscv/dts/cva6-genesys2-u-boot.dtsi
new file mode 100644
index 000000000..be2f1226c
--- /dev/null
+++ b/arch/riscv/dts/cva6-genesys2-u-boot.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * U-Boot specific additions for the CVA6 APU on the Digilent Genesys 2:
+ * the nodes needed by the SPL and the binman description of u-boot.itb.
+ */
+
+#include <config.h>
+
+#ifdef CONFIG_SPL
+#include "binman.dtsi"
+#endif
+
+/ {
+	cpus {
+		bootph-all;
+
+		cpu0: cpu@0 {
+			bootph-all;
+		};
+	};
+
+	memory@80000000 {
+		bootph-all;
+	};
+
+	soc {
+		bootph-all;
+	};
+};
+
+&clint {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&spi0 {
+	bootph-all;
+};
+
+&mmc0 {
+	bootph-all;
+};
diff --git a/arch/riscv/dts/cva6-genesys2.dtsi b/arch/riscv/dts/cva6-genesys2.dtsi
new file mode 100644
index 000000000..90e45d6ec
--- /dev/null
+++ b/arch/riscv/dts/cva6-genesys2.dtsi
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * OpenHW Group CVA6 APU on the Digilent Genesys 2 FPGA board.
+ *
+ * The SoC description is shared between the 32-bit (cv32a6) and the
+ * 64-bit (cv64a6) configurations of the CVA6 core. The core specific
+ * properties are set in the board .dts files.
+ *
+ * The root compatible string "eth,ariane-bare-dev" and the CLINT and
+ * PLIC fallback compatible strings are the ones matched by the OpenSBI
+ * generic platform to recognize this SoC.
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		spi0 = &spi0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* The CLINT mtime counter runs at half the core clock */
+		timebase-frequency = <25000000>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			status = "okay";
+			clock-frequency = <50000000>;
+			tlb-split;
+
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				compatible = "riscv,cpu-intc";
+			};
+		};
+	};
+
+	/* Peripheral clock, the same as the core clock */
+	clk50: clock-50mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "clk50";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			gpios = <&gpio0 1 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		clint: clint@2000000 {
+			compatible = "openhwgroup,cva6-clint", "sifive,clint0",
+				     "riscv,clint0";
+			reg = <0x0 0x2000000 0x0 0xc0000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+
+		plic: interrupt-controller@c000000 {
+			compatible = "openhwgroup,cva6-plic", "sifive,plic-1.0.0",
+				     "riscv,plic0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			riscv,max-priority = <7>;
+			riscv,ndev = <30>;
+		};
+
+		uart0: serial@10000000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x10000000 0x0 0x1000>;
+			clock-frequency = <50000000>;
+			current-speed = <115200>;
+			interrupt-parent = <&plic>;
+			interrupts = <1>;
+			/* Registers are 32-bit wide and 32-bit aligned */
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		timer@18000000 {
+			compatible = "pulp,apb_timer";
+			reg = <0x0 0x18000000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <4>, <5>, <6>, <7>;
+		};
+
+		spi0: spi@20000000 {
+			compatible = "xlnx,xps-spi-2.00.a";
+			reg = <0x0 0x20000000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&plic>;
+			interrupts = <2>;
+			xlnx,num-ss-bits = <1>;
+			xlnx,num-transfer-bits = <8>;
+
+			mmc0: mmc@0 {
+				compatible = "mmc-spi-slot";
+				reg = <0>;
+				spi-max-frequency = <12500000>;
+				voltage-ranges = <3300 3300>;
+				disable-wp;
+			};
+		};
+
+		ethernet@30000000 {
+			compatible = "lowrisc-eth";
+			reg = <0x0 0x30000000 0x0 0x8000>;
+			interrupt-parent = <&plic>;
+			interrupts = <3>;
+			phy-handle = <&phy0>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* Realtek RTL8211E-VL */
+				phy0: ethernet-phy@0 {
+					reg = <0>;
+				};
+			};
+		};
+
+		gpio0: gpio@40000000 {
+			compatible = "xlnx,xps-gpio-1.00.a";
+			reg = <0x0 0x40000000 0x0 0x10000>;
+			clocks = <&clk50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			xlnx,all-inputs = <0>;
+			xlnx,all-inputs-2 = <0>;
+			xlnx,dout-default = <0>;
+			xlnx,dout-default-2 = <0>;
+			xlnx,gpio-width = <8>;
+			xlnx,gpio2-width = <8>;
+			xlnx,interrupt-present = <0>;
+			xlnx,is-dual = <1>;
+			xlnx,tri-default = <0xffffffff>;
+			xlnx,tri-default-2 = <0xffffffff>;
+		};
+	};
+};
diff --git a/board/openhwgroup/cva6_genesys2/Kconfig b/board/openhwgroup/cva6_genesys2/Kconfig
new file mode 100644
index 000000000..5e49cad56
--- /dev/null
+++ b/board/openhwgroup/cva6_genesys2/Kconfig
@@ -0,0 +1,60 @@
+if TARGET_OPENHWGROUP_CVA6_GENESYS2
+
+config SYS_BOARD
+	default "cva6_genesys2"
+
+config SYS_VENDOR
+	default "openhwgroup"
+
+config SYS_CPU
+	default "cva6"
+
+config SYS_CONFIG_NAME
+	default "openhwgroup_cva6_genesys2"
+
+config TEXT_BASE
+	default 0x80400000 if SPL
+	default 0x80000000 if !RISCV_SMODE
+	default 0x80200000 if RISCV_SMODE && ARCH_RV64I
+	default 0x80400000 if RISCV_SMODE && ARCH_RV32I
+
+config SPL_TEXT_BASE
+	default 0x80000000
+
+config SPL_OPENSBI_LOAD_ADDR
+	hex
+	default 0x80100000
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select OPENHWGROUP_CVA6
+	select SUPPORT_SPL
+	imply SPL_CPU_RISCV
+	imply SYS_NS16550
+	imply DM_GPIO
+	imply XILINX_GPIO
+	imply SPI
+	imply DM_SPI
+	imply XILINX_SPI
+	imply MMC
+	imply DM_MMC
+	imply MMC_SPI
+	imply SPL_SPI
+	imply SPL_DM_SPI
+	imply SPL_DM_MMC
+	imply SPL_MMC
+	imply SPL_FS_FAT
+	imply SPL_LIBDISK_SUPPORT
+	imply SPL_EFI_PARTITION
+	imply SPL_SYS_MALLOC
+	imply CMD_MMC
+	imply CMD_FAT
+	imply CMD_EXT4
+	imply CMD_FS_GENERIC
+	imply CMD_GPT
+	imply CMD_PART
+	imply DOS_PARTITION
+	imply EFI_PARTITION
+	imply PARTITION_TYPE_GUID if EFI_PARTITION
+
+endif
diff --git a/board/openhwgroup/cva6_genesys2/MAINTAINERS b/board/openhwgroup/cva6_genesys2/MAINTAINERS
new file mode 100644
index 000000000..2f6eddd63
--- /dev/null
+++ b/board/openhwgroup/cva6_genesys2/MAINTAINERS
@@ -0,0 +1,12 @@
+OPENHW GROUP CVA6 GENESYS 2 BOARD
+M:	Marouene Boubakri <marouene.boubakri@oss.nxp.com>
+S:	Maintained
+F:	arch/riscv/cpu/cva6/
+F:	arch/riscv/dts/cv32a6-genesys2*
+F:	arch/riscv/dts/cv64a6-genesys2*
+F:	arch/riscv/dts/cva6-genesys2*
+F:	board/openhwgroup/cva6_genesys2/
+F:	configs/openhwgroup_cv32a6_genesys2*
+F:	configs/openhwgroup_cv64a6_genesys2*
+F:	doc/board/openhwgroup/
+F:	include/configs/openhwgroup_cva6_genesys2.h
diff --git a/board/openhwgroup/cva6_genesys2/Makefile b/board/openhwgroup/cva6_genesys2/Makefile
new file mode 100644
index 000000000..bbeee4831
--- /dev/null
+++ b/board/openhwgroup/cva6_genesys2/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2026 NXP
+
+obj-y	+= cva6_genesys2.o
diff --git a/board/openhwgroup/cva6_genesys2/cva6_genesys2.c b/board/openhwgroup/cva6_genesys2/cva6_genesys2.c
new file mode 100644
index 000000000..d021f9e46
--- /dev/null
+++ b/board/openhwgroup/cva6_genesys2/cva6_genesys2.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2026 NXP
+ *
+ * OpenHW Group CVA6 APU on the Digilent Genesys 2 FPGA board.
+ */
+
+#include <spl.h>
+
+#ifdef CONFIG_SPL
+u32 spl_boot_device(void)
+{
+	/* The boot ROM only loads the SPL from the SD card */
+	return BOOT_DEVICE_MMC1;
+}
+#endif
+
+#ifdef CONFIG_SPL_LOAD_FIT
+int board_fit_config_name_match(const char *name)
+{
+	/* boot using first FIT config */
+	return 0;
+}
+#endif
diff --git a/configs/openhwgroup_cv32a6_genesys2_defconfig b/configs/openhwgroup_cv32a6_genesys2_defconfig
new file mode 100644
index 000000000..e9f41b562
--- /dev/null
+++ b/configs/openhwgroup_cv32a6_genesys2_defconfig
@@ -0,0 +1,18 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80400000
+CONFIG_DEFAULT_DEVICE_TREE="cv32a6-genesys2"
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_TARGET_OPENHWGROUP_CVA6_GENESYS2=y
+CONFIG_RISCV_SMODE=y
+# CONFIG_RISCV_ISA_C is not set
+# CONFIG_RISCV_ISA_F is not set
+CONFIG_FIT=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_BOOTZ=y
+CONFIG_OF_BOARD=y
diff --git a/configs/openhwgroup_cv32a6_genesys2_spl_defconfig b/configs/openhwgroup_cv32a6_genesys2_spl_defconfig
new file mode 100644
index 000000000..83ad49a19
--- /dev/null
+++ b/configs/openhwgroup_cv32a6_genesys2_spl_defconfig
@@ -0,0 +1,24 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80400000
+CONFIG_DEFAULT_DEVICE_TREE="cv32a6-genesys2"
+CONFIG_SPL_BSS_START_ADDR=0x81000000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_SPL=y
+CONFIG_TARGET_OPENHWGROUP_CVA6_GENESYS2=y
+CONFIG_RISCV_SMODE=y
+# CONFIG_RISCV_ISA_C is not set
+# CONFIG_RISCV_ISA_F is not set
+# CONFIG_SPL_SMP is not set
+CONFIG_FIT=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
+CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
+CONFIG_CMD_BOOTZ=y
diff --git a/configs/openhwgroup_cv64a6_genesys2_defconfig b/configs/openhwgroup_cv64a6_genesys2_defconfig
new file mode 100644
index 000000000..43ecd67d6
--- /dev/null
+++ b/configs/openhwgroup_cv64a6_genesys2_defconfig
@@ -0,0 +1,16 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
+CONFIG_DEFAULT_DEVICE_TREE="cv64a6-genesys2"
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_TARGET_OPENHWGROUP_CVA6_GENESYS2=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_OF_BOARD=y
diff --git a/configs/openhwgroup_cv64a6_genesys2_spl_defconfig b/configs/openhwgroup_cv64a6_genesys2_spl_defconfig
new file mode 100644
index 000000000..5547818dc
--- /dev/null
+++ b/configs/openhwgroup_cv64a6_genesys2_spl_defconfig
@@ -0,0 +1,22 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x800000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80400000
+CONFIG_DEFAULT_DEVICE_TREE="cv64a6-genesys2"
+CONFIG_SPL_BSS_START_ADDR=0x81000000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_SPL=y
+CONFIG_TARGET_OPENHWGROUP_CVA6_GENESYS2=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+# CONFIG_SPL_SMP is not set
+CONFIG_FIT=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
+CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
diff --git a/include/configs/openhwgroup_cva6_genesys2.h b/include/configs/openhwgroup_cva6_genesys2.h
new file mode 100644
index 000000000..cbeda7ee9
--- /dev/null
+++ b/include/configs/openhwgroup_cva6_genesys2.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright 2026 NXP
+ *
+ * OpenHW Group CVA6 APU on the Digilent Genesys 2 FPGA board.
+ */
+
+#ifndef __OPENHWGROUP_CVA6_GENESYS2_H
+#define __OPENHWGROUP_CVA6_GENESYS2_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+/* Environment options */
+#define CFG_EXTRA_ENV_SETTINGS \
+	"kernel_addr_r=0x84000000\0" \
+	"kernel_comp_addr_r=0x88000000\0" \
+	"kernel_comp_size=0x4000000\0" \
+	"fdt_addr_r=0x8c000000\0" \
+	"scriptaddr=0x8c100000\0" \
+	"pxefile_addr_r=0x8c200000\0" \
+	"ramdisk_addr_r=0x8c300000\0"
+
+#endif /* __OPENHWGROUP_CVA6_GENESYS2_H */
-- 
2.43.0

