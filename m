Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEE7CF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 449DD89045;
	Thu, 10 Oct 2024 07:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="LyY/0Zot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB898903C; Thu, 10 Oct 2024 07:36:44 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F60889045
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opMZb3hV+r+yRqVvCJojpUmxcg3PmFJ5myRCSIt5IWWk0xIR1ZjIKN2Dm1u3chyFttoqwjWNL7BCT3FynxpvP7PPi6UQu9p5Vq3+fXi/NZ5qmwGeYKRPR9ejkeEig4yZ4TFdx7dkSdR+80g+n1OLuGpg9vXvcrsQQ8jP8Adf7Xe99dFhpPPq4omQwqeXZWIfhj2TOxDP6A/cWvjfre9raD4+kFD1YoL9gcFIN6IAB55fT0+Rf/lWXcaIsFUnSWoLTN01YxFv8FjXVFiu4yCkpHqs5P8qDQNFE+AHIZPeZo0dA5CU8MZAqRm7znav+EKc7l2iXsPiiqdiDrap6VzswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3n6RiyPPdlMCZMrR+d6TD8Ko9mGnnv2yxAxPo1Tr5l0=;
 b=ffbqxzd1KY7GHu1HDzJQlPaESqJdUSmtnOtOjCY0IPCUc1zOPPPvZoUip2KLejc5TDpBvJWxDX4Y4UTKRMpNoL3ofSEPyKDL96JI84bOqANQ0ldWnzApKo+KOqLwNaYiiHtMVzLu7p+JCn6fT580uA6O6cxeSvGTYSs7EOn0t+UlNIHawdVXD1x7IHurtc21N8ZmkxyUe1yFTddQd32R41UzKeK8nIzECb810KA3csihEyL+yihmoxMhIQinP2jE4YZLUX3Te/Dkwi9Q8VtGkVsUjyH5sb4/8eFqyp6nORvnySV8VjfzB5TdFED+YWIgg1a108L72S3qb/ngo3pA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n6RiyPPdlMCZMrR+d6TD8Ko9mGnnv2yxAxPo1Tr5l0=;
 b=LyY/0ZotoCDhGrWWQj81EkBjUPvi5x55Uvhp5NduyvIf3iOrc2x9JK9d8+4VpQJV8IlrueDjsz6oaZRAoz2vTMNtbm02v3bdHaK6KmGSzPFrstwx7y5oqH/ALB1ByA2ASmMS2/SHVrNLtyzSCtGgymJorfdTKqz0ZDhDUaHogI2W/oMH0XqmbvWhqFpDvsgCvzL1ErmtVpB5QTgTBA9MIM+mD8ypB8sJ/oH5K3+L5SH37/iak25sxDorebi2V+T5MUs77/YFfH0xrB+iFR3iQ4spixSRVHtuPpzxG9+SCzP2/7wszLrvsxsIFm3VWKkMLWuT0zekneYGK70jfpd+cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7458.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.13; Thu, 10 Oct
 2024 05:36:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 05:36:40 +0000
