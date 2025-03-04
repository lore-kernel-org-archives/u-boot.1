Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34862C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 05:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E0D808A2;
	Tue,  4 Mar 2025 06:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yNTrkSjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B36580BAA; Tue,  4 Mar 2025 06:15:37 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D588280805
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 06:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMefLL5rOT+Aer5cTsAaOa+3eT4I1WZU2CgQao9ehY97VXfvkJR2CuJ0uAXe4/ex8E+OgrEw+Ov2G58f08bkRONFSG7T428Qsn2yTJDlajMuTaI/GZyJzrS0OTZ1eOEGivAxbZbEvy8jwYjvVOSYF5rqsnNw73Pgl6mmkeVQUkKTRS7HpId902cKFTzruHPCVEGL8j57gtMUMXCMpx9ptA8q8fg8mZ847hOzLf30PnUEgRPewwVJ4bvueM57ysLwrAKue5RLtlshdEXOjQCcN5lh1r3lLoNrIw70BH6ihE9rPeHVaQi4BOva2Zcw6EApijFlGvCdxkOF7BW3OH20sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm8xPT1OrWAORXq4b+V7lbXpCeHU8UesqQVPP3QZJdE=;
 b=pQOrxTvm9GZxtNTibyYtVRsOnXmbho3CLKt+xrnk+x0ZepTft6KNNq4KMGBQtQ9lsxFJqLihJvXsJig/qDYOLsYGVFPzmmHLUEXYQ51t8UJod1m+gKW0yrAF4g2udxk2RdAthEHbdqm/+JA1qX6DFLTLhKa5x+PiZicbcAxTqQJQFEE1/hZd+yhImJDCRRMlg/eE3RimWyly5jv9iS7NvprIxj/+DGoH7+Z0iLhLQG4cx/0QlAkBWUv4gTZver1pH9eZm01u6ZmqLzgfkkveB1HY2DPyD8N8FTg00VQ+b66AoISUXV8mnG728cwpV+Osa0u7Az6zOBeGJFGGtfa3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm8xPT1OrWAORXq4b+V7lbXpCeHU8UesqQVPP3QZJdE=;
 b=yNTrkSjou/1RLT+ZyFglj+eZGmrIDDLOqDX4LWwlfSdK986PKjlSwhrRnnGAtlv5mDMi/lFjtyVLqm7/uz6lnbFBdRy7o56zxBV5Yz/STlJwDStoL09DGLoBB1zFwDmBAW/vWFNNJejgV2ry+LxMcPs2sXyufo0MZX5grQ4Urb8=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 05:15:30 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:15:30 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "bhupesh.linux@gmail.com"
 <bhupesh.linux@gmail.com>, "n-francis@ti.com" <n-francis@ti.com>, "git
 (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH] UFS: Remove the timeout while send command
Thread-Topic: [RFC PATCH] UFS: Remove the timeout while send command
Thread-Index: AQHbiN2BB/7OpTC1uUq4Jz656RJiFrNc2B8AgAWbqLA=
Date: Tue, 4 Mar 2025 05:15:30 +0000
Message-ID: <SA1PR12MB869721ED6126696822D6083898C82@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20250227060428.2070765-1-venkatesh.abbarapu@amd.com>
 <42964c7a-a544-4139-9e5b-9097b9e29159@linaro.org>
