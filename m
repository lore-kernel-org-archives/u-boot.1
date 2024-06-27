Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964F6C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2C588582;
	Thu, 27 Jun 2024 13:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YneRDSmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771A28858C; Thu, 27 Jun 2024 13:36:37 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A548857C
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwmNCucDt0YfaG4/HjO9ovmoefTRAYNK3toA7+q1Ktk/bYI8An8ofAxHuNlajlZb/jSnxVA5g6ttOOLYPNZfsw570LzE013eHIOmTjH2Qbd8vGzonhcCnBynfzrxQiQwhgxxuKfE7YNxFMdwIdNFW5k11NExgBML1ae+yiX6fkavxFCChdL2R2on/bNjyWnOpcL8T24s/Bl9HzVVluXhGV5CrG0y8d/msdb09TozKomxJn0sahzkl/oxXu5AVJNysI8tM+d+PBmh7XoLVVQ56b21Zq1imzYZzJdbFk2TtmFaZarFQ+DezMinclPlgMqf2x+Va020DUNXkPJCIvQf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtZipUdGin8y5R+ZdrbmOgnO5APxWnpVzGgyVY7LJJA=;
 b=nW44LTeadEgUqNYZ8F36nhO3LgI4c6clhqyNxDK+8RYpw+rGyofg3pa2O5AXgRjQWvOGj8ZTPUhpnDImWj1iWiU8shNmid8BkbxzNGExmjNNx055rCTn4x1oJZo1BzIlmRi7XA56BLLafgTDQuO02x0z4CbheOeqJMNZA+kd5eodhcfpBWSmBXshVCmSgtwz+XJfexj3I+YdbSaxwilxEBJc78EfBoUtBHa35Uxf8BNilpBhM8qMKn/xGGfTeoo+bV8+Sf08TyaX6H2Hz6zGg0j8gex548Ej2V/oeFTWo14nd6U5CKTX+Vqmi5tevTsqaiXxJeJdAzfIpik9foP3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtZipUdGin8y5R+ZdrbmOgnO5APxWnpVzGgyVY7LJJA=;
 b=YneRDSmbCo8Mz5/jGoNXweCBhc50YstOkL5fB2//SnQLtI7Cp9TmZwCWmcftyjNUKzXQxrRAGJRY6lqKM8ABWHX2mR+R5WF+n6TzqEkaZvwIsPgLKXewKHN8RvAnvjjpo9y2wmtfdgt0R8/AI60vWOapVVdNEvkuatXdcS4ncPgUsXGI69jjMENm1B2OBIoxu125RyzTcpDb87Skgs2dqJ+u6Nvz5SL6GRvU+O68wkVQonayjHf0WSk0yQhYF3c7Dqx9p4w3I/N2UQyAuDekt0Kf4gni3JhpHrZYSKd2pdlez8jK4+UPvX0HUOgrVT1yk8k0HQR/ZS+D1C8NAdsaBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 11:36:31 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::fcc2:409f:fdbb:186c]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::fcc2:409f:fdbb:186c%5]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 11:36:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Jun 2024 13:36:27 +0200
Message-Id: <D2AROWD3G731.1MMULONQ6YK97@nvidia.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/1] include: configs: tegra-common-post: make usb
 first boot target
From: "Thierry Reding" <treding@nvidia.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Tom Rini"
 <trini@konsulko.com>, =?utf-8?q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>
X-Mailer: aerc 0.17.0-167-g7c5a1afbda60-dirty
References: <20240618120030.41502-1-clamor95@gmail.com>
 <20240618120030.41502-2-clamor95@gmail.com>
 <D2351R7O6BQT.1TQPPLXS6F5AL@nvidia.com>
 <634429E0-0747-400D-8457-2BA066B18FE4@gmail.com>
 <CAPVz0n088T_EiPLcTRdZtDzYh078pU8+wgiuM1yLzm5x5kBbcA@mail.gmail.com>
