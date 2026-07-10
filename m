Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65253C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 01:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E78E8484A;
	Fri, 10 Jul 2026 03:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="C9sTfBoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E73C48496E; Fri, 10 Jul 2026 03:09:58 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA0D843B6
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 03:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajZQEYQcGMhwDQ9LLvo8eo0s9LzqZIhrtN7VhPDojNBCoVJc7pIunI6Md5rXCu9y501Yej2a6egzWZC1LfFTZfZfspH6cJ/piXFrmWWBri444f0IzigI3lxMc7+qzweVb34gRZTiJB4SfsuIBMiXzMZO5v6f/e1boW0BzntHYRojfzisvQSNE6AfmSdtxPMDly8FeMj8jDU0KIrJ0pNL/wnkzK45o95YCZDrSCoG0qLO3V33XfMcqhBR2/xry/Km6eawCWZmCuziulFP9s36r9tNFfTS435x9hwDqbtZ129hBWrDieDhewwzF4HOZafUpMkwXXNsQTcLSt+BVt2P0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtxFzyrpxst/6izM4hcLQ/QbvwaSxt7AburK6QuX/Q0=;
 b=Xy3hNbby4S/whB8vnKLZ7zT8hfl/BbushXJ8wKM4jMrn7DlFX7PqU+6KeEPi9P6ijdd+qyP9osIqCAOS3HBQJfxBxuYzX3s97OsrL2aUMXh4RDWUq9LJ5L8uzU/ZiozqMH0iS7QM7QCGWWi8eLyf7lT+nG0e5SI1djdYo0K8UdQpNLutSnWXAcnR0vaTO3bquA4v+tVmR6DA0QMyAAQ4erSPAvankZxP1toEc3L1Ci9FDEOiFCs8GuAXnzoq69QkPs9XWz0mQDV6kRbjZjrrz/FmZlNwWhNukIZzzbHR2yqTAHYOvOcD6lZhmIM9JiUh4xIz2B7EAgE1PwtcvlXXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtxFzyrpxst/6izM4hcLQ/QbvwaSxt7AburK6QuX/Q0=;
 b=C9sTfBoF3d/HNu0ZcsIGFD0fPbNwnDZU711fkWWyq6J3MF6RXSoZqKf/5JPQacFnoncpjbitxfL9DqOHBYwsAvmZGULeXgbveZ57YRZT29iWmzx0nXu3eopJ48wavNC8c6kbNJInkuwP91P7to2h6SzVeUzOWZgHf7kwluxJh/gRyi8i7/Kz5J6lCigjnyqGHh15uaE8FYmFibQxAolHXVI8nvnQqWYFXQw/x+ZQat+VQoFrGoBhzbHk/ZabfMSuXXPzwe86oD+w/pXhf2j+xM/FqRKB3jalmtCx0UFyTMTTDEahsfoSKvGPxcRqdBEMJlDm304snfWcHycxWGZYzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS3PR03MB989146.namprd03.prod.outlook.com (2603:10b6:8:39c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 10 Jul
 2026 01:09:53 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 01:09:53 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 0/2] arch: arm: dts: socfpga: Fix SoC64 TCU SCR span and
 sysmgr grant masks
