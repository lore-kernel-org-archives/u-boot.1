Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30246CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 09:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF06830B4;
	Wed, 10 Sep 2025 11:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6yvjgjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 190478318E; Wed, 10 Sep 2025 11:00:06 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235EA82B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGZd51mpHCOPj0LzDfOyMD5l0ABBoYO9G6ZiF4n1ji99t+a5i0pnPKmhLUPoV+xECiKv3kjs4kfU/o5n/wjOE+5WEnoSugNoJwO3cHWazsaehy88OJnbVR/E4iE//HzMY65BQ/lbVC+pln4kFbDyPuZATeK90kC4vD/WTtXQEUuPPNyPtTSOGshxyZglHA+oDzgaAkKfwtzyWm1Hln5v46+zQJWi4o7PRTj20lXQi/D/oMveo7N88o9LgZAjMT+usvDvE/BwJ7LwymCs45L+cd4IoW1Khh+zkGcRw8wNT9+U46U8KebNAbjMsOJFOcW6XtT6YKlE8USbWiu+wSFkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlavUDwSUxzhwgqbsUgEALypEofyNsEG/Rqoa3F+yJ0=;
 b=w1S5aDEkAqos69HyhOe1orXK8/PgGBH6b4C6y9YBmjxfsyRUhfLctU4MEORySprUqoM+42rn9DfD9lq5n3gBWmubtXiBYpy0oCDT336kFa02YPkcjtzFFK+xo1c6BkxinG0o2pg6zUCNMsactCH5c0uT//1TLP4w2eD/Q0D6VDRgxp6nm6z6qz52lGBWFpSdpKhfeGnnm/83ZYYy3BqwD7LeVmwPUaUXDjU+Bt3CV1PdcAN0bHcfC4Jb91PAcydFLi2WbUMY0xviC+JX1VuvDG1GITeGrcKFEJ0uJ657/2pE8dKHt6iSbDUAiEMSPCMXk0Te1nVKWl1PWZ0x2XGIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlavUDwSUxzhwgqbsUgEALypEofyNsEG/Rqoa3F+yJ0=;
 b=B6yvjgjf5XHGeXET5ORj1wqvrNNBuvyFUP0pmo7BUNLwDWZLsqfK3iIwDXk2HvYdzqHSsPOmtN9yhhteNHHDkaQy0S0rR3AH6ElJmD4DYAAStOb3AKxXhnnRfk/x5NeeOqNrrN+SLo0yaQE5pknDX6ECPQhIboKv7EBWVgIQVRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:59:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 08:59:57 +0000
