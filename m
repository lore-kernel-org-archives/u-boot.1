Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6CAC5AC9E
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 224B880F87;
	Thu,  6 Aug 2026 23:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GShv86vc45CU; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77DC080FA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059895;
	bh=yidl/wJ6/ln15iLNMYJP5tfXRESOsNcz5kHoDTrD8p0=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QKX4S2/sePhVKJl/rQGIg+IBvPYvO0FYvYnSqzqLHHJZ8BsYyDFJJBOZ3iE6cyQWa
	 XO+BXfAIyWuKzrsLp4zGlWWdDnso55+U2eWFJcOiacxwqf3CEPq7Dx5VcezXXOM70i
	 oDI9RnhXyPxlJLGaxLnj47yQgtznmAn+tQoyAJLwmS/Bi51QcEe80PYu3mHuMsWbq4
	 VbJ2OI1oQtIzlcN4QFfcsoAFHgvG5TwIvFc+zUbKXZWCtbT0I0aPQmB7PjK7B/IQzX
	 kWLJkNOIM4t/Mwk+UoAuB6AvA0UFTHm4YmW25gD29rPWeKP1/Eci+jNi0BncR8Knp0
	 4QZvtVZLlnwgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77DC080FA2;
	Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9E7223F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B9594090A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXgzy5U7cO2h for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9B33840903
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B33840903
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B33840903
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuV5Njt0iQHvZZi9VHpvZMBXb57tGaEh662ZsM0j+gdIEeex6xCbKi+4YjV98hq4lEJ8EFXKGbYPu9wvmRuLglvOuPjcMOAeM/EDGnKZiXlY2VUoAkyTCvWsKwmUnNI4MEEVN7jKrs07A5HRzlvZ9aGyB20ncJpTVIwyAV+f5qQMYr+ri7WmI6xxBoEY6mErMNHG6GDMApDci2JeY8dflOqm4I83RHb15vZNuY3EwiB/rZXOOGpPvM3Lde6kfXQlBbRnTOvKaJhr3XtiPrHgDb8iXyAY/ZBKMon9CCoWDg6TTXiuLwdveYvB2uSAjYc6vcY/jzJLC4ZLWcvPzPYrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yidl/wJ6/ln15iLNMYJP5tfXRESOsNcz5kHoDTrD8p0=;
 b=Uiafa22s3CTj3EN75OVBHJHi19wPBoD7A6MrxTVhXjRqsL55/3CP24UQ+FPvvT+qxGazr/ZzerVusihZFKbsM9wHbVq7aLfTvFZt6M8hbk0WT/0LAh3ui415eoCpvvZm1+t9PwvYTdUSvPbZoswdrdGdhJeVd1sG6T0aaDyPtdrXdHbQGDcwOai1jP5XdPdhDPVK/TPV3rz3mBdKxPvZgnFZ2YzeFhcr47s3s8+g/k0aLM5rdADLKFOW5jfMtB9AISvzXnpVteDtXPuJNO7s9tmV9/+lSkR2FiSJ7okzxGlp+Q80LAAhD4hHDde/sLxf2IWp+erHLgJ/1eLXS26XQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:43 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:43 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 03/16] dt-bindings: clock: airoha: Document support for AN7583
 clock
