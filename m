Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712C8C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 14:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2F788280;
	Tue, 14 May 2024 16:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="ZWj27dz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7216488223; Tue, 14 May 2024 16:04:35 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE6B882FE
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 16:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWDXk+HJ7WAOdzmK80wfr4CVBt1qMB/S5y93mG/Bw4ZGTtxY69mgwShTX0pM8Gtgk7PxVGqQsF3DeCST0NkiFc+insejNKhG0EtAeo/AADNV6jcw8apWNTxtO++uJdmd+vYPDU7ptNCJINLf3dG6KB/WPqOZdzeyXSsKbsxKRXxf3wplp5XkcuwUJ3UcnOxepckowtSVhM8LhTEkeWLsKHXnnVHPc4CD3BhY0k8obbcGUprLCp7f9I9E3BXUxdvUVqXNNu3Czm6X2oodsoJmYpI6KbI/8cNwJVUBWBcmnEvLDHcNOM8iLV+8UAmtvXMBhXrzhfQRH+G05Pq+jDWspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj/g/Op6BIpMj+309OPONVT4cqJwnA//FbbtNJxP8QY=;
 b=L2Ng3CopUfHCFnWS/tI3lmnFq4o3vVwUBXMTn8lstOjoql/hXLz8V64HUD/hI1jGh+OQnQnbosDaeGAqZ5ixv4bva53ZG6/P3phEjHXV5aMoAe9OtBtt2zr7jC4oVR6FaCOjS01zspzfIbr6Ykw6WctwlknFo1B+meORRiAd+oOBC8hd7svUh7USQv0lhijdArrJFsFE0FU54JbLrBTZGLFzwcm7ptbEXWgXYq7t8JdBiT1rRBC1cfK/aCTvz0q/nDcSu82Mp+nAd1r78ducF3vN3N8tB2Owx9ppBAnYijx7O71xfC7AthC5BN6sOxJU9op6tt4FI+SpFcPUW6LaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj/g/Op6BIpMj+309OPONVT4cqJwnA//FbbtNJxP8QY=;
 b=ZWj27dz0Khl2RxTUS9+xE8GTnTGI3jNWh2DMGiBGb5aLGN1DcObO2CvuOTwbQfXH1dbSGt0qzWTWysHUEoS4SB46o4HmsV/1BM3B+2JLA30t2U/J9MA0gU2egS3PMJ6fKzKMldoFY07PCOGbljHHRedZKuZlEpAIgEIheXgx4r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by VI1PR08MB10052.eurprd08.prod.outlook.com (2603:10a6:800:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 14:04:29 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 14:04:29 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Tanmay Shah <tanmay.shah@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/3] firmware: zynqmp: Add support to access efuses
