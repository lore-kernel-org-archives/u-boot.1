Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD23E7718B
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 12:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F9C8021D;
	Thu, 19 Dec 2024 13:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="jzPpwqJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C26801F5; Thu, 19 Dec 2024 13:21:46 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D93F801F5
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 13:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSkhiaYXd6poF7D+9mjpzIxjrm4lpkHb+ccEEff+X3JnyJYQBsa+xKr3dwMOTewV6nOWAzBXHp0iRotpBbI4zbtc7GQtVr706oG6jHqWQetBF626DCLjvExp7BUF/qietSSg8QI/ztFyyn6CE4fb/tk18EsuPAL8VGJHy9GCdorg/mKHfVDf4HPPs3QSynv7tmjZFOWE+n+LiZSzKAQaPE/heBCzcLHVRNsNfpUkMOWEaRah3fxqwPDAZVuiGK98UtZ7ifJy4n0eqfKRZH8p56N1wkW5aJaRArsPd41hJYPVUqEDG7kyEBwICagqqD165xL/glhBR6V11dVQuqZ89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1YP3IKp5pNmIpvQmH3/tMktHupi+0IjAtXs6YTaTrg=;
 b=PIr6jX69s4Q8vOQ1+Tcv+8amJPje3PdalMHCwLMqN5bGW1joQolAJOjVsItbCORCQxsOhAbU4mt+lPWCoqCz5sXtzwN42kv/7BU0Sn0t4COF8oMRHQmF/FZVFzmjq4k9saKaXLo4pmCff0Ob/lyEqUSaT64gaPiFJotlrO/7jGkQPUYF0L/Y5JCN5sFgLbZBnoaSXAOssO6JHRNHDzsiIpEz34Oa4Q11jowO5v/3dSV5YGTXzSTZaTeqjyL9twKzIN2VrLbrHx1A9vFkJW9qhcuZNXW58YbgdjfB3/6CbJN93hReaqLzBsygV/VvC3EbEe3RB4EPC2/hsmNBV3kPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1YP3IKp5pNmIpvQmH3/tMktHupi+0IjAtXs6YTaTrg=;
 b=jzPpwqJkJYTJ1rZTDZPaxfWoKmr5Q09j1bW9c92gaIUOdmRMos+weaXGkAOZh7m0RHiJYR1XCoHSur7lmig4VglMrcKrmdWU4UbxuP8AzbChSxNna1v0hU8yu1kHB/yPp4Z0FrKxAwlumxjmjj+3WbnfDdZdV1QnLbUqTVq7N84vfSWGDpFFBPskMLNbjegN2GgfgWhwQfFnO5ltMvtL3ggnQPi04qKibklP8LmcdRIRHnoOzW6pjHYTwa90SIApe7WZBWjCaRVfSyfIcsYGrIEGhBYmE1EAz1Kv5ZpIR0c60ybFhm9j5QOPC2+dmjrJf2/CZhRQlCT0qwnbxBqwkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR1P264MB2977.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 12:21:41 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 12:21:41 +0000
Message-ID: <6ad2da79-742c-4e33-8326-c08fc8cdf2cf@softathome.com>
Date: Thu, 19 Dec 2024 13:21:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] add the support of sha256_hmac and sha256_hkdf
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
 <CAEfUkUK3=yia5kmG7YO-niUUVSLtSZfjZS-k_4qEAe-6V5F9nQ@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkUK3=yia5kmG7YO-niUUVSLtSZfjZS-k_4qEAe-6V5F9nQ@mail.gmail.com>
