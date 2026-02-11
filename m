Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC406E9E30C
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D440A83DA7;
	Wed, 11 Feb 2026 14:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="0i1Rd5AF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A346883D9C; Wed, 11 Feb 2026 13:29:20 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4320A83CE3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 13:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRaCepQeqF+iJ9F0areC1Es+hg7sTGjb8qmbVWtI1VBuhT458293Q405NMg6sNuVb6DlF2a+cx/HrtxKTmTB6BvUUGqsilTOrGi4GUZ+SL5eFxtbx/3re4FrzZA8Y/1H/t5Mr5Dvt/RBsJJxnUKfLftXkuZUj9nys/z+nR5XfwlLHApvXCQ0JosC54hGY5MG9CYeznZZMbQ7I2lBAawJNZTR89rPg2cfjjzepQwk56ouqr6r+CKihTmsQ25robxNqYKeuO5XWG4dkokbWnqEbcNOZcHJvpEbZNPMuHflYc9Bv0ztbhCk68LxXBsZwHgxHdzNNcel4ksRdmPwBk4zaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU75jbpwCCKZEhyVpc4shcU7mocUVZdbGScq40mXrHI=;
 b=ducxiURbDik8NUlR0oqMD2nmrIUDW+0yvtdzMpuSIwvK6VldxNd2VrI6WebKckB4joL9rF8NTR7JbvIpPi1FB71YHYs8OcII9yr6Jt1m93sd1+lRQFeKgtP2W/JDcWnZQ8oDU1hvyBoZBrTWWCp6yQk5s5V7eDZbW5+YXGXA2GVMMYZgEbjOSCBkbSnmgG6OCXLI6FSzlCNZB/WTUP3ZPTDfLjKm7n7Q4kmwOkkAaFtvydIAcksrFINWRhXfaaftQeugy/F1TmG2GoBD7gqEcNmtvdYV6B7lhI8p7cIWMi7iXQqAShpNsHDVomS1MZkqxboxZCR5A9rtdOk79znpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU75jbpwCCKZEhyVpc4shcU7mocUVZdbGScq40mXrHI=;
 b=0i1Rd5AFmU7TV9z3zm9cJzCio4Pq6Iz1WDh747O7KfUXePlvZHhtNHOgaXC/Op2J1imezfSUKcjmXpXsuYouNdJO/cKoCV85YBr5Tr/jDoI/mrNng6FZEdT+08r3JFOmVvwdTwHNMidpkBRhlYWBPwruqE4tnLf2NBRmjRNgN0QPat97pL5ie0PSFejXqpS9BMB6R7qj9FlsExAtyXnLQug3/tZANXEmu2fo94c+03VZv1AqOs+EyjaEt3itZA4TCvsBfpMGBwOO/YQ4cHYsNxuV6fcqCtXm+NIL4ovB4rcL5NJKSIXrBwzDufwG4HruF0rDvqrVVcDSt4P8GpWdeg==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 PH7PR11MB7987.namprd11.prod.outlook.com (2603:10b6:510:242::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 12:29:13 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::b76:913:9a3c:a4d1]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::b76:913:9a3c:a4d1%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 12:29:12 +0000
From: <Jamie.Gibbons@microchip.com>
To: <u-boot@lists.denx.de>, <james.hilliard1@gmail.com>
CC: <quentin.schulz@cherry.de>, <trini@konsulko.com>,
 <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
