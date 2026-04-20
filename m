Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3FBF36C26
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 07:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30DD83693;
	Mon, 20 Apr 2026 09:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sS9bqGoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2E0839D5; Mon, 20 Apr 2026 09:06:13 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A77805D7
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2Rttv3EEBpV+g3NzBSi2T0RknGq+qgsxMTaLNmRZfrJ9WfKeeG9JOf4n85jDTKlfJSTLzkaxQyLRDuIgh/GH5dJ6wPqvckouXHD3+xomn2uZdEukzWxiLN8tknJ4q2hzRkwT5/iWRWYPf41JehPwjScw2O1VN4Zw/76ba8Ftsord9dp+u1WRPzrn8dJawEpinefb1GPQNISw1YTnAR+eo+n45Wjftm0T21oC8e12MDBHjAl91qE45dvNswISSPWk5AmApkKbmivS9nvlAUrVqHE3Up19GYq4nUNMpRlvea66ojyAdtPbjz20Nb9KJwzd8phLmLJiC/bUC5JCioK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8a3YK1Z/vYhPR//tb8iiuqxy5Gb6yfWbXwjUkgOkxY=;
 b=sXgo/JkCb6zngWMuCMYuU6sWwy0Ts8u9ZDUKTQUMu4d4Cm7EGWWBRDg8KBo5xGtk7Ynsg4TcQ48WJOvKzF13Lbf4hD92G0m/+IpoCYHt/7Mf5hEgczUl/QVbhSX1os+k9lzwTVUjLgo8ztuu9o7AxUntZyQl8MO0RfXsCOW+Aj7GWTk6KoQNYkrmod3pNOyuWKu7QJ/Fhq2VYZZLBGk8rkrmZ+ryshRteJecIlU7aeSyF+e45wSCcahof8zA8FaJkc9GJDmkbSOdbnPFRZovP6KEdD0AchFb8oK9bjZLAvvTlsi9rfAJMFHhQyBbW7OYsBuU7jLypokeqvi4QDHrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8a3YK1Z/vYhPR//tb8iiuqxy5Gb6yfWbXwjUkgOkxY=;
 b=sS9bqGozAK75zVlp0RgpUEoPZcRHtvbws0n9DK1nRZ4f2JQmgkaLTxzxkuBhpuwG5fk1JnE35RICNM0PBkEGwLXUbHusvGDKe2boeVN1bipyspfFVg+HK3fhcKwWN70HnKDShuhqbaIycC/lTfpOJp/rqw7ADdGkK4us4ynmiSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 07:06:01 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9846.011; Mon, 20 Apr 2026
 07:06:00 +0000
