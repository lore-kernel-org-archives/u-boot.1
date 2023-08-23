Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE3FEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 03:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9E986434;
	Wed, 23 Aug 2023 05:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="mraektMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1715864B8; Wed, 23 Aug 2023 05:23:12 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01olkn20803.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::803])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90D2833DB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 05:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltdpAp/+cuiR30xNSKvpaoti1BrItskgBYVKS7OupqEqlmV1D5molaOa98XTRnWKxte+Pallyd+ixtcBGW5OAA43wvg4l0Rq2S4TU+lzvyBDgIKlP2ZxJrqzKptFZgAjN7SVFDG2/70I5pCy0qmP/ZYXKlm1hg5I1PTPwRPD5lG42FKu8K6LS76o1wXAQJ7iF0bxEe484v5MgUitV3T55QnGfseKufPLWuLrz1VY17+qjN2JKOG/ffgJ2GYGUZWU8pHKK7JbpNZH9nweknHm/5As7CB+RqpQo3SS12U6S5X68Ry2JLpo7BsHORiQX9TUZDGMjw+iXqK5EpZQjQIp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOnWvr/D7kr1r66QElcZNdcjb/bJLJCdd8ePJie5wSU=;
 b=UNgbSufK2iibybvPIKywHeLYa9t07XLfxzsq606lSYWxCJjokaAwWX4j90uf3z5b2+8JKGMtXXB/74XhnabMaU/OpUBfGHKm4AAv2WsvWlGVwSK6igvfkotRz5LiyN6P6KGqTyb8CUqzVDQMUluZWFTUqtIaU5mFKQ8RTcUZlWwJvG2qPBQqAdAomuVII8+x6QT8Y+EvPGrMyoXS8Yjl5O+o/MQc58Af4Kx+EKJ3Or1Od7ATeO6kcp7QJz2CUhrSMk5+wRxAIOXFNaIT5cf9NZRQ6kxZb8kMBNbAbSShcN9zSfxcPIfrQWEoofMOTGqNKCtZBYqGPd2mmlV9rWUstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOnWvr/D7kr1r66QElcZNdcjb/bJLJCdd8ePJie5wSU=;
 b=mraektMAoGgEkz0U9WzkujdKnNQVo57FrI2moz6Xm5Dpgz6FJQGZuoB6ywfOx9pKFphBvJi9A0MnJJ3kIM7upMsBAgZszbFLR4EwSmS2mcpBufZrwuf3aFKWpuPTUL08HQD11ozePAasLOk2HDLDA9wuUV4zO1KT6s9psb8h+PV6hN9j1S6kClikFo5Z4+Uqquy6JP1w7ZArQKynw9F9QHzsNcWL/oB+fzhBer1/WuLlZp+rLUJbfIBzIc8v6QXRf8ZDWOYUtr3+fSyOl5vg03phjlBQSG24T1GBj/H42NK7VxEqiQ+Ce2QVDFWmhdxsgMYQt50dQrVxLn++uDd7EA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3125.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Wed, 23 Aug
 2023 03:23:03 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.015; Wed, 23 Aug 2023
 03:23:03 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, sjg@chromium.org,
 andre.przywara@arm.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, xypron.glpk@gmx.de, jbx6244@gmail.com,
 hai.pham.ud@renesas.com, ganboing@gmail.com, bmeng@tinylab.org,
 yanhong.wang@starfivetech.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v5 1/3] Kconfig: Add SPL_SYS_MALLOC_CLEAR_ON_INIT
