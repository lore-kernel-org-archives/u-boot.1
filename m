Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6450606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ABIRaVef;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sQJePJXI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FAC360AA0;
	Thu, 26 Nov 2026 17:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTpzIHzamh0G; Thu, 26 Nov 2026 17:21:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C3D760AA1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795713670;
	b=q0tVA6rbGrbE7UCOgDyZvyIcS8rNV1iMXPqsOsYh3HGk0TYy4iuQpGr4eisHLRmeiH7B
	 04PXGQViHeWrERPDZJy4OyjiOjseJQSXoO0fg+QiQ5mJrPGMqxQSNwXFzNcG/CEQdPXFy
	 9v3OPBBYImS+CGAZNK1RBkle9d0WEKzqe0YRCm/n6uRtwaDoTffhueGXMgGsFibtIfqIg
	 ybD+eL7cT7OJsKdPTtuHoqTtVhXTiEamKzLydgHZa1eHQJ4SBBdYwLvLEHy2XN+haVl2Z
	 9j5fW8V5C2F8GVtsiWlBHZaEDzi8jCm2nYDcjWWowpjpWVciSbk0Fpy/bU1HjEt93/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795713670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QmhoFZrs2e2sx4W4m0NlMqX5L5vn/I5nFJ4NUlTdYVM=;
	b=Hfa4Fu74W9tTx2dD2k8pM1NLerI0iHRXwFqRwn8Oo2Eqe6yR9JDY0YMka2ltCdCw7TKA
	 Ky4lRmIQYMc2/IqmxW2zY5ZS28NrmKZvKzCxRugaNmNT+JH1Xk6i/MG8M68xhYDx6tdcU
	 dgjdXa5as7LJIiIJRqXk/0+WGJJO9er2aYh4Fcd//uqpZaaiKXDKut6RcIA1Z0zEeNfhx
	 HrpFcK5NWq4KN4g6kCV7d26t5dxJDLGsiz0560kKkQmWZNilQKI8+6LPcvrvrxuMgZX3k
	 wFLb7IqArdHZL0j5aXqTdoLzvE7NVLxIQqctm1doT4Ss0tWer65lLgwri2Xo0frpTlw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sQJePJXI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795713670;
	bh=QmhoFZrs2e2sx4W4m0NlMqX5L5vn/I5nFJ4NUlTdYVM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ABIRaVefyj7KsKfFMnIb2cRORC+SV08x/4KLQbOIGaAN6v880KiiZ7BFsyMwVFsmF
	 +mnrihlQFHdL1alCh01xhv9fSgxmpCm4ulYuJOEf9zfyJ3TxxoRWcoz9uYsWgLjDCa
	 SH46wIV+tEHK6v8RPhpNbgxxgHp9imgNVbL6n41MipVu6d5slZHkIPPCZlU1D1OWH6
	 PihwzxuAsJTEPQEl26AXgHEAJ4OeZwezSMC0QU8pTbEflrdnl3HRFZQBKxjU74vXEr
	 yzh/fNQylslupdsjT1Trk+AvnRx2QqCnsKfnnQRTjJUYBvo7+P+dCSszuf9Kz6ebyS
	 nMeZpgQIGSPjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C3D760AA1;
	Thu, 26 Nov 2026 17:21:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90A4922B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7672760AA0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YmYHHRkT-_fw for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 17:21:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF9B160A8F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=marouene.boubakri@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sQJePJXI
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF9B160A8F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmhoFZrs2e2sx4W4m0NlMqX5L5vn/I5nFJ4NUlTdYVM=;
 b=sQJePJXInioJmalAaHVdGurPI1G8aVBWjtFtpuH9FTBda6lt6MVItBpG7aslQh23PXzS+yIzJcvZXmEhWKYIo7zCKNAQzQat4IpdzTbTV9Lq0hAyNrn/X0KFDJSzCkeY9Oapn1Ox2qVnxyyuwGOuDMXWZ35ECJ90d+VtK2F2l4G5AMUG5VB5OJ6kixHonlGI6+O7zzRDBBVuXT0i+3h4CV07WkMFmS4TixwU6buv68xojldCpcHwMWgQ63N3VfbF6fOyBWFNKI7F/nYFXP4h2MhIDfH8NRStVdrvRYgNjxuhw2sTH4vlweC7xUZ43vKrtYMzSNFs9YRrlFniQWOKJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by DU4PR04MB10959.eurprd04.prod.outlook.com
 (2603:10a6:10:586::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 17:21:02 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 17:21:02 +0000
From: marouene.boubakri@oss.nxp.com
To: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>,
	Marouene Boubakri <marouene.boubakri@oss.nxp.com>
Subject: [PATCH v2 0/2] riscv: add OpenHW Group CVA6 APU on Digilent Genesys 2
Date: Thu, 26 Nov 2026 18:34:52 +0100
Message-Id: <20261126173454.978816-1-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:510:f::26) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|DU4PR04MB10959:EE_
X-MS-Office365-Filtering-Correlation-Id: 946bd04c-5832-49d9-e7b6-08df4be1a4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|376014|366016|6133799003|18002099003|261009223027099003|3023799007|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: ltmXmA1IrG8Ihbhres5wW3NgawO+01jzqOz4PIBvRI+MMdVKfZ8MFrg6jqAUFzvVk1o9AFPSURv2ceQs1lSsbGwJxRef480pIj45kUYSkmzRZfdBoLiMN8QSXHTgfn4LoRzR9+rC7evMwl+d4lLi3vNhY1qu/4JcY9/DDkgRx8OXel1xH08V67vf2ffDvyCjUvW27tqPM+H9AkHI8SheAmLHH4FxqLUNCpyj+G691v4U4L8i0AOUSI/j059jCpMZhTmihFh54JpKU7yJv9CiGd8qvLyIYijpPhkW6OztQKuX7VshYz8vepGlisjXV+zwJ7wY4kw1DfmmFh7KmiEDJ8SY8bkHYdKU0ep49bK7IorjcbpYq9Xz0iICw2DmA491ZpLWdCjsMYjwIuyA96oPuzjGDEktnfHVRjgARamxe/fikQTLvaDbQIJ8rRKqukVi5RTzsZUWFLz7LcV+r+f/mzWpGyWWtzt/ypu7oOSw2lDwPkpsehzDqxsNXGlDgN7eyR6Rm6lNwWZ0QuByFP+qOz50TlHTyuvK1gfHCoCEkUoGFTvkVl74Dv4qXx8SDGwQWAsKMFqr0hpNBxsEMnAlM9E7Qyk4P0JLR6htO97G7iQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11203.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(6133799003)(18002099003)(261009223027099003)(3023799007)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dB9DQOOyUlV6kHWax2eHEvy8HgFMCqgjwp4M44ogH7FUFSqZ2OKyYkH23Zzq?=
 =?us-ascii?Q?EEAF7lnWYiLpe35iQANiHrKJeG2HSuY2dTRSKytw7qOX2oeCVCQrnhWq3pHD?=
 =?us-ascii?Q?6GWEZY3dHcmdvf8RLgZQUlVsX8oIQAxWt3O0AyD53qIcNEMu/qJpi5kQdS54?=
 =?us-ascii?Q?1R5kiNexSjQT9mnXcyGQNg4RHkl6sVc25/tsPAbEh5AiBiav5b6Hd9tUwxno?=
 =?us-ascii?Q?g70u/L/7XGoCcNMCGDD38fx+UC6dx05roPVZ467asLXBNkNn8w2V3FwGBoHS?=
 =?us-ascii?Q?w/ak4mhM7SMSH0PeHoFE9UXFXD2cM9+CTtoy7bk7vUCDgVEHf9F2cbOmGFpc?=
 =?us-ascii?Q?ePeKNcz4ssMeHp2IGKmj/Er5q6jxWgq9NxBK4HcQH1RKVkETgTnTuePi34La?=
 =?us-ascii?Q?qlovC5/cmH6Vv05uj+06XnzGhVVZEDTTRmP78wDd1t4aqvzgKcKxhBORYQnt?=
 =?us-ascii?Q?HHj6PBxMkaid4AglCew5oOe3pagCyHMvDZdv790/Ql6wPtBrqStwpPRNRJuf?=
 =?us-ascii?Q?GvwZIDdV6jckr2cgzmkgrdwT+YaIidP+nx5/9OiNYuTnVeaWcgdtH+EcDjcC?=
 =?us-ascii?Q?IvaBxg5hV3LohpZCz5SgcLrTEM0UQZDq+OKDz6R73sGw+l4KlYVof4i856hX?=
 =?us-ascii?Q?YX3i2kqYUFBa4Yh66o6NXiKkNP6LAHfMTbiYPBIiUiX5EbkBu+oRjINf+qL5?=
 =?us-ascii?Q?ksppvb8qlTayvwlP0U4LnTvri0Ies16BgUrwvhY+04TAOmJNGLqWHUNUs+Qk?=
 =?us-ascii?Q?IBMkLk88Yhugs0VkrRtKDh16/yuozWwdItJS7oh2/w4lP7KpsBOOT9RQeTcz?=
 =?us-ascii?Q?0QHeYCuM3diRyj7FxR3x3qLv5X9dEEzy0PgzqXNyw9CZ8Qyw+bjFigUHCOyO?=
 =?us-ascii?Q?84nUENpRDBF/q8OvbsMQ1iEwNyvjMLpZOaI8sRuxRi8Q609e5W/ma78sTlEA?=
 =?us-ascii?Q?BqAprLhXF7C7zcsGHnCAZJSj9qobNGuEapgPKmgnERuUEWA1/vMBxrcUHnx1?=
 =?us-ascii?Q?ANh2LkUHVcsGvILdBajVhFq1FtVypIVauSu7umyj6N6j1GHAfn74Rb/9qbw5?=
 =?us-ascii?Q?TTozDyuyuaQE5bSsN10MKoju3UdejHNjaWubR0AqjUEpEIjGSpbCiKdaB/dw?=
 =?us-ascii?Q?lQEsBsNw34AMn1TnODLAOdNA2tXNz0oCfrhwcqH4eBbxK9pgq9G/Mccf1ylq?=
 =?us-ascii?Q?TkbgVkz70wFRWPXaPTP75TVd2S7UJ5/7eTpsWowrcdoRmPPhJN02shH6rWTZ?=
 =?us-ascii?Q?/Q2dksYiNS/yxLf6vbZmj/nkZ5RBygc/6qF3Tlh6m69OUH1TZtUHdwlLVQwN?=
 =?us-ascii?Q?p3190C/KDIryO9gV9nG3FRbIE+fiI0pygBSgpMzg16e815SwdpuIT/emZG1z?=
 =?us-ascii?Q?pJ45x6YCBrwpO4HuuUM1mBoSEjX265ExnSFgMY8yYxqN8v6rjHQz/1+Qyq/M?=
 =?us-ascii?Q?XBwCjwBO1/SOPbZX6V3SPvBDLAj2+F73I4ssDSRFu3naxdYnjLGPbZe4Ufe3?=
 =?us-ascii?Q?tPL0yxdhYebOzR0nZTF7qHjXkcV4rqk0kNQ69B3PCTsxhMGC4wY9sifR/MF+?=
 =?us-ascii?Q?ItLMT7xtrUx30/a4SCLNnzgc4+dqbMqcIzgYTcpQAl/sIztrPwyclaoTsMMg?=
 =?us-ascii?Q?H8KVkqF/byd6BoiQ34F4MAx/Idn/NlMLSlF5CDLX44rgIKj0SCNhWEKz0xf6?=
 =?us-ascii?Q?W2wQ9qAFDKLVaDMYewP0HqeFmi2/R9QRcfqEKQiT5qbgkbaveeYJLARcfFlx?=
 =?us-ascii?Q?e623CrPHK+br4jmkOiCy+gukWSYR3muz+o5yH+Vj1hddjfflb4Z94jILWw7i?=
