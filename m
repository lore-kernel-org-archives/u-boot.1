Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA7EC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 06:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F9A884D0;
	Tue,  2 Jul 2024 08:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="GsntSHrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A618871A; Tue,  2 Jul 2024 08:49:02 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DF4884CD
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 08:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di1r8SQuJYOebw1RwTmtep49bukf5EmSVreflTCjoJOnn3SpkExIACXDLEFO7dwmDK2fndhnXGdbnyksY3iylDwqV+coEJv4idY4M1VM1KCZ3BYsOb02Gp0gOIHBp4YOx8UhXPl2JTQ9LuQ0guQexyWxVZ5dCQIedwNuiKDlMp4NMu/PBOX7Ic1NgCXnHbJpWJJzuToBktYrSpoLIzvCpPFhuEP+DihdK+2uTEfVRpiRUiaYEBbxjkjSzgCmlITPCbJoJZ5HyKdrOihYfDXOZnAzlBcahvwPW1N+3N51VF2kJvjzPrHRdpsFf3f9MLpZa8+KxHMVWQJgUcximBnRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bni/5vqNgjTxA3CKbIkr9hMVZ79BDyw5M+uIBoasSw=;
 b=UpGyWRaz+g/cnsUoTQxhGKhtlaEMGa3nt9OjohR4vDqyxCFzBciUEuISJV5QproSLK0lbxr1UjhPfTvej55WkQBAhnhrDuAvANzoRA8kl4khhL0P2WTLYh23MKqWPQY+4AV0meJMxVUP4izaefau1ucoVqbmGMus6GNeo7e4BmZTl2mWA48oLYmaewpVAwpPBwI+PG2JyYn8fHKrXYX7F6Dmwscoxe+0NXumYjAJjoZQqCuPkfYNwm3ksk47Jm70ISUZTitw2ksCRbzRc1BCZMhVrI63WIb4FbSSWCSv6FV+b3BkUBi1KScjMUGmqXtaty44wjwt6cjsyS0EM7J9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bni/5vqNgjTxA3CKbIkr9hMVZ79BDyw5M+uIBoasSw=;
 b=GsntSHrctfcUNZHp+WIw6c/9As0/m9FWoilcY7FDYra+z1Sn5PfwrVnpfPJlGJajBZ8ISwiaBLg2eKqEfJtFb0+1Vz89DA2P2hlp7okoRNViVbOwHOIQSvuT8vq8/uIRGEQguO3K9QoFx7iC95UHAFQifGdDUs3L7kMlY+VnQ4RoGKHINydcIXSHSpuiJ0z05iA04pdC5vsj+0VidFCTuzfmG4U7sv9mU/J0y0xkNyGrit4OELw1bcWtS13inOFeLbM7o75+NVCc7wc0qhZsDHx4344+Sz3NpqV9p+d+jO8ErWSLWXeFjqfSjpPDpNAeoHrmmVrCu/7AEKIK7zUPdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB6356.eurprd08.prod.outlook.com (2603:10a6:20b:36b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 06:48:58 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%2]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 06:48:58 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Kubik <piotr.kubik@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/2] Import environment variables from FIT configuration
