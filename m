Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF680EDEBEF
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 20:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4600483F2D;
	Tue,  3 Mar 2026 21:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qeU6J6Zu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883E583F7D; Tue,  3 Mar 2026 21:04:02 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F4883E7F;
 Tue,  3 Mar 2026 21:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+QcyqNCmetU6di7X7IA2UCGlRJ2iB4ONseCwNgGb5CY5CLPcCssUKnP/qiaqZ0SSwSNevAuYQLaB/6BEHsoWXGDVl2eet5vHN/ktzQLCEFnrG6RmcxP1oJFqLrzeYyyOjDZ2fH9KQUMgKqFbBcSEGPFzpEuNk6sdIXWCfJ+4CavzBtQENNs1Laa8qunQ0aTnHCHx+tIM1enszHDK5xhsHE72Eo5A4UT3G7fV1UawRJ3YfxCesRZi2DkNnWpV9sGDn/h2HgKdrT/Vz+SFIFk/m4jKXdpy3WhZcVNDW/hy9Xaj/ON4/q/AxuxpM3eGBtJ7wC+LKUrzDqLTdHDT5ICTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePCxBg9W3YSx1yKTwjXMoLMFW+0ZMaij8E/y5j3xiVE=;
 b=ljWCQEe58aeBZDmi64qG2Q8Pf+rN3NGt09VezZDFrUwwI80nYoq2GyH+hXUZksLWv9OE9oZxLjHHukOctkE4yUKijROOXNn82XUVTF31ayftLRT3u+1LIxy0QT/PWys7Xm+mfaz75VV4W7I/LbZ0MplCBSs19Rm57oeHjb/194wz1Wosq8gO/qeLYzEGSf58NyevcFCq/kJ0yukTuSuiqvao6OtFZcmegEQcFvOrO5cLa+7mmfxtvIJW4XHDT3FM3LF9eQ/Wvb8SyQH3TKxZVcAcIO3WdosXMUig30Yoe6PKPwHqB9/fAhQXLMKTw7qekWY6oIcwzt2jiZ01PYxZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=cherry.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePCxBg9W3YSx1yKTwjXMoLMFW+0ZMaij8E/y5j3xiVE=;
 b=qeU6J6Zuv14tq8R41WVBSVRAu2yP/ZOvfPhpF8/I4QAJvRxTvtwb6HsRsxutzs1qxEjuiVGKj0gKdwTH56W1K643HlMQTFcjN9zR3oGRTUjpEnegNZ//FWeiz0VnnUHy1mIHj0HRqfXRhRyfc0kojGJzT1Ic6gXF4qxVUcmu6bY=
