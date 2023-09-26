Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC203E7E657
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 17:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B6F86CBB;
	Tue, 26 Sep 2023 19:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="lT5j+6+C";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="lT5j+6+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD4FB86D44; Tue, 26 Sep 2023 19:41:12 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8418586C5D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 19:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeWlvL/lAFbSGKNDcbuFqTt/TyQHzbuC0ehc3llMvXQ=;
 b=lT5j+6+CsU7tpJJyNPHk5T8etERdWD2wifrX12Stv4Jy4Qf72DdYWepH808tINXcnaBI6gMR1U90KNI1vQdqnFi2Ua8Bmp+bgbEM1ttp/CD4KBPIfZG4aXf2OPf94O+GQzzPpPBHDw3d/uDt0OTSkP4HlWbqWSkpb4S7f1DR4LasmovpYOrP2q5ja5tf7d6FgsroC9NilNJV6DakIZqi2iL2vHAzK3TxAXrFOXL/bxQJ9k6QL31aBPM9x8omIgiwKPcm/WFMot6Tyd3yzVKXDE2yHu1ylud1gNdFy95caPH5F/nmOxxJFW0rg4AWv5LSfvfRIGJ4ewVnlgbLsYy/qw==
Received: from FR0P281CA0157.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:b3::20)
 by PR3PR03MB6652.eurprd03.prod.outlook.com (2603:10a6:102:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 17:41:08 +0000
Received: from VI1EUR05FT062.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:b3:cafe::52) by FR0P281CA0157.outlook.office365.com
 (2603:10a6:d10:b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Tue, 26 Sep 2023 17:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.82) by
 VI1EUR05FT062.mail.protection.outlook.com (10.233.243.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Tue, 26 Sep 2023 17:41:07 +0000
Received: from outmta (unknown [192.168.82.140])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 7B1CE20086FCA; Tue, 26 Sep 2023 17:41:07 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown
 [104.47.51.240])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id BAF902008006B; 
 Tue, 26 Sep 2023 17:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiW9LTMrhgw9dNO1DhUxr+DFPsaLjPlKWeKbZSpIa7E1fGRu5MrMKRUM884UQLLfmD+Q3Y3vPC7WZfnQFkafwsW0KBnKySVUUDDuORRXOnWeNTw/SGMQ4ADvGkb82cPhzDD18drrTfgz0OMgsWOduUihzyyzF6YEY7ihteR7FMvVPcLdGOEbh3g4qM7cIAD2xNm+JgQO1QmnKLyebZzFBjAdnp1w+0a0Tswg8idldYE0Brht+kF3sccrehzkKQxTM7Y9r+dNhjSLZ0JSqtdtHBdDLPNCER32U0I22bixi+GtsYmcPZGVbtEJP+q5GmMa2OV3sXs3/3zHtjbeks73qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeWlvL/lAFbSGKNDcbuFqTt/TyQHzbuC0ehc3llMvXQ=;
 b=n6eeXSTroSDIkUEuOW91XWHei7ebaxk8v1vNSI3hXFw8azThsupMEdYjxEVE5C5kJRdKK5r40T3hrbqwZq4a/4EGJ4E/X/38HiKFog/mZLrWCVKTFbAoeMHF8sDRCvj4sC9lrgj98je2eTLUHpABGH7hMRUFA+JYKVeyQTQwhMgqXfD38a2IrAUCELt/phxhqERrYW5d9iCYnkwhxacw3f5YyqUIdpc9csAjAIzOwBwwuUarrhLDMNkZiAk7QTDNRI65xO5UGVIjwNWJCc1QL2w7OZXkxvSVagaZ4FR2oC6OARtvS1fNiQN5dVaaVmEl56/u+0tEJNrst7JaYWOjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeWlvL/lAFbSGKNDcbuFqTt/TyQHzbuC0ehc3llMvXQ=;
 b=lT5j+6+CsU7tpJJyNPHk5T8etERdWD2wifrX12Stv4Jy4Qf72DdYWepH808tINXcnaBI6gMR1U90KNI1vQdqnFi2Ua8Bmp+bgbEM1ttp/CD4KBPIfZG4aXf2OPf94O+GQzzPpPBHDw3d/uDt0OTSkP4HlWbqWSkpb4S7f1DR4LasmovpYOrP2q5ja5tf7d6FgsroC9NilNJV6DakIZqi2iL2vHAzK3TxAXrFOXL/bxQJ9k6QL31aBPM9x8omIgiwKPcm/WFMot6Tyd3yzVKXDE2yHu1ylud1gNdFy95caPH5F/nmOxxJFW0rg4AWv5LSfvfRIGJ4ewVnlgbLsYy/qw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS8PR03MB9413.eurprd03.prod.outlook.com (2603:10a6:20b:5a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 17:40:59 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%5]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 17:40:59 +0000
