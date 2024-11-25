Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B29D3B7F7
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B401899EC;
	Mon, 25 Nov 2024 10:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="FjpXqkvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834ED899F1; Mon, 25 Nov 2024 10:33:20 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A95899BF
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi02FGZUIubWK9IPN+1B36oB0wZIXYHUdFei3Q9ge0DwgQbke5Jr3j/WQh1QYokgVUiTY46ycuMQtO7e9kmpyKv1MPWRHCDf3V51ubs8ldoFGLPNNs0bv2joXiIKB7tR7geNyfwDRNxyPh6mYnhb6rwv2RTas4svo9cCn8eHDvYwLRiLaxwF4T2j6p0siL3YXu5cD8flbiWwIkA95EgzE9eRhlkTFa5/Cs/tRyjUDN7q5NxvZttkX1ccTHwoSP2LKaj9QTsW02LIotAo5/UNe5LOyEdHZQEDgRxXvebhALDUgqeBv6+/eoo8UlIzHyBbBHXmKcRndAHFL6brSsM6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5/Bhf2Iyoqr7p8s7e+i3kbaVpFr3L5ZMLtbIM3Dba4=;
 b=QIDM8CeijUebzd5qrnSbMxSItItDFBW5WhzayebQov1IybmIv3U/xN0+NnH3wBUW5hT4Bulv8SFA9liNaFvux//M0ks3x4eTnA9QEyslTLH16TL9l7AT+2Z2/m6HdPcnVBlClBlRCIK2AlUsf6V2g56FUYem/0h1Q/EIoqBd3d2IhsbY3fh9PGUSQ0GRinRYx1QfrF1MSeCGyDcziDzUeBEGE6RV/YECSAu8Z7/eA5JhjC91WmfvIxwBwDONWLcPHAFDAI12oSwUaU8+PK0LuOL4kVAAlJsh7uCQKPolygAiWRElewqvr/QAgeInhOvfTuyKLdnNdqfvPf1OXs77mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5/Bhf2Iyoqr7p8s7e+i3kbaVpFr3L5ZMLtbIM3Dba4=;
 b=FjpXqkvKTXtky/haVoqPpzTI6GuY2Tr1XHgScmUPdz7jsk4z7c0BAqlwBL7bh0TO9xXPp5wUK9mH5nwCIwxB89Nnsww4E9r3tBs3Q/wBbq2EhoXOwPcNgY9exZhaIO+0HHE+UGxEerxU9BrM41fPLrH158+DpsuXBDlcdBFRDEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by AS8PR10MB6508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.10; Mon, 25 Nov
 2024 09:33:15 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 09:33:15 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] arm: dts: socfpga: remove spurious execute permission from dt
 files
