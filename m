Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ECFFED2D9
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 06:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2158405B;
	Thu, 12 Mar 2026 07:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XF3BOB7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A496583F8A; Thu, 12 Mar 2026 07:42:49 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4027683F75
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 07:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx3aav7pTwApG2x2ICi1H2bePg2NQ/oxbwJcSslGAGxinf2QiSMlNpPHzYnNhayq2RTzoEII9zYFhfkUzAItBNl/1tpN8yqO6yJlpFd0YKYbJ1FQKBegFdl8yO2RlfdDw46IFVTgAh4Cei2Ltgttslk9go6ZY779qNH5d+pwxqdg1bf9+4qRmwG1xMO+B8zCBHZ5cBc5/M9X05wlEVfCZHvlDnr03lxsLAputYMyBOeWg0+2E3cmnkQlUoOfAn0i8M6p7GqcW74UjiR6J5M3jqjGP0+PQPiQA+gRhSJy+F4MguK4H01MiDRSBc3uEdJpXnIFJIMqBxPaIzTtL8KmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToghiZ3He37iUAm72wnvFe0oJNFthJPgVTZU5OtbBLU=;
 b=OaESV33+6iBNRvedvt/yWuPtUMiUSxzFU8lV51VhBF74VgLCBrdtDm7nrDJV1yzKO+rwMDy9HBhIKg0mpzRS+ul3D1CPBv4r9X4Rivg79Eph2MUKXQeOsFQ+n5pY3BjV+1eRVrLm1m24ve+HmrpVYUzJ2of2olurAh/CndKmEm9HJtbnjtycRzRdakogmec5GVPc8h6OSybNxslJCwgvcD+ztgQmXt49sChXqmf+qF5B3N5iweNo+Kauc/J/seE6jz8/+pLoEQ3HdDtle3q3IsG7Op5qIJZwgE/lDY031/haZde7I06E/EAVAa7kwtXLxif0CEr4HtKdA9dA/u2nyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToghiZ3He37iUAm72wnvFe0oJNFthJPgVTZU5OtbBLU=;
 b=XF3BOB7gLYvQdKQjkQjXA5GTgg/9lgdHbSb2p7Sqi0nZLpDcT3psoDkyA18t9qKJtM65m+bGhZavyRGlwRIDLRWFynHGD6obipq+y9EHFoScSGT6MvvSTqSimPa72dmwRuwfg4JiB/wYVqbGAkUKV6rruWTH78GTBFv7ABpBhY8=
