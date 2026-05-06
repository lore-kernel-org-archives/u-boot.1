Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7BBCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 07:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF15847FD;
	Wed,  6 May 2026 09:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c6UTw6HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9952784812; Wed,  6 May 2026 09:28:25 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE54847F6
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 09:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRAmhnaLeQ+zES6nnhHjRD6vLfIL8PbXjrZlHwq6Ta5gsYa/hELLQRLrjV/JirnBzqXaloF+nSylodFQ9dA0vtc93wdVqXCj6FbIM32znbagSkTgPp2MBsMdK8zSdad0N8vU8Sg0bOE7qaw4UwnpAByBdEqNOaDx9PSk3y2PARnS/e6LMf/jA5byL0c/HXs74ZmNDfKpgHBzsgha02YREV9Oiz04TcKY29egu5HLu9Hr5KbERSli01/JTcWIJS8eMwnfko/aZdngGQRybluHuQKmMPKUp2/eXUq7f2n51yRf/1pIipEjbm3NOfVSpmqChuNdjXrbfHZa0wZszT+XLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPjcz12TIsiWJvd0iqQkK95Yc0p5t7O7fhvvDVnJwXQ=;
 b=DwDeT2BsII7veD3er+G1MIgLnfZfsev4bntDJAYaD46Ytvd4piV1vr0LOLRGFnhvwQrjRbn0N9oK/tAgglBM90nHlj0NhfQj2w+6oxD0mpMkcQa9OXckDnRDUQ95z5p8PJLFK2lCQNiUAmjg9A0iCauQrybCGyt1ZvM7VDY3WPk92fQ9nx3d6f2+S7v+5LCGpKkSyC5JfGi2KFh++Pb4EussrRkJX7pL6OV6TgPZxbg/APrrgYbSBVWcB2d25lQKJBGjKxjZZta9PXh7cNCSj5mdKTEGFcKOH9cDO6+7J6lxYd/BZUdZ2IkAy1H4and+6IddjpykkGgrPXWtqvhskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPjcz12TIsiWJvd0iqQkK95Yc0p5t7O7fhvvDVnJwXQ=;
 b=c6UTw6HTxAoM9IDfEPWmnq83Avkf8wublLtART5J14209ocoucGHwScHSRc8AL89U6GhgHkqG7nJkVRAztpMPlkNkjH4czgt79korrWQptTGScglcmg0AnAOT04JuGApWHvh1Cuj7NAUjEdZMJGMGuZnKMcpUj5jlwI5GGMFYKk=
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by IA3PR10MB8564.namprd10.prod.outlook.com (2603:10b6:208:583::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:28:18 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::28) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 07:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:28:17 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 02:28:14 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 02:28:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 6 May 2026 02:28:14 -0500
Received: from [172.24.233.216] (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6467SA8x875442;
 Wed, 6 May 2026 02:28:11 -0500
Message-ID: <51d0ceea-f139-4ed4-b245-0eb31a246d90@ti.com>
Date: Wed, 6 May 2026 12:58:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH V2 0/9] board: k3: Sync rm-cfg with TIFS
 v11.02.09 firmware
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>, 
 <praneeth@ti.com>, <bb@ti.com>, <afd@ti.com>, <n-francis@ti.com>,
 <vishalm@ti.com>, <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
 <20260225151047.GJ1593142@bill-the-cat>
 <e6d88daa-c00c-418b-a8df-3714c7254002@ti.com>
 <vjlrb25moymvlg6tfofolyc4ybgfju3yglefe5olcjk2qphz2l@5d6e4knya7re>
