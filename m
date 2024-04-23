Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9850C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 09:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAD5884EA;
	Tue, 23 Apr 2024 11:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="3+CpRW34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84778855E; Tue, 23 Apr 2024 11:14:43 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4362D884E9
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 11:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du7+6wu/S+o3vyzhHtgzpi4RhcC21odopAVCqp9DHBbH0N3Wia9YPgVpI5NWNT0t/vDEZ1A6+vDOWg5Q9HEcckMFUy5VyJWO598q1Tp8NiP9H9TGfTlPN31oQB+20KRr3Q2aI/K7N15JjyHdGqdm7GR/9rgbq82+MRw2IErYtxpVlmug0OMW40ln7RuCsHRhE8YojfAkCiWEfb2ulPJ3Zi+9iLXJ2chC5aXr5B9/VoN+DJP3R1T0EHiwFQxOdoKPMKphY2YsreUBGAi2YmxJRlVNdQWukvl4gfZW3P9woHTOpABxZPt2z8/wu3LkQ7a8c/78Qtcc3SjOlUrSBoD0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eed10AOH+3URXlgEnzcXdKMy0GpVKtW3PdpHJ0qrbXI=;
 b=eB0ZV4eVdHM68UWEmLHcApKY1omiUnDlfbn24UaVzeFwH2pkWZPs11MFE2hdX2w/JHNahNuBAkqx6yGMDjJ6Fxhll8UN/Kn5ltEr8HjXUT4rmR/YjYd6gJVtzgAUXT9QSB7H8XDK5O39jj1jbRPUHj+YfuvJkFXZM+CJ0QPfCdSYjZ7tHVHlpzfKNXtDVcQicVqpghrdG52sEp5ibfmDkrjtBOq/jzgm52Z4ijkavS/ZhCbBYftyk3rtb4cHuJftO76l2YD9qbahpOqOYghiW/TOjmzqGxZEUTaGSXvizHmkK+n78jaxkiCmVc4mSNHkFbp1p2OFabViNPD0WMBFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eed10AOH+3URXlgEnzcXdKMy0GpVKtW3PdpHJ0qrbXI=;
 b=3+CpRW34ZV/Z77QAFETJQTg6W5Xft5jZjE81sa4yWKkGbrDEkZMcjcnHT/N5CyrsE6homF/9GZ/AkR2Ww//6vfzwByS/uDAJgdmZeT7k1VF9bQZrF3S2hTlCNThzqyItwMa2yBqIJHL4u1z+qW2Np3awKh0fU3H6d4aMGRTA7Q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DB4PR08MB8174.eurprd08.prod.outlook.com (2603:10a6:10:382::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:14:39 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:14:39 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: E Shattow <lucent@gmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Green Wan <green.wan@sifive.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Nylon Chen <nylon.chen@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Tom Rini <trini@konsulko.com>,
 Vincent Chen <vincent.chen@sifive.com>, Zong Li <zong.li@sifve.com>
Subject: [PATCH v2 2/3] board: sifive: Call spl_dram_init() for DRAM
 initialization
