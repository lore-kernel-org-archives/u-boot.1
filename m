Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C62F327B0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434078433B;
	Tue, 21 Apr 2026 10:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="G47WF5Ed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E468F84378; Tue, 21 Apr 2026 10:30:32 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43438431E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIEYrudo4lY9ClBdZ57wrdR2TggKuMFxuILc167WsFA2aw121atOYelBgBa/YWNFKfI+vkKsqRMh+9z0Z7hCKOyA1fdb5Myb8TLdK/O9mZZ8dXRQz1FDGEEKo3qk005obMm4SNls3A+h1k1bP661FD05pNwsqR9/PTUirtq/r7N2n9qtvbDWZrC1AgZevPQWZvHdhTmcKf57pCkD+w5JXECNnC9WpiOQJUyG4BGjlwXLzm35nBJ4+7+8GwPTN26dLtyd7q+KGgVFFLfGr/nfEzSIeY1QXRe75EIbUW9CyotEFrlXuL/AOMp4pXDTMDfP45C+yf8YEeSy3/4ddXMj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUi4egGUORYBuCvOmjSLQaP1g2H5xD6GVOik2Lzkmpo=;
 b=Z1rrTmGPZSPoNDSSD8fP+ViCWPGMYCBeZnYomfo0sMpjfoKV29Tk+Ddq2tyvH8qK0qpBprhmA8fBSm28J3cUPF4XhyxT32NLK838xT4RehruhaD8W8VcPzCh3fFLFq2YrzH0TnQp7FIAU7vPfYXFbsLwzooVBuR+r7NdraKC7JM0dGo0BuITBZ2zQDy3Se7JC2TfIGoNPgTQyHHuIyVmNi4Qzp9jPF7VZDQ6Ke5qviIqzrwkhNHQzdcS86KpTSBqy00AxjSALAzzopu7Vl2gNaXk/e477ITV/vRpXhuYyST7yiTjmonfkqAh648SBhLpovYaEjw3hJTF49VyhtSVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUi4egGUORYBuCvOmjSLQaP1g2H5xD6GVOik2Lzkmpo=;
 b=G47WF5Ediavxd97/CYOqG07A7lc8SjAQIp+2MRxBab+YqFNFqSQ2BTUJoA1EXZJsLYyVa210a75aQ8g4C17vTbIWy/z8YuvyaIiQ+yJkv5vR3j6S5Y2er3ZdndmNAGAidex3L0ncX3y3m4nYxJjFgeOoT/NToZCh7YxyC8ZeXzmbDbGLhnClQbWx2J28me/Msgoie+bdduFwOE6BWnW6DpR9Zh5r62wgF1EzNP/hzUyPyPyeCMSxTaDa/wkYqFDAbm/xxxSlZv+nxvVLVcOlXfEHjeA+eP1RWkcqNRu0w/tXTC1FNCKYsPwd9MD60LpT5OXTxvyMKx3BX66lG3+iQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PAVPR03MB9701.eurprd03.prod.outlook.com (2603:10a6:102:315::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:30:24 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:30:24 +0000
Date: Tue, 21 Apr 2026 10:30:16 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v2] tools: mkeficapsule: Add disable pkcs11 menu option
Message-ID: <aec1mOCpyTFnONCE@mt.com>
References: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
 <d31d5dd6-6d43-4e61-8963-6474197675ca@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31d5dd6-6d43-4e61-8963-6474197675ca@cherry.de>
