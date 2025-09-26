Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13041CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED8483930;
	Fri, 26 Sep 2025 18:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mftSGELd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236DC83666; Fri, 26 Sep 2025 16:54:50 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3357835B9
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMmKB1gWrI39+ESrZh8Zr3FQCFJwliqqV5ZcS94hHQqlTZR6FdfZYGj2PeK9Y/9D4bdEU1TiWcRjhL+V1V5pwPtNmy0+RGjPjd/F09HB9c+9inW5H8vvkPgwU2/uuDyM0W/VApv5yV940iRfYVryN0Z2g+APrNRWgLU1w/8kul3evc9kNFw+sPCbBNGTL1hgTBQoP2K0syCI7FFY54OVYClkZSWktyoM1ayZPGmGqNHTJY1V9YNB9G3RNO+6v5Xp9KviFS/r6N5OL8RWQlFZT8+E33WxEgBp7qPftIBT1Scv1QQST//aAq5co+Ny8x6WCTK3w71l4EVNakXDhhffmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1hDIugsW5EfTKi4pmrM0/zgkwOR2ApkkNlO6DVBXZY=;
 b=fd72qWoLNp6o1aREheI9EZgk8SxT1trmOL8yrvO9XW9CaOrpDwbO5HBhbxN/AYAOsrsvjJdZYk+zl76Whn7uCmZVusC0pgYnE4QgQ1KEmkMoCaLjYE4HsZdx3pGbEY1cln0HxNkQMk24vxLcE2Ch53GdWQJKGGc9qPjJ5Mc7PXimNPdPJGEV31kQOB8n7lMI9HbukoI6PjBx+6X5WRUO0UCsPmUHUPzgBP0Y+ZLHQRvVi5bVIfLIo1z4sN99s8O+JPGHGj7+0bSKG+rIBZcmq+ydW0KCojF3ScFa9bCOR2g7Sy3DplKspEgDcIO16JPqIz61326eUEf2au5foLLmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1hDIugsW5EfTKi4pmrM0/zgkwOR2ApkkNlO6DVBXZY=;
 b=mftSGELdSuKKO16u4LZcf0DptpSJ3AoPImiV5LpIYmsft21mJq6NntblGjahkQiWWM5294mtXjDiPbB94CG/XB5hJc6LlP2RRvbdQlDKJKh+WePvibo6sEfBhAu70bidmNGpNTniOXkCKVXTO0cymGOIcfQCmZAFDhc8pbZHz+D1YPddPWA0D2WDXKEOt75nJD+g6X0pAdmpxJfGEOLtkjNZdleVNzSyJxTGdAJ1oMgUY/cjb6NqK0R9JGMh394gQrjhkjxaxAkMwYb2ZaF30rulzxN8i3CN+noZ+X+qeALAgz+oomTy6nltbQP3jIcpiMkowLq7RQuN5Zv74I66Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11845.eurprd04.prod.outlook.com (2603:10a6:10:621::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 14:54:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:22 +0800
Subject: [PATCH 09/10] cmd: scmi: Add pin control protocol name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-9-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB11845:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c235fd-5165-4ab2-52da-08ddfd0ca1a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGNHeDFTdTRRVEVyRWRiSVJaZXF4b3U1eFVObEdjWUZzRzlkSE53RVhKTFdW?=
 =?utf-8?B?ZDFxeE5sUk55UFhvcjI3MklrT0MrS0E3SlA2QjlwWkcwL0VyL21aSFk1Mkdh?=
 =?utf-8?B?aTd3TkJ0c0daK0hFemFFbEgrOVF1V2NNQ3JPc3I0Z0xjSmtjRHRVMERtdFNT?=
 =?utf-8?B?WXVTaWkrVVh3RjVSbXNUOW9oY0FuWmcvS2N6WnJzM2pWWHRNVkNBZ3pHcElS?=
 =?utf-8?B?KzZzc2NiaHRydklhbUpWOTZDSDFJeEVMd0Z5T2ZiUVdCdG1tbDlaMDg3TW1a?=
 =?utf-8?B?Sk5USkFRNXVFTEwvVW45eEh6MVNOVDNzNXQ3WkZlS1VLK1pUNWNjUnpPRS96?=
 =?utf-8?B?djc1K1U4TnVVdTNwdHhkOGFJZi9Rd0JvSk85V1FMSnB6V1JnVzVBT1FCMXVy?=
 =?utf-8?B?bXBkMGY2UGIxTlF2WTFQcjNHajdPTXdZK1ZEclVQd1RBaGpUNk5LZVRHQ0o3?=
 =?utf-8?B?WkpGcS9vRitGQzNGZEkzY2wxVnNlM1lJZkpYVklON0h4SEZZUmsrZXN3a3Zi?=
 =?utf-8?B?cVJjcC8xM3h5cjQyT3ZqZUxMbWJjQ2R1UTJIMnhkc3RHazZxaE90UldoQkNG?=
 =?utf-8?B?cmI1aGZxdmF5ZmdEdXlWaXBzTFVacjdWWVZrUGlvQ3RsZWhxTFkrbnVMejBV?=
 =?utf-8?B?aUdBenRGc1JQL1RUVWsxc0ZITEpFdmpKU3NkdTNhT3B4SXRRVTh3Y2p3T2VU?=
 =?utf-8?B?RktsTWtiWkJMWUFLRXBac1RJbHJTd1BuMkVncnhmdmQ0Szc1WXFVVkpBODE5?=
 =?utf-8?B?MWJrVFMvSnJaemYvUDU1bkNhVXdUMDBXNXlpNTlDVC84Y0Y1NUxWN2NQZlcv?=
 =?utf-8?B?TGNKZHk5VkVlWDdwb2phQ29yOFhvSThwb3RsaXd3TmlMSGpNU0FCQjFiODhm?=
 =?utf-8?B?R2s3RGhhTEgyem9GaXNpZFFsVWJWb3BGNXVieHV3Qy9NYjhvL1dMTVVkRGNh?=
 =?utf-8?B?ZHpQYTUxNGxBeXAwMU53YWdBaGhYdHR0dkFJeDE3QVlwZjFhN0JjTU5vRTJP?=
 =?utf-8?B?MVpINTBMU3BDcnhieXorZXRReTZ0WmlEQWQyYmlTYWJQdy8wNzhzYmlSQXRV?=
 =?utf-8?B?TVFaR25OWmJEWEZiMWhBZTFJSWtBbCs4azVUR2txTXVOUEc4V2w1Sk1WdW5N?=
 =?utf-8?B?d3FlcVExTWN6eTFOamVRaEhvdGsyVFZtMjB2TDg1VkVINHZWTWc2cUhGL3Rm?=
 =?utf-8?B?NWdtbmZ5ZlJJK2x3cFRuaU5tbzRZN0lhLytSenUxNEQyOG9ENWhHdjZnVDFG?=
 =?utf-8?B?bll5eW1HektqQ2hLSFFSWVQ1citmY2hqQjNkZHJwSzh1STJOZ1ZTVnV4SjVt?=
 =?utf-8?B?Nm9KLzMrWW1NT005WkZEdlBUREdZVTBwQ0VkV2hDZDRkWHgyc2ZMS0lLZmpm?=
 =?utf-8?B?Y2RmMTdFYmUrTUVmLzNsdWJQUmN5b09sY3dLS0NWNTRycmdWRDQ5Vi80d240?=
 =?utf-8?B?U3NkWGJ3Q0F4L3RSSzV1UWZ2NEF3cktXWFUxQmk0QnRwbTVEejZ6allpMHBE?=
 =?utf-8?B?S1VQa0M0WUtrT3VZQTFtZ0tZQ1pveUlUZjJhRXlBVmpNQWJ0NTFETnVVUWdF?=
 =?utf-8?B?YmQwblBKMm1rd1lZc1N5ZU1JYmErR3IzTDl2UFRRdjZnUndHVVBJQ3ZScldO?=
 =?utf-8?B?OEJPMTVGNi9FVnRFU044djlEYjVkTVpGMFI1aUEwUG1aN0dHamJPSGhmczB5?=
 =?utf-8?B?TXA2cjBlMHRrZGY3RGJwVU56OCtET1ArS3JUVVdlb1NQUlQrRTJ2eUM4bHZ6?=
 =?utf-8?B?cHBJNWRudVkycDlIbEh5Z2ttQnNtYVR5b0tGM1hKVlYzWkIyUTAvM2RRMWlK?=
 =?utf-8?B?SjIwQml2SGVkd0hydzFMbURSSW1uQld4TnhReHJtZkxYb3lWNUJ4eStHSjg3?=
 =?utf-8?B?MGlFUzdUWnZSZEJUUlVWL1JJWDNTdyszamtsMWRXdVlBTDNRRjUxK1pXNGhK?=
 =?utf-8?B?MWsrSHA2M0J1WlJWVDJERURLUmZMTVRDbHVDeklobVB5UVBuL0Y5dmZZM3FE?=
 =?utf-8?B?VHRsRkxrS3dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hKVmNkVHMyWGZRTjdzZ05oRWVwRTAxK0RFNTdOaHFDZmlMKzdWK1hwTjBx?=
 =?utf-8?B?T1BHNmhLT2VsV0l6WklqMW1tK2NoK1VIeTM0TnhOTWRhQjQyU0xvNU1FT1Bj?=
 =?utf-8?B?cGRNSnJ6dkhzUjRGSUh2YW91cnZwaFFzT3UreVVURTZIdHByeHkvTnBUV1Vx?=
 =?utf-8?B?YWhlTkg0VGFydU9kSVEyOXBteVdhbFJkREhwSlZGUVNLSXdTQWhtK0JQRDRa?=
 =?utf-8?B?OHNCRW1ybWVERDRWWnJ3MjFNRTZ6bTVDZWVoY25GZ2FhRFBIWVBQMGtDMVUv?=
 =?utf-8?B?bXdob0tNMDNEOW9GaW9hN1FXcWV1Zldyb0p5NCtVNzhJYUxDbEI0WnRBeHhU?=
 =?utf-8?B?TCtKeThoUHlCRmNlajNVVjMwR0g2dzBaUlFzbU8xeTV2Ui9SN2ltMEFVQ1cy?=
 =?utf-8?B?eWJKS0l6d3NqT2lTSStyT0haN1dxY3dlRTErWG5oNllPSmIwOW9pQVVSMlAy?=
 =?utf-8?B?bk1rNXFyTWd1Qk83dEF2L2ZHZUxnTlg1ZGxjY3lvenhYWVJpbWZhUXpnWUtm?=
 =?utf-8?B?Ny85NFpibnZTUXRvV2ZUay9ReXlyTGtOR1RJelhXRENncW5jOEdDcll4L2Va?=
 =?utf-8?B?MnNCc001UzBDRW1pSjEvY0tiazIvNkVZZFZWV2FjUFllNHhBZzRsaFppZ0Jv?=
 =?utf-8?B?cDY5SXhWQnNMQWFxYzRmdHVYNUVOMTdIb2RxWndZK3BYVjZrYzVzS3Q0Ni9l?=
 =?utf-8?B?OU8xL0J0NWVvbU96M2NFTlc2eVNGODdnR1lZK3kzZDdOU0ZLL2o5T3lKRWNr?=
 =?utf-8?B?b0FydngySmRnQ2NzaWsxamltVTVmQkgxU0Z1T2RWQXFyb0FVNVltNmtrQ0tC?=
 =?utf-8?B?SjFMQVUyaE9veHZ1U3NtQVZ5YlNiVHRDQXF5Q0tnRXFKOEl2SVdYZlNXV1FE?=
 =?utf-8?B?VEt1RFVWREgyVks3eE1MWDY5cm41NkJzZVM2ZDJnRTB4NUJDNTVBaHFqUmNP?=
 =?utf-8?B?QkprMStGRURudjFueW4yUEo2bnE3YmpDSzNyYzVHRVJqVXB1ZlhGVytzUUk3?=
 =?utf-8?B?d095Y1VYc25wL3RWV3VocGRiUC9qYk5vSk50b0pEWStBckR0TUJZbjNzQ25z?=
 =?utf-8?B?dXpDUXNkOE5EMFEvL1pXQUR6RXlTZkx3WjR0TE1EM3Nld3kzM3cwQzIzWHpG?=
 =?utf-8?B?RW9qTjUyc25DV0ExcTRUQnRHYjZFVmVRNWVaZ3RtakxUR1d3TnVNd0dpNHAw?=
 =?utf-8?B?RUJvWVh0aG1mQUJ3ODJMMXBJanlaL2ZEcDBxVXFBM0NNL2tVN2NNRWkxdFFY?=
 =?utf-8?B?N2V1Rm5zMndWZEhtR2tvK0hsRkVkK1ZISkZYZmFteDkzOTR3OUt2ZUVMb1ps?=
 =?utf-8?B?UzJIYTV1Y0gwams0THN3b1lhVzZxc2dTa2lQbHVoS1VmcndMekZDc0cwQlFN?=
 =?utf-8?B?MU5pVUNjRWV2OGtCaXNWYjFzMlpqMWdEQk0wcEgwc3hSMGRDQUhDNWNvbEZ0?=
 =?utf-8?B?OC9IcEJVMGQ4dE1iN2FZQkpkUmhrcXVjdmg1Ukt0TkpMcXQyQlpvMEV6WlBC?=
 =?utf-8?B?SWZyRU54UzRNc1J2M1hpNVJJR2hZR2hMQktyU2hudC8wcHlFYzJza0sxMnpw?=
 =?utf-8?B?blRrbXVNLzc3TDh6SjhlZmVsYVRlYmlndkxwR1dCcEtnSmloZFZUbHlzSkhI?=
 =?utf-8?B?UXBNYTBhelpTOTZNT09DZFZ5bVpEUlhrNXR5UHU3RzM0OHBTY0hQTkpLUTRS?=
 =?utf-8?B?dXlGZk9XeTRwN01WRTI1Zm92Q2lIZy9sWTc1OGI1bHkyTitVZ1kraktxNXZK?=
 =?utf-8?B?L3RZYjFHM1dJTCtTSXBxYkFMMGYwSlV6MDZqYldyMVBzSnJ5dXdSZXRiMWZL?=
 =?utf-8?B?QU83c2ZrekFhQjYzSGlEcEx6U1ZnNlhNakJTaXNJaG5qK04xUG54Unp3djJm?=
 =?utf-8?B?QzR1SjdYeVQ0NGFlb1BzVFNadDZMQUZabkVrVHFZZXZEQ1dIMVpwTzJvZmZR?=
 =?utf-8?B?MTY5a0E2M3NtTDFUN1d6eDNRZTRVam9VYUx4OUhnZm4yazJhMjNBMnVITHZs?=
 =?utf-8?B?SkozYldSQnJTMWpHZ1JFRHZQQkZtUEVnZXFhNFVkaUtOZWQ0QzNOTXR3d0Vj?=
 =?utf-8?B?TGJwR1JQcFhmN1Y5S09aUG9iNDRpckhhYUpTUWJCWkxRdmJjRFk0MFMySXl6?=
 =?utf-8?Q?o9AG97XRJ7ycT3HXp3B3bwPyc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c235fd-5165-4ab2-52da-08ddfd0ca1a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:45.1108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/Jy2y7U86ELLwQsaeNpeWRPb+HTmPoX/ajVGzzRkuF4n6M97fKq4PefbMkA7k4nVoFXeaDU90rcARlRZoqH0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11845
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

From: Peng Fan <peng.fan@nxp.com>

Pin control protocol name was not added into 'protocol_name' array,
however Pin control was supported on i.MX95. So add it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 cmd/scmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/scmi.c b/cmd/scmi.c
index cfbca63e1644e387dd80e1a445301eff39ec68b5..d0498b816aaa9c3eb4d431aef5e919f910e035e6 100644
--- a/cmd/scmi.c
+++ b/cmd/scmi.c
@@ -29,6 +29,7 @@ struct {
 	{SCMI_PROTOCOL_ID_SENSOR, "Sensor management"},
 	{SCMI_PROTOCOL_ID_RESET_DOMAIN, "Reset domain management"},
 	{SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN, "Voltage domain management"},
+	{SCMI_PROTOCOL_ID_PINCTRL, "Pin control management"},
 };
 
 /**

-- 
2.35.3

