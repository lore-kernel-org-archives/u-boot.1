Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0338CAC581
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 02:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC78E80422;
	Tue,  9 Sep 2025 04:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LET98Acw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1CE68313B; Tue,  9 Sep 2025 04:13:06 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F859800B6
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 04:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxPa4LFke7U25t1LeXeKfTGIykt/cE/OyylriysedLYMmobZVsOyc5a0gm56kbLcxvWVuFjLkssDz1jxDe3XKzpqWPvaVLQXPQoksOzcWEHusYFPibFyvItpjOR4zcKp6cUyA2UjwanS52A/a01XkbnQZLDCoOLPtq6DS5MBoXGsxJrtsEwVzDvgzoZLLNbcEOulc1cSVaSTM7TJ23iMm96mDzsMLsucnQ5MHMvVjEZmS4efHBDa25TF8o/apiPvEPRIfBXN0JtuxkZzQ0jRWcFhkfTj5T1sS7BY9sgi7k/zvJkjZiSQ+b8qxhylGEno/PTVNE1qIPwFM4dWhXYI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ygh7NYDzIdcEUPPAb3iMBTMkRMBN0GH1Bx/K8sjYAV0=;
 b=Qp79JMJSIqBoMTBZjuZJub7mCIUzXfAKj5EgpUJ+PBPtLTra0b+Xpk3nDcDifJWEyoygwKUpMBnKl6MWMAdvyyLineXaModNYhC7unyz/s+Q8ABBnHp1ULRRlijk99vfrF/C27uZJD8hMxSGEW4YZJhgc0Q6XXwyo2zQHLCXysAcIxAhlUErsXM9osoyVmy2gVUzvBQH0uJQhIRXRhvyhE2e/yR8DU09MLvIdEOT6PhtsIU5/uY/1kQczCdguwhslfL3zqWcqH58AzV00x/hAXdFiWExlo2L5xoEi8FHLNtvJGpZcu9Ky6tLlu6JicBEPpAKsNftee6EHrHqFYGMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ygh7NYDzIdcEUPPAb3iMBTMkRMBN0GH1Bx/K8sjYAV0=;
 b=LET98AcwcfYyHvJFOGfAhcfUmq0UdFHCFvwtFNfFXRSnzuLUawPxa7bHYJiLZSnHmUMcuoGv17NAxr7JKAlBhg2tgHdlzZVz+22/l+/MbJc2v8rF8xOespKu3cfB/iYZlgQGPbYw7ggWLNhMnJiRZbnJw9zQEp5jjfy5lksPBEgaUeWT86yH0NPZnk88GRQ9GupBdks5Mi0Zy7JjcR/5Uj8OIeEp4IQ4R6G7TOwPHILm6qbN0B4fqOvuYwTgqsGTsQbeJaKtDxpPelzL3iUhv6BBKhITNigvuc75sgzBDjOb+pPjTib/oM4KN//SAl4CFFQqMHs5JvYnpOYINSr5lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH3PR03MB7314.namprd03.prod.outlook.com (2603:10b6:610:1a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 02:13:01 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:13:00 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 0/3] Add Agilex Clock Enable/Disable API Support
