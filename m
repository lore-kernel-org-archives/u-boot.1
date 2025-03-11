Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F04C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7298169D;
	Tue, 11 Mar 2025 14:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pynU8E3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FFD80F92; Tue, 11 Mar 2025 07:39:11 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F79806D8
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGemOWLV5gP1uI9MMN2kC9PeQ7B3jJcUnc2jFYQ7V60+iH4BQva1VLOn8ajYZakgRPJZ6ETxzooYgFQ8lf8eXlApnPmQy9aVH6pLiRGnZSpqH1ZkIByC8LUXnglHeuzQkYNJPQy3Txvy/vOfNwkezdJyZJgUNxNZSwOz+Hqr6c5WJzIWHs+xEIV5QiRoqNhg2yv63nVbb1y7F0dFxDDhJ04MfptkWg+1wMj3NO8/5jL3hwmgoINtHdvAe2NkXUBMtTmlK2UOI0yXT8U8QhB8k7taSQ7ECMoX7iNyBbuutYkBSX0qTq4w/weTDx50am732hsdk4QSEg+sZDa/60sRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48Hfrqb/i+rlWBCn1G48LU7FKOMQRTUFccz3S60tBIg=;
 b=VqitWkvunhBtHrWkwYX1Jh7dGwwxb6Sm+0U+Og0n+a/i9xJsXiXpy59zar8Ad8Pn5JbL4r+nIIr03A2E2IJhcZJhYvNTylj3m9RtC9TdMMOsoA1KwgybZAhmbVgDH85rwzY7klAHIHIfOJWXUHSZaVRIIpPZWehatg7CsA1lj1PCkSdixzG68XrtE2POTLCZ3z3JeR00HM2inF4jYw7syIsxfggi05cCiYxq0GfKtH79j56i9aMhLpiXgep9CzbyEsx170eMlx/FQWfhR+BgQeylEXRT+Tv0k88ycL5zS47P1XHIQNzkhFfrVZgvKu8BSiXozs1FhfEcaFJlpRHPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48Hfrqb/i+rlWBCn1G48LU7FKOMQRTUFccz3S60tBIg=;
 b=pynU8E3ojg/QvCtL8LthNeOBIy8lCsi13sq3VpcVT8Tsd/N9ct6j2UR3NJ5ZkV+ANUfR1H+u54RkW0QXCiVRxya5AlZ4amXTE1cg0XzWwU2CRIlAWkB7KqO415MegWB3jweujpj54tdHSARjWOMchAb5PrQmj0bQpdf6n10oJXxb4loQ9UMOXOj2L90OV6avPXblElX6+o7105V88w/ttC/TQl529kpHHFFY1FPQHHVTcF68951VgZUq1Xz+Zh0I1wmGwigFfKD+kZ7NCM8pidRZSIxlV/6Lav2z30BokkK0SrojWIjcJTKZw8pF537WCakbF50qR2RbbpC5kzLrAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3877.namprd03.prod.outlook.com (2603:10b6:a03:6a::11)
 by CH0PR03MB6049.namprd03.prod.outlook.com (2603:10b6:610:bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:39:06 +0000
Received: from BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868]) by BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 06:39:06 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Mahesh Rao <mahesh.rao@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 0/2] Add HPS Notification for HPS boot stages
Date: Mon, 10 Mar 2025 23:38:50 -0700
Message-Id: <20250311063852.9059-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To BYAPR03MB3877.namprd03.prod.outlook.com
 (2603:10b6:a03:6a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3877:EE_|CH0PR03MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecbafd6-2008-48c2-f789-08dd60676b89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x621WEu0xJxckuvrSi0m2QNTJtcuozdDZBemeowk+XX6I+If0V/MtAwtT6Wt?=
 =?us-ascii?Q?XTWRKYIcv8arcXazXbpU6qIFBwBYVhj+rIDPqy3ttvPk5iBNhX2tuQrK7C8U?=
 =?us-ascii?Q?S1dVy9oMK51G8luIAXsmw4XYcd4GyBERkvsNd+APOGl8Wm2KycU/iM8jIvEu?=
 =?us-ascii?Q?SJZkl9vFl9qVzxKLf2BCxp3S1f0pp2voFyRMVjUlGMB/EgEEFeXI9dxDDnxd?=
 =?us-ascii?Q?ZzuEnjYWjLuWR+JGQ9blFjnr/vpHOGRmP7LUfmhyefrYVgkEF14KcZZaUqBq?=
 =?us-ascii?Q?x+mZc0NTOImXo9RTM4t5b51oIJToBiQ2EXdlt3ja24DoJBxWTg/yWiaAOoU/?=
 =?us-ascii?Q?FVCRWCmncbn8h3J6X/5fx1jvHERmdRzI4knVPaOF6jFdef1QkaKz2dbxAt2h?=
 =?us-ascii?Q?rk/6w5sfNHpWFP1DJXXjoAyIyLU1OGiplj4WuccAzb0h1zNCF3ASbGuZ7IeQ?=
 =?us-ascii?Q?MJadaUUfppejeNHEHDTme8/uUofMshXExfik/NSMtDe7U+q5ipZ+eiiN2fjx?=
 =?us-ascii?Q?rqgRsasQyPszxe6hgHcEQrkfVUNE+1DSJDVPrY/+WfCqRCJOzNnIppdxMQOq?=
 =?us-ascii?Q?UtQKWBz8jXwIqfg6co7Tw5lIJM75iiN5XSwnckwZI7mHkqcDmWWTty1v+Ur8?=
 =?us-ascii?Q?LJZKbxNN9eOR5PEgexJMNSng7pqzBBznAglyYaLgahlMFsecr1c3X5JToDR1?=
 =?us-ascii?Q?2G3/fnu1lgqdp45vTA5xhevHT1aixSy8dJ10QAu9BHkwZ3NXtD9acSowA2tN?=
 =?us-ascii?Q?8xmE4ivkmncb1Laq7NBYZvAr99QHUFJ8SHzuZYLJgHX2XFjhqVCKkFjnfj1I?=
 =?us-ascii?Q?gZzwvcrT9u817zCF0llKUbcIOGR3BqLzr8wD79oSY/E6gyFwqsrHDX+v2oJP?=
 =?us-ascii?Q?HcfDw3tHUfj9wgZDgxI31kYujYFy9WHqF4BwDCxbAJHnp/tKaMZ91YcE6huX?=
 =?us-ascii?Q?9+enBf0HfCyOqmkNuBqPBRVAuJ88vMPZR84nFPs08zH8/q1jzvOQtaekARXB?=
 =?us-ascii?Q?GnjymFSerGyzCOi9294iDodGw0dMDgqfLjq1vpHa9m5GQCrcsz7d5tkB5Xzl?=
 =?us-ascii?Q?HN9NT9kWHxC6xqtlKTrSKHZaYVAx7NGsnQ4uX7w2CfnTbKlVzK9Ud10RSjRA?=
 =?us-ascii?Q?jA8s5HrNqVRdRAepV0xgH0DZLzsGsxHNAevbl6LtIj1yukicBEKWJ+t9Fa6U?=
 =?us-ascii?Q?XvB/wSwm/yGAO80X5/+HoZR76Y4A/r06LAE5Fq30uxsxfmz7o3OD9gtTn4ya?=
 =?us-ascii?Q?iYc1OOXttYY+8Ffn6PXvsQYE4caNBd/Ko/e68pGDOLiVp7NsjQAD1psDATWq?=
 =?us-ascii?Q?XpKuEezn7YKVuTFVF8dN1kVpk2L3qyOOZGXcAsjGfO769enTf62byvsSMDCU?=
 =?us-ascii?Q?JnlhDYRWnqOmSuFZblgv42Ad33x6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB3877.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IoBCTkECtYMO03YrfRp4a2VU8fxQm8iuCC1FC8u0nxJa+9cqh64+SENV9Bh8?=
 =?us-ascii?Q?oQ+U0st4g93dcNG+Afd156DfmBymoqFpvxxFngRW/zegym08295bCR0r8cj3?=
 =?us-ascii?Q?nB4wCdiMt1H3+xSb9IxqhHOxVI5M/En9PAxzNIvQmmvuGnlyqVr5+EqAPGqO?=
 =?us-ascii?Q?dONmHzxE4LUxbxqlWRsxvlrRklbXxxNHQQeTWG0TgBPfYC1OvhrFEZltIiIH?=
 =?us-ascii?Q?Vovs4BU3+9qsKHc5yedtd0LQVorh1kRKaUyGaIYiHxTPdUNsBvpgwxvjnecJ?=
 =?us-ascii?Q?d2kr15g/QoGVmpAGeehefccddcVBOW6j8IpTpFoT4XohnuCv4uXDEeDOOnYM?=
 =?us-ascii?Q?A9RV4hOQfVir0F1zSINqpkdMkx9+asmV0yHvrqs5sr6Cbsp0s5YQRplXbLDS?=
 =?us-ascii?Q?gAYX5XAubjgPR59/X1CooShPXoi9ghz8qyawWMYOSSut/kcx+oadovo2SstG?=
 =?us-ascii?Q?eHPnmVNO8Z9oxr1VdnNs6qmnS9n+9f9rmTfPwcuOums8ATWwD8MDvC1/fxBg?=
 =?us-ascii?Q?7cqhKrCfHTJheIJqMhEt1xchsqn15z2MmfFLqSOn3nquVSFVq2hL4AQxBDz2?=
 =?us-ascii?Q?0IGU/gAVktbKXJ1vIDhvWt93GFgS9iMmQ6+Ggy2tYS8WCeqKclY+3DygbNg5?=
 =?us-ascii?Q?lf7zmA50FA+zjJZ0TbksDmiZgGoImDHsT9QcDdSLZ4G5zpzsDtXmgIbRiVaN?=
 =?us-ascii?Q?92szNTkjTeOKGslRkVq71fiYd1MD0cDVC4a9Hu3K0kP3VeOTp+2jlsBLi08I?=
 =?us-ascii?Q?sUhHdB6bom7oy0JW/7FiCfcH90Y2LQbKGBLqwv6Fj3TyXMJG1BBoi3qGea8r?=
 =?us-ascii?Q?FYhRoe8e+LDUUyZuBe3GrmDYTWTSCPgrYtHTesWLLX5Yb3DroK7bY/TaGA1B?=
 =?us-ascii?Q?dDRIW9EkhHAbYBVNDZ0PjBLMT060Vp/gnv95sdf8Jdd5sNDP0ANaJfJ3IB4y?=
 =?us-ascii?Q?ICT3MXqua6gzhFNPUilw1kCCr4Ud5M20INNpHEyG7+NbrpcjFqBGd50rgfU1?=
 =?us-ascii?Q?o9uXIVkG3y2Et7HMx2F+oRBIHewm/sbJWQyRJKXSxtDKCNbGtY4+HbxjN4Sk?=
 =?us-ascii?Q?TXVsi7Kd94raq9frPxZlZKAqSDAgLV24Jeh3BDI2ObrjS99SydXO+6jll0UY?=
 =?us-ascii?Q?pZVquTy2yp0YaNggh5F1bu1IHbW0pTXho2CLnzB2UighZQJcOgWgHwHRuajD?=
 =?us-ascii?Q?UsiRQPBZNOLlSL7fJ/cw5WtOhGwocPk/u5tY37cLwq+L0MIZun9RvyQVejp8?=
 =?us-ascii?Q?rAjRafsTwcv1yBkASPoHZEiJRLY65LOXcYuQ38m4XG5yWdG9BXv6nkx8TN0G?=
 =?us-ascii?Q?wBQ2Lj1WYP0u3xqb3NHo1EF/KfrINet33qAA/f6DgP6Wk6nDqxO8IfQhxHd5?=
 =?us-ascii?Q?5/sdXuE17LdfA1gnrrSYRnRhHBQRsxwTOijkI4HEuLU5FuFDnIQSMo7Ud6/q?=
 =?us-ascii?Q?CCpkOuDCRCZYANYE4jliL387NXeCnLtXO2GXHHQJjuQWQvU2+levdRer/c1q?=
 =?us-ascii?Q?DNHYHQ02u+8/LG2jjnmUoAybXvaV4bg/tVg/o/kNnAPh+pF2AL34yk+Z0m4+?=
 =?us-ascii?Q?49STmeaFuISXIfA4E5qTlhwoSp5+EXNEMFVIourkuY0vEBh8cwf59BL5sgsu?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecbafd6-2008-48c2-f789-08dd60676b89
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3877.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 06:39:06.0053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OncI01KHFvw3zBAM7jt0k8JHMnYYMGKEe+YuQHJ247my4mg3D3a2JCRrXrEng33e3x5qdpzqai1V9VYN6+NIQT0qmVvca0RTmAgz3DuZWBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6049
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Introduce a new mailbox command to notify the Secure Device Manager (SDM)
on the stage of HPS code execution.

Generally, there are three main code execution stages: First Stage Boot
Loader (FSBL) which is U-Boot SPL, Second Stage Boot Loader (SSBL) which
is U-Boot, and the Operating System (OS) which is Linux.

This enables the user to query the SDM for HPS error details.

Alif Zakuan Yuslaimi (2):
  arm: socfpga: mailbox: Notify SDM on HPS code execution stages
  arm: socfpga: spl: Notify SDM on FSBL execution

 arch/arm/mach-socfpga/include/mach/mailbox_s10.h |  4 ++++
 arch/arm/mach-socfpga/mailbox_s10.c              | 12 ++++++++++++
 arch/arm/mach-socfpga/spl_agilex.c               |  6 ++++--
 arch/arm/mach-socfpga/spl_agilex5.c              |  6 ++++--
 arch/arm/mach-socfpga/spl_n5x.c                  |  6 ++++--
 arch/arm/mach-socfpga/spl_s10.c                  |  6 ++++--
 6 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.25.1

