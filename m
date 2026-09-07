Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACB3C79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 07:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73DC360650;
	Mon,  7 Sep 2026 07:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iy7g2mR7xBPT; Mon,  7 Sep 2026 07:01:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 66583605FC
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788764492;
	b=DGNmI0DW+qNeb2nT+bXFosi7w9mCEx4LohioNSWEXaSUwqPp3T34C3lBGWmSmoGECACo
	 kYNtvyH1au3Bfo4DLYPD/JwOTtKJIx3mnDtIfbyOECgdchd9tEYzF/+arBNNW0gf9kHW5
	 XEXkuWWtddUvDPM+mi6R2S8bYQHF0x4huw3FgVfM3BISBO5KDzzxKo5d7LQV4c5aamyrA
	 ENrQkJ136/OXVR0BXXF4wt5CWqK43kJDekRJMQ2DYi4SJjY9E8B9ICQPpo7YUT/HdOYb+
	 2VKtzx5lIh+D91IMdEssYNw6xROSpP1tjv2Of5slvghKDUV4abGQXxN7Mo0tSDJx/kA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788764492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vMa7xu1Be4qg/KVexNhCr8gJbrikzZt+vOlSD1R4elc=;
	b=ToiE9OxXQ/zVVVKTW6ocS/vVcJydBJmuj3NlgF26Kh4nwnwDEEjCYSbMHt/7zdchnwEy
	 /Vt8/qBAnc7/u9sieOYzFD7MOwyVc/Qa2/fBXoZuMfem89kPnupMLizufceB4WiLaqWKs
	 ZVL9q03Bj21wzs+O+6cOE+AdehS+Ok0kCtYnMrZnonGFf2aoD2SNYzxvWlU4TE2WfOb5W
	 BhuZUxuCMYZJ+43cS0wsjgOrVL4drtbjBbXjMRvWR7bZWa1ayFCgVOIdJB7hLJAgSrSAE
	 iKYbtmUGRP5mHJUYvpCNL8gjcq9T7gPOGfdCSsCFwXos4PBBLi6SiQJbdE4rk1dd2YA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788764492;
	bh=vMa7xu1Be4qg/KVexNhCr8gJbrikzZt+vOlSD1R4elc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TaZb+rv/9gotT8F+wwa8wWpagrum7V0A8MT8gGNSc6QjB6qyCljwDq6BbAfMJlCxe
	 QdLJ1kdlobus7MVNq+LyHGsmWr1Lgu09GL9iN1aqrkcVK0IYibaHcJp3mFGYZduhli
	 zYsNk1Igi2K67rvtEg9tQjTTVZPcNet8FGcYcvWWPwkpfKp39CXBlAuAZKnnYMMPxf
	 oFGDfo4PGRvP3vqjSCXtfM6R005+s1+0mVM+cCdCiwRZ1tK+digzqAiIjph/ti2W3Q
	 gPvL9343nSLlGdeyU0bDwZ37qh809s5nRYZvGHWH4ACy0fe4mAtMhM/u5dT2BwtK1c
	 uU2jhrxXl+rTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66583605FC;
	Mon,  7 Sep 2026 07:01:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F90772C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 857DC400EA
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqadTsBjg-Di for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 07:01:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9CC6F40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788764490;
 b=MVh+IhYEAgf5DpLQv6Q402Q6OkPHK/9lMiz69POfuwxbXoECORlJ4OHxQ5TnFX978RfJ
 pX4BqXVDrUwIynjlIXeSKdzyk01rtTdU94XpE5+gJg16vf+qCe0ngcrwaR++O+O2LWIcO
 2Bvj3OFHddTxQtlTQUHeOsQZriMeIF7b2yPxYNvW8kJzXI5nOEV6+wgzQWacMyOrBtiOI
 uwnpnNAlfrhfOlqVUfhAZH76+Avp/Ni0872lxcy1zoVfDz30gN0fqSpeLZCxYt+96HQKZ
 foG6OjV/75q1vZwH9LDE7m/PxmgEOeTFC28oVgDlsHazz5jidNy93TaBBU+wCkqZImA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788764490;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=vMa7xu1Be4qg/KVexNhCr8gJbrikzZt+vOlSD1R4elc=;
 b=Sr+UTNnLibycTglT8PWMBXHZzPevLPgiNbZPRUV6dNdDFTtTo/lmv8XddsUyRvjMQmmJ
 7WYMFrL1j4qrldAT71q0fLypDg++d6jQfbt0/yzabUbo4Pbx8MLj5C4Mhzyz52Cob5Nil
 XJwav+FF3f4w97qFsFx933euZMpkw+lXBvQjb2CAtRDaDKTx4lkCHN82PuG0feFKZNseg
 TUY/e7aUOQNLz9yqQD/mE7T8JMCFqYhnyIaHrLz+RjZm2HfmJ+5ecu5mIqxgzWkD9kFOn
 obkRFBk1Yvjdh4itM8pGd3ABICgv5aOqxvoEPYAtjkpSPEhLujkf95cE0rzRIy9+gPA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=xGdoP4Yb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=xGdoP4Yb
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CC6F40068
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwsh/pZXILrUgaX60E8APnv4Mun74Wz8KypkZhldqGfJs56+wIolK5zgehQ9DvoifYVt2YdFRpSgEwWUgSvtqDlyvpmL93nJwK8UawdeTraQSmuohtlcFn5qLRtjppOUrmJh23xOlD6N7Q8/S5LEyusoLE6hs/C1FIxvQVvBySx0BR9ZJ8z0wyTN8bk4Il9g/1j3sau/0YAf+FWLwcADFk62ZpZFHr38jufdHwO1yN0+V85ub8nMD2Ul3suEmXXhAQdxjXy314je+XbHTW/uzi/hM5FnysFlcZQFhd2wdCFuZdL5QOZRSXUFCxDJ9Ism22yk7QkWEJ2n//k5NDFzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMa7xu1Be4qg/KVexNhCr8gJbrikzZt+vOlSD1R4elc=;
 b=KPgV0zNxdej7PxUsyxDkvDfwGKdx7NSdvXeA/26dI566NMpPjbKVfXEZlJz7476SRmRTbqLL0zMzU2dIS8NZDPCCJsO0pR6z/4Jar6DncY5EsepLFPLlDe2g3ngIP9ZcNcLeyy1tYQZkoISQiZXMIuH3kEvdrXRa1WnvdpjBx3T5469cGDc6SPRQtPIdLhrT4wWB2WIJ0ZhdwJ3jkYcaeWZLqY9xoWJUY7zb8DL516tdp7ltD3p3XjE6egZI013mXw56NWvOf7Bm9iEkX7QOY/X0B7TilFwzl7qcAGFckoqR8+PXiR6twKmDTaKP5TdCPbddafbXMXCZIhl2bb1nkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMa7xu1Be4qg/KVexNhCr8gJbrikzZt+vOlSD1R4elc=;
 b=xGdoP4YbcHXehYywgpREAsxRzA5wwFhzQYKMOiqKANCNZhKys16KkM2d2Zxj3w+qOf6asBaitwPK/9PCn0TyH5Wh2rZ3m0NlvkmlDLDBJi6bXDmcTpzxn+M9YbKieMa4S8mKTD+6ypB1hHwejHlhan1hZ+mKD3K4gUnA30vwBJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 07:01:26 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 07:01:26 +0000
