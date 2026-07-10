Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20E2C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09648484A;
	Fri, 10 Jul 2026 14:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bSKhoib/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B419B84A4A; Fri, 10 Jul 2026 14:36:30 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A71846A4
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nueoKNfHJhh7uHG4KMRvvaqtKsH5TbveAB6kxXah7MsJ9ClEx7VkvIKJJ1u9lxZk0i6sn7WzeuuvBgxTPgGdZ2kLPZef8vU5yaZvlzW9QY0Ltrx8u32yvC1ARCDYjgewj43bSfj4iliraVtuTmjf+lYyY1HRNdc2WiqCrKJIXV3FVSYxx0xLXeAdFMnsq6NDh+MAMnkj9dgdHbjV3ZkmWmS0QzBvj7EmOvEwrS2JelSCIkYyJhSeEdtso0A5a6EBqoTeaLTDoBqjTKOgBI2JRvAwwjxDcVCc5ErgwrV1HdH9aO/oUDDbJdu/tPQZQEdtUzDSh7OEggYdN5YHSIRh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S98DU+TBFz31beie1C3eujv18t+xjDB+6YdCJ14a3Fo=;
 b=L2wws3DTCDcMMzXbjLD5oPGzuFYqHYFLUZ0FHj5KM/PmyeQO0PuAqT9sUKIRNRdd34hgRiy7tiwEb0DNHIPXAay5ZR4z6c61HZsv6hOatCMThBvYp8gdAz7tHmrjq/xzIeGg0OKWynOtnCWnE/n8V2N6s5XLIB30BKQW4m8WnJ/eNcpW2uO/eHorVoihnQWHJVvg3hQKiWBSAEYxUHRIO95RGjIdp9C9uRMZRbK8vrKuzw/zy20fYhykHoe/O2sLu2/MXTXmte0iECAdJjWDCaqIT+l3LLKwB0yMM6286GUSLa6H6OqVV0PIPkjTMjsPvPg/1ywf82xeh0caiol6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S98DU+TBFz31beie1C3eujv18t+xjDB+6YdCJ14a3Fo=;
 b=bSKhoib/7utmruKxWOWb86UEQBKa3fObIyvS54G+Is3sMDlMR1lfqmDtkfVNx4HXY+rUxPk0ofqSHcScJngfUOWUQS80jR7WUg2OSUzoVrGWk2ptn3i8dIX49pU+T1R/3el41dPClX/Y2bi4hdhXBUbZorLFEm+geum1VMut7zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:36:23 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 12:36:23 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/6] k3-binman ergonomics