In-Reply-To: <CAPVz0n088T_EiPLcTRdZtDzYh078pU8+wgiuM1yLzm5x5kBbcA@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 31febe76-a0f6-48da-419b-08dc969d63ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlZKZjFLUmh0Y2ljYk9waFp0WldaR0VqeFNWeWZLTGVsTUlFaDM0L1V4SmYy?=
 =?utf-8?B?N3hhV2RhQUNhVGszR0dPNWJ5aVVWdUkxcWpRNm92WVVQWW9JTGNGNmY1Y3dR?=
 =?utf-8?B?U0VuTVFzclpQdTlUQXRIc0p6M041YVFwNTNWRlNoY2pubHpsYmxWMm50S3RG?=
 =?utf-8?B?ay82cHFYMnBnZ1lYVjdrNThBQ3h6aWxteXV3NEtrNGxWSjVNTkdYRnBEck1F?=
 =?utf-8?B?NDhRemFFbzkxTXp1V3hZUWVOUThqRG5aTGF2R3JBTHlWczk1dVBNTEdqL1I5?=
 =?utf-8?B?QmVhUzhqenZTZ1pna1oyc1dUdkxuYzhoMVhSK0V5YnFQdFlBdnBrS1NNeWpu?=
 =?utf-8?B?d1ZmK2xKU0FhYTY0Qzhxc3FDL1FHMFhhTEozYjBqdDNodVcwVG5BTG1LcDNG?=
 =?utf-8?B?dnVaSFkzR0g4T2d1Lzc3RGV2eURHQ09vN2V2dVd3NFRaSWxIdC9TeUtsck1u?=
 =?utf-8?B?NFFRUU9tbGpwdzZEb3g1NEd2ZWlMcW8wUUlCcFF2YmFkd2ZtaHNsZWRvVGY4?=
 =?utf-8?B?alFod1JaYUxzVlZzMkRGL0pQUDdVVVYwR01RdUUxeWlhMkY2ZE9yREliNFpu?=
 =?utf-8?B?MVVsY3lQcVRNcit6dSsxeTVuYVg1dFNkc2JVdFNWcS9PUmZ2TEpXTlYwL1BM?=
 =?utf-8?B?MXh5SEl1WkgzT3QxcVhsRk82QUVUbzRJeTZNYmRvK3VyS1VyOTYyV2ZvT2V6?=
 =?utf-8?B?blNrRWRPdGs5SXNKOGYwSzgzaHJFdGRGbWdmNXJyVEY2U0w0TWRaSEkza0tm?=
 =?utf-8?B?M3cyVjhweWF0TXBuY0pBUXdhWVpIcW50VnBEc2FnNkFLclJCWXJUY0lZU1hw?=
 =?utf-8?B?NXRUb2M1cXJRdENqWWI0MVpZR05TZkVuSHlDaXFCVDdhblVPRjkzMWc0NGw0?=
 =?utf-8?B?cXRBZjFKaTFaMjVWTU9EUjRvL0dDa0FQOGhZZXhFWmJ3UWlOV2FVaVNvMktY?=
 =?utf-8?B?ZGd4VDNiOSsyNk9JWXI3ZFhnYTRsOXZ1dndkOE9xRjBvWk03L0NwVndTa0NU?=
 =?utf-8?B?QzRUUVhGN3RXaXRoZlVqWVgvRklFQ1NVcjRlcDE0V2hzNVBQQmRpTUpYS1NB?=
 =?utf-8?B?SGhnZVFnc1lJYitUQWZ0dzluU3BQNjJ6cmhDQ1VkdlVzQUFMUzZyN2pkVFFS?=
 =?utf-8?B?MjBkU0xzZDlLSDkxWG1HMkwvS0VnUnhSOXV6Z0U1RHZBUm1TdWFTa0NzZ2dl?=
 =?utf-8?B?WHVoRzR3clFmRS9DcjVTT2VqRlkrWEVBQ2trT0xBU2RrOFBUd3ZJZnRCYVZx?=
 =?utf-8?B?dUpPRFFiUGNFQnJBRkRFeW9rS3EwZldja2tzd0FiRWdNU0tEVWNqM254RVg3?=
 =?utf-8?B?bmlUQ1dYQ3Rtbms0RWxXNGVXVEFKZ1JheGs0L2dmQzZmN29HaDhYVTBna0da?=
 =?utf-8?B?Q01GYnpQc3liWVFlZklKdDNFUnBkWHdwQUhoUHQzWks2czA4dmgwOExRV0FO?=
 =?utf-8?B?MlpHMGN6VEVzR0Z4YUp1eW9vdUJYQzdDM1FTam9FN1FDWFJ6UlNQcmJLRUVs?=
 =?utf-8?B?d0tDMGFlbWlRRTVnNUtnN1NYNEdhTytzbkZxdlFGa0NVdmxDR2d4bGRQcWhh?=
 =?utf-8?B?dGJRVUY5UjNKQ2I1LzR3bGVtbDBIYTl0UzJiR2lERk95MERLWi9jVXdiYnFl?=
 =?utf-8?B?bXVrUXdwOXVLSXFDVlNQZjcyNmZNaXRQcTRMZlJDdDBSWHlDcjA0UGpNYURM?=
 =?utf-8?B?bzdnakQ2T3pwQ1RWeC9VQmtLZTBueDA2R3RaaDcvWThNbEZHdjVpK3VkWUsr?=
 =?utf-8?B?ejNyMkVEaVB5VUE3VGgwZVF1c1RiT2pkSmNZOU1CdVZJTUdDVnNla09lZFdl?=
 =?utf-8?B?dWFTMjQwRlBjRG5OOGFoQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWpwbmlOVjZacUpGTzVaL1ExSFpKVEdxUE5YbndxK2dOR0k4STNUWFJiUm5B?=
 =?utf-8?B?dmo0MEhJOGMyeTVIbmFTZURYSXlvUXhlbzVlRnJKQlBtUnkyaGJIR0piZTlm?=
 =?utf-8?B?SEhOQTZqakt5MkUzSnRNUG5JZmphN2x2bURHTkFvTE9lUUYzcitwUDdpL1ky?=
 =?utf-8?B?cDRKVUR3dFduclFKcGJxUWxmcnRlRmt1WE5lNVUwSXNVVkhIRGEzM05TMnZO?=
 =?utf-8?B?WFdNaXRIZjlJQzlMbGhxalBGWDQ3amt2MVkrQjNyS2gzSzZwbUFkandzTlRI?=
 =?utf-8?B?WGt1ekE5K3U0T2hwakZLQ1I4NzRXdVlPTEdUcFZZdFFWaU0zcFozVFFIMnF5?=
 =?utf-8?B?YUd6UUNTd1NTWHJvUnNYaDFzUUFvS3Yyd2lLeHB5aENPSzQ4dG9LTFNFeEda?=
 =?utf-8?B?bU9kMXBob1MyRmlSN3dJWklEVHFMN0JHaFE0cjF2YUhsZVZKbWxiZnVlOWd4?=
 =?utf-8?B?ZkFCOS96R1J2ejJpUmkvSUIvdTNndFBqZnh0VFZ6TmZnQ0dQeWNHeG1HY2xK?=
 =?utf-8?B?M1BnRXN2Qjhpb3I5Y3BucmwvWFNSa2Noa0xmQ28vc0huYUJXV0huMFhTblhJ?=
 =?utf-8?B?MElvV0sweHltZFNkWVVVSnNaeTdmRTNuYTBtZElkZ1FzM2xKRHdTNlVPVGgx?=
 =?utf-8?B?UGE0bzhOR28xZFFpUjVuQVZ6TEdxT2JZbnF1WGVDOXd3N1Q3enpNaTFFSTI0?=
 =?utf-8?B?RXhYQ3Q3c3hNU09PcFZYSTVRNjJ2TjVKQ3hPdGxKZEpIaHBpbU9hTGNVaXY3?=
 =?utf-8?B?blp3T0JxcFJ3U2laamNSeDlRRkxyNjlINldtcTRFbWN6WWJPaUJ2RVJsTmtr?=
 =?utf-8?B?cmtUVDNYcERBZkQ4bEUwN1JXMEQ5dFR0SlVuRFp5MEY3bTRISEJPNmJReXA4?=
 =?utf-8?B?b055d0w2Y0YxZUpMZXp3V0ZlYnREdjJXbW1QNk1SeVpMK2M4alZXYVgyM3Nu?=
 =?utf-8?B?L1lSQWM0c0RCM25qUWdibEFlTzZ3ZlpiVlRtbG9PUXVlVWR5bXd3UnFxR3Q0?=
 =?utf-8?B?NzBtY2NCcWJ0RlFjbisxR2NZZFhObDlFdmUwdFFuWDFwVmthaEVXQVVRYTY4?=
 =?utf-8?B?dUR2dGNudklCcGVsZmdmRDNPNThyMXlrakhUZGhnMDlRczdRYVR1N2lhZFJi?=
 =?utf-8?B?RFJlM04xVmhQRjJVM2VIZ0RxU0FwUVNYNFJhaXhQWU5DYkVkVWhUcTVhOVEw?=
 =?utf-8?B?TDg0V0VQdkVkNTRzeTY2ZTl3ZEJzcGdEeUxWYVIySFhrZnQvR1N5TmZGVUMw?=
 =?utf-8?B?Q2RkOU1MTUI1Qm9BdHI0K0dTRVlpMHd4VDhjdlBYeGd4ZCtPQmF1ZXJ3YW1j?=
 =?utf-8?B?M2VReit0VUFDdE9IQm9PLzJRcHlGMzhxZHdvbmUvb3pIamZLREZmZFNjc3RT?=
 =?utf-8?B?Zkw3bjRLaTUvNDNzQmdMWFdzZkdieVplSU9YOWE5N3F6eHZxQjRFeUk3cVdT?=
 =?utf-8?B?S1BkVzlmKytKWEk5aGdQb0FrbHBZUmFoeUVJYWpkalFxUmJWZEcwTWdiTkZR?=
 =?utf-8?B?WUtRVi92SXZIamZjT1ZJeXppWVhpeDkwTFJ1NWVlZDUxeDkyeTg3cTY0UG9N?=
 =?utf-8?B?TzFXVW9GSlBIOCsrNVYyQWpLM0ZTN3JFeFE1bTFoSnY5bUg3Z0NJSlV0TFho?=
 =?utf-8?B?YzY0UXlMSU1EbHpkakhoNXZHSThhSXdNYlFIT2Jac1VUbXUxM1pQN3hwR3hl?=
 =?utf-8?B?MC9tSlJnODJSWDZTellBdlFidnFxOUN2bk5vdkQzOGJnVXBGMVlLNTZjWUNl?=
 =?utf-8?B?TW1MbkI5ZWhaMjVvMlo0YXA3RElJT1ZCS2pPTjY5WHVyYkdoTnpKTW5GVlZS?=
 =?utf-8?B?MUhaQXhqR0Rpbmw2ZVVhd1MreDdISFkvVzM1aFdMd2lXUUNiOEFHTFA5blFh?=
 =?utf-8?B?T3JJZjRKY2gxYWFpek9xQkFTUllsWXdXRitXdkQ3SlA4bEt6M2JCT2xFRVIz?=
 =?utf-8?B?aUQ3d2lDSUdoQTdDN3diZTkyeE13RjVVUU9SUm95anM0aDRMS0UrT29SenN4?=
 =?utf-8?B?cWhDZlBOQ21CRE5zWWlOenFNNHNHTFNoc3VQODhVV0lKUU9ZMXQ3Y3VzbXlx?=
 =?utf-8?B?ZHJTV2NiQjd0ZzZxOFYxQW9uUlhYV3NMYXplYVprek44bkJhc2VCOFg2UXY5?=
 =?utf-8?B?YUh6K09xOGxPbTc0NEU3NThsVVFrTHFHNFhtbDE3bDhxeHNyb2FwUjRFUGpB?=
 =?utf-8?Q?Tcx7usIya8YhN+XuN20Wm3VK9xCbLclhFd2qbZ08jUZo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31febe76-a0f6-48da-419b-08dc969d63ed
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:36:31.1772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDHmDB7wQ3PCpEbyAuO2gBlfnwZYFtPf5CK/0q9t9RBh5syFXwnMxXEX9jKaDkc5R2ap3jGCBtzADCEH18dISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

