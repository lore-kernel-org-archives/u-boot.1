Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A096BC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 08:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28EFA83564;
	Fri, 18 Jul 2025 10:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20Pxge4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC96835B0; Fri, 18 Jul 2025 10:03:49 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239A98353F
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHs06UKprZYMmoRmz+H4cjD/q7TYYYhJQqXSOVMUv7SH7j0VwfV6wlwXh1eFvaKPmXZahHMWo76J9E8GDdEFEWHepw7UAmRq1ig12vVnKMbBamNKuyQiqJ5FSsmS4uzUJOalk+nsQ2a1IohNvlFYK1jyexqX0F6ztC6wtnOgjtp+LW492SGzVzy+0zrX0zKCUXKpncftom+vJW940H9t+bAOi3koDxzuhSYFo8oz8RP8uu7h1WUiP5leKmOY9Z4zLtdei7SHvOIbYJuADNsl1Y9gA0ksf/HL1mHRaVYxI7MLdLy8FYKr2OlCtjNMLODylYzVB8DgwbuAG3j7EjylyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWoSED4FpxWMilrbSPcEDVbHw+/EoSQoPpynqc9sZ7A=;
 b=Xr+RbTHRL+TkCIXwGV0qfwYnM9nlfJ+0dhKAMnK1rLurXsSGsVhyQXxbnwUqXHCvmv7x0bEE5wHAZDaiMfCcDyazrBsm9oeTwA9DEtp32Kbuov5EWzhkzxOw2sBypRo1ymDQcdXe92ZxPxnPRqgE6+M1gJ1Bqw9tUD95dRiG4uxK9ruqbQZNlC5R+vXnXgQRgLD8zf7VPB5wN6797MntdexhqoAEsT+fnfS/7qHgLSRzSPdw4T3pc6nrXy+Jytn1BncGU8/YTq5DE0s+0FnAx0IEXbI1meXaPDJnR5zUzZQY1jYcwBAUM8djqcgmSTmLX4wR+UPJN+EnHaxLhj9qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWoSED4FpxWMilrbSPcEDVbHw+/EoSQoPpynqc9sZ7A=;
 b=20Pxge4vxu8SsiKWD3D6JbmMgiUAINbHdGJxigDWoeCmCqQfWDV1fNG0aWmc2vnYuiQmJgvubTuDZrCN9eXs6w9mlRGytqElB/vjAifKVrYVZssS36QfSZFyBTRFA4RhPR1aBuyKeBwzEn9WsN2A/foocs1Hvy23kdj5bSYJthU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 08:03:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 08:03:42 +0000
