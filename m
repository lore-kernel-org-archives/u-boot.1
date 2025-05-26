Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E25C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E906882B7C;
	Mon, 26 May 2025 09:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KDMEB59j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD3D82CA2; Mon, 26 May 2025 09:08:41 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3D482B26
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHltMpecgqGwlrfW0/37mgrMa2gdpBEFaiM/nI9A3zDXbEWzCp6H2DkqBo90wJguVCwiU9pvVg77t7eo1hQMOnpK8YeKHb6us749sykAwAeeA9npRlKfEpI03imwvYd35ZRYVTFIaj35SrvVmyRtExfm0w8PkpDjOGHnAjmZx41M5NF/6W8ebc7U7c+/SBK7DnnPFkvJ0wDnhUhqkN2xuNfj9+DJ6Nw29OXSRM/Kpie9Zx0Hf6XhohpRnR6vbHsJwKBvIP0sPirIJ0X1klUGnblAFBSVofwmqlVaE3n1Fho6ujSomDro9uhr8vTNx9W+kHMP58ScQzUks8IJtejwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRuxZog8LbAn35HKvyFDv2GIBlV23SOuFSACs3aMnZs=;
 b=QkWeANaAJtHqlpPTxUcAw6Uy7X7quNvhD4D6aumBLWDDEjTAHDIsQFE5BGcomtgkgkrMs5ePaPJt+OgDNClezF4BQpxks8paGWvuNtzBAygQZtEz4pxLfPh4iqNf4Vk7CpH8O4dpLttyyjT7dwbFyzsc1r2pWkMb262S3lstl9sfy3X9fEMOPTW24+sFhvdyJ8r6FHwuNKAVigHT/qzNanon23H4p6gYLfSus6lIBmxiT8qjhfJ8nevOKn7EPWD4rQKIvTHHWOu2mlgGgNwOs7kDNAk5kNwKctJCTmGodFBa6lYRrSJJpVyE3Leayhq43dGHoaDfAOz4/iDdNzUVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRuxZog8LbAn35HKvyFDv2GIBlV23SOuFSACs3aMnZs=;
 b=KDMEB59jo6xsSvsZZD5r7XCnmaslivn7Eb9h1+vruYu7aUehDRBaKq3hC/F+8u5mOFc6p7WAl3esRqwSRiCrk/hrDL2jnon69SdU1VdKSToJyDzu8Le2OmhIQxmg5iYgYdH2/8wzu68rdHjvQaZml9tptZmG1JHvBPUj2ciSn45flonZU2KOws4oIrDa9XDt8f+JDDib86ZkCsPr9SAexY4nUExzIygKEBb+8y9ME8oKLXGYCCmfT4YAWV2tc7friGjNyYdOoCkAPnHXJdFFnh7nQbfQMx4EqUzUWlMNxLPe/bbBhRVsPnB0cUuXJUL9HWFo+y6EX/loco347fKfOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Mon, 26 May
 2025 07:08:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:08:37 +0000
