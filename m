Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04713CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 19:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C918318E;
	Tue,  9 Sep 2025 21:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="wr2DAMBW";
	dkim=pass (1024-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="cHUX2Loc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6221B83192; Tue,  9 Sep 2025 21:53:47 +0200 (CEST)
Received: from mx0b-003cac01.pphosted.com (mx0b-003cac01.pphosted.com
 [205.220.173.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020C88313B
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 21:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=keysight.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=john.ripple@keysight.com
Received: from pps.filterd (m0187217.ppops.net [127.0.0.1])
 by mx0b-003cac01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589ENZ7k030792;
 Tue, 9 Sep 2025 12:53:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppfeb2020; bh=
 LhFRZW7BkGjEgyerwR21ES23B0Kjbr37CEfVWVHcdtc=; b=wr2DAMBWWEUH8FZN
 AN7LRnndbU8NPbTnRN600/J60u6WDhqBZSJXvJtyjv1IBeIHEjo89GAOFVyXrL0O
 HIqxNsZMCwdm2HcfaqqQxUW1nk5T+EbNQ0eCbPeUqX/QiwQCY1FMydFbk4FukJn6
 ULCBdLZ8swP7hMasEFsf0SDK+PNjB+AFHSm25ErLIHC5EI6NeZrVcKBl2al+xlc5
 Eu7JYHnsrNbuZeNH8q/OzRrrlOA/nQeXScbdf8faQPOngGpfkL7pZWoP6Re26nJB
 o9g44OHVumKazgh7EE+AMhqU2HCSphn7+Wr2d5Odk00EYlf+T2DpeXfQNZhH4oMJ
 fYtpkg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 492e0t1vmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Sep 2025 12:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGZIe8k6xoN2zFOs2k7mQonc8itbSufzS3Nv28nyGZK56YaK3yQ3LiieChZmuqBuayle4Rx9dskjp+1nWKOPRkvSHjq25IxnMjUfyIjNFjBmz7QMaCYE1f1hEKjs2GPgphEzIeK84QTA9VKkEwWMabhcIOWtQS+/QQhj4U53p44EahdWIV6bXEZyPQQ6SFEPeY3MHALBId5B9AvxAhMVY+OfaF1knFHIkX5at+L+FhqZDEO1yBruqtxebXBr0cu4twrQAllngN3bk0QaQenlq+Tr3DG2p5Yz3pMtnYo+LzgpYz8qREpHB2HA/lN30yJl7nj0R/zRvlDjplvEDG9HBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhFRZW7BkGjEgyerwR21ES23B0Kjbr37CEfVWVHcdtc=;
 b=yQIOnfW7CO0dfwyGxIu/39XeRNnNbTp0FwXQFOY4/jiWiredYmWgLWOkXJmLavRTIxvl5UIQqw6q1N4AMs9QnpLxzYShK2zjeYAHNZI21E67cbKQ6+6MfROyvKIT5mA15UDYOf3CekfNR81Oqly/IZDwCfO3Nueov2L1rRbpfCnfk/I0eZ9tA43ZgpZogNK4bGStzs24aOamlPDU4wxJ3ajdRJq4RNdI0fMG+WVHSnfb4hWXIJJfryyOT96dwtLTgUewikvUpZkFMCEG0b818/I5QvDsX5Z6ImYsnxZ4zN7SYjx1pajIwqag+2JHQaeGQkrqUxZ91cy75I/qoT3UJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhFRZW7BkGjEgyerwR21ES23B0Kjbr37CEfVWVHcdtc=;
 b=cHUX2Locr7cFwH4NbbZtxoERTWM8imWgeWuucjGJH1pUW5dQbCPNWzgBNKR8N9pWFdNJTa3DboyGEt3dp45hZPr3iNI+U2X0/gJjyObyJvEXCWnBEpkDr71a9UOi/5x03AZctk7OdJeaAgLGqHIhpZ6la2wREHfs4HL+ZCGX7+E=
Received: from PH7PR17MB6130.namprd17.prod.outlook.com (2603:10b6:510:1f5::17)
 by MN2PR17MB3984.namprd17.prod.outlook.com (2603:10b6:208:20b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 19:53:34 +0000
Received: from PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e]) by PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e%5]) with mapi id 15.20.9073.026; Tue, 9 Sep 2025
 19:53:34 +0000
From: John Ripple <john.ripple@keysight.com>
To: peng.fan@oss.nxp.com
Cc: alexander.sverdlin@siemens.com, andrej.valek@siemens.com,
 festevam@gmail.com, hs@denx.de, john.ripple@keysight.com,
 peng.fan@nxp.com, sbabic@nabladev.com, sr@denx.de, trini@konsulko.com,
 u-boot@lists.denx.de, uboot-imx@nxp.com
