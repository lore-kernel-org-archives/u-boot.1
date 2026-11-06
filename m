Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2806083620
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yj+dn3x6;
	dkim=pass (1024-bit key, unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=XNndjSYy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E427811F8;
	Fri,  6 Nov 2026 10:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhRbQArhEAR2; Fri,  6 Nov 2026 10:20:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD28F811FF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793960419;
	b=Z/xAA9AUlcap+ziMk1VmKkIbUvqQapN5X5o51AaUJKpF+YMb9Jui1Qea4O0MbfOhl6YJ
	 kGI+SC8jiIMqd+3TRv2xcm5cNfOqxnBdlElB+yEmJ4I+QfVqJ89eiiwIFkohlCBFMGxhS
	 47LbztsUY1HBroXZYTb21X8rEjYZ07csiDXIVlvs5rDEpu6vtAruXP4tdtahgNREm6nNI
	 aFymulVCl6rEgE6qhEK4R26lPgKGg1E/lUGCo+B3TbvsrjZTGBxyNNUPYUZY8LZmfJF90
	 YuyAjOr5BfNcqUNtu0n89V+fVGhnPuOqU4OjaVTG4DWJ1ylZZTWBLj8XPPpk/u6PJJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793960419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=unEyvBJ4gu3r+jxvpjnQ11VfE8LAXBlQfIL7ADYmA9o=;
	b=f3c8XrOcuFaRvJjQ7eKY3u9pIAlImWuARGjff8hs+xk50rRqI0r7VVRNHEYOYxlkNR9i
	 YYZ1MrvpjeDfq86M6gfdk/lkfhrUjs6J3Ho/NCBYaz3N5VN2frDrMPhjtQLzAd2n1RWQi
	 Hdqj23PB39Wb2MsSv8T/qNEXuvR//byehW7jr3IQHbP5u/XsR0e/8uc3EyZdU5BdipOhw
	 grVISc1oBXb6KVDgwNiiUCT2asZKL6NV1gjjybTvHb4hC1Br5xcwTBl4mvMS01v8X2Qb8
	 +9MKsswVvpqpc5dzgcQoSD9iJwMebf92buVseVouOOASADuBpsN8rMolu9LHgVgwxgg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793960419;
	bh=unEyvBJ4gu3r+jxvpjnQ11VfE8LAXBlQfIL7ADYmA9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yj+dn3x69UkvTDXtrGI1GgYd8n7lQZJxt9+EPAHja51RltQ4cCLZU1+C/QZJ/+4ss
	 5i0425SI9g3+lhDhz7LliChPklLbvoI1mvshkxRdoQQBtZU56tpZtvTtCBI3A5vGyU
	 whXtl9L07EcV8NDirBdNyBKjEoH0xtOGpPWmd7j6GHJodTzH43VgPIJB3ZwMVb9ReN
	 ROJTV/nLT8Xe58mdmthufuh9yHTu3lUzwjbXn8ovV1WY7RBSoGs0dZrZPThVTmBRD0
	 stNZxYFwWW5Ylwis5biu3+GAEcqxALsW+peIFhFYpIxlVurF+DE3jmBBkyBBxnnM8Z
	 gkA8CzgDXkgtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD28F811FF;
	Fri,  6 Nov 2026 10:20:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C08851E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5DBC403A9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KnXylhva6BJG for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 10:20:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A4324400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=194.104.109.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=XNndjSYy
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4324400FF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1793960411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unEyvBJ4gu3r+jxvpjnQ11VfE8LAXBlQfIL7ADYmA9o=;
 b=XNndjSYybZUqTIrXZltO/3VHahpfEiIgpGdBDS6cOx6YJFbkghVoQTtxdEXzzJ1WfqASx4
 j4ze3dFXJrQdE6/Y7I4141awLfgXnkrRSVniQEUjvaRBV5a5g7q9vJaH/Qu6Km2zXMzPKF
 IKSD03ktUJlK52K0R16LjIIpk7jj6j0=
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11021093.outbound.protection.outlook.com
 [40.107.167.93]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-89-TclpWDXZNpShFfoGOjkXPQ-1; Fri, 06 Nov 2026 11:20:08 +0100
X-MC-Unique: TclpWDXZNpShFfoGOjkXPQ-1
X-Mimecast-MFC-AGG-ID: TclpWDXZNpShFfoGOjkXPQ_1793960407
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB516620.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 10:20:05 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 10:20:05 +0000
Date: Fri, 6 Nov 2026 11:20:03 +0100
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Daniel Drake <ddrake@baylibre.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Simona Toaca <simona.toaca@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Torsten Rupp <torsten.rupp@8tronix.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marek Vasut <marex@nabladev.com>, u-boot@dh-electronics.com
Subject: Re: [PATCH 1/4] imx: enter fastboot on USB serial download boot
Message-ID: <au2p00b514-YiOTp@francesco-nb>
References: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
 <20261103-imx-usb-boot-fastboot-v1-1-f3a918d55a20@baylibre.com>
 <20261104085049.GA810881@francesco-nb>
 <CAPGwodr9Nsy_C7oZJ+up2yktsgJbrKjXzgw94QPmOpYWKAoRbA@mail.gmail.com>
In-Reply-To: <CAPGwodr9Nsy_C7oZJ+up2yktsgJbrKjXzgw94QPmOpYWKAoRbA@mail.gmail.com>
X-ClientProxiedBy: MI1PEPF00000D62.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::494) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GVAP278MB516620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1341eb5e-13ce-4194-cd71-08df3bef86a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|22082099003|18002099003|10067099003|4143699003|56012099006|261026121527099003
X-Microsoft-Antispam-Message-Info: n3a7QvoP0X314u1Rt2zE47pT+1R/LNVMaUbyqU/gEsFnH39lWoYLsKxiPtqo6265oDJsONv9PA10gU3OrmE8IOKJ9qEjMPkdoRBiSxPhl+U4r5JkkkpEQ8F9nluYJgZSij4/vFN7uM44w8K/gp7RzPHrP532R8n6OQOuywJr+EiLalTycZQjhtz349mpEHLoa/RR2DfnqCjOpH+g63RrYIu6GW1kwDBXOyuF1h9KkT6pfQWzM1l174I3nt+sO7iUUan0O7ADTJyNFXl7UvzQ/lYHZtUwC4Ki3a0JAeZ+OOmh/yvoBr8BmvMJUIUOk0dblhGgE6F0LpdjQ1RjYJbvI/cMVgEkE4rU807VzB1MrFbMfQRQqMECoNpmyHwRsEjWmgKQ2mS8NwG6tmwo11jnUqLY5vVR1p+fxpyld1CNkGYqV2mok1q1FTXXHtSMM5IvB0ezo0De5bLhxaMS/ihfMd7rVuqFhVjEZBk8Z7GMkVAoFeKAlS4zd1HWVaW2IkdhMuqAa2hS0/80Pepn6D1vaBw+wXpmMvl092KXyctpnL5GpD19yAAmZFSyIdml7ClWFvzxTeKcvYlyiYu354412rfGxnIXqXUfwEztrAm/53HZbnT+n27tgdJk9k008uQQc/IJ7zr0KFDeXAlfmc4aZgiKXxFfOTh7ZRHYg3MCpyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(261026121527099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qdYTsxr5gNzXk0PVLE+LvuhsVKhK8q2GDhWmGYXe1qxe+dQGp7ye46QgYHSi?=
 =?us-ascii?Q?3+U2JRRTbF7jNhl383loQgtmsEf7KpnORAkz/1H1hYGpGb2OgL3v00hzmbD8?=
 =?us-ascii?Q?CbQBda4jnYrQ0KH17HH1mVyINjlZDxhJBH8jlZgDBCexgk8vGF/bCRCMg8ma?=
 =?us-ascii?Q?rddKwUtsZe+PLhXeX77SUOqE0q2yBgQe+zOT8Cd+6So0/IPdUeBWQdwrAxKS?=
 =?us-ascii?Q?liAPkhUAO5salhW95YG6GcxZCCmDz9whDGpFMtBc7cIuPC+ikCNpfY14xHPJ?=
 =?us-ascii?Q?Q92faKqkejHIarINkE/xyWz2ZPybWhzDyr9CykBtMWZDdLaOsjEyHvLjafvO?=
 =?us-ascii?Q?zaBJTstaglWNbhC+YZKBbKkleqCjBIC0ONElAxIOwX9Vor8HevrWEbuqg3Fk?=
 =?us-ascii?Q?JrmDpuzTkttq8oeHFts48oZIKs8Zjs3kWY17Wo1Gqb4IeQnKEN0371NbewSe?=
 =?us-ascii?Q?ssV72mirH3pTPrNLxY00qS19+a9steRewMCKfxo+poPOoOiJ6J2OosFbW8G6?=
 =?us-ascii?Q?LutsVvY7hfiEsoGX+d+LIp8MIZryXd4Jddu6cwtceBLgcyrAw61zZxOEh6a7?=
 =?us-ascii?Q?+hsyLh09djhD9BkJCepCP32WLW+Jc7/oovl9+Jt/rWHRPb1SE+6I/Rk/ELqG?=
 =?us-ascii?Q?bshOfC181HkulZlxDIqnusnqn3YeJZUrCE18b1h5DRszEzUc9EbcYz3mIAKO?=
 =?us-ascii?Q?JN/CBdKnveh15QlujhV5usJq7ag5I4aKhXgZP3MxzLJKX6ZGzeaO3hsjYdT0?=
 =?us-ascii?Q?Tzj994LjLsccK3pHWQh0NsD+a8Ig+UqpVr5EUMc6kHItyVjy2rLLPxsPOXgK?=
 =?us-ascii?Q?gjROB1smM6DR3ok48VnYLeAikSSzJ4pFIn5g03bmeUJyCs/RWjNE1ys9FjEu?=
 =?us-ascii?Q?0lghpCc66quEWwT60zhUmeY6WH0TU/MIJ2qFdwdaq1+77UtKTz7LXca9FTXU?=
 =?us-ascii?Q?/BDbh/cmlOLBNvZUEu/2s1MYz8pgQDWVJVY6M6YnzFzBCUe8ETfrHwJNoH2g?=
 =?us-ascii?Q?g3oSuVP+lP7gUMWBOs0tuwakcz6rmdnpJtcORhXh3LIwaXovVVIe8Nf91DVM?=
 =?us-ascii?Q?f+l9SuCeOrRlT3pYxaM7R9NacrvFuMdTYhs2oFUKAMVdlvQn4+cFNZtj6VOk?=
 =?us-ascii?Q?fz26tI/RKljnJJ19I0jTKvKRbGReR+nPjczT8icF4ImAQHuFjnAIcYeRX2hH?=
 =?us-ascii?Q?/+dW3bt7gEe4fyYgIJzrmo96ALOVcrV4QGZVNF63IkXPHLtmdFDgEFp7QiDJ?=
 =?us-ascii?Q?hO4znLH2qqmdd8paa4URJ17wDxQJemO5znVhOxhTetMgsQ2rG5bKAZW0AwvQ?=
 =?us-ascii?Q?J/vOm0BrKfUlIzSRy5yazUCYd38YSCuQgzcLaapPbFZjTczqvYtCOy4F4HMK?=
 =?us-ascii?Q?05Lxa50wHa+oO3z3IghPr390rpBp+kWRSvJicaJg10jENWhi/AKmFacJnISr?=
 =?us-ascii?Q?MOT7spSD28w/QS5HnfMqgP3Pyhx/goHuBl0lEea9QbZ5deI5Q2pKLgiuyA33?=
 =?us-ascii?Q?3zaHV4Av1gVF+u6QLrFww6Xj4gCC6wRbEhU86SIxtKidaBz9ylDJnWNQD5cJ?=
 =?us-ascii?Q?/p3EYqJVUH4VAGnBSGv37/d8qpwSs3cqlFyQ+v+31YMg34+2dPkvMxpwyU02?=
 =?us-ascii?Q?Vmmq21A/SpEGzomVN9D/56klBL9M1Zbk6ncmSnoIDdTMpatwnZCg4OSXgldI?=
 =?us-ascii?Q?D7q9jca9NDOkO46USaEPrCWYV9zi4eqvsgwoy5Ub8Sy4BCKkIaLPUdnLiFlm?=
 =?us-ascii?Q?hOs6VPbXziYyuXOOmmaPU08+5BgvsT0=3D?=
X-Exchange-RoutingPolicyChecked: siLPZqszGxcszzUD+cf/AFnhSpOzBbK9xHckvTTkbsi2YLJDRrmug9Wz1UH4Aas7jD2TmRNr6ry9FSSB9QCjDaPecV0sntCPW8QS8qSu7EPxTgWxxpRdsFKyYyk/7KsuweTab/HW7504Uj0XBvE7AQfHzNuTGKbQ/TFBpsOzfZKWKFmHTYCuhYLInK5CX9/V6hvsq/G/sITkqnRfMswfXeTlTLg5VEEkTIwo1f2fkGnpiXIS8rZV/69Q6aPsP/o7Plemfy9YH0uucEBx0oVH/fcFLVovCWryNtWf0dKjHItk+PqfQ0HFGuDifv4e5l5wWKMwP1SrqZfEKrDOhIvXHA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1341eb5e-13ce-4194-cd71-08df3bef86a0
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:20:05.3290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf/GB2qYUm/8B5h8tiOmtzbjeTttDCIH9oWDOF8+29ryjmcLK/C5g4pYcd0OmgEudyg+xuDI1XUid6FdOServ3vp95uhztj3bydkI4WKTLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB516620
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2Bfhnq5qDRrquU-wrPdqNi0JCCPwjH0LxB8WstmPw28_1793960407
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 11:40:00AM +0000, Daniel Drake wrote:
> So I'm wondering if we should just leave this as a board-level thing
> as it is now, and have each board continue to do:
>=20
>   if (device was booted in recovery mode)
>      adjust the bootcmd appropriately;
>=20
> and I'll just fix up the obvious inconsistency with the way bootcmd
> gets set for the FRDM-IMX93 in front of me.
>=20
> Thoughts?

This makes sense to me, thanks

Francesco

