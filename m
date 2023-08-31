Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E943BC83F12
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 13:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043968658E;
	Thu, 31 Aug 2023 15:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zLwtDYbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE2A86590; Thu, 31 Aug 2023 15:23:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB5A88657C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 15:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nia5sBBN4Eh9egdj07wDA/IJ40hZRsHAGZePtGUj0RRc3eLVuqFdwc4AD4Gm6esBmF6zTS3dxmPa87Wd9FkSNl/Z1U8xoCEJ9BZg42Mg7S8Xk1Yyx5wglK8hdBd/e69K3Bq+amtJ0dNJjz7XcQf2iB/Aq09+hdXLwa4dAtAnVNmiVLDoAB4BZhw2BO6o40R0w7tnh1TAxem/kSYd5ve96O3I+wCsqghzYh6PsDMjeSm93JAh5q1wbnBZl0pujd2BbnNppmsf+Z/Pyo/pRWhL3JWUlZTq+UdRXfdYeHlpzUW+extlVQ7VGs/IHiSJO7+IGG/z33lr2t3LfmYdFVvrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX7J0IVQNQTZbixIuC9WjN2drqkmWOoxng1U4WQTTsc=;
 b=aqUZKgtHNJRjo9ENhdjS+Q0b9qPuOXiwTtvlS+y9G3gCcM/OBFRakJi4f/AjcLQRQID3YbhdhLthVlMB5XLdnLvUvh3jWmc7RfDKhZWfXurY6b0SRP69ns7UwFt+DTZO1nGp9GXjQl6/eQbIc4VceypLpCxpjb3GVDBMnW+76aaSAWxPiIxngzkaJvPdGLgW0wYNWqWB1USFbZzF0E1KziBH8Wq5L0uyUSBZ48rzq4e7jJVppZ38VSJHpkO/fTdY8If9g5zr/M9ZTNbhYoU0k747dR/ngAv8k6eeTtP7lljC/15ssw7NWkDDh80WVz9JHCOQFqemR2B6X66c1QfCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX7J0IVQNQTZbixIuC9WjN2drqkmWOoxng1U4WQTTsc=;
 b=zLwtDYbbMNSsA2R+K95Q4cNd3S0k3FveW4PID7e3/vZf75PC9O85cOfKGRVPozHzBIj3euNAeWIA5tdY7OrV38KMbe0qjtHyBATZf5802ktwRrS6IRB8vcXZp+Pn8jd/2CItpGIS6rw8F4Gu3NhXFeby+OWB7bEzZrsPRdwhWLA=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 13:23:12 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::78) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 13:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 13:23:11 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 08:23:10 -0500
Message-ID: <62d1dadf-6b3c-ed8a-4b50-b90f0d34a17f@amd.com>
Date: Thu, 31 Aug 2023 15:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Neal Frager <neal.frager@amd.com>, <u-boot@lists.denx.de>
References: <20230830065737.4083577-1-neal.frager@amd.com>
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v1 1/1] arch/arm/dts/zynqmp-sck-kr-g-revB.dts: add
 output-enable pins
In-Reply-To: <20230830065737.4083577-1-neal.frager@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c9b347-0340-45df-7408-08dbaa256c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1pXhwruI4WICB/vUt8vN2vedybU7u1cBuCi63VlMzbnoh+MPuo9znVxRnLFcSBzMob3lo3aKEcm0Fx1MV3/BkzKQh3LwiU5jhhb9B1BPWraSGH8Tl0Dn6OPG3JI4RzQAyN6jzDDhNpOE9jfB/eNEzbGLcrqlrBSp42JKSbFj1GHzVFnUNpJqu0vOSRsakY4SiSpPtotBpO0TTPXhkNB6eDI9EJBuFwxXfyTFsZzPaja5gsIpU5xjDXBswzK1UnG2qsGhASMkfVbGk9Czg87evJ8lcacfBWBT05gj18EwIMd7ku5r1FA4yfA6MV0lX2A1RR7MNwsj0IimYeyj6P5O3AOu/tGuJM842YXI0dC9IIQggxA0tS3eOVukpe8zZnwQeDRjswgROOhTqE8CKERcpvvxUPaD2cogcAAMJBnvNeFZg3grqxqn2J0XWQAjEBbN5sVB1reIlDpxrfFOULackGn25n53kJb1h4NiatVcszRQk/mFrsi7iF/TdHK2JmUkdxStzhQuoiUPF9dCaVnjNWOo8BFJQztBbDuUvphGNeHs35JXpBnYMqw8KEDH61ULRs4FMHnWPGW+Bke75Fpcv4txPbZ+sMXE6MYlhHzTKRObCuvk1yx+YlCoQ3HWoK8OxdDn7rE1LHA8gGshN8qvYfcvmkIY0zbiJHll1O4eh5L2c2qRIuzbGsECQbcCEvE73aQJHSN0di8coJ2zWRUaUYkvqre19QGPBUASlfRUaNYtUrR0M7y8RVmS00tnXeUrQY6Ph7DizVB5hqSoZCbGS4GMVJRhCMiAnIoEdh38UyRCT1gGd/LnMO+LfO0rcmG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(53546011)(478600001)(83380400001)(2616005)(336012)(426003)(26005)(16526019)(2906002)(16576012)(44832011)(41300700001)(70206006)(70586007)(5660300002)(8676002)(316002)(8936002)(110136005)(40460700003)(36756003)(47076005)(36860700001)(86362001)(40480700001)(31696002)(81166007)(356005)(31686004)(82740400003)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 13:23:11.3478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c9b347-0340-45df-7408-08dbaa256c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
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

