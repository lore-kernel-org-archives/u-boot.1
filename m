Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21C0C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649ED84BC6;
	Mon, 13 Jul 2026 15:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X1sey/Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C87284BDC; Mon, 13 Jul 2026 15:34:36 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B5884B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npAPCoXIn79RidbdqgodaMrIPwxXs+aYEx0Rzs3D7S625b7aL46Mv6I1d7gEI0URF33XtCzRcNBTtZpPHloeinAjasCWKKym+cQLXRbR/VRQZ1bGNFS3Q/wtSXQB7EjxZoSkmQ0YuIgDLu1yTK5ofkyia9Q9mlffHH3vBm6hm+6lhxCIKZkkN5apX9CNBiZLLNnu6CdgK9h9HHpwuecX3VZoFmLqJoFoTZkSaE0OVjsL+a+pnWhofIhm71SkKWxaS4ObV3PmacpQZHdGhldldfWsuujM/9zwfGwbJEhhAcUNHmUTF7QEq0YnSwo1VAPbYcE2U91K1KLRuArHj88BGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATsRGAQkGG/iwSfmqRArMAzmuGFn0wH8BLpnxNO7/tk=;
 b=KfGRjoF+D3WVDlJgJ06cl0d6Hoba2PYaIhHSh6eHb9hlLFgMiHw2fXeSmVW3UP25F/VZc7Lk7DbCUNEbb8Vb1RI814VNti8rQuseDdg/unqIEK2+kLmK9bSiA41fpdUYfFdRGHCiJafzo6oiDbvNg45nBGp1Vx3FkHJvOhJHzdm9b6NvAYenyCjd2aSMMNbco0RUwv9leOXOxzEujJ3daP43E6Eo/P2BtIUdjuPWg84BJbqUipL2FVzGwgQ/pSyhOn2Wq7hTgKtPoy6nbmS/ypjyBznCbBirvE1xK08MjExq51ys/bJEu+ua9dd+/MJz1sFt51EWTy0SZDJO6EnUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATsRGAQkGG/iwSfmqRArMAzmuGFn0wH8BLpnxNO7/tk=;
 b=X1sey/DgtIYBzh2GcvcGEksjBZZnwHduQrEXQcCXaLcsTfxCScHbS+JW91ZnLlOmwCExSRR7P3F9+N5C4KpaFor4ChbuQ/iAqX54NIxYE5stWWExNDykep9V6LjYWNLb/8O5UIjHqvCqJ0bm2SufQ5XgS/nOfdnOCQetnqcg1Em4dcKeOk5TCE5mNks1fR4MSAlfvBGYfdQUmJVC6zo7awtpoXmoZfelxfBqMHCqAZQ8q0cNgd9hQk7B19HiQjxnosItG5dyHeFelIN3unRx5epI3zXHFXkLwmDi+ILrXLm1WX8DlI7V3fM8Zyg/yIe+t1/TNrrwCY0dwpvzpCyYlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB9011.eurprd04.prod.outlook.com (2603:10a6:20b:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:34:32 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 13:34:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/5] mmc: misc fixes across MMC/SDHCI/RPMB
Date: Mon, 13 Jul 2026 21:32:51 +0800
Message-Id: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPpVGoC/2WNQQ7CIBREr9L8tRg+0ta68h6mi4JfiwnQQG1qG
 u4u1KXLN3kzs0GkYCjCpdog0GKi8S6DOFSgx8E9iZl7ZhBcNLxFwazV7GFWpjXKVshaojpDtqd
 AOd6Xbv2P41u9SM+lXozRxNmHz361YPH+VxdknHXdgHhqlKJaXt06HbW30KeUvoOYMSCuAAAA
