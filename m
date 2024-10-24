Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F3ED0BB66
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAD089319;
	Thu, 24 Oct 2024 09:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="kcfrOse7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064B689335; Thu, 24 Oct 2024 09:04:21 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4BD688E2B
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uadATKBTWLE8N/fziXoqspx7+xCV6CTnzgSg/us3IHQpz46h/e9ZZbdv/o5qqZRztYiDoc3MmzoQNCLEtnJGjXfo3VkjgVkZhxl9pTysa55vkp4Atbb+1mgSkz7WkJJK7FY5q6iAFZPMXszah3N5ibqtET/cBJvhzxLCvwvsjBw7VpUMQ9tgNvAPx6t3MxOIKiZqKrQglzjlTth4/MZlnpVmC5tI56lIDM467QVgmL9JSSOzcH60Fv7LRY9p28jciT+SNjkJbo7Qkq9DMmNSPnwPAAi9ZF2rVQllTXdUh8ZVJq1FpFZErTlxnewndd4isOfEcVN9Td/bo6t1n9nmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP5E/vzjkcI+1GBKPH11ZW6PHKJSj+SvMuGdIbsXsMU=;
 b=mdoKCDlJkS+11SnUBTfCeFZZnh4TfnuJURzIRXGMDZpkjwrIlRHPSi92/Kv1V6fkJ+MbXMn81PVfzbFHYnfCGdJc9bgsu7CbUo8tjwdyEg5fuxYqp8/H3e4nKKIIu7TTMtt3AWoqOeM78TY/tWWyeqVxVCssI6zsziNAbGoIBfKWwTGSO0ixZA1PcH7f7Z9j1PM8+G5e89uD8b+iSoaL5jtWc5fiCWPJQ132Gn9V/DpQBgBr3OArf8Wkg95mKpO4Vx463riHQgLQWWRDqx/UqAlCNas+kMO5AZB7ColJPOQW6JUYhBXQGfPErI6sKajMk14F3L0djH6o9xbETnqgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP5E/vzjkcI+1GBKPH11ZW6PHKJSj+SvMuGdIbsXsMU=;
 b=kcfrOse7EUO8eMHc+gCdf5BdH20jxcHFUQIK2xdNW3OWHGFh0v84vLAXb/3YJolhmAsnMRyaehX3FBrdqARjicBCv+rWKuxPFD5THMxbR0iSTm2yky3kTZ2K+n1flguRpoxYqaP6Q+udZ8mmYT659XNUfX05hf81Ls01tUx+weg=