Message-ID: <ef9b3617-c527-4ace-9cb1-a69f2cf99307@amd.com>
Date: Fri, 18 Jul 2025 10:03:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: xilinx: Fix kernel-doc for axi_mrmac function
 parameters
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, git@amd.com
References: <20250717044855.1359443-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250717044855.1359443-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0150.eurprd07.prod.outlook.com
 (2603:10a6:802:16::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: f699c75b-2d9c-430e-7e4c-08ddc5d19cba
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEpITjVCa05MZVdybGNMRjJ1VXRna055N1l3ZGw0dnB4UWZvbEp5bTVMS3dJ?=
 =?utf-8?B?cW9lR2EyRkR5c0wzM0VBOTRSUVppTTBPRjgrem5aQThadDhzRUVyK0YwTGpW?=
 =?utf-8?B?b2VPSHVEUVlYWk5MS3ZaSkVYcG5nS3RaQjZpRWtCZWVJTjNydDduT29XbDBG?=
 =?utf-8?B?Rzg2UlVjZGNOQnVLUTd5eHp0SlVVbUMydGdtdzhZVzZndllzVUFYT2ZJbzk0?=
 =?utf-8?B?Q3QvWk04OHlMSG9NcmtzS3FwNjhacVBHYi9sOVRJV0lVTHNtOVBIZWRYNHV4?=
 =?utf-8?B?Uy9aOVl2LzloWlRzQjFBNmtFVGRBQ3E4M2pydktUcHRPWUk4M3VjV0F2N2lY?=
 =?utf-8?B?YmpjUnMwREZpemRQN1dFY0Faa29pYkkzL3NQcUU2clZ5Y1JjSVdNUGZaSGgv?=
 =?utf-8?B?ZWJPdDVOenExSkZGTlIvY0VlRjNIcU1KeHpqbXhaOGwzeWlKSUcweWdrcEpJ?=
 =?utf-8?B?Q3F2UUMwVzFjQ0d6NU1WNjh5bGF4NTVZWnJFVEdTU2REWEpJZkJWRjgvcXNG?=
 =?utf-8?B?ZXcxak02Zi9QMnpLOWdUUUE3SDJCZ0o0RENqajhrUXZ1UU5yUHZFbUp5WnVa?=
 =?utf-8?B?RGppZUphQ3RTN2dqSXBFYWNWR3IxK2RwcENHUDk0cmx3R21NdzF5Sm1vcUZj?=
 =?utf-8?B?T0VjdTlyOURxR01jRktnNTBpMkJaaGdRaHQvQnRaWThXZ0diNnRWZEdHQURL?=
 =?utf-8?B?TkNNaXJNTi9mMFJOb2JwMUl1c3piWmN2bkc2WjhXNWE5OEg5TGlRbXBsTlNt?=
 =?utf-8?B?aVNuWnR2VTF0SWxsT01TeHljL3huVUQrUWJVNitlY3UyNkp2c2d3bXhmRXdB?=
 =?utf-8?B?dGdpK3I1VExGcFNWZU1DZUNKbG1RZGljWmppQUM5ZXNnNXJLMmpNb1g3SURI?=
 =?utf-8?B?MCtpRmVKajVKK1JyUWMzYm5kcW16M2lqaHh2OXVhNldVODN1aFJOTm5oZkpM?=
 =?utf-8?B?U1A2bTQ0U3owVGxBSFduS1pFRW4wODI1SFlabTJCSVhBbERPOTh2Z0t2d080?=
 =?utf-8?B?YURaUitrVlJscFNWN05vLzk0eDNmaFJ1azQrRk5VOHRCT1BlMmVDZW12NllW?=
 =?utf-8?B?Y1U2R3N1bU1aOTZUYTVUems1YTNhOEFZOVpzWGloRzlkRFVVSkhUMnNYQVpO?=
 =?utf-8?B?aS91WHc4SFJ5WnN0QldLY2xOWUk2ZkVQZEs4dE91SWUyb0lJY2ZRSnNuTm1B?=
 =?utf-8?B?WWExdDN4TjBQdHZuRVVtUHV0bzZHbHhGOStna3lTR3pBTmdrOFdoRHUxU3VM?=
 =?utf-8?B?cmVqbWJ0K3FWZnJjUTF5Q2lRV0JJS1dHdW1uK1V5TnY2WWpsSGNuTFZkbWd6?=
 =?utf-8?B?c2VMQzQxMi9CMktFbkpmUzR1SUNFS1NIRHR4TnRHNnNjbkRZS2xJbzFjcW9X?=
 =?utf-8?B?S1B0S1kyMDdwNjhRaTJUWnh2VlJXcFNtYnlYbUFYTmRRcU1Udi9FTEJ6amly?=
 =?utf-8?B?RVRSTEppSVp1c3RSTnBNVFhQM2pLTndsREttQkxzbGEzL1dyVmR5ci9LdDlw?=
 =?utf-8?B?MFB1MTY1WGxtT2Y2SmhNRUNRYnk5RUR4elhQcWFjL00vVGtaaktvWE1JeDBy?=
 =?utf-8?B?K1pOYkhweVl3T0J5eWhObDdnR2VDcjhlc1QrRXdmRFlxODlhTmxHZ0o4QVRp?=
 =?utf-8?B?aTBVM1lIN28xTW1BaG14Um1ySHFwdWpwRE84MDRUeU1NTVllalNLU2FsWWV2?=
 =?utf-8?B?eS9iWmorMlhJZS9PM3NuVXozRkZUdGY5bUs0VWJTM2U2aW5YVmtWMkloZVFP?=
 =?utf-8?B?dnRsOS8zMVdwTzVIcGhweTV5OFpQOUdvZFpkZjkwUlMxNnlEK3dqZXJINXlm?=
 =?utf-8?B?OEkyLzllV0hsL1d5U1hmOEYwOTRlclErUW5TeFNmZGRJcHBNZlBIS3VaUzVm?=
 =?utf-8?B?MkJYeFNIZXdFcnY0NzVLU3A3VU95WU5mUkYxRUR3VE0zTHZSZExkVTlkRktD?=
 =?utf-8?Q?izNCYSYYBJ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0U4QUVyQkF0cHYvbFlpODJZKyt2Skphbm1PaVg5eDNzWTY4QlZHQ2xmNUdF?=
 =?utf-8?B?SHdVbXJHeUpzWXd5SzdqOG51M05oc2FERWVHUitPSlMyajh5VWttamw0b2Zx?=
 =?utf-8?B?bUttSUh4Q3AzVnN3blRTdDc4VlFpMHZ2OVRYNjFiOWJtbEZsNlVKeUtPWDRz?=
 =?utf-8?B?VXVRQnVON3RGaUllb3NvclhjRjdvNjhGdXR2NS8rZEM3bjBLSEpwUnp3dkti?=
 =?utf-8?B?dk90a3cwRzR0dmliMWxPK3QrSkJBYnlHaW1rNlg0dTUybHRHdUhrTG81VXZz?=
 =?utf-8?B?bC8xWjRjYTc4NWY1V0JhRDgwWGJBMklwaGcxNzhkeGpwOUg1RnVXQzZzSy9s?=
 =?utf-8?B?TzZoV1RhMitlSU9wR3Roazl2dFBteGVrME1SaDZSK2hOanBhamxFRHo2N0E4?=
 =?utf-8?B?Zk1ZZ0t6WjFCTFFvNmMwUnZoSGZiZ1NibHpvNlcycHBwdmR3YjB5L3RDYmtu?=
 =?utf-8?B?Y1F0TGJTN3ZFR2RyaExNclAxeWd4cnFidjlISUI5TGRCNHI1OVFPY0xjK2Fr?=
 =?utf-8?B?am5oL29yMXc0STNtUE1DQTFaUUIrdG83MTYydDNzenN6VEFrT1lDYUJCVGFO?=
 =?utf-8?B?a1ZIS21XaGdnMS8rQy80WjJ5bEhremVJWVpFTFUzSDVhQ250ekd0ZW44MEtz?=
 =?utf-8?B?TndRdjZDUEFTb1NqYkhiVlBXdXA1b2tuTkdjWW1jOXc4QUJuRU9HeHl6Zjhp?=
 =?utf-8?B?UFovNjlJeUk1bW9aa24xZENyR3JLWFV2eWJVU0VUNjF0RmlRQW5qQTdNQ0VW?=
 =?utf-8?B?SUV4OHZBT2l6UkcxNThMUDJudVh5SWI5R3o3ZWEvbGxCaXZOdzQzUjdOUW5s?=
 =?utf-8?B?d1JrdjlvaEcvNUluWHl3RkJrYTZtVlo5VGdBbndNSHNkTVppKzZlMTRiU1VD?=
 =?utf-8?B?YnVUdDBkU3VpUEw0MnZ2S0hpR0lrTkMyRm50NGNHN3lEMUJ0WVhOd2UzbVhQ?=
 =?utf-8?B?V2hHVzNNUnQzVVNjUW0zdnB5QzVtR2w5WTE4ZDB2dW1UNW9UMkxOc1ZpeU41?=
 =?utf-8?B?N0lTWnA1b0tUTHd4UDNtQ0craWhiNjdlY0xndm05YzErMlhaNi9PQnhtUXVX?=
 =?utf-8?B?MjhwSXlaNzlRSHF4VDlMT01QNktSV2RhWXYyTXh3Ymd1VitjZ3ZUY1JVM2dZ?=
 =?utf-8?B?SHJtWW1TS2VsNGFDekhidkRMWjQyMnU3ZjVkajhUUUY5VXFhREdiRDRoc1Yx?=
 =?utf-8?B?VWZIZzd1RWozdzNMS0t2Q2hoOUFFWmxwUWQvait2aENjVmdDVTF1NjRISWpT?=
 =?utf-8?B?ZmVKSkd1dStjeWhOb1h1R1V3MjRIMG1pTWxYaU9ZcWV1cVJBcmhUNFU2cmNX?=
 =?utf-8?B?eFBkeExsZUZpb016RitzYzM3NktEQ2UzQldVK2dOdVh2aFRwRXBub0tHRXln?=
 =?utf-8?B?KzhrZGx4MnpIcEJBT0d6QWlmOFIzalNaY1VMc2lDcDhGbU9lWVRwMUxrYkJC?=
 =?utf-8?B?UVhvWWdKRlFOT1VUN1g0eVR5VGVIN0lOVFMwWUFWWGFOc295UGhGWDcwZFNv?=
 =?utf-8?B?Q0E1djBMNEx6VDBWOGNRSXQ0WkMvNE9MUUhFbUJqZDJuMW9kMFIyWW0zUnBC?=
 =?utf-8?B?M3U0VnVZV1VhV0tpRXRqKzJrZHdjekZnSnJ0T3NPK2xLVEwyU2k4eXRiNnU3?=
 =?utf-8?B?TFRWY2NLaUFGald5TjlQVDkxSVZybFRaeFZIT1lRcjhxV1dCbTh0RGNxbmgy?=
 =?utf-8?B?N2I3UTRuZFFOMFdqMC8xNXozdUJVSzZ4Wlp3dGY0Nk1jWmo1dkJGTlZkSzVF?=
 =?utf-8?B?ZTM1V2o3bk56YjZvcUxvclhoOXF1RENkMVRIbFcwVDNJMWRkVHN6cVlnOHdW?=
 =?utf-8?B?R3dyZ3o1dzdDZU5PSDQzOUE2eW1FekxFN0tzSmc0RncydytzMGNDTkgwU1Zk?=
 =?utf-8?B?UjZBRXZVRCtrSWREbnNYSVBnYWpiVjY1KytxaU5xbnNIb29TTjlISkxQRXBv?=
 =?utf-8?B?QUVwUG4yWThoY0JMd2VvakFhSlpNTDBwSm1TclIvVVNpbUoybnhSNmpUaE9E?=
 =?utf-8?B?THhVTHp3NmY2MWIxL28vUUNkRGxvbW5Gemp1a20vZzhIRjdmcklLRVVHQkN6?=
 =?utf-8?B?ODNhM0RkaWFuSko0eXEzRXU1UmNjS2srdE1MODFVZXJpNmZUWlVIV2V6SEZs?=
 =?utf-8?Q?djj7AlKHJ17HhhMFh9BORkKi+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f699c75b-2d9c-430e-7e4c-08ddc5d19cba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:03:42.6022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zn6XMxnHN47HgeWS+fJIBs3Ou9XPmh1v1SMrDf1UmW7y1t1yk7r31M+WOcaZZsei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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



On 7/17/25 06:48, Venkatesh Yadav Abbarapu wrote:
> The kernel-doc comment for the axi_mrmac_recv function was missing
> the colon (':') after the '@packetp' parameter tag.
> 
> The kernel-doc comment for the axi_mrmac_free_pkt function was missing
> the colon (':') after the 'length' parameter tag.
> 
> This caused a Sparse warnings regarding the 'packetp' and 'length'
> parameters not being described. Fix the formatting to align
> with kernel-doc standards and resolve the warning.
> 
> drivers/net/xilinx_axi_mrmac.c:357:
> warning: Function parameter or member 'packetp' not described
> in 'axi_mrmac_recv'
> drivers/net/xilinx_axi_mrmac.c:411:
> warning: Function parameter or member 'length' not described
> in 'axi_mrmac_free_pkt'
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/net/xilinx_axi_mrmac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
> index 555651937f8..56f877c20a6 100644
> --- a/drivers/net/xilinx_axi_mrmac.c
> +++ b/drivers/net/xilinx_axi_mrmac.c
> @@ -346,7 +346,7 @@ static bool isrxready(struct axi_mrmac_priv *priv)
>    * axi_mrmac_recv - MRMAC Rx function
>    * @dev:	udevice structure
>    * @flags:	flags from network stack
> - * @packetp	pointer to received data
> + * @packetp:	pointer to received data
>    *
>    * Return:	received data length on success, negative value on errors
>    *
> @@ -399,7 +399,7 @@ static int axi_mrmac_recv(struct udevice *dev, int flags, uchar **packetp)
>    * axi_mrmac_free_pkt - MRMAC free packet function
>    * @dev:	udevice structure
>    * @packet:	receive buffer pointer
> - * @length	received data length
> + * @length:	received data length
>    *
>    * Return:	0 on success, negative value on errors
>    *

Applied.
M
