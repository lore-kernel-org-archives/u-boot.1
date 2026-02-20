Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684E6C5516A
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C6383D5D;
	Fri, 20 Feb 2026 10:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="rAWRJQ2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E0183DF3; Fri, 20 Feb 2026 10:13:35 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F03A83AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcW1PTpK9smfd/tCCCdIb9wsmkI1SmtLiIVimvdiLATeIlL55eYFJmEy1+ZZ3QAt5eHpIhy9Dwszs7LPskUD+IAir6T6P4BdiU//yVjqT2OLteSRah71nKVWVl7BIrKe9ZnK9VjAqLYPgwmHwnqeaCA4MZxmtkls7TZAn3UMcwFiZq7woRf20uEG0KiTzAKhXWnHr0a+Rw65C0iI6Fz6Zqv7F8mUD6U4NTp6z2hzFMuSe4uGjmcGIAhoU4woVqOcHPlAR0oz3WDKG6dysSAqxOgcUHOGBIMXWjKpnSXBk4RDN1afWmTvHCFydmemv/iQ5LPtsP4AHN6mfJYYl8qtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/bvelw2gKzzshN4Rqae6CT4DyOc14ycOBc8RHvgTm0=;
 b=ECmDzkdk8iEsOPqlo1fZDF1m1Qk+cDzj31jbOtA3JlUinwatBk/nhRfe8buEdtZUAJ3+0NAe/h2w1FBkroEU1qH2tnqMgjeWvQ5vFDuOY9k/XARwcJkkdIuev1SBKzu9q2MmdKYSjW7u0Rg/VVLYcBsNNa6T9rECrhi5mTgjXVI7lZLVDYEcVrNrYx7kkOzH5QapO9pKVtYeghRF1PDAKWQWJLLiC5x8BfaVK+eay/ibJktgAqPEqRXF7MtbzKEZC0qRoa1XTpmnL56yH2JMZOQT9r2a5Smo+i2Ld4zlDE30Wtwc0swGtiQiOSRvODCA0+HWBWPCe2zcaitmnsGZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/bvelw2gKzzshN4Rqae6CT4DyOc14ycOBc8RHvgTm0=;
 b=rAWRJQ2mAu+GCrtG6X0n7C+qViizGLKgPCW+wQaJTYVAxqig4b7yXK1HVN0UTULP4BAlUEC/S7WmcjKeDXlPdEJTk+JzfpsTy1VZcms8gpwf20oSgwaZ9zd6jQh0/dM9eHOAS0vaFnxH/l9s/Ll/J4x7ov35RI230XfreA6wXpd4rukfxvT3E9Mg52kwEfR57FPwO8nSCtNOTqDhzr97hUD8lDZ7l7nGOfyMV0HRwgzNVJ7Yt1IaaoU8qsrtjvkvSDrmmh/6ET1iHVpR1mFnzw5snCzAs7I0DRaes5NF9uPujgD1ieij8Q+CSD1zm1BD39ZwMoEOZzcGjM085K7piQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DU0PR03MB8440.eurprd03.prod.outlook.com (2603:10a6:10:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:13:30 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:13:30 +0000
Date: Fri, 20 Feb 2026 10:13:20 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: Re: EXTERNAL - [PATCH v6 0/6] UEFI Capsule - PKCS11 Support
Message-ID: <aZglsLcTv87S07By@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
 <CAFLszTiexKf9VhSvKC46QrJMW4dy9Uc2ufsG5AyWvs0e1D4aMw@mail.gmail.com>
 <CAFLszTjNx8_eew0p1uQK_k4tR81SDtBPpNmDSVVBmZcc2mG3cA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjNx8_eew0p1uQK_k4tR81SDtBPpNmDSVVBmZcc2mG3cA@mail.gmail.com>
X-ClientProxiedBy: ZR2P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::18) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DU0PR03MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: a57bc4e4-a99c-4271-4583-08de7060507b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|376014|52116014|1800799024|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OAViZPANiovtCu8vcScI/A2TwLuvnyj+UTg4lVu5r9IXSLUSNIdx6QyvQJWQ?=
 =?us-ascii?Q?bWQg1DMb3XkgL2nnyggKZ7fstSkShWU+wXi2b76iq3StXLj0DpVB/8epnThZ?=
 =?us-ascii?Q?WeCIndIsYcofMyijuoYcphOG+GxWc7oTm3Dj4wJ0v6hy5/iUkIfHzbAeQNdG?=
 =?us-ascii?Q?GKcbd/p4Y5m4cbsxN34fY37poIFJfbw8429/Cl58GcBYfilsblHZoebcNKrD?=
 =?us-ascii?Q?Zv9yfDY+WwQ8fsuuAyKP/No4h8wvHoXFjNuKdxYlmZP7Ut2vVmCX1SbM5ZbM?=
 =?us-ascii?Q?fwMTQJYyhn5UMZTQszjyP3Dmcm8emOsJT0KmNMGA83p8ScH7hvPu2eRNn2Ue?=
 =?us-ascii?Q?tHkU4JPkbKDjAdlHltF6JCYohdLnnzkpTzC1iMHoafwPK1V0e1Rv7+4jIpU4?=
 =?us-ascii?Q?xEo/UTJ82RmqVfXmv3l8F2LcavNOCP37gMrzhktK9u1oKq1m50bA32362SGB?=
 =?us-ascii?Q?60txp1OMUbVZSL0I78WS4yo60+ukLJJmh2xPDCOXkipcYZPMgNpaeJobF/4I?=
 =?us-ascii?Q?EJZR4W1OF5kkoFF8v/7cBpr95EEtPyTWun7BIaOzw7FB9c1XfWm1a3pQupvA?=
 =?us-ascii?Q?boKjgLG2pTaV99qt++w+9VVGcgZq/0YKFpdV09IZvWKbR6wyRgfbF637Qz3F?=
 =?us-ascii?Q?Z+8Xn37UWAFQXudSv1aZthAZK8t2tHti8YX++4qiC2LirtBJKWbHz2cR7H6D?=
 =?us-ascii?Q?nIQZ4bP5jl4+/jmdXxCWYKJICMtcqOrL5ilK+2lHkvRv3IZEtBePl+xwkF/Q?=
 =?us-ascii?Q?KLOCYu4vyYldQn0YZPLdBNROeNwAAKFHiF0DZQscxEYgx5zOcZymZTkSJkDD?=
 =?us-ascii?Q?eD1o4M3Oy5dIrRM/VrludwCrL2JSM4AFPQpDa4cOD6bGXtGch+sdOuIvRdRL?=
 =?us-ascii?Q?cgjgKYZZKbXPzfszgcCpp4NTynv3ehMOpS2PI8e6DJVAfIfLUl81qyaDZNYr?=
 =?us-ascii?Q?2oadqykoGfZajPDYF/RfCG/bZsZfyAslvwVEl3C0jvfGy0y4alcBJsVzldNo?=
 =?us-ascii?Q?5X6kiT7un5Xspb5RHn8iFrsYNin1NAuy0FEd2kARsrwo9cjpo3iAhzPgnAnY?=
 =?us-ascii?Q?0d+Gc6OemOJNU4fgPiY83Q8+d05MTrbZ1kaT0DNO3/uGwhoX6EazsMY1JZhv?=
 =?us-ascii?Q?zLT5lNCExnB6eXrlqUvx/Ts4Vcc0wWSs9v+/MDUWrjuva/P8ZReZUKH+hj4J?=
 =?us-ascii?Q?Q+2tpj8qQ46tO85tlpggoqs/8Q0L/6ERaT/0GOKsphZLr+AhfkL//1DQdgBw?=
 =?us-ascii?Q?fNxhXSt65JAd24jYbHvasJ9mOZoEDjI0P2HJmAhaKceJbBmLD9gCETiVVAXf?=
 =?us-ascii?Q?C9LrrOXHny5VoKOxLuH1S7Afcp2OibjHG/wn+SSfH1Qyd/VEO3w8E941JXig?=
 =?us-ascii?Q?BfmnbJWpkIIoJ8MwX62yWmqNs6UisSGk4ohd+Ke5BYxxMgkPDsUWmNeWS53N?=
 =?us-ascii?Q?W3pahAGDluttLLspwvkPc8KqUxajbEDwEaADCHka3Eh3AQv8UyBloHfE6+xu?=
 =?us-ascii?Q?IHLR2dVfrrv5cWMxkEa6t0I3tV5874G/eNLun6SQf2SIa2SP3KfftJjlwPEx?=
 =?us-ascii?Q?IgmnJo5S2IUVf7Z5dL4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(52116014)(1800799024)(7053199007)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRfctPV0hmz5gb7rW6UeoLiDYwGHMdiRDHZ4ZlgI/jqQsUdGyP/W89TqqqoD?=
 =?us-ascii?Q?F6sU77a7GsgcyVohmsHKVawn1u3U8s8bMIhF7upuSrzQg07ZV/2bVJ8FBuQG?=
 =?us-ascii?Q?+aV7BgxNlfP/SRbYxM3aWH7fkMxa2H2JoeL8pvkVUT/KUZB+X7TC2lHd6gab?=
 =?us-ascii?Q?FP+e0pHGF/XqJqaGrILSbuvIlChbeJYJs4108jpM00Mtl/s0Z70o2NMtqhpf?=
 =?us-ascii?Q?8UwYckZZhGBV11NV0TG3oBwgRnNj7kOMZUKavCiZtkazQmDRl1QLLOiqUUlk?=
 =?us-ascii?Q?DwntaXqCskDBJlGTGW+46nQFu9baRjxH5c2y25ZZC4n9lQ+6zBchZ2kWBpvy?=
 =?us-ascii?Q?QgQEoE9K4BgESsfy8y1JSxzt+0GCR1WV+FG9CUX1X15VPyCM2VdVnogeiG7y?=
 =?us-ascii?Q?a74ZGX4lQTZm4HoQmEW9pvLm8ca2C8bKXR1JvGJ9r4Jbn6LSC7tG+VceohTU?=
 =?us-ascii?Q?MN/R38+XH7hoM7BlzEOT3OFU6IplpLk4J+Sgt01emmDmunI/8LW1j9a6Scv/?=
 =?us-ascii?Q?7utcm7HogZGexs8sgNhhVo+8IVLg3Fnmwm9LLf+ebyek1tRWixyYpnzS5QLu?=
 =?us-ascii?Q?bNfk+Qqzud5pvtzFmVha5iY6Gcx650hd0+xiU8gfdL0OjVCAoIaKF5q/kSR3?=
 =?us-ascii?Q?QaL/q1f02Rv1UJKH8eLpTQe5hbNVZL6LSqq2mmYUGhAeTkMqL/6OqATxTqRL?=
 =?us-ascii?Q?23PcSMI9cfXi9Z+h0V9jOKAzaAcAW0zMg61MdydSPnctRstX7mrCvawzALdU?=
 =?us-ascii?Q?ZEYfjO819aJzs+uQpy1hJxtir9KSya236lTa9IO9Eq9DKAlgDXz/O8Byflt9?=
 =?us-ascii?Q?RSsu7fN06OzJqD791BkhNgGQp6+Fb1K7ei4PZztm2gQqqyXZ/e472JASuOj9?=
 =?us-ascii?Q?fINMYnhpBM48voLX7UKqdJUN3IXnemhqn6lxIMM8nNJFCKuKKwllKEAwE7dB?=
 =?us-ascii?Q?vrcC1mgu4upRfX/1MUYjvbenJnXEymICCm8zfnO9WSMugxFoukL+RYF52DCP?=
 =?us-ascii?Q?NDMjWzvriP2tdeaU3U2s7fWTHZx3iYww9EtL44NugV/CuQXNI93L62/a6gzy?=
 =?us-ascii?Q?JndvKzgsoo6lv7zO14H+80fusb55lYCi9iW2OA5GjzL63qDMO58vmWgf8FV8?=
 =?us-ascii?Q?rmSFpH5j+B/6r67CrGusI8MqfMEfEYLnOOCn/L7Kv2VK6eXQn+IPki6o8FNL?=
 =?us-ascii?Q?rz+jnXnfAcTllVibLVBuhRgukDrj5GxfTGakCgBqqH2FBGcIbADPGPbDweSC?=
 =?us-ascii?Q?XBBzcSyG0p/1SdWgqAPicBK8sDDVz5Q4NOMbSCEUEhW7ZQnIbk4ftUhRYdP5?=
 =?us-ascii?Q?abKk2cAmCUOiHl+4+YyvbANunoDrNteiLnzDsliw3S0POPLB0uXaSifASKMZ?=
 =?us-ascii?Q?PVmLMisqNrmqJHxAkHJ5wDk1qTYPyaO5ip6k3DLZ/xB+8fYXiFZa8qBCfMgl?=
 =?us-ascii?Q?t6XY4QDLMe7OVw0l18jnovS36ngsoydWYxnd6TtqHrCGbImCJ5+vzujSN3k1?=
 =?us-ascii?Q?AAzdA3ct+XlmM0gZyF8WYzar1VoKwOyJimBSSQHB6tpyz/10WDKhkfwHd9sg?=
 =?us-ascii?Q?qNQFFLrQv6iZ4uo/bnMbVIUHtC7uGn6FMyHk1ujlJLVWDYDuO+DZ25MeI10u?=
 =?us-ascii?Q?uZDHONwVppnqNUYP9oHj6MTnzTKPae0d4ZI5XHZFC0SJjigbcpCmiomUAXGx?=
 =?us-ascii?Q?bzc/k77hfE82VCFTKAAMxqUVoBBcAU4L7Up9oiDTU7KFxacrV9ycRL9pCF8t?=
 =?us-ascii?Q?7uKZ1uUfU76ooXKZVs1NGeBt7Wnvh+iGeQ9C4a2bb9Ar/SRqkpQXzaxl7tsR?=
