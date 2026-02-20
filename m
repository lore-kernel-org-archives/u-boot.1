Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE8AC55AB9
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 13:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3690483C39;
	Fri, 20 Feb 2026 14:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JNRvK6wl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0577883CF5; Fri, 20 Feb 2026 14:23:52 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC6A83AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 14:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coxwj+KzpFQTpscagdGeP8jTQ9Ol2gsgf0Yeg39NIUonS30yPHNxVU3nooTd90jKA/sgSCdsBY2hSeEilwx1jqBmL0HGY4mtA04VvFewxybi01n8G5a4M09OCCfGp0IkRyk4d5uoNUdSz9v5k09sedZP5ruem7pCNna9V0qW9prJouXklJ4239QWbDe+UQ5Awpjfb3Ft0RN6q9qdCigYCZ665mf9iMHfvurwAUBguEbnVa9fZyaTf6Pm4H5oNBeQOGHjN/n+CByQ0Bb0OD91OFJaRA2bgth9nQzoz9R+GZ78U1Sql7T8TSzlHhKchpydliJTrXjMVNUtj97E4vg3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8lstthgPmixCT0hZMaCM3Oc8A4nfn6Mqym2cA4oL6I=;
 b=gglYKsIyE1KT/fh8BWonsf3PCOc5Wd1uGNMwnh+jxw1ghMF5mAMZ/7s4VNQEAeMB3HOmfAEHvgRm+rrP3nsYBh9p/GuWWYn2TB4kAMFLQDKiqItKzMPVDP3CJFjJpBYBxXEbTKmQYCyErNFfa/6vMshjrfLUCEFa4zyzZUZ47JrMls2Eoglma2gRXoEVc+DSdGk1N3pSOYx3OlyJicASSW8KC2FOeWKyAiFS6+KdxvhprInfsEnI5yI57qMS4wwRnXUjMTYALXrZK/cLJC8ddI5Z5rnTyudf2a4bPR502LA2JE74+u/qTwYH9p0MjG5Po7FwGpgNzLu3a9XuOigZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8lstthgPmixCT0hZMaCM3Oc8A4nfn6Mqym2cA4oL6I=;
 b=JNRvK6wlsIJsiYPt869wVqnz6Of6lc8qTqcE1/41SA/lyTV5VgyctGDh9T57vt4qvbmQDQTBW4G/+DBk8zDyGS3A6ESi9V9JOZnav0LHDhWdgpd/kvl7Kv/8CT/dXIs3Pmvd8UzcD0Af2p3Bpu3wkS5/lQ/Ad9D3UyL8VIsSF8M=
