Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9725EEB48EB
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1679C83015;
	Thu, 12 Feb 2026 11:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QnqE2fok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28FA783A47; Thu, 12 Feb 2026 11:32:37 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4EA80FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QG1ICKE0IELnuEZdlZenC8RTn0aZlIfAgWXGKt0bmlD8Tam0zz6WpWslslPauPU5maTxgbNJ66UBnkaP1dPRCck28aIDIkyzeMe06GqBRefSKpeeUv58mhc7GRd5HwRnTd7ScuOvDfa88ziIIkJiQjVcbUaPlZFXxWt8cQyrmC/Du8S7ZTxLEaxRuEgzbrKpWaZakU7eSxrlAuf/9+DG/wvhBuBDN7VeeCTrinmnAOH77MRdmZFE19yfR8pQ1SbUR+pw1+uoU3Mu2BOlwcrMLBD/tov18yneycOcMuNEzdENQaDjySf/HhxZhFlDU6M7pATL/tjGYi829oTvtCAbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXYkT3fKPwWffZFYdjCUG8hgN240BdqlXuU+h7kT9oY=;
 b=IbLXtSWR7kXC7M68SuQV4/LCJXbIeFI9ucNBt5FUH42Owuh4sllnNkurRMX+5ag8yD2gvxNYUIwEfxugDblardw2HtZzvIRiBwA3MGi0rtRkE7A7Xq7G3klfYWgB2y93A9JRvK62OaSBvt6RNXPE5ZFn6uEbqYOu0c0mBpWhxnbT5FKy5ShdAZatWMryqObLlvKOj6Y+rxtr5kpt6LqeiLIqdPkBQRsJTdxB6UiKDG0cqOdCWbnOCyl3E3Rgf8YYm/Z5NuHVcw+gWFO7sYjy30NJwmUWEnBUydV4zVdgkKETRCj8ogJKYMS8ufmvA7r+AvYZ4FflkhErhGorEoTpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXYkT3fKPwWffZFYdjCUG8hgN240BdqlXuU+h7kT9oY=;
 b=QnqE2fokPriSFaz25HkBaslv9HvIJuFKTrIlB4TBO9v8bR3D+2m5UvnXq3BZEBswhoIILAGbYlxT+jenY3Fo5YzH7vB63IvSamqjvYhf+p9sEAGDB8P8pf3ddv8sv9pBT9TDWW4jZmgkFs98Dgl8slaJ5tUOSj3rL2kOaWjYg3s=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 PH7PR10MB6034.namprd10.prod.outlook.com (2603:10b6:510:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:32:31 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::f) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 10:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:32:31 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 04:32:30 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 04:32:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 04:32:30 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61CAWTrc2912181;
 Thu, 12 Feb 2026 04:32:29 -0600
Date: Thu, 12 Feb 2026 16:02:28 +0530
From: Suhaas Joshi <s-joshi@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: Re: [PATCH 1/1] board: toradex: Make A53 get RAM size from DT in K3
 boards
