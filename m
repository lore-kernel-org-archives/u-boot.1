Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE368C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 14:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3C8360679;
	Sun, 23 Aug 2026 14:48:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQ_BGCt6Wrnz; Sun, 23 Aug 2026 14:48:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787496510;
	bh=Oy0677f54qjcdwM1vwJSOQExaHqxZ5JsSuV1gn+PWK0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZuZjXEI6CQnT9YlHvvpRxGVLxxu4Fs9zuiD9YotC69BBUlLQBACPlS/00jAI6GJwg
	 nFWggBDboAjJSS0Eu2BFrWaTNFdU1KKdc4h4wnvpafznCEFnFgmnOxzXntZgHxF080
	 69qT/M7mhZCALcNPCXpDFApk0GUC46vTNgz7gVEuZC3sGo3KCTDbAlXgaxhbGCbHwO
	 aul8gCW3deJmwo/cVLFsZUW4b5qEFY/tE+qTr6GcB3bgE8tXXi2bR3gJrZgphYMWpi
	 LDoyslk72HP3KKtRAHk1lCO1PfPzRdRccq8NWTdLaq14d6nDn3MnefL6rWkPBH1gMZ
	 yPj4CGs7aRssg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB37E6066F;
	Sun, 23 Aug 2026 14:48:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4A582FD
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96C97807AE
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:48:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_EmPW13xzFd for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 14:48:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=lD8kMZ0E
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B85CF807D2
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USr+qSPNO92L4df5U7H6Idxc8A8Goro4ZRPzvvOzjLhbmrtAWw/eOLWc1gbYp18I2CoJyynkDtEslicV91culmO+pvrHPfr3rRBtvyKa2O0Ge7cVoYA8Jw8yT+dT8R5lxQq3rzmwcNjlwMU2p2GUBK7qwLMRzGAWISEX0v0zgSJWavinVQRhDqriAiC3yPad7fh8SwrwWvrGNZs3saTrD8GA02s6mxWiEqdWe7Y6v1Qd4QQ1bMOGRtK1P4yAzMoecII6zkgGswmYTMtElSMjK5gXROqQGSHUfRT93ckeqUYP5L9VdBJIXC5ZkU5SvbDUjqnKINjJz1cNBPwmQipZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy0677f54qjcdwM1vwJSOQExaHqxZ5JsSuV1gn+PWK0=;
 b=Oa6fYi3poyvJ9I+LyoPLsD4gIHbccAY+LevcaIFJRJnfqdDiUD6wtkLcmFFFrWkC9Pjv3Gq6TUXYRmfQYGxqCDwNXxAv2iGBVY/7E5IGzY3rHBJsjRgDJWBL8m6kWeq+Fq6FN/Rd+s0JqXnta1cJtyRZ2xwq9YnSvTYN3Uib5oGK/AEXghrLmNr8nZCCtSDBEB1VBf6uPDPWQiGAns2eEz4mGd2JpZvJ7R7gCtpJl/b1rnYrOBkwxxA5WTJVLfFen7RhEtv2aOYG5REZoAJT3hD1AyjK6q8t7t/FNTUJfDH+LsFfWFofZ3SEvdFYbEV5EunJbAYt6m5aRvzHUAUirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy0677f54qjcdwM1vwJSOQExaHqxZ5JsSuV1gn+PWK0=;
 b=lD8kMZ0ELp4MgK2Wdgh8TaL2sKsvfmXZ7UadcxAxN3CAQuqdrKLLbKclF85nQlMJSezxp7KYGmSFQ9njAxOXSRd3V6uGubZ0w/pIdlCYtDDLAw1MVkw2PN2eGZ1JUsjscZQwBeU9WzTEBMBSK4NpQT+Ql8KSSANLGpNKrmQ/RYGTMB8nQO02WebxiTnI4LA4Qd8FB/5YKlaZGPy/bbGRxJ2yQbxwDb1EMcQrn7tKCQRsc5aV7ecahgiQhJ1qtfzG9EzPOtlcLLjkHcGKM4YabEmvXoE4Upu+elMO2vRlZyF01/jes08/UXu9qf3gvdniTL3kdzlXSy7wMq0ard9nxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7698.namprd03.prod.outlook.com (2603:10b6:610:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 14:48:25 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 14:48:24 +0000
Message-ID: <334f6456-6765-4cf9-b005-1668fdb6960f@altera.com>
Date: Sun, 23 Aug 2026 20:18:15 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 3/4] mmc: Call back to optee after a successful mmc_init
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
 <a95292a0b1dc11096c34916c020173f1671c492b.1787304541.git.jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <a95292a0b1dc11096c34916c020173f1671c492b.1787304541.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7e2413-742d-4b5b-d4f0-08df0125956d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|3023799007|22082099003|18002099003|55112099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HNXqXhM9YCKfkplLPFoaoTWWbhOl1P4DBw6RPyNKLinkU/fMopra2SHR4wS+qgzE2Nc5vCxienXO7Al76/2Zt2dha5Vtw1n32MRDfM05cR2EL1OA28bFKBkjP0HXxOSEYaM1tRxAPgleK0iRKYdWuJhS5X1lf/iQay32s0maShpU0b1t4L3DP94j16+r6xxC/7y869BcjbADn34rhbtFbjRiPqrBg4sqWDQUfZnJu3mZqJZDQsxcEYOqsoBuj+hpLpJoJW8NjgdSpo2FBxESmSyBlcanJPbCgErHTjNOf1e2/7yBbl8RlFEtFJ0bQfl0nUCtE1KI287jhDcgcdstjbLUCpEIn29DyaqQj23KqzSItLSAIvpVutfmO/jeTdsamK+3XOAMzQGfu3MgVYQ/+tRa/vpdya9XSluK2yErgKcNSC477YgPdFnMqW+k1P5PE/3L+UQgJYMC9xVzPTUdl5UQtpJaGv1YYAGELVTNZ+V1vWxGw8L8Cj3E/Md7P9iixaIBQhP6DrGgh9epoUxT9lyLihEQXUHIOiGmFTdTPEwKMqimSlvhCBaZ+jeSKzWrYs3nU32uUHtlO1jEkw0Ks3JY57sR1FtymCldxGyuOMw2yKzmEGSPq5Ko0Bu+NnVL9Ku6Ba4ZHcAKlOmlEX1MD2PsqBKDOmr5MlhVjT3nf1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(55112099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhxT3RITHdqTUN2dWRqRDBnU1A5dGM5TXZiUEV4bzdkM0xUaXZOQ0wxQWk3?=
 =?utf-8?B?bWxjS1FMVWtHdEh0MStGTkJJQmsyVUV0Um1UTEdwUGR3ekxDOHhpSnRRWXBO?=
 =?utf-8?B?SGdxUWVoYkVzYVZJcWIvWmJlWlVPanhZck9JRFVEN0owa1ZaNHNYUFpxdzBt?=
 =?utf-8?B?MmlCQU1NQjVTWVpiUVprenA5cTJaVTNDczl4WVJacGloNTJBb0xraUJnNE4v?=
 =?utf-8?B?RGpheDUrajhBK1RXOUhOV0tqQTJ4ei85RVhZMHk2RU5RY0o3L3dXb0FnbW5i?=
 =?utf-8?B?dlYrdHZTaEF3NFpPejZ1T3ZIeUQ2UXgrOHNNdkpQM2REbjRiR0hZcm9uZGdX?=
 =?utf-8?B?MnlvakMwRlBCeVdHcWtKQjVaRmpmWG5PTXhYMjFXcHVuVlBNM25ia1JvRTJH?=
 =?utf-8?B?c0VLTUM5SU13TUs4aE5vQS9IUmZQSUttaFI0QkhvVi9QcmtwUFJoeTFzdHVo?=
 =?utf-8?B?ZUtOWlRVRGtaTUVITjVOd0F3QmEzVXlpeEJrUWVTRnNEdmd6UTdPckZWbGN2?=
 =?utf-8?B?TGl0dnRnSXlNZDllK2NsRjJLMStUd0hFRTZYaWQ2dTBkMktZRlN3QkZRRmlL?=
 =?utf-8?B?WnpXL3lpb2drUytjWUNvOHZ5dGJGakJtTXdQTk1MbytPZmxXYWFSZmRzdFgr?=
 =?utf-8?B?ME04Q05oVnNzZUF1T2dBTUw2OTNYNjd6ZnhOT05WQ01IZ0VpWjM2UjVFbE9a?=
 =?utf-8?B?U3NIWnNFc0hmK3VyVXQrbmFxcUJEZ2Y3RWsvb25XMXJPZDlMcm12Y2E0VU9t?=
 =?utf-8?B?bGdJZ2lFbWVSb2lyUFoybFdzc3JpSkc0N2xOR3RQN1ZocGJ0OWY4cDA4djlB?=
 =?utf-8?B?UnZmMWdQSHVUOEpicTZESkpqa05VbG9MSmp2SDc2SHhaTFlFTEdaRHZyb2xl?=
 =?utf-8?B?eVdjdGNjWS8yMCtSN0RsWTFnWGpkVm9CV2liS2hYN3RQbVZ2azJPMXVnOXQ2?=
 =?utf-8?B?UkIyNDBjNzVjUjZvdHBlWmxma0JXbkg1RlRsbmZTQzlHcUVHZDJlVDVxN2pJ?=
 =?utf-8?B?YzJsTHR2ZksrYjMxb1MwSkZUaWFaUXorTm9CU1hxN0gxWmw4RWZkWmlZYjFZ?=
 =?utf-8?B?S1hlUHZYakl1b1JJUlBsOWRHY0JkcGFFQVFLOWR2VTZGSWJ3RjlwTlJrVDVF?=
 =?utf-8?B?WVR0RzJObWF5dTJoVzBDZ1Z6OU9tUFBwODRmbUMwNVFycmRpaHkrc0FnaXho?=
 =?utf-8?B?K1pDdWZhQ05MUVhtUjVJd3E2ZnBCVmpzV0d1cDhXQUpBbWRENy9sK2RQd2Jw?=
 =?utf-8?B?L0pXUUk3RWdtSDZyZTJ0dnZVWVJZMFdXZVFERlZsa0NrZmd6L2dCMHVaVjY1?=
 =?utf-8?B?Y0d0bWJaWFphd1pSQW5zRU1JV2FnMGkrTjBGcTBDRXRMRlU3MHk4ck8rdGYy?=
 =?utf-8?B?SHdBWm5lRkxGa0Zud0pMMUtDL09KYkNnRkprbDhpbEM4RDBrdzdSNVBvUk9o?=
 =?utf-8?B?VElIOGZKQUlVSDd3TGljRlJPMGdTVG84UTJQYzhCNUgrc2UyT0s1Qy82eWUw?=
 =?utf-8?B?TVZLV1pnN1U2a3h3eWtDSmJKK0JncTI2NHRmOGd0ZU5iMmw2L213NXVaR1c1?=
 =?utf-8?B?VzhKbkI2U2Y0Z1hVTlhET0N5bk5nNUFIT2FETmVYSUUvYjF4N1d6WWwveVQx?=
 =?utf-8?B?L2hYZkd0WGgzZEY0S1hnMHF6TUpSNTdYdGVxYVQvUE9ZWm5ZbjB3c3ZSSjV1?=
 =?utf-8?B?OHE1bkg5L1NIcUJRYnNybFE1aGxUbTh1NFo4REhvM2lrcHNWZTEybUJFN3h1?=
 =?utf-8?B?WElNSTB4L0RxVFdjcXQ3UjVNcC9BdTNrbWNYTVFvVFZpVXpXbkxmK2JQTGVE?=
 =?utf-8?B?Vit4OXJOQVhuQk9xYlJTa2dsc1V2V0RySmZDdnM4RmVDZThMdFZxek05bWh2?=
 =?utf-8?B?blZ0amxKdlVNTjVaeFk5cmE4K28zUzhnRmdyeW1aOHVVemZDWHNZNlc3dzBV?=
 =?utf-8?B?bllaTjNvODZQZDh0TGE2dXZBY3RnWmd3V3ZaeUlmYWRpcStyZ25MZ1RReFpY?=
 =?utf-8?B?MFY1TE5jR2Z6TnIvK0RLMURuMGdOUnpyaHhnVlZWV0dyaVRrV0JEcSs0clVT?=
 =?utf-8?B?QkU3Um9FOHhUckJNZTA5ODUzdm1SZzFNTkIwOElDSmlCNVpyVDJBR0pOdlFT?=
 =?utf-8?B?Vlg0aytXR2U2OVh1T2RxcVJucUtyZElybm9RQ0tGNVRJMFpzR3ZycS80UzJD?=
 =?utf-8?B?c1loU0RlaDQ4Nm5WTHBxM0tTbjFQeEVpZzJxNlBycnB6cnpLVEg1bEJ5Nll0?=
 =?utf-8?B?MW4zZUdSdEdvVnNtOGpIMk9hRWhwckt4R1BVYjZySDdySXIxYUVYVlBJb2FN?=
 =?utf-8?B?WEVnZ1k2RzdJUnU4S2krelVIL1RjTnVuN0dmaGFFU1RIdlRZUkhVVUh0TkVV?=
 =?utf-8?Q?yKKp/4rHjEUD1jdY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7e2413-742d-4b5b-d4f0-08df0125956d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 14:48:24.9033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NeWYt0i9fmvw0Bcao95l75mZydZ7Avab6B7aPM49m/E5uj/jMQFvFcEAVHJw+7DwGMM/IvdI1Xvj7LafHUGL9pr4FyosMlg/doSAknVQZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7698
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

Hi Jan,

On 21-08-2026 14:59, Jan Kiszka wrote:
> From: Jan Kiszka<jan.kiszka@siemens.com>
>
> This is needed to that OP-TEE can re-enumerate services which need RPMB
> access that may have become available now.
>
> Signed-off-by: Jan Kiszka<jan.kiszka@siemens.com>
> ---
> CC: Peng Fan<peng.fan@nxp.com>
> CC: Jaehoon Chung<jh80.chung@samsung.com>
> ---
>   drivers/mmc/mmc.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 670e92ee12b..2463e50cd3c 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -27,6 +27,7 @@
>   #include <linux/list.h>
>   #include <linux/printk.h>
>   #include <div64.h>
> +#include <tee/optee.h>

The include is unconditional while the call is not.

>   #include "mmc_private.h"
>   
>   #define DEFAULT_CMD6_TIMEOUT_MS  500
> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
>   				mmc->cfg->name);
>   	}
>   
> +	if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)

It will fail to link when OPTEE=y and SUPPORT_EMMC_RPMB=n. Add
SUPPORT_EMMC_RPMB (or stub the symbol when RPMB is off).

> +		optee_rpmb_available();
> +
>   	return err;
>   }
>   