X-ClientProxiedBy: PAZP264CA0085.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::8) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR1P264MB2977:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e959cd-1805-4b2d-5325-08dd2027b18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ti9KZVVkYXNrYTAyODFtWlRmUXVoUFM2d29Qcjl2L2VKQ01IbXl4OVpDek9V?=
 =?utf-8?B?QThVVlUveTAyN2t2MW5wN3RKSEQ2Q3VOUkpYajdCQ3BDNGpmZWF6M0o0SnVO?=
 =?utf-8?B?RVFsMU1TVzNNWXJMb2U0U1dXbGpsQzliSFY0T21hbnRzc2RTaTdVYmR3c3B4?=
 =?utf-8?B?emVmVEJDd0V2R01BNkVoRXZVaFhGWDV6OHBtQXp3dkoxVjYvdGNlTHJURkYr?=
 =?utf-8?B?MzI1YXg0aS9MaGd2VnpHcTF6WmlRQlhNZnVsYXpWVzFsK1ByamhiNllCZnRX?=
 =?utf-8?B?cUhNMjJKVVFLTVlLT1k4TzVIRkNkdldCdno2NFEwVkQ4NjhDSVhNc2hkekYx?=
 =?utf-8?B?N01xaUpnV0t4eUpmM1QrOEpMSWREQTNkdjM1MWN5cmNwN0J3c28rd1d0a2Rp?=
 =?utf-8?B?VG5adk03MWZIeXlvanNJQm9IRnRkcU5uUGNDTUg3K1pRZUNWbEtSVGlxZ1hR?=
 =?utf-8?B?ajRsU2U4bzlyQ1RYQ2dtcDBIVWg4amo5N21ucFM2cjJpVFFwMmIyekRtK1NB?=
 =?utf-8?B?Mjc0Z0FJWTRzK3lHYmVvT045YWswcXM0L2g4R1NwNnhwZVdjN05HWmM5V29z?=
 =?utf-8?B?bi9jOHJIYUFERXJtL3N4M1RkSnU5Q294VFYxTWpWYnBuVVRyRVlJMGJNRmJp?=
 =?utf-8?B?MWxyOGJub09IUWk3bkhXYjFEU2gxTTREMGNscXJqaWphRlhlR2JqYy9yclNY?=
 =?utf-8?B?N1VuRklzT24rRDlXVUdXV2wzRHB3Zmxta2EvODduUHM2QzV4ZnF6T1FRU2Z5?=
 =?utf-8?B?b2tQZ0k1V2NrZGpTK2E5eVhCQS9RK2RCa1F6Rkg1c2xETklCOWhxZ3ErSXhL?=
 =?utf-8?B?amgxUWhFWDVxcnNDQTNWa2lNOGViNm85eE1SRmpaYW9QYU11VzNqN0lkR2RV?=
 =?utf-8?B?YWpoWmdsK1M2YXpteVhabXlkamRrcmdXOE1xL0U4TU1oOXFCZzN5ZWlYVEFw?=
 =?utf-8?B?bU1VY3RabHRWd0o1YlBEVzRRd3hXeWNhSzRRZHZ3Q21HTWF5TWRLazM5eDQy?=
 =?utf-8?B?RTVTaDFVZFNRSUowd0MydjFxbmZJZUg3V21OTFRxY0tEclRuQ0NVbHZTUXhW?=
 =?utf-8?B?c3R0NlBPS3ozeDdZRWpoU0RYMGxuNkV5ai9rTXZkdHBnellzTzJjTjAvNWRh?=
 =?utf-8?B?VGc0YUhkVEhMaGxRelkvZGtxTU5ZSUd4ajBBYk53emRmYzh2bWJvS21XYXVm?=
 =?utf-8?B?YVZ5L0dwU1VzMTZ1Rm4xSkdjWGhPWS9ZN3U5K1gzRzVnZ3N5NjlVbnBmQ0Z4?=
 =?utf-8?B?UGhkT2wwWi9XN0dDSkkxbkdoRWJteGJUUW1DRjJOaDJ5TkcwckwwSHZ5elJL?=
 =?utf-8?B?aEhrMFVoSFRacWgyUy9JZEFhekZZNURhb3FsMlhrVk5BMHdWWGk5NWVxSW9Y?=
 =?utf-8?B?M1lsY0NqcExLN1U5dFRMSWdISnJuU0lrTTBzQkY5dmo1Ynh5UnZkY2FqSGh3?=
 =?utf-8?B?ZzVOREY1L3pTYTlVOVM2Q29ob1FoOHA1bzB5c25TcWRUK3A4M0w2RGFCNFZh?=
 =?utf-8?B?MEV0RTZtSDJhNXJ0V3FxOTBHU01KWE9ISkUyb0kzY21yN3Nla2VDdGN6UUV4?=
 =?utf-8?B?d3pvUkxxbnBxaXI0aWRsaVNWdndFOElCTzlMelFvV3h1Z1BmYXF6WXM3WTNQ?=
 =?utf-8?B?d0lLVE9vV2d0Mld3SVFyNExCK1RvY2wrL2pSQ0RMQXJlMExDaVVjM3JUL2JV?=
 =?utf-8?B?VlE4YlhhT3k5czNHTEZwRVY4b1Zhekp1Sm1jZFRyUUswZDN0aVVoZkI3MG13?=
 =?utf-8?B?UG5rOCtLWEczOUczRlNvUWRJWHF4MWRaWG5ocXYrMTNqK2FtMWpGZC85MVFv?=
 =?utf-8?B?MC9PQWgxUlhCcHdpOU5qK3JwME4wdzA2cWdkeTBmbVdQTGNtaVpmY2VJT3Fi?=
 =?utf-8?Q?USw+NEkKC9Pxc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpWZ3Y0WUtZdHM3N091TnFERmovTkRZWGk0WFhZRlBMTmJZT0c2aTdXTEVz?=
 =?utf-8?B?U2UxKzYyTk5rMlZWbDVkQlhLRWlMMWE0NDZyTTF2dW4zeXlZVFgwTWpjYkhM?=
 =?utf-8?B?N2pxNnhuZUJBR0dvbmF0aUo3SGNCMnR5aFdGTkhxZDFScTd0Wi91NW1KT1NV?=
 =?utf-8?B?V1cwTGhEUDV0NGtYMXlQK0V6RUdaNUQ4emZzNm92WUtyZ0NRcWFqRkRQRGRl?=
 =?utf-8?B?cFlIdTRFMXZQeXhxYVlQcS9LekxJWDlqV01PVEptSmdGb3dXWXV0S3FSNHdF?=
 =?utf-8?B?ektiSngwamJxaHhWR3lqTjZ3R092T0VKc211dndsTTJ0elJkcmpZcXhZY01N?=
 =?utf-8?B?SEo4TWZqVEdYaEw3aXJyTHRPQ05ORCtsQ0xuTzZaeHZiZDRvOEUyN29nVDV6?=
 =?utf-8?B?WFhicGlmOTV5Q2FRc2lVRWYyRnVMdzYyMy9wbEtyTnFzem5LODZKTkgzN2U5?=
 =?utf-8?B?QWhnNzJjVzBqemR0SFVDQ2JYTVdHaEFpRzBIRXlLbEc0a0hteDREZzJBV3lW?=
 =?utf-8?B?ZVljWExOL004WGJjS1YrYlh4djRiY3pZUHVvUGFNeUdMYjdxelBwY3hKVXVa?=
 =?utf-8?B?SWg5TjB2NHdsUWhjQ0lMSVQrcFA0NFhJZEVtR1gzUlZYMCtvT2NWVnlrUHJ4?=
 =?utf-8?B?L3RaNzhLTFRWNUR0ZUwxTEk0ckhtb1Z6MEFoQTNDQ285d09MWFkzbWZwSEFq?=
 =?utf-8?B?OThWbmYycGpicDBIbjFZa2k2VmdPTHg4Mzlra3hYa3Z2cEx3ZkJBRDF0ak5L?=
 =?utf-8?B?Wkdsb3JsMUM5UGR6TXUwcmVmT2ZRZmZTVGNZVGtnMVcrNnp3MGpYK2RMVE1u?=
 =?utf-8?B?VTA0blpQRml1TTA5QXpScHF1dkFQRGMra0ZISmFTTXgvdko5Rmg4U0ZwSlRP?=
 =?utf-8?B?MWROOEZVbmNzekswNy9qWENmQ2xPSiswWGNYYVJkNUtSaWRNamF3MUpZRTZC?=
 =?utf-8?B?eUk3cllGK0R6K3I3eFBncmZiNnR6cWdXTStrb1dIaWZlV01kQTVQbW5VRHhs?=
 =?utf-8?B?ZFJBRjFSQ0doWFVBdGIvZGhSeDNQREU3Ynk5TzYxaE1TM2ZPeUhIdnE3RmRC?=
 =?utf-8?B?Qjl6S3FxdHFrN213U2VNbitKcVdya2JuSndvT3FkWXUzSzZPbXY4WlNEZy9x?=
 =?utf-8?B?cmxLN08xRWlDcy9kTDkrc2lZQ3JLdHNrQVVudHNxMmszRnVEc3VuYnpXNkR6?=
 =?utf-8?B?NUtCQnV2TklmVm00VS9vV1dFbVgwZ1NFSkxsOHExNUt5SklDZlhZOE45eElX?=
 =?utf-8?B?Q1pnK20zalJRV0JTVkdVRC9DSVFKQmU5YzB6bnBzK2Z3YWRvcCt3cUtYUk4r?=
 =?utf-8?B?aDJaWlBSY21oc2ludEQrZHVCMTQ2Q0U4K0xHSDN4MlYvQXJ3MUhRamk0TmJ1?=
 =?utf-8?B?a0xFWHl3endlY2FzNWJtQlBDODEydmV6VFoxNnlCZkN2ZktUZk91SXhkLzVM?=
 =?utf-8?B?VzBreWZWSnEwU1dJNHpqRGszR1FzemZ0L2ZVaVNYVzVacVhmMzJ0c2tVMU9N?=
 =?utf-8?B?Wk90SjhsQ3hUU2s0YjU2UXNIUWhQc3pXVURKcEloQVhTRk5QTXJsQy9uU0hS?=
 =?utf-8?B?RXZiVXl6aDNnWWdManBpLzEvVitIeXJMRFhoQmE0YXBxcFZzL3Q2M09IZzVL?=
 =?utf-8?B?eUphNXpvYXY5YzRlemhiS0NObUNrb3FSN2xjdkJta3ZNYTlxcmZLRWpHNXpG?=
 =?utf-8?B?VDYzYjlvUUR2SFBvcjE5VTZTbFRNdm5pL05wSkZVT2xvOWluK1k2MkRNSWYv?=
 =?utf-8?B?NzlRSktaU1FWRXNCdSt0R2IvTG5zUkJYQk1HcXBSZ2xUSytRdG9JajZUa0ZE?=
 =?utf-8?B?aWU5TCthQThNNCtHSS91SXJUSCtyT05RNWpIeTNkWk5INzVGZzBWbHNqMlZV?=
 =?utf-8?B?NGpHTWdQL2lNVmFjU2lYUUxOU0l6azNtOFVXTjR5ZXczWXdQenU2Yy9tTm1X?=
 =?utf-8?B?d1dvS2xKRUZQRWhVcHplYjRsalZKelZnamE2Tk9OcGFyemZ2SlJ3SnEwZTF0?=
 =?utf-8?B?RW84UXFRZEp5S1JtOGloaEdOejNlQ251TnBCcWIyZlJZeEU5cXlzRzdTdW1V?=
 =?utf-8?B?bzVudjdtMFV4UGpYN0lsRGYrRXJIbVlJbG1wOE1SMlRoYjd1Tk9kalZVUklL?=
 =?utf-8?B?U2laa09NUFVWMSt2RS9KdmZZYUpqdURSUkF5cGx5d0s2Y1hNVlBNaktVUmVM?=
 =?utf-8?B?TTZGM0RHL0dtL3VWeWg4U2FWYlgzejN6cE43L3pLbzNickhZNk5PZ0lpYTB2?=
 =?utf-8?Q?TYHXDr7vBZXis/jIS16aa5GFn8Uya4bYYxMm/MmqgQ=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e959cd-1805-4b2d-5325-08dd2027b18e
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 12:21:41.5636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orvT9pyFfKaCpBsdPYZqQpN8s4qmjbbD1IkCGU8vJgPuYFSxNKuDDb4vbY7goVHXc+i0XBDkZAefPSx29rPwF0/EdcgE9OCuk9U0mxseRu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2977
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,


