Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0882CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 13:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA97384857;
	Tue,  2 Jun 2026 15:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C73F7ThR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81308485F; Tue,  2 Jun 2026 15:35:55 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0652884855
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 15:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4xNvkvAO74CKkWxfYHfFva+t2w2tw3E6QmyqC/BsPVoEme8ad2zjBtiHhxEYeCVN+2Urk8SSNKPIQla7oOAQqOtL0WxCviFsmse4dGyac0TGmm3sXnbKKOnDD0MghE930PMRfZq4R90Zzd4vz1e9lYrYth+fhASBtjbkc78o5nb3cdRZS8ezJ62nvO8/U0mgE+1z3FnoOLRqmkkzkqGej5X/Mw2vDyd08R9Vk/KqUPbuLjLQfQ70x5tOWWBtRgnvmKuIhS4BEgYD4sp1ln+ou2iuTNDVdv8Yq4gJ3r+PXqjQ9TQUEWpuj5Shdxn3jRe1bqOH3u4qOwoFoCBtF3c2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2PkRwnS0kyZHsIIA/eJFoxrbt4SvbeloU4gPdEZg18=;
 b=l0oHa9/wy9cicem3EqMGHOlUd1FRlxoq43IdR/6sujMLaX4Y1xuNjYhhWXY+qOxlW3Is8pxleuSkzhxf5fDBjo3h7DPNevi0keE96G54cuEXbUB7XXjr2AUqbjWbZxoEWiZ42GToDysG9iV37lLWvXAhzVPXEsjzUqeYqIcQ9d53c+ck15bMErpAJulx4EQ1v2hI9jxWz5aeYqPl+tvk7RsEHU9kIfDSYk+L69IQd2iVg2qKU9n7RZ6kyCNrXU8gd0B1UD3dUTRNBvDCiYY34UdXST+PQROYbX8UezS7y3TLi7/TXyrARXUdMJByOOrbk1Gk99XanHjZ5PaBAF/8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2PkRwnS0kyZHsIIA/eJFoxrbt4SvbeloU4gPdEZg18=;
 b=C73F7ThR+gHKsD+Hd30JFJwkEqqivGV2W20hiCFqcFYy+8yUdAuWvretv5gweri4bLG8qpZCNskpYMmxJhO7IquG5RbEKj4av7qHUaJw5WBGzOZZUBw0jdbFpn7u04XG0XVTkYMYud8z7fiIXQZc4hGRGckjHyv8TAm5/iIp656ve+nvySd7y/B2S63ADonGfcPRDnmgrzZedhWAuXtnws0P4nOTTJuJznlwxSN5d87lnGOvwrcQzN8mAC4xbkWULEnuUv0ua5OpheDDkmPRhV3Lr3aSrfMnmHVacHZeUzwtiSmHnrNFk7baMOlZi5+saOfzOqxyuHlKQLPFxGPDSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 13:35:48 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 13:35:48 +0000
