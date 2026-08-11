Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBDBC5B56A
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 12:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F94E605F0;
	Tue, 11 Aug 2026 12:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UIsoIiBd38M; Tue, 11 Aug 2026 12:53:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 809BE60618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786452828;
	bh=qxT95vSAZ0ctvDiB8T+ma4eHNZcWjWnlHUM2kiBL4Cg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w/2W61Tpkl+yi1p65HCPhaOj9CiclGzDv4K450XdK2XAmiAIxOu+zTtGm2kO5NmdJ
	 FlNkLRTvmNnQN/lP4VYa5vzUSpHs1aw4V9zABUd0iXuCAe9GDtN0QMWlcWIPZfSr2L
	 mgDh15nhKfSrpG6EmsZrX8yxgoD96wCyw8nd4RXw7j44xs1ljAW2+M+8EfXbgCVxDL
	 qy4/klcHA5xy3cz2ruAvIe8n11S1HCPVYdY6kgebkXQhRvY+PRFr/rEvBKTuIT2iTS
	 Tj9A7ictRg01wfdkJ9U6US7YY9goAMSC7d9hzERYX3IXk/2ShQi5idth88Wmc3Saog
	 3jx4YLMNklXxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 809BE60618;
	Tue, 11 Aug 2026 12:53:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AC3328A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 588EF400DB
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fCR8z6SBtZB for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 12:53:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C502F40086
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C502F40086
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C502F40086
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFu7JsWL8PEKmH62Mgn3/DtNe/hVwg/korGz5kSKNSRKVvupP9teUaY1nV9D0dCagqW8GxZnSzTwxpHfnq83KO9qtmxi0H7/FlYCJWompShfUhHIZe8dqD5tWoPEiiMhAIh3OSoMAQP0kSGXKm/GdeHduHVwUvvG/UXQ8fdtOTrxaBbkXflP2WNw9iJ1f2n/doNJWzHgbBWWHGWZXupFH5WM0Ot2Q9DpwJeFlxLasf7FtD0dfrzYO34gAPiWCKuoAWE61T4ENC6WW29+sdUUilYmZJf2l7OtpmPjarUWElwYoSqNjkyBKrpq+7+o9c+kP2ulwj6gLHAfBPv4Fjr/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxT95vSAZ0ctvDiB8T+ma4eHNZcWjWnlHUM2kiBL4Cg=;
 b=yt2cI5RrRCBCzy2RXj2pkEMgMnbszt66R+Vo8ot4RVQdypI6Gw7Ug3XA25qmu3/ZmrY9i/yPGp4G1gl0889TYbS9CX1n1oR1Rp7X5WPxH/yt2lbp+uu4q+6BaJJcAYErRn5MF5lefdwu4oy18l+CReaFzx4sWErX0TQ5/+olwTf9nuJ5ClCh3BriSCVWfqHrJI9+l4Y1DKwZ1w/2dbdyimNHEZQlKMuQdLg30/y5lNFHC5L0zjqc2XA+c7jm2G2ZJwmEhxzjlGK0zPsJBIAFBXEv56tyhuGbkpzG3KUhoZc73fXKoitftRW1TbKHnfdEZ7STUHwlyA3n6Gshbwv5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 12:53:30 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 12:53:23 +0000