Message-ID: <e69acbc6-ac0a-5f7d-c882-97188767a796@seco.com>
Date: Tue, 26 Sep 2023 13:40:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 13/44] spl: Use SYS_MALLOC_F instead of SYS_MALLOC_F_LEN
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
References: <20230926141514.2101787-1-sjg@chromium.org>
 <20230926141514.2101787-14-sjg@chromium.org>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230926141514.2101787-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS8PR03MB9413:EE_|VI1EUR05FT062:EE_|PR3PR03MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3189806a-36c9-4338-3846-08dbbeb7c3f8
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BoQrwdplhYKueD/NZBZjRTscOS1c9ngv86ZoytZZpV3utxPuiBcZOA1jzPSpeDUrsts5cC0neaRYRaKrVIwlUKm9OKPPZm5tAeEEaFTsvKXuscxRpdhef12r8Hd9tLrigKJ4T/bLDBwL19zy/3S8gq/InZhXFUyPh2E8nkDO1+/QYeI4gdcaMVadAUNY26/4X6G4ws22G9C8gMSeSzZhX86vAEgy3CI32LftP4PXWN2gqxDUQbzE5JDUlhvvmqQ60EVN90yxLDfrBTfhDllFzLKPSNTxDzE/g2YIFYY4KQAX6vli/Esrnc+oZcMzM5NIMysIak2J/YwUioc0vr+MMZCDzysHouTQquBv870Q062P2z+OlQpoIwoTyeqquOu9yIk4GmRQ69SjKFHhx5N2avRBZtJ6Ych5SBx3YnY9VLgA//zUxRD4Pf3plS22DUFh46Di5NuJoHL5rVvgZbBqftJ4VqdZuioQeFkwBx3WpoU9QwG33b2s0r5UODL7nJuVD4CMgTHE8UKDwvNy63wHU3cwpH+Wh22JsDSCtoROSfT/NZu/8I1kmzLpTxim31YKggveDJgDySXRiM56CZ/KouyeieOCC/IzP7MU0979t4hrmM96X3K/dD9HOqQEpf0mbBJLxr056bsBlih7FFF8ZrSynKwCgzfguBzsSTvZ0rNuFn9xz/gduw4tKFWjriOQ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(2906002)(44832011)(8936002)(31686004)(6512007)(110136005)(66556008)(66946007)(66476007)(8676002)(30864003)(316002)(54906003)(4326008)(41300700001)(478600001)(6666004)(38350700002)(38100700002)(6486002)(6506007)(52116002)(53546011)(5660300002)(36756003)(83380400001)(2616005)(26005)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9413
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT062.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2739db69-495d-44b3-19dc-08dbbeb7be31
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9YoZJ2Uo6cQYagOAm793F55WUKuPQFHgoTzOf0cSrK5ng6cRIoVg7RC/+ZJuU7h7oVQkNuMKN5axJIK0UOPqhT/0Jhy1GpoL50xqA53dqtyYbJiu550uIGxRWhZEeDhtn4VJIk6MLH7RppPQ1pmB4JhorTNsHutdVlg6cWnO4//7Za7QVzmIR0+PnVNQFTrda/YPEdAM0Bp1APJeGSJd2J4bNW8VTO+22Cqb7KCe3IkbtDg3KZvK4GzYfftpC/JCkV7sqrU6huHq4IyAOec3VPKyHcKeNnWEnghmMwOuawAgw0W3S5WuKJyNCZp4e0xgcDiJd1gRki9NZENe7+3o5nGp7WSYZCtzx9nBSslfCWScVQleuWur6B2YT48EDVMeRfUMBNA2mHeSH8ey0g9PnTpxV2OSkeCXy8gcIFdAs2tO2aoumbLJiuuPc2bh64KgPZMTuhpwYiaIMh967l8BRwSTF5nwLJsuIGConrGYRMYasBwFADXsF62RrIPSOM+C56HeBdMbkIWV8glJzpiRtGA6l3zjnOhsFku6zyqVnAH8V3ccYmfZ3uiiZiuWeym08ldBp7uC01R6BtHV3WsokYoTd580K3JIOZKtWAgvlo2xx3lHiqEeB81TX+QdwMK2kYXmYdgwtQYItG91JyIJurNZkWX1K4gm93JfLOgiwWdT7rX8CsfExIq6bxFMXq8OfDALOceuqA2oqlyTXLsb+99h7Xz8VB3v0wWkpBFS04IBlpozSGEoeBUxVPLTUD/nqSThPKV4aF3aeB+E+K3as0xgmScfy4FLBoGXpRY+PfOYGtpctGbtzYNGnRu8AAJxNhIg59ZwzCdib8LOLVSv2ONFvDERozYqgPdUCQgd/A=
X-Forefront-Antispam-Report: CIP:20.160.56.82; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(39850400004)(376002)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(8936002)(5660300002)(44832011)(4326008)(30864003)(8676002)(31686004)(41300700001)(40460700003)(316002)(36860700001)(40480700001)(110136005)(70586007)(70206006)(54906003)(6666004)(26005)(336012)(53546011)(2616005)(82740400003)(356005)(6512007)(31696002)(7596003)(86362001)(6486002)(47076005)(83380400001)(6506007)(478600001)(34020700004)(7636003)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 17:41:07.8080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3189806a-36c9-4338-3846-08dbbeb7c3f8
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.82];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT062.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6652
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

