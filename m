Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABBC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 11:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7300880D92;
	Mon, 21 Sep 2026 11:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-PBA9B7BSUZ; Mon, 21 Sep 2026 11:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4E3A980D6E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789989992;
	b=gvUDL+igWwy83m0zbXCrtFiH+IwlvMVZ6wCqWnXlxPkbusW1PjsJaIgZ6Mqpoq/eytC3
	 2CVBZmy/kD17jQ1pNJPKzaeYvfXFs6ob2Ax8R4cwzIUvCBe1LVL7plcL5uvX0c4iuxiHb
	 EckZjVwvtfDEu9taos7OprIa/xinPecnnF8wBXLlsuu7Bpaambb4N6FEsHfu50wR0/IjF
	 QeLwvSRc1+g3pZegWW586mhYOJA6ykQPl+OMh8L1PnOnZhCog55n8KM0wECQnrtpNQ63j
	 VRH2xROpgikUe8SblFOht6eDIE2vmb7oPMSxEcWPm4WxxDPrGwLM4LL3Z5Gn3lvhN9Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789989992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
	b=Yc9OShMs2p0kxp3FZnyQOSF2Ca5I+0qiRufpaqGJulqH+ZYWDpd6Jbt/7UAvm1HZcsVa
	 iyLbVsy1TJ5vsSK+DViBzCXO6HP01gpKxNbwb1N9DU5D7QDsWnIwFy4graPcuI5AXNCvq
	 U+QCX8mIuROgBbakC8aNIeXg6Ky2UJaFAXl5mNbOcf8Tsq0fuOKahCjxyZ5w+THyEzjNu
	 k5pBuTDHwdjLGFqPKplpryuceasproj69x7HyDs8wNXUVHpzZHkihIWU215zIDFLyW1+e
	 bmjb25zkqoT5/BShBDEBPSUYnTNyczF6YC8hE0ZJTjwK82ODLPpLLoriIt14LCMAgkA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789989992;
	bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vE0wibaUnBr56BwR8fDNW/V3r9OtZwz5AaOzxdcVCCTiq1VMRjFGqkmX/g12xRH1l
	 RUjcXsNt25saNpluUYcpq42e20UdCIPhgcm2wNXLBCFNMYkkAjTcByEsh3F8DyTr3g
	 LxCsED+/Ag6FjUiWJHaEMDNA2JnlWIyV5AA2l5B6FIaOnSUZBQowhzNpk6dFw0RblT
	 6Egz2MPGLyciTqYqYwUJ+j3tRDoYWiXj3vhcVuMeYSusj5XpfQcrCGDIweT0y42fWh
	 voZ3Z+PH/VquGTNSYGlFGTETMZncHfctGLmj+tQjo0fsSoFwwi1uXARt5kgnu75igF
	 mQH57fTkVPR6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E3A980D6E;
	Mon, 21 Sep 2026 11:26:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 492F3392
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46E954018C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGQLOO5LI-cb for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 11:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7CD5540111
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789989989;
 b=PRkAbET/9lheGfeadUxXRQRKVMrdveW8J/7m46sqK4lE1B1Ov69PCDcJbVws79hf4FlK
 OLiCRcGDVKoSCcL1rDkNkTCQ6CMENH69QvZzkmJMseSC05HFxy+93Fw7xI87PBtqr8sT7
 umUfnaH+1BGT0A6sqHBt3i+MUM5uVhuWVf5do3KACGmYDZ4JKmbqjJ8oFjHotU+FKSfbc
 AOK6cly+jXacJhgwEYsBCLd/Dn3vipk/E4DrOhe/wnZ/HDx/m91HRNl9ApOKHpQpdJBVx
 TpP4bRoRkhDxgAIqHpTlH43aAgK8ac3XuaXIsyp1ipP+dRQdy/r1/3fKse/C8fKd3Ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789989989;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
 b=TvF+gnB524lzTFA3QLkH8FXUX/5O+pbacum5ZD68oe+K9XnaQBVFe0I5JPlV2Efh3Qfn
 YsCoPXSCk+WSyGaBT/Ji/EbVdxDrMYTEpPeMEm5cwa81MfNDkGYsNOU5k8/3dCUuWyMXU
 R65KmEBpq/lK1tl//lJaF+r/21U4WgHMOecc5CSy0cl6VyR23Ge19YtzViAbEUq2yQWmH
 Atc/HHTp8wBnWq3aUps9FTTBRQm7HwfwPUZbIFlxkgS4gHJ0VKwGewaFm00iBJ0jrlfaU
 Ya69dSLhaxqJH0GcoETXo+IZp5bi8RogrY4lYlD6qAiDbH/2saasIK2nTE7xla2sqbw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=QRReV6ic; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=QRReV6ic
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CD5540111
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L96vsp3drMnYbnpSTtu38URFInlYmym8mx2mIo7fsfHOExDLBl/Jxl0jrj8IzdyITDjE5bfsZtCEIposFldYDMECdmsUo/po8boyZbpVH3Nz7SNKBh3IbxQyu01mOxzvkn3DXT9AAFkYNLEm/I+zsaqu7uwSYb3BAJTmE/2n9RjJZ+A6ontg6qh3hAsOl2y8Z55naHzKCank0FOKFc0A7L/HzEpB13x77F1wH4xyyngSaDvp/QAlMbz4NU1dm0X+AlQYXfBRrKMRmgBx5wpR2I04hBM2fr3cOmzz38w3OAxgEHnuWNfO5yRvacifZDKLoJNzdODatOQOdRis1az9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
 b=rFzzNaBi6jW7tvREBfi6UxkvXOgOcnWVkCAmjrZ7pioCyvRv1NaBO5OnEUY1ra9bGZpYs1VSsU3aZtS/rnqf2aw0PsMtnGb9grMlAqMLz/QxmUpSzaqmUA2G/4HQbuVczwTD0ypR5u4h7l/Ocyrq9xcwSjWfqDr6gd6KtbQEYGhW/rXVVcO0K26T4DDSaSRhwC3h0I2MUx4bVZPFsz54sFsXNIOLlWej1qteMtIS9uz4ynvR8C+zmMHdFvPvplF5Y6RvUNQuP9iEiVEo2J/aEpWHIMxW5h1FRymYspQU/jdYqbWCW0/78Xv8YBft9e4dt9688TKzzNtYjlpW/180wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
 b=QRReV6ichj29iWeEUE9VWpg986CCwwHAYzuEeJuFJJUgGehWutyMz+8lcvdVHG/SklmDIGJbxLz/SpSH6Ki0TttDLV+yG8SzHHpVAwLkeqwJpUv+ykFWzdeQ8gHHY4peu8F0X0fDAgjTUjdOHGb0PXya+b8uKtqRsH3nV1CFf18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:26:19 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:26:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 4/5] cmd: optee_rpmb: allocate large enough buffer when
 reading persistent value
