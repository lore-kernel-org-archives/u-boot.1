Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110ABC3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E3CF820DE;
	Mon, 14 Apr 2025 08:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mix4Bh8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9067582027; Mon, 14 Apr 2025 08:29:03 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E9380EFB
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCFsqrev17sbOmSHe+wwxTp2w01Mhd3H7boLumfc8PFknpaTI2ump5lDbVKTRu7j94OayTI/DLDYnCOX325KjsVK/u4lItCH3kaN0y4U7aG1EAcjRk58QPy1z7n6ZOAr2zAV3lOo5BCxoIXQJHyt5aPMuorGDu4R6CKLRg5ysaYSo3z1qCB4yqfYc8/+CqWEAz/KNg+sh0MqrZjbbPSQNvBsZwzapm/wU0cHw0FzXgfTlFrGJmi1D+S8q4prKqpPrpAhMVwzKQTMwpZTlPGrM0sLQPaRyVj9vQrW+qfHmftdVgPKUZzxgyYBpDBVXBba4munbzlth+LQNNcu3FzJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZKZCTHZImdI6KP0XJlWAUNj6flnGa004CHP2nk7Pds=;
 b=WSv7G4VqifeL+86BpTRp0HIuRXhGbU3/XEoGMazT+XZyomWLFHIOQjDVNVb3Bn/J2ziS8DFnfKM7phZTFikcnRw2ouOUnTvMCjcjOJGjNqvRGZF2VxPqOM2AVWiFta9eHUG2C+bj/N0yE07m9KZQNfcaKJ2O+G0sBeEdt+Hl/+qznS1suEi1VT2792fzXs8szWNHP26MKDD2k/e+YZ26HqS+AbSBzmFKCHSY+qAXy+Vf03/28CD/1D3rY26hmeGV5ghUQdO1hE5bC2DlXQwGIlZNCSzLnrPDEWjz8Pvnac9gavCTS1yJx6n4qN4xi5GpKy9Bd9L8+cpI1nK48v/eTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZKZCTHZImdI6KP0XJlWAUNj6flnGa004CHP2nk7Pds=;
 b=mix4Bh8e+V+SZdMMnBcZ3hjDRrt49SfKGzMXM74OFGq9OIhh+9PKkdBTgKQrYPD04i7C+ZxhSWEftW84VPtkx1DGDWK6AfF0nDF7GBwy4NPSsemuK6v3viawo2qEJJ1s/gm5OQcvJItOZ3p11hvaDHOxq+q5TGTjzgeacD0lLEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 06:28:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 06:28:58 +0000
