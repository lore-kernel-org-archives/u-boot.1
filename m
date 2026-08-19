Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E07C5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DB0660703;
	Wed, 19 Aug 2026 13:45:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6hQr46V1ilY; Wed, 19 Aug 2026 13:45:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787147130;
	bh=70BxhisAqBRCz3NUuYISryiIFCQiu5cFrQw+xRd3Y/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p50FtCxNWe8yB05fxa+kzgXDA4kgwZluilDh1eXnaAe8rOW0UAnKni/xXOvSscqKk
	 7lesBYXPGVzFItQz+ez1GviuM/xS/WgT+9UEfh6Wrh3mh+oWc2AKPkT1+adIa4Bixe
	 JhCGZCRBCHZp4iSunyQeAHZxROmtX9/sjIG1sF/y35q+LeMCumVA+JRJo9VKYvVWgN
	 HasiBybBTQ8kASQsvnhJfDSWzxYfnZ+6N7rRbBwI7MDQsOQfO8TsIWFG5q7aZeBflQ
	 5ucv5ZK/tnAM6D1B6FAjLyM0rrKtFc9wYgtIkGEm3sp0YmdLv6l+/ji7iRvVos3ZiO
	 LQz/ZtxL0Q0fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 057A6606C2;
	Wed, 19 Aug 2026 13:45:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 111141395
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E5A4400EC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BqWB7Pl5VHMz for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 13:45:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=go+BL+Ex
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6CA1400D1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1787147124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70BxhisAqBRCz3NUuYISryiIFCQiu5cFrQw+xRd3Y/A=;
 b=go+BL+ExoFIH2SYyK7jAwtbXW3RF4mh4kCvRBTvNH0XPktaNTVOzPeJaEtJ9zd2O7YxJS4
 IzpUeCyc5aVYM/UdNZdAubLWkTxAntNEUK9/rtq9aehd5P1S9fmOt6kgV55Bl/IW1sAd0n
 iS1CSjN72hfLe4n7jm85i2DD0T+5tU8=
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11020098.outbound.protection.outlook.com
 [52.101.186.98]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-52-8f0jpeVpMWycMnZGwd8qTQ-1; Wed, 19 Aug 2026 15:44:07 +0200
X-MC-Unique: 8f0jpeVpMWycMnZGwd8qTQ-1
X-Mimecast-MFC-AGG-ID: 8f0jpeVpMWycMnZGwd8qTQ_1787147046
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV1PPFA93B279DC.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::224) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Wed, 19 Aug 2026 13:44:04 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:44:02 +0000
Date: Wed, 19 Aug 2026 15:43:59 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com,
 ernest.vanhoecke@toradex.com, alice.guo@nxp.com, peng.fan@nxp.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 0/2] Cleanup i.MX95 based Toradex boards