Message-ID: <613b8d27-83a7-49ea-b4cb-b9dc9480de71@amd.com>
Date: Wed, 10 Sep 2025 10:59:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] arm64: zynqmp: DT synchronization
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Paul Alvin <alvin.paulp@amd.com>,
 Quanyang Wang <quanyang.wang@windriver.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rohit Visavalia <rohit.visavalia@amd.com>,
 Srinivas Goud <srinivas.goud@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1b1861-848a-44fe-6d79-08ddf0486ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckIvL05pQjFkRTB0TGdPeUx2UG5OcGRsQjBwNThYTldlMTF4TkkyR2pFSUVR?=
 =?utf-8?B?T1JKRjJPWXJhTFFma1pGcVhmYmZBQmorRjJqYXUzRFdGalZMTFozU0FiSFN5?=
 =?utf-8?B?RGRLaGY5T2V3TlcvdFNQY1JBN2R5VEVKVFM3c2dydUhGQXNEY1hLQ3hpYkIz?=
 =?utf-8?B?TWxTVGtTRFMrcHhPcUFxZTNsckY4dGhnRWFsb1NxMWM3REZvN0tJd2dSKzlB?=
 =?utf-8?B?ZC9IUE9QamFHTFBGNEhYY1M2YmI3c1YwNHNWdnZxQnRPOWY2M0JyczNwb2NO?=
 =?utf-8?B?Vm5Bd2x3TnFqVktyR0dYWHFCUkx3Y2JxKzhXNHhzeDVwOGlZTEhJK3hSZExy?=
 =?utf-8?B?QlFkV0toN3lKTlVySk94YXV6N3JvckxqK2IvQStvcXpWM0kzKzFDTkd5RDBq?=
 =?utf-8?B?T3IwMDBWbW5JV09RcE1VQUVLaHlNVEwrM20rR3JOK25nT0Q4WDM5emxuYlE0?=
 =?utf-8?B?YzdSVUxpV0N3VGp1ZDBOdFBIM29tam4rOHdFdFlhb0I4RStzVmc4RW9SQXpv?=
 =?utf-8?B?Q1d0SWVKbERHWDQyZEduenI5U2ovV3JaMCtSTVltQnR5Sk1xNWVsVEtwN3JN?=
 =?utf-8?B?YjBqeHNCQ1pkbWxnMW5tNDFyTHBwSHREdjA5MjR0Yzl4Smcwb1BSUUYxMGZw?=
 =?utf-8?B?RlhzcEExdURwMURXMDBPM0VvakdmZ3E3dTBLVmlUbHRvbXpIZnd3K2laTGM2?=
 =?utf-8?B?NzhWOFQwakNwNE5sa2ZOZ21oditTR0p5dFd4Z1ptalNzWFA3anVwY2ZVSmF4?=
 =?utf-8?B?NzA5b3RoMGVZUjFMaFppK0tpVDBBZVcxSnZaeW5FaENmOExrbFJsb2ZzYnJ0?=
 =?utf-8?B?TzJ4a3VVcWc3RWFsQjNySVJoaWR6K0tYR3BoTEE0ZWRPN05Ja202VWpobG5x?=
 =?utf-8?B?bUlJOFpxVDc2QlhZZW9RNnlhVDhKSGNVbWNGSDdyandEeWdlUFgwbDVFN3VN?=
 =?utf-8?B?TzhWSFJqTXNhNW9paElsSkdFQUZDdFVGQVRoMWc2VjFMdGJDZ1UycjFtTWI2?=
 =?utf-8?B?c1dlSjlVdlA5N1FjSkpnSVlUY2w1Z0xLQWM4ZURzV25jeWFlTWVsL2NjdlY1?=
 =?utf-8?B?R1lzelMxR1dKVmVQNGNvcDh5UG1La2hmQTdCMDRKVzJHNXA2eTFFa2gwTWQz?=
 =?utf-8?B?MkM0eWFiWDhkWnR4Wk1Pb3JvWFRzUkNacG9uNGFHSmNENHZJMDRLNUl0aGtJ?=
 =?utf-8?B?TnZoeGpNbXNBTlQ4RzJhV0pxZ2JPZVJCOENTWEJnSnJzVXo5MFpmMS8rRWNs?=
 =?utf-8?B?dnJoNWRzVDErMWlvbUFYdHhmVXg2aU50L2xuelNta2JFcjYzSVJBbXV3cjF0?=
 =?utf-8?B?MVBKWmtObEFOeWlrQVBJVDZMaWJsdmJCZnpQM1RsSkVIK0FoL1kvUHpPaTRS?=
 =?utf-8?B?T1AxazFMaXNsYWdqemJUVXdCSmlQOEduOUJwajhhSEdWdDVBWlFPV2E1eGhW?=
 =?utf-8?B?bkhzdGc4QU93K1hlVkNzNVZ1b2E2d0NvM0FNNHJNZnozR3A5YXRjTUVQZmxD?=
 =?utf-8?B?TlIzOVNDUjdrVENNdElkRm03WENobzA1OUFQbHBTdmw5TnF5NnZDcnZXdy8w?=
 =?utf-8?B?Vkd6Ym9vdW10SFlUdC8rbUM5bHdqUzhic0lya0VyeVhGOEpUUkFiZERzMVRq?=
 =?utf-8?B?ZkNFbi9TYzNqWTB1R2M0NjFROHdKeGhGS1lTUUwvWG9xcTVGSVNncENwRlJa?=
 =?utf-8?B?eHF6dmpXd2VLazlqRERjL2l2bVR0Z0RZdmQ5dktCTkVOZERrL2NXQTRZMnpM?=
 =?utf-8?B?bWY4SFB2czZhRGF4d0JzMFg3amtzMERNa3BiYmVrUVV3aGFGSjZheXJEMVJp?=
 =?utf-8?B?b2kwUnpzSUl0Q04yTmxTakpCOEJvRmF2WGR3NElxdzNSemZ0ejhqd3pjZzNC?=
 =?utf-8?B?VTVBK29WTVlTa29HTHBoQlpmejF5UXpLUEhTM1hBQ0xiZmp4ek9rMHNuVWd6?=
 =?utf-8?Q?SGXJN5Gtnt8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3VVd0RmczhkZnArQ2FwRHRiZnloYU9hS2d2cVJDZWhQaGZBTHMyK0svQUZ5?=
 =?utf-8?B?NTdwdERtOEJsaytMQmhUOTVqMDQrVmlsREU3d1IvMmJBLzVUbnZyOFJQY3hi?=
 =?utf-8?B?WHNiR1JyT0o5RnZ2Z1c4NDk3NDVCdU9PQ0NFcjJQRlVRZ1B0QVN4emI2SFFo?=
 =?utf-8?B?MnJiMlFwRkl2bUtxb3RSaVpkZ2FmTnN4dHREdUtPM2Z4S0NiNDM4aitFcnlh?=
 =?utf-8?B?RlVqUVVMK3Y1TUNIYkJpOGYzWXBtQ0hWMDZ3UUdmTW1RQktFOUdVMXo2MVo0?=
 =?utf-8?B?aEY5OVdTVnVYZURxTDJoZUI3VVRZSHdiQ3prY0o3M0M5eklKSzVjK1AxWDhG?=
 =?utf-8?B?NFFBM3pkYkhBdUVEa041R01ucGpieHZQZnZyS3lieC9QVWxOdHhOTERjNEVl?=
 =?utf-8?B?M2ZBNSt1NEpWM2kyanNuZ2d6NWVwditOVDl1NzVpREp4d0paWjJEV3BZZHha?=
 =?utf-8?B?UTkzbEFZVzZ6cDNGZ3hjSWNkUWNIRTAxRnM3RFUzZE8yVWZRQTVLaldicEwz?=
 =?utf-8?B?RW10L004aE1MVmhsenZLRmlpNFNyQ21zYTNHNzNGUTMvMU9hdEZ1YTd6S253?=
 =?utf-8?B?aE1kSERudm9yWWhmaEhTdzRiTXVKWFo0V3ZaMmpXZVkrOWc0VW9YK1I3NUpt?=
 =?utf-8?B?aHdvdXZIMm9KUllFblJvQjBXWDhjb3UrNEExMk9ZV0J5d1hNalBEdWZlOS9p?=
 =?utf-8?B?d1lTcWFXb2o1OUREd1NETUVpd21pdXNVT1lhWVVINDFRU1IvOTZKMHd1K0ky?=
 =?utf-8?B?VE9xaHRVejBGSTZORjYrS0x1bU4rU0VsajY5eEg5Z2VYOEplZlFoalpRUGFv?=
 =?utf-8?B?bDRyUVpLYmRqMWRyTzA1RnpwWE1uS09DekNqMzVxM3JxbUo3ZUI0SjdHOVRP?=
 =?utf-8?B?QU40VHBKM1pnZ1BoMXpkNVRVbHZpdVBKdzZpdGJMcS9xb2V5ZW8rNkd4ZGpJ?=
 =?utf-8?B?WmJNK3JLbjE5L0ZOSnIxcUVQZzY3UlZtSVAxa2wrc1Q1RU92ZVpOaHF0emR3?=
 =?utf-8?B?eGl6L1dXUXh6NmRDYkJjSm8xT05WM0NUVllLUVFuaUQ1cHdac1ZCTHdNU3BU?=
 =?utf-8?B?b2ZvZmNRQmZ5ZUxnSk13SWw0RlFPOXdDWGV0dlp2bmU0QjZoWCttWmZhei9Q?=
 =?utf-8?B?bHVEdTVBUTBndFR6V2x0UTBNNDdkQkd3N1Q2NTQ0MkJqWThDZ05iL1NwejRz?=
 =?utf-8?B?MFdsS2Q5QytXK3o4UzJNNjRSbW5WWUloeFJ3YlhKUlV6bnY3VmVPem8zOXo1?=
 =?utf-8?B?VXJLbHBJZDU4dXVpNHVlcThwc0tBeG90enJQa3d2Z0ZLYkJ0dnNJSThHN1p1?=
 =?utf-8?B?V29KdTVYV1ovcGZxdmFMSXduaytzalVnUVErYk5QWTBDWHdJaWFkbi9QdHB5?=
 =?utf-8?B?NVhBRWRMbi9HK2YzS3JlTkJzSGlzQVlaUGhBaUJMS3lieEw2b1liYllqSUVE?=
 =?utf-8?B?N20rK1pGK0NRSU9mNXdsWU5VQ01BSENJNVp3c3RvR2kxaFNMUXYwTE91Q1Iz?=
 =?utf-8?B?K2Z1TEl3RFdVYTg1M2pITDdoakVobUZ5Z3pBcXU5WmtMeUs3eGl2NTl4TUdU?=
 =?utf-8?B?MnFGT3MwYXAyU2o0Ums0N2pqVGx2OVRiRUNLcEs1OHU0bDkxMXVtN1BUOUcv?=
 =?utf-8?B?R1BiRXEwM2ZWZjNjbEVwcnA4RHhrVnIvWEUxbTRNcUp6NFpmMDFRUVBUUm40?=
 =?utf-8?B?UENrZ3VHZ2VDZUhybWtsSFNwajRMZFNzelNLdXZNK3FOV1JDNit5REZUM3Ny?=
 =?utf-8?B?bTg0RUl5SGRISy9FclZmM3JHNXljVExjK3F5Kzh1Sjdic1Nlc29OemxrZ1Mx?=
 =?utf-8?B?RTRMSGg2elVHWkVJNjhlY2lPSUlHTnptYkV6NUJ6K0FuZlFjWVRianNrUW0r?=
 =?utf-8?B?NGZQcmxtcXltSWcwY0xkclpYcXhlSGNmZFRnU1dMTU9iZVhqSG9vWDZjbjNC?=
 =?utf-8?B?NFFuaG1GZjBLMjF3OXpteDJFM040bkJZS0RBMkZ5Wmc0bXJLMzh4MTIvSzJo?=
 =?utf-8?B?ZnZMS0hlMEhVTnNTZDBIOGtLL0RGVHVNWVdjb1FjSHdIOTdtbGN3S2JoT0xD?=
 =?utf-8?B?dFFIdG5DVE9pZFJqN1dnMHpPRFI1TW9RQ2U0T0NQbGZGb1pWYTNJUW1rdTFG?=
 =?utf-8?Q?lyfnmjwep40Hv024wlaTDBj6p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1b1861-848a-44fe-6d79-08ddf0486ab0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:59:57.5624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luAdupKx5h6U5E59SATsKWBdGzNIsG04hdY0QXJZCT5GFlT+VRCu2UzlzFk6G6Qg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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



