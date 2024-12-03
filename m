Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D2BE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311BE896B1;
	Tue,  3 Dec 2024 20:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=carallon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=carallon.onmicrosoft.com header.i=@carallon.onmicrosoft.com header.b="CwGoKTsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C04E9889E9; Tue,  3 Dec 2024 15:30:42 +0100 (CET)
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c205::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B259893CB
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=carallon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rufus.segar@carallon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnPyY72sYpioimI17I1FN0Y9ftzjyFzzwpIGfztCz5N/f0if+D6Zn3zfzxkLT0QtaAVgGSaeXO48WRuU95HugIykSxS4wfOwhPaR+z6MNWLVeijSJfge3MWi+KHuJFq0B6gf0EJd5q2eLE2GRwh3QMltQqdqaG+ZmqWoLkTVJ2HjfZm61QZgDPbfgoCcUxy7Q1Awuze+IWP6pvr7bUEV59KLIFb069NSw7QdqwibQW3Ob4POvm5Et8slZElrJWrD1eNd4DArzwvEtZQ9ZDhCxx520smdcJt1+tandqxclBmFIYD9cte4lkA4s8anGV6aeMRQeUgK9yl9JQmAgq95PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Om5GuG4cscbOoSQMPdtG6KVfPSH7DY8AaIwxXfKWqk=;
 b=S1ChR98MXi15eGIihrJQylBnKvmljher1Ome6AbPEIM7945ytWVIZ0dogwJcpuVSqXZsEYB/swtI2BFchVUL/tm/Y/UGFiQNrmNkAsacCSTFJCJ36mTjCZc60OoOf9RRNWSVFmG44zRFnBFGBLD8rByUeKU1yq+fX9/xHyeUnH1zjgakwY0dGoTx/O7S2XtgALVYrqe6Sukj1AWBl0Gv8zvtCOq1bWw1m1nqWlKfU1f7Zly1YOE5CEEKZ9lNtNncPFuu1z3Iv9WqGoEdUgK8e8FlXwgHmtDtzyE21aeR4hfAtZ/TnxxEByGEin3jxQzCDvVotrpniuh/KtA7G9UbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=carallon.com; dmarc=pass action=none header.from=carallon.com;
 dkim=pass header.d=carallon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=carallon.onmicrosoft.com; s=selector2-carallon-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Om5GuG4cscbOoSQMPdtG6KVfPSH7DY8AaIwxXfKWqk=;
 b=CwGoKTsGXjkIeD9HGSLWW28pZUgnGjhOblAITpUm0+ow/qDwzL/4Uvx+GEhTptf8Pg17S1p2X32cGJOpTY1rjmc0KC1nfQy6llojWJBISm5w8oGGFEqr6tt1D8eZlleE772m3/PrkUkF+QXkAWJ8fGI63YVTbS3ceTkMAQFpzKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=carallon.com;
Received: from LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:325::9)
 by LO4P265MB5945.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:293::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:30:37 +0000
