Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155B6E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F25801CF;
	Tue, 17 Dec 2024 12:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cbn8+CXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DF4801F9; Tue, 17 Dec 2024 12:06:32 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CF4801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjAh2Ap334TKCEhmypsO8DRh5fhlKdat6ZzDONzpLTBAuVkRxN3/LfWDY904HtFsPWORjbqEF03vDehlfa58yiSFEDzJYquN8Ov8XoDWixfu56ShNfh8yQFOEHsmy64+pf08sXqHrINCD1j9boMIdBFfiO7/sUe/6fYKtEzjICqlkSbnIL/T7/WumlEwVLvl7ruxdyu0/h7njRFyLzGlOut+Z/LGzgiW04SVlOkjR2PWFVO83b87VHBTp/XZeDx/RyjDSNoM0KsOXXaWjkKApfWw3oBrEqX1tl48UTQO+WZ8AY96IDGwK9chP2JnjKx9NkOBuJ8PNDPtdui+scut0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG3zbZKCJwpUdoVUAXmX8XRl8t1vlnP58OWjj+HZcos=;
 b=aMW0qgN035E149xe+Xb/6lBnyE6/sou6500EuHV2R2Pz8sx0vDtoEUX2F8SoIRF9wBdRMeaB/eaVZMEsgnWcZkaKC0xCQqPqaCaPogy4fS8qBDU1a9HgajRa/OeEXJO8Lwg3pmwCX6WXs8DaBXcwv79PPkNEuDEDJPUbFMsMkTbtIA6p7dGciA5Q/8gpJ2zQdjSNFLnJY1wL9iw7P6uKmA8bbJ+2GmFRrVbmd3Sdxd5GbAX3onbfcNLHrs+wXpyzhQskss/uke+dXn+VNxbjEThDDop6NXL1TIPot2LIUPDMOQg3aM5LWEjxKuDLtr6XiN8Uxk+ELQ2vsQJ0Tej33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG3zbZKCJwpUdoVUAXmX8XRl8t1vlnP58OWjj+HZcos=;
 b=cbn8+CXzBrn+trD2B5JBtAIkud4514irKt9HEQSbqlSmYAbkfqvd/hmYAOA5NFtxJGWJzJ5vvKifIKLS0ZfKeIw09Coa+3zm+GcBHjmpeMKcGaSwRqjtAuyHx7U2KrfYnLuCfNFkhZjgo6Wf15nEyTmc8pJkgVstJvrDthkVlpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 11:06:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 11:06:26 +0000
