Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783E4C07E8E
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58E088DFD;
	Wed, 24 Apr 2024 10:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbQxYayr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BB488E10; Wed, 24 Apr 2024 10:34:53 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D79588E06
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mksVXpaWfpYOi2xySAR17RRDE0uYZhHhMCJr0R/s9H7RATDVfSQ6HBOWPwkElZGrxriowUBQqX51UdHo6EIMJaKBERHVuSVqAu9Irr/cLivb3oDZQZtN/nnyGVWMpVHNBk8J+pOcMj/RKPYAbvUSk9MqkrcyPRdzwRm2XFXcWpy+u9QNE3SU0UHcZmSV3PiyKdiInD62jxWAUz25ogBqf9iA3nvGDT/8Je+cxWfWzuJs5FDvv9Y1m/p7mcZniirJPAm9+AqC7XQfnNG5D/UoXvYfWqpGXxNqNV5kZkicj/BtDEiXNT2H4yDPeLlxNWS4MQe+j83DxQmYhPHh+so+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPcpAp+RqSGqLumk12zllWnUriX5gblixlSXuSJXR38=;
 b=ZOOJeXStNjEzLLPROyT7CjyIjyMmhWddv8PPn0zizaFym0hL0tpn8EqRfgtsgqj2cr/iF13ZMoA63EhLvqm45ROZY89cdW5pm1GN7gNEjupVdWUAKrRi9G/oY4sxIUF1SGZWjKlXoQE4TW6UnqCFTdHbxDOGKpt9YUQgCcW35PEnvlthdVRsWZqq460KSc0HCUaYjXXiI+txeH9zQDW/1Y8lZPd9uYbstBdfUU4q/AOFBg/jb6uLOhvTdGYZjp8fbsXr9XKenXQXSyEDn9De4ssCwH2PHwBcD3Jg/PYnoK5JAu46ZdbrxQAtqI2yl4xfs8Lp5gAfravmNxLWw63lRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPcpAp+RqSGqLumk12zllWnUriX5gblixlSXuSJXR38=;
 b=QbQxYayrEMxntod+p90wcd8ZaARuO6lRHD5LN/jC/ooxfWGY1dRMXtBQevIuUjJR/BmCgNAqigWMyTbNJ4+NUjoLQjq2jG1yYbL8EW0FL/Pt1L0YUSxk0kLnExLHh6/F7hSYQMfUXTOsaWFfpf3rgLM9nQjWDGz940StXraraWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:34:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:34:47 +0000
