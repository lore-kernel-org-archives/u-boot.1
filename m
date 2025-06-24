Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8D5C71157
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 06:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1308A82B20;
	Tue, 24 Jun 2025 08:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GAhq4mwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41F682BCD; Tue, 24 Jun 2025 08:04:04 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5654781F66
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 08:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kV3/HtC5RlP8Im5zGphMQs6YHk6RJWVbRlFdJb4+59gkFrmcKVdjVx+3W3DyJPxXTVJyuNqWL1OO/wqbcI3pMBZuGAXfzQ288+qfGYFcsgy3kNyeflStibj3Ulx6rCgBeXPhfFbh4K07yqqXPXyLMoxMMc5HTt2KPtGi/hN8zKI4lMGgFQrxAVMUuJxhGVOMetdAk0cpwkz3EDpgOv5V6GfK3d+4/JoFuOEAHj2GxfUviccxKXOWCjLgZ1605rN1kwGLSvljCEdrfnmon3y8Luo8kt43tYLkAQYVYJmZjpX8Ng66cNPzdqAks7uqPOJdgc76WK1rv37wqPLpKz44HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oToaVd2Q/8z7lwd2TEdNZLSbc+mA3b3FNsCWqVFx8Fw=;
 b=OS5PbVMRPXIglb6ZRzwUjb9Fo1p9l4YyqaC781vUzydVVvzC35yH4y7u8THYKDpD8OVzC9WUPHzPQta8XnzFxcGwzxv/BOP4AnqfbjFBF4U77yC3Yw60VXTaEmLc1d2765mXE7491S6qN1g5325vh5PiqeGMYSGlpKcuFfW2pxKk00pUstszLwCxW/KV1VMFs+8ZQet9lMInxDRB9nCd0Yc4YDmUj+j3YLddptAJobvm/Fa+zl2kM/UAnyn+6v9wgdiYNH5uzyLZGdSYj5Qe0jBClFoMg5uPP8SnzNF3yZ9sgtna3I0hPFllX996SUt6SMbOKv8xttfvxrrnx8a4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oToaVd2Q/8z7lwd2TEdNZLSbc+mA3b3FNsCWqVFx8Fw=;
 b=GAhq4mwaUy8QJc5VyKtmCS5fa3aT1c5Mv5eaGFX15bQVsilRePcbd24xfkf0s3pIp4SxMQA1BNR3n9sQqFRK9Ai3r37Q7wdBqYBJK6eheel8sSk03FcgAu8JYR+9WFC5dqecSlKnlYyWyqySUgn5d4/Kurpnr3cTtwt8J0RKluk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 06:03:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8857.021; Tue, 24 Jun 2025
 06:03:54 +0000
Message-ID: <d5b5f585-dde1-48ac-8b1d-e7ce089bd0e0@amd.com>
Date: Tue, 24 Jun 2025 08:03:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: mux: Fix the crash when the i2c-arbitrator node
 is present