X-MS-Exchange-AntiSpam-MessageData-1: TJilFY3ZN35nuB5DSKG+/m3RpvjCwGLXAnI=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57bc4e4-a99c-4271-4583-08de7060507b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:13:30.4571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTB7GBhMdQofRPwYmgQN5TwUJAo8zIssTHglAsvuNFEmPfoml7AXin8PsNI5AO9UacD6oE8ODYjeXcHlILxv5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8440
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

On Thu, Feb 19, 2026 at 07:39:04PM -0700, Simon Glass wrote:
Hi Simon,

> Hi Wojciech,
> 
> On Thu, 19 Feb 2026 at 06:12, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Wojciech,
> >
> > On Tue, 17 Feb 2026 at 04:53, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> > >
> > > Add support for pkcs11 URI's when generating UEFI capsules and
> > > accept URI's for certificate in dts capsule nodes.
> > > Example:
> > > export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
> > > tools/mkeficapsule --monotonic-count 1 \
> > >  --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
> > >  --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
> > >  --index 1 \
> > >  --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
> > >  "capsule-payload" \
> > >  "capsule.cap
> > > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > > ---
> > > Changes in v6:
> > > * mkeficapsule: use strlen instead of hardcoded values
> > > Changes in v5:
> > > * add bin wrappers in test for all external tools
> > > * improve error handling in python test
> > > * fix data types in python
> > > * standardize option name in mkeficapsule
> > > * fix typos
> > > Changes in v4:
> > > * adapt mkeficapsule python support to dump detached signature
> > >   for authenticated capsules
> > > * verify detached capsule signature with openssl after generation
> > > * use p11-kit to figure out location of softhsm2 library
> > > * fix missing long option for dumping signatures in mkeficapsule
> > > Changes in v3:
> > > * fix write file encoding, env setting and extra line in binman test
> > >   after review
> > > Changes in v2:
> > > * allow mixed file/pkcs11 URI as key specification in mkeficapsule
> > > * fix logic for accepting pkcs11 URI in binman device tree sections
> > > * add binman test for UEFI capsule signature where private key comes
> > >   from softHSM
> > > ---
> > > Wojciech Dubowik (6):
> > >   tools: mkeficapsule: Add support for pkcs11
> > >   binman: Accept pkcs11 URI tokens for capsule updates
> > >   tools: mkeficapsule: Fix dump signature long option
> > >   binman: Add dump signature option to mkeficapsule
> > >   binman: DTS: Add dump-signature option for capsules
> > >   test: binman: Add test for pkcs11 signed capsule
> > >
> > >  doc/mkeficapsule.1                            |   4 +-
> > >  tools/binman/btool/mkeficapsule.py            |   8 +-
> > >  tools/binman/btool/p11_kit.py                 |  21 ++++
> > >  tools/binman/entries.rst                      |   4 +
> > >  tools/binman/etype/efi_capsule.py             |  17 ++-
> > >  tools/binman/ftest.py                         |  66 ++++++++++
> > >  .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
> > >  tools/mkeficapsule.c                          | 113 +++++++++++++-----
> > >  8 files changed, 221 insertions(+), 34 deletions(-)
> > >  create mode 100644 tools/binman/btool/p11_kit.py
> > >  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> > >
> > > --
> > > 2.47.3
> > >
> >
> > Please make sure that you have 100% test coverage now. CI will fail
> > without it. If you need help on covering some code, please let me
> > know.
> 
> Please note though that the only goal is to cover the code. Binman is
> full of fakes and other techniques to do that with the minimum of
> effort.

I have added pkcs11 tool support and now on my setup I get 100% test
coverage. I will send it in v7.

Regards,
Wojtek

> 
> Regards,
> Simon
