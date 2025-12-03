Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DFFD12D55
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB9683FAD;
	Wed,  3 Dec 2025 13:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rlYU7YQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E55D83FA7; Wed,  3 Dec 2025 13:22:38 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5691583FAD
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqb4v8dFF6pRBpJcMgMgO7TDETvXxA3TWjIS2RaY7L6IAhITw1MSYyO4FufvF5/wz9o2B0cH/I4w9TFwgeK4HFfoRGwIAKx64I1czdbQ+JUXh1mNRzmhiuB/b36b9m4EH/tCOpshtTpmI4JGNheFz9VKq55LWj+jwfjqj7iQ/yyPPUtEdO52no14TQzB+DbBMccOo+F2o62Ao++PKkSoXm0GUmtcB/A9wSXKxlpY4875gd4l2UFGkKhEcLZcnSby/Rwfn8oUx9lcFcx6uN+4lzDjOug20uwGCmAaGsSr0HHLJOJYKzUzWtWH7QxPVIPRn8Bf8tEIJ75fD0DhTxb1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u763ua4SDYQrb21FeBWSnQYENTclou28ywM5wOVGZhU=;
 b=Vln416v78vwSmuVMB0wteVcjb4TShY/iR1vGNaANCiekDTOVwSn3cdYOllYEewXw2MsKJRQ/EmtNbZ3mf7SIsmozf1kdGKek/zrckaetC/whd8Lt8r/Vi3132VxRVx9xgnVmfE9AUv6eNvglgwn9u/wjuFXrsNirjcwhkwV3mwi29xipcBlbuOIGMIJJaVYOCTDJiTsJAuqdCXvesBYW6RjG6DmJRnvdi4Q2HZHcYFmG5NvRE0Rf05TrifdvqXBVzlfTjMdbBaQjukUdNIzmx2PCcArJntaVckXuhVoJSjFAOlLXb/FU+XtbfGHYH9vZYkTo9RQb0lCB50G7RfOvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u763ua4SDYQrb21FeBWSnQYENTclou28ywM5wOVGZhU=;
 b=rlYU7YQKOumlOAcqHj8GNy2qSvAnQbhU24pqUdLojSRBW/BZ/FlkFm2og/AhQ1uiHwYj4Abw2gIU7NJVcRnPWdFoomr4g6exem7HCwJP1DCuVyLtxN55KJbAZpyRqbiOut6/QaRSulyuNO+NMBFYjWOjiX4OL7N5YeKOVAnuCBXJSBbOdftxnESKx3Wm8s7u69cBxahoyLhyVYw33pyaNd5axvSZRr7kOMl9vDaP9ZhtTHRhqDnNWWhN9BNwne4/t4hosNQ7DFWJ1ypgSui91gy/gPyvlAp+eHO8v9cAznTVLYJZAt8uV4sDZTuyu5FpzJtt4T7Ks7ipYdw5OgjqGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY1PR03MB7924.namprd03.prod.outlook.com (2603:10b6:a03:5b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 12:22:32 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:32 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 8/9] mmc: sdhci-cadence6: socfpga: Fix DT property naming
 convention