Date: Tue, 14 May 2024 16:04:14 +0200
Message-Id: <20240514140416.156747-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
References: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|VI1PR08MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: ad49c2b6-731f-4645-8070-08dc741ec584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|7416005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VyhHbWf4AUsapV4rCIRzKiGHrSFyDJ8kThnB5UZIaixvg9y5UpNRW1jPv0jE?=
 =?us-ascii?Q?Vxh5zA+BChMA0xzDCSlFvpGdTknr7UL2Y2zNCShhs4JoYExMkaB52jTYYeXq?=
 =?us-ascii?Q?eyO+wiqetVodrvTxyl/ZE2C7WkLya5sBRLiQVse70arUWZjOhEzLxrlYyAnO?=
 =?us-ascii?Q?L251q1eD01lwhnTudJlcVMc60a9qEhx6VB02GBuFmxMxJM4ZccyVcM+/ERnd?=
 =?us-ascii?Q?AMUKuMGmLg/qeUPCbm3VRpNOGGmG/UHgBJ5HUZEOogZv/+zT1zneeGoSAnrt?=
 =?us-ascii?Q?NUccYq1TGKywoTYxqBK0poVELAPfsGeWOHv43eSpvazBH/AhOPp6ZCVnaAaf?=
 =?us-ascii?Q?CJeQ02d0Pr87aqjxPHa1nOauU/GetL+JJX4WR8KFKDPGxCPDR0ic4Ke2OXnD?=
 =?us-ascii?Q?0OeVw/VyzW7O4uHtJDGfhzOKXrqef3o28kN9m1YOJ7d+0DvPNnOSl7AsuSiQ?=
 =?us-ascii?Q?QZ70YNnFXUwiOMOQEgucp0plj9+Tor+PmD5j7JtiwnraLEoo9W4zelQPz3ga?=
 =?us-ascii?Q?oeON6BO1Qam7AJjklWz6jnKtklSdpI3q3Uj1Qcyt/jsePZfnBWGIDJAGGwFn?=
 =?us-ascii?Q?mfHlELzZu57QFGACBKZgjq5NMDG48B7WzY7wA5Sf8TwoOEWhrvSlXSweil6w?=
 =?us-ascii?Q?h6GwPvlMA7lnXHrtwHBUzRIoHrL4k9l564tdq11eSgrCj8PqRmgcMiszUlug?=
 =?us-ascii?Q?/xz7GwqIEp6J4ymjNIJyYTS4h7+bTkZOF4lm6gtW5yJEPEliDvcakY7he5Aw?=
 =?us-ascii?Q?dU6kDt4BnF1UptMzuWIG3y/Nvs/PfZsdV0Gwil8zKEC0nC2HQ8ALTJ+/vBmn?=
 =?us-ascii?Q?ejk8e284pk3fb6WlD3Hd2HH5nQ+NB2q43AHUsvJWQ0ofLKWhK8KIer5UZl1V?=
 =?us-ascii?Q?Rk3Z276CxAaUzcYbsypdwsWjYV9omgAMm839GBHEwz2wV0izUd+hGmS/P59r?=
 =?us-ascii?Q?4E84b7eA+Xlz3h5GfjyFC04WpnVlEDXgYKfs1viwMyibRH//QmwvLIvSP83X?=
 =?us-ascii?Q?bMfCkyVMmwxbdf75tTAlZEScamWOkJH2YE3rO4JakvK4OxGmPM5nicJxhMkq?=
 =?us-ascii?Q?SUkQ1pGu9L+XBZwXaQ6xMHmcD9TXYfwj+20iKTscihdJoWERrb9WezQTqYhs?=
 =?us-ascii?Q?S4H+IchtzAUBK/i/p8d837UVvUe5iR8q/alLvwb948WOeMeE2l+kckTfnTHA?=
 =?us-ascii?Q?SagP8C6s6et+cURs5Yw+Ug2yN2oCjcDiEyZS+yov2PWGmq3fLBU3Twb/IFL4?=
 =?us-ascii?Q?MwyHUF8zhTemPUj0loC5rWCYJzhMDqyS21p/MNeW1+yu4af3rFyHW7EAGz/G?=
 =?us-ascii?Q?U2b7BVLhEnwgqE43zd8kMZipUbp61mfLTae2NimOmZRCMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QslIa7GYECTo0NBvHpwZXk16VA9SDtHVY23LChxTyjHGkwmRAIsguL5bQHcS?=
 =?us-ascii?Q?VQ9mODJrh30qko2Y2yDz4jwpYHTonTgpdmdA+9Hy5mcjJIHWSXTDFOl/IJmw?=
 =?us-ascii?Q?CgAsxHeaYFC9ry1jWGBSl6VtvXsjsikt+5734oqSyelclCR8O4IBXHadYwbu?=
 =?us-ascii?Q?rMDDJ/kFWd+FdFZW8j5krkgkP+oP6YC7q3Hjbg/ZzrXT/WbS+cybG1U3MOjU?=
 =?us-ascii?Q?u1P1Y3VxtLa8cWXfacicOMhYDtBOQgotq0B7+igj3IGmd3UWmAnuVlYW4tpg?=
 =?us-ascii?Q?7u+A543I8d1iUVTIkcI3o8pqVEgWxnkFHyQM1pHjhSiJnadAM7Bxuq0fwHmR?=
 =?us-ascii?Q?3TjXzyU8AOAlpIH2yoUwR4BKUYWxivwdBYv7yCq9ksvp7+kygnQWGSbWvv5K?=
 =?us-ascii?Q?QBOWTrGOD7fDAXAp16j2n+btqkG8fNfUPcp8YYv7bKNE0DMpNPqSteDifsom?=
 =?us-ascii?Q?xLWny4N7C1dkOoIMqG9yvkHCRgYF11UfSfzeHv2ubLVr+GUTEMuuNfKG6Jz5?=
 =?us-ascii?Q?Qf5kbY4A4fvl15q66+KRzMOMuYHHk6lIwvCNPfsAc051FEpCACE//harC++4?=
 =?us-ascii?Q?jZo35vaD6Yl4g142BUsC5fO+G+kAyMJTB++d9fqUEGmOUpi6AmFidlvbRyNI?=
 =?us-ascii?Q?A28oxE6xibLfe6EwEKFJxHIwLmjIk5pwowUauu4nK88UU/HXi6U96dMDm46a?=
 =?us-ascii?Q?jLrFqGBI5GI6/ffDP7CP+2xMn9nmBoxsJw5wu//CS8tg8Qpa9hWR+ic6aZDX?=
 =?us-ascii?Q?6sUEtrYmoPzZuYK8hw4+JJ7YN5fZA/Sbk0UWcMXguOhwomsQLZBs7iG07Cqd?=
 =?us-ascii?Q?kVI926K4n+Lrb7wbDGSfK4ccFlqMsb+LGtwW1W9FhidiAuoY7Jsr2wvJygk2?=
 =?us-ascii?Q?4R+n96qOmHylu/VFVG8ItsYDR2DuS/FIpo2XoSTXuzw98jLLEbVfr9mzvUkT?=
 =?us-ascii?Q?6dEsld6gPxacMnTd6KCMYOltQk5inOwATeZ/iyD5C+kWbHSmSTb+BHFp55Uw?=
 =?us-ascii?Q?j9P+EV8wH83DWa540tSVdrRhLbHkZjycqA8TlwGCOUTIxG/kITWGv5donFVT?=
 =?us-ascii?Q?vtACizrPAlv4UKoDKgJ8grzdexTnki/B/NEi0DzDD8fCuBRr1qaeFdfQx3ve?=
 =?us-ascii?Q?xaH4ABYoZ1/YV4yNF3NAdVmh4tAWRA0Nv9sxoTYCqQD05GhfIpemVkoXbGVD?=
 =?us-ascii?Q?gY6Qc9r7kOfofsL/SQnEDYizBotP3FV4ZPwdQ7WMiBx2uMgphGRyvAXsejhR?=
 =?us-ascii?Q?Zf0B3yFsrzDslwEBtfXN8liTC0sF0wlO+lPPzH9MwGPiXHhKTnhZqYzQbeqr?=
 =?us-ascii?Q?Xj2DESu5i0KN5fM06HyQqqiuLooOhnYYhszQ5KdxWNLUtLFbPnah65HXWdo+?=
 =?us-ascii?Q?lS5P/zMk2s7G8xp8FNYGpuSh9CFioO5rUTBbSW3KPpz9O9reIsfn6YVeWKbZ?=
 =?us-ascii?Q?1wIrwqLCClOLePTMEk1CZI7KAOcsAJ7c5IxSwuAQNJ/RaWgVr7VAw06wJOJ2?=
 =?us-ascii?Q?gL4SJGnRV0W0q2WUeI/dLyNhw5mqeri5Mee92ZTtVvKLxWgP99f4P8o29w6w?=
 =?us-ascii?Q?DxSUgAFUSeBPK22ADniZALJtKN6SuHG960tjp3JW?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad49c2b6-731f-4645-8070-08dc741ec584
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 14:04:29.2468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHeg9iDhXxfrDw0TrI8JGnHn1ma6OPVdnDk7UsoKJ+mL2YQUtx5jsrYWR+JosfE4O95joZbZ7n4Xt0q1hi7B8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10052
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

Add functions to access efuses through PMU firmware
interface.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 drivers/firmware/firmware-zynqmp.c | 31 ++++++++++++++++++++++++++++++
 include/zynqmp_firmware.h          |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index f99507d86c6..7483f2a8709 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -210,6 +210,37 @@ int zynqmp_pm_feature(const u32 api_id)
 	return ret_payload[1] & FIRMWARE_VERSION_MASK;
 }
 
+int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return ret;
+}
+
+int zynqmp_pm_efuse_access(const u64 address, u32 *out)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (!out)
+		return -EINVAL;
+
+	ret = xilinx_pm_request(PM_EFUSE_ACCESS, upper_32_bits(address),
+				lower_32_bits(address), 0, 0, ret_payload);
+
+	*out = ret_payload[1];
+
+	return ret;
+}
+
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 {
 	int ret;
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 73198a6a6ea..7f18b4d59bf 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -453,6 +453,8 @@ int xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value);
+int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
+int zynqmp_pm_efuse_access(const u64 address, u32 *out);
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_mmio_read(const u32 address, u32 *value);
 int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
-- 
2.30.2

