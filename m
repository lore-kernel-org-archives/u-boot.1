Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2BCFD5F87
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 06:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4585283693;
	Wed,  8 Apr 2026 08:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="xi7XJzk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D67838BB; Wed,  8 Apr 2026 08:50:57 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3341080433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 08:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HucyanC9jCwq65QHnsVZAnw/BXuGOuyIB9p7DpiSOkd2uNIApQ35pt6m4mQaLvfCl2zBQwxrhQXEnCbHvhbj3NPCkt0cBOM1V/A+r/QL9RsT98fTV6mmpRVTZ05pXFIuNzpht4r2sJftQVQW5wIzj1/PJ/APnorh0FgsZWgEEd0Me7h/AN/jTJL4KfcUJHYH7emLPKhb6/wEoH4V26YSUZ8tRcymS3cw6kwoxFm0L4oXnQlzI9/+K1TvdUkwWkZK3DezfWHDw1xqHRK04mLNW1SgzauzrE0qrbqvq10F1+XZhmcMINNUapQejjZ7ZrLUfxeCf/FFaSRhSFB3tRQ5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvNv38047MuMT1OoHbm3W8uzdHJA+SdBgZ4ZKn7JVKY=;
 b=ipdiqD/ct2k8AnzVbzhxNNpQobOO+FKtWH+7mxTKIhPyOhEW32QPVMXnes8VgBzCx4DPcC9EqTljEoCsKNNrbHTbhiszOxU5zStHNT/s/fS5IV6vHoSxDi2EwqUcAhdf0YAhHqSuG2vbKIsJOOmum0k5A2m2VRxUFL/t1cqQtt5e6Z3walW2x9Q6lIpEDCMWk3n0/HfJhYxIc5SFKtapEj680L7llIyKCC4mHORqYmw08cTHQEAzccAWCT6umRvd+cTDtT3X2B/Atf7tWfTGRXv/f1Ytyzvjt6oonFgXdc4Or6J3ccH4fNt0NfmcG/G7DTMFU7LaWNYclQkI0qQPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvNv38047MuMT1OoHbm3W8uzdHJA+SdBgZ4ZKn7JVKY=;
 b=xi7XJzk2DAPBJzk0WdONozqi6iEUqs6xJLKjY5O5XytwouHfOayh8A0D1kj9x2Imsvwv0+wLdT6aCKJe0hDZ+E+8nwSOxaUTZ5jsq+0bo6fX2c0NsGvKS6xPlKlgW7O4VsKHxFd/Y+UT3oppFiIUhnYB53gK0xfBiSUeDE7W6PArYbCD5EnRGo2CO/5AAeM/fLQsWVV3EE6821vuY5Ax0zNTJMSs1cnJ3Yeei4ZOi9Wh3iUlU6LW1SeSeGM0DOFdupS11Zg1W66XbwzMtCI6ix0H8+3DMCBIuF5PnWYq7Ibo2mm8mnhOa0fu8vLZkFfcNouq4ZnvEzQA4EfvYdjHAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DB9PR03MB7179.eurprd03.prod.outlook.com (2603:10a6:10:224::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 06:50:52 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 06:50:52 +0000
Date: Wed, 8 Apr 2026 08:50:41 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: openembedded-core@lists.openembedded.org, u-boot@lists.denx.de,
 simon.glass@canonical.com, Francesco Dolcini <francesco@dolcini.it>
Subject: Re: EXTERNAL - Host GnuTLS now needs pkcs11 support
Message-ID: <adX6wVUWvNrzYfuV@mt.com>
References: <f5ov7deig7xaovxmtx3nhewki6mudgebahghknhxodlfa3lrdh@ary63d3fodkz>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5ov7deig7xaovxmtx3nhewki6mudgebahghknhxodlfa3lrdh@ary63d3fodkz>
X-ClientProxiedBy: ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::6) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DB9PR03MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: f419e073-0854-4fe8-6275-08de953b2cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: GEKq2mzvLtC8tBimtFj4KJk4QbrcMl0cXQJk8l0B31tebHBagWik0eIRBbwX1G+0a6yi1Nu6VfCmAI8vo8eyrCMjKtwAHO+irs+hRozX80cbMmOnBLz5I5UrCoe6llcjL08Zz/oRRyYbFO1pTKkr4ZyilBg8BHiAZAT8n0pegxy2kyuYCVVFff1eG5NasBh8tePpq6l0mpH1XOoGUX75PtXc7QYT0Jv3/OpQJ92NYu3mu7qXfkqbnI2NMBoONWUOvDMUAABMKCATQviIvycYcWDPEfoZl5fpXk92F/sH9/OruIXl+qaWw3zLaiBcONIbsTDOAxJ/DZl6KVKeJLV8MyThqDPjwimy9GnmXXnU3skCeGlQ1+LvSecArxNLDeRYdvOSGJAH9a5RbE6KpZMRyoDBt/yGXd+RIWdveYS4WF7q+ruUggcZbge7YWk2hEPTws+8rwUc9RxPgWgnCtt13hdHcLr2BBplvsOs8psHDiNkwQffTMPsXmRdcrbwEW4FS7UAfRj5Zel82i7Xke8EcBXPzLxe0pdBsNPnP0SEhJ6FKRIPZepSaeLSECIBujNa5mxNxXhmWlcdy5gGCHP7e4TXeoD5GXKy0o/v0YiI2ZN1MdEG14ilcWq4JLjx8QLDlGO7QY2ExrFcAIRazqVLrXIGeaIVaPqMf68gmwi/jUUhx5+wN8ecjg6J4tlJbMFvjETTMSfYfzOI6x5wTeWvc/m9pt38z7tHZUdKXeih/SXgPYoUCjTwYwqJUcpBoyO+RpeWdUG+SdZOszqbmrXPEpkMAbPL3Z7jzXF44VLtmT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?W1iyOekNRQLyJp7foRufgwwAkcdXmWBA4n+gF4MdAXooUcKx67RMsp6Ngr?=
 =?iso-8859-1?Q?tZQ7cwtlwL3/1XLuUj4Gwu09CrO3ON1AuSHyL94qZgfxFW1Isk1szIFtu0?=
 =?iso-8859-1?Q?Xixtj6aKPECfL1PFWvIEbCVYHAzzA6uaz+mE7KeiJpIr73pejn3JZjKYqm?=
 =?iso-8859-1?Q?+SONEIeQzh0ruD8mrHB7PhzKz2GRYCKIGS0pcU6zeFxR0nNOAsXuwhPj/J?=
 =?iso-8859-1?Q?+HJRILYGd8vF3ptK3GXQSZJAtYDXY5iLoYRCaPhU3nL99zfzm/u7ff53lT?=
 =?iso-8859-1?Q?qXoR6YlQjYXKkLwyjr3xLig6/67nyh5ZLGEDQ6XvCcnPe/Fdwrr5xZ4Hnf?=
 =?iso-8859-1?Q?8OBj8Lg4lSPRMVq6pNcuzWs1dFYLsA1DVw9NPxCScyaDWJVHkwbF5yWF2y?=
 =?iso-8859-1?Q?hJ5MO5wyAR5//vX3VPPr/q29Nk6e6ok+nlxFc1dne82DTxPoSI72hPRvxk?=
 =?iso-8859-1?Q?ZDfr2nU4G8eLQKY9XQt44GaWoVzn1kImrjXiIUml8iFq0IsNQHHHuCB31K?=
 =?iso-8859-1?Q?6aT3WN5r6zLLX5gtIE5RD5kAG/lHVuAcMADKwB0DF1tD7umX0xSIrtFFsQ?=
 =?iso-8859-1?Q?O5seOA6F6Zs5Kya3A4xasGF/ei36YA3E9BlXqSMJ4bRB9o1mcda7uptQ2b?=
 =?iso-8859-1?Q?ZKdDMW3G41bJTo8x0xx47m1RFzaYU0mM08seSg99uP96i1AVHnhkomyTaC?=
 =?iso-8859-1?Q?EW+9JhwFWcMjt65YeHBT1kAkU4UG57Wlgnr+TIJAj+ozVvkxsDuuuhfQcI?=
 =?iso-8859-1?Q?ARYdJuWnNw/rpvSNiGhzVzJruVulehpGAGe5diZ0N7hmbhdzGd7Ou1HvA1?=
 =?iso-8859-1?Q?zPFJiVn0vELZ+snR3SVoq1IPVoZtmtM4aKfqPIX7hfMjoQcyc4swpbUk+I?=
 =?iso-8859-1?Q?ydj5cT9beQZMW91had5nfBzKAExmtS4X18mrPQNyh1JzR+esOC/uX7Q+BM?=
 =?iso-8859-1?Q?rWCr//2H38JWqPe1Wfc3BkDIoQLGYU88wSxj1K2C7gPldK5On/1ZVCqOjC?=
 =?iso-8859-1?Q?+iGnuxlZmeLz9+Wh2zZV9Q1NUo6cdJ3tJzzZo4v8JH43yf7hgmMWFwrpiV?=
 =?iso-8859-1?Q?603oem1YdWUsaGdHbcFgNFYmDJFI5KfNHhogBjSVA52u7mSnn5oEvHuGu8?=
 =?iso-8859-1?Q?eSt7NZNBsm7jjo9iZG7qrE04dlwcmg2pldvcdX7km2wNLoom9U3pTlz1KH?=
 =?iso-8859-1?Q?JzMcbNpfdqwlcOSITRhjn7rLLuEAwJPqZGc5Gkw6wZ19ywAAuqdi2+Fx8z?=
 =?iso-8859-1?Q?/leZ3W1qUGKu/w5rBJQjutFl4d3XpZJNNGNqOFjyn0LVBnyQO+pHAPFboq?=
 =?iso-8859-1?Q?Ua7lBHJwlGZ7LVFPFDtPS7AxmTfLxCo8dUl0V3a7v5vdr55Ptw3sHiqPBC?=
 =?iso-8859-1?Q?bH8mSIV80Q+baTv+36lnGIR6TL8+f0uklRROXPPLt0ue3rfKOVYl4QEm09?=
 =?iso-8859-1?Q?yp6bZJzwHqM5XPFcUOMs7hZWgB4io0R23iOfvObOdbJ+vnZEt3YsW0NQfw?=
 =?iso-8859-1?Q?XGmhXA6IgKy7hr1xL9akyqsEni8CNyf0iQLQjB+SuIdZeY43gb3Vdj1Zyf?=
 =?iso-8859-1?Q?uMqwryTvcfIujdQo1RQGzTClBnLFwSRy6toTVsm79RZowP3/ULDiY6uWYM?=
 =?iso-8859-1?Q?etzBN0Ih/muZfeLUf2JGEcAkCQOBYiw4Q3lIQDSDj02TvACikdXwfBZGeg?=
 =?iso-8859-1?Q?1HudWdzbjZ+gFod8io+WZEfF3Kkwk7VhdEmRypH6JRurlYASxhGoOk75/h?=
 =?iso-8859-1?Q?sZ72C+OSxB1h1mLjBf+KEVthR33iGC84HfFFFGUEW9kQ8eAnKeAUgZNEk/?=
 =?iso-8859-1?Q?xRUjfxsGCw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f419e073-0854-4fe8-6275-08de953b2cef
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:50:52.4594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73rXUULnDqoKmSldRyzFEyhe/bCMlJ1SBo08g1b0qj+KbopnV/HUQUJgUjJFOBugaD9qMqf6dfCjuWAH4n/krg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7179
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

