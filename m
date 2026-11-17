Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F31606A32F
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Uww6pZ2y;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TCotWVko
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7A3F607EF;
	Tue, 17 Nov 2026 16:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gwvn495LARHj; Tue, 17 Nov 2026 16:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF46260797
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794933613;
	b=pz1U5YwGjMYeiNuw9Ue9P7wED1edfQQmRzoVfvMN7fE5Oui5van6hKkpprqB+zuwdFZs
	 tYZVNg61QRY2jAbhQkBcqlLnkvD3zigI5UsxAld3xWM6GaNlgXvNWIOkSANm8ab0iuNf9
	 ScRyz13ZcloJUt6x795lBrJN8875ACtIYLTJ5xnVRl6Ye7rxYcq1ViItGKQcHEM0Zjvm1
	 3kUXd5NQHzikL/9atKe6NS594h95T40S9JkRTvUzvEE7Y5+skLY0XwA8rVR2v+obFlIQe
	 KIxY1kpw+T+7S5Fgi3IEazpshX8RDhUS7bsKQGCKwOyftMUx/yb0EWeiog1P80eQpaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794933613;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=g2cmSQ14zjEU2CV5inbzlSmkDZHcLBYibphMIR8FRa8=;
	b=rCwWVd09rKf/UQ97RQH3le2bXmaylTX3RsuiALeI40K/Y+qpHbDMMrGN+D9hAIdUKkdx
	 c/R43k/6U/SSrn2DMgadhy+cpLyc0xFsubV94hGLi+q76cSLz7CgAGYFhPSc6qM8WY7oz
	 c9J0Yhusj3O6833FUELptEUKypDHWvj0kc5BIQzJlFhytXovEwqYpNtDF9L4kG7Kf/Mr2
	 YGC5t82TrRIwUd/A0Vb4UjUn4oojYbxqAIwS5PufCuxWBQJwp1agGa5Jilv5/vwAo9FfU
	 mI1/6sEIG22QYsruQFTb2b5dixT4R8ooOhrqjTnyCw+M3m7aMK0Un/yrkC2dph6y0Rw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TCotWVko;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794933613;
	bh=g2cmSQ14zjEU2CV5inbzlSmkDZHcLBYibphMIR8FRa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uww6pZ2yjqKc7JzaJkMts7UVvcq+OsnomH8N3BzytNfXyDWN/Z1Yxa3maHnEzb0mE
	 pxCU2oJYOMbhQ1ZaOd8KLX8vg9bYYlfWOiGwBdyU+hFz9JziDESxgkZJMW2aErIBet
	 8UndtST4CScR9hHFMVjwJg9tyA2spNLW0EQDk5CPXjtKIz08BAoWO1fgyNyJUBa6M9
	 P4E+zw+Gj82S08we6WWhcw0xxIcJSMFl+hC1HafHfPDT173vPCZaFcFSAYNLdBphos
	 ej/EJyT0Jyea7kX8+VAqgUoK7Y7vBU1I5RViAMkUwR34gPGsfUO9j1JQCnxVK55JNF
	 wCA3Hptp0yuLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF46260797;
	Tue, 17 Nov 2026 16:40:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DFC91A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63F5F60797
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kmwM4AwAiR4J for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 16:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 606E56076C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TCotWVko
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 606E56076C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2cmSQ14zjEU2CV5inbzlSmkDZHcLBYibphMIR8FRa8=;
 b=TCotWVkoFud3xvBkSMzb7L01hOebCm5EGJI8PXW8MtL9tSlOKhoMUpJVdjqGNxmuv/uwVPHsxD8QVKL9yn99vD6tDpEpJRSKaSkQVBwYAddB78OzBMKJTjMd+WSvXwnmsyv3+XUzNPrAgpXsnvGV4pI7D6SOHj6KBcpc7QfETck=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS1PR04MB9381.eurprd04.prod.outlook.com (2603:10a6:20b:4db::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:40:02 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 16:40:02 +0000
Message-ID: <4b4b6b1d-9676-4b02-a10b-506d3169800f@cherry.de>
Date: Tue, 17 Nov 2026 17:40:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ram: rockchip: raise error when configuration is
 unsupported
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0004.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34f::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS1PR04MB9381:EE_
X-MS-Office365-Filtering-Correlation-Id: d02284d0-f3dc-409f-da87-08df44c96d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003|4143699003;
X-Microsoft-Antispam-Message-Info: np8JKBpG0SkxVsd4TWuz6AmvQek9KZhj0lK+YW4gdn3/eSmhwF2/lvh6Tsn0Ol6ZJOw0saUDH2A/yxyYiVAUdZQXhfQ3UfKmezkfmh13mx8MFK4Frnd7yz74jA39Xg1Y2XoICttQIEfk4moiuDhGvxN3iuxWk+mDN/NKUpGPBLG2XYkSkpuqZd4sG5mF+i9IFddjr8M+agcHdaV3CxSVz+pQ8pZrgfB1QLtksLb0Hn3b88PCwVLebiFkG6e0g7JJiwSO+Aey1aYWSoxEnQB4IEHBjkGjECrzL0lf+KAHmQxybcrmEjnYd/py/T0NvYxyVLXTEDMDqcHg0VOPzpTRv/ZfRDBGNkSqz5qu5ZzJVTlrlIzb9gA8WI43bkPPfotQA3km8ydzyIOqDMDY+kslgC3nI8O1lyZ14a9rFzbKJoOhbJnjbmwWEPN1/ObkU1xbn2qr2xnLwrmzp68yKXapHYqPF7drfOfOT7kwNfVR38opl2KQwmbmyEXZjJaXpACNYkLwQ0KtfQUZVp7XZuu30ct8sdKvnI30sNnW9gOCq4xbEnRNnRUu5iXkBb5H5f5QKguXtMs522AK2bOzWf66Y0Es0tBBdxU7y3cuH0qTQfieQ4jRRke9M3kgcbET5A0lZx3z5INjpkmsdMnnMF1KK5sAZRrxXLYWXbkx+bu5DLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UitGdHdEa3NpK2g0dy9kOHJOUnlxN2M0UkhHZ3RSUTltbGhqOHdTZUcrWEo0?=
 =?utf-8?B?enhxVm9zczA4LysrVE4xMHFZY1AwOWRERS9xQ3liUlBHL0NnaDgwSnQrVkpP?=
 =?utf-8?B?dGhXOGlneUNaS0VqaGc0bXRqekhSOHpzOFl0ckRwV1F6OWdiWWVpQVJqY0ZL?=
 =?utf-8?B?Z2pxL21BOERjUHpwY3NiOU9zZkl0RG9FNW5SRXl2MnVFK0ZXVmgyWGl6dW9n?=
 =?utf-8?B?UnM0YU0zOE1BdnErcDBiZG1SdlBETkdwd0d4UXNkcGFYbkFZcURBak1Pb2RH?=
 =?utf-8?B?d3pFTEN5d0U0TWxnWlkrWXNUVTRoQ0I3aUtXaGhrQ1kyelorNk13WEVCaVJJ?=
 =?utf-8?B?UUUxc0hEQzQyRHdCdUE4MTMwRlZSVUdDUEZZUmw1NGFiamE4SjdWM0lxOUsv?=
 =?utf-8?B?VXNXNEFzMElMT01XSGoydDJqOS9FSGRaR29hVDZVcDU5Wk55TEhnOUtmZFZy?=
 =?utf-8?B?d3VkaU00WlMrUmRZNDA4a0hCOXlaVWFaOXprdHByWk5zWVlFNUVHZzJkb1oz?=
 =?utf-8?B?RmppUkVpUG1sZG9DMU5HdXJzOUdUK040WkNkekk3S1cwQ1JZVDRGby9YRkdm?=
 =?utf-8?B?K0NEdXl0UE01QWlaY0x4QUovRlpRdFBiVlVPMjE3RFFIRXp5ZHpGWDVseld5?=
 =?utf-8?B?VStRODJqQ0kyL3cyajVOcEVvWGVBRTBqWG9NUm1rWm96Z2xsczFka1c2djZy?=
 =?utf-8?B?M3BycStmNUsyQXNVTDV2Zk5McG5IQXkzTEpheXRVVFhUd3VWOVZ4Ylg2SkVR?=
 =?utf-8?B?SWJkdDhxVk5ldEdZZ2tQN0hUQUgvZkpQZnlOOEw3V0QrdHNrUit0bkR4eVdB?=
 =?utf-8?B?T0FTUHViNitPNWt1eGxQb0Y3VWR6cFYwRy80NUVveFZIZXJUazkzdmRrSTMz?=
 =?utf-8?B?RFF6Vk4rbVNTaXNWdlN4b1dVNGVjaDJLdkpyMlJpVkpQTll6TUViazdvSHFl?=
 =?utf-8?B?ejI4MG56dE1TeDllOWN6UlhyOWI3bU5pcFpxeWVxbmVhWkdsdjBTSzhtakVr?=
 =?utf-8?B?WlNiQXlQM2RFRk5PVURGTklzYzQ5QmxWdHdBZUJENVNZZ3BsRFY4MFNGbFda?=
 =?utf-8?B?c21nTXdKWHR0NDlnMjkxc08xRklPRFlGc3dLNmZTV1VNalBqL1NMZU5TSnRa?=
 =?utf-8?B?WlA1ZTNDb1BieWQ5S1g3dEVxOEFIWXNxQzBOeWlCaGxmMXpsVEhIcTV3K1U0?=
 =?utf-8?B?dVJwTCszanpCSjdlNWZBWkk1cWpBZDE2anhiaVVrbFRWbTkzNXhMYVBpSHlV?=
 =?utf-8?B?UGZLblI2SGJmWjNRWUhkVmw2T2NraisxdVhsTlp4MkJPVUtKeGVLOXg1NWww?=
 =?utf-8?B?eDU0OEQwalQyM1o4azFja2E4Zzd5RTB1SFhGeG5yazNHQmt1ODVQVWZqSHh6?=
 =?utf-8?B?cTB6ajJIUHhlKzMxOHFMUG56c2RoUVZmdHo3dHNhT2RxQ0lLd1RZRktRdzd6?=
 =?utf-8?B?aHBSUUoydEkrQUVjbGVtdGRnRmJ0dUdtYjhlRWkxb0JHZURNTjdZLzJYNEp0?=
 =?utf-8?B?RS9ZQ1RBRVliaU9ZSXlpSVBLTktMazNNQ1dwTkVRN3VQOVQveWNmVC9tSytU?=
 =?utf-8?B?bW1mend6dkxCMDNIR2kxUUtWU2M3a09IRXVPaFkyalhYSXgzbkM4SXZ3VUl1?=
 =?utf-8?B?eVR2Y2pNdEJWSk50NFVHK29CVXdQWk9FeHNZNkdmNS9ZNUpSZXVmUEp3REV1?=
 =?utf-8?B?MVpVaDlkOHdJT0VOVkZBcTNiZFhUaFE2dXN6YlYzNTY1VFBwSGFCMUs0NTVN?=
 =?utf-8?B?R2hXbWVMYXRpMjE2alhqRHdvSDNqd28yVFAvVW93VmF0ZkFSZ0d4WHJZSVdE?=
 =?utf-8?B?ZGIvK050eUM4NER0ZmFoY0dHc25xOWE2R3dwbFh3ekNia0ZydkFtRmEvOG9C?=
 =?utf-8?B?M0NpWVc5bDVGV0RlKzZvNGtkcnRGOWNUakh2VVBidU9RRThhTDRRWHM5R2lN?=
 =?utf-8?B?bkQ5UHJ5OXoxYjVVZE1VRUZIYlB0WXVvSzMzOGs2Z1gyNm83aXZzd24yQ1M4?=
 =?utf-8?B?Q25HM1M2cGxCbjFxMndKV3lHMzRNY1E0TWJ4dnMvK05xajRlVko5ZUdHQjlo?=
 =?utf-8?B?YkdmckVKemlJNFBCTkJmWVJONFNkbFI0enF6bFFMRHNEN2dweW9kN2R3anNC?=
 =?utf-8?B?ODNveklmWXk0cTBTdjM1REJ1MzBkYThYRDNLVDBSV0ZhaVlRSVNGa1I2czlI?=
 =?utf-8?B?QytCM1Z6OVVNTjZIdWs2RzJYbnlrak1oMjYvbnArYzNBRng5REdPem5UNGJX?=
 =?utf-8?B?dnhPRktUYmw5b0ZvVHNob3l4VnUvZ3pKWWxyZUdBTzNRcCszRXc0WG1uQmxL?=
 =?utf-8?B?eW53azBOR3NZVDFoNXVEcHJjbnJRQzBJMGRyaW5EUVFGUXpDdFR3UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d02284d0-f3dc-409f-da87-08df44c96d83
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:40:02.8433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1PsSa7oR+Ea2Z5KGHdjm0OwcKmMeHf9a7peUYdWRCXqOLGMdvn/xy8BSXZft1VhBVNUENBNvnm3SQuZjgIYLp4O0OqHl9cER94Zt9HyH4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9381
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 11/16/26 7:39 PM, Massimo Pegorer wrote:
> The PX30 and RV1126 sdram drivers support more sdram types but only
> one type at a time, really. The type to support is selected through
> RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
> more than one of these options is selected, instead of relying on a
> debatable and embedded priority order to choose the one to support
> among the selected.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

If we add ROCKCHIP_RK3399 to the depends of 
RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR4, I think 
we should add a similar check in the rk3399 driver to refuse to build if 
there's LPDDR4 and either of RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3 
enabled. What do you think?

Thanks!
Quentin
