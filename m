Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4A5D29DC4
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 03:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F079836AC;
	Tue, 13 Jan 2026 04:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hJlO8UGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F53836C8; Tue, 13 Jan 2026 04:02:26 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8485836A3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 04:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggNTLP86LE7b+4C/qpmoyMpE95bk8611lniu/7kwLdXWI+U5fpIZZpJ4pokmIiPO4ODhNLgACBY6laxN1c0S8WhvgMAQKsYmHM5hA8lHRFz1/d7qmiQgxWNiLjVfyozCRpbHXME+u7uQiWTUgZZSr9hY3FHWe/EDxKP/KxwyxFDX+u4ehCoN3hEI0jkxYpZrCifN0dDQunxyqzWPGsd8e/eO2gnIG/8CkGIs0QBZ50BKJ215X6DtDs21kc8qdfZw3cZKE14Nw48dhkX3Jrl/M4+yC/3j2G/S6S/QXb0CCOZ7FaINHweg15ZTkMQMh/l29RcntbjDBLXEKMkz9WyUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upsq6OclyWXe5R3isXM+ilyHIszigUeYV9WcOa8FntY=;
 b=HaT0l+U+fzIl1xhVEIB4U7fNTrPdxgASHDAiGzFR64f7vL1Hb1CA4JkIUX0eMaPJz+oJ6KH7FV1tQ1rQ6jL2P1LZkA4c6GoIT5uRlPaVAVpCS6gnmAfcxgVe8a2AIpEW0W+4xcq6vDuE5dul/YDH3JuhD1UPXUDQBuq0BsEI8D0Op7xzak3hFjtdtaIhP7KsDw83IfVpHKixvkLc/phRjlgH0wPkd/TnmMnLE0Af49lCW5wrIGChzLFXNIUspeo+r+zsfJ0Hr5oYePjtyhfS8CTMc12UGd6gWkpjnuhfR4n0ln1V2vgsYeB6KwlcHuFxP3RT1x21xRMbgXQY/sHUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upsq6OclyWXe5R3isXM+ilyHIszigUeYV9WcOa8FntY=;
 b=hJlO8UGd84Zy5uo1jt/JuaWryj8T05P41WWDarcvvYs48GrTnjCkdiJYJJ3mxnbAiAPUXztteP4itq4FbtB7g4RaCDFEtyCd/mQN54uOxfIOXxQGDvrl2R2DBjZscMhc1j5HuLVAqFe95I8uR4GzX/zZ/fIYY3dG1jbMwTAq1Y0=