To: hs@denx.de, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 trini@konsulko.com
Cc: sjg@chromium.org, git@amd.com, u-boot@lists.denx.de
References: <20250623080607.100895-1-venkatesh.abbarapu@amd.com>
 <76349303-7fe3-392f-f272-004c3e173206@denx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <76349303-7fe3-392f-f272-004c3e173206@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e69e183-03be-4b61-1aa3-08ddb2e4e606
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWZmd0dQRzBxL0lqR0htVVV1d0tGc0g0VXd2NzRSMEtGcWkwcEp0SUpQcXFx?=
 =?utf-8?B?bWF4QlVnL1ZyTkVDOUlIMUlrZFJEcU5JZTFPT3hRZ3k1Vktza2ZydE12eUln?=
 =?utf-8?B?dTQ0VUM3blgyMm45VTE0bE91eWZOVnhiUi9hanAyc2FtQUcvNCtjRCtta3dQ?=
 =?utf-8?B?a0pra2d2V29xVGFTYVRZM1RqSWs1QVJwTytKZFlvRVNiV0R6TWl4VjdWU3Uy?=
 =?utf-8?B?ZjN1UVpvbnhMZk9KSmx4QkN2VlI1TUNBeGtONWRIQUZZaEwyRGwwQkRjTW1C?=
 =?utf-8?B?UVZ5czhpVEIxWk1haS9ENS9LaDhqVmIxKy81L2p5M1BMYWdsNHRURk1vd2to?=
 =?utf-8?B?aDR0MUpUV21Wb2w2aTBqV1gxKzVKZW1OWnloS2UrRkZmaE81OXNXTHF6Vkdz?=
 =?utf-8?B?bGpqRmRQSys4ODhVL05CYUZBSkJvQlhlNFhMcVBTbmNVb2U5Y2thcFUwOXJF?=
 =?utf-8?B?ajJGQkRCaUdLWWlDWHZFWisvazM4WG5mN0ZsbGFpdVdNbWE3OXFGbldxYTN2?=
 =?utf-8?B?cXVKNG1YU1dGdzJsNXRvMHE4Rk9oN3lRMVJuckFqLzlwOE9vNnJUSzg2VytJ?=
 =?utf-8?B?VGpjS1Mzdms1UlFJZHZQZEVCRUdlUVU1ZGZ1dnlWYnN1WHdwTjZvQlY0TkNL?=
 =?utf-8?B?M0hIeVdLbWZvaWw0bXoyMzI5bGpjK3AwRTEyeG1FRXhsTEMrZzhGZ3picHZG?=
 =?utf-8?B?S3dNM3RuTU02ak1adk1Ia2VYdk53WGM1VUY4NTFaNE04S2l4eHBzZ1dBQjhM?=
 =?utf-8?B?RkhnUTdEZzZ4RlhIZVRKTUd5eFpRd05VZDdTNnE4TUZwRlYzU2RFeUV6VVdE?=
 =?utf-8?B?V0VMZWh6dUFZcmFwdFhWb3o5VmZES3pKdzg5cGdJL0ppYXNVT2NYc2taS2JH?=
 =?utf-8?B?TmluTFlQTXJYclE5Ulg5enZYRkhFZ0NFK2ZWc002R0M4VXFLMjIzc2tudVVD?=
 =?utf-8?B?dlJBdnYrb0RTSVVuVzJGQVRlTG4yRDNOTDg4MFB0N1JkU3lPVnhmQnU4YWMv?=
 =?utf-8?B?eVZQN3lUNGV4MStOU2xobG94VXIrZkZwdzhpcHBEMXoyNEk0T3lKWHYycjRP?=
 =?utf-8?B?ejdSQXRKUDV5MjNla0NhVzkwU3pKSzA3TTZsSHhhTDZhNzVWc05xYjYzY3Vo?=
 =?utf-8?B?STdRTjVPL0pXSHd3TGxaZ1FTT2NKZEhYSmdmZjFEbytBYzEzVUh3L0xaeWZy?=
 =?utf-8?B?cU44YWVJOUpRYXV4MjBUeGkvcTlCZUJmWGtRWkpVNzhxejlwdWFtckkrd3h4?=
 =?utf-8?B?bTc1bGpCM1plWlgzMGZBWExCOWJUTVdMaWJTUHpuMXNBTkJDTDRXdTV6T2Jw?=
 =?utf-8?B?cWhjQy9HQkxpa05BQy9YNmJ3T1RSZU5UYUcwZTFJMmlId2hSYTZRRGcxbXc3?=
 =?utf-8?B?d0ttQTJqZndwUThvVjJCSnBjeFJxTjhhUTllM0hyOVZwTnNmd3g0Q0JoNk53?=
 =?utf-8?B?LzZwcTkyd01PK01QWlBiclB6dWNxK3Y3WlliUnF2aTVmeUUxWlo5ZUFxV0cv?=
 =?utf-8?B?cEJ6M0xQWG52ZTVKK2pGVGFjQXErVldFcmNncUc1MlUrZ0NBZWdPbjBoZ0ND?=
 =?utf-8?B?Ylp5UE1TT3MyVHFWakEwbVJsa29ER01MVk5QeGdNcGUxT2djcitGbG5DRHY3?=
 =?utf-8?B?Mzk1eStiZG9IV0IrdmFHZjhYNmZpakUwaXVndWQwZytvU280RUtFa0xYK1V0?=
 =?utf-8?B?N1FndzA0bUlRUkU5NHRJZ0ZPYkQwV0t1RGVPSDZ4cXZhV2pJZUVwSllrU0tY?=
 =?utf-8?B?ZGdjMXZkdlhtOVYyTkRkOXZ4cUFIUWx1NDMxTkxINmFqeEJBMWZMSEl4N0VO?=
 =?utf-8?B?ODc2T0JZdk9OUDBOMFF4NUsvTEgwOWZzZ1VHZlNQdEVPZVAzdTFyUk9zRmJv?=
 =?utf-8?B?ZzRkcWt6QjVJelU0Ly9UZ0ZuMmpkNUY5cUFlUzF3VUNSa3VJZ2xQTC9admdG?=
 =?utf-8?Q?VW6fjuoMRGQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pYdmhRZ2VZdFFQcHY5WVNQMkpNYkd3OVU4MURma0lJSUtvam1EMmpPWUpO?=
 =?utf-8?B?Nk12OURKM1BPWGcwL3ZSWkFHVysrMnB6S0ZiVlc1eHpDUHVyMWRFOUFRRTd6?=
 =?utf-8?B?UERVL1NKbUROSmlqRERRdVpLTytXdVh1U3RkeE80TzAxWjBrdUJWK0tUTnZF?=
 =?utf-8?B?TUhZY1U3ZFMwQ1FjVFY4dmMrSDVyVEpmTHRJS3M5L0NCTURaYmdZNkFMNGdJ?=
 =?utf-8?B?VC8xN2FlUDBrSHRiN29QYkgwMDFNblNQVTVvY3NmY0xtZzhKN0tvc1pCN1Z5?=
 =?utf-8?B?UzZFYnZoMnROYkJwZzQ3bGtqM1VMUmRWWDZKc1Z2Z0xQU0RQa2g0WS93SHdO?=
 =?utf-8?B?UmgzSE5ibGJucVdxbGZMM3YxbnMvTElXY3FzQjB6WUpKbUNGaHk5TDUzZnEy?=
 =?utf-8?B?R09aQjRySGVmQTJaS3g1dTg1RnE4di95ZVo1d2pzOWF0WncwNXRlM2JwWUpS?=
 =?utf-8?B?TStZSklBc29pSXFHT3Z2cjhDQWRKWWx5VEhuSG1QdHBtNzYrK3VFby9nK2xw?=
 =?utf-8?B?WHMwRU1SWCswTi9CbytBR3dZdXBoMmtzS0pFblN0SDdHVFEzdFFFRGpXZXMr?=
 =?utf-8?B?VFNsSmtPMEdOWXJ1UklXbTlJSWNScG4rdXdYNmhNYnovWENNU0xGZVU5bW4w?=
 =?utf-8?B?UUY5bC91WXJWOUJKT295Q0NBWERuUUhkSWlVT0diT2Rab3JBUGtkcmVTZUVU?=
 =?utf-8?B?WUxTcnZnMnhwR2I0TEthazBsRUVpR0xhQXRuM2dtT0svTUgybGlydzloQTNa?=
 =?utf-8?B?SXpYVWhoVTB6RDNveUJpZ3lWRDhjSHc1dkI5L0sxbVlCTzRDaVM1VHRwSWhG?=
 =?utf-8?B?a2dtKzE0NUVSeDdLUEV2Qm1NbmZ3bko5T3lsZlVCRDRGZVpWczduendYTkRQ?=
 =?utf-8?B?YXE4TlJGZ2MvcGYyNHlXRThzU3lsL3piT1gvdWZ5aE1oY2NhVVVqN1FCUHp5?=
 =?utf-8?B?cmEyU3huUTUwV1ZEWW9oWk1aQXJlRlRrMnpNeGJrOFZTZHBvK0xjZkM4VEhV?=
 =?utf-8?B?RDdmQ2l0Tlc4M0MwZ0hsMCtMa1BnbGNGbjExQU5LQzJzaXVhRXhXOUlTZjdj?=
 =?utf-8?B?R1FpS3lDNjBsK0lLWUs0eFVObDdxeUprc3Awc1JldjNIRU9LeDlKclE5THVr?=
 =?utf-8?B?aEhIZW1FRFJ2WUpNZnN5ejhJbDNOWmlIaFBZZnk4djRhbFNxNU9sTmFGTGRs?=
 =?utf-8?B?NklIREhBVG1JOXp5bGs0eWRzZ0RYOFY5U0g4K3FrZFlTMnpJVnFhMnRlcmxF?=
 =?utf-8?B?UnpkTkIyUFF2Y3JXVGJlTVJZNEpqZzlMTGMwYUFuVVBKS2xqUUZ4cDVOWmZ2?=
 =?utf-8?B?dkl1QkExdnlWS29ZakxYNTBvS0x2cW1zc05PWmN5ZjdCeWVCL01lY3MwaDdj?=
 =?utf-8?B?VXU3KzNoR2FReVNNTHo1QkJOMFp6MHJSQjhFL05mRzF5MmpwczdTaFltTExh?=
 =?utf-8?B?REV6UTl1a0xzbEJyN292SWxZZ3hSK25jdEh3WW5RR3dCNUVXcG9mUFpIbCtx?=
 =?utf-8?B?d1VjdE9ZTkZFN1JsNXAwNUhISUFNcmFpL2xJSW1HckY3NFBja09wZWcyNDgw?=
 =?utf-8?B?ajR2VFZ6bXJoZnJLRHVDTzRyQWFaa1QwMzkySDZJamV0VDNkT1V2c3RISmRn?=
 =?utf-8?B?Z2s4YzBnM3ZYUDlsU2hwZjljcVV1UGdINzYzanI0ZFF3N1UwR1ZMVW5GVjBl?=
 =?utf-8?B?b1R6WDBHc05CNHBpcktidThHRGRKYVVnNHZQTGdUMHpJZ200Vll2SDBKSjVy?=
 =?utf-8?B?aTBKazVtQnd0OE1CUEFzZHR5NUFKY3BuZURUbWlwKy9DMGNLa2srT3hRNHpK?=
 =?utf-8?B?bVhPbEZZT0VGR283cmtQNGZaSFNJL0s4YkpIYlB0a1pTSDRJODI4VWIwYUdk?=
 =?utf-8?B?bm1Jam1lVkxlOU5ZelUzelJHOS9OME93b1FmYmhJdFZNLyt4eDN0c1MzR0Ex?=
 =?utf-8?B?emlPOVNzRStwVWo3Szh0c09VbHNZRlJGSEcyK3ZpQjJaWEhvekFGdkdIZTZh?=
 =?utf-8?B?MlNVandYSnVNWU1BZXU4MGg2eVRGV3FTYzNYT3ZURE52K2VFVTdDOXB1MVlX?=
 =?utf-8?B?SnlOMTRkU2lEWDFVWkF2TmdlN0JnRnAweHRSVW1McGNNVkQ0S1NFVkdjcWdy?=
 =?utf-8?Q?X9YqZeTZRK5m5aSgxj0uZPDoj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e69e183-03be-4b61-1aa3-08ddb2e4e606
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 06:03:54.0112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rfdJnq8A3P8r9qKodxGxGBjaD/lOB+cw0RCrwng5CufWu/5Ha59YOUTYKDdWQHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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



