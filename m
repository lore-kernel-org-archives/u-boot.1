Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16592C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 12:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7080A848EB;
	Tue,  7 Jul 2026 14:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="MFBZml16";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MFBZml16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C79F084979; Tue,  7 Jul 2026 14:41:04 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30B884852
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 14:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pYgiGxgSnEhgHt3SsyumhkOxaBKLY8PlTW1Ff4I+DLxwfCKSCqZVwQP0EZ7+FzpoKmZU7rTBJI4b6tWgFkMNoMpwnOgZnsFJqG/ymB6Ij+WsgBwVoU2faktB2rsmxn7IUZtcMfBjGuwfPdxHHzRDjnWk5nDSRhapPE7hHfFe5hwNI88umFrA3wASSoo3am8kip5prg360Vs1Nu/EmTpzomAxGJwgTzbfqo5d2vcDgMpioedZ9UipRL16F8FLaqy2w16XrsWo/eSsdeSS6WLZ9G7CZvsINEfykPrUiqP4NMpeQDHjpYlmY5I0Mb8UjnXDiSeiCUigFTuWAaGMg4ilPA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7UJgE63Y1wNRqpd09v9pZPcSa42hInCliEvI/X7jmQ=;
 b=wWVowj+3GAovfzKRAWGG8vIoVjcm4+pUMhngJCkesBG6DGwj4d+kNUxUr/P+We8xC3q2sHK9eQvErwcgLHXNJtvfK8SxlAoqL0LzHQugHqnnDYswlPeuUrPP7tsZazPcIuW4klQp5fbzEG1Hn3IDB1smQQFZ6uvO+kAuQl7VnS+gp5I40T/t6iviHpWhKVw7AUL66BpIaIDlMmUb7CHNoGC+y9WNOyK+oV5yc4MIrssa7fjU+Pidkeqc4fUGDlY6ufTX9FoI37fQI4+00faB55mXlPtt7LCr07Wv+7EqfuA6R751jvPFQUupPOwI6BxFeU3RtPufcu0aCi+BVcXa5w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7UJgE63Y1wNRqpd09v9pZPcSa42hInCliEvI/X7jmQ=;
 b=MFBZml161h3pEpZ+TJLS7pLzg9CKSZftQBsZrb9DQYZ61z1f5ugtqoGvDB1ddmelhoS75IIbqKekTvV6kDuGED5PF3UiGIKhb5vvxI9cMM1RcPRLX8bJEI5G+neYQ+BNTuXKoDNBUn/59dVIxOHw84qNew2vKHuz8rpB83ClQtg=