Message-ID: <8f61a744-63c1-4cf9-ab96-4aa867f10973@siemens.com>
Date: Thu, 10 Oct 2024 07:36:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
References: <6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com>
 <f7ba8d78-e6d9-4f44-8d49-c7f805d60c5b@linaro.org>
 <55c65001-bc56-4b48-9645-1e5f735fe06b@siemens.com>
 <c9d41382-0590-41d5-9bcf-9729bd5bf03d@linaro.org>
 <8d9f785c-2640-47d4-9639-dd0384daf1be@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8d9f785c-2640-47d4-9639-dd0384daf1be@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0349.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: c549bfe4-f3b5-4067-041f-08dce8ed846e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnBkWjZRRExvOS80T1NuMm5OYStwT0xRMkh0bW1XZWwxR1U5QWRnMGtCUk15?=
 =?utf-8?B?ZzBSVkpCdFF1MGNMdXlTNGxIQmk3SmJkVlRKVCtmR2RmZyt2UnRaTnRXd0VR?=
 =?utf-8?B?Q3BPM1dxSnFkYjVTWEoyVTg5bDJqL0ZPYkQ0K1dnVXQ5Rm9lRlJraUtoMGRK?=
 =?utf-8?B?MC80b3RCdEliMG9KNnROVHVmaWFudXRONTVtWGdyc3JqbHNJdmhFWHFJczcw?=
 =?utf-8?B?aGpjTEdGTmNyNmdRNlhsdEFlNENSZG9sbDcvSncrUU9MZVRWT0RGazY0Tkpz?=
 =?utf-8?B?dUxDaWlCWTljTmpYSnNPMFZlUjNOSjBlckRKUDJ5aHJ3a2I2VkRYOEtyYTdH?=
 =?utf-8?B?a2U3anZla0RoWW4vNlcwS1lyVXZUanBKOUtTZmhaeDFNT2ptaEJHc0I2VHNk?=
 =?utf-8?B?dC9DVzRMSzJnUnNiTFVrM3hleFJzZUdIVjY0MHNvcXFiRnEvTDYxK001dlo5?=
 =?utf-8?B?OHltYlpHYTNkTkk3RUs1Q0RzREtoalVWeDN4UkQzcmIzTnNuTFlQN1BsczNz?=
 =?utf-8?B?czUzU3EwOGxLUGhTczdnZzVrSGlCMCtOMzdQSTVyNU9tODNnank3RXVHYkh2?=
 =?utf-8?B?T0RqNkVmYmE3MGNucGpvNGJLUFBPT1VqOGFMYm5LSjdoWHo1b3VFYkJYanNT?=
 =?utf-8?B?c05LYVpiQVM0KzFnWGs4MllqUzN0R3BuWUJVSzdHOHFha1c4enhmL254RkNY?=
 =?utf-8?B?ZXFmSHg1cUVSbWxseUxXVFYyWndFa2xHR1JzTVFKeDlUV0s2L1ZpRlBiaW1B?=
 =?utf-8?B?TGNITDRrQ1dmTkhYVVVaSVZYcjNxYUV3VmQxa2dTSHd1aW9IaU8xYitNYmtZ?=
 =?utf-8?B?ak5KY2J2VmRtaWphcUthRTREYWNINmhPS2J5dVJDNjc1ZWYyVFp5YjVyWGJQ?=
 =?utf-8?B?SFNrRkxvdFFDTkVPc1Z2S0pUTkVhNCsxVXJkbkxySUxzUUFSbThWUEI3Nms4?=
 =?utf-8?B?dWVqblBOcHVaaDBaY0FSZ0JqTGcrWkFkUTJuMStFUmdCQmpYRWRvU1VvRHM0?=
 =?utf-8?B?WE1XaDhpcUV1dFMrekc5QkVDME5QTkRpc0VHZVRCZTZKQ3F2Z0xBNTBwZ1FC?=
 =?utf-8?B?RXZ4YWFncmFSRFYrT2E2bUJFRHZPUy9UZkRhcTVNUGFWWDZIbXp1SVdFMENi?=
 =?utf-8?B?RHhLZk1NbmY4cWUvdEMvTGlGUjFlekJVd1NqZXVCSVNIMUsxN3NadElINlo3?=
 =?utf-8?B?cFhwSE9iR3o0L0NNN1FZS0JodzlZTi9tUHg3ZjduNGE4bzhQNEtwL285MGVt?=
 =?utf-8?B?STMwQ2NoZGU3WFJFdXczVXYxcnpIZEowL1RhTlhXeEFjWklPaEVhL3pFY2ZD?=
 =?utf-8?B?L0FNOGtQUVB3M2M0SHpsdDNLQVFhNVA5Y3BRUXN1OFJvR2xWL01ZNWNLWFN4?=
 =?utf-8?B?NE9oajgwaDNXNzdydFRXTWRnY3VKMWhQTFV6ZjZjaHBJdDBYTTlPalNDWUdx?=
 =?utf-8?B?ck85OGRhWDFSYnMzLzVqUTFwb0U5dVpFQ1Y1UkpmT1YxcVpnZzJDK0l2NG9S?=
 =?utf-8?B?bnl4aWsvcHZ1dDFYYzBHVHo1VytMRW9CVzVBV3IvRWhPRVlSVXMxNDJpSlVa?=
 =?utf-8?B?UTlsa1dGTk9NQkViZnlRUFNxY1BpdW1mb1B2c1hEdHQ0eFM1RnBEQ2JxWWFt?=
 =?utf-8?B?T0VPNDlWNGtyemhzdzhWeTdmODlQYUcxSkExQUZ3aUdFbDZaQit4emR4STJN?=
 =?utf-8?B?cHB4cFF3bmdqVmdlTVdUU096Sm5McndacTQxNWFpVmtzUUtwWmszL1JBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVZV01nOG9hNGRMZFBaSjBZTnJlNjNXUTEzaytMZVA4WmZZWEp6dmgrSnZE?=
 =?utf-8?B?RFB3T3lwN3JBbU95ZWxIWWpqNkNtbm4xMWk4OVZYMlI0SmhoMWxXUHV3bms1?=
 =?utf-8?B?NllZRnJFQzVQOGlPQ0ZobnhJbVJSaDlxK0pra1BwbmdFRy9lNmcwVEptL09h?=
 =?utf-8?B?UEhRaU1lV1JCVFpWRFZqSXBtbTBaVVRTUEt3cjMvMnladFNrclk2VCtsS3dX?=
 =?utf-8?B?ZWlqajlkMmtEMXR0d3YrYWs1L29GWlkxWVc0cWs3eE02d3RvY3NPM2U5RlJj?=
 =?utf-8?B?UXAvYk9tUTY4WVhaODAvNXhueVd6N3VaR3VvTEEzNzVudmZJQjIyYytRTWhY?=
 =?utf-8?B?NzZxMEhSRFRwRmpLUG5OZVg5TWh1UjlyYU9LN1BiaExpQSs3L0ZkNnNjWDc0?=
 =?utf-8?B?MjQ0OTFpM3pTakV4RDNqV1JoUStxdC9TK1pranVGaGlaSDg5SkFXdVZYdFBx?=
 =?utf-8?B?TUR5UDVCaDR0aEs0Y0dVb3JwUlpQK2VYcEJDeUhPQ3BUTmNURENqZjQ3MW9o?=
 =?utf-8?B?WlF3TlVLZGp3YXVvQ0lmblAzOHEyMkdablFuRmhqTlR3WEtINlp5M09yTUFI?=
 =?utf-8?B?QUFnRDA1R3F0d1hjREtxY1gyZnlraTRWcFdFa1lybEhKbEVEdUdJZVdVWFdo?=
 =?utf-8?B?NE95d2Rxa3FzSEF2TDVkV1NFNytnRXVFYUdKS0c1TG1MUDl6TW1pYW9UdFAy?=
 =?utf-8?B?M3V4Y1E0cDBFVlhic2E4YlFXK1VKajVwWGtyczl2eVVJbUc3Nk1TYkpFbGxQ?=
 =?utf-8?B?azM0YU9mMGhJUHJmQlhZM2dqd3NKK0hhN01DdEgwK1hYMktMNnRCRkRwUldE?=
 =?utf-8?B?dmdjNTBnNlVUYUx2TDM0VHlJOENVWlM4ZmRCTHMxLzhmWEpuN0hTWnh3Q0wx?=
 =?utf-8?B?UGZJL21taUtPcjRKNkNOZ0FwN0hYUG1LUGEyWkV6U04zcUVRNEdJcmx5U0p0?=
 =?utf-8?B?V0duaFBISkU5UWtVNWRjNkJ0N0dpVDJnWnoyZC9aMG43b2ljVlY4ZW5pSFgr?=
 =?utf-8?B?bWw4ZlIxb3RLYlVQbGZKR2NybWxuZmhsTkdSQWVNT2krTmpyb09SQitiSW1t?=
 =?utf-8?B?MGw1VURMZFlKNklVdEpQSWtUOHRuOEhvYUMwT2lYRjE4SHVLb2MwTFdER0s4?=
 =?utf-8?B?Sjc2ZG00cXJrbHljS3d3RnhqOW9GbTBDcDU1T290SVAzNGJoQURtdEZjWTlq?=
 =?utf-8?B?T0Uwd2ZhcXFFRDl5UmpwMFVnamJ1WWUvdWtBWDgrLzFTemM5SWpVNm9qYTFK?=
 =?utf-8?B?ZVZ5ZUd1Zy9uYTZ0NENIamZBUnpQZXF2SkJveHNpUzdIR3ZrZEplVWpqVlB0?=
 =?utf-8?B?WThJWHVrUXBqbVJEdUNJSVgvclZQNXB3bWFhK3R4aDBlT2pRVk5jRXdkdzFn?=
 =?utf-8?B?MEFjZnltSnJKQUN0MGFqb0IraUMrMGRvTmk4czJMdkdGRVRLREk3MkxIOEcz?=
 =?utf-8?B?V21BUG83eE9VNmVrKzYxT1BGSmZhUzlzVE4zNlFha3hjczJFck1UTUJLc0M4?=
 =?utf-8?B?dWwrZkZ3U01nNlhpMmtoU3F6TEJETGgxcGhLUXVucUZBc2dWNG1MbjFSVG45?=
 =?utf-8?B?SFZQQzJTUXpmbjQ5OU5iNWtiLzA1TlJxazFwL25vUTVxWWFtbys1S1djK0hn?=
 =?utf-8?B?VmtuNVFhcnFjK2Ivc1RHenA1N0lVdnRzN3VUWU5aTjkzN3UyVmZBQ3N3TW10?=
 =?utf-8?B?VjBMcmhjZEhrUUFoTjFrUm1OVWh2MFZMWkRsVnlLK0c5RWVXenJwSXJEbko1?=
 =?utf-8?B?WXh1ZmpBdHBFeDZYczgzcms0RDZWdkkyWEpGa3BRek84ekNwdUFmbXJhd1Zq?=
 =?utf-8?B?MVJLTThvd3NMQ0hQbWYxdERnbm4xWGYvdWlQMEYxY2JBN2NQdzd4eU1HY2dO?=
 =?utf-8?B?elNaMXp3SVR2cHNJY1p4QWt3d0ZvbUcxNWJ3SG4wclNwUms4Vll6QzRLeVAr?=
 =?utf-8?B?STBMT0pTc2FiK0FrK2hqQWJadDZoa3ZTczRtbUZlQlpTMVpMWkNqdHNlOW1n?=
 =?utf-8?B?NDJjVXFuY3JxbS9KZE90U1NRM3JrSHY4Zm02NjkzRkwrRm5COXI5UnpFODRz?=
 =?utf-8?B?S01VRnNTWjNVcTN3c3E3dzFTNEhLbjVjYzZKbVRwR1AxazhlcEQwcE5tc3pi?=
 =?utf-8?Q?XIL5EmCnU3d1TntAk4hUxHcrG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c549bfe4-f3b5-4067-041f-08dce8ed846e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 05:36:40.8363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2eeVka7jwbI4CQ8bOJr+P8tPS1IyFMzAswoi8K0l88s8vnU6t451b7IPy1VlhUBcC7A8LvtXNyBYx2khP20KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7458
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

