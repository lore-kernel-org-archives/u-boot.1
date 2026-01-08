Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3639ED185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA898398D;
	Thu,  8 Jan 2026 14:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EZbA87im";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBDC6839A5; Thu,  8 Jan 2026 14:32:03 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947B083980
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pULRJNEzYFWvFvY87hcZjn3kxuyxJ6LN2fZkBMHxsEmIOus4bxvfEZO12i47zuM3Pw92P/mRFRIWNrUYhssR7clIp48wII+Qyf4X1JYds7WSEz+H/UmB2NA+orwI+sJ+fd5hYMkjncF3zhdPPl2c9gA1jMszsgJypIUv2dWivB/BDjVm+ILsx8m81UFXc59NQnmuEBfhqTrc8lT1YIcNTctaLDg52x9aK/4SS9v2+JHMWwXT5YVPBXizdjkxwZjFLXUr9p2KXlDfFgaaazvVmprq0aQQahefAA0vkpzOzvxkOuy+dFZ8sYr1zmDuN118iUeJRFuE+LvCUCx4wx171Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBv28tnRs3OS8oy+I8L6jF+7zstrI0jyRu1P7HtJ2qQ=;
 b=MqavcBmhowkI7vUjR3bI61oo8KNYgKMGaC9RsDsmddeNnule9QdZtAyy6DC/0m/nb8b1b5TEERI+WymkNHOYSZ/i40vCUUBdi6IYuZNEDi3PKPsqaIEOofqStjt52UmQjODE/Wu8L34JkC2duW1GFPW//7OGoXW6RMOH4yvQHTIuitcpMZqooiI4debi9ZCVcd1kXRdXSoutCLNHI4e+FLVTolH1CWU2WELaiAb5xuuShPJV4QD6LnOFxBFe1i7EOBPJWxLBRGr4CRg5NXaeIe6FYOWmEN59VT2eHtB+SR2XODVH4+JEoxCNFBNOVQhW3jd6PUrFoD17ugSOC6SE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBv28tnRs3OS8oy+I8L6jF+7zstrI0jyRu1P7HtJ2qQ=;
 b=EZbA87imN5wbWolyIdj0erD6TJaTKwPaH2Kx/Ljf3t03ZgksqQX9yVZImmOXFM1L+fea7AHB8lyaxVDwOWyzFJ5ZT1t7DFEhVV4IbJ4ksaCB1X6IJqSf2H6/735ah52G2SEeU7i3Mgw1FTSMIkioZhnJm5lTvBPso96f+2tOuAk=
