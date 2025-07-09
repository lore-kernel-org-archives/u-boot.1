Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363D9C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 11:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507C98343B;
	Wed,  9 Jul 2025 13:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="F9Vr6869";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E120483443; Wed,  9 Jul 2025 13:07:59 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7501A8341A
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 13:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DC2zEONsSXK8y0ThDJB9f0PK9KCueGUoGlE5zqz/7/JZKIVuKY/5JTy4k4R5zZfJypyJ3fy/vJrlLFtUPFskDTBIFgsD1R4uXsyPlhXeH/E8jOvkLw1EmG4NuKD6SaNtCVVqkyNMy3uZJYX6srzGR4NPV6TY1qAwGFxmFJaefAj0wv/3UrLoULnFV5dNkRhh5HukSgPrngjpnydBAKixb4EePqQC61NrRIVTWcCt9Jv5zmx79gVrjjyW/Jjq9vZW72npek5LYEmsGCvNnCaBDuVgpBdk7cwUTq6PIacRG8VOHnHpUsLaBECCx1sLC1UfBWFMIGIxn6E+4qEnBfrFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hga11vrJWFv1CxwCquMqIAhTv9WfwTdWtlpl80iYcZg=;
 b=cfzDOwQPfmzS1VoKB0FAdizTRKzOjW/dcNbz2QvpzxCq49YSmIG+15dlEhrObig2L/egIomFIcghYzM9NIjDwT3m0PezkOa+XJTqN4Vsre6k/a+TWYd8xFS1LGH4CFFKvTo2OmTGnEAGxPRrnB7kpNdYL+oXB0Njx+xyr9RRd8ujyD9XhI1XE1WPXYzW4kdfLC56lSeg1BuAb2JYxYukyz4L4sqBbMV2nOF/fyVLSKvmtPF8p8+Lt/C57vkfd7AjyM6CbPRgae5YtzK4OF5Jy4VBLTeFNGpmwSB73MqCPbFvcrfFtbVfH9FI5mC6X1ZBeB2Uq8Xzyzj4dA/JrHTPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hga11vrJWFv1CxwCquMqIAhTv9WfwTdWtlpl80iYcZg=;
 b=F9Vr6869TFaZrN/gBwvez0Ia93kbyGBFKr2XsCJtKfMXV51S+ISXDAARAb6YjpfutfbeLFMTw7f2S0wXyeUu8XikWRxkbtupbooWxVrb9JNqqhJrEtN2TNqCWBWlh8T2UKk5Izl+9iaRLwpo6GxfcYh/87YpNhpEvGmICMfjMEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM7PR10MB3205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 11:07:54 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Wed, 9 Jul 2025
 11:07:54 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Andrew Davis <afd@ti.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] arm: dts: am335x-evm: remove duplicate chosen node
