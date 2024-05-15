Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC24FC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 07:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519B688229;
	Wed, 15 May 2024 09:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="aEhiW0oX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C6088179; Wed, 15 May 2024 09:36:27 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA26188202
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 09:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAkuArVbnnqR7sn2jQrsOMtMS4yOqqLUxSWE6/Xf9FtL5dKc5mvCkl6ClhRj/uw3hghZGfc9nBTL3N2cMsc5IQBbhR7bJFl3EjImT+N65G2y9wIjBh7/0RiThTzdL8NVh74NT6TVh2exUY3jnsHN45KE9Z2bIka0YtkQblHz9zaRd7HionniWIkIoWhE6E/707xo8JTZo6Nh9fh7UDxUGZqvQ2ZD+iNSnx8iOiNdnRbIXQ/0gJWo6WxsJUb1n+0XtbBwEwYyhEswspfPgJZcECSNk8WkBTLs5dcoN3/KT3XfX4oF4wli/nRFcmXRAhOcORVW5loWGhstK2yMsBsw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36wbWGv4MBtZLWbSxvGFOkm78pCyhxiWfFB1+61V23k=;
 b=C16V+493vfDclorBZLm4xyKjqAkV6MNzDWbC7uugKsu9RvYvlx5CI19zJwtYmXapP1FmVzQHwVIApaIF+OJewuRK79vyhJnqMLV/uBWEc5Ajt8epuopqSpy+Pql344/PDiEViCNdsKyRNn+qn0RI5kkCuVQ1laS5Sy9kStG6QVNvX3CN06KTs0lElsozSuTVLqtSEl90o9zmLM5KfYcFR7r2fSfquGR1tj1JM3rtkGhhKHYKs75k9MOzBmmW8nfCBvgqWL5NWMbUoHbzjLJh1U56Tllyp9dASpTS/DAEfagdyqHvYX+PkpEdo6yT8uvccpKzAKDRpwu3Oavd4i+uDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36wbWGv4MBtZLWbSxvGFOkm78pCyhxiWfFB1+61V23k=;
 b=aEhiW0oXpmiU+blwzhABtft3FbClF5Iq4kaxaIB9jxtsOEimlNPZfEdanynSi3EVPWL7Pi1kKSmCqT+FVNope/xmuayIGkqvDplm4b/6217ixlH/3qq8Yw9lgN9Phdq8PFTLzK4V84omxAmt8wPLHyhWwo0W8Hu1S8PDXS3KjvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA1PR10MB8919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:36:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 07:36:23 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/2] scripts/setlocalversion sync with linux 6.9
