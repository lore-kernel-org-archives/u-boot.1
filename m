Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001CDC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 874786065D;
	Mon, 27 Jul 2026 09:09:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z7cqrDUkIj3K; Mon, 27 Jul 2026 09:09:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EF12605EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143375;
	bh=jq/4j0cd0WFwmz5+bn3+c83iF4WNIUoIbmlHt1y1avI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lukDJY/qQbtwP7CVFhvMjoU+JYI42hgX6qYZeZYTpvUbrRYpXDp6vMlxVooGAMrXe
	 CXk8Zh32mHqd3SiNpTXL0XPz22Z385D03mnbY6Sq/2raUr9mW3x2GEgEU6mWdayN3k
	 PKUXIoXuYwZw0CTIoiYzCbfOdP5FzlQVl3RW1xFyP0u64LoCZ31UvAucBwspA9R0xP
	 RdB+YYZHewoBZ4AYogY3PBtIJtjKwf15XmdszfAw0dz6lQdxWa+2WW3x3Vx2W1osZX
	 Z+VJzj9qlS6KZ/lDn7z3LA1pnE4DFFHaIdPHvic8+YXSx7pvJiLgBIdNtcKtic6YTX
	 IEPqSorEg3Zzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EF12605EE;
	Mon, 27 Jul 2026 09:09:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA03769
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF6C4400BA
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HeWHap8V4WWp for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:07:15 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CFC58400AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFC58400AA
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFC58400AA
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Weu9adZasngq6ZIbKS8cMqJfJzYYaEe6P6Z/sKzhcGR1l8FmymuvjDlyWszSqslyB7F1aZl23Gs8mA36LA9/1/zdnNNmHOKnU5DKN0opKRYTE3x+ACmfT+ba0dO23WVKo3PDtsiHX8sjb7EZAeFbYdN1htMSalY5N2ntBIvd3STpXpBfyI0IaW8QnZxCbDQ6fS5+8kxkw1JAuRyampHgoiFeUxrJsDgXVvRjDqJCxfmY8sc5pkxfSdCMKnTfvIaM/iXnCbemn1HK+9Ecyzry8nmNJzpvVRb0GFOdyKukkgSBqmKUzWBa8KeYPdmDUdUkWidtfuNzrT1KqtuYoVfF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq/4j0cd0WFwmz5+bn3+c83iF4WNIUoIbmlHt1y1avI=;
 b=lbhyf8ABx5whYH7x8/Lpqip6odnYKjS7qZMUJpsrv4Txn9+HMl5KV6vrQkmBv68HnggH1cbKDk0OV5QohKkqXcfqJw7jlFldS8WUn+t/1bt2mGl26kodVJXcZ4qHky09+iJjxkH38SNWTGNtRKxwJqo2h7uEFjsnJntORF2rnftKwYU7hf5gM4b4ilOnQyQmTRtfsO3hwfacXWUhF2P7IQQbp0BEc8CR6eway68a7CnnEpI4z5JHPRbl8hx9+LPp1t1vqWNGg4IAH40QInmGWwWQvCECoU5BAuRwIZEoKLN90FPifklmS36z7A+JGVpObiPEO0H+D2Qpq2m77sfyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by DB9PR04MB9353.eurprd04.prod.outlook.com (2603:10a6:10:36d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:07:08 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:07:08 +0000
Message-ID: <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
Date: Mon, 27 Jul 2026 14:06:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3] imx: Add FRDM-IMX95 initial support
To: Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lei Xu <lei.xu@nxp.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
 <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
