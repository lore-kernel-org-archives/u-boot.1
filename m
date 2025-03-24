Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6660CC3600B
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DE18186D;
	Mon, 24 Mar 2025 16:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="M82FDOV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7796A81FC0; Mon, 24 Mar 2025 09:40:04 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1CBD801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHBg0pLvfJ0XO7WKd4KARYSOZAFI3ki0thyIlqtl/W6AZpYkFY1EqwGZB+jHwC8nfNs+R2M4HV8l5GoTEpbJWRTBFhsLjH6IdngFWLU5tsTz6fDl3Tb5ezAoii1arMOoEhVd7KidFw6+qPIReYto565dYucGPRYP1k77uN/59tY8e/OrS/N6S5m/2VRrPAoNFv8nqVsBOQLqho2S3lLh4v7DMOzeVKZQtQz1GhKXASRUkEO1LBXCnhErliHNrcSUlMV22OqOkZ1/bn+xabIHKXULFGA2s5fjRrq4Wwlf6Acw5IWAwlaadfXGB9OMwLMb1yCrM7uUEjWpVXd3UP7upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fi/bIBB6MeH7+HVN/QYs/1v6cJOsHANdBAn+qsZQJ0=;
 b=PBSqyDN2oJGaLzhIHxK5C5p8o7X5dLXMLNsIl9SYqmUuBMS94kAXQohJk/e5rLYhr3dimlimt1Prht6mTZtEzN1myeZmTCKTBrR1nh+uZcrExACQTD8xts44ead+2UjxKzuWaQyQmmF6M+JdLTUeE74DngHMVPUBiprYBH6gQsVURIaMeetb56F/NHkdXDg9xHwyg1bdlp4b5Ayj2pwI6eaL1W535oj4BAaW2+sqn/1T31vvNsXCxiM/NlMV9OtmRaQlbuBSDbbKoo8IMiZh5PPdamtBGqr/MkTHE/FWnQXkO/86rwOtS3a69iV91TnlJiYKEX9u/HU9gMonEDmi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fi/bIBB6MeH7+HVN/QYs/1v6cJOsHANdBAn+qsZQJ0=;
 b=M82FDOV+GtvurtGoavpwS4SELQqMCLQtpjySnWz+Ur9+ledgxWfS7evrJHHj049+l0NDxaA//uBhtZw4sLlqXLpZzSrxIBL8h0qTg6t3rDWlV/6CWxoQfSqEaHWLg3x7sxvuI+qfoIJYH3KqDZRxMOosPeITmmPmw2TaAyZqmbAim8We662tdsEeI4rC8pKrVRmzgXuGepbhkGGJeLgAiV2FxvZzVX1ikSpidSMLNjW+X/bNwva0uyCDlxyv7Q9yCUr0kT7fZJrSeYr3EtzzMEdnUC5VUEXFi2rwTt+bDeJLKR4ObrI9sENW1WCcuPKCptzc15TjNSVdLPRNPy+VHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:39:59 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:39:59 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 01/12] drivers: i3c: Add new i3c uclass id