Received: from BN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:ee::14)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 06:42:43 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::92) by BN0PR04CA0009.outlook.office365.com
 (2603:10b6:408:ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 06:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 06:42:41 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 01:42:40 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 01:42:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 01:42:40 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62C6gdKu2333210;
 Thu, 12 Mar 2026 01:42:40 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Mar 2026 12:12:38 +0530
Message-ID: <DH0LLC5YYZBT.150TWGKWHGJIE@ti.com>
CC: Francis Laniel <francis.laniel@amarulasolutions.com>, Harald Seiler
 <hws@denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: command negation in modern hush parser
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <878qbyr2wg.fsf@prevas.dk>
In-Reply-To: <878qbyr2wg.fsf@prevas.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 0caa90f4-a441-4070-de2f-08de80028f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1LgYgBPdy6/eojZfD2l4XdVTu31dIpcZUMfbDxNRaVWhAR4QRwJyc3BCkspqEvWfzvzrg490QnxYziSOR8Y8owABerZUkxaQt5+1Kg56JgvoxbtN9pw5DazHdLEq8GN9oiQ0m0b6/zJ7oAcgGgLdDICNESRmq2lzwlXaezgujBFvN1B/OxzRILXx+yhvuM4+/938Qm4D3jfLULbzoY9A1kd6jHfoVE+fT152UkOjFLW/IbFglDFfkYie6t8ROZeYDNI60/5LJ4uSUi5nU9WUVWEiQxi69DFfLxY7Wcynf1B088v13FQYOGFdhswfPlGBrx8pZvvRth8UuBnJuiqOzumKONhjJcJu4ElkAiyVfFWUEwwZ0oRj8nD2ifIgQEKX58zSZzruWtcEZkiZfXSPHLiMA72sbyDSkQDsCp1kUCeYaQYWmwPKTpBL8vFgUuzpcLL6X7yVoBLjwLeE5gzApTodSorDCC50Zw5Dn+OIKI0UroISlI1Cvz9hmIbhrGCH6nc5ce9Q6vt+QZLldsQGSmMecp3B0u3G5rnMQ1Wd+SAgSF10ejGsATGBCajt4NPaAKYWri4bZPtLLM8BFNmyflWTl5CI/QhPjo6b++iOPxuvok0pe81cmbydsZlzpKpxWd/t7JELSHtAbWEZUt5VRl/kg/dYlEuLUNe/3i6U9tuoFF7szM2D/9B6YG4UR2+0INHborSCAvWDzc/Uwgq7VEZwHkZiuzEuxt/hnnHDWcN3fdCuDCkfFopMyGBUAjrBefMQOVA5yEAVdIfm7Sieqg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ne/IrWnovzTFe8Dm+fM4K0YpDV05pcZToUgAo+5jvbrYJq28t4026CVdsBTAV4f8wajwOKArUdARp1NucptyTVKQPMrFFqW06ztZiBrA2KDIiNfhiIFXjGOJEX37MSuW8kr1VYqihLxWxcBM0XD1Tu/N6kd3RE5NrhxJJVMWWKB0bsAWfF8TPSzUDJZUdaXy1IVeeaXXLtPJVv0faj/VgpwHnf0SCRqjXu5znIi92UnHQpI6Wxtaz2ci1+bbPg7j7WoArrSa+bqqjXHo0FgmByuPntA1+HHrV8lS5WZmwY8SOGBH514iyA/JbgOL7NBS8APtfdarmi9Rb9DhlnlXNEg+la3OxGK0PkFvsAZN3nBbbCFuZ4JEZ8AyUMZORyRpEvIvw224BiiAoqrnHYK9CS64sZtASLZx8zOOj6TNWCfCiuPCNiI9GqJIk6xowxyY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 06:42:41.6733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caa90f4-a441-4070-de2f-08de80028f6e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
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

On Wed Mar 11, 2026 at 5:31 PM IST, Rasmus Villemoes wrote:
> Hi
>
> Today, I was bitten by u-boot shell not supporting the negating
> operator, as in
>
>   if ! some_command args ... ; then ... ; fi
>
> So at first I thought about implementing a simple '!' command which,
> similar to the the 'time' command, would just run the rest of the
> arguments, but then negate the return code.
>
> But then I looked at the modern hush parser code, which did seem to have
> support for that in the shell itself. At least the "! command ..." gets
> parsed, and there is code for rejecting "! ! command" which does seem to
> be active, but unfortunately, the "! command" form doesn't actually work
> as expected:
>
> =3D> cli set modern
>
> =3D> ! false
> =3D> echo $?
> 1
> =3D> ! true
> =3D> echo $?
> 0
> =3D> if ! false ; then echo "This should be printed" ; fi
> =3D> if ! true ; then echo "This should _not_ be printed" ; fi
> This should _not_ be printed
> =3D> if ! echo "echoing always succeeds, so... " ; then echo "this should=
 _not_ be printed" ; fi
> echoing always succeeds, so...=20
> this should _not_ be printed
> =3D> version
> U-Boot 2026.04-rc3-00079-gb008b86fd180-dirty (Mar 11 2026 - 12:44:08 +010=
0)
>
> gcc (GCC) 15.2.1 20260209
> GNU ld (GNU Binutils) 2.46
>
> I don't really grok the whole parser code, but just injecting a simple
> printf at the start of done_pipe, it seems that that gets called twice
> for each command, and the flag indicating inversion gets reset on the
> first call, after which it doesn't affect the actual return code of the
> command:
>
> =3D> ! echo hi
> done_pipe entered, followup 0, ctx->inverted =3D 1
> done_pipe entered, followup 0, ctx->inverted =3D 0
> hi
>
> Any ideas?

Hi Rasmus,

I was able to reproduce the issue and it looks like we might have missed
reverting the return code based on pi->pi_inverted inside run_pipe in
the one of the cases. The following diff fixes the issue for me:

	diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
	index 748ef60ac90..c01ba00e475 100644
	--- a/common/cli_hush_upstream.c
	+++ b/common/cli_hush_upstream.c
	@@ -10377,6 +10377,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
		debug_printf_exec("run_pipe return -1 (%u children started)\n", pi->alive=
_cmds);
		return -1;
	 #else /* __U_BOOT__ */
	+       IF_HAS_KEYWORDS(if (pi->pi_inverted) rcode =3D !rcode;)
		debug_printf_exec("run_pipe return %d\n", rcode);
		return rcode;
	 #endif /* __U_BOOT__ */

Regards,
Anshul


>
> Rasmus