Date: Fri, 10 Jul 2026 14:36:12 +0200
Message-ID: <20260710123618.2036728-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F722.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2d8) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 43500f67-f0a9-43a1-bb4e-08dede7fd9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: UGQuh5Xf6hoIqfoNb7o2+wo6YEi2rBew8C6mvm3qvkuHcVogR/yMZtup2wALdIw7ind989EKdW9B0410LhsmjyrlqHf5Sdkk7W4A7CkNzXcMIXnTuImTnEBe06DOCGwjnhDUB/3hXu3pm/DkQHHaQgkuubcBmCkkVkBQKyqwsGBZumqZQpRmZxWBMoJ7/pCNWLgBvz0T0PwihBHwRfGKXUyjHKPMK9f6gx619GJHJEvQbPfoTzs1X6MHGJIfscJYp18N681YEPieuDb/HQSftXxoz3RTT+zQNtuHseTQTveLSUY13FsUP0WdZZNBn5G8y1ggROyuFxSKqKLyTgbxuG+mgVVPGStR0csR9tfSN2oxdLlTqYv5Iw/PxKDY/hYw+SBNMxssWXRasJg9yncKSKzU42XhdddQxXaGcE3ZZI1TrCJjX58pzfpvz6YNpL+v0JCqlKNlZnSkgJjxDdg+sDShaxFWAwIGKXgnAWSuPBLwd3bFJq2ylBhb4fInejK/g6G1U4dRhPlq1X0DIlgrEoJzccstf4SC+cQdUPccMPVSNOvUGCy+c5r7pCqOZLcDI2lvf4BmULJz1ccSj/CrcL2C0gT4lpzax3/8KVBgadxeoBUReDjN6H6J7pHXuwVus+Q5JAsQ96E1VUwUkhjhdKcn9YrcADZKlYaFSSAFBRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7gTXSVHxyKh3zDV6VsW0vJ4zh65DUEW7G6RMsBKCHKZNshBnMYyRcFNfsj0?=
 =?us-ascii?Q?Sv2eWnZyO8APpGkfj/o4dPCFznRWH4bNstTmkFzwiProj+0c7anh/0N0k6H+?=
 =?us-ascii?Q?KWR2KRHruUECSsxRuoUVmtLjUOXHObSfsr0oQB6TTTCkM55AOpd6sKMxGLG2?=
 =?us-ascii?Q?dMhrIyzkSi4jIC+2E7/iLgERYMhtqtMq7pLHi6t0ZY1irkh2aj7UsyZem3/1?=
 =?us-ascii?Q?o+zx4PuMqfDLuQqteZrZiKr4bCi8QZbJJRhhBgMy78RYdgUagXPYbkLt0fGD?=
 =?us-ascii?Q?Mzs3esiBul0tmvNeqpqFipz8Z+xFO0UJG1cVy70OPSx5oz8SIbebtwSOnWod?=
 =?us-ascii?Q?rSQfeaISm29c/VXcOzg+wx0wvEhMvB7NY+bemZ3yKDdbz4psHqdruLngFHj8?=
 =?us-ascii?Q?VrwEDPQByo3IUzfPs9adv42/FS0Ts/g5DZfCyquRsvZ9Z48FhdqWKRXh/VLP?=
 =?us-ascii?Q?uMpjSwf0/8IPzAL6Y627ZDCKfQTZahNDxclViF1C4MSYiGe3+ZfYoGwjdqVc?=
 =?us-ascii?Q?JlHu9MkbAOgA0cKo9wiOnC6TDaaZsAP6EIfTV60P8mcAaSIl6dBPQAh+yWVC?=
 =?us-ascii?Q?Dt8epRrEZA5qJ5h/Hdqlv53OJ/yVcm5/MQrPlOGv1/iCXRsdIeltJU3f5B+s?=
 =?us-ascii?Q?U72+CBU2biLnbvo0Nq5k7RP1qPD/s5rpoa4UPnmFOXc8+N2yJLfyKIFMsPJO?=
 =?us-ascii?Q?vJDIMpT5EI9VaE0+Z0cudx6y1/ePXwgCdgKyK/4D9rQZ6IBF6mf84YBT2xUu?=
 =?us-ascii?Q?OuN1CLxyZ0J9wwomp4DxjDN6Q/4vf5Z++2Rts1sajkbfCA+zMGCy0+dBIBYR?=
 =?us-ascii?Q?QjYHs1PXQ+joYrpD3+VujpHRhgluIFwcrp1EBvhVarF36u/JDQt2PrVzvG/b?=
 =?us-ascii?Q?yk93ozHP3dxhmkOYtQRjtBJZfresgUhOglRIFIGrffEDM7h3LvZ9031Or8T/?=
 =?us-ascii?Q?4ERwA6TaMIqgJ3wG7+c7dJzIjIjCDxQ5ZlqJAJM5Waa2t3fvySzyVbmk+AhY?=
 =?us-ascii?Q?7B3cOT+Ie7WmnZeauv53Ewu+ImHgp3eJjnKL0o+V4hlXFSEP9vLNkqAR8qcr?=
 =?us-ascii?Q?nY1Vi7TUJd41c93lSOgu2TytfgKe+9T/Cq1LStqJ9nHBaF8eqmP/hOTI8vat?=
 =?us-ascii?Q?8dRR2HStoyFm23bHfDOjl6LYs3L4Xlo3201Yn0zPxzR2IsO9PcOrv5VxxDcQ?=
 =?us-ascii?Q?5/ZgRy0yYl2VLdFGy9A/5MfRueLqvcVvKM6b3rX6VmXgRyoeEiesoNIU/hQ/?=
 =?us-ascii?Q?JWXoPvGUV1US2/jnNpGggOPQmmOIpW6K80R+SMQh18p9d/xpOninL2VAaBWu?=
 =?us-ascii?Q?QqGaDyISV6bJoCYXCjRJ//VSV8IPsDHnW5+x92roRhN3zx/XMvtr4J8k5iNa?=
 =?us-ascii?Q?9ilQ5xk/DWPjkPoJOHcHYqJt4AMPa/NjUrj7il/AhCkPebZrz2cB0WON09dd?=
 =?us-ascii?Q?nnjsJIfhcQPvoPST4kbrTd6H0PBLcJikWnRhkahOhPyQc6OTftm2rBFvmyz3?=
 =?us-ascii?Q?rvN+QoV1l2F2w8Ni/5sUruth9E5H+F6rUuyAVeiNY8Hy7ZX8Ia7YQTtvI6MC?=
 =?us-ascii?Q?dOS5uI1CcQxdnpVQz7IogjYYOG0sZ74nzNEYJFK+77KX8sZalYb7mM5Mw5yi?=
 =?us-ascii?Q?qOpy1vUfz1yDSA7uWEAoY83LLcNiJhCvNitQuIpr+nttgmbqfi6rtzRtR1MD?=
 =?us-ascii?Q?X74add7GGHOu1XBogllKNnQULg7I4TwsLQWaqpYHSlYxEmxr1p8YgpoLcxmt?=
 =?us-ascii?Q?WPc3VZ6xae6zkSUdapVdlAvVt2Fumqc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 43500f67-f0a9-43a1-bb4e-08dede7fd9d2
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:36:23.1417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHMbVSp0fWwouUqkyPTW1nn5uWvNeGc4JA6e32Rt2qwBOjEftH3omtSlMreHpbEVmD9XsoDevirG+LMKIvWzOVxksVB+LzM51+HlEWKHUZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6942
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