Date: Mon, 21 Sep 2026 13:26:06 +0200
Message-ID: <20260921112607.1562189-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921112607.1562189-1-ravi@prevas.dk>
References: <20260921112607.1562189-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0014.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f02c13-51fd-49be-b929-08df17d326aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /PIpPiVf2V78EbSuOml5xaJM3zqahuPbtILxAB7mH7+0apFnPmnjiMePGO77hZx/rihFz0bNj3o5Covf4wjmen1P+5eyeGED6vcVOAdm061WAGTztEZovVvtRT1EfVQBeyxj6YOtWLZfPD2V37Sewi7C1B2VdZa8TcNe4T5x7dz8HxY8k0g42sJMSaAMWgFmRkvtuc0QG5jiuRnX1AfhS/GDEFD7MsRA8roH9/aGOMEmB+/I15Y5JsPQtJYLxCpNVZXSwui88/jYqrMhCW53T0dZx7v5utA+sQcAp3cevd0OKtp33C+Fmi0HBy6bYTMaR2mtdZwEoMnhhoiJPLuWZFM0lIXysBE4xsu3kwk27vggCTuDuL8Tx3G+7yZW10/Te1gzObbOnIR5Ay+tr9AKTjp5YrVbcsjSd6vnO4N0eIuyFm/ALPyH/BsSsXkAm6t6N07zQCCtrP8gHKwMZRwLxXkdDOiVkJyVNyPAifpBoPU9oHM3OkSc8qS1ahYmYCPUBmGZZSEmAYWGWseMtHUYMky89TeIM8YmR0Wwc4a/5P6w8PjdZEy+N69WpK+ynMEJnsQG8pULQS5RwTphMwC15gaISUa1lWMCxvPBjFoPYRkuh5O/n4e/3SPw6NAwTxzn1EtW3dTFPvTiyCF4t2O/sJNfXGh6mNRBBNzI0PwL8J8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EfS9ijxqhBxzGjy3Z6gW+ZyneMfd/0Gti+Ab32YJ8+JVMzre1BlhIfNl19SD?=
 =?us-ascii?Q?mKQWKFd2bZK5L8xlC7swG7SFmCPuCkgZWch2N9QxjCVjsoY0EXEa0oRa2VUZ?=
 =?us-ascii?Q?Q1OQDrCuRpkzXQBUf5zNlzdR+YL4+xmxjOU9pa5d+6/6cWZVaRp7biwfcLNE?=
 =?us-ascii?Q?euopN01wJKPjyNANk9KrzCb6PPyAPStirSl6b9Y6Kxl8zRcf2dyUKaI423cM?=
 =?us-ascii?Q?LxrJIuhyP3XhBqVnJycwePhxwevVvqDMoO9zlRGRC/w86ZqsgeyDoUF7D3dW?=
 =?us-ascii?Q?SX8Kyx1LXgv7TSG5l+eacvn2N1S8JKx6hU/GUOyf6RwEjRBA7jcuBKqAHvdL?=
 =?us-ascii?Q?10v6ACEB7+TDR1Lv/eNl579TpThMTihTAatNvthm4IuuID+QL147dOcyy+G/?=
 =?us-ascii?Q?+hbYa1BBLeiOuBwEPyFHOMJ0o+yZA+INRa6e077hAhEeikNilBMzVaWIxirX?=
 =?us-ascii?Q?sfAGSlqu4GzxI4dsFrpjK85b4JVIv3ZZvOzzGzoKGubbrlqEu/przsrS6dmq?=
 =?us-ascii?Q?yX823j4DAgGK6tTtSDuqT9MN9TMsUHMirt+iZZ2X4k9SJxgoKhHiTkT385Tn?=
 =?us-ascii?Q?ifmQB+NuZVzV1GxDXicLTpKYTjLE/SCCif7ZmDwUFTHqGlNvKSapj+eldLCJ?=
 =?us-ascii?Q?eO4m1ln+Wi2UyqcJXfSbJtmNtfDsJ6yzpiBF3doaRM8oGe/c6NhqvQ4fa9pu?=
 =?us-ascii?Q?Pd/xpEoRd/QoT2gpyiatvBsL6XHWVNZ9izUZUrhaS1gZJQygrAmi1G40dEQx?=
 =?us-ascii?Q?K75ytFhKo2S2Y0965SRsm8mJRiH6UBoODjY8o2s7QnSAhk5+p09rZUksYTqs?=
 =?us-ascii?Q?E2TVc3Kazdmle39gPAHQ8vJ2gLWbtvM56EnD0iWrXSDu7PYnvlkGWgtWXxH9?=
 =?us-ascii?Q?BXKruzhBS5NZAVc7zXv/EZXV1dE1mGoP+tuYEBFXdtcbh/AF4LxkS6qmSev4?=
 =?us-ascii?Q?VxA6lh1/xehuJ6wBD2vXjajM6FVU4GVIZvh57cIroBz6OKPboptp6EYbXspX?=
 =?us-ascii?Q?Gwf/uSwS0seIexMfBX0/+8t27IRKW5A9wVAthx4DQhSqdY060LEGnR0FWlHG?=
 =?us-ascii?Q?t9t8EgpGFUgsIUETMmHZcVZ4SxpCtVLcbwjYvjjG8iTiNy1OGvYImwJjdmLf?=
 =?us-ascii?Q?vWuaBkKjpzxr2EBUW2lkqaL7/7hKwIwZoWUYiOfa51ZZGeEiqzEEQ01c/axh?=
 =?us-ascii?Q?tixUm+EqsVP6PecJ1ZEPIa+12vwZQEffg7x9JIZm9mm704bG5/99/q+lQo1L?=
 =?us-ascii?Q?xCnw+322A5IeNrWWOmO/fX9oBI+yuhkwe4jY3o9cWr/qIJdLYQS0wEzfjF5S?=
 =?us-ascii?Q?r9BxzVRHBzQYKNw2FUU3Ubk+UCLfCM3ttQuSOMqArABsZSAx/xQaOZl6mC00?=
 =?us-ascii?Q?o99qbZMF03LQQCHKNBUUFHXH2D6pwYNaQ8xLvYstXIRC2jW6GFtPLB6w2sUE?=
 =?us-ascii?Q?ksPtmz6BKvZgvGhvLiKwhowJZGucRhPNL3jpncchusz5FnAyOrvdAbneyFYf?=
 =?us-ascii?Q?ZWNYFKLvGBjYcmN3493gbUtYdiy6x2Vr789+iNYHE1PlMYfkQypO6MbI9AbT?=
 =?us-ascii?Q?htHyFQg7XEs4oYhwZ9XaSGJ1wMw6eV4Rk581t5VzAzwUHJnKTA17+2vgXa/P?=
 =?us-ascii?Q?uXcfLogmOQiVgDQixjfVtkYkzkm7e1XVf6N3KcUtLcNVVaR+Dlf5uxDbrFNd?=
 =?us-ascii?Q?0NbukUuBxNtCHISggTtOHLIgJB5QWK2xEbLZdajnWFMsn1HRGmX9MLL6F338?=
 =?us-ascii?Q?GwpOMqghDiwKyogDXhtOtDhEl7GfboM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f02c13-51fd-49be-b929-08df17d326aa
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:26:16.5435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d797rsudpqTbbVe15gnSE2owQvx1vLTmhCq5AtKa3HrZcbGRPloPhlzlWRalxc0UPoJ+IqBYVpU3hJb0M8icsP7D6BE6wQn4O05SPhddaJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863
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