Received: from AS9PR05CA0334.eurprd05.prod.outlook.com (2603:10a6:20b:490::14)
 by VI0P195MB2572.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:237::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 07:04:10 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::66) by AS9PR05CA0334.outlook.office365.com
 (2603:10a6:20b:490::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 07:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:04:10 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
Received: from lws-moog.phytec.de (172.25.32.62) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH RFC 0/6] imx8(m): add optee node to binman FIT image
Date: Thu, 24 Oct 2024 09:03:34 +0200
Message-ID: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEbxGWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNj3YKMypLU5PjM3AqL3Pj8gpLUVF0LM3OT1DQDQ6NEYzMloMaCotS
 0zAqwodFKQW7OSrG1tQCmrXACaQAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "Simon
 Glass" <sjg@chromium.org>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.62]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|VI0P195MB2572:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb1d6db-2f9b-4458-1994-08dcf3fa0f88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnRNKy92MjU5NWJPa1VKd2Z1WnNuS0gzK2JXZ2FNc0t1Qmc2YUdsT0VxQnFM?=
 =?utf-8?B?eHR0Vnh1QXViaWc1Ty8zVXNsbnVUWU43ZXVNWGVndTVlWVBUeUVyazN4NDBS?=
 =?utf-8?B?TnVEQ0c3bmhMUGIzOE1pRENSVkVQZURJM3hwUXdxaStzQ05TMW84TDhwOU1Y?=
 =?utf-8?B?aDJybWg5dGhSSjB3aEJISHVrNzNKL21VY1hPUVVTOG1KbXdsdXlGRG1EWElt?=
 =?utf-8?B?bXgydVFDWDNWekZ0L0tqN0thS2FtYnBNSzFuOEdxeXpmUk1NMHB4T3BYVC9o?=
 =?utf-8?B?RnpFb2JNeEJRb3RnNDFrbGlZZzhvUnVnWDlHTm5qWVl4bzEzUjI3WE9QdnFl?=
 =?utf-8?B?enRrMHRESGZzcGF6cHVKUWdqMGl1b2IrLytvRVNsdWJwZ2phRFp6c1RvM3JR?=
 =?utf-8?B?LzBkM1hxWnJNMWxJOWtOQzdoS2dFalB6QVlrZVJuUXNZNzlzWXRTeW1scktj?=
 =?utf-8?B?WmN4cDVVU1dxL1B1SjhyK0dLUC9IdmJyMytMZktsalJ2eFovOCtsc1hGYStZ?=
 =?utf-8?B?SjZHN01Jb0oyM0s1YjY3Y2ZnZWVaa2FZck1KT05id29XbUJicWhCeWdRVUpm?=
 =?utf-8?B?SmR0NUdka0pxdjJCK0Y3elZpVDFzdTY2aWREcHN3UHFVUXoyc2FmQWh4MzVQ?=
 =?utf-8?B?WlpyQXRxQm15SGJzUW12M0NqeWRpakNkQkU0emI4ankvUy9vS3MwSFRGZ0J6?=
 =?utf-8?B?Wjdyek0zN1YyUUJqSzAwSFByWUV1V1g1YXEra3ZFREw5RzZqV1gyek9JbThF?=
 =?utf-8?B?RkxQd0xEK3JoSGxqaTU3MUVkVi9vTElZQWlRcElqRlptb2Q5bmo4OXErNlFj?=
 =?utf-8?B?bE9GWEFRd2E2WUppNFlPdEtXUHkvSjc1VTREYWpkcThhZHBhQklCYWRydWN1?=
 =?utf-8?B?ZWpLbG5zaXpFTGNMVGw3M0VyTVEyeUJyQzF6NEtZRUxxNnplYU9ZN09EdDdx?=
 =?utf-8?B?THFZTDVhdVNOdDRvYWg3ZHUvSStXU1Q1WkViK1M2bVkrSEZrN3BaNmJodW9F?=
 =?utf-8?B?cEZSam41ckVFUU54bW5jUC9vKzdteFB0WWdlT0o4RnFwSjk4Y2NJbnBCWjlZ?=
 =?utf-8?B?OS94dW84Nm80RlBGeVlNQUUvamdTTklzM01VdlpXVUJtbmJiTkRGeFNUMUhB?=
 =?utf-8?B?T0dSenp0NCtTN0N5ci9LbW9qdEVLTTNCZVcrbEJnWW9vTnB4VEJrelNIaWdP?=
 =?utf-8?B?UUtwa3Q4cjF6UEFWU3lqanc1SHhGR2NlcnR0Lzl0Y1F4Q0U3bTJGWXZJUGZC?=
 =?utf-8?B?S3BWalFsaGdXS3FyS2M2ckxYTGIrUzYzK1Y1Nm4xUHAvTFVmTU1HM0xFQVIw?=
 =?utf-8?B?aXA5ZENNaUIxL3NXaDJmWERiNkRIQkNLQXJWTVdneGZITThhbDhlbkJJTHJv?=
 =?utf-8?B?MHAxNUZtM2tPK2wvVHJJZWIrNUtwMG9Kb2tDRUU5RzBKUXZmTUQ2NktqOWxm?=
 =?utf-8?B?NkpMRVNXeCtKclBMNE5UVUVHcXJjVXI4ZzdwRUNIMXcvS2d5V0FKaUlOZTZ1?=
 =?utf-8?B?Z2FCaVVGRWViaFJoWWVIOEhzVnhsQXM3SWdmUHM4TGtrWWluOXZNS280Qkph?=
 =?utf-8?B?N3NtV2pabmg0MUE1NTJuTWs4M01ZdnVieVJVT3VVckZUd3F3WXRqYkRMWkhI?=
 =?utf-8?B?NGRxd0lxZEkrZmdlMWJhNmtuYkxub3IyaEhJR3lyWFJtb0lQY3V5RVcyTWdP?=
 =?utf-8?B?RmRIRGFJcXgyUVB0dFdiblFSbjZGU3hIZnpLOEZSdFNDa3BhSDg3WTEyc2Fj?=
 =?utf-8?B?RTZIRURUWHJqYVNxV3NWUzdUWDRJUitDZmIwYzFoSXgvZHVpWjRuMXFINUpZ?=
 =?utf-8?Q?fEH4dlzu1NDbw/HSv/oRw7iKHS1743Ru1m2c8=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:04:10.7406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb1d6db-2f9b-4458-1994-08dcf3fa0f88
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2572
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