Message-ID: <39694c3d-3743-47f8-b576-37ccd3467cef@amd.com>
Date: Wed, 24 Apr 2024 10:34:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] arch: zynqmp: Make zynqmp command more accessible.
To: Charlie Johnston <charlie.johnston@loftorbital.com>, u-boot@lists.denx.de
References: <20240410195008.405061-1-charlie.johnston@loftorbital.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240410195008.405061-1-charlie.johnston@loftorbital.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:803:64::44) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c1075f-b2c0-46d3-e7a0-08dc64396691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dm9hTkZ4aUlOUHdQWEhKWnZOTzkvNFdLek9URURrakhsSFRFUnZwUlZqMnl5?=
 =?utf-8?B?bWsrTVAzYVE4RDRSZUlDZWdxT0FMdk15RjZuYTJ4S1d4NnR1Tjh0VzNBL29D?=
 =?utf-8?B?aHY4S1hDaE9qUmtRNktOdDhVY2UrNFN4VUFUYlJBcTlsNFZBM3BFeGZaSktj?=
 =?utf-8?B?K0Y0bCtzZWxkdnpKdUx5akJuK3UzS3FxeHRYVE9EQUhHMTQ5M21qTmpZelZ3?=
 =?utf-8?B?MXdXaU02OTlwc3QvWUtRMUJaSWZmZ0V2QTViTkY2VjB4clBOUUlybk5WOEtP?=
 =?utf-8?B?SkREOGRDV0FKN1hJaWlPekdSczhtQlg3L3pvSUF4K3hGYmpwOG9sTDRQQVpa?=
 =?utf-8?B?WmdvemY1TUtCb3JJNmpnYUZ4QkRPYTF3OTZOOTdXSjU5Vm9TejJKczVMUVpv?=
 =?utf-8?B?QjBYWHNoNXptUUFuK2h0dlMrTTJ2ZDhSWGgwNk9kbTBtZmpQTzV0UUJPaWlP?=
 =?utf-8?B?V0NYbEZXaWRRNS9Bb0ZJM3hhL05KVGZsbWt4R0JhR05OZ3FHYTZDR21pMmZG?=
 =?utf-8?B?bmVZalg3SHRXZHl1Z2JMYjNMQ0prS1hoMzZKNTNRWjlUS0FnQzRJY2xEMUg3?=
 =?utf-8?B?djI4dEk5MTdJVHhCSXduYzN2Z0V0czRCR21QYytSVmRMWklXYmc2WERVa25a?=
 =?utf-8?B?U0krL3hDZUxDVVppVnRQVGl1bmg0ek40MU5zN0hpWEEvMmxSSTdHdy9ZcXV6?=
 =?utf-8?B?WkFiSjNWS3owdEZoQUxsWllWOWNEWmxZdVl5YVlHWTF4dWZ6V3llcVFCSEl4?=
 =?utf-8?B?ZzhMajZwUkNDMnExbUo4Znh5Yk9hQTNwTG1QRi94b3NyMmZDSktsNEpPckwy?=
 =?utf-8?B?TVFUL0s5bmxFODROZVIyUTY0L2o2U01qUmtZSTVSeXhseC9tdmJoRDZXNC9k?=
 =?utf-8?B?bHU2cFhGY2tBSlYydncwWTBnY29POTdacEI4dVQ4ZDd4c1AzUk81WUxjamp3?=
 =?utf-8?B?Wlk0dXV1UTlNU1dEQ25LRWNTTGQ3bWtiK3VjNm1rUEpiY0xZOHNodVpobCto?=
 =?utf-8?B?cXRvMVU5ejk4dTFYVUZIZGQvalpVdzF2RlNBSlZvR3YzdWlXbW9yK0swcHh6?=
 =?utf-8?B?Q1EyeWNCci9nb0lpUXhoemV3OGZtMWhjNlFwSTJSZGNMS09PMUU2dDBhMnhI?=
 =?utf-8?B?S3FlQ00vUEVqUXFsS2hvd0o0L2JiWEVUQXdUaWhCSndnYVhSbHlwcER0RU82?=
 =?utf-8?B?M0ZvSTJ3cWdmWUlWWlIvVmdlUWNmczhzbElYSFJXSFh6SmJrckFvVS9Fd3Zw?=
 =?utf-8?B?N29ucmxvU1NObENyZWtGbXk1eThVVSs5RGlNNFdBdnRmeitJVGxDWnRSQVhQ?=
 =?utf-8?B?VVZrU1BCTHl3MzZ0cDJ6ZWI5NUlyRWM2WElVSGh5RGhQR1JldVNNb2o1Mmtm?=
 =?utf-8?B?b0VNTURNWW9SV1NMZ1NOdG1JVktXOGdIL2xlQUVTbFZTT0ErQjhwSE0rQlN6?=
 =?utf-8?B?SlphYTc4bHZnNURYVWsxdUlTTnB3QWgzclVZYmRJV1hjOGFacDZLQWx2U2Ru?=
 =?utf-8?B?dWZlendnNkVJM1hRL2h0M3JjejBaMXNFdXpDKzJKSFEyZ011VWNEb1Rkbzg1?=
 =?utf-8?B?REtTNm5vL084ZVZ5bGtjcEtzNEM3czU2SW83OWJpcUNkZ1hrbzBqdWNWc1hy?=
 =?utf-8?B?OXdoaFNiaGcvSmZ4cGgwTVBaWjBIaG9IUFZSYUVuOXF2K3FsQXBMMXYvaXh3?=
 =?utf-8?B?d2V0eUNZUFBoQXRCSmJCRFpjZWlYQ2hFMEppVzFjQ083NkZIM1RnSjlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Y2TmdXbFYwMitQcE83MXM4ckRYRTF1c0I0ZmttaFUwQ0pJeXpOYjBzSW5X?=
 =?utf-8?B?N2tFVzZnWFZJZlJFZzJneUMxMFp5V2cyMUlma1lLa3d2MGZaWWwxNnJMc3pk?=
 =?utf-8?B?UjZWZERIQjEydVo2MXVWaDhzNEFMelJodTZSU0sxdFE1SFJuL20rYS9CQUZK?=
 =?utf-8?B?aVo1dkxzbjE2aUZmNFV2bm4za2h0dXF3YWlEWVhsZFpuSVFVbGtzcVdnSHFk?=
 =?utf-8?B?MEp1anNrNkdzWjhqWGh1QmtQS2t4MENJQ1llY0dpeENjeVZnYjVtdjJpZnRj?=
 =?utf-8?B?SmlWZkNSMUxRbXRlQUJHcWJKSlRQKzZMRnk1b0dpQTdWV0lPemhDdHRvR2V4?=
 =?utf-8?B?Q01sVmRINkJJamVqRFJHMS9xcEFvejVpaWF5WXllTHl4Z1VFZXRIQnRsYW1B?=
 =?utf-8?B?Y2dGUXVPdk90dTJ6eWlBY25aVE1KMTllQ2tyTW5pdGRPSVpTVGpjdnBkSllx?=
 =?utf-8?B?SUhtelRwS0pIcWtKbjdNVGNLMEhpZzFadEFrM2lqNVIzV3N0a2J4c2ZHVFlG?=
 =?utf-8?B?WlNTdmxEWWxzUlJKTXhNWDlVdC8yUjVzUk54L0Q0RXZJSUE3c0J3RkNibFhm?=
 =?utf-8?B?UmlsK01JZHYzSzhDYnlNMTNsOG5mdUk1Ymw2bnB4SEZuQVR5VG9OMDVDNlQ4?=
 =?utf-8?B?LzIrZnlKTGZTdnFhby9xS0g5ek41TXFuVklhaEZUbTZKclhOTHRYSTVzNTVy?=
 =?utf-8?B?L3pOQUw5VEFhSm5McmdhallsRTJJK1VCZEtsd29qZmRKT2s2UkY3MXRxcXl0?=
 =?utf-8?B?TEw5bmROaStSUXJkNk9YUG10dWRMRS9aVEFIbmswV0NHUDN2MUVGMisrSVRn?=
 =?utf-8?B?d09YNzdoZ3BrdUx1eU1rdCtoczdJMDlHU2QxdWxyQm9vWktNdXd6Q05DRzNZ?=
 =?utf-8?B?bk42b0NoQ0JtUFQ4d3JiOEJMSmllVHVCZGQvVTI5dmJOMmwxa3lnVEM1cnNa?=
 =?utf-8?B?RVFXdVI4dHh5ckxsRDhGdGJ4ZWJYbTdoZHN5bjVNSU1vby9pSE5ka1BHQmFz?=
 =?utf-8?B?Tk5WaTgzSzY0OFBNQ2tFRGxNMTBvbWhTck50b1pjejNyWWYvOTRYUjdHN0ZX?=
 =?utf-8?B?R0Fvd0IxQ3pIb3FHa1NCY1lCTkxFaFJ0eGI0K05oVzd4cTFkTEZsYVJUT0VZ?=
 =?utf-8?B?THpTTWUrVjd1QmRONmZ6U0tzMkpZb0p0Z3VXOHBURGZNaTh0TWhoWDZXdEFP?=
 =?utf-8?B?V0ZsYTFjdnFsQUNYOU56SDV0dnNPL1BpbWo5OFJmaHNEU1dpM2VpQlNaTDFW?=
 =?utf-8?B?YlRiVTNJZVBJVEZzU3M0cDBIQU1YTlYxZUxERWRHQ0tiYkhaaE4vWWE5OXhQ?=
 =?utf-8?B?RktsL3IzbW5lYUtHSTRTazV6SmlSOFFmUkVEd3RRaFRzMW4xK0ZkTTNwVHpM?=
 =?utf-8?B?c0FhY3ZFcGMyWTByZC9nVnBVcXU2V0x0NE9xRzhKOVc0aDh4TGNCa29DOFR4?=
 =?utf-8?B?aWRray9zZmNYQWYxd2xHVFFidDhZK0tUQ2hBNG1mQ3Znayt2d1paeUNuR0Jk?=
 =?utf-8?B?cWJQMTlsUHZMVEtaUlJYMHVvSEdmZ3VrMWs3OGZJYWRxRjcycjBwV0tnUWha?=
 =?utf-8?B?cEc1Mm9PYUFNNWRXK3d4S3dtalpJYlBheHozdk5JeldPS3poV0NyNVo4VmNy?=
 =?utf-8?B?N3BsWDh4aTBBSjl2Nk1ORUVLVUhpZ2RFc1FmQytkZnBnUWY3bGZvSUJTOGJC?=
 =?utf-8?B?MlpQM0krNXBrSXVFZXhqNE1YRHp3Z1BCZzRPYzBpdTVodjJyKzBDMGpNbUQz?=
 =?utf-8?B?TlpZYXBFRGFFd3E0L25TblByejEzVEdlUVdQMjZQRVd3eG1aVHVEbXJ3QU5r?=
 =?utf-8?B?OG1KMXRpMWdBSmMyWnZqcW1QdSs5SFJHWTlQZm9wTFlMWTNOeDJiNGg5ejY2?=
 =?utf-8?B?anhCaUY0dC9MbG5ZTzgyMGhva015REVDOUFhNDUrQks5MHlWaU1FSE5VR2VU?=
 =?utf-8?B?TW05K28vTEJWdEhIUi96aU9Qb1NNSGNzaitZUGVTRDQ1N3J0VS95bEVaRXhB?=
 =?utf-8?B?UDQ3Z0NGQ01ZNHFHZy9aQzdxWEp0RmtiajZscUU1UlZUMytVOVllang3VDkr?=
 =?utf-8?B?ekw4U1hiclZpNjlhSHZBY3c3cFR2dlhzdzVFTWdhelNhZEsrRGNkN2dhUmhU?=
 =?utf-8?Q?aoL+p09WhJMNbK9Cqs/Z+bUEm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c1075f-b2c0-46d3-e7a0-08dc64396691
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:34:47.8974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIycwQAcTSt9WKueZLrG6v2BW95AcGxu+QUvUUbLpCZMIjiDOntAh3bYQEVGvmEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
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



On 4/10/24 21:50, Charlie Johnston wrote:
> While working on a third-party board using a ZynqMP, I was unable to use
> the zynqmp command even with the proper config definitions. While that
> command appears tied to the architecture, it was being included based on
> the board selection instead.
> 
> This patch series moves the command to be accessible to any ZynqMP arch
> based board.
> 
> Changes since v1:
> - Squash into a single commit
> - Command is now moved into arch tree instead of cmd tree
> 
> 
> 

Applied.
M