Subject: [PATCH v4] imx8: Add ahab_commit command
Date: Tue,  9 Sep 2025 13:53:22 -0600
Message-ID: <20250909195322.245323-1-john.ripple@keysight.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909023709.GA11150@nxa18884-linux.ap.freescale.net>
References: <20250909023709.GA11150@nxa18884-linux.ap.freescale.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0129.namprd11.prod.outlook.com
 (2603:10b6:806:131::14) To PH7PR17MB6130.namprd17.prod.outlook.com
 (2603:10b6:510:1f5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR17MB6130:EE_|MN2PR17MB3984:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ba7e71-025f-4b09-03ed-08ddefda8f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvmsreBSdICF/5Ij/zDxsqYSRsSmBcScIVbEVYPk2+G72ZtK5Byfuqu1RA4W?=
 =?us-ascii?Q?ZoCDbXm1DNrONKnYWvaen8kfA53Nhbu8xASfHu64d2UM2rspL/EONTRJopHe?=
 =?us-ascii?Q?/2I5DhfRxYFuVjIPLdcHmy+LDt1/3pkcjBBd1DViu695HIM+Nrm/RuAdKmeY?=
 =?us-ascii?Q?9/3GVLil7PB2Pud8AkbVxhrL+UjzJn+EKorOrcdHBrEOECw3uIsOpcRn/NzG?=
 =?us-ascii?Q?6sot9dMyufHriVcl8KIiiTDAFZ9a2UowqGSqjfOPSMWUCbe9kwMJIYsB/YhE?=
 =?us-ascii?Q?hI3JN13zaiVfCjelWZFzNKNdw5786YQVUUScKRioLIfzhuWDKEnqw31JG/Gk?=
 =?us-ascii?Q?PsuXfKltcryGAc5VPT+MzCia0XsgdZ/rti7AQvAUmhKxfGKnKKv9ZP0VoWNb?=
 =?us-ascii?Q?/XfhB6gzzAeImlk3WXZISPF6zIWkxW6rTdbOGlUrEIlJ8z/gFHlGVmFpNCxD?=
 =?us-ascii?Q?8dnNlk9NU+F9WONmvG4alEGvqrtPGox0BY8U0MYYVvhmEEwWksjuftmlDEoL?=
 =?us-ascii?Q?fsqvi385wf+5q7jgFG78MTA1FSYErbXF1zU4TahgBxXAZ4qm7hU16JPyJFqf?=
 =?us-ascii?Q?RHcYixTid6u57uRWS00PTt7BtJ88fUM5wLVv+sFN4nB5jIhXAhuOTJ8cV72Q?=
 =?us-ascii?Q?MzORK1QBa9vEG7K3ho2tILQJDzqIFDOTpOsh7xpGtSywUXGCeZjZjqDqBnno?=
 =?us-ascii?Q?Ec3dlEaWLIlngZ+Rv+FFevJgE7Sd7ONfaHpbsh8DDDMsyWYQqPqkMYL4fTBG?=
 =?us-ascii?Q?sqzd/0VihIFGIqxJjw+4v3JAzwYJP5mfv6JCibFUsxsTgEra37y3jIyfVlHl?=
 =?us-ascii?Q?xcZaMfGj44GTeJ2TCfAuE4BLbuPFNneHiY5F7567tghZnH6WnLhy4f5h+MUt?=
 =?us-ascii?Q?GEnygvnC55vEY4zYAf9LxJtNsIedBGpGjW0GPL3OA/5bDCiU+/1kUkA8skmt?=
 =?us-ascii?Q?E+h6nplGTQ32kN4eQV0opmVx08qjEa9va7K9p1xy4QBSGupZmQty9jF3B6MR?=
 =?us-ascii?Q?vM94OXa6fjE6flYUHwEAprHRoUN88lKWQtSR3Ud/A62pb/chnwtoQdkRomh/?=
 =?us-ascii?Q?kAdMa/7QpnoqOsApRbRA9Fwoz1J4x325oQfAbb2pAUrJCppsLCIdg0gD33gV?=
 =?us-ascii?Q?LeVs0xQ0iU4DG81cxG5vaPn1TiVYwTEs7zmINIdQHKWY29UPJNzHfSG1BsQD?=
 =?us-ascii?Q?Lf5A+qOF07L5aNfSMM5n128CoFKyXaeFKsT2sWNK43//2O4gzog1XnpQMYgz?=
 =?us-ascii?Q?Sx9R+FD/6jNzN5M3xaxzff94WWDFsMwVre/caBrqZ+IZZmGqa7hOotrdY68K?=
 =?us-ascii?Q?ON1EHl6UvkvcTdskQtWY82zpP3+oUsQTZc3pvZfa9u6plyg/W9r6ypDsphJj?=
 =?us-ascii?Q?KYAfIRk51TVMcmZ5C6H6chq6lyBBdLadH0a+gfQVVSCNHHxiYWYWD2As5ZrX?=
 =?us-ascii?Q?lXRY8szSJtc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR17MB6130.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSdtkdoHFYonzybPywiEiEQB3RAor/OncGj96ASbIVSpdZeGWodh8CPyTlDp?=
 =?us-ascii?Q?KbUFw6zmYCOmCKgx0a8t5XoxYhr12uUuXscPAv4KrYuDqV3B38YgvP+ka04S?=
 =?us-ascii?Q?/dxADUlqpIZIo8PKnQlToXz9RSoNCqEAzOQvPsaaEFw+1jS5SSwznaggOQKh?=
 =?us-ascii?Q?gqQS1znBjyrN8sGzHZQ64At9fNu7R8dRpjVTcj+6wVI4oLDwVJRUmcqJCH84?=
 =?us-ascii?Q?Ksu0Hw7LWy57Mw+lE6GIV+Ni3Ja3pY77IMb6BENuWDttnXmbM7EmspoooLhl?=
 =?us-ascii?Q?pmE0O/yyS3JiuNAOR8veOISnmyY3VJORFDHjZDen67/0d+gHVqq4VQzYgYL6?=
 =?us-ascii?Q?DdmX0fRGfPnr0ZLegRwOsUWHy7VpUM8EkLsSN0hkqs194Mrn8Mc95NFJSfJu?=
 =?us-ascii?Q?KBxnl0FU+uhCKJ3GCrNjzwI64qPW4dDm3t7UPKYTH5VmlSVlQXhYeUb7pPOv?=
 =?us-ascii?Q?ZVj97P8wM8L0+LG7D4CeNrV0fs6dGKVDb1Yk6SKxjjF26tK6AXsUE1LQ3NtX?=
 =?us-ascii?Q?+bMSQy0dFqbe6HnKTtZSwBVNL5ih7gNK8TEqdekpbZaf8ZOTtVEwDaBmHIXF?=
 =?us-ascii?Q?4A1L83PDMVcC59EcMQ66UbXMc3GuP0tTaWimKe2F3JBrR12ldz7A3SpOZ1hd?=
 =?us-ascii?Q?KMk8XuP6M36WSdXadJ6gBOOsu3YlCuV3a1fhtrsrbpk6hN1oK653yDVogHOW?=
 =?us-ascii?Q?4/GDD27VQ4geUCGAKJfCMrCplPkqsSOpPeHnkc+IHnHp4v4bvZgGshGxzt9Q?=
 =?us-ascii?Q?5xZ9NyX5JORB8csla19oR7w0FghlalnWn/FmU0BH3MUkdX+jj30O0+FMy33u?=
 =?us-ascii?Q?PqLVvrGn/E4X54UUolKk/SrdBq0EltxbikKdKtk/Sr9gEHibm6wT31VzrV/5?=
 =?us-ascii?Q?pqoeFY4NBr6zrwL4dZjDnPsNL694oMgwbDST4SnjCY11NmVz6MjOFSROmEX0?=
 =?us-ascii?Q?ZITgqSpjzk+ucnW0AtGNbQo+ITW3s/5JeB7NrYtpTbSIb45PH3vv6pkdwFZu?=
 =?us-ascii?Q?d67tkwVddTGrYtNdOMO+ojwLuoornDVDH/4WhT3jIAnbIOzxvZF67gzFbAqL?=
 =?us-ascii?Q?bsf4tZFakm9rb5IgdGPcd+/IHvQRMwQySJuwlo7ouAUeDx26BZx1ncK9HNNm?=
 =?us-ascii?Q?GOrb1FOvXEkOKy4VAy4z9h2Zdn2FSDuzX2WApZZ9+IE/TUPbrhg8obhPWFSj?=
 =?us-ascii?Q?6TlkHpZWOgXx+v5aljkhwDzYKHiy9lheRVzpxYTTGmERiECCUSBa2PJfYfSH?=
 =?us-ascii?Q?QfixiT/1KslRR/m4ZNxWC4IHxd4aINujsmMttB+eatDtUnFkQwTIp+0VPDQP?=
 =?us-ascii?Q?4tsot+3527WkBDIuk4hpHEcj8s/fgta/MUR1WHBWfm4NbM738u4jEqZCgoDN?=
 =?us-ascii?Q?tUFZFXSUwWeNQa9Fy8NEBquALdTo+VxuCpqv51gjwIfyaffdEdlIBoXhTxuC?=
 =?us-ascii?Q?5rGMDGXc8jUZU+7PtpBXGRfuNx9GrrXpQ8zOISr8+8XpCMN49sG8p6FrOnT2?=
 =?us-ascii?Q?L8+2kgx1HdKYydD1S1ZH9x1LAsFFlNrWFsPtY9vHJU7xXSb5GWH2QoA4uq+5?=
 =?us-ascii?Q?IF2yokyvM4+l8O8CQvrEcjQXzJZ408nLT/V4L5HeMCiAHUuiGp18r5JOhMWr?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X9rpEvKRHtPkobcLo6TXRhmmtdPA4ln5b/saefj5pOijrOwtNLNLkrk9OR2EDyJB5j916tDGjNxrV5VShyYvj7eA//k1kAyepQtSj+rZ+ksjy9UQoNgD1+X+Igr1EmKoRx6/jqxxc4MQGUTxFjC7bUDgqRTnDqDAZyJ+vlGskE9Y7KtHTM/qK1BzO8Nq4F6Wm3wKZIAgRmBiqYxSE+/0+SX/c5gjfzXP2Imi8GzUr1XvgKQTAaGOSLP7HXgUmSCuRbeGic8/UEU4EJwp/k3O2jlIJw+Q9A/5skFhS4tzj32SsvavE2sNgRirIceh9YosT4hX1DNwQH1Xu5mp7/n93gSbI2SFmvpIATZlYmbFZR1d9ADT9dcnQMw9nfPfXQW/3IrExw6aRB7C17ukcXHXUE/XcLIggFu3RT5t6Kc1E9f5+6a9sRElyv168q3RhwacFouDxmg088wW8Lf6T8G+P6j3Pc1CI+XVK6Ud1xi1am1S7qcFIpkL6rbr+7QqSpDxsTrAiks43w1PkChXaj8WAMyaacfmClBrdAnORyy9QhN6YrhcPjlYF7Nsi7VY4BvL4/LUv1Nme7G1RMIga27t/hGUBD2ICQJ0f+zAAk4zuAbTT7EpEK/HRRzOdCHYV0qV
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ba7e71-025f-4b09-03ed-08ddefda8f38
X-MS-Exchange-CrossTenant-AuthSource: PH7PR17MB6130.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 19:53:34.2513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3S+wRSideaD9I09FxgUM6LM6WQpER6e0ztjF6fFntvqUd3m8i++LVhL6IUVEXdd1kQnMue/vg3xmZmhmZheumMh0XjG1Kh7t9q/vomGVHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3984
X-Authority-Analysis: v=2.4 cv=a7Iw9VSF c=1 sm=1 tr=0 ts=68c085c0 cx=c_pps
 a=LgxeIWTYIBSsDeecVwaC4g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=vu2TTH8h0NUA:10 a=F6MVbVVLAAAA:8
 a=DFe7BWdYuPSjU5OGzG8A:9 a=6mxfPxaA-CAxv1z-Kq-J:22
X-Proofpoint-GUID: tddWVbO8VkeW7_Z570Gn2204TDOtYDmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDA1MCBTYWx0ZWRfX+4ncYlaljWnm
 t++j4dG8evoFLy0XB2ftK/oFBrmsWuehlBpkLNKPHe6BHknVSL/tzi6Vzn6o8h9uy13ltzqNM0D
 waepMhbpniO5wTlU8/Je8/2pYa7+t5JCiOUMZmaW+xMvFtdCL4E1O5P41KIaRkTqDWEwJK6CaxU
 A9eeD5OKGVpRgXgW08dV+0k3W4HbtLRpNyKoOvH4vpn7ykHN7jRPsHDRNV9z7sfq6LFAxto977A
 tc1bTKgmKOMtKT1/1AzqvIriEaR4xf97/hv+G2DFB4IqH0yKFXf/Gqm3d1QFjevlEUsIumKX3Ij
 +xEKDghxQlzVHG4Nu5W/NDl2vEgAjYh9gCT1ObhGlcegM30yULlKI9rOH1cgVadtgOttcQ3qjTh
 rBZa44U+
X-Proofpoint-ORIG-GUID: tddWVbO8VkeW7_Z570Gn2204TDOtYDmy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509090050
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

The ahab_commit command allows the user to commit into the SECO fuses
that control the SRK key revocation information. This is used to Revoke
compromised SRK keys.

To use ahab_commit, the boot container must be built with an SRK
revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this
means setting the 'srk_revoke_mask' option in the config file used to
sign the boot container. The 'ahab_commit 0x10' can then be used to commit
the SRK revocation information into the SECO fuses.

Signed-off-by: John Ripple <john.ripple@keysight.com>
---
Changes in v2:
- Changed patch name to have imx8.

Changes in v3:
- Changed patch name to only have imx8 at the start.
- Add error checking for sc_seco_commit message.

Changes in v4:
- Better error handling.
- Removed unnecessary comments.
---

 arch/arm/mach-imx/imx8/ahab.c  | 29 +++++++++++++++++++++++++++++
 drivers/misc/imx8/scu_api.c    | 31 +++++++++++++++++++++++++++++++
 include/firmware/imx/sci/sci.h |  6 ++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index 324e010bb2c..f13baa871cc 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -401,6 +401,29 @@ static int do_ahab_close(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	u32 info;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	info = simple_strtoul(argv[1], NULL, 16);
+	printf("Commit index is 0x%x\n", info);
+
+	ret = sc_seco_commit(-1, &info);
+	if (ret) {
+		printf("Error in AHAB commit\n");
+		return ret;
+	}
+
+	printf("AHAB commit succeeded.\n");
+
+	return CMD_RET_SUCCESS;
+}
+
 U_BOOT_CMD(auth_cntr, CONFIG_SYS_MAXARGS, 1, do_authenticate,
 	   "autenticate OS container via AHAB",
 	   "addr\n"
@@ -416,3 +439,9 @@ U_BOOT_CMD(ahab_close, CONFIG_SYS_MAXARGS, 1, do_ahab_close,
 	   "Change AHAB lifecycle to OEM closed",
 	   ""
 );
+
+U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,
+	   "commit into the fuses any new SRK revocation information that have been found\n"
+	   "into the NXP (SECO FW) and OEM containers. For SRK revocation use 0x10 for the value.",
+	   ""
+);
diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
index 8985ab6584d..d9cc7acb970 100644
--- a/drivers/misc/imx8/scu_api.c
+++ b/drivers/misc/imx8/scu_api.c
@@ -1286,3 +1286,34 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u8 access, u32 *data)
 
 	return ret;
 }