There have been attempts to get op-tee node integrated upstream in the
past [1][2]. The challenge is on how to handle the load and entry
addresses where the op-tee image should be loaded to.
Different SoC families and architectures have different RAM base
addresses. Further the final addresses can vary from board to board
(e.g. depending on populated RAM size).
As a result, I propose to solve the issue via device tree where the
optee node itself is defined the same as in previous solutions.
The difference in this approach is to omit the 'load' and 'entry'
properties from the node definition in the <soc>-u-boot.dtsi.
These must be defined in the <board>-u-boot.dtsi.

This solution avoids the route via kconfig while still allowing each
board to individually define the op-tee load address.
This is possible as tee-os node has the 'optional' property.
There is no need to keep parts in #ifdefs when no optee integration is
desired or possible

I included usage for PHYTEC boards for examples (with documentation).

There is one caveat however:
The series in its current form would break all other imx8m{m,n,p}
boards. This is due to the fact that they do not define entry and load
addr for the tee entry.
During runtime, spl_load_simple_fit fails for the OP-TEE node (no load
addr).

[...]
Can't load tee: No load address and no buffer
spl_load_simple_fit: can't load image loadables index 1 (ret = -105)
mmc_load_image_raw_sector: mmc block read error
SPL: failed to boot from all boot devices

[3] suggests (Any absent entries are dropped immediately) that
using this proposed solution should work and is allowed. However [4] on
the other hand clearly states that the entry does not get removed (which
is the case), rather its data set to 0.

To me the question now is on how to move forward.
- Is my proposed solution undesired in the sense that I try to use a
  mechanism that current U-Boot/binman is not designed for?
- Should load_simple_fit check and discard optional entries right away
  before doing any other processing?
- Should binman be changed so that optional entries do in fact get
  removed instead of being zeroed?

I am asking for help regarding the questions above since that is not my
area of expertise.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.3921891-1-tharvey@gateworks.com/
[2] https://patchwork.ozlabs.org/project/uboot/patch/ZeHDVr-Bzm935-5N@mecka.net/
[3] https://docs.u-boot.org/en/latest/develop/package/binman.html#optional-entries
[4] https://docs.u-boot.org/en/latest/develop/package/binman.html#image-description-format
see optional: description in [4]

---
Yannic Moog (6):
      arm: dts: imx8m: add fit optee node
      arm: dts: imx8mp-phyboard-pollux: add optee load address
      arm: dts: imx8mm-phygate-tauri-l: add optee load address
      arm: dts: imx8mm-phyboard-polis: add optee load address
      doc: phytec: imx8mp: add OP-TEE documentation
      doc: phytec: imx8mm: add OP-TEE integration instructions

 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi |  5 +++++
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi    |  5 +++++
 arch/arm/dts/imx8mm-u-boot.dtsi                    | 15 ++++++++++++-
 arch/arm/dts/imx8mn-u-boot.dtsi                    | 15 ++++++++++++-
 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi |  5 +++++
 arch/arm/dts/imx8mp-u-boot.dtsi                    | 15 ++++++++++++-
 doc/board/phytec/imx8mm-phygate-tauri-l.rst        | 26 +++++++++++++++++++++-
 doc/board/phytec/phycore-imx8mm.rst                | 25 ++++++++++++++++++++-
 doc/board/phytec/phycore-imx8mp.rst                | 26 +++++++++++++++++++++-
 9 files changed, 131 insertions(+), 6 deletions(-)
---
base-commit: fd3f2e3f0edc1f87be4c5a39a0c81037d551c069
change-id: 20240903-phytec_imx8m_optee-8674ef012a36

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