Message-ID: <2f30722f-526a-4b18-92c2-7043c5bb330b@amd.com>
Date: Mon, 14 Apr 2025 08:28:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] xilinx: zynq: fix dfu alt buffer clearing
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-5-vincent.stehle@arm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250407170529.893307-5-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e0beca-4182-4c2d-d221-08dd7b1da355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LysxODBTREFBUzc5ME4yd2taUk5FcFdXVWpJZ25DOEhtdkMzT0ZHbm5EcStl?=
 =?utf-8?B?Q1lxb1d3Z1hhdVI1d1ZabEtEV1VrdFJybmZkbmdFUkpmYzZUQ3BuQksrZ0FK?=
 =?utf-8?B?ckkzUktoT3J0K2EzZEJ0MWcwUGZ6Nkg4bWNDc1JhdzlFUHp6M3ZLb2M3OXVt?=
 =?utf-8?B?NG45dnVmUUxpSGhNOExSeHJSalc2ZWEzb09MS1ZXZDdHMUZYcVN4aGdWUTRp?=
 =?utf-8?B?SlBZWmhEUXMzaUplbUtLenJoRG1XbXQ4c29ZZmFoWHRyY2VhQm9JcDI4WE9W?=
 =?utf-8?B?RDdTaW9FRE12UGZCR2NYRFI5MUtlc2VtUzdiUGZFUnRFQTh1dG1wSjF4NFg2?=
 =?utf-8?B?UG5tUjYyT3FqUUxkaEl4Vmp5TUd3T29lZlJBL3NzZ3hQbjRlMHdCTFgxREgz?=
 =?utf-8?B?SGZ5UVlHSWNUUERyRVBid1JjZndDZXRrcmdteGQzaUcyQ3dkQXZ2ZHZGK2pr?=
 =?utf-8?B?RXMxdmlMYUZLOC9ueDkxTHA2V1U5S0owNVZnTElpelE1b0VBQnJYOHIzZUpl?=
 =?utf-8?B?VG8wUWpUWHFHSVl4elo4aDJ1TEtYTmJJb3RrVWVrQkFIK3IyTkJ3cE1QMytx?=
 =?utf-8?B?aEhZblR2bVd1QVNBRTZzaklObVJJbmo2QlM1Y2JkWGdHbW9CNWpwSCt6Z2xu?=
 =?utf-8?B?MUY4NG1ZZ05CTjVSQjZoVGRldVVRbXg1T0ZhT0ZKS1QyVFhqOHpMSTRqa25I?=
 =?utf-8?B?UWliUlNOeWpBZGpaWnBkM3paRDdqZEpHdUV0Rm9kSjFUU3F5OHlQSlY3Z3NR?=
 =?utf-8?B?b2RMSG9FU1FVYlZXc1paS3dKSjZTNlZOWExpdWlWVmhhd004eGZoZ2xBMENv?=
 =?utf-8?B?TDJULzNKR1N1eVlLRVZkTUVkOERqNjJRYUJyYXJIWGNFUnVoWDJDYVhOelpz?=
 =?utf-8?B?VUVVSEFoNGxKbmRkNWJNd002eFRJSG9qcVVLcGJ0U3hLbmlVdi9rL0I3V3Jj?=
 =?utf-8?B?RXBCUkt1bUhDbnR2dkZ6cE5nS2tnVFMrV1pYMzNjNTdwSkhVOEpHY1lNeEcv?=
 =?utf-8?B?aWlmQnBpQVA1RmpVOTh3aG1sUE8vU1I4MTl1Zlh2VGhjVUFyN1FMQ2d1Vy9S?=
 =?utf-8?B?dzJ2b2JYRVFlN0JmNFhmc3hMeXovWXRaMnpEc3NDQnJXRXc4cVlWMnhLM0FD?=
 =?utf-8?B?WTdXOHdkOVFFYW1WUEtmQWZXb0JwSWwzaGptWHJ5dUVWMnEyYzBnOGYybDlQ?=
 =?utf-8?B?TTdER1FGaGZFbVlJeitFSy8vUjBEZTV5ZFdPdjBXckhydlNCekJLUzdBL1NH?=
 =?utf-8?B?MklORHk0UHdHNlp1emx5YUhYWWYwM2FaODJKaEEwbUlya2NjTm56NVl0bERC?=
 =?utf-8?B?QThLOWRrLzVMdGowSXFPSmFQLzk5Z2RuNElZQTRCSWlRTlBLQTB0SExPZko0?=
 =?utf-8?B?em1PWUQ0WktqRVg0VGM4NUZzcm16ak5TYTg4K050anFlYzArWmpNNHBtajkw?=
 =?utf-8?B?aXozTTd0VXg2M01DWmk4QlliZ1BqL1BoeC9jeVNpR1YzYlRQM1RmVWVtQVZp?=
 =?utf-8?B?eXNjNFVLYzZuTnp1UlQ3YmlJODlBMForbDlhUjBLbW9hcmpEZExpeXoydEJU?=
 =?utf-8?B?UHlITXp5WnZPRFlyN2pBRTVGTTcrZ0VaajQyQmdPZTJxWkRPRzZSTDlqUThF?=
 =?utf-8?B?UTVLam5wM0VXZ2R0OU1VU3g3aXBDME1KSGlwWGlyVThuRzNUNE9aU3QwUHZv?=
 =?utf-8?B?d0c5LzZIdFA1Y1owY1o0NzZjMjM3bUdRTkRISTBUd2k5cytZMlUwM2hMVktq?=
 =?utf-8?B?YVBmWlVoQTNDZS9WUUsza1NFU0NXYjAweTJsdGNYSUFhcmlPUThsZDk4QmJE?=
 =?utf-8?B?UUJLc0pGYzJhaGhpbWpDNnY2QnNIaHBuYUc2Z3pLVXNsMUNnTlF6eUdMRjYx?=
 =?utf-8?B?Yjc0TjFSZzEzUVRxWlFUU2hHQVVvbWEvYXB1YzVtVHhLNkgrM2lES1dnM0Jl?=
 =?utf-8?Q?pEjR/BAfPm8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3BNTW9DTjZDUG5JaVdMK3BNdkdVdzY5M01QcURhamQ2c2JUNiszakVxSFUv?=
 =?utf-8?B?QWFsQkxzV1EwaGxmY2I1Y2dkbVltd2ZsWWVja3JjNk80M1lLTHJreURva2tO?=
 =?utf-8?B?RmxjczA0cFhvZ0plRnRzK0JuWUwwY1NjSExGYWF4enhMc3FFQ0ovRjVEdTZR?=
 =?utf-8?B?MVNERlMvOWk1VklmaUxKL1BBam8rYW1jUFhWMWpwTjhRVnR4aS80T2svODFW?=
 =?utf-8?B?SmE0V2d5V2xQY2U5ektVR01MbE5rRHVSWXhZY2E4M3I4d0dFeGlDczl2QzUr?=
 =?utf-8?B?ZlN2MVpDcE5zR09jdzd0UndUa21RUFg2T0R2M0Q1cGFMa3UrSTdhbE4zZnpr?=
 =?utf-8?B?R091bklFVlNCU3dTcXBYWTV0Q2RZakFSV0g1WmpML1JWZzU3NG54L1g5OGdT?=
 =?utf-8?B?bnZheHAvZ3RXNXROSlBPTFA2K1QvdHlpbFFPZ1o4Wi9adForc3A4Ym1ZN0tP?=
 =?utf-8?B?cmJUSE1xeEdZcCtXQ0ZqaWo0RWRJL2NxYm5YZWdJVG92Um80MFFtNG5aaFJ6?=
 =?utf-8?B?R2ZLODEzMGVYc056WGpVWE5WMlo3SWlaKzNaV3hQVG5nYjRiTTF5cGtZT0t5?=
 =?utf-8?B?ZWhPZU54eUNVN2dkQjFRQjU3b29WUGEyUlozT2twU0tmc0Q2WlZ4d1ltYktl?=
 =?utf-8?B?eXZReDVHZWFFQzNnZjc2WUxNYWhrbjNxeDUxTC95b0pUNExUa3Z2VGFJS3Vz?=
 =?utf-8?B?WU9oZVRESzN4L3dHNHI5dmx0di9HaWxwM3ZCUndubGR0c3ZwN3kvL1ZEaXBG?=
 =?utf-8?B?Mk9iWHdMTnlHT1ZHbmxKQndYcjF5alpOR3NrMjFCRzdPQkF4aytTeTZYNTZo?=
 =?utf-8?B?bUQyc1h4UUFKa0ZNNjFEdmhINGRzVTIxRjRlUjFnNGVTUUZwTFFpYk5LZWY5?=
 =?utf-8?B?Tkl3V004eHp2VFhmS3N6YllrV1dOd1ZzTmh2cFVTT0FLWjZOK2loc1VtK3VV?=
 =?utf-8?B?NE5NekIzTlRsV0wzZzRKbE5TQ3pwZ1ZOQnRQUzcveG1BaEFseW1xWDBTT2VW?=
 =?utf-8?B?WkZnbm5KeEV5Q2poT1RQQVp1ZWptMEl0aE1SNzk3WHI2K2JKRjZlbFNhQVlZ?=
 =?utf-8?B?WE9PTG5YNzRqWDVoSE1FZXRLbk5qdXovT0JIS0FvWDUrQnFoQ0tacktRYnAx?=
 =?utf-8?B?SVAwNDREMFNZbm94eHJONkdoRFlUWFdjeXNJTjhWL0t6aTZhRE9GZ3RzbDlX?=
 =?utf-8?B?ejlKbERsZ1NEV1ZxT2p5Y01lOFgzQ3Q2R1lybk4xMmo2WXpXeHRMQnZ1V0dx?=
 =?utf-8?B?Z2lXTWFMa1hTbE9FOFIxRkI5SUpLQjZzR1g0engzRzNWZDdOOEF2dVlVOGpN?=
 =?utf-8?B?KzJtSlEraGNMNCtidnl5YUJLdnJkUnZpU0dvU3JYZVRQcktlNEpDekNjU1JJ?=
 =?utf-8?B?SHpGdkltUDNEbzBlaklJa0g1cEYwQ29abWJXVjJkU2pwQVRmM2E0ZjdWZ3Bv?=
 =?utf-8?B?bFpHMFJRclNlemhDVVVYTVNoamRPVTFVbitIdkpzRWV6aW9UTE1hZi90NEUy?=
 =?utf-8?B?SEYwWXNjbnBtcXdRQTBPcmhtTEpXM01udGRpV0UxL1ZzNnp4cUIybElObVVW?=
 =?utf-8?B?emkrZE5TQ21HT0QxbHF4WWx6VEp0UlMyL1RlT1UxaGNjOUYxYnlwb1VtNmNI?=
 =?utf-8?B?YW5mbFVmMjhKMG1BNjJxeHlicTI0d01xZTVuVEFZclY4bWZrZ0lCdDVmL0NN?=
 =?utf-8?B?WEo0LzByRTRWbEJDQjBTOUdoWHZocVdjelFaOE8xdFFRQ0hISHQ0NDlpRkFZ?=
 =?utf-8?B?UFlML0dGaU51U1dYb29JMStCR0x6QStRY015bjIweFRGbWR5WFgwQ1c5aWFi?=
 =?utf-8?B?aDU0eHZ1cm5CTC9FNGFXc1h2YmlIV2NDVWlCbmtKUEppRGlFMzhDbjl5TFFS?=
 =?utf-8?B?WGcwZzBITzUvTmJuY25vZ0JtcVVGR2xIOFhJNDJwa1hCKzdOR1c4SE5ManN4?=
 =?utf-8?B?bkYwTGdDOXZhRjVKZS9ZZlpuSEJnOEFwa2FEbWc5TVliOVdxSmJBcVVYQWRx?=
 =?utf-8?B?SjNXU055cmVBR2dNTTNjeEI4ekd0cU00Vm0yYUcybkduQTZmaE4yaDRPc1Iw?=
 =?utf-8?B?L2Rua0FkZnFLNDIxWjhqRGdnSGRwYkdlbG9jWEtDYkNobElDZUxOWWpLWG9o?=
 =?utf-8?Q?Urw7trV7UMutMIGMS/Hme5Wbl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e0beca-4182-4c2d-d221-08dd7b1da355
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:28:58.1957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USfQd3HTjtDSAta3RcWVRe+SAXTjZxLQ6sgroAFALM2YWc7ZovTIIx2WVTXcDtAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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



On 4/7/25 19:05, Vincent Stehlé wrote:
> The set_dfu_alt_info() function calls the ALLOC_CACHE_ALIGN_BUFFER()
> macro to declare a `buf' variable pointer into an array allocated on the
> stack. It then calls the memset() function to clear the useable portion
> of the array using the idiomatic expression `sizeof(buf)'.
> 
> While this would indeed work fine for an array, in the present case we
> end up clearing only the size of a pointer.
> Fix this by specifying the explicit size `DFU_ALT_BUF_LEN' instead.
> 
> Fixes: c67fecd2125b ("ARM: zynq: Enable capsule update for qspi and mmc")
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   board/xilinx/zynq/board.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> index 8dbfa560423..d8d4d5022ae 100644
> --- a/board/xilinx/zynq/board.c
> +++ b/board/xilinx/zynq/board.c
> @@ -176,7 +176,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   	if (env_get("dfu_alt_info"))
>   		return;
>   
> -	memset(buf, 0, sizeof(buf));
> +	memset(buf, 0, DFU_ALT_BUF_LEN);
>   
>   	switch ((zynq_slcr_get_boot_mode()) & ZYNQ_BM_MASK) {
>   #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)

Applied.
M