X-ClientProxiedBy: ZR0P278CA0138.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::17) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PAVPR03MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: 543f1b3c-0e40-4dff-4b26-08de9f803bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: e34b8VYOMAGYA/4SOoDhLmfdHKlv5eUzyVsIxan7Rssz7pt6bkk+GYBPU2LpSP9xP1aCh/mdFK7bzq0PmnQHxIbkMHI2LTeRCdPlmXklvhoxgK0cyKZsvWt58RDx7M3l4UsmtcCt/JgjeJ0eyYhIO55P8m2I3JlaRf/jbCOZO6m2f3eikO6urPxpZpSV3SgqXRzs/aUlG1tFG1ellIgGh8j+uWJ+aM2p0wnWv+N6R7eHJaUfDB3bjbKE7GH0f/05eA9mQ3QiBPHHdrPgYyAxD5kTavS0eqryK3zMOAiLcsklfl4T8A/J6lhdrT2/DF79VC+JSJ9six6zzcjnccwBUgTjBOWDnO9IqIFolJgN7jTlVVLCiTDbcpGBDz1RDRvCGMc+12HIYK0oFfTuJVVChOq0euAWQmFa5Zwj8nNzKtGQTKQzkgDlrbUe7pd+IQKaZ9Wj8yMujxl9PtV55QptYy8khQexbyO9e6eRnXAAsH5rXy5YzCRxz3McGJ/J86I+1N/N9mZOaNFA1TyWO/fr5dqlZy43svNXKcbAcrXo4x9oSnErsOC6kwUd5M1CcLV+duX18x7NGBfIeRBiHZWNsSokybhCUQzO1vV/Amm5TWBSAN79X1Wwititi83w9+WzJkoIPToYFP+GaC8tugwDDkl5cpuw4TaWbqVxVvm9wd91n+yJVYF7xyGEvLaLlYoeykKNaAbOjGpIQXkzfPEbLCFkx08+xEsUyu6ScHvWFNlJSZvi8UV6HtrbPJU8lXeIoUqZEiX97qvfYSvaic2FuDb56bG4t4+rev3uKSld9Cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aWY+2nMvjW4/miriBzKUIsyo+FVhO3Yv43E3XEAYTEmWzP8en91VWqZT6qvm?=
 =?us-ascii?Q?jRtyQaqWtkvl6utTLH/DeY7iDBn+OeG962ntw9u53jve49HtKyyFsYZHFx9K?=
 =?us-ascii?Q?iwyN3yay1h8YI33JjtPXEZigbS6hBE5VSqHymlTlPEwpSAcpUN8Vs0rXMxZP?=
 =?us-ascii?Q?9F/7TkmSZXZ3/5s1ERFCxBdFOIgQZKAyFkco1FjZcM5lbrHTAp1QSyhO9bWu?=
 =?us-ascii?Q?JTLe4zA4nQQHcbVn+DW+VgGmPD7GVzWjuTdBhHlqqzXhDRo0v41z6PJSWTZO?=
 =?us-ascii?Q?o4bH/i+/8aJL1SRcm5vUnXkacGRg+X5RNooYSVBppxcQwPC3+sCPMqvoidJ8?=
 =?us-ascii?Q?eUPIllxPuvFALOEf0gnicqrKRJsPuqiZkd/eE6cpptEuNp+dGajgazpTaZUz?=
 =?us-ascii?Q?ymop45V63RLPBQRFbTOrZk0hSoNyDyGIJVaAb4sroDG27NcEKxEDR+pgBeBE?=
 =?us-ascii?Q?Bgd8sJgyCdqbDh24QBTNisijEkQkdeNHWxigo+l1O9YjV1s8ispuIsJwtk9X?=
 =?us-ascii?Q?JF/KuW/VSrp/xitutIwcFhgueVjcQMGXBSuzJDaM19EgL1gZDqpWVWEMwPcu?=
 =?us-ascii?Q?IrOkK73uyFxShV4/fRL4z832AiYcl4CgdU4SpD0zuSL3RBc2RIWwtfrDT14g?=
 =?us-ascii?Q?DIWXw4I20cpLMe79mk6N1hO9yP9OK7eH9ZRaF07o4gPxlvYHVF7cAcZMOzz2?=
 =?us-ascii?Q?0ogS/RA7S7UXaBNl3BZ3VrtPuUqyaez/EEcabwEHi6/dM5Dowbjz3uRBXi54?=
 =?us-ascii?Q?doqfgKnDasYpWPngJNa8bGf1ZsmdQd+xyUXQDf7CnwBb9Tv5IN3HVf6SB/Cn?=
 =?us-ascii?Q?4H0qTMSEwRLqCD3S5Y/cY6o0SXlupMnwzpfotNButLYop2iAYNeTBrZnpVfI?=
 =?us-ascii?Q?mnYYFKZTfs2YoKFIxWPYMW60Mw3oRSNyBgGfcnJNdU4XxZIvS9vmjZ5Sz72B?=
 =?us-ascii?Q?sL3W2AGNdSjJDLArFvfLyBKgf7j8BbCoNENHmZ8Y883lhsvnoooXNdB5XVrt?=
 =?us-ascii?Q?Jkaj1ZGJ3KGYgpOOFQEoqRrh9SB2K4ynn2kBDrPmFtFXYPL4t0OKUFrqH9IV?=
 =?us-ascii?Q?3HKnW/+JtQ/qER09QDtkNtc2ciP0zWMja8DdALytpBzFIr9VvPLR8CH37EZE?=
 =?us-ascii?Q?wjCHre+hr5h1oWz+lPq1iO5nYNeRQSGuoEJ8sD6JoM3KMmQu92i1CKz04ki3?=
 =?us-ascii?Q?4V6n+fehqdN4zco7q6+/YvPh/jWgJCHyT9nnnKCComV9sl8uUiElbOfik0Tb?=
 =?us-ascii?Q?iKp/4Hwjt0GRJBNa8Js96liUHdwPQirrkwYhLlA89gdHytsrdEn/9k7knJwp?=
 =?us-ascii?Q?uwOHZa9mdMnr8gkxf0GO3AMKgO8yhfU5i62JrB2SN3XiiHNJCDLB50sQAr3U?=
 =?us-ascii?Q?E85qlarotbiBmxvQqSAmS190mpqtqh9dfGzciUsPEcuoKc9Fle2eC7mfw9kX?=
 =?us-ascii?Q?w7wNtO0kl9fViGh16yJv4NS73pDGfXcSsrDuT2f6x+qQLxo6RUf49O6uqfs4?=
 =?us-ascii?Q?/yvaNcK5stWyC72gBvR8kRWVS1ID1vj7Nb/4SW/Y5EAppdmdyy0bHwQpmCYs?=
 =?us-ascii?Q?WM+64AowpO4rDQ/LzC+pzCHoa3Q8QH7/+gdKoTQPR2OVnfgWmmKdX5eZtJ+0?=
 =?us-ascii?Q?3UjOvD6lD1kStbnKjTWZbJW/rh4SqfeV5tlNoCCq5hiY4IK1OT6dmvzFpt4i?=
 =?us-ascii?Q?oE1aHl/WGsTmoKfX25jz12ke5U8DN+laX0mOQGP7+SI6FbvdBwonJvSKNOyd?=
 =?us-ascii?Q?LfwQByq8OQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543f1b3c-0e40-4dff-4b26-08de9f803bd8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:30:24.7391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXmXGjnTY8jd5Jx7YcsMurMv2YzWLpmvjpZjTEjguphy7DP06i6zAp6TXtwnJo8rJosxh3l9XEGi5aD+yEczfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9701
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

