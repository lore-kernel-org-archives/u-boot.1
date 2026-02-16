Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E3AE63F3F
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 09:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6A383CB1;
	Mon, 16 Feb 2026 10:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="UicgT3M+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D42683CF2; Mon, 16 Feb 2026 10:01:43 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D685883C6C
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 10:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQx53YmqVI+FmptGNikvR7Gpf+AyV6pHMtN5DxkgZ0qqy8tUHovLSJzFuyVXHXvXaaRlfK0IrSsacc/3RXELCtnP6D38WzPncj/+NknhF5T0gd3s4NDAnmIKZdjcDm0m5HplxVqLCH1MwynP0vcMvgUnOy/Fru0wJZQ6iWl/aWJ2K/Qsa1LAojCJq8+1qETPVTd6jUq59efTr74nd42WwcdzIV2wN75kwl+MgtnOHxHI43x2f2j0weiPuIJbHRlqqDBHuZZvD0JRBwztiNMxE8JL3lGdEOGhq/yN7f18H3kIvmRCEtqfovvl4E8GRu6unAPQhy/+xbw8bfTIu9GoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qBI+YOGvp1cvBNuWXUf+otCl+VqRvtkmbnctuzOaws=;
 b=cHKaDalYUlH+nW98NkHaBHRMzWff2eBHBwC/DCqM/AsmwCvbZicIMuXNnX3qYTL9OrhV3n2p9uAuGpiXQTtmZsr9bs/WFPAoeoWlH9kKLeiu/7Zf2Fnz6IHDsGLzttiZZCBmZehwoQdeH9cIBMC7MnV7y0Pjc2HSowNT998T8NYkSWy4ahNcfHjRK/eLShfUcqkqLjZmshxEdi0xVxO3gs1Jv23Y+xJOZmIXGAb4LukfqmzVh6nEC7KaQhSpM465Tl2DsjTNs+M1b1R2zr8s+bEzECRhGR59u0HZAuB46MVMxfpBvtjbkTdeQublpO/ie5r8yJpH2CnqXOMxhYwhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qBI+YOGvp1cvBNuWXUf+otCl+VqRvtkmbnctuzOaws=;
 b=UicgT3M+vbvEQn9P6Aomb17+d1aiCZBMFhhGvhO9PPewC4N1R0oKkV66ld4wDoOVWljokqT4CCCzXfGTvre8KwC6fUTgOp/ZeWVxl96qRe96R1Vj0bsdeyyTcLbLO7zOTwXLoudgM7a+2Ize8Y7fa+HXokOu5UCo5Sm/ymLz0zh0Nbqs1wQKC2+AygXEXaf+KP9Es8951akg6Ctzsl6f3zLLGPJPh1L7LwI7hTgxr1E/BukZQJZnfWYsxIsDHnZREj1o1b74qWirjalwvqDsZr+tviFP+4/rKrlG7QHO6lniph6d9wOntrGxUqg2UvC/hk2gQKTCrUbMMMffzQWdWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA4PR03MB7375.eurprd03.prod.outlook.com (2603:10a6:102:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:01:38 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 09:01:37 +0000
Date: Mon, 16 Feb 2026 10:01:35 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: simon.glass@canonical.com, u-boot@lists.denx.de, trini@konsulko.com,
 quentin.schulz@cherry.de
Subject: Re: EXTERNAL - [PATCH v5 1/6] tools: mkeficapsule: Add support for
 pkcs11
Message-ID: <aZLc7zC5PJyyXkxv@mt.com>
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
 <20260128080515.1275941-2-Wojciech.Dubowik@mt.com>
 <DGDUN3ZI09SP.36P8F54DEPVUQ@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGDUN3ZI09SP.36P8F54DEPVUQ@linaro.org>
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA4PR03MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 172e863b-bfba-4f65-6522-08de6d39fddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HVaKb7wMFbUueKwByMGU3iJYm4OgQR45VNH+zAJD/QSU28WhchquSRWj4t+8?=
 =?us-ascii?Q?xbl5rRfFhOgu7fP1tbv5m1R+M6+roh4Lx85NKaj4lpY+GJ3QiiAnoh7aRD4l?=
 =?us-ascii?Q?UOMdsSHlkxqlKaqB8NXp9hxbGqfp9ik7TM6ZtJ8TZVamd+6w7/fS/H6uxt19?=
 =?us-ascii?Q?VmsYsNGhih1dewgtuUXPq1JZlcKp59gEJ/0ZyLJ2pPqF0MpcQhH1Ahjn+B2R?=
 =?us-ascii?Q?/iz+83HRvQEMit64Yy+SdTvXAwnHPL0Foe2JZZkX4mbY4Yg7rvkC+AKmmCk9?=
 =?us-ascii?Q?4KJqezleyp8b/r+vdqagmBcoHFGD4j9c1J/YVEd6zlCDpbcZ5NBIVhsYwzs7?=
 =?us-ascii?Q?/LGLEtX21owxjd62/waLFztpefLRmci9AF9Cd5Svypkdy6PXz43EBx8x29ub?=
 =?us-ascii?Q?eKp9VRHRpDVu5pP7t8L0OslZ1Ci/Sr6e5VuUZ1uVQbqGmUb1yX04mDW3rJ57?=
 =?us-ascii?Q?Xm2Ggpnt2l6/YNoRQ3ufegkR/Udqugl0x+1x1iL5B7LY8OumavyRnBeqxJYV?=
 =?us-ascii?Q?aLQ7Axw6RnRLpPn4zESV7pAr5oi3tgo913Oyo05g7PPZdjtc155kNy5uxdz7?=
 =?us-ascii?Q?EG2VLkB068qZ/m5Bmn5w8A6D5nQB8P357SmQ1WO5YmDu3qmgrndVLMmPBC9M?=
 =?us-ascii?Q?3WXuyUxMykFXrZsM1UXMe7+waT5z69Ldj+nIJZdvqvOXF+iuCj5UfBOgkkm6?=
 =?us-ascii?Q?txLKjxkIGMy4mI1XCmeofgu+bRCawqXmGjkuZSWxWxI/rmty7jd4KqqTHvl0?=
 =?us-ascii?Q?iPdi1TU0QfRHiAdt4nUaI7gZrJZWT7zt09HBLQ2uS488jGlZYB9eahWjNMMi?=
 =?us-ascii?Q?Ap2TUBbrgF6x/S/vP77T3dp+P+yQuzlbVnDnpPHy+SnzU7pL+2dVRxyGbE13?=
 =?us-ascii?Q?rKUEXq2fpMC7/u+F7A0G8xfUKV6QU3Z84Khz9k7AabnL08wRmz1q878iHA10?=
 =?us-ascii?Q?eYqzNoUXFddjQx69Zc6Lgt5yNsDu5694So0405WHV8dNr+X0+L7KmuJrsJrr?=
 =?us-ascii?Q?DCJtO2QATwiO2UzcUOqX3dPXa+kZ/7E3lE6wYAIKaXyIBn/8Ae3BGphwxQhu?=
 =?us-ascii?Q?xmdxlHn6bHWPNWwvOIieqFzD8DBWCZOG8R943S9+sv6GGfx1RJGm/WDcvW+V?=
 =?us-ascii?Q?4xi1AzYRncTwCqwSsKKtcpWQmuulyFzJ/9/6vkJ+Y/9f6nFuvOC4UXAgeum/?=
 =?us-ascii?Q?bzsNsa73+Vdwz+8kpZN/tNR835LLOW2aYaw9C2RH4w5/hO/XBBdTP95JZht2?=
 =?us-ascii?Q?G36KHWUnrjy1qrZXEmgOLCat6wzZjD5Wg3o4RULhLcTzLXw3S05NE2HGcRYk?=
 =?us-ascii?Q?KxjHKhzd3tCArm5Uzjkz0lp4ey++goF6oYPxcpBnAmKsiQrKGYg2H9vY3y/K?=
 =?us-ascii?Q?a2yOdsNS24MNgaMaVaRhaymbC2fk8EBJxuYP4wHaxZ/aB+J2UeV1IcAB7F2E?=
 =?us-ascii?Q?62Wq5w8nyiJI1Om3CNSvlCyF8T0z8jbZLUSBFQH1rH+xoXPIpcIPEurm4D8F?=
 =?us-ascii?Q?Xqnc9BIavZ99J/bv2DHzCvv6xGqvgnn2slN3kNzGWUbuh948gFnQI9VHw3Qe?=
 =?us-ascii?Q?7q5JbSRiyM6kWOz57JFCbzFGdwiVsaUdUtIVedgs830hd6dgA6wlUFc2A/5X?=
 =?us-ascii?Q?OzQg/zXCJaBCKhI1N0KfUHE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4yqn94/F3jhEScASM2Oe/YzDH9sbp1/JOy/8ZZvzhd+gFK+J8RLWZT4GaAv?=
 =?us-ascii?Q?WK5GQkWy94QWslAR33fVGzOkDdsyw0/KnJYC2+4vio+nbLacyg9ZDQKYDTwP?=
 =?us-ascii?Q?9izFwBfSqH4F3PWYtq6GcxH6DPymqFWT+bQfCCHshnut9IWI4HfCwnLlfUTa?=
 =?us-ascii?Q?QBAUEGL/XVJ7KBGbWaO9PGdsZAd5OThkwafZdKl9EEZGbPFNzTfuk+knxWeI?=
 =?us-ascii?Q?gShWvV3UB4yRWazS1276xxXqaykY9pokgW7+YdwItm7kV/5//MT/ajQPeX6E?=
 =?us-ascii?Q?/TjeT7W++kfbXSQifNjCe6hVPVz4XUgzcbTMlfVhoDMAL8ZMaapEwLL0xg7/?=
 =?us-ascii?Q?PzP20ucSmbUqMmRKY2tfHFT0phbq85d913ug5QscNlIbXiGDLaC1xe7Uzbgh?=
 =?us-ascii?Q?DcEG7/TuTB6ry9QfqO3K6s3u6eXJpg6BTWiMX/nfOiuOYyAQfe3HsqZgkTvY?=
 =?us-ascii?Q?RWec2vhLuuZ4Ztozit0XIswg8pBF+Up0We8/4+HLXbdBEaVUtfQT19yR2B2F?=
 =?us-ascii?Q?/84dHOBSgOpYg6ZX4+w/DN5RGnqM4+2OAOrSUuKVEY3Q+lnNVV+5HYLt1wwf?=
 =?us-ascii?Q?NLe31B3DUWQWTomEVzIioA/StYBGmSerFZX2HO+A2QugVexR09pEd6AScByl?=
 =?us-ascii?Q?0tVuIyXeWUONClcwCWOEOt2UrGaskEc44yc/D8Fl8qTVn+yJWgmp8LCN/GI+?=
 =?us-ascii?Q?FPYWFsCCJMjrA4mUqjbn7l9L6N4odaltbjfdLpTslXV3uqYPwrl+ofEV1/gX?=
 =?us-ascii?Q?0eSDUIJtVxeKckCTSS1vItzsRZrgfZm1nvbuT3hxWQV2PcVJRjKmwOx1cIzD?=
 =?us-ascii?Q?b2eGMsKj5008KiJxcNOU2jqoVFhAk278cP2CWLshA95hq+zRfair3L5MtDn8?=
 =?us-ascii?Q?FO/vwpvlZMn49IMa719FGE8VeKIyJNdEeKdsh7XdiXzi63rklnBcDd8SjmVl?=
 =?us-ascii?Q?YbQccM73hhaUHkMTMV0uO236TIruX5p+dNE0EpRZ9JrQVQ29nRK+rzcKPhn/?=
 =?us-ascii?Q?Hs0uBRHGCjh1S4scTRtoezJ5xV93k4jaY66X1QRyGXl0g7kkDCknuh/GdHvb?=
 =?us-ascii?Q?mgzlEK6bD6nexJDSzW63b91u2EN0uT4eGAmYQBOEaovOGwoL503e5ENyeF7R?=
 =?us-ascii?Q?cEQuwyEhJvmfpqWodQFLy9IeKnwH/Go5EPXtUWVdHqvtkC98tpXX1JfKgWjS?=
 =?us-ascii?Q?nv1h/p4gGY/w9CF9ye1niFzDQ/pzrtU6qDyTw/SRcxgsaM7RrKWeT3PloTnH?=
 =?us-ascii?Q?m9o0LWn/BDrgj74bEzDHPXaxURd+TtZD0gPY5xawhJW4HuJm3s0c7ZPlNV1X?=
 =?us-ascii?Q?p8A3hy63fl8Gdwsqeizq1RurLZAkulPYCP6U2LQYliLubYvKjy4C82Ime3B9?=
 =?us-ascii?Q?AuW1QrBkQnuKweeh5xREufOAFaVRT+w9cDKZ4hMR1EhSBFjVshvD2zBNzFdx?=
 =?us-ascii?Q?+nSFJHAcSXNVa/JRVUQLL75OL85ffkE2C9+WyNuARbb9AY22FkDHJjKtPkcH?=
 =?us-ascii?Q?joitw50cyk4kg/WuI14l5QGwptsf7UQ4xRVE6Lf8Y5mbomfE/Tj6C4fPwQfm?=
 =?us-ascii?Q?BHfHL+5qFj4hWbnmI6SmHGEWaETX2aFjUNhWQve6Pg13HahH6QLcSq+6aa8x?=
 =?us-ascii?Q?65RqLXsbJlrMweKX70z3sGUpszOb3Z0sOJSDHYfHYFnQAyCC2ei/BGZReLv5?=
 =?us-ascii?Q?CTqrQF6ML9C5qG6GH7Qd0rxK34YVl17Hn1Z/7bivBNvK30/fq/a12OK3PtNI?=
 =?us-ascii?Q?UBimu0FmeA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172e863b-bfba-4f65-6522-08de6d39fddf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:01:37.3971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn03BhdRvRoxRI1BHUMJniAYnx+VyqGoMt8fE2bPSOUtFix0HHUznDvWY1e/29J1TDV8QfkrFJ1vLPgC1m48EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7375
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

On Fri, Feb 13, 2026 at 02:56:48PM +0200, Ilias Apalodimas wrote:

Hi Ilias,

> Hi Wojciech,
> 
> On Wed Jan 28, 2026 at 10:05 AM EET, Wojciech Dubowik wrote:
> > With pkcs11 support it's now possible to specify keys
> > with URI format. To use this feature the filename must
> > begin "pkcs11:.." and have valid URI pointing to certificate
> > and private key in HSM.
> >
> > The environment variable PKCS11_MODULE_PATH must point to the
> > right pkcs11 provider i.e. with softhsm:
> > export PKCS11_MODULE_PATH=<path>/libsofthsm2.so
> >
> >
> 
> [...]
> 
> > -	ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
> > -	if (ret < 0)
> > -		return -1;
> > -	if (file_size > UINT_MAX)
> > -		return -1;
> > -	cert.size = file_size;
> > +	if (!strncmp(ctx->cert_file, "pkcs11:", 7))
> 
> Can we do strlen() instead of 7 ?

Will do in the next iteration.
> 
> > +		pkcs11_cert = true;
> >
> > -	ret = read_bin_file(ctx->key_file, &key.data, &file_size);
> > -	if (ret < 0)
> > -		return -1;
> > -	if (file_size > UINT_MAX)
> > -		return -1;
> > -	key.size = file_size;
> > +	if (!strncmp(ctx->key_file, "pkcs11:", 7))
> 
> Same
> 
> > +		pkcs11_key = true;
> > +
> > +	if (pkcs11_cert || pkcs11_key) {
> 
> Don't you need both the cert & key to sign the capsule?
> I'd simplify the logic here. Instead of having both a pkcs_key and a pkcs_cert,
> replace the variables with is_pcks and have that set to true if both the key
> and cert have been found.
This is what I have done in the first iteration. Later I have learned that there
is a need for mixed pkcs11/local file usage. The HSM devices are very expensive
(at least some of them) and have limited memory. It's quite common to use private
key from HSM over pkcs11 protocol and all the public stuff locally.

The test is implemented so at the moment.

Regards,
Wojtek
> 
> Then the if/else cases later will become a bit easier to read since you'll have
> to load the private key & crt on a single if/else cases depending on is_pkcs.
> 
> > +		lib = getenv("PKCS11_MODULE_PATH");
> > +		if (!lib) {
> 
> [...]
> 
> Thanks
> /Ilias