Hi Neal,

regarding subject.

arm64: zynqmp: Add output-enable pins for kr260-revB

should be better option.

On 8/30/23 08:57, Neal Frager wrote:
> Now that the zynqmp pinctrl driver supports the tri-state registers, this patch

remove "this patch"

> makes sure that the pins requiring output-enable are configured appropriately
> for the KR260 Starter Kit.
> 
> Without this patch, the USB to SD card bridge on the KR260 starter kit is not
> enabled correctly when booting via SPL.  This causes u-boot to fail to detect
> the SD card interface.

SPL connection is misleading because pins are configured as the part of pinctrl 
interface which SPL is not using or calling.
SPL in this config is just using QSPI which is already configured properly.
On KR260 SD card is connected via USB to SD convertor that's why pinctrl set usb 
pins up. By correctly setting up usb pins you get also SD working.

The patch itself is working fine.
Actually the same issues are there for kv260 boards and also kr260-revA. I think 
we should fix all of them at once.
I did it for kv260 revB.
Do you want to do it? Or is it fine if we look and test others and provide v2 
version of your patch?

Thanks,
Michal

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts 
b/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
index f935f25c887f..1b1d9e772f55 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
@@ -193,6 +193,7 @@
                 conf-tx {
                         pins = "MIO36";
                         bias-disable;
+                       output-enable;
                 };

                 mux {
@@ -244,6 +245,7 @@
                 conf-bootstrap {
                         pins = "MIO71", "MIO73", "MIO75";
                         bias-disable;
+                       output-enable;
                         low-power-disable;
                 };

@@ -251,6 +253,7 @@
                         pins = "MIO64", "MIO65", "MIO66",
                                 "MIO67", "MIO68", "MIO69";
                         bias-disable;
+                       output-enable;
                         low-power-enable;
                 };

@@ -259,6 +262,7 @@
                         slew-rate = <SLEW_RATE_SLOW>;
                         power-source = <IO_STANDARD_LVCMOS18>;
                         bias-disable;
+                       output-enable;
                 };

                 mux-mdio {
@@ -289,6 +293,7 @@
                         pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
                         "MIO60", "MIO61", "MIO62", "MIO63";
                         bias-disable;
+                       output-enable;
                         drive-strength = <4>;
                         slew-rate = <SLEW_RATE_SLOW>;



> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts b/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
> index 1ebbe683f3..104e67ddf8 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
> @@ -248,6 +248,7 @@
>   		conf-tx {
>   			pins = "MIO36";
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux {
> @@ -299,6 +300,7 @@
>   		conf-bootstrap {
>   			pins = "MIO45", "MIO47", "MIO49";
>   			bias-disable;
> +			output-enable;
>   			low-power-disable;
>   		};
>   
> @@ -306,6 +308,7 @@
>   			pins = "MIO38", "MIO39", "MIO40",
>   				"MIO41", "MIO42", "MIO43";
>   			bias-disable;
> +			output-enable;
>   			low-power-enable;
>   		};
>   
> @@ -314,6 +317,7 @@
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux-mdio {
> @@ -344,6 +348,7 @@
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			"MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			output-enable;
>   			drive-strength = <4>;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   		};
> @@ -371,6 +376,7 @@
>   			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
>   			"MIO72", "MIO73", "MIO74", "MIO75";
>   			bias-disable;
> +			output-enable;
>   			drive-strength = <4>;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   		};
