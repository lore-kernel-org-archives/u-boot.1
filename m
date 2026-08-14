Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34612C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 12:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B62B40C1A;
	Fri, 14 Aug 2026 12:22:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ubMi--RlPc8; Fri, 14 Aug 2026 12:22:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 961F8407ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786710126;
	bh=Zp+0R56k5bGfI049rEbQrXiGutuLJ3wuCHGTd0HlnzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c72RIihJtPGwh7H1E1HXvft3dYKsMzcj7vLkPJenwFDZiZcwUrVGQY7T5RqQ6Q+eS
	 f/P3UYZNkZo8JtN47uJfMWOSITIiNYilGjhW0yqFAsoIXBYGz0HeKk6ijsoZLhsWea
	 r8rldplzWZAjn9e732lvICgg1/+QUpcARPpQe+UnmCCKokaK5ZRcjWZiFwfCNJjE3Y
	 BFJhstlL9lQ90Jq2vD1COvG/Jxt6xtgxCE8nKyERhZz0BwKcfRis1z13fuFBwTUbb1
	 OzmsEtoXcBdNQ6DQETQxS/NPINI9e734eCTfF43PO28SEvwT7tpwcGgFQf0IdK3Uyv
	 4e0cq/ra+/lPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 961F8407ED;
	Fri, 14 Aug 2026 12:22:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DC265361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC5EF402BB
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jKNbtAHxNR1c for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 12:22:04 +0000 (UTC)
X-Greylist: delayed 438 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 14 Aug 2026 12:22:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7748140083
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7748140083
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=e05KnC5e
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7748140083
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1786710121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zp+0R56k5bGfI049rEbQrXiGutuLJ3wuCHGTd0HlnzQ=;
 b=e05KnC5eCwbB//E0FO1lUNzNNWPl0MzXhy7sp9bJqp16+Y6cpU7rHLqtdgpJTHOfNtN9Zo
 ATT+FJJ7DMCt7wPTedID3Km94yYFiK3suS8+Rgb/qsA/ygqJ14kK/eLg4iUTpXzmpFs5u2
 QQJa+vgbYOO6cn0nhVq1Qem3NQ5sqeM=
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11021072.outbound.protection.outlook.com
 [40.107.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-65-P8Zyps9FMyWSD-vPSVsOOw-1; Fri, 14 Aug 2026 14:14:40 +0200
X-MC-Unique: P8Zyps9FMyWSD-vPSVsOOw-1
X-Mimecast-MFC-AGG-ID: P8Zyps9FMyWSD-vPSVsOOw_1786709679
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRZP278MB1938.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b7::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 12:14:37 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 12:14:37 +0000
Date: Fri, 14 Aug 2026 14:14:35 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH 0/8] toradex: Decouple from Toradex product ID table
Message-ID: <an8Gq6o4MJUkiAdY@francesco-nb>
References: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
In-Reply-To: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|ZRZP278MB1938:EE_
X-MS-Office365-Filtering-Correlation-Id: 39615ed5-bec1-4e01-c122-08def9fd9bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003
X-Microsoft-Antispam-Message-Info: fHl/RS4dB2Gz5oh1xXiXl64B9+kRI2kEVsny5m0iux71spdxPIMjcCihkZUlzA3kIpjNmMj4svDbkIhJTdYnRLcmDJenz6WcdhQlh8VB8Z5AmsX9Ge3ut5IDdixcvNrNsS9Rt+RVeOzVkWBJ5aLaIkLysrOSnHPgT+d9qqBBFjpOndarzybJwCO0Hyr1iG+8cHaAD1FqDUDcZ+Ut7oki9wx8JVvjcG2oS/5/6qj59kBdmv9FV3N7Q4FGzZNT6iSgIXIVsk5shjY1J0MgRqn9nPs+M+w3t11rRpXEUvX5grbRwsE6uq2959WGwYgausWlcrpgbwXaMTMuZE8RMlIdGTGxrnVI2tmnv6nAkBNB5uPg+4pIXbTf897SFqBv8c0OVFg3baPVQv1vjI756GFhQJwZ6N1+xHO1X3eYfzFC/nXue9gh4Nli9X9R4UDTK9S2crOD/tFTnf2Ri7es1pajxYZHB1YJreyQfx+zaa2HM6012WIeQgxsZLZj2DW9r/KVYd+EB9cok9RbkmVLI5ihl/NMR+0I9tIrOkL0sH41K2HJewA/uZOsRWc2qKesfHqnLxpCzJfTlGi5GQYd7dXNK8d/T8D/KAlE+8xcXAfxbK29HBpYYCvfVZScTuIj+WZnrEW2HS4z5/wKwHZCVcmDvrLFSVY7M9/b5YheHOs3/5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?buVPMJxJmVx8ccIuy6OuY69jNutjjqhzsC6GfFu/qWQ0qyNHTBhOunA4LKEz?=
 =?us-ascii?Q?2BPTGZunIN5AgcpQpVM6jigINsr2nefoSqYsyuezhOVtlxtSX8359mPdSk1O?=
 =?us-ascii?Q?gywccL34OB5CE5nhYh44elCVWB71jGP1UcN6X2tX/0eUbhKbaiSTinbwYCI9?=
 =?us-ascii?Q?pSSkF4Cm8/f9cnI9koceMoXP/oBAOmVTJ2rK7XXo4jYocF4kNh1iifFASapg?=
 =?us-ascii?Q?LyZiYVvp5ZOyDE4tGinrpLwYwomp7fpSaOusRn+bzr5bkSssKYzFIwa5rIrQ?=
 =?us-ascii?Q?G/LovTDtNtZidacpOSbFQeU71wBviD4UmM5/51ruHRiPpr7bFgOPozruAMsP?=
 =?us-ascii?Q?LgL2MWwRB/njQFnS6FPRhdxx3+X54lgrCGmMbpZ4vVdA2ZZebAZ0Z0MFApWp?=
 =?us-ascii?Q?FkxtgQ+xJV6HDuHlQniMoS+8rW9o7KzP3ZgAdIDoSChXluW4akCNK0MUrHKV?=
 =?us-ascii?Q?VrFMakM2h0X9Y7g2h6HhFTgp3iAu2sLz3D9nbaaQVlNQWzJKtuzBLrynsl9n?=
 =?us-ascii?Q?LU/VNHpg04Gc03X2M/w8eJ5c2O40dm0CevE04zsMIyp6ERYqiE+NwQYb+/SZ?=
 =?us-ascii?Q?G94nSPZ3+z/tyvifReXG/hkYOfeYcKiKGbfzd1mWxESmnEk0gEeEsI1hRLK8?=
 =?us-ascii?Q?1bgAfzP0pa0W0uZW30RGPlyyferL44zh80pMgkhQGKefeqk5/aRxW4g1JNa5?=
 =?us-ascii?Q?tK2UMlhnSZJCHxblJibqX0Wk1SI5sjmYTcvZIcHLtDSn7XX7pprM6sbC8v5j?=
 =?us-ascii?Q?bkK6YOBjX2YEF03xq9X4rxge1jXEfyxnIianCRaQl4qcZUpl3K1VTbYVNhi/?=
 =?us-ascii?Q?9o3lEJjlNbn4AbdHyxGS1nXckNDY0M2ZQOwr2fZuey3RsbGeYG/xS+Hr7o4u?=
 =?us-ascii?Q?KoliM2Pif+Hvx8QGVPTpBaZdVFchM4wwd0Wt2vbSQNKIMuHP+vckQDgKbR2D?=
 =?us-ascii?Q?TK/J1s6GB49tun6EplSKBC9elaw84UaAaGDEQVDMFCNTbtVCYDCBfGWCVrUv?=
 =?us-ascii?Q?AI79A9TzZabdrcECNrMZnQ9yaYd17BhdrgfDm6ZirYe/ApN9t5920rIBm+em?=
 =?us-ascii?Q?JvSO1K8BhA4FUfF6wLT3OL3pCq0z+EiUcnLcKcwQq3C27ZsQqnXAcVcy7i9d?=
 =?us-ascii?Q?xts+Nf4uR2RDN6znk59z0npp+y1a8K9MSIlY0UqPHSJ2eGnjNPRgLZMQjjpb?=
 =?us-ascii?Q?2VvPKaThQmrCVJq0/dHngzoLp3vUeNOUZ1EdU6vV1NRRec9iURlGTGnCJldw?=
 =?us-ascii?Q?Ty45a2KQfZIRVeGbvZOBcUjueDoRY3ytNqI9cueyyB7mjr2pp0/x2kSkUr4j?=
 =?us-ascii?Q?WZ4V6f8QFkRD2GU8Y2/jSKfIdGHNkxJ5w76KNv1bkFVwI2ItxKpYmZmynlce?=
 =?us-ascii?Q?Sv7nP3XvIM6s84InBRc4llgwLJBdTocv63VpQs6bwblOxItbDRGnUf04EJUH?=
 =?us-ascii?Q?LwsvrbL7UpLlhglVRmoz7I9pX5JdQl/ncxeRcrJNuKSTwDY9cFoix6q52SSn?=
 =?us-ascii?Q?51Crs2jcvgmEruEIM9iKKrJGfCpEvUgDHUGkBqv1bICH027bDK788LMux2Lf?=
 =?us-ascii?Q?noEaazHwvOXdkYU57ungfPTMKRJSFE74L5UfxSf9zJeXs7G0gCZP98UhSAa9?=
 =?us-ascii?Q?A6RhF7l5hUvBgXgFRFkPqfeNmah2KiHMwHgfWWZCMW1ER3IPxgb6nt3kw7wI?=
 =?us-ascii?Q?hQO0Mf8W5ZfeajjklCq++IJZHMflwbltjHSdh8x5TEQorg5OcB9OGqJg3fIm?=
 =?us-ascii?Q?P9dW3zvJigZ4kIIfr9g2GxVHvjx21Tk=3D?=
