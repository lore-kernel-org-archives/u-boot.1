Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A74E9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 01:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FE183AA9;
	Thu, 19 Feb 2026 02:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ikVpR0vZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453F583AC5; Thu, 19 Feb 2026 02:46:14 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FBC83A47
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 02:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGF9k101HdhTWh3dcoh57KhhKWQ8uh0uOPAxfO8HauVk7Kez6F1UOarSgtjfeWOumS5yPJUQ3YxPlP39/LBYKaFy/VhH/HRD3cMi1KEjdnEypgQXTjWYiTOyHEo5dMRqAEyNI2F3UnlvSI9IErmHA5EWUlSUhynNR+/hgMvSFTUc/slFmzQZ9e/t9iIvNRgdJiYre33QmVtSV8z0IVinCUI7dqJFF1fjgrJK6+LL6wjEyC4gQA2iL7djLdr8oPpjUV4YIwSN7g7D8BftmlS4XEYnCZgdySL/OKd/A7S62rsEFoJpnuXrm+CiLQvo3W8uRMcf9w8F0QRcT7E5DueNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qVwdZZ9NCf+kNoL0f35k6QQJfK4GblEoDSuJAiPujI=;
 b=ICIstl41A4tB3psdjw1uutT8upHXtJ42brxxQgWudfpj0dHAyv1rhMctYICU1u7XYFIie95vt16FN8Wq4xnRbYMVn7/+MFqznDMS6WMUv1Ivtwg9LzR5xag/XXbyUTP0ikOp/x2ICDPP39gXHLJ1xHhvePBXcA8iSOilIvEeLQvQYgS10qh9SjIf3OIdY5bGBFb3Z8RD+isMN8tWQ7It1pAcy2h0PieUZfHrYuESzol6ocIF0qYqCc/AWE0/nrmQR79Z0iti4qKEquaHyf7Nk+TJL21h0IJPKO69aKUTQ8pcjiNMe7LQXWU+Nm8EestQXeG/895EA8D8qRaRI1CeMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qVwdZZ9NCf+kNoL0f35k6QQJfK4GblEoDSuJAiPujI=;
 b=ikVpR0vZCWIpbpvsoFR0kEbiRlh6QGI7XC3Qxqwf9l33Ik0oQz+utcN2KgfoOOx2RvdO2o9XDRUV7jBX1UmB1hVIAaINuUYJngiQly8nTPcNUTkhWykAzCppfznOBlrkTa4dmeO4TBJEx/j7xZEOTEFaccmXkXpd5sTcmDIoNrY=