Date: Mon, 26 May 2025 16:18:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 12/13] board: venice: append configuration string to model
Message-ID: <20250526081824.GD19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-12-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-12-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 838e21c6-8ad4-428e-60d1-08dd9c2422c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7+aeoO1zdHG48u43bj296DCnj5ht5i79KMQ3HnzFU4lVZfDZT7pumr8CxYcd?=
 =?us-ascii?Q?YtzKsNZdrUxkWMwOlmGlIG54N+5RpNEsW3I61aHvEll/0BS1k8nlSJKLtQpa?=
 =?us-ascii?Q?7MKRbJ/hK48dWcoStzpDipctpsA/UqygPG6cQe1ot6Ii5rg8F1gfDhkhL2AJ?=
 =?us-ascii?Q?IjyXB3rK4sn/x9A1GryopsXc8LUIPs6FfZKRjchRkhH31oLV0BeSA9WQxIqQ?=
 =?us-ascii?Q?nN1TYdMSNbglpaf2YS5D7guidK4e5TusfQovRBsR8yank2eCL/mQvKB0/IuO?=
 =?us-ascii?Q?DERDVbqSckTL6Wh9ESXkFvYxNr/w9i58JKqwEp+q17aC/4BBn8CKvr/1B2Q8?=
 =?us-ascii?Q?2ywUbHeIgVOyJuPaG7UcD75t3NpgXp4rdHW/QAnTQeZ1/EvAHAr+NVcRK2I9?=
 =?us-ascii?Q?Q7kusHE6HPN9v2+FAjuXJ8xpM3FBsMzxcrB/zPjZbvLC7VeGlEkixr//feL5?=
 =?us-ascii?Q?k87//BfScYjEb+RXnC0fbMPzKe9uw3LwXLMbrhXroCkmYhe7AmD1/GhG3xxx?=
 =?us-ascii?Q?0gVE8yFY6dbPS1TSWSPo5pWgCWhNm9EiM41kHFHcSJSa6L8r1agQbgMoT9Rn?=
 =?us-ascii?Q?JXTtn57Ckit3tW/AaEpHayrKIYKUrhZhFOwwBBRPew0OMAt2pBWA+dQAw2FH?=
 =?us-ascii?Q?iWEmwPL9dEXhEKFRji6wBPIq3+KoC5Ip5W/dzY1aXKQQmol/JlfscbqdCv/u?=
 =?us-ascii?Q?uGfL/rKthtA5uIavoDTUNjtzCD33d64uhWF4n6rmonHAmwGbjmR/0iBes8Sy?=
 =?us-ascii?Q?3IGbO42Z7FxTVn21vpRaI2RFGl9Ya9ENxDMMFRjjaRMx7QxneW9iYdODHHLd?=
 =?us-ascii?Q?VozicxHKaRCO0qxHVjcgVvl2tvHtlSyfKBMTIO243Wq9aj9w3P4Jn9XT/aQC?=
 =?us-ascii?Q?3NB1SEUht2RzimuvVj+Xc3+K4duhWFqYFybcP8T2cIAYvdoRCXYNAmePk15i?=
 =?us-ascii?Q?awjrWS6ssHb06wDtPeulePiUoZ6b8xVf/TIaQ99W3gUBDIAlLV2VBwm2/cT0?=
 =?us-ascii?Q?ERGUQ/qZAKVofGG+ceJuWY0uUN5xtJYYkzpKCnsex5ogVMZ5zONRyAFgWP6y?=
 =?us-ascii?Q?zZ75bwP5PL4Htx0nBHSAag2IgqxN60yWQYFj0eiUaRuTAzyrEP5CR7IgiqnX?=
 =?us-ascii?Q?bJ6gzHUo2PJbqDMFWllQJnWYl7NupLfaMG7e2ODw1xI68u/mmERzp2JEDrjj?=
 =?us-ascii?Q?PxDMdguax3Yx5NqH/pmHeeqOv4uleJ+86EkqW/xT9JvvNmPs7gOiP+lVOieZ?=
 =?us-ascii?Q?uPpFnOvvBV1z6svSgUvZCYtD1tE4VZVQsetNrsrS5I8CY0kxvcoXQBPseWoq?=
 =?us-ascii?Q?2YgzmHx0auw48cAGRbL5foyHSPNM8lvLtLg3ZXFJR3ybQ1BE2LS0ePf0CWiN?=
 =?us-ascii?Q?tanZuuchecdAxQrK8f9D/M+OOp8m2ZJ5/vwo+FyM+wZDWI3Xo19dupoZ94I+?=
 =?us-ascii?Q?lvCPr8vP9GH+skLCYjABrcc2F1IJBHFgcMJgTy38lml0eBVC8TPJPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?su12+d94Dvh5IFwKwmt6BTUo9HRaQFOtzx3sLcHT4hDSyh+HqR1GPh0Zl7O2?=
 =?us-ascii?Q?TJkQP50QpH9HB7tjiQe8JFULKb51JKMYqbX+ho8HsAck/JBFuXL1laELnZkD?=
 =?us-ascii?Q?syl6d0MSx26Q/mrlfkKYDSCedqarN2GP2DPDLuR5hCszxOrNULvU8q2rLVyz?=
 =?us-ascii?Q?Xq7wu3ZU4hUHMUp9Iid/yHd5B3VC6X24Rv9leBaAOHfQMReVvFl3hjwVRdZf?=
 =?us-ascii?Q?kTOJeNhz/Reup1/jqc8RIClNnL2+8blCi0s3mUzPDmkoqIxYJIyGbm0JoePi?=
 =?us-ascii?Q?MKSFkbSBoH3v+FGeUYh/8jsBf8vlORn1ExZv2NvUkzACfehx+rn9JofoVTeW?=
 =?us-ascii?Q?d5Ci9hSgnmXAXgn00YqT+37Ysq6jOQk/yqyJq5MTXyQwjiKbrUvahh6DqGMm?=
 =?us-ascii?Q?R75vHtz/3fGtBkab/1m2qPGKH+ZXDiXdEVyelk3gSdUO9pBVDDkNero9bexJ?=
 =?us-ascii?Q?/zaQHVZ5cq2aPLgnb9a0U2GNcXHjs8R5uwBpG/4bCRY567bEoSxf65uaiiXI?=
 =?us-ascii?Q?gBFsQWWLRX7LfX6MsUrXHnEc996qSoCZvzYnyVjsxtPAsMbn+Cc2kZJimjAe?=
 =?us-ascii?Q?Zja5djx6Mi2HGb3PD68BHsFM/kx88ySyoRJ5+JQ/pa+38q4Kcw8/z6oUw1PV?=
 =?us-ascii?Q?t/62zWCFQLi7KS/5UdFT7vh+MYEucekK9qbArprc+6EXmyGH+kuWev/qsk13?=
 =?us-ascii?Q?NrwhsuKLDP43C2ebjlS8y0icxITL8x8YanomIwBahNRE+ToWwdJiho/xBX+a?=
 =?us-ascii?Q?gxT2I5U6C5BEaFkf/H4CNPuMIy2Eg61frj6v2U/leRdsBisS/JuWB5iIrKLN?=
 =?us-ascii?Q?EdqVzASx234a1iM27FTmi/fL3ZIxPjvUveZYMXyFpFycO6nSEIbW5/JNje1A?=
 =?us-ascii?Q?VTjwITd/QsSWvHcUjcb08Cnxv6DbX07GDHwCQK3Ymd07vxgR+XTJjgaB6WpB?=
 =?us-ascii?Q?8QUAcJrpQR1K6DN8S/26ZUXX6+mrHEpMByVuNNhVqiEjBkk0rh1NyYsuAEO1?=
 =?us-ascii?Q?qurkT7bldXczXjKbc/R1r0wnf5iZ9amOkV1eQqUyvmKBom3zL3vzsKgnVP3k?=
 =?us-ascii?Q?n8iR3ilwRJ5orb4svk8IjFsFQbiZLjOT7Aq4HJLhzQa7BXco9Gvte7rhs7hb?=
 =?us-ascii?Q?AH2HhYK6JEIkpKkbgmalP1eix1SsuhhqR6UVtA2DcWnb8CaY3kOdSBBWrRCt?=
 =?us-ascii?Q?yHeLH1F/2Azb7pE8tw2hWO3ogftS1Pzas0awLyds3ncy2XFJnjylHsRvogP6?=
 =?us-ascii?Q?D2OgFFyACzBEDP3LA179wiKFhtKkVL8Oeif4jH7bKY8lChHTXkKd5rFPEz8d?=
 =?us-ascii?Q?4y5l/JWMKX+gEA7mTNvuTLa/7HFUgg87l3anSRtpKfo++Nd6DmtRJCE35dKh?=
 =?us-ascii?Q?6lr2l/nPhBNa1RdZum96TF3Jg88sAocDw4uDYIn/pbXvvSIWgARsO5NQNjQS?=
 =?us-ascii?Q?zLAEeQtTy5b198ocDX5RfcxjCJfYXfeWWLApDT5gHxlCrb/Jw8OkBjPSsETg?=
 =?us-ascii?Q?BzLb0jgo9q2UqgMbvH2wUGfXKphAgoJO13QXOdwmsyAcwFOkjLO/ZHiT4cWd?=
 =?us-ascii?Q?AICKMaHBwU/Ue+J17hK7gDWeuRw0gxuNgjYbbdoZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838e21c6-8ad4-428e-60d1-08dd9c2422c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:08:37.3788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BY3uPhmOXuWgUDvlIGuvAwbMe4CwymntJFdiQTOXSrzztFGGw+pQ4Fs7BipjrlHD6MG1bNIyObNm4bG5RgzHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Fri, May 23, 2025 at 10:20:17AM -0700, Tim Harvey wrote:
>Append the optional board configuration string to the model info.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
