Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3274C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A61884B8;
	Tue,  4 Jun 2024 16:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="NqhZ37U3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306C388494; Tue,  4 Jun 2024 16:27:54 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0783A884A7
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 16:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdI6KKpwrZynw+PYYshm0SaaF3RlFeJEThQSru1wzg+7acxV9xlePELoymu4DG/BlR56q4yeqQd8ggApAZWsplLJsZ1XkqefXY01SlfOB2Fd4AMaeaevhntSDWOCP/LjgYcHiz6pEnTSRZPVugXYJ5S0e8xI6VsbQFhIDBcXQaNLZzFdkKcy4uY4M77buk8JYirOiFDF6ummKFk+L2ys91WWp4BEp3i1LJSOupaoEDo5FGeyz//IS4QcXgRbRpcIOa6MZW0GAvqlW3PMw6Iyrl05iUIKn67DbHjxjTiGLPMpQ17p16eURvF9kNWvs+trYfwCkLvIMcUa7TrlcXcrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67q98n0dNiLSX/sTawrBqc6uh1U0bS03SsRrSRqAhSk=;
 b=nWQe3DHY4do0k26zRwVSP+RBjV/QOFePBGFV5imkr6Jb1W6D4B4wsglou2NcTK7gDe6w1wo+FNAyQeI6dXDeGSBaME4pfAmI/rcaucBpU9vehCKwcgZReVMJZ45dcv4ZcCQG8Psw3w4eg9j5M8c3h7VTxihDpHVIOZejcJ4pmj+IjxCileO0iRvjDmmLeGOKvtH/SNitJcuuLFS5e1WuEu0qPdElqykzckmo81g+UD4Pv0XuREQPNggMIMB9OsfOGtCyKvWrC0yg0v3/zezs1RhlnoNQ7gazdhLpbKf9gFCRMyiSZPPaem/hYoslbBD4Ey/1lBihjWsm2m413Q7Mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67q98n0dNiLSX/sTawrBqc6uh1U0bS03SsRrSRqAhSk=;
 b=NqhZ37U3LSKLwz05dbK/TRu52zlTDmVR0wJSBIhXc3ITkeS94WVbOmB13ybChaCXrY/aWCbaMHAdytLZN2xF7377tEL+o9Te19IGfuTQVgdmaGyMK8roMeflhhxO2jg0v2miKu0CBaPVwqRuhvSHmBqvsaZoduHmVU9cdduxTX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5827.eurprd08.prod.outlook.com (2603:10a6:20b:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:27:49 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:27:49 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 1/7] configs: zynqmp_kria: Enable CMD_FUSE and ZYNQMP_EFUSE