+
+int sc_seco_commit(sc_ipc_t ipc, u32 *info)
+{
+	struct udevice *dev = gd->arch.scu_dev;
+	struct sc_rpc_msg_s msg;
+	int size = sizeof(struct sc_rpc_msg_s);
+	int ret;
+
+	/* Fill in header */
+	RPC_VER(&msg) = SC_RPC_VERSION;
+	RPC_SIZE(&msg) = 2U;
+	RPC_SVC(&msg) = (u8)SC_RPC_SVC_SECO;
+	RPC_FUNC(&msg) = (u8)SECO_FUNC_COMMIT;
+
+	/* Fill in send message */
+	RPC_U32(&msg, 0U) = *info;
+
+	/* Call RPC */
+	ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
+	if (ret)
+		return ret;
+
+	/* Copy out result */
+	ret = (int)RPC_R8(&msg);
+
+	/* Copy out receive message */
+	if (!ret)
+		*info = RPC_U32(&msg, 0U);
+
+	return ret;
+}
diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sci.h
index 588f3671103..876d52cac35 100644
--- a/include/firmware/imx/sci/sci.h
+++ b/include/firmware/imx/sci/sci.h
@@ -144,6 +144,7 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u8 access, u32 *data);
 int sc_seco_secvio_config(sc_ipc_t ipc, u8 id, u8 access,
 			  u32 *data0, u32 *data1, u32 *data2, u32 *data3,
 			  u32 *data4, u8 size);
+int sc_seco_commit(sc_ipc_t ipc, u32 *info);
 #else
 /* PM API*/
 static inline int sc_pm_set_resource_power_mode(sc_ipc_t ipc, sc_rsrc_t resource,
@@ -383,6 +384,11 @@ static inline int sc_seco_secvio_config(sc_ipc_t ipc, u8 id, u8 access, u32 *dat
 	return -EOPNOTSUPP;
 }
 
+static inline int sc_seco_commit(sc_ipc_t ipc, u32 *info)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void sc_pm_reboot(sc_ipc_t ipc, sc_pm_reset_type_t type)
 {
 }
base-commit: 1a7882de8c859467ce931ed23761db1e391aeaff
branch: master