On Mon, Apr 20, 2026 at 12:16:38PM +0200, Quentin Schulz wrote:

Hello Quentin,

> Hi Wojciech,
> 
> On 4/20/26 10:38 AM, Wojciech Dubowik wrote:
> > Some distros are using gnutls library without pkcs11 support
> > and linking of mkeficapsule will fail. Add disable pkcs11
> > option with default set to no so distros can control this
> > feature with config option.
> > 
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > Cc: Franz Schnyder <fra.schnyder@gmail.com>
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> > Changes in v2:
> > - make use of stderr more consistent
> > - add missing ifndef around pkcs11 deinit functions
> > ---
> >   tools/Kconfig        |  8 ++++++++
> >   tools/Makefile       |  3 +++
> >   tools/mkeficapsule.c | 17 ++++++++++++++++-
> >   3 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/Kconfig b/tools/Kconfig
> > index ef33295b8ecd..ccc878595d3b 100644
> > --- a/tools/Kconfig
> > +++ b/tools/Kconfig
> > @@ -114,6 +114,14 @@ config TOOLS_MKEFICAPSULE
> >   	  optionally sign that file. If you want to enable UEFI capsule
> >   	  update feature on your target, you certainly need this.
> > +config MKEFICAPSULE_DISABLE_PKCS11
> > +	bool "Disable pkcs11 support"
> > +	depends on TOOLS_MKEFICAPSULE
> > +	default n
> 
> n is the default, so please don't specify it.
> 
> > +	help
> > +	  Disable pkcs11 support. Can be used in cases when host GnuTLS
> > +	  library doesn't support it.
> > +
> >   menuconfig FSPI_CONF_HEADER
> >   	bool "FlexSPI Header Configuration"
> >   	help
> > diff --git a/tools/Makefile b/tools/Makefile
> > index 1a5f425ecdaa..60e84bfbf20d 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -271,6 +271,9 @@ mkeficapsule-objs := generated/lib/uuid.o \
> >   	$(LIBFDT_OBJS) \
> >   	mkeficapsule.o
> >   hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> > +ifeq ($(CONFIG_MKEFICAPSULE_DISABLE_PKCS11),y)
> > +HOSTCFLAGS_mkeficapsule.o += -DCONFIG_MKEFICAPSULE_DISABLE_PKCS11
> > +endif
> 
> Is this really needed?
> 
> Have
> 
> config TOOLS_MKEFICAPSULE_DISABLE_PKCS11
> 
> in the Kconfig. Then in the code simply use
> 
> #if !CONFIG_IS_ENABLED(MKEFICAPSULE_DISABLE_PKCS11)
> 
> and it'll be fine.
Yeis. I could simplify it.
> 
> >   include tools/fwumdata_src/fwumdata.mk
> > diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> > index ec640c57e8a5..2f6e22626c51 100644
> > --- a/tools/mkeficapsule.c
> > +++ b/tools/mkeficapsule.c
> > @@ -229,9 +229,11 @@ static int create_auth_data(struct auth_context *ctx)
> >   	gnutls_pkcs7_t pkcs7;
> >   	gnutls_datum_t data;
> >   	gnutls_datum_t signature;
> > +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
> >   	gnutls_pkcs11_obj_t *obj_list;
> >   	unsigned int obj_list_size = 0;
> >   	const char *lib;
> 
> Reduce the scope of those variables so we don't have to have an ifdef here.
> 
> > +#endif
> >   	int ret;
> >   	bool pkcs11_cert = false;
> >   	bool pkcs11_key = false;
> > @@ -242,6 +244,7 @@ static int create_auth_data(struct auth_context *ctx)
> >   	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
> >   		pkcs11_key = true;
> > +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
> >   	if (pkcs11_cert || pkcs11_key) {
> >   		lib = getenv("PKCS11_MODULE_PATH");
> >   		if (!lib) {
> > @@ -259,6 +262,7 @@ static int create_auth_data(struct auth_context *ctx)
> >   			return -1;
> >   		}
> >   	}
> > +#endif
> 
> This is getting kinda ugly. I'm wondering if it wouldn't be more readable to
> move the pkcs11-specific code into specific functions. You call the function
> from create_auth_data() and you have two definitions of the function, one
> when CONFIG_MKEFICAPSULE_DISABLE_PKCS11 is enabled, one for when it's not.
> 

