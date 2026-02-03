Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA566E8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87EE984167;
	Tue,  3 Feb 2026 14:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gi5qJdHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E5183FF5; Tue,  3 Feb 2026 08:49:08 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C114D83FF5
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnEdfliXE2vSNRG2wG9887gRjq5wZL6lFGDro3dhEXy12Us5gL2jeTlROXiPtXLNLwqcmGnv0FXZ/YOhx3AJl1QoGjXIWSxc3bcO04qww7ZL+QNeMZxwVSLK5sjXjWUsgW1dLqzp/cn4+hwNQSEroTSxDSPe7c58zfOItuk0e65zw7fSGXTtdZfsX9DXCg4dJEjEWotl7sQv5rNxnQsDPhjLggD9PJzPH6zld8YBL7vNBMxeAtPrzeClUETDzQHuud/7vX7MWnF417KgYgI+ODGcEXYrDylhQje1bxLB+rQLLYRgIrULmcmxgTrUscnS7S7HeOYvn+aBg6jR0YaTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKlrQzFmXxeYE2kiCDoA1l09qGjAHJAb8YYZJ1E3C4o=;
 b=jsUNGTJoxXmyguqrmMR2UAL9nNgm6XXJhZkDyfXAg96nj0bi5hjKSejK8KwapO1mPPd4r+zf5xWFHj236se5p9lpsow6Jd7Kx8rtI15IXZPIhiF5sPKS+V0n/a68S4qKRzd6PAQDysWiW7ojICkLvJqEXCi23vnPJuN43pAUwGDPyqrXTYky3V3cQAay3+2rfiavR04EVyPPJwunHVmdhU7ilo0yfWr9NrG4384wbPWt6JnFzpnO56MSGmZnSmuItLIAdU7h/GZvl6mDDni6sNy0I2/ACsRiUS6zPNabcFBRejdF95+B1sqpZnlsdRZKDi4N2sDhfK/v+enVVLmJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKlrQzFmXxeYE2kiCDoA1l09qGjAHJAb8YYZJ1E3C4o=;
 b=gi5qJdHuVmrb9BJZHuNZFCOdZ3G9EHFBzMdY2teaAtrl0ElqhepU3RNXlGpkwBqoEdNKRf86Vee6oofS5psm1nY1hYWmVEaPA1BLDXk5Mrn1Jt3N5UJXyCUX2iifpxmgpP3fV/XU/ijc+c+FXTlOu6ZPNLce7VvqyYgVFZtozpjg0bkgb8WFKSHYezv+Ew4/LTsnMSoT8oMaKoUFPuCtvivpiXTVTDzuIDP6ETT0fNl1Xa09paDIYUJ/O9n3jw9GUiDDjK7/L0pmCMpqa1WPsFTOwwRGtfyZmGhLb3mHWVlbJPASNVyi5hkP/2sZURE89IeFtTFip5fPzlGUe+ahKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV4PR03MB8236.namprd03.prod.outlook.com (2603:10b6:408:2e0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 07:48:58 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:48:57 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 4/5] arm: socfpga: imply SPL_NAND_FRAMEWORK_CAPABLE for
 Agilex platforms