Message-ID: <aoWzHyOL1F_W-N2d@francesco-nb>
References: <20260819133900.167046-1-eichest@gmail.com>
In-Reply-To: <20260819133900.167046-1-eichest@gmail.com>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV1PPFA93B279DC:EE_
X-MS-Office365-Filtering-Correlation-Id: ac93df4c-9691-4741-86e3-08defdf7eda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|22082099003|18002099003
X-Microsoft-Antispam-Message-Info: +5SJjsfzm7KI23EMfBPkjwMJnspPPYwKPyiyx22NFsrzvDIFtJpvRI9IMnK/eRMyvJ8VSGX5ONVriY04PUKynAGu8wTlGJOcUPgl9EkV2WaJWy3S5qmuE6M7djehMbtKYOMFSoIZqUtc5LtROEw8YW0eRPPslTsYzFMaWg0EAs8KrbrCwpnHnRNgxi4CYdWMV8F7poKbPkVxYP1oyrjHCKPnQMMz0uou/D51MW0R83RTOinD0IpXSSxorgL1gcuJJPFjKaw3r9hyx4eEER/ctIRLhaSnSOR6fqXMQ9f8zc/Cu7CETw7Qxv5Tp09N+bZpxWKdtjeLhP2QrvkzQ3UgUsaLoywgderyl+kNzdY/tUkG3+j9V+pXxlcr9U1S87UhhKXY12jKNVrvL2dER5f6o5n3t25pUUrwPVdxQi+aUxyeigZuOqh8gW7ZmbBaUm+0qvAywJDAtOkN5tKMyszNxeASkPzwAJP+K001adcxA4nq6umo0tWCmDkqeWND2BeoSis403ssoQsf2IjeD5Jb4Dhww+VpDYZERE7cdYOXcqYJkvL2Orsxo/sw/jb989hu7IMwifIycTs9+xTAdJ0yMFqjQJp646thSl/ZzBOGbw2uXNre85FpzYOeVl6WDz/43NX/64WFU09Cy3KGky8AHa5kJ8wCzkaY/A4oqBrOHW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3n77vl0l7JwXj8IEwaMuYXrafTd5nPaSrem++1bvBZBWqreqLwWgoymm/Wtk?=
 =?us-ascii?Q?+CBBjN8/5BQTLOxDmcG2vMN0m/n6zeOP4cK+0GfMIHOgLLFaqwed90HxeFb9?=
 =?us-ascii?Q?2hQ+ms+abMzRvf5DkxTwxVgIbw5S8UPDX1TDPbc8tQipLWXzQugLxDwzjWhJ?=
 =?us-ascii?Q?9x9GyLQr0+GOflf6l2CO4y/8IVqcE+ZfBdDLiNQm/Q4LFi3GFZp+6eUL2H2M?=
 =?us-ascii?Q?2qZJYx6D+EIGvqPykUfWCVRBH/1TjYd4rBuE1LEH4TdavTENWMdgb2AAFcmL?=
 =?us-ascii?Q?0LEOFqM8PYmaNzZQLxPh1JWZg3oG/EjGHysgSv5a3LpPnOWm4GJmEjj2Ooj9?=
 =?us-ascii?Q?xP+qt0az0slgH5EhTEYDuDQU4BR0Xy2boSCoKg/OSe/ZR+sSpn85w2znLJvx?=
 =?us-ascii?Q?AWJJuqmEMAzRwvvodkhunxB+c6RSZV5j6KXW7S+yvm+SwtUCPOdySY28Svlj?=
 =?us-ascii?Q?2Fxbn5hHDji46omcRa9/N8MzjvmzDJD2R2IE+ouPz37d9Q8jaXDgo3qbGLe2?=
 =?us-ascii?Q?kdnpEhAea0dZc022d9tDGwP8mwZ+kyOAH2UnVxe3meCLe9+nE0Pp/RKNlo/n?=
 =?us-ascii?Q?JCw34+oFXzeKfiZxyNhuX2l8g5cEJx26dY1fGGUajgA3ssFClZt6ZUR/csxH?=
 =?us-ascii?Q?ZTLMMBnZlxKfdxkFZUjpFbyRHqmda1zEUDEerw6EPKCSyMnFkBBYfemxa2Hm?=
 =?us-ascii?Q?M/q2+NB+SkBZSykJzUOmY9m5eZFiYghrncUxvI/f7pJmsPPdrnfhyonjQs4j?=
 =?us-ascii?Q?hPNVPw3x/ZLp9PC5DgujcBYP3dnYxH2gQbflglmTfnmdNas5TScWbzp8UVnJ?=
 =?us-ascii?Q?5OGOrviZ5Y/YyOj7YY73VTk0nHyGkaeJwPk8ucK7w0MpaKp5lj9U//wciNd2?=
 =?us-ascii?Q?kMiBuWZ+uVkPz9ksNzx6zgent3SrofCkF5QLhAcr8IWIja9n81UGHhbdIS+s?=
 =?us-ascii?Q?AE0B8H2j9+sM7zs9xdIF3BpWKvudvCRi6Q93p0C4VfAumMOgNm1+Ka0Mt045?=
 =?us-ascii?Q?uQzYjOIE6NfIq74oxhG8U1kANE6zLTwlA2pgnVMsY1Y1MPqbkNFVdva9Rlj1?=
 =?us-ascii?Q?CV+5GvQES5wOz39iq3mQmzG4A7DcTQ4+d7tDmVbs9m0mbdoMXFJgsNA8qyXs?=
 =?us-ascii?Q?w5DxjI10/EdKL1+15ytpVpL6scOa+QtxTn5ypAbnmOOcgQDqbZmhU7d79tjE?=
 =?us-ascii?Q?uMRrhF86UfAu0iejohCMMVnUSV6DYKq7L9Iu8mTa3PTy1Qv4hOL2dk0QE/x/?=
 =?us-ascii?Q?jagYvg6+8QjWda4lYqioW8GkVbY4o7y2ng+9u1lqEgEBCpib7uRN9QYviCab?=
 =?us-ascii?Q?3XMNVQO57YgWObFBgizlRNAtrPNcqW5RmsoyY7HGJcym6bhh258nihhcxDMz?=
 =?us-ascii?Q?14Ab/LmX2fQAHNLKG3X+yaNJDz0SIrDx4KfXHkMdAONn+Cy82m0zek9agt4P?=
 =?us-ascii?Q?EqqH6JAPHab2f0uI1bgLl5xFLgeIpsPILIILhaemIo3s4F0Ma2WCh2AE0s8y?=
 =?us-ascii?Q?XRaLc+j1t7ubTRDujBg/nKqj45IoYOFHI4r7DG4/0qD4ZcnSORIdD//A5wya?=
 =?us-ascii?Q?9A1opdk6VaQIBBE8kX4DH1w8gUpsIX7qC8PMWPTarkCaQW1dsfRb1pQkD5xp?=
 =?us-ascii?Q?XRPi/TmscgODxLoEoq1aU40NlFZQeeg2TeniKdAGoAr/CZk61DKJWbXLkHms?=
 =?us-ascii?Q?XQG1dUIwuI+BoQn7MR4vrQ1yYj37QymxNRyRyMOwC/HJLbd1hNaxENIem7E8?=
 =?us-ascii?Q?YIAC/c7WYvUoDC9jh13u1yAF8fHb1wg=3D?=