Received: from DM6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:333::16)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 01:46:08 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::7c) by DM6PR03CA0083.outlook.office365.com
 (2603:10b6:5:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 01:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 01:46:07 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 19:46:06 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 19:46:06 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 19:46:06 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61J1k6hQ1799350;
 Wed, 18 Feb 2026 19:46:06 -0600
Date: Wed, 18 Feb 2026 19:46:06 -0600
From: Bryan Brattlof <bb@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260210092646.w5bugrscifmsh5px@ula0507357>
 <20260209202001.saeaf6l2kz57rufg@bryanbrattlof.com>
 <20260210105014.GB214446@francesco-nb>
 <20260211101113.GA176369@francesco-nb>
 <20260211112109.56e27kyy4coqpcbb@ula0507357>
 <20260213102015.GA10715@francesco-nb>
 <20260217132150.of5l5qirxkeizsne@ula0507357>
 <aZVjSOzCH6ZP3CjW@gaggiata.pivistrello.it>
 <20260218145241.GA179991@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260218145241.GA179991@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SJ0PR10MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a05bd0-dc60-4c95-bda3-08de6f58a681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R29zWEZ3Q0J2NWtNeTBNN2xEK2hnS1pYWlBEZHdzNm1XZ1gxdEM5aU85T0dX?=
 =?utf-8?B?ZGNTTWxWdEYzaTNVYlJhWERMYmthd2dxQTBjcHhhaDUwTFNsL296ZFZWaUNx?=
 =?utf-8?B?bEY0N2I2bXhDelR6Zk1JeVl1ZkhHTUV3ZXBVNFdwSXE5UTF0ODFuOXhCTEI0?=
 =?utf-8?B?bm9UWDM3aVJEY3JFaW9GZ25nTS9Zc0NwUWlFWis0UzVybzN3RWFEeWF4TFhw?=
 =?utf-8?B?aEwrcGVqcHZicXE3Tkdha2RZT3JxVTNHUnE0eVRWalo0UzYwRG96QzJhMFdv?=
 =?utf-8?B?ZWZkQ2htaGJQTHJMVHU4Y0tzTlJuMm0vTVVwV3dqUXE4Nm5FREdzTTIrdEN4?=
 =?utf-8?B?TkpKR1AyQ1g3MGk0eTRxTUhVeDRST1dWajNjTHNiaCtKMlVvTmwvb0gzdW5H?=
 =?utf-8?B?MmhLUjV2VThDUG9PQ3d3UlFGVEo2eWNiOUQ0QTNIbFNLeTdDc1JYczlRRysx?=
 =?utf-8?B?RHpkWWhJQWtNNCs4R1FkTDlsSmNoTnk0WVFqejk2QkYrK3ZLQ2ZKemRyVGd2?=
 =?utf-8?B?L0RMclhVM2Jiak96R0FYWGpyVFBYS0w4QjZjWlZYMmxXNlBnaGVZR2FyQTdO?=
 =?utf-8?B?Rk9tRUtBeTBFRVZGdWNIVkxJeHVPZmVDWjlNVUR4blBaaytrdkJaQWp2QjA1?=
 =?utf-8?B?aXRzVjkxVmFEb2xlR002SnFONk4xellPaTJYM2hJRndWVE80ck9CcEFYTEpl?=
 =?utf-8?B?eW1tRG15S0pIZVh1QXh1MDBoWXFlS2xaOVJ3QUhiSkRab2NBVUIxZVJXUEFt?=
 =?utf-8?B?MnQvRTNialRHU2JGZXdHVStlRW9xUXRUUGgxNTltVHlEMHVLbm91V0o5aEpI?=
 =?utf-8?B?MzVSMEoyOERDU1RITmVHaFJ1Sk1PTS9hZmk0TEp2aXpLaDNtWUp3aHk1OUx5?=
 =?utf-8?B?djZsdnBvMXhkV1FRSXk0dHdGczQ0Mk1mQTBvMHpjQXM5SWxSQ2xJS3NVbjJu?=
 =?utf-8?B?bEREV3pJaWlWTkRKRys1T0hBRXNGbHA3QUNvalo3MXNyYXVEL3RkaTdKeTh5?=
 =?utf-8?B?VkczeCtmNnlPVDFKanltQkF0Vm9oNU1BSlN1SHF0OEsrVlUwL0V3NlV5ck5L?=
 =?utf-8?B?V2lQaWNORXMxYnhFTGF2TnFZY1phOWZuTk11WWxOS29Zei9GT1VWRnlubXhY?=
 =?utf-8?B?Z1pnaTY2TlVpR3Q0SUdMeHNSbXg5Z3VzTUVoOUUwY0FCVGJvWXhwamRCcXRU?=
 =?utf-8?B?NUFvM0RMQjloTzkrWThsWHY2QVBKVUhMQklqOGdZWE5oelZQTUhLR1V4Tmd4?=
 =?utf-8?B?Nm1ScDYvT1RkRmovYmF4aTdaRmhXQ2dWTnhDQjBpUnFhLzZHdnBpUnlVeXNo?=
 =?utf-8?B?dGtSRG85NWxDRjFGRk1mU1RaQnNodncreXN3OS9YT3cwcnUzZkh0dDVrYWpm?=
 =?utf-8?B?eDRtbFZlUDVIbWxjZzNsdWFid3g0ZXROWU05djJoQXVCT2QybHoxTGRjYk92?=
 =?utf-8?B?QmRWVkZ2YUgwNjFxOFFNNjZ6NmgyYzNORlBISkZOeHlCSm1iM00vL01VV0Iy?=
 =?utf-8?B?VXdzZmdpRWFQdWUvOVNneGoxRXdPYURnSHpzYmNaejM2NkFRWGlKL3IwMTdo?=
 =?utf-8?B?UFhTTUpCOGJtYm9tUUt4U3VMVFpSdG1aTFNObTVsVTFjRjl6cS80Z0F4b0NF?=
 =?utf-8?B?NjFLZEp6TmdjeHlrMERvcFhZQms2TGdoSnRtYVd3Y2lHWExlOEdYTzF5a29n?=
 =?utf-8?B?V3JsYmNRVDYydVozVGpDTXMyMlhOYnR5b2hEaWVmazJvbzJRb1dZUWcvOU1j?=
 =?utf-8?B?Wi9LNSs1ZjlYYlR2TW8zeFZtbk13QWdJMnZwdzlLVllZbzF2VXV4ekZqTC9h?=
 =?utf-8?B?UTVkaDJJdncxanpoaS8xSzVFNCtJNEJZeXRlU2FtNXI5NFJNOEkxMWJWU3B0?=
 =?utf-8?B?RFNZL2JCZ0ZXTnF1c0h6ajk3RkxuaHNrbEo1VzBKcVRJMFEyMFgzSnBzQzJo?=
 =?utf-8?B?UW9wUCtORGhqaHRwUU4vQzA0UEFobmx5dVg2cUN4WGJaejZWZENIQTk2V05W?=
 =?utf-8?B?N3pRYW9Nc1J5SUtLeWZlTTh3WWRWOU11VllobUZKcEEzYWI2V3p2Zk9rN0dk?=
 =?utf-8?B?cDhEdFA0QXZCQ0NGT0RWMnlJVDNFSWgxQmhNaFp6b2VUbFBlMk8rVXFCbHR1?=
 =?utf-8?B?L2YrNC8yK05ISTdpa1FyZDdIdHRaVXBzUG1mbHFKOUg2ejkwMHNuL0lqWlZL?=
 =?utf-8?B?VkE9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w6v2BRrIHoJs8JZ9E81fl7EkW95feB2aRfyRhQYMDd9ukpRlI0h+PR46pS6RiGAfng+9Vla33cuNtlDBmLnr00sVa8kz2wOWAV3CUSYJN3RYzsqluBbaejEsjJxGu5xmDrxUfyWyEsrjkmP/cbjvM7fNz3AkbQvTPN5z1zXPu7n/+d3oxT3EvIagTNzl/lZ6wMDi/dppU7WOCXjko3yRK/eB0jeuAMfO7A068V2xcc+TKG8oMPYUeJacxMMHQIPnAkQn18DYQdUcqykgL1ROKMLgOagsawL722B+i2NLZqj8I8ILj9E06h3whxXfpX2WD6DaDjGQE1H02xyMkUDIle5PL3BO36UeI0ZQRSoh5AIQ4yOzjLfbCacr5Ja4C7up3bJQK3s6g51fQjgEQ3bpeB9ITNTviRQ/E8vF3IUEDPBRAd0fs/3nhsGYW7sJtnFf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 01:46:07.3449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a05bd0-dc60-4c95-bda3-08de6f58a681
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
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

On February 18, 2026 thus sayeth Francesco Dolcini:
> Hello Suhaas,
> 
> On Wed, Feb 18, 2026 at 07:59:20AM +0100, Francesco Dolcini wrote:
> > On Tue, Feb 17, 2026 at 06:51:50PM +0530, Suhaas Joshi wrote:
> > > On 11:20-20260213, Francesco Dolcini wrote:
> > > > On Wed, Feb 11, 2026 at 04:51:09PM +0530, Suhaas Joshi wrote:
> > > > > On 11:11-20260211, Francesco Dolcini wrote:
> > > > > > On Tue, Feb 10, 2026 at 11:50:14AM +0100, Francesco Dolcini wrote:
> > > > > > > On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
> > > > > > > > Do you mind copying a boot log to a pastebin for me? I thought I had one 
> > > > > > > > of these boards but I'm still digging around for it. 0x80000000 should 
> > > > > > > > be where we load TFA now days unless some boards have opted out of 
> > > > > > > > letting U-Boot move it to the bottom of DRAM
> > > > > > > 
> > > > > > > Here some more logs
> > > > > > > 
> > > > > > > https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed
> > > > > > > 
> > > > > > > The files are named with the commit sha that is tested.
> > > > > > > 
> > > > > > > On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
> > > > > > > > Verdin boards are the only ones that are reporting this issue. Is it
> > > > > > > > alright if we revert only the two Verdin-specific commits, and let the
> > > > > > > > rest (TI and PhyCore ones) stay as they are? The patches are pretty
> > > > > > > > un-connected to each other.
> > > > > > > 
> > > > > > > Verdin AM62 should not have anything special, the code is all there for
> > > > > > > everyone to see, including the defconfig, the DT and so on, and the changes
> > > > > > > we are talking about to me are self contained withing the SoC. Something
> > > > > > > is wrong, and we are not understanding what yet.
> > > > > > > 
> > > > > > > I just retested once more 42b3ee7fa524 and it just hung, you never know
> > > > > > > if I did something wrong. And for what matter this was spotted by our
> > > > > > > CI.
> > > > > > > 
> > > > > > > > We are working on figuring out why Verdin is seeing these issues, in the
> > > > > > > > meantime.
> > > > > > > 
> > > > > > > Anything I can do let me know.
> > > > > > > 
> > > > > > > If it matter the board that I am currently testing has 1GiB DDR RAM, and
> > > > > > > the SoC is a AM6252ATCGHAALW. 
> > > > > > 
> > > > > > I was able to trace the issue to the get_ram_size() in
> > > > > > verdin-am62.c:dram_init().
> > > > > > 
> > > > > > That function walks the addressable memory range to dynamically detect
> > > > > > how much memory is available.
> > > > > > 
> > > > > > Not sure on the proper way to fix it however, Bryan? Suhaas?
> > > > > 
> > > > > Yes, this does seem to be the issue, even in my digging. I have sent a
> > > > > patch to fix this. But since I don't have boards, I have not tested
> > > > > this. Could you please test this and let us know if it works, or if
> > > > > there are any other issues that pop up?
> > > > 
> > > > With commit f9ffeec4bdcf ("board: toradex: Make A53 get RAM size from DT
> > > > in K3 boards") merged we had our CI running on our whole board farm
> > > > last night.
> > > > 
> > > > Good news: the issue is confirmed to be fixed on Verdin AM62P and Verdin
> > > > AM62 [Quad|Dual] with [1|2]GB RAM.
> > > 
> > > That's great!
> > > > 
> > > > Bad news: we we do still have a boot failure regression on Verdin AM62
> > > > single core with 512MB RAM. I have no idea if this is the same issue or
> > > > a different one, but from the logs it look different (despite that I
> > > > decided to keep using this email thread and not start a new one).
> > > > 
> > > > The failing board from the logs uses a AM6231ASGGHAALW SoC, maximum
> > > > frequency 1GHz, we also have another device failing, single core again,
> > > > with maximum frequency 800MHz, the working one have 1.4GHz max
> > > > frequency.
> > > > 
> > > > Worth noticing the errors
> > > >   Failed to set clock rates
> > > > 
> > > > These are new compared to the previous U-Boot release, it affects also
> > > > other boards, and I have no idea if this is related to this issue or not.
> > > > 
> > > > Logs of the failing device (U-Boot is commit f9ffeec4bdcf1da655a0ffea482062adde78fee8)
> > > > 
> > > > U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
> > > > Failed to set clock rates for '/a53@0': -22
> > > > SPL initial stack usage: 13456 bytes
> > > > Trying to boot from MMC1
> > > > Authentication passed
> > > > Authentication passed
> > > > Authentication passed
> > > > Loading Environment from nowhere... OK
> > > > init_env from device 9 not supported!
> > > > Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> > > > 
> > > 
> > > I don't think this one is related to the firewall series. Not really
> > > sure what the issue is. Just to rule this series out -- could you drop
> > > my patch(es) and check if this specific device boots?
> > > 
> > > Was this device booting earlier? Could it be a build misconfig, since it
> > > says that it can't detect an image signing certificate?
> > 
> > This is a regression with 2026.04. 2026.04-rc never booted on this device, and
> > before commit f9ffeec4bdcf1da655a0ffea482062adde78fee8 none of the verdin
> > am62[p] variants were booting for multiple bugs that were present in the
> > release.
> > 
> > 2026.01 is booting fine on this device, with plain vanilla U-Boot.
> 
> The issue is still there, and it seems again related with your changes.
> 
> Can you help? Any test that I should do?
> 
> 
> 
> v2026.01 booting fine
> =====================
> 
> U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:15 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> Changed A53 CPU frequency to 800000000Hz (K grade) in DT
> SPL initial stack usage: 13512 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Authentication passed
> Authentication passed
> Starting ATF on ARM64 core...
> 
> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> 
> U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:38 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> SPL initial stack usage: 2048 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> 
> 
> U-Boot 2026.01 (Feb 18 2026 - 12:12:38 +0100)
> 
> SoC:   AM62X SR1.0 HS-FS
> Reset reason: POR
> DRAM:  512 MiB
> optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> Core:  159 devices, 34 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> Loading Environment from MMC... Reading from MMC(0)... OK
> In:    serial@2800000
> Out:   serial@2800000
> 
> 2026.04, commit 3243a73102c3 ("Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sh"), booting fine
> =================================================================
> 
> 
> U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:33 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> Failed to set clock rates for '/a53@0': -22
> SPL initial stack usage: 13512 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Authentication passed
> Authentication passed
> Starting ATF on ARM64 core...
> 
> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> 
> U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> SPL initial stack usage: 2048 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> 
> 
> U-Boot 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
> 
> SoC:   AM62X SR1.0 HS-FS
> Reset reason: POR
> DRAM:  512 MiB
> optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> Core:  160 devices, 35 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> Loading Environment from MMC... Reading from MMC(0)... OK
> In:    serial@2800000
> Out:   serial@2800000
> Err:   serial@2800000
> Model: Toradex 0071 Verdin AM62 Solo 512MB V1.2A
> 
> 
> 2026.04, current master, commit 8666b16015d4, NOT working
> =========================================================
> 
> 
> U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:31 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> Failed to set clock rates for '/a53@0': -22

Hmm It's interesting to see this start to fail. 

> SPL initial stack usage: 13464 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Authentication passed
> Authentication passed
> Starting ATF on ARM64 core...
> 
> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> 
> U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:54 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> 

I'm suspicious of the spl_enable_cache(). I've witnessed issues if we 
add MMU entries that are not backed by DRAM which can cause the MMU to 
crash the CPU.

I wonder (complete guess right now) if we're passing the correct DRAM 
density to the A53 SPL?

~Bryan
