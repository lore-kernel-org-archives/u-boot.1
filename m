Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1019CF36C53
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C13D839D5;
	Mon, 20 Apr 2026 10:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="mt1O6g0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3A283E16; Mon, 20 Apr 2026 10:15:01 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8888E83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EePaxZ226ZkdQwuLP/g7IoSRRakUryhu4ysgi/wh1XJQeOlf8CQseR3VnGWnC4GKTpYEpmf8hxxIcYCfxnMe4AqXpyNaRLA7eesZT5jSneNKCvFvEuWF+rU7bw8Dh4QlqtvCfKZ8K0IjCu6W6/16MZsO9fY3BW9sHBnQg1HlaFtpS3yK78IFkINIQjmDf9n06r2eQ9oNA7tkNxZDkD4vsTnhTy9Igs2+gIjxuBwkESEKcy9iITNiw6gfWVLRVKDyxM8YODRF1wM4jxifTNp5RRV4MmP6Bysz6ZhapvMAhuf2Oc0wEYLBiecgHRQ+VAiscF2yPErlxmlyNFc3hDL4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOF2YOjy2u5dAAeqfQwxzdS2RII4PDs/qOhadP/liiU=;
 b=ogrTM7UMFmtyRvZPG+oVotV3Qjs53lK3JPWEoguwgY16u0dFJwJhPShDDGMBGJCKW7bIqSCSEIEyKpLamd/5FTmfP2QTsiyCVR0Lb+3wlUKfsJkWX1XijsviyagzC5gaS9lM6gIMhXuiBgSfehOD3jJYAAitIEJ2mHF9gyzPmUg5XlUkA0M4WWaXMoXqshwHdUdJz2WiC6cyMixu7XnYeYwn7VlefSf7ORrLNVD9kDotPuDLEwh7s9wfHQK3mhqrm/x6ywjoWkZyk8kHCJ6Aoq50YrN3jThJ8pn5GkgboNEdoBkezi6RzLqSN82WnVzELp94hvoOIAV0r9uG8tyapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOF2YOjy2u5dAAeqfQwxzdS2RII4PDs/qOhadP/liiU=;
 b=mt1O6g0uKU4VE39ZNG9nuaE+aY1GeeI3e5tk8e8sC0HAyklnQ2/V7wjxVRXOYUKX9XojwtsW8aPf2Iu4U3JROscW/aFVe1cYVWTy7VPJT3ofBPovWG8PFgcY2R4eYE9cigWWrcNMg06fj70jU4Er2YKFlXkpmggpFC6KwKt2+om2sUHFZTOG5kZHcppVNzpxxn4Awoqbcs0j7id0buJpny0DLw86PPXdluNWuNzu+NRoYLnZZT05Jm8NihN0B5lxmpjU6kYsykTojAq1BC1mtJ0SZmFFazCGgF4Vs4SjYDKE3dKa1f3nVvaimEmB1Fv405K3/kZUax3ssu7Mx7mHbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DU4PR03MB10744.eurprd03.prod.outlook.com (2603:10a6:10:585::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:14:56 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:14:55 +0000
Date: Mon, 20 Apr 2026 10:14:46 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] tools: mkeficapsule: Add disable pkcs11 menu option
Message-ID: <aeXgdkBin5uz0-OH@mt.com>
References: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
 <7xe72m3tkzultqh3hw4cubfognfryjk5ababajoe6w6zt7jx4c@aaxa2kehv635>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7xe72m3tkzultqh3hw4cubfognfryjk5ababajoe6w6zt7jx4c@aaxa2kehv635>
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DU4PR03MB10744:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fa49e5-de61-4411-b810-08de9eb4e78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Cks3Lj7nkllExs0B1KUic3mcqtpg6xHaW1SJCg+Kgw0qPJgqP5jNZvebtEEnbfAxjAFb/OG92rAn/TA3H8d6ASwzAUx5crrn6SNPpX10XwcN/Und5LiiQqYg3fLel2Jg3apmqg5oalmmZFoaKmJFD+l5pa8SC8/IAlahN3I/L/wRyQyMb4IcyU4DTwkQpE3tfZ4U618yNdV8stSx4gdib9MZLZq45qqfIZL81TyFCIgRMnHYswgQy/Zp53/TnPMwZHfI1//STywPhriDxPBOWY+of/mYGWSLcN6YhFK/iUtWR0hfhaHWEjv85hhMbol0EZhnK1WAFypL8Apyzl9f3K1V5gip1R/PHAeUYTdjEtFk6OamVqiWAq8LUT8Zf8TkU47+kjfZSQfgSKV7ce7PW8L3rnWzceTnTTde5CWmAAdkn700cDrgC8+l9M4cCL44YEtrT1XrBexMwLqRfAj81oghyUtgKCi4yV0ErZgRYTgQltrqqaMJMZxWoxmJiO1ZANr+qrvspjyzwqgj2B52PMWqeKsH0M8/+svSr1M3tp+ojPPn55FKq823NUArzH6gZhkFHGKdOb0ZA8Zs6x4YVT9CXVWSDqc3IfM8JHiZ3LC5ApCpoXEuCsdLW9UH7S0jcJvghv4OHjQveBwi7ewslUogVE2heH8fpo8JViDD7I5kppcxIpIJu1jULG51PFQbgu2kFDiv2XiKjkJFt4blFKGQ9eiReq0SUExEioYGSWWJlNxJQEVqlNPIecdcFDJIIrf96HEH83h07cE+LhqPWCSax598OnV3cbnglGy1RWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zhiJB9cNtMrWcS+uA7FXohTBoPJvVug9owpnhm9lvYSZJtb3uhbK2bxPu7r0?=
 =?us-ascii?Q?KmwEqytm0v6dBNx9XncNvALtuIz/mJBNavFDP55grh/5wXRENITvKAAnv9Cz?=
 =?us-ascii?Q?6M4mDXjH2kNdtqizZAg6B3ZtFz+7ZA4lLaXHfvrpp2merZCMCb2IyiGw3sf+?=
 =?us-ascii?Q?Suhule6HEDlhXqXxy9nQ8+Ywq8bNaMdYbXHOdHBfdH+5//UQn9LsZAfof2PC?=
 =?us-ascii?Q?lMVmhtKvzG/ij/LttwACt3McxTUsR7/H28lDOcCHgkhUlFIwH6flNq2Xhgt+?=
 =?us-ascii?Q?SGvz8XlTScWsNuyg6+53X1TOVVm7Wc24ol5fXGmT4PY54TvlhE0chXr6DOkr?=
 =?us-ascii?Q?h4A9Q+4evoR42GspD9efh2Oi70BRtLy62RT+NYghPc84auGpCoW8tNQhSyzZ?=
 =?us-ascii?Q?0OTuv1uO/OQ/YCeGn8gXS+oGOBNhSDAMxc8f6YJdUQ4FgSs4eenraYMtbrk/?=
 =?us-ascii?Q?XV0lW/bx2jIxd2uHLlkOD5ASUBA4x16TzE3Kjil+o0wwNo3xboG4VPbs+VMR?=
 =?us-ascii?Q?8PvRlHZEvh5HeAdRdnclplmni25JpIL62xh9twXzyiFEtHoqAViYE9Cu4wRj?=
 =?us-ascii?Q?9gRl/I16GeYHOQ6+oaZGlTudFa69ry2CcjJXvlMl0Wmu/CKgwIfsPe4z2+kc?=
 =?us-ascii?Q?Ppo7M2zLFKSxOuyEPytd4KTMJ7tH34hQ5MGmqe71jDZPKi6lVplVXm+E/qdh?=
 =?us-ascii?Q?DJ5w4t9z6BtJlKk7Fxn42WLS7Ps8c2PR2fbCBL0Vdq2oPHtE3ThlkmqVIewn?=
 =?us-ascii?Q?5f7QLUJUZvW6mtBAQk5q6lAmglSTLFDLF6aldjA70ZhdlgOhews8TIUT9ynH?=
 =?us-ascii?Q?z/7FvNK3S/a2wZZofs29qERuazlb68zSg39N7iLNotgibHG3nwnVA9aF6yo+?=
 =?us-ascii?Q?4jVtYcsvgx14DlnmR9ZHUA/+ckWJdAaAhZ4EJwNlSbP1P7SRw5tG7wIMlEzB?=
 =?us-ascii?Q?zXEHJrDhfxLP48ZCiZHP36UjEFQxjC4X/iitilh2ZUAdTi5usmRfoXj28Eaa?=
 =?us-ascii?Q?uj1pK3ta0Ycg29vPW+AAnGC1Zwce9SpjyY9nFGVyadmn+TYJWkJxcKTL0X/Y?=
 =?us-ascii?Q?G8GGknHXAL3zm8C8/3CeOflQwdHpvipS2FIwG102q39ZFP3TCUj975spOcfu?=
 =?us-ascii?Q?c0g5/RD19wDXEarDP70lQJHH0GJtTtkhYgIGgH3Z9f4GkeCk95yc9ocueBhy?=
 =?us-ascii?Q?G/mpNSY8CQmzI+RsBpppmkZDjFq5h6550hh4pikYm7C6g3GgUF1UGhabJkY1?=
 =?us-ascii?Q?q9G7KEBXQ1NmjmwHk4JbAIBGQU2KgvruJac4TDcufky5ozYvwFKW/dXgM5n0?=
 =?us-ascii?Q?3b2f6wCojL2sgib/r1+1T40v0ZVzsY2FSstXxEZPZNlHBeJhFldvD5mRIlr6?=
 =?us-ascii?Q?snss4gtlLu7QGrbCIz1/BWMTXxpTk6VnmPyy8c4FaHdGCFOavBsWtyVkP3/q?=
 =?us-ascii?Q?F80es94dsX5wvn8irTIn+/3lkTZ4EaQUaQoLBREHOKzUQegctbRD+je9epwQ?=
 =?us-ascii?Q?E6CPYklMMPVX8YHzwivuz6vXrn/JeeVDkMENaoP8qruB/1f2U8EaDfQ0jHlc?=
 =?us-ascii?Q?7zmqXFo/lnTce0X7QDxq4wAfo81TP0+CRotHX6gCOPCQmTKvwQHmmvNmB7uZ?=
 =?us-ascii?Q?0sEelDTuW4BeVRHxRB3UdffPe9l5Wynaa5c6J+lL+3ueNG1HVzgAMnUJ7Eqp?=
 =?us-ascii?Q?4K+pOhLdpNZ+IyLE7+2sxN1ey4kbdEd9SKtbsTR06wPHS4/J2TZQeDcIFo/G?=
 =?us-ascii?Q?aFeURH78wA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fa49e5-de61-4411-b810-08de9eb4e78d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:14:55.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwdsgJ78H/eFBhcCYrKREOQ2SgJua45+nuTgYpjmRPfL5LXMhAi9dDMj7B2a3aC4zPlKGOgdT+J2CN7fNNE1rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10744
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