Date: Tue,  4 Jun 2024 16:27:35 +0200
Message-Id: <20240604142741.425307-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 47944833-973e-4f51-28ee-08dc84a282df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5LVobpy9LZDHFi98gJoYDKQJpY6cv+Wb79QWnvni/s6cCPqdD6whM3TopKhh?=
 =?us-ascii?Q?XKSLUs9ZADngr0HowbSlbiHrSvhTfVFVr3+VRrbq7u7gXmOPpPXrMQLnvy0r?=
 =?us-ascii?Q?Ao4uSBjqW/tSyzpBDziNcWDTo0kg1/r6pbD81yrH2gh6nYRkayJhKYQje4/x?=
 =?us-ascii?Q?rPHC9w9O+BF12xALYRLDsjAWpUFLg9bTynzIN08pAXObc3vQiB0/VzWmiRiZ?=
 =?us-ascii?Q?/JZvJhnf47TtaZlDPKB2uHLZabD2xglN5w22jWJ3VsOMvsnvldjv62DB6B7x?=
 =?us-ascii?Q?Nijd4q/fXqrpcPyqgzYxsO4DmvvpxbuHSR1UD+V5jxa7Ytws+XZLAitRzfYW?=
 =?us-ascii?Q?7OoonwOWwIEOJZ3M6SJVvsYC5y+nzIDikc0Ql58whp8FpLA7kB7VZBytlVGj?=
 =?us-ascii?Q?G3hQPqMzgHBpOzmkD8mL5BuvKwBscAkUhiglyApCUnhS56FbK6QFBkEaG1YX?=
 =?us-ascii?Q?Omq/a221EQcjaxs199m4CAkWHEQNczn6cbE+DpEEZoki6eQpiofwB5exwqFU?=
 =?us-ascii?Q?DzMPVp33hNsDNyHGjOg2Q3qwX9BvfdZqpzuqaj5oMhbvvIEnkg7JIDhrCoX3?=
 =?us-ascii?Q?KG+0++TrRRnqsIbyOWsUSivqY32jYqkNapF5zcUnupPEDktjrV9ChdCdGZZ4?=
 =?us-ascii?Q?9A1FdiwsdKPU8aQ88wROiu2acy5pj4iVFme5/eCBFUi+3ehVlNlUV2zKLUHH?=
 =?us-ascii?Q?r3SlgBij1sniXso6XSBFBfNwer+C8qlWK3zl0l7PU6setZ4Lb3SMyyW+JKJn?=
 =?us-ascii?Q?hFWBHzv0ff4CELV+VwQZNsuoPlRgwFafnWgnD+6RkEWbYo21C4ymyX3fs8Ub?=
 =?us-ascii?Q?UnqQERmFutogcd6R/riZubsB0xZfImhSXvP8E+jqWUCJe1UJe6tyPJPXNDZH?=
 =?us-ascii?Q?Ij3AjCXtEmZl/CGPFBVnOtQRot7aynihl6YI1mnJTW4FH8Rkr3nH0Pk6T3Q6?=
 =?us-ascii?Q?EDux5HR11nNEsxc96ATzvwGf/r+CLkUK4aI8AvkDvsikyeCjLQKEatZV1GtC?=
 =?us-ascii?Q?+q62dL6Q4l+Dv4mD/VzISLbQxzsytJIeZIY2xJaIV8g4Om1EXmmKjAIK+M+V?=
 =?us-ascii?Q?X3o1j4GLQ3WWVM2eaxILseiA1T2FOUwh+sAE1s530dvpz1BMekldGfa8R/qr?=
 =?us-ascii?Q?48vuqGl8knHC/iHbLy6CDvFWzswUeD48wMAAHXOalsKK8Bj/DkMtKHrsRDYw?=
 =?us-ascii?Q?P/CP0DXRr4rXIXk1rxu6Gf+59qIYe0bBgRQygQ2Eeo1FumNeUaLDRAfEcr10?=
 =?us-ascii?Q?bnYjRJ431pDNjHqoG2McldVb+OJjPtw7gy3CVfLR7AKPSCkQ9OZRIk0tfKpf?=
 =?us-ascii?Q?56f/wX0RQvTsVVKKuQshG7URkUcVP5finU4Vc70HLYkjwl8xMWI20Owzd5gm?=
 =?us-ascii?Q?ia00gmQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zIPA0m5fCuzYmfP8IzeBEelJ2cLc5ld/hz7SS5F8rLqShLCDbnzQ2F2IWwTC?=
 =?us-ascii?Q?gEQuwaRE8lP7CkMxxTyAm82nPz3UQG8tRRuFQK4VbsXtG36z9iX0rqF9Ey94?=
 =?us-ascii?Q?/PVTOONihfNNHH8IMAZ5EQVtBZlwy5j1VZNNyEw2+MLG7VpxTv4nDIk9S0Rp?=
 =?us-ascii?Q?RvnEzNQWDbTFFF3bIbA/1IPLxviaUerV3erBnpJ0HA8vbuN5nY8scgMKjznu?=
 =?us-ascii?Q?4yxBYPOMVtCUzXx1eAMJMYHmDtDIznf7HeHDfE5AUTO8A/7p44R0dyUqcEVx?=
 =?us-ascii?Q?+4qWRwmhFN2zTKXZYp2je4Inu4dU7Zk85taBqDXt0cMaFs4tBNIdAnoSPAGI?=
 =?us-ascii?Q?SSwmxFsnhcEAM3/R5b5M2LTH3S2bGPLnFABPDlXacqZ7WdRoHOU9AvpQ4osj?=
 =?us-ascii?Q?xrwlXC/fWFB2FbT1m2L3hjw/f3fEuW2ITHKkcj9iCg0XbP9P8tm8Xqh6wGFo?=
 =?us-ascii?Q?e8pSUbkNwYmpO3vUc7xXUOMUondsHUEC4FGG7i7/lnb2YID4G/gWzuz7mIWw?=
 =?us-ascii?Q?FphbQm9FtaYegCp0YOx2jrBKmYRNfW5y8hfmxcTkeeAgo/hp59IM4+uOTNCu?=
 =?us-ascii?Q?IyT7VHib2dYHKaKHOr6DmRIEMu8Ey6p7EZ+acj6zClU9129RBff0tRUA5Q0n?=
 =?us-ascii?Q?zaYcOxwK2G6HeV0o/sKeuh3Yb7Ga7FFav8AdyxKSYIJUc4jASuMhIzMa3l4C?=
 =?us-ascii?Q?7m+L9kC6jRseh4eW3lFefbdo2POyyROaR8bJJe0n/IPR3xe3SBKsQ7IOjBS5?=
 =?us-ascii?Q?EMmlUGosvOe9OOHYXY5DYt0HC5ovKR3W22StnUZwhE8u3QyuIIZlVcasHFZz?=
 =?us-ascii?Q?k+oCqCH2gwkw8Bnx+DOSI5LxiMA0qvUQdD1z5jeWegO5PxISsHpZ+qNw0ySj?=
 =?us-ascii?Q?BMxE9WAnOYMCWkY9LTvdgOue3cOz9B8gyTk1YkFG8y7RZUXBx+u4dNWNl48r?=
 =?us-ascii?Q?y4mAlHhWx2wHFtUisJu1NZiUYyew5QISkV1TL1ADjPjLYoNNSFNCiohhErVh?=
 =?us-ascii?Q?ON0NruJXSVFP0oW/3GzInuI2s4i27zD8Vu7prwAw02YP74l9ijlDyZNuwjVD?=
 =?us-ascii?Q?zQUeMPE/DNBavlqnIzEy3YhP1zcVS7nf2avfDHA/Sg9G4KDJunDWaJ8PcOZO?=
 =?us-ascii?Q?KaOs+i7PAI1KTX6gd1AJQ3vNXJLuyYdPm9YvVm/Wj/mvXS/shlgSwU7kkecY?=
 =?us-ascii?Q?/g0a52IHsJpcmapEOPXFhK9dQ0apzae6hC0m3GzG70yXwn77KA1HEkYmZuEa?=
 =?us-ascii?Q?rCwHr65rfPjSvHVFq5S22bWr+dR2FzRaS+NMcUFKk/aiz3mdsYxt32uLMha6?=
 =?us-ascii?Q?F4JWvQ0WcWkDdMzDVornNxrpNI4o9b/rC40TvgBrq7on6lNmRmE9tjvEdv1y?=
 =?us-ascii?Q?5bi0A3NZ84UDj5MnBnkEejU0pP9zZnS0CIVkqRKVBM9r5MQHUDV3edvGMZXb?=
 =?us-ascii?Q?1cYLiPHUNsN6yKO7KvGOP2ONCDApaejk6+cAu3PvWRhVtRj96TjGP343f8ei?=
 =?us-ascii?Q?QuKOrdHGXKYjJo5bDPAB79vNDehrBf7JlSC/Y7WBAuEiXh4e0jJ8pYQriHet?=
 =?us-ascii?Q?0mq1vLi2TlK97DiCR/YecPEuZ8bdCRJP/Z08+Abh8THGSKvIlA7kg4u3I1zJ?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47944833-973e-4f51-28ee-08dc84a282df
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:27:49.5790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkNSQ9yV+44w5LUDy0xFZ67ZpuVy98rEyXzd3+ywbH5xB6nmrw6eQ7N9TBBRqxdsCr7w4q5YYK+fPFnHJpLQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5827
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

Enable CMD_FUSE and ZYNQMP_EFUSE in order to be able to write
ZyqnMP eFuses from within the bootloader for Kria SoM.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 configs/xilinx_zynqmp_virt_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index ee87beb19c6..1edd4ac77b1 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_FPGA_LOADBP=y
 CONFIG_CMD_FPGA_LOADP=y
 CONFIG_CMD_FPGA_LOAD_SECURE=y
+CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT=y
@@ -147,6 +148,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
+CONFIG_ZYNQMP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
-- 
2.30.2