Date: Wed, 15 May 2024 09:36:10 +0200
Message-Id: <20240515073612.1511149-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA1PR10MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f7bcc8-2722-4e1c-e744-08dc74b1b841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mNp3NHFJ/cVe+4GaZ2xlkwn8GBgNFOVTo43rPQhrzgpkETJ2m0DYZd0gV3WY?=
 =?us-ascii?Q?nxmKcqbcuo/3Gvkfs8JnU4AtNFrvULl9a8F+4zJgKbAJnXcZB0blFwUXLql0?=
 =?us-ascii?Q?E0m3ZcSZ1RqwdEp11ZR9VTJoMHkZk+LB03RxqLfN1sbH9tjvhCyy0SWCis4E?=
 =?us-ascii?Q?HCAQ1Qkp4L+8IqjMYFDoOJKpo5Zh0TxuuMsbVmwBV4qZ78QVE9QqE5jnHWQi?=
 =?us-ascii?Q?fg8X6M2X0zVtDAvZbBlygYt4kYyWDkxO8ZtZQDNj8+GDFI7IkaY9t2rPEjI3?=
 =?us-ascii?Q?9C8LUErLg9o2rggw6uqOVKwD9XKRKaITz0vORTurHfSvkXeayHk23wECd+U5?=
 =?us-ascii?Q?Kv09wzacCe1z2EtxdnxDvBLx1rn668ZTvDCZ5daiP9WVbp1xSS8ZNM8ucgKe?=
 =?us-ascii?Q?ewppp/VC7ltzHNmz3fDosoSgcFb0obOmFoI6A5HzTM1EDc9ryFs6Qit4j7aT?=
 =?us-ascii?Q?VRw6ONexgkKc4oZmjEr0RibRN+auqFoDHo9TduO6glyn9MJ8qZD8qGp2TGhO?=
 =?us-ascii?Q?nvfZm9WFDVO0CVmRWthNzsG/13bFfyAe0IhryUwrK9fXpbIdRzUiKnDGnJSk?=
 =?us-ascii?Q?ubXTz7jEyYXV1xF84woMhFtuI9aNnn0edb8LF1yqKBNIc3RCxDAp8cDs9/x2?=
 =?us-ascii?Q?daCVCYBEqzwCDg3qtYx6RyWOafuwWVdxVZ8bpKZu8/pM3D9JaRLg/IWIfa1e?=
 =?us-ascii?Q?qYm0+/DJKcWvj7CKtllNo390uUWIYxVr2KVSIoqj84QfWMzRhCl8UJJnWDSB?=
 =?us-ascii?Q?Bm/VaWTeGWI3LDsJjBEXpYoMgESZgihEP5AzT0vsUW7AoArsk+1aBFfXdvtk?=
 =?us-ascii?Q?uLHbqraecSF3cEIbLvr9GXphDmmnGl8fRN1cSXZiF2xxLBdQDiAhV4r63NJN?=
 =?us-ascii?Q?irABsUNjweYcvBYu5m/IjSbCjAUdSp4tnLToUeKV2tIG/qpGcmPcXCCLE4TZ?=
 =?us-ascii?Q?X8iAAysfhRQFiF8q9g9+cN5yAVT4tEeEbXJ6gX22cV5GbVOgUQmexe4B+N2K?=
 =?us-ascii?Q?yi1oZZ2nAKrYmuK+vMKLHJbR4vPYtgCV5e/9PG8czCDT4+8/dEt5cRufZyMo?=
 =?us-ascii?Q?3iZ9J2GSdZFEJIZZ7VQ1CA13PIBO0wtF6nBbvMcJ2w0dHIQBL+RyQ7gg/hfl?=
 =?us-ascii?Q?dN4ZRABuCGyzJDwQgq1FTsDLYdbpF/RoLFYaRsipt5hJr9uC/OHodubm80Aq?=
 =?us-ascii?Q?ZtyqymMt2WQpdOR8vEc4k8hM1bQToF3W3RYVywZg8bGzY5AS1KLIdRSbIqr+?=
 =?us-ascii?Q?ZyFOwqEPhGI9WNJ5FyzOlQeZkugd2OdGpeOoVUuGxUUptnXSYduE9E/MJ55r?=
 =?us-ascii?Q?PnAhiA/bk9tMiuVtmNSJdjJ6m+FML/IYlxY9bGpw+s19nQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jGZFr9anXy3O5czOdSuzZCq0fDvXyYJ0SuVYnlOu7/gqNA6MOHKlpmXWl71V?=
 =?us-ascii?Q?meMwe9CywkGEupc21IIdcI2DR7FM8dwlxaVNpfG1XWjtxJlDjEsqA3TN4s4r?=
 =?us-ascii?Q?dAOlmaYDNtiAqIHNdTVLotujRDHFl+r3EgcrCgVhd5WShgbhbds4cCWQKbbg?=
 =?us-ascii?Q?J1lhSZGvXuH+T2ZkojogCbdgluBJE6XmAs52BNf6+zf1JRX0FFKp414Uc3nd?=
 =?us-ascii?Q?XwzIhWeGEVbWnWjsuik8vI5y3v83D+n3lX1qHavQDmWkynDcXCnBwU9jPEvv?=
 =?us-ascii?Q?Fb03zAvAU+p+iNTuFkAeYWhwDabMXHASQQAFKj1vMqXLH8mpn+vPFTakOztU?=
 =?us-ascii?Q?s8xB6ESuyRK5zq/dwsBWnaDZ7L/m6pfau/yMoWBy12VGvPqBlOJS4vuVTBNs?=
 =?us-ascii?Q?J7/YORVyIpsOyGKtJ2tj9493kJfLIO4hjVkissGSs1KWNhZPQVlSyTjyzKBd?=
 =?us-ascii?Q?xp6JeYe0hHhK2pX9RgVbSKNjmFHeiSa20LVMJYf8hVa1nWYInvTGwzDRssCe?=
 =?us-ascii?Q?AomQWoyaJ51KTGh0s2jL++4xTBa6q7BHpASY/SqX7QJLWRpiG98aXYJyHuFW?=
 =?us-ascii?Q?F046Tn3PsSkdKPDkgiZltwSNVYwrmzdr1HXtHnevuN3vu/L+GiwSfknfO1rI?=
 =?us-ascii?Q?LKoOzEr/pQJsawraG7oAKOOyQsp4IMYXu4tgDe1KPgcB0ESLUQlR4tIg8Jyf?=
 =?us-ascii?Q?q6jmZZrPPz685RfCm7AMTHuxO/3LvXFvzyuroejnWZDdq8mkTvNxZNGUzQgI?=
 =?us-ascii?Q?4lpTAatvil+o4cXUhbY+YYU3mdN0pHFdBkHEsjAg18eo9rapHPd5ii2azeIz?=
 =?us-ascii?Q?iHchn5fmq5pWrVDHkOpaGSwku1gYsw2zwCgq/fNhOfHxYou+PGYlP6A8HC35?=
 =?us-ascii?Q?ISgYXNSKCTu3whfp7ch5vEGyPsV24yZirtBZrL0w7bGknY0m5cXgWoLF0Tu1?=
 =?us-ascii?Q?Jry7LI2kjdI+/9w8WMWrIRtg9lZ75EjQZrYlCq16dYkoaVDHpd8dewgjEFIM?=
 =?us-ascii?Q?MqsNmeOMMHL9q1Iq137U/ESMXJzRqMXH4gvAkcdD3ozrXHpZSXWfAmSK0Lpx?=
 =?us-ascii?Q?Vd696z7laCGIsabyKjxHatlow49SvNhUfY+rOCWhmRV9QW3izorhMpc++WcF?=
 =?us-ascii?Q?JMFEzeQ1Zm0g3zSWBXoqnJv9l2bG5++VmLDYOv7qqteDKwmkrTaPPS8lKYle?=
 =?us-ascii?Q?3sC8vj6d589dRWz+x5WPiyUkvmPssuy0x2assFagb3C30hrM3ihdqw6uMKV3?=
 =?us-ascii?Q?Tugl7aqSZH8Hx5z69KjznFimW07j9ibT+ef31j50m+qg42zsBUz8UWWoGqjL?=
 =?us-ascii?Q?4IlJxCJPbcyi0y/Iqie26tVuv4n01DsTy3VnnYzg+NOYOiviDS8u5OX80dni?=
 =?us-ascii?Q?s6Nn0rx4k9qnwL/kg9ft4vGRey9iYxJrtOdiWiFfbPkI13PyGhL9eDUvm9PY?=
 =?us-ascii?Q?g9eTzUjX7FsGL71c+nztS/m6mrlQGYv2MOVw9O9/y6l7K4vYum8b6yONsYs0?=
 =?us-ascii?Q?VpCF330GQEPvn2NUYRkHVe+Z7CoRAueGHpA9XHMuNYyRi0PFo7xNkV7OxbxI?=
 =?us-ascii?Q?5ADr7lXIlIOn7mHwYAJ0gmv42Pb3bBCyYNO1Du7KrPlZ7TJRSzHeGy2w/MSy?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f7bcc8-2722-4e1c-e744-08dc74b1b841
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 07:36:23.1431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGtq6bu1DLcBHg+re/1e4/jeGsONwAWWCin2H8nRYx9e1r387xIqdpPkpveVhthva7oUZeIPSwEYSOo7mKNvAmO2xKGvt0/HjCRS7RaXGKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8919
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

The first commit is trivial cleanup. The second syncs
scripts/setlocalversion with linux 6.9, with just a one-line change on
top to account for a Kbuild change that U-Boot has not yet adopted.

Rasmus Villemoes (2):
  Makefile: refactor ubootrelease target
  scripts/setlocalversion: sync with linux v6.9

 Makefile                |   7 +-
 scripts/setlocalversion | 226 ++++++++++++++++++++--------------------
 2 files changed, 117 insertions(+), 116 deletions(-)

-- 
2.40.1.1.g1c60b9335d

