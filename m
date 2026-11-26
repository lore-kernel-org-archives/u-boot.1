Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE09E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Vd4Rs9Qy;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gUuj8EY6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3C1C60AC2;
	Thu, 26 Nov 2026 17:21:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmPR5-yG68M2; Thu, 26 Nov 2026 17:21:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8FCCA60AA8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795713672;
	b=YeSYprX4yrDRVj5ErEMTzMtzyYb0hGijGj7iX0GjrC/tAHq84u9qEhKctZ8BiQxlOLd6
	 NtdS3vSNf3TEmPiZjI7wtVSdNAhqIfd6eGyf+bnOd1huWplr51Oc3ab6Ib4J0qMCWJQKP
	 12AyRt7W5v1/5S+s1OrYe6yW1FioSC0AWaz5ijyfUClsnqFF6/7PHzmQIHpPhFCFqZnzj
	 gHFGN0wMZG+uaDAeDFKEV/O2v8ybftzME4dH6IwRbmnfT4dfEEvRvnz3HUXVkQxVbPxeA
	 WlzYGtjNSJhiRx/l0X5sKvY6yEeaSxLvPJi2n88rQnnfeJXrjmYhBVr90rUE59SOfcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795713672;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3KaEI1f3VIav2eFPm1Zgz0hxrJ6o877favM5rXyJsCM=;
	b=pow6fe9bI4PbtJZFcrbW2ukOdGxTvI0e4uKWfwitPpcvPRBi7bVKI8iNYoFeFQjCpRAt
	 F6RQCyJqKv4g1N2qQdIXleNP0n0M88Z2aZYS4k+ron0yFf7djTavEtB0nNPxcSgS+Olzw
	 SUCU4ZsaXRIwJvdwubYEVem7pk15dh7avdyVcI32uGi46OXR9UEhCw5slDNXiK9Q1XKWR
	 MHuvHABXA+ycHtIlQ9c+DY2FhfZ8gi96zUK3dVWFbqM8plxwBgGnWdA/aY1mxBqNnns4W
	 SyF5izlw4oI5Ddy+BPPSHnxq5YtEwFWfuP+isxmvLKpXi2iIS7gOF/bk2HMgg/KlclA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gUuj8EY6;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795713672;
	bh=3KaEI1f3VIav2eFPm1Zgz0hxrJ6o877favM5rXyJsCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vd4Rs9QyqkJlR25uWr/QzuhMjkbrTNc+DtBmFr54CnNwK/JohMwOQ7WNu4uqjOLli
	 gJLOC+GCMs2myVaj8bbisiwxkqQZN7YvlNxNa5oO/KJRmLYqGrKwx8Z3u+iPr+UzUh
	 4IxncQYpkcC9ssvnGCYzfUu3Q4BBww1bgnQr7VoXMrDvOTXcmqJi4lQyxbvMrUFbRK
	 d2KuMPxsSNYEvlLzJoJzKe3EZoHP+VeneDLwJG8U+cWWiLTc7cFneABj37w51StlES
	 adal32L0bLrWBdz6LszCvJZrk+AvfQ7WRZhZY9QhQMpbKgBxi6ub3sEXAy1UEPEo/Q
	 mSChCbtY5fmRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FCCA60AA8;
	Thu, 26 Nov 2026 17:21:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0766C10B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE99D60AA5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AaXyfWP8bEEH for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 17:21:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0BB8F60A9F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=marouene.boubakri@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=gUuj8EY6
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BB8F60A9F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KaEI1f3VIav2eFPm1Zgz0hxrJ6o877favM5rXyJsCM=;
 b=gUuj8EY6vYn/Jo9rXT+H2k5VrZG/lTXItvdEzCwqwy0lt3VxhKF35zKkcikzjj2zmVucCYJ+QhkFHIS1UCWVW1Do8T4FB5sJuDCpbchME/hRBmGauw0CRKOstffKs8MIZy6r8mFj/OTUBpv5FCYGNGa4BEpQV1lE7ABXnOJXy9lydYmVH9vvzsCCjVERJEPfp6tF3O9gRj3b7Yx/HpqGrZrFkEJYXcdqL45LSXlbcPUlGXP4mJ1CAdn6SIR5BFhAa4heb0yA2MrG6tdqNb6Nh5a/vGoVdwE78ZSCN7b8AgqytFDBsZHyNSSuGTouPKUIaAO+rKn0oVrtV8cESvUQgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by DU4PR04MB10959.eurprd04.prod.outlook.com
 (2603:10a6:10:586::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 17:21:04 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 17:21:04 +0000
From: marouene.boubakri@oss.nxp.com
To: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>,
	Marouene Boubakri <marouene.boubakri@oss.nxp.com>
Subject: [PATCH v2 1/2] riscv: add OpenHW Group CVA6 APU on Digilent Genesys 2
 board support
Date: Thu, 26 Nov 2026 18:34:53 +0100
Message-Id: <20261126173454.978816-2-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126173454.978816-1-marouene.boubakri@oss.nxp.com>
References: <20261126173454.978816-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0003.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::15) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|DU4PR04MB10959:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b58d5e7-ded1-4f2b-88b4-08df4be1a67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|376014|366016|6133799003|18002099003|261009223027099003|22082099003|3023799007|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261102124527099003|261026140227099003|261022115727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 1fvLYKDyidHNrdxnEzYK1rK6sdDXIRxA+mhR/zMlDrM0ibZaDa6TmHcBh1y73NB9HXSij4hSufqr2KbUvHAozik7/m5y2fnE7q9RU5pUTVDHzzIQvz9CrfENn7l3TtB80t0pNyNkVgTxnCg/ChG7225tcdkrb+ySP4kEeA+k194vTwlgvB7SQLkqNR8L8iTM4sWheYCrJmNZr1ozJNhW1eZBjp18AWvp9dFpZ1TpItq3/+bg2I7D7XcTnxVJfxNd0X15xeazq/G/Va1GfsCi/h6j2Ck56uym9F8qqdOu/A7u0i0U1KAWg+ze+/DDDjO5dKFSYCKohfwLq3Ao/GGVTV5cH+LmebrunrnTHF3pyUTS/PcoDVELkPB5r95du6MRqo6uMCuf+0o6tqv+Hpi0Hi1xdQsNnapECdZZ+RBM5PKLFpS/8GPX7JXnR5yYhPScniX8U0ndupp6bXNqMhd1DzkIFtAk+E+w0bbC2X6VeUEylhKHJmbUyGsjUiF21CeUz6tJCOxKYr5Ccfpcdo9pq7iHkwdhPHMhudOdYi4yNbPPMz3+JUItOF/VBevxZ55OUpu93CuDqU99d1l1NLHqEFWWyV4ahthB7z7CullIqBdylF0mJluvvCDvtYGD34y/Yayk5haBA9hgZPzdOvs9VK2FZOlxFtBf3aM8Mx14w1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11203.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(6133799003)(18002099003)(261009223027099003)(22082099003)(3023799007)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261102124527099003)(261026140227099003)(261022115727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?40YYahVhV4yBn2hNZslGOJYV8sMulwcnc7OIx3Px+KtKFcCo1PZ/Z3btfet2?=
 =?us-ascii?Q?p241LT4zCJmia0cBYHDMnur7CVR4vyHBSlSWjk6dTV9vi3ufPxwWxz83epif?=
 =?us-ascii?Q?Z+ySpVM0OoK9A7/HuZp46yqghN8Jwf2WwBAVLGhpDC7gu/NYBJJ9uezsfH5W?=
 =?us-ascii?Q?CSQPEOE1Ik6BiEqUhQO4uQbem4QAjKIiF7FL0eNhSGSt4g3PG0a7zEXI1OAA?=
 =?us-ascii?Q?z52L56Rl9jpi6iWk0DynMjssJx96M+eZbP/sTs/Zlu+nyJe4Za/lfhpMXuNt?=
 =?us-ascii?Q?N0/r8oDVpFE3FWu4rCaPPwUuwK8LvlPhCtOIPtyJSGhNv1hb4/8O4sBEFqKf?=
 =?us-ascii?Q?kWUqDbTzFz7uugdfm6Vm98WZBrd+nxXOKe0gAOO3oHoJi6SZ/v/EF0EmZc4d?=
 =?us-ascii?Q?xSPQRThz4ThDJhIYllgMuTQVoCNd67BZNBE+Iw5ea5sQYiPXRaFN+q1pAvRx?=
 =?us-ascii?Q?WspUhJ4XPDs7Tz3/ln3bkplg1XD5IaZcQqJiCvPjetowcMdZcpWMeezjbA78?=
 =?us-ascii?Q?mqfXUgsT+9uBZYAxZXjWembxXluPOeC5U0UQ5nlsr+eEGZU7YWZ5cbVgF6CK?=
 =?us-ascii?Q?COUXrVD26c6L/MoaIu42retF9un6Kxyqs3sCuQj8/KHCEW7AefLhRbu+Haji?=
 =?us-ascii?Q?WBEI1uKxACKuh90oc6cAKDWepnMSJil/7AcgcoKMMeHsiE1W4WdAnJVrUEcu?=
 =?us-ascii?Q?4sgFdlXe/TquoQtsSH0dipONMTQCWC5WiASWouNev3gLd/+ZqD9sKCii1MyE?=
 =?us-ascii?Q?OGJCe60zBRRMbC4NqWFyCgiViF3vBFmQuO5YWpLjswrCIxIuhozv4udBoxki?=
 =?us-ascii?Q?svVzyGO/tBhabNYNC8PEos4owRJPxpNYI59Xko8lmdzw9ARO45WSZpU2EqCs?=
 =?us-ascii?Q?59b4oDqLZKmCtOaU95xiHwLhSzccWzOlc0TFL7aDML1qKVerAxzLthRqSZ9/?=
 =?us-ascii?Q?w0/qo3+IpPyTLd0dHKkLfwWuooZW1fiwyyF765ZinEIZi8WRD4dYN+pCy10k?=
 =?us-ascii?Q?afRdUo179WmDDN0AzDHsIkIMn1mRpmYPiBTPXMxZcrcnCP0VJFitw+sA3UXb?=
 =?us-ascii?Q?riGcOjCkZjnJ6W5FLCFW5R2dGbig8Ts4qTmZAg4S0Ilq5aXacmnt2Hp1fJC8?=
 =?us-ascii?Q?sbZG2Ri1Q+/Jz4hhTvcjINONhLCFM5gizhmUcORS7TQgI1pWGCmujSvN3Zcq?=
 =?us-ascii?Q?9XrKkOr90daPYL/jOGDXNgR05kdIBm1Ag/xaklTha5g+OIbt8U53sH6lpK5q?=
 =?us-ascii?Q?QJuPETH19FXsKu6sYFMVohA9vbWsC0BOF/qMNhiU+iTxz6mgWxRWyex770eD?=
 =?us-ascii?Q?VIwnb4QD6RyFyOOfLuIgXRnVCFD8tFa+078x5bdaVjudjLmHqalRl4afh6As?=
 =?us-ascii?Q?gbZa/28V/mXVCNQFZvBgMgZ3ziSu7yJivGHV7kjimjHTZBTTD4zPmtGhPrHQ?=
 =?us-ascii?Q?9LIoLKj1NAKvIIyOLb8DnsM20C+Z7WJfn47aocG6kXI2lAENAQPpqHY7wfQG?=
 =?us-ascii?Q?ijpW5aGno9j1pOQxRzZ6VpS1v53NvaN+WbBqyDB/nU+x1pDDzWUCaoaYBBw4?=
 =?us-ascii?Q?fjME34naPNexK9yzdVnXYQgeaiGXaxWby3jDsAkA1oYalUd2Z4cFTCGnyt33?=
 =?us-ascii?Q?8caHjbtGKnuesX/3op9l4Ecgf5UNEBL1Ru0kE4PtDgmw0+XPhZt4FDEXt5k3?=
 =?us-ascii?Q?nPbcgMqhat1AoFoZKXqIjYrtZaEis0orAB5A9kor+FEgLSLxdqiEb54XrohZ?=
 =?us-ascii?Q?tokP/isXUDMeO94mA4Cq11R2R9opjgucNMWtpozqtsR56+3jg1As+H0hgWEv?=
X-MS-Exchange-AntiSpam-MessageData-1: /Rknbj0iLxTQdg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b58d5e7-ded1-4f2b-88b4-08df4be1a67c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 17:21:04.5877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxBMdMJjdL5k5rERpuCwAkASA5ZQ8e25RG3QMIBJuodS9KjgRNXIvIiXb11IGBHBdZWAmWND4X0IUwDoXOK7v5G1HVJsTt8vI3GqVkPXV4PthWZkkIci9TqrukaKySUfNcSGvHHgxkeJ/hyRoMQHRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10959
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
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
Changes in v2:
- Rebase on u-boot/next
- Sync the device trees with v2 of the Linux series: version the board
  compatibles after the CVA6 release the bitstream is built from
  (openhwgroup,cv{32,64}a6-genesys2-v5.3.0, openhwgroup,cva6-apu-v5.3.0),
  replace clock-frequency in the cpu node by a clocks property and
  document that the 50 MHz clock is the output of an MMCM without a
  register interface

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
 arch/riscv/dts/cva6-genesys2.dtsi             | 169 ++++++++++++++++++
 board/openhwgroup/cva6_genesys2/Kconfig       |  60 +++++++
 board/openhwgroup/cva6_genesys2/MAINTAINERS   |  12 ++
 board/openhwgroup/cva6_genesys2/Makefile      |   5 +
 .../openhwgroup/cva6_genesys2/cva6_genesys2.c |  24 +++
 configs/openhwgroup_cv32a6_genesys2_defconfig |  18 ++
 .../openhwgroup_cv32a6_genesys2_spl_defconfig |  24 +++
 configs/openhwgroup_cv64a6_genesys2_defconfig |  16 ++
 .../openhwgroup_cv64a6_genesys2_spl_defconfig |  22 +++
 include/configs/openhwgroup_cva6_genesys2.h   |  25 +++
 20 files changed, 548 insertions(+)
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
index 386241efd4a..adba603c8d1 100644
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
 
@@ -119,6 +122,7 @@ source "board/beagle/beaglev_fire/Kconfig"
 source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
 source "board/microchip/mpfs_generic/Kconfig"
+source "board/openhwgroup/cva6_genesys2/Kconfig"
 source "board/openpiton/riscv64/Kconfig"
 source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
@@ -135,6 +139,7 @@ source "board/xilinx/mbv/Kconfig"
 # platform-specific options below
 source "arch/riscv/cpu/andes/Kconfig"
 source "arch/riscv/cpu/cv1800b/Kconfig"
+source "arch/riscv/cpu/cva6/Kconfig"
 source "arch/riscv/cpu/fu540/Kconfig"
 source "arch/riscv/cpu/fu740/Kconfig"
 source "arch/riscv/cpu/ast2700/Kconfig"
diff --git a/arch/riscv/cpu/cva6/Kconfig b/arch/riscv/cpu/cva6/Kconfig
new file mode 100644
index 00000000000..0a999a55f40
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
index 00000000000..745306276ba
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
index 00000000000..8a0bc132cc0
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
index c588ce546bf..92801cc2bd1 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
+dtb-$(CONFIG_TARGET_OPENHWGROUP_CVA6_GENESYS2) += cv32a6-genesys2.dtb cv64a6-genesys2.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
diff --git a/arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi b/arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi
new file mode 100644
index 00000000000..0ec9ec3c8a1
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
index 00000000000..3f6e80bd1d4
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
+	compatible = "openhwgroup,cv32a6-genesys2-v5.3.0",
+		     "openhwgroup,cva6-apu-v5.3.0", "eth,ariane-bare-dev";
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 128 MiB of DDR3, as configured for this core by the FPGA build */
+		reg = <0x0 0x80000000 0x0 0x8000000>;
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
index 00000000000..0ec9ec3c8a1
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
index 00000000000..d2a534274fd
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
+	compatible = "openhwgroup,cv64a6-genesys2-v5.3.0",
+		     "openhwgroup,cva6-apu-v5.3.0", "eth,ariane-bare-dev";
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
index 00000000000..be2f1226c2d
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
index 00000000000..0ca138d95ab
--- /dev/null
+++ b/arch/riscv/dts/cva6-genesys2.dtsi
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * OpenHW Group CVA6 APU on the Digilent Genesys 2 FPGA board.
+ *
+ * The SoC description is shared between the 32-bit (cv32a6) and the
+ * 64-bit (cv64a6) configurations of the CVA6 core. The core specific
+ * properties and the memory size are set in the board .dts files.
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
+			clocks = <&clk50>;
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
+	/*
+	 * Core and peripheral clock. It is an output of an MMCM that the
+	 * bitstream configures for 50 MHz and that has no register interface.
+	 */
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
index 00000000000..5e49cad56d6
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
index 00000000000..2f6eddd63a5
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
index 00000000000..bbeee483181
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
index 00000000000..d021f9e46c9
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
index 00000000000..e9f41b5620e
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
index 00000000000..83ad49a1959
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
index 00000000000..43ecd67d6e7
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
index 00000000000..5547818dc7a
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
index 00000000000..cbeda7ee906
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

