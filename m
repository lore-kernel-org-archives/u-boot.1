Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0B6E9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 08:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3F583C19;
	Thu, 19 Feb 2026 09:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PlTAUE2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27ACE83AA9; Thu, 19 Feb 2026 09:38:21 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C67183CD3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjaLB6bBqa60yHAvHOBsxua2R40flUMX936PI7J8n9lg5R+oWlUCzF/oXzH6tMwxtzU3k2ZHCzPbQwM51s4JuwBpdt96hjcnmwWIzpUywEyafkk6+XU4m/xCNJqXyshDqOLGkm+KoJiU3a0xpykNoa+1EgDUpizXICZwXa8L8L40DTpiy5EtougL6QDdRPSv8LNx+z52VZZDiBsINFoIyt5ZiIwyFZS75fqowqnR8nyqvrDbQxbk1eHgy2QTZxYgfnH+sC9Xt75hcKEHScx9Je1JFMXiNfFs/LNEr+Zz5yi9Erw1gLIFz5GEBhMj67ZOUggsQBpVEtxK4bxE7L4cAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8wPAUQMdVDWJyiEYCVA5Qp613DB7j24ZgPgkhdSVyg=;
 b=pDB+1ArJo5JtR9qOa+B7jVxCdUzFOS3YKvIEKtUChBB+CY+v6Fd6Y3+Ma/VDD5Y2fts0jW7Y32Pjhsvc5PV+oQ4HgWRrrx1dP6XOOde0LNSGSFboaJolGSmt2k48M2eS6rNGNqt1geLVQtrMCoN1qPwLFi5/eZzU8rMa0zVGnJd8IEMbQFb7Xt2he/Whqh3DY2OaN6rVt5yB58S0LdzrvMXr5d9S305RPYxXngjBMg6HOkXsTg5+M6xX92YVlFtDSNf9Iaf538cQbuDoe48HPh0jHTFzDDwvm/EZQUmUQoCuNg3QmfiKBt5kprwzBAunV02SYlxSCmAfYam8XKIMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8wPAUQMdVDWJyiEYCVA5Qp613DB7j24ZgPgkhdSVyg=;
 b=PlTAUE2BwevXM1DOgug63MZbH1VJkas3GsDFCYrEijHnEcWhIgEq2GjyJikQJoAsh//HALrWyBtbn02viTpD0gSrBzBWrUeeJq8x7gVtlCMXGvrYbH6hkgYy64CuVH9kOjusHxbeNqEXNg0HfSHpQNMbyMjauBpwZZRycs/A3aA=
Received: from BL1PR13CA0438.namprd13.prod.outlook.com (2603:10b6:208:2c3::23)
 by MW5PR10MB5667.namprd10.prod.outlook.com (2603:10b6:303:19c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 08:38:09 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::ae) by BL1PR13CA0438.outlook.office365.com
 (2603:10b6:208:2c3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 08:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 08:38:08 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 02:38:08 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 02:38:07 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 02:38:07 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61J8c6HW1825549;
 Thu, 19 Feb 2026 02:38:07 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Feb 2026 14:08:06 +0530
Message-ID: <DGISWASK42DF.1HYLBZFMHMJQF@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Anurag Dutta <a-dutta@ti.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <s-k6@ti.com>, <gehariprasath@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/7] spl: mtd: Add bad block handling for SPL image loading
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260217112156.272154-1-a-dutta@ti.com>
 <20260217112156.272154-4-a-dutta@ti.com>
