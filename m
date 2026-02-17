Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C80E83858
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C69A8063E;
	Tue, 17 Feb 2026 14:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a4gm7qns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 056D083C32; Tue, 17 Feb 2026 14:22:01 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6732F80325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFgiYLRG5jTNFQ3TPBmZSTqfDTyU+h/yTpCo9BzmQHDoEw5BNCBaozabb/ufTbv3NbV/zYMVxoEH5JB6VfZ0PNOwNHM0RtzDnlenOtHS+HyEx5MFYd94Eso9ebiDv4dUQke8/WGrP/5FHz6P422sgdt4FJD+6yYeDmC7doDtHpMXrDn5lVI39iAnk/JZ6LG0Kr4VKrZUWSVxTqPfUNx16bgtUTRd2q/BbCEeOYEaK4Mcqttt72AIqREp2miD46gvIXHSRdwJpYKplkO0kxPuAqkXofkQbF1wRkqNuywmBA3gUAPgXHtilp/ynIhHSmGtClDwu3kbzFFXm6hW8NFwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILgl4T8FXFwqd233xyKzDsY9TbsuvLs9JJc30DmNDFU=;
 b=GYFg4ZhetXgk0Nl4Lvf/vbUHgoTyBON6Yan14gcXUffHBUM2LcV82MbbZCQJxFi65Eiw4tIbu7rWBIhGy8xuUpkTOZuvErwkiVs1QJZ1Bo3zc+ucwk432mCYD5otTMAfiUFhwQEKhsjM96QIyVDF7X7DYWEUGc3T0vXEzZs7xyr18CdM79cvRBrMruj/t1DuMP6z7lH8SY6AoHBrmCjzWD1vetIy10hyS9CuyTM6Tom38Lyg0mQ1yCHSXkWIQX2/VYNhpNmX8IUkOXCWmcc0oqPQTuiGXW0VM8CzDzivlsLGG1LQ+gyPakc6mG0/jZSw7MixEjpGVNW5gvLubVqvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILgl4T8FXFwqd233xyKzDsY9TbsuvLs9JJc30DmNDFU=;
 b=a4gm7qnsQApj7oGFYb+NG231L7HHw2qnD8ujq2sQZ7xGkX9+SronOHsMzjYCe2yoqNhzz/dXBvV5vQ+LRNzMZ6+ZPK0rRCVKXwegQ5T5NagcYSqLZB3SABLnIUKmIu/qS1mMn49U6z1xhon22FrAaaFD3fIHFKbJgrMoWFUtAyw=
