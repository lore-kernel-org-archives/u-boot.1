Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7497CC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC95839B5;
	Fri, 25 Jul 2025 17:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gEHmFJLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80833839BB; Fri, 25 Jul 2025 17:31:06 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23899801DD
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUOD9RmeR42WDbr/LUaIWvLGFMynbFIA8JUzaMEbv/xeFwZf9brl60duapUqpuSUKDXs3N4Rmg9OY4VtA1PGWKso1yZWYP/yULTaIo7QT8IraWqC4PALLybmD/CEQmErGyKNLiNN6w6ybdaJM6neB1MhCaZ1IPbxzRyZRUulclNaBu5FZ7ZHJ7CUZ5PkgaI0eW+SIABjaA7J8g23pvEtZHfkKgZWLxGuMJeOmjlYIrkQTAVRm42Zt/2Bag9fVTYtEGHmRLyZ0jaoK4woqo8CY4+E1HcwRaQgY57dxqkvLvPftaHRBDPmMrY7bTeVzYadlWNoutu3HT4WRErc9IC4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+F1Zq2OI482ZDfHzCulbMX9g7KFLVFPhCl5Frk/GP4=;
 b=srTTVwHFR+OvRPgHqdXO++eZ5xZb1A+u5rODLRICyzLXBfE1MS9I465k5j1fvmQ16P5wAUs/tlU8Zm6KBEoU2Bz7RgOQgSIhkOPajPiMoFQk+kWc9cmxtOitjVguzWvY3ZelODc+Q6u0xNf5R8X3W5JT4Vyxq1DzBQSO15Irrfb2K2LX7e729uV1Ih7B77z/xTTdKblz98chKOi5IaBwbdlQOAq6/zr6TmKoNLiiSgHNA7ILAxuwCZ5cle/oDCKNK/W6gCpvqcsKWMlkw399s4yFGa0Y+0ApC+pwtHYKW25i7A0Q7Ab3wh2zlqKBWQAcgVpukjQA/033vICtg6zEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F1Zq2OI482ZDfHzCulbMX9g7KFLVFPhCl5Frk/GP4=;
 b=gEHmFJLu8FuzTAtchYP3Ux4+gaioJN0Z9oB91RBkx5dNE3oC8EkdLOA0IN0oMQa1XoRHYUlsLcNB6k09HYHeVtc41LosodfvAUkdwRQ0uidlbkowEPJJUDrhJOQ1gol9bQQ5BWSZ2T5448lGvjKVUYKu3urfG+Ln5FZOcYJNACk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 15:31:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 15:31:00 +0000
