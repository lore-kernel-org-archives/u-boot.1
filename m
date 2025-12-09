Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FFBD3B99E
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 21:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8AD83C5A;
	Tue,  9 Dec 2025 22:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="GN0YZSC1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="nw3M15J5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A039483C7B; Tue,  9 Dec 2025 22:45:48 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2878D83C08
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 22:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hZgLe5ZvpQIIJMnRVkVukp5TPApHVUbu2jgoRogFCilLOngI4keFCVRp4qVN4bTimgG+q8dtFHB4pmFBDhfdRWg5wchGvUg8kWiACIlx/OH2F9fCibtKpShTjCbFp2h+XpdFNksMDn2eVchj3naj/kywqNlEGNCMgABF2Prr2yl/Jo7dtS65FzVk6QGLAm2VJ7/KDhzRsVbkH6/A2pRUcFjGpR2/5yrL+ioHBP8Xj2HLV9TSRHBQWD9MNhDq9vqE6RihUiNuk9TUuKIe3YN8Ei87OV2P/r5X+ArwxSaPsBv+Wh28ciETg2EGSMqMeXKXL8exYASUv+mNoDyN7Te7MQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgNmnbduJppshS/qRPvoVuc//4xXymfBh+F5cXOcamA=;
 b=OqjVrKV7SbDPk7zFlVIJTjGWXFRRCsvp9ydN/QAMP3mMFhNijby5F31MD45VTK18CEtI7Iv1DMbq7xuFcRjsmzkhL4oeyjfvzXyit6Ae0TE46ShnFhBLHy3IPL00QDtO+qMRMCIdJp54X91coIbWEiReSdTRBgqpPYHqHfXTRjKFCL83cC9WJ4muKFgIhImQ+hcqhhOKzLtWUficbYFVNP+h9luagIQx+vP9eXlXBoPoFmpjBxmzVGge9L4v97k1yTM7H2sfswjcGtXSwipVTeaHziwwllLdzJMEEprugzTkVFwknyOLnvbtwfbgJZnnACXYqbKDkpl3DJ/yisKftw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgNmnbduJppshS/qRPvoVuc//4xXymfBh+F5cXOcamA=;
 b=GN0YZSC16aHkXGuw6jGsRFVPY2zTZXDCu2jLm2nrSeAXC9p5CcWV6X730UTW2TkkB/FDsiqWkTQr/zoE1Vr72KlvXJFdm71W03VNktOEmVPNoJsOj1A/0hI6CrST5BJUimd55pltWpqJ5jq6B9BuT1s4/FL/9vAOYuXz3hIRHhncsB4SE/T51WG4K3Iv5+QKXYMEMSDHsA8Yo4G0gm4hFYDccYDWVe9Rins8Lxd3Fz0hkDQKYxXALpQthMzJKvAZfWQbQL3a4BPiiuDUFHX2THoXSWiWmA4nyZdw4YXanVuh0aATm9Lure0Gp3+FGq1pf7iuEjN8fLKUkrQJILRsbg==
