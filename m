Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF95D25959
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 08:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1F883FC5;
	Tue, 27 Jan 2026 09:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BqCFvmO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C14D83FC6; Tue, 27 Jan 2026 09:06:48 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E511E83F53
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkR4UUZVmcu+zGakXolF7qqpXIMFD+PKGJX8+DIpSXOnakAsx+xS+MJOrwh9CENkD2aDcRzQYM8wQL37Eg+6+FDM4D7ZBN8oz6Qk/VT4KU2Auhcy4qdw5ObYzTk+nE7L7jjeiKkJzpkvzrmV1PdWnL9DIqEZP2FmU2btHGd5gaMlxz6X2LWh1pcgJSkGtAJksCeW+hppkR03BPVaN2nSTLHZTmV1tOpSRNyywuKVC3iprEi6ibI9/NqzKkGG5t27nPZZ/iUtrKKetpkXfCS+mFDQSJaU5TnRYUd7VNd3K43UVZAVpxzWMWKoSc/b9CkAu3RldH8S+3/4sJaOp9NNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGTq0ykF7MEc7UVU6aZklNiTOO8uuHk5k1icYvEBGus=;
 b=vwpIcnBkwbHdPVJ5UuUvMbM4mz45rkggUtzl5z2U3rS1Mlt1ML1V0UgJ96qNQv1InnvKfv5VeojMy4YYtYCs8fpWjQAVOHyfNoQI2i/u2aOO5vB71P133k+DnwbKNzovv0An8WTeNXUgQIUIJZFaNl7fpfmzDYVhPaEBb3FNh0laD9xnyStRBq2boxBd7PLIzBI8ABs0/DE5g+hKZCK1iuN7CllYTBZyTwpjchoXnu3fbWLd5AkR0EjY8PV+Q3kSY20WnceuQVgdgvuvlv+br46KLNeqImhO3JZN1+vTQQnS895E/isz07DOyEGUEE5B7WE+W4o9EuSGoiiK4X1VLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGTq0ykF7MEc7UVU6aZklNiTOO8uuHk5k1icYvEBGus=;
 b=BqCFvmO4o4M6fZ+BLrjLwOutoRxwUG+wadYT+h+Xz+IDshozfsiMWcQihrDv1JyzMiLXjFY1adg+EsfY5gAXFxeeRfNyfukNl8zRVKIZeKkwRtVDVH1xnUora2qo3DG49RbnHz1mIE3OBUhIBH4qShEkDaFl9o+Tf1jJH7QwpVFYQua87dVggSH0kB5UQwaC9IOSYfzcv9+vhMc6X8BrqNkBVQw2xmg9tbDXnhOBVzJ9mdVqPVW99plMnxG12RLoUhkUhmxfwxlhyFAuL5Ce8J0XYPek3L7te0BXLH/xqhHZYFNXjYTlx1yZIA8olfmkL+irUlip8sJ22L4m1yrN1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 08:06:43 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 08:06:43 +0000
