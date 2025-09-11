Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A7CAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E22B83322;
	Thu, 11 Sep 2025 07:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="eg/vbwLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF3883236; Thu, 11 Sep 2025 07:12:41 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEA683236
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjcFfF5e+A0CxPhaB2g26ydhgOWxGHJuPXjQlu/cFCxDtCGhwlmbC1Io4ndqNmAL7i3u0XUdSOEhA23NCwZXz2JtWX9fV0KjjQA1bVJ9AjI/fhFpbAH1978xjdGwrh2BQHyI26lm8xJqr+aHYv+L1J93gOF0XusWDvuaGwsfFfLnP2oW7W+Y64nJwMTPatmFF+2zRP0uhq2Uh/CU7j+MNN5cpXzARu0d4X8zxjV58jvd83Kkl6gpsH+xsf1cJHw4ehtdjrOHi+WeYoD0iUD7aE23C3x4z586ZWHJB2qJ0Fs+QH7E1YlvMdZSpXpU8B1ACdmwyH0ZaYIJBi2wawemiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7X1zgRh4HiODljESWnmJGeEFrt3go3MORVgvtEFn6c=;
 b=IwQBHkmDwp3x5MsMtKRmz2hYxZ7v+XX8Gb8Tzag5DBFhPOiYpvwpojSjSEv0stuOQJ1HC0KxSCOaJHlzcicOfEOqi9ETO8KXklPYIzFntf5zi1FoVmBGGY0iu9nWDdfI34cQ3FJOmY0IcFwAnuHVoRCIhN4EcpGr/qF1g1EY50sMg28P9F5ZlE6V/G0PJgJJaMEzEpiRMEEpMdz73Hk9sd/OCv9ebIWRenfuUYEv6jrQxxmkK8gLFL2vrZK1AlnYhv5MjTMQj2kM/4x+/Hpm3tpGSMAi69KJZZU+akoBfnu4vHVgFF1xC/PirbBYUymTiaAkxHg6tw9Fxmi1I9h+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7X1zgRh4HiODljESWnmJGeEFrt3go3MORVgvtEFn6c=;
 b=eg/vbwLju9RY/tTz+3ohYdoDXyehPO/HUMLmc++hrcISZ/6KJ6rr+Fxe2ZNJF1px81IzQF7P1IvrgZHBz1z1NpZM7Q+noSWCe1v7td3CNPEq+p0yR0ahBqaeU81dlUEsMY3SqWRtOcyOEYkihS0qn1MB+zPZTr7yTy33LtBgzqvuItKaCAX4QeHqPgQA1jWmnRKlTBNIWNMyq2utdPOl21rvMET6wzFPy8OL+w2lQiV8fYPUBJsvrj9kmNomCTf1+wmhzYUa1tH94UO2eLWFIWJpsDNLa4YIdyGqF4Sx3QTXuSSWZWk1kfW/tMoT7/xuVl6gI1qK2DK1jUXejXGGSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DM6PR03MB5050.namprd03.prod.outlook.com (2603:10b6:5:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 05:12:33 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:12:33 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Date: Wed, 10 Sep 2025 22:12:07 -0700
Message-Id: <20250911051207.10479-5-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
References: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DM6PR03MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 4030a8ac-a255-48bf-008c-08ddf0f1d076
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dYEE4boVYQJtA++R3koBHAeirc8kICB+o3+p0Iok6Pa9utf+8nj+4Hy5yzh9?=
 =?us-ascii?Q?dlEtEWMa/XYUp5WEIgMlL0Q5Bd3qNuucsI84dYwFYYw+uEwtGuVZGPzajLBl?=
 =?us-ascii?Q?uVpz/GAFhqf5qYijUvHCQH7im0dee6M12l8EJMWiBIxR8juMbpqr0PzlqPjl?=
 =?us-ascii?Q?jRo3ikoqLKDkq1AZw2nzM2ur+EHzSlzQp2DXyK3D9zHKDoOAWcm9ceQFhb98?=
 =?us-ascii?Q?KE+vmewzXUEFJwYxiqozItGRAL9bfsXA6Yky73jHjlLvZs66TEDrYHIYqJkN?=
 =?us-ascii?Q?NgX0DFPMzdOhPADJhJBiKBi1F46PKB3qJbyLQPszMpujmKL3XxNagU5uS6Zp?=
 =?us-ascii?Q?mn4je5aL3V0A8t/AcOuykoYRuM6DG+qcJqCVS52wGGBpOgXoaY/EgA3Zh4Ya?=
 =?us-ascii?Q?mQx7WrTHMVPGOalwrCfC0AzrrRgwrNhJ4yuZmaFue40DdsQopnmxFLw7nf7o?=
 =?us-ascii?Q?K0Hjy6auGaFDFEgw95RFmlhRNPMxH+zaFEMqteJPWMfkWW8CeK+1sy6lTJM4?=
 =?us-ascii?Q?hTvk346Z2Nj0YQhM3L+MYIcEec3icL0ulgcDOqmwIxDK0VYNoOufmwS77qDl?=
 =?us-ascii?Q?eS29dPB6f0YjZGMjYqwdivUXvRWXcNwCMrRmfnjEhtPsL1ILFFRvfC6uvW0P?=
 =?us-ascii?Q?QeNmiwGFjKcSK6HWUiBVQUFQtFIsSuVSVFKzRoZVSGFQhDDLKgyCFxMeFd58?=
 =?us-ascii?Q?+i/fQUBxtq9oPxl1uw9bKJ1OXjeB7FEe31vBABHo+HcVyk7LXZFKLM00vUYk?=
 =?us-ascii?Q?3xrsGOEUH69VQX5S/sEegiBCPYxkvLnB5MIhgrwA+ygK/YDEVBbc+40L8ojW?=
 =?us-ascii?Q?NuMs0tOjv59cL0+9EgiJE0A5MqYF0lqhLZUr7ShC3RwCX76/h9gE/uWilPxu?=
 =?us-ascii?Q?mqd6j6v3sBaYXPYVpi+IkviXUp2pNZK1UbIEAWMkZHRsfciYbXQLhOSpkLH5?=
 =?us-ascii?Q?E/s1Gg1ccIhYdXGS497vtJGGy5SaerS/awfkIYYkk6bNNhRzufjWuKrCxgjk?=
 =?us-ascii?Q?0Pql9zFrEZPoV/votmwPywBhrntzlDnoL22cWeJRgsXYjtprf4WdbOAs6mh5?=
 =?us-ascii?Q?ycjZOQKi2Kl5i2s3cfWFGaICMHfXmbx8if8BB/FSNRxLAPwoCSqeBqAnHJkt?=
 =?us-ascii?Q?LMcVqi+Y31Q+nKxnzkawxKGRNZ/JqeHqNQr1o3Iqz0Pi3Q6UOqIllCS8TaMn?=
 =?us-ascii?Q?4YWDvc9ACTxN8s8yfarRnaQ5fT+rUsBcbvRfHAAWtwmO9x2IYo0/f/ZLfzcH?=
 =?us-ascii?Q?0BvKT3639Lh5sWYa40NV9XnHuqaQ+uZBIkGk05iezwdxa5Vq/ucFHIxlWaHL?=
 =?us-ascii?Q?1zwpeS6ZFtqYBvDSRjGsvuIlnlblUMFceZ1WomyzURHagw5jcqlAdhroehuW?=
 =?us-ascii?Q?4VSIuyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WiJuSbM6fPAzCQzMmgS87sWOdoqw4N4YPTglKU8NAvFfB4xrmHdyKwm81Nlf?=
 =?us-ascii?Q?LHAatYM3FGXTfNZTLrs6F1HP5GTCGYr8Xmb5Kp7+VfX0REUSP+/DHNDlsfu5?=
 =?us-ascii?Q?LqNakz3RHEotbT+ADHa2Ljj0Vr9x+QuivNJPzI7aZNLXcHjRBsX1aYJihbCe?=
 =?us-ascii?Q?/V3Yt9LU9D0Y88Rc/YQ7u6oJbdwoW8cAFmwA/qXD33t0btd3j1uVX+aIslVz?=
 =?us-ascii?Q?VMozZxCYSeJuMzYT3xr42V+Dkx/5l4OJV+Cyd+DMxZh3NeHhv36U9x+XoKmx?=
 =?us-ascii?Q?opBTfxN3bR0hZIXQh//H0umBhYl/Y0So4wIafuKzG9U06Gdg2bM4ZixI0Vqo?=
 =?us-ascii?Q?V/yI/8utNzz9PF+03iP12wCzpbP99wVxtMOda5t6Gg+N0PBo/ZhgB2o6uGST?=
 =?us-ascii?Q?CR1Z6v/Bi40g6NQyzApF4y31tXsCX4vsx64xbK7djX4KNO/o2V+NJ4XDJI2q?=
 =?us-ascii?Q?A5eC08NjUrM69v04QW7XJpgYZncIczC9bsnz485JDbS/mDK1WzXSRVvzxoob?=
 =?us-ascii?Q?BJbEVwO/GLYjMndmP4IhB86qn0q+KMXcY6Oo0shc++bOqXCN0Fue9TNXf9pG?=
 =?us-ascii?Q?UGsuh4+OlbKOhV3lpbFuiLoP+9OL3e6HFVs21SSHeEzuu86B7h4rxdwfx9Qt?=
 =?us-ascii?Q?QNMhLT7iqPdA4DDYmuhz0ZCM0Cvmrd3aoG+dUcso34mzmzhLjH18NukM1Mj5?=
 =?us-ascii?Q?Lic7qSzG5SacJF9UPbgMnQ43VI4mkUGpQ8xN8F2tDPniiKNs2uR+xQAH0Dr/?=
 =?us-ascii?Q?VbNbMf4XcjorTzFuu+/NjSiUXDHX0Vkvcx2G99sONE6dzEqa0reBx6rJnjG7?=
 =?us-ascii?Q?/AVIxhyIU3ccbxdHlnITMRUgZWIR7mfC7iiSiYb1l9IxEf6gs/86koB9Iff3?=
 =?us-ascii?Q?NUwyQ3aTqkvRMPtTXuGiCN2+nrTunuWcTlxqXLMWKKhmEvku2vYvALcGNXUm?=
 =?us-ascii?Q?OukFuRb17WOrWhRQF0cllEZSxi8NGyp3BnUVLJe2mF34IvaHKkRGz1mv/tCk?=
 =?us-ascii?Q?78KsxSqPGBXyW4g53+lOFwnbn9jDcKSgD4VjwrpNlQwnPHcNU8sTZRDP2fOg?=
 =?us-ascii?Q?Cnx/xabVWfmaeA/wNorQez8lKWoke26f5g5LldwsQIzy4spjipb/6+KJ6OtQ?=
 =?us-ascii?Q?58EXxzVY9eadhv/iVEtHlNAjWIzSkul3ERpon9y8DCPK23Egy/+kkijkMSW5?=
 =?us-ascii?Q?YDGRIjOIE0jVujtww4CBp18FurSa4InmDBOOqE0PEwGAQH4IouHoTdHM1rJ0?=
 =?us-ascii?Q?FwrEcNrMvaHtAGBN6UDI4fNmMj5Q4xwvEmxFJwgb0jchEbPgJjMeWoveRcul?=
 =?us-ascii?Q?6MGGdR9fhbhkI4m7sfdLn0pBkYlxTfUvKTsGukuri2EnjszCYm2xHtT+KubX?=
 =?us-ascii?Q?RYP7GjQoPPkT1Fg42ZIGFt+S0XrJAzaQSdtNQtb96bCUIbZ3FzjlAiIk+8Fc?=
 =?us-ascii?Q?Y219npMZK81y9KRpTO0WdiAdGpx8AEdmVVsuMjVh3Ovu+73qDTmGE+4hbMcr?=
 =?us-ascii?Q?M0YKEuKefz7a1ihCghSo5Yf+TF9q368Y7fZbA8a6TlORN0EmztQBmfDC55sY?=
 =?us-ascii?Q?K20l3BZUnBaM9Fd/H7DdmQgQJfJFK3nw9tHyxR1P/F9ahZLeWsTpTiztcmpI?=
 =?us-ascii?Q?ciMQtMrtB52INFtpDYQDB9Q=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4030a8ac-a255-48bf-008c-08ddf0f1d076
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:12:33.2470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQcKChWYSMyH6GW0EgoSZijDwBn9MpRZJC9xfgT+sSqjtU4E5tUWEjvAjAz9DLR9WHtkjJ7qJX8QjVUblKsPv86BkkHu/X+Rupr8bolutxtICF75BzNJUbzT5sK7y0Fi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
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

For successful reset staggering pulse operation, reset pulse
override bit is set. Port overcurrent bit 1, which in reality
reflects PIPE power present signal is set to avoid giving
false information of Vbus status to HPS controller.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 .../include/mach/system_manager_soc64.h       | 12 +++++++++
 arch/arm/mach-socfpga/system_manager_soc64.c  | 26 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 054a28d845d..f768a3a55cb 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -33,6 +33,7 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_ECC_INTMASK_CLR		0x98
 #define SYSMGR_SOC64_ECC_INTMASK_SERR		0x9C
 #define SYSMGR_SOC64_ECC_INTMASK_DERR		0xA0
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0	0x1F0
 #define SYSMGR_SOC64_MPFE_CONFIG		0x228
 #define SYSMGR_SOC64_BOOT_SCRATCH_POR0		0x258
 #define SYSMGR_SOC64_BOOT_SCRATCH_POR1		0x25C
@@ -47,6 +48,17 @@ void populate_sysmgr_pinmux(void);
 #define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK	BIT(0)
 #define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_MASK	BIT(0)
 #define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK	BIT(1)
+
+/*
+ * Bits for SYSMGR_SOC64_USB3_MISC_CTRL_REG0
+ * Bits[14:13] Port Overcurrent
+ * Bit[12] Reset Pulse Override
+ */
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR	GENMASK(14, 13)
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR	BIT(12)
+#define SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR	1
+/* BIT 1 actually reflects PIPE power present signal */
+#define SET_USB3_MISC_CTRL_REG0_PORT_OVR_CURR_BIT_1	2
 #else
 #define SYSMGR_SOC64_NAND_AXUSER		0x5c
 #define SYSMGR_SOC64_DMA_L3MASTER		0x74
diff --git a/arch/arm/mach-socfpga/system_manager_soc64.c b/arch/arm/mach-socfpga/system_manager_soc64.c
index 4b42158be9d..88d538cdcda 100644
--- a/arch/arm/mach-socfpga/system_manager_soc64.c
+++ b/arch/arm/mach-socfpga/system_manager_soc64.c
@@ -1,16 +1,36 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <asm/arch/handoff_soc64.h>
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+/*
+ * Setting RESET_PULSE_OVERRIDE bit for successful reset staggering pulse
+ * generation and setting PORT_OVERCURRENT bit so that until we turn on the
+ * Vbus, it doesn't give false information about Vbus to the HPS controller.
+ */
+static void sysmgr_config_usb3(void)
+{
+	u32 reg_val = 0;
+
+	reg_val = readl(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB3_MISC_CTRL_REG0);
+	reg_val |= FIELD_PREP(SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR,
+				SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR);
+	reg_val |= FIELD_PREP(SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR,
+				SET_USB3_MISC_CTRL_REG0_PORT_OVR_CURR_BIT_1);
+	writel(reg_val, socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB3_MISC_CTRL_REG0);
+}
+#endif
+
 /*
  * Configure all the pin muxes
  */
@@ -18,6 +38,10 @@ void sysmgr_pinmux_init(void)
 {
 	populate_sysmgr_pinmux();
 	populate_sysmgr_fpgaintf_module();
+
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	sysmgr_config_usb3();
+#endif
 }
 
 /*
-- 
2.35.3

