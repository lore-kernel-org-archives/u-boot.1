Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADC2C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 08:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7CD87FC5;
	Tue, 27 Feb 2024 09:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="zIdZfE3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8892487FC9; Tue, 27 Feb 2024 09:40:19 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB4387FAA
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 09:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjuESnHdW0yz4ZVJ2gGc1RegcrJG4HuH4YgULQHiZ4u9uGpTZOo3uwby4JWXtF0QsFsTni/QEM+8L07G91CqF01rgRhY1/oh2mPADWlqG3YnuE70D9t2YEUPSXOvzvW1WF6BNsFc+iI/8qdQd5MGdcjHpE9vKyvnQy5Cg5LHnBDRMFt9+9EVnr8IlcmblTf75eE20tUR4BXszwIgtRp8/+WmYgEiKNgBJZY3zVnO3jut91AmZc1k+mzT5MAO5vdlxqCy0YlYA48Qlsc44NVwWgzBTz6d//KQjg+anE9XuljFDyRvafv+Ai2l1BawGhcouvZ3G6vFx+IVuxTwGAGrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgEXl/guP4DYrgWicOh2486I8IqIlgYwoBS2Q2YXHYE=;
 b=B4um7LYXKyqxQuyhc8kCDh2CNAqIDj6vtSYSe4Bmuh2OOVVkkhNMCz84k6SagS7TJh1CufccisJUgSHuVdP2zJ4/q/ck9KjehFBXpdmSH5AaLooewCtuDQY4TX1BuOELYisM4La1JvuuOOZMrkhV6KdtDPnOMsPqu/NlllSLuuEIKd9S++aOhGAh6J0H4ASIgNBm+K6pl75fG7SCJR/vGB1TdXGFwhtZbLpeoNWs2HoaNnEBfTHqsyuKy4vd2sEeRXqsxVsXRTkvIN6Mq5aKjc6xcUeEfajiV6CK42zA97ll3v1/OtKit8h310G6m31GuGKTpDFN8pompNqdmksamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgEXl/guP4DYrgWicOh2486I8IqIlgYwoBS2Q2YXHYE=;
 b=zIdZfE3iVM5/nC3wRf2c2nUllorpKZCsdhkgyMF4ImUS4y9vL+T+nXSSh5+Js8PFKAnAoK/b5kqwS6KsiV+gIPudKqzjdQLsxdUDQh44hoZqG+BIXMh34GqeFROQY1OnwHUqPRt2LURiaKMRJ8AhoYgcdgEEeoF268pmLzd0tao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PA4PR08MB5984.eurprd08.prod.outlook.com (2603:10a6:102:ea::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 27 Feb
 2024 08:40:16 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 08:40:16 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH] arm64: zynqmp: Add label to pmu fwnode