Content-Language: en-US
From: Sparsh Kumar <sparsh-kumar@ti.com>
In-Reply-To: <vjlrb25moymvlg6tfofolyc4ybgfju3yglefe5olcjk2qphz2l@5d6e4knya7re>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA3PR10MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: de7b9635-6895-4b49-e3f5-08deab410abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|10063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: kgy9XWv7+ALavRiKjwzzKGh89BUzhJfsV167um3ZVTAS0pZUXiIue5Nnr44bGGeuP3+ZOLCjlESLBQI/yvJiWQbO4I9tuJ8r4ZiPICbVM2W6MOwyUX0O6HifjSkr0myOR35VXQ+PivdHL5BMgPLqz6mZOmWApzBL2BshDrBR8sU+Ff5WFZ2l+xkMTKeYbLAYFEtqQGnbwRpycKP87iWIyTyV8TKzAA41gSpLVJcfW6+IYQbS2jgLuAisngVzNZEGoURKc//dUX2RpysZR0Pu4sc68qzomj9PM15jWbHWfJDKk/P+OXKOPsvuymKsr4ml+XJqHFuPmF8GF789t8V38bsqdwh6+yjWBMAK/qXF2piv8YMvJ/fM+7h4u8PTcNTUPOZyJMfDDm0ZjsAE8HfR0ZJLFIYSh6xn5b4FFZabVh8ZIwLN+fH7OOdZu6BoKdYdllJH7OWpuWITPcvX4cihQolrEGtU6QOtIoxRqshaq1IPfO5w4OqLd0rw63z3PM8mzTR9g2KWM83U0r8dbjKIfx52mqyZImgXfhXWu7XDPnUH5u9DTuzFLdehOEGGRZ2PsNGqFfDQ1WV4qHzzRTu2fOJxQu8B3G0s7s58wsGwGHtpPqsGsSc1tbKRxbJpMl7hMb0z6BiQbbQsmI0Y7cwGQVSK7OwGxh7xaSOefQgmbfFALIlsilvLBVCGNaMUN/oF72/R7o2mcUFrO85ZIqjvp/zQXdi1ROLN8NsH2kDHV/0=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(10063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eWfCWGwYSkoRz6fBrXd8gjTZIYsPuQU3ja2AM+y4nM+9XIbdZkIA7QaS+aftDi9AfLVIJ9uj4denAfdJLxMD2q7qWT4ASIAdYzZCIS9TWEMiCOJR0ra9FidQWjW1ukPKA6eZ1S313UaSs2hrxCA8DL76LFhdF6h+rChCUI4wOvanfCZKOzI/WcETDq/XJ93x8c6WgsGZHnFSaLsLiNARx+YRy7njwbbM9WVXR/7COxzaASUNTmN+Jh71g6XpPXImc4UwZTPtqfUUlA0wfvJ/xt+oIy4UTToOPnkKWZKanzCBDmDZgAgZdTYV5lJI7TSOmdnM6kEdGheqZD3AaNS9aUzg8R28kLTw99aV3nh0KaLhiZ2rsJWLrCCr+qXtXzgmtMd7BVlGc/XWCl4CA8PGDoS7pGF/exA9W6YxkidrJYQZWCzXBeopflJS93E+H/aS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:28:17.3264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7b9635-6895-4b49-e3f5-08deab410abb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8564
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

