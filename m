Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82049C61DB6
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 08:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 270F380B2E;
	Tue, 25 Aug 2026 08:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qtu7RUOyB5G8; Tue, 25 Aug 2026 08:19:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787645990;
	bh=pWVHwCeMXkO8uRZsbm4BdD+6Rql9Y7fU2KMVJUhpALU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xt+0DyxcQAD3Ym9b5vbyfmgkZ+Uzb+6UvToCQT9ZfHhTByN0JIAXzavY902XWHtNy
	 K0aFt4P2zUQCvDUEytVXZzqJuzd5D4q/WQJ959GMGmUV3cjy82LhUGwQkn94Zdx/Yn
	 lTBjqRK/8G/hGkI4h6J+xnx5ZOYvajyX+/ALCaJIwBkrIlAmfrpFi/HP3cQew8lgfe
	 IwZdHUWrEaZtMBDK/3xUkzUgRoDNVcl2x+iEIF4RjzAcbE2E/+QpafBh1yZKpVralC
	 Bs0qn7Otwvka1qwFPW/c8ZJ4gXBbe9hLJXirWduMF+8pB+LS4n7v81wU38B9ndWvGM
	 SgyZWgdtxkGlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D94D80A87;
	Tue, 25 Aug 2026 08:19:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0D37279
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96FB8405FB
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6PKSzOMeovg for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 08:19:48 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=J1S41/0w
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3C2B405F6
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzWbNwE5hW7xeKSrW/eVQviWKz3PKztLDCbHvd8lBrQ+81oVjOzXfD5BM3W2HOtoZhxmg8BiBP8AmRbC5F9TbNaw06iYDEXU1NCIC6LhWpvvubo2n9tj42xfzv40Ok8xSI/XY0o+Qg0W2yywuEvDX+70S25I1Q0K2NYaEzB/SbhY6WO1jA4rc6pQ56JP5DDzITNXc8fK35JXfpdrWblSuS16TPeCCIntJrZL3KYRJmbSm4bmuha+/nf9owItO1uoTLnhpKS2EZk5KqnsPvWSUUW/NXniBRfmNjmx25jQP1VFHBguN/lyrHp2lNBu2x9AdtnlGnqx29N96ov1cT4Qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWVHwCeMXkO8uRZsbm4BdD+6Rql9Y7fU2KMVJUhpALU=;
 b=mnkQdySVKVZtk0tM2aHaLMwk3DB1c4lW1aE0/C625TIPJ4RhqDbKC4GFUUErTyctA5fNZ9WeosCASqBhlP1mAu7S4XxNRWxKp6VkIU0/hwxKH75yAfkMNQx7LdoDg6xmA8/bslEN7jm4IgveECNfLbUbAoRTH8UXlKKs7IMCoTIC93gj98tmKYYOeOFLBJ2F9EMyLOv4TL0cBqTDkIULQ8mQ6DHA9Ma+JL+FO0KqhpSxY3JCUTg177qfLDjv+nbH/+RRDfHJiuNzuUNWloEadKLa+1cGTlrnw/4AE4Q7E0tptUNFmwPhAkMAk39a/7l7fhQy/0f9sr/RQYRAOadM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWVHwCeMXkO8uRZsbm4BdD+6Rql9Y7fU2KMVJUhpALU=;
 b=J1S41/0wHipvOiM1eMbBdwY/NfsZpBqVUVNZUTgbG2s3pQeOjaVQuBS+xhqR1iemgTIUCfSW7Xe99G/H4BV1coVcd/Ss1sES7dDzg08XxuSUZGTMHRojwL6UU05FzD+uTsfsNYW3EwYOY6y4Y5XW3xUnSYxTT62WkEwOtW/VLk0hw1jeQHVB9itYmXFXu19z3d39ccFWdmysuc8Q5nLb3fR5fIoG3gzVkMD7rrAHt0RiNk4LWF58oL4OyjZ6QPbw5frgU03zIit+aJfSB2v65aOJwEtd7tDb3RZHgAJUQ2NzrRNs4xmEzlMsoA1zEUFWaDAvQUhSjs6DRixEkP5Pxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM9PR04MB8635.eurprd04.prod.outlook.com (2603:10a6:20b:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 08:19:41 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:19:41 +0000
Date: Tue, 25 Aug 2026 11:19:38 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 5/6] common: kconfig: raise SYS_CBSIZE default to 1024
 for FSL_LSCH2/LSCH3
Message-ID: <20260825081938.b74bey6zpuewig7l@skbuf>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
 <20260824122825.95712-6-vladimir.oltean@nxp.com>
 <ao1L1_1E_UAufqWa@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao1L1_1E_UAufqWa@nxa18884-linux-1.ap.freescale.net>
