Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C17606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mjP/5qkI;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=J9Is/+Xo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABC44607F0;
	Mon,  9 Nov 2026 17:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VaeMj1gsneb3; Mon,  9 Nov 2026 17:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5C43607D4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794247161;
	b=DiVdggO6gBbK3GThKAjPg7APsBqQ1exfuUm/9f08/knSKY/y8f2z2bLWAM1xAjLRjLxZ
	 6ThLhmGZiyBpZS0c45tKTvrLtOamRiJ9YWu+zoFQ3h/2Ba0T8GSpYskRM+D8NlKEGV9c7
	 gnQg5FvqNGca6B6wD/olq/pvZbdVJBx6fkdQjtf7cdwXb1HXNXMoF+GWKLJGtoYqVtKXM
	 Z5KTls5dD+kw1OvtOv/05VVlgrxrGmDMNysobWrvtExHJyDOVYDOjs2IOR0mZdvj4yg3/
	 gKXpxxm9EMN1UmRQ5jKWW5ok3CsvjmYBApoZZcB2d0RxVxay2uem2zjHvJMb79XuYOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794247161;
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
	bh=qMits8OjiC5/9XuE3Lz1PraNxaosJCpJ2FCpLSNNoq0=;
	b=XGeBvEAjzcuC7VjZL8e4Mj+dA73YZfRiAR55BPBE3c/HTGYMVkspZep3BFFE9FiVUHeX
	 IZP7UmaS4y8NmIVeb2FJEKYGVFx0FiBW8ja2ncLoC0RgFHl8SgUbuPj2REj204GfZdT/L
	 plaoZeL9AzpwmzA5qur4PL3gRbAi8O5IVqpXWwn7ieUMBW1oHJ2M42VNxwraoht65ufTv
	 k1HhmQV2poxoSSvl0fVwW3hpmSP0DOCX6+s8+lV5MqLRc+/+ThM9lErp5RwO2909t2Bhx
	 i2CU0l12RGx1gEIp04fwOQhMCNZFyk8pg5+/upQjgSzfGKA0paNB1gxt1dcUH6M71Pw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794247160;
	bh=qMits8OjiC5/9XuE3Lz1PraNxaosJCpJ2FCpLSNNoq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mjP/5qkIGQh7hbpACZZyYpGxAKQ0fEZcOIu/Hyd+4M+ka4mVOYnXClTT4x1gzjbZY
	 T82cCpqq0eEO1X3xJtKIQqdLZKnSBifmj6LWM6JV4HDqOUzzBWCLlzOPxN0uoHtZ9N
	 tpnIUlyt8YTJVSOhLr1tfhGe02Z1g9PEuL4KkkWTPMkggqK98fG3i8RHCYRHMBNOag
	 1j1xrlajtJtxH45zJ1mxU30Vku2Hk/tA3A3rv7Gm7meaktfxNAPX7ziqoQ0hPbrh//
	 Y41jJ4ZYU62FzZMmKfPY6ZMrAYfYJRo0l7NHzb4WlX9d4eZy3k786p03SQ1i4Lh5Bm
	 nGlqFa2PJYe/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5C43607D4;
	Mon,  9 Nov 2026 17:59:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F88328C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 448F281026
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GYIes3QFuiYz for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:59:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9E4B81024
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=J9Is/+Xo
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9E4B81024
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMits8OjiC5/9XuE3Lz1PraNxaosJCpJ2FCpLSNNoq0=;
 b=J9Is/+Xo9PYN2gbaL7GyaOXLY7Y6DFt/hefCR/QVb7/sEHLj4rkUqvFgR+16/ykzXuzBX7+QkFQZ1cQHnMiSEhT7A5P8DWpAdkX3x4IOvetqKwt6RWw9c1rMdDEQUZam4tiksZXtrV+c8ZH1me/M5M90D5/RxHUoaIoXmq8Lh34=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU7PR04MB11138.eurprd04.prod.outlook.com (2603:10a6:10:5b1::7)
 by MA9PR04MB866193.eurprd04.prod.outlook.com (2603:10a6:250:102::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:59:12 +0000
Received: from DU7PR04MB11138.eurprd04.prod.outlook.com
 ([fe80::1776:6d51:6136:3dfd]) by DU7PR04MB11138.eurprd04.prod.outlook.com
 ([fe80::1776:6d51:6136:3dfd%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 17:59:12 +0000
Message-ID: <51b3ad23-7f57-4fd8-bc4d-f07beb05b788@cherry.de>
Date: Mon, 9 Nov 2026 18:59:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: ram: Fix LPDDR5X size decoding
To: 1579567540@qq.com, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Anshul Dalal <anshuld@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>
References: <20261023-lpddr5x-size-fix-v2-1-508af15a8200@qq.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261023-lpddr5x-size-fix-v2-1-508af15a8200@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0009.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::8) To DU7PR04MB11138.eurprd04.prod.outlook.com
 (2603:10a6:10:5b1::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11138:EE_|MA9PR04MB866193:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c83bca7-2a59-49b0-816c-08df3e8b2916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261021121427099003|261022075727099003|261009223027099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: XP3+7bD93cwjdxBHYcDJBUVtL254k3XtlICzCXnvy84yEzP2MLV2PQ3/q9D3OZBxXFx8WnzZvgdSC0mIlwfqv0o71Olh7CPsJ96XQo7K3I2uRVbNcPXFm35BpEPNQfKafsowkbn66Qs7Y1hZbK+zSDfu+duA14Mtg3R+U6RY0oDyHI6SOgk6EUgRTY6jMWSPfUukaPAhEOSgdw1TCzdiczwwP3AifwR8sa70pIITa/C47EI5Xw7sEkD+JyybSXYtdbxbNlb2YoAN6H2tFiGsCvvURDqv0XEIC/VdQrzGwh0M9geGvehFonTFd/J5/2eAgdGdIQ4G/BLk8woXQo+3bwMAFp93zEdW3dcGJRcq/gCb9UjrKsxajGyayuIrvoU0rcnZzb3+Gd4m0/l3M/SGS2gpRsPU7zhIxkChy6jvpU7zJojNkOcIslP3K7eqMXMvHBd2r2vIxD4S6tX3hY/biMh7VcRvY96ZQVAv3ItKUeers9QQBE35oCDz2qQDXYaMhYyqP/jd/HFR67oLR8ptsHNNW0AVh03rRuvhGLs4F2nwpUzD5Dp9nRvBz4ppA4vekrjnURFkaVQqSDLiOK64dxDya/ayXrfzcJ/GZMPm3Vsiu9JZHKhJ9MVMSa8m4K6l0yeaSaA2vamvVEfM7k2qLCkHZ64lOkOKQYfZkMQ/pIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU7PR04MB11138.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZFWTBEMWJBTkZPYTVDa09FdVlUNnZrLzFOQXpEMmhSeFJhcm9ycTFxakNZ?=
 =?utf-8?B?a3pRY2R6RExZWTMzVGJMa2tYb2lPU2FqWXl4ZUlOTTNyZk9VUjJwVnRrK3pL?=
 =?utf-8?B?b2dHeXlkUzNpMUxmVTNMV3NzeC8yR1hzS2xvUnM1MWZhMWRDVzFwR05qWWJO?=
 =?utf-8?B?STZHc0RnbjlQYTh0Z3hiQUg2eWRpV09yQUJhTjBIT2lFOElyWmUvZENwVWlL?=
 =?utf-8?B?c2pFcnRkcGkvWFduVFZiY2g3eGU2OHYrblRzTnp4WkdTaE9vRXRvYitoWThn?=
 =?utf-8?B?TjRZMzFxclI5Sk9EZCtZVy9ZTTJLcWJzSkJWbDRNYmdSQlJYMXUwY2lnaXpI?=
 =?utf-8?B?SDNXWDYrYlNlVzkxNjlCQ2V5YTczNHhGUGpya3JIZ2dBWmw0K1VFajMxNC9K?=
 =?utf-8?B?NGNwNFRlVXRmc1V0VGZ1WkQrK2REWGp0d01DTjFhZFpPdUtDUzM2UE5ZSVVX?=
 =?utf-8?B?bkdUZUpIVzFUS1VrRGJ4M2d3YUJHYXN2WnFDblFGQXYwK3ZoOVUyWmJqNGda?=
 =?utf-8?B?QTdPMlQ3cnhnMFF5dXFXay8vWEFxc3JidUNSbUY4NlpGUmdoYVlRaENFbS9P?=
 =?utf-8?B?Vnh6NURLdG0zYUsveDdqM0REaWdha2pZV0RhSG12MmlXOGthVlhQZVZCTit1?=
 =?utf-8?B?WmFVZG8rSkVXZWJ6UTRDb3IzRGJwUVR3ay9Bam4yWkRSWEUxRHdHUlRrMU02?=
 =?utf-8?B?TU5DSisxSXRQR3R3R0RtVWtCQzVIRGZsQ25McFREUUdaMnVDU2tDY1lYVFd4?=
 =?utf-8?B?WU1jd0J1bzFwL3hPY212dGpVZEMzNmVDNU13RGR2Umd6anJrdW9nRGVhb0hR?=
 =?utf-8?B?aVBwMGlkdlY3L2Q0VVNrRkVkMHliLzg4NUQ4bmdGM280aWI2N0pGaE9JMHkr?=
 =?utf-8?B?Mm94cW5qSy9URTNXYXQzc3VOTXpYWXA0RjZzaDRodkd6T0hJalprWFZhQ09Z?=
 =?utf-8?B?clZnekVhNEdVZnJ2eFJwU0RUMzhmem1NQzlmL1R3aFY4WnRHbVhNVUtucWNn?=
 =?utf-8?B?YUJzTTZMVS9NeXR6RnFLazVhZVRvZmNRYUFsMUZzb2RsZ3Z5NzI1aExSTFI3?=
 =?utf-8?B?Q2cxb1lxTGhNbDN5S2JHZDJoOUdub1pwTFRtTmhEb1UzemtyYXNualBYYlUv?=
 =?utf-8?B?WVdNODNrOVpyMlY4UmFyQVdESlNOSVVTdjJLaEdpclVPT0lHektUcGdvOTht?=
 =?utf-8?B?NHRpOW9iUmlNZU5FaDFEM1lvYjUxSFNLRDBSVXlpNGJmbFlObktaSmZtUGpn?=
 =?utf-8?B?NFh5MGFpOTdJbS85VjFIVk41WkRGUTBlMEt3M1hralZlRUZ1UTV5MjhtYmVz?=
 =?utf-8?B?S2tud1hUbktXUis1bmZwWFdhMzl3RVFqcUkrNzVqWjhPdmN4NjYrbEZGcXBo?=
 =?utf-8?B?ZWhKL3pTWWhJTzFuU2RyZktGdkdhbkVub3JNbytrbGdWUjZRVDgyZE1yUTEr?=
 =?utf-8?B?bEc0b0xlb0lpUWh1U3VVbE9YRndMN2kyTlpMcHZoU3BSWmU2c2pRVStIY1N1?=
 =?utf-8?B?TFp3R0gxUms1MUIzcUg5N0ZpN0tCd3FQNDg1NjNWMkFBOU92NjZObkcrQ0hv?=
 =?utf-8?B?M3Z4UzVkZktoWjE0ZHJHOHJQLzRlZ3Zkd2FrSGlmdDdUSThyRlpxU2JPZWl6?=
 =?utf-8?B?dXMrWEh5RHZJcjlCUWswRlZaVkFaT1RYQ0NncHdNWldNTEp3bUlUYWxlVmJl?=
 =?utf-8?B?ZnI5RkU2YTFIbVpOOU9vYmY3M2R5NkdXNld2TFRMNXlBSG1DTW1IemJFdW02?=
 =?utf-8?B?ZExOL2VIU0xmQThjV3lORjViZ3FkKy82NEQySGd3cVJsdjQveUJPNXNTdFM0?=
 =?utf-8?B?akR3cVVScUhSMlR1a2QvVC9jMkk4dG9XQ1FySG0xSUdVK3dFdXNvSzVBVGtY?=
 =?utf-8?B?czFIZGJ1cEpYWmF6VE83aGN3MjladzgxSDdia1NyZncrd29XTkpraGdBSHp1?=
 =?utf-8?B?VzNKcngrQzEybWp1QmZ4amhBamVaamE4aE1PV0g5RE51WFliZGpkMEpyK0tM?=
 =?utf-8?B?Vk1UZ0ptR09wa3g5L1ZpbzFZTmVrMy9NTEg3ajV4NC9xcFQzT1MxSmtCOXVq?=
 =?utf-8?B?MUpRbXFUNEkzNGRLVXo3dHBrVUtFTHh5TmNKVlBDRno1d2szaGtiRHQ1L2tw?=
 =?utf-8?B?ajNmQ0dnSVVvRHdTdXZPc0FwN0FGaFJVaHAwK2FLV1pUNXBjSm1vWCt5QUZ3?=
 =?utf-8?B?dHhvNHQrclBMdkp3V2xvaTlWZkorSzJ2a1JkQ05oZTBYVmhidm1zcUxid3pB?=
 =?utf-8?B?VnFwaVZ4emxtWEcrYlFjUzZ6OGhiOFJNWXZBQmhJSUJETG1LR1lzeDZpWlFN?=
 =?utf-8?B?dXIxWTVUcTl4dXlIbkhVN2hYVUdJYUthV1U2MURzMllKclhYc2pqdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c83bca7-2a59-49b0-816c-08df3e8b2916
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11138.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:59:12.1752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0FDebBp3r0zdBePORq0LySAJ4iNKIP2eltQHL9COVjAT8NuY6Xz44xVkzDG7imrtyFoVfrrC4fhKhVlfwOk6iFMnCpiMmvJxDv4EnjJ+Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB866193
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cunhao Lu,

On 10/23/26 5:10 AM, Cunhao Lu via B4 Relay wrote:
> From: Cunhao Lu <1579567540@qq.com>
> 
> The shared SDRAM decoder treats type 10 as DDR5 and uses the wrong
> bank count for LPDDR5X. On the 4 GiB OK3572-C, register values
> 0x100043c1 and 0x30001001 therefore produce a size of 1 GiB.
> 
> Replace the DDR5 symbol with LPDDR5X as type 10. Apply the existing
> LPDDR5 bank decoding to LPDDR5X so the same register values yield
> 4 GiB. The type value matches include/soc/rockchip/rockchip_grf.h in
> the kernel-6.12 sources of Forlinx OK3572-C BSP Alpha1.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

I unfortunately don't have any LPDDR5X device to test this on and this 
is data coming from the DRAM init blob which is also not documented.
Additionally, downstream (https://github.com/rockchip-linux/u-boot) 
doesn't seem to have the same formula for the bk variable. From a quick 
look at the git history, it seems only the Cool Pi GenBook explicitly 
state it uses LPDDR5X (the introducing commit for MNT Reform2 
incorrectly states it supports LPDDR5X).

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Cheers,
Quentin
