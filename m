Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEBBC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 15:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C285887E8;
	Wed, 12 Jun 2024 17:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="IQIsatHq";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="IQIsatHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863018880E; Wed, 12 Jun 2024 17:49:55 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2620::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15259887E8
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 17:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vasileios.amoiridis@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/J8ptaCdvoPGkGBmCUm7tttx6rhZrKgbYV2otDpqX9RSRMxMBiqZ4AiNOucLgU4LhRT0e3NzpKnHp9bOZ3gADl7rfu8RmpMorlFh2QhhAplPHPkx/PbPN+K30nfWHlTk/OGbz7eSIUgqvSoCUo91UlkbwZKk18am4DHKwO9Na3RpgkLRM0ruItT5pjfKeLqEZZmyBF2BVJKlg+jIFLm56cD5MwxcCu4+Wqk7bk1WYXXUj1PbgTqb73yGtR8rB6UiMuEz9uM/6zGx6eljSy7/UEGDUslz23iqbBwmNzFldBkHcdw8po6RaJW21Xfygbj/qXEqkdniz3nsXJ9wZ1Uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLWs+Q0gC+NKlPI6IgShoWxqJ6kOhM/9jxbW7B9Cby0=;
 b=k0mpAZtMpkfIXR1WqSoke9KgSRmvefcEuyQGa1E1STaRTJ0knEWFr40t9dcQoaODiwV/Vgpkq4KRGfUtw8p2c98c5j36XVFYGjKRb28l4tI1pn/QT9rtciJ1Zpfb5Syaj86GsW5AulQUuME/Xr3wCOhTsW5ckxkYpAjvzuiMBJUw3owiclnipAw80IkRU/hYprUeztStb07SJBwel+zKh14ElmddzrVMTn+U3VkBUfzneljmAiRP0nwizqZWZRjVAq3koc4oZzeMiNIHM97mD1apkjTLEAsxOsS/uGlz4Rerook+mijjXrwNLFOYZaXiZTecLAEtQy+JdUbhtTF3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLWs+Q0gC+NKlPI6IgShoWxqJ6kOhM/9jxbW7B9Cby0=;
 b=IQIsatHquwdkUZLkgCuqLQ6LHPeLPcXezQC+U99cRl/Q3RhbEMcxODlqGPMA9/jqa1x3306zEC1iizFqJv4Vg0oxPB2jDY61SSdJsJFckmiA/dZIthkc1jsnMP5nlICqexdyU7D/5Dh5qwB+cYl9p0SXIH4JvxCgCneabM61XhY=
Received: from DU7P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::18)
 by ZR3P278MB1655.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 15:49:51 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::a2) by DU7P190CA0006.outlook.office365.com
 (2603:10a6:10:550::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 15:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7677.15
 via Frontend Transport; Wed, 12 Jun 2024 15:49:50 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.6])
 by mx1.crn.activeguard.cloud (Postfix) with ESMTP id 3DC99FE5B0;
 Wed, 12 Jun 2024 17:49:50 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
 by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id A7616FE210;
 Wed, 12 Jun 2024 17:49:48 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=IQIsatHq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLWs+Q0gC+NKlPI6IgShoWxqJ6kOhM/9jxbW7B9Cby0=;
 b=IQIsatHquwdkUZLkgCuqLQ6LHPeLPcXezQC+U99cRl/Q3RhbEMcxODlqGPMA9/jqa1x3306zEC1iizFqJv4Vg0oxPB2jDY61SSdJsJFckmiA/dZIthkc1jsnMP5nlICqexdyU7D/5Dh5qwB+cYl9p0SXIH4JvxCgCneabM61XhY=
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::9) by
 ZR0P278MB0026.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:19::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.20; Wed, 12 Jun 2024 15:49:46 +0000
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67]) by ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67%3]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 15:49:46 +0000
From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
To: "michal.simek@amd.com" <michal.simek@amd.com>, "vassilisamir@gmail.com"
 <vassilisamir@gmail.com>, "monstr@monstr.eu" <monstr@monstr.eu>
CC: "LPolak@arri.de" <LPolak@arri.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "santoshsagar.algapally@amd.com"
 <santoshsagar.algapally@amd.com>, "venkatesh.abbarapu@amd.com"
 <venkatesh.abbarapu@amd.com>, "sr@denx.de" <sr@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
Thread-Topic: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
Thread-Index: AQHatdXD0/P73fwV50Kiuh9pvfodrrHEMRQAgAAEGQCAAA32AIAABsSAgAAFyYCAAATvgA==
Date: Wed, 12 Jun 2024 15:49:46 +0000
Message-ID: <96faa31fd92d13a4bfab92a2f65b53cee8423d3b.camel@cern.ch>
References: <20240603164738.437834-1-vassilisamir@gmail.com>
 <CAHTX3d+mD+iqJ-+N4W+y5XVUozVqq-n19-zRBBT5BqDs3BpJAg@mail.gmail.com>
 <482398653f2b41292c056eb67077ca29f0b9a7ae.camel@cern.ch>
 <48dc217d-f5ca-4ba0-b174-18b4ba6ac0d8@monstr.eu>
 <a1567b35ac623cfcbcc28ba12f43813f6e3d8887.camel@cern.ch>
 <b0954805-8e3c-4594-956c-9e011f858522@amd.com>