In-Reply-To: <42964c7a-a544-4139-9e5b-9097b9e29159@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ca259fd9-04f7-4183-83fb-5ed1362b2fed;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-04T05:03:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SJ0PR12MB8113:EE_
x-ms-office365-filtering-correlation-id: 6a2f0435-5178-4aa4-7242-08dd5adb9523
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?eXRwQkRYVHp4MTUzRmVycEhnZ2xSa2ZOUExrUmd2OHVtYlRmVzBBc3ZZaE5Z?=
 =?utf-8?B?WGx3RmFPeDhxV2xkUlZIWEJSSGkrTVRmaWFIWWtFM3JoVXNKUmRGakhOM2Nj?=
 =?utf-8?B?TE8reHZlSVBmOWhOcUQ0c25FSFNnOHUzdnIvTTI2MnhOZUFnYm9rK3FHS0FG?=
 =?utf-8?B?UFVoRGZycTdXTkJxQlZZeXJ2UU05d0hIUUR5bUl4WEJDRnMrRFRaOXBNNE1a?=
 =?utf-8?B?N1ZodHZOS2lnUFY1UStDTXE2bndGMjgxV21qaEtOallJYXh0SmNOR2I4YmhQ?=
 =?utf-8?B?cDFVKzFJYlJ5R0dXS09nMXdhVnhibjBGU05ZM09OOEI5dU5zbXZUTWIrQVd3?=
 =?utf-8?B?VDl0MTkzcUswYVRETm9OSlEreDhTaC9lNU82SW9HY3JBRk0yd3JaT0hEV1do?=
 =?utf-8?B?ZE1HQUs4ZGZob0ZCV2tSemlKSlNxRzhTYXZiSmMzQklkMWl5QlpVRERjUUFH?=
 =?utf-8?B?aXNSc3JNZFBvTWF2Um9hZi8vSDAySGpMQVMzV2NXeTVmclo5MzVlOWI2TXNl?=
 =?utf-8?B?bGFoYlVHWGNyQlR2WGUvVGVXam5rdXJJdXBkWURodDMzaFFhNzZHQW03Vldj?=
 =?utf-8?B?RGxZT2VGdGFoNzlLYlMwV0crSDdVSVpFVnJXdXc0bDg4WndqWmMvSnJlbCtK?=
 =?utf-8?B?R3VlMFhyQWdXajdGMDE2THg0RXdxRitHUFJJRmgyb2FDbFo5QmNqZ1J3aTRt?=
 =?utf-8?B?b3RlS0NxQjVQeERyUGFYRjFBTjVPSEhRZVQrQ3AzMDk0Tjl0THN6T0VXcFBV?=
 =?utf-8?B?dmFTZWVpRllseVBCN0gwSXdLY1U5UXRtd3FYMGp2NFdYc3gvT2srY1BaSXI3?=
 =?utf-8?B?NGVXODNzL0VMREU0MithdnB1ZlEzbmRzTW1VYWNWZ0pOcXBpcTMxM3U2bkZi?=
 =?utf-8?B?SUxWbThsbStXc1pCS0dSb0NTWEtVVGdTQmVnUmxkcHVXREtoaG0zMkdSdlQv?=
 =?utf-8?B?YktGaDZ4dlZiZ1lXNUxFOEZyNEplbW5DUnRiVVpMT1BzdEt4VDdkVGZLTkls?=
 =?utf-8?B?a3lIU3NoQm9YWnpsamFOWEhNL2pNL2JKRjlpSDhiMnAyYzhkdEl4cVM4ZGVM?=
 =?utf-8?B?U2NtQUlkVHo3R3NmK0NNZVkwOWE4MXVBQzFYNW41bHRJV25uekYrMjBuOE1J?=
 =?utf-8?B?ZkFmZ0Z0eUthYW9XKzVGZk9GZC9hazZ1Z01vY003blhEcGRrZTFhR2VTRnhP?=
 =?utf-8?B?SDlwSUZ2b0NvN3N0cFVxaW5yQkhudm1ZSDJISTFUU2xubDZTTzZHZk5hTHRa?=
 =?utf-8?B?TjgyU1J4WU0wQk5FbU5NNkhxRFRNT2RTLzgzalI1K0xMbDlHa2w0NjVNTFo2?=
 =?utf-8?B?MjEzUC9aNzdkb0d2MFg4R21SSC9UYkdYZ1lJdVVDZ1NpL2RRT0N4cE0wOUlN?=
 =?utf-8?B?ZCtqaitoT2hxUmd6eXVPOGhvdlJyUW9BWG5IU1FBQWF5T1NvZHE4K0o3ckdI?=
 =?utf-8?B?RzZWR2ovWGg0cXlncXZ2N2FvSVROcjVzUldZL1MzZTgvaWJwQmJUL2MweHl5?=
 =?utf-8?B?TTF2RjdYR1N0ait3VDAvVElxU2VlUXdGbG92KzllUHUwQnN3c2NxT2s4dUN3?=
 =?utf-8?B?ZThCK01VVyttVnVLYmxmL0lNY3pyRmtKd3RoMzVGbWlZQmJBWHBvS0lIeXdG?=
 =?utf-8?B?SjBHbUpIbXhCNE9ZblFlblprZXRxd3M1WGxTeUprZmdrNkkzSlJNT1Q5NDZ3?=
 =?utf-8?B?Q2JmdjdrRitMRXRzMENYZllUS2VMUTBZN21SaktkZVZLcklGd0xQeHVSa1Z4?=
 =?utf-8?B?cU8rOGhlZUx2aERiUmg5UE9rb1pRZ01rbkE3bXJxRFIwaEZFM2ZzWFRJd1kr?=
 =?utf-8?B?UCtZeE9BRDlRZE9HeXA1eUliT1RXWlp6Q1VwbHUyWmZJZC8zSzVwdHJ0YWtF?=
 =?utf-8?B?QWVDNEZ5dE96VGx6amVyNkM1alZLV2YyODlIODBMZ21CWVkzMEt5a3ZYUlZr?=
 =?utf-8?Q?ETP+CVsINF1qLDkI7tU2/7kauo+hzHd4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVRndGdZMng3NXBFQ2MvS2lFaDIzdWROMDlUYUR0ZVFOZEZ2UlRYajkwWFNx?=
 =?utf-8?B?bVc2emJTUXA0ZWFadG5QOHZCTVRFdk03Z3UwUlp1dVMzVENUa2c2NVJFNDdr?=
 =?utf-8?B?UXE5OXFQM1NMUEhaSDU2R2NmcTI0UWFya3RueTJxTjZyQjY5SmxiZWFjMkNK?=
 =?utf-8?B?RGNzVW5WU01LYTJHcHJQeEgvWkk5UE05ZE1TTkJ3SW92aFduTU9qS3RnSWM5?=
 =?utf-8?B?ME5mUmFidFRMSHN2b3RwdEMvd1VtNmtrb1NYMU52azNESGhEbE05aUZEaDgr?=
 =?utf-8?B?SDllN1lKMGR5SFBOLzBIa2xkSnR0UUlhMkNqczNTcTB3VC81NGpiU0VhUXdm?=
 =?utf-8?B?OTh4cCt1Z1RCaHFYUGhhM3dOVVpsQjdpa1pkcmxmNjN3UTA2VUxDc3pPRG45?=
 =?utf-8?B?K2VXSkllWnBqRVVFQTZqNXpNVi8vRHhEWjZsVXNXYVVQNWwvQU9nbDRkS2Jv?=
 =?utf-8?B?ek9TSksxWk1ORkk0TnQ3TEt4bHB6c0c4djhlZ0VLMmM4SFJySlp6RnArTXhV?=
 =?utf-8?B?blRIOHpSajdWUUNGUmdod29lWGhUdE5vdGRLWTN4UE5aYkFNK0U3SzJUSGxQ?=
 =?utf-8?B?UGRUMk41MUxUZjF5dGlOd0I1aFdwd0kzZGJFUEdqNVdKRDVOWXM1WTAyYUlw?=
 =?utf-8?B?NkN4Q3FSUlRWZy9IWkxBOCszYWtOTDV0MHVSME5TMnRhYjBaWlIzR0EraitM?=
 =?utf-8?B?UzFZci9oMkNId0swSXc1Y0xvZGZBN1RzTWcrclA1bFVzdEhzL2dNMzhoOGhX?=
 =?utf-8?B?RHFGejhCNWc2bnpvb1NFSkdSSjdKU2NBbUl4NFdOT09LZWRsUjQ3TDh0N1Y5?=
 =?utf-8?B?MkhZdDFTcHVONklhUE90S00wY0dWcFlIYklUVmtCT0VyT3ZqWTd2VHh4YXFL?=
 =?utf-8?B?bW56Tjcvcm9GaWJmMWxlSXhZWXBjQTlPSHQ2aStMQ2RiV3p6elc3Vk9zWkxT?=
 =?utf-8?B?QXN4N2lIY2l6Z3hjMnVGUTUxWm5aMEVzZTRIVDA0OVBlUWV0Rzlwc0MvY1M2?=
 =?utf-8?B?NHVWNkpSSmNybWQ4UitMK3M2dHQ0cE1OdmNqOWFqWDFINzRrMHNDSlNZSXBz?=
 =?utf-8?B?YnB1RlZFUFk3b2Nla1U2dmo0QkNyNVZLeWhMSVRlMEhsdG03YjV0NmhnQnYw?=
 =?utf-8?B?SWp1UDZTQUw3aUV2QUtSQWZmUXhvRjBON08wT2JwSWZRb1FBVVFnZ3QvRndQ?=
 =?utf-8?B?UWFVQlZQVHVjaVdBdlU1Z0Y4NWpYK2FTYkNYa2pFNUltTmg5Sjl6RU9JWlMv?=
 =?utf-8?B?TitJYUhrOUJUOTBBVUVQS2dJL2hkSTZRNXkyVGRyY25YTXl3QzhKamlRZVBR?=
 =?utf-8?B?aXVLaGN0SUMvdHBsYS96aXZCQ0NoZmtnS1k2azlZdHlBOC9YNXFZYjJxZ3dx?=
 =?utf-8?B?c3lzTnFxakxnRXh6cDZxc0VWK1BvdDZ1a0twTmtVZXNNZ0xxR3g3QmFhcG9D?=
 =?utf-8?B?OHh0TnIyN0hHMHBwdkVQcUhka1ZRS2hnZW5IVEtnbGdsdk94OFFHYTRUOU94?=
 =?utf-8?B?ZHNQN3d6a2ZJaGg5MUoyMWFCa0xCejJRT2J5VlNpSlJHVWJySzFZbFNmRWpx?=
 =?utf-8?B?b0xnN0JBVUxVUEFsR3BVNDJMcHU5czJWb3dqQ3NlRzFhRlZKQldUV2g5ZGJw?=
 =?utf-8?B?ZTgrdERUK29Uci82blBJVVFnYVpvL2phSmxPaCtoallqMXdKRFp0b1Q5a0FF?=
 =?utf-8?B?akViK3NVMlFqdzI0VU9IbmFzS1VuWlFzN1hPVzdqMXFIZ1NCaXI4U0FUSWdT?=
 =?utf-8?B?OUU1RXVMZWxuRXc2elRRbDRqSVkybjlTWitBSzJ6QXg4bjB3QlFzUXgrUVQ1?=
 =?utf-8?B?N1R6KzFGeERycGJLaGZ0M3ZmTGhCdUh0ZlM2Uys5NDh6dS94bGtBZVB6aDhW?=
 =?utf-8?B?MzEzQld3ZFVRQTVaVktqdDJ0cDErclNEclQ4cUVEYWg5aXRId2pZK0dzQThu?=
 =?utf-8?B?djBneVJ0NWFKQUExZytxWWhBbnh4QlZ6R3NVSTBFdzg0ZnE2aTg2bkZyZWVh?=
 =?utf-8?B?TCtwaU9uMzBLM0pDVGJ3UkQ3dkx2NkpQelBVTUVVckp5WmFUQTdJQjFxalcv?=
 =?utf-8?B?dEZGN29DQTJybUZOSEwrQ3hPREN6UGgrNVd3TThTejI4QTYyVnYreGhYN2dN?=
 =?utf-8?Q?TUmM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2f0435-5178-4aa4-7242-08dd5adb9523
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 05:15:30.2409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RttvGD+BZ//kYA01nDVtRUYHWv+lYMcG4DbwKyt5JNq+7MBC5s3njtoYwTJYuvoRzP5JlBqo9PTGMchxIPbm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTmVpbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBuZWls
LmFybXN0cm9uZ0BsaW5hcm8ub3JnIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPg0KPiBTZW50
OiBGcmlkYXksIEZlYnJ1YXJ5IDI4LCAyMDI1IDg6NTUgUE0NCj4gVG86IEFiYmFyYXB1LCBWZW5r
YXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUN
Cj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgYmh1cGVzaC5saW51
eEBnbWFpbC5jb207IG4tDQo+IGZyYW5jaXNAdGkuY29tOyBnaXQgKEFNRC1YaWxpbngpIDxnaXRA
YW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0hdIFVGUzogUmVtb3ZlIHRoZSB0aW1l
b3V0IHdoaWxlIHNlbmQgY29tbWFuZA0KPg0KPiBIaSwNCj4NCj4gT24gMjcvMDIvMjAyNSAwNzow
NCwgVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IHdyb3RlOg0KPiA+IEJhc2VkIG9uIHRoZSBVRlMg
c3BlZWQgbW9kZShIUyBvciBQV00pIHRoZSB0aW1lb3V0IG1pZ2h0IHZhcnkgYW5kIGNhbg0KPiA+
IHJlc3VsdCB0aW1lb3V0cy4NCj4NCj4gQ2FuJ3QgeW91IGJ1bXAgdGhlIFFVRVJZX1JFUV9USU1F
T1VUIHRvIHRoZSBQV00gdGltZW91dCBkZWxheSA/DQoNCklzIHRoZXJlIGFueSB3YXkgd2UgY2Fu
IGdldCB0aGUgUFdNIHRpbWVvdXQgZGVsYXk/DQpJIHRoaW5rIGl0IGFsc28gZGVwZW5kcyBvbiB0
aGUgZGF0YSBzaXplIHdlIGFyZSBnb2luZyB0byB0cmFuc2ZlciByaWdodD8NCkFueSBnZW5lcmlj
IHdheSB0byBmaW5kIHRoZSB0aW1lb3V0cyBmb3IgUFdNIG9yIEhTIG1vZGVzLg0KDQpUaGFua3MN
ClZlbmthdGVzaA0KPg0KPiBOZWlsDQo+DQo+ID4NCj4gPiB1ZnMtdmVyc2FsMi1wbHRmbSB1ZnNA
ZjEwYjAwMDA6IFRpbWVkb3V0IHdhaXRpbmcgZm9yIFVUUCByZXNwb25zZQ0KPiA+IHVmcy12ZXJz
YWwyLXBsdGZtIHVmc0BmMTBiMDAwMDogT0NTIGVycm9yIGZyb20gY29udHJvbGxlciA9IGYNCj4g
Pg0KPiA+IEl0J3MgYSB0ZW1wb3Jhcnkgd29ya2Fyb3VuZCB0byBzb2x2ZSB0aGUgdGltZW91dCBp
c3N1ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSA8
dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3Vmcy91
ZnMuYyB8IDkgLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy91ZnMuYyBiL2RyaXZlcnMvdWZzL3Vm
cy5jIGluZGV4DQo+ID4gZjdkOGM0MGM0NDguLmMzYWNiZDcwOWU3IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvdWZzL3Vmcy5jDQo+ID4gKysrIGIvZHJpdmVycy91ZnMvdWZzLmMNCj4gPiBAQCAt
ODU4LDcgKzg1OCw2IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2NvbXBfZGV2bWFuX3VwaXUoc3RydWN0
IHVmc19oYmENCj4gPiAqaGJhLA0KPiA+DQo+ID4gICBzdGF0aWMgaW50IHVmc2hjZF9zZW5kX2Nv
bW1hbmQoc3RydWN0IHVmc19oYmEgKmhiYSwgdW5zaWduZWQgaW50IHRhc2tfdGFnKQ0KPiA+ICAg
ew0KPiA+IC0gICB1bnNpZ25lZCBsb25nIHN0YXJ0Ow0KPiA+ICAgICB1MzIgaW50cl9zdGF0dXM7
DQo+ID4gICAgIHUzMiBlbmFibGVkX2ludHJfc3RhdHVzOw0KPiA+DQo+ID4gQEAgLTg2NywxOSAr
ODY2LDExIEBAIHN0YXRpYyBpbnQgdWZzaGNkX3NlbmRfY29tbWFuZChzdHJ1Y3QgdWZzX2hiYSAq
aGJhLA0KPiB1bnNpZ25lZCBpbnQgdGFza190YWcpDQo+ID4gICAgIC8qIE1ha2Ugc3VyZSBkb29y
YmVsbCByZWcgaXMgdXBkYXRlZCBiZWZvcmUgcmVhZGluZyBpbnRlcnJ1cHQgc3RhdHVzICovDQo+
ID4gICAgIHdtYigpOw0KPiA+DQo+ID4gLSAgIHN0YXJ0ID0gZ2V0X3RpbWVyKDApOw0KPiA+ICAg
ICBkbyB7DQo+ID4gICAgICAgICAgICAgaW50cl9zdGF0dXMgPSB1ZnNoY2RfcmVhZGwoaGJhLCBS
RUdfSU5URVJSVVBUX1NUQVRVUyk7DQo+ID4gICAgICAgICAgICAgZW5hYmxlZF9pbnRyX3N0YXR1
cyA9IGludHJfc3RhdHVzICYgaGJhLT5pbnRyX21hc2s7DQo+ID4gICAgICAgICAgICAgdWZzaGNk
X3dyaXRlbChoYmEsIGludHJfc3RhdHVzLCBSRUdfSU5URVJSVVBUX1NUQVRVUyk7DQo+ID4NCj4g
PiAtICAgICAgICAgICBpZiAoZ2V0X3RpbWVyKHN0YXJ0KSA+IFFVRVJZX1JFUV9USU1FT1VUKSB7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGhiYS0+ZGV2LA0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAiVGltZWRvdXQgd2FpdGluZyBmb3IgVVRQIHJlc3BvbnNlXG4i
KTsNCj4gPiAtDQo+ID4gLSAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVUSU1FRE9VVDsNCj4g
PiAtICAgICAgICAgICB9DQo+ID4gLQ0KPiA+ICAgICAgICAgICAgIGlmIChlbmFibGVkX2ludHJf
c3RhdHVzICYgVUZTSENEX0VSUk9SX01BU0spIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgIGRl
dl9lcnIoaGJhLT5kZXYsICJFcnJvciBpbiBzdGF0dXM6JTA4eFxuIiwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZW5hYmxlZF9pbnRyX3N0YXR1cyk7DQoNCg==