Received: from BL0PR02CA0101.namprd02.prod.outlook.com (2603:10b6:208:51::42)
 by BY5PR10MB4193.namprd10.prod.outlook.com (2603:10b6:a03:202::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:03:57 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:51:cafe::ca) by BL0PR02CA0101.outlook.office365.com
 (2603:10b6:208:51::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 20:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Tue, 3 Mar 2026 20:03:56 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 14:03:38 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 14:03:38 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 14:03:38 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 623K3bDf2723943;
 Tue, 3 Mar 2026 14:03:37 -0600
Message-ID: <233a88cd-c83f-4e72-ac54-fa773b60ff20@ti.com>
Date: Tue, 3 Mar 2026 14:03:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Binman and blobs
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: U-Boot Custodians <u-boot-custodians@lists.denx.de>, Quentin Schulz
 <quentin.schulz@cherry.de>, Neha Malcom Francis <n-francis@ti.com>
References: <CAFLszTgrGjthPK8uxD0fErNfgaGYawiv6ojF42sakLj7oVejQg@mail.gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAFLszTgrGjthPK8uxD0fErNfgaGYawiv6ojF42sakLj7oVejQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|BY5PR10MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5653ad9d-5414-479d-e412-08de7960005d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: DQdktN6bwPm9lqTjXTt2E5GqrMl6uftn/cvRAGpOUWo7UHtIq/P2LM0Gg77bMFvIly2fiHML0rq++rKbBj9AMWBA3E2nvw/g7nt/Xn00RE+ZgSwcJk88Wfe8FMd6ZpOMBbJ4K9+nuWWfX0+6lS3ZdC1sn8Lj5VlvAbKoMNOe3ddsqozk5fpd4rDdfCiayxAh8gSHjeNDjmU8fr88xm7TrkIDaylzPDey3Kzer11cKQtHcKy+P5a2e2jr6f6Pkv6ApUtPUXHriJyuyPs/Dm7TpTAsZDqqlzP7hM37aqtyX63kc4SxBxdJYkZsqv2HGy/D0itnR0e+xdFsvfDGnktZT9yQylFuBnQ7hMnZA744OYsqt9u/Gu3ncEsRNFzFIiZVfXGvZjcXJlzJweEdS2QMorf5cSlHVzfbjmJtcu6dqaKqXu7uTrtQyXtAwDX90TvUescA3GJFCsLfMzpuIeIt4T5CRhTwKart/8oewXeGLuZQC3bmjdC+eZCcKLZogg3K7JCL56n60nylwEi6BPF2m82OGdWNbcMownt6guY5fzGF38/MMFyIFROrKlSBNo9scfluxAH2adkWf1lKWqYahErJyhFye0UzM/AxXLkIini6j1e59zpBNJTGLk3WxAg5L0ZOpih/tVdZEluMOHFF6OmilVPsKyO+lmEK4IRmMin2i+BXsxTKNhEt+RSu+GpzoNME1UIodu9K2fNRJVlyrszD0eZlnBdbxrfHMkCe3F2o4PA657T3HUIhsK4yEl4q8HQAegCmq97y9I/qA/lrHQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P8F8mtcE8lkDxV8UNj22vqPdfvgm4AEkhvRBrN1riGR8eEIKJbr6vgWMm0BA/1XFf8IzmRmKXqsKJfq1d+uVWRGF5sYiTdb6KpEKCUbwNCz9p9Bv3PVsdHtbm6p9oa6lj+6hHxr0w9qhHNj+nNKDl4mCypA11g8639OZJIIIFd2tUFczq6DUlOvVjq6zRZeHtVtwAgmXhIUjZeiQq+CjRLSSyKgezmpb8eyQsSbdUWcdEAZCByZOg4MLuCWgDY6GvJMakUY/w6L0vqbjJnVH/u5yO5OL9bAOatfBTeUAjn0otdnDEi6+4UcxM5fxBK0/gGwbHEracHdJpewVLA8CTCq1Ch+cQeqA4uBlvaMbvezxqiVMaGYjmBXGrfX+drA8MsXqpdxW3my4n9jWAP0FLSMAgfBJlzvrmeqs6bDffMwvTBpqbxJHaTqoer3m4GYr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:03:56.1976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5653ad9d-5414-479d-e412-08de7960005d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4193
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

On 3/3/26 9:14 AM, Simon Glass wrote:
> Hi,
> 
> At present binman handles finding/building tools needed to build images.
> 
> There is no equivalent mechanism for the firmware blobs themselves.
> Users must manually obtain these and point binman at them.
> 
> This is quite painful at present. Each board requires some splunking,
> reading vendor documentation, etc.
> 

If the pain is in finding/collecting these blobs, then would this be
solved better by having a single location for vendors to host their
blobs?

If we had one repo that we could point BINMAN_DIR to, and the existing
"filename" properties would resolve and produce a working bootloader,
would that fix much of the issue?

https://www.youtube.com/watch?v=iz7l9On8qik

Andrew

> I believe we could create a similar setup for blobs, where they are
> described in the image description (compatible string) and there is a
> way to build them, download them, etc.
> 
> What do people think?
> 
> Regards,
> Simon