Message-ID: <ad876397-a18f-42b8-ab84-47282b7a4f48@cherry.de>
Date: Fri, 25 Jul 2025 17:30:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pylibfdt: setup.py: Drop license_files
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>
References: <20250725151821.2067853-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250725151821.2067853-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0086.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::39) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d010062-81a4-49c5-1d55-08ddcb9041dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0YrTzkwaDZ6UndLelRFS0JjUVl0bmIrWTdFTzdsdkwyZHNxblUxTUVKb21p?=
 =?utf-8?B?Q0gzTzk3ZkhSVjhpVms4b2kybUhydmF5Uk1iV3lScDZoOWdNYUdxbXV0ejZq?=
 =?utf-8?B?QUtINWNwUTVsT3NGaHZIdk4ycnp4QjBIMG9SNlB5a0lyaTZoU0k5eUJ4bzF6?=
 =?utf-8?B?NVRPNVN1d2NVVDR0U00xU0IzR1VVR2VYcWFqVis0WHluaGJ6WjRmSUErMS96?=
 =?utf-8?B?TFNrQXJnS2dlM2srUXBVdUZEV2RnVit3Q2tNa0krdXdwdEhhcGI5WTJoTnRX?=
 =?utf-8?B?Zjhmb2lxa2hhbmFqTFZGOXFNaVhCSXd1STJraW51Z01UOWozNEY5eTUycWhR?=
 =?utf-8?B?WGJ4YzVRMmtFcmRDTTFlRFpBcGdhOEw0b1FWV3cyR01kRHpwaStxd2xWL0NB?=
 =?utf-8?B?b1VRekZxWElab0ErUkhYdVUrOFJmNWpDb3BwRDV6d0dJNW5PRnFVSHI0K0Qy?=
 =?utf-8?B?RUpuZ2QwWTNhMS92cXZsOGJ3VEY0UGgzTFNhVHE5dDl4MkVha0NsUElQclgz?=
 =?utf-8?B?UndjVTNBOFJlYW12OE9pS2g0SkowMDZnNTRtZ2d4T3NPV3QyeG84bGtwZGFq?=
 =?utf-8?B?Rm5JMW50Z1ZNaUdVZG9hQnFQYzZvcktQT2JSWmhWanhWVVJ0MnFhUmMvMzg3?=
 =?utf-8?B?ekZXekhWLzRiekZCS0lWWlVTeWZEdDM1UXoweVQwUjEzdHRNUkwzUmx5RlRz?=
 =?utf-8?B?U3haVlEyRUtFZElHdWxoM1N4enNwMFF4d3FDbTNITVBrQ0tpeExHQTNZaGEv?=
 =?utf-8?B?NUhHdkx3VjI4RExmQzIrUXcydGVUV2Z2MGdZRVZVZ3kreDBaTGdqbzZDSmhQ?=
 =?utf-8?B?VFRkQ1kyNUtWaERuMVZ2NCtSWXhZWkE2eFJQVUZtM280VEdJeGVocEJxM3NF?=
 =?utf-8?B?elhWZWE1cUdJVWEzTXRiNDB1NFAwb1JYUW5mWGcxR1BLWFRucjVkaVg0YU5j?=
 =?utf-8?B?QmJ0OU42d1FrT2xzaDFJaVR4amx2T3J5Q0pyYXVqdEVkb0NtcndhSG9uTlRH?=
 =?utf-8?B?Ukhjbmh0T0ZWL1dtQ1NEYzZkNjJsWlJzcUZXdEpSbmx2TktBeUJkT09DU0VE?=
 =?utf-8?B?NFBEM1Y5Wkc0bUd2aDh4UlBNUS8rWTZLalpodmpwUlBHSzg3QXMwRFhpUzZT?=
 =?utf-8?B?dmp2MXAwN0NxK2ZSOGJnU1QreEEvL0FUaTF0RlIxRm9xYVpKOTVqQ2VsSldt?=
 =?utf-8?B?WDQzVlFSS3dFcG9sQVdHSFRsaUJCaGFlMzJmLzRXZmlrdFdFOURMWmtKL00y?=
 =?utf-8?B?TnpranVDS2p3Ky80UzQ1WDQ0Y1A3aDhLWE5GZzBUZ0lFaGlMQTVxTTBCcGVm?=
 =?utf-8?B?cnhpZzlHT3JwRVpqb2RKTjYxeHF5ODFyTjVSMm1VSDdiT3pSS29vWXA2NWRl?=
 =?utf-8?B?MVZnMDE1ZEtjcXN6UkNaajFKNEdkQkM2RmJEMEFEV0s2UWlucVZoZzh1ZjZh?=
 =?utf-8?B?N3czZS9PSmsybWNnQmZxWHpBdXhXbHNrdmEyNVRJSDZiUmVLUWxDUHJzZ3A2?=
 =?utf-8?B?OFoweG8zSzREcmJjeWl1ZkpRbFMvYkYvUTdFbFJiVVJ3WkgzZzgwejNaUzY5?=
 =?utf-8?B?QU1YREVxckMvZ2JuaXhacW5mRmRyY2NYZzBqbGtUVUtyaStPT0dLRDVCN1Nm?=
 =?utf-8?B?TnhiNjFxRnVMRE93N0Uxc3VtdG9GbllRUWhCcUFkT3lOOU1ia0Fqb3ljMkJI?=
 =?utf-8?B?aERsbEkzUEZIMkFDZmxCajB3OVFEQlZncHB4NE5Rdk9PbjF2UXNWeU9JRHVu?=
 =?utf-8?B?eUg2U0ozaGhEelNSeGJpaUFmdHFia2FVV0hSeE12YS9ZSGNKWUR4UnI3YXN5?=
 =?utf-8?Q?sw4eS3FlcV2pWaC6EAKlIyAkFQ1/K9qP+0kao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9ncWZiZHVROHZmS21lNUNzN3lyT3pvckpkNGh3MFJyWWw4TWdCbnU1WWlR?=
 =?utf-8?B?VVV0ZkkzWkJNL2dJSlBycjJjMlVYSElUZFhZemEzN2h3dnVpUmE0Um9WcEg3?=
 =?utf-8?B?cmJ4SXIvWmxvaGdYb2RzeGhOOUhEZCsxdUt4SHVQazg5V1BLcTZvOEhkVThP?=
 =?utf-8?B?WG9nR0FVOS9tWTNza08rR2dVb2xhRmM2bFhkWTdJNm4wVFR4NVhSNTRJdUFi?=
 =?utf-8?B?U3cvWkxPa21BdXV5QlhJVElobUlaaDRObEJ0NHdSZ1JXTllJL05OK01STWla?=
 =?utf-8?B?VzhqVTVPUmh5QW5ZMElsQ0ROeTRELzg3TE9HQXhMSkM1WlJyZWdScUhMcVFG?=
 =?utf-8?B?a2lZMlJDOEt6VEl3SnpKUlhjZ0xKYjB3S3o2eTNhaGNPcncyUFNUaEpLUDBh?=
 =?utf-8?B?MzQxbnRMZDFoenZZeHNxVkJxMFBWSUNhSldmeTRVaXdad3gxQWtveFBVcmdK?=
 =?utf-8?B?N1JNZ1YvTWJ6dWZLL1BJMVU5WUlWMFRGV1l2MjFrem52VENNcEZXZm5mektZ?=
 =?utf-8?B?clJPK1BlenVlUFNvNHJZTXEwUTR2ZW40SFlJUG9RcFdIVEdHb2VZZWxCSCtt?=
 =?utf-8?B?L1VrNlB1a2xuVTBSVG16bllPT0pmckpoRUw4c2gxOGRhVHVWVGpOcjVqNVFS?=
 =?utf-8?B?Mm0rVmcxdDRCcUs3VS9LbFg4N2poU0VjbXhKb0ZzMzg4dUQzbFpuNnlXQlJa?=
 =?utf-8?B?R2lZT25ERGYwYXZUeXQ3K2pIbXlwOGpKblE3eGd1MHp3RHBvd0xkYWJNekw1?=
 =?utf-8?B?RTExZXlmYW5rUnBiWUhJS2o3aUh6d3FUY1R0TGFoNTB3WnJDazRZY0ZQaVVM?=
 =?utf-8?B?NG9neWVEbm82R2RVeHgzQXJsYlgyc2RCUXFEMThLeXdCZDV3ZlllVFVncTY4?=
 =?utf-8?B?bUpnQ3k0ZVpWdlpSNW5wNXdqYkJoTXpUa2NsN2YrdjBoa2pFUm9jdjg4OEtt?=
 =?utf-8?B?VmQ3cUNvWmZEODBTaXYzZnJjQklWU3lPUnlqWGYxRHNmMjN0R0xmNmxMRHJw?=
 =?utf-8?B?OEZZbEdLS2swODZDNnRFU2dJUytzUDVZaFRrVnlSdFE0RE1GczlsYVBUcEI0?=
 =?utf-8?B?RGM2TjlpRXc1c0JSNVlMN0FMNGNGc3JOTm1kVlp5dndEdlJGTDh3T2xDSitW?=
 =?utf-8?B?VHZXclBvY0c2RHZRS3ljN21pK3NZbU5EV2QvUk5IUUlYYmZLbkcveEdGWnoy?=
 =?utf-8?B?Y0QzZjE3U09QZmVzMmh4T29sZzZwSm01V0VSTUdCc0hmTDJ4ZFZ3dGtCbjIy?=
 =?utf-8?B?ZzdwM01XY1pYQ1A3QjZhbWkvRFJrajlma3F4K05rN3lGUUxibE5UK1BmSWQ3?=
 =?utf-8?B?S2FtUTY5SFVwNzhQeVhmZ2N4KzRxcDJjb0JwYVFDOVNQeUk5R2Y0MksxaHAy?=
 =?utf-8?B?UEJ1NzVyRnBvbkVNeEovOHRTTjFtQVN1blpPZmNEMEpOK0RlTkZjYms1TXh0?=
 =?utf-8?B?aUlIQ2FzcTR2MXF3MjBLc1BUYTE2OEZNOHVKS21sUUJINUV5NWJMdTU5SE5n?=
 =?utf-8?B?dGZiemFJQ1VoVHJwelJNbWVXL2Z4Z0htdWRNVkVCOHdxV0hCMlRpbldIVmJT?=
 =?utf-8?B?U3FTVXdvQVdBVjZIQWZmb0U3SDNyenBLdWhOVFRPdHFudzRVSUVJUStjNXBF?=
 =?utf-8?B?MmFab0JKYTJtZmIvVWMwd2ZkUnI2SmdjbVllV2lRWjN3a0Fwcmxia0pvdG9i?=
 =?utf-8?B?YnpCcVZrWmNqWU9ZREJRc0J6TXFuRTJCQ1gwZjl3Yi9aSGsrK3YvdDVCeXp3?=
 =?utf-8?B?cXdpMDFkekM3UkFkcGJsK3BXMDZYNXAwVSsvSHp2V09UNk1DS2F0Z0tLLzRO?=
 =?utf-8?B?NVM4NWVGSmRQSWd2cklmWWxjVFNnc1psdmNpS1JjTERZMkN4UFY1alJVdDdH?=
 =?utf-8?B?SEpzUVk5V0dWTkpuUFVUdzl1cHNvMXgwU3NnL1UrOWN4VFBqUGJVMmRZNzdj?=
 =?utf-8?B?U29Hdk5sUlhYYjFEenpvd0NacklDcUVRSy9JTTRJM3hidUpST3IwWlkrVmNw?=
 =?utf-8?B?ZlZNTm5pV0dyV1pSTVIxRXpuNjc4ZTVzY0dKR0FLWjJGMTdYem5nY0ptV0NB?=
 =?utf-8?B?bXUxOEFaNWZ1RGZ3NkhMT3YwQ3FTaGhCR2RJY3JiRnZiMU4xLzJqWUpMSHE0?=
 =?utf-8?B?NjBzdDJGUnpRTDF3dFc0T092WnRkNnpoZnlXRE1PemNOdmN0ZTJNbmczTmo5?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d010062-81a4-49c5-1d55-08ddcb9041dd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:31:00.0188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Em/RvJGRF1KAUmGynF0BAt8yqr03z8BPbvd1Dr42gkyrFgk8GTK/h8UClmSBNb+skr9Bis7p+lutdiWA1z5G3qcj5ZuXG9IxuWbAM7dOU34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927
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

Hi Tom,

On 7/25/25 5:18 PM, Tom Rini wrote:
> On more recent versions of setuptools the warning about not being able
> to find the files specified in license_files has re-appeared. This is
> because as best I can tell, it can't and won't look in $(srctree) but
> rather only subdirectories of scripts/dtc/pylibfdt. Since we already
> provide both SPDX tags and a license field with the SPDX contents, let
> us just drop license_files as it's not mandatory.
> 

IANAL but I believe we need to ship the file, that's part of the license 
requirements for both GPL-2.0-or-later and BSD-2-Clause.

Can you try with a relative path, like ../../../ in front of Licenses?

If not enough, it's possible it's because it cannot read in parent 
directories? What if we have a symlink, does it copy the symlink or the 
target of the symlink?

Reading 
https://setuptools.pypa.io/en/latest/userguide/miscellaneous.html, the 
license_files should then be automatically included in the sdist 
tarball, so the presence of the files in it shouldn't be an issue here.

Cheers,
Quentin