Le 18/12/2024 à 16:23, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Tue, 17 Dec 2024 at 16:36, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     This serie adds the support of sha256_hmac and sha256_hkdf.
>     A first version was sent several months ago just before the
>     integration of mbedtls. This new version is based on mbedtls.
>
>     The first patch of this serie add the support of hkdf
>     using mbedtls.
>
>     v6:
>     - use const for test
>     - set buffer to 0 before using to to compute hmac
>
>     v5:
>     - use mbedtls to compute hmac
>     - add tests for hkdf
>     - enabled mbedtls in sandbox_defconfig
>     - some cleanup
>
>     v4:
>     - fix computation of the hmac
>     - add more test for hmac
>     - move sha256 common functions to sha256_common.c
>     - some cleanup
>
>     v3:
>     - also define sha256_hmac for legacy sha256
>     - add some #if to define function only when needed
>
>
> Can you add my review tag to the commit messages for those ones I 
> stated if there are no new changes?
> So that I can skip them in the next round.


Oh sorry, I missed to add this tag on my patches.

I add them and I send a v7.


>     Philippe Reynes (9):
>       tools: kwbimage.h: use linux/compiler_attributes.h
>       tools: renesas_spkgimage.h: use linux/compiler_attributes.h
>       mbedtls: enable support of hkdf
>       lib: sha256: move common function to sha256_common.c
>       lib: sha256: add feature sha256_hmac
>       test: lib: add test for sha256_hmac
>       lib: mbedtls: sha256: add support of key derivation
>       test: lib: add test for key derivation
>       configs: sandbox: enable mbedtls
>
>      configs/sandbox_defconfig        |   2 +
>      include/u-boot/sha256.h          |  24 +++
>      lib/Makefile                     |   1 +
>      lib/mbedtls/Kconfig              |  14 ++
>      lib/mbedtls/Makefile             |   2 +
>      lib/mbedtls/mbedtls_def_config.h |   4 +
>      lib/mbedtls/sha256.c             |  59 ++++---
>      lib/sha256.c                     |  67 ++++---
>      lib/sha256_common.c              |  50 ++++++
>      test/lib/Makefile                |   2 +
>      test/lib/test_sha256_hkdf.c      | 198 +++++++++++++++++++++
>      test/lib/test_sha256_hmac.c      | 294
>     +++++++++++++++++++++++++++++++
>      tools/Makefile                   |   1 +
>      tools/kwbimage.h                 |   6 +-
>      tools/renesas_spkgimage.h        |   6 +-
>      15 files changed, 670 insertions(+), 60 deletions(-)
>      create mode 100644 lib/sha256_common.c
>      create mode 100644 test/lib/test_sha256_hkdf.c
>      create mode 100644 test/lib/test_sha256_hmac.c
>
>     -- 
>     2.25.1
>
>
> Thanks and regards,
> Raymond



Regards,

Philippe

