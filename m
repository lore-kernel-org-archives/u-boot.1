Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48086C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 08:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F7484085B;
	Tue, 21 Jul 2026 08:07:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9jYEWkz5w0ps; Tue, 21 Jul 2026 08:07:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F77E40844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784621277;
	bh=sbEmKXJIg6hvdAQnP1DK4Zln22lrrQgHaYNlCaTYInY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JFiyvDWjmd/t/na3SwO84s5CBxhidp4geXeU1gC9FDIEKExs3oPk3TD3KOtYtIC0l
	 v5totII8hQCocubUZ3r3bvKV+6nDVXWCq4sCt2Y+JyP54JD3IInaRyL9kqCTZXb3kh
	 yl46nu6VSf98U96TzSitaxSFtxtQSZMvtAV+Nz21z27cDhL7fwwGm56Mp7lJHpnL6k
	 wUAtTR4DNmQJETyo1HwGcVisQJeUY0P255srEcQsmrMfPKMgGLllN4bBjVxRd9pZIz
	 2VIz8FPAN0uvhZIS3WKIAz8gzR9VHYwsUfcwRypZTmO2dmKDXA3lcy0EOiC1lfjT05
	 c0CjZwHzJ15qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F77E40844;
	Tue, 21 Jul 2026 08:07:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C61C96C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2215980DD8
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Z0wQ2yxvehQ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 08:07:55 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7777F80DD7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7777F80DD7
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7777F80DD7
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:07:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133E782991; Tue, 21 Jul 2026 10:07:51 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B723803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 10:07:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwVlZJ26Yidr7KZirGhKVAq3XqN0RJQO694KHLiCBLC+G44T0h3gF2xqavjXyEJ4m14kGbcqYqh3nMgLBBu6be4ByvWqnMLFiB4MO3/AEWQ4LWV9y80VONSVLDLWait96DyjO16hW8MWBb6e0lFca3zeimKRnkXL+niKb8rvA1jqxLdI/n7vM2kyoEar1BzqN3RNeOnXex3uuPE7p3t7fBfDm1VHWuikQzD725iPAcNTDzIH2vGrMimkuhhJUu/sLQUUQuWhv4f0kDiwdIm0pKvjzs32l7dt/KAgFEhqXq0Wkx7wIeAXDZE1ufyQUGi7d+ilx0xObfdfm10mEWcLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbEmKXJIg6hvdAQnP1DK4Zln22lrrQgHaYNlCaTYInY=;
 b=bKUuU6kuoRj/NwEVB9U36yEaJGpZ3neMxnn6at5IxU2oozEBnQNwqrbVFZtZM5MLpc5LLQqTNI9l/yFLLymzItqW47qHD5cE6rK0V27txMV//t4w+jQzxqS1CFyWER0kijIUN4K4XjsN3Ws8xOdnBCDqhj2nkpLDr8lxiL4nMswdATqxmSRukHyj0nCk0Ac7NYaoEldwxpj7k1ZsbFysKm3G751x9txZSu9iAmF0x3yXgno2eWiVzAabIhQJ6mbAMe/ThGDFiFBELInMTiZi8knlW8w/+gh/c1qxSOlDr4gc58wug/UpqnQPkwCQhq44HnvToyVxcimuj882GZpg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 08:07:42 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 08:07:41 +0000