When trying to hook up use of a customer's own signing infrastructure
for some am62x devices, I found it was more difficult than it should
be to point at the right key(s). One has to patch in the keyfile=
property in way too many places, and if you miss just one, the build
succeeds using the generic custMpk.pem for the one you missed, but of
course the resulting artifacts are unbootable.

Use the template mechanism that binman already has to allow one to
only set the keyfile= in a single place. I cannot really imagine any
case where one would not want to use the same key for signing all
artifacts across the r5/a53 cores, but that is of course still
possible, just as any downstreams that have explicit

&{/binman/tiboot3-am62x-hs-evm.bin/ti-secure-rom} {
    keyfile = "foobar.pem";
};

&{/binman/tiboot3-am62x-hs-fs-evm.bin/ti-secure-rom} {
    keyfile = "foobar.pem";
};

will continue to work.

Rasmus Villemoes (6):
  binman: openssl: refactor creation of Distinguished Name section from
    dict
  binman: x509_cert: allow and parse distinguished-name subnode
  binman: x509: fix CN emitted for basic x509 certificates
  k3-binman.dtsi: add keyfile_template node
  k3-binman.dtsi: add empty distinguished_name_template
  k3-binman.dtsi: insert keyfile and distinguished name templates in all
    ti-secure(-rom) nodes

 arch/arm/dts/k3-binman.dtsi              | 34 +++++++++++-----
 tools/binman/btool/openssl.py            | 51 ++++++++----------------
 tools/binman/etype/ti_secure.py          |  3 +-
 tools/binman/etype/ti_secure_rom.py      |  3 +-
 tools/binman/etype/x509_cert.py          |  8 +++-
 tools/binman/test/security/x509_cert.dts |  5 ++-
 6 files changed, 55 insertions(+), 49 deletions(-)

-- 
2.55.0

