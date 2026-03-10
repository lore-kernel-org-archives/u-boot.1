Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F90BFD4F0C
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 17:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5604F840CB;
	Tue, 10 Mar 2026 18:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="iTAa+7GU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED26840D8; Tue, 10 Mar 2026 18:40:51 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF048409A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 18:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vladimir.oltean@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vslp0We45ZuTAHKNuPu38RIpi06B/c00TWZYTm2cFxby3cwMhsqkt/uZofj/Zo9WhF8J4rTAAD5si1Fdcv9MCwpNpE2E+9aFIFwhZmD2yjp7nw2brZJ4LTi1lew4A99UfaEUBy2vKK0qwkqFnOLyugIqMFCWskmWCJTTKtzPfiHytysD+/odgJlJSgAVKPaDW7tfbNB7kKs935K1tXtF2oH03HQbGR6rXwI0bhI9yq+WNdpAOSBjn7iBfSecrmFzBXIObGEX4+o2q1ojSqwPwVr9KQyu2ddIgd5K+DXdgETt2m2MHFQNOTg2xcXhqv5wqs9+NBTxs9nmvE+LtYcUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25lE+y+Us2cSDeeVCLdI8KJ6gJCJfMwfXi/TlSlkoDA=;
 b=UvdMkD+pxtlq8useomMoK46fPIfcCehwWaMYgJKYBDrBSLiu2t3RgSkWzAPbKE4EzIA9ceu6zu5yq03kWl41EuVcu0vEU0qH15pfAdm8k2e2lmVZ+2vENUaz15IDcrZVABtAjJklCXJnn3jwkIAly7HtXwvodrK4WFzikMn1qIqcLeRJ7ZNI9l585AUZG/0pNU5oXyZe+souK3WCKoriy31MAcdY4um4EF8UZFTi1bnNVCAFepeOQJkwUDtbMTzi3J/5wROQYD/esiByrg6iIJOMUltB4vqnzikGnwo9C466tWoaAUchNsvTqRfwQTMbVv6LzF/3Nb/a5IOpRC5GuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25lE+y+Us2cSDeeVCLdI8KJ6gJCJfMwfXi/TlSlkoDA=;
 b=iTAa+7GUlEomLZCeRuwvHjhTkiPRrgIiI4BnL/nySdsTCpLmHlL2k/Y5sTFk/I6opUsSAVPy19A2NHYphFl0iNTLZ/1cHcSsJbNU43SHPtCIYT1wr9PT94dVPmWsxp1V424r3MZLAeyyarur2W5N+Vtwv0fAHnk5wnJfttKbdl0n7ZiBrMcWro0kQLu71c/Vnb1dysI3aWi4ZYtB7ewTfwovsXZp1z73OPWwKnXe9KWdggG+fPSUmmCJXjiXoC/bYXtALOyGkQFQHLRyT+uVLKR+CZPIuB6FCwGqgajFBU6hWu/0dxFvVSrGE0r7hGqhVuC1NlSQXceOTU4HzSBvtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10081.eurprd04.prod.outlook.com (2603:10a6:150:1b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 17:40:46 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 17:40:46 +0000
Date: Tue, 10 Mar 2026 19:40:42 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com,
 kabel@kernel.org, frank-w@public-files.de, daniel@makrotopia.org,
 ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] phy: add common PHY properties support
Message-ID: <20260310174042.lotpfwz3tszyn7er@skbuf>
References: <20260308140614.50489-1-lucienzx159@gmail.com>
 <20260308140614.50489-2-lucienzx159@gmail.com>
 <20260310083200.cbcedg4gj5jlgqso@skbuf>
 <06373536-c45c-439e-9876-69276055e565@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06373536-c45c-439e-9876-69276055e565@gmail.com>