Received: from SA9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::24)
 by LV3PR10MB8084.namprd10.prod.outlook.com (2603:10b6:408:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 13:23:44 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::59) by SA9P223CA0019.outlook.office365.com
 (2603:10b6:806:26::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 13:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 13:23:43 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 07:23:42 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 07:23:42 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 07:23:42 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61KDNg8k3905014;
 Fri, 20 Feb 2026 07:23:42 -0600
Date: Fri, 20 Feb 2026 07:23:42 -0600
From: Bryan Brattlof <bb@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260220132342.did3zsxh63tlw3hd@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260211112109.56e27kyy4coqpcbb@ula0507357>
 <20260213102015.GA10715@francesco-nb>
 <20260217132150.of5l5qirxkeizsne@ula0507357>
 <aZVjSOzCH6ZP3CjW@gaggiata.pivistrello.it>
 <20260218145241.GA179991@francesco-nb>
 <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
 <20260219104020.4gzvbit3b7qqcoqk@ula0507357>
 <20260219193044.GA203975@francesco-nb>
 <20260220010527.mpji63idcn7vj74w@bryanbrattlof.com>
 <20260220104621.GA15099@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260220104621.GA15099@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|LV3PR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f129141-69cc-4648-ed25-08de708344f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OStDV25SY1NSN1piUnlHdndwNGhjUzk1RmgwMmtrazNBblJvenUrYVRVbW1j?=
 =?utf-8?B?SHBEVVhTdnBmcm93Q1dCSTVBRUZRVkxtd3N1Q3pkMUtVR09xY20zeTFRWmow?=
 =?utf-8?B?eWNSdFpWZUt2dXUrSzhmS0piWDhjUk9hTldSMHp4d0NNM1JiL0R3dDlUU3FS?=
 =?utf-8?B?Ri93b0FjaE52QmNiRktlc1cyVEtEZUYrWkZpRVh4bXo0Unh3YWJsRHVhb3hu?=
 =?utf-8?B?aWtQVlNhTDB4VzVNQ0tORkFoQkwwQklGaEtqa1JkUmpGK0I5MjI1Wkd1VGlr?=
 =?utf-8?B?c3FaSEdwMm9xMzI3eVNkYmJLdmwrVytjMDlZcXRHbjYxUjkwTXV2U2FJRVdq?=
 =?utf-8?B?WXVabkQ0eEZRWXBjdkxDMmJZZnd1RWY4RDJNcnFyNFhYTmhFMVdjbFB0azg3?=
 =?utf-8?B?UzkybUExR0txVDhoR0VpUzg5dGFKeVE1RnlXUWdNcFd4UXV5UVBQc0VIVkFw?=
 =?utf-8?B?WHBrV0wyZTZoUW5VSS9TclpCenlXb1g4UWRxN3IyM3pFTEphVzV4TTJlb1J0?=
 =?utf-8?B?elVDKy9aK0I3angxK3JIWmV0bWdZZUpYNjhNNDRxRkp4T2gxOTkwOEhuUlFp?=
 =?utf-8?B?VHlId2o1UVI4cjR0WC8zcDZjQnpBaHdQNE15ZGNFRnVOQUxySTVqazJOQWty?=
 =?utf-8?B?TERBdHl0K3llSWNqQ3drcjIwZkZtY3M1VytZcFlTOVlPV3hjd2hNWnMzSjM0?=
 =?utf-8?B?VjYxY1JwZlZ0cnI5M1lmYlphYlp3NG9tbEpEVnVwRnJZNmtIa2hPMGcvUTJi?=
 =?utf-8?B?K0pDNjZjSlJjQ2dsQ0FhL2ZXNTl4RTdLamdvb0ZxeXZWSDJzNU9tbGIzK1Av?=
 =?utf-8?B?TUNnZUxnQkJ3ekF3M0ZNUTgxUVIvVWtEMVZ5b3RFeTA1VzhOVGpMbnYyQUNs?=
 =?utf-8?B?SUNvdVU0VVpJWm83Mkh0QVQ2SytWWm80SUhiSDRXMllwOWM1NTRmeEEyanpG?=
 =?utf-8?B?VUxIWFlEM29Pb0YyMnI1b1BHeTlUZFBsQlBNS0g4THBCZnFKK2RwRGErQ3dJ?=
 =?utf-8?B?M0lvMFdDU2wzb0lTRHJuNkpWMTgxZU1kUENUVTNkOUFCaEdkN0xSV0hqWHlM?=
 =?utf-8?B?WjF1am91REJqQ3RxWTR5OXRWRFZBd3hDeXBJeTdpVjFDSFMxSkRyUzFDcTdH?=
 =?utf-8?B?Y29WcDhZaFBabUJEN1VxUFBrWmZUTTU5dDVPM1J0THFyT1h0QmkrTGtteHRL?=
 =?utf-8?B?SCt0aVlwSUtDdVc0WEd4RE9pUXE5Q0tGRXoySGIwV3lXZjdoUnl3L04wdkUr?=
 =?utf-8?B?SWFmU2ZtVklaZFh6WDVhWEEyeWFhTGRTNnJjTnBNSS9GRnVuZkF4dC9tTWlw?=
 =?utf-8?B?MXhzUzA1NlNOMEpvVzFLVFlFMXpRUC9mVGhnTmJSTk9HVlE2TVppRGRNa2ZU?=
 =?utf-8?B?U0xidjBEV1FXQ042enhOVjRBREFCampPK1FhNlZST1RCRUpJOFdLU3N0WVFS?=
 =?utf-8?B?Mzk3dEdQVVJSSVNjNW1tZllTejFLM2ptdmhZRHNtRkQzeTRxb2N4S3lEVTV1?=
 =?utf-8?B?KzM3b1g5MnlxYlNDUkJBcXhyai9rTGVUOXZMQ2h5SlovKzdxTUhQd2RnRTVR?=
 =?utf-8?B?cUFOWk00VzdaZkJubFJBeWlCU3lJbU1JbkJIVE53VEdkRm5DTXp0ZHdWdkhI?=
 =?utf-8?B?ZDBnOEh1blpoa0tRV3VLWUVzTWprQ0syTnhQS3B2bVJjb1h2TWQ0ekVvMWJH?=
 =?utf-8?B?VTBUYm94alliL0NuZ1BwMlVvVVFmUythekg4Y01Tblg2NUdVRlN3VHVMQUFT?=
 =?utf-8?B?Wkg0Yy9SNmd5K05WZEU1bEk5ZjhyTFVVZUVGUm5kcnRGNVpHalYvVmQ5Nlhm?=
 =?utf-8?B?N3ZRdGZhZkxwQi9QdGVuN2QyNUlORHd1cnVpaXQxdWt0WWc5YzJ3allXbmxH?=
 =?utf-8?B?KzA4OWUxdnlybTFOeXh6SGg2Qkk4d0IwUHBza1gwVktFNG9tS2p5VTlFSGhq?=
 =?utf-8?B?WnJNSko5UVRtODYrTzdrM2RFa05RNXF1ZVVYQWdEN3JsakpUR05PN21aNm9E?=
 =?utf-8?B?U0NyRkFUZmtJNGlLK2k1VktWb1JZeHBCVzNrUVA0aFRtZktMSThSWnNydEJq?=
 =?utf-8?B?eExXc2s5ai8rMzRGa3FUejdIRWhUU3lsVlNDZkJ0ajA4S2tTTTMvOTR5bGln?=
 =?utf-8?B?M0pHa3BQeGhzUmdUbnJxWitOVjk4Uk40cWVUU0dYMGhUMXlqSStnL0MyRUhH?=
 =?utf-8?B?bFE9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MIdQsLXVyqJ8zQXxWkgbn/eayAqLM1KNxjpf4guV19h9lWCAT/VfcdZ7KDX+TmdCPYej5gJOZJwLwzbJcv6on5NVV9jfETMudgNThZtUnjCF82ow17dx5UAL6V+b/ExTBsfzws2+H6MWYffefxdFM/8xYlKXvSl4oA00+n2lu3q7FQHkvBg+8bqUno4jMX6ywxunpwp7mgj3yY+miiXCzfER/m7rrs23OTuQ6g4CEp3aLU0B/fCaDclGJhRG2rlYjF+tSyysRfPUOSSILB2HIMTDCXqyJSmPc61mc651VZOgQcKIgoW6go6uSBX26vHy7d2oeYbnYv/DnpWFkH+o9VVLuhzXxoVPg8viqjiaufJ4X0Kfa7A/fxJXbQn/G4+iRU04Z03696sJJFGO20VhJDH1rIcs7PRONCkxNrhtJpRnHgz+8MuPr1aAzIfBrmXj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:23:43.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f129141-69cc-4648-ed25-08de708344f3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8084
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

On February 20, 2026 thus sayeth Francesco Dolcini:
> On Thu, Feb 19, 2026 at 07:05:27PM -0600, Bryan Brattlof wrote:
> > On February 19, 2026 thus sayeth Francesco Dolcini:
> > > On Thu, Feb 19, 2026 at 04:10:20PM +0530, Suhaas Joshi wrote:
> > > > On 19:46-20260218, Bryan Brattlof wrote:
> > > > > On February 18, 2026 thus sayeth Francesco Dolcini:
> > > > > > Hello Suhaas,
> > > > > > 
> > > > > > On Wed, Feb 18, 2026 at 07:59:20AM +0100, Francesco Dolcini wrote:
> > > > > > > On Tue, Feb 17, 2026 at 06:51:50PM +0530, Suhaas Joshi wrote:
> > > > > > > > On 11:20-20260213, Francesco Dolcini wrote:
> > > > > > > > > On Wed, Feb 11, 2026 at 04:51:09PM +0530, Suhaas Joshi wrote:
> > > > > > > > > > On 11:11-20260211, Francesco Dolcini wrote:
> > > > > > > > > > > On Tue, Feb 10, 2026 at 11:50:14AM +0100, Francesco Dolcini wrote:
> > > > > > > > > > > > On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
> > > > > > > > > > > > > Do you mind copying a boot log to a pastebin for me? I thought I had one 
> > > > > > > > > > > > > of these boards but I'm still digging around for it. 0x80000000 should 
> > > > > > > > > > > > > be where we load TFA now days unless some boards have opted out of 
> > > > > > > > > > > > > letting U-Boot move it to the bottom of DRAM
> > > > > > > > > > > > 
> > > > > > > > > > > > Here some more logs
> > > > > > > > > > > > 
> > > > > > > > > > > > https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed
> > > > > > > > > > > > 
> > > > > > > > > > > > The files are named with the commit sha that is tested.
> > > > > > > > > > > > 
> > > > > > > > > > > > On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
> > > > > > > > > > > > > Verdin boards are the only ones that are reporting this issue. Is it
> > > > > > > > > > > > > alright if we revert only the two Verdin-specific commits, and let the
> > > > > > > > > > > > > rest (TI and PhyCore ones) stay as they are? The patches are pretty
> > > > > > > > > > > > > un-connected to each other.
> > > > > > > > > > > > 
> > > > > > > > > > > > Verdin AM62 should not have anything special, the code is all there for
> > > > > > > > > > > > everyone to see, including the defconfig, the DT and so on, and the changes
> > > > > > > > > > > > we are talking about to me are self contained withing the SoC. Something
> > > > > > > > > > > > is wrong, and we are not understanding what yet.
> > > > > > > > > > > > 
> > > > > > > > > > > > I just retested once more 42b3ee7fa524 and it just hung, you never know
> > > > > > > > > > > > if I did something wrong. And for what matter this was spotted by our
> > > > > > > > > > > > CI.
> > > > > > > > > > > > 
> > > > > > > > > > > > > We are working on figuring out why Verdin is seeing these issues, in the
> > > > > > > > > > > > > meantime.
> > > > > > > > > > > > 
> > > > > > > > > > > > Anything I can do let me know.
> > > > > > > > > > > > 
> > > > > > > > > > > > If it matter the board that I am currently testing has 1GiB DDR RAM, and
> > > > > > > > > > > > the SoC is a AM6252ATCGHAALW. 
> > > > > > > > > > > 
> > > > > > > > > > > I was able to trace the issue to the get_ram_size() in
> > > > > > > > > > > verdin-am62.c:dram_init().
> > > > > > > > > > > 
> > > > > > > > > > > That function walks the addressable memory range to dynamically detect
> > > > > > > > > > > how much memory is available.
> > > > > > > > > > > 
> > > > > > > > > > > Not sure on the proper way to fix it however, Bryan? Suhaas?
> > > > > > > > > > 
> > > > > > > > > > Yes, this does seem to be the issue, even in my digging. I have sent a
> > > > > > > > > > patch to fix this. But since I don't have boards, I have not tested
> > > > > > > > > > this. Could you please test this and let us know if it works, or if
> > > > > > > > > > there are any other issues that pop up?
> > > > > > > > > 
> > > > > > > > > With commit f9ffeec4bdcf ("board: toradex: Make A53 get RAM size from DT
> > > > > > > > > in K3 boards") merged we had our CI running on our whole board farm
> > > > > > > > > last night.
> > > > > > > > > 
> > > > > > > > > Good news: the issue is confirmed to be fixed on Verdin AM62P and Verdin
> > > > > > > > > AM62 [Quad|Dual] with [1|2]GB RAM.
> > > > > > > > 
> > > > > > > > That's great!
> > > > > > > > > 
> > > > > > > > > Bad news: we we do still have a boot failure regression on Verdin AM62
> > > > > > > > > single core with 512MB RAM. I have no idea if this is the same issue or
> > > > > > > > > a different one, but from the logs it look different (despite that I
> > > > > > > > > decided to keep using this email thread and not start a new one).
> > > > > > > > > 
> > > > > > > > > The failing board from the logs uses a AM6231ASGGHAALW SoC, maximum
> > > > > > > > > frequency 1GHz, we also have another device failing, single core again,
> > > > > > > > > with maximum frequency 800MHz, the working one have 1.4GHz max
> > > > > > > > > frequency.
> > > > > > > > > 
> > > > > > > > > Worth noticing the errors
> > > > > > > > >   Failed to set clock rates
> > > > > > > > > 
> > > > > > > > > These are new compared to the previous U-Boot release, it affects also
> > > > > > > > > other boards, and I have no idea if this is related to this issue or not.
> > > > > > > > > 
> > > > > > > > > Logs of the failing device (U-Boot is commit f9ffeec4bdcf1da655a0ffea482062adde78fee8)
> > > > > > > > > 
> > > > > > > > > U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> > > > > > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
> > > > > > > > > Failed to set clock rates for '/a53@0': -22
> > > > > > > > > SPL initial stack usage: 13456 bytes
> > > > > > > > > Trying to boot from MMC1
> > > > > > > > > Authentication passed
> > > > > > > > > Authentication passed
> > > > > > > > > Authentication passed
> > > > > > > > > Loading Environment from nowhere... OK
> > > > > > > > > init_env from device 9 not supported!
> > > > > > > > > Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > I don't think this one is related to the firewall series. Not really
> > > > > > > > sure what the issue is. Just to rule this series out -- could you drop
> > > > > > > > my patch(es) and check if this specific device boots?
> > > > > > > > 
> > > > > > > > Was this device booting earlier? Could it be a build misconfig, since it
> > > > > > > > says that it can't detect an image signing certificate?
> > > > > > > 
> > > > > > > This is a regression with 2026.04. 2026.04-rc never booted on this device, and
> > > > > > > before commit f9ffeec4bdcf1da655a0ffea482062adde78fee8 none of the verdin
> > > > > > > am62[p] variants were booting for multiple bugs that were present in the
> > > > > > > release.
> > > > > > > 
> > > > > > > 2026.01 is booting fine on this device, with plain vanilla U-Boot.
> > > > > > 
> > > > > > The issue is still there, and it seems again related with your changes.
> > > > > > 
> > > > > > Can you help? Any test that I should do?
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > v2026.01 booting fine
> > > > > > =====================
> > > > > > 
> > > > > > U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:15 +0100)
> > > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > > > Changed A53 CPU frequency to 800000000Hz (K grade) in DT
> > > > > > SPL initial stack usage: 13512 bytes
> > > > > > Trying to boot from MMC1
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Loading Environment from nowhere... OK
> > > > > > init_env from device 9 not supported!
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Starting ATF on ARM64 core...
> > > > > > 
> > > > > > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > > > > > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > > > > > 
> > > > > > U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:38 +0100)
> > > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > > > SPL initial stack usage: 2048 bytes
> > > > > > Trying to boot from MMC1
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > 
> > > > > > 
> > > > > > U-Boot 2026.01 (Feb 18 2026 - 12:12:38 +0100)
> > > > > > 
> > > > > > SoC:   AM62X SR1.0 HS-FS
> > > > > > Reset reason: POR
> > > > > > DRAM:  512 MiB
> > > > > > optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> > > > > > Core:  159 devices, 34 uclasses, devicetree: separate
> > > > > > MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> > > > > > Loading Environment from MMC... Reading from MMC(0)... OK
> > > > > > In:    serial@2800000
> > > > > > Out:   serial@2800000
> > > > > > 
> > > > > > 2026.04, commit 3243a73102c3 ("Merge branch 'master' of
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-sh"), booting fine
> > > > > > =================================================================
> > > > > > 
> > > > > > 
> > > > > > U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:33 +0100)
> > > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > > > Failed to set clock rates for '/a53@0': -22
> > > > > > SPL initial stack usage: 13512 bytes
> > > > > > Trying to boot from MMC1
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Loading Environment from nowhere... OK
> > > > > > init_env from device 9 not supported!
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Starting ATF on ARM64 core...
> > > > > > 
> > > > > > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > > > > > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > > > > > 
> > > > > > U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
> > > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > > > SPL initial stack usage: 2048 bytes
> > > > > > Trying to boot from MMC1
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > 
> > > > > > 
> > > > > > U-Boot 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
> > > > > > 
> > > > > > SoC:   AM62X SR1.0 HS-FS
> > > > > > Reset reason: POR
> > > > > > DRAM:  512 MiB
> > > > > > optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> > > > > > Core:  160 devices, 35 uclasses, devicetree: separate
> > > > > > MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> > > > > > Loading Environment from MMC... Reading from MMC(0)... OK
> > > > > > In:    serial@2800000
> > > > > > Out:   serial@2800000
> > > > > > Err:   serial@2800000
> > > > > > Model: Toradex 0071 Verdin AM62 Solo 512MB V1.2A
> > > > > > 
> > > > > > 
> > > > > > 2026.04, current master, commit 8666b16015d4, NOT working
> > > > > > =========================================================
> > > > > > 
> > > > > > 
> > > > > > U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:31 +0100)
> > > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > > > Failed to set clock rates for '/a53@0': -22
> > > > > 
> > > > > Hmm It's interesting to see this start to fail. 
> > > 
> > > This is fixed with another patch, and I would confirm that this is
> > > unrelated to the issue we are debugging here
> > > 
> > > > > > SPL initial stack usage: 13464 bytes
> > > > > > Trying to boot from MMC1
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Loading Environment from nowhere... OK
> > > > > > init_env from device 9 not supported!
> > > > > > Authentication passed
> > > > > > Authentication passed
> > > > > > Starting ATF on ARM64 core...
> > > > > > 
> > > > > > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > > > > > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > > > > > 
> > > > > > U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:54 +0100)
> > > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > > > 
> > > > > 
> > > > > I'm suspicious of the spl_enable_cache(). I've witnessed issues if we 
> > > > > add MMU entries that are not backed by DRAM which can cause the MMU to 
> > > > > crash the CPU.
> > > > > 
> > > > 
> > > > I looked into that function.
> > > > 
> > > > This is my current theory:
> > > > 
> > > > The end address of 512MB RAM is 0x9FFFFFFF. This is the same as OPTEE's
> > > > end address.
> > > > 
> > > > If you look into the `spl_enable_cache()` function, you'll see that it
> > > > is subtracting the size of page tables from the top of RAM, i.e. it is
> > > > placing the page table at the end of RAM, i.e. it is placing the page
> > > > table in OPTEE's memory region. Since this region wasn't protected by
> > > > firewalls earlier, everything worked. But now the firewall disallows
> > > > U-Boot's access to the page table.
> > > > 
> > > > On 1GB and 2GB devices, there's a great deal of distance between the
> > > > end addresses of RAM (0xBFFFFFFF and 0xFFFFFFFF respectively) and the
> > > > end address of OPTEE. So we don't run into this issue.
> > > > 
> > > > Francesco -- Just to confirm if this indeed is the case, could you
> > > > change CONFIG_K3_OPTEE_LOAD_ADDR to any other free location, and check
> > > > if the device boots?
> > > 
> > > Any suggestion on a good address to use?
> > > 
> > > I tried 0x83800000, and the result is not booting in different ways,
> > > failing in different ways
> > 
> > Ah so for our am62 SiP package (which also has 512MB of DDR) we ended up 
> > moving OP-TEE down to 0x80080000[0] to let U-Boot relocate itself 
> > without crashing into OPTEE or TFA
> > 
> > Because tiboot3.bin starts off the main domain by sending the A53 to  
> > TFA -> OPTEE -> SPL there isn't a great way to pass along the info to 
> > TFA on where to go next at run-time.
> > 
> > So for this to work we will need to adjust the jump defaults in both 
> > TF-A and OP-TEE as well as modify the K3_OPTEE_LOAD_ADDR here.
> > 
> > We're doing this in yocto here[1][2]
> > 
> > [0] https://git.yoctoproject.org/meta-ti/tree/meta-ti-bsp/conf/machine/am62xxsip-evm.conf#n7
> > [1] https://git.yoctoproject.org/meta-ti/tree/meta-ti-bsp/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti.inc#n29
> > [2] https://git.yoctoproject.org/meta-ti/tree/meta-ti-bsp/recipes-security/optee/optee-os-ti-overrides.inc#n9
> > 
> > With that updated it should allow us to get past the TFA init
> 
> Some progress ...
> 
> I had to review also the U-Boot configuration, the whole memory map must
> be revised ...
>
> With that sometime it works ...