It is implied by the comments in avb_ops.h and the translation of
TEE_ERROR_STORAGE_NO_SPACE to AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE
done in common/avb_verify.c:invoke_func() that the
TA_AVB_CMD_READ_PERSIST_VALUE could return TEE_ERROR_STORAGE_NO_SPACE
when the value is longer than the passed buffer size, and that
param[1].u.memref.size would be set to the actual size, so that one
can allocate an appropriate buffer and re-read.

However, that has AFAICT never been the case; there is no mention of
TEE_ERROR_STORAGE_NO_SPACE in the history of ta/avb/ in
https://github.com/OP-TEE/optee_os.git, and what the code does instead
is to return a value truncated to the given buffer size. In other
words, not only can one not determine the correct buffer size to
allocate, one is not even told that truncation happened.

Changing the ABI of the existing TA_AVB_CMD_READ_PERSIST_VALUE method
to return an error in the case of a too small buffer was
rejected. Instead, a new TA_AVB_CMD_READ_PERSIST_VALUE2 method is
implemented which does return an error in case of a too small buffer
<https://github.com/OP-TEE/optee_os/pull/7959>.

Make use of that method, thus making the <bytes> argument to
read_pvalue redundant - continue to accept it, but only use it as a
hint for the initial size, defaulting to 64.