Date: Wed,  9 Jul 2025 13:07:51 +0200
Message-ID: <20250709110751.663614-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0021.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::26) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM7PR10MB3205:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9f23aa-b8d1-4029-e7b1-08ddbed8da3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uMnfhuSRojDeQnTXDml8lzY/Ff0GxiZ3INRx8VzSD9n9XZOQy4CgpnacxmVI?=
 =?us-ascii?Q?IqqKjPEXRkYiaPdnPhKgQqhDj7dFCgcY9UAH4VL+PjYbVArOX62sBgvGbmr4?=
 =?us-ascii?Q?JMGLvlWU1DN+4fOKxQxGUpJZJgG2ZVbttS/4YVayj/6fJm0Bz5LgUO6CoY+q?=
 =?us-ascii?Q?cGDoTDybZWS/s80+AU+HI9ppBAd/hyZ3QPZ+qAmFQbFJ7rt8zq3PeqL8OJ5x?=
 =?us-ascii?Q?dISC8Wg+DXCvLnMCekrdm/dEKpXLIxg+t/rWPQFXVVBjybH9DI4W6sr9xfbK?=
 =?us-ascii?Q?RLtxIFT+hCY/GaaBNqN76gNZcpTVLF2Cc87+sskzaU8lG/CGnr5nNLa8ZmvZ?=
 =?us-ascii?Q?xZ2b5y95/M4QZ2lsV54nBtBvCsZGwEwgmxE2zDswJb1WhScKaB2H9ReIv/c8?=
 =?us-ascii?Q?vDtytodMJhUlycGwtsZ0U57TgUlqoXDKeQ1Fc4qZhO6oZQBOj2VQ3PTQcyDI?=
 =?us-ascii?Q?j+/GsMBagQ2coYr/4omSU8z+WlU5OPjNuYBc20KkL16KQq2TlNm15EDIpP/z?=
 =?us-ascii?Q?PoQTMBYheLLvsEH8CX8SB5WkmFjMeL5Vmv3WN8DenyojBWlhfAblsTR1Va7A?=
 =?us-ascii?Q?grHKwgEIGAmbrngOSvWUAwsXu7PYvRiof43isNCz2iHv7SP97jZT50GsCHV8?=
 =?us-ascii?Q?RXrpbxXoly7Q9sNiIzgq48Dsgv7xCAtdOGYzbU3HvpCMTyWD/9J1wDB7aJqH?=
 =?us-ascii?Q?oO2Ks1wADraVuImDKqy/Bva5kh0lWab7ebjY7WuIgLZpbQ6ORk5zxW6bxAwR?=
 =?us-ascii?Q?h2HeC0WLnq5cHJxvZDrbDtk0YIUgi+ytZKVkeWsgzdzzUdMLiKrufoPUuIv+?=
 =?us-ascii?Q?B6S29zuwaGpXW/fYI3LuO3qB0MLwfeiYMLXLQC17TljYuqZlyY1qbkoPJtw8?=
 =?us-ascii?Q?ZB+IbJYXghQOipNnCqYjgwueVWBaNfn+Gzho26fogtVdBxGjUaKjvFUqMkvH?=
 =?us-ascii?Q?CWDxPmkQ8BQeUVohvMJ+ba6ZXm960rQXQbWT8CvJfooj2+pPB5xrpS5qimft?=
 =?us-ascii?Q?N2q/NxzObDYq9cCsz+T8m6TSwnMTpXEE7AYudn7AFw6WsfO7ERcGa1ktzEAj?=
 =?us-ascii?Q?EBChd5FRVxN7B/GZhG4MAgvmMqiM7DlfGKSL45q8saQ2nTT4AwT/aASC906e?=
 =?us-ascii?Q?P4ij12OYNRdVEjy/Dysk+OrSDNG7Azk3GiqjM0pjCBZ9ACoA0Wp8k3Gwf9Fa?=
 =?us-ascii?Q?Pj/7VuKSrNPqtWZtfLdsfzR4FkTLMZuym+qhEu5HicJj00t7ttweZRAMRhMx?=
 =?us-ascii?Q?WYQlbWEmsj8raQyH9C3ZKHBYy4yJ+LcbFSaeI90BtEtrpH+yc9lCt4p+ietn?=
 =?us-ascii?Q?oUtkMHnktr/mXo1OMhFrN4/palWV+18hT1zDS7wUCPSCVcRanjbcZUhLI+oz?=
 =?us-ascii?Q?8wUnCCpzw4VQdoD2YWB0h9Z8+UU/nzuec6hm5RjNe6I4L3EB4+OfkJLuLzAe?=
 =?us-ascii?Q?gnWFqnl9FxuyxGd+Ajj9Jzt+2I1Eg6irzcyMhN+W0Jo6JAU/HU2xeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qdqwsVioSMAOZ5pk94A+1NtVgWgC1O+9+66jabStznzg5sK6cv0IDbas8Voc?=
 =?us-ascii?Q?hAFpvDrgYoxIdMs7TDAjhtog6yh/5RpVz30mPZpO1T7kR2d3oSoLELVmcUlx?=
 =?us-ascii?Q?gU328wsSLHNlPouAz/GBoqOkj57yyljvcyca+VnlNPXwv89gwr8RR0Md9Pj8?=
 =?us-ascii?Q?sdg4yvMynf+UwuzmRsyC4GjPPsBKA9T7tqubnNbmEwrB7ajBeQl6VDuJrar0?=
 =?us-ascii?Q?zXvLf0CuDJ8R/w6etni1LlPP/BperrhAbS3e3mmGSLwVFXOADmnPDxbhdPFp?=
 =?us-ascii?Q?77yasUy8vUrYEkCR98pL+0yNALppd8bWUT4TsBT5zAb0Oeopj1ABeVYYk3Tw?=
 =?us-ascii?Q?q1u+Sq8i/hO+YdzCqfFFJMhTMK58M+CFi1vRYID3WHXvnCMaS5RwBpslDDbh?=
 =?us-ascii?Q?cESUg/qYTfpeH3wjdYTWn6DOEH2szOexuR1L6EsU0ikqFQ5flw24Hh34Plam?=
 =?us-ascii?Q?YFcg6zLv4ZC/OHjrVa9kSufwoZe7hpj0/nE4/v9VFg4zqHbh1c80KEStL5GQ?=
 =?us-ascii?Q?apph0ayMK2zKsR1fxTGxu2GD+xDQ0SnujEFyr33h3Iom2AtEmNWcr9NIZVvD?=
 =?us-ascii?Q?SFYuP68K7z65KsM4znsQN1P0AQfnSpNuSNu/TzpOYvkc353uUjmi1FpO8OOQ?=
 =?us-ascii?Q?k5DSeROOlINVpDinSKjlTRjT2uGcisoSNKTJ0J2YYcXwoLsjDPvMqmC3MxxP?=
 =?us-ascii?Q?Hz+kgvur6P1ppveBHvUR587UjjvmoZADA1jXKcquR++QaIqiZf505aCRo7X3?=
 =?us-ascii?Q?rmZRlO3prLxGP0gfbMBDm2n8cxs91mJYz7/O1p/PD+ypD60eKgef3bX5MRaR?=
 =?us-ascii?Q?kqr0ky6yBTT/6zSfwqLTmiSAAwM4ANZ69SNO8ovTSwd2qO3EbsrhHpJFt5kZ?=
 =?us-ascii?Q?r2dsMhDM3MQ+zg7Xako8Pdu3bK1Z+yKhKu83+fPxag/uOX9O1QcfD1ECEZYU?=
 =?us-ascii?Q?nnb2+FKvQ2St8i16N+QbatHP0YbY7vC1FpcO531GGvRRMt3EqcQJcVzai8AO?=
 =?us-ascii?Q?IlzraD4VzCvBhQfDuwBv8xAzm3BD7rzIbfojZFxhaa2S17dgXqZHjC+riql9?=
 =?us-ascii?Q?/tjhVogyym94HNd/ylZbXJCnQccuNNfNTFIM/iIPi4755D1bLEPL/R+Vv54n?=
 =?us-ascii?Q?yGmY1p62UDn/6TyFIYUM4+IqqpHayIhmfXGhfHqiPWxRoA5WncbqInQrBoWw?=
 =?us-ascii?Q?NgEc4ZYLM4+Dnx1sfQlK2qkXDxYA3kb7W3fdfWxCGEXtwzQxYvhdM4cSRQhb?=
 =?us-ascii?Q?6gx8K2JBG59rE8sU6/XhVgrnGJw1lZueXl5dDjJQ8x3a3xo+X1afaZ+HEy7S?=
 =?us-ascii?Q?mUMhLLF9/M9S/KgEHbzwm93njRvS4Grlc6QwVDrQTle4gPrWWllJ29dFSdTf?=
 =?us-ascii?Q?u/qpE6jMG8O/IQrVJM9bCsulHf+BsPC5H15rsRdK3T/9aK5wos9dpYqgMzMf?=
 =?us-ascii?Q?KWqdhJaq1Ab53nMO7/SXSwd0Z64pEP5i+vzUNBoIDbsjFfx3NbbbDbs8zfo0?=
 =?us-ascii?Q?4oYZzUEjVtpUQdymn61x956T9Zl1LWDzTOzBcvT/f5FeJvw1JAAKxNKXWmYg?=
 =?us-ascii?Q?YS6Ry2khRWO8PaqReZxjpON0377egcD5ocTskFyNTGrg8gK2fLbjxkk6zwKY?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9f23aa-b8d1-4029-e7b1-08ddbed8da3e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 11:07:54.2018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxHIH//tQsrN+sNF7KbiI+MLyn8SllhQTzlcRITsDsu5GbKSkh9SMNEiLMl0ozozi0v0vhz6FOJDPeDgsls7qrAsLBRc8IcEF3QMhvTUKfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3205
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

The stdout-path property is already set to this value in the other
chosen node ~15 lines above.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/am335x-evm.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/am335x-evm.dts b/arch/arm/dts/am335x-evm.dts
index 6e799621678..1b5b6270068 100644
--- a/arch/arm/dts/am335x-evm.dts
+++ b/arch/arm/dts/am335x-evm.dts
@@ -27,10 +27,6 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-	chosen {
-		stdout-path = &uart0;
-	};
-
 	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
-- 
2.50.0