On Tue, Apr 07, 2026 at 06:15:13PM +0200, Franz Schnyder wrote:
Hello Franz,
> Hello Wojciech,
> 
> with commit 0c716a157be ("tools: mkeficapsule: Add support for pkcs11"),
> mkeficapsule now references to pkcs11 related symbols.
> 
> This breaks our OE builds because it causes link failures for 
> configurations that build mkeficapsule when the host gnutls is 
> built without pkcs11 support:
> ```
> undefined reference to `gnutls_pkcs11_obj_list_import_url4'
> undefined reference to `gnutls_x509_crt_import_pkcs11'
> undefined reference to `gnutls_pkcs11_init'
> undefined reference to `gnutls_pkcs11_add_provider'
> undefined reference to `gnutls_pkcs11_deinit'
> ```
> On the OE side, enabling support in gnutls via p11-kit fixes the failures.
> However, I wonder what the cleanest solution would be. Should this new 
> host requirement for pkcs11 be handled in the U-Boot OE recipe,  or is
> there a better way to approach this correctly?
> 
> Any ideas?
I could add disable compile flag in mkeficapsule if there are no objections. Sth
like this in pkcs11 places:

+#ifndef DISABLE_PKCS11
                ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
[...]
+#else
+               fprintf(stdout, "Pkcs11 support is disabled\n");
+               return -1;
+#endif

This way OE or possibly openwrt don't need to patch.

Regards,
Wojtek

> 
> Kind regards
> 
> Franz