On 9/2/25 10:53, Michal Simek wrote:
> Hi,
> 
> here are couple of patches to sync DTs between our internal tree, upstream
> Linux to be able to do switch to OF_UPSTREAM.
> Last missing piece is around MTD partitions but some days ago parallel
> spi configuration has been merged via mtd concat driver.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (9):
>    arm64: zynqmp: Remove undocumented arasan,has-mdma property
>    arm64: zynqmp: Remove RTC calibration from sm-k26
>    arm64: zynqmp: Remove "ti,tps53679" property
>    arm64: zynqmp: Fix incomplete comment in
>      zynqmp-sc-vn-p-b2197-00-revA.dtso
>    arm64: zynqmp: Enable PSCI 1.0
>    arm64: zynqmp: Update compatible string for tps546X24
>    arm64: zynqmp: Introduce DP port labels
>    arm64: zynqmp: Enable DP for kr260, kv260, zcu100, zcu102, zcu104,
>      zcu111
>    arm64: zynqmp: Add pmw_fan label to k26
> 
> Padmarao Begari (1):
>    arm64: xilinx: Add i2c mux idle disconnect property
> 
> Quanyang Wang (1):
>    arm64: zynqmp: Disable coresight by default
> 
> Radhey Shyam Pandey (1):
>    arm64: zynqmp: Revert usb node drive strength and slew rate for zcu106
> 
>   arch/arm/dts/zynqmp-g-a2197-00-revA.dts       |  2 +-
>   arch/arm/dts/zynqmp-m-a2197-01-revA.dts       |  2 +-
>   arch/arm/dts/zynqmp-m-a2197-02-revA.dts       |  2 +-
>   arch/arm/dts/zynqmp-m-a2197-03-revA.dts       |  2 +-
>   arch/arm/dts/zynqmp-mini-nand.dts             |  1 -
>   arch/arm/dts/zynqmp-p-a2197-00-revA.dts       |  2 +-
>   arch/arm/dts/zynqmp-sc-vek280-revA.dtso       |  1 +
>   arch/arm/dts/zynqmp-sc-vhk158-revA.dtso       |  2 ++
>   .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso | 28 +++++++++----------
>   .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 16 +++++------
>   arch/arm/dts/zynqmp-sc-vpk120-revB.dtso       |  2 ++
>   arch/arm/dts/zynqmp-sc-vpk180-revA.dtso       |  1 +
>   arch/arm/dts/zynqmp-sc-vpk180-revB.dtso       |  1 +
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso        | 17 +++++++++++
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso        | 10 +++----
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso        | 17 +++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso        | 10 +++----
>   arch/arm/dts/zynqmp-sm-k26-revA.dts           |  3 +-
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts    |  2 +-
>   arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts      |  1 -
>   arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts      |  1 -
>   arch/arm/dts/zynqmp-zcu100-revC.dts           | 18 ++++++++++++
>   arch/arm/dts/zynqmp-zcu102-revA.dts           | 18 ++++++++++++
>   arch/arm/dts/zynqmp-zcu104-revA.dts           | 18 ++++++++++++
>   arch/arm/dts/zynqmp-zcu104-revC.dts           | 18 ++++++++++++
>   arch/arm/dts/zynqmp-zcu106-revA.dts           | 14 ++++------
>   arch/arm/dts/zynqmp-zcu111-revA.dts           | 18 ++++++++++++
>   arch/arm/dts/zynqmp.dtsi                      | 18 +++++++-----
>   28 files changed, 185 insertions(+), 60 deletions(-)
> 

Applied.
M