X-Exchange-RoutingPolicyChecked: B64ezZP5p7TMJBJ4/RIXm+Cydz84cG2NOfZjNPp8M4wXELGbhI1b/atxxUcZqzo6gz+IOXtmnhWY5gzvDRg/HIVQcBntYIWZ6P5JWNNBJnFHy8fZ55+Ib7EJT3HWO75gHH0yIa+ybXjnHmOdFHgMYq+4qTlm3EmZy736d860trS9QdJqYKEDEgdIQd9qNWzQh6KP1c4SSi74px1yUq+eSoIXFxcDLHKfbXTi3ffyvDjknnBAE6SPYI/r+UD0vJX/bShpDR+kDarSZHq+mxXQ3lrUtkdjOubfMPESezPpJUii4FWlZmi7zeI1yHh1/h5yjLAg8i72U75RkolaGb/Irg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39615ed5-bec1-4e01-c122-08def9fd9bfc
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:14:37.3907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6ad8SJwK5dFWX3LFZyzzY+SHpIABV2tFcPtS6S/TH9Wti0o0j1/vRPCP5hWsvxkfZGqQDzy95nGWeaW9LEvhoVyn4I2w6iaE3bWXyFyIuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRZP278MB1938
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NF0wspkbNDdB9reWj8FhF3dEwR0ob2qxnXKtak30Gq4_1786709679
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Aug 14, 2026 at 01:21:15PM +0200, Franz Schnyder wrote:
> The sysinfo currently uses the Toradex product ID table to print a
> detailed board model string. With various new SoMs that are released by
> Toradex, the PID table grows and needs maintenance effort which can be
> avoided.
>=20
> Rather than printing the board model based on the PID table, rely on
> the model property of the device tree and the data written to the config
> block during manufacturing, which already describes the HW correctly.
>=20
> For example, the printed board model string will change from:
>  Model: Toradex 0075 Verdin AM62 Dual 1GB WB IT V1.2A
>  Serial#: 15412798
> and become:
>  Model: Toradex Verdin AM62 WB on Verdin Development Board
>  Toradex SoM: 0075 V1.2A (00751200)
>  Serial#: 15412798

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

