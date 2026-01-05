Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EE5C2A075
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 08:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9728F83A9F;
	Mon,  5 Jan 2026 09:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="cBt/D6+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F09183AB7; Mon,  5 Jan 2026 09:48:52 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4501883A3B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 09:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0UOu6GBPVR/yQECk69ceTKdjgbo1ti88zV7tEBzxi0V0J1PLEYb2rdU1CTGPc8dkZr6z1JW4std1Rct7jYsQxlXsmZEWkvzKbW2JLTfJaM/U8gyVEYE1pwbEnMMJPsbzbOcQj8X+MRsbNdMrNs3/FtSpAlckproArmoofKO8MKCgRm2RAInhEwD+Msg4xv7+E5jtYzqdudAPOFsUwcC0W0Q0DU4szNkxj5oHussofpnoVN5sDdKkzqqERHVvGWtMveKBcFYOEzY1CVtMdxnqNo9Gh0vAZsyyY89PGXv2fCwkG+WEz5q2bDzneZk+uITSyAoeNJ1cJro+PEfwkNfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpkNJl3lZ7wKlTLUKmiWhhzSrfWRWu/W4D+Gdh1Bm38=;
 b=gAJBOLm+Z6FrtIxElLMebSVm9pBdeyv+XPGz5gtWx1q+qtAPVgRdklWnsGh9SOxdsJwNt6BTb6jzklkB0c/g3lVjDNslaXVNuq8ShDshzjqG6pjToazolqrPUKq9Zry+FB2741DF2YBHts4Hd13FYKfxeyoMtVivtcTne8COecN1xbxDgSbfACaoaDnACxtW6J56JTtvadNlfTqyYv9J8Vrhl8RiyIjdf3Pe70jpF6s++YoS1mBJoQ0AKIZPBzUZjKMdGnE4u/RSuvrfs+Cn3zEHV4JNXZGJ86AZAVam28ObIubVAuJD/kPdcOgooXOx4H5Cnbdky2W+kSVrPxdDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpkNJl3lZ7wKlTLUKmiWhhzSrfWRWu/W4D+Gdh1Bm38=;
 b=cBt/D6+PqNPuLuVJbc9yx27C0NlVH95ajQsFsPPG9d3K3SYr8IQB6vr9GDBfqVQqqXJdYw+KYnJicWyFpAiztv8j2bdOT0YtI/2YKxl2veZ558PLGYHDIpYvDEqWKZrYjtV7SIOIyli5CBz3er5FqhfxBIf9IlAd1FpLHsnKJGF1tEVHKVPsqObDT9llm5yZ3cSxWXy9XMFgPX4FZRYkh2X7nLPzOL9/oMVwe1loMoSiVF6LC9g3oPRdAZZTNkw8I1nKs2d6DDLzBK/B1cTgAnYwawZqYPgECZ2KWPMccoJJ/5cj2yRrTt+Vv6YE9ZLug2kae/2wwheol/6WsC3BDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PAXPR03MB7885.eurprd03.prod.outlook.com (2603:10a6:102:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:48:48 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:48:48 +0000
Date: Mon, 5 Jan 2026 09:48:39 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Simon Glass <sjg@chromium.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, trini@konsulko.com
Subject: Re: EXTERNAL - [PATCH 2/2] binman: Accept pkcs11 URI tokens for
 capsule updates
Message-ID: <aVt65_RL1KF2myTM@mt.com>
References: <20251216150841.331408-1-Wojciech.Dubowik@mt.com>
 <20251216150841.331408-3-Wojciech.Dubowik@mt.com>
 <CAFLszTjfwkAdc9LHvq29Y=hFtZcoqJdh64LPrBP0AJcr0VMAgw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjfwkAdc9LHvq29Y=hFtZcoqJdh64LPrBP0AJcr0VMAgw@mail.gmail.com>
X-ClientProxiedBy: ZR2P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::12) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PAXPR03MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f2ab68-0f20-41b4-0e0d-08de4c373e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p5uUfsJIKDvfYyROwUkUZEhNDZZnReG3ym6UkfbVciZ56eJcRhUQWxjJX8/i?=
 =?us-ascii?Q?Td0+H2kWfgihX069OG7L9dfzt5IVnxbvWMJE5OKRAIQJBZhCHkSc1E5gpYRs?=
 =?us-ascii?Q?CgbcMlfJ0F+lxU3xxrVvrnMyZJJiZBCN+ZwT+Pg0iXCkgxiLbeZi6aQDdgjZ?=
 =?us-ascii?Q?nuo9FISB8LstilQn2fWV03QbYElNZ8233Ca4mSc/H5xNiSX5NKXCKfxFqzRw?=
 =?us-ascii?Q?w5mLW5Ijui2sl2tvRmFiVY28Qin3AswNJH2HFCunyKWZ4hT9scVWk5eLVmEr?=
 =?us-ascii?Q?zztHHnwu9J3xng2/oug2LcACUzQX845niwT9iKmeFGORTaUHeaoVW66x4M23?=
 =?us-ascii?Q?hAdvcXxZ/pPHtd1SPotXyFEFyBrStKF6pW7Oaj2Pk1KjGIN9cIh/Dzjpl0o1?=
 =?us-ascii?Q?V28M7Tv+Erh6+rFJdhCnhIn6hC93TWP0Eep2lDBtnjjXlGCVMqdhKJVmh63A?=
 =?us-ascii?Q?Ox2CubqC/lH9yVb3pUs/zAfr11HHUJNbr24DrI77jmHr7aqRMZaBmEsvUcoa?=
 =?us-ascii?Q?nWfZpxH4t9kbuhI0CWlFCvOUST5776VGue/u29bKwpCpM7H96LsFXX7YnJwQ?=
 =?us-ascii?Q?/aeQg3E/vAz4JeFHoOcMxRFLyI2o9Zwn1z4Fc4/cQFhf9YsrFlXRWy/Y4gMM?=
 =?us-ascii?Q?CNPHMQWz1I1vEE7+FZze9YJPVchczyrv40FmaWTko14owMEI1cGZHMHdytQV?=
 =?us-ascii?Q?o3EMbxWs5eB0fa+sVacxjiTlyQP5MlQm8gt5vuEBNDk0Hk01KOIGkOfHerB7?=
 =?us-ascii?Q?avdyFpko7ckI9NRWWq12plSwd6/ktmTuyGanEF+YAtdUMG+7MF+tuzUWZpvY?=
 =?us-ascii?Q?n1Xa01MBBrkwE3m110uIDePjPvsW/Bs4lndmZmtqxenhFcx6MwwClWYvhzt5?=
 =?us-ascii?Q?QW2A21Ajpos2FnHjuu4IxTMmr2Y8QZOq6lvyeoSuJiFiWHj4zBlK9yoTDB+C?=
 =?us-ascii?Q?BNly0dq6ORHlQV26gRk2FeIOKwOj532o9y+x0yWFUm8Sd70QLwKr25I97Zfm?=
 =?us-ascii?Q?inefQgaNyipkDEezms+MX1ufDlTaBFHZaZnWSatWy7iki3llS4SQ40pQ38dg?=
 =?us-ascii?Q?Oe9U1QflWahD8SUV31VvpCnp+xmNMSwWeBecP+OxVA6DlHlm8SOKZOuZ7aDM?=
 =?us-ascii?Q?fGv/Rq7TGmsif6zXqOeclXLU+rAq09b9AV3EfMDho4hGZfhNC0NmFLKaOpQH?=
 =?us-ascii?Q?bVnGwXDmzjf8YiYGHFTAmhjx/vlOpQEFkWkgaVDEJs7nkM/RrJ/BsP7FCyU1?=
 =?us-ascii?Q?RDNTRA4MtpTYbM67p2bLJN3cwkx3KjAlKSZb51gya7bPAh99xJUJ7C1SMUHB?=
 =?us-ascii?Q?mBoRHSBJHQqpcaGj2vpqYrTxoIiyVF+j7c9ymQox/tq8ZruuLkWy59mI7cma?=
 =?us-ascii?Q?0Gro170B8CCbg+4EBZnZA20EQJL1MpJA+zfgWg4KnYUbK1icyjXbr5DoX78k?=
 =?us-ascii?Q?YRc3I7pHZWIvHsEwAzsiJNr8w9wlVe0ZzYJIRGiQ67xPh1S3oNUNejWNgEwg?=
 =?us-ascii?Q?bYnjPzq81a0aoZj6gjofRUgoWcpGkGkjEAmI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJsEg42NCKEmpx4sVJO55Ejmmlc67yfymgqy9grh1S5nxE9UomsW11/Q6tGl?=
 =?us-ascii?Q?PvIFN/Hit1MXtwB/LeM8QHyarKOOU8XzM2rWwuJ3OEbMr29dR5mV0jCe1I/H?=
 =?us-ascii?Q?kQgQEewGy4AA+1l6v/s6J9cRbFBjDB78poWgDVQH95TooWJJtZ9Y2YTa5O/r?=
 =?us-ascii?Q?3RC2qwZWCvHD0Dp41w9E6KCmaNgDHp+htFsvX6Ny1ZxSt/rKtJHhLpA+ownK?=
 =?us-ascii?Q?R10VXbljzsJUsL/8V59f4GTPi4tpQMXc/C8qK1L9V5a6oPpGA8EeTjLYlb7v?=
 =?us-ascii?Q?/qRg8K1NVjORKxBAWEs2DzIoTR/V8V/behHOtYUUYIWRo2mYN6xeVN/nHVE9?=
 =?us-ascii?Q?H9XszF79P16jYb4hoGPu8fdOb5DyqjRmyOuso+RU0/VX1Ge8TMirafWfSaHc?=
 =?us-ascii?Q?TV1FQCRpHnR6pMvjJYODpH0dfbJiI5DJhfQvqrp83K1wZFf2hpj9nTVu8jKc?=
 =?us-ascii?Q?/w4rKxLMfJ5VI+g0TKCLwo35W2axLah2X9nAqukCRP08ZuwUV3Nn1ym95izx?=
 =?us-ascii?Q?zmDqUFGbpLnPKX5umyIRllVj+WSfX5MW4rbS4BbdLZy0gajlNXwbipSaXYKV?=
 =?us-ascii?Q?HBcruIEtZyNt5MPk5G0h1GbL5XXvw5CZ6p32dT8hoOikXJJu8GJiFm7nkAyz?=
 =?us-ascii?Q?16zxqtDqFAxaGAHlkej/w+M0U6/qhpIphbQEqoKy4Q34Fx9WRms0R5bw97pV?=
 =?us-ascii?Q?j+ZZlnEI5cice1L/7Qj5G4oLMscDotTPNzR0EggsHyAfp1r18Lg9LQvcOEZ0?=
 =?us-ascii?Q?zww84JVrziI5LDcupvBkOo1TkLOMfwUx8SkMvj6ydphspbrG1qe0ZRqA24A+?=
 =?us-ascii?Q?8//lM6Rajdc8L4qbOrjy0W7MovrrAQscxn1bkfQyPZN1DdcA98Avvr1fiGD3?=
 =?us-ascii?Q?Pg922Gw2vVnyclmS+Uk8txBQNS1dxtTFTdpckR1wU3+SpS2fSa/wrfL0+nJj?=
 =?us-ascii?Q?ORdyvLheTujrhvevppNGnqWIUWvjuAnJW2EK5lDSU72/R92FGxBPh0Uz4HF2?=
 =?us-ascii?Q?tkihJCAVi5C24pVpQqe3IQPHsYFC/KwSFa24xSKsJ9Jr/fER8pl267Ku/VOu?=
 =?us-ascii?Q?OAQSxxOmceY4JaFvHURi268+J3WEmf4G4D9LVGlTLvrHpAVpouDOxZ/IPLqa?=
 =?us-ascii?Q?nWIydcFLykYlwpWXhmMlbGvZEomC+cFkO10Uf0K2pXoihmQMGebraT3/lvNK?=
 =?us-ascii?Q?P6nZSZ+qpCBzLwTflHtPNbL03ROrKoT5fzvmKL6JA+gVx6uSpDq3FoKx/7Id?=
 =?us-ascii?Q?4Y8rXw+OVtymvaw+vol2ouAjxbtl59rMkwEp7VLZZ/TiMuES01JG6d43+hlz?=
 =?us-ascii?Q?/Bjo7gHwr8UfRa5oMskAFaPpqM0b476KySOvgXU0wi4rNrm9vXYAeLruVjoR?=
 =?us-ascii?Q?W3Qaeq9CXA/ln8KeBLfdvkRTdzRFVAQG0tWbPA/exiub5n2x+L428hYMvlyk?=
 =?us-ascii?Q?SfshcY5wNjtubux8uAevEePUPWhH1aLC+pC9KdWZeoO1nTv2W7Ov/s2mME6h?=
 =?us-ascii?Q?K/B7/el+0BUXpjBwnjxFw1OvYtGmnLTZxjT29FVC/8rqUu+Zid2R5Tc7B2g6?=
 =?us-ascii?Q?4Yb6S8p0CWjgxfw5N4/TDuRvi0iineWJoYw1PW5wATawik6OllYSktgDZkdI?=
 =?us-ascii?Q?1kq2t9ZGaxWFaEnd+8dc4d8RabqFyOls5jyjeKmJAwJQYPFxWJ+tLebWXYRU?=
 =?us-ascii?Q?/bgsdPbdoVFm68x99a80dSrjMZiT4aRB7odXU2+el4Qs8tUg0R8ekBbQoC/u?=
 =?us-ascii?Q?HdcVBI0e+w=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f2ab68-0f20-41b4-0e0d-08de4c373e35
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:48:48.4627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFpwSOyl456tYWasgOa+Huu5TAipFX+WrN5MxyYr4cKmd48T9SAp4iqHZZvBxK6XGc1KvfRgNCBawBtM+LVbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7885
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