In-Reply-To: <20260217112156.272154-4-a-dutta@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW5PR10MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 9096da77-e4fe-4afb-027c-08de6f92359c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGlCSkgwVGpNT1A3NFhEVFlRb1k5UGxZUHVIaXVQRHN5TlltaFQ5TW54TW1M?=
 =?utf-8?B?N3d1YjZ4WWkweFFuYTV0alBUN2c0bEVCVGQzMjNPZGpKZjBmM1U3akpDM1lD?=
 =?utf-8?B?Z3JYa2lkd01ld2kydnVNNEJqazJCL1pIT2JnZmZnSW9WdDdCYTd2eXVTZUhh?=
 =?utf-8?B?RDZVbVd0U1lGUjJKNmdpSzRkRzRRaDFFNHdHRTdIN2crR1cvY3pxSU5vR0RB?=
 =?utf-8?B?NE92eUlTV0RuSHUzQVg4bTJUWkJzeHNQUmM4UlN4MC8vM3RDSzhnb3MzRFJa?=
 =?utf-8?B?ejQ0OU1kWlhnMHVISklqenNlZ2huaG1RZkJoS0tBbkV5aWRXbGM1RFp0VU84?=
 =?utf-8?B?MkRJNng0Y1Rja2o3WXRwNVlHbDJpemRPWW44RUk4WmVtdk9ybk9TSzQxVW9w?=
 =?utf-8?B?YURpbkZzU1ZmMjVTOEZwTW9KN0VXOW9ienovdVVqYlpWWVEzc2dKdzk3SHdj?=
 =?utf-8?B?Z1ROZCs5WDZiTmtwN3lKYUpxWXdkZzJLNGJTelZFNG5KMERuMHg3MW1XQkEv?=
 =?utf-8?B?ZVh3Qm0vSGxUcFd5cUlON3hBeEFuL1J0SUErVVRLYVpmWDVQNXpEN2dYZUc2?=
 =?utf-8?B?VnNteEdCdzhjYXR2clpPWEI0RGEweGlxR212eUV4QXVBMjh5SnhtSUU0cndE?=
 =?utf-8?B?MmNVZmxpOWI4OS90RVY2SFcycjltWDZaM0RNWHRVRDI4MkpNUG5uSzQvMjlw?=
 =?utf-8?B?YmFtdzArZDFSWmVLS1RhR2dlR0poZE93bVNMQ2tLMlE2SUU1Z3R6RUEzQk9W?=
 =?utf-8?B?NHlzaGozS2dPWnJKSmNpUkxtOVJNaFVhblNVZ2duclN0SHJmZ21sa1hLT0dm?=
 =?utf-8?B?MmN0N1hPZHdtdG50NFF6KzJRYTdlRTFpZXhrckU2ZVpjU2xFeGduOEI2Q2Fp?=
 =?utf-8?B?NEhQVVQ2RFFxazJIY1ZNUjhMNGxEYUw5VFBieGRzS01aTlk3R1ExYjJOdXE1?=
 =?utf-8?B?eEQ2R0F1bDNyMDlqTkhOMHhZbmk2QzNuWDZ0cWFUQ0p5TXJFNDRSdW9SMTEr?=
 =?utf-8?B?VVN4RjZZYmlVMzdsSHdjWnpwOWliQ3FNbWVnNXlpeDZPN3ZNcXk0Qjd6MXRQ?=
 =?utf-8?B?elB5RmpZdzFVL1M5TUhGNmJGbkQwUExIMkxtWS9sMXFMKzExRzJNLzh4Lzho?=
 =?utf-8?B?SGlDaWlIbTAxZFEzMklKTDcwR01PTGpwNEJzbTdmdHNLSDhKL3hjVlJzSERs?=
 =?utf-8?B?WXZraXBhWDBFckZXTit0SlJwcEJaR2lLbCsxelBCRjhreU14WnZYcitodEpt?=
 =?utf-8?B?QjZWSXlKeFlSVmpWQzVDbzV5MGcxb1E4eXJKV0R6SGRhKzNCa3A4cnJkcU14?=
 =?utf-8?B?ME9RakFGT1RJLzl6a3FwcHlZQi9NbUYvL1IyQllybWxSbFJrbFR0WFFSbHJF?=
 =?utf-8?B?ZG92WGgvMURkazc0U1RuN2R3NWhCUllLL0Y0SW1haUN5RHRDWWRZUER0TXpD?=
 =?utf-8?B?WXpHNzhSd21oN2MvMW1kVkxVcVhhcHFZemJDWkRZZnB1MTVxdEJqTDRzUHZy?=
 =?utf-8?B?TkFJTzZmUjkwVGNmNmNlblBmVCtXbXVQZENpRXQ0djk5ZTd3eVV0dUt2V20w?=
 =?utf-8?B?NkhyejVWd0F6UEE2akdKQmRUM042RzJ3cHhzS2hWYTA1Q0pvc1kvYmxyM1hT?=
 =?utf-8?B?T0Z5WkIyQ1JreSs3UGd0ZEtBWm9ES09RUUlGREoxOUJrQlZoZyttQXZwaUxS?=
 =?utf-8?B?ZWdCamNud2FGUGdPSkhLSml3b251cGVQZXlDY2RGTlFUTzZ1dXVFaG5UK0hU?=
 =?utf-8?B?QTdvZTFYTlNRVnB0azBUUzJqd2IxK2NxQXppQ3hOVVJLUmZ5SldGR1lyczlv?=
 =?utf-8?B?dUNMT0d6ektnSGxsRFpLcXI3UFlwamJoOENRSTBZUTlSMCtvbTlCanNLQ0d0?=
 =?utf-8?B?MGszNWkwS0RrUXF6SG9IallSZTdBU2NSOTJkUmNua1B1dUt0NC9QVW9ZNHlC?=
 =?utf-8?B?WnFGbkRSOHVTZXp6VUE5Rm5oYzM1RzhrdFpNbHFTR2tYTUJHLzlWSytFN3JK?=
 =?utf-8?B?bEM5UFlWd0h2eXhVb0dmbmZqbUJvUVJIWFJlczVwTmJTWHk1aGxIVXRrM29k?=
 =?utf-8?B?Umxpb2dUeTc1eU5XTjlQZnFnN2oxOE00UFVidHY5ME9iRHJYNzF0K0RucmZh?=
 =?utf-8?B?OUJBUTRLOUZYV2tpeDZCNjlOOXNzZUFRdnMxa1F1allaY1dWS2Q1TEtCRWp6?=
 =?utf-8?Q?7be8SeGELC+kF1GmjoHXTNITPWH+GW6lvmgrBrbG4gc1?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EyLzHIG7MfRaeCpDNUc/WJXaQ2erA3GrBot/odcMmJUBVBql1NPulxSgukmndz9ZJjRVjvM/P9IqCN2odkGQ9rE4rSvJYgfUpHuAE3fS07rs+3sAdUCeTFELEo6jks9lIOvipCwrRL47eGg4dtQcZw924lJ27pWD1h/5utOezzWdE36D++3G0qrHVDxS2cv3m/e6qMMwp5U44LziFniWqXPEotKDZeA4sKEK4x5+mQssuriO1HVXsjvHrF7bA2a5Re0c/xTtRxO4D7ISP0vQArKEuRYNUp8tLCpBdp+ViOjWa6CHn+l6JkGVwJxOtX5OmjMsgMqTOzIwkvXTJ7V2YMhXKJOQgriWnaNtfNNWK+lY1RFbfqGIRirs1i3lErYRcRULRk/hMO1jmOp6HTRHoAI7pF6rGJowvUm9EhghRFm4cePR0dreUBVp/7/Vdz7v
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:38:08.7375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9096da77-e4fe-4afb-027c-08de6f92359c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
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