Received: from SA1PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:2d3::23)
 by LV2PR10MB997779.namprd10.prod.outlook.com (2603:10b6:408:378::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 13:31:58 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::c3) by SA1PR03CA0011.outlook.office365.com
 (2603:10b6:806:2d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:31:56 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 07:31:54 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 07:31:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 07:31:54 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608DVsPw2554852;
 Thu, 8 Jan 2026 07:31:54 -0600
Date: Thu, 8 Jan 2026 07:31:54 -0600
From: Bryan Brattlof <bb@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: Nishanth Menon <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, 
 <praneeth@ti.com>, <vigneshr@ti.com>, <khasim@ti.com>, <afd@ti.com>
Subject: Re: [PATCH] doc: board: ti: Add AM62D documentation
Message-ID: <20260108133154.5hitufe7wnsyaraa@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260105183545.4108567-1-p-bhagat@ti.com>
 <20260105185909.t7xv4xjl3xzw4d6m@granddad>
 <d00d6af8-2c14-4d33-a24b-68a13dee6aba@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <d00d6af8-2c14-4d33-a24b-68a13dee6aba@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|LV2PR10MB997779:EE_
X-MS-Office365-Filtering-Correlation-Id: d656cb55-0866-4a10-be8d-08de4eba4b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|34070700014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDduTXRCMlhJSUJjbWlNLzJHellOK004YmE0WXVGVWh4UEs5cnllRHoxdmhP?=
 =?utf-8?B?TGFMczlrS1Uzd1l4RTVoRGpBQ1RKOFJ5VTJmVlJzaVdjcEdRQlFkdzdDRmF3?=
 =?utf-8?B?Z2tiL2c4RGdkRWRSLzJTVytVN2w5Y2c3RWRWNG9aQm1SVk9QdVQvaFNCRmRY?=
 =?utf-8?B?MzRSVkFPUVlmcmwzYlpnLzZ6dVRlUllHMW4wR0dtT3RKUkR5Y2tKVFVOaGR6?=
 =?utf-8?B?K2M5SDJnY1JwVDViTEsrSTBVSE9RUkZtZ0hqN1daOVFjTmlrWElVS0g3dE1o?=
 =?utf-8?B?a09zWXM5Z3FBV2hYQXlROTJRM2FZaCtlSnFsbktpb21IeW11S21PSnN0eXVF?=
 =?utf-8?B?Y2lUWWdtWVpEVmI4cVJxaWtDcnBxY0hQZDI5R3VaaFFaRXlXcFZocW9PdkJx?=
 =?utf-8?B?My8rWlFCTEpUWWh1N2U5dHU0dS9qSC83cmR5VS9kUXpQSHFJempocjBFZW05?=
 =?utf-8?B?WG9kNVh5YUZiNWtQM3I4OGtMYStEQzFkdUxVUWNXM3lnRUMycERxL1hZcmV5?=
 =?utf-8?B?U1NjSGxTblYvVXVWN1lVcm9lNExUQTRFYTExbGRVazJheUc2azd3N3BIWWU1?=
 =?utf-8?B?R2NlakorNUJMWlI2ejFzT2hRWDNQMlpVWWdpNEZzOFJHNzZJSmlFaDZEc3l5?=
 =?utf-8?B?RHZPTE9jVnU3NXU0VmNhUy9DVTRrMEtVc2tEb3VTYWhOS1VKMGVVTkNIc3pW?=
 =?utf-8?B?V2I3SExvaHdQY0N3SjRrcnJQVkQvMmpSZ1hZdi91K0w2NENoSW5sZUJ4aTF6?=
 =?utf-8?B?S2ZjUTZpS1NMS21GMGJWY0NmRXFmQkF2SzRQQytLUlUrZ0pPWW8vc244b3Fs?=
 =?utf-8?B?dEFBZGY0azc0aC9kNG5xVm12c0FZMHQwWThuVi9JMkpiaERQVG83ZXRrbi8v?=
 =?utf-8?B?ZnBneG9PbG5jOUdRdW1hRGRtck10Q2FkVW5vKysrUC9NUVZieG9aZXgzd3Vp?=
 =?utf-8?B?c2ErSFRvdy9QRHhwazVycjVtSzZQcHM5NGdPR2ZteXp3SnZSZml6N3hLemtx?=
 =?utf-8?B?bW8yb3plSlJ1Y1lwUGx6MHJLQktwRTVEd0xsdGF3WjIrZnZkN0o4VnJWUHFv?=
 =?utf-8?B?bmovL01PcnJqZlV1NjVEVXlOR2R3UVpwLzdzTkdRL09PTzhzM2psK2JJQStI?=
 =?utf-8?B?Sm4wZjVPRllKUXR3anYyaGtwaFRnbWI3b04zUFZHVWxxM3dsNkFJcVVLSUQy?=
 =?utf-8?B?L3FkS05hZktuQXdvMlQyV3QzcWlzbmJ3Vm4ya1RsUlVwQzNURWgzQzNZd2Fh?=
 =?utf-8?B?WGRaMXpER3lpVWY2RGRuRWU1Rkg4U2FNbzZ2SXJOM3htMlpEL1BRTi95bkE0?=
 =?utf-8?B?S0l0UjJIblB0Z3I0S0hxMW02alJRQTIwaTlsZWtrQVlRNjIwTGJvWWRRS1lm?=
 =?utf-8?B?ZU9yMnhQMmxLbXk1clkvQ0VPMFBidXBJVFk5Z3NmM0NXNDRTN24wSnRnaWZy?=
 =?utf-8?B?cldXejZkWVFPK3FtV1hrMExYUGdpTm1PaURmekVsdDh1NnA5Y2htK05ZY1Nm?=
 =?utf-8?B?OEtDNVh6MW5pcW9EN3MySnRxRFNtRUYyOFZrN3RWNzJYY2U4dFloNE1MR3lZ?=
 =?utf-8?B?YjhwdDVlRk1wdWlNZzQwUXQ1cGl0RzBKVUo5b1R5b0hJZmlLTTFuYU1teVR3?=
 =?utf-8?B?YUgrYzg1eVZsTk5TNVFIaFRjNDh3alplWTZYOW9ZWm1WOGpreG9aUjFBNUx6?=
 =?utf-8?B?ZHplWFJHNXV3RHlVZFo5dC9abEdxaGM0OGZqanNPNEhuNXVlcGNzSittcWNK?=
 =?utf-8?B?RWc0bEVrOHF4K1ArbVovQmEydEtpdWR3RXg4Yjg1a0dNSWE2NUNDcXFmZEwy?=
 =?utf-8?B?NUlLOUtza1lkWVVJSmRmTFNMOHNteFpzL2s0enJGRFdpSnJocVZpWk54TnBl?=
 =?utf-8?B?c2dQTi8rTlByWUYvYUxvYWRweUlpTzFOb3J0N0JxRnRXVEk1OU8xQ0t0YlRG?=
 =?utf-8?B?TWJlUWJmam82MCtZZ2NEdTBHNEYwVXcycm5BZGhhWkVLZU9RK3lPWmVsdkRh?=
 =?utf-8?B?Q2YrUEsvVForZlJQb1U1S2E4c08xSDd2Tk4yR1pXTnZiNTFCMEdZR0JrZXRi?=
 =?utf-8?B?bW1wYUtJZkVkYmROaDFBUmNnRStyaTg4UWJpNDVLd1BHLzJKdm5ZVk5ESnZ4?=
 =?utf-8?Q?bEYY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(34070700014)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:31:56.7283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d656cb55-0866-4a10-be8d-08de4eba4b55
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR10MB997779
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

On January  8, 2026 thus sayeth Paresh Bhagat:
> Hi Nishanth,
> 
> 
> On 06/01/26 00:29, Nishanth Menon wrote:
> > On 00:05-20260106, Paresh Bhagat wrote:
> > > Add info of boot flow and build steps for AM62Dx EVM.
> > [...]
> > > +  **OpenOCD support since**: August 2023 (git master)
> > > +
> > > +  Until the next stable release of OpenOCD is available in your development
> > > +  environment's distribution, it might be necessary to build OpenOCD `from the
> > > +  source <https://github.com/openocd-org/openocd>`_.
> > > +
> > > +.. include::  k3.rst
> > > +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> > > +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> > > +
> > > +To start OpenOCD and connect to the board
> > > +
> > > +.. prompt:: bash
> > > +
> > > +  openocd -f board/ti_am62a7evm.cfg
> > * Are you sure this is the location[1] ?
> > * is am62a7 correct for am62d ?
> 
> 
> Yes, since they have same core architecture and count (also verified
> locally).

What version of openocd are you using? You might need to update some 
packages on your host.

~Bryan
