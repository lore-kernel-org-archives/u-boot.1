Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D565CD3CCBB
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 07:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45EE480325;
	Thu, 15 Jan 2026 08:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="jXf4175i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0404282BF2; Thu, 15 Jan 2026 08:49:07 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBEF80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws7c/UPjhanpEVvGsjcwNKIhmX0NWMfuD2v8bjmkoCXROmNAae7VINu9sL2y1PgDeGA/ZlcC6psFDZmuZL0VzV+x2JhctrR9ybvhabpNZq87F9Jcb8zsVcG437Eq1KlySbzouVEeKU+c/fWu8RTBKwogxF79ZBV4ZMk2JrNGrjmrwE/ZiVmFr7fauiAxRMK/HJrcH9xHWtJO8zEfi4DvLW6gxT1U7TyntHwv/ZQOvjCguN+f0ZXSPcKqKtB9//u1ou1TfoTwdP9Ugq+gNM/d40NJti1JEwHBDdG04i7nOjZsnZvsfdsp61i1xgfAN0XS+EyS8GaPC1nLdQUcVP7zHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySZgzlokRDKjZTmwzBeLCsLRjhY7m351a3EWmrd+zqg=;
 b=XoY+fk1f4aW0e4rhabj9i8bieVErMY9FKcIgiVBAx9mfswTzGCniYJMQXa919+g4OPHlrq8Qa5qIXKnMdcgCn1XakLucoRYxUZPvZ6hsuIiKPO8ptL3rQeGjrqN+x1fwVGPiAz0k2CSMAwOztBsUYEY3Mzs+osRyHKO3FUpss+M9QyOfc7vPkjkE6k6dC3e0K9GF55252N00cxO2Clc8Q95EtqeAQXxKmctsO+3USYUZzs5B0TEg4wmFPyME/CWQMMn0GYAPZO43FQoihc7SYOH6UOfUGG/iPFN2ZZ7dANWxYe1yKSbjqVBdnJQ5uJz3EA9oOUuOt4Beton3zlDobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySZgzlokRDKjZTmwzBeLCsLRjhY7m351a3EWmrd+zqg=;
 b=jXf4175i5F4nM8KYtsKlE6sqB/rXfPLAXpaduFZLmwrYa3G2EmqFICHW+iP0hmkp25uHV6bQQnLdqEH1MexJODSFOY8ijIr9Z5zyiWg47U7Kx3bsVrD0QEXLUbCrqPrwwU6djhoGT0qRVOWU3FauOExitG7JU16LIfg9TGpXIBz/D1Depkg0s4D8SZ7QPNeTd0TBkcucLKaFhl2Yxg4up3jWC3RkduexhDLVbehHadHCwR57gku3Hje1AGwWTxxjNAKLDfDuXzMe4uHD4QZ6i02+WS4SKMv1yVqbCHSwam8ltKv6Eqh/VJIq/mTtdr20vr8+tYJhOPkChTATwEkYGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8792.eurprd03.prod.outlook.com (2603:10a6:150:a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 07:49:01 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 07:49:01 +0000
Date: Thu, 15 Jan 2026 08:48:47 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.glass@canonical.com
Subject: Re: EXTERNAL - [PATCH v3 3/3] test: binman: Add test for pkcs11
 signed capsule
Message-ID: <aWib34Okz188cYDq@mt.com>
References: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
 <20260108141346.1663305-4-Wojciech.Dubowik@mt.com>
 <72dbeec9-448c-4828-a887-61a596e4451d@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72dbeec9-448c-4828-a887-61a596e4451d@cherry.de>
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: e5edfc68-ebf8-440d-c2d5-08de540a8c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|10070799003|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fEdDlsPYK+nZ2zNaST2sKBOKLtEhgQLLK1cybB/DuEhmlK2E5uMVyuJX3spZ?=
 =?us-ascii?Q?ntRwAPPWwJ9ArDFIJGgGyci1Eko1Ma3PXYQz4AAYdCf6EoVR0XkaMsjPTAuW?=
 =?us-ascii?Q?5lW79QKNVYEiI78LbczEVkHFfYhAIWy4DafAeeKxOF4zVAL8nucWwlR2FN8D?=
 =?us-ascii?Q?wKuM7KkgHwutuUDbzj3urhXhCjwIK+trqyBzcNLTzt9QfJLRViAEglqFblXn?=
 =?us-ascii?Q?TD+2YmGPK5gcMfityVcLLcJvDWY6sYV7tpMnOQ1goPF/muXHmA4Gka7g1YLT?=
 =?us-ascii?Q?kfJFOZceQrlc9YMgyRL6hBVQmR6Pn33+eKXvgELuMIXfmViYJeRumjKizI7b?=
 =?us-ascii?Q?QFaca0NFQzSFh/Mbf7sQQYPcl8RIxE/1naBeYkf+uXd21UMBZuzPy06elFva?=
 =?us-ascii?Q?ssINk7Jddtx2nbTxXDQoBm/fnnNsMOmoKTO0u8o3zVVHfnhdU18AJSz1N1B9?=
 =?us-ascii?Q?IGO7O+8UakiVi73D3dso4uTqRBqx6Pdt90/DzaFxmw0WjNjol9yYICCNiqj2?=
 =?us-ascii?Q?vvtRfjJTMCLqgb8vCWJ5PjdPViLkgZtXCKB2zNh/hxvQ+PvVKjfqVhI7RTsi?=
 =?us-ascii?Q?JIu8Iq3RqmFd+odB5n8flJQw3Uioqq4JcOZkqsy+RStZlbjgNpW9/8SBOXT+?=
 =?us-ascii?Q?krpchUX152oTR3sG0awxG7Au6iq5Rp5qq2aRqeEj5oeCmCLIeJdtB/58d/k+?=
 =?us-ascii?Q?2AghJ6nDtHWQCZm4TIUEmI4L14G75fqWdwn/RbWnZvcDvtGMPS8ex6csiQXr?=
 =?us-ascii?Q?ZnQXETviUfJqHGVLGdT01uvX8o8H1NG0VoxHWcGZ6N5pOTxSGqvhD+Czbgun?=
 =?us-ascii?Q?8ugpRhkPjaNjiZD2GX4fBQpXPqxz/0UOq/qRLsiBinGbBxsnzkjUlb4gAFgm?=
 =?us-ascii?Q?xHEMv68bZCDIX0ceVCl5BztcSEdeIPQq8WIRI+dc78P9S0EMA2ImnJpGmAeY?=
 =?us-ascii?Q?Yjx+f/8gHuo5u6NzAdDFP7eCu3VcFpqY2d88l6YyVTiscVRXKTivdoU5KsgM?=
 =?us-ascii?Q?HAdYYDvLr9RpjAhAK5PZabxTsmr44wVTQUZZwJovgbDPNVkkt2j1mpqnYf/A?=
 =?us-ascii?Q?kViYGXMgMbePGO2jk4POGW7DlvkEogxzvxmvW4jw1I0hfUJbxMKWZWtB4Wup?=
 =?us-ascii?Q?vf+jaqamwau1MOlj21pv3KcrTr/SVMPSMZfDz2R4VXAGoPfy1jZPMmTl9HjT?=
 =?us-ascii?Q?043ZQ/iIClS7n3aDkTKBxMwlvRTpyrLA0SSCnqw/joNaVXqXwi1nPMYfMDE6?=
 =?us-ascii?Q?A3AlZ0gvdZKnUHw5HkpbHuFcF/uKVYWxzHjr0mWjV2oB4vzOrtnKSRJ5ODkB?=
 =?us-ascii?Q?SqS1RYeHa7DMqp4caePLA3tDyrD+B1+MqM639iRFqxxbWQGKmB6xBaoiUap7?=
 =?us-ascii?Q?6Gpk66oj+9suw+I0RqqjNndlnjBOhB/s6EeSNghvbK9/hZqe3mBW7CsMVgwY?=
 =?us-ascii?Q?qsAL2aOqKw2+dhds5YznrLdQWyHEmgSK8zRY2Vz+Fnv5RuYXEEzGe6E6kN3K?=
 =?us-ascii?Q?PvuO4ePavmkNJKI3umfjUQ4GptstJzPfWyYQjx2Mwdd37eiBASB7tvnPKqUw?=
 =?us-ascii?Q?ll/AfkqLEjeUQTtGPsU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(10070799003)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3FiEdfz8RzX/N03AOKfKWi2gSMo1LZv6e2XJ9IBVv/SbqhXa32MOM1HbayhA?=
 =?us-ascii?Q?sUDunWKE6sSaOyCNAOCQ4yUIMC8P8CdKlyAdvD/hqPNYSvob8SZ3TfcIUIki?=
 =?us-ascii?Q?rbJI6jZxfTc33rw+LkmQggtnUwsbVvDM3Uafri5DoQykBDRJrpXyRN/+0F0G?=
 =?us-ascii?Q?uXgJTPgqjk/x8KgaD7XkzYZPIxd50WrMyi2VAWX/U30HjSY4bM/c9QitOO3u?=
 =?us-ascii?Q?BNH79rRb/j5s76tVOlRaojUO4ox1Nqx+jF/S1bk+Gms5kYodqEGcjhMg5P5S?=
 =?us-ascii?Q?L8ehAQgPVnPZB7KhQ/QGenHjH/GyTT/QSjG59AuKq0se9uiNsLx19B9vndLT?=
 =?us-ascii?Q?0V41gz+N+xKWnhZ/NoJWOMN4qVgDIJI22W+7ILVCfopgoNXzbKkHz0O25T1k?=
 =?us-ascii?Q?mi05J+AabuDAGb7SAZ4Aswxdu6m8CaTeZF+gb4xuHn5eFXOZOB5stevED2Up?=
 =?us-ascii?Q?lG3tY+Ofn0MylXgTJYDQy5/7Mw4g9ZdVSYiYYUudNzx67il2egLYil8uESjQ?=
 =?us-ascii?Q?Qv6nHOpSZScd48hQ9Phvo9qk9+z9zNQe6Ku2tX5X6IhlMoECB97hJXR90BEC?=
 =?us-ascii?Q?83RmARHCoZFIhYzHFI1AZLMKfqgaKeICwkGhV4voH+cXKSeRE35Fo4KUrWCk?=
 =?us-ascii?Q?/0HICPHtC9rYxZbOVT6vQZz4DrYZIXQMO4gaZOyhQGr98y8Wji4aG2ByLgNc?=
 =?us-ascii?Q?Ge7OF24jDlwVBsagcmzgNVnruXARQ0KMtk6A9022KOkbZ0ZgyW9mKqeyJlLT?=
 =?us-ascii?Q?25giXMHqXyPmR9tPe8DGAnWcaOe4cWkXJsOkedsQiYlJmG4eVWM68DzxkUCn?=
 =?us-ascii?Q?kFsjTiF306ba7GGNj+myGda0D7EhcOFLE3yvrQwcDj8Z2F5cgEoSH1YiXswN?=
 =?us-ascii?Q?sKjtOTinMER3xP+ClmUIvaqYR08g/z7OJdvMTixDMF1gcAyBbeLp+1Paebn0?=
 =?us-ascii?Q?KqfurC66tfg9K1DAUxWfFLyzHl45rZ8eb+ULQrQdrNsXC49ISPmDpzrf/oi9?=
 =?us-ascii?Q?4wdMW5WRuZ8G/N1ZDtaqVzoZWwqzzISoEUpmjnF1wotgmeqLCI8hnbQiJreJ?=
 =?us-ascii?Q?XHIMs8qHs+kRywe+9dS/UwOX8o+thsviJe9vwwmTcq2pG7ENJ3fr+K8LQS64?=
 =?us-ascii?Q?VOP7gbXTPYDwhFeH0RD5KHmKG6wP3YQQOlOxGOuv4C/TtE8ESvMMioakJoDu?=
 =?us-ascii?Q?sQXChC6WN8snm8k1/oznfBSRmj83F2M39AgtAbqm85Og+uGfaZCp2bZBqf0r?=
 =?us-ascii?Q?GRQij8CxMs1rIXyc0RJBFRIgGtEFjsHfctvBpCgj1OA0WY2ghabMQ9iFyd6s?=
 =?us-ascii?Q?KcLp4gC2xZimw4Y6KaKZBGzHZdNlkoEMHdeB0GNS1f8B3KZczlRSOn4KpAXg?=
 =?us-ascii?Q?IpaMm2V53jBCbedgObah0EbOFDJNmebj1MVVRHlezA3Vm2bRIaA7AfNTzLWF?=
 =?us-ascii?Q?fFhDgIb6vMa732vIcldgsHw0gawWrNognwe72UNoo945VxVJq7jTXpjWElqp?=
 =?us-ascii?Q?fAnKzGbdyAS34c24vYbtGquI/WVQ6bM8sUgqzO0SxByNj5Jq95/2og6l/I42?=
 =?us-ascii?Q?yJeD/qgL9WOtk67QGl5qhI2K929+1VHgLKAGVafy2z3YKiGW6hAmJ8qwRsJp?=
 =?us-ascii?Q?yDtvbFcCRYX0pojG9zD3tG0Mw7PpizmX0/ge9FlVVxXGug4avPMlCzupiSed?=
 =?us-ascii?Q?AN/8frDoIeTwzyYmMNYULMDVk33YbGeGlFGF1GR3OHOWp1Mvm+kQg0hS2iBd?=
 =?us-ascii?Q?tzBvge4jyUMLpe53rTMuhu57pk3gQVqVj8TMOsGl7dawN7cYzKYrQjP7E+Fn?=
X-MS-Exchange-AntiSpam-MessageData-1: xoLAGSmtn/v3RSBrm04Ha5Dc5qtqfDYknXo=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5edfc68-ebf8-440d-c2d5-08de540a8c48
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 07:49:01.5102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUgoEStRnVYk8XKY1bXBO6GQLLGxDYinTukjJhSxBrOWiY2pvbRZgLzlcVsG+y+V7XY1WX+lyV9P7kJmdF6i+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8792
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

On Wed, Jan 14, 2026 at 05:36:40PM +0100, Quentin Schulz wrote:
Hello Quentin,
> Hi Wojciech,
> 
> I didn't see you had sent a v3 (going through my inbox from older to newer
> :) ). Please ignore review on v2, i'll repeat it here.
> 
> On 1/8/26 3:13 PM, Wojciech Dubowik wrote:
> > Test pkcs11 URI support for UEFI capsule generation. For
> > simplicity only private key is defined in binman section
> > as softhsm tool doesn't support certificate import (yet).
> > 
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > Reviewed-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >   tools/binman/ftest.py                         | 42 +++++++++++++++++++
> >   .../binman/test/351_capsule_signed_pkcs11.dts | 20 +++++++++
> >   2 files changed, 62 insertions(+)
> >   create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> > 
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > index 21ec48d86fd1..ad5c2d63900a 100644
> > --- a/tools/binman/ftest.py
> > +++ b/tools/binman/ftest.py
> > @@ -7532,6 +7532,48 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> >           self._CheckCapsule(data, signed_capsule=True)
> > +    def testPkcs11SignedCapsuleGen(self):
> > +        """Test generation of EFI capsule (with PKCS11)"""
> > +        data = tools.read_file(self.TestFile("key.key"))
> > +        private_key = self._MakeInputFile("key.key", data)
> > +        data = tools.read_file(self.TestFile("key.pem"))
> > +        self._MakeInputFile("key.crt", data)
> > +
> > +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> > +        self._CheckBintool(softhsm2_util)
> > +
> > +        prefix = "testPkcs11SignedCapsuleGen."
> > +        # Configure SoftHSMv2
> > +        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
> > +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> > +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> > +        tools.write_file(softhsm2_conf, data +
> > +                         f'\ndirectories.tokendir = \
> > +                         {softhsm2_tokens_dir}\n'.encode("utf-8"))
> > +
> > +        softhsm_paths="/usr/local/lib/softhsm/libsofthsm2.so \
> > +                /usr/lib/softhsm/libsofthsm2.so \
> > +                /usr/lib64/pkcs11/libsofthsm2.so \
> > +                /usr/lib/i386-linux-gnu/softhsm/libsofthsm2.so \
> > +                /usr/lib/x86_64-linux-gnu/softhsm/libsofthsm2.so"
> > +
> > +        for softhsm2_lib_loc in softhsm_paths.split():
> > +                if os.path.exists(softhsm2_lib_loc):
> > +                        softhsm2_lib = softhsm2_lib_loc
> > +
> 
> This seems brittle, isn't there a better mechanism than this that can be
> offered by distros? For openssl, installing libengine-pkcs11-openssl
> (and setting the provider in the OPENSSL_CONF env variable) was enough.
> Is there something similar to that for gnutls?

I have based my code on gnutls test where the lib has been hardcoded as well.
There could be a better way i.e. with pkg-config but I havn't analyzed it yet.
Also p11 kit might give more info. Need to dig furher.

Wojtek
> 
> I don't think this will work on arm64 hosts, c.f.
> https://debian.pkgs.org/13/debian-main-arm64/libsofthsm2_2.6.1-3_arm64.deb.html
> 
> > +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
> > +        tools.run('softhsm2-util', '--init-token', '--free', '--label',
> > +                  'U-Boot token', '--pin', '1111', '--so-pin',
> > +                  '222222')
> > +        tools.run('softhsm2-util', '--import', private_key, '--token',
> > +                  'U-Boot token', '--label', 'test_key', '--id', '999999',
> > +                  '--pin', '1111')
> > +
> > +        os.environ['PKCS11_MODULE_PATH'] = softhsm2_lib
> > +        data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
> > +
> > +        self._CheckCapsule(data, signed_capsule=True)
> > +
> 
> Don't you want to validate it's properly signed?
> 
> Cheers,
> Quentin
