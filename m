Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26676E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 15:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1298A83946;
	Thu, 19 Feb 2026 16:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="UTLCHr7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B092C83A47; Thu, 19 Feb 2026 16:23:47 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6704980050
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 16:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKr+CJ6z7w/DM3rvW1UWKnSMuWIGKygHKCBhdRRpxE2fgucpWpzZnsHC8YymVuGwgILOsI5S1XcYRcWny/cRRI7llnLRqIqF0gryJWG8HJLWntVWL5hMAQEgD5BIuqHQdbRDxaUBU94CvIIe4oSrdI151oip0BspkY9WrmQGnYJgwhyrcPIIE7p/fbezS8VSJXP2Vti6l+u9QH3ReAvDbfEwvX8U9D2Iwgeztl6I6DOnS2t8VxxawWjtrF6mBGOPbvZrU41GT0Fk5NJeJaBIyUPrOJxrx7p6f8G8UI8wWwW0Id/mnleL/uVaYCm7xXTXkiiKD2sgXmjVQoCNvPR0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3MWGobIWpunQcd6vvUMaIqvolVnwNAKCXBQ7tBIFEo=;
 b=ppf2LTd3mrtkJJqJbnqq59VM3kX2SduUDEuqqkVWcJK5AknXJROeFi0iQ00DHtS6wQfO1eBDggJdfIB0utOBCiThtTr8TadiMuJH/mTil92xa6hzMtP42hBt9CC/aCpFQjmcBGDer8lE+CVka1u2qQwxXXeAzNAHwbPgb2QrZV+T/xt17/h9E8lkYt0MGVQeuYc62GOc4TJShN5yUm9f2ZfYpvxyipI7gX2tT41LgRf8ptsqHbgqEqrKvDKsV3ZJ3OcQQtCY+1BDsNUl6/dYY9rnA8mwCGXcQ1UZ2CQ+/2VCb5GrLBwqESolZ+PFIrwhofOVowr3wqqac8yhALx8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3MWGobIWpunQcd6vvUMaIqvolVnwNAKCXBQ7tBIFEo=;
 b=UTLCHr7J0LUSRYLNlgfFZMwr7fdAWXX8LAV/CQy3jas3dW5c/SlvKuvaVOI9L/DMnz+FIJ+wMqnvHaoZJBCPZwdOhhLk86nA9W5NMmR/tyUAOK7d0SGvOvL2MlSqxI0r95jGmwvGArTp81fry+8GhDePIIWSbNib+uk1ON/f5XOhek3BI5AtqKUBWrhye+wwDhr8roUfTRoi26lMtNN0h5hm2D9Ov2vrtezwXHEEre74sqq/mmrZiDS+/hKdFaItmpUU1ELJHoYfI1lGLtUwOlvx+r8ScGn4os7H7gS1DH4k/BxXacPTkJguLsYFRv+vM9UsWtP7/gYhEqtLEGEytQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA4PR03MB7181.eurprd03.prod.outlook.com (2603:10a6:102:103::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 15:23:43 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 15:23:43 +0000
Date: Thu, 19 Feb 2026 16:23:35 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: Re: EXTERNAL - [PATCH v6 4/6] binman: Add dump signature option to
 mkeficapsule
Message-ID: <aZcq99-dMBpCNqzv@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
 <20260217115333.503359-5-Wojciech.Dubowik@mt.com>
 <CAFLszThD4sb6dDOq_8-XJ-QapoxbuHOZJt0rRJBeydpr6fhFJw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThD4sb6dDOq_8-XJ-QapoxbuHOZJt0rRJBeydpr6fhFJw@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA4PR03MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 25da6915-4815-49b3-41b3-08de6fcade1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p48efgyp36judIybWCZBmquyN/S+Q+FhVDGfiX0BySon5wDPT46mN2+jy/3F?=
 =?us-ascii?Q?EA6dXBYdj6Z18qbWWNlkcPrXJJWdIcTiXy0h7qO6hLMm/7p1o3URtJiQs2DM?=
 =?us-ascii?Q?s1jW67e55+klwUjl12POcuG3yyoixRG8eG0CFAjF+JGppT24htDxY+js2zYz?=
 =?us-ascii?Q?M+k5dYrJ4fpb0frdQ/HiFQs9y3z54H94MYduus+ecb/TQ7yElevxVRHakNhY?=
 =?us-ascii?Q?MHYn/qtU8zAVVYXoncWB24IyLhBhOkk3sTBl2FU6oGNfAOZLdmDfrms4F+dv?=
 =?us-ascii?Q?VdSE0DK/qUWgB8kXHcVGZR0jKf2SraPhsPoe4G5FA+lSsLPTez0q8hpxs2ES?=
 =?us-ascii?Q?fQMHpBMGZrpD5bgCxPqmhW95FV2IgMOLRGTiswObm1J9BkXnASs8K8Bmk1Mj?=
 =?us-ascii?Q?Sxb/egDy3RNDwySglQZCYwFRN48K3Xha8jDRCpEKWDWmYYJ5CltyC5WgqbAY?=
 =?us-ascii?Q?fmiTGcdf/tdWgVI/MCa3uh67ALxP5FhkhmPLaElHcvgx8uR2j0AFaT/K9wOY?=
 =?us-ascii?Q?XAFfGVmOltLBCFwPXrNzjU73vfdPOBf9hUQLat9UtrcMZxc6Ir3WzqTQE0ne?=
 =?us-ascii?Q?FSdfg+RfDeI09YaGyV7ynAP7+ZfeVjEcXz6MUuHhsTK5jsJgVC/Pxcd3A5Ml?=
 =?us-ascii?Q?zQS4EGK7JBU3/VtRAbItoYhxLWrWIAUc16kLO4qqfkUGozGj0xf5HCG6XpB5?=
 =?us-ascii?Q?7NqBuDWDmGwdh9gPD23ljWL4GPoPbUxOa41cZdALjy6BHi/Bkit8Hwm/YADV?=
 =?us-ascii?Q?e5VOEGyMl4DuXdqNYTBlZR6PJulzv/X6ZwV/t2fN78gp6iaA3YQKbP3aG/Qh?=
 =?us-ascii?Q?EAIRl2Dbg4oS5uveWVdl1c8RGqrsK/vD8Y/f2ccmpdywYIb/LKAtQQDjbIRs?=
 =?us-ascii?Q?PhSDTNNSmeMYffvPceZiwY/OMGhJ/LQdFxIaarR1JMod0ZOlBJii2ZaoA9dP?=
 =?us-ascii?Q?WYbA2dSpWep9MJszAYykof1gskFJCuDBikLAHP1GRuXkqNhMsce9gFTEWg8Q?=
 =?us-ascii?Q?cqtDvYYtApj5MVYBwUU6qRZDIiyr7qJc/sCvTSpXOGCt8hqxlMP5o3zh7y6N?=
 =?us-ascii?Q?RhEZeJ66g9pEN5eLOetdhgmrAy8KmU6Vb1HyX4r+HspI2UUHX7nKHoHPGnKT?=
 =?us-ascii?Q?/n4d8jXlqhrN4l8IsU8WQHk5/HV3BHaldoPIKnuzqGU6mMkcKovwcKO3juzp?=
 =?us-ascii?Q?UeB9m4U/TKlQAz0vN8BLeOMf8xdoMAFtdzETPmVkAKNcokKGfTXC2OyPiQ3L?=
 =?us-ascii?Q?mDpVXH9oAg4NG2hLgoec4W+4B3q4rbxB7H07r9DOLngfwYUHTNwyOfpcQ+eW?=
 =?us-ascii?Q?4nqW6u8xJAy8m+u5zPKGNBeBGYXEGVpx43Wj2sG71+683rT5Ot4XnTQnGLTd?=
 =?us-ascii?Q?yyXGd4oSpN1MlhlFl3FCUKLCKbXLDOdPSIwo1SGWBX0pjJzhRFMIMvAvWrq7?=
 =?us-ascii?Q?B1hWNGhi/xtjhAwOOfYtUFYLm+hql1bf2apNcrSLgpk7NDoBYjE9rK6iP0lZ?=
 =?us-ascii?Q?ZbqcBHWsh2iXPtU145QMviCt5IXmjBwMyadTyHMx9pJWGkzg8ASJiE+vL8IY?=
 =?us-ascii?Q?2iL9jg1udNYn4MR3v4DkqaIuK6hJKP7Mf17CQgAuYL7h5LFURvKYDkU+9zfR?=
 =?us-ascii?Q?qsu1E+fpzwBm2hM3VCSTTxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G8R8Zm9EoJLeg/0W22BR4SQVIHoiKWY0SCqjghzwRwYxI4BP6gv9eipxLNlK?=
 =?us-ascii?Q?xXBK0gKv1DA4px94wWxWwkEpHwfTUgn6iba+TIpCbz70zt/V30O44Lis2vVb?=
 =?us-ascii?Q?C2i4P/FKxRabgVP0UyUF+hMtFLDZr9/MxDKSY3k5q9rHHbI+c4d5zavZ45KK?=
 =?us-ascii?Q?ikxh1wf7seTw/7WvmoVht0qcZdyRx930vRpZH/P9AzVqnEq03707ZetNDAZY?=
 =?us-ascii?Q?LuVc4FZS0d2yg4P0YG9dMmkVSNE2eIszk1ROxk7iuRTVMalKAQeGTGayQR9+?=
 =?us-ascii?Q?Xof61mnMnlhfxC32OxG2ZDaNRVRspUaV2LPMxyNBLQpJFIUWrqX4qy4iXZhX?=
 =?us-ascii?Q?NfhEUqYS11MNnjTuXWWOFDqG/N4rNvLjNCVEPrCbISE6sQDWqGiWrvuwii2Q?=
 =?us-ascii?Q?fnODESXmt2mQ+7hjLpFK2JOysFSH+cVv1H1s8h2IaW3NUeXbvuc1XDGWCJto?=
 =?us-ascii?Q?S2aiD3xPcesLjGW5GJCc0vCbJUoTLPm+Au/d8DwClZ1fsx9XXVZFrtcfF8J6?=
 =?us-ascii?Q?fr3TD6hNC2OGN7hUVG1INaBmUvv+zFENW/i5I+6gYPixR1PTPvQqC/fyymuL?=
 =?us-ascii?Q?T4Fb7qB8O2ZlpFPAY3cUgw7B8VHLaMDTshkybQcEwJVTvMfplY4unN3FcAXV?=
 =?us-ascii?Q?+Bb4JYSnpaNdM6rZMwQPeoasOBSdeMe5nBZg2MSEuL35N20HexUe/41xEM8J?=
 =?us-ascii?Q?kubRdUjr/sW4iYO5BeFpj4sq/Gd+t5Gv2grHEYQlwF530Rul042PMMXFQHcJ?=
 =?us-ascii?Q?kplhfDrw3iHjIXiuhAPV/hVaNiIvsdB2dEyhrat3Y21v48nAOD0cLjJD892T?=
 =?us-ascii?Q?EbC5nLyJnIEftafyAbZyxhJZh6XU2U1UOBjE3HVgmpExNvK0diuuT2Q42ZYH?=
 =?us-ascii?Q?GynxG8vXHGHItBkGkP3UwAoERt9o3VO3i1gWaDYGcV+bF3DujZAAGsIcQs1W?=
 =?us-ascii?Q?n7b+GuIa0ZkAAPHWcjmQ3EfskF+b8a+sQ37Z7G8VGcy+8fm3eQZHyjzE5Szp?=
 =?us-ascii?Q?HiX61rjQcVnYhM87OH4+OK6VG+VeyhKnUB+2oynqhhtJa64seIOYRxYeJmzF?=
 =?us-ascii?Q?y7VjynIYy+PTWV7tmZh2frkvgpcqTj/7A5XMX9ThgZ6GtIQpWSXpjzXOZwOT?=
 =?us-ascii?Q?o6hUVp6TtaGIMHIxEdpCvDZI/atZlE9zzK0GT8euTbW6JdxAbEsAJNEPNL54?=
 =?us-ascii?Q?uQaV23xZp0xB1dBtxHTa4OT/Ch9tFUbSiwYspVS/tlZg/fQaG723TV5Kogbb?=
 =?us-ascii?Q?J8qDV/GyKKFdylLgr/vwMsBkXywg2SzEaFNvqDACpx0QXskl6uuz+ns4Q7bC?=
 =?us-ascii?Q?JTxaWD7RKJAnl5NMxyX8bdbBUSUad1Owxf3k6+/PrnJRhnGPVLDEoyyxRFxC?=
 =?us-ascii?Q?XkAHczYtUizjumLz2wovxDihanEr+F5Af//8eLcy4DSHudlETEg2Q+Pkp6il?=
 =?us-ascii?Q?BnbXfeCQJjuBDTJj9ondXQKtfYeXsOvK3GFc6iStRn5kCXuJGnejGSh7ezig?=
 =?us-ascii?Q?reldY7bXAwDuL7mSp0MTlb1+O+xXFWi72HQPN3LbGjsQz57DAmQ0QI62VHWB?=
 =?us-ascii?Q?wiqLLsLb/G4PlUqSzzf3xgS2UYzsT0B+91gJlzbAN6JRai9ABmVEmFKSNhbq?=
 =?us-ascii?Q?eGw/y2N9q3AkUKm96Ctrc1TVRCq4RtrvOxfl2pXDkynzbaQrn6DVh4P+2wib?=
 =?us-ascii?Q?kq8LVOLrmPPXlFOwPGJus3CNES7FONB/JdWwUpjXTtrtfyqllYMpqNvxEGOL?=
 =?us-ascii?Q?meJcBycPGg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25da6915-4815-49b3-41b3-08de6fcade1b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 15:23:43.4542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDdEHBOJLPq46rXvfiBkuecFNbzc1hM1tTbwolwItziCMLoZPhDmivwfljintfUqBiMaOBHuY9xfPRBnaA7RCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7181
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

On Thu, Feb 19, 2026 at 07:31:08AM -0700, Simon Glass wrote:
Hi Simon,

> Hi Wojciech,
> 
> On Tue, 17 Feb 2026 at 04:54, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> >
> > It will be used to capsule signature verification.
> >
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> >  tools/binman/btool/mkeficapsule.py | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
> > index f2ac654db81e..7638c941a8ee 100644
> > --- a/tools/binman/btool/mkeficapsule.py
> > +++ b/tools/binman/btool/mkeficapsule.py
> > @@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
> >
> >      def generate_capsule(self, image_index, image_guid, hardware_instance,
> >                           payload, output_fname, priv_key, pub_key,
> > -                         monotonic_count=0, version=0, oemflags=0):
> > +                         monotonic_count=0, version=0, oemflags=0,
> > +                         dump_sig=False):
> >          """Generate a capsule through commandline-provided parameters
> >
> >          Args:
> > @@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
> >              monotonic_count (int): Count used when signing an image
> >              version (int): Image version (Optional)
> >              oemflags (int): Optional 16 bit OEM flags
> > +            dump_sig (bool): Dump signature to a file (Optional). Default no.
> >
> >          Returns:
> >              str: Tool output
> > @@ -73,6 +75,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
> >                  f'--private-key={priv_key}',
> >                  f'--certificate={pub_key}'
> >              ]
> > +        if dump_sig:
> > +            args += [f'--dump-sig']
> >
> >          args += [
> >              payload,
> > --
> > 2.47.3
> >
> 
> It looks like there are still two problems with test coverage:
> 
> tools/binman/etype/efi_capsule.py                          65      2    97%

Do you know what the second one is? I see on my setup only one:
           if 'pkcs11:' in self.public_key_cert:
***            public_key_cert = self.public_key_cert

Regards,
Wojtek

> tools/binman/etype/fit.py                                 358      1    99%
> 
> Regards,
> Simon