Date: Wed,  3 Dec 2025 04:21:38 -0800
Message-Id: <59dbf39453510052ee1bfbbb3c822799e991c00a.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1764760325.git.tanmay.kathpalia@altera.com>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY1PR03MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: f5068374-5629-4d96-0345-08de3266a27a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnFLaHN5SGlyZWVVZHVDUnJNRWNJUjlpWnp1eExnb1Z0VHJrNXhXRXZleitp?=
 =?utf-8?B?S0VRdXpSS2NtKzFFckhoMFVPaEZ2akl6U0YyVzcrMFpaTlBsVkp5TGQ4WXFh?=
 =?utf-8?B?K0RNWTRWMkJXOEJkdFRuV0llcHp4UXNYSXYyMnVValNkb202a1UxbUtZaVlh?=
 =?utf-8?B?RjUzVEtuMk5VamNKY0pSSXpHVWx6KzMzeVBraTJQNWZOcHJuR2c2V2NZVnJa?=
 =?utf-8?B?b21ydzY5R205MmlmUGt6b3N4ejBNY01vbjJZVXVkMzVSUEtxN1RMaVhuQzE3?=
 =?utf-8?B?MmNVZlNQUjdlTVBadDBXWTFWL1NKcGx2eXNpckFON28zVmJ1Q1BwTWhiWVFa?=
 =?utf-8?B?eGtwc2plSUcxNXVRcVRJR3NIeUkrWVlKdm5idllQSk1PenVCK0NkOURNYjgw?=
 =?utf-8?B?RlE3Y3RrNDVjdVM5UVpCYm9wRHV4SnhmUW4zRE9ROFdoZ0J6M3Fnbzg1YVJl?=
 =?utf-8?B?VzVRN09laE1QaXRuMUU1VkJhKzduMm9ORXA1NHVaa3ZwdG43TXBsenNkcTVJ?=
 =?utf-8?B?Z0c3eFB3ZkdWQTZYSy92aEhudGZGT0lEdGpxWXQyYndobTV2UWQ5UFRGNW9S?=
 =?utf-8?B?RjVDNFIza2RsWTNPR3lzc0lwZkc4S2xIU2JISC96aG50Ymw0YXgrSTg0VS9T?=
 =?utf-8?B?UnFmMCtFMmxtS1VyVmErQzhvTFlJUnJCeWhNRUZmM1lnajlJcGNHWG9TUE51?=
 =?utf-8?B?cy84dm50czRxbjkxV0JuSHRiazB3M1Z5eEVPTnZnZURZb2tldWdFZmZyV08y?=
 =?utf-8?B?YlZqenlEc3JFOC9jak1xNFU1ekdnaXFRVHJBNzBZNEpSQWdKS3pEQWhVcnMy?=
 =?utf-8?B?d0ROTkhJNlJpa3A1bGxMNTRsMTJXaTZWTHNmOEpnUXNkUHJObndUbFp0VEhy?=
 =?utf-8?B?ZmlyMTk2am9RK2xVQXdxRUh0TmtUQ2ZGNUpmRXFrU29lNVM4Y1ZmbWtOVTR3?=
 =?utf-8?B?Y05CZWluUDNTTTJ0aVB3OFpHTXdHWG1kbE5OWVA1bEdVMlhpM3ZOUlFlNUpI?=
 =?utf-8?B?NmswdmFlVTVUZXBYdUorUmtkTE10Y01mWnRpbWdMUlVXN0RiSm9keE5UaVRF?=
 =?utf-8?B?dUdqYUxTYXptN05HYTh2V2xUemREdWZWR2NSWTUrdUN4aGsxblo2cnFLaDZI?=
 =?utf-8?B?NDZiMmMrUS9vcVZQdlM1cFprcGt0RCtBUGxuY0dYcGFjcDJCQzBVa3p4aGFz?=
 =?utf-8?B?Rm9vN1MxazRxcXUyQXQxZ05UelNhdzlNcG1mdkN5dkdFejVTZWtjZHFPbENZ?=
 =?utf-8?B?THZ5eFRKdG03QnI5TjcwMDBVeDVmZWRISGZzUjdjeEdGVUluZ2pvcGtOS2hp?=
 =?utf-8?B?eXBlanBqZWRkMjFHaWxUMmczWCtHcWJsQ3l4UmY2d3FPRjJDQ01aeTU2MHlj?=
 =?utf-8?B?djRFcFFqejdhV0R0UFQ2VktqaUtNWmRDWkk5S2ozb3NaOEVMWE9RaVVmLzJj?=
 =?utf-8?B?WG9CbDEzb004OXdxMjI5WHEybGplUThDSTk3VFUzTThGZHhWV1RLK3VnSjN4?=
 =?utf-8?B?US9IRlZmVW9yaVhQNUhjcUJSKzR0Rks2dEVETytCYjZZdTIxL2c5LzljbnVY?=
 =?utf-8?B?cFFXdWliUDgxNlEvWXFzOW5XU1hzaDdrK0wwY2t4QlY2VlA2enJmem9XL1JF?=
 =?utf-8?B?R3NJaUlFeTk1VUFRcVZRZllOUGgwTkhtZ3QxMmlBR2tjNWllZkkzYzU5OFFK?=
 =?utf-8?B?cWwxZEtJWVJIOTUyaHFWQ01LV2FhbmN6ZzErREp0UWNBaTBSelcvZDJxR3py?=
 =?utf-8?B?a3lFTWdBbmh1dVdFSzJXZWdLdWJ5NWpCa2d0QXVpS3I0eVdyZndMenhscFhy?=
 =?utf-8?B?Z1MxblVCb0szbnQxSG5wM05laklZNUUrNFFGc2huUXc2R1hpV2xLK3psa1Na?=
 =?utf-8?B?WXo1T3hTMEVLTkYwSDdqakJUNHZqMThDT3JldHc3MGoraFhDUHErMDlqOXZz?=
 =?utf-8?Q?mbFKOvUqr76YI0tbYO96QZLhPhwwzWId?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUw2NnBDb3JqcnMxb3dRNFM1N3U0RzhhdUFmNnZEckQrL0lLOFRaZlpOYWNO?=
 =?utf-8?B?V05IclVpWCtnY1VJd092MTI4bFZhSjBDTkZlckxhNk1jTnJsOHo0R2oxbXJq?=
 =?utf-8?B?VGh2S3U4M0Z6SFNRNlpKRGtqUTFTSTBXdE8rNENNUmNMWWZtcDhDK0FrZlBs?=
 =?utf-8?B?VUR5Ry9idWt2L1pGdDl3SnY0UFlGdjF2aE5GbDlpWTk1eGNnSjAxNXFCRUg5?=
 =?utf-8?B?bitjRmRpbEtNMnlFQ2JzWTUrL0U2bWJxOEVsU0RlTFp4Vk91U1FFNXpEVVpL?=
 =?utf-8?B?d3hiTldvZktKMnZCQXR1SjhTS2YyYjdUd2V2THB5WUdiZDEwYUUxelhEVUNo?=
 =?utf-8?B?MUhjU3BVaCs1Nnp1U3hQYVc0RW03dU5MaUpCUzhDQVBkdU5SOFhBaXlybFBX?=
 =?utf-8?B?dGZZUlMwWE90VlpRSVhSM05jeTRqbDQ1MTZFTHVkMjBsQVNhQWlHbUVHZmdU?=
 =?utf-8?B?cGp4bFMrSWpDSkFCZUNVYjRHcmlkcEs2T2RFV0VLdDVIbkRzMFFhV0kwMXQw?=
 =?utf-8?B?NTM0QnpwN3dkdEp2bktDSjlsWXJ5cVI4aGlLVHloYmZPU0srRHROSU8veWwv?=
 =?utf-8?B?ekxyK2QxaHUzd3hONTNUVDJ3NUY1c1BOTkVtNnhkNEdmMS9paDFBWkZ0OHRr?=
 =?utf-8?B?MWRPZEIvcFovN2l4WmxIRER6ZHhPQ0FRTVdZc3A2MmtwUGxxeXQ2eU1ZREo1?=
 =?utf-8?B?TGNYQkU3aUpRcGx5aXFJbUx3K0RPOWQyWlZLK1d1dkt5dlhiVHJCZWZNRWs4?=
 =?utf-8?B?MWk0TDRpdmpiZVZqRjlveXM0cUtzcXo0MHZaTmF2V2RickxocTdBbjdsb1lt?=
 =?utf-8?B?UndiSXdWb0lvRDBhSm1VQUhZY3A4Z0FreCtZWDJ5TmdVTXMwZmprTHJXRjhv?=
 =?utf-8?B?TEJsV0k3OU9UZXBlS0VkNm9zWGxjcEZ3cWVrUnIxR2pXRFN3anNKSnhqWnh0?=
 =?utf-8?B?MU4wRi9udkNiZytoeGlCakZhWFp2c1cvaTgxeng3SlNPNTd0YkJhbXROT0hY?=
 =?utf-8?B?ZWZMTXZkYlZKdGR3NlJWYUQ3RUFVRmRJaUlLRnVRYnRFMHVqRnVwZmprMTRa?=
 =?utf-8?B?NW9mc1hBcU9TdEhJUm5mMVRpUzYwa1pNa3hXaXFEc1RLS2JYM3ZKWkNFRXFs?=
 =?utf-8?B?Z05QdTUrNnhGOHZWRnlmUG0wYXBvSGJKRXpFLzlscnNZZmErNUZUa0w4ZElF?=
 =?utf-8?B?alpKcFVYQlNpRWNCR2pSZFhzYkJLWUVYWTdvODBNbC9JckJDTE05OFJoaDMw?=
 =?utf-8?B?THJRd1hTNHlxd1hVcHovb0VMZlNjNENkOStYaS9ETWl0a1pUb2N4VE5xV3d5?=
 =?utf-8?B?enovZUtUL0xNbGlIem1ncWxxZmtHZm5JRHRzZGtpNDErTmxEYmxqY21JakJ3?=
 =?utf-8?B?aTFqc2dxUlpxaUZweU5uVEVLclpGbERrVk1KQVJCZ2NXU3V6SjVXYTV2MFZF?=
 =?utf-8?B?QlplSnRRL0hkakF3Uk9FY0lhTE83bFBBMU5hU2MxZEg4dzBPeDVDeFozNHVE?=
 =?utf-8?B?V3pLOE1odmRERVBaclAyMXpMRnFwb0pYYllBdEwxVk1XUGl3M2tYbXNWK1dJ?=
 =?utf-8?B?RnBNVjhLcnVORTVha3lIUzRYeDZRMWFFaHA0UnFpVGlJbG1aR01NWXV0emtX?=
 =?utf-8?B?aVpBOGpobEQxRDJTb0hsQ3JQSjAwL1JTM0FoVzFPWEJzUzdIRXdKbUI2c0hn?=
 =?utf-8?B?RzM0RFhHdTkwQXNJeUVhM2xmMlNmU01vSmNaQkNBVEQwYXQ5SVMxRTNMMkpl?=
 =?utf-8?B?WjdlVWRndGpUdE1hM00rcU1rR1ZNcitzaVZxWkppblFjdzF4ZjFtMXJGRVFv?=
 =?utf-8?B?OHBjTCt6NE5QNlcwZ3hWa09EU0R3Q0NyR0xBdVA0ZU0wMTI4RzNBOS8rTS9I?=
 =?utf-8?B?SXBBRnZ4Zk8xWVpUNTJ4alIvS2t5RHZRYmtUYVh6WGZSYmxCL3ZaMUVzRXVV?=
 =?utf-8?B?ZGtaV2lSb1BicEU4aTdxdnYycUdNajFINmtpU3NJNTd4anVvNWdodC9tUlNh?=
 =?utf-8?B?YnNzZXlVUWdtVGtPQnVrUGphRlh2YlpURHdtU244Y0JjNk1yRU83R00zeVdL?=
 =?utf-8?B?WmlmRUNhUHBkLzJaVDdqTTNVaGc1Z3k5UVZUQ3RWQmdTYytPbkNIWUFqclNt?=
 =?utf-8?B?Y01kQkdaM3hBUjVsY0VrUzQzSnp1YU9tRnVvamxHYVlGcVlrWitwZlc3YmN5?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5068374-5629-4d96-0345-08de3266a27a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:32.8628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsGBBVG+SHcZng8qJiSfyZoFnJ66sZYy1giCl/JtnAUHkRQBHkORlYU8+25jMriZ28OuG8HeriHLkhp1z6yltDKUiiI4l2baXglmveUlWIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7924
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