Message-ID: <f37f1f8a-7be4-495f-8592-6fe94e683f93@amd.com>
Date: Tue, 17 Dec 2024 12:06:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Sync DTs with Linux v6.13-rc1
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Paul Alvin <alvin.paulp@amd.com>, Srinivas Goud <srinivas.goud@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Vishal Patel <vishal.patel@amd.com>
References: <06e466d64c9d8e718e2f06a76cc65d6da2a37a7b.1733996500.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <06e466d64c9d8e718e2f06a76cc65d6da2a37a7b.1733996500.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::12) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e871f5e-3170-42b7-a119-08dd1e8ad9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1RwRzFaUU41a2w0SEZVQ0I2Zjd6SWFsT3lYY1FCTS9lL2NOMTVzQmlRU3Ix?=
 =?utf-8?B?VGZocktpcGczZ2M1L0RWNXRJcDgrYlUxQXBNVHI1TlZsWjZpU0RRSUdhMzNQ?=
 =?utf-8?B?VlBCOXdyWHZHcWtMdUZ2QjVyQmtsWXk4MUhtcjRNZlZ2TWVpVW9qQVlSSnlG?=
 =?utf-8?B?K1FuTHByRUkveTBiUGpHaTJWdGF4dC8zSGNPNXY1OU5GRXNiTVhsYTF3eGM2?=
 =?utf-8?B?c2dBOXdEM1gxRGc1ckZnb0c5Y3ZwSmNuUnZodEtoWmthZU40RG5iTjNld05q?=
 =?utf-8?B?Vis2MXBmMVRDVXBVU0ZFVUJ6VTluT3JpeHJNb2hTdW9paHF2R1kvK2dDeThI?=
 =?utf-8?B?NnJONlZmYTRWUXZ5emhyU0tlaUNjVlVMQ09sWVRQVWRHNnp2Q1JkamdGRGkz?=
 =?utf-8?B?UDJ2TjFuUExobms1cEZ2b0dncFZUQitQUTNSaDE2a2ZzbFdiem9kNkxMZ0hN?=
 =?utf-8?B?OEJqelBGZUl6cEs4TzlPczlGTU1NSGQxakZGUU84cG9TTFRnRE9FbkFObnN0?=
 =?utf-8?B?eFVsWTVvSXQxZ3IxckhLWmtqS1JpbnJoWEN6cnVwN1k5SGxYVVVDYVY5YytG?=
 =?utf-8?B?aW45T2tnbHltajRDN1lvZVdkVEpHcXFka3psTmVEbDB3a3hjWkRtcldzc2dw?=
 =?utf-8?B?a0dWVTBGKzcvV1ZMdFVFZVZIYlI4SW56TUhwZ2JTQUk4VkZsbjE0Z0lqQlI3?=
 =?utf-8?B?OStpSzBxb0IwcjdtejUzcFlyZ2Q4N3NKL0JGVmVmZUEwTms1aDdaR1lOeUUx?=
 =?utf-8?B?K0JZUE1YcDBETlZ4WWpuYW1sSEJraFI2S01iUHp4SU5WdFZWRjBNcDB2Q1NG?=
 =?utf-8?B?eXpFeVpUVjZFOWc2VVRYNUhIWmdqU0lqMTQrekdocjV2bW9wbSs3NEVTdlZF?=
 =?utf-8?B?Z0xjQ051bzVVMDVTTUFaTU1rWVA5VktkaTI4ejIxNk9pMVRLZmRtTkVkSXkx?=
 =?utf-8?B?azgwczVzenl1Q2xaTDViNDNpSUUxVVlzUXpQNzRPUUorVGcxV3FMSmwyME1Y?=
 =?utf-8?B?L2J2VmZvVGtSSXRWdFliK2xkS0R4dllDV3JETkhTeGUvZ2VEVUlYaVdRZGo5?=
 =?utf-8?B?M05hWUw3dHRhZTIrbU1KWGpWRWNDUjMwRXE1TnY1ZkpqdE5IM3pJOVg5ZWtq?=
 =?utf-8?B?c2NUQ2dsK3NiMWh2eG45NGVRdzBDOTZkdStidDlJTmxJK2JNeTc4REEzRHcv?=
 =?utf-8?B?QnlJcmRtRmJXbzVZUTNVZnZoUnI1K2QwY08rNW1wd3E3UjdVYU5xeXE5WURY?=
 =?utf-8?B?TEx2RDE0eDlkWHNIMEk1UGZtcUZVUXQwajNNcVhKdmZYdWJYWjBsWjN0ZlVu?=
 =?utf-8?B?RlhxeVJQMTY1SElHVDVrNHJhdVdxOEU3WDN2Q25sVTBmSnpxTDZMbkp1blI0?=
 =?utf-8?B?VS9hamt4dzBQSHhZajBJTEtSUTlSdUc1cDdCaCtwVWVLNjZSaE01Q2VLNHJw?=
 =?utf-8?B?OFBGdmhBZUVSUEo4bTBGMFRnVG1yN0IxWmlkMkRoQnA4U1BjazI5eXd4T1pk?=
 =?utf-8?B?ZkFDVFhPVFRqVjA4NEZXY2tRTHJDYnhlUTV6QlVRblJzV3E2YkFobzg2MERM?=
 =?utf-8?B?WXVIY1dQYmo1RHRqSitoNWNteWdwSFN0SU5nM1JpQ0Z5RHlCbkVSQWd1OTVD?=
 =?utf-8?B?SHNlWXUxaHhzenhkTFN1SDJCRmNFK0haUFRTSlRUZDl4bnlUVkQ2cVk3QzlJ?=
 =?utf-8?B?cnQ1eld1RXk0bkZUNGQyUkFSeDg3ejVuZUVvTHMwKzJMeGdJeXZGR0x4ZXNo?=
 =?utf-8?B?dlNWbnJQNVN1L0M0NENrQVlmTjRYNUxiMWlkaUhKaTdpMEp0KzI4Q1dyN0dB?=
 =?utf-8?B?NExFUlBpNWZEMjdTdkJNY2kySXV5dTdvUlJqVWFYYUZnSDFKWnJiS0VyUy9Q?=
 =?utf-8?Q?lcfyU3ONSHESS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BwRnoxbU5GRVRkOGsrbjVZbXIzZG83Zk1mc2NmZ0lvbDFITzhlRFVvNmFL?=
 =?utf-8?B?dFJiM2xJQkFlNERvNTlRczVJVEZhSENLNVh6bmtsb0FESW4xd05DaldUckJC?=
 =?utf-8?B?aXpWYVJiWUw1bHh2RDJ1M25zQ0lJNnA1MmtSYmZGcFNIU0xQTzdBUGNqajlZ?=
 =?utf-8?B?S2Y0eXlJSkowamJSbVZwWmFjVDBDbUdVNkRBSDdnb0N6RmIzRVZtekQ5RHY0?=
 =?utf-8?B?Yi9ycUJqT0EzSk5sN3NSNk5yVDArWWZoZ0U3bHlDWWRadGVxSmptSEluUVRR?=
 =?utf-8?B?OVNYSUxuRGtlcXBTOGNpNUY5L1kzVjRUeEozT3FkT1BGZnFNTENKUWlkYVBG?=
 =?utf-8?B?dDBCY2NpWVZyWHVDUndBTE13SW03dWN5OFg2L3lkWWgvRHVpSEdRMWtaVHl1?=
 =?utf-8?B?UVhxRXRUTmc0d2ovSEk0RFpURVBrdU4yQVJ6U0VsRi9VeDBoc2VZNHBCemRU?=
 =?utf-8?B?Njk4TVdUcFJOT0ZEUDdXYU10UUpneFQ4amRuQWVRK0NNMTRNNDRxNGxaNEwy?=
 =?utf-8?B?WHFac2c5OHFDVXdHWSszRCtza2laR2NNWk5JUTFIdUEwNUYxSDVDamIwTW5i?=
 =?utf-8?B?THJFRTE4UjJzRXBEdkM5eklVVTNTczRYUUdRVXlWMUVxYmx2eGNqc2ZGT3Ur?=
 =?utf-8?B?OVpBQjRDbmpPakxvNFRqNTRCLzRvdmo2b1NLYWNsZjRGaDhzR0x5dFF2RDBr?=
 =?utf-8?B?bFBZZ1RSZ1pMMDIvTnM3UTRGYXZ0RUNsM3pJNXNpUC84NGRtZlB6VFlpVU5O?=
 =?utf-8?B?YW9WYmZPbVdZMytrbXRGbnRUME40WHI4ZWZZYk9LYUpRcEI2ZmE4dzVURTFh?=
 =?utf-8?B?SUlxQVdEZ2xrbnVPUHRjUjVzRnJpNjltV3NaTHpydTFNN3hsQ05mUWk0VVE3?=
 =?utf-8?B?WVBNSDNuVWNQVFZraWk0MU9WT3BNOFIwUWlFRGJLT3FuWitzK0l2QzBOKzBK?=
 =?utf-8?B?eTZGcTBrdTZENmkrOW5DYjhEWjc2Z0FCeGJGQ3hXbmlGcVBTVGlyWHViN0Vy?=
 =?utf-8?B?aVRXb3Myb2RHU2haaElPdE1uRnQzN01rYWxmUzRpY0hSbUs5Sncvd2RvZFVN?=
 =?utf-8?B?VmxvZDQ0UnpzOGZxQzhxUi90YnFyWXVTYTRJeCtyWkRBR0xDSGFTRmtKZ2Vm?=
 =?utf-8?B?Z1RNU3FLTWovV2NOanlxZ29wU3c4YkpBTmw4ei96YWc4M1VUbjJ1cGYvV01r?=
 =?utf-8?B?UUk1QXNwSEVXUytvMVlPUXMvL1hJd2llNU1TOGZ2NENqdTBHTk4rWWYwb29r?=
 =?utf-8?B?VjQycWl4dm1GYW02VXNaOTEyVTBka2svcFRReXZGWFcvMStQRFlXY1dyTHhW?=
 =?utf-8?B?YzMwRXdzR0JJVCtuT052M3BJTU50NDZSVXVIK09tNDhXdEdieGUvcHpwTzh0?=
 =?utf-8?B?T3A4RmU3Zll3eCtUOXY3T3RwZklQNlVmQ0tWUE9WMUFLTHZDZTVaQ01HckhM?=
 =?utf-8?B?N3BaVTk5V3dNeXlJV0I3citOY0JLdXdkbzQ2WjAwNVhtam9kMU1TcG9QQTBZ?=
 =?utf-8?B?eTlBV3h3NWNKQmZXdlB5b0pCbGl5ZFJMd0s0WEZ5VEE2eFV5ekN6YzZONkdr?=
 =?utf-8?B?YkNubkYzZnRBaXBKeE9JVlVGd1lRejhJbEdpODV0TEFFUFhuR2w3UnNUVDZy?=
 =?utf-8?B?cHhpdktTZ0M5MUhtRXV4amVKb1VENFRGelBUeWw4V0JoeDN0aDY3OWl2RUZ3?=
 =?utf-8?B?TXdObnlTTlRLb0E0dytjblZyUGZhQzA1MG5aYWUyZG5JeFRmUzJDNzREdDZu?=
 =?utf-8?B?dXdMM0tDQ3VoYlRHcWRlYWh6N3VYVkhhTjVYeFlzd2VVNGJRQzFrK0F5cHly?=
 =?utf-8?B?Zk9kZFpZekcvVDM3N1VycmVtY3BRd2xSYXBCcWQzUDlCejY0ODJnMFBGMjN1?=
 =?utf-8?B?K1lpMVQ2REFrV1UwS0hmaDZmTjdwZ1orcU1zaDBEQ0hZemtzRS9GQmU5UnFj?=
 =?utf-8?B?cm1wblBvTmhwRFlpSTZKYmNOUFhBdy8zRFVVWGZYeTZYQWhScGRmczUxaHBP?=
 =?utf-8?B?NjY0U2xycjhjK1dMYW5maUgvSzVWV1dJTEVEbk1GQXU4MDA1QTZ2SUlhUk1Z?=
 =?utf-8?B?VmNqVXVveVQwV3k1ZGRFbDZEazdXclE3Y1JJd2hIR3VGMG5GZVRMc2tGT3gx?=
 =?utf-8?Q?oDI/hC8ys9em3tWSFXqAMvnl/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e871f5e-3170-42b7-a119-08dd1e8ad9e2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 11:06:26.7321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0e0lAIRzezIkgvAIdKYrzGLf6E9MXVcJC+GJTiCHgcwXpPthuY0E3ufFlfvL+jv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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