Date: Tue,  3 Feb 2026 15:47:20 +0800
Message-ID: <20260203074721.25520-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260203074721.25520-1-dinesh.maniyam@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To MW5PR03MB6929.namprd03.prod.outlook.com
 (2603:10b6:303:1c6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV4PR03MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 73572491-6967-406b-9aa3-08de62f8af8e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2pi9ct2Bgi3qHBiFauVn/c3QdrbiG8BJRXENsvDLFAiQXsEV4voY8PBSEYrC?=
 =?us-ascii?Q?Rmiso0cKweW1/W+FJOo+MYpqOlY72z5J3Frj37VtqWEOS3ajMnq+qo+YbNL+?=
 =?us-ascii?Q?24pnNfDxTqwI5rqmkWFOsAiCVxZJezhbuWHF9SEdYgEgX4m1eEgXj1nTNGkB?=
 =?us-ascii?Q?Lox7AaPcfrxCg2uL7Ljy1eDJwKwO9N9d86rhVV2as1SI24FUMW6vVRt7ayJr?=
 =?us-ascii?Q?tlUh5ewA1XoBXFKytR74dyf2vBGxXQygQ+VuuPJeJUaLEy7g3bOBMknySQIk?=
 =?us-ascii?Q?xSMR9OP3CYFJrGIPHzQGFrmrR4FFc5ZAC+KdSrBGn5HxUOdjvUi4I+4s9cVy?=
 =?us-ascii?Q?mFUxCuVa5VaipxSFS9u5ndOv+H8i6RPoW5YjX3pWAQqnORLZCGR+HXe9daYW?=
 =?us-ascii?Q?+rDeHlSeo/nRypv4dXm+EREiRpFLA41vDXhBCK9hrvssVAwtVK855OI0k1Ka?=
 =?us-ascii?Q?W2aesTbquKAXg1voTmbUuyd8BbcINYhhjj3gV1KYCYYVMBntBCjBt1Gac8ez?=
 =?us-ascii?Q?xJdIB/Z8JkqL2/mH72jbxoZH032uM0zN1d0+bfjQRL2IGxkC3e+Tj1Bz58U4?=
 =?us-ascii?Q?58dc5BaKbeXqof4VFEZnX7phJTXHcDvNGoX6aruLRnwf1FeeqrabPFN5PnEe?=
 =?us-ascii?Q?jDj8TYp7HS4n3KyYBsic2FwMXOC82T2GoklhYXAqeVttj40EH7BaZUdlQWRc?=
 =?us-ascii?Q?AQmnNtG/j2AwkrjDZHZ4TUi3zghwTSljfuwpGlsirtb53YK+giNL+viORCrJ?=
 =?us-ascii?Q?2kjak9xBoIG0Rs4bn2jd0KUHPso9eQK3RQWcR3gAdaDLv4leXIG7afpplfOc?=
 =?us-ascii?Q?MtCjODEBGlw/IxePfbhzHBB7U/HYpcrRgbMg7yoO9ZLrAl//i81aWNN1Ns79?=
 =?us-ascii?Q?u0ZEgrpPO3DMuRnfnak6cxQiBWdypRHzMzIf7oP0P/tfj7s5U1yA5xrsaEMk?=
 =?us-ascii?Q?fZuR+Ch/2UKPVg+39exXpK2tfO2P5YhtQC69caJQPqFNneJVgcqUex2eriEI?=
 =?us-ascii?Q?kMl9q9kO3kc/b72S+ki7c5Z6ftg9L/BmJmnplvG5jgf7XcJVXXycuNzdjnZB?=
 =?us-ascii?Q?YWiazCUIUl0HWc35TvsDwLhOLdTPMjn6CIs6nE1aUwHICKtg38ULdSLUTYXp?=
 =?us-ascii?Q?f/g/EolxqLuzIwqhj3Cq8NMzf5ZP0wpfxHFbkxP0uBPS6B9L2d3ZKI/SH1P/?=
 =?us-ascii?Q?xjbnNf3G03xv2O2PEXlOwMJvuJcVFPTUISv2eXskPwrt9dKkbw+pgBSnv/iv?=
 =?us-ascii?Q?Fp0RaReQNuDl+g29Ywk46dpU44eZdnxNkjLspiefTbgNNyk65+DTMqmCI4/D?=
 =?us-ascii?Q?jpAt0haohpPML2EMi+ZhVGE1BpWt5KTUirF8Q+0Xxkh9mLyJUvjdDWNkZ5ox?=
 =?us-ascii?Q?qqynDz08m2JpOGtEo+1A9X8lWA747NLanul+ex8jM81RSztz94yaWPvp2YlA?=
 =?us-ascii?Q?pvPkL+60gltAyiiyDvRcwYIEOsm3wNjUAPT/DWYKneYPURk5MUUUKE2bci8z?=
 =?us-ascii?Q?eYK/ht36tmOliI+nA7O1/9Ghi3qqIF+NNJ1kS68dYWHbtXR0NdsULeycFLh5?=
 =?us-ascii?Q?hfcmwPvZoywqjeEfrek=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DHLBOoymaxyvZwMfsksFhzYHKE+nb7AzZEXc5P7QD09JXbQvKujHmVZghybg?=
 =?us-ascii?Q?PqdIiaSqrvv8WQvPceCZzwhjbv2X7YWFXxhx/vd6D4QabiFqYBHAQ5wPiMqc?=
 =?us-ascii?Q?Chw46dbuW6L9azWMP5lmSCYY4+lnePb/biAKHUwmzKxiNql74fmKcElGKssA?=
 =?us-ascii?Q?RqNupl+JMU3aGbvY1xjQyGMh5CzISN/dhMX5ftjut9cxvuQpkPfeWZcJWi7f?=
 =?us-ascii?Q?mqG7RFDn8mAseoy0aQysMliztp+cEjc4vcz/0QmSJ2J9TqPYp/qYa2ciYOM1?=
 =?us-ascii?Q?9DlnQ0og/IMtaTf8Pm6nFtrQ6BP4I8B1ayZwpp2nX7lnwDtpQB0BqkDWyCNh?=
 =?us-ascii?Q?jjtOZnDdvyjKrjqU196zQCFssV8NDlZrfelDnZke2S7RInN5dQlsjwAQohIY?=
 =?us-ascii?Q?vf6VJulqsiDJDGWNEg+trXMmNIYopjPVHKGqE6XJCuQMXj1R9w5oBT6FbJ6t?=
 =?us-ascii?Q?FVh+hookYzxdbxzwxCMru7bfiWhlajQV9esfIvmpUKUBf7z+NixHwUOP7vDa?=
 =?us-ascii?Q?4vwX15mmgIq5Cd4fZCeimeU65bVPWmKFz5aT+Rn303mV4kCtAcNa3D7+ZMrD?=
 =?us-ascii?Q?Hrr4CCM6HKxK2AJQmDLaQrBs0PV//Bf4ipdiNfus5IYDwnwF4e7KyIK1yO0a?=
 =?us-ascii?Q?ghg9IeuhZwmt+AwFPg9D9Hb0Mwtd/8evGWZ+LF3U3dCCGE5IK+WhL91OfUMH?=
 =?us-ascii?Q?B83kfnD9nGJn7hoEMDm5fpvh8V0b8IgB6bKaKPUY9Fj7VdEGOHmtHzD8/vg+?=
 =?us-ascii?Q?5iWx6n1a/j2+iZpPAkUSdsVni7GsyExuoGuio23Nr8OlfZvTXttraqrOqb9y?=
 =?us-ascii?Q?vV2rS15xP7YpFS6p1PwtxgPdQEYmPXML5kMtUJnCOgMCrZIkXkgAQGOEGidD?=
 =?us-ascii?Q?7GWaQ6vh7qa//huC03vYfmqYSsT9W8/GiH006BKQL08dLOsXM6ZkJn2JRu/5?=
 =?us-ascii?Q?QfCy1tXphAhRcWGiDoLjesZMUMRrgJA57vtSO8BG66czvljSK7aKUgkNk4Gn?=
 =?us-ascii?Q?r2OCa/wjp8ZUNY7e/NhMA8ala1SxS4SInvmjSDdKkrpybbvGzOYi8jcsHdV4?=
 =?us-ascii?Q?qQPgL9N4i91nTfrILG7ZwSorahCgUnzfbfVoUfU9i8Y8SgUFc7VtF5DP4uMo?=
 =?us-ascii?Q?DFSqb1ZrI1KwOF0BLJI9g4h3/rFAf7xilK19pu4Fop1vWw8cfrk9pIt8Q6/J?=
 =?us-ascii?Q?Twg8AP04Epf+5nQrstJEm3HLE67hZmuD29jVthPKR7/J5vKjHffzGw/56sli?=
 =?us-ascii?Q?hvw6j3EvtJ9CJdIat5dXPVwyeufiDbvxMrjrs6D5wEn2/QeGYIvv4IBsv8NF?=
 =?us-ascii?Q?X7vkEwam5qA94E25sM/24oMcd5s7/H/Q/TI0aLZhJ67WWDhZFhJAGnwm/teI?=
 =?us-ascii?Q?lwp14LrF3fDI/7tXFHTS1f2THEA1/bZdpx9LdCdNGjXXGxgLQaCJDNBjpWU2?=
 =?us-ascii?Q?nwIo3TKrZd7SCIETeXFD9Nv8a37aLUlvQ6z5w78TNxqSY3I1p4Nd5lXknOMW?=
 =?us-ascii?Q?F3xgaCIrxi2V53sxC2qD5FXyv1XTliZYXinaBjzvmhR5oD6r/AZ0/TsG0FIt?=
 =?us-ascii?Q?UpUN/Mchrx7iQGctoObqbtjXt/1n+AHQI2Kn4BsnHdUsItnjLDx9u1QrO3Wl?=
 =?us-ascii?Q?jrlaCxzetAmF4rQPzRdh12eKdCGgYbEdyT+w+f7Ksc3CVupOY8Ip1SPfUELl?=
 =?us-ascii?Q?yboE9Q/9mOC4NSNvLRPmqKn9peZqoNgM6VEmY4QDLFyiJvIP3pPWg6eUaBUk?=
 =?us-ascii?Q?T885k58KaEmi/wcLGrS3fYT7OQbM5fU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73572491-6967-406b-9aa3-08de62f8af8e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6929.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:48:57.8001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NM+Ei01PGfeGB1VDaYHOlXLVVam0r/ZrHWXOnEFFnXgoXUOPQ/mVoOqMgsf0xL7U2346poK5cu+OgYGtZSewMWqPC8FgIFJfDfOjLPYjgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8236
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:34:39 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Use imply instead of select for SPL_NAND_FRAMEWORK_CAPABLE on
SoCFPGA Agilex and Agilex7M platforms.

SPL_NAND_FRAMEWORK_CAPABLE is a platform capability hint and should
not be forced when its functional dependencies are not enabled.
Using imply avoids Kconfig dependency warnings while allowing the
feature to be enabled when appropriate.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..3b56209c3f8 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -59,6 +59,7 @@ config TARGET_SOCFPGA_AGILEX
 	select NCORE_CACHE
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
+	imply SPL_NAND_FRAMEWORK_CAPABLE
 
 config TARGET_SOCFPGA_AGILEX7M
 	bool
@@ -71,6 +72,7 @@ config TARGET_SOCFPGA_AGILEX7M
 	select NCORE_CACHE
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
+	imply SPL_NAND_FRAMEWORK_CAPABLE
 
 config TARGET_SOCFPGA_AGILEX5
 	bool
-- 
2.43.7