X-Exchange-RoutingPolicyChecked: rk6KwVf80a7ZF9jVZawobIskwFse/ZYcEFMAP8R8wdJo4YyrxXHKGjh34ZAig0JGQmxMTVmO5sAxwHU7itvVdq6+T+YgNCqN6HNZo/8lPncj9MO/RkyCkiAV1iLlKNuYP6z38JKkOgjK2tJWdY5tOoE0kuDK4Pr4cT5xe7So0TdE2fOwVx5kzK/pQu1MDU++zDHybMJ0lA3s0CVOnAXssQsJEoBqHxprUgOsZS5/wgBpwyPCHB7oDznZIa5i3EkagcUXu1+/CwZ6dep3AeXWnuMF6B20ocunnK6GjsBERBVmaA3p/fyZCVBnT4pUoZTYmLT/BorL8uMYKji58Dq+/w==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac93df4c-9691-4741-86e3-08defdf7eda4
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:44:02.0311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LXxHthvEW0xE7kJyA19Z0I9dE84cSfxQpyIo4FnGDWryo57DV9E7TKSTqvZxJ2v5StXj3Eeb7VJb3SIp2RAj9sJ3CfvO+lXnpPIPOUrDJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPFA93B279DC
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -8YZeZCOheSdOQKE-oLHOINVbuKZOVhElO-X0_QqCaI_1787147046
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

On Wed, Aug 19, 2026 at 03:38:35PM +0200, Stefan Eichenberger wrote:
> This series removes two leftovers from the Toradex i.MX95 board support.
>=20
> The first patch drops CONFIG_SPI from the aquila-imx95, verdin-imx95 and
> toradex-smarc-imx95 defconfigs. It has been set since the initial board
> support, but none of the boards selects an SPI controller or slave
> driver, so SPI is not usable in U-Boot on them anyway.
>=20
> The second patch removes the WDOG_BASE_ADDR definition from
> verdin-imx95.h. The ULP watchdog driver takes its base address from the
> devicetree now, and the macro it expanded to no longer exists, so the
> definition is dangling.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