Message-ID: <5c6ba716-263c-4a79-aaaf-ccf714050b75@amd.com>
Date: Tue, 21 Jul 2026 10:07:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] i3c: dw: fix slave device setup and probe issues
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Dinesh <dinesh.maniyam@altera.com>
Cc: git@amd.com, padmarao.begari@amd.com
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1e4f8c-3781-45a3-4a93-08dee6ff2366
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jk/8f7mUZf61ugv1o5fZa6QdAaGHdy7M966CxqSRxv/n1Xx24eLtCyYEEiW6yQ0O05yey8newXVVhCeZxyqycrvQcbrcFpHB5jlO34MTl8idpfgJYLtzZdzjPDsV9+7FnpZG+fICIMLclMbNsQPn+oyNNNzFZAtOrkYbaofIhcbBNcUv4O2RBprxnj7BeC96yh2SiCdllxk431VjwYrxFUzgg0GBQ5qQKiL1t9JH99z8nwXVr4UrY6x4274d59EvMbYk47SnlqtDGuCFaEIBLwYyfh05yL5SSUpm3E96wv044NPeP7hb91cR8HXTNVIjulw8G8NekpKaT9szT4cKsqaAmAIw6aF/5CSUztYVKE0AU+kv4yb73uA3cALhvocb+ih2CCzcqybsL6dZp4FcF2dcK63Zj9IZlGgwEVT2f1wg/Bg85wneo/1hvN8J7C6kRjxa9+0slrFjwlIsOhiO1zK5NM4p1S+GQD9q3eXHAxnjmwJO2tKFILuK79R3H9B/xkdGS+YlbrGnvHMmmjQ0WCpfz2VX6G+PrINEC9TdIrMdXTi5iKGyQ1I3soQhjLSADHzDF3ANg8OKAsZL98ID54iBm+hoTA1oPwAY+vR5sjHGLK6ItvFGCgeryOBntJVL1pS25H1d7apbR3AxcvMSZQ9cYfavXwy70l82t8Wg+eI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVgyUkp4dFdxaktjMklyTUxWMlc4YkxScUorcENMdC84QWsrSC9ySHR1UlBx?=
 =?utf-8?B?aE1HaWtXUGVtYWdPa2VrRmVuWFpXeGZ3dHB4N1pOR2QrZDluUm9mWW1mYkxQ?=
 =?utf-8?B?cmZKbDJOYjVVSFJKKzJxR2tvU0ZCWjNwZWNWeTR6Wm5HSEl1bW92Vk9ROHhQ?=
 =?utf-8?B?OVZVNzJUZE1ZVEluVUMxaVhpOU10M3BLYkRhSTREWFQ4cGpZcHBQMHBtQklM?=
 =?utf-8?B?Z3BScDVhSUtmWGZZV3BSMkNCOGJFYndNbDVjQ1V5T3hXbi91aXgwelpsVFNo?=
 =?utf-8?B?Zk0xVXBaWEVOdlhsbmtXYWNrOG01RlJDL1BhOHRhckhyYTRSVTNDeDNlOTFD?=
 =?utf-8?B?MDdDUWVmeWZWYnU4OS91dTh2dFM5SXQ1Yzk5bUkzaTNqb0gxWlR6YkZidFdE?=
 =?utf-8?B?ZzJrTU8zUDcvMCs0K1o0ak9OdE4xekdQZ2V4TGhJUFN3R0JnS2g3R2tyZWY0?=
 =?utf-8?B?YkxFUUw2bThlQjRmQW9uc21yVDM3eDdVWVl2aEVlV1QrcHIyYklPT25ZbjdP?=
 =?utf-8?B?NFYvS3hVUEFnQWZOdXdKSFhRY2IyL0lWWlVpSnZISGN1VzMvNzJwTFFRZkdI?=
 =?utf-8?B?SDAzMG13YjcyTU9pL3RoVzd2SndCTG1PMDI0UGVmRFBmL0E4emk5Mk84RXdG?=
 =?utf-8?B?eWlzeGkzT3FxY2xEMUNFTWg1RnpBTW5jTjhIM1dISEkzZDVKbElMY1NkZERN?=
 =?utf-8?B?M0tpVU5saFJoMFZ4UnB6T0E4Z0x4Nk13VW5Vdk81SXlzakFLUitBVEJkU1RQ?=
 =?utf-8?B?aDZhaklwN3ExN2x2ZFNGSklleXhRdjg5ckhqc1BYVWFhWjhvYk9FRDVwRXFk?=
 =?utf-8?B?Q0w5bWFpRzFRc3BCYzVwSVcxWTdqRkNBT0o5cFRtMFFEK3dITkcrSTRNOG9Z?=
 =?utf-8?B?OWV4QjV6TFByZStYcC9MZkdiTHRoR3I4YkxoblNwejN5a3JGMVVVd1VjOG5H?=
 =?utf-8?B?WUVnNUd6UG4zQlJXcGlxaHR0U1JXY1ZFSFlqRVlKR2lCUUVHdytaSUZXMzhR?=
 =?utf-8?B?K0NQVHhWZi9VZnU5aEp2R0JkUHhKS1lZSUUvR2NGZjJZenVUTllLSW9PMldS?=
 =?utf-8?B?Z3RCci9QemlneFdxVkRKNkxQWGdhZ0YwYVNZR0dHdCtqcEh4QWJIck5IRDN1?=
 =?utf-8?B?c1hIS1FZS3QzdldnbnFZK1FwQVBSOVVNR1lMSjlGT3hUNW9uWTVVMjZXOE03?=
 =?utf-8?B?U3BwODFzVkE5R296M1JtYVF5dE0veXpKUU8vZE1OVXdNR1NrSC9jR0xVR2J4?=
 =?utf-8?B?cUxoNUlYeitKelI4OXJ0ZXoyVEk4bzVGalJlUG9BTTgzOUZrZnVVbEh3WEdv?=
 =?utf-8?B?dHA5WXBPcUtZMSszWTgwU3dlZDRPWktWR0ZBN0VBK1hpRiszdjVrSFA1U1Bo?=
 =?utf-8?B?cE13TjdIRWJONm9pVmVXdmJreFRaM2Jnek1jOVUyZkw0alpqb0lNMVU2ZkVs?=
 =?utf-8?B?R3E2YmkwNFRjUHdjenVaaytZOFcveVUzWFU5dVpFRVl3TXM5ZjVSbWhlNEg5?=
 =?utf-8?B?Unk2N0lvVXFvdHdSeXNwb2F2ZHdFb2lrZDBaNk1OanduTC9HdVhrNVlhWE84?=
 =?utf-8?B?djQ1VFZ0YTMwVno4UTBkWE05QXVwLzFXTWRjTTlrdzlrYlVzdHlNNEpPQzVO?=
 =?utf-8?B?YWxKNkJQai9oNW9mdjM1bkZlcCtXdC9yVjJjVS9jbndzeVhuOFhoa2pHTXRK?=
 =?utf-8?B?dDFCTUZ5QkUzYUtmVE5UTnhLdWEvU1FLQ042RXlMVm9Bc3ltODc2VHZzL3JL?=
 =?utf-8?B?NktOY2h6RURzUmRWOGtFSC9ZUUlYb21XR0dJSW9INGhwbENsUEFUOU1rK3d3?=
 =?utf-8?B?SS9SZEx1SzVuQWNsWEszWkNzUnB5OGlremNRYUVYVWt0OC95V0lYSDloTitj?=
 =?utf-8?B?TFVsRUpsWjh5YkhZejdMZy94VmFKUjdJQTBpVXllamNzUUlxeFZIbzJ5Qk1B?=
 =?utf-8?B?WnUrZ0pUbDl0ekswMVBkN0QzTFB6UkVFZGE2MjI1dGY2N2g4YWdRa00rVkp1?=
 =?utf-8?B?dS9sU05vR0JaanRmT3FOM1B1U1VtSlFLd1JHY3hlTnBqZVNjWFBSdFRNelhl?=
 =?utf-8?B?T2tFOWRISnpnNHJhRnJGUXptQ2EyaVhFZzRxNksvS1ZKU1FRRXFVK0F6Skdt?=
 =?utf-8?B?RTFNWVVlSTRGZHkzbkQ5UEVUOVBoLzZVL3lDOVg4SzFDM2Y1WDlPUVNvbUVs?=
 =?utf-8?B?VS8za0ozSVpMQ1k0TUFaem9hdlllZmZNZ2dLajhxYWs4SXlzVlRiZWxJNm1Y?=
 =?utf-8?B?YUVsSkJhS2ZTai8rdG5saW9keWh1RXMvZDU0SnVRSk13cTVPSUZyMGxTL2d5?=
 =?utf-8?B?ZHpnMlpaODQwWWlocFIvWmhocnJlZXF6WTdiTzUya3JRMGJpNngwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1e4f8c-3781-45a3-4a93-08dee6ff2366
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:07:41.8959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyufBpzVrWtwTUn/BBxrl1/MtT1mQQYDjfig31A/g4UfaM6jEJkHkaabJUGQRvjg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbEmKXJIg6hvdAQnP1DK4Zln22lrrQgHaYNlCaTYInY=;
 b=KeKD875ESxOdXvDoqbkuS6Wi9EYbMmDL28htxDED2DmxfkG9Hc3FlaOIoKE1aWxaF6hVz/GKij1HohsJ4iMLeCzW4ffqDB4/0Amp1CsQeiKBCeB9SmkI3pP+sO6qd/Y2pZsZLmfPrhWqvivfcjbrGEB4BJdJyzoDEr7hgxteh/E=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=KeKD875E
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=michal.simek@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="KeKD875E"; 
 dkim-atps=neutral
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
From: Michal Simek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Michal Simek <michal.simek@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Dinesh,

On 7/9/26 11:12, Pranav Tilak wrote:
> This series fixes several issues in the DW I3C master driver and
> related infrastructure that prevented I3C read/write operations,
> and enables I3C support for Versal Gen 2.
> 
> Changes in v2:
> - Use -ENOTSUPP instead of -EOPNOTSUPP as the reset stub in
>    include/reset.h returns -ENOTSUPP when CONFIG_DM_RESET=n
> 
> Pranav Tilak (4):
>    i3c: dw: make resets optional in probe
>    cmd: i3c: fix list and current needing pre-selected controller
>    configs: versal2: enable I3C support
>    i3c: dw: fix slave device setup after DAA
> 
>   cmd/i3c.c                          | 11 ++++++-----
>   configs/amd_versal2_virt_defconfig |  3 +++
>   drivers/i3c/master.c               |  1 -
>   drivers/i3c/master/dw-i3c-master.c |  7 ++++---
>   4 files changed, 13 insertions(+), 9 deletions(-)
> 

Dinesh: Can you please look at 1/4 and 4/4 patches?

Thanks,
Michal