Message-ID: <20260212103228.64kaa7scuooosnmv@ula0507357>
References: <20260211111328.1481562-1-s-joshi@ti.com>
 <20260211111328.1481562-2-s-joshi@ti.com>
 <20260212082518.GA366331@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212082518.GA366331@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR10MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b3f51e-63ef-4080-f23d-08de6a22070c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KGK2s2LP3wM978wR53vuDjlccARkFuM7hxNELOFlzfQAKf0UZfq8JHc508b+?=
 =?us-ascii?Q?GGKp9JJE3DVg2JllhKC/pTHqfptu2S3RGGVHvrlf46xivaHs28dD/UwoLn6W?=
 =?us-ascii?Q?YOXW1foWA7yPo9eT21tDtiln+uQ8ekGYTQeGosbjWID0EwngB+tZRHXqw55o?=
 =?us-ascii?Q?9sdX/g0SKcXlh/agh6+aS6EVTZDSsNmiKQxD7aPPr+8mWs83sRSzGxpvJY99?=
 =?us-ascii?Q?vJ1I1wMr+pA1lg7ubSmTGbWQv69Z8Bute+cN+9fw1+cafffjLeKHNJ0dLzrQ?=
 =?us-ascii?Q?Fs4aYVW5xo/yVWFAepILakF/bymNGUD2vUKb4ObAFwHiA2wA4uEbamF620WU?=
 =?us-ascii?Q?ykwMCpco4upETPS6qQEKye7krLahctGnghFHngZv98hIObdTiVciUHLv8nUM?=
 =?us-ascii?Q?3ZOsPFiRHkuqlcf5YWeY+b8N1rBRYx/yIoBFygwLOLumF0ZhDR+jGoXkPk+l?=
 =?us-ascii?Q?K60cDP2zMVSf9NbfwUvpUAJSE3mEzW8oIwWNjicBVQbHTcDpU9GpTEuuIwSQ?=
 =?us-ascii?Q?rcttnox3PQY/CSjrc055sz8Ttp/GSkpgPfMUkB2iNs4Eww/BGfc+tuSp2wxg?=
 =?us-ascii?Q?+FALDvu4GWHTrN5S5Fx79QR/sRoFRLxs0byFj7ZgIENkCOme7m1oBH01vYq/?=
 =?us-ascii?Q?aGaV0Ay23r2mqgbyf1v5asDvquZJeqQetk8B1J8NMYKi/Y5UhV2TzdacfJL5?=
 =?us-ascii?Q?vdINed6ZWufOvvPyBvBatB9HSxxxbW41o5LfPObwv7aKgehR3F/RxNzJSufU?=
 =?us-ascii?Q?DBrkT3gMKX7B57JKLb00UL4QtpgRCe+yWoh5XcT4RSoLorPkJDLbX7yxkQTo?=
 =?us-ascii?Q?XlRxR6x/U2GPE5cWdlaY2jEBbbT9pm9DL34laTDqQptxV5p1lgJIqiRhImPy?=
 =?us-ascii?Q?+qYeIjQRTEANrwgcYh8TCCEmC6EOux9nI0EuM58Io4uiA0MTn4mibcV/C3TO?=
 =?us-ascii?Q?hbrDx/o7R9uoARpzBwZvCG+5Pstaq4pf/JRh31spWgW/1MYTFg0LVIranUUr?=
 =?us-ascii?Q?Wo4faPTI4thD/35AsMgdK1N/6qyG996GCSbX9IyfT9kRylD+EA1g5QXlkLYn?=
 =?us-ascii?Q?HklM5Qf0NcLq7hVYQNbTJPFI09UnwZ9J087JzmKbIMIQk0HMTWhh/6rh805E?=
 =?us-ascii?Q?ef0LvbwbQa1/S9STK4BHk/XBbKwKY4vzIm2v9QcFL+dKFSafBYcJ6Zoy8Jxe?=
 =?us-ascii?Q?JT8J/6uNMbRFg+ErRRk9MfHTyFm/hJZCfcHpnD7/iiBHmNO6Dgink7RW872Z?=
 =?us-ascii?Q?gmR25TAVyIHfIiq3Hk4RAxlDPUJ3JyRE3FO0sXAzSoCSRdrp3ofs0fKoouoY?=
 =?us-ascii?Q?RX/A4bHLpuMw2SdHsdqxyuiZmn+LR2fErt3jFVdN9oMErrW0RF409R6ZQflk?=
 =?us-ascii?Q?fiQCsho01n1AgIEemKZoY1qBsshnwczaIpbyzHdv+qu9DsXYdSJHP+lm6MTd?=
 =?us-ascii?Q?Rww/LyPU+2/qjRywCDk8PNzBNRCIbsr2mUP99DZ+5DsLYqSpBBsCRG46I5pA?=
 =?us-ascii?Q?d7eXax/ZFwim+ETDAOuprYAjtvN5BhgF8H7p7+7W9XV0RXu4z4NXTw9LzLNp?=
 =?us-ascii?Q?06tMq1VC2Cmymp3fGEJ6n/ufmvyheT1XK8ucKfFbPWooTUr1/Zt0EDjya/l5?=
 =?us-ascii?Q?NU2ZboZEJinhjUk8Oz3/ekdomBlRfqe6Is2PAWW1fTc8piVbriTelz2rm3dj?=
 =?us-ascii?Q?aNCr1rjjSAddiOfMgnAoueCDsJM=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HJGpZ/2F2awsQpH75X1WS5/joyzE5ouycEkrdmBtJ+h4ceZamU2+7N9EWuuExTVSS/JO5iC4O9P4KvgVfGViznc8S73ySow1tVtq0GFCpBxg1m7VI95TFUWHIZ3BFEym3oWftoXkuhV1B33H2nkASaLBaRtyA+6fRk7NtVY8musVWfPkX2L53kz6wJpwhgx7AgmdkS8todYOjWkGokmRPw7axxAPOTlvATIcZ0nb+aUfa5ZLUf1kiwUcgXyqb7TZc07kXDeNQmf7KlP3yqx4Gi+bTPaFOHI5pFpi1qW5mpX5CkoLMw2ouZG3xaAB81Loi514wMnlr/Xvrc7K54Djq6VPLUtKF5nnhy4dguauQMCVXsWk21NGtWrqbOpjRJuQEhwhUuZRgmXXq8HwqZ05AIbQPBjDCHKNQjSJGepuVMwVz0RaOrzjkElQm3bZY9id
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:32:31.1871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b3f51e-63ef-4080-f23d-08de6a22070c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6034
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