This obviously requires running against an updated op-tee, but as the
optee_rpmb command so far has not been usable programmatically (the
values read are only printed to the console), no existing boot logic
can have been relying on this command.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/optee_rpmb.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index 9a3274c4332..6f6c70ac084 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -72,8 +72,8 @@ static int invoke_func(u32 func, ulong num_param, struct tee_param *param)
 }
 
 static int read_persistent_value(const char *name,
-				 size_t buffer_size,
-				 u8 *out_buffer,
+				 size_t size_hint,
+				 char **out_buffer,
 				 size_t *out_num_bytes_read)
 {
 	int rc = 0;
@@ -81,6 +81,8 @@ static int read_persistent_value(const char *name,
 	struct tee_shm *shm_buf;
 	struct tee_param param[2];
 	size_t name_size = strlen(name) + 1;
+	size_t buffer_size = size_hint;
+	int retry = 1;
 
 	if (!tee)
 		if (avb_ta_open_session())
@@ -93,6 +95,7 @@ static int read_persistent_value(const char *name,
 		goto close_session;
 	}
 
+again:
 	rc = tee_shm_alloc(tee, buffer_size,
 			   TEE_SHM_ALLOC, &shm_buf);
 	if (rc) {
@@ -110,8 +113,16 @@ static int read_persistent_value(const char *name,
 	param[1].u.memref.shm = shm_buf;
 	param[1].u.memref.size = buffer_size;
 
-	rc = invoke_func(TA_AVB_CMD_READ_PERSIST_VALUE,
+	rc = invoke_func(TA_AVB_CMD_READ_PERSIST_VALUE2,
 			 2, param);
+
+	if (rc == -ENOSPC && param[1].u.memref.size > buffer_size && retry) {
+		retry = 0;
+		tee_shm_free(shm_buf);
+		buffer_size = param[1].u.memref.size;
+		goto again;
+	}
+
 	if (rc)
 		goto out;
 
@@ -121,8 +132,9 @@ static int read_persistent_value(const char *name,
 	}
 
 	*out_num_bytes_read = param[1].u.memref.size;
-
-	memcpy(out_buffer, shm_buf->addr, *out_num_bytes_read);
+	*out_buffer = memdup(shm_buf->addr, *out_num_bytes_read);
+	if (!*out_buffer)
+		rc = -ENOMEM;
 
 out:
 	tee_shm_free(shm_buf);
@@ -198,24 +210,23 @@ int do_optee_rpmb_read(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char * const argv[])
 {
 	const char *name;
-	size_t bytes;
 	size_t bytes_read;
-	void *buffer;
+	char *buffer = NULL;
+	size_t bytes = 64; /* Probably enough for most cases to not require two roundtrips. */
 	char *endp;
 
-	if (argc != 3)
+	/* Use a third argument merely as a size hint. */
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
 	name = argv[1];
-	bytes = dectoul(argv[2], &endp);
-	if (*endp && *endp != '\n')
-		return CMD_RET_USAGE;
-
-	buffer = malloc(bytes);
-	if (!buffer)
-		return CMD_RET_FAILURE;
+	if (argc >= 3) {
+		bytes = dectoul(argv[2], &endp);
+		if (*endp && *endp != '\n')
+			return CMD_RET_USAGE;
+	}
 
-	if (read_persistent_value(name, bytes, buffer, &bytes_read) == 0) {
+	if (read_persistent_value(name, bytes, &buffer, &bytes_read) == 0) {
 		printf("Read %zu bytes, value = %s\n", bytes_read,
 		       (char *)buffer);
 		free(buffer);
-- 
2.55.0