On Sat, Dec 27, 2025 at 07:52:36AM -0700, Simon Glass wrote:
> Hi Wojciech,
> 
> On Tue, 16 Dec 2025 at 08:09, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> >
> > With pkcs11 support in mkeficapsule we can now accept URI
> > tokens and not only files.
> >
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> >  tools/binman/etype/efi_capsule.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> > index 9f06cc88e6e5..8ab022915d9d 100644
> > --- a/tools/binman/etype/efi_capsule.py
> > +++ b/tools/binman/etype/efi_capsule.py
> > @@ -125,9 +125,9 @@ class Entry_efi_capsule(Entry_section):
> >          private_key = ''
> >          public_key_cert = ''
> >          if self.auth:
> > -            if not os.path.isabs(self.private_key):
> > +            if not os.path.isabs(self.private_key) and not 'pkcs11:' in self.private_key:
> >                  private_key =  tools.get_input_filename(self.private_key)
> > -            if not os.path.isabs(self.public_key_cert):
> > +            if not os.path.isabs(self.public_key_cert) and not 'pkcs11:' in self.public_key_cert:
> >                  public_key_cert = tools.get_input_filename(self.public_key_cert)
> >          data, payload, uniq = self.collect_contents_to_file(
> >              self._entries.values(), 'capsule_in')
> > --
> > 2.47.3
> >
> 
> Does this have a test case?

Not yet. I have seen that pkcs11 engine and softhsm test framework have been recently merged into
next so I will try to make a testcase for it.

Regards,
Wojtek

> 
> Regards,
> Simon