Received: from LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM
 ([fe80::28cc:cdce:8d07:84c4]) by LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM
 ([fe80::28cc:cdce:8d07:84c4%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:30:37 +0000
Message-ID: <fb698f79-3b93-4e03-b582-c6a80b827318@carallon.com>
Date: Tue, 3 Dec 2024 14:30:35 +0000
User-Agent: Mozilla Thunderbird
From: Rufus Segar <rufus.segar@carallon.com>
Subject: [PATCH] dwmac_socfpga: Add RGMII-ID support
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: LO4P123CA0402.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::11) To LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:325::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P265MB6811:EE_|LO4P265MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daafef9-85e0-4c01-b4e5-08dd13a70de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alNKRElsVDllVXp3OGUzcWplcHkyK29NdFp1Z0ExcGJhMzAzSDUzUFlmSDJK?=
 =?utf-8?B?MWtHeVVHeW1QUTdRL0ZtdjlKdFFDYzI4SXpRWnQyS3Q2SlZFYWtlMDB2Uks3?=
 =?utf-8?B?N3haQ2tXbTdWYlV5Qm93ZUlwT0pFQWlRK25IU3p5cnQvVTZ5eUtYdjh4V3g0?=
 =?utf-8?B?S0FRVWhTK21Qa3dQN1pNc3Axd1dmcC9xRkJUNVVXeGpkSWZ1OUV0Q3pOUDc3?=
 =?utf-8?B?WXMwa0V3VDl6a25PYi80UVNyZmd6Wkh0SE9PamZ6VTIvUGNndmJnaG44YXF4?=
 =?utf-8?B?UHQySmdDajVYUUgyVzBMZklRWEVCWURKOHNMbVRZMUFqS2tmMEduemFNV0Ir?=
 =?utf-8?B?MDIrSE1tYkFtUndsUCtvSEtKQlJ3Zk9xbUFLZWdrL0FwZGUzZGdUaTBXSUJH?=
 =?utf-8?B?VzBMRnptWU5LdTFkc2ViSFNFbEpBZmx2Y1Z2TG95Y3ptWDlzN3VGbm5TZWU5?=
 =?utf-8?B?WEN4MUMxZzZGbEwwbGNDbFRINkIyanFhdE1LN3JUcE1sNVc4VFZBZlNWWHJS?=
 =?utf-8?B?aWtzdlBreFBYSmM5VkcvVnRxZG5SWS9ReUU3OElMb2tGRW5ReDNMbmF2VUty?=
 =?utf-8?B?VCtycWNnWE9KUXBZckVNQ2c0dFBpcGRmNjlLQW8wRWlhUnlvQUVtRDRUd2FU?=
 =?utf-8?B?UHBwRksreGFNeWJ4K0xSbU5ZakJMSTBoQks0cUh4Tnp3SE1aODhMaG9kR0ZY?=
 =?utf-8?B?ejJCZStGalNZWUQwWWRUS21YRkEyOGlUWlBKdFM5d3M4OU1Eck1HeDdsbWtx?=
 =?utf-8?B?bW1zRGhPRG1XWjZRcTNmNFBtSWt3VThxSjdCVUgvZDViSHlWVlkwZUsvSU1m?=
 =?utf-8?B?V3N5R1E0S2VsR2c1azhXcy9kc0FMeFh2a1FldExzdmhtd3NJUXRlQWY5R3pR?=
 =?utf-8?B?K0ZBcUtRenZUcW5DUDZzUCtyYkdXTFFwQmI1NzVjU28wNmNHZFNBRzI2aUo1?=
 =?utf-8?B?RVFWQWs1SXJiWGx0NkR5TS9nNjM3cnBYbG1wTzVIbE5qaUpBL3dnVktjcVB5?=
 =?utf-8?B?eE5CMURlait1cXBCZ2FQK20zR05UMXZuWTYxUmd2RzAvNUsxekZjamhmUnVT?=
 =?utf-8?B?RWxnaVBPL0FodTlPeThwMVhQRDcrajd2UndSZXlvRGgxOTdNNmQrclE2Zmoy?=
 =?utf-8?B?Qnp1SDJwWml6bGx5ZmRUUHpsZGlIeWkzYjdvK1VwSG4zeExIKzFzL1BQYkdH?=
 =?utf-8?B?elBPUzFOZEVXOTREZkVReTZxcUNOWjVvaDc3T3RlRmNnNUJqanRXQm1qYkZT?=
 =?utf-8?B?ZnY4NFdvM241M3ZDQXFkdDM3bzBKb0dua3NYTFNsbHB2Z1R5Wk1hdW81Z0xx?=
 =?utf-8?B?VFcvUXMwZnhyRGJKYzdPZ0VjTUVwTmVHZmlEc2JKUjV1S3lhZmZpUXEzeUI2?=
 =?utf-8?B?QmtrQWRKT3dCcCtaSHJrdTJOQ2kyYmo4SStDK1FkNW8vMWFQRDlQRGk5ZjJJ?=
 =?utf-8?B?MXRGQS8rRWdoc1pJQ2t5WFl2WU1HMVdYdVlyOGN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlnMjlVSkIwNmYyNlcySC9lRGM1SzRKeWkwNG1icytoaTBiKzRJTFQrem50?=
 =?utf-8?B?d0d6amtuUzdabW5CRXBWWTlMV2ptOWVRaDRFL0U5UkxxWWQxNG1Eb0FCazlN?=
 =?utf-8?B?WUVqMWxRb2JIYUxYZ01FZEhJRWx6dDBJaHN1YWY5VnVXR2xwZkEwVk5KKzlz?=
 =?utf-8?B?ZFZxZWMvZ1FTT1lNb3pRcHVjaVQyNE4xdElXNUpSQ0gxa3NRckw0TEFrM2o3?=
 =?utf-8?B?MUZEdXhncU5TRVVncS9ENTdaemxjbTRyMDZwbnB2N1JWUU8wQXVXUUgzYUsw?=
 =?utf-8?B?Y3BuSUZaMmw0SWlHTjloVlhLQStqNVpQcnB1ZUlldXcyb0VROWwycFdZbnV5?=
 =?utf-8?B?L0dxZjFTZDYwa0RqcWRNM3dJSmh3bE1nQVVOcFlHN0Q2SStJemF3Rk5jQk45?=
 =?utf-8?B?dU52M1VOSnA3azNYTHhzc05pb3RyMzFZbjlPVTRZaGh3RURsRE5uaEtRVUdZ?=
 =?utf-8?B?NkU3dWJyZy9aSWk3T1pRK0wrNVNNZzc1T2FYUHl5RXAydjhUR3hGWVNjUmcv?=
 =?utf-8?B?Z05DQndEbFhIR29BMFJFaVFwOEsxWk5mZlBDdXNTcTZxNGkrMExWYmJGVmp1?=
 =?utf-8?B?U2EwejFCVWhNMUduNnBBRzdJcnZTRWdiNjV4Sk05em0zNW9URzAxSldLVmFr?=
 =?utf-8?B?WWoxcmFBQ0ZhSlBVM2pQY1pqYjlHNGVHZjNaT0JvQ3RLWEd0ZVB4bW5rSzNr?=
 =?utf-8?B?YmRCWHdHQU5XYU91NG1aWjFYakd6SWxhTjB4N1J4cWl4U2hkTHpWV0F2bXlR?=
 =?utf-8?B?M0lqR084SXZKZ1JOemVCeC9HaEo4N3ExZy9OclhTR2RGSEh2ZlJlUmtsZHpK?=
 =?utf-8?B?SytIMU82MitERlNGUSszZnNUUEZMUkcyZGdpdWFKYk5PMm9EdEt1aUV5Zmda?=
 =?utf-8?B?NUQ3M1dzaUhXeVlaOVh4K2dLelhhRHU3RE9WUWpyVTVmQ1hYbW4vMUdidnRL?=
 =?utf-8?B?VmlWSks0NUw5Q2FQTG1raitSQjVvUldOamYrWnJKeDFXS0lTY0tkWHJaVjVP?=
 =?utf-8?B?U0VXYmQxOUExVDlWaE9SK1kyVlZmMklSdEdwQXZwZHEwaStlWGFIczg1V3V6?=
 =?utf-8?B?eFpLQlZOR1IrdHpFQXdZK1ltZ3FhNWZabUFUS3BkOSs2bWpSZTY3MWNFYlRa?=
 =?utf-8?B?dzRuR3J5djhyMEt4bkh0ZzZ6U1d2NW9aL0VnUjdCZlc2ZDJMODcyTjREb0NO?=
 =?utf-8?B?NzVZU0ZrcG1oM3kvOXI2amhKUmZ4MmZyRnBOaXhhMFg0SUNCczJtR3k5bEFO?=
 =?utf-8?B?SGlPanhEaXJiUEFZcER3VVprWXZmcjRvZ1lLMjNyNHY2djdmbjhkNkUvdFJq?=
 =?utf-8?B?aHRjYm1NcHlSZHdOMVlVUXQrZHNmTUZLVTBPaHZkUXBuNEVxYjYvSWdEWXBW?=
 =?utf-8?B?Z3g2cGE2Rmh1VDQwRDE3M3MyamVDYnIxdzFhNnF0NUY5RldQTVo0aXZWVzRv?=
 =?utf-8?B?N3FTbHI3ZmNrOVdrUjVLVUxYcWY1eGR5ai9oV0h6UjB1L21PT2pHR0M3bWRF?=
 =?utf-8?B?UHlvRVdBNU1RaHVqSGllTWRDTkhiMFU4SUlYUk5tNEFOWnBlN2creVZkcHRi?=
 =?utf-8?B?djg4K3ZZSHl6czVHRE5GdGZJRXJPNEtVZU1FOEFWS2JrVzlWbkkzamxlYWxq?=
 =?utf-8?B?dXp2UlJlNytqdUoxeE0vSkZjT0pETUZlQTQxakkwbEVUa0w4S2FyM1VtRUhx?=
 =?utf-8?B?MlRIRS9WNVY1ejh6dDI5NG5jalduRDR4OW9SR250ZWVRK3dRUlFoOEgxdVp5?=
 =?utf-8?B?bFdUYjVVTVNJOTk0N1RhUTlmb1FHWFZGOHM4T291MExPY2ZHUmJFSzgyMnBX?=
 =?utf-8?B?emtDM0xtRnBZSlNtRy95OUdJbkhaVTNTNzZ4SGt4QitFT0FtN1BBcndwbmtX?=
 =?utf-8?B?a1dJMDZ2ak9hbWUraWVrWExuWU9tK3lkQmtkOWhZYURCVzJ2RzBmN3c1Uk94?=
 =?utf-8?B?VTQ1R2pNMWZhUlkvWm55NERiam9SZmIzam44WGkwQVNDR1JzL3IxaTh2M3ZT?=
 =?utf-8?B?SVRRSVNKTUdNZW9LWk9VTmZIS3dZL3daMXA2bklBT3g3bnEwOFlFNmR3SUFZ?=
 =?utf-8?B?L0FwQ1FOT2p3R3Z3cXl2MFBrQzlQaXp4eGRaWFVqOEVXK3Q5U3htSCs3OFVt?=
 =?utf-8?Q?OZO7Mns8C+ugbIw2a9ncLZnNr?=
X-OriginatorOrg: carallon.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daafef9-85e0-4c01-b4e5-08dd13a70de1
X-MS-Exchange-CrossTenant-AuthSource: LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:30:37.1979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5677293e-6dd8-433d-8f8c-03a0fd233eed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9wcJugn15lhLiBrTvAEKMdbsk24ylyQ8LXhnk8YUDrX6M0wQvwra6DUCC2pLzhsMdmYNiFr3UfazilVg7AsuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB5945
X-Mailman-Approved-At: Tue, 03 Dec 2024 20:40:44 +0100
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-dwmac_socfpga-Add-RGMII-ID-support.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-dwmac_socfpga-Add-RGMII-ID-support.patch"
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

RnJvbSA5ZTI3NDUxOTM5NGZkYTQ4NTBiNzc3MjZmZmNiYmViM2MxMjgzNTYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSdWZ1cyBTZWdhciA8cnVmdXNzQGNhcmFsbG9uLmNvbT4KRGF0
ZTogVHVlLCAzIERlYyAyMDI0IDE0OjA5OjQxICswMDAwClN1YmplY3Q6IFtQQVRDSF0gZHdtYWNf
c29jZnBnYTogQWRkIFJHTUlJLUlEIHN1cHBvcnQKClRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZv
ciB0aGUgInJnbWlpLWlkIiwgInJnbWlpLXJ4aWQiLCBhbmQKInJnbWlpLXR4aWQiIG1vZGVzIGZv
ciB0aGUgZHdtYWNfc29jZnBnYSBkcml2ZXIuCi0tLQogZHJpdmVycy9uZXQvZHdtYWNfc29jZnBn
YS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9kd21hY19zb2NmcGdhLmMgYi9kcml2ZXJzL25ldC9kd21hY19zb2NmcGdh
LmMKaW5kZXggYmJhM2ZjNGQzNC4uZGNhZjQxMzJjNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQv
ZHdtYWNfc29jZnBnYS5jCisrKyBiL2RyaXZlcnMvbmV0L2R3bWFjX3NvY2ZwZ2EuYwpAQCAtMTA2
LDcgKzEwNiw5IEBAIHN0YXRpYyBpbnQgZHdtYWNfc29jZnBnYV9wcm9iZShzdHJ1Y3QgdWRldmlj
ZSAqZGV2KQogCQltb2RlcmVnID0gU1lTTUdSX0VNQUNHUlBfQ1RSTF9QSFlTRUxfRU5VTV9STUlJ
OwogCQlicmVhazsKIAljYXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSToKKwljYXNlIFBIWV9J
TlRFUkZBQ0VfTU9ERV9SR01JSV9JRDoKKwljYXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSV9S
WElEOgorCWNhc2UgUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJX1RYSUQ6CiAJCW1vZGVyZWcgPSBT
WVNNR1JfRU1BQ0dSUF9DVFJMX1BIWVNFTF9FTlVNX1JHTUlJOwogCQlicmVhazsKIAlkZWZhdWx0
OgotLQoyLjQ3LjAK
