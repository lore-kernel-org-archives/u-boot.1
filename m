Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB78CE7AB6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 06:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72111885A5;
	Fri,  6 Sep 2024 08:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lki39UC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216A988CF1; Fri,  6 Sep 2024 08:46:51 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14AA88413
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 08:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2/AvFzfBII+P1i3iqz1Utgv5PbOorYAU1TotoNpurfP9NdZpFPBIbFV3A3GIL+WAM6OrdzLohbxTqgSRRxdnc8pvFfXpQkT0f37ulVjVw1uQAtgzS+5loIK6pkrYiD4wavf9e1rop3vCW2TEpGUx/3XnmseAqBqTb7/GfVizypc0eysevz7XHFv5N8EFPl9+IAiKXRD1bT/dbvEskgABHrxXLWNiQEUpMvaNFQeI17VrQNDyv7CrV2pLeSK+nYYCUqYau042M/IaiPZ506P7Zm++9CUwWui5D5yyvNZOzlS+elj9OL5sbZrGlxzjbffgMrqi60jOsjti1RSOzG9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClnDHQEy0eGnjoNASByKTEguzNRSv3XuCWU6MWgpe44=;
 b=eRSphwyphanfRyTj0sSHrCZm9vHqCkLuK7AgFHd2MkfQ1/SVO+PHYfeRXN4FDkNeZqz++BS5IyHeX9MnqDw7LrN3vTdx7lLkFSSnNt2KncqrjRzm7XLbGt4W3ui8VXvlfanfezeFqisaFAHSE21pHO15tECVSoAYjcBf10Hw7Fmr0vHikarvC2S7fbrekHjSyxcgCyNXVf65fYkNT3l58gCtM5OzQVULspvWfP7LyPCsD+2GKuJmQAnlQHKHYLaDDOlLWrlRjCX0C/fyI/svGa3vL9jb1meo5jfrl4oHjyD8DWYh4/Z6+yyvBLXQdMncvOX7oyk8yAZY4VtR2g7V2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClnDHQEy0eGnjoNASByKTEguzNRSv3XuCWU6MWgpe44=;
 b=lki39UC7lWjinUTTiexHfvPIaVUunR84dio1QmfVkYUFARcXCnn+Axt2pMt9dKh6GlRuEu8tKLUMTO5TP8lZ5fPGIkIpaDGxGm5x6eEDUroUU9maW1HpgBlpFNFwP5TkiIOuEIUtaeRpP2ckPEW52cjLu8jbRJkxesXGW0tNzNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 06:46:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:46:45 +0000
