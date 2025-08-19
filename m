Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DBDCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA380802C1;
	Tue, 19 Aug 2025 06:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bP2u9a1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665AD80422; Tue, 19 Aug 2025 06:16:14 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF018006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llrrMo2quH7DYQ/I1oQ5Lu6FpdThqPCUdR+kBVhp51332/5/u94yGK3e8HyzrgRHdhNJypu9qfXzbFCFA09cNTmGKx/V4ynKRzZ1vn3C6f/qWksAStx70nDHy4hP6/AKObxFUbbVF669G8CDNGIfUi02hCDWlD+JFHnXRYTHL7bte4VxgduQ54REkSBwpi6S1hYFKHAIrDiGtZw3JVbGefW/oPBroV4RaO3IBRAti5YitmxYCYu8sjgoPfAk8LZ1kjENqK8sLMAblzDcD2daQN2wk5OYjPhU8DEb4Me3Jq79rpRBF5JSDKTfxuvPcxPa3eQDgHulEuxTU8LAz+6JJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3wv3vfVRBgOW/Lsdp5qxAR6o7C3cvMh5SdDZEciLac=;
 b=aLAsS/qMiAImpmyuHaFWxg1jtFfs6hma3Isnb3kx9dMIWII5QFBZjcxaKcv3LcfafmLIUxKYhfb3AxaqQ8O6R2c/ubX1m4uq1UieWVMC70iAw8qsWejtgIm15diOaRLfwKN41+V9gg9JDaqiFQfwawG2VTYPQhkfltrreKTQ9Mac4D/X4XWnmkmcCa6WoP06dv1RRw2+lb70yroGenccM35UWjU8AiiogIcbU4p2/JVp08HzbcLXUMsKsX7lRCofZmGKJq3BQRmft47mYirmRfAXvBoxYToj36CEx+AT73Dyyq7xyaX401gE0urC5gvvAiYiIxDG3OWnMpkkqirarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3wv3vfVRBgOW/Lsdp5qxAR6o7C3cvMh5SdDZEciLac=;
 b=bP2u9a1lCXZT3WE12VgdwW6j0tcWMJZckw0Aom0R79jrOUtPd2epi/ws3HbnNqrbf2HDW03P/XC3PPQjb0ER6F0TcREGPYHNhZRTEavpxnyw6EfpzYEQVrd2DAVc87NFUQX0pAZ+5f2IIToogLi7HtjuFZdwHLhXw8R/A2C7b7VNakIsdwdG+6yG1MH96muyUwDGC74DrL+F17IUjBNWaz5UAAYrQY3B1EPteiBUt7cv8lNjTatiqLkTMMRJ2oJqSPVhV40qO1w5wPe5rp1IR7eaMYzw0/nrYU5trm2HHHbfVInKfRz6O9e6BgkaB71whws+ZsQrknKwg0LfPN+qSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by MW4PR03MB6948.namprd03.prod.outlook.com (2603:10b6:303:1bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:16:09 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:16:09 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] arm: dts: socfpga: Enable driver model for watchdog timer