On Thu Jun 27, 2024 at 12:27 PM CEST, Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 18 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE 17=
:16 Svyatoslav <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> >
> >
> > 18 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 15:23:09 G=
MT+03:00, Thierry Reding <treding@nvidia.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> > >On Tue Jun 18, 2024 at 2:00 PM CEST, Svyatoslav Ryhel wrote:
> > >> This ensures that the device can boot from a USB device prior to MMC=
. Useful
> > >> cases are when installing a new OS from USB while MMC still has a wo=
rking OS
> > >> configuration or if the OS configuration is broken in late boot stag=
es
> > >> (kernel boots but the system does not start).
> > >>
> > >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > >> ---
> > >>  include/configs/tegra-common-post.h | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >What's the implication of this if no USB mass storage device is found?
> > >How does this behave when USB cannot be read or booting from it doesn'=
t
> > >work?
> > >
> > >I vaguely recall that boot order doesn't always proceed, though
> > >admittedly I haven't tested all of these edge-cases in a long time.
> > >
> > >Thierry
> >
> > If no USB mass storage is found bootflow will continue with the next
> > device in the list (mmc1) with co-responding info that booting from
> > usb failed. I have tested this on lg p895 which has only mmc0 and
> > with asus transformers which have usb, mmc0 and mmc1 in all
> > possible configurations. I did not have booting issues whatsoever.
> > ATM, transformers use boot order which I have proposed in this
> > commit.
> >
> > Best regards,
> > Svyatoslav R.
>
> Thierry,
>
> Since you have not responded to my statement above I assume that
> you are fine with applying this change. In case you have any
> objections please answer as soon as you can since I am planning to
> include it into merge request for the next merge window.

Sorry, I had meant to reply to this. I have no objections if this was
properly tested and there's a reasonable fallback that works.

Thierry