1. Replace underscores with hyphens in device tree property names to
follow the standard DT naming convention. This affects all
"lpbk_ctrl" properties which are now correctly named "lpbk-ctrl".

Changes:
- cdns,phy-gate-lpbk_ctrl-delay-* → cdns,phy-gate-lpbk-ctrl-delay-*
- cdns,ctrl-hrs10-lpbk_ctrl-delay-* → cdns,ctrl-hrs10-lpbk-ctrl-delay-*

2. Fix typo: semmc → emmc in eMMC SDR PHY property name

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index d4e2cb1c83e..d9467293807 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -73,84 +73,84 @@ struct sdhci_cdns6_ctrl_cfg {
 
 static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-sd-ds", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-hs", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-sd-hs", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-hs", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
-	{ "cdns,phy-dqs-timing-delay-semmc-sdr", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-sdr", 0x01A00040, },
+	{ "cdns,phy-dqs-timing-delay-emmc-sdr", 0x00380004, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-ddr", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-ddr", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
 	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-hs200", 0x00380004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-hs200", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
 };
 
 static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-hs400", 0x00280004, },
-	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-hs400", 0x01A00040, },
+	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
 	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-sd-ds", 0x0001800C, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-sd-ds", 0x00020000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-sd-ds", 0x00020000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-sd-ds", 0x00080000, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg sd_hs_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-sd-hs", 0x0001800C, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-sd-hs", 0x00030000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-sd-hs", 0x00030000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-sd-hs", 0x00080000, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-sdr", 0x0001800C, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-sdr", 0x00030000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr", 0x00030000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-sdr", 0x00080000, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg emmc_ddr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-ddr", 0x0001800C, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-ddr", 0x00020000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr", 0x00020000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-ddr", 0x11000001, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-ddr", 0x00090001, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg emmc_hs200_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs200", 0x00018000, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-hs200", 0x00080000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200", 0x00080000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs200", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-hs200", 0x00090000, },
 };
 
 static struct sdhci_cdns6_ctrl_cfg emmc_hs400_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs400", 0x00018000, },
-	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-hs400", 0x00080000, },
+	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400", 0x00080000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs400", 0x11000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-hs400", 0x00080000, },
 };
-- 
2.43.7