Date: Tue, 27 Feb 2024 09:40:08 +0100
Message-Id: <20240227084008.2086287-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PA4PR08MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 8955e39a-6cee-490c-ca35-08dc376fb8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cc6tg0RGgx6ULbELw5LW127a13cGqjvnF17u+KsbGY+m2/KQMVx0+D6foT4QMeV6hVy0MRUn6SmMoT8tFffaAJweIozlshJc6+pOdgsgEsQvbbrS2HhpekcfOgjHqNYoIpLrVUTXy7Km0mPh+1fAgEwo7N8Gsro3pQTZOCxw7M0QuNgJECdCVQ/pVRFSVy6c6UZCKLUEymqsIwURPTJsL2oaNgxi03xbPhXBOldNXGgJh/GDc9kucf7I7SqMGMeH6+cf55Vqb464dj6SINPXJBfmOVGA0jHUTZq7fKcnUV5Dv92NBG16HFnZSsmIbKyaZvyEYBq7t0oOTkgnSy2mFFCXg1rDts7C6Xk5+QEUv+unqSEr/p3s0Gwti7cde0LsP1APpOSY2iR7MAgtxsjzARdEqGOTFXtRBc9DO8N+BEdcF8xf+0vTmgPBGkX45sOAHO6f70AatV3nDp8QXI3pfZqSjxs/ZB+/nU71eb8Bb18YP2uaF4C7zUmrRsg2y7+mEvKFUm24k7oFR5p1Rj2LLDNJsJEW/uwb3LvuPaSP9bw6btIHanXMgvGoz9hx6PB/jV1C947FglcXNJnyt7XpQJ+NKYQ/O8yIqIMBcVMbsEjck8CO8EchrD70k16+b/neQ3ayADs8MJb+750W6qXvv2uJK9e/jg/DtLrqbiXZnR8Hql6K5LEnIaQ5x8y+EGKArho/5hTZi1ZiRa/kzWcSZvbdKmxo5xFPfV4JwXMdtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Snj9LakUFxT2u2cKHB76neoANTywb81ymFmex/fQo8W214ToOdgeafuvAf9k?=
 =?us-ascii?Q?xKKk0X1fTP4+5As9YAaWeliyE9hrRm29+ICUmw/JcLaQERrqxcz0plKBNUGd?=
 =?us-ascii?Q?rVF8CrLA3/L0dl+mZJE/FuM5TMXHQL5CyyPGRogPiI+1Oh/fgclVTdBPwnLG?=
 =?us-ascii?Q?islhs08q6snzNkvSWEJKrJV/8gj/oaUqOp46wvCNnZgk/NG/pksGM3Q8JrKt?=
 =?us-ascii?Q?xpc2aYwOhn+f8v6ji4na3NwcorizWx8sR/pB8ejKgRevWo94ePamn9Q22me/?=
 =?us-ascii?Q?9Un3B6rf52jHNv91rN2lbzRbUwYao+jk4yuorx+dbe9SvXWEkK8ECDFsDFO+?=
 =?us-ascii?Q?REslcCVmcdJplx77zVnnDBGjKCx+oisjp+IpibqIAOv8FQiQUp9Z/PdwrNfQ?=
 =?us-ascii?Q?kWrEQhJ6NVMBETchZRAsA9P1l7xKrRRnwlpvD9rqxIybBODjd3MKY2wWvmuZ?=
 =?us-ascii?Q?38nDPKjZ02bINarN4TcM2LXa0EmjmGrYePeYLktdqP1L8Wfsxkr3q6F/YpUN?=
 =?us-ascii?Q?mOhORdus/t8oq8+nY58ZXKr2A/SFy0EhwdoqdxqUfFdUPwHLM2iyMaqT9KZk?=
 =?us-ascii?Q?ddcapCRjNbcSQztp/5tJzlB7ZyRfuyVv+K6Oj7CL1jaYaAeB45zt0Y0+qaaU?=
 =?us-ascii?Q?lM9qhZUeIiDzY+FtOn2hDYMg9lBwch6zeGgQicWfxz2Ocsr/rbuV6bS0U1Vj?=
 =?us-ascii?Q?awQOYD4sx4kXsr3TalSUMQ2MUVAh0SQSj+y2boQJIAZaOyRCk6+ljSmGk30b?=
 =?us-ascii?Q?K6DGL8c3JfHgUEuH3LkTp6RA3SFHLTOiXMl7uyosiVUIvDEvWcU2n1sGLgii?=
 =?us-ascii?Q?Nzrsntvn9k4j3YtL7NJXRSw6YdkHvEWmNByxULoPp0iefmB6+yhkY5Wx5iZG?=
 =?us-ascii?Q?pR9yS+Y2gSCgII48SuqVlsfFO33rSHpkhPxHgM1Vi84Yd6I0gXRCrQjQF0Ax?=
 =?us-ascii?Q?LDl0X3F9WIgaS7C8YLAGArfNQduNkLEztD5kdwfFl199HatvtpK6r0H5tckz?=
 =?us-ascii?Q?Rhbo69ATLJCp3d8RT5/ubNQembfNg6fxo0YF0ZzIoJRrDOQmYj+DoMCHs3k1?=
 =?us-ascii?Q?XHI2fFTKIfpG6Hs4GpZ06eJH9C7plGNdQ/7VwL031fK/B/mnp/DznbCJ9hjr?=
 =?us-ascii?Q?O6ChZXPH9KoSIM0nQdEV5BIMN2hfbeL16K9Lrg+zwrZ6jX/PzTxL1SqUxLBN?=
 =?us-ascii?Q?9rMOr4VFKFjpCPZGrVR+aYqMukngqwdWlkp8ppGGrEQ0iMoSFJi194EfVqx7?=
 =?us-ascii?Q?K67D1PPSL63vc4X6geqTZCetSQS+xsGh9VGBPtAU5cdsqH0w9kzBlq1Laows?=
 =?us-ascii?Q?Ptq+R6cMqcaeblQbI/0Kh3oOT4w0hhknsDQmTjaE8+pT40V534t0k70AqQ78?=
 =?us-ascii?Q?EcM/7o5IFD7793VQ0LfR2tCVFXZbbD753FArl1AoQIsHfvwj+bI13sAB9tNa?=
 =?us-ascii?Q?bPo+OlMUmTTUWwve5M/BIEvN+GHWvlVVlSbifkJJP8W1VycDpxt8EKHkkmjK?=
 =?us-ascii?Q?2k0HTP3JizIc00LWMKtAvJqVYNOjnCQutgACQVSEYQtvuM2hn9rBgMKffqrM?=
 =?us-ascii?Q?gu6EydJ9V55MyzBoF4Tqcz6JKt0C+6ByOBUpvvFfK5pGGtRiOtJkyRyKJm53?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8955e39a-6cee-490c-ca35-08dc376fb8d5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 08:40:16.2757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOtj6kRIT0dEyY4m+kR3oWfiQxgby+mzwiGYxE2b6PuhO3joSzPv75MwycG6PYr4RkVFbSqJ5ZtC2fye+xDM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5984
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

Some zynqmp SoCs (the cg series) only have two cpus. Thus, for some
cases the cpu-affinity has to adapted, because cpu3 and cpu4 are
missing. By adding a label to the pmu fwnode the cpu affinity can
be adapted in a device specific dt.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---
 arch/arm/dts/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index b50b83b772..457f8e394f 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -168,7 +168,7 @@
 		bootph-all;
 	};
 
-	pmu {
+	pmu: pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.39.2