X-MS-Exchange-AntiSpam-MessageData-1: hRUEOVM/bpKVag==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946bd04c-5832-49d9-e7b6-08df4be1a4e7
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 17:21:02.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xnvMKzxZyUdHElO+5dNWuAXIwGgVvE+RidEG/JgnQHsi8CYSXdMp5FeHBtrMWaR7YnGabHziV5xBFZy/ybaQwEYf8ckiEAcrcG9KrzlDbrquJb0MbPqTd4LgZbh0nO9+nUCPXT3YqrTYAcoGWNewg==
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,T_SPF_PERMERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

This series adds support for the OpenHW Group CVA6 APU, the FPGA SoC
built around the CVA6 core (https://github.com/openhwgroup/cva6,
corev_apu/fpga, release v5.3.0), running on the Digilent Genesys 2.

Both configurations of the core built for this board are covered: the
64-bit cv64a6 (rv64imafdc, Sv39, 1 GiB) and the 32-bit cv32a6 (rv32ima,
Sv32, 128 MiB). The SoC description is shared in a dtsi and the two
board .dts files only carry the core specific properties.

As for the QEMU and OpenPiton boards, each core gets two defconfigs. The
*_spl_defconfig variants use the standard RISC-V boot flow: the CVA6
boot ROM copies the first SD card partition to DRAM and jumps to the
U-Boot SPL, which runs in M-mode, loads u-boot.itb from a FAT partition
and hands over to OpenSBI fw_dynamic carried in the FIT, which starts
U-Boot proper in S-mode. The plain *_defconfig variants build U-Boot
proper alone, to be embedded in OpenSBI fw_payload placed in the first
partition, which is how the OpenHW Group CVA6 SDK boots the board today.
No change to the generic RISC-V code is needed.

