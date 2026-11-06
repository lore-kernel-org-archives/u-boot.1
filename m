Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2F606A31B
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kEdx05Ed;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dLsgdb1L
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 755CC40909;
	Fri,  6 Nov 2026 00:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hA82gTTTylaZ; Fri,  6 Nov 2026 00:58:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97344408FC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793926727;
	b=SVSHw806AiXFlfA2VXBjmYRhIZQlKhpz4L9nIDJsagVfNbsHB4PBiZww64p7NB9yGUMi
	 uCauBfqW17HVGjJw+m3qoBz5r+cj12dz7b5l8Cr6nYcXaSPRFntKsB7k+7iHqOkwLVwg0
	 ApTlwXSDR3PNk2ulAThVx+0OcIyxspPayt8aAGcgh6aCoQVT/11UVeT0mdmfDKHbxFJep
	 u1lm8bkMuKwTVb492veDvITxrehOm6Jrp6OAoq3wD0xpBBcNyzk5u9IpEE7LpRM9v568H
	 qKLRJ1xXJRfx98kZOafuu8fqrBj7DG++Iu7lz5HB14F638kKNYs7lftffLzGdRZ4rRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793926727;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Content-Type:Content-Disposition:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PfCDLLby9IpJlkFbuee5S8QTrjoT5zZlkecM+THPrdA=;
	b=nHDKR+4OSP0bb31XepVmZYEadSiAHd1WgDpT4CooTVpENhsdXQjJKgYAyEmKxNVed2mF
	 S+T9sBG8zmmyUDIef8XynTQfMXG3HvzZkngcl6NtgdpQjTE9JchIIXklkPalwdfDBsGBD
	 C+rvcLAKD84S86y8/4Q5W9Us+6VD/jWxfwl8pWItjAqUnpSNj2Mnn2AOzeWIDLP2NaR0S
	 KXr3bOKOzkyW8pUiS4Dl+cJZKQRApOmJK48MnXrukYbbCflNhVM61pPr42guvtTAEHHjV
	 pMmiQ32hmZRkP8V2rq1Jrn1ghgpBhV0gcGlWrKIE9PT41jecYLBiqMJ8mHS0LmoO0RQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793926727;
	bh=PfCDLLby9IpJlkFbuee5S8QTrjoT5zZlkecM+THPrdA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kEdx05Edxksn9qvub+eqt9GqzfAmNxT3m153/QYM3eyNzHYFHL3SIp4hAyCxFGEoH
	 nBN1kbqx4fQAHYLmCWbut5dAO/frzWjmK9C2PTI/M986EIRJGI2+0rdQ1Qs1JeXBo2
	 KPukPjevf/nzSVL0AW8O2PjGJdNXexywGW6+EKUWbiUXHfDEZlk1W5flLBVvfAae4a
	 VkDB+/2eYap/38chik6TIIrlAsx1wPRscYfLHJmj3bNTNPz1Q0kizL43VbjES5bnu+
	 I3iAgjZo0ZTDd1TZ9pV2N93Sbzxkge/bd1473u4KRNSOLSWtKM2Y4YUA43yIAMZng5
	 EvWaz2r8sY86A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97344408FC;
	Fri,  6 Nov 2026 00:58:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE6C42FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 00:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3FE881124
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 00:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdewD2s_GoT8 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 00:58:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 478218111C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dLsgdb1L
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 478218111C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 00:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfCDLLby9IpJlkFbuee5S8QTrjoT5zZlkecM+THPrdA=;
 b=dLsgdb1LqqAS2TcpbqGiE8qj6ssiAgp38LAkI5ZBKXc4QN7b/CorgwFSVL4asu37tevcBAPblVFRB4Hv0gtPDFZjtogcrWz63yntmX+SOpy4PWUUobc8jFHqcEGnslQfwhQ5pH2B90xOWSbmuB4fiekClbIfx4nLa0Z8BiiljSxC0vXENVugrEPrA/uqbIb4HmY+MpnViSINGXSFpNJRlsyPUahNy/aA+GcQv4zg0idqEdpgPSbpsIiKYAVvH/gnnunK7AUpyrmKH401K7eZituR5LJI1B0ITZr6tjCLeriWjCeKOLIso9YL7Lo4RsnyzutvuYU5wipT7v6Ak1tAwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBBPR04MB7883.eurprd04.prod.outlook.com (2603:10a6:10:1e9::23)
 by BR0PR04MB346493.eurprd04.prod.outlook.com (2603:10a6:2c8:2d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 00:58:39 +0000
Received: from DBBPR04MB7883.eurprd04.prod.outlook.com
 ([fe80::3a91:cf25:36c9:c3bb]) by DBBPR04MB7883.eurprd04.prod.outlook.com
 ([fe80::3a91:cf25:36c9:c3bb%7]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 00:58:39 +0000
Date: Fri, 6 Nov 2026 08:55:17 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Michael Walle <mwalle@kernel.org>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Yuho Choi <oss.patchbox@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc2-1
Message-ID: <au0ldYATeuApmixE@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DBBPR04MB7883.eurprd04.prod.outlook.com
 (2603:10a6:10:1e9::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7883:EE_|BR0PR04MB346493:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bb9dd5-46d4-4051-c419-08df3ba1182e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|10067099003|18002099003|56012099006|261022115727099003|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|11063799006|261028144727099003|261021123027099003|261026121527099003|261009223027099003|41080700001;
X-Microsoft-Antispam-Message-Info: fvBl7cx8Nuhzv9dadPuOus1F9mS96DbXMcXStYSnurhuB63ErqCG7Si9ECk5Gi3cS+bPtTl1BaRnoQdmyl/bzfazOBdIc7/YY7szCAUcC1wlaeudxPOmgLGul6a7VdgZww5mfoFuFBR1d7P5U7y+FT6qypubpBsMGLt0Z63zjtsZUkNv//gYZ6C5AIz0ikWzhNLOqAOwoJe7OjASyl+8yTqgWtgX4JS7SjgL7ETttpXrPqrLLBkrrtw8bhJHumCDeX0oHGF84VTZbx2jMn5eHYNdNTfEh11IhBrj3bdaKpdGdPN8kXOMHHLleunQs6472j7UHLAB03+/3rpsE+8sgVCdWm0M0CTIrBa75ZGNrKrnKGXWkHW9uxk7U4RYEwYZ0w2O20utnUvlbr+JfV8BcWOF31MS4BBi7oEr9tJCKVGmpGitNvLtE/SDeofsaUzokgnSsGqEfxosmUjiXWqEuBNiEtMD1WOuJWUQRxxgGn5DnzyjGEJawFW9gx/VBC0WixiYtrTaJTtqKVFp/++rMH2AfhK4MWGXCtFweMzfZcDPQvQfIWyUlLEwl/T1cxpBAHoRP5929I9M4INxqUtebvbCAO0sVKzVm01ZIoDJLq0aoIgS/SVfOjVE6DjrfAtXI7/Ce27WZfd5q46p4bwlt3aTTF3Atx6+86WhRJNo4yc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7883.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(10067099003)(18002099003)(56012099006)(261022115727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(11063799006)(261028144727099003)(261021123027099003)(261026121527099003)(261009223027099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HYGJVFVYedqc6RLx5z9a1Q9uvn+XVp2NMPxKR6UFpKForKBet9m/i3iXUNlj?=
 =?us-ascii?Q?ZEZ6SDnSQeBERIJkHveOh6j2xaM1bfuqUifEiMMTPpnY69wYQfj3ikX0eV07?=
 =?us-ascii?Q?/QAe2LA8DrrpkaTJTXgbZz4ylwS+xcpKitb/V1RWD2HIG+NbxdHM66nNlCRP?=
 =?us-ascii?Q?1EZn+XonQp3cx63jxnPNIus5HDt8vSOlcDcwDs31QHP9y5ZpMAPLkyASUm+X?=
 =?us-ascii?Q?z4FC1ue2KZpjVgpH/vL6S4Mmt8syD3iAhnReI4bVn2JNPXg1Oy6/leuYwqwu?=
 =?us-ascii?Q?7fU8oBCAK2QiXITK8ffSLYkCwgAvsMsJnCDZq/NAADt35B2M9JSOFZfmXrZ/?=
 =?us-ascii?Q?qq4BBhc+9ytw25s3UEEKpYG62H/jnAKlXpe8FB07lGabJfnbj/ABnX+dtXh1?=
 =?us-ascii?Q?o05lI4b/Voen/Krs2LEIUfkVT3t2QvQYeCGfQQR5vYBZ23khyQcVomRfofnT?=
 =?us-ascii?Q?8p2pd7F32kbmnPehlIfz3flRvGdQjgLdSkW51KEVfW7kuXEjbAXOd1MpFxYK?=
 =?us-ascii?Q?+jtEg7XqERj2QeCHQML7dS+uAacPco7MlEXIkq9YLknOnsWF7ZoL285xRGBh?=
 =?us-ascii?Q?RGLdcWKAns6R/ht9CFSjrCEMmo0uOWUoZGPsmUD2GZrQRlVmDSRqZckXNARS?=
 =?us-ascii?Q?R/+XyNq4pawKON4yS7GJPeKHqR671M6nkBep4w9RUycBlnt3VgAmD8LNdaRa?=
 =?us-ascii?Q?czqQKOGJBOO/G2wQc0xa9OioyvYOcydXocBOUPgcOwfZv+tYV6f6+ly6voEg?=
 =?us-ascii?Q?JJw9Pth1Ed9yC7dG+ih/J7B+SWxFhOEgYnL07ZeH1f8XZkkt1KMRfqomIGhL?=
 =?us-ascii?Q?HWjMGGcpW7nYj870vYix+TmY0MO4cqAujR/CfpfJZRDrhlxw3D1BlVlhHl6W?=
 =?us-ascii?Q?ve8a1O6GXequyb0BrLQSwAzjNu4u5q/0Lg6y/uG3Ri+cpeQO1YG+upgmgxv8?=
 =?us-ascii?Q?Y2s17Ac76cTCI8H9cG4j7vpXUBH9RfMMmske4/77g0wQARp/+3VscjUG9Iul?=
 =?us-ascii?Q?Nc7N5rbk4Hl8jIOe1w7EnhgUTHpg69oZ89Xz8CrYnD/HYGuVw4YP7OGTB/KO?=
 =?us-ascii?Q?FfIWMgHWlkePoiU2p/dQy/oxOSqKtCBqxHPkBxx3W/MLkwophoDmiPKYHDPQ?=
 =?us-ascii?Q?UmD16dVBVeBHULZ+/tLDl/nMgTClKI70pVqm6eEnww8kK+DhirDm/QLfSXmi?=
 =?us-ascii?Q?ZPqfV2K8cOu1yEjPmQ87zsfO0GXs/obfdxwof/AJakiskP2/yy3nHovfMh8x?=
 =?us-ascii?Q?rilOrkEsKVfb/Y6TbMg5brAVJP6/MVCTxiat92FGHwTHmS6AGbcYgnLZRe8H?=
 =?us-ascii?Q?4D9tlHHF9JyrgY4Z7Cnt8+Q1+quGh8tngfJgQvXPTMj2+KGtpRU5j8ccER3D?=
 =?us-ascii?Q?epGKW8TGY0HdNPhsosObsVliRkwm83xRgIdeUlLuE7kZhrci57T/t+c0DZpA?=
 =?us-ascii?Q?HQZtnvU8XL+ZgTeQwjKQzsenlbnACZlTCb4JTiu3VOe+w3vBbSD0vsNMU+dc?=
 =?us-ascii?Q?e5/3GnGj4RDoEux035/eNqVyOjlWypqw0nUgx5jfd+iMwob0C77dBB0ZASru?=
 =?us-ascii?Q?tVDqlnmaToWCtV2LF66h6/E4NYHCNwO8u1dTVFejThyxXekytNtz9gQveAE7?=
 =?us-ascii?Q?Pt+wk1JI+bNfyqKYNQpyeUXkwQL0XljItL0lHi+lXzd1MzCg0xX1/ImNS1o3?=
 =?us-ascii?Q?JqY3XrtG/AFvDMZ+zsYCvljM3hBRK6JUQUvYZhm8B3TOUzWjwpFjyrzTRsIK?=
 =?us-ascii?Q?Xyx0KXBpVkDfBlTOWXT23kjZN6SNs+M011SW7NmYiO3yxlhhPxOB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bb9dd5-46d4-4051-c419-08df3ba1182e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7883.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 00:58:39.6106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU0zJJZa5PQKO/Gl/6c4N4oghBYyjbm3dvEEMAcL38W4LqDr5br3aupXPghp8/TAOC4W33G2qNZNmvywK5EaKiyVM6U5SpzProajbZ0ya5yKvDvLJf7wpbCnbs8qbTJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB346493
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull the other round for 2027.01 rc2

-----------------------------------------------------
Fix memory leak and check calloc in ft_board_setup
Various update from Vincent for nbxv3
Fix the FMan firmware load offset
Limit the U-Boot image to 1 MiB for ls1021aiot_sdcard
-----------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/1854

Thanks
Peng

The following changes since commit d1d45c926a571fb6c1e6d7105c280833646915ea:

  Merge branch 'main' of https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv (2026-11-04 09:03:21 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2027-01-rc2-1

for you to fetch changes up to 39f8afdd594bc05fa6b4eedc9729e6b537673d93:

  net: fm: fix the FMan firmware load offset (2026-11-05 10:56:44 +0800)

----------------------------------------------------------------
Mateus Lima Alves (1):
      configs: ls1021aiot_sdcard: Limit the U-Boot image to 1 MiB

Michael Walle (1):
      net: fm: fix the FMan firmware load offset

Vincent Jardin (7):
      configs: nbxv3: enable SPI_FLASH_SFDP_SUPPORT
      configs: nbxv3: build lib/ for speed and zstd unminified
      board: nbxv3: get carrier from the RCW build stamp
      board: nbxv3: do not start the MC for bring-up RCW
      board: nbxv3: serses 1 lane settings
      board: nbxv3: get carrier from the NOR overlay
      pci: layerscape: bind LX2160A rev2 aligned with Linux kernel

Yuho Choi (1):
      board: nxp: fix memory leak and check calloc in ft_board_setup

 board/nxp/ls1088a/ls1088a.c         |   3 +
 board/nxp/ls2080ardb/ls2080ardb.c   |  10 ++
 board/nxp/lx2160a/lx2160a.c         |  10 ++
 board/nxp/lx2160a/nbxv3/carrier.c   | 231 +++++++++++++++++++++++++++++++++---
 board/nxp/lx2160a/nbxv3/carrier.h   |   7 ++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c |   4 +-
 configs/ls1021aiot_sdcard_defconfig |   2 +
 configs/nbxv3_tfa_defconfig         |   3 +
 doc/board/nxp/nbxv3.rst             |  87 +++++++++++++-
 drivers/net/fm/fm.c                 |   4 +-
 drivers/pci/pcie_layerscape_rc.c    |   1 +
 11 files changed, 341 insertions(+), 21 deletions(-)