Date: Tue, 2 Jun 2026 16:46:21 +0300
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com, fedor.ross@ifm.com, 
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com, 
 qijian.guo@nxp.com
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <4phebvxijyyk5yd4p7omjlup3iotsqgp6r3kt5aiwgimwg6nyp@hnl3qq4imsf2>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <acfe5311-2ec4-48fb-80bd-55c11931b377@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acfe5311-2ec4-48fb-80bd-55c11931b377@nabladev.com>
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|VI0PR04MB12302:EE_
X-MS-Office365-Filtering-Correlation-Id: af342da9-c5e3-4b9a-3daa-08dec0abdadd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uo5FAztkFEvqAxIknWgwz2JUAN77R/SRh6HyORZpSmxGxeSuzTRSdq3HvXi2ZJPFMVP9w7hV86OBi1/5n4WXKfBjJS5Cb3Hnb33NkyAPaXWB/1xW1ZhRQVr/iWauKQBouXErK7SoYavdIJZUJAUA5OYCtGxFIIwrHsd9mCFL/fBbOmIkHBawcfBTizxkmtq6Sk9lKPVLLcUZZSodwU+VWP0sX+GOTokZlblUUI8L1jqEgpUi62+/gIDMoY/QODfgrSpihHvVG0kz6i/9d1B7ySle8Wlaac5JUuEA8NXY/eVnpMW2mq3VF06lrbkginuPzHnyeaSlXyABfW5FV/oiZT9F0MC05FRBKzekR7pkVHlyJDjlf0hZzX1d4Z6JFN6J/Oqjr9pwp/27hEyqUhbCWv7aVu+vzSeRfhTlUP27N7bfUHNkC55vqmXmo/hlICI9hqoVccBwt4z3rM4x6y/hWvHq8u1c4HoGLjqp7MsYPnED23bASFJifgXPSeyKp3T/luFVeSPaYfrBLGJ6PiuPW2srVXOkjnVEqI9I2KiC3u3bpsr4EQiPdC/BPFhT8CwNeyWREA3RcYdFj+2DaTI5xVUF8WJ+4h5eihaE0LhVWEnURaRFJqnS3DuwlSiuYnFw/UDt1batv3tJl64musieEEdvLjQqzD1IByrhiM3sjLZRKvv3fLl+KL5GGIDAMTYH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7Hd68vUOamV+D/fq405FJL+p9NpJqwqlBFJvRZrJJ7CmQNboBqx9JXW7vtI?=
 =?us-ascii?Q?x10TL5c6Fbk1FfrdgAmEX8HHGJkWh/u5gXLdvPVnCdGUNgsoPHWj7Fq3Iexr?=
 =?us-ascii?Q?kvvbVbQN2Gqxiov6rXWkPLiZ6pgRj9htVqKbCfKBcv4jlKLvvo90Zz0DpoiT?=
 =?us-ascii?Q?PhJQH6JBoQkK6fimqZdPeVrTAhJkJocsM3sdaeUhs0l9lIyyctB8Mchxnzj8?=
 =?us-ascii?Q?1VEV6xho6wdImsAijT7/u7HURsJjEGQBSLSuZ1FJTVPyPoEvjjowdjm+Jmmu?=
 =?us-ascii?Q?QGJXbYdpGWS6xuSlJnNQ+kyAVvhTAbi4Uwvj2+1+ECUkO7CY1eq6IN3fq6CC?=
 =?us-ascii?Q?YMFrBfFdt+0oK9GkwZ6YrVeQNT/a5sjLui6x41VYHz1cAmNNhjNkLXG4D1zq?=
 =?us-ascii?Q?BAlO2YMQGB+ZQ1ReSH3G0ECTGoVY7LiqMF/L4hCLRttGhJrxfeLx+sBhsFqE?=
 =?us-ascii?Q?4vPelH73JLPDgaK5gQotV4mXsc4RECOUNQaz8jMFO+CiN4AvSOS5U45l681s?=
 =?us-ascii?Q?E5OmprlwhgmQB+tD9xLpnBl34FafKb22JYezippZwNF5wok0Tco+RDIVAiK6?=
 =?us-ascii?Q?8W+ztNVUg95MPgr3kGSkKBluL8TkjHPZtV9un3nQgJe/FN0+cBp/TmePgeT1?=
 =?us-ascii?Q?/7GF5aHdpCP0xjDQOE0EJ0cXIOL6UUWDr58d2ZogKpzZ7y+OJDds79l32n0T?=
 =?us-ascii?Q?6/2Exk30bqQUWhij5isyrndAasxypEdyotK+tnhX2xCCe5HpGae+T0td9/rP?=
 =?us-ascii?Q?4P3TT1xqTJaq1E7Zn8NtM+IgvxkClUcD+CnNShsy7UYGzhGiFa1ugOMi3uQf?=
 =?us-ascii?Q?0R+89P5eQOuFa+BI9FdTwZA7bjjGZXxAQ+cPAiSPNgOOk7V2T+rypb8w3CoR?=
 =?us-ascii?Q?iyzKQoqDJx+HH4lM2fKmUEuIlcRtqUILm7HB5eLRswXuFF5mKlyG90vxE+NF?=
 =?us-ascii?Q?h8FNALPpPCqutI3XwJfl42AoNFmOD3HxvJgKiMrwHPqU2KQ59hRPPDApTUw3?=
 =?us-ascii?Q?er/1iJlxspGiTfyL94SANNJ2QCjys3AwG9CW9VMeGZjXlFx9neem6EoPgQap?=
 =?us-ascii?Q?DlmTl5FJ4kFWlxFY7fJAJD0blYInl2r1pMdHc35gBZ+bePVHZhm5jQdJDOnu?=
 =?us-ascii?Q?hKmKmMVXtSFz7gd4etwkI3IUbjUaMePD/LksoP7gXewwknphDEWgNybh8iea?=
 =?us-ascii?Q?alj48+b+69PBNyvM4n4Wxh6gGqAG2HCARWFpAlVGQ96m1jgK50U9qZCLs8L0?=
 =?us-ascii?Q?BexXlcNpCilqoWXJNS+ECLK57jpE17lWLM9Jh5qM7h7SwlRd+dmu9CVD88I0?=
 =?us-ascii?Q?5aWy/pZk80Y1NrjOlVsBdsfV8AIp5oILe/VpoThIK4/ZnyR32mkD9/kowSfk?=
 =?us-ascii?Q?58jUJpGaYXqyPmCrQUKNddVeM82aR8n+0Ji81/m3KyE2UZkym+ambRGyuPIu?=
 =?us-ascii?Q?Z6F72r3a+RioWGh0nZgaZhu4khWpIpEq4o5PlvXY/pab4nF7BPACRdAx7Lu+?=
 =?us-ascii?Q?V3kDAexUR+posmlp2McQItJ1QeBv88oRsBPdCOIXh9ZZiJ1KR57OV+i2fACg?=
 =?us-ascii?Q?9BrF51VoSUchMC+H/J3wyyeCmZgUbnFbiZR83eQFZfEsXwvqCQkCJVOjQOiv?=
 =?us-ascii?Q?c7Aegd+Z8upGGuJUyemdpEA+H7UAkQ9kFLI5BqG5L2UC3lPn9tgTtQ42mPZi?=
 =?us-ascii?Q?9rX2KTqZASpSyFEnRuT9pw/Nz6wKO360xEKNxGm8taayP74cO2l4gt8Mgx6V?=
 =?us-ascii?Q?CBF6UnAuSA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af342da9-c5e3-4b9a-3daa-08dec0abdadd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:35:48.0171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvsKcRcAjLtY36+fi1SAH7dt0P5MAlYQnfk0XvBFt7htEAlTAEwuL07KNNxODLjPi4YlZNmZYPPgu0ernKrHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12302
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

