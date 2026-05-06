Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD74CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 09:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D1E847FD;
	Wed,  6 May 2026 11:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qbBYCKPG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qbBYCKPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EA984812; Wed,  6 May 2026 11:02:48 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E00680086
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 11:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=blXN5qKpQ/JAusbQsu6NvClOW0yJT3WO3KPEP+pNivTKrYXkcXHa4Brrmq7QqO0EZ4IChtF8PK4OjdxxpaMIJMfBjhMxzRr/U2F32pcBJdTUdJF/U0OjdJcLMU+dk2EDlpZatxMVW+CBYw0+hXJNpVXx7W0NoFm04qz8MSCNPSUor46Jc8k4/lUkJhS3EAlqvXoBEgQisxPfiYYoVoKktrerUh9QsIXq4eFwcQO+zGQzy/zhl4TSulgoOz6xjfvEBUJ0it91L5SGSW9vKq+wFrkRcs76haWFtdLqrJVaGkW+h3N78+qo9TIpvJ6HaIw5k59uvACwHuXe4P/M7mx55Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+bPthXTnH5onycCmdjTNij6+v1Ou/of5aQe+xmYC30=;
 b=CGdMTr5+KSb3laPsIcNeTDqLB5B3VsitiJO81ZCWxGGkPYS5nFpPzK1uahMVW22tLftoj0joRIjJjddyRw1vOoE4WwtfvZsLlxjMEB83zQwgAlnue/7MP343rfdmtUYbtSuriJ8BILy8HlJyLgwEGcHxEbyX162zg5FEiRNJreLuj1OkET2bCLDOVQ8LXtI8qZED3l+07XBnxHfRovCa0Wcs5HCS7KXPEolvgKqiEQvbSxMmdwmuZGxWl277wi2TRK1z1/x8DFna7KNg8LbSpuVUJEgucGnqAXUft0i6P5V6r8KjX6l5buQTW00ZWvbwyBTwqhVh3QqW/XuYoqBYiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nanoxplore.com smtp.mailfrom=arm.com;
 dmarc=bestguesspass action=none header.from=arm.com; dkim=pass (signature was
 verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+bPthXTnH5onycCmdjTNij6+v1Ou/of5aQe+xmYC30=;
 b=qbBYCKPG3mWsr0xFSAEfKsEQQHhxcSOtoot4F9puIdoFW3Sks7qD0+i3kQ7qrefI8OwAJVZXApGWr5Q8FtUFrPwXDEnELckBSPrPz8hUpkX+d2hyNY+OSp6VXsShJ53PN8kr+R1vIajEG7vCjA0eJA8Op78KyXX/eDK7xOnhD7g=
Received: from DUZP191CA0043.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::26)
 by AS2PR08MB10252.eurprd08.prod.outlook.com (2603:10a6:20b:648::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:02:44 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::7f) by DUZP191CA0043.outlook.office365.com
 (2603:10a6:10:4f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 09:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=bestguesspass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22
 via Frontend Transport; Wed, 6 May 2026 09:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+NrcMRgFEPNniju1JiRoi0jbjHvv+6mj2B/Y8j4QX2bmvfMfFZy1in81M+dZ8NV5WjSGoSSZQQrNhAVupCbGlcmjps8ssplJHAmxcmluXgqo4DvdZUEw3GLuy0sdAzYkbQSyRaFIpDpxDcs/+cTGBOU8WnCDjXCVHWhnaluOBXMGrie5D4FNm4gcOFAvfWVGI8LZneiUOnrMRDsWsTevNKgEDsDpGswppgjdDxZPUEAfEvqTfMVoEsWBmjCoo5JZhLiJ9HBc0H6UD+vNgTL7FN5o7V+7t88NlFF+iafpXxv2zrUA7DTZUDK0vgrdhAyPlO+bR5vYWmtwDkI0eIKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+bPthXTnH5onycCmdjTNij6+v1Ou/of5aQe+xmYC30=;
 b=l5r5VekBOSJ0kOR1KHlRc10ONycsgM2kkxcOKg6D9xCOfo3QDLcOmOzLxVaJkpIpR2Wsd1Kyh3zQpJHKBffUNAyKlQLZf6zyr1VGNd2/wIQr98zKkJwwQcU08DYT6UG9lgz2sxA6LU6BV8l5Rw6Be6UBYtjyic9E5hfdpVytQPq5ntiKJFR+doFLOov4LNr0dmK9T5P5K5jtU03ibR2BCU+sQT73JMfifbd/IV1KvAwk/lAlcm8V5pwvdn15Cd6zY7a6hWQq8D2CIjaIDSdrWuxRIsSB15q/C72ZP80zXtkHHtDb03PDU0tj0MmyQFZw5gQwsMjkoGSJPqCL95sNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+bPthXTnH5onycCmdjTNij6+v1Ou/of5aQe+xmYC30=;
 b=qbBYCKPG3mWsr0xFSAEfKsEQQHhxcSOtoot4F9puIdoFW3Sks7qD0+i3kQ7qrefI8OwAJVZXApGWr5Q8FtUFrPwXDEnELckBSPrPz8hUpkX+d2hyNY+OSp6VXsShJ53PN8kr+R1vIajEG7vCjA0eJA8Op78KyXX/eDK7xOnhD7g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV1PR08MB7779.eurprd08.prod.outlook.com
 (2603:10a6:150:57::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:01:36 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 09:01:36 +0000
Message-ID: <1560582d-3166-423e-a29b-ecc481cf6eac@arm.com>
Date: Wed, 6 May 2026 11:01:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: macb: support for instances with less features
To: christian.dreher@nanoxplore.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV1PR08MB7779:EE_|DU2PEPF00028CFD:EE_|AS2PR08MB10252:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0eda37-b0ba-4c5a-6559-08deab4e3bd4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: TsDjVed/mXK/miliOIx+09HXUcvSO5TiV6HeXKRQkctHKepfKOHOzVVEv9RWfkYWaFdPUzoeZrBtiDlIy6nAAHmoU4zGr9Kia/fsJBar7Jk/Ew2g9GKyfpmh4HMXdWLaYKH+8Z1XRPaoLcO9QsUykTD4g8tcklQox7ImxXTgXY6QriiUFNd/vxxrDPa6XAtudDKVMSg61BP6uShn8qLYz/mCWSgSwnjIgCoL0kagUB27aWnuPjcAsNUYwfMTE3mazlbFVMaZoN0BiAk0d5GDbtOsI0ycE6pyxg/CClbSEcVHF+dMTYcvhI66F1E0KA3+U0sU1+D2jh9LaOVE5iELkIxLVfN/TwCK/p4aYkBvJ96TUBgq1YXKmjGk+8V2vuq/wG231cYv3YSIABpkPz5kU914FjJr8nJq7XJIRQJeHuAac2w/NYCMEPNp8HhYF+IvF+F8yh0VYdNLZoGy0zHpuxxDJ63PiWipqvIaPvFjc1rM7SsECSEWsITgD5rFYJ7kevjIoL/yv8LOHv0Ya3ABYNdHvVgrks1gDMjm/II+Lqg//Jpavxtkc7ZNHvJW9NNUPVJKe0Juz2rRe/2JlZkCCjH/g+62GA/jCHqmS3D6cKXiseBvKziM2pbr3YcOyakWNZbim8GSCtMyx+4MgKrvnWzLTUQHyPExCULRzH3QaDT2QBTzvPF1tSX65QPzqD7b
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: c8RPEaR055xOZnJXxDxznFzcuz2enLFkDCK5z03u0fBpyFPtmFk5Ncl/y5mRxQBi3vHdHw7hdhDXCNsFNHkVnwtmlCctMmFbIqykCyL64kZ35UmCmhg2YFRrybPX0yYafTeQnLHU17EtP5fvzk7dc6iZsClH1I4ozzsIyEBAG6pIN54P2MxqIKgRgsZDzE9NkB9VBOHKnDdB2msNjnwbQCAoNPRFMUs1Hy+KJc+gOPaX7IgCo0HAHJl+jfhHBNpD7eSxsuRih2HlsaTAfqIAOt3PeNOd6i40kmUulyyP9rUT7ODMnodHEchgO+i074l2nQbUsjXLPGr3Gb3z3ND9+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7779
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5c9d5030-78af-4e49-a9fe-08deab4e13de
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|35042699022|14060799003|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9pcYND4pX9I+Y8Tj4b6qq9qEMlE+RnADVcM5DGS305RqONH39MdKYkI2UsuKHBRsTwSbh11kmtFIGNiYkyYIQjXlQHMkgRtF9XECMXR3xYhxfMZ4mIZp3uqP0ZeIDIK3NsruSxMI44Fxmsnj5/qvTynN3Y17UTEVU8yGQgWFDEI+mjssTqaeGU2MtxgqSrODdv+GB9iBeL1QU4oY4m95VRAbBCOx5Tz7srIOe79KkbhuhYeg5P6ZUWjyZwqSq1Nsx/9+BgHLwzuUVGMz0nE1EEFyLyBK11xfv1XNAg8od2j+wzYy/KUTDVktJy6T5SArYbcaUuzAHeJt8nMmITrs4xWG9Uop8AMXbiCvDKwnLu0FHQyXG6voPezFL1acbAX4rEJtx/ucaV5wLH1tDXgvLYlV1eEyln7TI+h62fytYFiaKlPSQ9Brc6rs4zwwY9ViWM+gYpJ0GJxEsyl8jydF6oVymxvsg/WMlWiwCpa8KR6v2WJNVpHu5yspCBZcj+8+QKHX8BIRvbVLwU0bo7PN5IproXwZxlf4beUaQlSt4okUMDOavSzdtsKTebcAesITgrDG5GBfDC0EohfU4a0loR3BCztw7lCzD2+KDW0knjc19d7qSgsIH/TueNEFb30ar61GtFrbLn7Gh8bUAAZJ9yl29SocblzIzfvtifqrwvUMgqFH+atLJvW8X5N6pgn/l97zgVEad8KMwy6/6S5knbqyKURhxXovKD7lJ6LNRaM=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(35042699022)(14060799003)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wz9Lhrb/NmolWVfPbMXtA1/yZUZPiqTWijvpsRrct0m+vtX2luptG5f/JjKHCqvOmDs3S96I8/oJubCgj8TfDsgblC26T1Eh+xkoJydJhCbSHYsddxGLB9xrdzuu/mu6s56zJP2HNdf5IW1p2Y0MKv6ekNfheZx+M6Oenrkh5wtwJytN3UGBs8oUUde2ptaOq9azISZggyYU06lMJC6+Rp64sVaZs2hPON2Xw5Y1b4g50zRCTDFu2Gp0OutwQLzQKqRky5pDSsRxgaUdx8oQVcgDAPlDEobUJQmAtjdgcwcDPo5Is3N4nV7QAB9ezdoi4EK1tsjfLpDt6FBgEJkvd5+2E9mxJtDHQiRjX3CvoR4ZOXEiWUmHecJalqQZ16+7s60g143iSzsO0zSRledY6HlWPJ4EegrnJeFo19DQjs+ecM2cvNvdo2h0buoX4VHF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:02:43.1719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0eda37-b0ba-4c5a-6559-08deab4e3bd4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10252
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



On 28/04/2026 20:04, Christian DREHER via B4 Relay wrote:
> Hi,
> 
> I am updating the macb driver to use it on a new SoC with a Cadence
> GEM (IP7014). The GEM is instantiated with a different setup than the
> ones in the Atmel family, and this patchset allows the driver to run
> on this other configuration, with no significant change of behavior
> on already supported platforms. (The support of the SoC itself will
> not reach the mailing-list before months).
> 
> This patchset was tested on emulator, with a RGMII fixed-link, by
> pinging a remote host (an actual computer, connected to the emulator
> and running Linux). The test produced an ARP request/answer followed
> by a successful ICMP request/answer, using the legacy IP stack in
> u-boot.
> 
> The patchset was developed and tested on top of U-boot v2026.1
> 
> It was not tested for non-regression on previous hardware, since I do
> not own any.
> 
> This patchset
> * Remove a build issue when the mach does not have its own clk.h
> * Uses MAC filter 1 instead of 3, for GEMs without 3 filters
> * Does not set the user_io register on GEMs that do not have one
> * Add fixed-link for Gigabit (added for test purpose, may be dropped)
> 
> Thanks,
> Christian
> 
> Signed-off-by: Christian DREHER <christian.dreher@nanoxplore.com>
> ---
> Christian DREHER (4):
>       net: macb: include arch/clk.h only when necessary
>       net: macb: use SA1 for MAC filtering on GEM
>       net: macb: do not set user_io when it does not exist
>       net: macb: add gigabit implementation for fixed-link
> 
>  drivers/net/macb.c | 94 ++++++++++++++++++++++++++++++++++++++++--------------
>  drivers/net/macb.h |  2 ++
>  2 files changed, 72 insertions(+), 24 deletions(-)
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260428-net-macb-support-for-feature-lite-instances-fb0707bbad26
> 
> Best regards,
> --  
> Christian DREHER <christian.dreher@nanoxplore.com>

Series added to the net queue, thanks!

-- 
Jerome