On Tue Feb 17, 2026 at 4:51 PM IST, Anurag Dutta wrote:
> From: Santhosh Kumar K <s-k6@ti.com>
>
> Implement bad block skipping functionality in SPL MTD loader to ensure
> reliable boot from flash devices with bad blocks. Without this, the
> SPL would fail to load images if bad blocks were encountered.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>  common/spl/spl_mtd.c | 78 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 68 insertions(+), 10 deletions(-)
>
> diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
> index 95c0c8ce8cd..d635aa2b476 100644
> --- a/common/spl/spl_mtd.c
> +++ b/common/spl/spl_mtd.c
> @@ -17,15 +17,64 @@ uint32_t __weak spl_mtd_get_uboot_offs(void)
>  	return CONFIG_SYS_MTD_U_BOOT_OFFS;
>  }
> =20
> +static ulong spl_mtd_read_skip_bad(struct mtd_info *mtd, loff_t offs,
> +				   size_t size, void *dst)
> +{
> +	size_t remaining =3D size;
> +	size_t ret_len;
> +	loff_t current_offs =3D offs;

NIT: Do we really need to have a current_offs here when we aren't gonna
use offs later anyway? Would be more clear to use offs directly imo.

> +	loff_t block_aligned_offs, next_block;
> +	u_char *buf =3D (u_char *)dst;
> +	int err;
> +
> +	while (remaining > 0) {
> +		size_t read_size;
> +		size_t block_remaining;
> +
> +		block_aligned_offs =3D current_offs & ~(mtd->erasesize - 1);

We could make use of ALIGN macro here.

> +
> +		if (mtd_block_isbad(mtd, block_aligned_offs)) {
> +			debug("SPL: Skipping bad block at 0x%llx, jumping to 0x%llx\n",
> +			      block_aligned_offs, next_block);

On the first bad bock, next_block would be uninitialized data and
printing it here doesn't make sense.

> +
> +			next_block =3D block_aligned_offs + mtd->erasesize;
> +			current_offs =3D next_block;
> +			continue;
> +		}
> +
> +		block_remaining =3D mtd->erasesize -
> +				  (current_offs & (mtd->erasesize - 1));
> +		read_size =3D remaining < block_remaining ? remaining : block_remainin=
g;

We could instead do 'read_size =3D min(remaining, block_remaining).

> +
> +		err =3D mtd_read(mtd, current_offs, read_size, &ret_len, buf);
> +		if (err) {
> +			printf("SPL: Read error at offset 0x%llx: %d\n",
> +			       current_offs, err);
> +			return size - remaining;
> +		}
> +
> +		buf +=3D ret_len;
> +		current_offs +=3D ret_len;
> +		remaining -=3D ret_len;
> +
> +		if (current_offs >=3D mtd->size) {
> +			printf("SPL: Reached end of device, read %zu/%zu bytes\n",
> +			       size - remaining, size);
> +			break;
> +		}
> +	}
> +
> +	return size - remaining;
> +}
> +
>  static ulong spl_mtd_fit_read(struct spl_load_info *load, ulong offs,
>  			      ulong size, void *dst)
>  {
>  	struct mtd_info *mtd =3D load->priv;
> -	int err;
>  	size_t ret_len;
> =20
> -	err =3D mtd_read(mtd, offs, size, &ret_len, dst);
> -	if (!err)
> +	ret_len =3D spl_mtd_read_skip_bad(mtd, offs, size, dst);
> +	if (ret_len > 0)
>  		return ret_len;
> =20
>  	return 0;
> @@ -52,17 +101,19 @@ struct mtd_info *spl_prepare_mtd(uint boot_device)
>  int spl_mtd_load(struct spl_image_info *spl_image,
>  		 struct mtd_info *mtd, struct spl_boot_device *bootdev)
>  {
> -	int err;
> +	int err =3D 0;
>  	struct legacy_img_hdr *header;
>  	__maybe_unused struct spl_load_info load;
>  	size_t ret_len;
> =20
>  	header =3D spl_get_load_buffer(0, sizeof(*header));
> -
> -	err =3D mtd_read(mtd, spl_mtd_get_uboot_offs(), sizeof(*header),
> -		       &ret_len, (void *)header);
> -	if (err)
> +	ret_len =3D spl_mtd_read_skip_bad(mtd, spl_mtd_get_uboot_offs(),
> +					sizeof(*header), (void *)header);
> +	if (ret_len !=3D sizeof(*header)) {
> +		printf("SPL: Failed to read image header\n");
> +		err =3D -EIO;
>  		goto out_err;
> +	}
> =20
>  	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
>  	    image_get_magic(header) =3D=3D FDT_MAGIC) {
> @@ -82,8 +133,15 @@ int spl_mtd_load(struct spl_image_info *spl_image,
>  		err =3D spl_parse_image_header(spl_image, bootdev, header);
>  		if (err)
>  			goto out_err;
> -		err =3D mtd_read(mtd, spl_mtd_get_uboot_offs(), spl_image->size,
> -			       &ret_len, (void *)(ulong)spl_image->load_addr);
> +
> +		ret_len =3D spl_mtd_read_skip_bad(mtd, spl_mtd_get_uboot_offs(),
> +						spl_image->size,
> +						(void *)(ulong)spl_image->load_addr);
> +		if (ret_len !=3D spl_image->size) {
> +			printf("SPL: Failed to read full image: %zu/%u bytes\n",
> +			       ret_len, spl_image->size);
> +			err =3D -EIO;
> +		}
>  	}
> =20
>  out_err:

