Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A85C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 09:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0913088785;
	Tue, 30 Jul 2024 11:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yd5BVqI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7830A887FF; Tue, 30 Jul 2024 11:04:36 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB8C88570
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 11:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvpmGpySOCzZIKjbytbg4RMftYOhWSOLdNivLvSBOwXL0P1SYbuojm382A2GEHUfkGIhuehwg7E/iEtPg+0dF1i+DAJcUOV1tPdlZ/bmkGVvSpzui6ohhXZ00wHLb9F58t7svKjAgGuuU0vGajsCXhyVrd4vDYH8+nZjSj97SRWP12PLeiK33HtkIvyBR/+Yna3pU2XMLTmtpbX9+J3t956aeyuwEUf6mlpdsRiLGJPch3dg9Pl3/VuCno9xMb01IQ5R88b8KVZYz0M2RCI0wkrET9SMOtrJKfeDyNwgsCpgSPNofaxgeAOavxczUgophS5Fg+vCNTNoVdfkBgEtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE8LgYZpyFI86++lekKSptr+ug1wRcUl5aQlRVC1x0Q=;
 b=IW0dV6//y+RdWPmwx7uYwKQQpO/3+4JwBxNRrcsNPHbECttyBjT5IF8gAPGcgIOpUW1nRhuia2Lu/QBXB/gGji23ls8nI+vNG/9ZrYrlOsbmbZRAX9z+oRHA2QgzFtBO9xH103LuQs48qmq+HtxelHiz9wCOoqFhpNhDHrxmKgTUvcS+I9ZwMOkrssxH9LktIONi/j8KouC6CdWIIZMECG3scdf/hWlpYcxH+T/M80ZfjTOoVytyhxbNms5asg1BAdYo7rEMojEoE4ewvYNIjoh13xbKtaAVl0fdkOr2pFGcbkyWQd3657L6UyfJuquX9MwkuzSa3e0X4q5mAvJQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE8LgYZpyFI86++lekKSptr+ug1wRcUl5aQlRVC1x0Q=;
 b=yd5BVqI/59FBw9uQqRHocBlMuN53FPuuU6DEyIj2GaV1shlK9cqHrn3VryNuFk07EBoiGE/cR1QIsCQJdPp2L2rUYfG8DOOoLViMj9CjdKCG7NIZLkdAt70ygRbjWe5ZHS0tRPAJnJxW23UZCsnuhqkItgwYvtLecahC22CNP0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 09:04:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:04:30 +0000
