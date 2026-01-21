Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43344C44526
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7558341A;
	Wed, 21 Jan 2026 13:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="OUMGmWMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B97F83946; Wed, 21 Jan 2026 13:43:29 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DAA83015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 13:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2Z6CQlpXOLuRx0YhE38FttkPMm6ZlN3qc0nxxIN/QjRqKsrTaTjLO3+DJZDAQUdEbHWGqlvGqkGmeN4+4qfsVbg7Ia5yXH3y/mAHygOMfXYL6W6rEBbLlczIihRCSjpHjQm70QaC/gzui8CwR6pZwbbR4heMPshiPa0w8PX27Ed3Km2AT6u7/M8nGD2pA6t0OOHfvbpRpsgItVwe0pvZaa3euwctbbgi/ef842JxCxXkdyCEc8514jo4Dau1MBfHgBhwsjSBpjyFOPjovLpbBJ2lahEL0J+RZ8+EoLfikN5I/iJuaQFtdOyn5jUUDvfD3Cqe2gckWrtUClImiX9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdoIuXg0DpQBcy1Touy8yBpA5rEm/CB510WyqReytf4=;
 b=RzPKigRLcItGFGkLJ7ZSenUyT4/UJG/b+ppciAgQsXXQbV0YXs1nmgh9mdTsdlUDo1vm1WucZ/7D9aGCJMzs1jXaN2b3g74Z8KNNLzBi+AHUjV5fWThL78mZA2qYS38LzT6x/Aw3lxuvwsL+GAQ+8gyI5zd+4iBg03nbO2fsHWnIYMqmhbGxD6vIPe7dKUhy3L2D0avzBwbH7nDUcdq323cBV8pfQN1CSG7K1Gg0E0BTu3iodEY6PHbvav534VNAH33HPDvXh1i+LTl3LCc6Yt8oC65wbWtH7W2wQfEILmrwHoQsS5xVU4w7vwMcn+df0HwcJD//QdhE/6Qa0Pe8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdoIuXg0DpQBcy1Touy8yBpA5rEm/CB510WyqReytf4=;
 b=OUMGmWMJp3D26Udc9faCgDAc815py3ZPm+IgoNMu1eV2iK2YevtGufKXghn3ZqWi0JbhbagzVtXViVEEerUd5tum5E6G2lgJEa/hXmIV7OODoQVBBamtjSRSTrlksVpjWSF8woxJwrxSjwfoKqwuHNObpNHl9N+NjNYUlkSBbwUXo62wN8bnXzxQAvzjNZkXu9ykvjNMHa3QOyacClXnAfShuNkkT948+/ciQnHeL/2myCsUc0GKhYqG8ogjgXA/LevLXMt1aMOCTJDqnjgZscKwmk3j6+SH+/U+H9CDR4xohApZFAeFVP4m0CzWSzDNV1YZM/iJkleAa3dOGaeJZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AM9PR03MB7171.eurprd03.prod.outlook.com (2603:10a6:20b:263::21)
 by AS2PR03MB9004.eurprd03.prod.outlook.com (2603:10a6:20b:5f0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:43:24 +0000
Received: from AM9PR03MB7171.eurprd03.prod.outlook.com
 ([fe80::2acf:84ba:d6d3:743c]) by AM9PR03MB7171.eurprd03.prod.outlook.com
 ([fe80::2acf:84ba:d6d3:743c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:43:21 +0000
Date: Wed, 21 Jan 2026 13:43:12 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.glass@canonical.com
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
Message-ID: <aXDJ4PrbO2eL63B-@mt.com>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de>
X-ClientProxiedBy: ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::22) To AM9PR03MB7171.eurprd03.prod.outlook.com
 (2603:10a6:20b:263::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR03MB7171:EE_|AS2PR03MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 4421a7e8-5f6c-4b53-f6fc-08de58eaa907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZyqxDmuA+63k+vs6odGlhro0pPYfOqwzQV+z/m/94gxCj6PfH/hpjoJfmUdu?=
 =?us-ascii?Q?5g6V2UyTX3YpCByoVAapwRqOLqWjfNCiAWDLWTg914XfqI8CLdPRVvUl0h5D?=
 =?us-ascii?Q?9mdQwQDvpleeTDQve37YiuxcNh5veQuiLjeegjno2iAI/XaxRec276O6noGW?=
 =?us-ascii?Q?cyYOcXoI1lyvJXhOn/z8FXjzwAldEzwZYVtBOZqxAQ1uE15vXT1jOlNGVNSI?=
 =?us-ascii?Q?Xg4L1VEmE0NcaUGJxZVV1P9ek60E20NHgOX+yMUngHfYMfLrNjEqBDMOjukx?=
 =?us-ascii?Q?bXPSdmSp1wGOaeMaa48qjscN8oWQ4sq+43iES0ZJfIXpvud5s/kPCtKaEbaa?=
 =?us-ascii?Q?ueyWLQjDnWQ47ao66meKJ6FNTHUyh32Bi5PQeKVRirKVmTpuGVXtn41ipXqQ?=
 =?us-ascii?Q?fWHQvbYwQR/QV0s7ERkbPs88uzQ8fmqFAbT71IclRVIpnTXCJeDbg19amgqa?=
 =?us-ascii?Q?LUtKu7sY/X8wrPWoDuicwe1LMrKSo7acgjeWXjkAVWc0+B0eXY4is+1I3CrR?=
 =?us-ascii?Q?7IJBpLC/K98+YRIk2Y/nqjUPfdrBkXMwcSViD7IjTd7l8e+viJMgT0PYSJ72?=
 =?us-ascii?Q?e+OG8j5Pajtp76ToePaH9/lu7SWX/fYKRlcQHFjaR4fdOVMu2TaMM4lTOOry?=
 =?us-ascii?Q?tayzYBqSPgzIwUzEnUqtmS1E1ZeyhBT2A2LhWKc8XVYL/eNa6EZzLyNTyW2x?=
 =?us-ascii?Q?Dr5NT7svkR3bLDyySvuNY8ZIXFQ+sJZPQt7J8dcGStFTpGLDUzOYiCOskAyP?=
 =?us-ascii?Q?gaQXQK4zdSDOQOJB2FaRb/kbZWxvkW6UymZ8mF6L9taRe6+eVEke7ySswDMu?=
 =?us-ascii?Q?Y9bbA9wDGX6HJ4vuPpwxkRgZfETnS0LRoZ0NH7+iIs457P1YEuUilt/+eaGf?=
 =?us-ascii?Q?LTIqqIhSV7C408Z5AmFz7UEdS1WghbOv/C/pthpCqHao+YStV/MwOFXc3Nuc?=
 =?us-ascii?Q?+LutW6yKC44QhBV6yDoTynamIP+xdKRQ6XonHOQ9KkuPqZ/bamiZuWWyvS8N?=
 =?us-ascii?Q?jnV9BQEkP5BgoNFgjawctrWoXbPmIU3bczY5+w1RqgQhBXLN4tp/3nD1Poyf?=
 =?us-ascii?Q?0AdIl7mPGjy8pcqG/jcnDpLFP1SEfRVcEKDEisRypDyeyr0vt7+DangeOKTi?=
 =?us-ascii?Q?tCPee2rkfZMBxtLrCEdkj2nPsObRdNAsMPJrbX0f8//w8JH4Cs8FONkhWDwy?=
 =?us-ascii?Q?hiAJIU2/pifBcw9+KUBISLh0hbm5TDfKlF90ZEaMe1citc1SDr23qZ3eYiS8?=
 =?us-ascii?Q?0BnLOVYlPi4KfYbEmWlqgAeWCCEqx9Hry+wBP4SjUheVQ0GejNtkSImLfmJx?=
 =?us-ascii?Q?Uzyr7tFnnkHlJP7F64pG1H7hQ7GVVROv/Qhvg/sLziKgj8LBpaWKjK3vJfsR?=
 =?us-ascii?Q?VnKS0LtooDh0cw6Fi2JMa+ve/M3rde0XutkNiCTb4LS1qGwUUzLyeJQhNcFc?=
 =?us-ascii?Q?lV0D8/+YT7rNWK6wP26F9LPHIaK5PKyTFWsakf0+jBV6RAHlAfzQQlEFRKTZ?=
 =?us-ascii?Q?CZ52GZnr1Nrup6dTXWkMhL8tlvJYvIzh8O6kYPyUhKcE3P+gMuR02+C6dMEw?=
 =?us-ascii?Q?l376H0SkfLcfnVGnh4jHGxe59aUwv7HFaSfRFW8K/TMQImB3QbchKMEbelAO?=
 =?us-ascii?Q?tXC5/Hgn9LKC13yr7q4U0/M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR03MB7171.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VnrpWobdTh9Y/y8PNF47ZGlXwFW/XYXo3Oc8kJ4ahBUShCbibzk3gIzTHnu?=
 =?us-ascii?Q?g9dHptmRpuy5AQt0dHPq5MDOfI/22+GP4evzIGpDQbK3uT2bTs/nFJIQf7Mt?=
 =?us-ascii?Q?cnvaaFmSArvMEboo+l0Ts79+/wEGRGwJH0KJZsgL0mJtUi/zxkTlPTU4kJ2f?=
 =?us-ascii?Q?I4pZR/XeZ1z7//sgoopjyuK6HwpvwIzNESf1m/PsHkD147HOsQR5FCaH0mWw?=
 =?us-ascii?Q?VoyxiyvPBiH0sbri/bAbbFrpWomyh0Lu/v1i6+JgdlgIkxTZi7fnzNamXd3G?=
 =?us-ascii?Q?UITfLOZDGbJEj8lTuWNZEoVMDctj8NEKHAG7RCsmrGsnrKc/vD8z8UNiYan9?=
 =?us-ascii?Q?pDlj6PGtXLWBZooVkbJviICJc1jnfQHyAyL8pp6Mnqh/HI4eDw9G+1mdZLAI?=
 =?us-ascii?Q?apWRIs7FdRqgonTTAMh/wlos//Sr9oEb6PDXuUdPlPmAy9Jx7NJhX/Y3kGb2?=
 =?us-ascii?Q?TU2AwPN0in/XJJRbb2AkLYMfom5ty6tR4lvU/kzlpC2IqVC6B8t9jpFsRnm8?=
 =?us-ascii?Q?zP+jcqj0Vwm3FpULWelcgHgSD7dCmGG+UTHixpkjjkOkxcExfXII/kWKnv5/?=
 =?us-ascii?Q?WUw4B1KYDw0ZTsccdxruhecyweF4sUKPJNnOcYaN6EHwN1PC/ntQyRTCAeo/?=
 =?us-ascii?Q?l6LXN7hYqGI2UBoODWfPvWd0PBGo/UGMOIVJ1UH8ajdjEDPN+QWpyJHAFOEc?=
 =?us-ascii?Q?MzDBX4+e8d+8a32DlBVV8OPHJjf/jHZNUA4tG0mrh7JGMOr/++1jjSWsj3bY?=
 =?us-ascii?Q?hEfV33ggCntAx5z6Yxz7Amz1Nhfk01dQll5dOSXEFusjE01RuVRYezBzoTuI?=
 =?us-ascii?Q?BinPa/rbRmNgccFeuoT1Pf6Hk9Vf8sQeNPL9XPxHWj+frnP/CksCzPkeBnNy?=
 =?us-ascii?Q?fjAcy73a0Ny+mCmzQICJ6v8q2y0np16BCeQefrzxSjcO1kZN+Op31nZ7h7Qf?=
 =?us-ascii?Q?GjJFbd0B2oZDkR/Y95izU6FUedekwy1qo3gLbEUKobAOz935cNZWxURyFlbh?=
 =?us-ascii?Q?aO+zeh/bbHVMfWX/f/yDfZpU0qGv+Q3RE9u5HrAfJiQSxOgnMbNaBavlE9+p?=
 =?us-ascii?Q?J1An94Nf5tyZQ9ktmkl11GQU0TGTx46fE0XegO1wfMHxQyoOijFcK1hKC1K7?=
 =?us-ascii?Q?TAO7D9bjulbTiS+7MkuWMiYdt8IFq0luPxX+9G+XoeV7tjr2RDScSHYWZm2G?=
 =?us-ascii?Q?CEJyPXO3O2s6LhKRVYJ+dYNK+wVr9ygODy72jQt/BeaqMfFNyt9H/f8HL4Q3?=
 =?us-ascii?Q?+g1jcuTEbH0gJuEnXEDkrbqbQ/DaRfTMcwPsPRTSTSL2ZPV4nALSA7dvf4pC?=
 =?us-ascii?Q?MRFHlhhxsTzx4TVcJEYhkSK6/EJ8R1Gd52gts9wP2E4RgJ+7i5rGhc3nE61c?=
 =?us-ascii?Q?XZe0DoeJ3NVWchv3GMGpnGUfCCKhlc6ftCK0Hdf3VLjcDv0lZcd0aFrix5w2?=
 =?us-ascii?Q?KdHQHvHFnJf5+0IhwFLfF28FQ1j3e81cip2qsUpcFuDakEEOIUfWtkD1gjja?=
 =?us-ascii?Q?MJwwuufXfAj61h+8bRlGg23hL0YqOLi3UeiOb5jI46LNTuF+Sl6S8ygEOORM?=
 =?us-ascii?Q?msRFAAQ9UruWSDlBapUXRhOrP/IPvARJUTM5X0rviaCI3z2CNDzDnUSoZxdf?=
 =?us-ascii?Q?BmaxN9AA28JXk7AONUGXl5E7Wdonb+QfwvamZPwVxqzmoCLII7B3l2ZQfsLh?=
 =?us-ascii?Q?VGjNuuQ9gXa04JEtC7ug9DM8wrYYW62j5XnRA2qexQkywoPceg0XuFtkF4Lx?=
 =?us-ascii?Q?eOpxA0GAtg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4421a7e8-5f6c-4b53-f6fc-08de58eaa907
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB7171.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:43:21.8531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYKtugfMGTJg8JJqEy0EUXSaLnTRo0Os8s1NbOn4AJ7ElzJHTHh9kj8jsOHP6W7o6RQB0NkhiVN73xBVsS5H+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9004
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

On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
Hello Quentin,
> Hi Wojciech,
> 
> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> > Test pkcs11 URI support for UEFI capsule generation. For
> > simplicity only private key is defined in binman section
> > as softhsm tool doesn't support certificate import (yet).
> > 
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > Reviewed-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >   tools/binman/ftest.py                         | 53 +++++++++++++++++++
> >   .../binman/test/351_capsule_signed_pkcs11.dts | 22 ++++++++
> >   2 files changed, 75 insertions(+)
> >   create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> > 
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > index 21ec48d86fd1..a005a167e414 100644
> > --- a/tools/binman/ftest.py
> > +++ b/tools/binman/ftest.py
> > @@ -7,6 +7,7 @@
> >   #    python -m unittest func_test.TestFunctional.testHelp
> >   import collections
> > +import configparser
> >   import glob
> >   import gzip
> >   import hashlib
> > @@ -7532,6 +7533,58 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> >           self._CheckCapsule(data, signed_capsule=True)
> > +    def testPkcs11SignedCapsuleGen(self):
> > +        """Test generation of EFI capsule (with PKCS11)"""
> > +        data = tools.read_file(self.TestFile("key.key"))
> > +        private_key = self._MakeInputFile("key.key", data)
> > +        data = tools.read_file(self.TestFile("key.pem"))
> > +        cert_file = self._MakeInputFile("key.crt", data)
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
> 
> data is already in softhsm2_conf due to calling
> self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> you can simply do the same I did in testFitSignPKCS11Simple and append to
> the file. Or you can append to data before you call _MakeInputFile().
> 
> > +        p11_kit_config = configparser.ConfigParser()
> > +        out = tools.run('p11-kit', 'print-config')
> 
> Please create a bintool and call CheckBintool so we can skip the test if
> p11-kit isn't installed. It'll be a bit awkward because there's no
> --version, --help, to print the help text but not have a non-zero exit code.
> 
> > +        p11_kit_config.read_string(out)
> > +        softhsm2_lib = p11_kit_config['softhsm2']['module']
> > +
> 
> We probably want to have some try..except here, or a more forgiving
> .get('softhsm2', {}).get('module')
> and fail the test if we don't get a path?
> 
> > +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
> 
> This is wrong, you'll be messing up with the environment of all tests being
> run in the same thread. You must use the "with
> unittest.mock.patch.dict('os.environ'," implementation I used in
> testFitSignPKCS11Simple.

Well, I have done so in my V2 but has been commented as wrong by the
first reviewer. I will restore it back.

> 
> > +        tools.run('softhsm2-util', '--init-token', '--free', '--label',
> > +                  'U-Boot token', '--pin', '1111', '--so-pin',
> > +                  '222222')
> > +        tools.run('softhsm2-util', '--import', private_key, '--token',
> > +                  'U-Boot token', '--label', 'test_key', '--id', '999999',
> > +                  '--pin', '1111')
> > +
> > +        os.environ['PKCS11_MODULE_PATH'] = softhsm2_lib
> 
> Same issue as with SOFTHSM2_CONF, you must mock the environment and not
> write to it.
> 
> > +        data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
> > +
> > +        self._CheckCapsule(data, signed_capsule=True)
> > +
> > +        # Verify signed capsule
> > +        hdr = self._GetCapsuleHeaders(data)
> > +        monotonic_count = hdr['EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT']
> > +
> > +        with open(self._indir + '/capsule_input.bin', 'ab') as f:
> 
> Please use self._MakeInputFile() and prefix it with the name of the method
> so there's no possible name clash.
> 
> > +            f.write(struct.pack('<Q', int(monotonic_count, 16)))
> > +
> > +        try:
> > +            tools.run('openssl', 'smime', '-verify', '-inform', 'DER',
> 
> This means you depend on openssl being present. Should we maybe do something
> like
> 
> openssl = bintool.Bintool.create('openssl')
> self._CheckBintool(openssl)
> [...]
> openssl.run_cmd(['smime', ...])
> 
> to skip the test if it isn't installed?
> 
> > +                      '-in', tools.get_output_dir() + '/capsule.efi-capsule.p7',
> 
> tools.get_output_filename('capsule.efi-capsule.p7')
> 
> > +                      '-content', self._indir + '/capsule_input.bin',
> 
> Reuse the path created by self._MakeInputFile().
> 
> > +                      '-CAfile', cert_file, '-no_check_time')
> > +        except ValueError:
> > +            self.assertIn('UEFI Capsule verification failed')
> > +
> 
> I don't think this is valid.
> https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIn
> states you need 2 (or three) argumentis, only one's provided here.
> 
> I'm assuming we don't need the try..except since the raised Exception will
> just stop (and fail) the execution of the test but continue with the other
> ones? Can you check (locally) by purposefully using the wrong key for
> example?

It has worked (failed) with try/except. I had to add no time check as the certificate
used for uefi capsules tests has expired in 2024. Maybe somebody can refresh
it one day. I will try other methods to see if we still get meaningful error
messages.

I will try to handle issues you mentioned also in other threads this/next week.

Cheers,
Wojtek
> 
> Cheers,
> Quentin