Message-ID: <867d741a-f856-48e4-8689-9c432f31c75b@amd.com>
Date: Fri, 6 Sep 2024 08:46:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
From: Michal Simek <michal.simek@amd.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
 <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
 <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
 <17fdf962-20b7-4bb9-93ba-bdb7335c4762@amd.com>
 <CADg8p979GVQ+bk4RYUmE94Fnd1jQ6sv41V82ZRW=+gjRhn6dwA@mail.gmail.com>
 <41f4766b-7861-4608-905f-9717e6fdc230@amd.com>
 <CADg8p97-Nbn0AsnL4Tu=375uoONmPSgr9Yj0MnEB5u1O8P0AEg@mail.gmail.com>
 <db7aaa38-d66b-4575-a50c-0b1bdbcda9eb@amd.com>
 <CADg8p95Sg9ASrTOXOGJz8-HcFxuadRL6K9URYAQdZGCZ9NPgQw@mail.gmail.com>
 <1bf05e73-3ef2-4f15-87ab-64c32d60f924@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1bf05e73-3ef2-4f15-87ab-64c32d60f924@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 11079613-dda1-4f7b-388a-08dcce3facdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFVzd29paXpteFBzMStjZ1lUY296dVZUMDM2SUhVa0pvNGJPV0NJVFVMR1Vk?=
 =?utf-8?B?S0xzT2RGQlhuZjZCTWZDT1loR1VxSHZ6bmQxVnpYaFZHMERZM3AxZzNlbWM5?=
 =?utf-8?B?dWFZSWZndkhuMmt3RU54T1Y4MGE1SEZwTDljeWJOR2pDZzBEeXNhekxreERF?=
 =?utf-8?B?WUF5RE1xUVEyeXhqaFM5SFBLcTk2N29Pbms5R3lTYUtEb2RQMXd0QnRjRGtX?=
 =?utf-8?B?am5ZU0ZWNk1lemtYZHU1bE1CMmJqRzM5ekVNbjJ1S0lTRFVMK3NidnJEZlhM?=
 =?utf-8?B?N0dxYnZPOVJWVXY3YW0yK2hrZWxFS3gzeC9FaHNpWWQzRFRNeHc0MHNYd2xn?=
 =?utf-8?B?UHIxeDE2S1dQZmVkZ2VBeElUYzAyS0NxMlJqUmNDZTVCdXlzMVh5L05VeEJa?=
 =?utf-8?B?dy91Vll3N1J6dm1tUm9laitwRGdNdnJHQ1QvSWJnMkVXNkIveWVLdmNuaGRi?=
 =?utf-8?B?ajdSQUlWRHFsLzhTdWdiQkJBeGxWeWJWRWt0Qnp2US9MbGFyMEpDdFB1Zy9q?=
 =?utf-8?B?dDBGcEI5VHJZNlNJL3MrM3hXRHI0cVVaRkR6NWRuSWFFNGNLZ0VpMVBCdHZQ?=
 =?utf-8?B?R0xSc3ZQUHlSSkRZQWhnUzlrL1RYUVFSU21GUmVIZTVRbHdmdE9vU21IM0Zv?=
 =?utf-8?B?NEI4Sm1RYUxleVRFNlU4bUF3LzRPNWhvQXRXSDExU2MxVzA5WVFDcFliU0Mz?=
 =?utf-8?B?YkRpcDl1VVRnVFBYUkJQNTlTdjNta1FKbEp0b0ltTC94ZnlvNlN1bXg1WGt5?=
 =?utf-8?B?YXp4YjlpYlNnQmc3K1A3OFRtSDZBRm1PVklLRXNRVGY1V1ZxaVRBWUpzRnc0?=
 =?utf-8?B?Znp5L0Z4YmZoOWFLS3VqZVVPU013V2EvNThNcGYrejJXeGN3UE5OV0UrQ3dK?=
 =?utf-8?B?R1hwUUV3ekVOTnVxM3Backlhbkd6cFhrczJOM2t6L21yN3YwWDR4TU5USDJv?=
 =?utf-8?B?dWtYZ0dQQjRvTDJGVUJzNnoramlNSW1vakc0YkZ0QkN5dHNTRmZOdTFqTmVs?=
 =?utf-8?B?STRxZTlBaDA4MEpFeDkvTlhCUmpNYkNtQ09FQkVYckNxWDNIUCszeThUVTVo?=
 =?utf-8?B?WmpoOEpyVlJxd1d4TXBNNkR0R3dLWWVRbFpCRldLOU5NeFhrZ2JYbi80a3N4?=
 =?utf-8?B?TlBFMEN6dlhSeDRaazI1T0tiUitNaC94emlGRHNiYnpwZUFUNEpDYnJkMzU5?=
 =?utf-8?B?T05CSkdKUmVrT0ZIU3N2eU52NVJoMlQybEZsQlh4SjdZUlZPeVlXaXF2bGhU?=
 =?utf-8?B?dXkxYytncEp5TGNqTXZOL3lUbkF6U0xhZzFJSkE3aUk4SEZYRndHWTlYU2dE?=
 =?utf-8?B?NWthNFdOdy9WL0c1WmtaWHJ2M29OTTZxdlNxcksybVVMMFZ0c2syNWZXTyt1?=
 =?utf-8?B?Mk1GOUJrd0E0NW9GK3ZEMFdqRklDVFY0Tnpra2VZZTFDeTE1VmQvN1orM3Vq?=
 =?utf-8?B?cFFHVnNkU0VvRkFtWjd6NjdETTRlcUFDYzdKa095Ui9TSkZnOTRJU3BiSHQ3?=
 =?utf-8?B?MzBNdFpSZ0N5cUZDTVRad3hyQkM0Q0hKbDA4b1pCRm8vM3VMYmhsUG9pQWlH?=
 =?utf-8?B?M29vc2NrNnJKQzFvM2NRYXg5L1NpdndNR0pkcW5MbFFjc3BmQUhPYnVRYUl0?=
 =?utf-8?B?bzN0U3pxaHc4QlhGWDNnMTJocHV4bUQ5RlNrTE1HM0Z6eG9CYXFTcjRLdjR5?=
 =?utf-8?B?bGg4bm5JVUxDVVNldGlMQjFjZ04vaStuWVNaUWw5YTJVTjNWcC91UGpienJn?=
 =?utf-8?B?akUrNmdLeW1pQ1lJdEMvZXlSZTlaMEU3YmVxNnJZcnpMS3lBWDdUZWdCRmFu?=
 =?utf-8?B?OG9WcDk3STJzU0xxS1VBZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnJzQ1BQM0kxSHRIQWU2bGZDaFlFYTJlRC9uOGVHUWtHMUhUZEVjajdzSW85?=
 =?utf-8?B?eGZuYnVuZlp0M0o3RTdhZG1HZENPYStESW1KbTdmMWZSN0t1M0YycUt0Q0V2?=
 =?utf-8?B?bHY1NEd6MUFGbVA2MEhPcUZ1SUNFbDQ5YUdadDhTbTk4NHl0YnU5ZGR0U25S?=
 =?utf-8?B?MWsvUXZJQlcrZkZkKzlnZWs0d3ROM0t5NkU2SkVTTlBLMjhaZ1I1RHF2bW0v?=
 =?utf-8?B?SlMrOXRMRVE0N3c1SjZOWGVVNEloZUEwWTlkQUE4L2ZDZFZHV2F5aUYrV3BL?=
 =?utf-8?B?akEvZEdPbDVzOXlxUGVrVVBZVlQ0QVdwMTZYTG5UUHU5OTk4WFdoTDhXSXd3?=
 =?utf-8?B?NkFmcENkdUV5RlkvUVJBRS9CaktpRlpYaDZycXFzb2NYdmV6eWhpVVc5OFVv?=
 =?utf-8?B?UHFUUzlsUTZDUTUxOExHSWR6QnY1R3UraUhYbTEra200ZEtyRWZTK0FMQnlK?=
 =?utf-8?B?cEhzaU9yWXBnUnJlQmtXM2U2aGhTRXpNRnR1eGJ6SUpVWGtxbjNsWm5iczFy?=
 =?utf-8?B?dko4Kzg0Nk9VWDlDMXJvK3lncTVJUU9NUHdTd3U0amVOTHcxcnJZOEIvNCs0?=
 =?utf-8?B?a1RoQ1o2aUU2Ymt2cTRmRGJJelNLTi94dkRUZzJJajMzU3FCMXp1WHpJazRF?=
 =?utf-8?B?cGh2UksxdlFzcmhldFo0Y3BPdStwaGlBYjFMRzFaaWFqRWJrSXBYdzA5Szlo?=
 =?utf-8?B?a05pVURYV0NIL1V4cjZaU1ZxbitkWTRiaHl3eWFDQVBkOUFSOWNEeXZqSC9U?=
 =?utf-8?B?dnBqay95Uk15UWxyUFJkZEVNNEhIdXlHTlF4WnRBWFM0aFBiREJtZzhpeHBS?=
 =?utf-8?B?RnRiTzF0VDFJSmhPWGhxMEJhVTc2QXpNSXF6VmR4bEhsbk1yclBzNThURXd0?=
 =?utf-8?B?R0JQWXdaM0Y2Z2c5THNtLzROZXl1MXFrcDJxU0RiSlFXUjZDWW8vaFFucm9L?=
 =?utf-8?B?cU9ocjRNZ0c0cTJlVEJ2N0JiMW1SdW1oMllIMWVNb2dYeEp4RmszOFRtTjVV?=
 =?utf-8?B?L1ZJckFQbjh0UXMyNVVEK01hMXM4RjZkWWZHZnd6TkFjY3RhM0ZwOUxtclpR?=
 =?utf-8?B?VzU5d21sN1VtYTg3VzN3S1o0Z2p3UCtMS0pNd20xYUpDUldTbkVTTHVWcmRR?=
 =?utf-8?B?cGZJdDNiMFNWTnFBbTZqY2p1Mm9yRFNCS2FpL29DK1E0OUhjdWVOc2U1b0N0?=
 =?utf-8?B?Mk14YmxLdjc5ODY2alJvbjdkRjJ3TEJsOHZMTFl5d3dvRTVHTDA5TkpFRFNV?=
 =?utf-8?B?UFZ5Z1VhRnN3YWpWWThtTWpUb0loMW1RRlFIRTFNcHBpb1JRcUllU0FJZkV4?=
 =?utf-8?B?QTZPM2dweVZ4dzhPZmRjT2UxV1lkVHkveFpDc3M5bHhRbCtacjdhQjQ4UXlr?=
 =?utf-8?B?R0NpeUhQODlzNXE1L0hqSXVraHBiUkplM2JaQ1pxeDIyTld4QnlleWR3NFNB?=
 =?utf-8?B?ckhjblRjS0tWWWlQcXlsRzhlaE5hL3NBQUU5VG1nWU9PSlZRSGR1WWVyMkQw?=
 =?utf-8?B?WE5jZFQ2TU9wdVptcHNYOGdLQTNPa3lhdFRXWFBaS0UyTk1EVFdLSE80dUZJ?=
 =?utf-8?B?dWdSR1E0QStKM2NtQkUyTDVDMUJ0S2pGOGZEZ1lDQUwyN1dVQUpFR1dWeUpQ?=
 =?utf-8?B?RmJybCtrS0R4dXFHTGpFNnptYzM5bWptN0pvNTZybElaMmxCTEcrU0JQT2Ez?=
 =?utf-8?B?eEFLOWkySUIxdUhubEU5cVhRL09VZGFoK2ZrV0RlNlZvZUZkQWloZmhCak9J?=
 =?utf-8?B?UzY5WlpuZWZIcXJEdVhsd0VwaW1zcEFXTDFVeDUvMEhSekhtVmIyS0R0MDFJ?=
 =?utf-8?B?UVNqS3NLRkRyczMzVS8zN0dLaWJEeXJqRk1PY2REVDJaOGE3QkdjVGhTSzZS?=
 =?utf-8?B?RHArQ09NNFpuVlZKRGwrZlpxOXA2SVR5dDNtMHJUVE9Ma3RaODFTSVRKVmxI?=
 =?utf-8?B?QUxhZ3N6cTM1ZHZTbTE3RHpYYTQrUGRmN1JBcnppbHdocHJPY0tRd3FUODFw?=
 =?utf-8?B?SVZMNE50UHRQRlNDUnd5aUR1ODZCTlcyRE1IMGNRRkJYM1RwREdQL2pONTM5?=
 =?utf-8?B?NkQwd2t3aFlsNlhObmhFVkxYaUlXQXBENmx4UDVrNGtKZytkVm9MUmZTZHF0?=
 =?utf-8?Q?qEDI2HMkiiylfKaduRPa6l2ik?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11079613-dda1-4f7b-388a-08dcce3facdd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:46:45.8802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smocGnTinOWXLx1W4ov4cYElI+4ENmcZdD1WcpUJ9/9mU35K/g3v6mEzZdpdGOpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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