X-ClientProxiedBy: VI1PR02CA0061.eurprd02.prod.outlook.com
 (2603:10a6:802:14::32) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM9PR04MB8635:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb87653-67a4-4eb3-83a5-08df02819c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|19092799006|10070799003|3023799007|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UmXr63NdtU+Z0CNeNx2YHZ9wFIlulB5xNpU/tsTyJVBLv8WXLYdVV0ge2IvUUMDFwCIR99gF+K1pAJBjRAjjaNIxMWkxUE11b1x8cWKHM5+2JzKGHRGHJnRbQhAPVREePy684jnCWwSzG4m2mCtZGl/hPf9jH53XhZhHjnLrTVhpiA/sSjnBDX5m7zeCTB9J9IVg1sYGrrIYaAd/nPvn+rm0NECOMFErAm3zE2+pFuO0LuPVFiNXmWC9BUnumfPoXCBy/7UwbJs6tmsMLK+h4IGw1SEnrJY7+/FNn8VdpGXq/r+mR8XJ4RCbtGr5yAd9Rv4W9dK+8o9rb4H8UG8BsfOPeYne+ihRbxRhbAHe5uPjVL4VbFEUtz2qzi0ZD1CZoZ7CbHInwPm6q5ddW4B1IQSBmFSZW4TAMy5FIQ6EjG0+xvXxKQn1WzP9pcRn01BnMnCS4dtH/GV9vzMQjG5gZ4Yn23PMpQ5DmwKgwuwSoNr3qATFYNMmJ+GGEaiUM2NTLn2f/+laUHcCHQS92o0QTX10l9yfcl7NPvmZYx1nF+cos5eVUjhQ0BytQgY8k0hsxqZsWKRVjjoN5p0rJe1pxKgNvjpVhoGSTLTwOxuTsVdL3Jgr1GugG02EDazwmQVYAU3uWnWonv+ky/FwzwxfUvYWDiU+4yS5YrWAdtUD+1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(10070799003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDp8eUtNszVRRDCdqUe+rmekMPz5YVmlWItP3DWcJKQH3/cKhY0t8rPuaQG9?=
 =?us-ascii?Q?+muZfQd51YBxpcqlEYcbJUTTJ+q2T885HfnBLd/E7phzDfuD9Kz9CiqxVTZz?=
 =?us-ascii?Q?DselFugdRmoarxPZf7yTPONS1Nwt9hzXnhGWY287dY/UK34CA64qJfsk0+1T?=
 =?us-ascii?Q?mXfmo2E36ONQjHkoV5NJjLhZpbZv70rS/3l1+Q6JNOF4pkSD983NUZ1U5gyH?=
 =?us-ascii?Q?GFVPNJ0Jkwqx5bzGM9BykKJJIjzpCc7cH7bOUbpbffQQie53faNTNcnPcySL?=
 =?us-ascii?Q?39uZyNf8CpTOSn16ZeWyw1jkjfdkDvODuRPTJSTiPrbxnrz0vlwwh4dCDxWr?=
 =?us-ascii?Q?cS7vpKdAPcNDxS4FmqCe2Z87y4iJUr/YAS7laJzMgvApS12AeSMcM/HrRSY3?=
 =?us-ascii?Q?R5P9e4EQRS53s4VSg4NO9P11paRtka2Ofz9Sg+62oEfd0JOQX/2vz8hMCoTX?=
 =?us-ascii?Q?dwSc8szfehSxNWJjABL7GK392i92YNQFkyyZXgOnZm0gGNC9qr/hJr2mNVMa?=
 =?us-ascii?Q?LzyGSMfa7XJ3foN0nK2g+pingmtlMQspDqNBRu33Nk/jnqY/haMoHsYIEorA?=
 =?us-ascii?Q?pgze3yaoMvBVJNSlspYbuh1fRy/e4STqyKYs15N4vfrs0A5V+NRSKaGqv3GM?=
 =?us-ascii?Q?x7ciqvVq3b0AHGTllaygpsd6Ydd+s/lmP4ieqoICgt8LhIgX6Dy9vPzMohia?=
 =?us-ascii?Q?kuPeRlmdk98v2vaVuac/akWYzNJ4eXDLDfQS4Ex3N4y4hNh/Jgfv2Kct/aSE?=
 =?us-ascii?Q?Tuay3ST7iw3mdvWg+aTVbMvH4UNtajC7Q7mgpEJO6ySGTAYfI+5Ukjyv9drO?=
 =?us-ascii?Q?wCa1zzyEr9mHSNEff1226LV3dJFUzKf/hP2X66Bi20BvBWr1LrCBSFRg/rA9?=
 =?us-ascii?Q?g1QPJQAHXJg/bsUb903tXFksmrBJs4yiNugWMB1I27vpbTdVQghMh4W1OnsV?=
 =?us-ascii?Q?PEG1DdlpByb0g1hJoqQktp2f09Ei+ZjqWlvUgfkoNNKkAJFhikilEvJnYibw?=
 =?us-ascii?Q?ZsQHuW03198Hs6i/S8K0kJ0ozneQt/kadZZNnIeYKX3KN7ZdmgKiJFAX81fX?=
 =?us-ascii?Q?SsoLjOU/q3l7ulT2Qazd75Lv4VqETfyj8wlhudwy17LxNSQVM2j7grHK2SBg?=
 =?us-ascii?Q?NZZFSi0wzLqNa0smXogpSGgaQQLuzO/Nbj85kw+984pR0UaWhmngeo2zqC8W?=
 =?us-ascii?Q?vwk/UJTPbKC8dJQKNACI18AXF3EYvje0t8L8PKnVTmqtMZEylZ2MPBtZqI1q?=
 =?us-ascii?Q?SlPq9dvPuX18+YllIWcGiQPr8eV1rhDfAXKPdeNC6q0cgkLBDvthXBnHtI4d?=
 =?us-ascii?Q?s+YQRsCcyYt+phCyevH4zJj8tfaLmpHlRLytZ//MtXfjRaFXmI1jfLB+5dQR?=
 =?us-ascii?Q?qvDeH3xIMEGpsi03JgtR0HHX8d2y891vPKXS4RDkR0Hn84Wg157c/TQiwJNf?=
 =?us-ascii?Q?ncqSwlX9hnFS2rvsAcybrKCdON9Kj4Mx8al9UKMeYFNTe0gK979nvdcCp5dp?=
 =?us-ascii?Q?H6Rm9A8ppOLhNyNzhgCUYeOkPNHa1aRPnGUdRx4ZcUVo/0NZ4q96fPq3LYtp?=
 =?us-ascii?Q?qFPvRH43hDcfT2dyGqVswkDFP/1lzCG+KplBYhBZ8wFsomamJnZ24nAJUAvi?=
 =?us-ascii?Q?9ooAmq0KcjdY/VWvNgnbMK376fS+zFMOft3uTAMRVkLITMZcfqQh5cXw8P24?=
 =?us-ascii?Q?1KsEpDgSZS+AGW5TWZTRPJ35Wgt39ZTCziCShyrYsuLjFqh7200hGk7yBm4i?=
 =?us-ascii?Q?CiYWoS6DtVZ7QPfSvHl62L9yYyWoeKRIXquJ+vNfWOe0n1GSLzF75P1HQx9Z?=
X-MS-Exchange-AntiSpam-MessageData-1: FJzr4GrR/FpUWZfOWn34bxD2NKV4NyY8oLg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb87653-67a4-4eb3-83a5-08df02819c75
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:19:41.0381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+DfHLioX48QXjVtfZsyvX8Jur54AnN+VGUa39qhXcLxCrvYGvdkn3eEJHCt0qj8OJ3wVelMnUwDXGF+TEdhHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8635
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Aug 25, 2026 at 04:01:27PM +0800, Peng Fan wrote:
> On Mon, Aug 24, 2026 at 03:28:24PM +0300, Vladimir Oltean wrote:
> >The 512-byte console input buffer limit for Layerscape SoCs originates
> >from copy-pasted boilerplate in the original LS2085A board support added
> >in commit f749db3a75ec ("ARMv8/ls2085a_emu: Add LS2085A emulator and
> >simulator board support"). No rationale was given for the 512-byte
> >choice; every subsequent FSL_LSCH2 and FSL_LSCH3 common header
> >(ls1043a, ls1046a, ls1088a, lx2160a, ...) inherited it by convention.
> >
> >When CONFIG_SYS_CBSIZE was moved to Kconfig in commit d31466b382dd
> >("Convert CONFIG_SYS_CBSIZE to Kconfig"), the existing 512-byte values
> >were transcribed mechanically into Kconfig defaults, cementing the
> >limit without re-examining its validity.
> >
> >The practical consequence is that environment variables holding
> >multi-step boot scripts are silently truncated at 510 usable characters
> >on all Layerscape boards, making it impossible to store commands such
> >as combined TFTP+flash sequences in a single variable.
> >
> >The same problem was already identified and fixed for i.MX6 and i.MX7
> >in commit f7b237b81e5a ("MLK-24380 imx6: Enlarge the console I/O buffer
> nit:
> 
> This is a downstream commit.
> 
> Regards
> Peng

Correct, I failed to update the commit message when rebasing.

Would you prefer replacing the commit sha1sum reference with just
"downstream", or just remove the justification altogether?