On Thu, Apr 16, 2026 at 05:51:13PM +0200, Franz Schnyder wrote:
Hello Franz,
> On Thu, Apr 09, 2026 at 09:47:07AM +0200, Wojciech Dubowik wrote:
> > Some distros are using gnutls library without pkcs11 support
> > and linking of mkeficapsule will fail. Add disable pkcs11
> > option with default set to no so distros can control this
> > feature with config option.
> > 
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > Cc: Franz Schnyder <fra.schnyder@gmail.com>
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> >  tools/Kconfig        |  8 ++++++++
> >  tools/Makefile       |  3 +++
> >  tools/mkeficapsule.c | 14 ++++++++++++++
> >  3 files changed, 25 insertions(+)
> > 
> > diff --git a/tools/Kconfig b/tools/Kconfig
> > index ef33295b8ecd..ccc878595d3b 100644
> > --- a/tools/Kconfig
> > +++ b/tools/Kconfig
> > @@ -114,6 +114,14 @@ config TOOLS_MKEFICAPSULE
> >  	  optionally sign that file. If you want to enable UEFI capsule
> >  	  update feature on your target, you certainly need this.
> >  
> > +config MKEFICAPSULE_DISABLE_PKCS11
> > +	bool "Disable pkcs11 support"
> > +	depends on TOOLS_MKEFICAPSULE
> > +	default n
> > +	help
> > +	  Disable pkcs11 support. Can be used in cases when host GnuTLS
> > +	  library doesn't support it.
> > +
> >  menuconfig FSPI_CONF_HEADER
> >  	bool "FlexSPI Header Configuration"
> >  	help
> > diff --git a/tools/Makefile b/tools/Makefile
> > index 1a5f425ecdaa..60e84bfbf20d 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -271,6 +271,9 @@ mkeficapsule-objs := generated/lib/uuid.o \
> >  	$(LIBFDT_OBJS) \
> >  	mkeficapsule.o
> >  hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> > +ifeq ($(CONFIG_MKEFICAPSULE_DISABLE_PKCS11),y)
> > +HOSTCFLAGS_mkeficapsule.o += -DCONFIG_MKEFICAPSULE_DISABLE_PKCS11
> > +endif
> >  
> >  include tools/fwumdata_src/fwumdata.mk
> >  
> > diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> > index ec640c57e8a5..ad1c46f0e909 100644
> > --- a/tools/mkeficapsule.c
> > +++ b/tools/mkeficapsule.c
> > @@ -229,9 +229,11 @@ static int create_auth_data(struct auth_context *ctx)
> >  	gnutls_pkcs7_t pkcs7;
> >  	gnutls_datum_t data;
> >  	gnutls_datum_t signature;
> > +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
> >  	gnutls_pkcs11_obj_t *obj_list;
> >  	unsigned int obj_list_size = 0;
> >  	const char *lib;
> > +#endif
> >  	int ret;
> >  	bool pkcs11_cert = false;
> >  	bool pkcs11_key = false;
> > @@ -242,6 +244,7 @@ static int create_auth_data(struct auth_context *ctx)
> >  	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
> >  		pkcs11_key = true;
> >  
> > +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
> >  	if (pkcs11_cert || pkcs11_key) {
> >  		lib = getenv("PKCS11_MODULE_PATH");
> >  		if (!lib) {
> > @@ -259,6 +262,7 @@ static int create_auth_data(struct auth_context *ctx)
> >  			return -1;
> >  		}
> >  	}
> > +#endif
> >  
> >  	if (!pkcs11_cert) {
> >  		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
> > @@ -301,6 +305,7 @@ static int create_auth_data(struct auth_context *ctx)
> >  
> >  	/* load x509 certificate */
> >  	if (pkcs11_cert) {
> > +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
> >  		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> >  							 ctx->cert_file, 0);
> >  		if (ret < 0 || obj_list_size == 0) {
> > @@ -309,6 +314,10 @@ static int create_auth_data(struct auth_context *ctx)
> >  		}
> >  
> >  		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
> > +#else
> > +		fprintf(stdout, "Pkcs11 support is disabled\n");
> > +		return -1;
> > +#endif
> >  	} else {
> >  		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
> >  		if (ret < 0) {
> > @@ -320,12 +329,17 @@ static int create_auth_data(struct auth_context *ctx)
> >  
> >  	/* load a private key */
> >  	if (pkcs11_key) {
> > +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
> >  		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
> >  		if (ret < 0) {
> >  			fprintf(stderr, "error in %d: %s\n", __LINE__,
> >  				gnutls_strerror(ret));
> >  			return -1;
> >  		}
> > +#else
> > +		fprintf(stdout, "Pkcs11 support is disabled\n");
> > +		return -1;
> > +#endif
> >  	} else {
> >  		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
> >  						     0, 0);
> > -- 
> > 2.47.3
> > 
> 
> Hi Wojciech,
> 
> Shouldn't it be the other way around? Use of pkcs11 should be disabled 
> by default and enabled if required. As it is now, it would still depend
> on the the gnutls library having pkcs11 support and therefore still 
> would break our OE builds with mainline u-boot if we don't change our
> modules defconfig.

As far as I understand, gnutls is built by default with pkcs11 support. So for
most of the distribution it should be ok. Security by default.
I don't have yn strong opinion for this but default enabled has been suggested
by the maintainer.

Regards,
Wojtek

> 
> kind regards
> 
> Franz