On 21/04/26 8:46 pm, Ernest Van Hoecke wrote:
> On Wed, Feb 25, 2026 at 09: 17: 03PM +0530, Sparsh Kumar wrote: > On 
> 25/02/26 8: 40 pm, Tom Rini wrote: > > On Wed, Feb 25, 2026 at 06: 54:  
> 16PM +0530, Sparsh Kumar wrote: > > > > > This series updates the 
> Resource Management
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> tJdi1lwHPC1bga2NF3tIVrcuzWKosV1nyLqwWw3W9oiThr2cg3_QFMBFOt-- 
> e_D6WG7bRsTVT0QRq3fBi6wrfylqlm3Aj1v28uBtLAjlNJLSssbTwvOWqfU$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Wed, Feb 25, 2026 at 09:17:03PM +0530, Sparsh Kumar wrote:
>> On 25/02/26 8:40 pm, Tom Rini wrote:
>> > On Wed, Feb 25, 2026 at 06:54:16PM +0530, Sparsh Kumar wrote:
>> > 
>> > > This series updates the Resource Management (RM) configuration files
>> > > for AM62 family devices to align with the TIFS v11.02.09 firmware.
>> > > 
>> > > Background
>> > > ----------
>> > > With the latest TIFS firmware (v11.02.09), an additional virtual
>> > > interrupt and event is reserved for MCU cores to DM usage on am62x,
>> > > am62ax, and am62px devices. This series brings the rm-cfg and
>> > > tifs-rm-cfg files in sync with these firmware changes across both
>> > > TI reference boards and vendor boards.
>> > > 
>> > > These changes are backward compatible with older TIFS firmware versions.
>> > > 
>> > > Additionally, the am62x platform was originally introduced without a
>> > > tifs-rm-cfg.yaml file, unlike other platforms in the AM62 family.
>> > > This series addresses that gap and enables tifs-rm-cfg in binman for
>> > > am625-sk and am62p-sk platforms.
>> > > 
>> > > Changes
>> > > -------
>> > > TI reference boards (patches 1-4):
>> > >    - Update rm-cfg.yaml for am62x, am62ax, am62px
>> > >    - Sync am62px tifs-rm-cfg.yaml with TIFS firmware template
>> > >    - Add missing tifs-rm-cfg.yaml for am62x
>> > >    - Enable tifs-rm-cfg in binman for am625-sk and am62p-sk
>> > > 
>> > > Vendor boards (patches 5-9):
>> > >    - beagleplay (am62x-based)
>> > >    - phytec phycore_am62x
>> > >    - toradex verdin-am62
>> > >    - phytec phycore_am62ax
>> > >    - toradex verdin-am62p
>> > > 
>> > > Note: For vendor boards, this series only updates the rm-cfg.yaml files
>> > > with the required interrupt reservation. The tifs-rm-cfg.yaml files
>> > > cannot be updated without access to the corresponding SysConfig files,
>> > > as both rm-cfg.yaml and tifs-rm-cfg.yaml must remain in sync.
>> > 
>> > Do I read this right, and the vendor boards will now be broken?
>> > 
>> Hello Tom,
>> 
>> No, the vendor boards will not be broken by these changes.
>> 
>> While it is generally recommended to keep rm-cfg.yaml and tifs-rm-cfg.yaml
>> in sync, the specific changes in this series do not require corresponding
>> tifs-rm-cfg.yaml updates for vendor boards:
>> 
>>   1. AM62ax and AM62px: The global events reservation change in rm-cfg.yaml
>> has no corresponding entry in tifs-rm-cfg.yaml, so no sync is needed.
>>   2. AM62x: The virtual interrupt change would ideally need a similar update
>> in tifs-rm-cfg.yaml, but none of the vendor boards have this file. This
>> series introduces tifs-rm-cfg.yaml only for TI reference board to align with
>> other K3 devices.
>>
> 
> Hi Sparsh,
> 
> I'm evaluating whether we (Toradex) should start including this
> tifs-rm-cfg.yaml file. Could you expand on when this is required?
> 
>  From the documentation I gather that the tifs config is a cut-down
> version of rm-cfg.yaml, only meant for TIFS consumption.
> Furthermore, doc/board/ti/k3.rst mentions:
>      Devices with a split firmware will have two firmwares loaded into the
>      device at different times during the bootup process. TI’s Foundational
>      Security (TIFS), needed to operate the Security Management Subsystem,
>      will either be loaded by ROM or the WKUP U-Boot SPL, then once the
>      wakeup U-Boot SPL has completed, the second Device Management (DM)
>      firmware can be loaded on the now free core in the wakeup domain.
> 
> Is this a necessity for secure boot, or how is it used?
> 
> Thanks for the help and kind regards,
> Ernest
> 

Hi Ernest,

Apologies for the delayed response.

The M4 core that runs TIFS has far less memory available (176KB) than 
the WKUP/DM R5 core. To keep the memory footprint as small as possible 
we trim the full RM board configuration down to only the entries that 
TIFS needs and store the result in `tifs‑rm‑cfg.yaml`.

A couple of important points:

1. Both `rm‑cfg.yaml` and `tifs‑rm‑cfg.yaml` are generated automatically.
    We use the K3 Resource Configuration Tool (formerly the K3 Resource 
Partitioning Tool) to generate the files from the SysConfig file and 
then copy the generated YAML files into U‑Boot. No manual editing is 
involved.

2. By using a smaller board‑config file we free up RAM on the M4, 
preserving space for future features or extensions.

3. Secure‑boot relevance - The `tifs‑rm‑cfg.yaml` does not play any 
direct role in the secure‑boot process; it is simply a streamlined copy 
of `rm‑cfg.yaml` that contains only the TIFS‑specific resources.

Please let me know if any part of this explanation is unclear or if you 
need more detail on a specific step. Happy to elaborate!

-- 
Best Regards,
Sparsh