Content-Language: en-US
From: Joseph Guo <qijian.guo@nxp.com>
In-Reply-To: <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0161.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::12) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|DB9PR04MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 07368fe7-104d-4b18-49f5-08deeba54a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|1800799024|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info: b90qjciBx2tdteXyiIbZa0P5DwL8+4gNfQb1eP54RGfkmVCCkIeI19b4xoiu5Xd6GGzL6yVk/r1ulmf85eJeiil4zWBUv65nPZj8DvUyOszhMiDmPI0j65Rd/HRwu1Z/GAOyyQdLjUmoT7OJ/CGOFXUua6weJ1edgmpewUKMx3Bqq1u4vFpXgHs3AN9cIYp4OLYYj3u7mCjhkADYxPqLoJce6PpMQMeGi/OKHDV+iNKuzDPbUw5Evg4e8T5rham1/IRrXAjBu4ZrXIZXUi8EO499KziSJvKhGIgZvOoKvfBZniTHO6r5gm0L+TT40NA35eNEar2Yxs89Yww60ScWKWjLJAu5FX+yz5nli0HFPrtkYB2uj+Vw04OVVUdRCnySTCdagbA6tb1hcfHGfX880ym0eEA3dQLBKs7k/GRj0eNpGtajL5IF4F7RA/cEcvCst+C0MX7g5MT9MPSazyC19DCKwfqPyKZPBzT6wt6ArGMlnALAVNKR07D708lBsYcb+kQDzJfVc04M0W7X3ZcX6t3h+2zzJXAG/5pobfoJ/9tATnkhLom/XwOqi5d1o4DEfEG1DPcp4Rpg1YbormYqRm4X4o0ZVZe2xtGmdYddE5gde7M0H5kON+D43ik+DLt2TBITqp9EvA93YraOKMaZZmOW3YHJW0dOg0g3y9FERa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmRKbGlMUnd0K2pkZ2ZMWFlSMlJ3WUVJS2lkOHRBdVh0TzA0cWNyUndjYSsy?=
 =?utf-8?B?Vm5NbkpBWUUxTGVoYW5MS2xYM1REa0l5RjhOYmwweHVqbXhBNGQ1cWpaT3M0?=
 =?utf-8?B?Z3BPSmU4ZVRkcFU3TDA4QWdrdGRML0NRT3hSM0tPL3pjTlVIRXN1MENzdEpD?=
 =?utf-8?B?MU5MQ0FhdGxuVUxxeUx3dDZxQjcyaTM1S1c4NDVnYVZqTGc3TFFwbU5MdWU5?=
 =?utf-8?B?RWhJeUJiTTFXN2tTOEpGK2YzRlJOa0RWL2xRM2I5VFgvTnNvT0NBUFdWYVRD?=
 =?utf-8?B?VzNwRlVlUTBzTTVhZ0ZWVXhINDVhTGFSVEhtU2xnUUdFd1hEWUFTazNiVHRY?=
 =?utf-8?B?c3lPMENEZi9FM2JWS0RsNGczRC9RWW1DcXkrN1pMK2pJRnRMcmVBU3BVWm9m?=
 =?utf-8?B?ZCtlUUlaaVI2YUwzeUZpLzRkeGg4VjZJc1psZzJxWklqdm9nbzdrTHNNZnBi?=
 =?utf-8?B?ZFdYQ1Q3OWdwc2FGQVcxK0lYTXQvTGdHUFVXcHlkWjFFWU9mMnVlbktKZ3Qw?=
 =?utf-8?B?OG1vOURQcDdycWNqbW1CSjNsc1RRalhSbWZSck1zeHhzQU5wNitVemRZYXhh?=
 =?utf-8?B?aHZGQVhVWGIzL2NyL2o4UEtTSFM5dkhqWW5XdWVkTk8vUUZjY0dQYytEb1VV?=
 =?utf-8?B?UHlBclh3MjU1ZmtySTgwMlJkVk5pWmluMHkwTGRYUDJlZWpvaUJ4QkM2ZUR3?=
 =?utf-8?B?YzNFYUM3RFNBYm56QmUrL2xHVlI0Rmp0aU5ETEI2ZUV1MWQzVTRlZnlGaTJs?=
 =?utf-8?B?ZXVnVnpxYTFUUjl3QkUrekxaTklOcnhHdUtZQW82d2s2cVdkRHZLcGV5WUU2?=
 =?utf-8?B?S211Y0k5NmxtM3YyVXRzSU40NWtCQ05uVHl1ekZvdUJBY1pjcURFaVJiVlht?=
 =?utf-8?B?QkFSYy9kSU9FaGh0WjVmR2kxbjlVamVXdVIzZWpuWXBjS3hUbmgxajVxSkZr?=
 =?utf-8?B?bG84Z0RER2dVSndaTm5TSWM5TFVkaUcrK2NQc0s0UkhLTWlTMkpuQ0ljOFVP?=
 =?utf-8?B?c1lRVzN1UWxxM1VGNVJGTnN5THZCSFRiMUNMdTZDZjNIU04wTG13SXBjSE1u?=
 =?utf-8?B?S2FCbmpKSVhoZXVmcCtiMkNGNDJ1aE9wQ0M3eTdER2YxTGVJV1N0a1NJMXkw?=
 =?utf-8?B?VFhicm41RXdubXhZc0Y4RkJxWm56SUNMY1NTTi9TT1lPRXpTNFZUZ3lDQVVJ?=
 =?utf-8?B?Y0xwQlhjSW5iU0VwL3Y3M0NYdjZObUFRYU1rVEVBOWc3aEs1Q2RVMGE2K3dy?=
 =?utf-8?B?MkVDeXR1emlkeDZqSTR5WTJVVnhibUJ0bU5sazQySEE4NXUwK0FsSDJsM0Ex?=
 =?utf-8?B?Q0VGVy9oc1VxOEhqY1M3MldDWjVEVFUraUFZNFRvVVdHenlITW9RNmZwcFJC?=
 =?utf-8?B?OGpjeVlwYzJEaWNzLzZYMElvOHhPY2NOOFpTRStXRzVnTU5sdFJwWWNEd0hR?=
 =?utf-8?B?R1NBTFhzNVhrbkdSREhzaW1DSE1OTE1NeFBnUHVjSHlvU3dmMWJTTzlhYUxn?=
 =?utf-8?B?OVp4YWVNR3FIbjF4WTRVYUZRaW14Tk9rblhuY0MrL21yRGhXREdmNjNMczY2?=
 =?utf-8?B?UmloYlhqSUpRYUlIOFZIUTR5NWkwcFRRZFBqUmJ2bGJIQmxjS011a0JNVXU1?=
 =?utf-8?B?em5zdzh3bjlBRXlCWFdVVHl6Mmo5ZC9yMXN6cUl2c1VtcDAzV1RmQlhnOFIv?=
 =?utf-8?B?NG9wSy9WcWhBRUk3Wkd1YlZ4MGwwSTFjYzRGYW54K3VPODJOeG40Y2dwUCtN?=
 =?utf-8?B?bjFkU1ZTdnpOOXVhbDZ0b2F2TmxZeGxtNDdsdERpaWNPSkVvUVZxTEJSdkV3?=
 =?utf-8?B?UTltTTBtYXhBTnpBTjRDQjRTdkdDWGN3dUJYdFFPNjdCQ2w0NFl6VmlneDVy?=
 =?utf-8?B?OTlGaUpuMUh5c09XSTZ1elBUL2VSR1RNTkVzVWtGNTlGZThuQkJyMlcvaHp1?=
 =?utf-8?B?U1NRY1ljRm1tdk1LbjdwRjJ1cU9TZUgwS1B2WFdFRGRhVnJyclVXSXpKMXh2?=
 =?utf-8?B?blQrN09qZVh4VVhPOWVOMlJtakRsSEkvTHRqOElsVUMrU3B6dUM3djN0dXR6?=
 =?utf-8?B?b2M1Znh5OVdmSTBuajNMdkZLa2xZT0xRcStYNWZ3QU1xVXVzbDA1b3dDZUpP?=
 =?utf-8?B?enQ3ZVI5Ynp5dkI3aTd5YVZCZkxzeGs4YlZJRzEySys5YUNlYkZteGF2bzlI?=
 =?utf-8?B?UWw4K2xxNWpJYWpKenBEOWVpMDI5cThOeXhQT1lrNkhvaEFkNjM0U3JvdXpY?=
 =?utf-8?B?a2ZFeVNjYUE3d3FreWxJUXBzQ1RrRm50OTNSeHF3Z0JRU0JnRjFCYVRtQVpQ?=
 =?utf-8?B?a3FNZEZWdUc4MFY5cjJRWWs0NkpMZFUvUWxwaEFGS3ZaaFFma1dmdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07368fe7-104d-4b18-49f5-08deeba54a92
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:07:08.8750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaEl/hNbmDKnTBUSZrcwhGawd2vbBFQeS+o5Bnnh74w2yX4ImGpRyl4TiBAPJXwwohaKrt3Eca42mQtMFLTeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9353
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq/4j0cd0WFwmz5+bn3+c83iF4WNIUoIbmlHt1y1avI=;
 b=liS/La3bxUKcWr53tr8cg8kwhGQsAMex/k1ZWegtu8Mks0qgH93vJQFxseNCA2EhdKWSi9OFjfShEtJl2UJZfup+mb7Rzy+grsi/flaSgK19klXD8iX0oLk0qcHWNXXMsolLsLhepFgG3QWPXFcHfU4q5HWHE0LmBcNHP6klzzq8kzbrOo4UdYVLSib2AXueGh9irR4lCxCu/+B6dZK6EPNfLPTBj9SfyyGv5nTPyen+Qt0uCpz8p2xgN6pmPEnZSOA7LOD0l8zCCLMHW4pLiD+stHspdp6YsNANTmxvdI/9UncB8BWrYFHt3L6tkULvt7Rstuiba2Op4CWjtVwe0Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=nxp.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=liS/La3b
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/24/2026 8:34 PM, Fabio Estevam wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> Hi Joseph,
> 
> On Fri, Jul 24, 2026 at 3:50 AM Joseph Guo <qijian.guo@nxp.com> wrote:
> 
>>> Please help upstream the alias and bootph-pre-ram properties in the kernel.
>>>
>>
>> The alias only works on u-boot stage. Can you explain why this should be upstream to kernel? Thanks.
> 
> This is not a blocker, and I can accept this u-boot.dtsi for now, but
> we try to keep u-boot.dtsi as minimal as possible.
> 
> The bootph- properties are accepted upstream. Take a look at this
> commit, for example:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20260723&id=06d40112780e79631537496f37958087ce2704f7
> 
> If you can help to upstream these bootph- properties, that would be great.

Hi Fabio,

Sure I understand the bootph- properties are accepted upstream. I'm happy to upstream them.
I prefer to keep the alias into u-boot.dtsi because only u-boot read that alias to assgin the fixed sequence to netc PCI host controller. It is no needed by kernel.
Is it okay for you?

-- 
Best Regards,
Joseph
