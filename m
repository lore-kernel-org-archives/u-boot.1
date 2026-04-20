Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76E2F36C49
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAE8839D5;
	Mon, 20 Apr 2026 10:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="QUt+1fzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D0B83693; Mon, 20 Apr 2026 10:17:29 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5327F83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upBNGvcptHK4CitOeIdlNd+PZF54HsJnssSozoPBIupDuZ1h8+z/ACk4UGayZmGuceJ9lp7nJE5FpEmi2PN5WXlURbsMT6HhlnEhctdGsSEPAGJwzTvWyVs/DNZLSt33vQX8FGWmnT3v/Jo/wqNDvJ8EZF4QZ7RYPDNqn9rf+5vJeYlQ24cxTSU1TPAdRK3y+urReONbjJG0K3uLY4mlwMH9/Oc10U6o8CLN2TKgMcTgN989x2/2RXrCMRlvuSginsa7Gk0kbkEH+ziIrR3Lu+SPlVu0CVrzhAaPHXQdTXRW13g0YHp5bZ9heAR9E31XpeaqoCP0ExFwtBpJiuAx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN++0PK0Anvf2nlcMP75ffG0iwfmJTq0eo/rp6uj7es=;
 b=jhWXa9bHVGjpS8hkYEoL2rgraIa6+wYyJjQezrO2pUlMAEsr3SPopyTA74RCIgKTjek8Bi8sXLzEHXbHa14nsgpWfWztsyICd591KZ6XIOfEM/qncs14MEcsOYBe/No3/G9j2HvSOTaL8uAa6tB+xehT8yGEInRrL7zKJOpXawIYlqDD58hnv2rk7xDuDq2j0q71raOte302iZsEPxY1s/vzTPoupdjyk2eZqKo4lfwnbulGB0AbyIKDfekEQXU91gnd2vTg1PqNPTOl3gr1dilN5f1KbIZGHVsbwJSAfwMj4I11gmtOLEgrONyY+wKqqfa+2381hZdU5XiOazWS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN++0PK0Anvf2nlcMP75ffG0iwfmJTq0eo/rp6uj7es=;
 b=QUt+1fzNK24UgKw3vQ6ZkKfEdiSRoqGS3QegVBY2Oz7OCJyiSWt8V09FQDFaPiSupCagRfnHACuEQNlbBJA+1uyHqhFn3RNFRhDPi00+TuKHne5IgyighLzm8HO6pI5ZC9iG/oNY7OhrVDmpA1wcUMPas7hXX12UTbHBn7UiDqlkVn4Sjpj7W0sUJnc0UjfKRSMY/TlBBsbRPjSpUadZi2k+zNX4l/gzgB4mVoYrGF7jQojiRaqyPOCiSBsJsSql5j3NJVXWh3SWCjtMjNQd1Augidjw2OsFpj4FdZeC/P/V+TXTW+kZ9NOxllpKn8/FIuI8FI6fo4WhpBNAe+0AWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM7PR03MB6545.eurprd03.prod.outlook.com (2603:10a6:20b:1bd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:17:25 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:17:24 +0000
Date: Mon, 20 Apr 2026 10:17:22 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] tools: mkeficapsule: Add disable pkcs11 menu option
Message-ID: <aeXhEqRP0GOa5WUh@mt.com>
References: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
 <CAFLszTjN_MPr-RtBm4QMzcKVGU3mz7_TouvBugWOG=7CeTCb6Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjN_MPr-RtBm4QMzcKVGU3mz7_TouvBugWOG=7CeTCb6Q@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM7PR03MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 6829f3ec-cf6f-4d1e-aeda-08de9eb540dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Jt5HNuwjeMJZ2ksZTQAoOp9TCjQneVQGGdH+43nmDW4X9zzaqxAn0U3uwbOG3EJxLL+Q2pmhhfWQEkIns4VYNMSOXBp1BWyzftcCN+D9PHBBTZSW8AUlKBkxPPrecDPRVtqboHK2RgyjD6P3Owkr6AXuhX0evJr3jLnKQq9oXLe1Nn1yfSFN75kPoj8IxwjLugbi5HFnaX6CzGgYuv1NuHo/RjigzBijvOyd+4Zvp0hQ3BFmq9CkytDVeGYJ+Et9Klw+ZPonidxOzytmHD6OO5wpBygfSAUP+ItZFffc2fQKaHIdD0OOo4R6VUtqpEBxclkMzjKL1b+bSum1dVPUFs6hIGrH2CCaG3j0Nwij1CxXBxLwtPJzcNe7wb25T32m9rNyMhj+weJ2EZm/OtzvjY1foItBFuCW8o/KgmF0/QquyOFHvgv+nEh8txf6UU9Ni840EHe0UURHmTFhiTbSrrwl0UD96EKX3JfKa9lp1i/1MLQqdbULLDrQkrr13+MzAIVfPt+0js697JfSfICLMv+9/rHYsHbhhG7IiIO0f0VhIcnTbDcb7/XyLNae66tRrJBhoYe3ViPqd9WmaZVV1sn58m++MHt5lKgJfXFHR9fQrxDVvCijJm2WamB/tyXLPCRrEGAeLcsdEH+Ou43qVAHgz72FoDU/QbG25YmJATyhct/9iNFyaUqUUtKKWJDqbqZtG2KpYh8pQrnP7Gl2dn9MNLox5NUI307fSdaNDoExPKYu+4tkYvQ1Q8KTfqVSYTDC6KQXexyEBMltLKUhTTAalszAJDkRWYLQG8MtCKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ykWBcUSwOHwWt8ecBB9OuXRQ5vhEh2/47y3OT6hCoqqC8nKXuwtSa5UyWove?=
 =?us-ascii?Q?qjZjC593lf4d/i22kzmrCLX3Yze2En12atltUuk9bjbIzazzB51JSjFxuEkD?=
 =?us-ascii?Q?8Bj1IXw7bNXWxyaJ4FDE+Cexr4SXlE7Z110cfU7NVy5VuozuR4ljQDnSSOih?=
 =?us-ascii?Q?eUElIs1M+f4edKvMJrQvvKKrkEfmptAiOonkikiVdw4cAe11ZVHDLHfgPIs9?=
 =?us-ascii?Q?k5d7QIHtwG425V0Oe5Tdcxzl1n9ss03w3sVScOKYw9XR642OBejN751QrYnO?=
 =?us-ascii?Q?QrpNPZCVSHM1DKNS0c8+mSZtXI49v9gGfFyzZ61DLWJipsIffoccGG/UkKXt?=
 =?us-ascii?Q?X+6FXBRVAepYgvWL5+zOwHKHlYlZTxd+meU9HMCQCoZtH/PcN5gwo4MyDN5h?=
 =?us-ascii?Q?Y77oMd0o2GbVDnj/11Ib15Jotzt7TRRAnFyBNKpNXN7rzeMSRKg8EcJYjV4i?=
 =?us-ascii?Q?Ziw38QRvg83mriZX0ZvVHvqBPppwXL3UoqAvzmCdtR+brEZuJkFBIuR38TRe?=
 =?us-ascii?Q?Rr7Wt3XiVja5hdmAsSm/a21sE4oQMjmUBtsrg7NDH55yiICZe4wmiC6c8ka8?=
 =?us-ascii?Q?tUZ+Mvf5ehywEtEGJDgE3wrHAo3FdVtewNe9wNfRBmilqjy3qKauUNsyCgTT?=
 =?us-ascii?Q?OAaiPKj3x8qbSUihJ5IIhOwztRDeTGaWVJfxBO+gxLvrUlS7dOBQSyljnNPp?=
 =?us-ascii?Q?tjM/GQo0OGexjz7QSse1aIlKcMe7y+ecSL/CKj88fhsXEUTgVBe0EAAS8UBq?=
 =?us-ascii?Q?vUyVgtvtAyVGLKGLySzcaqSGNjJaRpft9l7/4eGDTipxBHpxH/FCIaU+Len6?=
 =?us-ascii?Q?9x9zAQ3TQXKKVQsk8E4Io7aQSsWs3W9KvrgSU+P45Ai6/knbuwkAcYWwmUzM?=
 =?us-ascii?Q?tHjoyOVqDM9RtoiDT8Ib7hO921S7NzL599Pnmt1UJxmOaVtMDOHQwlOhKD48?=
 =?us-ascii?Q?HHZ9FiigFB1s4twEp17PY8FGmwKVVbUpxkf4KxAWP3qRgdDh2g3VZ7sQaJWf?=
 =?us-ascii?Q?d500ZAnFxiZ6zMwiNyqC3Mo+fWoE5GrPzT+zvATNxHCPMnAsW5Zi0whtMoaw?=
 =?us-ascii?Q?VF+Yfz2Thp9s+4hLyIOM8y03MchL7QTJzeKBDHHK7EP8lhI0e46cHEY1PPk+?=
 =?us-ascii?Q?6LEuVi670FonZjJ+6NSp0w65nCsuIXOrIHW1ZKaTRSGvFGm7PAuKY6BiKzDu?=
 =?us-ascii?Q?PrJ0itQ1ojFkbz5ZYti7s84WsMppl7V2ndtl3vPWFCw40Kju5so33/Sluz5F?=
 =?us-ascii?Q?llbPuxP5NLSflpQa2/OE/F/DXVLfWtFFOJgdb0EwE3OpfM4myBa5mT3+g2EL?=
 =?us-ascii?Q?x9M4XJDI/ZuT/T1uwGVzARqnrod81IMVLULe+lYFA+NN1St/WRuC8cdC8SoT?=
 =?us-ascii?Q?r7QjJgBplrEAguGRKxknNTUG3enMnWy56tBDyjo+VHtLuLlsLPo84/kmgtnN?=
 =?us-ascii?Q?ipCJwf/6blXLbBBXRRgLSzFxHZm7LGNi7h6v7NNtkeS5KJp1aaxPaPUvKp3j?=
 =?us-ascii?Q?xSIjvY4upA0o+Vqa7XVfsOcpW2c4BPaGAMqORhm2jUAy8FQMlpo553XvT4G9?=
 =?us-ascii?Q?SJP3hC28nEmihZQJIMiPlmq5kE+M+aK9dpDdekUyE+5C+yvkf/z5XcIbUYRO?=
 =?us-ascii?Q?lCcatPmUzTECOvYRJpnS965nR84QMPsLXXiXajrfFyBWGoGDXAe39frtzowr?=
 =?us-ascii?Q?Xm2/gP0Wx7wbhuSz8fVeQ3E5/7SuwIIFyYjTtFBqLky7BqUDu8bvHI6UkjkW?=
 =?us-ascii?Q?VKLH5M+EGw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6829f3ec-cf6f-4d1e-aeda-08de9eb540dd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:17:24.9092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+ToT9IrR0EX3pIEFDMuBTCcBNVuA6Vp5G0doih2HBu9M25M35KcCr3haU1GUee/bQq6xqIxRRD7oXpNNqsxHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6545
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