Received: from CWLP265CA0398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d6::20)
 by AM7PR03MB6530.eurprd03.prod.outlook.com (2603:10a6:20b:1bd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 21:45:44 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:400:1d6:cafe::f3) by CWLP265CA0398.outlook.office365.com
 (2603:10a6:400:1d6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 21:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4
 via Frontend Transport; Tue, 9 Dec 2025 21:45:43 +0000
Received: from outmta (unknown [192.168.82.134])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 B15F620080591; Tue, 09 Dec 2025 21:45:43 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (unknown
 [40.107.159.134])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 35458200C4FE6; 
 Tue, 09 Dec 2025 21:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtwQRo/A9seXimtibibO2xegEVk5HV2mEOqO37Ux1oNCCaAkYdang0hLE9xJm0/lhESD9/Kp5GV1SxtP86FmfHuEDbvPCAO8yN4TgHFehhUpOAE3Y5CMXpl6aj0lZVQPtQdAO+kRVMPDJjen9R7Bl4Y3gQwViQ3iAdyk9yThumOaVGddJjyZI2UVrSsR9OEjf3Ri3uZTBxHoJr1EWcfAcSxsJ/2zjNZWC66/b/ni3PFTRnTmPjAkAfXbbTRePKTbBTZeuExdWW1U0nZivvI0CUYWngx/hQUglqcBLTyUMnuee0WEHCaS+IJ52KTj17J+gaVrCFSDCnB+XQSgOCGZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1uqNM0Wndayxb1G+4tn5A4efVQlo+ct4gBXMPkAfYY=;
 b=dASvzYgooPbNIbHuwA4JeaH3KwNd9FsamWxoB8vCA6HglGdIzcydSuRFW33Sg20od7NOhXEpsTH0LzlRqvECuWeDOOG3+8+UcWh7XVO4nrErfXP5YjekJ/xvl+pn8gPzsnwJiAqYXiM1WyLCjdAM2X/hIR0bh6oWsdY9JUdqd6nvLYkWxsTakGz5ZSmFsGFlgO+U+TdfVDp1Xxg+FiqD2kjafuDgh31tRimC1F5XNaTQdTZLRCGgkGUIo2L4jni2PW09wm6F/EC1lQMSmmGqEsTCN4y5j+XybagWGKdA7kS4lFUEL3WNZvmw4uJwzxnXc4SeHV1xO6CGvjMYY9onGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1uqNM0Wndayxb1G+4tn5A4efVQlo+ct4gBXMPkAfYY=;
 b=nw3M15J5FkfLFYjXTqxO3jIyMQOn6IIqJnXd04XE5VOvreCNm4Oa7cWOwQkxzcvUGJ+kRhqPy4l6F5M65wjzjr7HymcbzfS9Sp0jzO/DyA+fLBk229vyebkuV6m5I7FnaNzYvrrfcVaOOY50jLD6rVDfrLCMHcx1vDOr3CtkltNhYfYFGPThq+sbftHew40KZ0c4mGaCjUCsRtAVVn/GIg6UKbln77on5EnNdqaj6ZDpGJjYtTA46gwDXpRhc6ndP9mQa2W7pKYdLss0e/QSvRR5kZ2Pq6IA++p/aTPiOwSEXe8apyXDiw905g86D536neYf4gr6Qs7xZfcQeGYyPw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DU4PR03MB10909.eurprd03.prod.outlook.com (2603:10a6:10:585::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 21:45:40 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 21:45:40 +0000
Message-ID: <1aff7b02-f742-4f73-b388-7e1356210586@seco.com>
Date: Tue, 9 Dec 2025 16:45:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: designware: Allow disabling designware driver in SPL
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20251208-spi-designware-spl-v1-1-21e6f519a4de@linaro.org>
 <3d0a90ad-f5aa-4a2b-89c6-1f9dbb8e1c60@seco.com>
 <CANp-EDZKunW1O3KCE9zcyNw2vLzLuFRgceWn=He6NCFXWbPHkQ@mail.gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <CANp-EDZKunW1O3KCE9zcyNw2vLzLuFRgceWn=He6NCFXWbPHkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::16) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DU4PR03MB10909:EE_|AM1PEPF000252DA:EE_|AM7PR03MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: cafeef43-2549-488b-6c24-08de376c4e14
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?azlkUUU3cXBjWEJKaUtyVVhENnh0R2RiNGtpT3d0MWprUUJJSGpneEczSUtW?=
 =?utf-8?B?QUhWTmYzNE80MEhJS0RYb3VTVXVTWjg2akoySldsZkg1WGFyMGJHRVpueXBT?=
 =?utf-8?B?SUllK0h6d3BhNEdCaU5CaTdtVG9BTmtqM3FqSkpzUTQ4R1kycWxNa0gxQmhK?=
 =?utf-8?B?WGRSY2hqWmZ2ZVppdWVCbklNa0VRc0NJYzhUQmxYUERaWk1LS1RDY2tsYlFH?=
 =?utf-8?B?Y2w1VFBuaUtDQkJERG1TT1RvaC9nZjFJbTVqdXlPMk84TVJyUTRjVVBSekow?=
 =?utf-8?B?clp6UllncW9SMjlhTEFyYlF0ZThaZUExT1E0bkRaL0R2bkg3NWgwalY4ZEN5?=
 =?utf-8?B?S2txU1YyV0ZWTEt0eDJOOVZiRDZKaGM2eExncWd0MFcydVpSNXZpR21rUkZW?=
 =?utf-8?B?a0RGaDIwc2orclRKcnd1M01wLzVzUUppdHl2ZndRNkNqYmpaWm1pR0xmN3hC?=
 =?utf-8?B?ait2OUJMU0hEZWJTQXI1YUZtdkxKKytIMHFNV1FieC9CRmZMeFdYNGM0SWMr?=
 =?utf-8?B?RzZDVFdXMXZDUC9VOE5LclQwNHdqWGFpQlNEcERkeFJmdURmMmdsaVNubFQx?=
 =?utf-8?B?L3V3RGFjeVBrM0Uvc1lBY3VIdWZna1VDR3p6U0xtM0R6R1AyTDNHa1V5ZVpm?=
 =?utf-8?B?SGlHQndJVmEwYU5YamJOWGpDQXk2TzBoU2swaUpmVHYxZlJyZUJ4VjM3bDZD?=
 =?utf-8?B?V2FCRStCNzVDTmdsRm43ZHpWTHBUL3lSUi9OaVF5ckk0MlFkSzZnV1dNVHor?=
 =?utf-8?B?WkJlL1F1Z3pBdlJDbWFGVTB2Z2xTdTdGZzlyYlY1aDRxYXNXWlljSGNWOGZG?=
 =?utf-8?B?bFBoVi9DQllubmt6Wld1UkpkajdjVHl2d2JHQmhYWHVSdkFONk9rcEtoT2F6?=
 =?utf-8?B?bXhwVVZ4eW5PV2Uzak9VaDZBbUE5cEZGZkgzTVNkVUtWT3pSbzJ4MnpTZldQ?=
 =?utf-8?B?NGJpT2FUekRqWTVEVWMyQ0w0ZmlrNWlpMnRRYkFFREpxUGpwd3RXTThjdlVT?=
 =?utf-8?B?NllsUVZlajZ5aHh1cWhYc3FUSXhTb2RLR3B1V0tONyszRVYzSHFzNkVhVkUr?=
 =?utf-8?B?T1J0WVBGc2tCVUQ1NjQvUzlaVTNDS2xDSU5FSHIyVk5nV2ZkVXVzUVhMTUJJ?=
 =?utf-8?B?dUplZmppVkxiZ3VnNGVhNHRKYkxZd1VrTERKekQwcWdDaSs3amg4b1ZkUGI0?=
 =?utf-8?B?Z2daSTVSTzBENzJrNDJqRE40UkhwTWRRSGVDc0RDeWhnRS9tanJJbm9VZENS?=
 =?utf-8?B?YmNNaU9xWGZjZC9iSG1ENVgyQzM3R1ZxRVJaZGJRMlp2U2VkUUxXSE1OdVEr?=
 =?utf-8?B?LzNNa205Ti9UKzNWRU1yRlY3a2FuSHpDN3dFOWNpQW5mdTVmVWpNQzI5eTVm?=
 =?utf-8?B?SllWYUxrQW4xRmVGRXZzY2Z6b3p2SnhMeitQOUk2MnByejRIaFVkYzFHV2dL?=
 =?utf-8?B?bWtuNlMxQjlVZEtUVlliYmhMS2diYjdidmtxVTBqSEsram9CYk5NNlNjQlFJ?=
 =?utf-8?B?NzVjbHUwQThvbStPUVllTzg2ampDVWYxbHpRUUhqK0NNRGhWTjdtKzQ4SHht?=
 =?utf-8?B?T3E4NWZ5OU10Qzh0TmdMbFpjZWlHZk1oL3Z0MGZPWG1pVnIxN3dkWUl5aitY?=
 =?utf-8?B?aXBGQ0lqTFpYdnk0RXI4N2d4VmJiaXFlbFhvZmpISmc1SStkajRwQnhPU3gw?=
 =?utf-8?B?QVlHNEJuam5YL05NK2d6bG5hWkpkWWlEWnhpSjM3U3lmd2dvNHZzZTVrSDho?=
 =?utf-8?B?V213MVVaR2ZXSGh6cHlab3pIU0xKVmxFVHlSZERrbFhCQzJxTExMbkhwUmdL?=
 =?utf-8?B?NkNyVGNTK29mZ0dwa2pQdE0wRUdiMjk0dTBvQ3M0QnpoRUlrazlOSCszaEE0?=
 =?utf-8?B?K292K3BiZnRjaUs0QlhUbGdRWEF1bWJiRGIrWlRvU1lpYVJtdktBQkZDazMy?=
 =?utf-8?Q?YcSjo+jeZ6TGvDxnpzEtP6n/wQV5Dk6A?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10909
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: eb09b5d2-a4a0-42c6-d715-08de376c4bae
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700013|14060799003|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXFnbnFoVHRIdFdUT2orTnRCT0t1SzJMUkg3cElNVmFUWjFtNWsycXpLbFdM?=
 =?utf-8?B?eVk5YlhjN2d6QWYzY3NPMUN0WXpxK2pJbUF2NDVVTGpZdk5Ec2FpWFRwN2Vu?=
 =?utf-8?B?bDlPNlltcWNadUJzMTNrNWlkVGRnWjBLUS91cFVPRENkVnVYOHNaZjFVSG9h?=
 =?utf-8?B?K3pUL29sZ2RCWDlTNWFmVUI0Kzlnc3FwekZvMEVUcm9oKy96RDNVc2pTMDR5?=
 =?utf-8?B?S0J0am9EdDBWN3VwcU9UeVd3bWU4c2g3dDF4SlVsK1JWMm5DRjFEalJoVVUy?=
 =?utf-8?B?NjhaSnFOQ1pPaTUxYnZSWTRKbXRKL2p6M3J6QWVVTlRtM2l6M1d1eHJnSVVs?=
 =?utf-8?B?c3ZaQndha3B0cUhYYTlsTkFCMkE0Z0VQSVVsTVNuNUpnZjRjVkh1NFY3cjVS?=
 =?utf-8?B?QmRURkhjNVJ2T05Md1hOMWpEMzVweVFTR1lMc1dGeG1kQUlFUnBkWXYrR2lZ?=
 =?utf-8?B?TldzQVpvSlJwN21HZ1VneTBGSVZRbWRTQXVxeTdrakQxOUhZRW02bFhUd2hB?=
 =?utf-8?B?eFhPV1hwb095VU1BVm9za0VuVjhMenVxb0NGOEFMWGhZd2M1SnJsVHBWa2Fm?=
 =?utf-8?B?cTBaa1hMalk2Y1pxVXBNem4ybzBRcllWZ3I3emovSUlTbWlKbDRkbU1NSUdO?=
 =?utf-8?B?TGR2WW5EMnpSSnFFWW1yQXZZSzg4YmlaMWUwT2VpUWl3eEllVCt0NXVsNGhI?=
 =?utf-8?B?YnRpQjdFWG5MNU9DUCtmbitXd3JzNVlwWTl4Um1oRWxRUWVXd2pFRFBDM050?=
 =?utf-8?B?cWtyaTNJMlRYTTFsL3krK1BmRkJoenZiamwxOWpKVHpMVFlyQ1IvN3ZtUHI5?=
 =?utf-8?B?ZG1jeE5kQzZXNUw2SDZXV0Fib0pEWForMUtUdkZjWFZDK2JJbFVZN3g1QmxX?=
 =?utf-8?B?aTIzSFRLVlByenhtdWdWY0ZxSUFFb0pBQmtwY0l0Z3duYjNtNGZ6WjB0SmxR?=
 =?utf-8?B?bTFhcTBMS3A3RGdRbmZqWFBna1IxT0wwdHVhTkpYSjNoNkxEQ3RsTGx6YlpC?=
 =?utf-8?B?bjVGU3RlVVFJV2hvbEwrNVkvcEgrU3plbHowK3dzRkZGelZLWDg0dmQ3eVJP?=
 =?utf-8?B?VnJJMiszbU0zUnZka3RiYTFYTmZRdDQrZDVwNUpDMlhLRVEvNE1zL0hEblhn?=
 =?utf-8?B?SUdMMjN2aDN6dU8rZnZWMlF4UURJRHAwa1JWVWJqcDZZN3VTQTF0MmhtNzhQ?=
 =?utf-8?B?MnVHVmNlN0VqVlFyeGFzM3F2MDh6c1ZicTN4ZG1yZlpHbmFuNFN2VWFTcGw2?=
 =?utf-8?B?V2x5eVNoMDhjNU50WDFGVXljK25nNHAxdjVRa0NMZDh2VlRPZEpObG83Z1hi?=
 =?utf-8?B?aVNlTXVmSlpBQW5DUzkxU0VDUVVnS0J2ZGVVcDh1ZGlYV1FMdS80dWdvdVkr?=
 =?utf-8?B?M1JQbWtUdVBKWlpTRzBBQWhkN3hVTXk3NDdqYThrRi96MmJXRnlsVG1HNzJp?=
 =?utf-8?B?Vkk2bTh6QlF2bE9LcDZXenZqcnVqK3R2WmhJWDZwc1JsUVVTa2s5RU5qSjJj?=
 =?utf-8?B?dUVrUEI4VkYrZkpDaFAyMkZxbXpOVFNTWUNocHBodnhMY3NNZ2RHY3UraDJ2?=
 =?utf-8?B?ejRtejdLQW1TRmNYUmJFdXVPSHY5a25ZTlhIajhMM25MRFBRL3d1UHFWWTNC?=
 =?utf-8?B?Z0JlVVpGVEYrZFFwZ2lPdkxrdUErWHlvNVg2RXA1bGJDeG1Lb2VOaUdwK0E3?=
 =?utf-8?B?S0E1SHV1NXd4Zjk2T1N3VDNVWE40Yi9KYTNmVkJXWGx5cXNiMFhTT0UzVHJn?=
 =?utf-8?B?RjBFeFlJbTU1dEt6ZjAySGdxaUc4d2poTVFQNU9yUm5KY2hwd1JwSWN6eExR?=
 =?utf-8?B?RHBGcUpEMG8zV0RsMEhrWFZONC9BOU1pR3UwYVJkYUpURVN1aTJhazFzakJW?=
 =?utf-8?B?TUU1NTZiVDNYQWNSOG5DakorbHV5OWRmNDRMckkxbkFtZGRHQWVFR2twQ01h?=
 =?utf-8?B?RE1STVRlMExBL2FnT0IxYUpEZ1VhTUJ4L1h3akMraW9oM0hDV0NMRkhEMG00?=
 =?utf-8?B?WEdyUzNQSUJtOERTNHhKeHRDU295TkhKcEZnT0RVMGxES0FabnlIR040UGdD?=
 =?utf-8?B?SjlIRndYRlRLWkExWFRBQUR5eFlIb2ltMXJkMnF2aGFxTHpZaTI3bFltbnY2?=
 =?utf-8?Q?+9Ws=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700013)(14060799003)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 21:45:43.8710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafeef43-2549-488b-6c24-08de376c4e14
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6530
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