Received: from AS4PR10CA0018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::12)
 by AS4PR08MB7532.eurprd08.prod.outlook.com (2603:10a6:20b:4fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 12:40:57 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::44) by AS4PR10CA0018.outlook.office365.com
 (2603:10a6:20b:5d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 12:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Tue, 7 Jul 2026 12:40:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZPpzsZttKnxKbrETxwDycy/go1ExhuAfHxcsw/8nkfX4L6hwBHuDYFy5afKBcLQ0BThW8hHKCn/LJDtdb4NMukx4uGfMnGtn5/Y05qnVCNbzQXxt61aCL5aJF3Y6eE1Cyy0X+GRoZbAfhf8RQmLRzwPON5OjyrzwvsLJ1DjyTM7GMijxmTfhnHaywvBTiqw2FDcbiWU7c0P0LFXlrTK9byRp5iHile8GAhXylc/IRY63n6ZErbcNqJnCI0smtgE+c6XByb8ckQ7+4K+TQ4hWC3iFZ6RX0gpLFqloYQSjb1kmMfHf9K3BoMMI3CIMwMoPAvcdzjnF7eVX6onYueHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7UJgE63Y1wNRqpd09v9pZPcSa42hInCliEvI/X7jmQ=;
 b=EPggJHy6r1r1Ywbri6c0PBUioNuwJ20M9fEhGehHFNUefsUlyrbFP42AvZ76n1l1YAvrx1aKOvEgUhDRmVeTTWFnrqW2sdZyLu8pDv2+YS1xxL6c3i3MzZ0UfGcVHssCOJsPSz8e3Dyd0H0UHGNV+tSFM5XQ2bL4aLkmB758SKqzvZjcEwXusvayu65+pflCpiLO22/1iw53vtzpd+hNiRJKavUG5BqRr80FLHG9Vd/qor5uqaBpak5CdfkjG4cV68cfhNvfchs3dxBEYmrQJRqBj/h9wi1QD3K22W9kiiD/J3FskqnATTztZJbEDWSEsdBgNlJxQFunPrvZc/gejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7UJgE63Y1wNRqpd09v9pZPcSa42hInCliEvI/X7jmQ=;
 b=MFBZml161h3pEpZ+TJLS7pLzg9CKSZftQBsZrb9DQYZ61z1f5ugtqoGvDB1ddmelhoS75IIbqKekTvV6kDuGED5PF3UiGIKhb5vvxI9cMM1RcPRLX8bJEI5G+neYQ+BNTuXKoDNBUn/59dVIxOHw84qNew2vKHuz8rpB83ClQtg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM8PR08MB6401.eurprd08.prod.outlook.com
 (2603:10a6:20b:361::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 12:39:54 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 12:39:54 +0000
Message-ID: <92f2f758-5e68-428d-8813-6791ba2e3230@arm.com>
Date: Tue, 7 Jul 2026 14:39:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Drop unnecessary device_set_name
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, nd@arm.com
References: <20260703-net-v1-1-3c2c7d6323c1@nxp.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260703-net-v1-1-3c2c7d6323c1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::22) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM8PR08MB6401:EE_|AMS1EPF00000047:EE_|AS4PR08MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddced97-0510-4946-7688-08dedc24fe3c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: qFBEiMW8TIl87j8L7A9YxbHNATbMCPB7QNeUjmsgY1lIiYBDPIeBG+Rfvnuc3hnJxfm8VCBMO6CW2dpcCDX3hC0A7w2wb82dSrXe5UaY54aR9McsLbscxLyImjUZWoHhg4zwTKDZafb0DCWSUkjCb/L9WAwem5zO3bZDe5jdaYvM3A0CYVgL6m6PCqX7JiRSAfHNYGRbZ82UMFhni74Z+V3OewnD1z4AUaWnMLjzMEh/lHuPmTy1BmfYTQE1fxakLG7HKU2y59EfWngbWfDzeMkvXPdZL3nXnOuRA4xG8IokLGWFPPUTTrDT2b3iPidci23rqPfvGWtRPR2Bgvr43/GXOd6+0YDXmXvwtFdrVGIrFowlEJF6mD/fcDA0dWre90eONCOlQmCLp6u8hHYUvCecdXUU5lu/ZUoONzzMNln4i+6GDo5wl7pIMphJbSNdcYofm4GDzWuyGfNPwmXmGTl87Y3y6xrd6UNyBpJQr7YsLmj/Frg3da3X9/6xvnBEr8TY5EBIpCmtwLqyjGB014bkGBYTCLIcIsLBKdoPKFA7DkJS+dSLWr6Hvb6GDRFu7ulN2kXb5/sATLcqGyEoyC4HU6wtTtVveOkeQYVOnoA9z2plNK9xwri1psY3GUTcC8eD5MfORu5t5SvGob+3RBGcHet2kHzQJaccoEK5KSo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YiKxEOE9qDyZB11O+yhZqfckWIE4Wi5KqXhlWOiPN801PbEOagXHH0aQ2p7Wga8BMrkjsHEfzhwafTmNO1A8qa+sRFq50IKCVnOEvIeDeESTsmdhwmVHL6+VP1vH+iVabFrAQ4uY+YUplg+1HZ89mL2ZN4X1FcaQn8u+yPM/cqpFqPxvo5XAjFSHcvWV2Lh6iUmGcE1eUgB52PmKMU+IIr1oezjJof53Zh+5zK23HfM4I6KxQGNSioRtjesH8p5pUFHkPg/ptKuUQCci/MSHL9bayPBiWmS2AcNtYOjHU0PboI1jUr8yAWDDuMUrJtYomIMyvGdYvvzpqifBJ8p9EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6401
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f7e221e6-b281-4508-a331-08dedc24d8af
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|14060799003|23010399003|36860700016|82310400026|35042699022|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eSZOzKAz/qfPruhyxXisf4vTbrmRALWHL22waKf/qMMbh6a0b+TnwoqfPzZU2LAnMwDstyF+64zvde1cDnsmxXJx5z2+HeFJgysjl9IuJy+Xrum8gNvkx2l8BgzzePrtVWVGLwMhQOyTDSOnCnuNS1auC7gHlayh72ppbc514M0xdthGjBe1vyIhzg7D7vEWhiGIqwiQ+mjHi+lnMVIer7lHzk8CiGuO1J4tM5yFmXP/RQiM/Uy4F9yZ+WNQt/IM20FX/Cd/x4fgsmDC5ky1tlHnvw2QBvY02oZs0U9eIbsWWfmtlyng2W8isaJj0O1z/OLOJzGH55e6k+IM7t+xio5FGYIMVcErXUsB89kXXIrQODwxtm3cj7PXKG+C/z8LjQm+i40haITAR7iO109j0z3nEIYESHMsLQVxrAQ7/rjoLFoh3+gNr+TjwbhfE59Wtd95o10gm/GvvWzJiAa3dkBF7tGHA56Pv+GHh5aKuJQ9Qi84YhIpmt/+C0+Myr/ob4dYSaQxpEyEXqKLxtdiDvv4nVri95WshqIOfP3VGR/PmU5N/6hTuCG9Echa+cm98XVUEO9tG122Wm2rA/tiIPlNeXJl+DYdGqQcPSmZ4cFvhUgz7CYS9yoxPcQt8YfyA/4r5QQsNZzSmclCAZF2fHV2/Yg7PaQHW8pM8ggCAJrtQ9RjP+VaazHweyZP2536KA4mwIG1Xj8FNtnZD51yvw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(14060799003)(23010399003)(36860700016)(82310400026)(35042699022)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F7oI/n+pL1tR+zAkgT5YQomrs7vJ8bdxj811tgDR9yqZt8LQgoNjfbE52NqakRV7wiuEAvNDHT8T0gjES6boMSplPC+nL53lJgEYor42hknmsSONPI89Q36cNR+gRf19hqqUUbfz1kT/wzyisM/CfVxbxP077UprGDyQ79tCEJy6I7M3Tkw7hgOqgudlH0n1eekkLJv4V0W8ZYm28kFfY6dOeH7U1Qm/OuljwYgCZWzVRBA+U1ZB4NNEIQ/aWpn9fyZ8hV6o7DlGw9VWxqsFMHulJ9znFtPlKKVFp9jLoZAMg9cYB2EKObfRYv141s8KYCcPWGRjjo44/KSqPMFq4prJhv+SY3w8nrXJ5GYcoLv5Npa/QpVCnb7grJhLQxl1hj4HH76ukGK3PE2/LMlwb2dhs/Cp5TewTiDl4fwh2FuMRh+72r/FxjtRBFfSmAzY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:40:57.4615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddced97-0510-4946-7688-08dedc24fe3c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7532
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

On 03/07/2026 09:50, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When device was created, it already has a name assigned. There is
> no need to alloc space for name and set it with same device name.
> 
> Cleanup the code to avoid unnecessary device_set_name.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/net/dm9000x.c    | 6 ------
>  drivers/net/ftmac100.c   | 6 ------
>  drivers/net/ks8851_mll.c | 6 ------
>  drivers/net/smc911x.c    | 6 ------
>  4 files changed, 24 deletions(-)
Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