Date: Mon, 24 Mar 2025 16:36:53 +0800
Message-Id: <20250324083704.26259-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f44411-cde9-4ab0-e720-08dd6aaf761c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a6vf4HFxMnEmaCUimjB1l9lxR+CJTZ/l0EA12gG4CLHJv2zzRTPiyiH2Mind?=
 =?us-ascii?Q?cgmLC7QqT90sKsJn4Uhdifj9hapZw9Y6nxmQ7lT99LoyBWYx/Gp2qPFnXSuE?=
 =?us-ascii?Q?yWskoSmlbPXCTAFmLsvmxNNpmDlU9IifM3Omn0A3y1UGM86PkQMvmsspZcEE?=
 =?us-ascii?Q?PVUuT8vuIZgRRepCOB+ojdjjpuoxY5a3Pf/HmkO+9IX1VyOy3s1fbk2Ps28D?=
 =?us-ascii?Q?u6yeUyYoR68WkICIaie8TsFexCbtZWVxc1NMzKVlC8V4+1iwEX8AnfqRsmVW?=
 =?us-ascii?Q?hl0mepGtoNiaMoHHNnnN7X2OOYz8FqGhJvr6MZrApqFP/G8/qnTAcCuHXsfG?=
 =?us-ascii?Q?jPg3cEZcva60J+4oF0rWG2A3+cGb6lOcxFwo+D8qPkoXyTPWKNM4Pp/wK+D1?=
 =?us-ascii?Q?6USA19PWdoXKmn/tZ/dwZjYOOveAuswTVyENP1D/7VWE2JEy1Mr0wcfGibl2?=
 =?us-ascii?Q?SN2xo80l7kNgLDb9KxJ9LeqhM8EMLgPqjdi3iKAxQ9hCSL3SXT+Z/Uu92ISR?=
 =?us-ascii?Q?/BGOMakxAvpTPJnpzhZ87ZES53u/ziyoS6z186UAygc9UvPw1TxlkGWMTiMH?=
 =?us-ascii?Q?Mme1Scrti41b+cyoCvctOBwQP4UwvMqXTOXvjTYHcUButgXoMInR+t9jUIeJ?=
 =?us-ascii?Q?FsNguEMINBuSRqWVM9F3VTDcHetdwk7Vj5S2X+/VhlhiXAaPISXKRu+UEMmr?=
 =?us-ascii?Q?z7yWi1gp7kmiH4e9/qV7JLsQzB1z4RR1JsbrrEZnuhFNX+pt8fMgfhY6dn06?=
 =?us-ascii?Q?nRSHYuHKldviN2RTI2GWqTWtZr9lA8mxPkHQ3nbpiW099WSGORk8HMXlAVGu?=
 =?us-ascii?Q?DNvYkiKG2aK5gykUjrDVme/uSqzT8uo1NvI3ASkX4xEC4jDRWqLh+SXU7yGP?=
 =?us-ascii?Q?UYOwNSLk1bBJ1qjMVgIiRU12C1Q5hgom7Sst+3NDtfmTVbafVZNX0RJiaUGH?=
 =?us-ascii?Q?/Iln7IAusEpLwZ2Rdgvq9AA9PwG3mFTcSakXu4ZGYQ+/6hiUG1k9iu0pKh59?=
 =?us-ascii?Q?kTw8FC3EDoCAfonfBmFzuR8+O01JxMaqYZQSiXgikVi+8dPZ+X2kVT3Hw5Nw?=
 =?us-ascii?Q?hsF+MWg8Te5OtUn2/Rfp7tDx0ajbvgQGxPz7xFIahENRotuGAQX886aydNpa?=
 =?us-ascii?Q?jemGS/bzFHW5+RNRs4zC01i1nrJB2UnhgjaeO0Ca0eCKLC4XQJluwtJMdkEo?=
 =?us-ascii?Q?rzNvStnB1XYtZwpBYadCNYVeWpMwNqU40cWDBCDuFLAybgDmJSbuJRxK1B7t?=
 =?us-ascii?Q?TWEXYocexxhCIRjlBBrFZpmPtO/RE0dN/64uXsoQsWX6okoc0bs3Enp3ibrg?=
 =?us-ascii?Q?FCzQLIXqz/43rhMOnkjLngSKIstJdx0dfPrscLyhOJyZN1HH2242u/lH/Ftz?=
 =?us-ascii?Q?Nic3tVDHPDSqP6Sqlkb2Rm7xDAG5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtRtlv92yOS2I05ozewcOQ2epLAdxaabZD5pBRxKGabKPe3bRpgCpm92LMpb?=
 =?us-ascii?Q?p1J7Ndo7eKJSUJkI79pZOUaqV0J6EWA4OxdpJZyHEKIyBOeqeRmlin7TMGis?=
 =?us-ascii?Q?qVsz1LZ3e9BggLR0EXQYVFSSRFooXQBNHb+UarN7HjEt2I2R0SfQ8G6MMBsr?=
 =?us-ascii?Q?5hUkafd2b3HWEs7dLWiI0pMDI6KTD0/hYt0+t5SaCm5FMBumtYmz07AEvtwl?=
 =?us-ascii?Q?6IxIUwUCQmkIKma8a4UNvEHq82quhVpwMy5LSe4xm/8cKYK1eMETk8K9TLuW?=
 =?us-ascii?Q?oWU4BKBThIHfu2IeBAnHEKLMr2EP/4FcXuoH+GeeGcZEvwk681/vkdB0KCgQ?=
 =?us-ascii?Q?V22PlF9u34lRq40Jxf3lVAdflSwNKMA2yLEomj7zwoQFHc6JsFcw0t9HEoLs?=
 =?us-ascii?Q?cD1N1Ynn7emGDvhuk6hlTVg4kVfmkyEembz8lM9BvSZmAAHww7nTY9vnN3Cf?=
 =?us-ascii?Q?ah0wZM6i5yqO2FJXCnLDl4NA4nc7uAj/1r3SaFhKRQFG5ojL7sdTg2xneeUF?=
 =?us-ascii?Q?XK85JhJGCZMaBOwMvmo1vcDZI1fam6zbLqcp6v606/P58fUFWWBgTvc4JpbT?=
 =?us-ascii?Q?haCB7gh+cQ0tHmG5F5vcp3VloWN4lzCIqsWVykl8gX7TQ/RyBmVP2QEIO/t5?=
 =?us-ascii?Q?7wkEUw+sQvBJLhduy2C9aPkKqr4vdpo24t5Llh53wNmYMplP3SXYN5CDOYkd?=
 =?us-ascii?Q?CKb2BZZjvcmP5f6u0fkfIuPp0v5IXg80MXwW4yntuSsaJUWvqDjA1ID8mKyC?=
 =?us-ascii?Q?Z2lH4f2x5kzOnzxX2HAqDNLt2RmY80g5lqRBGMs5egBeuNVeOq+loNkjc0QF?=
 =?us-ascii?Q?AYhXY8t91Ss+g+LYurfcJp8vWjzburFO52GEUx686cSvGkWqBY/U0yjUNE0D?=
 =?us-ascii?Q?sCwTJtl+s+oPJnB8Rxzcn446fahG8w4uom6XHiQ+bKNU2E2zoaKAAenBN+yj?=
 =?us-ascii?Q?4qV3O5j3f5k8fwlziDY8jqPcqLLJCapxfUrUVTHt7IvFbsQ4vAW86/FPZ7Te?=
 =?us-ascii?Q?fiScve1CWDJCZilwP7301hExZwmcASkiEmauCb28LtfRWOhZ3alE6aD94zNE?=
 =?us-ascii?Q?YswuWncxmrmWUHHy1W/Z6/kSQP3vzTMpIcc+RMKD7psWFtnR2JJDcqQ2clqB?=
 =?us-ascii?Q?T2Eu7YECRTFmEnvLmN+W1V6WLgcamp8NeaAKtciDsVbWh3/FSSWwQqilN6S+?=
 =?us-ascii?Q?rpW6ycUdSl/uaT1SQw7urbTGJHGaKYyVP/qMrF6g/YLt6F1xHbmF5dS1p17x?=
 =?us-ascii?Q?XnFv1Wq1gFazHvhlUE2DQnIsomWPPpTpWrbfBlmfe3lFjJgHUQJlVDyuGj4V?=
 =?us-ascii?Q?yiH/RCnyo7tEFztbfjqxSYIO7bJ0qILvAlIHHCoI8RlxwVHJuUSR3MdYktAq?=
 =?us-ascii?Q?pmjEUuOJbdX5jg/wganTV/Dx63FMDgTXVWTc+nWQqkz4LjUpUnDbnr8l9ZWC?=
 =?us-ascii?Q?JnOHpi5+BqSWJpvaN9/YLJDQXL2u3VC5P23y7Bb5wLU9geCIn0xqkA58H25U?=
 =?us-ascii?Q?fp8RLVmi2RqbXJCE/VQMLbgtHGFofYzi7CODNc0LwZ6yJ8VYH3MXXErI5oof?=
 =?us-ascii?Q?K+ayFJoUpGDTJsjNFXm3/ekoPO4OHqceM8t+SdQpLjtD8ika27gV0nF1OmGV?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f44411-cde9-4ab0-e720-08dd6aaf761c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:39:59.2581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBB0PkbkjC31YIIe4Kh2VTEUcGwsSJv06IPZI8ZZ2tiaDGoKpfDyXD6/tfxYD7RLKQBLIqxBSIykqT/npRttUIFHWLSkYHqZOEzNffovu3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add i3c general uclass id.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/dm/uclass-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..1d259b439ff 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -78,6 +78,7 @@ enum uclass_id {
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
 	UCLASS_I2C_MUX,		/* I2C multiplexer */
 	UCLASS_I2S,		/* I2S bus */
+	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
 	UCLASS_IRQ,		/* Interrupt controller */
-- 
2.26.2