Hi Marek,

On Tue, Jun 02, 2026 at 01:20:57PM +0200, Marek Vasut wrote:
> On 4/30/26 10:33 AM, Simona Toaca (OSS) wrote:
> 
> [...]
> 
> > +static int imx_qb_spi(bool save)
> > +{
> > +	struct udevice *flash;
> > +	u64 offset;
> > +	int ret;
> > +
[...]
> > +	ret = imx_qb_get_qbdata_offset(flash, SPI_DEV, &offset);
> > +	if (ret) {
> > +		printf("get_qbdata_offset failed, ret = %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = spi_flash_erase_dm(flash, offset, QB_STATE_LOAD_SIZE);
> Can you please double-check whether "offset" here is always aligned to 64
> kiB (SPI NOR erase block size) ? If not, this erase here will fail.
> 
> Thank you

The erase size of the SPI NOR should actually be 4kiB. I added
a patch a while back enabling SFDP support, so that the erase size is
parsed correctly and this does not fail. I only enabled it on U-Boot,
but if you are using SPL you should enable it there too.

The only reason why I did not enable it for SPL is that there seems
to not be any defconfig for iMX95/943/952 for booting from SPI NOR.

Trying 'qb save spi' from eMMC on an iMX943 EVK (with SFDP enabled):
u-boot=> qb save spi
SF: Detected mt35xu512aba with page size 256 Bytes, erase size 4 KiB,
total 64 MiB
u-boot=> echo $?
0

Without SFDP, 'sf probe' reports 128kiB erase size, not 64kiB.

I also do not see why I would check if the offset is a multiple of
the erase size, since the erase fails gracefully.

Best regards,
Simona