Date: Mon,  8 Sep 2025 19:11:13 -0700
Message-Id: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH3PR03MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 394891d9-12f4-45a5-50b3-08ddef4666ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2V8fNJ3SBJrG5vUfsMf5XYH17f38c9VPeh4aITQbSuOmTm9ryc0Or041odDR?=
 =?us-ascii?Q?vosgfxYGrvtV4G/PARIto/5+TumlEZLf4PNjZgxGBHx60BadhNOcN6H48nSf?=
 =?us-ascii?Q?Neei9/QRBwplBGzYFtteIYMjdf1bWEyDy74V+tmmpMVOvhPF6SFHHt4ISWg8?=
 =?us-ascii?Q?CprA2Dt1yajdjJWRS29QHCwW2nTq1l9HTS8eUbQpWF8xIpvONZufVWKFMzQ+?=
 =?us-ascii?Q?SZqgBchPG9te5t5Y4/jq3Ap9V6euog4k+zZrycFiIBTBS9s7X21l5mKHyxmx?=
 =?us-ascii?Q?Oxaj+VpiXhfC9g9gS3CQl/41t0kTzFdc/YfA7/34j/kYyU6mgPpEx05oV3X1?=
 =?us-ascii?Q?8IJMFn2UAK0Rq7aw+WZvB61ZIeyz7E6/kIyI0C0i1tm4zKFOsJAQzLmrbFu+?=
 =?us-ascii?Q?ZitrbfbwGDir2l7kFLs9eI+r0hg1pzYcH9JTG7tKl8QsWCf1O2LFkud1u9Co?=
 =?us-ascii?Q?3x1vnzIZB9IpVgqUjwrBo4fOAiFZ8Wm0QyqGuZRPSzYS5wU5GvI46Dv6HjYJ?=
 =?us-ascii?Q?jGX6pHpe8qy32u2AhmSAKxm4XDqoW12v+oIqbIuQF8AJ0BetJJA7bD5IRj5b?=
 =?us-ascii?Q?AxD4f4CWg0NjCJcYasUeB3VngDp5nxY52u41Ozgrl0f/JpfuSooPLNsEZP7C?=
 =?us-ascii?Q?+CrNeNr1rkMBjhfs9FtS0xwml+zVxzw5TOiszWSWS+g+HiG4dysx5hmAJh5w?=
 =?us-ascii?Q?RpcOapc7b0Ny4Crrn02jTCjLQYPq9wTf1zOEVC4Do3bbIOznnU3UlDy2vC61?=
 =?us-ascii?Q?X/qjHkAnBTTPYJfleCV8/D/Ciwu+FTB6RlV26fSQ8G4qRYZxmzBm7sRmDZ7P?=
 =?us-ascii?Q?14T4f5A1mtsx6u+oI8sFF6bBqyOckTGRe7r9Rzlg/OB2zWsOEtCnSR5aGNnQ?=
 =?us-ascii?Q?2BT5jCFCp58LBWfIA9BQe6qeELQ8Bx4P1uw/slH28yDmwm4ntz7BAdJoO8nj?=
 =?us-ascii?Q?TQNDNjQV0iPtmxV0NXvGSHwHAzyZcZQedDz5EE7rKkLtExQaguw0p6zDOfQB?=
 =?us-ascii?Q?BE6EIksOxjWSHo9B53WJ0FmTvFBZlYTB9uHNOqYws/X6YAF4BPHgIS1lNAsm?=
 =?us-ascii?Q?qoxAkX6bFosTjy3RJe02UQ7PBj25jcCJHS4GBaLEww+CSrPOPLzrY0ljcMP+?=
 =?us-ascii?Q?sPzfIcUXiUpRi69mBHj2SsEqtAiO94rY2FQsLqGCi7PfUl16xyZal+5t+hM4?=
 =?us-ascii?Q?X6ZdnjyKylKmEmEHQ5NhhuuIRYverrnGcop8pc6d4Dkk8HRoHv4RTYJQR/su?=
 =?us-ascii?Q?YQ+Kz6jmuUBJy5mcWIoJpvN3lq/xxFeAhrvkld5goYFnSVRAYvXJ26lKLsmB?=
 =?us-ascii?Q?KSuN0DNAaChwfgcF9RiHJ3RGrzRI9VpPeyBNVoFcFiWpuKO+Tai87v040WH4?=
 =?us-ascii?Q?WQjjrvcxQB7Aj3xjDd1wNNIF2vJ6hKH/TFQWGLctutDuFf2qPjVdmI+Vpibr?=
 =?us-ascii?Q?FetiVLmhOlo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?trvxcMsKFIlqZFd5jCkkFBG0ajXQlVSjJuMhzgQpWArnijNcD30oxS3/U+OM?=
 =?us-ascii?Q?XIfs6gjecbXTIo5LEO/+xHOIDIxi1p2+9Y7aJ8NgnF+E2z6TvM0WPKodf5vL?=
 =?us-ascii?Q?4Pgt2Qe0Gl686hyZZH52s6jF1PfoR5bnxmQhreBVCQyz8c0GBIbk8zaAGs31?=
 =?us-ascii?Q?WxBgueg+ndVCMEbmTChlcSoaDJlh0OfiFedSAQ3hooDmHemzc6pQueQKWJw7?=
 =?us-ascii?Q?2nutPt9xmwofnHq0PRcbbL/S+B/fjFw+rjfGl67sFmBojMOVcuv+BDTnssQi?=
 =?us-ascii?Q?sGS9u2zTqT8dVSTyg0kQ/Tf46ukXfItVe4/w3N/CDd3B8DMQVZY5RHdNZgIS?=
 =?us-ascii?Q?t6NEH9jyQFjRpsvFjcCJdvfo3t9sJ1aPoK1ARmPpsw+QItrq2Dd90wPy+ypl?=
 =?us-ascii?Q?YCSDdXdyIyhjWuA3XBjl+Nla8e/0v66YM+6zDSXWondRslUw/Ka6zj/cTMEP?=
 =?us-ascii?Q?EmFgxdUpQbFAbYT6N6nvXridcwVTZktYBy9BbT02fYOmfkPwveP00GGXJIya?=
 =?us-ascii?Q?JKj/V/xQqC8Uel6jPrWtp6ni2JlHoxwjS8T9n8uL2aJdrfPvmHQ2Tikdo+Oj?=
 =?us-ascii?Q?oGQOq02hMhddZKjyyRGsOxhvKRYGvVV87q/0/gpZh0xnShvMJ2ry9Gli0pIk?=
 =?us-ascii?Q?tvJlDoHn6KKh0qESiNl+67FJeEMRP25czzB8A+TQ9JsAHo5n5vJ7RN0osWoN?=
 =?us-ascii?Q?MWQofgsZRZ1uq2FM/jlcLj5HzHrnxFghsJBmyecudLJDOQALJn6iTOASyDrQ?=
 =?us-ascii?Q?J7ZsZz2WcKwdlsYGvZfhjaG2M7EBRK73ayrkTWLoC+p+nAH6YKR/wI06Kctl?=
 =?us-ascii?Q?ndqEHPaie/3U6sSiA1slXN40mRqwi3GL9llLtQh+0AyEZyEehM0ilih977XR?=
 =?us-ascii?Q?DJZ7OfGWgf/IGD2ie4ALF52AcaQdpov5xUVp8mmYEtJvS1HzYjVK1oa5/mpx?=
 =?us-ascii?Q?DqtpRHC5+Cu83cFlPnsPcw8WkTeV8/FqSfX4UGj4hXA/6MV1J2SlLH26YTDY?=
 =?us-ascii?Q?HeQCkp1A2gI3MaS/vhNizhut27NkLJUt1zpxiGgifMOQdS3CZtKLXvmEI98b?=
 =?us-ascii?Q?vX/grxf7xkuXQi6HZ9Je9+yMcIn9gyiq9ac+YDvcge8y5gW11X03SQxgHkP8?=
 =?us-ascii?Q?yIoFz4C3KDU+8Btw46Ar4MYfMgrnHrAdCUaxP1k0n5UosWBNGZsp7aNTPg6O?=
 =?us-ascii?Q?CgB3Dj9GXlXBGVK7KWF/jkmuIks7zp6Fqf0ofa6AUuxJ3R2BQMnS0rmlGBbS?=
 =?us-ascii?Q?abAqBlI3sraph+7VziKiR9bdOJqI6LS7b+YXO7Cecbir10y5m5l8V/V8SxgS?=
 =?us-ascii?Q?B7OOzv3hpLrDRAz6tyXWRLFpTTzOXj/Z222s1vVKCdf2AOo59rmsECv7/0B0?=
 =?us-ascii?Q?spQzn51poazJwSW0BoZJVaXYo8oCfblIdZAuyvzh1uk5EeEumm6McE56lwe9?=
 =?us-ascii?Q?HF5/K0B+6ohdXgNfsxmO7xFxs6o/tYZKp99H5M3/wAAvYjFTngIpO7Zu+NIX?=
 =?us-ascii?Q?ZIMjMRkLWxaBd2G+Yvw+fPYnOIR12pOyyd6bTRRisnRFrj7wxslYroJoOkqm?=
 =?us-ascii?Q?ICzeNOBSOxXjUYyE5SDCk564ijfQZz3r5f/Wl96ybe4VJirvyvEs/5lw/8AU?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394891d9-12f4-45a5-50b3-08ddef4666ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:13:00.8146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNqjX3tiJtNO2anJqZ2Vfl8w9Zv6iaE+Uea6vkh5jjnf86nEuNvuFqgdwq+Sl0skaFnnSRoue3UNofd7N1I4CpIye8BsfNfQm65pSWiMj+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7314
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

This patch series introduces support for Agilex clock definitions and adds
enable/disable API functionality for the Agilex clock driver. The series
also updates the SocFPGA DW MMC driver to utilize the new clock API for
SDMMC clock management.

Detailed changelog can be found in the commit messages.

v1->v2:
--------
- Implement clk API to enable/disable SDMMC clock in MMC driver instead of
  directly mapping clkmgr base address and configuring it.

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/patch/20250804004710.10222-1-alif.zakuan.yuslaimi@altera.com/

Alif Zakuan Yuslaimi (3):
  include: dt-bindings: clk: agilex: Add Agilex clock definitions header
    file
  drivers: clk: agilex: Support for enable/disable API
  mmc: socfpga_dw_mmc: Enable/disable SDMMC clock via API

 drivers/clk/altera/clk-agilex.c          | 120 +++++++++++++++++++++++
 drivers/clk/altera/clk-agilex.h          |  20 ++++
 drivers/mmc/socfpga_dw_mmc.c             |  33 ++++---
 include/dt-bindings/clock/agilex-clock.h |  71 ++++++++++++++
 4 files changed, 228 insertions(+), 16 deletions(-)
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

-- 
2.35.3

