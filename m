Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B88CD11BF
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 16:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9F887F78;
	Tue, 19 Mar 2024 17:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="0bcV2Jsq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="vN1OIrVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17F987E1D; Tue, 19 Mar 2024 17:15:30 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0711.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EE3288033
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 17:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=nSMeyMnGSLVoznn5Lehr1XPYQNE59GC736obaLGTk+OkNPgz2i4parud19AtUKnnV2uAY+qden9I/0sRWu3QkdAgrg4tjMH+pKzweZM8v95HAsM21ehMPzRkvN7cpVEi6dl5bXQYGnpvlz50L6IgnpNsQgNEmBMah9w0d6xcABzucLJ70f+v6rT2CP2JWaBtyoyMuHLUEWrSeqA+eL8kpJqaWrWW0HA3yCPvgZgLFe24QgILYBpG6usYGeadLbTpXAX2+cKyonYYHMpPRZ8NnEZIk4p62XGiR/njbOnGjRpIgmthErbUjRtslSRiNP9OQttbA2DX3f2PXk39VpSVGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS/kFBvpPpDLin+frTDOjnVmZhC8cdOdswdc9Tc7mlQ=;
 b=Q4UzqN4xtcISd5xuG3RybYFkqr8wB6DHSVx3DgsSDKkVvAzxl8WHXIZgNoT+G8HUfJeUJz2mdFcFAokSPFoilKMqFB2wqGU962+jQK7xwS2WD6i1iEwhEP5uF3DtFCaQNz9LnhKKDA7Q1Ct0RTN5Hh8cY6EadYrIi9A7J8IYNNyQCF0k7SWAwzRTOBQsl7A89kOv+a0hT0AFvrHp2nBY4RP/AVZFAIFs8o3Qcxh2shKreoJ7osEQ7ujBE8Xazqhhg/G+SCLgpY1D8hSGDGvO1xCYfAQRrddsXmGcDfA4McMu/m49EELwoJiYUw3/cIla627jSB+gkTjdW+XxSuH8Lg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=baylibre.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS/kFBvpPpDLin+frTDOjnVmZhC8cdOdswdc9Tc7mlQ=;
 b=0bcV2Jsq4ChA+A09UhLuduk73/IwJT8TFyDYlB39Iqg21wInhvj2bWhdZ3FOwBtSl0NvXFrzGSp3TxIRjD1iLr8x+KRgbXVIDsDMsQmLQ2LKSKhUMMr5O5Q6QtdmQvkdsnE5meeo2ajcmzJDbSsjw76v/+wuExSABqd6cEgNDdcxrKJWGzprXu5g0tizinTwKp/2PGsS++NTCmy1cVSJFUn6A4b+b0/8g48qnaPhYq7UjAJZOiWPIeaMt2nrVoR0SE8DpEr+U00wsg4154e1AjqvFlsFA9xpj9bh8dl3D62QpmDhMlFnMc0FTxLywIP0iw5Sk4JXnVgGWpD5ulN7TQ==
