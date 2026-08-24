Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50956C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF89E60632;
	Mon, 24 Aug 2026 07:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coD8-CKONZMB; Mon, 24 Aug 2026 07:38:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787557129;
	bh=IY0M/MqNKVGacg4jXX5GUUPW0oWdrymlDqj90nJR7DM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gfz6W50VAzRDdgcbqhugiYjmOQAnIiyirzXnxl/kl65d7M8jl/S3tSv9gqClmKZw8
	 nXBV9a4aMyhxSkB5LvLJTwBnWtLx11ksLYxQsXGkvvoJGAMj4Mt2Fb9ZDJt9yIH5VX
	 ya1QWBBg0RAa2KxFZIAVh0T3S4poc5mP7t67hf95HdKyawYcf3PNq6zo0ruAs4vTIT
	 BVdQHMhnU2IMMg4646qjYvWLwvVoUQOgG6PYr5Ymtpaimhyf+czPSxibgXMcJ2BKEm
	 0DUffp3WPY/naeYxf0VembGFI7S8pNbV72A+yHxyW+S5UHi3tQwZUiYHgA8bjeden6
	 TR9G2Dl+ew0iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9129F605F5;
	Mon, 24 Aug 2026 07:38:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80D733AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72C3C400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JT88FnOLvkEW for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:38:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vtlB5fXR
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 588724005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdeudloaYbuyG2a8UPl4LHHNHiEJHebSK+5rPrLigyp1KsGDTpUXdn/m97/ML/4ZdWfuduFv24msNr4051NzbWO4sChGEJn2ypAxQ+QUur7hMisAQsUjO0Ve5jE8AsLvCi/6fIWf5EIgcvV2PjQw5Nlk9cqaOqCl0px77fLw5Sdm5s7P1pmiJqQjSb4D/4VfnUwxC/edTXF6TxB4k4uREDVL2Vc7tspgIWL8Gx0lNiyx+opJb+VdRlpOQ8jGCuC8VwtFzPL5mZl62M5oDJR9grlM/iBcjVHFrwmvJ+83fn454S/o9uYMWLsLu6zxZ6XDrbJP6RA/mVe155XanwZqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY0M/MqNKVGacg4jXX5GUUPW0oWdrymlDqj90nJR7DM=;
 b=SaC+au8s9tRtIH8J/0NKSgeL6+syVVgktvJGiv6Q+pt9fRY6/GW0l7kmtrAM2wbKa24ANCHa5qXjr1x6Z+e+dvpIB/Br9two5D09PzofNuaLIrPiQ/fS4FQnLejZlP/m1KKBE8COU5X4jL2Xbd7yt7Q2XwrzkJ+Lf2xi4jG0BDdJFAN74Po+hrgxnWag623h1Apvh4LreydfBTXsxBxAOlwv/b311r7um1onpXDTwMm60qKrXUpR4iyD4/6Kez71c84gEQ5qd3nByB2VuIC6400gHhpUzjKYhTy4uvK2QxXn4Qu5qGn98Zt7Lmp3On4G0hNvcQ/G6uYttsI1QZTo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY0M/MqNKVGacg4jXX5GUUPW0oWdrymlDqj90nJR7DM=;
 b=vtlB5fXRgJUUcX5+C5WN7CAzSzVDBd4f9rwMp65+0BUJO9Bk4DpIGpt8uG3Zh/NGBySpM8v3uha4UslAnA/PwTDanR1jrzSDVSPFd2TF5zYKE0QbnkRu1t6tv2IQYwJhri4I2hCP6omaGYzcWiOs6yrE4LofD9xPEOpkBWzjJII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:38:38 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 07:38:38 +0000