X-ClientProxiedBy: WA2P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10081:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cef0a49-179c-4a60-e8b8-08de7ecc2931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|7416014|376014|19092799006|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: iNyQnFod2iF1ZDZcpirEElyKXE+DyuHQIJKHkDcdrNmum3sC0uxMbVy2HpgDSEDzIHazOhFNa+0ojqGAp78pcyD4hr9dMhkj/vnfauf7O/NzCtAzTHX/GNWGwZWc2jta/LzALq4nV1H+NA1DYO1fn0d8xEZBrx3xYZ8T/5OxIM4SsxPJEEBRanCsOBZdMlW0deNZ5GCqsq+jU4//GCCmBQ4SL9TdpPA7FpiTWHV/hjZbdbmS4/zBrKryFQZT/FHEEg5NVVUk0bDzCXDd7kFFSsYJj5TEAeX4PE1enRISBfP+5l2gJrzAVs6/GH+36FPHKe8O83Wrn0ekXgKM9apqo5EHgjJA28r8T8g145SPfZQeYKxPc+Q7cHSqjs9aKM9vpZdqBFhFPpc0dNiKK+wV0B58O9pV5c0e5hLOZO2bHSpvoNeuxKsoAwQQi1z5inWvtnNeNtLbmqsBMzNLL2YXLRSt1SsPZeS37kHfLVEI7OAeAWVwzbjNxGcjPyMoJbehqbfkyLyz4Q8cQFsANIYBhzwJcF54eISwK5OVpwkVnufnFtqrf0LnCJHtdqzJIQ93T2cwewFcivwmGEX+JEghcRhElxCW1a35mupHKX7A3rTkgSWNCtwRE5XswRmxVAkmHJUmdSW7zLo/z7W5WZ1sXjgkVuaCqPTbYxAYI+cUl+lfebhqyVejQqGzJ9jC36gIFW/SA+6i7V00Eayur5ez+MtgmfGq+v2t98HlLlqcPlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8585.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(19092799006)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCLni3JcOqcpH5DlA8xMnyyCI9O9JLNHVYwQ7gbIiTj3CywcU5G9lEZXavA/?=
 =?us-ascii?Q?ZyFsJWqfmzISCCNoMJhuUGdmXosXifMwriYb0eXMAY8O1ZTdVBcglXjrAORQ?=
 =?us-ascii?Q?lb6A5rvkSBk8Fihfb7ABmuafcQYskj7hdSpqiG7pzA3FfvIOvJRfkI+brQix?=
 =?us-ascii?Q?71+VDwoqBs3mb1Xw3JpyXbpdR98ZRCG3uQ1rtPuY44vZ0dcDbmWmgsUxnB/T?=
 =?us-ascii?Q?lmZQnXNynb7h7XNS+INMQnsq6Kzz1RWlWBibesyRJpmk4OsyxBOsWaXevoVi?=
 =?us-ascii?Q?keees5AVBXAaQEJSX0456IN+GQ+8PIJiwFIDQT2IGarhsjUR+UWYY50RBESw?=
 =?us-ascii?Q?D3zcvwApAvcrMxDGxlgzldmuwZuOMTCG75pUyXzcKl+ojMIq33RNZojQL8/Z?=
 =?us-ascii?Q?BQvYajNczWloGyHSVOBWp/jyE3du2eTyAyg70T9IHQY0LXWOvSO6Naj6NwT8?=
 =?us-ascii?Q?Ps+PLRgmv6TAqHp6HeXihVl9rANPgrRdKgHym8adScQKFFwZ7uIB4KjFvFoD?=
 =?us-ascii?Q?bTiHdFA7gk+MUXgcAnLxXhoEn7ORo4OYrGx65nsEJEs5W9017DfI+rDP264m?=
 =?us-ascii?Q?D/0ecS1rfPeiDlm5Rp1aP90ytrCWLfieOj8wFKV8X58IDpanudAW4YvVHQt0?=
 =?us-ascii?Q?rj8Job17WPWw+ZqRjGbE0v/vHjpi8a//EUmBnWMBAHu2mFWQVrAWol90naii?=
 =?us-ascii?Q?6GDPFTpoUyRrXm415HFhXS0XUp9VVWZ00fkLSEvv7jCJYdGUmKofoNbYD02h?=
 =?us-ascii?Q?KwVdQO7kS6jOnnzySQRVJ7Clts1zTFvmX0BBRcO52+rgQ1XzgRBzJ88c49VL?=
 =?us-ascii?Q?ep/oPvVdVR3TSq9CyDrcfP0Roygx8Ck5uChI1Ag6BkxqctpaeqBdTly2bDqO?=
 =?us-ascii?Q?fW1bK5STfAXNE7hRmBZZuMRa6gfCFQYktNZjT7MDv6srjg55G/Cqni4fuzao?=
 =?us-ascii?Q?kdL1kPofgZkHgZ0aTU7hwXcd0qaI90aulEBEiOMV/exQ68RVir9nEFesYLwy?=
 =?us-ascii?Q?XvqoGhuHB813U3Es+F4oolQJBNSS0D7Yn+2Y0dhIm7SbsQsEPJ0rC8l9deB2?=
 =?us-ascii?Q?Y85KJ/CZHvLL+HE5bCrBAk/y4L84CreDO85qoHLl7S1t7nJIGBgBq0fkMRNf?=
 =?us-ascii?Q?ulbGFIRJtqE9uqm8dC5CuoVbtQoutbzUfruUILlbOwOEHdWkGeLdtpXyWpEj?=
 =?us-ascii?Q?mBKqayLf0exR5b9sUX7KZDlPZ0TNR6jgI2CRGcix2Uysx4JoF7HXYMCNDpSm?=
 =?us-ascii?Q?bYKaABar8Hkw/oHrCeGH2ALPjlEe9LKpOTyCAFWruqTp3nc3yb4CXUsH7pV6?=
 =?us-ascii?Q?GHKlv0qHifVLjrDoJalRKcIe4SovI4KuY8708kWraL3jrn8JMmFhXnGxn1ap?=
 =?us-ascii?Q?oZg8C1h5iSgBWcpX3uk2RZYqFnrnXSfdMBYfSJ4dky5BE63chfCrnhbYJdFz?=
 =?us-ascii?Q?VeVsR5DBfyqh9mTFQyy54r9j/LRnA7utnMl8ghUWHVZUzqa/5Uei3JpboTuU?=
 =?us-ascii?Q?D0Q34Mc2IjWlIssS6OAVmWYIZiIDfYx8UpEAevpRfKh+qri7sD0lI7xF0oHn?=
 =?us-ascii?Q?lVbK7YZ3uTTY37xlnj73Jj9L1INiMuPe5XT8WYwzV6gT1ztw6n1VGk+SYIBg?=
 =?us-ascii?Q?DKdl6MH6Ms8xcDBshNfwrP4lSWeyguFPk5p420z3uFzgDp9zcL4+WeTVi9dt?=
 =?us-ascii?Q?L2pY9P3ow910uwZv3/DUbMHLFPbCL6InSca8VOJhfdc3IqEj+FUxACPDI8c+?=
 =?us-ascii?Q?lVEpUWuim56K2M4vCsQ3ejgEy7qudi2HgZQrScX5c6cKqWcx1OvhFFgqlnAi?=
X-MS-Exchange-AntiSpam-MessageData-1: Mx9af/9dQu7Dfi6MHSd9J6xXOOcyrcPWaSQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cef0a49-179c-4a60-e8b8-08de7ecc2931
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 17:40:46.4140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1B3JYXdPKa5mqUPHaCMECo6zdhIF/tRS8yjRf9Pc+ZoYfR4tJIt5QsH65/USvxy29jjO/rDY6MZet5f083krNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10081
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

On Wed, Mar 11, 2026 at 12:21:45AM +0800, Lucien.Jheng wrote:
> I haven't used KUnit before

Enable CONFIG_KUNIT and CONFIG_PHY_COMMON_PROPS_TEST in the .config,
build and boot the resulting kernel. The tests will run at boot time and
appear in dmesg.