Message-ID: <c07b6877-345e-4449-a110-6a82d42261fd@altera.com>
Date: Tue, 27 Jan 2026 16:06:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] arch: arm: socfpga: Assign unit address to memory
 node
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-6-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251216084623.19589-6-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN2PR03MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: b9115526-bb8f-41de-8129-08de5d7b01d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2h2NjNoVXlJYTlBeUkwZnJIOHl1V0grc2JLeVROWWg3Q0lYV0crRnFzOGlx?=
 =?utf-8?B?UmUrdjBoOUZRQVRDTlBHdlVvQUk0ekM3Mzl0QWFXRFdnbDAzbWQ1KzdmSmMv?=
 =?utf-8?B?RFVQcGRpcDFLS0FWVUdkbDJQbVJMNUorbW9ETW5UMGR6ZEZlMGIvNHIzWVFa?=
 =?utf-8?B?MndTMTJnbTlwUU1kYXV0NVJETStkVjRmSTJpaDNYL25XOC9IMXkvbkFUMUky?=
 =?utf-8?B?bTBJSDdNODdGQTNEeWttejZvdktnUWI5UmRiQVp3OUczRXdIYUV2VXpiaGdj?=
 =?utf-8?B?b2xrR21XVTdIZGRkdzYvNDFFS2lOT1dJcFVaL3REc3p2N0p5NzVISDBzSWxn?=
 =?utf-8?B?RVJYcEo1cyt5ZnFZcXg5VVVLc09ORmYyS2c0QkZDd0pTSUpUNWlnbDlrNGRO?=
 =?utf-8?B?NHF6d0lZTHd3a203eEZmbGQzKzB6QjBPekQ0SEswZHNpMW1jWVpNMmNOV2xX?=
 =?utf-8?B?d0I3TE5nRHgvVHFyV2owbnE2dXY3UHhOOUJPSmtEbW5FSUorLzVjWE54Q0xz?=
 =?utf-8?B?TGpzMm9DdXQ0VFA4MW9XTVpkK3M2Y3ZSUmxES2lKaS9OZ1B3eThKMldWOVpz?=
 =?utf-8?B?bXZnSzNYR3VWRzNuZmVraEZrRFM4VTJ4ZW1EbVlYNTF0R3F3NVQwZ0ZLWFdY?=
 =?utf-8?B?d1lGMGxBeCtJZlNrVEdWMENzdTBhZVlyUGt3ZkhhNjlVTmp2ejc2QjNQSURs?=
 =?utf-8?B?cHhNNGlwOWtYNDFpN3I2THJjUjNUdEtDMStxTUFoUkxXRFZGR24zQXhZOTcy?=
 =?utf-8?B?QWpvWmR5RWc1SHJ4YjRLVFNlTG9ZRUlVb0Fsd2E5bnJudGhvcGZ5MjZIL3FF?=
 =?utf-8?B?TEdFREZsRWN2aVVBdjRqSy9GNWJaNE1KeWNPa09LRktoV2Z0ZGZTeXVPVnlh?=
 =?utf-8?B?VndXYk1Ha1hjbkxoMFNhdDF5Zmg1YmdWM0srUkJlT2pGdFMzU0ZhOWdlck9h?=
 =?utf-8?B?S0dvK0F5cDFTbk8vR0JxTkNrRHhRUTlJemUrMkdqZU5hV1M3MmtZQ0QvWTF6?=
 =?utf-8?B?dDBKK2FoZmJVWURlYTI2WDRjY09sU3NMRHRVaHIyb01FS0VkSmVienQveldk?=
 =?utf-8?B?ZWZaVXloVURtU0Q1RmJhd0VPOGJpQmYvMG1SLy9kZ1M2SjgraUY3QXQzMUpw?=
 =?utf-8?B?cGsyYWM2QVZDY2hSQVZFelB3VjdRWnJxSlRWZVdOQjBremxab2FnbWFJNmIw?=
 =?utf-8?B?aHZBcGJrbnRVdXRyWk44UGtJVHNzYjVDbTd1K2FjcitMelVFUHNPa3RSa1F1?=
 =?utf-8?B?disvdXJ5ajFDdTM3S0JMV0w0Z3o0NXQrNTdqWHZ6M3RQTnk4MFhkV1VtOTNr?=
 =?utf-8?B?Y0Q5SmpFVzJiN0hrN2ZrVVVmL0NUZ3Z1dnVNejltRXdCR2k2K3hQYnJ6dG5S?=
 =?utf-8?B?Vms4M1hFOGVJOHdsd2UwRkJaOTI0RFJVQ0VTWmJhT0VOTURpaE1vRzRkYnc0?=
 =?utf-8?B?eHd0WnZhTG5zcUp1UElneFJ5NXhLUkRsYWpTM2JTSGlkQm0zTWdIeXJTczNx?=
 =?utf-8?B?U1NzcXIwWEt6T210cXFBM29DUmNkKzJ3NUVkczNzeFZITVhQWjBRRVhKWUI1?=
 =?utf-8?B?dTRHWENLTSttcG9LdUpVbEd1RGJvTGFqM0xPMVNwejVoQnA2ZzNIalJvZXQ5?=
 =?utf-8?B?cmU4TGJSdGg5QThLcHNoVHo1WG0yK2hqUzJwSVdxWHV0MnZzOHdlQWhKcFZJ?=
 =?utf-8?B?MDkwOXlTMHo2Nkh6Z21xOXU0UkgvVnZMWEM5L3gwbTdTblVzT3IrTHlkcXRO?=
 =?utf-8?B?eU1ZNi81SjlEcXBJWll2aklKalRQb0U5bUM0Slc3TkNXSTRHQUZ6cVVLcFpZ?=
 =?utf-8?B?SWNFQkVqdEl2T1lWVHQ4clE3QURTZkNuK0hqUzY3R0lWcC9SY2gwWUNZQXg2?=
 =?utf-8?B?bHlYWHFmVmsrOEpNQzVJTGl1cXNTVExWZkdJMW8wWXZJT0VxTWE5d3Jickcy?=
 =?utf-8?B?VStCK1E4MndxeVJpS1BKaU90dFUwNkJyTlJxS2NrSUVWMC9ZTkZIeUJwNWRG?=
 =?utf-8?B?RWFkSGpaV3ZtZVU5S3ZPZXJiUjFEdEVQcCtVM2J1Q3krZE9KUFc4VURCMHg4?=
 =?utf-8?B?cDB6R0NWbFZseVh3eWpzemlnUlJFci9UeEE0YlorQUkvUTMxVEEwbDlPV2Rz?=
 =?utf-8?Q?N8+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHVYQ0NuRm8zOWtCV05QbndGUGN5Z09MNGJ0Nmk0aUF5dGR1Y2RKQTBQMlpi?=
 =?utf-8?B?NTZnVWtZa0N3d21LRXFVOHNseUpua25iMXgySXo4NXFWbFpUbkdsbU5USW1j?=
 =?utf-8?B?VW1VaTlSeFFsanhyc3BoZ3cvNDBoWlJJSytBQWg1NXRHZ2hqWkMrKyt3QzJJ?=
 =?utf-8?B?NUF6NUFZckpnb01UVzZMTERxUWRXdlZZbVd3OVBoeXR2eHdmaVdIc1ZjWjNj?=
 =?utf-8?B?SVhMOVdDKzBXN0dxbE9RU1JpVzIzRUx6cXZHakpSQ3F5OGRocXBEa0ZDT3NS?=
 =?utf-8?B?OVIzV1dVTnNXeVZOUzNkMWNiM2UydmR1a3hLRGZseW5FZEJrRkcxelR2c0do?=
 =?utf-8?B?R1FkOFJaWXA2VGF6M1I0aUFYc1NKdEN3c2IvdHV5Y3N0ZkRQbmtYVGVuWXhl?=
 =?utf-8?B?d2xiNStjOG4vK1BYSmEyL29YZE1zRGFBUnd2am9mbDZrdVpPeU9zelkxTXdX?=
 =?utf-8?B?UWNHVTVQc1F5R3FlQ21jajVGZnlRcnNuTFcvSnpmdkpjYVlqSFdQOXB0aVQr?=
 =?utf-8?B?SzhoRW1ZZGY4QXNBU05HR2E1YjRqQ1JMT0JwYytxY3J4dFNsVmJjNmRJcllG?=
 =?utf-8?B?T3dMZTJxdzQ5N1pIUHhnRTFIV2Ixc1VFS2FSY00va1lHbGZIMVNKeHhyNjR0?=
 =?utf-8?B?bjRsakE3RHJGODRaSXl3U2IvMFh0UUNxS0J3VVJmWmZoTTlJSGpxQnUrdHpK?=
 =?utf-8?B?N2RuK2xqVE1heTNaU3ZlZFZNVlNLVzVDSTQ2VDN2Zzg4R0xudy9nZE1UMWJS?=
 =?utf-8?B?T1U2ZTVwRkJ6Yy9VYkh2OGl5RmhKaUVJam1XQjFPc2p1Q054cytYbFoxVVBh?=
 =?utf-8?B?MGtZbjk1QU1YcmY1Zk1RWHNYWEFxeG44eGRJVWgxZ0JhQXFwRXNwOWQxeHo2?=
 =?utf-8?B?THF6Y0JuY2NIYjNNU01uL1dXL1FPdU9ZUWdKUjYxb0xBajFwWFliVXJnN2hS?=
 =?utf-8?B?K012anhINHNoV3FkekhvSzJLcnVCSm11cHNXVFJJeURMcTFxb3JIQUxtSEpl?=
 =?utf-8?B?c3A2a3VtRE0wWnM4UUc0Z0dSRGJJbnZqSVBrWWJ3ZGU1QzVUMmpTanA0cUFv?=
 =?utf-8?B?K2IyUUhTb3V5RUg1RXVsazRjYXkyTUtRNXhraWltVXhIdUY3WGV0Z0ljY1A3?=
 =?utf-8?B?V3gxdEhZaktRc1E2a1dIeUJlM05KM3NHbGVHK1dMQ3B3MVA3MHUvMW1yck1W?=
 =?utf-8?B?UG83cmJCZW80VVRwTVhuSStQM0EvS3BwV0tXL2czOWk0Nk1ReFk4KzNQajU3?=
 =?utf-8?B?c2xWS2ZyUmtEZHZOdzhhRy9CYWVUWUhhNDUvTFAxVnpDN2xINU8wV1hCNVp6?=
 =?utf-8?B?dWZiM3Y2Yk8yeG5yY0JjSklpKzVaWGV0cStwWmx1ZUQybXA3K09jQmZBMkJj?=
 =?utf-8?B?Rm5VQmpBUEZhVExLSWlEMHVxMGh6b1AzNzBUaVU4UVl2S0l5a1lyMVBLQVlG?=
 =?utf-8?B?REgxSXVwdWQ3QlhrS2lmRzRvcXRxdmE5emdHV2kzY2ZiajM4STc4c2ptdXRo?=
 =?utf-8?B?ZXFFU1hrL253WDlvaGR1d3d5dzkrUU9SMklTNXB2TmFtK3NodXJJcm5zWEp1?=
 =?utf-8?B?cGFmMmxzNXJET2E1akZGWU8ycjViWkxjWnBhVWY5ZDhYUFo5cGlmMXhmWTBl?=
 =?utf-8?B?QmdnZEM4b1RwQWh5bGhEeGpoOE9Tb2hMK0RmV2FvTmFGeHU4SHNaRGlnMFBx?=
 =?utf-8?B?NGJhNC90ZDcrd29ZVEpYcEpObndUc1MvMDhia3EweDZCN2xmTkFWTmtYTEI2?=
 =?utf-8?B?cGJCMXUzWUh4U0RuRXRXQTkrV3BPamljT3ZzdmpRVCtKZkR5ZlNvNmtyREV5?=
 =?utf-8?B?QzA3cWV5YmxrRUZTUmdSSTNyclFCaStRbDhDVzRMK3d6QmdHNzZ6SHF0cVBV?=
 =?utf-8?B?Z2F5OVduRzNTeFU2elBZdG5IWnI2WmY2Q2tpcGRxQUQ1WlRBVUVVVXdWd1R3?=
 =?utf-8?B?VXdFdlUrNVVWSHUyU2FEckdKWWpQQ3FtbnU0dTcyQlQreFdxaFMzbGpJZVk4?=
 =?utf-8?B?TjlxdDFZS3lhN0ZRUmpuWkZ0VXdFNkR3Y2JLQUhyQjFBSk9ZOVNFRm5xaFNU?=
 =?utf-8?B?ek9sTWhSWVhwTnhudkw0VEtqNldOUGRQdmdrNUk3TDJrTDlmZ1FQM1hrWVp6?=
 =?utf-8?B?TU1kdnVqckVPLzJ6b0pidkpMaEpsenJJaWtkWmhiVHNxWitkdmRKaWlJc1lv?=
 =?utf-8?B?ZVVvNWx1dGdLajVuc1gvT3hwb0pLRzF2Nm1CSmNZR0w3L1JDT3pBUy9QU3Zw?=
 =?utf-8?B?S3dMSEIxVDZCMjJIbVV2dE41eHFSalVmRFFQdzRXZGl3N2lHOGpqWHJ0NGtu?=
 =?utf-8?B?cCtJZk1yWVIrSExjNE5LcUZack1mbmpzeUtOVkIwcXRtNXMweENEZGFvWlBD?=
 =?utf-8?Q?QVNqJmSiMDwGhqSQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9115526-bb8f-41de-8129-08de5d7b01d7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:06:43.1198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SOQkuonNpcZQtuVORc1hpKixHrRheuIuXETG6OmTUpYMtiY1mXpJcV2EQqgppeGCQc06d+xJH2L1SYiftZD0F3ONi4mg5FEswgUCSjnHqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5168
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