Message-ID: <76c794f6-379f-4ead-a687-d65a3f238df0@amd.com>
Date: Mon, 24 Aug 2026 09:38:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove unused emails
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com, marek.vasut@mailbox.org
Cc: Andre Przywara <andre.przywara@arm.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <a14a6d0d7de1afe226edd49b3f683a3cf26cc50e.1787556953.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <a14a6d0d7de1afe226edd49b3f683a3cf26cc50e.1787556953.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d4bba8-be81-48dd-e225-08df01b2b653
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rk1h1mdILgEdyQUlGWEiVuARpipCJQYoXHjFQQNIQ6w9ELUJxFoKxMNun8GMabvrxebOp1qWULBbUSROpXGmOnBKJzK1uePqKApFPVraJ4lh2RgiQFH2UFQHxdHEC72205oNqGqG3veg/egwJC+0YZJO4105UcKYLOmlZjm6OFmBtoq7tV0I2bxWA4fG+xqkdb43JEU6sqAk2eSZ46TDr8ZFm8m06ePNqdMW/x/4sDxAV/UJEaLtSIv1aWD+jucYGBATR2XihlAcy5zNoV6CdC2YZjGh5AWW42G8HQDBhi6FJn2+jGLxZfMqVJ4Vg5XbV9UIs2dDd6wfDmNru3FJ+gF0xqAVXIeSoRrXlY8eUX/NDi2YvFbo3pT0+8zReETjQ5I3mHcvEKIhE3+JEZJVt2c9SqVVrNbUfjAp6qfjAeOGSe/alEpHGgA5VJwsM+qQ5cVMQIuQ78KE8YFyKyz6wtSUCYSbHwIf77OZghRob68fuohd7MnWYLfabyoEe9VHCOE8bChCY1FQBPixooMgfkUAupeeQkeo6XCEYtFqtX4Mf0zDCGmpfVYgkOiMWahUduS8qmmcV3Q9owFbFFCx8nE2QusDICQq0jjJbr6KCUa+eSyD+1w65xys0qMqgoOOGv6k5JD4UK+WAZg/ChqFgvL5GOIe6KV4UTKRcOB3ZQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVDMzNHcEFNUjlkeFN3akh6OUhvVkwrU2dEVHNoUmdDUHBoTU1HUVBQTTFt?=
 =?utf-8?B?WklZdUc4NGlFaG9hbDBvMHlkNno0U1ZDdHRSL1BNL0M3d1k4c2ZVUnZYNEN1?=
 =?utf-8?B?anAxeTdxd3puMWlFSGpKQ3JHTjY1YmlKQUdSSUJtbllIV2N2TmF6czArRjEw?=
 =?utf-8?B?T0NTcjRxZWtrc2RwY2x4L3dndUNiOGR5VFQxMGE4eWpBT1RRSmowWWhVRmhx?=
 =?utf-8?B?TSt0OGcydVVXbFhzUHpFbDdsNUZ4YVkrdHMveFJ2bWpDQTdkUmFMdGZPMVpO?=
 =?utf-8?B?b3h2UjkyN2FQT0ltM3NPZUNQMi92YWVlVkZBS1IzZExoUDVEN21WdnVRV3ow?=
 =?utf-8?B?Yk50VHh2eU9XYXVLMXNjTGRIYnNHNjV6SERYeDRlUTRzK085cEM4YWd3TFpE?=
 =?utf-8?B?SFU5Q0wvYUoxcGxjWTdveUVrcndVclptSW5Nb3JOTHl2V2VveVdaS0YrbGxX?=
 =?utf-8?B?ZlVzMG5Qa3BBUDZMZWsybytLMXNDVlJsaEN4UGN2NFlpaUJ5a0dxTEVZTThN?=
 =?utf-8?B?bEFIdFJpdDlUUHVlVFkycjhtMDdUOVM5cTNQV1d1eTU1bG84bTRvRDMzZEEx?=
 =?utf-8?B?R2phdUxoMGoxV1VuSVNSdDJlVGlreE5xSDFYLzJOZlhKOFEzcnJhSmd6THFX?=
 =?utf-8?B?UFpqSVJqZnloT3h0RHRrQzFTa1ZWRUhkcWhONkgzOWxEV29maVdRTnRtai9h?=
 =?utf-8?B?RFhJZzhLUGVQZUp6eFAxVFhBSlArVGxpZGcxbmU5d3JBSGF1WEExVGlxRjIx?=
 =?utf-8?B?a2dTSnRWcE85U1Y4RGNSaFpKK0x6N1FKdXFhNUJ5UGVhbHEwNzRldEdVWnYr?=
 =?utf-8?B?NmFJU1FiVUViVEkwVDkvN1NwcEtRN1RZL0FzVlVlSGU0WDVvZVFhUGk4NXJj?=
 =?utf-8?B?VXhDUS9YYUhxblZueEtQSDZKZ2dHVzlYOEdGc3lyMVlrNWRaWXBScGdSeWZk?=
 =?utf-8?B?bmUwZ1lEMk83citOVHluQk9DWjJPSGhGeGdpOVp0STJONjFjV0Z4ZHhYUXQw?=
 =?utf-8?B?aFVwWG80S1pYUTR5OWdpRE5VMUlBL2YxM1VYUFhLZnRvSkxVNXlKLy9nZm04?=
 =?utf-8?B?aHZBR1lEMEZxK1EveU5VaTdpV2hBT243K1N6UkFQUUtJZW8wOFpyM1JYWllk?=
 =?utf-8?B?dlArTUFmbmFjMjFzVFVqU2hxczZkTjUwYlFIU3J2UTNWWStKMitIYVVTMU1U?=
 =?utf-8?B?c3Y0YnNPVFQxU2ZVeTVIVUN5ZTlPTkdTdHREUUZNSUFObG1FMDJIRlNxVW5H?=
 =?utf-8?B?MFJvYk1FSDBCMk1YNWdOSGFxSkpiaWxXTkk4UGxwVWhESXVSVUR1WVdkbEJv?=
 =?utf-8?B?Tnd5RG4zSzFxcWhYbTR3ZXErTE1CR1hVNTNUZGN4OThHQ2QyVWpER2VLcG81?=
 =?utf-8?B?WERPWkY1cEYxdWNjSlAzSzEvRm9FSjFMSXRGK3RZaEdOaytiWDVGQThqUld4?=
 =?utf-8?B?dEhpSDc4MEI3dm5uUC9MZ3h4a2dqKzdZM0QvZ0tYS2ZCelRoYzkyQTlEZ2lE?=
 =?utf-8?B?aUZpL0J3Ym1KZE43L05jYzlhU05RUFVHTi94NHNqeGtTano2amtQMDR5RW85?=
 =?utf-8?B?dWZZTHFYQmxQVUZEWHp0TUlSbElranZKNktSTU9EWG9yUzNmN25wZWo3Q3o2?=
 =?utf-8?B?d3JVdlRhcW1DY0dQREcyWGw0aFFhd2VERWNwaklDWXlqQmV1VzBLa3I2bG9I?=
 =?utf-8?B?RnpqU3k3bkt4WjExUDEyWHN5RTExV3VxNk9adUxFcThSYnU5QVZwb29kLzNl?=
 =?utf-8?B?bjhDVGF1OTJDWmNmQ1hIN293d1NDV3pOa2hPWTF1WGVFc0h0OEgxMG5KUFpy?=
 =?utf-8?B?MC9TMzk3SnE1UlcyRWlBV2hqMG16U29TWGtPcTVEZkJNNWJjWG0xdmw3Zkl4?=
 =?utf-8?B?QnFMaVNjKzFUYy95aFdtWFhDUXFaSG5tY0pjaG9vaG9IMTRpN1g4ZDRLcFVm?=
 =?utf-8?B?bnlmS1Nlb2NjQVc3ZjVJM2QzNG1xYU9UVHQ0UTBmVEp2eGRETk4xdnY1Y3JU?=
 =?utf-8?B?eG1kcUhLeWFlbi90K202UVphbjFVNGNjQ0V4TnA2WkUwNGFrdmY3eDgxT3B5?=
 =?utf-8?B?OFdpb1EvTjJxYzRzUEN6RVFpZ05Na1F3aG9GVVNaNXllWHV3Z2tmMExnVGNG?=
 =?utf-8?B?Q2p0SzZBU1RnQzdsWjlSeEo2THlPZitmQkIwTlVhOGhZdWtEVnhtN1hGN2RM?=
 =?utf-8?B?aVZ0SURaMmpuWWU0dG1LcGtuNHd3cExRMnYxZDNrelBBMUphOS9DVGdlaVBT?=
 =?utf-8?B?eGtZUDdBdGpUSklNRHhiUElIbTlFa3NvOWtEeE5NTHE4SU9Za0JBZVhYYkpE?=
 =?utf-8?B?Mk1iRStaUmVHc3pSUnhISmNiVnpudlZyWTZ1RWU1UDdjSVdGdWtpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d4bba8-be81-48dd-e225-08df01b2b653
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:38:38.5808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msSeyrB2rWNH6hYCFU2geX+/ErBL7PMjiLq56s8tMDTrRTysAjUuNHj9KGwSLJaW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/24/26 09:35, Michal Simek wrote:
> Remove inactive developers whose email addresses no longer exist.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> When I sent previous series I got replies that emails are not longer valid
> that's why better to remove them directly.
> 
> Not sure what's the situation around denx.de but I see a lot of references
> to denx.de emails and also in git-mailrc.
> 
> Marek: You have a lot of fragments there.
> 
> ---
>   board/altera/stratix10-socdk/MAINTAINERS | 1 -
>   board/bosch/acc/MAINTAINERS              | 1 -
>   board/intel/agilex5-socdk/MAINTAINERS    | 1 -

These two should be also removed. Got it when I sent this email

-M:     Jit Loon Lim <jit.loon.lim@intel.com>
-M:     Dinesh Maniyam <dinesh.maniyam@intel.com>

I think it is really good to do this cleanup.

Thanks,
Michal