Received: from PH1PEPF00013303.namprd07.prod.outlook.com (2603:10b6:518:1::12)
 by SJ0PR10MB4607.namprd10.prod.outlook.com (2603:10b6:a03:2dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 13:21:54 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF00013303.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 13:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 13:21:52 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:21:52 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:21:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 07:21:52 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HDLoDh3394964;
 Tue, 17 Feb 2026 07:21:51 -0600
Date: Tue, 17 Feb 2026 18:51:50 +0530
From: Suhaas Joshi <s-joshi@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260217132150.of5l5qirxkeizsne@ula0507357>
References: <20260210092646.w5bugrscifmsh5px@ula0507357>
 <20260209202001.saeaf6l2kz57rufg@bryanbrattlof.com>
 <20260210105014.GB214446@francesco-nb>
 <20260211101113.GA176369@francesco-nb>
 <20260211112109.56e27kyy4coqpcbb@ula0507357>
 <20260213102015.GA10715@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260213102015.GA10715@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SJ0PR10MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 9666fa8f-723d-40e3-eca2-08de6e2783ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EcjCvdP685hEhzd+yTXkDyjXR4cobUDX6i31EZqMx5SDBh3eM0FZ6JfwlDfu?=
 =?us-ascii?Q?8wIxhyOfdhisOp5Fk/aMDla1vKKiVBKPMwqb8ohatFIRRZYHE8mOV4M13K+o?=
 =?us-ascii?Q?LvyLxHrVSBUIUmOw8XdWuwD1CNsKL7i/nqQYgxfKbzZDwqtaGD107o1OX/hO?=
 =?us-ascii?Q?rD9CdrEAc66VxOw0xOo7vEbK1dS6nTptGyspN7rcqUBpmthXYgelbriLPlnj?=
 =?us-ascii?Q?JtsBftrklao6jXwJ6BlR2jQ9o2IafSF3J/ViOobzCNc2cmg/j96uuWWyAHr0?=
 =?us-ascii?Q?XjbAVWFXUEAFe6vcxiNNL1gsTZI1EZkzq/2ydaKAXfbqybwoIZPMbkO0YqiT?=
 =?us-ascii?Q?dsG8ASZ96/Lf2bs5wWWPD2YCPSr0YfKp9f28I41jgr58VxKlirGkxbFKRPnS?=
 =?us-ascii?Q?TPkAyVUxcTA7Hg+LtHAisU4B2VSzrsiMTcPyFNg+AvWfoJnmcx1mXd17Wyqs?=
 =?us-ascii?Q?teOPJhgso0RgpDJi+zEhSxkoczh77S8xaTrZRQpoTHArE5jL04cV/vyuWpLM?=
 =?us-ascii?Q?dliosOMhBRqbBC+GKGgJKghwjrbrDNm5jUGbyIOOkJJyqeper5l5477th7Px?=
 =?us-ascii?Q?KkrRRTpHU5GIrV+k3yzR+h4b3uTaZRlzLAd74FlyJ06hMBI0fdeLgFhGj9Dm?=
 =?us-ascii?Q?J7Leqnc0ahgKxJouhi3SDqzcFIiKYvpUEWnxSdjOEj0kz8plcIm3P3uBA/nO?=
 =?us-ascii?Q?xHkUgMM9AqTXajI9aOQKHRfJ2Q/9ovlydqCTXGWEnuLrjQLvtgwtQPwzXSGL?=
 =?us-ascii?Q?LE0JbTCj3fdT5HyupIl9f8lckF6bL/wvsf3JokdzHBoTSqhZ4+98vnmYWzaR?=
 =?us-ascii?Q?2hqFI4Uk4GddK7go9Pq9U5Bpnn4FIF3eXw42TqtwgB2pGi5taiCcbhxoc6xQ?=
 =?us-ascii?Q?KXAvuWfbCCk0KUCeuCFnHwreiCXDFNIn1xsDpl5rbnmdLjdcTB7Vb2rnE9/t?=
 =?us-ascii?Q?zyY/u+CtMv5CL7oMYQeGtzwkVKDtCSEY2PB5tbT0KEvRJkDlicBjyL/Bp4MS?=
 =?us-ascii?Q?UViYm1nfcbfR2zJvOK/TsXZK7N4DGGiJGOFIk37UCyDSkxjiNHuJT2XpEmEC?=
 =?us-ascii?Q?PRl0zF6gk/w5bZr7XWmxKA+ICvMRRUyiHts7q6g7pSUKgo0zvLSfKH7+lsvO?=
 =?us-ascii?Q?P4y7x6NzjiVP4YyAPNHiZJlTa4FsiuI82MX3K2HxXa0dgMHunrW62UvlDtRm?=
 =?us-ascii?Q?Y80sOs5bybkzRTWfQnKaJ2hyOgkY+ZvjIJClF8xhmUq5A0VLhfgIfmvL0VGm?=
 =?us-ascii?Q?kSFXcbMjHDjEudQadMrVL5AC0PwceedDvOb0oTb+VkDaZktAodqwlKAP/wXf?=
 =?us-ascii?Q?be09+KtiwlZBknWaBcFlwcgeurg10uMck+nhlrHEein4JI+ar4mdXynYmPXs?=
 =?us-ascii?Q?Z4pMzOXwrlwA5wThKwiyG/FCnmtRRyJvh/l2GggeeP4CAHnxV16/HUa/BmbT?=
 =?us-ascii?Q?MEIgLfXXsapmS9+5eHhQ5UKRLQq7orc3MfxAGFD+rSun76nG0lAo2n/I99Ok?=
 =?us-ascii?Q?CGTncCtMmLIw49VTknZY5Bj7YJ9JXn/yVMG8miKk8wDXUGgQUTPJwY0R81zo?=
 =?us-ascii?Q?VogsU52jYkps3xgur+5ZqWDvtCIZ4FstrGOurCyJ+idMKIU2n/nltAKKhu7W?=
 =?us-ascii?Q?Zg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n4Sbw1VrfOs3T2+oTRUH8BEsER3PaaTEhYgJNvVOzu+AFtM8+949cWO4tP5s+aWaaaDEbEB4oUKy1w80O3st2zUiRNZN+qh9AMK+YHzTPjbaAxSxLclpFmCn3U+Gc73/eYdeJ8DWjlvRLEPkMkd7aTB78A8YlybXzA22R+JSpaeecqi+SNggSNN7EYeVN+4uEhs073YzfsErN8XBvIzLogEbvrHSc/s8CAvs2Mh0p+5riT5r2VuDHwv6Brx/Mdu6RTsFmvYbCoy+Ik0WHNZQvR/BQUGFGjEjFdvEDL76jnRBjbufSZH5fIj0JW1hB6enE2VC3CNseBbCXny2OhzCNxZtthBLhHXrDLju162S8jyBRLLn/hIzeo6np212Bhk/Z/nHdpbogGiYpOtsutskPnnqBiEDDLtd6NsQFHWzQM16MNKIV0ie0r62wEm6mqT+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:21:52.8521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9666fa8f-723d-40e3-eca2-08de6e2783ed
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4607
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

On 11:20-20260213, Francesco Dolcini wrote:
> Hello Suhaas, Bryan, all
> 
> On Wed, Feb 11, 2026 at 04:51:09PM +0530, Suhaas Joshi wrote:
> > On 11:11-20260211, Francesco Dolcini wrote:
> > > On Tue, Feb 10, 2026 at 11:50:14AM +0100, Francesco Dolcini wrote:
> > > > On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
> > > > > Do you mind copying a boot log to a pastebin for me? I thought I had one 
> > > > > of these boards but I'm still digging around for it. 0x80000000 should 
> > > > > be where we load TFA now days unless some boards have opted out of 
> > > > > letting U-Boot move it to the bottom of DRAM
> > > > 
> > > > Here some more logs
> > > > 
> > > > https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed
> > > > 
> > > > The files are named with the commit sha that is tested.
> > > > 
> > > > On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
> > > > > Verdin boards are the only ones that are reporting this issue. Is it
> > > > > alright if we revert only the two Verdin-specific commits, and let the
> > > > > rest (TI and PhyCore ones) stay as they are? The patches are pretty
> > > > > un-connected to each other.
> > > > 
> > > > Verdin AM62 should not have anything special, the code is all there for
> > > > everyone to see, including the defconfig, the DT and so on, and the changes
> > > > we are talking about to me are self contained withing the SoC. Something
> > > > is wrong, and we are not understanding what yet.
> > > > 
> > > > I just retested once more 42b3ee7fa524 and it just hung, you never know
> > > > if I did something wrong. And for what matter this was spotted by our
> > > > CI.
> > > > 
> > > > > We are working on figuring out why Verdin is seeing these issues, in the
> > > > > meantime.
> > > > 
> > > > Anything I can do let me know.
> > > > 
> > > > If it matter the board that I am currently testing has 1GiB DDR RAM, and
> > > > the SoC is a AM6252ATCGHAALW. 
> > > 
> > > I was able to trace the issue to the get_ram_size() in
> > > verdin-am62.c:dram_init().
> > > 
> > > That function walks the addressable memory range to dynamically detect
> > > how much memory is available.
> > > 
> > > Not sure on the proper way to fix it however, Bryan? Suhaas?
> > 
> > Yes, this does seem to be the issue, even in my digging. I have sent a
> > patch to fix this. But since I don't have boards, I have not tested
> > this. Could you please test this and let us know if it works, or if
> > there are any other issues that pop up?
> 
> With commit f9ffeec4bdcf ("board: toradex: Make A53 get RAM size from DT
> in K3 boards") merged we had our CI running on our whole board farm
> last night.
> 
> Good news: the issue is confirmed to be fixed on Verdin AM62P and Verdin
> AM62 [Quad|Dual] with [1|2]GB RAM.

That's great!
> 
> Bad news: we we do still have a boot failure regression on Verdin AM62
> single core with 512MB RAM. I have no idea if this is the same issue or
> a different one, but from the logs it look different (despite that I
> decided to keep using this email thread and not start a new one).
> 
> The failing board from the logs uses a AM6231ASGGHAALW SoC, maximum
> frequency 1GHz, we also have another device failing, single core again,
> with maximum frequency 800MHz, the working one have 1.4GHz max
> frequency.
> 
> Worth noticing the errors
>   Failed to set clock rates
> 
> These are new compared to the previous U-Boot release, it affects also
> other boards, and I have no idea if this is related to this issue or not.
> 
> Logs of the failing device (U-Boot is commit f9ffeec4bdcf1da655a0ffea482062adde78fee8)
> 
> U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
> Failed to set clock rates for '/a53@0': -22
> SPL initial stack usage: 13456 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> 

I don't think this one is related to the firewall series. Not really
sure what the issue is. Just to rule this series out -- could you drop
my patch(es) and check if this specific device boots?

Was this device booting earlier? Could it be a build misconfig, since it
says that it can't detect an image signing certificate?

Regards
Suhaas

> 
> Logs of the booting device
> 
> U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
> Failed to set clock rates for '/a53@0': -22
> SPL initial stack usage: 13456 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Authentication passed
> Authentication passed
> Starting ATF on ARM64 core...
> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
> SPL initial stack usage: 2048 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> U-Boot 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> SoC:   AM62X SR1.0 HS-FS
> Reset reason: POR
> DRAM:  1 GiB
> optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> Core:  160 devices, 35 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> Loading Environment from MMC... Reading from MMC(0)... OK
> In:    serial@2800000
> Out:   serial@2800000
> Err:   serial@2800000
> Model: Toradex 0073 Verdin AM62 Dual 1GB ET V1.2A
> Serial#: 15412849
> Carrier: Toradex Dahlia V1.1D, Serial# 11287113
> 
> 
> Unfortunately I do not have a single core board to test readily
> available now, and I will be out of office a couple of days, but
> I decided to share this immediately so that we can try to understand
> what's going on. Middle of next week I should be able to do more tests.
> 
> Thanks for the support,
> Francesco
> 