Received: from AS4PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::11)
 by PAVPR03MB10180.eurprd03.prod.outlook.com (2603:10a6:102:327::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 16:15:25 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::9) by AS4PR10CA0015.outlook.office365.com
 (2603:10a6:20b:5dc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Tue, 19 Mar 2024 16:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 16:15:25 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 E16DB2009538C; Tue, 19 Mar 2024 16:15:24 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 559322008006E; 
 Tue, 19 Mar 2024 16:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZJVTffZKNeDORpJDzFSbxep+KDuo5gA5araoO4ARkjznA04PndduQaeFwmWWrKbqnrf7CwgxoZ1yMeJKTh8VBWjqyTcyxdMCAASarleashkzF8d/BE/2TAAqy+O1ehlMd0xjtmAUhgbWZWP0XYVGDP9wgV3eKq44yhYw/G2Jq+N8sg5TYMdSoKhJB7JuaCQHyXMLwg/t5Noww7e3r0O2w/7ijlATYc+YhjvdAghhvESsHCSzE4HsnaZXuJcNGYXiEvCiUycLwr0tywg73nFZokCt55Lr+zzrmgTlYzlVyaULz6h9vAVOcBT1fSkN8I9/oGeW7grYgu3FHpmYJktgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BvuE0V7O0PIEl8qCK4GX/eYNSMClvCfFALlyUyh/EI=;
 b=aYRk3RxR8wBsabT4Z+Mlc44/9AU8glKwjoX0uaXGM6VkRrLMqiBx0C9WCpMUAKZPMbrpr5xiynO1bHpqWLSdAX8j9JKix0tJ655Rv2xxX5fjoibWYNbIF8il23rXivzyAip7GcveoEtYKOZmUeaHuTV+tgiUxQpi9fZCpwKWaQL8X/FOLpL5Rvq6R7sUgVg/BXfCRghxqHCPu0UdAz+AUL0dKFjoI4sejc4YBC7vtjljl/0kKZbqy66iNLdkt4tfdw8vPg1X01NsedzW9/7cSoeiP4/8JnK2GlTnwPz8R5QJXG37QMmDomEmUwniYt8W2XR4Z4wsW9YyfdCSUZ55Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BvuE0V7O0PIEl8qCK4GX/eYNSMClvCfFALlyUyh/EI=;
 b=vN1OIrVg0ed5B4DZx4BdIqmS7GPo0F4yGJHlvaXFe/LGR/Xtp/T2BHJ3xZqHEhtuioa65EnijoYB8oDSxseBP5leWutrH+gk4gGEpu0pdPBDUllKcdJBHvvDAMlAU7hIlFNV8NrXYL62QZJlHXPXoV3ssqLX+E1LU6ttCKSTdhGON9KOL/Cjtj6i/O6uxVjEYGr2Ha4fKAlYv0fIFhjaLv6uL7VlV8Mb4XEBr6mkdQNhRDnVe4dAvwno1ro3+aesn4WSjZpp77f7phvj+cdFrlReEgpCqrOkklzQ6zvwR17e07SwnTL33jMsrnrLAD+yojpZu3Slj2igzBDzkhOfbQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by GV1PR03MB8310.eurprd03.prod.outlook.com (2603:10a6:150:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 16:15:20 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:15:19 +0000
Message-ID: <d22c23bc-8fbc-469f-90ea-2d6b51c12580@seco.com>
Date: Tue, 19 Mar 2024 12:15:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: bootm: add ELF file support
Content-Language: en-US
To: Maxim Moskalets <maximmosk4@gmail.com>, sjg@chromium.org,
 trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 ralph.siemsen@linaro.org, xypron.glpk@gmx.de, mkorpershoek@baylibre.com,
 souajih@baylibre.com, takahiro.akashi@linaro.org
Cc: u-boot@lists.denx.de, Maxim.Moskalets@kaspersky.com
References: <20240319161022.41451-1-Maxim.Moskalets@kaspersky.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240319161022.41451-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|GV1PR03MB8310:EE_|AM2PEPF0001C70E:EE_|PAVPR03MB10180:EE_
X-MS-Office365-Filtering-Correlation-Id: e026a344-b1a9-4fcd-6cb9-08dc482fc8f6
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: HfXNU1NkskI5SKCYEwL5a3PyWiUnbqf6VeHJSqLBXw6ybVbnL2MWehecX22+1SHeKTJNrTHBblLixoZGOSM0J2EAaCX2+5LZ1Z9TF1Uw/uzUBjL78PZhpjtqkU7s2+8q+89kldf1No9+lDSKj1SScfuethEWh36CtLO/cszGsInSdzEWk6RrmiPy/vFD+4iuAiYrUYbQEMP8DmT+K9jGFON5uQYb8nv0LBxbbwhflc7cPtPRqXYyGM1voG8kanRM+dgPRMGBh5wcGmBcGsmLNs8Vz0dboS6uFGW+szdiA4sMNlzidBYEi2G3Tlhe91hm7TnvAG76yeM8BJsQNWKRkLSK4ytWpaJdkWJV/Zz3BaUbBQC0N2q3MIwnfqZmT6qoHysTrBIUflJ+G50tcJyJ31/aFmkug7GBx0lLksFjtd72L6YcBdEDnVlqh6nlZT6urou+EvtY9Jqw+40rfoLHgwxnJ54ImrKaNk9QrbQu04oE/4/wN8J0SFZx2p9RjCjxZ1+mosCl8cEF9JO+krULJQIJJAXXaTMevjvDtNPp2wnU71Sb9P1H4HjOnx9ewEj+327G8GScFKNCTxO08QqJy+f6VyiiV222lVOrhT5jOZkomwmRXs5rhd9W1qvidgHiVixKUvla8fUFdyTE+lE0IdTzm1Gdmb2SDetaLn5aQ/VHU/WeuUmsdsxo6zEVXbnYmzMatFKihCf6LpPSe41tj60tN9Zl402ibdWpAVXY7BE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(7416005)(1800799015)(366007)(376005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8310
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b862b533-b454-4a9d-d283-08dc482fc594
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7muubjnCaIW8XG+F4onqUjeOCXndXib+k8PRGEqhTIkIeLIIaCF+D/2yn7zy/1Z7u+R7BrOgYvOai1ENGLhYPEapNdCLUpM9OI5vOb0GoGP848s/aepVME/+8vvMGVnwl6LAJhfRgevBZ9d1BlCTMzsYdtDkAHqbP1U7e4xeFXuf6XZ3ADke8KXeCPFpBCoEWxTjRhijQBj4mKfPqisSMT+xONgEWM3S9IsECSX6Y1IIFPvtzHyo6cp3sowwUmIf9uSTRRvHWit53+2E12aXtkBHWrXxZy37fBAV9lFDzh9JyZ4VPpXGuVLQsJqRuMvdyAcX4vuSjTVSW8qMbXi0uqVqqg29bCPTzBRq/bYDCodxvy+UmatkUnT6CMA8pRLhxUUbvjoayufGjk+8BiU/dakgHp9KkH3cloCJ6UicD/JiiNmYob8pH6hgX2GQntw0vnYnFUpv2k8zWGacdBh9HQpAThG0HtEQcQMPjRmSRE3Nu54NqOu51dbcdBDZY0+NqvATkrydnulLRor7m9sAuGddg9MNEyX3bv/evm+QDynsJTqaGbD+80HRC++vA9bBksMeOrqGL+6tiq2zFSsN6ljZptNNY7pEFdocZBtyE6jFKIMQ23cbmScCBUUnchk33SvNNeCrYJc3bXRnuRRV1jyZmC7soPGMbF8KTAN/Kt7Ram324gz3UV47uSWfYJqEJJpeyDmbGv823Vemh8xb2Na/qdge7C+ju4NO/bUPEjnswTM+GtGniihhrPGJxKB
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:15:25.1554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e026a344-b1a9-4fcd-6cb9-08dc482fc8f6
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB10180
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

Hi Maxim,

On 3/19/24 12:10, Maxim Moskalets wrote:
> [You don't often get email from maximmosk4@gmail.com. Learn why this is i=
mportant at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/q=
uery?url=3Dhttps%3a%2f%2faka.ms%2fLearnAboutSenderIdentification&umid=3Dd37=
28a4f-0e7b-4ded-94bc-5bd133b6deef&auth=3Dd807158c60b7d2502abde8a2fc01f40662=
980862-7a67d937c0016d0d3292f79af55f0ce3d78f480b ]
>
> Some operating systems (e.g. seL4) and embedded applications are ELF
> images. It is convenient to use FIT-images to implement trusted boot.
> Added "elf" image type for booting using bootm command.

Why not use objcopy to create a binary?

--Sean

> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>  boot/bootm_os.c  | 21 +++++++++++++++++++++
>  boot/image-fit.c |  3 ++-
>  boot/image.c     |  3 +++
>  include/image.h  |  1 +
>  4 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index ccde72d22c..71bfb34926 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -395,6 +395,24 @@ static int do_bootm_qnxelf(int flag, struct bootm_in=
fo *bmi)
>  }
>  #endif
>
> +#if defined(CONFIG_CMD_ELF)
> +static int do_bootm_elf(int flag, struct bootm_info *bmi)
> +{
> +       struct bootm_headers *images =3D bmi->images;
> +       char *local_args[2] =3D {NULL};
> +       char str[19] =3D ""; /* "0x" + 16 digits + "\0" */
> +
> +       sprintf(str, "0x%lx", images->ep); /* write entry-point into stri=
ng */
> +       str[18] =3D '\0';
> +       local_args[0] =3D bmi->argv[0];
> +       local_args[1] =3D str;    /* and provide it via the arguments */
> +
> +       do_bootelf(NULL, 0, 2, local_args);
> +
> +       return 1;
> +}
> +#endif
> +
>  #ifdef CONFIG_INTEGRITY
>  static int do_bootm_integrity(int flag, struct bootm_info *bmi)
>  {
> @@ -536,6 +554,9 @@ static boot_os_fn *boot_os[] =3D {
>  #ifdef CONFIG_BOOTM_EFI
>         [IH_OS_EFI] =3D do_bootm_efi,
>  #endif
> +#if defined(CONFIG_CMD_ELF)
> +       [IH_OS_ELF] =3D do_bootm_elf,
> +#endif
>  };
>
>  /* Allow for arch specific config before we boot */
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 89e377563c..0419bef6d2 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2180,7 +2180,8 @@ int fit_image_load(struct bootm_headers *images, ul=
ong addr,
>                 fit_image_check_os(fit, noffset, IH_OS_TEE) ||
>                 fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
>                 fit_image_check_os(fit, noffset, IH_OS_EFI) ||
> -               fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
> +               fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
> +               fit_image_check_os(fit, noffset, IH_OS_ELF);
>
>         /*
>          * If either of the checks fail, we should report an error, but
> diff --git a/boot/image.c b/boot/image.c
> index 073931cd7a..5b88d6808c 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -134,6 +134,9 @@ static const table_entry_t uimage_os[] =3D {
>  #endif
>         {       IH_OS_OPENSBI,  "opensbi",      "RISC-V OpenSBI",       }=
,
>         {       IH_OS_EFI,      "efi",          "EFI Firmware" },
> +#ifdef CONFIG_CMD_ELF
> +       {       IH_OS_ELF,      "elf",          "ELF Image" },
> +#endif
>
>         {       -1,             "",             "",                     }=
,
>  };
> diff --git a/include/image.h b/include/image.h
> index 21de70f0c9..9a40bca22c 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -100,6 +100,7 @@ enum {
>         IH_OS_TEE,                      /* Trusted Execution Environment =
*/
>         IH_OS_OPENSBI,                  /* RISC-V OpenSBI */
>         IH_OS_EFI,                      /* EFI Firmware (e.g. GRUB2) */
> +       IH_OS_ELF,                      /* ELF Image (e.g. seL4) */
>
>         IH_OS_COUNT,
>  };
> --
> 2.39.2
>


[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