On 12/9/25 16:32, Ralph Siemsen wrote:
> Hi Sean,
>
> On Mon, Dec 8, 2025 at 5:55=E2=80=AFPM Sean Anderson <sean.anderson@seco.=
com> wrote:
>> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> > index 2afb15fff1e..94054ba39b0 100644
>> > --- a/drivers/spi/Kconfig
>> > +++ b/drivers/spi/Kconfig
>> > @@ -223,6 +223,14 @@ config DESIGNWARE_SPI
>> >         access the SPI NOR flash on platforms embedding this Designwar=
e
>> >         IP core.
>> >
>> > +config SPL_DESIGNWARE_SPI
>> > +     bool "Designware SPI driver in SPL"
>> > +     depends on SPL
>> > +     default y
>> > +     help
>> > +       Enable the Designware SPI driver during SPL.
>> > +       See the help of DESIGNWARE_SPI for details.
>> > +
>>
>> In addition to Tom's comment this should probably be moved out of the
>> SPI/DM_SPI if/endif and made to depend on SPL_DM_SPI.
>
> Ack for Tom's change, but I am puzzled by your request to move it out
> of the existing ifdev. I would think that we'd want the two options to
> appear next to each other when running 'menuconfig'.

That would be good, but each `if` adds a dependency on the condition,
and this is incorrect for SPL.

> While I admit that adding SPL- and perhaps TPL- prefixed symbols is a
> bit messy, it seems to be how it has been done elsewhere. For example
> drivers/clk/Kconfig has quite a few such cases.

And if you notice, in that file each config explicitly specifies whether
it depends on CLK/CLK_CCF/SPL_CLK/SPL_CLK_CCF rather than using an if.

If you don't like the configs living too far apart, you can move
DESIGNWARE_SPI out of the if as well and explicitly add a dependency on
DM_SPI.

--Sean

[CES 2026, SECO]<https://exhibitors.ces.tech/8_0/exhibitor/exhibitor-detail=
s.cfm?exhid=3D001Pp000010EbaOIAS>
