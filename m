Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540A9E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDD483CD3;
	Thu, 19 Feb 2026 14:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="EIy/Biph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4E183D0F; Thu, 19 Feb 2026 14:23:40 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5432383AC5
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iayvClGj2qbXc8mqi0YextPUqMd8P1hPyz7gHIOFVJsAUPPTxtmFO7iAQJ5TtNdfvogJoBkrYsOyhXtYdRL/07CPZ86q9eQRSN5RcTJ253OYOZHXX/pFAwqtaEeAWD8///RaOupZtV12DaaTY9aIRDENNRCM3N1J+BPAAUgWrgSBxhe8y/8Z57IjK2yDZz4L/BFqZj5u+6tUU/Q6HUpoSLBBZynNynvXdzfC85kpMEFPXGQ2KPdAjvhbyTl2oTo29KBnZJdqW5j3zPj1OVWjuW6i5MMrB8TdaoGyw9gAX7bVeNqqlZMQTFXKNyseg5vW/rZkK+bsHnk9b3zrcLnJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlgfD5/OcgJZa8Yk8Cl6CRBTqlXF86qadTWd3JwMs/g=;
 b=d4yNAIroK8yX1n+F5XUaZCZkToee303plJ/ehmsVAFR82a0120xjiev1wRV62NeTAF66MAGb5foioMO8zjJci5FPa/Er/Bga7SHaCf2w1fhTKBx8VKVARlXHUwRgoVYQy6Y5zctFaTpw7RZli509RIDeknprlK5Qgzp+MovmokwzRE3XROcfx7hXpqyK+32Hf8L1QOlsWAHA4Ac3DDb8koDQsYnkyUBTt8zJqFYDwT88k/nNw6GaVyq41ur+/LEOLZSr6mH+0PgajO/14fjcathXlxgyeQl5CHYNIajmTcyETXYmUPu35Av2DHVL+vdKGsDNZOjxa5kSalXHg8b4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlgfD5/OcgJZa8Yk8Cl6CRBTqlXF86qadTWd3JwMs/g=;
 b=EIy/BiphlWMr6uGM3waMGDpDnKlJn3Nyn1DxJBBbU1nMnVkyvsUJBuihpRb5ely4X2DXFISdGMVY7xD5cXBxrhOd3cOnNVCU7Gv1O/8Ed41xDWha1WLkAN1MeXwbnPZGTw28jy39Vm1rCK+wTqt3Peq6Piy7UGPFEeiRjdaVBPMDf9O+ne6H9RzU3ED7JN8s95kus+jCVBiBvcY2lK4WfcEJxda9UTyq/rji20o/rgQ00on4U+doHXGpNG3k02Irg80iIBfpf4/2E54u9mwr26CuMdhxmeSDMCJSDFbq+0dmC1yKHSgUzqYySmUNFq08iR+kCrfCaLNzrypcVU90zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DB9PR03MB7514.eurprd03.prod.outlook.com (2603:10a6:10:22d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 19 Feb
 2026 13:23:35 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 13:23:35 +0000
Date: Thu, 19 Feb 2026 14:23:25 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: Re: EXTERNAL - [PATCH v6 0/6] UEFI Capsule - PKCS11 Support
Message-ID: <aZcOzb-jpCY9oC1i@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
 <CAFLszTiexKf9VhSvKC46QrJMW4dy9Uc2ufsG5AyWvs0e1D4aMw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTiexKf9VhSvKC46QrJMW4dy9Uc2ufsG5AyWvs0e1D4aMw@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DB9PR03MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: b08ed231-ab4a-4ee8-da1e-08de6fba158f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|19092799006|376014|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T1Dk0vmjTD7Eyom6+QtA19KuZWi3AP3sQxy4+pcSjp62W4kc66xSibREIbDn?=
 =?us-ascii?Q?SNKyATX4WYAlYNpON4JuLIamr3uOw4YSwXTTmV+lmTqRhR07lurKDeBHpeoj?=
 =?us-ascii?Q?8rbB2go2105khpVl1B4u9BDLc6OKnz1LpFbUeFbCkon4ZgzVmc5ljB07WME3?=
 =?us-ascii?Q?aFXD4ZEXfChNN0mynQ/uCYwJBLgPW+wEpcPg9JhhjHNqyUYyViuHNZos4Nl1?=
 =?us-ascii?Q?fb0fGp3BzvI022iJjJiQYdNeTBvuPRp+3bhO544EXmu2FHaukACm/YbYdJcG?=
 =?us-ascii?Q?3YXKwMFov/wmH1aGoJ5Ygi8dE4AQhRqennlz75+sTNu5fbdnm4kwrlF17oA3?=
 =?us-ascii?Q?JnMFLFp5YeRZwObn+PNnxIHZ34OdwhoX5nYiCqNGSGnQKkxQHFt/34RgfpHI?=
 =?us-ascii?Q?rzCgskof7l/bat4PsWKv5QJD1e9CXmFvRAHgaS4bZZT2GLJWKEzCx+zZuReb?=
 =?us-ascii?Q?Xz1WcX0VCh+eCtFw5T7r+xhjgDEjTdEzG/vgFh8alGdXp+r574W4ie1XpJrs?=
 =?us-ascii?Q?vCSjvHS2xJ0LGWDN/I7v8ukkvVzat9I5iqhH8fAdHdMQVNEMTdKgEGX+gbMw?=
 =?us-ascii?Q?7hCmQKDlr/pzoIbDsOepJwXBXtfacQeKDHawJ9pp4f+dTMC06S4rwNoIT6Fk?=
 =?us-ascii?Q?nPllDmp80Ob5TEICrbF71eOYK3zN6g+hiw9axdPCbORIIio10NbiBCc9uRa7?=
 =?us-ascii?Q?DaF5P/eSzjgKwNxxltJ+7rxo18Y4Rdep7lK9nrYF1w/+1ZC2qmGpEthFTAlw?=
 =?us-ascii?Q?7n7SjmQ6sy6mkIOF8FyH9D0T7IWhGRZwC0nXbfQWFT7pZ/MXEF+FdnlTW48o?=
 =?us-ascii?Q?iLVze+GAm03LmRZizhp99dQIz4bXmFqvS7beDH9Jckcg9omeRwuEkRcIRe2W?=
 =?us-ascii?Q?FnExpsXCfdFGsADhyujeapM7qVZGXPaRQCLAhTF0OBhzdQNYMvG3r+jXDoJk?=
 =?us-ascii?Q?fSnLsA4TL50l5wcZKbyHockH9K+6cnTGnZnlhBl0ewfyTQi8rSovyc+HSmXK?=
 =?us-ascii?Q?sxhyjgT244rt1l5QWOo8gFXzKprW1xXjfRjFXu5R+Pp0Ke+niySeF85Wnns/?=
 =?us-ascii?Q?6w9jtkCy4bQh4TmPKYcOD8ES5LNxgVp1el/bksrAe+MKRo/1XesJXwZeQ+P/?=
 =?us-ascii?Q?6JKnAXBd4qmUNd5IbW/HOfEk6vIcWBZsrxouR8BZ8Tiux9ERvil1JJgyQUqb?=
 =?us-ascii?Q?O9jdNWcnMVztu1Mm8yWTqQ7Abj5NJtU5FdYt9oeONaM0cAczErkaSek05FBx?=
 =?us-ascii?Q?Bq2XlFTFmAbECn6gzZsNEb3WUZYV4PuW4m5M4XVXiAGzrsDnFmLL2fRVIzMc?=
 =?us-ascii?Q?cifcdZ3g6ESGPCqrC6Jj4BDQStbwYKTuHQy8bwVjuDPXuTeYNL2aKQqRnBc5?=
 =?us-ascii?Q?4qIYOP52BDmjfOohU0TbfP+5emUOoZzMiHZ2bpcUTNWXU/XHXq3Ng+nmTVH+?=
 =?us-ascii?Q?Cpo4rPLw2cMwMz2AURRZp14rxw8t5ooZVOD+eU0EYcuC+TYdhpsvjczTaEkv?=
 =?us-ascii?Q?Pqrdi5RSHWKe+7WzG0jCcNRBELWyzDQ+tNPe/da+y/n9S7RwAfYU8DoEBoqk?=
 =?us-ascii?Q?3dhEaPIBVe2d+IyrcaMNrHSVZVE/HCDZfrediTo12AbpYO909TAULTaiAamn?=
 =?us-ascii?Q?lvbL/l75NzvjcBb/DrhQ4e4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(376014)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LIWqKwfpKZcG1lGwUrDNhNFek8EpDYGaCyHj5MKiUubTs40uaIDBZHsEFdc4?=
 =?us-ascii?Q?M+4edqmIPuTHAj+DOtEi7tWBgUmxOL2iK2LlPzxejsbc5ThxHiDssk5AuY/2?=
 =?us-ascii?Q?rSHY02qHH+IxshA0MunSBbTV1a12M6Cs3MxnZkWyIQu6NGMSsxlYlMPv+KgO?=
 =?us-ascii?Q?IfAmH0JMYkYXKkYZL4uWOF/rGfgDth74AFshSKWBtS/RbxyZVCOL82+MDh6L?=
 =?us-ascii?Q?QjvuUGm0iBYSOg031lGKxwM34+5etQsUVO3XJ4Uu3GxtQbi/w2iqmRhtElO2?=
 =?us-ascii?Q?ul+sapEiP5D3ofiUn9SG+6esQ7pcq82SwxwElBiK2MJ78w17GdSkXE52uiCo?=
 =?us-ascii?Q?gNtHMBHlQ/ZClQi+r05jmti+ZnhSXjLYiHxWVrMxJQS6kxlPnxCyBadN0dFK?=
 =?us-ascii?Q?2kBxltsiyvaHYDOi9wPtIumTa2YKbkVPSTVZuILHaXPYp1U0N6c2amA+174k?=
 =?us-ascii?Q?zKkqqW5mDx6CKWS8DPx+J+ntMklk0EIoOmbwuMpDODo8vMOazB8lV6fInw2Z?=
 =?us-ascii?Q?7/jFIzdXyIHkXNlpD7I0cjuJq2Jef4OfdoYpan9NcVbhXavzloq6jjumN3L+?=
 =?us-ascii?Q?fo3yfw1RhVWc4yPAfLP9mf8vjAW5lman4XfvWwdZefjhkrslmzL5PJYMUVyM?=
 =?us-ascii?Q?hBn5ATYg4zldNZV+ApB+o91DxJV5m7F8YRZOlTY6pwhKPEGtXiy3P+d2SrxS?=
 =?us-ascii?Q?YaxATelUPPBL0v7UxJ6NPUKV6XBQKIH4DCLwGf2bFFhhvKvzeWlxmvaLWT6S?=
 =?us-ascii?Q?sy9VLkZMJLT+1ipz1yw7i9KASh5V6oaXhNLM8XL0lsdmFJuyBgBgWRoUuCO1?=
 =?us-ascii?Q?Ml9dH/0nBQitOrCB0Dmzh1tEILjloIMnCGW7JNlxNmCwaIYM0f5ZGk3QBzhZ?=
 =?us-ascii?Q?uMCBpoYgTDX7Sf9KZ6sHGG/INPZUo0IMsV+jfZiWfSmMp9rMhquTTIG1Q4N3?=
 =?us-ascii?Q?5gYulKvf9S4Q94Rqgm1P4ZxHFNddDXdrXBeF55Nzd3zTA+3IzjdbzG64b9uE?=
 =?us-ascii?Q?YAhhlCbkgRNIXh6R3Aj6Ky58wslzUQsdGurLxp9llZWrt11e4WoGtu29FXOs?=
 =?us-ascii?Q?hg0EXx+fa6/4+R2gnB0CT7D0W8bCXKNSHuMK9Az1eGX2nPfBGBKTbEciieDX?=
 =?us-ascii?Q?pVYpI3DFERle8TlWQLjMRKc2X/sBZqImMMYX7kz0Wu9geGVX5QiSDcZDuzS6?=
 =?us-ascii?Q?Rw+G5KaNn0YjyQHYv2sBt/QI7ZLim9a303y4/y7x6A9M3QWACmho14nC+/9E?=
 =?us-ascii?Q?tSAyxLog9IfC7xe5+eUd/aoBRFpVzUaaKk890jTWuuJ/eZyf/ATCfEsQj3tA?=
 =?us-ascii?Q?fY1euqh8bX1B3KcuT/8pjQvGFOg8JeJeSIK+XHEgwXc76XnTSaQHpIL/n1OE?=
 =?us-ascii?Q?HnxGs7Emx10yLTHGnoUDpRlIFm59r16hhNJUnHPpiMut3t6MiY8n1P0kyOOl?=
 =?us-ascii?Q?TC6Dg4PFfDYexSJcBOy6FUObGwT/ksZU/M7h2xB/1d00xRnWgdP6RQitxz72?=
 =?us-ascii?Q?TEfxzgC/1hZbgjrwDEjx8bYskSOYveyHQWMD4xr7tzPeW8BLbAJjjfSJ0K84?=
 =?us-ascii?Q?ukcnHvhGJkzFkQiYd4KMMDj3LxKrvHukcY1Kg7/YdfWEdwfvSrF4/U6w4cJC?=
 =?us-ascii?Q?djRZNsc1RMygOExPRi/8NSiZhOAhorgPcv16ZGr4DXqPtLSYsIO7tmoC1+UV?=
 =?us-ascii?Q?Bg4HElQo2vtM5NPlXPgl2c2oz3gjEWVisfYniNvX5uhbP5LQm5/pARnAjpJw?=
 =?us-ascii?Q?fLXItiEb4w=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08ed231-ab4a-4ee8-da1e-08de6fba158f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:23:35.0833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4uphzOg38ZqRVju+kjimpRNIlAnedjvOIXp1OZno7C6NR6De4AnibZkN6d4TjI0GuY1nv/LvlaiAIT2g1Cw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7514
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

On Thu, Feb 19, 2026 at 06:12:51AM -0700, Simon Glass wrote:
Hi Simon,

> Hi Wojciech,
> 
> On Tue, 17 Feb 2026 at 04:53, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> >
> > Add support for pkcs11 URI's when generating UEFI capsules and
> > accept URI's for certificate in dts capsule nodes.
> > Example:
> > export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
> > tools/mkeficapsule --monotonic-count 1 \
> >  --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
> >  --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
> >  --index 1 \
> >  --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
> >  "capsule-payload" \
> >  "capsule.cap
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> > Changes in v6:
> > * mkeficapsule: use strlen instead of hardcoded values
> > Changes in v5:
> > * add bin wrappers in test for all external tools
> > * improve error handling in python test
> > * fix data types in python
> > * standardize option name in mkeficapsule
> > * fix typos
> > Changes in v4:
> > * adapt mkeficapsule python support to dump detached signature
> >   for authenticated capsules
> > * verify detached capsule signature with openssl after generation
> > * use p11-kit to figure out location of softhsm2 library
> > * fix missing long option for dumping signatures in mkeficapsule
> > Changes in v3:
> > * fix write file encoding, env setting and extra line in binman test
> >   after review
> > Changes in v2:
> > * allow mixed file/pkcs11 URI as key specification in mkeficapsule
> > * fix logic for accepting pkcs11 URI in binman device tree sections
> > * add binman test for UEFI capsule signature where private key comes
> >   from softHSM
> > ---
> > Wojciech Dubowik (6):
> >   tools: mkeficapsule: Add support for pkcs11
> >   binman: Accept pkcs11 URI tokens for capsule updates
> >   tools: mkeficapsule: Fix dump signature long option
> >   binman: Add dump signature option to mkeficapsule
> >   binman: DTS: Add dump-signature option for capsules
> >   test: binman: Add test for pkcs11 signed capsule
> >
> >  doc/mkeficapsule.1                            |   4 +-
> >  tools/binman/btool/mkeficapsule.py            |   8 +-
> >  tools/binman/btool/p11_kit.py                 |  21 ++++
> >  tools/binman/entries.rst                      |   4 +
> >  tools/binman/etype/efi_capsule.py             |  17 ++-
> >  tools/binman/ftest.py                         |  66 ++++++++++
> >  .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
> >  tools/mkeficapsule.c                          | 113 +++++++++++++-----
> >  8 files changed, 221 insertions(+), 34 deletions(-)
> >  create mode 100644 tools/binman/btool/p11_kit.py
> >  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> >
> > --
> > 2.47.3
> >
> 
> Please make sure that you have 100% test coverage now. CI will fail
> without it. If you need help on covering some code, please let me
> know.
> 
> Regards,
> Simon

I will need to integrate pkcs11 tool and make two tests, one with mixed
keys and one with pkcs11 tokens only. I hope it will solve the issue.
Will contact you when in doubt.

Thanks,
Wojtek