Date: Mon, 25 Nov 2024 10:33:22 +0100
Message-ID: <20241125093323.1135253-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::20) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|AS8PR10MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f9142c-8283-4c37-a0a5-08dd0d343039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?duRdF4ZuM3f2sdi7S0I3+K+p2Od8y+UqKPcREChRCxT0b84rlkqFAxszf/w0?=
 =?us-ascii?Q?qKw916OS/Ogl/1EcbXJLjlSTzTgMSTmK/FXNbstGBdstMKZpzIJ1NGJvIeBw?=
 =?us-ascii?Q?Ofg1Z9+a1hu8BGxfubkKfAOCbnfqgXkl+eR3DDLHDY5+gNCtpgRYuowZN7So?=
 =?us-ascii?Q?R8xZoUeDzFMVAmVohZiKuw1h9HJfmIRfWLytdOPXNI1i9rzHMmNgFc+U/ZMA?=
 =?us-ascii?Q?gWP60VXKvrDkisg8PdmHnPuMeRURRqg9E0N0ryI1cyo05oR2KW54Pbg35qDV?=
 =?us-ascii?Q?NSlqizStMhHmPDJsReO9YlUA+2Sv5O3XjS9YldwUKxDVJvqECIcqa4FZYY7b?=
 =?us-ascii?Q?ZA9+4e6w4zwAIpciDGxrZxW9WzIesvsmZzSci57CXo+uOY65F0DohPTz3cUo?=
 =?us-ascii?Q?6TLEPFl/bqG/Pl4oBfk0ZSBVLqe2Z/fd4jhUneeoZypVXuaWWK2JWW2oT4Oi?=
 =?us-ascii?Q?KMQksM/inHRrpgrWg1sfIECbiiatEZN4/bt6pEtDor/mVxv8l+oFWMsEr0Yt?=
 =?us-ascii?Q?fct5lP1UlT1fW15srqj0DUX3yIhljtMZeubB4Wt/4CpqRUmgr91Q3D7He3oa?=
 =?us-ascii?Q?P3ti03iEOUsKPIVgUPo+PEgSJIAQlnxFD/cw+ZoLtnR3jqq52fzeVuVQ0dL+?=
 =?us-ascii?Q?j2ekS0+gkIQGVV2aiR0nHqG16KXrHfrcejuwAKlU74pNnLdeRMLeiTiQD6cS?=
 =?us-ascii?Q?6XWWcMfVvcygWU0+c2mxixU0e8IJhtxzmT2s63Ly4Z8MNwUpoHBJ3emfCeeB?=
 =?us-ascii?Q?Jz7quuscRowlN7KgPycUytizPrQCvJJjdOQGXtCBfIX9brnNUgkHmGH+1XRX?=
 =?us-ascii?Q?/XjUTH2Y3pEvt4HtgQmOgVrbLE3daeksAn5MHfrYM0yBYLGxOVZx59tGcenO?=
 =?us-ascii?Q?TnZ2Xx0aSK+vZBnKHDxTabC4BfYj6H23ablyvf6dHOONU8nw6dNaohPPuBth?=
 =?us-ascii?Q?urkXGNCam4RTajRbML2Ev74KlHP0sZAhVrijyFOnEljQQhvQV8OQ4bWMF1jv?=
 =?us-ascii?Q?9jvZQbQbgD1qLgx07nwP79p1lFW4W3NT70fQwkxFOr8mvSGXx8Xgf8x7lKAs?=
 =?us-ascii?Q?xvwAYbXd/eE+G9QStw46O6EWAcjYyPTcqpjoGRijU3hk6ahaPKRuifZsLABY?=
 =?us-ascii?Q?aMj3UyTIGs5OIZGLuyPlCDxTZHL+bEOdHJRVNqQUQCNLRsstkmsnx2fW92uv?=
 =?us-ascii?Q?/afnG5k2zoabF1OXM/Dre6OxKluTql+q6Krge8uy5/BzjkZvTprr81E1TAY2?=
 =?us-ascii?Q?XHhTASUH05kX9IYq2UARufQkdBY/XqWJYaFZ9AGH9Dyq/WBT1pI86a47x8yM?=
 =?us-ascii?Q?WSLoZzU/BbepUGllJE0x+uGDI5nkGLlwJ/StUmBC7VJS+sMY5y2pRkWxf/fa?=
 =?us-ascii?Q?MrGtBcIJpkrxz9gWH/XY88cG2J6tantUjA8v35TBtkf25/hy0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dBlw4THxRYh7dvEM7gNFsLxqU35syyzbXi8LPfnqM3Rol0TSIg65HYCGhIaQ?=
 =?us-ascii?Q?Xg+5CCgH/9Ok1zczTbsPiN2xMLCj1rSZxe5+l0N+v6LpJmGEMksO17y+C/4O?=
 =?us-ascii?Q?DL1T/uZQiQpcC5q1yB7vt9BV9sx24SAj0jGbostdW920p+/368O8k6INyfMb?=
 =?us-ascii?Q?6RcHg02BRb89kdIs1kBivTBQCfJWHq+QipY6HpGDKnxtN4Y3pWdZfOZttSf9?=
 =?us-ascii?Q?wsgATqnIPK2O1bYHINc4ON7n6uJlaxEXpaduVQpES7eOrRkMtqydmWhJPR1R?=
 =?us-ascii?Q?QsYWS7ThuShu9K2FJ5RDBJpbk8YUWBWYLlbRF6M7nVaOgBtWtGztnSxGvagu?=
 =?us-ascii?Q?CUJgRqYudMyBAHxIyVgJnMOLW8GoKRUD7vWl2mf15yQGaOAs1oKwAIOFuVw6?=
 =?us-ascii?Q?RdhVrIUBnVKEu2JMgZ+YGPABwZUwksGOt5AX1eJRA1gp67RZhkyzvRPP45c5?=
 =?us-ascii?Q?eRZ/qqqgFgcLL/3KqgiPx/9K878bHR3KKCilYNfDSoUVhyyVuewEZnpSPh7k?=
 =?us-ascii?Q?Q15Z0x/GLqgL7SGOUiaPaRn5LFi7S+2cN4KExHd8kcl3UpDnwhxXS6QYrn7v?=
 =?us-ascii?Q?pZ62dbgUlSy/xp1hIMmyGdE+SWCGu6a7ftjOIs57+AIWwGPMFOIr+nW6fY5V?=
 =?us-ascii?Q?EECddySayeNHsXYAib50ciND2vMPLwHtGTsEtFX61dwspDyzNplSxXtAx4SP?=
 =?us-ascii?Q?KsZ5qslsSGsQcBqwoSx8swlMKq2oDu1Lk5HJwQBMPJsDlvgg/V87fSIcg4HI?=
 =?us-ascii?Q?cHpPKV5H9coQAetlEddX8pyCoFbYduob/B2ZEE8mvpkMLV8rVuPR68jdAeZQ?=
 =?us-ascii?Q?Tiz27goh6xDtJEtEs+XAqVrUyYNtaf3zTbzHyl1b6ugiJZyTlP7fufIUazvb?=
 =?us-ascii?Q?SZYICx2ep3VvjkA0bP9dJIjcmSEztpr9+uaXQLWmprR0G3cK8gxZt58fwAb9?=
 =?us-ascii?Q?lkVfB2qgJjtansQTNBd9k+0QFbdW79QhIQwiFgDLclcuFub47aLJDLpwvuzu?=
 =?us-ascii?Q?snrs4OclPwZzAFWthwy9wscRjD1HcSKPgnLEcQPgOLpZ5OIa8OLweNidoeyX?=
 =?us-ascii?Q?Bkg9zuAPKgtbRhbDKaUQuC9wkzRIKriuElZwhrJSEI8rUUPr4rYjdTwDpIIe?=
 =?us-ascii?Q?+VOXpF/INmt6pq/WflIwLe2CcptMARQAxDF5KnDQH1DvFPvPHLb0x80d9m1O?=
 =?us-ascii?Q?O4onYgWT5XHXqd1MKypHwTfmacbU/fslwDjQIuJ559ED2LmNNx6gj92M2cZL?=
 =?us-ascii?Q?/s/mgivmQH5lGXAP+Ok+xGrS+BMeplP88pXe3bwJlTN+oE8kEvCS25W8prNB?=
 =?us-ascii?Q?A2aCfzlwUpOV1dGJoo5L/77pzTFsMurVPpl4w5V0eOmRfG+PBbVG+rfu+JJi?=
 =?us-ascii?Q?WjGvAe+C9JdcWqSP2JFcYm93kvRbro2HxhgADzHEMlRplHgL8OFJBr7bbUcZ?=
 =?us-ascii?Q?cpv81XZVT/29iyohCw6EijAJcC57r/nlEPWu87UotCN1bhqGnUTfIBnfK0BU?=
 =?us-ascii?Q?i4llevK6qku4RT28g93HgsRkftPglYOQintdbKSVnlzYjB8BsInZPw+3h9EO?=
 =?us-ascii?Q?DJYeCIxDmZbC7P4rbjKmcNZ/aelyaZK+6/ZcAErF0qvUaeUvn9jYVT8yGSGQ?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f9142c-8283-4c37-a0a5-08dd0d343039
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:33:15.5846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QAvQp4FL1KHl69za1XtJcJqLHaCmKtNSAcBe6qvCr9Nz4Lz3XLyXbZChdop1zsgC6DtCKpZivZTMeq8Du/CN96ckc4OE/geVrLqY4p9//o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6508
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

It doesn't make sense for these files to have the x bit set. It was,
probably accidentally, added in:

Fixes: 2c494e62c31a (arm: dts: Stratix10: Add QSPI node)
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/socfpga_stratix10.dtsi              | 0
 arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi | 0
 arch/arm/dts/socfpga_stratix10_socdk.dts         | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm/dts/socfpga_stratix10.dtsi
 mode change 100755 => 100644 arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
 mode change 100755 => 100644 arch/arm/dts/socfpga_stratix10_socdk.dts

diff --git a/arch/arm/dts/socfpga_stratix10.dtsi b/arch/arm/dts/socfpga_stratix10.dtsi
old mode 100755
new mode 100644
diff --git a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
old mode 100755
new mode 100644
diff --git a/arch/arm/dts/socfpga_stratix10_socdk.dts b/arch/arm/dts/socfpga_stratix10_socdk.dts
old mode 100755
new mode 100644
-- 
2.47.0