Well. The idea behind was that you can have mixed pkcs11/cert files when creating
capsule. This is real use case as some HSM are too expensive to store public stuff.
Rearranging it would go well behind solving the current problem of OE not being able
to compile. I can have a look into it but probably not before we solve the current
problem.

> Something like
> 
> #if CONFIG_IS_ENABLED(MKEFICAPSULE_DISABLE_PKCS11)
> static int mkeficapsule_import_pkcs11_crt(...)
> {
>     fprintf(stdout, "Pkcs11 support is disabled\n");
>     return -1;
> }
> #else
> static int mkeficapsule_import_pkcs11_crt(...)
> {
> [...]
> }
> #endif
> 
> [...]
> 
> static int create_auth_data(struct auth_context *ctx)
> {
> [...]
> 
>     if (pkcs11_cert) {
>         ret = mkeficapsule_import_pkcs11_crt(...);
>         if (ret < 0) {
>             fprintf(stdout, "Failed to import crt: %d\n", ret);
>             return ret;
>         }
>     }
> [...]
> }
> 
> Also, I think there's a missing free() after the data.data malloc if there's
> a fail (or maybe in the event of a success, I haven't followed if it gets
> freed later on). I see a comment of a few lines saying "better cleanups" and
> I'm wondering why we don't do them? Any idea why?

No idea. I have noticed it myself but I have turned a blind eye on this.
As it seems to draw more attention now maybe it would make sense to invest a
bit more time into it.

Cheers,
Wojtek

> 
> Cheers,
> Quentin