Nice!

> 
> U-Boot SPL 2026.04-rc2-00038-g2d83c0fbbfed-dirty (Feb 20 2026 - 11:23:36 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> Set clock rates for '/a53@0', CPU: 800MHz at Speed Grade 'K'
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
> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b38
> NOTICE:  BL31: Built : 10:24:51, Feb 20 2026
> I/TC:
> I/TC: OP-TEE version: 4.9.0-34-g33919ffbd54a (gcc version 14.2.0 (Debian 14.2.0-19)) #2 Fri Feb 20 09:27:46 UTC 2026 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
> I/TC: Primary CPU initializing
> I/TC: GIC redistributor base address not provided
> I/TC: Assuming default GIC group status and modifier
> I/TC: SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> I/TC: HUK Initialized
> I/TC: Disabling output console
> 
> U-Boot SPL 2026.04-rc2-00038-g2d83c0fbbfed-dirty (Feb 20 2026 - 11:23:59 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> SPL initial stack usage: 2048 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> 
> 
> U-Boot 2026.04-rc2-00038-g2d83c0fbbfed-dirty (Feb 20 2026 - 11:23:59 +0100)
> 
> SoC:   AM62X SR1.0 HS-FS
> Reset reason: POR
> DRAM:  512 MiB
> optee optee: OP-TEE: revision 4.9 (33919ffbd54a7cea)
> Core:  159 devices, 34 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> Loading Environment from MMC... Reading from MMC(0)... OK
> In:    serial@2800000
> Out:   serial@2800000
> Err:   serial@2800000
> Model: Toradex 0071 Verdin AM62 Solo 512MB V1.2A
> Serial#: 15412819
> Carrier: Toradex Verdin Development Board V1.1D, Serial# 10996055
> Net:   am65_cpsw_nuss ethernet@8000000: K3 CPSW: nuss_ver: 0x6BA01103 cpsw_ver: 0x6BA81103 ale_ver: 0x00290105 Ports:2
> am65_cpsw_nuss_port ethernet@8000000port@1: RGMII mode without internal TX delay unsupported; please fix your Device Tree
> 
> Warning: ethernet@8000000port@1 MAC addresses don't match:
> Address in ROM is               64:1c:10:2a:6d:c2
> Address in environment is       00:14:2d:eb:2e:53
> eth0: ethernet@8000000port@1 [PRIME]am65_cpsw_nuss_port ethernet@8000000port@2: RGMII mode without internal TX delay unsupported; please
>  fix your Device Tree
> , eth1: ethernet@8000000port@2
> Hit any key to stop autoboot: 0
> Verdin AM62 #
> 
> 
> however, sometime it just crashes somewhere ...
> 
> Verdin AM62 # reset
> resetting ...
> 
> U-Boot SPL 2026.04-rc2-00038-g2d83c0fbbfed-dirty (Feb 20 2026 - 11:23:36 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> Set clock rates for '/a53@0', CPU: 800MHz at Speed Grade 'K'
> SPL initial stack usage: 13464 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing
> (HS-SE) devices

How strange. It's odd U-Boot on some boots finds a certificate with the 
binaries and on others attempts it does not. If the image inside the 
tispl.bin was corrupted I would expect the SPL to reject the image.

I'll start bothering Andrei for some of your hardware :)

> 
> It's quite a pain. I will review the complete memory map and check if I
> missed something.
> 
> Bryan: I think TI should consider having both OP-TEE and TFA at the
> beginning of the memory on any AM62* SOC by default, this would just be
> the most robust way to have something working no matter the amount of
> memory that is fitted.
> 

Completely agree. 

The BeagleBoard people went through this pain a few weeks ago for the 
Pocketbeagle2 boards. It's a problem.

Originally we envisioned DRAM density would go up just like with flash 
densities as the SoC's matured. Obviously this isn't happening

It might be worth finding a way to move them (or change their default 
locations). I'll start pestering people in TI to get a plan in place.

~Bryan