Message-ID: <71eb3ec7-20b3-4e72-be23-0d7d5f95f0d1@amd.com>
Date: Mon, 7 Sep 2026 09:01:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] pci: versal: Enable AMD DW PCIe controller for Versal
 Premium Gen 2
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <cover.1787559753.git.pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1787559753.git.pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0183.namprd05.prod.outlook.com
 (2603:10b6:a03:330::8) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5d7508-2868-40c7-e434-08df0cadd55f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ok/tD4uZp01NhC20g8KGNkWS4eRnhUJ7HaSYG43GkW9rznjnelliyn2d/XGIpNH+vn+VKh50R6aavBg3829A+YyBfn7y+Ls4mwWLxrtdYsFham4UsW4pv8NTAg8IfiDUH2wRRa0PTzYQ4bgJfJLVq5uA3ln1pVtY0UUoxAvwWdzOnC0fw5rM73whYbggW9XXH66X6pYp78HXrhmbZpBIuoMBEZIzGT9F9kbnL9y0vG/dk/lZ9xBmBR2lEqKRVmHaNJI5U8bcIv2l2GIVeqnoXl+nVQAngsS+MWzucrVKa4zsLDExVcK6okfRVLoTesPHlFA/nfAg3Eqc8oEEM6Ii533ZbW5vFRzUFU2ryOUWxPRUfN4DcOe0/cNCKEqTJBQLoZQGlAarCxiBjwdgYyKmq/LKpk8KbxqSCVwuFPxUSsvqQ6e5kuZdOQHKXLxJncuj7885Yk6pBwpeZE8de2UGtYL0o82z3Pk1Av5C1K0uwZwvEPcY5xubbNJz3a1PaAG+3FisaO0iV5Djl95pqnBRMDvH8GeTXmtIUYwb1uwDLj0uU9NFhPjywy+u4ZYLVYCjKcxrtm9zypm5k7euxhcP5vBAFBajbZk+tFBjW5GEt8Ca+IT9dunvNju4Xnu8UNJF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlOcXp2cG9ZamsvYndDaGQxL1lwQUlwWlB3UzgyNXBiWjExY2lSOFMwRm9J?=
 =?utf-8?B?QmNvSThMZ3g1ODd5dFJkeGpPMUJNQm04dmlUL0ZvMUlpQUpvU2QvWXV4WTd1?=
 =?utf-8?B?d1BidGVZMWhlWkFuNDlEcXRZUU5zMFp2OHpVQkFqL3EwUGNYa3U5ZlBPNEVJ?=
 =?utf-8?B?NmZiREQ3NUFzcytIQUE5YWNKNTRGcFo0NmNuR2ljaGZHTk1LcWw3bzhoOTla?=
 =?utf-8?B?aGpJQTVwUlM0STJnekxqNXlmdkE1cnhZMGsxbWZKWFVjeThCWU02aUx4YXZr?=
 =?utf-8?B?SUZIQmZTWTRNMjBmYnRhdjBLUnE3ZkZwZU9JQjhpejNWdFdUM01zd1ZHSStO?=
 =?utf-8?B?Uy9NNDh2eVYxaXhsQjJSMkhMOWVGcjRQQm1BVWlzcWZDaU1kM2xGSFBjQlFX?=
 =?utf-8?B?UGFUaEIwUlpwdUVVSXVLeXRuTXpKakFlcExvUlQyNFAvaDBCNGRSWW9nZkZp?=
 =?utf-8?B?UUQrZDNuVHF1WlBJWkttZUtjQXNxT1BhSmFjb1YxSG5xVDJaL0tqRWRGbHk3?=
 =?utf-8?B?Mmh2UiswcFNFRVpVTjZZMzlXVVhscUczSXFJU3dRS3FjVXFpeXRvMzR4c3NV?=
 =?utf-8?B?cjl4eEFyNThDb0lEK04rY0tsWFpsZmE0OEFzRVF2Rm9od2lTZ0VaNlU4Tith?=
 =?utf-8?B?eXVqQjhPZGtkamxTYk5ZNEd2c2U4blR2MktkZmZXdVNaS3E0cG9FU040Ukky?=
 =?utf-8?B?UE1XWlUrTHhJVFdUZHk5bXpxd3BBQ2RyaDNkQmJzWkRxdktSeXpWcHF3NDBl?=
 =?utf-8?B?OFcrOWtZRDVraUhUUEkrU1M0RmE2R3lVU3lib2NoQ1JZa1ZvYjB3WFphZHFV?=
 =?utf-8?B?azM0TGRNTzZYa3pVWHIrZHMzblZDcXQyNHZmaURFb2VQbnFkOEN0dnBGTjZw?=
 =?utf-8?B?V2w2TWlJYk11RGsxaklQVWlEMzRhTCtkRVdGSi94cmdNdTdqN3ZBM1YxTUJF?=
 =?utf-8?B?eUVLM051b0h3K1MyQWlvaG90UXd4SGZOUHB3aFJLL0VsK3VlbFVPajl5VjJk?=
 =?utf-8?B?SGhTdzhPSXZtMGZYMGFmMGs0dkJLK2hKWXlSam85cWlxd2lmaUJoeU9QNmhx?=
 =?utf-8?B?eXo2cnVsVVdLb25kbXp2REdoV2dsWnZDaDB3MEc3eHRvZUZBUVR2UXRKRVc2?=
 =?utf-8?B?aW9TMWQ3TjQ2VGovV1lrbFYvZUpLWUxSRjBteW9KeUhJbnQ2NHl3Qk0yd1B3?=
 =?utf-8?B?UXhZY0JhcE04QmhRblFzS05SYVRkcHB2SzBSM0lNVGd2WFA3VVZxb1JydmRX?=
 =?utf-8?B?Qkt3dlVHMkR2enFpdnU5am9SaXl0aFhxd1VNRzdUaWt5RWw3WFlOSWhhL0p6?=
 =?utf-8?B?K08ybEF6YmMyRmQ0WTNmN1pJSVdpc1lWSENqZ1cvb24rRVlyY0NIdGt1ZHNx?=
 =?utf-8?B?R0ZMMTF2N2ZQcm1WdDZDL21XQWRXL2tUSzJxZVAwYUI4Ym1hZWZNTXJtNXZB?=
 =?utf-8?B?aU1mbDdUUklRNHNseE8xODFBbEpHNEpueUQvN0U3S0s1Z0lXYjIyQTJGL0Rr?=
 =?utf-8?B?YXNyQmRzUGNCWUZlUHBKZVpNSmZ6MXRtQ1RTU3RZZWhtY21NTi9RY3o2RC91?=
 =?utf-8?B?TkQ1RU14OXdRSFFjdGVpdkdRN3E0M1pqU2NGUW5POTRETklRcm8xYWIraVhB?=
 =?utf-8?B?QjRodzlERDIyNWg5TlFnRzJqM2NleVQ5a3JpSWVaa2NFTWRzeTRtd1M0MDJT?=
 =?utf-8?B?c2pSazJsbzBjYWZuMWRMS3h3TElGb3FYQk43ZXBDQnprY2ZwcXNTNURVMDVL?=
 =?utf-8?B?bW90Ui9yRU43MVpZWHlnVnZYNktYTHNtUnRPdFRIN2JTQ1hyL0htTFJsQ0hs?=
 =?utf-8?B?WlhtZVBCeGNJMG5Ka242QW12R0F4c1R4UXJ3MUQvd1dGRzNHT1hZMUkvQ1k2?=
 =?utf-8?B?ZXNWaGdnakJVS21GZUVNTnFtTEoxOHY0cGtMdkhyTTYyVFFNc1pyaW04RGw3?=
 =?utf-8?B?ZHVyYm9SdlRueG1oL2JKeDlFZ2owUjZTZ2E5cWttVC9wRlpTMnkvWW0vZVR2?=
 =?utf-8?B?K2ZCTUJUZmdIR0lGdXZ6RWFSb3Z3aVE0YWVoMUNiVTZsYlMwUjU2YjgwT29P?=
 =?utf-8?B?L3Q2SVN6YWIzNXJOT0VDeGc5dmpETnI1QTJvajI2N080RUhoVTNrWGpXZll0?=
 =?utf-8?B?OHF4TlhQWTd1KzQ1MmlJaHNzeE5vK3N2QlFtZjNUOE9ub0c5WWJ2NHgrVDRp?=
 =?utf-8?B?VWc0NTNhLzd0VUdUeTkzOGthUytIUjZ4SE5qeWQzREVwVGI0RWcydXFVYzlE?=
 =?utf-8?B?eUh6L1lraVorQ3NZNG05Ujg2Vno4cnhXb2lwNzhlNmVQWDNIcUM4RTJIRk5B?=
 =?utf-8?B?S2ZtNnhEaVJBRTJraTErRmE3MVRCMWtreUhQRFBZbjVVRU9yKzdmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5d7508-2868-40c7-e434-08df0cadd55f
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:01:25.9800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXIqqOt80kj9/Mz25MAS5aqnc69Q9fvQumw5gN9ojoRNvR1ihJVCCtwZ3Yoct9OM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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



On 8/24/26 10:35, Pranav Sanwal wrote:
> Enable the AMD DesignWare/MDB PCIe root complex driver for Versal
> Premium Gen 2 and turn it on in the amd_versal_premium_2 config
> fragment.
> 
> This series depends on:
> "configs: versal: Add amd_versal_premium_2 config fragment"
> https://patchwork.ozlabs.org/project/uboot/list/?series=519895
> 
> Pranav Sanwal (2):
>    pci: Enable AMD DW PCIe (MDB) controller support on Versal Premium Gen
>      2
>    configs: versal: Enable AMD DW PCIe controller for Versal Premium Gen
>      2
> 
>   configs/amd_versal_premium_2.config | 4 ++++
>   drivers/pci/Kconfig                 | 4 ++--
>   drivers/pci/pcie_dw_amd.c           | 1 +
>   3 files changed, 7 insertions(+), 2 deletions(-)
> 

Applied.
M