Date: Wed, 23 Aug 2023 11:21:04 +0800
Message-ID: <TY3P286MB2611136D3ECB23E5003256A4981CA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0.windows.1
In-Reply-To: <20230823032107.1792-1-wiagn233@outlook.com>
References: <20230823032107.1792-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [51rCeW6w2ybGJqXBFPmAgaj7Q+Cz7W5vhV7vOTxlecThiOzmJlJloqWIGpsvPym8]
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230823032107.1792-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3125:EE_
X-MS-Office365-Filtering-Correlation-Id: af8698ae-e014-4714-fe4d-08dba38842b2
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWiCif6GDuV3ScvVn8CDwm+8lU1G1qo03AZh6Yv76g9twEXU7AAHXXWBOhH8ALCOPgUbdcEZu671vVUfxem4HaGLKd1KpKizPgcFT2CLn+wX73G6oWif9HvnHmt29Rh8KYyGUF6Qejp0TCJ+c1o0vg25oGYKRCUKnTjamDDeYEqfUoya03ia61N8c4xhFf1qVODbD4HzTqDYSxSG6do+7dbKzaNg0987EFqPxTYzOFWlv30gHlJEdjPxWycbDpb/CdI4BDOa5BN1GW1l8ENGJQBJLV2ulM4F0nrp4+FUzD7XsI+EQSS6TNeFe0RAeXSPspklVblRBFccCmL6ke5/ZpPjMZWApVV3AlnSVJ/V38vSoT8tcVUaNGf+QRpfVK8xfd3okphbUq67qaIPLqMfKYn4FqTKA0niTvzOf7ljxrs7wAf8kWtXWxJMPcz8H8qCp9h2F1yQv0ALMzb0eGeC9kOCVO35trl4ZsHGhRCXHJDK8w0qNaOY6+do5Sswv8FnVAsjgye70c8A3cG2b1whtoegQSkX7mZ5dfURCkq9eI025+JC7Z5KQlN1OcMlNX8kpVnLsLGnvV3djp23c0w05JTSnrf2Iab9zno7S0WJtsfM5sQZIuxkPArvTudOnnZryK11yqHi32m+4gV2qFicunzy4FTa1lrN3PjuGt3Q0uDmvyf9fiGETIeH2G/J6WwR8FLMFhwVYFPX+UaN6iQNir5Dzy+NjmaoSTzPiRn1LsnCqMFm5I3iKV5/h6zrJ8cCc6aP39DYtAL8sUbkew0E+KP0SJ8NZTddR0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgEd3LdW2/45gGcJEV8LofD4al4ezO6ACqk+eRmdu5iuX8ZC763QogQda7tpS+Uu86sU1Mn2OHxPP/YTPZFOWqPYLEbGh9y8a47/4wE4spbLGivfTauzTT5u+cdYlZhpB6AOjgLn2MG4XO1KZ0eFErMQs8y/OiSxE8+7WXJcBbHFklQHa/sLa7ubGBGqSj+Pi0n8Y2q8KxqaioWzUfutxBGo2NmPrdYndEpK5jFGS8XX7wNWTq8grd1TG86kKzhwGp3eQhH2DpYC0WRp22OKYisQY+rCe+odEKoj7gVuI+ad02cB88RpzfY4HJwxdSQooAlGeTnYRd+53RHFh+svblXeg/olya6LxU892OxF+cvwBkxa1yeE3if1t3jOsWpo7L2tQ2CHes2/wq/KRWkW9FglpIXyhY0hXbTn8/3sUxrp1v9NaYouZzsBN1pvFO5MmSA96AWA+1nixu6cgrJkkUHeyWA5W2jn0BDzDdGa/0jMGjZkrolvLRMwlaNctMqWhnqKRysE2bmAXDLzkOqTtORxgE6axTRGhv/FpV5ZsjivOQmJGwVnvPzODRKq+cJcpVviaM7LeIfdGFx0UGWB2rWC0b2+9EtvCiNSv0ALNzSH1+HuaNsIdskashoe4OzL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1J2HHEDRLSZEH5CLXlD0FHBQcS1NJ9+Yu6evZozLAVIt1uEcSj1zZ+nDUuS0?=
 =?us-ascii?Q?fS15jBuwSTu8PfVB38w/iMKlW/DvCxEOEozx5d++SlHJmzO8XtV3qy6Ubvwt?=
 =?us-ascii?Q?bTt9z/a9LV3eP++/Rnve0AstKEX+Kp9ZfFFPDaSEJj0t0Teq9a/4ZYKwM4qF?=
 =?us-ascii?Q?jjo8P/cHfwvOyHCwP4XZYE8OplX+LrLzDxvbtgLLAdSdZOvx8VvS6jC4+A9b?=
 =?us-ascii?Q?7L0V2HKJxpHOiyOxCgf17AbWHMZO6Bkp7kAdpAGhfm5JZbizH7FOZMYnlrGU?=
 =?us-ascii?Q?GmGU99cH8GmUu6YltLkvmgOZ1eInl5DKmzy6iRIgqPvNSsuV/p34u8UQT1cI?=
 =?us-ascii?Q?j9Z9I1RxoX0Se5jCmRm/ev54+Ha/lZYzcGdAfca/0fMu08Ltxnza7hzXZT+U?=
 =?us-ascii?Q?yiA9FiQSHWmn+F5Prf+v1QAj7fRhQyUEbCS6vlOT3cjZI4bzH4rmQ7Q4v+Td?=
 =?us-ascii?Q?2ZjDRmf5kRpst1h9RhizW1f1phDdFP7uEH4BOSMQ38uOT1xFBuqng/PInSNd?=
 =?us-ascii?Q?m2r6LNwDOoMMxuwwZS7PgtDgFnEgHnaHcVcaXcIEJxu0WessmqmiBs18yWgy?=
 =?us-ascii?Q?ddnQTDJ1+ky7lIguaSKG1k6yKuDhTKnv1GDvd7ayTwGmCVeGU034MlaFNfsf?=
 =?us-ascii?Q?uJCr5Ug6pYAo7tCXVJ8uluSpXQ843QFx4odwL5jqtbub2YFzwZuuoVaOtfmT?=
 =?us-ascii?Q?YDfkdvqUE3CZPDPPqS4SHgFPQoRkW+uZmLaKVYR2/HF0d2PVyDakAxUWvWFv?=
 =?us-ascii?Q?mwtJQzCkTQchBCm3qHewNDIgJ1eRbqkmBiTCQxayuFhBLfUOXnbt2kT6o97G?=
 =?us-ascii?Q?EjOhYkKDGEtDZAI0/b9qgDlhfBf2ow9oJS+uw+iHwwET2ec6vftRVefU4DD7?=
 =?us-ascii?Q?qogZdVF9xUooWGRrrb4wo+e0uzRWg/OzA/YEae29oREoXs85fjoPYlNTS78S?=
 =?us-ascii?Q?yGtI7LW0ahc0i8cG+OvpmrQOTAC0jWtURXjQuv5vpoYhaYCev6chT21EeN14?=
 =?us-ascii?Q?WsKMI1MvLBB7Dc6xtGupKO5UBv4vmOyHHil0qwybpIW7sD0qJcN1kGsUQMk5?=
 =?us-ascii?Q?Av05siS6gVuUMtlS1axovonQW48WyKCaK8dGEwp3sz4hLcbb5Q7uwYHPJWEE?=
 =?us-ascii?Q?/JQ40dkWksikoK+GWaIh17lu0n03Dzp9/9ndlQYD38U+XMA+jKJtMhgP6WSm?=
 =?us-ascii?Q?CDuTQIt3Mp8SBmN7MExYmibAKYY7U0pQmjssMmX13d49JagIJKwFypxp2Y2E?=
 =?us-ascii?Q?nceZa1k7nXHOVetjr5XFm3p4uLmmH0NHVKZDdGoWyw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8698ae-e014-4714-fe4d-08dba38842b2
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 03:23:03.8046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3125
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