On 9/26/23 10:14, Simon Glass wrote:
> Use the new SPL/TPL/VPL_SYS_MALLOC_F symbols to determine whether the
> malloc pool exists.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add new patch to use SYS_MALLOC_F instead of SYS_MALLOC_F_LEN
> 
>  Kconfig                                  |  9 ++++-----
>  arch/arm/lib/bdinfo.c                    |  2 +-
>  arch/mips/cpu/start.S                    |  4 ++--
>  arch/mips/mach-mtmips/mt7621/spl/start.S |  4 ++--
>  arch/powerpc/cpu/mpc83xx/start.S         |  2 +-
>  arch/powerpc/cpu/mpc85xx/start.S         |  4 ++--
>  arch/sandbox/cpu/start.c                 |  2 +-
>  arch/sh/lib/start.S                      |  4 ++--
>  common/Makefile                          |  6 +-----
>  common/board_f.c                         |  2 +-
>  common/board_r.c                         |  2 +-
>  common/dlmalloc.c                        | 12 ++++++------
>  common/init/board_init.c                 |  4 ++--
>  common/spl/spl.c                         |  6 +++---
>  include/asm-generic/global_data.h        |  2 +-
>  lib/asm-offsets.c                        |  2 +-
>  16 files changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 690ccdb93c4e..57afe597b0c8 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -307,8 +307,7 @@ config SPL_SYS_MALLOC_F
>  
>  config SPL_SYS_MALLOC_F_LEN
>  	hex "Size of malloc() pool in SPL"
> -	depends on SYS_MALLOC_F && SPL
> -	default 0x0 if !SPL_FRAMEWORK
> +	depends on SPL_SYS_MALLOC_F
>  	default 0x2800 if RCAR_GEN3
>  	default 0x2000 if IMX8MQ
>  	default SYS_MALLOC_F_LEN
> @@ -332,7 +331,7 @@ config TPL_SYS_MALLOC_F
>  
>  config TPL_SYS_MALLOC_F_LEN
>  	hex "Size of malloc() pool in TPL"
> -	depends on SYS_MALLOC_F && TPL
> +	depends on TPL_SYS_MALLOC_F
>  	default SPL_SYS_MALLOC_F_LEN
>  	help
>  	  Sets the size of the malloc() pool in TPL. This is used for
> @@ -366,8 +365,8 @@ config VPL_SYS_MALLOC_F
>  
>  config VPL_SYS_MALLOC_F_LEN
>  	hex "Size of malloc() pool in VPL before relocation"
> -	depends on SYS_MALLOC_F && VPL
> -	default SYS_MALLOC_F_LEN
> +	depends on VPL_SYS_MALLOC_F
> +	default SPL_SYS_MALLOC_F_LEN
>  	help
>  	  Sets the size of the malloc() pool in VPL. This is used for
>  	  driver model and other features, which must allocate memory for
> diff --git a/arch/arm/lib/bdinfo.c b/arch/arm/lib/bdinfo.c
> index 5e6eaad968d6..b88b01eefdcd 100644
> --- a/arch/arm/lib/bdinfo.c
> +++ b/arch/arm/lib/bdinfo.c
> @@ -57,7 +57,7 @@ void arch_print_bdinfo(void)
>  #ifdef CONFIG_BOARD_TYPES
>  	printf("Board Type  = %ld\n", gd->board_type);
>  #endif
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	printf("Early malloc usage: %lx / %x\n", gd->malloc_ptr,
>  	       CONFIG_VAL(SYS_MALLOC_F_LEN));
>  #endif
> diff --git a/arch/mips/cpu/start.S b/arch/mips/cpu/start.S
> index 2acc21d5871c..a95c95bc7832 100644
> --- a/arch/mips/cpu/start.S
> +++ b/arch/mips/cpu/start.S
> @@ -46,7 +46,7 @@
>  		sp, sp, GD_SIZE		# reserve space for gd
>  	and	sp, sp, t0		# force 16 byte alignment
>  	move	k0, sp			# save gd pointer
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && \
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && \
>      !CONFIG_IS_ENABLED(INIT_STACK_WITHOUT_MALLOC_F)
>  	li	t2, CONFIG_VAL(SYS_MALLOC_F_LEN)
>  	PTR_SUBU \
> @@ -63,7 +63,7 @@
>  	blt	t0, t1, 1b
>  	 nop
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && \
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && \
>      !CONFIG_IS_ENABLED(INIT_STACK_WITHOUT_MALLOC_F)
>  	PTR_S	sp, GD_MALLOC_BASE(k0)	# gd->malloc_base offset
>  #endif
> diff --git a/arch/mips/mach-mtmips/mt7621/spl/start.S b/arch/mips/mach-mtmips/mt7621/spl/start.S
> index d2f9c031cbae..d56e624f3131 100644
> --- a/arch/mips/mach-mtmips/mt7621/spl/start.S
> +++ b/arch/mips/mach-mtmips/mt7621/spl/start.S
> @@ -37,7 +37,7 @@
>  		sp, sp, GD_SIZE		# reserve space for gd
>  	and	sp, sp, t0		# force 16 byte alignment
>  	move	k0, sp			# save gd pointer
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && \
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && \
>      !CONFIG_IS_ENABLED(INIT_STACK_WITHOUT_MALLOC_F)
>  	li	t2, CONFIG_VAL(SYS_MALLOC_F_LEN)
>  	PTR_SUBU \
> @@ -54,7 +54,7 @@
>  	blt	t0, t1, 1b
>  	 nop
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && \
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && \
>      !CONFIG_IS_ENABLED(INIT_STACK_WITHOUT_MALLOC_F)
>  	PTR_S	sp, GD_MALLOC_BASE(k0)	# gd->malloc_base offset
>  #endif
> diff --git a/arch/powerpc/cpu/mpc83xx/start.S b/arch/powerpc/cpu/mpc83xx/start.S
> index 6749263da8a2..d72d3147f63d 100644
> --- a/arch/powerpc/cpu/mpc83xx/start.S
> +++ b/arch/powerpc/cpu/mpc83xx/start.S
> @@ -244,7 +244,7 @@ in_flash:
>  	cmplw	r3, r4
>  	bne	1b
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  
>  #if CONFIG_VAL(SYS_MALLOC_F_LEN) + GENERATED_GBL_DATA_SIZE > CFG_SYS_INIT_RAM_SIZE
>  #error "SYS_MALLOC_F_LEN too large to fit into initial RAM."
> diff --git a/arch/powerpc/cpu/mpc85xx/start.S b/arch/powerpc/cpu/mpc85xx/start.S
> index 562b6993b9da..e9c304277347 100644
> --- a/arch/powerpc/cpu/mpc85xx/start.S
> +++ b/arch/powerpc/cpu/mpc85xx/start.S
> @@ -1233,7 +1233,7 @@ _start_cont:
>  	lis	r3,(CFG_SYS_INIT_RAM_ADDR)@h
>  	ori	r3,r3,((CFG_SYS_INIT_SP_OFFSET-16)&~0xf)@l /* Align to 16 */
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  #if CONFIG_VAL(SYS_MALLOC_F_LEN) + GENERATED_GBL_DATA_SIZE > CFG_SYS_INIT_RAM_SIZE
>  #error "SYS_MALLOC_F_LEN too large to fit into initial RAM."
>  #endif
> @@ -1253,7 +1253,7 @@ _start_cont:
>  	cmplw	r4,r3
>  	bne	1b
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	lis	r4,SYS_INIT_SP_ADDR@h
>  	ori	r4,r4,SYS_INIT_SP_ADDR@l
>  
> diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
> index 1026898727f5..bbd9e77afed9 100644
> --- a/arch/sandbox/cpu/start.c
> +++ b/arch/sandbox/cpu/start.c
> @@ -529,7 +529,7 @@ int sandbox_main(int argc, char *argv[])
>  			goto err;
>  	}
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	gd->malloc_base = CFG_MALLOC_F_ADDR;
>  #endif
>  #if CONFIG_IS_ENABLED(LOG)
> diff --git a/arch/sh/lib/start.S b/arch/sh/lib/start.S
> index ddb9aa9f87b1..f0e1c805b01f 100644
> --- a/arch/sh/lib/start.S
> +++ b/arch/sh/lib/start.S
> @@ -53,7 +53,7 @@ _start:
>  
>  	mov.l	._gd_init, r13		/* global data */
>  	mov.l	._stack_init, r15	/* stack */
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	mov.l	._gd_malloc_base, r14
>  	mov.l	r15, @r14
>  #endif
> @@ -73,7 +73,7 @@ loop:
>  ._bss_start:		.long	bss_start
>  ._bss_end:		.long	bss_end
>  ._gd_init:		.long	(_start - GENERATED_GBL_DATA_SIZE)
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  ._gd_malloc_base:	.long	(_start - GENERATED_GBL_DATA_SIZE + GD_MALLOC_BASE)
>  #endif
>  ._stack_init:		.long	(_start - GENERATED_GBL_DATA_SIZE - CONFIG_SYS_MALLOC_LEN - 16)
> diff --git a/common/Makefile b/common/Makefile
> index 5c1617206f07..cdeadf72026c 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -74,11 +74,7 @@ endif # CONFIG_SPL_BUILD
>  
>  obj-$(CONFIG_CROS_EC) += cros_ec.o
>  obj-y += dlmalloc.o
> -ifdef CONFIG_SYS_MALLOC_F
> -ifneq ($(CONFIG_$(SPL_TPL_)SYS_MALLOC_F_LEN),0x0)
> -obj-y += malloc_simple.o
> -endif
> -endif
> +obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
>  
>  obj-$(CONFIG_CYCLIC) += cyclic.o
>  obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
> diff --git a/common/board_f.c b/common/board_f.c
> index aef395b1354e..99c2a43c1961 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -794,7 +794,7 @@ static int initf_bootstage(void)
>  
>  static int initf_dm(void)
>  {
> -#if defined(CONFIG_DM) && CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if defined(CONFIG_DM) && CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	int ret;
>  
>  	bootstage_start(BOOTSTAGE_ID_ACCUM_DM_F, "dm_f");
> diff --git a/common/board_r.c b/common/board_r.c
> index e30963339cfe..52786901be55 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -191,7 +191,7 @@ static int initr_malloc(void)
>  {
>  	ulong start;
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	debug("Pre-reloc malloc() used %#lx bytes (%ld KB)\n", gd->malloc_ptr,
>  	      gd->malloc_ptr / 1024);
>  #endif
> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> index ebf0f27e1657..c2f5a7347b89 100644
> --- a/common/dlmalloc.c
> +++ b/common/dlmalloc.c
> @@ -1291,7 +1291,7 @@ Void_t* mALLOc(bytes) size_t bytes;
>  
>    INTERNAL_SIZE_T nb;
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT))
>  		return malloc_simple(bytes);
>  #endif
> @@ -1572,7 +1572,7 @@ void fREe(mem) Void_t* mem;
>    mchunkptr fwd;       /* misc temp for linking */
>    int       islr;      /* track whether merging with last_remainder */
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	/* free() is a no-op - all the memory will be freed on relocation */
>  	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
>  		VALGRIND_FREELIKE_BLOCK(mem, SIZE_SZ);
> @@ -1735,7 +1735,7 @@ Void_t* rEALLOc(oldmem, bytes) Void_t* oldmem; size_t bytes;
>    /* realloc of null is supposed to be same as malloc */
>    if (oldmem == NULL) return mALLOc(bytes);
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
>  		/* This is harder to support and should not be needed */
>  		panic("pre-reloc realloc() is not supported");
> @@ -1957,7 +1957,7 @@ Void_t* mEMALIGn(alignment, bytes) size_t alignment; size_t bytes;
>  
>    if ((long)bytes < 0) return NULL;
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
>  		return memalign_simple(alignment, bytes);
>  	}
> @@ -2153,7 +2153,7 @@ Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
>      return NULL;
>    else
>    {
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
>  		memset(mem, 0, sz);
>  		return mem;
> @@ -2455,7 +2455,7 @@ int mALLOPt(param_number, value) int param_number; int value;
>  
>  int initf_malloc(void)
>  {
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	assert(gd->malloc_base);	/* Set up by crt0.S */
>  	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
>  	gd->malloc_ptr = 0;
> diff --git a/common/init/board_init.c b/common/init/board_init.c
> index ab8c508ad83c..ed2365daa35e 100644
> --- a/common/init/board_init.c
> +++ b/common/init/board_init.c
> @@ -79,7 +79,7 @@ ulong board_init_f_alloc_reserve(ulong top)
>  {
>  	/* Reserve early malloc arena */
>  #ifndef CFG_MALLOC_F_ADDR
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	top -= CONFIG_VAL(SYS_MALLOC_F_LEN);
>  #endif
>  #endif
> @@ -159,7 +159,7 @@ void board_init_f_init_reserve(ulong base)
>  	 * Use gd as it is now properly set for all architectures.
>  	 */
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	/* go down one 'early malloc arena' */
>  	gd->malloc_base = base;
>  #if CONFIG_IS_ENABLED(ZERO_MEM_BEFORE_USE)
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index e270edb7aade..8967a140041b 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -527,7 +527,7 @@ static int spl_common_init(bool setup_malloc)
>  {
>  	int ret;
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	if (setup_malloc) {
>  #ifdef CFG_MALLOC_F_ADDR
>  		gd->malloc_base = CFG_MALLOC_F_ADDR;
> @@ -864,7 +864,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>  	} else {
>  		debug("Unsupported OS image.. Jumping nevertheless..\n");
>  	}
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
>  	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
>  	      gd->malloc_ptr / 1024);
>  #endif
> @@ -965,7 +965,7 @@ ulong spl_relocate_stack_gd(void)
>  	if (CONFIG_IS_ENABLED(SYS_REPORT_STACK_F_USAGE))
>  		spl_relocate_stack_check();
>  
> -#if defined(CONFIG_SPL_SYS_MALLOC_SIMPLE) && CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if defined(CONFIG_SPL_SYS_MALLOC_SIMPLE) && CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	if (CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN) {
>  		debug("SPL malloc() before relocation used 0x%lx bytes (%ld KB)\n",
>  		      gd->malloc_ptr, gd->malloc_ptr / 1024);
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index c6d63b3657c3..f8fc87f1e46e 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -307,7 +307,7 @@ struct global_data {
>  #if CONFIG_IS_ENABLED(CMD_BDINFO_EXTRA)
>  	unsigned long malloc_start;
>  #endif
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	/**
>  	 * @malloc_base: base address of early malloc()
>  	 */
> diff --git a/lib/asm-offsets.c b/lib/asm-offsets.c
> index 0808cd4b0c11..216d9716d0d6 100644
> --- a/lib/asm-offsets.c
> +++ b/lib/asm-offsets.c
> @@ -32,7 +32,7 @@ int main(void)
>  
>  	DEFINE(GD_FLAGS, offsetof(struct global_data, flags));
>  
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>  	DEFINE(GD_MALLOC_BASE, offsetof(struct global_data, malloc_base));
>  #endif
>  

Reviewed-by: Sean Anderson <sean.anderson@seco.com>