Message-ID: <319a293f-6e6c-4916-830f-17033fae55c6@amd.com>
Date: Tue, 11 Aug 2026 14:53:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ufs: amd-versal2: Cleanup firmware interface
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Alexey Charkov <alchark@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
References: <cover.1785394153.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1785394153.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0426.namprd03.prod.outlook.com
 (2603:10b6:610:10e::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: d250f1cd-de63-48bf-2d3d-08def7a78755
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: bUyDUeAjOgP4bWMGm3Dvp00lfH1tQFBs/nz94AHL91u7m/Dnw9P5Ud7KJgt5uI4z/9ILxJ8o09aVWxaIIVFSza/4+9WSIpyn/9xAQnLv1taCw8NAyxcUR00pKXp1j94WhEbWzSzrc8R1LnlrELW+pxuJOUfXjHlWdHiyxp/wZGMf0s7XLEImQ9lIo1xOswBvrfEFC5kER0OF9jxY9vgEB5uZv112McpUKuDVOF6Z+EqWUK890f7rIHcRLNLwIjDA00ZjVsDmOf5kQOM8+q58GE98zd2JvBOI+Pd86c3Dd6UPjwFxMMDNZKtRNkvDF96nLWSEnsmW2eK1Ro+HTMxB0R3l8l9Yt6JdRkcp8a08QIP6zI09kDKN1yB+2jKvavXvD/AvTbpWQrOF1QTSWSG8hBVKuZB0OXRTmtevXpOnzV6nxY9jF/FFaHsRic+KBldWHVvkELCNGPUVb8FpqzmtlhTRWovJJAUMrYyibo4xtZxqZ2QNWBvsTU7E8nygWo+px5rQEFZ15d5jMi4GPx53RqM/tOXjvU5ctNbmNFg2sXv1f+OO/TZrDXHNBBXyNTp2oyLqmAyv2W+C17/ZdyNIkJ4jrvHiHi08dO8zV06B7X6R5kmt7Mnt5Wot/b+p6pBarz1EEth+DWJIZxXX3p4GbDuYCBR8xqIwR3Jw2Aoil+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdkMjRaMzV4UGdmTkVGc2NMcTBOZk5vdWZrVmliRDNNc2Z0RDZkaUFtaXBn?=
 =?utf-8?B?VEY3Y25XTXhnaUdNMk9jbEFTV3NMWjlDUHdVd1BHd3RqNWlaWEw3YnR5SUdD?=
 =?utf-8?B?VCthckljTDlmb3pVTDFnSTdEQkZvV1V3S3pkbElYbkQ5V3l4MGRiMWl4NlI3?=
 =?utf-8?B?VU13VlFkZjFFSkp6My9YMTFvTTJ2cklaekVMZTdWVytKejJaNXgvcVRCME5P?=
 =?utf-8?B?aCtvZENLN1loSFFHekR0SE5sQjViK1J0WDgvTEszS2dRelRPaE9QQkMydHFY?=
 =?utf-8?B?ZE15a2crK0xiUEtUajU4dW02WWJNQkQ0Yi9PMURaam9MYW16ZkF5c2N0V1pQ?=
 =?utf-8?B?OFpBNEZ6UXBKeHAybGcxRHVWMEgwMWx6azFEUEhtZExPeDlSU1F4dmRzVGNE?=
 =?utf-8?B?LzV4V2NzY2tBU0RPclVHR1E3M045SmdsSldGUG9uV1BHdWVzaHR4TW1QU3I4?=
 =?utf-8?B?b0ZmRXkxU2NUTnczZllMMFhBd3llNzFzZHV0NzdzZTJPYjFYb1NnNmp3aVFR?=
 =?utf-8?B?cC8wSWV6djExUmVRbmFjeUxaUTlZL01hbnV4Nkl4SzM5Z3lyQk5iaXZJWmVT?=
 =?utf-8?B?VFhsMU1zZ3NXYkVQU2U0dG1FdlFhd3U0MVBDNFFCNzdxT1pGL3dDb2hvUVpC?=
 =?utf-8?B?U21xWHRhWUhtVEhJMWFYeXByeWJqV0lhWUo1ZzduQjZxOWtveVorZUxMbjBQ?=
 =?utf-8?B?T1JLcDQ2RXk1UU5JdWFQTXA4U0cvcDJ6eHFBVHh0bENlYTBWSnJYc0RiK21Q?=
 =?utf-8?B?WFJVZ0dFRjJvUzVoUWFvTDBib0REbUpnc09WSUc1Yk9PKys4Z2dCSWZXamdS?=
 =?utf-8?B?QWw1UXZhN3NzdWlHWEZzSDNJdjg4S3gxK0hzUk10QUZqODU2VUVTajIrVS9v?=
 =?utf-8?B?UTRrT2VHczVPRUs1TDgyOHRZd2M2RTZISXlhejJ6SXd1UEtxeTB6ODgwQWVK?=
 =?utf-8?B?QisrMFh5MHpkOTRYZGJFMEF6SFhLRFh1c0RMbWVaaHhaNk83SnY4NnIxbW91?=
 =?utf-8?B?Mkhna3VteGpUVEFRbFFUellWbGhMZUp1aDhtSVJoQ1BxbVJHRnRLWkxjOVdH?=
 =?utf-8?B?SlY2UXN1dFV0UU84YmlCdmhORTBwQURoOWNwN05Ca1VQcDJKK2N5NlVobWRR?=
 =?utf-8?B?dzF2bDRlRjRCa0R6cGNSQ1UvMjJEQUFKcnAvdTNVQlhiVDBpSmJ5Ti9tSGht?=
 =?utf-8?B?SmxnVjR6Y0R0N3FoWjFoY0VUUThiOTBJZnlrc0NLaWJwTEVpbnRtT0FaZTNx?=
 =?utf-8?B?OVJ5WkwzYTVLQ0JzcEhtaXdzUFJQQUpGdFFBNTFWNWwrbWxTNzBsRjdrZE5v?=
 =?utf-8?B?S3lWMVo2ZzdBMUhra21zdWF5NnFTMTlGMEV5dTIvOUQxakhVaVQxbDBvU2Q5?=
 =?utf-8?B?MkF1ZEEzeW5YUGZkblVGenJDbWR6eCt5SWpyVFBQTUNqY0JVNnFGcXFZVVAx?=
 =?utf-8?B?a1pudlhFQm5DUm5vaCs0K2hYOHdWcXNjV21SdnFGeVgvejdPbzFHZVJtY0lx?=
 =?utf-8?B?aWlvNzVqWGNtWnVDZnNwS0I4bzdnTUNZVjJkQmN1ZFEzM2ZsR0pwWTVla1Yv?=
 =?utf-8?B?d05EQ1duZWhhaHg4U0ZZRWtHamE1RHUrVFcwc1Ftb0tramtYblBMZHZKdHNX?=
 =?utf-8?B?emJ3dTBBRTU0YjBHWG5QQ3dPbkpMdnBxcStHclFXeTR1dFNSVXJjbXpPQVds?=
 =?utf-8?B?b1VXemx4Rjg4Rlk5Rk5qYTJ5NXFnZEZDeWtoeXY0aEtraE5MSUtFSkhmUkU4?=
 =?utf-8?B?aXBORTZYbEJ5amdIcjdTbUlTTjdBWElkSVl0SEhCaU14RlpZMjBWbHBpZWZI?=
 =?utf-8?B?OEV0VU5hdnNmeTlpU3Y3MXpkMG9LSWQ0aFBJR0JxSW9MNXA5d3NmQ2NqcXFJ?=
 =?utf-8?B?REVyV2tja2NkNzNteFpXV29FNE5wWXNzUHozTDJhK0tveS9FTzg0MHlBazMr?=
 =?utf-8?B?ZlQ4NlJ4SjFtdHlja3p0RlR6OFpVUlkxdjgwMXI2R2J1OHpmUm1sdkJTdVE0?=
 =?utf-8?B?UUhnZGl3SHIyZ3ZZbCtob0N4c2xpOFJQWUJLTDdtb1dUQVc1dzc2T0czNVdB?=
 =?utf-8?B?emFEVFpnQm1STUZ6UDZSeVlRdDU1cVN5eGpTb3hHcitQQkkrVlAwemQzeWU2?=
 =?utf-8?B?c01FMWZDTEY3R1Brc284dnVEYThFdjcxVnJsd1FZVFBiWUFPRU1aT0J0V3E3?=
 =?utf-8?B?aHdvb1pUUmIvRVhhZ1ZhbFM0V2t6VzJGYkNRTXV6dUJiR25SY2l1QUNQU0N5?=
 =?utf-8?B?RzNCdmZ3UE01U204RlIvV1hYd00zMDhkVTdPYnNwWXBOMTM5RUZSZGdEWWVL?=
 =?utf-8?B?UVFQSGp3TmtraTRLYi9GREp5YzlENDdhaHVLSjlGOG9RbktKY2lHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d250f1cd-de63-48bf-2d3d-08def7a78755
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 12:53:23.6459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce28fHlkSscUxBrXzGPz0ymb2oOt6t2RrYcuHCl2Qb9s3iuwaTP7wTWLxW4Iph+m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxT95vSAZ0ctvDiB8T+ma4eHNZcWjWnlHUM2kiBL4Cg=;
 b=ZfmwEe1kaWovG7VTGER90ZFazViNKs1TatEAPMUkSLZG/Acq96Z3SnJQxTDBUs0B8PiXgwDnfeMObu3/MushaROOkAbXmHydsHsNBXKQz6JSKbEOVyyagABYxr6HikrwQ/4yH1CaIcmxW6tHMam0MMYpsh6j9tBo6RTDLuN+2BI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ZfmwEe1k
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/30/26 08:49, Michal Simek wrote:
> Hi,
> 
> the first patch mainly alignment with Linux kernel version. Issue was
> related to IRQ handling which is not valid reason for U-Boot but still
> correcting sequence make sense.
> 
> The second patch is moving firmware handling out of UFS driver. UFS driver
> cares about delivering functionality. And doesn't really matter how exactly
> it is done. If it is done via firmware interface, via IO polling or in a
> different way. That's why move loops out of UFS driver to be able to use
> different interfaces for it.
> 
> The third patch is just Kconfig update.
> 
> The series is based on
> https://patchwork.ozlabs.org/project/uboot/patch/6419fe4f6f1f451aee624c7762b7aa690d50e498.1784870711.git.michal.simek@amd.com/
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (3):
>    ufs: amd-versal2: Perform controller reset in the init callback
>    xilinx: versal2: Clean UFS firmware interface
>    ufs: amd-versal2: Remove ZYNQMP_FIRMWARE dependency
> 
>   arch/arm/mach-versal2/cpu.c                   |  34 +++--
>   arch/arm/mach-versal2/include/mach/hardware.h |   5 +
>   .../arm/mach-versal2/include/mach/sys_proto.h |   8 +-
>   drivers/firmware/firmware-zynqmp.c            |  72 ++++++----
>   drivers/ufs/Kconfig                           |   2 +-
>   drivers/ufs/ufs-amd-versal2.c                 | 129 ++++++------------
>   6 files changed, 119 insertions(+), 131 deletions(-)
> 
> ---
> base-commit: 7e24149aacb83335fa997e2457144f23ba5e1bda
> 

applied.
M