Date: Tue,  2 Jul 2024 08:48:32 +0200
Message-Id: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b1f2c9-cba3-4f14-8f53-08dc9a630c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zJi1TOep37WEbAa+fbWSl29WGRAbwktGJ1ZtjBcmjtCvAKQHH9xenwzzdHsD?=
 =?us-ascii?Q?M0vzGgi4R0ZvppOZiqGfja8OFPiFomZfBAi+VvhiG6n7X26z0NPwCiATEcCd?=
 =?us-ascii?Q?EQN4vUSYuW+hPr1T38ZaGnHQjZOspLNnYfzBntl/ZTdOcrovJlczKcJO8g3C?=
 =?us-ascii?Q?Luxetixpi9R8IHJ23jAVGGQMe0T2Yf/y4YYHGBNGljg0ziIlyR5u5A3TwmbG?=
 =?us-ascii?Q?a5+m2FbWVxCDnJB7JFkwfxF3OS+m0CqBSpEeUuCtHwind/US+n2RlHhfLKAy?=
 =?us-ascii?Q?3X8GaeRhnR1ktIOpmsXjpM0H8xoof/02yNtlhJlkttd7cHoXKmM5DOV/cM2S?=
 =?us-ascii?Q?G4eFGYV3dTD5xXbl/qOu9Dr/tTeAwdNwdYgvs9FuVf8p/zaG8mmrQHh4gOCK?=
 =?us-ascii?Q?wGMfv6RInhAyW2BvREZ4zHWrPMTn9msDvyikcE1q9YtoXApp8RmPh02gKU0s?=
 =?us-ascii?Q?DPWEyoy+43TXzZmeskdYysTx4AR2M/kuHXIVBJC+CS6DYh0tag8CJ+epTOlY?=
 =?us-ascii?Q?l6IqzRaw4QzD7T2Y4Ng5MY8PHzsZ1Y10joXUCyKKpQICQsPlEJE/QqWx2T64?=
 =?us-ascii?Q?YlLU7UPuE0Qni94F1pSHcuqjLZ9+j/KR5xf2UoNR5kG8wbgb0Tmy0HzzpvSF?=
 =?us-ascii?Q?VMOTuCSsomyNAD1DTgshap8/ZprVGhueQnP7/pWD8vEYmpAuM31SZ/Mr60FG?=
 =?us-ascii?Q?N9woDFaY0gJeHrjGv/g+esmAfR5BPg4X6khmxLaeCPCZJpE4v8YC7TJmXoOx?=
 =?us-ascii?Q?FKczHKXNa2JNzTGmai0/EFDKq8igqpzDgBS9bWJYSNVRGu/8Ycif118Wsbyv?=
 =?us-ascii?Q?FBMvmCYW5z57xRMo34zmSr37JuQ17a4zJJ6pP/ZEI9IKpNzLXKB5595Gd6ue?=
 =?us-ascii?Q?thyvFecN9v3Tdl1053iz8V9qx5A3AftvURzGOhUCXhoOCaNFpf/2mvmYFw+U?=
 =?us-ascii?Q?GxB+su3u21x7ZlPw7iiH5s/Hv92PjLBtHDIeOCyICWRyO8e4G+H1/+4mXQsn?=
 =?us-ascii?Q?rNzlaLRuh7oU54QWVJ9K/WftjabCon9QZ9qA3cw5eohqjpq/FTkUxUvkMbPh?=
 =?us-ascii?Q?xX/GzBW1tqNRjEVqXA+Q/ybIjHcOTLdp0Wqbt50/RnpFbit/mADq6gPsLGIQ?=
 =?us-ascii?Q?jAFiuGwhIieQPnLNuZuVyur/MAzrxbNqPqTb0VKcqmqe2sBbpbeHxmZ892Bk?=
 =?us-ascii?Q?y1uCKvygKmsgJcvwuP03UtxjypTYWw3+WqsR3fnVWyiyS8OSdi5kWFDCEuDQ?=
 =?us-ascii?Q?fOUnutM+5UV5W8tOEFrh0HkRb18kvCNw7d4pQL2khTafYbRykeYHAuGvR3D2?=
 =?us-ascii?Q?EHZ8iYwB7rnHhqHkdGEPz2HAS8hWD2HpYNfAY9cGmWYArZJxuLii/gwHtuzd?=
 =?us-ascii?Q?Y/PlHqA7YFIFlVC5xmgRMI17Qd3d2iiCneW6ES9QauYPcznbVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YzHCoH15S6ppdoWGuZ8Y1wT5g3R/rOF0Hjfis8IlQ5JK3+bZmqs8YrzBg9Uo?=
 =?us-ascii?Q?0NbQKEq6O9fYgbDJyl4iQCSfw1Por29DSin8+BpZRKVI4HhY4jxfMThIK9jV?=
 =?us-ascii?Q?LIrjxb1PX70/NK6RpCoREbpF4lmq5mS74Z4Zh8Rjx2+SieekGy/7W//ybGm8?=
 =?us-ascii?Q?43dniOR/YhrOPdbgLRnRSu1c/+uwHyCARdWs0c5I1BJ0SEJMAKhorrUInZ5O?=
 =?us-ascii?Q?Dc9onm7nvt8xSQkyax70eVKzY68JvNtdA7D/ZTXkpA+EjWl15GQ/xVQjqq2n?=
 =?us-ascii?Q?voap0NuKv8d2XMCURfbdp6NV9Mpta9xEsKquY7VzY6oDPTZcbw/EqflQM/kz?=
 =?us-ascii?Q?DaHwRSjOrGYajvF2fpmiCNK3d3/m3vkmqMVWZ7+tZfCQXyToqVHUwVJx5va5?=
 =?us-ascii?Q?UhnaEChfK2gaRVbL5xJ04416hmxaNDwjs7OB2tR+3dmhjZUyFB4H9JCZmBgH?=
 =?us-ascii?Q?W1q8wmHu4tCd9hxGNzFiC9nnf5nM1H8DrJinkQjerEu3sLjPzRENLuYwafEr?=
 =?us-ascii?Q?o/vyHEVbx6tAlZmNPSP2JeMN5fUkBCGNuueBCzrUwc9cIvumMoFeZREKgSwT?=
 =?us-ascii?Q?FiEKzbvI4V4fts8KA8XWZiwjDEleLnRxxZ8j7rLWPL5hqOCKMLRwzsc8Ne7B?=
 =?us-ascii?Q?dYQ4PlF2NgGYwE6KRbCEq7NRC5pGcvGV9YsAeaQNsHRUnNGpcOqKJaVPMrlp?=
 =?us-ascii?Q?wFn13XJFpkvAuHchaBi9ANLhJYrbJ3KKDQdqYwpXLLt2w72FG5TzdoTSsgy4?=
 =?us-ascii?Q?aRSrLtTnjST7X/kw33AV/5SuhX7oi0ZRHSZws3yP1AolQwZHB+FwRWEOSp24?=
 =?us-ascii?Q?Ih7ensDRlqxzE5VHQEcCcDzjRcwuWe2svDZLtCwlPYirqR5DVuvk6msNLc9a?=
 =?us-ascii?Q?IVJwZpDwFfSNU+fuw6Q+YMjzA+OAW3U7/alKfvOWKF68xD+aMKlRxh82ORVw?=
 =?us-ascii?Q?DOxNqFMtVIfjH5NuK7X/eGOm67Km1pJC5i4N2qlJqbQw4XDwh8+ODl2XsdZx?=
 =?us-ascii?Q?DKh+Zf/z7qLn74Lscv5NhPHKiOrcTYg9r3RYrcJOD8gmjwjRb5g6qqAVG6Sd?=
 =?us-ascii?Q?VtCVePa9l9Pzc+YAWFHLut2SOJo6DlciuMwVjj82FHA8Vxn82ZvMJ8aPp4mk?=
 =?us-ascii?Q?MFgw3q3zCmmL5hyyHwU/yQ4xA5w4GonVRL97vFR95+g+WQCq1fIXZoZOZz1n?=
 =?us-ascii?Q?lJYsBCD09hhu+RNz4QGZGRtgUp/nIQwL67xy5PGAvoSCHdBNCobTGHPqC4Z9?=
 =?us-ascii?Q?+pOSwhC3BmoQCzfM/LqcmmlS+MVrXyO6DmQ/sSU/MD7TSHoPqyeWfeu+Rn7r?=
 =?us-ascii?Q?kpNTcBeH3uuvaGf7fFtu8Sr/TU/fSooARYdNiE44uHKHydFEkY8JOzSym97W?=
 =?us-ascii?Q?cJKgKj/XDK1e3aNQw5GlYwUbGAufdglWmGlmhHabwuP0g+7iAp7COY6vMmSm?=
 =?us-ascii?Q?FrQoSAbEuT2X+jDhLfe59m2MD0/D3l5bdQG9qH01N4GiJIElCMnTuDgyky4b?=
 =?us-ascii?Q?1yxpLOnlJ/MCXQsVnoaM99fqyt4oMk+MxyLqCro1BITx+zfEJUAZNolplFBp?=
 =?us-ascii?Q?Zu8G8Nckf5QjN/bUfLXdDoIOKXQF+oaufLTIUJlopuArvs4Tc9EmFKV7z9Qr?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b1f2c9-cba3-4f14-8f53-08dc9a630c65
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 06:48:58.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hEMmamOnWEMPYdJwBVJfUtiRxfbF8AmN53dnEvk0TS2ZZODJferKLfpOOfJ79FPoYPvhAgm2XuATksVMaDYrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6356
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series enables U-Boot to import environment variables from the
selectd FIT configuration. One use-case is that the overall build process
enriches the FIT configuration node with dm-verity information which
should be injected into the kernel commandline. U-Boot will then read
these (possibly signed) environment variables and put them into the
actual Kernel commandline using variable replacement
(see CONFIG_BOOTARGS_SUBST).

Example:

Config:
CONFIG_BOOTARGS_SUBST=y
CONFIG_ENV_IMPORT_FIT_CONF=y

FIT:
    configurations {
        default = "conf-1";
            conf-1 {
                kernel = "kernel-1";
                fdt = "fdt-1";
                env,dm-verity-args = "dm-mod.create=...";
                env,bar = "someothervalue";
            };
    };

U-Boot cmdline:
=> env set bootargs="rootfstype=squashfs root=/dev/xyz ${dm-verity-args} ro"
=> boot

Kernel cmdline:
Kernel command line: rootfstype=squashfs ... dm-mod.create= ...



Lukas Funke (2):
  env: Add function to import environment variables from FIT conf node
  test: fit: Add test to check environment extraction from FIT conf node

 boot/image-fit.c          |  4 ++++
 configs/sandbox_defconfig |  1 +
 env/Kconfig               | 10 +++++++++
 env/common.c              | 28 ++++++++++++++++++++++++
 include/env.h             | 11 ++++++++++
 test/py/tests/test_fit.py | 45 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 99 insertions(+)

-- 
2.30.2