On 9/6/24 08:35, Michal Simek wrote:
> 
> 
> On 9/5/24 11:17, Sughosh Ganu wrote:
>> On Thu, 5 Sept 2024 at 14:07, Michal Simek <michal.simek@amd.com> wrote:
>>>
>>>
>>>
>>> On 9/5/24 10:12, Sughosh Ganu wrote:
>>>> On Thu, 5 Sept 2024 at 13:20, Michal Simek <michal.simek@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 9/5/24 09:43, Sughosh Ganu wrote:
>>>>>> On Thu, 5 Sept 2024 at 13:09, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/5/24 09:38, Sughosh Ganu wrote:
>>>>>>>> On Thu, 5 Sept 2024 at 13:03, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 9/5/24 08:24, Sughosh Ganu wrote:
>>>>>>>>>> On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 8/30/24 13:40, Sughosh Ganu wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> The following set of patches are miscellaneous fixes and some
>>>>>>>>>>>> hardening of the FWU update logic.
>>>>>>>>>>>>
>>>>>>>>>>>> Sughosh Ganu (6):
>>>>>>>>>>>>         fwu: v2: perform some checks before reading metadata
>>>>>>>>>>>>         fwu: v2: try reading both copies of metadata
>>>>>>>>>>>>         fwu: v1: do a version check for the metadata
>>>>>>>>>>>>         fwu: check all images for transitioning out of Trial State
>>>>>>>>>>>>         fwu: add dependency checks for selecting FWU metadata version
>>>>>>>>>>>>         fwu: do not allow capsule processing on exceeding Trial Counter
>>>>>>>>>>>>           threshold
>>>>>>>>>>>>
>>>>>>>>>>>>        include/fwu.h            | 11 ++++++
>>>>>>>>>>>>        lib/fwu_updates/Kconfig  |  1 +
>>>>>>>>>>>>        lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>>>>>>>>>>>>        lib/fwu_updates/fwu_v1.c | 18 +++++++--
>>>>>>>>>>>>        lib/fwu_updates/fwu_v2.c | 80 
>>>>>>>>>>>> ++++++++++++++++++++++------------------
>>>>>>>>>>>>        5 files changed, 99 insertions(+), 42 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I found one more thing.
>>>>>>>>>>>
>>>>>>>>>>> I did this change
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
>>>>>>>>>>> index fbc2067bc12d..dab9530e499c 100644
>>>>>>>>>>> --- a/tools/mkfwumdata.c
>>>>>>>>>>> +++ b/tools/mkfwumdata.c
>>>>>>>>>>> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
>>>>>>>>>>> fwu_mdata_object *mobj)
>>>>>>>>>>>               struct fwu_mdata *mdata = mobj->mdata;
>>>>>>>>>>>
>>>>>>>>>>>               mdata->metadata_size = mobj->size;
>>>>>>>>>>> -       mdata->desc_offset = sizeof(struct fwu_mdata);
>>>>>>>>>>> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
>>>>>>>>>>>
>>>>>>>>>>>               for (i = 0; i < MAX_BANKS_V2; i++)
>>>>>>>>>>>                       mdata->bank_state[i] = i < mobj->banks ?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> to break desc_offset location. I generated mdata structure and write 
>>>>>>>>>>> it to
>>>>>>>>>>> primary mdata partition.
>>>>>>>>>>>
>>>>>>>>>>> This has been spotted by (my debug) which is the reason why I did it.
>>>>>>>>>>>
>>>>>>>>>>>              if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
>>>>>>>>>>>                      printf("mdata offset is not 0x20\n");
>>>>>>>>>>>                      return false;
>>>>>>>>>>>              }
>>>>>>>>>>>
>>>>>>>>>>> But I got one more message below which
>>>>>>>>>>>
>>>>>>>>>>> mdata offset is not 0x20
>>>>>>>>>>> Both FWU metadata copies are valid but do not match. Restoring the 
>>>>>>>>>>> secondary
>>>>>>>>>>> partition from the primary
>>>>>>>>>>
>>>>>>>>>> The reason why this logic is in place is to handle the scenario
>>>>>>>>>> whereby, during the metadata update, the primary copy gets updated
>>>>>>>>>> correctly, but due to some reason (like a power cut), the secondary
>>>>>>>>>> copy does not -- this is because the primary copy gets updated first.
>>>>>>>>>> In such a scenario, the secondary copy of metadata can be then
>>>>>>>>>> restored from the primary copy. In the scenario where the primary copy
>>>>>>>>>> is corrupted, it will show up in the crc check, and will get restored
>>>>>>>>>> from the secondary copy.
>>>>>>>>>
>>>>>>>>> But in this case - CRC of primary is correct but data inside is wrong 
>>>>>>>>> because
>>>>>>>>> offset is at 0x21 not at 0x20.
>>>>>>>>
>>>>>>>> How will this event play out ? Am I missing something ? When the
>>>>>>>> metadata is getting updated, the offset will be written as 0x20, and
>>>>>>>> not 0x21. And in case the metadata gets corrupted, the CRC check would
>>>>>>>> fail and the primary partition would get restored from the secondary
>>>>>>>> (assuming that the secondary copy is correct).
>>>>>>>
>>>>>>> It is not after update. It is initial state with incorrect mdata structure.
>>>>>>
>>>>>> Well, if the metadata partition is being written with incorrect data,
>>>>>> not sure how we combat that (or even if we should). After all, the
>>>>>> spec clearly states that the metadata cannot be protected against
>>>>>> malicious writes. The logic that you pointed out earlier is to handle
>>>>>> the scenario where the primary partition got updated, but the
>>>>>> secondary did not.
>>>>>
>>>>> I don't disagree with you.
>>>>>
>>>>> Scenario here is that primary partition is updated with incorrect data content
>>>>> (but still correct CRC). This is correctly detected that data is not right.
>>>>> It means primary partition is wrong and shouldn't be used and it is not used.
>>>>>
>>>>> But because it has correct CRC syncup code logic is doing syncup.
>>>>>
>>>>> That's why I think we have two codes which have pretty much independent logic
>>>>> what to do. If primary is wrong sync should be from secondary to primary but
>>>>> that's not what code is doing.
>>>>
>>>> The scenario of "primary is wrong" will only play out in case of
>>>> corruption in the metadata. The scenario that you highlight, that of
>>>> the metadata being wrong, but the CRC check succeeds will only happen
>>>> when the metadata has been maliciously written --
>>>
>>> yes. And I did it on purpose to check your code and all error condition you are
>>> checking to make sure that code traps them.
>>
>> The code should detect and fix any genuine error conditions that might
>> come up in the field. Even the check for the case where the two
>> metadata copies are valid but different is a scenario that can
>> actually happen when updating the metadata copies, and there is a
>> reason why we are assuming that the primary is the correct copy and
>> should be used to restore the secondary. If there are any valid
>> scenarios that are not being handled, they should be identified and
>> fixed.
>>
>>>
>>>> if not, then the
>>>> secondary partition should also be written with the wrong metadata,
>>>> and the checks would then fail. In the case of the primary metadata
>>>> getting corrupted, it does get restored from the secondary partition,
>>>> assuming that the secondary partition is intact.
>>>
>>> When primary is cleared/has incorrect CRC there is no problem and recovery
>>> happens but if CRC is right but data inside wrong code doesn't check it.
>>
>> This is where I think that this is not a genuine "error" case. So, if
>> someone has written a metadata copy with wrong data but right CRC, and
>> only written this bad copy to the primary partition, how do we trust
>> that the secondary copy is actually correct ? One can generate a
>> secondary metadata copy where the primary checks pass, but the image
>> information in the metadata is incorrect.
> 
> If U-Boot knows that data is not correct, based on it's check (in this case one 
> incorrect field), you should never use it. If second also won't pass this check 
> U-Boot shouldn't use it too.
> 
> If secondary copy pass all your tests you trust that it is fine. But if not, 
> then you don't trust it.
> 
> And that's exactly what it is happening here. Code knows that primary data is 
> wrong and properly detect it but another code blindly not checking it and just 
> copy it incorrect data over correct one.

here is where the problem is. Code reads mdata structure and checks only CRC 
over it and that's it. There should be additional checking perform before you 
can say that data is correct.

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 983f232bd179..9ec750b51da0 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -313,10 +313,13 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
                 err = fwu_read_mdata(g_dev, parts_mdata[i], !i, mdata_size);
                 if (!err) {
                         err = mdata_crc_check(parts_mdata[i]);
-                       if (!err)
-                               parts_ok[i] = true;
-                       else
-                               log_debug("mdata : %s crc32 failed\n", i ? 
"secondary" : "primary");
+                       if (!err) {
+                               if (check that format is corrrect)
+                                       parts_ok[i] = true;
+
+                               continue;
+                       }
+                       log_debug("mdata : %s crc32 failed\n", i ? "secondary" : 
"primary");
                 }
         }

Because issue is that CRC check only cause that part_ok[0] = true but that's wrong.

Thanks,
Michal