Date: Tue, 23 Apr 2024 11:14:28 +0200
Message-Id: <20240423091429.178653-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240423091429.178653-1-lukas.funke-oss@weidmueller.com>
References: <20240423091429.178653-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DB4PR08MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: dc237874-6772-411d-679e-08dc6375ccbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pkrMlY3LRtOxP5OI6W/j3cIX1jrqtbhiNvohPOnoXZZ1X9tBcc76mJlyKJdO?=
 =?us-ascii?Q?ya8Ndl3TGFoXP6DH2e+NfFAs0trdbLZWcQK1qYTmEG9d+BuDXGwwTWyz6bXR?=
 =?us-ascii?Q?Ex7mMh6aOzQg48vmpDZe9sv01510mZv33zFAqM9Hqau9PBOxpWfo9NX9QFiL?=
 =?us-ascii?Q?C6wPwT3YXLqleTzI3yRVP7rBYYEByJlGAQpAC4ZzhaP7/BXGhCh2BBB/UNnv?=
 =?us-ascii?Q?dMW3N6jiv1VE5QHdsFIK7neGEvxsIcJjRBf4vEP1uxZ0N1BluAlAyD9RD3Gu?=
 =?us-ascii?Q?U9rPHcfbNrARESYQKMWcdPrdK71aOFEpBaDd3GE4TMLNzo928QHg+ph7uI5b?=
 =?us-ascii?Q?wk2htI+kmCr+3n2H1VmwcA2MOQviSeGF96fvfIaDn2mntClFb+opj/MHcTYX?=
 =?us-ascii?Q?bdgHzBDeUR/f2C+VYPzlriw7UqLYomOvzz2o8WVekT+uG8gou/I0NZJ7AZyY?=
 =?us-ascii?Q?KtO7s/txHkmpY+j/YxNw4zMzZj5XL72xdqSmZB+fCHezhLd4MEaW5B9qCFxo?=
 =?us-ascii?Q?qTEfT1NOJBVQJAX5gpdQce4fRgNgiAO8Tg3sTopk8PCVbpADsvmHhntDsAid?=
 =?us-ascii?Q?6xkya/BtjgagOVCQGpndptWbhfy3pJ8hcZrDFi5QThIwbhdK4uDTvroqp879?=
 =?us-ascii?Q?4eA/7nX13NRanLK2sERF4RNfFJWbghQ0lp3DMim4IGbva7IWwcQ7y7t5G6GI?=
 =?us-ascii?Q?q6DuLGswwdeB5wnPQJXGbU0WguYnlnrRdXz0iNvqCfhgGiyHeab8ZCNwqTnP?=
 =?us-ascii?Q?F2DNvzENS9tvbcOeoJ3TRPznDUa2vD4bVKK3LqoZL/ochsrypiN4FECrC91w?=
 =?us-ascii?Q?sIWTljkDKyqxP7ZiQzOOkBQFFUpTxM40raog2mgWkIKKR7DZ1PjjpBCP9rfZ?=
 =?us-ascii?Q?FJQ8pL1EdFI5M4p+4W2hhl1+o+4UiRpwdNU8KjEIHbeuFqGBuk/fDobdSrXS?=
 =?us-ascii?Q?/zqQCRi7GEky3+qfOO0jbVhqZTttj7tPunwzlZtL02mhnthKvfQfCSaT98ul?=
 =?us-ascii?Q?JIiN/+5bbmw71nov7XWPEv8QwB0Vt93KapOFKk6lCo95Z4QsoY8mm50N3GbU?=
 =?us-ascii?Q?wt81ApjiFncwJ3txbMBGVpkdpwHglG16H1E5cb3oIjnj6ab0PhjhAFmJJtSg?=
 =?us-ascii?Q?55UvK8CDltgS6JjjS2BmckBGk2K7TgyxaYGxK2SnxXGBQV1yGFyNDIcp9DMe?=
 =?us-ascii?Q?jjjMKINxTjJKVzrnMo6cSlqNwAvwkb9BsED60jfKavTAxriUqc5dk6zsjjCF?=
 =?us-ascii?Q?8CYEunlJRhtpnQ+fHjlpM1FmeXWlF1eRqizymwNzRF9HiEvlAIPZKdvx7A4i?=
 =?us-ascii?Q?R+yCYbsD/+m4RanlTpdjBM9D0WSmD/VbvveqVhls2KlHYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5XZvUZS6CjB5ocKEUEf1E1VYnzR5DsrqeH3/M1Hyhvcl3/o+FZ4w7v3997G?=
 =?us-ascii?Q?Gjl1WgMB2DFchpt/H/g0S+3RUcEGUl/bQEfl4JxS3O04leVjDmJZzAjLy+y/?=
 =?us-ascii?Q?UViPhKi9jcc8xX3lQySppugL8tVyEb9+xwDam+aaggWSwNzojYkP9KP04uys?=
 =?us-ascii?Q?deqtAt7n2jQQuGDHFMZft1tw9AjBztJm94dpqR9TpjT32wDoEVdxN7k4F4fo?=
 =?us-ascii?Q?1I5Zf3cG7CA1B/fOLEVUWc7emYHJSOoCH8FqkWKKm6eB4Jzd+LPBrffAEaVM?=
 =?us-ascii?Q?yoRN3X8Q+KHxwiaYjt+jyFV1wiFID1icuFIC9yPFpdfF+vfMgq2Op+BYW3ad?=
 =?us-ascii?Q?o1EQy1XZjsk2SNsAIbdPRW8N+AGC8wr6aOvrZSJEZDySOCsx7nzHNZws862r?=
 =?us-ascii?Q?UYaLkszAdIia5u2Wzq4nUdx9zprzW5dvJ4MBVfxxDUwGMNPPmwHFK+RCLiTA?=
 =?us-ascii?Q?B6f+Sf+A/76GfX9d31DOMBcWARU0hryJ168z/rkZRYgLKUI2hjAsjqT1u9WL?=
 =?us-ascii?Q?Q+V5YJToexkLGNhDaEe4vzIyuIAPfJACDGILPARRs/3rFw4GZfBolI47R9TC?=
 =?us-ascii?Q?L5B4s2aT0UfoJauwTsyeziVXOV5cPqzJUz7h8pOcozh3YileCelvJp+3sl/j?=
 =?us-ascii?Q?jeOy9/ard9/oFtZE5G23/lVh2tEsNH/x1zjsMCWZOTlOIsIrlnhktgUI19Oj?=
 =?us-ascii?Q?AwL5Trii7tLhDqoH0ng2pqlOEm5nn/mp7+qc2rKnVihqeTiC35miQt4UEq3c?=
 =?us-ascii?Q?IYq+CVaVtvCUsAhqWOEH86m//HteeJAbUCicEPtam6h+BvtophmsAn8SS+bW?=
 =?us-ascii?Q?LDVjkBXV1pfZWRCp+uG7beU1hLdpMt/ccw3mQj8zPf3XUI/SvmkGD6z4Umen?=
 =?us-ascii?Q?XAEIlsvaFbDOxtj0UMKt0M4K6h2k+fHCKYgtDtkbrHpVij++FwVe4Os09aF0?=
 =?us-ascii?Q?frnhwiyN9sg2LdfCCTMIYGmJTkvErhZ/V55W9+Dq+6fWsXNVEzlAO+i7RoMk?=
 =?us-ascii?Q?od9vUE3TgW2+nkwWmADc6d/flcuO31/1pC+TYgVBRbD0nb5HfXz/ouLSSkmd?=
 =?us-ascii?Q?TH0lXXtnvE46O63Cm5LfOSY3mVm8BD84zLyhYdll2Fu5ilpIrKbQhQKWAUQc?=
 =?us-ascii?Q?rXJx8TklqYzxSqRt5LfQe+AEkQymIGTg6WVkCLoFkd5ZMRJdIGMCeK0lZ5V2?=
 =?us-ascii?Q?wKjAkRu+OG9jxamn8ZJVifQI4XxAIqkaMXj7tPKTXXYTvOePYj4xICSzsrCq?=
 =?us-ascii?Q?n05xCyQYLM70O93N9M0y3lnMw2oKmr2wZIwXtFIqWPyaZc+2OqEgCKkuxyDb?=
 =?us-ascii?Q?RNJuFBHtio08G46B82i9ZdNeL9J/UqjTh+q7pwczA7kHdqeYhIaDsXyj5nik?=
 =?us-ascii?Q?6KWBqiXXZV2vAGX1gu3mLJJGSqI0dxboVDRFWIO7C91ezBkgp3hP3aLMrkq0?=
 =?us-ascii?Q?tH8yjsrWCM/wJb7WdaV3wuV+Y7o8GmXAWqipWPL2AKAQXtIgAuAki6PDAtGk?=
 =?us-ascii?Q?Orqw3CwUrtBmso6ovA9pyLkhkSOsuNjzdmrMWYIYL9mzOJsMjEJPPcg7E2VV?=
 =?us-ascii?Q?8NVU3ejqZQKVcJgsZTdvj0rGTLbHE4q3cXn8+uK1r+CmLtpIDpXXZs3rEG7W?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc237874-6772-411d-679e-08dc6375ccbd
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:14:37.8084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk6o8PYoW26dYksHAVZRzJwOdVHiwDfx3Bg2wOEfOycscZaYeIHlAfFZR0BrXDZkdgJBRAEeh/IbwZOdFu/Y/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8174
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

Call spl_dram_init() since this is commonly used for DRAM initialization
in u-boot.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 board/sifive/unleashed/spl.c | 4 ++--
 board/sifive/unmatched/spl.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/sifive/unleashed/spl.c b/board/sifive/unleashed/spl.c
index fe27316b2d..9df9c68604 100644
--- a/board/sifive/unleashed/spl.c
+++ b/board/sifive/unleashed/spl.c
@@ -27,9 +27,9 @@ int spl_board_init_f(void)
 {
 	int ret;
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("FU540 SPL init failed: %d\n", ret);
+		debug("FU540 DRAM init failed: %d\n", ret);
 		return ret;
 	}
 
diff --git a/board/sifive/unmatched/spl.c b/board/sifive/unmatched/spl.c
index e69bed9d99..6fc1d80954 100644
--- a/board/sifive/unmatched/spl.c
+++ b/board/sifive/unmatched/spl.c
@@ -134,9 +134,9 @@ int spl_board_init_f(void)
 {
 	int ret;
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("HiFive Unmatched FU740 SPL init failed: %d\n", ret);
+		debug("HiFive Unmatched FU740 DRAM init failed: %d\n", ret);
 		goto end;
 	}
 
-- 
2.30.2