Date: Fri,  7 Aug 2026 02:44:19 +0300
Message-ID: <20260806234432.4098414-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd7b830-a3b4-4957-ecb0-08def414b095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: y7B9xmDcUwTsTA6GsGYOdwwS1FZvKMbfr5FJIcX8JXKjlITGuO9nlsB+oe1dcVaIS37Qz6Oj+3wBlkuuasRxRKYztyG0ktbCPHS8K74m8nzTnukHKxqSRwan+fReSaH0OT/0dpyPDQm7buGz41pB0ZcHX2Pgvo4OKjp6mMYDoa+b651wd9Vrqb8XN8pinWCNcC0uYHCPpeGyGqsC4GJJvFYYxmHeM9JGVoCnPEXBpIqjs7uIjpQpPW8yNe/bUGXPBTDnDDTMtVD5zlMZfIHnWKWLHgKsBIFK784MLegpEfepcVIOVEsQbaj/qYpO/m6886VJtUbcxnAnHsBmmdSyOvXi+WTGN/FJgsmEKvyr2jYp6nQ3Q6uhWJZD12svkI0U6qS9LTaIIs9UXTGrflRmjqonCF/oVfzzaZ81TBYZJjlQ8H1VJjyo/Tr2paNoiAQG+5Iob2RgorBRvaXb2/1F6w15SZKVY8bAzWYqS8DzO6dL7tJF7x9DUaUhVxocFpcAl6F73BBNoZJR1EkgmXThFf2SJj4gJ/PF3RA8T5t1ZffQGO9JoblvW76Qy+SkXi47YpE7FeAH3Vqc0fV80+tt+NX3CrQwmDWV0Bqw85jMaYUUTVZ3ZtivwgL3RaoVtpS07+11m28wEWXZ3WbY5QFGSHFxNiPL/k8/Kbm2YqnQhkLvl8PzXwBr/566JGxFW9emkWRwvvMh1bipEKh3OXIeIC8FQTjryd9NT7lJ5gJQ8dQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjAXdk10ARzElOu/MLEV8b8LMMuRFa9Zv3GS8bVYAUIOPcM5PG3F1iXLvRpC?=
 =?us-ascii?Q?hiG0yGtwWe/da4Iv2O9lPblC6FpgP7db6ubX8hhfEauziTborENHKqBZ5eHQ?=
 =?us-ascii?Q?p9E5PKdvTr+2fBZWEJQFn9nN43oKVQHQSVsrFc70jZxC6hxR1WcHJbHiOWQn?=
 =?us-ascii?Q?Ft8YsdI4/VhvBYbGIUuOcWNKbBDNnjPfvm/RY/nhenPy5CNFORLt6kuLTUVW?=
 =?us-ascii?Q?i45SbR5voDyoK3cqxRfvC5gs9R1A/RkIZ4et7krKlzsIdJqOiGJkd5HiRv3d?=
 =?us-ascii?Q?ViMwXXEtD4egeyXi0Z+xqmavqw4N1gPyz9fh/kJW30Z4tpmzepaFgbkZAgw2?=
 =?us-ascii?Q?OQqHZNbBJRKmmWsKvY80O4CPxcvVPKhFslBcSq7CD2NxSuTkCYnKDJRxHZBc?=
 =?us-ascii?Q?C10vib0pMDB5I7L0dwvp16QJ9SZ49J2CGJ5Q2geb1LXiIzRQf4JK8TNneg1/?=
 =?us-ascii?Q?IHPa6+VgqgFgK03JGBV53ON7k98jx9Z5zdHsIG1HJxN84EPbZLh1i98SISBf?=
 =?us-ascii?Q?zIqdeFgCM8ak7wa45MT7DT4FG+QHRdFzjY3HNiu7b0mMHEnq9M4EvKbi4e2s?=
 =?us-ascii?Q?vGOLS4nmdwOsXf83CNx+sb678k4/qV+M0ed69Fai5BMNkiRtjU1PtTu/tvcc?=
 =?us-ascii?Q?43rLwj+FC8mDRPOiVxsd25ghp/ZuPUwnuKCBBF+0eHz0O9E1i1f2046e+Pxb?=
 =?us-ascii?Q?pzL4MSb8m+WhK7UFuLJHaTIOwfbZ4iJMhoaa0sFIL5yZsKn9/FQxbu+2uNQy?=
 =?us-ascii?Q?Cq9KsTN40V5WuPrZAB4TX/vHzIHMAL+NwshnqK6f1ehbHhbNowMHmhkbL4oa?=
 =?us-ascii?Q?zayi34xO7QCuNLUghVMiguCAZZeugdnjh4vtrOK//XZL6a02QpcYetnC3w+j?=
 =?us-ascii?Q?0MpPVAM/QmskD1boQKDa7FSRcPSf0SEvgx0Yy0UgqAhhbloVr0mAxf3W/J9M?=
 =?us-ascii?Q?Dcu4agmQ4QxwpnHOPukcuYpxt3ZjcYfsWM9v24HIB0TPgaIs4AxyEXhW05PP?=
 =?us-ascii?Q?kwnUV0LIRMM3nGP9Vd7RHvSzbFWXZ1O5tVotVadmy23X5URpapW88arvrIvp?=
 =?us-ascii?Q?cshMB9CE/VVpXjyfn8qRsdD1QssiFb7RJSDsrLxCITx/x3YJ3svYS9PVtpaC?=
 =?us-ascii?Q?fRSaR70DZ1gFQBwbDT0GXbeF5Uf5D8PZU8HbtPSDIJ/REI+LPzc3GVaWQl+X?=
 =?us-ascii?Q?ow9j5BGAiKoe55l8Ake4G+L/o6L/2AEvh3qGArJ8inVHGJnuPe32LOG3c1RO?=
 =?us-ascii?Q?U4RytqhL5rglKI+xXlpJ09oqrQD69t4q1mx5pZTsD2XfPse79B0Y+mXvyCGn?=
 =?us-ascii?Q?L84GAAbriwFCKi5dPnl86wutubhL7sTT1kZDZSrG7caJcUp2GVVUgxlt9trc?=
 =?us-ascii?Q?jN5k2Q5pp5pKpLc++NH2UUEXZq78L03aDMGXKVG9mduEPZ+eI9uk9/IOPmuo?=
 =?us-ascii?Q?vA3Xygz5BelscX62CiiOS9T6WWFC8kVpnqVxtlHeoSoINVcADk2cP7wlDgGm?=
 =?us-ascii?Q?l9ckveFK9Bnu0pdqPDOkah/Ilp9mPBNWJP5Rh3yVrE56vqzJp1F/Slp7kG9P?=
 =?us-ascii?Q?DZK9jS9MMm43E7/OVtm0oHUnPyoKaTTKNtDdJE/pP4KsUD6MZl1Ir702sWUY?=
 =?us-ascii?Q?tORDFPktQhVeAYmLimnvB1uR6zzbSgcAzGZNUz3wiof7Eg9Dgdjj6KVlGuqh?=
 =?us-ascii?Q?+ANHRUzt44ks7AZzA6+E/PgGX4ghtKIY8osb4Y/aE8K9jvcl2xjB5/4BZ6aK?=
 =?us-ascii?Q?6ieIwuKrCCnid0YJ0MsFjdBwFUGlEt8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd7b830-a3b4-4957-ecb0-08def414b095
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:43.3610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fkzxz1jn974DrMgBs2pomuQfYYygZlk7ucNeK2msZG65OcG9G3RwyCIBUg3I+BI09AzzttwnIQ7GisN6QSy6sA648pjIUuzUl6/V2S9p+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yidl/wJ6/ln15iLNMYJP5tfXRESOsNcz5kHoDTrD8p0=;
 b=xXIcRDq9P6Pfm71j0sVXO86cGzhKj2Yqe7pXcOihS2M5I9a3NB/qH5+EDEWiEHZTcivRWudeNwU9wr5GPf5BHSYy9UCoKIcn2+r/9GndcUDVlsJjzKNXIE0FickIQmVBEaX8iJ7/egip/S94Tqq1O1VZROWQjkP/jnee6qk2raNbjAvtgnoJSdDmVvCG+hAsIMmvxj4mOxCgXuRaS45cqSCHsYFiO6Skh+fL0hDLt3P3RlCyjYdG41rDbgDP/Qpg9C0WX0p5mRzH1VvmdlNpNhOpwXxnBIMzjkoSvRb7gM6TX2+9UFxCLmc9lgCiDq/wz3V8R39t5VQpb1YWmnzuqw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=xXIcRDq9
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Christian Marangi <ansuelsmth@gmail.com>

Document support for Airoha AN7583 clock. This is based on the EN7523
clock schema with the new requirement of the "airoha,chip-scu"
(previously optional for EN7581).

Add additional binding for additional clock and reset lines.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 dts/upstream/include/dt-bindings/clock/en7523-clk.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dts/upstream/include/dt-bindings/clock/en7523-clk.h b/dts/upstream/include/dt-bindings/clock/en7523-clk.h
index edfa64045f5..0fbbcb7b1b2 100644
--- a/dts/upstream/include/dt-bindings/clock/en7523-clk.h
+++ b/dts/upstream/include/dt-bindings/clock/en7523-clk.h
@@ -14,4 +14,7 @@
 
 #define EN7581_CLK_EMMC		8
 
+#define AN7583_CLK_MDIO0	9
+#define AN7583_CLK_MDIO1	10
+
 #endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
-- 
2.53.0

