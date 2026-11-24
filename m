Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014A606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=asZq4YLN;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=pq4V5axG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1F0580E36;
	Tue, 24 Nov 2026 20:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m8oQ7F3iDiPL; Tue, 24 Nov 2026 20:06:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED57F80E13
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795550779;
	b=ih95lcklJUNz/mwTV2O5/TS6gVf14ngtrba1uEOwIlGhoHnIHIjszl1xK3pNxT/LFOyQ
	 qmkwRZddDUd7RCTsWIbIedrM57vrKT8n2gKg6b7SNDHYMfR88fivgGoTBbzIC9bxlQu9X
	 yKk4fWpfhZ8P03UnNW8SAv8IEJkoVhn//2Cd9YW/YmDGQ+cP8x2MZexOyO2z7l10pJ8Xz
	 mJtcegvhl5i4jhraX7FZCYPoSutQCqGPL4ZkN1TufX3C50mUocIW98mhvcoInihf4gqQu
	 qCqNv/CWWhWpHOFI5+59n/z7CcmLykRS/T6OSaC5Wm0QllKamayjMW4RWHRXTdazx8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795550779;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KkSSSsVgO0Y0nLsy3QxxAC9OBgret1q8WLgi0An1IHI=;
	b=EuH9OM37KRPcnR9Khtgi51CGtVU9A4JR/w78AHwWdT25me3tUYybPqfhxljvrCE5DFFv
	 hP8Wx3U9LLQZD7YXnbcUJVr93BfzTw7i5olG3kdC7du9IzCywUGpJgBGixSaM3VFLjbDq
	 ow0XUMBCXbxRW1XaDXA/+1g6auF1m3Q3g+YIrk3OOJjQtHlyOm2bRVuYP6o+/o0QAgW1t
	 BRlUDYmn+8TS76LA3IgE/gSmRG1A9g8ggBHMNNncS3AZaQkTQCARDmOvYx4R7+L7NCI6w
	 P8Tq9xdXXvw3OTDYzSQ5xa75v3wq5klKSaeoatI5HFpyMklVedgn7tg7zWnELHyFfyQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795550779;
	bh=KkSSSsVgO0Y0nLsy3QxxAC9OBgret1q8WLgi0An1IHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=asZq4YLNWEhhqNSeKhxE5+cJQZxt9D5yRWU6FjN78Ol7hKn4ZpstXWcO9OJc5nneW
	 fo2cQR7FhahsIuNCjSqxX3LBdnNu3jY3jFx3yXqQXVeydg21U0No6HX7Ok8kZdWmCq
	 UBjJaleh69A+43ue355wTLoPfMR4lwtB3CEc34S7RRUv6OPITJwTeFO8UpKATYGpv6
	 Xhm2ZkiZu1OhHEvmFyKqyfY06S1lqsx0yOjq1PL3oQzquJATDqgcGI22JQhMs4x5no
	 NEaF6nbZx7JuNmn6YMC1kBWHEpJBYpkYY7wbTz0deJXCT2ngI3DpM151ADmiCwDwha
	 Y75UvjjsV+Mdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED57F80E13;
	Tue, 24 Nov 2026 20:06:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85150325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7743B4052C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QeR6w6dLTUXR for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86D6240534
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=anthony.pighin@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=pq4V5axG
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86D6240534
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkSSSsVgO0Y0nLsy3QxxAC9OBgret1q8WLgi0An1IHI=;
 b=pq4V5axG0kiWIW3lRyoQEfi9M3dCCAKPBGoJCeS4udS3F/Bp4fPvsqqQe40sOzwIxlRcuvRnoQYfFAQvKJdExFWWKXUb54tTTFVJetSMxzTNs6meQ0SyAzet6YyLcw1N3gxhmZwaiLmKEiuH4FM4BjADpFsp6wmdyoBwNSzsK8iVu2owMesQBEnaD8MFED8Di4wYUFq3xrACk97wMZpqKh+M/l7GaKkfXSYfJWvOy7vvQYkVCsuaeOjtISHCCeovfjfWDkiuVjdRKcQWyHtFviS46CF5PwlSOcgifSjxUg0ko285CKxBd7rsrm+9RpECzen/FRct4UVExLCNw1Lk/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by DSAPR08MB846671.namprd08.prod.outlook.com (2603:10b6:8:51a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 19:04:44 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 19:04:44 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Olaf Baehring <olaf.baehring@draeger.com>
Subject: [PATCH 2/2] crypto: fsl: drop the results of abandoned jobs
Date: Tue, 24 Nov 2026 14:04:36 -0500
Message-ID: <20261124190436.560138-3-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124190436.560138-1-anthony.pighin@nokia.com>
References: <20261124190436.560138-1-anthony.pighin@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:610:e4::14) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|DSAPR08MB846671:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c7b330-de66-4bda-cdd1-08df4a5dcd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|6133799003|3023799007|261021121427099003|261022105027099003|261026140227099003|261102123227099003|261022075727099003|261026121527099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6gXtMFtjJ/RVXO2ixnSfI+vV/1xBPabW3Zbvi+QrWWbMmt83jrsW2ARWf31HLgpFqIlV78KKpRy8QF4RkNR23kQFIk3t5FSeR4WBxeylje4wG8mDSE5N3120RmkbO5JBVda9kDqbmCamFVi1AY7ggyHbUwfajcgi7pm4UfiSRO8/XxCNByzqszzeM5nWp+59k91OQL4doNaeyYCz9WztMsXlHe1DWZ3SUPbkFPdZdMJH5ul4T+9c/XibCCYF9N1HjMzrr1Op4Mv2N30mPXM9DpgQnLyfQKFuy4uhczTrhJ3USe5M0/azAJnFoX8daIkzPI4cgVAYxBWaSIpZJqGOq+w7olCvrTxrBa2g49EYMI1NXDq/3Z988MNnclKXfK0TM1vktp4DlBWwncKE85t3ynzBvyy/zGB7S9AiNQF6dOfwb6TVS9UZOUMdqyF/RTMo99Er/NIzxUakGQ5Fb/hd0+GZuvoXir7WSl4r7La7a+/mLKE5ckpzAbTqxyTQjQux2VcmiWjIF5OWpzUdQtavSPwzGRkG4W9qLn+0paON5SAUCieI0pBy4+7WnAlHxnC6kwIlBttrm8R2a6++ahi0xfHxl0GpXdLypLVDzWcSF38VDa1ElOxJgiPXuN3vyhW6iCjwowqsd8b8784txVEvmkpTHZ0n7aKJUuTcqgv/Wb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(3023799007)(261021121427099003)(261022105027099003)(261026140227099003)(261102123227099003)(261022075727099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sv+FWX5JBJYCrXwSupzhwIGD/MPwq8Kg0rJkwIJilpmEOcpP9ZY8vxDKqO2y?=
 =?us-ascii?Q?iAltAd4co5UIc+LxsSSrltY8i5bxxdFEE2SGFd78/q5wA6PHzDsGuNK/rYQN?=
 =?us-ascii?Q?i/1lOrrNGdgPZWkV10DFDWysX3umknJY+IU9hexAnhx4C10+El0CQYZgTPMt?=
 =?us-ascii?Q?q5W/s6J97qNWb0ICLQDCiEWzrhmIwv0WYeXZgWwwAgnbfJeHFUmP2Lyzg27w?=
 =?us-ascii?Q?di+GKtk0HXb/7QMyxWtNnWP5AalfWWHRBtgWx4XNqad03CAK2yVOF7CSMnVt?=
 =?us-ascii?Q?yMtng04z8JXS/LCnR6ZtI0h7ijEOxXWE0FBNZfOWg6A9yVICY+pIQK20sftb?=
 =?us-ascii?Q?S2ustpaSY3SjVAusJ1g4sbGjeOaE1avmXxd3BRAsiYhV7m12DQvZWnOTZaNM?=
 =?us-ascii?Q?SsG+YGnpwOW3PtnF1DKnuTDr5JuQWtt4dblss4yig2vqrfOZjOELI3+uamLr?=
 =?us-ascii?Q?p2HdgqHQatFOR5cUy3da+e/VX7dsHRjxRQo7UAhAccTvBH5trI8hpfa1VwCq?=
 =?us-ascii?Q?OE6e+iDo3xA7Dy8KjNvPkp9pYN9zdgomO/qJfRHSL4br3mMZEj5v8AvhALvr?=
 =?us-ascii?Q?nwMDMS+bjs7YAUpXgOK/Onx8bbsw5oLUhyJzDtPUEFNmB5kMJzTrWxd42P9r?=
 =?us-ascii?Q?sRRO+bNHQN+/xWpzIh2skneqm2VUtPo3Y3NcXJzKyYv0WvI9koeUncdzmZj3?=
 =?us-ascii?Q?DM9t8cbNIoqWCT10/2kkYSFEQDidmRwTgBsLJG745FTwhBIF0TdzgQpXecyA?=
 =?us-ascii?Q?o10AxH7WTIwKtTa8Qkkuihu8xD7vxoU12Xd+C/IFG9gkCsecPvu4xtal9uQG?=
 =?us-ascii?Q?EQEKOz95qu5dy2XNxOtP51KWY6Lto/uj1v2NmQQV3EOlkjbVH/lavrq/mudy?=
 =?us-ascii?Q?wsURSka7Sco7DPq6aVld9Pp3LUkT+4OyRLT5Ki23KhlI85LFWP7R2ZqCTQfG?=
 =?us-ascii?Q?RxVwsxRYNtXhA6fIsD9ovPfV4KcYcm/lLaVZwB/m0h9dl7oCpqZBqVqJY7YS?=
 =?us-ascii?Q?4ZUx3XWgPUPEJ1P497PullMCQoZ6vBzazgzgZtDvOLRtAyQCswGNo2ZeHkk9?=
 =?us-ascii?Q?5lf+OgE4TwdxrHN/XBRqXkE8RO2LBUQD8fngxPQJfi/eWMnUfgrWF7NOn5ta?=
 =?us-ascii?Q?HaRSOUsO6LTlIVhZZzWba9tK3q0eIjKE6sB7P01uiGM8Mwk8UtZVXHeRskHw?=
 =?us-ascii?Q?BXk8LSX8tRQlM0M4lGRPsqcKoSxFY7Tk+tmR0cPP2oH1ru71+J0FXVTxLpBc?=
 =?us-ascii?Q?nVGyksXchOCgtPRBFlgL9qvMVKhV7AZpCN/OLnAdJF4OjRDEAI+Q5n42G7YG?=
 =?us-ascii?Q?zkK8uMX3bWn/2ExNTddTByZE+6ZmzpeSKmbqw8ClE2f3iqFXy/o49Ds8km4M?=
 =?us-ascii?Q?wkLGGUzmMchLoZZMVGbS+bsnfExuAamVtwJML7xND7NV+nV6w5ot8YksheX3?=
 =?us-ascii?Q?khGS49Bd5IdPiGUag1XLMlgbxigttzIAkkgzDlk9Chatm/ym4x3iiXBehtRC?=
 =?us-ascii?Q?nFdL19LsbfyDjjWcTIRWJAy3qYTXaNfaB3BZE2k3X8pJczHDyHtbLKMilIge?=
 =?us-ascii?Q?gqsMvdUIWNKJH0F4sPVdcm4rF9MhbR3Pq9zDaSFBcOwPW/qqE9bxgduAuRwB?=
 =?us-ascii?Q?qESHZjCzzB0QCizb/s99/Aduq5jHv4FRfJrFdXNc/nFl4PgEK3O4xIV/WgMh?=
 =?us-ascii?Q?E9Beoo/wsxlqfPNR2ZdTB1wS8LfrrZqFs4fL75dziVnAEcgNSAYm6JiEVcZL?=
 =?us-ascii?Q?qkhn8YKK3CB6WsSpmMgDMLDou9Q1ceQ=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c7b330-de66-4bda-cdd1-08df4a5dcd4d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:04:44.8453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVn2l5iSk5OJEtlrYF2/zWM03ubI+FjDTrrqKTBPjW1WKi8YYTCLlOZHeKHcXrL5IGdtXreh4Ao5FFReGuUu5RK5N142NY3InMGGyrSwpew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR08MB846671
X-Mailman-Approved-At: Tue, 24 Nov 2026 20:06:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

run_descriptor_jr_idx() passes a pointer to the struct result on its
stack as the job's callback argument. When it gives up on the job after
a dequeue error or a timeout, the job stays in the ring with that
pointer. A later dequeue completes it, and desc_done() writes the status
and done flag into a stack frame that no longer belongs to the
submitter.

This has been seen on LX2160A, after an EFI_RNG_PROTOCOL GetRNG call
from the Linux EFI stub failed. The write landed during the stub's next
GetRNG call, on a saved return address, and U-Boot aborted:

  "Synchronous Abort" handler, esr 0x8a000000, far 0x1

Clear the callback argument of any job still pointing at the result
before returning an error, and make desc_done() ignore a job without
one.

Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Olaf Baehring <olaf.baehring@draeger.com>
---
checkpatch suggests u8 for sec_idx in jr_forget_result(); uint8_t is
kept to match the surrounding functions.

 drivers/crypto/fsl/jr.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 53f8af15f5c..6e6be5c5c50 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -320,11 +320,26 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 static void desc_done(uint32_t status, void *arg)
 {
 	struct result *x = arg;
+
+	if (!x)
+		return;
+
 	x->status = status;
 	caam_jr_strstatus(status);
 	x->done = 1;
 }
 
+static void jr_forget_result(uint8_t sec_idx, struct caam_regs *caam,
+			     struct result *op)
+{
+	struct jobring *jr = &caam->jr[sec_idx];
+	int i;
+
+	for (i = 0; i < JR_SIZE; i++)
+		if (jr->info[i].arg == op)
+			jr->info[i].arg = NULL;
+}
+
 static inline int run_descriptor_jr_idx(uint32_t *desc, uint8_t sec_idx)
 {
 	struct caam_regs *caam;
@@ -354,12 +369,14 @@ static inline int run_descriptor_jr_idx(uint32_t *desc, uint8_t sec_idx)
 		ret = jr_dequeue(sec_idx, caam);
 		if (ret) {
 			debug("Error in SEC deq\n");
+			jr_forget_result(sec_idx, caam, &op);
 			ret = JQ_DEQ_ERR;
 			goto out;
 		}
 
 		if (timeval > timeout) {
 			debug("SEC Dequeue timed out\n");
+			jr_forget_result(sec_idx, caam, &op);
 			ret = JQ_DEQ_TO_ERR;
 			goto out;
 		}
-- 
2.43.0