On 6/24/25 05:43, Heiko Schocher wrote:
> Hello Venkatesh Yadav Abbarapu,
> 
> On 23.06.25 10:06, Venkatesh Yadav Abbarapu wrote:
>> Observing the crash when we add the i2c-arbitrator node in the device
>> tree as per the DT bindings. The issue is with the child node of
>> i2c-arbitrator@72 i.e., i2c@f1950000->i2c-arbitrator@72->i2c-arb, as the
>> arbitrator uses the uclass of mux(UCLASS_I2C_MUX) and the mux uclass driver
>> checks for the "reg" property using the i2c_mux_child_post_bind() function,
>> if it won't find the "reg" property it will return -EINVAL which is leading
>> to the crash.
>> So, add the logic to check whether the  child node has the "reg" property,
>> if the "reg" property exists then read the "reg" and update the channel.
>>
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/i2c/i2c-arb.txt
>>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>> Changes in v2:
>> - Return immediately if "reg" property is missing for arbitrator case.
>> ---
>>   drivers/i2c/muxes/i2c-mux-uclass.c | 5 +++++
>>   1 file changed, 5 insertions(+)
> 
> Reviewed-by: Heiko Schocher <hs@denx.de>
> 
> @Tom: The fix looks valid for me, but I am unsure if it is not to
>        late for 2025.07. What do you think?

No issue to take it to next release. Issue is visible with pca9541 which has 
been sent too but won't make to 2025.07 anyway.

Thanks,
Michal