Date: Fri, 10 Jul 2026 09:08:27 +0800
Message-ID: <20260710010830.5423-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS3PR03MB989146:EE_
X-MS-Office365-Filtering-Correlation-Id: 519d01c2-ca8e-4d0b-22e7-08dede1ff259
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|13003099007|55112099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LKYCKy/Ao8wwPqIehyHxLdXO5qoIwD4y+ZPEosgtn3gKCDhlTVb7CpVfZun7Kvrrmu4qMWfW7P2IOBPid+9aiKASlQkv7cwGuebPhsu6nLtodMgObGI9GIDfasrnzpMgpqQ8H0dUErQZfn+eCbo2VB2F8eFt/nIk9oMaMPM/7pKV79KHp3D5aJlA7/ALTXoAzz85nRy+vu9asUOo4YX3grzBgqFievKAubsEMOWQgLFMG0QIJG7NlQb8B4qhSPXvzMpKCS0PBrIqVGZVHa0pChtvq6OjMY9+u22JvhTJ1Bnua4/zL1/qMPfitH/Mx47jAXMRTsF+UYbbb7BS/ZD1vegPL4vcpcOEHJi/Qxp6eL8y6p02ZnBjOa+aIWcKymv7bXhQzSSKuXNUKeTXt1ut6wWk99fmBiyNNf5EhVFFzVfAJeDh0cVH4Fw2H/Sue1ysrgAiXSw0LKIS29AHfUYEeLRiMVLNVNTYMQMn15ZrMxkztirQ9bKU27ujkOFK+kNr/CQzukQ2wWGsM3sm+So6ZeyUuRB4zuhJ93OUNrjaU/ORrsllhTx4C2Vfw0j7hnVOxMrTfINntoQQiWQtqbOyCLO4DHsGQ19triYE8Ap8guYMvNHcLODmcduM43EGe6CREMBSLvD9O9hNVMSTdbI1JWf36z2qiS7DIh2Im3Q8XyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(13003099007)(55112099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rR4Zp4mzksLiybnf5rrfaQhUe+Vm2Q2cV7qVTMqEYPsQJrRl7nYTwD8vZ+EU?=
 =?us-ascii?Q?trvxtGM4UcGu3YvpHtw9aDlA2pdT/njrhlqkiG7dJuUQkhQoos2uWLFC9cw/?=
 =?us-ascii?Q?NFxmuvHHYME/2eBgjKM+ILvfZnldmeENK2iE+XQKRf146UTuyn0nf1m9gZph?=
 =?us-ascii?Q?61hqyJAzU9lhBbnk34OPIjRknxIL9MojjW03TJU1gI5ZXJpQrVrlJ5kSIpU2?=
 =?us-ascii?Q?qpcSMybuThkaTk5dSwceFmfR7lXbWJTAOcpMBUPJGlttL5x7mWtxkx5KuX4y?=
 =?us-ascii?Q?Q2p/UX7bLUg+YrPzquVbJ3GeJtpj195GvaE6LLN28hZOxo6AUSbAyQhGuO+l?=
 =?us-ascii?Q?Bg1tMkqb+UnVpXI0b5r7GVyCiCfSARARNru1YivmqfJ0uIShe0Gmk+RfyLyS?=
 =?us-ascii?Q?esnsJL//RPrvfjC0aPFnFkhgiialbfaFxjVRiA6UF/fBuZRrxLZLHgpcZcpO?=
 =?us-ascii?Q?mX77HOlew3+G3qKdgN4Ef/1LRSpfEWe/eg5tCMPGhoR9zIlK8K1S3llM3hDB?=
 =?us-ascii?Q?neUtogPgng4xFm2KevUcSGhIfqJ1MmzoSOThlhzBjnDRLms4HV88nKTHLnPh?=
 =?us-ascii?Q?An3BaWuvEmmRI7uk7I9UP32pnZQDfKnYCHt3+Hms37yt4JYrs+TADspV03sw?=
 =?us-ascii?Q?J4iSrsSBnj7/ATzZGJnhyaFHE35O+1KpMkQXVcQ+SMYCjAsAtowsggGbvFeO?=
 =?us-ascii?Q?9tJGaWdJskhboyYbaxVibVJK8TJ2PiVv1re/LWJZeFgQGM6zgP/5Jf7VoLGs?=
 =?us-ascii?Q?j/Q4AExVQht0jr95n2QVghuzlVCPZskIYSoMmkyLiNoIvjBnsqdhzewtNvpn?=
 =?us-ascii?Q?8AWjS1w0G0SJ7sqc7IlH1RzCfmbtabKchWB2TVHcK2UuFcIReCxWXpUlsCZ+?=
 =?us-ascii?Q?QwF/4mgqUjSo3CKIq81VKOZcFgr8EqADYsgoDcPF3IMiHvkHSozzde/xbGvw?=
 =?us-ascii?Q?Y8ETNQ+PREyHWCattMYW+Y5K9k1qzqCBrGu7Ku1zO4cgCRpWrp1FJN/DZz9/?=
 =?us-ascii?Q?QSRbgbYDmXMJvgCevHm3Sq/Vprd8Tr6RneM9m2uAqK7E4X17yUtvTRR0C47Y?=
 =?us-ascii?Q?mAqUgVZs+7eromyGlCTQqgA7IXA9jR2zyPZX7sQ6xJWNV9v5YvEIzMSQPxGF?=
 =?us-ascii?Q?ekqokBvLEpvHH2h+ft3StDfklFJAW7113MqOhJ7TneRW8iM6Cr+J06TkEapg?=
 =?us-ascii?Q?P8rkDexiAnaPnpYKl+iSkC2LJO2YIHOe14uY4ZtZCcCrLkIDMcZIz9MMl6rf?=
 =?us-ascii?Q?82/CQyLQ9qVZyA59D+iTN3mzq4+mynXk85KXKEborB16cNe9CMTh4ORxkrnX?=
 =?us-ascii?Q?B60oWLSH3AJPz1Y0pGCH8zAD+GOjXXLMpUcD9uHuBnM2ETFuesTuW9DHJaIl?=
 =?us-ascii?Q?fdcRQ1E3JXJmrQMundu9ShO8VPdEne8DwusRCiue23zHdCE+4f3nL5vr1uEU?=
 =?us-ascii?Q?PLhW22q+lkNnhoOoPDYKTKJaqI8c0lF1HHm57mYPcXF5V/H49d5emeCxYFek?=
 =?us-ascii?Q?qm8Z0mFJ8uLCNRWV0YQUcZQgdyqT5Baqt7BYrmO2hWWlqR3dy6YJroIYwiJS?=
 =?us-ascii?Q?JYt0qKcbkpf7uB9hSX4nqICa3Eg47Jn++WfZODPx2M5wO8xqBUX7sF5c+WXm?=
 =?us-ascii?Q?aNsYp99WWYCDcgi4JcgqVkzkEGMs7DwtZ7EI5TeK5KKVE04OPSAirHssQ4w5?=
 =?us-ascii?Q?GOVSkiT82TkS1YLpQkbCl7ZIhabWLRx6DvoVR4umOXyZg6H5o66CiXF93RTU?=
 =?us-ascii?Q?j9fLkPm6rw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519d01c2-ca8e-4d0b-22e7-08dede1ff259
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 01:09:52.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP7la/QfFeAw9LB9bKMAwxXzltHLYTpzp6IxGy7+P56hq8dc6ZkLqLj2EOYZgz56cZ9nbjVEZH+tPJlmmqrYww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR03MB989146
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

This series cleans up two issues in the shared SoC64 U-Boot firewall
overlay (intel,socfpga-dtreg) for Agilex7/7M and Stratix10.
Patch 1 corrects the noc_fw_tcu_tcu_scr reg span from 0x4 to 0x100 so it
matches the documented 256-byte decode window (0xFFD21400-0xFFD214FF),
updating both nodes that describe this register for consistency. This is
a device-tree correctness change; runtime behaviour is unchanged because
the dtreg driver only programs offset 0x0.

Patch 2 narrows the intel,offset-settings masks for the system manager
L3-master grant registers (EMAC0-2, NAND, SDMMC, USB0/1). The previous
wide masks (e.g. 0xffff0103) caused clrsetbits_le32() to clear unrelated
bits before setting the intended grant bit, corrupting the GMAC
configuration. This surfaced as a DomU ethernet-passthrough failure under
Xen (NETDEV watchdog TX timeouts, link flapping). Narrowing the masks to
only the intended bits fixes it.

Alif Zakuan Yuslaimi (2):
  arch: arm: dts: socfpga: Update L4_SYS Security Control Register size
  arch: arm: dts: socfpga: Update system manager core registers masking
    bits

 arch/arm/dts/socfpga_soc64_u-boot.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 

Changelog 
v2:
- patch 1: also update the duplicate noc_fw_tcu_tcu_scr node under
  socfpga-l3interconnect-firewall (was only updated under
  socfpga-smmu-secure-config in v1).
- Added cover letter

v1:
Link:
https://patchwork.ozlabs.org/project/uboot/patch/
20260225032149.1342-1-boon.khai.ng@altera.com/

https://patchwork.ozlabs.org/project/uboot/patch/
20260225032149.1342-2-boon.khai.ng@altera.com/

2.43.7