On 12/12/24 10:41, Michal Simek wrote:
> Sync zynqmp* DTS files with v6.13-rc1 Linux kernel including three patches
> from Sean:
> arm64: zynqmp: Enable AMS for all boards
> arm64: zynqmp: Expose AMS to userspace as HWMON
> arm64: zynqmp: Add thermal zones
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sm-k26-revA.dts |  18 -----
>   arch/arm/dts/zynqmp-zcu100-revC.dts |   4 --
>   arch/arm/dts/zynqmp-zcu102-revA.dts |   4 --
>   arch/arm/dts/zynqmp-zcu104-revA.dts |   4 --
>   arch/arm/dts/zynqmp-zcu104-revC.dts |   4 --
>   arch/arm/dts/zynqmp.dtsi            | 101 +++++++++++++++++++++++++++-
>   6 files changed, 100 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> index 620f5185cc46..b514dc27f710 100644
> --- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> @@ -90,20 +90,6 @@
>   		};
>   	};
>   
> -	ams {
> -		compatible = "iio-hwmon";
> -		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
> -			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
> -			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
> -			<&xilinx_ams 9>, <&xilinx_ams 10>, <&xilinx_ams 11>,
> -			<&xilinx_ams 12>, <&xilinx_ams 13>, <&xilinx_ams 14>,
> -			<&xilinx_ams 15>, <&xilinx_ams 16>, <&xilinx_ams 17>,
> -			<&xilinx_ams 18>, <&xilinx_ams 19>, <&xilinx_ams 20>,
> -			<&xilinx_ams 21>, <&xilinx_ams 22>, <&xilinx_ams 23>,
> -			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
> -			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
> -	};
> -
>   	pwm-fan {
>   		compatible = "pwm-fan";
>   		status = "okay";
> @@ -369,10 +355,6 @@
>   			  "", "", "", ""; /* 170 - 173 */
>   };
>   
> -&xilinx_ams {
> -	status = "okay";
> -};
> -
>   &ams_ps {
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
> index c9051360931b..3542844e6977 100644
> --- a/arch/arm/dts/zynqmp-zcu100-revC.dts
> +++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
> @@ -593,10 +593,6 @@
>   	status = "okay";
>   };
>   
> -&xilinx_ams {
> -	status = "okay";
> -};
> -
>   &ams_ps {
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
> index dd63d22f45e7..955810ae7178 100644
> --- a/arch/arm/dts/zynqmp-zcu102-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
> @@ -1065,10 +1065,6 @@
>   	status = "okay";
>   };
>   
> -&xilinx_ams {
> -	status = "okay";
> -};
> -
>   &ams_ps {
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
> index 31effbf27a8e..64d822255ec5 100644
> --- a/arch/arm/dts/zynqmp-zcu104-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
> @@ -527,10 +527,6 @@
>   	status = "okay";
>   };
>   
> -&xilinx_ams {
> -	status = "okay";
> -};
> -
>   &ams_ps {
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
> index 999b2431bdf2..3e883d717c2f 100644
> --- a/arch/arm/dts/zynqmp-zcu104-revC.dts
> +++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
> @@ -539,10 +539,6 @@
>   	status = "okay";
>   };
>   
> -&xilinx_ams {
> -	status = "okay";
> -};
> -
>   &ams_ps {
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 70ca5e6379fc..e8750b08162d 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -18,6 +18,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/power/xlnx-zynqmp-power.h>
>   #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
> +#include <dt-bindings/thermal/thermal.h>
>   
>   / {
>   	compatible = "xlnx,zynqmp";
> @@ -36,6 +37,7 @@
>   		#size-cells = <0>;
>   
>   		cpu0: cpu@0 {
> +			#cooling-cells = <2>;
>   			compatible = "arm,cortex-a53";
>   			device_type = "cpu";
>   			enable-method = "psci";
> @@ -46,6 +48,7 @@
>   		};
>   
>   		cpu1: cpu@1 {
> +			#cooling-cells = <2>;
>   			compatible = "arm,cortex-a53";
>   			device_type = "cpu";
>   			enable-method = "psci";
> @@ -56,6 +59,7 @@
>   		};
>   
>   		cpu2: cpu@2 {
> +			#cooling-cells = <2>;
>   			compatible = "arm,cortex-a53";
>   			device_type = "cpu";
>   			enable-method = "psci";
> @@ -66,6 +70,7 @@
>   		};
>   
>   		cpu3: cpu@3 {
> +			#cooling-cells = <2>;
>   			compatible = "arm,cortex-a53";
>   			device_type = "cpu";
>   			enable-method = "psci";
> @@ -388,6 +393,101 @@
>   		};
>   	};
>   
> +	ams {
> +		compatible = "iio-hwmon";
> +		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
> +			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
> +			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
> +			<&xilinx_ams 9>, <&xilinx_ams 10>, <&xilinx_ams 11>,
> +			<&xilinx_ams 12>, <&xilinx_ams 13>, <&xilinx_ams 14>,
> +			<&xilinx_ams 15>, <&xilinx_ams 16>, <&xilinx_ams 17>,
> +			<&xilinx_ams 18>, <&xilinx_ams 19>, <&xilinx_ams 20>,
> +			<&xilinx_ams 21>, <&xilinx_ams 22>, <&xilinx_ams 23>,
> +			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
> +			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
> +	};
> +
> +
> +	tsens_apu: thermal-sensor-apu {
> +		compatible = "generic-adc-thermal";
> +		#thermal-sensor-cells = <0>;
> +		io-channels = <&xilinx_ams 7>;
> +		io-channel-names = "sensor-channel";
> +	};
> +
> +	tsens_rpu: thermal-sensor-rpu {
> +		compatible = "generic-adc-thermal";
> +		#thermal-sensor-cells = <0>;
> +		io-channels = <&xilinx_ams 8>;
> +		io-channel-names = "sensor-channel";
> +	};
> +
> +	tsens_pl: thermal-sensor-pl {
> +		compatible = "generic-adc-thermal";
> +		#thermal-sensor-cells = <0>;
> +		io-channels = <&xilinx_ams 20>;
> +		io-channel-names = "sensor-channel";
> +	};
> +
> +	thermal-zones {
> +		apu-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&tsens_apu>;
> +
> +			trips {
> +				apu_passive: passive {
> +					temperature = <93000>;
> +					hysteresis = <3500>;
> +					type = "passive";
> +				};
> +
> +				apu_critical: critical {
> +					temperature = <96500>;
> +					hysteresis = <3500>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map {
> +					trip = <&apu_passive>;
> +					cooling-device =
> +						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		rpu-thermal {
> +			polling-delay = <10000>;
> +			thermal-sensors = <&tsens_rpu>;
> +
> +			trips {
> +				critical {
> +					temperature = <96500>;
> +					hysteresis = <3500>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		pl-thermal {
> +			polling-delay = <10000>;
> +			thermal-sensors = <&tsens_pl>;
> +
> +			trips {
> +				critical {
> +					temperature = <96500>;
> +					hysteresis = <3500>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>   	amba: axi {
>   		compatible = "simple-bus";
>   		bootph-all;
> @@ -1153,7 +1253,6 @@
>   
>   		xilinx_ams: ams@ffa50000 {
>   			compatible = "xlnx,zynqmp-ams";
> -			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xffa50000 0x0 0x800>;

Applied.
M