On 30.09.24 06:54, Jan Kiszka wrote:
> On 09.08.24 17:19, Caleb Connolly wrote:
>>
>>
>> On 09/08/2024 07:19, Jan Kiszka wrote:
>>> On 08.08.24 16:27, Caleb Connolly wrote:
>>>> Hi Jan,
>>>>
>>>> On 08/08/2024 10:51, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> When DM_REGULATOR is disabled, all calls will return -ENOSYS. Account
>>>>> for that so that targets like the IOT2050 will work again.
>>>>>
>>>>> Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus
>>>>> regulator")
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>    drivers/usb/dwc3/dwc3-generic.c | 6 +++---
>>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c
>>>>> b/drivers/usb/dwc3/dwc3-generic.c
>>>>> index a9ba315463c..2ab41cbae45 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>>> @@ -246,12 +246,12 @@ static int dwc3_generic_host_probe(struct
>>>>> udevice *dev)
>>>>>            return rc;
>>>>>          rc = device_get_supply_regulator(dev, "vbus-supply",
>>>>> &priv->vbus_supply);
>>>>> -    if (rc)
>>>>> +    if (rc && rc != -ENOSYS)
>>>>>            debug("%s: No vbus regulator found: %d\n", dev->name, rc);
>>>>>    -    /* Only returns an error if regulator is valid and failed to
>>>>> enable due to a driver issue */
>>>>> +    /* Does not return an error if regulator is invalid - but does so
>>>>> when DM_REGULATOR is disabled */
>>>>>        rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>>>>> -    if (rc)
>>>>> +    if (rc && rc != -ENOSYS)
>>>>
>>>> regulator_set_enable_if_allowed() will return 0 if the call to
>>>> regulator_set_enable() returns -ENOSYS
>>>>
>>>> Maybe it would make sense to have the stub implementation of
>>>> regulator_set_enable_if_allowed() return 0?
>>>>
>>>
>>> Possible. Would that be the only case where a stub should not return
>>> ENOSYS? All do so far.
>>>
>>>> Somewhat confusing to check for -ENOSYS here imo, since it isn't really
>>>> obvious when that would be the case.
>>>
>>> But that would still leave is a with a misleading message, even if it is
>>> just a debug output. The absence of a regulator is not per se a bug to
>>> my understanding.
>>
>> Ah good point.
>>
>> Alternatively, maybe it would be easier to gate this code block with if
>> (CONFIG_IS_ENABLED(DM_REGULATOR)?
>>
>> But yeah maybe fine as is.
>>
>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Can this regression fix be merged now, or should I add that gating?
> 

This now also missed the v2024.10 release - can we please merge it now?

Jan

-- 
Siemens AG, Technology
Linux Expert Center