In-Reply-To: <b0954805-8e3c-4594-956c-9e011f858522@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic: ZR2P278MB1164:EE_|ZR0P278MB0026:EE_|DU2PEPF00028D0C:EE_|ZR3P278MB1655:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c52d28-f0a4-4672-076f-08dc8af74b7e
x-ld-processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?SHF3OVdqQ3JXbmVqTGlZQWUycFBkVlVYWW1VOXN4dUc2OTFXK1FWOVN3TXVk?=
 =?utf-8?B?emRRbjZWQk1sdUgxZVUzaFVyVWdaNVBnZmwyU0dhN0ZOTVdlVHViV2JKakxY?=
 =?utf-8?B?QnU3dlJBU1Nmc3l2RHdpN1FyK3MzOUxRd1JpQ3VwMnQ0U0xvS1B2b1BmTzZD?=
 =?utf-8?B?eGVJR0E1Sm1BZXNkUUdTMDdmdU81NEJ6Tjc3d0dtUSt2YUd4c280NG81SVVV?=
 =?utf-8?B?QUZBZ3RyaENENmtsTFdrMndRRjNTUndCTFBJL2tXQUlLWFU3a3J6UkRvUjJS?=
 =?utf-8?B?WE4rOGR2RW84MVhSS0FGYmpZakpwUnVZRWdCblQ1RHJ3QWRSdHNDNkxFQ1A1?=
 =?utf-8?B?NVJRczAvSkhjUFpVc3hQZjdDdWxycXdYOWxVVjlGaTcydTJYaS9HOWM0T0ll?=
 =?utf-8?B?TDY2clRxdnVmN3U3dS9uTkxaZFcrRGJmSzRvemg4Y0FVblY3NjJMVTBha3Rw?=
 =?utf-8?B?ZXo2YTZVVHV0VnRDT0doOUQyVWhjWERLY296UGFodXdhdHZVRXJUMFRzYjMx?=
 =?utf-8?B?L2JZa1JnQVNpa1ZXNSt4VHlDWUloeHFWYzVJY1N0MHdNZ1c5bWNwMmlDWmU3?=
 =?utf-8?B?WEpDaTYxdGd0QTVsRXRoWks3Tjd6d2ZWekRQZlZGQnNlMVAzUHBpYVJMYnpv?=
 =?utf-8?B?dGdDNCswNW0yb2k3d3dGbHdQdHlMYVo4aEROc0g5dEgrazBseUJVMXY1VG1w?=
 =?utf-8?B?ejRsdk13a09lQjMwdXVMKzdmWXova3hsNGtPNW55c2JTY2p2YUltVmVRV2N2?=
 =?utf-8?B?Z0I1a0NvRTZOR216b3A0d016MUtXYnNGQTBabGRZZHlCTWhHOENhZHhLWGxM?=
 =?utf-8?B?WlFGQlFpcU9uMllRSTl1eUVKaXhSVmFSSk1NWEc4dGNLS3RvSHRib0RBbU83?=
 =?utf-8?B?L1RxeHY1a2oxRnFoL2w4Z2ViUWloZk05S004ZWJoK1ZtOStPQ2xwS0F0WlQ0?=
 =?utf-8?B?Y21oUTVMRG14YWtJdytzYklKcWlsSkQ1RXZNSHR4T0lSU2E0cCtseGhudFNa?=
 =?utf-8?B?TTB2OTNWemczNjdZOVJQMTJYZlFLQWFSNnRUc09LTERYY3hQUDl0dWFnNEVW?=
 =?utf-8?B?SnJ2bHhFVHo3RzNHZ1hOZlZrYnZXR3h3WWxMdHlmZGJPZExZRi9ZVjVPbmlJ?=
 =?utf-8?B?YktGYnNGOTBPOXM5ZVRTaDByYWhPT254b3Z1L2gzeWl5YkZDMkMrK2dFaEE4?=
 =?utf-8?B?N0xZdEZKcWJ6QUg3T2NKakxuNVdVSmY3alJsQ1NuZWN3aDl6eXV4Rkt2Sk1z?=
 =?utf-8?B?RXNoVXVYMHM0bENMOVhaK1hkQndXdHNoRDNPQS9MR0pUblNzU05rdmJtNm10?=
 =?utf-8?B?MFJJcHQwdEpoUmsrWlFPSjI2QTNrOVVENTdFc0s1RElMZ09icnZ3cnZ2aHBv?=
 =?utf-8?B?L0xESjRmQyszZGxMT3lFeS9pQ29BZVNnTEtmWnllK09MZlhRYTc5S2hSaUNk?=
 =?utf-8?B?SnBXWVFoekNMbFpDMjdLTTRMTmRRblBxK1gxUzZUbzdyR0JZK3pJSC8zMDdp?=
 =?utf-8?B?aDlOL1dWVjBKT0JxQzFxQ0plbmgyTStZaWpnbGlrZUpkeTZYOE83RVZ0YTdw?=
 =?utf-8?B?bVBJc0w5ZWVrTzloV3pXeWZaYkFhZ1NGRjlmVEVBcWs0NFdHZDAyYmZCV2s5?=
 =?utf-8?B?TG9wY2dVcHRINHZjaTFPdEhJKzhaYWxVYUk4MkovMmdpZ24zaWRHeUZuZDFv?=
 =?utf-8?B?NGRxbTBaTWEyTnl2a1o0OEx1RHBhMEVDODFsd1RnNW1wMmxWSGhwck4wd3R6?=
 =?utf-8?B?WmpRbEpyNFRiQjk1K2Vna0tFa2JWS1lyNm9iY2FJWWsyV3VwWTRVcE14M1h1?=
 =?utf-8?Q?ktWAQMzHrllqmgy0wqzCglptaDrcxlX5bX78o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48F988B5D06E7C439150F32A7BB859F2@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0026
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 289c02a0-1ce1-453e-cc54-08dc8af748c1
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|35042699016|36860700007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE5waHlsVTFZS1N1NkNKMXVaVmdlMGFPSlhHckZCZnJXRHkveG5xQVlkQUJY?=
 =?utf-8?B?YlVEQ2N1UGkwL0NBUExBd28zVVVjem4yT3VtV01Nd1Y3eWFHVzFWa1p3NTc1?=
 =?utf-8?B?Y0luUzhHcjRtWVJtQ1N3RjBEenFjemh4VW5WSkltQy95MVJ5bUdJRXRsZzZX?=
 =?utf-8?B?OUFWdE05b1pYRHgveTM3OVliVGQzVG9ZUkpvb3FiRHBPQTNOK3lJZHFNcTcz?=
 =?utf-8?B?SlVLOFNybHAwSHUzQmVZMGRIOWIrQlRkMjNaMEZrWTE2YlhHYUFJT1VHRlIv?=
 =?utf-8?B?VDhHL2tMVTdiVFpKTkhROHRWcWoxclhQakt0dTQ0d0FHZ0tiRGlGeHZoaGpk?=
 =?utf-8?B?TXJBWU81MytlY0o3Y1pwNXNaWXRlbWFOUDFWR1JiN1JOandmUU5YV0J0eG52?=
 =?utf-8?B?UWV0SUZuMkIwemxrNTRaVWhvWmxZSjdWV1YwU3lOR1JNWjFUVXNOdjdEb1lo?=
 =?utf-8?B?L0ZxK3BERFA1RFFpU1AvTzg1KzV1ZXBNZ21rUkJNa0MzUkxUOU1Md1R1SlF0?=
 =?utf-8?B?dnhiTFIyRW92VjdBY3lTdW1BaDgxMS8wdHpGMjdOSlREUWY3dit4dGg4alVE?=
 =?utf-8?B?KzJKRmtEeXRaRXJjcTNnZDFKdDdobGFFbjRaQURMdVFrSEhBYkEvN2FGbnFN?=
 =?utf-8?B?bW9KbWcwRmZmcEt2blNKODRwRDROSlRXVjZaOGRNMXdFVlRkTERsWmV0dktU?=
 =?utf-8?B?T0UxYmgyNEllQTNDcVE2MjdpZzAzSVgyNS94NldFSVRwcFc1SVZKNUxOTXEv?=
 =?utf-8?B?QUhkcExRZ2pEeWpNRVZXeS82RHJwdjlLZG13UlhNU2h4ZHJqd1diZXpqTjRD?=
 =?utf-8?B?QzFTSHFnYjRJV0lKckxqRlUwMjBzekN3dUxtQThCOHJyT3h0ekZKRzRidkNT?=
 =?utf-8?B?Y2wxSzRwbmdmMzVkTTJsT2hPeVhNcElzd2JzbWhQSG1NdG9xQVZhSHlxUGVw?=
 =?utf-8?B?YjE3VnRsbVRvRDVhZGgyYzBDNFUrQm1WRkZwYjBWSHk3L2tpVmxBdTYwSU9w?=
 =?utf-8?B?V05jYWlFc2xtZUM0YkVnRmlkS1NSdnVERTdyWVl1TFlwZU9WcTN3NXFMdHp4?=
 =?utf-8?B?c1BHb3Q1MUN0bk40dlM3Wm1kcVNWQ3ZGOXRjYmhNam5ZbzM5OFJwaU1uZTVB?=
 =?utf-8?B?enQ0bGpic3k2Vkh0QnliNzBzZmhMK0c0Zy9CK1ByOTN1ZmtGTnJVTjNxWHFx?=
 =?utf-8?B?OTBvQVl2U2tPVW9VV0dGUndGcFdVQnRxT2M0cXp2WkVMUnpuS1RmZ3NUVzdp?=
 =?utf-8?B?OUVMMkhRYWxJZnlsMWhoRG9hZ2ZyWDZLNm5PQ2VlWng1QjR2K2p6czY2UXBv?=
 =?utf-8?B?UW5NOTJUeTZDS3FsdUJHK3AwUnUrbENYUXFqTEdvdVgxUitwTHJMRVNXcnhS?=
 =?utf-8?B?aVBDZWVVQW1weUI4NmprYjlDbTdtSHZORysvTnpmWGc1V0tEYmlVdGVPMjB0?=
 =?utf-8?B?NFF0NEY4YWtta2dDTkljT1pFUzVSbGlKS2lHeDBuOHQ3VGFTbGcyZVdPVEpX?=
 =?utf-8?B?MDdBRXVjdkxFWVVvOE5WeGRKRjNCQzBZS0V4NkszbkhZY3JkbWdMNUNhektD?=
 =?utf-8?B?Vm4rb1BlSFBzMVJlNmhDTUJkRDIwa2crY3c5RERYalRDZU9iUEZKc3JTS3l1?=
 =?utf-8?B?UUpJODhUSmZKZzRORVRMR21rbEd6QjZsWUF5ZmVyVUFQanpjQ0o3TCs5c29U?=
 =?utf-8?B?aDJHUTRwN2lqNW9sL0R1aEdYYWpuT2JGMHRkNm1NVytUenBYR0JBVzZtZFZQ?=
 =?utf-8?B?azcvRzZZeElTSXJ1SjNaZUQ5bTVDU2NJOWlITUc4bGtmQ05lTTBiSGpuZWVR?=
 =?utf-8?B?Z2JTOWl5Q3oxUEtlRjAzVVpJTTZISEhBZ1pVMk5vY3hPVHJySTB5bTFiSG1H?=
 =?utf-8?B?YmhUdWZ4TmlaaXkrNDF1ZCthWVJ6M0JyUWRvN1NlZHpPdmc9PQ==?=