On 09:25-20260212, Francesco Dolcini wrote:
> Hello Suhaas,
> 
> On Wed, Feb 11, 2026 at 04:43:28PM +0530, Suhaas Joshi wrote:
> > `dram_init()` is called by R5 SPL and U-Boot, both. It starts by
> > computing the size of the RAM. In verdin-am62(p), it does so by calling
> > `get_ram_size()`. This function computes the size of the RAM by writing
> > over the RAM.
> > 
> > When R5 computes the size of the RAM, it does not update the DT with
> > this size. As a result, when A53 invokes `dram_init()` again, it has to
> > compute the size through `get_ram_size()` again.
> > 
> > Commit 13c54cf588d82 and 0c3a6f748c9 add firewall over ATF's and OPTEE's
> > regions. This firewall is added during the R5 SPL stage of boot. So when
> > A53 attempts to write over RAM in `get_ram_size()`, it writes over the
> > protected region. Since A53 is a non-secure core, this is blocked by the
> > firewall.
> > 
> > To fix this, do the following:
> >     * Implement `spl_perform_board_fixups()` function for verdin-am62
> >       and verdin-am62p. Make this function call `fixup_memory_node()`,
> >       which updates the DT.
> >     * Add an if-block in `dram_init()`, to ensure that only R5 is able
> >       to call `get_ram_size()`, and that A53 reads this size from the
> >       DT.
> > 
> > Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
> 
> I was able to test it on a verdin am62, with 1GB of RAM, and it works as
> expected. I also agree that get_ram_size() should be called only on the
> R5 SPL.
> 
> There is a small change that I would do however, please see the inline
> comment in the code.
> 
> Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Verdin AM62
> 
> 
> > ---
> >  board/toradex/verdin-am62/verdin-am62.c   | 10 ++++++++++
> >  board/toradex/verdin-am62p/verdin-am62p.c | 11 +++++++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
> > index 069aa6c7909..1aa106afbd9 100644
> > --- a/board/toradex/verdin-am62/verdin-am62.c
> > +++ b/board/toradex/verdin-am62/verdin-am62.c
> > @@ -24,6 +24,9 @@ DECLARE_GLOBAL_DATA_PTR;
> >  
> >  int dram_init(void)
> >  {
> > +	if (!IS_ENABLED(CONFIG_CPU_V7R))
> > +		return fdtdec_setup_mem_size_base();
> 
> change this to
> 
> if (!IS_ENABLED(CONFIG_TARGET_VERDIN_AM62_R5) || !IS_ENABLED(CONFIG_SPL_BUILD))
> 
> this way is clear that we want the get_ram_size() only on R5 SPL. It
> will make the code and the intention more clear, with no changes on the
> generated code.
> 
> > diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
> > index 7c631f380ff..12693c1a46b 100644
> > --- a/board/toradex/verdin-am62p/verdin-am62p.c
> > +++ b/board/toradex/verdin-am62p/verdin-am62p.c
> > @@ -18,6 +18,7 @@
> >  #include <k3-ddrss.h>
> >  #include <spl.h>
> >  #include <linux/sizes.h>
> > +#include <mach/k3-ddr.h>
> >  
> >  #include "../common/tdx-cfg-block.h"
> >  
> > @@ -57,6 +58,9 @@ static void read_hw_cfg(void)
> >  
> >  int dram_init(void)
> >  {
> > +	if (!IS_ENABLED(CONFIG_CPU_V7R))
> > +		return fdtdec_setup_mem_size_base();
> 
> same comment here
> 
> if (!IS_ENABLED(CONFIG_TARGET_VERDIN_AM62P_R5) || !IS_ENABLED(CONFIG_SPL_BUILD))
> 
> with these 2 small changes also add
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Done, I have sent the v2:
https://lore.kernel.org/u-boot/20260212102847.1560553-1-s-joshi@ti.com/T/#t

Do let me know if there are any other issues in v2. Thanks for testing
this out.

Regards
Suhaas

> 
> Thanks for the support on solving this regression.
> 
> Francesco
> 