X-Change-ID: 20260712-mmc-fix-cc14724541b8
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d96106-4741-4e23-0052-08dee0e378ac
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|19092799006|23010399003|18002099003|6133799003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 9FA6Lp88eJsNhmd3aJIwm6MDhHGmSfEUkEsmGzwQN45vUNNrJYo3NfL21pTvjUAQfLFZHtjATxfXpboa9jFUeAYbEbxxEXmd+gD0oAn3HNYT03d2gk5Ko/s8XTZwXm7IPDLPvKgM0V1v6hPHV2oSnBR9119EADhZii1BZWp8ckv1sypyB6NYam0C8o8IQMhxMvC5EGy4lrqAKDcrcitzH2GbkCkCOgfD4gZB56cjxuS2q15HNU8Hy65ndMTK+ksHhqon2Q9CruVq5sJWNVZep8vZdxLQxbLyt19yHGVSNORZlEFXdT+gjBQtUJ1th9BSVBP7xjNYOYvilvFm6lcc3CFgE8SYqUQCTpw7ugMjcYwpzcz28o4fsvwpZIwJ/CdnjLHK/nncATMYyLI5F99PrHtTpTi2qhHO4OTWoPw1D80BdX/0Qbo3Jkr4YtgSKtwp7QfS9m6gLgWt16JI0P6VSmfxR1ySnpuN2/OCabLjHP6IleFjQIkLPsJkHpzwIDUw/pPvoJxDFPNdyuWX0R0vqgtKOodnWMNZtz5f5ZfWfQdH+l6ocxDJJHeMxr5P5X7za9Q05Y/qoNGxuRv7SbTdnjXXGypdr44eqvPOqVt5QP38jvcproSNXsclmw7RIU6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(23010399003)(18002099003)(6133799003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZoL0lQVzRWV3JjREF5cUQxYTlwNmpxUE1TOVRRcWxGTGpKWlJ2SUhzd2E1?=
 =?utf-8?B?bzEwb00rc3RMbit2TkNRclpISno1SGFVWmp0dW53WHBUK20xNXgzV2taZWNT?=
 =?utf-8?B?SEhOUXA3Q2ZzNkdJRC9pUXRyMDN0eExjWGNWdFJ3NjJaeVNIZHBGYXJUcENi?=
 =?utf-8?B?Y2s1NzZQbER3ZUl5QkFWVjVWSFhSVnZURmJFUnZndXBZRVJhV2MvWC9ucSsw?=
 =?utf-8?B?L0Zab2lFbllRRUpZVjNvU0wxVGV2b1ZiRU5vcmpwOEt3TzZjS0Q1a29MT3lE?=
 =?utf-8?B?NVVGTzdjYWthemE5SHNGdlRVR2N1UUtBeW5kd3dHMXlGVE9SZEVSaU9rMGlV?=
 =?utf-8?B?TmZOWWZ1Kzl2bTE4anVkY0dBQXhvMVRXZXNpUkhNZWdMeVh4MW9WWSs3aHdt?=
 =?utf-8?B?VjNzaWxESjlESmJSeVhpVmtGV0Vmb3lDengwcUNocDQyZkNTUytZWWZYMHo1?=
 =?utf-8?B?OEtmQVU2TWRwN2tscXF1aTVHaWJGQzVPdlhSU3FmaG9ua1BPR2FQMXlPOUhT?=
 =?utf-8?B?MEZHeWpPSzJvVG9NZUFBZi9jcjZNejlreG5Tb2NMZUJQQjNwN2R5Y0dTTWNO?=
 =?utf-8?B?SWRrcE9adTAzd0ZDQkJJV0xyM3dqSWdrczQ4SFJveFJCMmk3VTZOOE1qaDJS?=
 =?utf-8?B?RWpFZGVBeDhFTWRZTjJwNzZaOVlZcTd6ajZKNklDWklsVWh0SVEyc250L2VL?=
 =?utf-8?B?WGhDTzB3TFZGNENrVUFsZENsNjQ3TUpmckczSDUvOWJORi9LbFJuUlh6U2o5?=
 =?utf-8?B?NnhqL2NJQjIrWTlXMjUzSVdFQWFucXl0U1FlWXVJNDVlQkxONHp3NWxGSWdQ?=
 =?utf-8?B?SmFMcFBENVZRNUYrZm91bU5Ubk90bnZodEtUck5pQlJFWGt6SVVIWW1LNDhC?=
 =?utf-8?B?VU1LUGhqVEpZSkZiY3IvYUUzMCtzTnc2VkpYWlc2alBUMUhUNU9xMUtETEpn?=
 =?utf-8?B?cjVnZ2RFa0RQMXB3RS9IajFTTUl3WVQ0bVBkcGRNNkR2OVB3TExKTi9zUEpQ?=
 =?utf-8?B?QWFLRkZxdFUyRFNLVjZZRkpWUzlXcXdSNUhaMlBFNFRlek40Rmhnc2hYQkFu?=
 =?utf-8?B?ZlBDckFlbEQySEVFY3BObFNrMy9TUER6Wk1mOHllSHZ0UHhTN0EvaFl2Y0ps?=
 =?utf-8?B?T29ReFRRNUpsRXNuSk5sUk94RlozSmh1RDlhZDhrdlJCUk1QWnZkeEN5QWk4?=
 =?utf-8?B?YjlGUVpEVFJuVHRYQXVXM1o4SkJxYThEWVNjU0c0Sko3Qklna25NblBNQVlW?=
 =?utf-8?B?cmsxMUYvWmtTVVdwbklNQTB4MGp2SmI2YytLN2VXdXhpMkVKZ1RvbWk3YlMr?=
 =?utf-8?B?UGpxNjE1VEZIVXFUMVlTSDFvRHpDZWc2alpLbUtZMHZvdnlCT1N6TXBHb2Ni?=
 =?utf-8?B?dHk0RldCckM4ejV5QjhMaEV4eFBwZ1duYzR2UWlGYU9sdUhNMDhHeGxoYi9s?=
 =?utf-8?B?UHVEUnFkMkZYTG9zVGx2VElXTitqU3FKNk9MSmxTWGVqWnFOQ0lyeHMxdEpa?=
 =?utf-8?B?RnZ4aXdhS1FXT0ZIWkZ4NEMwSmZGbU85RUFPOVN5bnQwTlpKcGNEaUlmbSsv?=
 =?utf-8?B?NzBEOWFCTzR6RWsvb3AzQmNmYkhBamUyWndpdXc3c2VHWFdiT3NZRjRrMlcr?=
 =?utf-8?B?dzJDTVU3SW40eWpoSjJLekd2MFo2Sk1Dazl1b2xrMzRKeWlOdkhZbzdKVXUz?=
 =?utf-8?B?dk5OWkJYVDFKMDNFQXljeklDanRFNEh3ZzFGOFBCZzJhdU5DTDAyaW9qUHNE?=
 =?utf-8?B?NnBRQWtycWx5Y1BsOEZDSUVtQVhRM3h6ZTQyN3UvMWlEWlVFYUNoZ24yNkwy?=
 =?utf-8?B?WDlTMmZvS0hiUzlXMXhYUGJEUVp5SG5OREZPeTVPemE1dXpmZmRJZ1ZYcXFm?=
 =?utf-8?B?TmZZRWVEY1NScWJSemxXU0FjRG9GSElxWWtPNmc0ZFVSbE1Vd2UzbFV1LzJG?=
 =?utf-8?B?VnRHREFkblFJQkVQYUpza0tkdWM2NG12cDQ2QTI1cEpPYWViYkxUYTFISnUz?=
 =?utf-8?B?ZU1kWDZHM0lpNUkzWmRPcHhwd0llSGwwRHlqYTZIbVlyd0tzajhPZ1FTUldI?=
 =?utf-8?B?Wk1Ic3lnZ0J4OTFKcUxCL1JmM2huaGJUN2RZUDJiTXdiVWltdko2c0ZJeXcw?=
 =?utf-8?B?UUI5dUp3dXZWMXZDTTFvMy9pdm9lOWNGVjl3eTYvVUtPTjBHTXl0YWk5ZXgw?=
 =?utf-8?B?ckxvSjEyeklaclB3eHBnTEpxbndMOHE3ZjhsU1hxbXFDaXp2KzVTTHlkYjBZ?=
 =?utf-8?B?SDVIN2dRSTFJNlloZk1RS00xV20yWGVSaUlIYlU2NGkwL1NHaEE2Vlo2dE5L?=
 =?utf-8?B?Y3QxaWtGSkFDUTBQdElVUHlaQ1pZZkZIclFvc20remhpZm9aTEt2dXJHazRs?=
 =?utf-8?Q?ZtDKClrqGq+f2gjZR3nytkwE02Ik0AEpLxC+Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d96106-4741-4e23-0052-08dee0e378ac
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:34:32.2834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dFLolyXJH7qi+cq0dKCww6x9aYzMMSyZHvuubfEUEtbhyofCNI7ilhKDkbsJHgFAA3E4RhQXJSC1xaV7mOzdNP8vtuupQUJd3P4DtL0gMWf5i2Xj3BcJ+CXiIKHxq5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9011
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

Patches 1-4 are straightforward single-site fixes found through code
review. Patch 5 fixes a regression introduced by commit 906ee6785b1
("mmc: sd: Handle UHS-I voltage signaling without power cycle").

 1. mmc_poll_for_busy() can return a false -ETIMEDOUT if the card
    becomes ready on the exact iteration where the timeout counter
    reaches zero. Fix by returning 0 directly on card-ready.

 2. rpmb_route_frames() has a tautological condition "req_cnt != 1 ||
    !req_cnt" in the RPMB_REQ_READ_DATA case. The second operand is
    dead code. Based on the pattern of the other cases, this should
    be "req_cnt != 1 || !rsp_cnt" to validate the response count.

 3. sdhci_init() allocates a 512KB aligned bounce buffer on every
    call without checking if one was already allocated, leaking
    memory on re-initialization in the non-DM code path.

 4. mmc_bwrite() uses mmc->cfg->b_max directly instead of calling
    mmc_get_b_max(), which the read path (mmc_bread) uses. This
    means host drivers that implement get_b_max() for DMA boundary
    constraints have those constraints ignored for writes.

 5. mmc_deinit() strips all UHS capabilities before calling
    sd_select_mode_and_width(). After commit 906ee6785b1, that
    function detects cards already at 1.8V and enables UHS mode
    selection, but no UHS modes remain in the filtered caps. The
    non-UHS fallbacks (SD_HS, Legacy) require 3.3V which the card
    cannot revert to without a power cycle. Fix by preserving
    UHS_SDR12 as the minimum fallback when the card is at 1.8V.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add R-b for patch 3
- Update commit message and Simplify code logic for patch 5
- Link to v1: https://patch.msgid.link/20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com

---
Peng Fan (5):
      mmc: fix mmc_poll_for_busy() false timeout when card is ready
      mmc: rpmb: fix tautological condition in RPMB_REQ_READ_DATA validation
      mmc: sdhci: fix align_buffer memory leak on re-initialization
      mmc: fix mmc_bwrite() ignoring host get_b_max() callback
      mmc: fix mmc_deinit regression when card is at 1.8V signaling

 drivers/mmc/mmc.c         | 29 +++++++++++++++++------------
 drivers/mmc/mmc_private.h |  4 ++++
 drivers/mmc/mmc_write.c   |  6 ++++--
 drivers/mmc/rpmb.c        |  2 +-
 drivers/mmc/sdhci.c       |  3 ++-
 5 files changed, 28 insertions(+), 16 deletions(-)
---
base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
change-id: 20260712-mmc-fix-cc14724541b8

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