Date: Mon, 18 Aug 2025 21:16:04 -0700
Message-Id: <20250819041604.22221-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|MW4PR03MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed3bc8f-48fc-4a14-455e-08ddded71fd2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U96tjLgZNv9M5WNuCZDqPJHfpkZdsnheUrmOw4dhT8WASYrbIn4KrD9bfxt7?=
 =?us-ascii?Q?e2PJ5AGmGCEK1/kT8OStyNAVn4oa7TixpBwY88bBRB8OA7QgkcAmH1YdYfAl?=
 =?us-ascii?Q?u8SIaYbxYZUwlSLtDKgtI3LiLK92D8petu05pINbB+uB5bXu9AlHdcC1IrDf?=
 =?us-ascii?Q?hMXqavXDDgyhnEwD4olWjh/M3+WTB9AA7TZ9I4Up8gqNgKF4ZETkc7AeZquN?=
 =?us-ascii?Q?l9eMbkta0ODUPBmJhPGx7xrri1bOi6LQ6XJoMvWMKfHl8gihjG7k7cJEEw/s?=
 =?us-ascii?Q?FTGlvnhD/o3L1JrC71sNSCJkaN4NO2D0hApGytw1QZalE9Ug2UCZYTfKFzXU?=
 =?us-ascii?Q?NmgTi97mnJdCgeGrCHBZF/ylv9F5guc1FzQvS4EI5t8qY5XEHAZVlXaGFBdH?=
 =?us-ascii?Q?3FVjjlJk0OGjmmTHgqDbDLrElz/RXduzMFm8DABMM4k4ii83bUiBLLunSu+X?=
 =?us-ascii?Q?mck+d8byRT8sPZQhoRJ00IqTI9DQGDvTXwuA9Zn/vagaemchZsP5zKFYUFAX?=
 =?us-ascii?Q?sHq2/EDmVunSituyZCUqwrHCgJvaFV14imnfVyyYURv/OAjoLhjgqa4PyMR9?=
 =?us-ascii?Q?InOudIFuD9OdDNR1wtuM3L9a8tYUNhLYLXFahRkpr3QnTXxNYk9DCPMh8l8/?=
 =?us-ascii?Q?fvX+WfkyFIiL/ieNl6/fphNx7EY33r5bEIrP7Di4H/ION9YrGbdsIi9sst3x?=
 =?us-ascii?Q?JalxIp89JfXwTk/KLSVqlGZXyQzHwfGW2UBYYMJize2MPX4ajlwyabsiXHfg?=
 =?us-ascii?Q?AdLktE/SKJ45vRuLLEjkYY62BXmopMBWRsjynUVsW3kxc1+l03O1dIAFkd1n?=
 =?us-ascii?Q?A5iBYr1jrtXlPKbNaJygc5yHPoIv/Ule2ESXXJYI+il9t/gpdUUEZ9H7RKZT?=
 =?us-ascii?Q?eJSLsSq0eKYn2WCD/IQx5gAcqShopwumVxlsFTfIt/OBXxaZkJ3LQwQMKCtV?=
 =?us-ascii?Q?z9rO94fOim5DkHBYed8ar61tILAW7zp2tBLCD8rtBoS6c7ZvROZ/7OnP35SV?=
 =?us-ascii?Q?7UmSIziwWYiTjrRv5VNHwFUBdEvfAwIgpiCI5TXfBzWwjxT9VE57G/hVZj4o?=
 =?us-ascii?Q?uU3zOV+/hpjdH1BKqTeNbpZC6o1XbaVr9i7UApIrJmUFp40uhXVoRvfeye+4?=
 =?us-ascii?Q?GIIvduQyjMAIWo2RPyrHHqynIVV9d6fBCQcJlMVdvC4Bykxa5FfskreeSvC9?=
 =?us-ascii?Q?hC63VsKk+r/fmhSqOmSmb79O40rY+S8rIwwXKWqPNRm2bFqyFW9oWdtg0DLO?=
 =?us-ascii?Q?aQPbECIREDSelftnsioihfuMvrqDBptBh1m1abL6EbAFHUXgzmVam6ACNa+V?=
 =?us-ascii?Q?/SZdNJgGRHPThYFYYKItXsI0mrSSYUv5q8BtsIR7LRFa3fH6BBuXBdYyb1j0?=
 =?us-ascii?Q?P2ihtqzZhQak7DtNkvLVIMBjlS500qm/VwVUjwNPjkjBH1chhadQackZ3iJt?=
 =?us-ascii?Q?jreEmrFXG7w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LRromrfDT+2/bPoP+dX20X2/LrxAd+1KLaZSt+KvlFSLYhwrtuhNAKOpWmIA?=
 =?us-ascii?Q?BEfgkUPhR7S204Ee8TvdoUThgaBDJluWlQyzsT8A/+HUDlD26kwJDRHs+dgp?=
 =?us-ascii?Q?gszSesmEaRgbVPXdeMKpQT1lbhzY+KCBoZ1GFAJDYW2gDvsUpa1COh6kbnbP?=
 =?us-ascii?Q?9D+lyLTd4KEt+WDrJHJHoRz0mYf/TzBGOStopftr3JaZJSVpNLxJNplK+KW2?=
 =?us-ascii?Q?TazhYaMZ//oKm6+iDEL/vjp1EPWgPGWCnoq3jxK6nXq7f58sa15LIsQ2Q8wK?=
 =?us-ascii?Q?a5/EKi9C9TYMDlwOnCVVD/LUC5GtKM1rWq99F648nY27iCoXjVa4pFp4wvks?=
 =?us-ascii?Q?RkdZNxCJIR6G3XcjGoR+oz660r5x6h0LkoUnUtxZq2E48Cqr5/0d7vcPo+Cd?=
 =?us-ascii?Q?I8g9UrR3SddCzCtBDfbewRSIPQZYi2Vj/bkC+RdPKygWESRCIhVhNOMcHGqh?=
 =?us-ascii?Q?y1cRT1E3Ee3ZSY1LdkGzRdIKFOQgKBptayJVx1vKixeH6q5JfIWmUr4yQjGI?=
 =?us-ascii?Q?uISZ/JlW4T9NdVofb8/wrpVzAbImPfoyyxC87JyqJ9bFu5PO4zUCzqkbDm3W?=
 =?us-ascii?Q?ARHGdWIEBJkZ1RJ24/NESYEyTBB5OcJUBhtE9lMMhyG25GC52YAkFeict6XG?=
 =?us-ascii?Q?93LZ5E7pYkTZlL6Z7o0f2HcMe9REuMN5VTqebwllhFkvJQibbdc6g1zDd/kj?=
 =?us-ascii?Q?/P6iIMw1J6ENn258IDwQWGz/D1ZgFDF/hQktu3Eihfruq+8psRdri+ReKktB?=
 =?us-ascii?Q?0/XgkZpHgG8LZNgY6Lz7OfoeBA8qwU6h/2lkxIhvHHO4FBMfHiLIntqNEaxu?=
 =?us-ascii?Q?V5HVDorq+piOXRF88t4aRMywPk+lj2mVkMCf2ixw5uGoXXrT1dVBfYddbd0w?=
 =?us-ascii?Q?tUoh9miZeWOjJfghqEs5PvQ7Zt2pCajBsNc1w5oAdr5yKipJcSlmWjAFFMaL?=
 =?us-ascii?Q?N7XHjM601zuQ2FIdR8yGQFljXxipaWRwcNzw8C7NbtR8ZeaCdCuZzxiDV+Y1?=
 =?us-ascii?Q?n0UoOTi7pZSbNHVvC7wlpTVLr9wcRTODnWEbjkntlleRMZWQywpfHe2OtJCl?=
 =?us-ascii?Q?fkxQC5ErDkXqyN5tLc8uUsOa6rBKhprukpcbuV4qED2lHPNLHZSlqvWWkcn3?=
 =?us-ascii?Q?VPp93bpMKdd7HjmuwYCUFhHGvauO0ayxOMDDmHTnsxHZask8peZEK7uarG8b?=
 =?us-ascii?Q?PbJ6QitK98ipsbZBECeCZtP1kp5BYqPl/07uGD/LLVKBYAg29vTWRaPHG593?=
 =?us-ascii?Q?uL2M/i400kHdG7lqZogIbU3lbP3vhdWgJPIdQXoyhbw9IosgtuJIAKGccbTv?=
 =?us-ascii?Q?tedcrUwtFIqNSOMSRdf6Yn8EWDocC/iPbpWlwgCrPAzG9EqofhdA05L36f09?=
 =?us-ascii?Q?WKlK/n1jWhtUD5Bz611LpgLNxs/5IYU+vRTD8KbQuscDrphRMP+BNdTnGVrk?=
 =?us-ascii?Q?USiY7qjNfnojxIbVbqC/UtqpHCQkX2wywcJzG9w6Dag+NOitTwC/YdciaZrF?=
 =?us-ascii?Q?lA8rMdWHhsW6TTcFUfgSHQOPYlu8UsGBG5Flm+t7iFQKWIsXJFCKH1Nv3v79?=
 =?us-ascii?Q?+7MufYtKq01PivzUWgJ2bIYDWChv3fBt4yO2f06HHrdCrPpOhT2UswSpzYzt?=
 =?us-ascii?Q?s7azcUkXVuErN0RnGAEjnCA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed3bc8f-48fc-4a14-455e-08ddded71fd2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:16:09.1767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsQPVMxzmqyqT9beXsLRiHTxWniAqHguMyMRklmLKPgYjotF4QxZrlfH7VZb7kcZeUhXUcADod+0kri/Wdy2MkKETHWn+taeQloVaf8YiHKvUUFFDWKAF4pIOP9+TDTL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6948
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

All SoCFPGA platforms are switching to CONFIG_WDT (driver
model for watchdog timer drivers) from CONFIG_HW_WATCHDOG. Status
of watchdog is enabled to assist with this switching.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_stratix10_socdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/socfpga_stratix10_socdk.dts b/arch/arm/dts/socfpga_stratix10_socdk.dts
index e6d8fe6a907..864f4093ef8 100644
--- a/arch/arm/dts/socfpga_stratix10_socdk.dts
+++ b/arch/arm/dts/socfpga_stratix10_socdk.dts
@@ -137,3 +137,7 @@
 &usb0 {
 	status = "okay";
 };
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.35.3