Add SPL version of SYS_MALLOC_CLEAR_ON_INIT, this would help devices
that need to clear ram before use to work correctly.

Signed-off-by: Bo Gan <ganboing@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Kconfig b/Kconfig
index 91170bf8d2..588acbaf9b 100644
--- a/Kconfig
+++ b/Kconfig
@@ -372,6 +372,17 @@ if EXPERT
 	  When disabling this, please check if malloc calls, maybe
 	  should be replaced by calloc - if one expects zeroed memory.
 
+	config SPL_SYS_MALLOC_CLEAR_ON_INIT
+	bool "Init with zeros the memory reserved for malloc (slow) in SPL"
+	depends on SPL
+	default SYS_MALLOC_CLEAR_ON_INIT
+	help
+	  Same as SYS_MALLOC_CLEAR_ON_INIT, but for SPL. It's possible to
+	  Enable it without SYS_MALLOC_CLEAR_ON_INIT. It's useful for boards
+	  that must have particular memory regions zero'ed before first use.
+	  If SYS_SPL_MALLOC_START is configured to be in such region, this
+	  option should be enabled.
+
 config SYS_MALLOC_DEFAULT_TO_INIT
 	bool "Default malloc to init while reserving the memory for it"
 	help
-- 
2.38.1.windows.1