Message-ID: <1a1f881c-bd6d-4677-af87-1c73bcac3dca@amd.com>
Date: Mon, 20 Apr 2026 09:05:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Add support for DT overlays handoff
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: venkatesh.abbarapu@amd.com, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <696b7f4d-e192-44e4-8652-e8db7f980507@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <696b7f4d-e192-44e4-8652-e8db7f980507@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dcce98-3d9b-4593-4401-08de9eab4742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: PcFzVQiSP6dNevOjdCwUNboD7zw4mE/gUe4AQTg/4Dxdg7yhuv2O6XSvNRxVvxrNOXdYKddGarg8Pp5Nve8+6hD3hGKMJK3gs9o9mXghtZSrgTjVk9fBfGNg0CqA33BclTam51sfFwgKwRmwXTcafIY7UBN+u/VFRY/QcFGPjYTFRPk71Puv+Pc9TQBPGhsNw7MwqDRzm81DUUwuLaohF0sAW24cRo/tsdJrJ7eCHQhEJW1DgbmhdUab1++UptIQwMZp15ijqp+UmxG6+vCNt9kBaRSh7/JKVzhcY+nU48l7QrA1BCEsj71cg5yJENh6h3azAlO8KwRnPWrdmUCUSlwxK1DW8LvF+bhk4BHnkFU+SAStZGqv2rTPSPKjAN+Z80zEYVGVUdHG89O82DkcUa09DMgCYuzaYoaQ+AdsgGrcGwBKBVDIsSnxOX7kQfwUblT9gbvwbmbpKtBVONejEpFS7Ht5kMiRjk6/gUiEP49w8ygtVIcUBm/8eWgdfBoSV9+gelVDUe3nmfC8gDqcPs9Ab6bg8m/OV3ZPHU7YA+nlPYUkwbdFVUIoekg/hjAkgPlMVBwfxpMgmOsiD1eZxaK1CD6ceUWb6s3ZFsYrnMyBGP9Sxzh0akg1dBsC9J3/313wTurdgMzCL09cSXGsEda/x/VcC+M6ux3HA5rTNr1IKZUoubItclOfouw+NmQdan8tXqxYdigXNdCiqlE1CSCfVVOnZN8j/frScaH8IzeKXUgipQHQ+wEkFTDF/nwu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9HVGlwU01pek90bjZiQ0h5OTNnSGVtQ29PVTNOMzM4blN4bXBSQlZmY1NP?=
 =?utf-8?B?dm0xWTlmc1FPaVV0bURXUmorcmZBc3FYTFhJSDJVRU9UN1lEMjZ4NmdPVS9t?=
 =?utf-8?B?UU5OclQ2OGVYQncwQWYyakk0TWl5K3NOS0lneXFnUGRMTXgzNkNiTk04UDRB?=
 =?utf-8?B?ekNEdGJxemNMaktYYzA2RkpqMWFTZmJKNm83dXU0dCt5MWx6VXZwVzZkNnhh?=
 =?utf-8?B?VWxzcGNmRVRlc3l3aFBZN2VYbS9ZWm52bmhDMXVyM0hnRzE0ZWxZd3hzL0pz?=
 =?utf-8?B?VFdJSkl4UkU5Z2dPUGJ4aWFZc213dkdLQ04wSEk2ZGxFRTQ3YXN3cVFPbnE5?=
 =?utf-8?B?UXd2cWgzMHp1Ly81bjVkRDlHNE0xeG1INXpyK3IzaWlLWmRPTVpDa21ta1g5?=
 =?utf-8?B?bjRSWHc4Sy9wUEJvZ3lKSU4zcGFvQ0t1OXRwWkpHdGVudGdJZlNEd2x1NEcy?=
 =?utf-8?B?ZDNDeWwvNWY0eXp4bWNpUlZPeHlQMkk2dngxeDQ1TFlRcUI0Qmo5a2wzQ0hB?=
 =?utf-8?B?WHFURHhieUhYM29qUDdLY2pGbC9NSW9wc3RMaThpd2J4SVFPMklzVmRURkM3?=
 =?utf-8?B?NitmYXRJU3pPbHVtQ3h3TVRDcFNxQXFVRjZTdnhLU0duZzNnM08xc3ViSi84?=
 =?utf-8?B?RThGWUVhQUdkeWRjbUlRcDdPMzFGWlRsRVIvSXFXU0VIcW5wSS92NkpFd2Rp?=
 =?utf-8?B?dWg2ZUh0MWJvS2dteml2TGtrWUNMbXVUdEJHZUIxTVpVTTZzUEk2UUVibDZL?=
 =?utf-8?B?VDlJNllsclZJUTc0Z0JuQ0tCYytiVjhTT1gzeS9EMEU2M1ZzNGU0dVNyYWJ2?=
 =?utf-8?B?VnMzTzZZZlpzWENZY3RwZkxPY1doK2g1aklDdCtoN3c3ZWNsdi8rSHAyVjY0?=
 =?utf-8?B?WUJLam9Ta0lwT3ZxazhweE14MUZHSGU2WDNPVlJwNkQ2NTdvSEJoMVV2emFa?=
 =?utf-8?B?U0tsaG1Da1lnd0x1dUdCUExzSUNMWUZYbnV6d29hL1JEYnJQM3U0NU5XN3Ro?=
 =?utf-8?B?UVVHWnhQL1ZyR0M2RTVSL1NrQVVzUHo4WlZ5ZU15TXZ6cjRqdWxIQTVDRURp?=
 =?utf-8?B?V3Vid1VkUkZCYm1xbkhGNklzWml4K09ZeWVSWitnaEpLOUVxb0xSYThEeGVq?=
 =?utf-8?B?ckhQaEJBSG1uZTV3Y2lxK2k3N1BOZVB4UysrckxRZzVIVGo1VU9DOSt0RDdq?=
 =?utf-8?B?ZnoyRDh4OG44MDdlUndweFloRk1CazVrdmJ3U0EveUZpM1dzOHN5VWV0NW9M?=
 =?utf-8?B?bG5rZHFhNmwrVE8ybXdPWnNxUXlvdjdEdThvRSt3MjdnLytrbDdlV01LYUlX?=
 =?utf-8?B?Rkh3SUhxK3pTVUxZekNCWmVVeXBGRG1iRHN1dlRKSUp5QVlVTVd6bnBLSk9T?=
 =?utf-8?B?QnR3SGs1SXFHUGVUTkY3enNpdXdsNHM2YWNpK1ZLTGJ2M3FnTENmRmJTeGZz?=
 =?utf-8?B?bXhvazY5dnVPdWJQbHZLZUFqSVNudnp5d0pCcEY3dmlDRTFmNHl1OC9CS3h2?=
 =?utf-8?B?YWdWRENjdGg5WEVNckFROVp3RGd0bm5jVTQvbXhTQkF2RVdxVFZvanZkdzRJ?=
 =?utf-8?B?SGZ6bE0xZjlWN0tPUHdSMHZoeWdCUVM0bm1FcHd3U2t4R2orSjdWNE9lSU5Z?=
 =?utf-8?B?SDRJZDhlMDU0VWx0L0srL0lxd21UVVRVSGpWSWUyejJRWHk5bDYvbjdEb2RP?=
 =?utf-8?B?cVdyUGtWM1c0OUtCc3gwVDRoK2xweENXM0EzckVYUEQ4WWVlNjUrRGxrSnJD?=
 =?utf-8?B?dTlqbHJkNHIvUCt4S3p1ZjBOVXE4Ry93WnVGMEViVkQwMXMrbGxlWk9MbEt5?=
 =?utf-8?B?dWEvSEE5WHJPd2lQV2YwazhHMHpFd2pmM1B3eDFqVlVjN0hiZE9OQmdIRDF4?=
 =?utf-8?B?UjRiZXpVdUdKMGlvdUVSTnEzaEV2cmVid3IwMmVYVzNPQ2VxWk11a3VlZHZT?=
 =?utf-8?B?S3hoVUpwRzhqdU5ORnU0eDFDVFlYTkhsUmVrYzdwZmVPSzhqd2RuNDNDWmx6?=
 =?utf-8?B?TFAwRHI5Y1V0SDN0aytKaFd0OEo2RzI2Tjh4WnBScllnWWpqZG5DN0tUK1k4?=
 =?utf-8?B?TUJqUUZYdG10WkpKVGNwMjc1RnpMYnBVdzZDWkx6ZHdFQkUwaTFXY1Jwd1hB?=
 =?utf-8?B?eVQ3eVdEMkllUmJZOFBXZ1E0UHp4bzBDSW9tTU9ZQjduSUYrYTVWdi9SSmRy?=
 =?utf-8?B?NlZEUVg3b28vdGpDb1JQNnBHcDVvbFI0Z21YQ1pGeTdYUmRuYjBoOVRXSTNl?=
 =?utf-8?B?N0ZhNzc1U2prQ1VGdGEyR2NaOWNLSG51TDBHWndyM1loOWhuNFNsQU9TTDlB?=
 =?utf-8?Q?6K/ovaNTTKdg5CCMtE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dcce98-3d9b-4593-4401-08de9eab4742
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:06:00.6920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkBbHsWpMW7YcLIoqZs/akhMsRM2BH9g7LpKVHvnkGEYrHwu2gc0gfuDw0KyDx+z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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

Hi,

On 4/17/26 22:39, Raymond Mao wrote:
> Hi,
> 
> The Firmware Handoff spec changes required for this series is already accepted 
> and merged at [1].
> 
> Please review and merge this series.
> 
> [1] Add Transfer Entry for Devicetree Overlay
> https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> 

Yes. We are using this series. Once retested we will provide our tags.

Raymond: If there is a need for any change are you going to send another 
version? Just asking to double check it.

Thanks,
Michal