Thread-Topic: [PATCH v3 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
Thread-Index: AQHcmvwm8uFqcH6WKkeAkWBrgTzWLLV9b2gA
Date: Wed, 11 Feb 2026 12:29:12 +0000
Message-ID: <4fa526c355abda8ed5ad0c88f99d215a7615a977.camel@microchip.com>
References: <20260211021351.2678571-1-james.hilliard1@gmail.com>
In-Reply-To: <20260211021351.2678571-1-james.hilliard1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|PH7PR11MB7987:EE_
x-ms-office365-filtering-correlation-id: efb3dfdc-06c8-494a-5259-08de696929e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SVVsZWtjVUtFMDNFN3Y3Q2xvSld5alFuY0VuVUhEVUFScFZmTEZUeURxN1VW?=
 =?utf-8?B?dWxiVzdRWk1uYlpadkpJazRPT2V0TVZjZDRINHBBekcvVW9OOVE1L3h0eUll?=
 =?utf-8?B?dThLTkhienE1NUw5VE02d1NwaVliYnlReFZTL2VXL3l5dE00b3lVZ1U0TWlI?=
 =?utf-8?B?SXJ5Q3FJVEtWbHZIc2lwL0tjTzFHdXdLeVNwb2FyZEFlWEVCb3ZlRWJIUlBx?=
 =?utf-8?B?OGRneFhVT3pzY2huSldGenRpNWJNVHF6cWtVSHVhMmNwa0N0bjJMVHpFRkpY?=
 =?utf-8?B?d0puOXNUOTM0VUtFTFNsTlZSaHk4L0lrVWJ1bmkvVnRjZ3RmRWNLRDFnSVgx?=
 =?utf-8?B?czAzalJ6UXVEd3lZYnNFSVN1TXpFMnFydk1abklLaDVPcytVWDE4K1E4VWox?=
 =?utf-8?B?Y2IyTHlOS3NpcmNNMFljOGxySk5EM1VpZndja2kvUFpOQ3l2T0FsYjFBVGpI?=
 =?utf-8?B?T1QxN2pKSmhTK3Z3U0JHZDdBbGt3cGhHTDNoZDd4dEpRdjhvbW9EemYxT0ZT?=
 =?utf-8?B?dXFkMjFCN3d5MlNPV0pLM0s1bE5VMkUyaHdRNU5JdVdvL0NvOVR3cG1LNWZ1?=
 =?utf-8?B?SUw4ekRoQ29TL0ZXMHVYejFpZDJBQ0drYjdjZVdmbmxxZ1d0YzZBQU5INkcv?=
 =?utf-8?B?ODc3QlQyWmRnR2twamd2RWZiSG9oMThsUGt1VzAwWEg1MHpFUCtad2VyWnQ4?=
 =?utf-8?B?WlZHLytwaXdneVR1MTJMaFZOOXhXSGx1bDc4WGtWMWdxSmN5ZVM0S3ZQdCtS?=
 =?utf-8?B?bXRVODJrcGFUK3ZQeVA2RTMwMG81aDhhM0ZQZ3pGOHdWM0JLT0NRSithSGNs?=
 =?utf-8?B?c1ZHMWhvWlh0NTFRbnpmWlVycFNXRXJIZ21sMzRNRXZzb3FBNXgwamNKQ0sz?=
 =?utf-8?B?UThTeTV4ZnN5K3MveXlGUnFuR1dxODJSOFROUU9KRm9QbE9sRWZsVVMyU3ZT?=
 =?utf-8?B?U28zbTR2TXIyK2RrbTJwS2RNWXg5dzk0NEtiUlI0Rm5taTdlbHBLcE1DZ2Ew?=
 =?utf-8?B?MmpyTVFUc05haW5Gd0RZWnpRSHlEakwwS21hamhwcjZCV0ZuSWFkWWZjYXNT?=
 =?utf-8?B?NTU1UlVjN1ZIVGp1OWxTZVYzclBtZjM2QUxlODh4eFptYzRGdjdWMWxmRHh5?=
 =?utf-8?B?a1BocWc2ZWx1YVdvQWNTbFJ5U2R3M0RBdHVMc0Y5WGpxNEJkelorVGZnWWdQ?=
 =?utf-8?B?aVdRSFFqZmJnVTFWY3BGVmwvSDVXdHlOQVl6SVFIS1dTcmltUWhCY0x1UlFr?=
 =?utf-8?B?K296NHhKd0ZRWXBQNThxSW5NS1VWUVAwRXlvUGZuK1ZqR01YcU9MRjRHa1c1?=
 =?utf-8?B?ekxxR2M2YjBxVXNGTGJwSWtMTllaNzlVRCs4WXhHd2xiNlNtVWtNMjJUS1VR?=
 =?utf-8?B?WjhXd1FwZlMyTXR3bkd2blgvb3RHeGVMSVg2SW9VMDVnZnZpTUZnQ3Bsbitv?=
 =?utf-8?B?Q0oyc21IbGE2RENQTG5neHRpOWVkYUJjSkJva1pGK2podWIrWlk0aEpaMGEr?=
 =?utf-8?B?SThoU1M1ckJxK0NWckEzZUJJZnp2T1pqNFVQZ09Wc1dlcThqQjdISHlydzJx?=
 =?utf-8?B?anNpeDY4bXBUcEZjU0Y0REpkbjJEK0VqN3ozOTYwRVVPdGNYek1GbjZESEdo?=
 =?utf-8?B?Z1ZMdVU0UE9OWVNXSXRVREtpeWloUnNqTGFyM3FYQUc0ZkpqSnFGbVlEQ0NX?=
 =?utf-8?B?ZDBNbjYxaFhibjYxQXA3NTY4dzk4MGdBa3lxd1JlOUhWT1RwYWhlcWphdFRh?=
 =?utf-8?B?WU1vTVpoVk91TXFDNHpTU3I3UjY5cEdrS3dmSGZyMXVxRHVtaUlIVDRUbk5V?=
 =?utf-8?B?U0s5cDNEa1NLT1VmR0JTenpqUks2S3hsMTJ0T0orVy9mVTRwY3FPc2kza1ZZ?=
 =?utf-8?B?Q1V5dXNpYkdiSEpSbnBOT3ZseFhYa2tqYXYxclljdHdPaHdVTHY3clg2Ujc5?=
 =?utf-8?B?OFhnbFVMTFFtSzNTYWg3Yml2cXRlUFcrY2xIbTdhTG92VWpweGZ1aDdHR01V?=
 =?utf-8?B?UjNhRXM5dDFiRUxQTmFaRk5ITnNGY3ZlYnVxWTVSZW9VSHQ3OWkrdjJBNG9K?=
 =?utf-8?B?amIvbVpGTXYzdWtuQkVZZlBZRnpvbkdCc0g2cDZjL0c0Y2ExWEdBWVFDbHFh?=
 =?utf-8?B?WHNzRmIzUTlvdlZIV0xZMUxPbmJ2Yy9ENmFVdEhsWUtYVWFzU2hWZXU3TThT?=
 =?utf-8?Q?cr8Q9q1xFQ7zbMTGdQj5kv4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnVEdEtKdWY5Yk5vVnlMN2hjZDBlTWt2YytidkFydVdLUHY0RmVURmo0LzEx?=
 =?utf-8?B?V2RWcjVNMlJXLzNpcVp1K2hqbUhWUy9VSURibFp0Z1VUWUoxamNqYSs5Tisr?=
 =?utf-8?B?ODhiNkozYktWdEc5T3dsK2IxSDBGZ3lpZWlKMlloUmZiZDI1OEd5c2l4enJm?=
 =?utf-8?B?WEVOeENlWkJNM1M0WitRK0ZCV3NObHdmYkh1aDZ4YnZhUHVZbVZ0VmFZYy9n?=
 =?utf-8?B?TnFQNTZRbU5wNVFWdVo3emZIQ05nNWl5Mkw0UmZvbVJ0YmFDdWhzVjVDYXE5?=
 =?utf-8?B?QVRJOTdxclNOUVRERUxHVmxxcVBwekFpcHZ2VzBnQk1Xd1V2TE9GM1JCSTRI?=
 =?utf-8?B?Y1NVWFlnbVhIaWFHZWUyd3YvV2hpdDlQSVhvUjA0YmI2bGZHOTIyMzZXOS9L?=
 =?utf-8?B?bUFxTU9ZV3NWZFJaeVlNTWNFQ09PUHJpNTliQUxRYjhKTjY0dnZXcmh3cXVV?=
 =?utf-8?B?OERHWkEzM215d2VVL1ZsOTlpd2poL2ZpUUgvY04vQmJEMC90SEo5RFZ0SnRz?=
 =?utf-8?B?bWIwS2hxNEdXdlZjeDZuV0tSNmVySmgyN1NKQVJ1VFFnbUpQN0VVaXVsMit2?=
 =?utf-8?B?UC9pWlRnZldxNVUzVDJwaUVTV2dTUUw5d0JvNHhUckpJamdINHVJUUZCck9y?=
 =?utf-8?B?SXcyUCt5S2djU1ZQcTI3UmRVYnBtclRuekpTNDQ0ZmlDQnVWRCt1SjAzNUdh?=
 =?utf-8?B?ajdncFZBRkZ4NUd6dkszb0xNU0cvNk1rRTkyb3VqWG1ZUXF3UHE5NjZzbkRq?=
 =?utf-8?B?SnZ3Wk1IVXBIS1JGSkpKbnNuSnVyc2k4N3JrTEJPT29tenJDbVdJMXd5N2Jk?=
 =?utf-8?B?RVpmcHNvLzU3SzE3eS9pVFVSNTN0OTBFREp1eVRyQVpjV2ZFd3lwTTZkNjlO?=
 =?utf-8?B?OG02SGxlcDBpbTdNRmVXVllBajBvd3EzVGtnRXdrRjJhN000aTFYS05yMGhB?=
 =?utf-8?B?TndaQ3Jyc1ZrWkRHQVJJL1I3eVdUeG0rZlY4UGNDRjVtY0VlalBRT2R6RlZC?=
 =?utf-8?B?M0hWbkRIZFpST2E1RUQzSTBjd3c3ZVpMNmh5OXpIbjlYempSdHNwKzdCQkhD?=
 =?utf-8?B?dnlab3R0TEU0K3J5MWRnWUFoMm5Ndkw2ZlZHTDN2aWF1a0NlNzhYc0dnQm5N?=
 =?utf-8?B?dlhQWEhES0RMcklZSU4rSEtRMUQwL0tLMmtUZ3AwTGpSRXZwWkJacFdaRCtO?=
 =?utf-8?B?MHZTY2ZPUWE3T3QxT3gvbjBzOStkYVZTeVFiSzVpU1hnbmVHUG5taExTejFt?=
 =?utf-8?B?eURCYkl2a2pyYTg5VG5FVVFuZzlPRjJEbVlNcnRzNnBCQTB2eEFrTFB3TVE1?=
 =?utf-8?B?NGQ3aVkzMmY5YmE0TjBjZk11S0hlRkNKdGJYYUYyV0laMHNzT2hhanNDM0Na?=
 =?utf-8?B?Q2x3VEJiT0R6NFpzaXhhMG9xcjF5cEZBVlNxN1NUVzBhN2RaNEJQaW0vYmt0?=
 =?utf-8?B?Z0d4WGR1bEtNS2lGanBJODRwQjNoVEhvemNlRFF4OFowbHN2WXh4eFJkQzdK?=
 =?utf-8?B?ekMwem1kNVM2UTR6azVXNFpscGwvSDZ0aTNNWFUyYU8zN3VnZWNUVit1dU1l?=
 =?utf-8?B?eU0wbUVCK3YyaTk4VGkwc0FpalpaTGZ4Y2dnOE1nb2tkRFRzK2pVNjhmMkt3?=
 =?utf-8?B?UGJwMmdhNFVkUDNiL24xOFFjSHFMek1kM1NVM09PQk5vU29veVlZNjUzSnhW?=
 =?utf-8?B?em9Tai9jR2gyTjZ0dVdtd09RWjljUzFlb25WcmNSa1htQ0lIK3lJYUIrVC9p?=
 =?utf-8?B?b2xxUnhQRGplVHhqOXdPSUtHYjRCMlFLbEZzaUVIY1ZxQyttUDlFYTVvT2ZD?=
 =?utf-8?B?ZlNhVjFUUG0wUWJOWmtRV1VsakxOaUVCR0dkMm14YnpIcGpFekRiVGhZVU91?=
 =?utf-8?B?bW1iNy9iWWZGcEcwMUhubTJQeEt6RUhoSng3elRKODVBYU9aVEFzbDlKV3ZR?=
 =?utf-8?B?bFJxZkVjbWtHUzU1Q0Ntb0ZnRFFpMDVlSzlESmE0eWYycm9IYTFrM1cwMERK?=
 =?utf-8?B?c1VyUC95a2hLSWowNFhvVjZtZitwcVpuNHRKcC8wRkcyeUg5bFloNVp1Wmh0?=
 =?utf-8?B?OEdEMlpxcDBjVnE1QmE2cjZQdko2aGtHQTY0bEtsQTI1bUJWNE1jcklLY3FW?=
 =?utf-8?B?d1Z2NFRsK3pPOEFod0syaE1jWGg0L0h3RWtYQnRlbE0xUzlIYlkzSEo2R0JU?=
 =?utf-8?B?bC9lbWVMNlkzMnV2OFhnQjBGRHBhSlE5QzVtblhGSlVuSnJSem80UGM2aEVX?=
 =?utf-8?B?ZnJ4YmFHdWkzVE9sc2ZwNHlQUUpNRngybmJFR2UzZ1YvUDRDNmVvcnBjdllL?=
 =?utf-8?B?Q2pZVkNXbXI0c2k3ZmtBU3FFcGs5WnlTNjltcUFXYWdRUGpzVUdYZUZTK3E5?=
 =?utf-8?Q?Ei0vdQkSmwlpv2/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F95D35F6AFD2EB4DB0FFDD80B0D7CAAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb3dfdc-06c8-494a-5259-08de696929e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 12:29:12.8063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfYcZRtE1+2lPmNCTe5fBkWqzAc9mu8L6x3NnLdjC8Z8u0ZI/CvzpI0yI+4CcpJ0hLN6GJTO7EWjoNIhi7cUqSK0ix5Ug8Xqro6WE7PMhiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7987
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:54:02 +0100
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

SGkgSmFtZXMsDQoNCk9uIFR1ZSwgMjAyNi0wMi0xMCBhdCAxOToxMyAtMDcwMCwgSmFtZXMgSGls
bGlhcmQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gbGliZmR0IGV4cGVjdHMgRkRUL0RUTyBibG9icyB0byBiZSA4LWJ5dGUgYWxpZ25lZC4gV2hl
biBsb2FkaW5nIHRoZQ0KPiBiYXNlIEZEVCBvciBvdmVybGF5cyBmcm9tIGEgRklULCB0aGUgbWFw
cGVkIGJ1ZmZlciBtYXkgYmUgdW5hbGlnbmVkLA0KPiB3aGljaCBjYW4gYnJlYWsgZmR0X29wZW5f
aW50bygpIG9uIHN0cmljdC1hbGlnbm1lbnQgYXJjaGl0ZWN0dXJlcy4NCj4gDQo+IGJvb3RfZ2V0
X2ZkdF9maXQoKSByZWxvY2F0ZXMgdGhlIGJhc2UgRkRUIHdpdGggYm9vdF9yZWxvY2F0ZV9mZHQo
KQ0KPiBiZWZvcmUgYXBwbHlpbmcgb3ZlcmxheXMuIFRoYXQgdXNlcyB0aGUgYm9vdG0gbWVtb3J5
IG1hcCBhbmQgY2FuDQo+IG92ZXJsYXAgd2l0aCB0aGUgRklUIGJ1ZmZlciB3aGVuIHRoZSBGSVQg
aXMgbG9hZGVkIGludG8gUkFNLA0KPiBjb3JydXB0aW5nIGRhdGEgbmVlZGVkIHRvIGxvYWQgdGhl
IGtlcm5lbCBhbmQgcmFtZGlzay4NCj4gDQo+IEFsbG9jYXRlIHdyaXRhYmxlLCA4LWJ5dGUgYWxp
Z25lZCBjb3BpZXMgb2YgdGhlIGJhc2UgRkRUIGFuZCBvdmVybGF5cw0KPiB3aXRoIG1lbWFsaWdu
KCkgYW5kIGZkdF9vcGVuX2ludG8oKS4gR3JvdyB0aGUgYmFzZSBidWZmZXIgYXMgbmVlZGVkLA0K
PiBhcHBseSBvdmVybGF5cyB0byBpdCBhbmQgcGFjayB0aGUgZmluYWwgdHJlZS4gRnJlZSBlYWNo
IHRlbXBvcmFyeQ0KPiBvdmVybGF5IGNvcHkgYWZ0ZXIgYXBwbGljYXRpb24gYW5kIGNoZWNrIGZk
dF9wYWNrKCkgZXJyb3JzLg0KPiANCkkgYW0gbG9va2luZyB0byB0ZXN0IHRoaXMgcGF0Y2ggYnV0
IHVuZm9ydHVuYXRlbHkgaXQgZmFpbHMgdG8gYXBwbHkgYXQNCmJvb3QvaW1hZ2UtZml0LmM6MjQ2
NSBmb3IgbWUuIEkgaGF2ZSB0cmllZCBib3RoIG1hc3RlciBhbmQgbmV4dA0KYnJhbmNoZXMuIFdo
YXQgYmFzZSBhcmUgeW91IHdvcmtpbmcgZnJvbT8NCg0KVGhhbmtzLA0KSmFtaWUuDQo+IEZpeGVz
OiA4ZmJjYzBlMGU4MzkgKCJib290OiBBc3N1cmUgRkRUIGlzIGFsd2F5cyA4LWJ5dGUgYWxpZ25l
ZCIpDQo+IEZpeGVzOiA4ODFmMGI3N2RjOGMgKCJpbWFnZTogYXBwbHkgRkRUT3Mgb24gRkRUIGlt
YWdlIG5vZGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBIaWxsaWFyZCA8amFtZXMuaGlsbGlh
cmQxQGdtYWlsLmNvbT4NCj4gQ2M6IEphbWllIEdpYmJvbnMgPEphbWllLkdpYmJvbnNAbWljcm9j
aGlwLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgdjEgLT4gdjI6DQo+IMKgIC0gYWxzbyBmaXggYWxp
Z25tZW50IGlzc3Vlcw0KPiBDaGFuZ2VzIHYyIC0+IHYzOg0KPiDCoCAtIGRvIG5vdCBwcmludCBv
biAtRU5PTUVNIGVycm9ycw0KPiDCoCAtIGxldCBib290X2dldF9mZHRfZml0X2ludG9fYnVmZmVy
KCkgcmV1c2UgYnVmZmVycyBhbmQgaGFuZGxlDQo+IHJvdW5kaW5nDQo+IC0tLQ0KPiDCoGJvb3Qv
aW1hZ2UtZml0LmMgfCAxNjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tDQo+IC0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEyNCBpbnNlcnRpb25zKCspLCAzNyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ib290L2ltYWdlLWZpdC5jIGIvYm9vdC9p
bWFnZS1maXQuYw0KPiBpbmRleCA0MWFiMWY1NTJiMC4uMDlhNTdiYmI2NzAgMTAwNjQ0DQo+IC0t
LSBhL2Jvb3QvaW1hZ2UtZml0LmMNCj4gKysrIGIvYm9vdC9pbWFnZS1maXQuYw0K