X-Forefront-Antispam-Report: CIP:51.103.219.121; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx1.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(35042699016)(36860700007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 15:49:50.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c52d28-f0a4-4672-076f-08dc8af74b7e
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.103.219.121];
 Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1655
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

T24gV2VkLCAyMDI0LTA2LTEyIGF0IDE3OjMyICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+
IA0KPiANCj4gT24gNi8xMi8yNCAxNzoxMSwgVmFzaWxlaW9zIEFtb2lyaWRpcyB3cm90ZToNCj4g
PiBPbiBXZWQsIDIwMjQtMDYtMTIgYXQgMTY6NDcgKzAyMDAsIE1pY2hhbCBTaW1layB3cm90ZToN
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiA2LzEyLzI0IDE1OjU3LCBWYXNpbGVpb3MgQW1vaXJp
ZGlzIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIDIwMjQtMDYtMTIgYXQgMTU6NDIgKzAyMDAsIE1p
Y2hhbCBTaW1layB3cm90ZToNCj4gPiA+ID4gPiBIaSBWYXNpbGVpb3MsDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gw7p0IDQuIDYuIDIwMjQgdiAxNToyMSBvZGVzw61sYXRlbCBWYXNpbGVpb3MgQW1v
aXJpZGlzDQo+ID4gPiA+ID4gPHZhc3NpbGlzYW1pckBnbWFpbC5jb20+IG5hcHNhbDoNCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gRnJvbTogVmFzaWxlaW9zIEFtb2lyaWRpcyA8dmFzaWxlaW9z
LmFtb2lyaWRpc0BjZXJuLmNoPg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBDaGFuZ2VzIGlu
IHYyOg0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIC0gUmVtb3ZlIGR1cGxpY2F0aW9u
IG9mIGN1c3RvbSBoYXJkY29kZWQNCj4gPiA+ID4gPiA+IGVudl9sb2NhdGlvbnNbXQ0KPiA+ID4g
PiA+ID4gY29kZS4NCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAtIEFkZCBpbXBsZW1l
bnRhdGlvbiB3aXRoIGdlbmVyYWwNCj4gPiA+ID4gPiA+IGFyY2hfZW52X2dldF9sb2NhdGlvbihv
cCwNCj4gPiA+ID4gPiA+IHByaW8pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IHYxOg0KPiA+
ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290LzIwMjQwNTIyMTc0NzM4Ljcz
NTIyLTEtdmFzc2lsaXNhbWlyQGdtYWlsLmNvbS8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
VmFzaWxlaW9zIEFtb2lyaWRpcyAoMSk6DQo+ID4gPiA+ID4gPiDCoMKgwqAgeGlsaW54OiBBZGQg
b3B0aW9uIHRvIGxvYWQgZW52aXJvbm1lbnQgZnJvbSBvdXRzaWRlIG9mDQo+ID4gPiA+ID4gPiBi
b290DQo+ID4gPiA+ID4gPiBtZWRpYQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiDCoMKgwqBi
b2FyZC94aWxpbngvdmVyc2FsLW5ldC9ib2FyZC5jIHwgNDcgKysrKysrKysrKysrKystLS0tLQ0K
PiA+ID4gPiA+ID4gLS0tLS0NCj4gPiA+ID4gPiA+IC0tLS0NCj4gPiA+ID4gPiA+IMKgwqDCoGJv
YXJkL3hpbGlueC92ZXJzYWwvYm9hcmQuY8KgwqDCoMKgIHwgNDcgKysrKysrKysrKysrKystLS0t
LQ0KPiA+ID4gPiA+ID4gLS0tLS0NCj4gPiA+ID4gPiA+IC0tLS0NCj4gPiA+ID4gPiA+IMKgwqDC
oGJvYXJkL3hpbGlueC96eW5xL2JvYXJkLmPCoMKgwqDCoMKgwqAgfCA0OSArKysrKysrKysrKysr
KystLS0tDQo+ID4gPiA+ID4gPiAtLS0tLQ0KPiA+ID4gPiA+ID4gLS0tLS0NCj4gPiA+ID4gPiA+
IMKgwqDCoGJvYXJkL3hpbGlueC96eW5xbXAvenlucW1wLmPCoMKgwqAgfCA1NSArKysrKysrKysr
KysrKysrKy0tDQo+ID4gPiA+ID4gPiAtLS0tLQ0KPiA+ID4gPiA+ID4gLS0tLS0NCj4gPiA+ID4g
PiA+IC0tLS0NCj4gPiA+ID4gPiA+IMKgwqDCoDQgZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlv
bnMoKyksIDk3IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAtLQ0KPiA+
ID4gPiA+ID4gMi4zNC4xDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGhh
dmUgdG8gcmVtb3ZlIHRoaXMgcGF0Y2ggZnJvbSBteSBxdWV1ZSBiZWNhdXNlIGl0IGlzDQo+ID4g
PiA+ID4gYWN0dWFsbHkNCj4gPiA+ID4gPiBicmVha2luZyBjdXJyZW50IGJlaGF2aW9yLg0KPiA+
ID4gPiA+IENJIGlzIHJlcG9ydGluZyBhbiBpc3N1ZSB3aXRoIGl0IGFuZCBJIGRpZCBhIGNsb3Nl
ciBsb29rIGFuZA0KPiA+ID4gPiA+IHdoYXQNCj4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+IGhhcHBl
bmluZyBpcyB0aGF0IGlmIG9uZSBsb2NhdGlvbiBoYXMgbm8gdmFsaWQNCj4gPiA+ID4gPiBkYXRh
IGl0IGdvZXMgYW5kIGxvb2tzIGF0IGFub3RoZXIgbG9jYXRpb24gZnJvbSB0aGUgbGlzdC4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEJ1dCB0aGF0IGlzIHRoZSBkZXNpcmVkIGJlaGF2
aW9yLCBpZiB0aGUgZW52aXJvbm1lbnQgaXMgbm90IGluDQo+ID4gPiA+IG9uZQ0KPiA+ID4gPiBs
b2NhdGlvbiB0byBjaGVjayB0byB0aGUgb3RoZXJzLg0KPiA+ID4gDQo+ID4gPiBUaGF0J3MgaG93
IHUtYm9vdCBpcyB3cml0dGVuIGJ1dCBpZiBkZXZpY2UgZG9lc24ndCBleGlzdCBvciBub3QNCj4g
PiA+IGFjY2Vzc2libGUgYnkNCj4gPiA+IHUtYm9vdCBpdCBpcyBjbGVhciB0aGF0IGl0IHNob3Vs
ZG4ndCBiZSB1c2VkIGFuZCB0aGVuIGJlaGF2aW9yIGlzDQo+ID4gPiBjb3JyZWN0Lg0KPiA+ID4g
DQo+ID4gDQo+ID4gSG1tbSwgaG93IGNhbiBhIGRldmljZSBiZSBub3QtYWNjZXNzaWJsZSBieSB1
LWJvb3QgYnV0IHUtYm9vdCBzdGlsbA0KPiA+IHRyaWVzIHRvIHVzZSBpdD8gSG93IGNvdWxkIHRo
YXQgaGFwcGVuPw0KPiANCj4gVGhhdCBYaWxpbnggdmlydHVhbCBkZWZjb25maWcgYXJlIHNldHVw
IGluIGEgd2F5IHRoYXQgYWxsIGRyaXZlcnMgYXJlDQo+IGVuYWJsZWQgDQo+IHZpYSBLY29uZmln
IGJ1dCB0aGV5IGFyZSBub3QgcHJlc2VudCBvbiBhbGwgYm9hcmRzLg0KDQpPaywgbm93IEkgdW5k
ZXJzdGFuZCBob3cgdGhhdCBoYXBwZW5zLg0KPiBJZiB5b3UgbG9vayBiZWxvdyBpbiBkZWZjb25m
aWcgd2UgYXJlIGhhdmUgdGhhdCB2YXJpYWJsZXMgY2FuIGJlIGluDQo+IE5BTkQgYnV0IA0KPiB0
aGVyZSBpcyBubyBOQU5EIGRldmljZSBvbiB6YzcwMiBidXQgc3RpbGwgdS1ib290IHRyaWVzIHRv
IHJlYWNoIG5hbmQNCj4gYW5kIHJlYWQgDQo+IHZhcmlhYmxlcyBmcm9tIGl0Lg0KPiANCg0KU28s
IHRoZSBpZGVhbCBzY2VuYXJpbyB3b3VsZCBiZSB0byBVLUJvb3QgbmV2ZXIgdHJ5IHRvIGFjY2Vz
cyB0aGUNCmRldmljZT8gQmVjYXVzZSBmcm9tIHdoYXQgSSBzZWUsIGlzIHRoYXQgc2luY2UgdGhl
IGRldmljZSBpcyBub3QgdGhlcmUsDQpVLUJvb3QgdGhyb3dzIGFuIGVycm9yLCBhbmQgbW92ZXMg
b24uDQoNCj4gPiANCj4gPiBBbHNvLCBJIHRoaW5rIHRoYXQgdGhpcyBpcyBhIHByb2JsZW0gb2Yg
dGhlIHVzZXIsIG5vPyBJZiBmb3INCj4gPiBleGFtcGxlDQo+ID4geW91IGhhdmUgY29uZmlndXJl
IEVOVl9JU19JTl9OQU5EIGJ1dCB0aGVyZSBpcyBubyBOQU5EIGRldmljZSwgdGhlbg0KPiA+IHdp
dGggdGhlIHBhdGNoIHlvdSBnZXQgYSB2aXNpYmxlIGVycm9yIHRoYXQgVS1Cb290IHRyaWVzIHRv
IGFjY2Vzcw0KPiA+IE5BTkQgd2hpY2ggaXMgbm90IHRoZXJlLg0KPiANCj4gRm9yIG91ciBwbGF0
Zm9ybXMgd2hlcmUgeW91IGNhbiBidXJuIGJvb3QuYmluIHRvIGFueSBib290IG1lZGl1bSB3ZQ0K
PiBoYWQgbm8gDQo+IGNob2ljZSB0aGF0J3Mgd2h5IGNvZGUgd2FzIHdyaXR0ZW4gbGlrZSB0aGF0
IHRoYXQgdmFyaWFibGVzIGFyZSBzYXZlZA0KPiBhbGwgdGhlIA0KPiB0aW1lIHRvIGJvb3QgbWVk
aXVtLg0KPiBBbHNvIHRoYXQgSSBkb24ndCB3YW50IHRvIG1haW50YWluIG90aGVyIGRlZmNvbmZp
Z3MgZm9yIHNsaWdodGx5DQo+IGRpZmZlcmVudCANCj4gY29uZmlndXJhdGlvbnMuDQo+IE9uIHBy
b2R1Y3RzIGN1c3RvbWVycyBzaG91bGQgbG9vayBhdCBvdXIgYWxsIGluIG9uZSBkZWZjb25maWcg
YW5kDQo+IGRpc2FibGUgdGhpbmdzIA0KPiB3aGljaCBhcmUgbm90IG5lZWRlZC4gQW5kIHdoZXJl
IHZhcmlhYmxlcyBhcmUgc2F2ZWQgaXMgZGVmaW5pdGVseSBvbmUNCj4gb2YgdGhlbS4NCj4gDQoN
CldlbGwsIHRoYXQgbWFrZXMgc2Vuc2UuDQoNCj4gPiANCj4gPiA+IElmIGRldmljZSBleGlzdHMg
YW5kIHNpbXBsZSB2YXJpYmxlcyBhcmUgbm90IHlldCBzYXZlZCB0aGVyZQ0KPiA+ID4gZ29pbmcg
dG8NCj4gPiA+IGRpZmZlcmVudA0KPiA+ID4gZGV2aWNlIGlzIElNSE8gcHJvYmxlbWF0aWMuDQo+
ID4gPiANCj4gPiANCj4gPiBNYXliZSBJIGFtIHN0aWxsIGEgYml0IGNvbmZ1c2VkLCBidXQgSSB0
aGluayB0aGF0IGlmIHlvdSBoYXZlDQo+ID4gZGVmaW5lZA0KPiA+IEVOVl9JU19JTl9RU1BJIGFu
ZCBFTlZfSVNfSU5fTkFORCBidXQgdGhlIGVudmlyb25tZW50IGlzIG5vdCB0aGVyZQ0KPiA+IHRo
ZW4NCj4gPiB0aGUgYmVoYXZpb3IgdGhhdCB3ZSBzZWUgaXMgYWN0dWFsbHkgY29ycmVjdC4gVS1C
b290IHRyaWVzOg0KPiA+IA0KPiA+IGEpIEdldCBlbnYgZnJvbSBRU1BJIGJ1dCBmYWlscyBiZWNh
dXNlIGVudiBpcyBub3QgdGhlcmUsDQo+ID4gYikgR2V0IGVudiBmcm9tIE5BTkQgYnV0IGZhaWxz
IGJlY2F1c2UgTkFORCBpcyBub3QgdGhlcmUsDQo+ID4gYykgR2V0IGVudiBmcm9tIG5vd2hlcmUu
DQo+ID4gDQo+ID4gVG8gbWUsIHRoaXMgbG9va3MgbGlrZSB0aGUgY29ycmVjdCBiZWhhdmlvci4g
SXNuJ3QgaXQ/DQo+IA0KPiBUaGlzIHNlcXVlbmNlIGlzIGNvcnJlY3QgYnV0IHdoYXQgaXQgaXMg
bm90IGNvcnJlY3QgaXMgd2hlbiB5b3UgcmVhY2gNCj4gbm93aGVyZSANCj4gYW5kIHlvdSBydW4g
c2F2ZWVudiB5b3UgY2FuJ3QgcmVhbGx5IHNhdmUgdmFyaWFibGVzIGV2ZW4gdGhleSBjYW4gYmUN
Cj4gc2F2ZWQgdG8gDQo+IFFTUEkuIFRoZXkgY2FuJ3QgYmUgc2F2ZWQgdG8gTkFORCBiZWNhdXNl
IGl0IGlzIG5vdCBwcmVzZW50IG9uIHRoZQ0KPiBib2FyZC4NCj4gDQoNClRoaXMgY2FuIGJlIHNv
bHZlZCBieSB1c2luZyB0aGUgZW52X3NlbGVjdCBjb21tYW5kIChjbWQvbnZlZGl0LmMpIG5vPw0K
DQo+IFRoZSBpc3N1ZSBpcyB0aGF0IG5vbmUgd3JpdGUgaW5pdGlhbCB2YXJpYWJsZSB0byBRU1BJ
IHRoYXQncyB3aHkNCj4gdGhlcmUgd2lsbCBiZSANCj4gYWxsIHRoZSB0aW1lIGJhZCBDUkMgYnV0
IGxvY2F0aW9uIGlzIGNvcnJlY3QuDQo+IA0KPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gT24gWnlu
cSBpdCBiZWhhdmVzIGxpa2UgdGhpcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBNTUM6wqDCoCBt
bWNAZTAxMDAwMDA6IDANCj4gPiA+ID4gPiBwcmlvIDANCj4gPiA+ID4gPiBMb2FkaW5nIEVudmly
b25tZW50IGZyb20gU1BJRmxhc2guLi4gU0Y6IERldGVjdGVkIG4yNXExMjhhMTMNCj4gPiA+ID4g
PiB3aXRoDQo+ID4gPiA+ID4gcGFnZQ0KPiA+ID4gPiA+IHNpemUgMjU2IEJ5dGVzLCBlcmFzZSBz
aXplIDY0IEtpQiwgdG90YWwgMTYgTWlCDQo+ID4gPiA+ID4gKioqIFdhcm5pbmcgLSBiYWQgQ1JD
LCB1c2luZyBkZWZhdWx0IGVudmlyb25tZW50DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gcHJpbyAx
DQo+ID4gPiA+ID4gTG9hZGluZyBFbnZpcm9ubWVudCBmcm9tIE5BTkQuLi4gKioqIEVycm9yIC0g
Tm8gVmFsaWQNCj4gPiA+ID4gPiBFbnZpcm9ubWVudA0KPiA+ID4gPiA+IEFyZWEgZm91bmQNCj4g
PiA+ID4gPiAqKiogV2FybmluZyAtIGJhZCBlbnYgYXJlYSwgdXNpbmcgZGVmYXVsdCBlbnZpcm9u
bWVudA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHByaW8gMg0KPiA+ID4gPiA+IExvYWRpbmcgRW52
aXJvbm1lbnQgZnJvbSBTUElGbGFzaC4uLiAqKiogV2FybmluZyAtIGJhZCBDUkMsDQo+ID4gPiA+
ID4gdXNpbmcNCj4gPiA+ID4gPiBkZWZhdWx0IGVudmlyb25tZW50DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gcHJpbyAzDQo+ID4gPiA+ID4gTG9hZGluZyBFbnZpcm9ubWVudCBmcm9tIG5vd2hlcmUu
Li4gT0sNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgaXMg
dGhlIG1lc3NhZ2UgdGhhdCB3ZSBnZXQgYXMgd2VsbCB3aGVuIHRoaXMgcGF0Y2ggaXMgbm90DQo+
ID4gPiA+IGFkZGVkLg0KPiA+ID4gDQo+ID4gPiBJdCBtZWFucyB5b3UgYXJlIGJvb3Rpbmcgb3V0
IG9mIFFTUEkgYnV0IHFzcGkgaXMgbm90IGFjY2Vzc2libGUNCj4gPiA+IGJ5IHUtDQo+ID4gPiBi
b290LiBDb3JyZWN0Pw0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBXZWxsLCB3ZSBhcmUgYm9v
dGluZyBmcm9tIFFTUEkgYnV0IGVudmlyb25tZW50IGlzIGluIGVNTUMuIEluIG91cg0KPiA+IGNv
bmZpZywgd2UgaGF2ZSBkZWZpbmVkIEVOVl9JU19JTl9GQVQgYW5kIEVOVl9JU19OT1dIRVJFIGJ1
dCB3ZQ0KPiA+IGhhdmUNCj4gPiBub3QgZGVmaW5lZCBFTlZfSVNfSU5fUVNQSS4NCj4gDQo+IG9r
Lg0KPiANCj4gDQo+ID4gPiA+ID4gcHJpbyBpcyBteSBwcmludCB0byBzaG93IHdoZXJlIGNvZGUg
aXMuIFFlbXUgYm9vdHMgb3V0IGluDQo+ID4gPiA+ID4gUVNQSQ0KPiA+ID4gPiA+IGJvb3QNCj4g
PiA+ID4gPiBtb2RlIGFuZCBTUEkgaXMgdHJpZWQgZmlyc3QgYW5kIGJlY2F1c2UNCj4gPiA+ID4g
PiB0aGlzIGlzIHhpbGlueF96eW5xX3ZpcnQgZGVmY29uZmlnIGRyaXZlcnMvZW52IGxvY2F0aW9u
cyBmb3INCj4gPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiA+IGRldmljZXMgYXJlIHByZXNlbnQgdG9v
LiBUaGF0J3Mgd2h5IGl0IGdvZXMgb3ZlciB0aGUgbGlzdA0KPiA+ID4gPiA+IGFuZCBpdCBhbHdh
eXMgZW5kcyBpbiBub3doZXJlIHdoaWNoIG5ldmVyIGZhaWxzLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IElmIHRoaXMgcnVucyBvbiByZWFsIEhXIHRoZW4gdGhlIHNhbWUgYmVoYXZpb3IgaXMgdmlz
aWJsZSBhbmQNCj4gPiA+ID4gPiBJDQo+ID4gPiA+ID4gZG9uJ3QNCj4gPiA+ID4gPiB0aGluayBp
dCBpcyByaWdodC4NCj4gPiA+ID4gPiBJIHRoaW5rIHRoaXMgc29sdXRpb24gc2hvdWxkIGJlIHJl
dGhvdWdodC4NCj4gPiA+ID4gPiBJbiBwcm9kdWN0IGN1cnJlbnQgYmVoYXZpb3IgZnJvbSBvdXIg
Y29kZSBpcyBub3QgdGhlIGJlc3QgYW5kDQo+ID4gPiA+ID4gY3VycmVudA0KPiA+ID4gPiA+IFUt
Qm9vdCBpbXBsZW1lbnRhdGlvbiBpcyBub3QgYWxsb3dpbmcNCj4gPiA+ID4gPiBmbGV4aWJpbGl0
eSB0b28uIFdlIGFyZSBlbmFibGluZyByZWR1bmRhbnQgdmFyaWFibGVzIHdoaWNoDQo+ID4gPiA+
ID4gY2FuIGJlDQo+ID4gPiA+ID4gb25seQ0KPiA+ID4gPiA+IG9uIHRoZSBzYW1lIGRldmljZSBi
dXQgbm90IHRoYXQgeW91IGhhdmUNCj4gPiA+ID4gPiBvbmUgY29weSBpbiBRU1BJIGFuZCBzZWNv
bmQgaW4gRU1NQy4NCj4gPiA+ID4gPiBUaGF0J3Mgd2h5IEkgdGhpbmsgbG9jYXRpb24gc2hvdWxk
IGJlIHByZXR0eSBtdWNoIHJlYWQgZnJvbQ0KPiA+ID4gPiA+IERULg0KPiA+ID4gPiA+IFRoZXJl
IGlzIG9wdGlvbnMvdS1ib290IG5vZGUgd2hlcmUgbG9jYXRpb24gb2YgdmFyaWFibGVzDQo+ID4g
PiA+ID4gc2hvdWxkDQo+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiBkZXNjcmliZWQgYW5kIHRoaXMg
c2hvdWxkIHJlcGxhY2UNCj4gPiA+ID4gPiBlbnZfZ2V0X2xvY2F0aW9uKCkuDQo+ID4gPiA+IA0K
PiA+ID4gPiBZb3UgbWVhbiB0aGF0IHRoZXJlIHNob3VsZCBiZSBzb21lIHR5cGUgb2YgbmV3IFUt
Qm9vdCBub2RlIHRoYXQNCj4gPiA+ID4gZGVzY3JpYmVzIHdoZXJlIHRoZSBlbnZpcm9ubWVudCBz
aG91bGQgYmUgbG9jYXRlZCBhbmQgZ28gYW5kDQo+ID4gPiA+IHNlYXJjaCBpbiB0aGlzIGRldmlj
ZT8NCj4gPiA+IA0KPiA+ID4gTm90IHN1cmUgaWYgbm9kZSBvciBqdXN0IGR0IHByb3BlcnR5IHdo
aWNoIHBvaW50cyB3aGVyZSB0aGF0DQo+ID4gPiB2YXJpYWJsZXMgYXJlIHN0b3JlZC4NCj4gPiA+
IA0KPiA+ID4gDQo+ID4gDQo+ID4gVGhpcyBkb2Vzbid0IHNvdW5kIHRvbyBkaWZmaWN1bHQgdG8g
ZG8uIFN0aWxsLCBldmVuIGlmIHRoaXMgd2FzDQo+ID4gZG9uZSwNCj4gPiB3aGF0IHdvdWxkIHRo
ZSBwcmlvcml0eSBiZSBmb3IgbG9va2luZyBmb3IgdGhlIGVudmlyb25tZW50PyBGb3INCj4gPiBu
b3csDQo+ID4gdGhlIGNvZGUgaXMgd3JpdHRlbiBpbiBhIHdheSB0byBjaGVjayBmb3IgdGhlIGVu
dmlyb25tZW50IG9ubHkgaW4NCj4gPiB0aGUNCj4gPiBib290bWVkaWEuIE15IHBhdGNoIGFkZGVk
IGEgZnVuY3Rpb25hbGl0eSB0aGF0IGlmIHRoZSBlbnZpcm9ubWVudA0KPiA+IGlzDQo+ID4gbm90
IGluIHRoZSBib290bWVkaWEgdG8gY2hlY2sgc29tZXdoZXJlIGVsc2UuIFRoaXMgc2hvdWxkIGJl
IHRoZQ0KPiA+IG9yZGVyDQo+ID4gYWxzbyBpZiB3ZSBoYWQgdGhpcyB1LWJvb3Qgbm9kZT8gQ2hl
Y2sgZmlyc3QgaW4gdGhlIGJvb3RtZWRpYSBhbmQNCj4gPiB0aGVuDQo+ID4gY2hlY2sgaWYgdGhl
cmUgaXMgYSBkdCBwcm9wZXJ0eT8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBnb2luZyB0
byBiZSB0aGF0IHNpbXBsZS4gRXNwZWNpYWxseSB0byBzdXBwb3J0DQo+IHJlZHVuZGFudCANCj4g
dmFyaWFibGVzIHNhdmVkIHRvIHR3byBkaWZmZXJlbnQgZGV2aWNlcy4NCj4gDQo+IA0KDQpUbyBt
eSB1bmRlcnN0YW5kaW5nLCBJIHRoaW5rIGl0IGlzIGVub3VnaCB0byBoYXZlIGEgZHQgcHJvcGVy
dHkgdGhhdA0Kc2F5cyAiZW1tYyIgb3IgIm5hbmQiIGV0Yy4uIHRoYXQgY2FuIGJlIHJlYWQgd2hl
biB0aGUNCmVudl9nZXRfbG9jYXRpb24oKSBpcyBleGVjdXRlZCBhbmQgdGhlIGNvcnJlY3QgZW52
X2xvY2F0aW9uIGlzDQpzZWxlY3RlZC4gV2hhdCBhbSBJIG1pc3NpbmcgdGhhdCBtYWtlcyB5b3Ug
dGhpbmsgdGhhdCBpdCBpcyBub3Qgc28NCnRyaXZpYWw/DQoNCkkgZG9uJ3QgaGF2ZSB0aGF0IG11
Y2ggZXhwZXJpZW5jZSB3aXRoIHRoZSBVLUJvb3Qgc291cmNlcyB0aGVtc2VsdmVzIHNvDQpteSBx
dWVzdGlvbiBtaWdodCBiZSBzdHVwaWQsIEkga25vdy4NCg0KPiA+ID4gPiA+IEl0IGlzIGEgbG90
IG9mIHdvcmsgdGhhdCdzIHdoeSBJIHRoaW5rIHNlY29uZCBzb2x1dGlvbiBpcw0KPiA+ID4gPiA+
IG1vcmUNCj4gPiA+ID4gPiByZWFzb25hYmxlIGZvciB5b3Ugd2hpY2ggaXMgc2ltcGx5IGNyZWF0
ZSBuZXcgS2NvbmZpZyBzeW1ib2wNCj4gPiA+ID4gPiB0byBkaXNhYmxlIGJvYXJkIGVudl9nZXRf
bG9jYXRpb24oKSBpbXBsZW1lbnRhdGlvbi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGFua3Ms
DQo+ID4gPiA+ID4gTWljaGFsDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBZb3UgbWVh
biB0byBiYXNpY2FsbHkgZGlzYWJsZSB0aGUgYm9hcmQgZW52X2dldF9sb2NhdGlvbigpIHRoYXQN
Cj4gPiA+ID4gZXhpc3RzIGluIGJvYXJkL3hpbGlueC96eW5xbXAvenlucW1wLmMgZm9yIGV4YW1w
bGU/DQo+ID4gPiANCj4gPiA+IHllcy4gU29tZXRoaW5nIGxpa2UgdGhpcy4NCj4gPiA+IA0KPiA+
ID4gY29uZmlnIEJPQVJEX0VOVl9MT0NBVElPTg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgYm9v
bCAiVXNlIGJvYXJkIGRlZmluZWQgRU5WIGxvY2F0aW9uIg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgZGVmYXVsdCB5DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAuLi4NCj4gPiA+IA0KPiA+ID4g
aWYgZGVmaW5lZCAoQk9BUkRfRU5WX1NFVFVQL0xPQ0FUSU9OKQ0KPiA+ID4gZW51bSBlbnZfbG9j
YXRpb24gZW52X2dldF9sb2NhdGlvbihlbnVtIGVudl9vcGVyYXRpb24gb3AsIGludA0KPiA+ID4g
cHJpbykNCj4gPiA+IHsNCj4gPiA+IC4uLg0KPiA+ID4gfQ0KPiA+ID4gZW5kaWYNCj4gPiA+IA0K
PiA+ID4gTQ0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBUaGlzIHdpbGwgYmUgYWNjZXB0ZWQg
YnkgeW91IGluIHVwc3RyZWFtPw0KPiANCj4gSSB0aGluayBpdCBpcyByZWFzb25hYmxlIGNvbXBy
b21pc2UgdG8gcHJldHR5IG11Y2ggZGlzYWJsZSBib290bW9kZQ0KPiBtZWRpYSANCj4gc2VsZWN0
aW9uIGZvciBzdG9yaW5nIHZhcmlhYmxlcy4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQoNCk9r
LCBJIGNhbiBzdWJtaXQgYSB2MyB0aGVuLg0KDQpDaGVlcnMsDQpWYXNpbGlzDQo=