Received: from DM6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:5:1c0::40)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 03:02:18 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::33) by DM6PR12CA0027.outlook.office365.com
 (2603:10b6:5:1c0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 03:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 03:02:17 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 21:02:16 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 21:02:15 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 21:02:15 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60D32FHf1555738;
 Mon, 12 Jan 2026 21:02:15 -0600
Date: Mon, 12 Jan 2026 21:02:15 -0600
From: "bb@ti.com" <bb@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>, "Sverdlin, Alexander"
 <alexander.sverdlin@siemens.com>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "c-vankar@ti.com" <c-vankar@ti.com>, "kishon@ti.com"
 <kishon@ti.com>
Subject: Re: [Upstream] Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers
 again
Message-ID: <20260113030215.v5jjy34tezvxrczx@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250815160240.3575140-1-d.schultz@phytec.de>
 <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
 <d47cb78e-e3e4-4a65-a0d0-b7dbf22e7339@phytec.de>
 <20250910120815.ifbg5fndnaodopvt@bryanbrattlof.com>
 <64f1a6561417bf7ff9d8e92ea69e1ef842bd2055.camel@siemens.com>
 <20250910125335.orpc2lrm2amncbwg@bryanbrattlof.com>
 <ae14d825d76df8b65cf82ac78a43aa0c47689b52.camel@siemens.com>
 <20250910132609.bfqpdflcgfbtouq4@bryanbrattlof.com>
 <50c51eea-af1f-48ad-bb15-eeeeedbf9bf1@phytec.de>
 <5e333477-1745-4db8-a56a-abfdad8ef825@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e333477-1745-4db8-a56a-abfdad8ef825@phytec.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: e883ba27-0307-4f15-3eb0-08de5250290e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|82310400026|376014|1800799024|42112799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TktFOEI2cmxCbE90dnQyUmQ3aFhvNVpPKzc2WVRGT2NDcVlmd0x0cXFQdTUx?=
 =?utf-8?B?c1dLbXpaT1dhMVBua2laQXZCNnJBQTM2RHNwWUtqVFh5SHJmd2F4V1FqcmRF?=
 =?utf-8?B?bzJSeVFUcXpVZnd1YmFycS9FcmN2cDQ4QzlweDVyNmJEcXFCNmZvT2RtYk1x?=
 =?utf-8?B?cEs2VGlNRFJNeFY0QUlLaS9RV0hDbjl4ejFYaVoya3dodlBhemQxTlh3YmYv?=
 =?utf-8?B?SzBUWWpBMVBod0FQVThqV0pTS1FwNGo5R0JpTFZwalJQZjhFNml0amhwU3Zz?=
 =?utf-8?B?OXhkUExPZ3cxWmVGWHQzSHAyRmtqVGhxeWlzVDBnMVhLSHB2c1VqZlpCV2dX?=
 =?utf-8?B?MlpGTVVUalN3bXJDcnB2NDI4dkU3a1RBOGhsTmQ5ekpESnJ0Tk1ycE1TcGov?=
 =?utf-8?B?YlVlOSs3ZG9TbEtoWHUxbi9ENC90M1Bad0t6WUNGMFlLbFdPSk1pdUhzbGdr?=
 =?utf-8?B?Wm43OFN4SlQ4RDlFL3dnNkVqUVF0SCsrMEp1YlBwN3gzWFFwQlRUUGxVaFFT?=
 =?utf-8?B?WnM2MXBLaEFvVGIzNVdtNXRCd2ZJZ0graEZQK3hyVTV2QVNKY1FUUCsyYTEy?=
 =?utf-8?B?eEVMNEdRNjRVWWo2SG9sZzVWSFoycVN5dXhyZzMwaktiU1NDNWlRODJza0E1?=
 =?utf-8?B?MkxVOEo5ZmZMR3gyZ1ZzTHJHTFVIMi8yeVNETm1rdDJQemJyTjJ6OW5qYWRs?=
 =?utf-8?B?TnROeFVqUGZEK2JUWlJQR1RnazJYR3BVeXcrSFFtZkFMSXIzd1lyR3NPV3lW?=
 =?utf-8?B?dWxxQU1YRlB2VkU5VWxBMkU3cWhHNlNOeXlqWU16TDROME1ocldkZnVBQllJ?=
 =?utf-8?B?U1k2ODNZMkpzdDZrSTY0TjZBM0c1S0dyTDVKKzduTzNMTFNJWjVHNGIxSVJn?=
 =?utf-8?B?d2pKc3E1Q29vYW10YmR4SFp4MzlBUTZacEVkc1lvbWJVeTFuUjB0bnpzQ3JE?=
 =?utf-8?B?SGFPYXZ3TmRsVDVzUDluN05yZWpzSEtveUZSWkVHdWJGM3kybEo2dHBKeStK?=
 =?utf-8?B?aStYWkNQODdIZ3F5M1NMODR6ekpZRkh3cy9VeThDRnpVMVVveHlHeEUyVUJ6?=
 =?utf-8?B?TlVyYzZESDBxcTlWR3dFczZncE91aUswb2VxOGl0UHVzNnlMWGJBc3BNajdm?=
 =?utf-8?B?dzJrNGZ4V2Z5Mys0TGRISVErOGllRGlEc2tadTlXM0R6d1hMdlBpTDJOWnU3?=
 =?utf-8?B?ZTFIU2kycURzM2Rxb3l6NGFFK0xUOForVWQxcXlyWlR4VVIyMEJCR3Zjdm5x?=
 =?utf-8?B?UHBnQ2pKOTRYQVV2TThaRUIyZkdHa1hoQ2lwcmZzUzBteFVtVXdhbDJtVUlY?=
 =?utf-8?B?K1FpQXlLWEgwWXprVTJob0swRk5xMlZVVklyTU5QbG9zOVJ3b1F2MExzcWdh?=
 =?utf-8?B?SnJqUlR4V21mMjIweFlBbDI3S2M2ZlV3NFVQVm5IOEN6Rmw1K0ptSnZQNlpp?=
 =?utf-8?B?RWFOZGdUeitOd1Y4NDl2Mkc3a3NxSy9sRlpRalVZa2lGY2p1blBmbDNXV1Fz?=
 =?utf-8?B?T2VtdlBIR09RR0cwSGFmU2ROZ09sWVRzQjJ6TDZLWU1IdU1oYU1VRGhoeDJP?=
 =?utf-8?B?Ym1pMDl6WFdZUmdwbWZvZlRtaXAwL29MczBYUmlac25TOWJIZjlXeE9PK1dh?=
 =?utf-8?B?djBOQzZyblNObEJUZjlBM0FIN011b1UvOWFkVzVEY3B0V08vYWV6TzhBdkdY?=
 =?utf-8?B?VWlxSklUa2ZMMEo2SkJmT2trUE1zK2x6bUVrNnRZalZsS0R0aUFxQ1FaNEk3?=
 =?utf-8?B?ZW9oUFhITVd1UDUxRjZuangzOGpmQjdWbG5VZFl3V2c5NVIxaTFpb0poTGE0?=
 =?utf-8?B?T2FSMWFZNmtUbHl4RGE2dnhtNzJFZUtURkFUdVR4S2RTQzlGR0RLRVJacjJy?=
 =?utf-8?B?U3JtYzFiSU9PaEkyT0dtSFdmdjN0ZUpaSDNoMXUwaWtFWXdDQ2VBRjVRQnJu?=
 =?utf-8?B?MkhaeTRNQm1mRzRid0ZLTXZQVnJSQ0ZxTGpRYjk5NDlIL1ZxUnVBQWZrOE1h?=
 =?utf-8?B?OHZpTm4vSE03K0RhemVZTi9peW1RK2Y5cHhzUmF1SHNpTXdhYVVjR2xsRTdE?=
 =?utf-8?Q?/L9y4E?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(82310400026)(376014)(1800799024)(42112799006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:02:17.1780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e883ba27-0307-4f15-3eb0-08de5250290e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
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

On January 12, 2026 thus sayeth Wadim Egorov:
> 
> 
> On 9/10/25 9:06 PM, Daniel Schultz wrote:
> > 
> > On 9/10/25 15:26, bb@ti.com wrote:
> > > On September 10, 2025 thus sayeth Sverdlin, Alexander:
> > > > Hi Bryan!
> > > > 
> > > > On Wed, 2025-09-10 at 07:53 -0500, bb@ti.com wrote:
> > > > > > > > > > The watchdog requires to have the MCU ESM error source enabled to
> > > > > > > > > > trigger a system reboot. When booting HS-SE (security enforced)
> > > > > > > > > > devices, the MMR registers are locked again and all write commands
> > > > > > > > > > are simply ignored.
> > > > > > > > > > 
> > > > > > > > > > Unlock the MMR registers again to successfully enable the MCU ESM
> > > > > > > > > > source.
> > > > > > > > > I'm just curious, could you please elaborate
> > > > > > > > > a bit, where the registers
> > > > > > > > > are being locked again if they are being
> > > > > > > > > unlocked by ctrl_mmr_unlock()
> > > > > > > > > in board_init_f() before enable_mcu_esm_reset()?
> > > > > > > > > 
> > > > > > > > > Is it TIFS firmware?
> > > > > > > > > What else could be affected?
> > > > > > > > > Do we expect to leave General Purpose Control Registers unlocked
> > > > > > > > > when we return from board_init_f()?
> > > > > > > > > Does it mean that the whole ctrl_mmr_unlock() has to be re-done
> > > > > > > > > after k3_sysfw_loader() call?
> > > > > > > > I really can't tell why those registers are
> > > > > > > > locked again. I figured out
> > > > > > > > they're only locked again after loading the TIFS
> > > > > > > > firmware on HS- SE devices.
> > > > > > > > So, I also assume the firmware itself locks
> > > > > > > > those registers again as part of
> > > > > > > > a secure/security feature.
> > > > > > > Hmm yeah this is likely a bug or a config issue. Ideally we
> > > > > > > (U-Boot/Linux) should be in complete control of when
> > > > > > > these are locked or
> > > > > > > unlocked. TIFS or DM shouldn't be anywhere near these MMRs.
> > > > > > > 
> > > > > > > > The A53 SPL will unlock those registers again,
> > > > > > > > which will be permanent. Only
> > > > > > > > the watchdog is problematic because
> > > > > > > > enable_mcu_esm_reset is currently only
> > > > > > > > called in the R5 SPL (config only enabled in the R5 SPL defconfig).
> > > > > > > > 
> > > > > > > > BTW: We have seen the same behavior with the AM68A/J721S2.
> > > > > > > Hmm this is strange.
> > > > > > Thanks for your assessment!
> > > > > > Do you know who can be contacted at TI regarding this
> > > > > > possible problem in
> > > > > > TIFS firmware? Maybe this has to be fixed in TIFS firmware indeed?
> > > > > I've started creating some noise internally to see if we can debug this
> > > > > faster. Most of these teams are fairly insulated from the outside world
> > > > > and can only be reached via e2e tickets.
> > > > Thanks for looking into this!
> > > > I read it as if we would not need to create an e2e ticket for now?
> > > That's correct. I short circuited the e2e process by creating a bug and
> > > messaging a few people internally to jump start the process:
> > > 
> > >     https://sir.ext.ti.com/jira/browse/EXT_EP-12916
> > 
> > Just for reference, I already opened an e2e post some weeks ago:
> > https://e2e.ti.com/support/processors-group/processors/f/processors-
> > forum/1511852/am625-am62x-hs-se-spl-cannot-write-to-
> > mcu_mmr0_rst_ctrl/5813164#5813164
> 
> I would like to know if we can proceed with Daniels patch.
> The reply in the E2E post suggests more or less the same change.

Hey! Sorry for the delay, I don't think the ticket went anywhere :(

I played around with an HS-SE configured 62P-SK board for a few hours 
today to see if I could reproduce what we're seeing here. 

I know the TRM doesn't really describe this but the first bit (bit 0) in 
the LOCK*_KICK* registers indicate if the MMR regions is locked or 
unlocked. So initially I added some prints so I could at-least see if 
the 62P SoCs are doing the same thing.

    diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
    index 599ea7cf2dd8..b474802ed694 100644
    --- a/arch/arm/mach-k3/am62px/am62p5_init.c
    +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
    @@ -104,6 +104,7 @@ static __maybe_unused void enable_mcu_esm_reset(void)
    
     void board_init_f(ulong dummy)
     {
    +       uintptr_t a = MCU_CTRL_MMR0_BASE + (4 * CTRL_MMR0_PARTITION_SIZE) + CTRLMMR_LOCK_KICK0;
            struct udevice *dev;
            int ret;
    
    @@ -122,6 +123,7 @@ void board_init_f(ulong dummy)
            ret = spl_early_init();
            if (ret)
                    panic("spl_early_init() failed: %d\n", ret);
    +       u32 u = readl(a) & 0x1;
    
            /*
             * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
    @@ -183,6 +185,7 @@ void board_init_f(ulong dummy)
            }
    
            preloader_console_init();
    +       printf("MCU_CTRL_MMR_CFG0_LOCK4_KICK0 is: %s\n", u ? "open" : "locked");
    
            /* Output System Firmware version info */
            k3_sysfw_print_ver();

What I didn't expect was it looks like the R5 SPL is not unlocking the 
MMR partitions at all[0] and relying on the A53 SPL to unlock them later 
on during bootup. Even moving the readl(a) further up could actually 
break boot.

What is odd is moving the ctrl_mmr_unlock() to after the 
spl_early_init() gets the R5 SPL to unlock the MMRs for me[1]
 
    diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
    index b474802ed694..e6400b9d09d4 100644
    --- a/arch/arm/mach-k3/am62px/am62p5_init.c
    +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
    @@ -117,12 +117,14 @@ void board_init_f(ulong dummy)
             */
            store_boot_info_from_rom();
    
    -       ctrl_mmr_unlock();
    
            /* Init DM early */
            ret = spl_early_init();
            if (ret)
                    panic("spl_early_init() failed: %d\n", ret);
    +
    +       ctrl_mmr_unlock();
    +
	    u32 u = readl(a) & 0x1;

The only thing running this early during boot is the TIFS vendor 
firmware and this R5 U-Boot SPL which makes me think this is most likely 
some type of race between TIFS firmware unlocking a firewall or 
something along those lines.

Moving the readl(a) above the ctrl_mmr_unlock()[2] seems to indicate 
nothing is actually locking the regions again so it's probably a timing 
related thing.

    diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
    index e6400b9d09d4..81b2c279bedd 100644
    --- a/arch/arm/mach-k3/am62px/am62p5_init.c
    +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
    @@ -123,10 +123,10 @@ void board_init_f(ulong dummy)
            if (ret)
                    panic("spl_early_init() failed: %d\n", ret);
    
    -       ctrl_mmr_unlock();
    -
            u32 u = readl(addr) & 0x1;
    
    +       ctrl_mmr_unlock();
    +
            /*
             * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
             * MAIN_UART1 modules and continue regardless of the result of pinctrl.

What I haven't determined yet is what is actually blocking us from 
writing to the KICK register and if TIFS firmware is doing anything to 
help us. If they are then we may need to move the ctrl_mmr_unlock() 
until after we know TIFS is ready.

Sorry for not pushing this harder internally

~Bryan

[0] https://paste.sr.ht/~bryanb/546373815c73894943685d1560937b586e4f5eee
[1] https://paste.sr.ht/~bryanb/6cde0b6595ec903b5791fe6a9305050f28e15ba7
[2] https://paste.sr.ht/~bryanb/89f3ae8232bd9644fa6ff107b48d34c3e0c11e9e