Message-ID: <b68ec280-bd16-4977-af34-3ef8ba59d30e@amd.com>
Date: Tue, 30 Jul 2024 11:04:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] test/py: spi: Add tests for SPI flash device
To: Simon Glass <sjg@chromium.org>, Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
References: <a68bffff608d11f4249ede9e51226f9ec917da59.1721819159.git.love.kumar@amd.com>
 <CAFLszTiMk_oJTwU8K4CZGJa9FXnSgkJs2xgcD0fAWz_9iPjftQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTiMk_oJTwU8K4CZGJa9FXnSgkJs2xgcD0fAWz_9iPjftQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0145.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8e7895-1bc4-455c-378a-08dcb0769f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU8vVFBZZFhOMXBHc1VMQjE1ak1tTFo0SWFqQU5rUnBTWHlvTVkrUmQ2Z0NZ?=
 =?utf-8?B?Q1lPbHhmeFdYcmJMTFZXNUh3YUduWVNPSG80UE9Rc0tHWFZVRzlYTW9nclVZ?=
 =?utf-8?B?bkVObG1jSTFOMEE4TU9PVE5adTRoeUlsYmpkb2dZTVFXclh2VjU4b2JXMXVX?=
 =?utf-8?B?SHFrYml5K2lSdHJ4QVpIZ0xPeXAwS1UrMUpIZjBSTGdJdWhqM01PNHVMdGg2?=
 =?utf-8?B?cEJJbkRMWE1WT3FCZXZnYmR4L055K3EwWWVqNmF6YjJMenZhL3JnaFJGSjZh?=
 =?utf-8?B?TjBmbUpCTHpjVElVWWIwYnJUS2lqam5qYVFQQ1Y1VmNnS3ZDbDU1UXVWajRC?=
 =?utf-8?B?b3k5RVVucW1adUVaSGVIcy9XWmFBYmw2NTk3aFNZWVlWU3BWRnF2SHdnaWZI?=
 =?utf-8?B?YVIyU3A3eFBYVDNybm9JeFlpenFtZ0p0eUdiM0Rkak9CV0pkakJSbTRZNVB6?=
 =?utf-8?B?Z0c4eUFobnorQ0VyZWEvNC9sak95aFR6ZVVBekJibEtSQ2QvU3VwSXJCUklK?=
 =?utf-8?B?VU96dEc2M1Q3OGs1NE9UMUFDY2tIM2g2UDc0d1ZLY05IbklHRUdQcUdhU0U4?=
 =?utf-8?B?OW9MMFo0YXIvTGU1QkNlTko5SFllRWU4a2lRN05CTnNKdUpKSnhLbTVOTXhR?=
 =?utf-8?B?blB4dEdGMFVxK0p0YU1iV1c2WFdhQ1NHUTVBOFF4VjlYWnBKT1NQbHpuRXZ3?=
 =?utf-8?B?cU9vOWNpNHZ1R3loLyt6dXVRTUdOamVBOFI1YXh4ZFVwcmthTHk0dHVGc1Vq?=
 =?utf-8?B?R3NlNDBJaXlHY29BQzNoWkRnaFlodndRajVCRHVOSGlGYWJFTnNKV0RPUlB0?=
 =?utf-8?B?ZDlWb0cwUDMyWHNpU0dpYnZQeVRsOVZhbUYrMHhmQVowYVdDSkwraGpiMEtK?=
 =?utf-8?B?VW4yTzA4UmcyTTBpTGdtL0Zmb3lnVXIxS3BJTE10MndWZXI4VDJkRmpyNGVO?=
 =?utf-8?B?NjhEV3V6aVBVUjJGMnBId0VaSWt2VWg1bE1pQ3lZTXBkNFM0WUJpV043QllU?=
 =?utf-8?B?MDByWDZnTUJETmxpUFJwV3VsamZPQjhKNU5GdExEL0Z4QzhnR3VMQnhjUnMw?=
 =?utf-8?B?TFo1blNtbEJQSFFKckJhUmJoc2RKdWxwTjZzR3VvOVVlQjU3SkdjNUd4eHBX?=
 =?utf-8?B?V2tPS2wrdVBrVCtPVUZmdmNZS1NMS05PTHE4QlVzcWQzL1NYampjdnJDMWY0?=
 =?utf-8?B?dWtQeitWS2l3SUJ1S0ZSbjBCQ2d3Mkl4Um9wSjljRlJ6U2VUT0pOT1NMVmJm?=
 =?utf-8?B?MGkzNEFaTWhheHYxRnYwY0ZyWmVORFhRU1dHK0lCekRJMnFmRjdoQTRYbVBv?=
 =?utf-8?B?QnJIcVBXYVRQdXdsZWdUdUoxRWR4VHF1NjhBVnlLSEs2bGU3Um0weUFlVS8w?=
 =?utf-8?B?cHlPL1pSdXg5R0VjbTNNYkZCdExkNGZwSjVwWXIrOVhGa2ptclFkVzZxK2or?=
 =?utf-8?B?RkN1T0g5YlJWZC9kbGN4NWxBbnR4NUVaZnY4UkFnMmh6d1J6VEpsYkhPTEFX?=
 =?utf-8?B?YzRhMTJ6V0FUYnAwWkJlalZDY1c3elVsU2xYMFEyOXFjSHE0YmhzRVU0T1R4?=
 =?utf-8?B?Wktta3dNSFBld1REQzkyZlhPeHlSem51bytxNWoxL2szSm9SRDV0YlZXMC8z?=
 =?utf-8?B?QUZGaFZ3RHNNd291cmtGd3JvOVlxVFp2bjFCMGZqYlcvcC9Xd25vRjJ5OXU0?=
 =?utf-8?B?NlBDOXlFdlBXeWhaM3EyeFJEVE5xNG5DQ2NjbDhkRXZYOU5tVDBuRnh3ajN2?=
 =?utf-8?B?V0QyeDl3bnhnNEFXNmZmbmhvZklIZmZhVTBmZStPd2VaR2hnUGdzT2p4cmI1?=
 =?utf-8?B?UHJPeGdKTm1nUGFDaVJDQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXUySlpXZWt2ZmkwWEFCMkxUTVhKKzVLVERMaFpyUDJIVFF4ZCtMUHk0Ty9U?=
 =?utf-8?B?OXdzb3Y4blVSNjhVejZaSVlPRnp3bnBHMGpNbzFuc2JOQzZsTXhHbVdWd21m?=
 =?utf-8?B?c2VFUjVleTZqUXkreGtObGFCZWR0RnM4bE9WTTFLQW9xQ2JXTXlva3RlWW5X?=
 =?utf-8?B?VDVjMFJSeTBkOGpqcDlXRng2eHRoZWgxc0VtTFpDOU9sQ0F6OHVhVnlCeDI2?=
 =?utf-8?B?RnNZZTN3VzRVemxTS0lhZm9WYmJEZm5ZWFQ4VzRvSU83SHNYZlFnTTgxTDNG?=
 =?utf-8?B?YVpSQndtZmxlSEowN20xS0F6aFFWL1RjeC96TEQ4ajErREx2WjJyWk9NQk9w?=
 =?utf-8?B?a2tpRlNCSmk0TW5aREl0N2k5ckJQV2IrMnR5eHFrUG5HUWJ1VldEWDE2M0ZE?=
 =?utf-8?B?TFd3NUZKUVVmWXpSQVVCb3BhSVpQdllQRFczTVV1Mmx5YnZwRGs3STNDd29a?=
 =?utf-8?B?Zm9pS25WTVoxU3NPZHJKSklkZ0ZSWnFqakVxalhid0pzNzBFL25PdGZ3Q21M?=
 =?utf-8?B?bndYQWVNdDB1Q241d3IwZ3pYbWpKUU5qSHlFZ01WQjRUV29icGV4K08yaXJU?=
 =?utf-8?B?SnYrRjIySi80c240KzhpaUljTTYzWVpEUS9RanhxS1RwRWMvbnRHRU5obXJY?=
 =?utf-8?B?T1JncWxmVkdQRWg2bHE1YWlJY1hmMmxESE1wL0tiVU84a215SFdEODRMTDh4?=
 =?utf-8?B?ZktMdlROK1gyVDJqNmw2ZjMwd0RDTXdMclBxcHpTZE5XVmpyMnZXdVYrMURN?=
 =?utf-8?B?OW9JQkRCRW9HdWQvZndzY2dwNUZCaXdCSEI4SEp6VnBQTWQxaXZFSzZURFpY?=
 =?utf-8?B?Yjh2UUY0TThXYUttbnNkNEVCM1hFZEZYbjRwTW5TVWxrZml5bGtreTlJcXc4?=
 =?utf-8?B?QzRkQXVCcTlVTnJFWjlNTXJLNkFJbC9ENmJ1cGlrTkpPZUdqWEdnUjRoc0Z4?=
 =?utf-8?B?Ynp2R2Y1MFZjWm5VNGxWN0twdUErZXhXQTJtMzhWVDVmZkNQd1hJajFhMmMv?=
 =?utf-8?B?cndJUXZkZ09aTVhmYlczWVdJSzkwSHp0cmZsN3RxYWJIb0RGRTVMc2xRbnU2?=
 =?utf-8?B?bmJEb0Q2UW5tMi94K0pmZDlXZGJQY2xtRWxBclZWNGhJVlhYTU4yOXppSlRl?=
 =?utf-8?B?TEdWTDRiYlZMTG5PcTM1NFRPUng4aU5VTWJ0RGQ0UUtLT0ljWndLMUx0c3hn?=
 =?utf-8?B?VnBUV1VlMjlGVTNyd3RueXNWTTUzTkk0WStHQnpxdHVmcDQ2cVMzRFFnRURv?=
 =?utf-8?B?U1NCV3NnZk12cTk4WFFQbWg2Y0d5c1NVdVJZb2trSThKYUsvMFFEcnNzTjQv?=
 =?utf-8?B?UVBmSXllbm5vTU4wY3JyZ2RJSXUvYUJFQmhMSStmUmpaZWc1bnlGR04zSlVP?=
 =?utf-8?B?VDBPRXgzWnNLRThEUHJ3OWhnZHVZYjExRURVSUdXcGtDeVg2YmZHY1VmWTZY?=
 =?utf-8?B?Vnpmdm9LQllrYnZHMjk3TzFOTm8zUWpKQ3RxYnQ4UGErU09ock83Q1d2U2wx?=
 =?utf-8?B?TXdPNjZmb08yWkwzRkFQWkdla3pZTlhkZE9hNkFJV3dOYlZPVGxEMGVFZ1Fk?=
 =?utf-8?B?anpTVThpSWtUMlE2WUVzT01hWnJ0QnVCVG0xa2ZLY1V1bWhreDBWRHgwek1G?=
 =?utf-8?B?SnN3b1JCM3hRUlFnTHhob3Q5SUNXU0UxcGFvQ1JtakNCM1RiL0ZZRXdMaC9z?=
 =?utf-8?B?aWRJUzZZbzBGdzRqYTY4SWpTMHJmT1JibmNscGpRRHRPdDF6NjVBbW81NXJB?=
 =?utf-8?B?UmNrSGFreXpwRDVjemZVbXh3dERmeVpaTGMzTjd3QVBZVmFzdGZlTkx2RCtE?=
 =?utf-8?B?U2d2WE5saU9EaXRqc2lqZjMzT0ZZa2FERUtpeHdkMktvK3BWc3F4UWFud1Jt?=
 =?utf-8?B?Y01WY0p2dGFoOEZJemJhTHN1dzJUZU5UQW9QT3l1VStrVGplZVlFaS9KWFRP?=
 =?utf-8?B?Zk9yS0lFOFVHeGxRdnFlZzZ1ZkZTcWE5dzJMNDZkVmZFbUU4MVFmSXNFSW5N?=
 =?utf-8?B?TkJCVFFMRVlUOUYrYjhTYlU0OWQzWjFkUU1uNFhZaDRONmlhcDJHRzN4YkhQ?=
 =?utf-8?B?QXc0VEFZczY0ZHlqYVRoY1RScXViaXZjNHlMNUkzUlpXVWlHK3Ava2lEcHlo?=
 =?utf-8?Q?nnfG76J29XtS/Fr4v/Gds2vjm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8e7895-1bc4-455c-378a-08dcb0769f45
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:04:30.7013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIbGZ8Jzu2wZg6+sMvDbFrLUvfzMSsjcp2Mlar/ctX+2B4p1Ect3dAd6OJuZbkWL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
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



On 7/28/24 21:36, Simon Glass wrote:
> Hi Love,
> 
> On Wed, 24 Jul 2024 at 05:07, Love Kumar <love.kumar@amd.com> wrote:
>>
>> Add test cases for sf commands to verify various SPI flash operations
>> such as erase, write and read. It also adds qspi lock unlock cases.
>> This test relies on boardenv_* configurations to run it for different
>> SPI flash family such as single SPI, QSPI, and OSPI.
>>
>> Signed-off-by: Love Kumar <love.kumar@amd.com>
>> ---
>> Changes in v2:
>>   - Fix the pylint errors
>>   - Re-order/organize the tests
>> ---
>>   test/py/tests/test_spi.py | 680 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 680 insertions(+)
>>   create mode 100644 test/py/tests/test_spi.py
>>
> 
> How is this test enabled? Can it run in CI?

If board owner wants to enable it it should be done via uboot-test-hooks repo 
py/travis-ci/* to define exact flash part description to enable this test.
But test is wired already it is just skip if part is not described.

Thanks,
Michal