On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Assign unit address of 0 to memory node following latest Linux convention.
>
> Without this unit address, SPL will not be able to retrieve proper memory
> node values set from the device tree.
>
> Update all dts files which includes the common .dtsi to add unit address
> as well.
>
> Fixes: e291277689f6 ("sync socfpga common u-boot dts")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   arch/arm/dts/socfpga-common-u-boot.dtsi         | 2 +-
>   arch/arm/dts/socfpga_arria5_secu1.dts           | 2 +-
>   arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts      | 2 +-
>   arch/arm/dts/socfpga_cyclone5_de10_nano.dts     | 2 +-
>   arch/arm/dts/socfpga_cyclone5_de10_standard.dts | 2 +-
>   arch/arm/dts/socfpga_cyclone5_de1_soc.dts       | 2 +-
>   arch/arm/dts/socfpga_cyclone5_is1.dts           | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga-common-u-boot.dtsi b/arch/arm/dts/socfpga-common-u-boot.dtsi
> index 695242bec21..ddef9a2896d 100644
> --- a/arch/arm/dts/socfpga-common-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga-common-u-boot.dtsi
> @@ -5,7 +5,7 @@
>    * Copyright (c) 2019 Simon Goldschmidt
>    */
>   /{
> -	memory {
> +	memory@0 {
>   		bootph-all;
>   	};
>   
> diff --git a/arch/arm/dts/socfpga_arria5_secu1.dts b/arch/arm/dts/socfpga_arria5_secu1.dts
> index 8e9c3bbdf9d..dfc04cc2d7a 100644
> --- a/arch/arm/dts/socfpga_arria5_secu1.dts
> +++ b/arch/arm/dts/socfpga_arria5_secu1.dts
> @@ -16,7 +16,7 @@
>   		bootargs = "console=ttyS0,115200";
>   	};
>   
> -	memory {
> +	memory@0 {
>   		name = "memory";
>   		device_type = "memory";
>   		reg = <0x0 0x20000000>; /* 512MB */
> diff --git a/arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts b/arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts
> index ca030c8c41b..094db1cb7d4 100644
> --- a/arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts
> +++ b/arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts
> @@ -20,7 +20,7 @@
>   		udc0 = &usb1;
>   	};
>   
> -	memory {
> +	memory@0 {
>   		name = "memory";
>   		device_type = "memory";
>   		reg = <0x0 0x40000000>; /* 1GB */
> diff --git a/arch/arm/dts/socfpga_cyclone5_de10_nano.dts b/arch/arm/dts/socfpga_cyclone5_de10_nano.dts
> index 34886ec1ad8..346b2ef9e2d 100644
> --- a/arch/arm/dts/socfpga_cyclone5_de10_nano.dts
> +++ b/arch/arm/dts/socfpga_cyclone5_de10_nano.dts
> @@ -22,7 +22,7 @@
>   		udc0 = &usb1;
>   	};
>   
> -	memory {
> +	memory@0 {
>   		name = "memory";
>   		device_type = "memory";
>   		reg = <0x0 0x40000000>; /* 1GB */
> diff --git a/arch/arm/dts/socfpga_cyclone5_de10_standard.dts b/arch/arm/dts/socfpga_cyclone5_de10_standard.dts
> index b38f0723823..37203b63410 100644
> --- a/arch/arm/dts/socfpga_cyclone5_de10_standard.dts
> +++ b/arch/arm/dts/socfpga_cyclone5_de10_standard.dts
> @@ -22,7 +22,7 @@
>   		udc0 = &usb1;
>   	};
>   
> -	memory {
> +	memory@0 {
>   		name = "memory";
>   		device_type = "memory";
>   		reg = <0x0 0x40000000>; /* 1GB */
> diff --git a/arch/arm/dts/socfpga_cyclone5_de1_soc.dts b/arch/arm/dts/socfpga_cyclone5_de1_soc.dts
> index e9de72429f2..264ca3dd53f 100644
> --- a/arch/arm/dts/socfpga_cyclone5_de1_soc.dts
> +++ b/arch/arm/dts/socfpga_cyclone5_de1_soc.dts
> @@ -20,7 +20,7 @@
>   		udc0 = &usb1;
>   	};
>   
> -	memory {
> +	memory@0 {
>   		name = "memory";
>   		device_type = "memory";
>   		reg = <0x0 0x40000000>; /* 1GB */
> diff --git a/arch/arm/dts/socfpga_cyclone5_is1.dts b/arch/arm/dts/socfpga_cyclone5_is1.dts
> index 58a5faf6ea2..b26248b023e 100644
> --- a/arch/arm/dts/socfpga_cyclone5_is1.dts
> +++ b/arch/arm/dts/socfpga_cyclone5_is1.dts
> @@ -15,7 +15,7 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> -	memory {
> +	memory@0 {
>   		name = "memory";
>   		device_type = "memory";
>   		reg = <0x0 0x10000000>;


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