Patch 1 adds the device trees, the board support and the defconfigs,
patch 2 the documentation.

The device trees follow the ones under review for Linux [1], where the
vendor prefix and the CPU, CLINT and PLIC compatibles have been acked by
Conor Dooley. Once they are merged there, the board can switch to
dts/upstream.

The series is based on u-boot/next. v1 was tested with the cv64a6 SPL
configuration on the Genesys 2, on U-Boot 2026.10: the SPL loads
u-boot.itb from the SD card, OpenSBI starts U-Boot proper and U-Boot
boots Linux through extlinux. The v2 changes are build tested with the
two cv64a6 configurations. The cv32a6 configurations were build tested
with v1.

[1] https://lore.kernel.org/r/20261102141727.640769-1-marouene.boubakri@oss.nxp.com

Changes in v2:
- Rebase on u-boot/next
- Patch 1: sync the device trees with v2 of the Linux series: version
  the board compatibles after the CVA6 release the bitstream is built
  from (openhwgroup,cv{32,64}a6-genesys2-v5.3.0,
  openhwgroup,cva6-apu-v5.3.0), replace clock-frequency in the cpu node
  by a clocks property and document that the 50 MHz clock is the output
  of an MMCM without a register interface
- Link to v1: https://lore.kernel.org/u-boot/20261102135820.640652-1-marouene.boubakri@oss.nxp.com/

Marouene Boubakri (2):
  riscv: add OpenHW Group CVA6 APU on Digilent Genesys 2 board support
  doc: board: add OpenHW Group CVA6 APU on Digilent Genesys 2

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
 doc/board/index.rst                           |   1 +
 doc/board/openhwgroup/cva6_genesys2.rst       | 157 ++++++++++++++++
 doc/board/openhwgroup/index.rst               |   9 +
 include/configs/openhwgroup_cva6_genesys2.h   |  25 +++
 23 files changed, 715 insertions(+)
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
 create mode 100644 doc/board/openhwgroup/cva6_genesys2.rst
 create mode 100644 doc/board/openhwgroup/index.rst
 create mode 100644 include/configs/openhwgroup_cva6_genesys2.h

-- 
2.43.0