On Mon, Apr 20, 2026 at 04:27:03PM +1200, Simon Glass wrote:
Hello Simon,

> Hi Wojciech,
> 
> On 2026-04-09T07:47:07, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> > tools: mkeficapsule: Add disable pkcs11 menu option
> >
> > Some distros are using gnutls library without pkcs11 support
> > and linking of mkeficapsule will fail. Add disable pkcs11
> > option with default set to no so distros can control this
> > feature with config option.
> >
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > Cc: Franz Schnyder <fra.schnyder@gmail.com>
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> >
> > tools/Kconfig        |  8 ++++++++
> >  tools/Makefile       |  3 +++
> >  tools/mkeficapsule.c | 14 ++++++++++++++
> >  3 files changed, 25 insertions(+)
> 
> > diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> > @@ -301,6 +305,7 @@ static int create_auth_data(struct auth_context *ctx)
> > +#else
> > +             fprintf(stdout, "Pkcs11 support is disabled\n");
> > +             return -1;
> 
> Please can you use stderr here for consistency with surrounding error handling.
> 
> > diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> > @@ -301,6 +305,7 @@ static int create_auth_data(struct auth_context *ctx)
> 
> The cleanup code at lines 420-423 calls gnutls_pkcs11_deinit() when
> pkcs11_cert || pkcs11_key is true. When
> CONFIG_MKEFICAPSULE_DISABLE_PKCS11 is defined, these can still be set
> if the user provides a "pkcs11:" URL, but gnutls_pkcs11_deinit() will
> not be available. Please can you wrap that cleanup block with #ifndef
> CONFIG_MKEFICAPSULE_DISABLE_PKCS11 as well, or ensure the function
> returns before reaching that code path.

Will do it and send V2.

Regards,
Wojtek

> 
> Regards,
> Simon
