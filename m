Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E498606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fyuHCVGq;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=lK0Dw32U
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62FF44057A;
	Wed, 18 Nov 2026 10:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3RMwHeVFdDmz; Wed, 18 Nov 2026 10:44:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 905874050A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794998660;
	b=EzvbNGRnXit8YWo80BJyA05NA42ow70bpUN1/pxbV2dZbI0xyvzkFVq9HDMvF5wxdxLR
	 FD5vLtkHWq2lXHPka500i1dlzXS+/SKYJSQmw/jTA7i1Hb2k+N1vHpIjQ9gh6/9RzdG4P
	 G3YFyTMVLP1TfMk/wjtHmgJxHKGidMS/vE3HUoJXi0vjJ9E5raiChnP7nl+CDjc6bEW+f
	 RhGtYjkSZL5OkzICThb/TDh8cK1N5FaJ/HhgqP5IcwVVzv2u3JWEx/EtyibS6XTOQNWJh
	 mjW8sIw+WorlFoWlX49dcB8d2vyne3avXSTcTzRUNpYr/B+KS2DU7wTLWLOtiTxWVGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794998660;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eMrrKeXHFNNDi909fLTTGLdHMG6QJfMx+v/tZTaY4as=;
	b=Cxq/T4jOendfkt3jVqwiyQpIcKChst/iPc26TK9GIan9RmORtz0vS3g2rjHUAQqMn28J
	 5n+deGaQyNcy/cB0GkpyFH+1uEqoWvMskp0LM7xvZT9iHalY+9sFNct3dvJ4M1DLYwKOv
	 l5hUtta3ajLikHFCR33IkuuUgviiFKV6KWGB/p94ulDw4y1cTqsQk0Enj9STUoMZWPda1
	 IuX73jNYaTt2d2zfMWzehpKUZ+vgGIfkhY3TJhBfmCowQ2n9YTupGj94FujeVd2ybJmN6
	 LSedhFwIIa/V2IvruW/hO4Rwl9zE7++uiQ7CBkmbRA6rp1oFd3F5eACBfnxFAi9zqzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794998660;
	bh=eMrrKeXHFNNDi909fLTTGLdHMG6QJfMx+v/tZTaY4as=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fyuHCVGqCWOs8SCTzcK/1xzVFvmrpzWkXiBbq1QQ/H+SS5o+5g8ri8sO0opn9oeOs
	 7MQ/QDZ2Urnw9NC3LQAmvXXbP8cFfVTihpzylrnhcfFGFpzKDDPvYmNLlQzOrqhH5a
	 VipOyOcQo9uopoXzY3IyUYRVHYje5ACKlr14qYdTwBxtdXNig512x6D6ED70jvB7I0
	 6aRCsDS4NDRqIBnndCNKbv2o5Ad6PxQoGJGM8Rx+i0t2ckyEcFdxc37kvZYfGGjwng
	 EE5aQ8jEMb+Wuin2AUQGqChyIcydzWE+Hbum9gcg+LRlo20OHnWPwsREALOGOygxKT
	 9Mxwx6Vza4GBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 905874050A;
	Wed, 18 Nov 2026 10:44:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1BA5260
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C368480D85
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fxr-cx0U1sf3 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 10:44:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F214B80D87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=lK0Dw32U
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F214B80D87
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMrrKeXHFNNDi909fLTTGLdHMG6QJfMx+v/tZTaY4as=;
 b=lK0Dw32UNK7njWs7mpFj91WtEHTX2Wb9+RCuj26kiDBH8i+wHTxiyEa7PnDI0WgGpjcQMhu2jfmM8ar2iMqOVUoWZxilHeFG6omCLvOL/4V3BozJKOx1KP/+0mkahiiXUUkf6OEvjBRjSjI2NiDZ8uVdATRFm3xvwWavMWja/f8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU6PR04MB11182.eurprd04.prod.outlook.com (2603:10a6:10:5c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 10:44:10 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 10:44:09 +0000
Message-ID: <7bcca998-bc6d-471c-9534-5c218f79b460@cherry.de>
Date: Wed, 18 Nov 2026 11:44:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Move usb-onboard-hub into drivers
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20261118072332.627163-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261118072332.627163-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0045.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::17) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU6PR04MB11182:EE_
X-MS-Office365-Filtering-Correlation-Id: 93efad33-fc5e-4956-bcc1-08df4560e08f
X-LD-Processed: 5e0e1b52-21b5-4e7b-83bb-514ec460677e,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|7416014|1800799024|366016|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261022105027099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TAhQlu+rpRZRasCaxbXKmpZlmdqo9u2aRPj9qhk3DbqHU3duT/G7Hw9hEQe+1n+euSvkNgeQrJIQV60Ae2x6SrL0d4QzEqKMtPk6jaBUilEb2VvJ5pnB9flOfXrxaL9ttG6FA/ygN72x5L1mb07tXoCxcM2jtEx0wjFHqeT4ihIbf3mC5VFVSUG6xy7GcCII6rwF18oEVkNMPzyoNADwl0aQiGi/W/88ZctzbM5xrDfbROZNkP5Qx3x4ppF7+/imXPGVDc0LYUUoTLVyr53rrsmhLKIluRF9IiVuoaFijzUoUYCCuKDLaUMae+40vKrJ40ygSOQBE+in4JhIkXQ2LTBB1gBJAw3RK0bOFWjGyzOt67yHyvMLlwjoJmHbrqMcnjsBBJCpNu+9u9DxdBjfhhpNhukD+UW+FpTaMbafhBAIijR0oDPyo4AwFmapdC9SSCQuZHnQA5GxCdGtqVOBSMtP9m60OqSnx6LV48k3fwf655358rYTFjhGVpiyamrL7cQ7idU00pRzCxDdZtxumNMzO44Q/pabYqU8kihj0NS61TVWnYE+KuN15bTzS5ctF0Q0MP3MqXme0IC7RW8R18yVVIPACYppoHbMdBWvuWhpcXFKihX0LpehyvUSxbhs33QGGZP+pOM4z3LZ2ckUPuM6eFUPxLZUSmptdFOoZ+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXg2TjlnQmVBb0NjWVVvZFlRWjh0aEdNQjhIMFBJUGtwaTRpZUV4M2dSWnVo?=
 =?utf-8?B?WTgwSWhsZVFzTU4vMzlYeXZUVmZRQjYxMFpYeHhBVk9kbnVkNjIyOXV0UTZI?=
 =?utf-8?B?djg5S1pLOHJIdGF0R2xTTjRYS3hFMjFHUXNBM2pDMWdOREVBVFYzTytDVkZm?=
 =?utf-8?B?UmFnakIvYitZcXFWR0ZRRXYrQkp5ZTdzaDkzcUY3MXV1REhSMmNnc3dBRHU1?=
 =?utf-8?B?MnhpVWpBdWFDZTl6WDB6b2pWYkVxOGoxNHJiZEd0UFJxcWdVUzJocXZlMUZu?=
 =?utf-8?B?Sm5vYmdycTZrUGpTMElabzlUelhsOU1iM3RwZmZPck5wd3lYSWtEQjAxTUcz?=
 =?utf-8?B?VE1zZmpwUFE5d0JzOWtvUm10emRKRUJwY1h5VUpXbHFRdStWNUwvZDV0Y2Y3?=
 =?utf-8?B?Mnd3ZG9UNTVYakw1RlpFREZsWHljQTcxM0ZVd3cyQ0hxZ2lQdXZhOFpTTGdZ?=
 =?utf-8?B?RXdQNWVKajR6eDFTajBsNWZOMnkrT3FRK1lJQllzZW5zSmNmTlRhTExxSlVh?=
 =?utf-8?B?Yy9MNUZoSzhBeThGTTBBSlRYTnRBdERqMXprYjhJYSsvK3ZDM2hQelV5OWxB?=
 =?utf-8?B?Znp5emlZTTUvUnVMWUhWay9LSmEyRjM0UldaOWpmT000NFVxcDFwMVl6NkR3?=
 =?utf-8?B?ZTRoaVl4eDFOSVMvdnpRaVcvUXo1eXh1eFlXbkdpazlvbXNZY242bGEzRzVR?=
 =?utf-8?B?RWVPelc3Uk80YUtvTy96dldXM3RBNWJMZVJjdlRMWGlSVC8ycDdWcEI2QzRB?=
 =?utf-8?B?SDEwRHZMdmU4ZWVUOFV1ZXNidmh1TWNINXNiYktXbDBhVTB1NEp0cXNYM1Iw?=
 =?utf-8?B?NjhTbGRUN0NQUk5Kd2VFbzU3aXpWU3ZRais3QXNnN1VuUVVJVy9TVXhYVjBR?=
 =?utf-8?B?RTh4R005NjlFZjdwZkVoWmI5OXJ2b05tS052dzhLdUZGWEFyLzlRMXhkQk5u?=
 =?utf-8?B?RUxpaUU5WEw3ajFGVHZlSjRWajZkMVZ0eVBQM0FkSHNnUit3dE8vRU10cEx6?=
 =?utf-8?B?UmM0d2pQamR3VDBzMUVWOFM1TVUyMk42UWoydGdFR0k1QlAxVnplUGtIcUVm?=
 =?utf-8?B?NGlCZXVuZzZTdGgrNDVhN1hDUmQzYnBiMkh3ZFNSY2dLMFpjemd1QXk3anEv?=
 =?utf-8?B?L04yYzVIc0FNNW42K29LeGc5YUJxUjZ3UldTdWY2bWNKUk5MUTlXUzI0S2pK?=
 =?utf-8?B?MEFkcHJsN2k5YWl3cXEzL2EvQzhqVXU1bzAyK3lYVEl6TFUwclpEdDM2Wkk2?=
 =?utf-8?B?RTVXUWt0SjBqMGVYVWUrZDNkR1Nzbm1sNnNHTEc4dmw5TE9qRWhNZE50bFpn?=
 =?utf-8?B?dG9Wa2R6V3QyZ1Fuell0akZnUDVjR3FSMnZUYlNRcFFscFlOTE1zbjhjM3VI?=
 =?utf-8?B?MkZKRzZmRFFSdWFGay94eEgyRU9vc0pCNjBHKzlBd3RkelhURlhPQ1FtZDYw?=
 =?utf-8?B?UEZMZkFCbzk2bWpvRHI3VTJ4M1FYQ2lYcnlINWthSGxETlg4Z016RGlINnhw?=
 =?utf-8?B?UkhBVDNJQkRjQVpiUkNPVmNrazJpcjZnenFHOUlUZWJheHB2OW1zNmJoSW9J?=
 =?utf-8?B?Z3FTYlRBYUhxTVRaMEZVZG1JeUFqTGlZNXpabGlXb1dTcGdiUDNpQXc3dTRC?=
 =?utf-8?B?eUdvVFU1dzJZaDNaL1JXV0Rpa0FGV3JxZzhzSnNhVnZ1N21NSnVDOEYzMDRo?=
 =?utf-8?B?T2ZSNVpuNmtqVzJXUVNvWXBFUEJ1OEJ2WmF0YitBcHUrRGh2MXU4K1pMVlpS?=
 =?utf-8?B?eHpKcGVSbXcycEk1V2dJQW1EbzYzOXNmUTVYUWlGMHJuWnd1TW9jYmN2dFZJ?=
 =?utf-8?B?cjhPSzM4dXRqVFpqSFRhYWRuTlVMVm5wU0VpWm9vN3E4RS8xbEpUbVNucDU1?=
 =?utf-8?B?WVFaVEpBcERWa2E4ZVRPdXJwanB0N1pEQ3JId1pnK1IzVXp0R2pVMVhENFBX?=
 =?utf-8?B?N29QUUNLYWZ5ZENvTUNETGZpZm43N3Y2QXEycHdRZkJ3dENYV3NHb0lhZlFH?=
 =?utf-8?B?dWpPeDlxL1R0RTBib2xvbnJkSzBPL1pSSjFQc05DUHVIRVlOUWt4dFlyR2VF?=
 =?utf-8?B?REJ1bUwrL2ZNUXdVZWQrSlp1cmZxZ2s1L244M25XallhN0FoTnpjTFRzZzVu?=
 =?utf-8?B?M0xTRlNlUnNpWUcybXN1OWxmWm1wbG8zZklWRjBSTE9LSy9KVWNJSkgrQVZn?=
 =?utf-8?B?eklyNVQ5cU40SXpLMVdXTHZiZzVmUDVOSG1hVHZ4TG1YM3JVYmtpbE9oUzdQ?=
 =?utf-8?B?NUpxSHJWL3dmbU5wMmlPa1JsNWRFcjU4cTRkeCtWSTUvOFdnUFFhSWdJWmVv?=
 =?utf-8?B?emRCRXJYbXowek16bmoycURGTmFTbGk0MkxQVC9xWjM2cVQ5YzU4UmtCRWJ2?=
 =?utf-8?Q?OPIxt7WRZGXYTli59J67OUblwaAtbA3/DD05Rf/YmYhDA?=
X-MS-Exchange-AntiSpam-MessageData-1: d345nj4ZKGIFFp1AUUgHy6QWKlb72q06ld8=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 93efad33-fc5e-4956-bcc1-08df4560e08f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:44:09.9012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpxe52+pOlAIbmxT3kkYYjcempPTDDx9MiLIePJjSTnpcDzvlgwc+3YDgeklp7AR9TkragvxFKMxFbssi594VfvAUtm6sMs31lbspDEWWH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11182
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 11/18/26 8:23 AM, Marek Vasut wrote:
> Move the onboard hub driver into drivers, this is a driver and should
> not be in common/ . No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> 
> Cc: Alexey Charkov <alchark@flipper.net>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>   common/Makefile                                  | 1 -
>   drivers/usb/common/Makefile                      | 1 +
>   {common => drivers/usb/common}/usb_onboard_hub.c | 0
>   3 files changed, 1 insertion(+), 1 deletion(-)
>   rename {common => drivers/usb/common}/usb_onboard_hub.c (100%)
> 
> diff --git a/common/Makefile b/common/Makefile
> index d62ea34599e..ac6a2d1ae6a 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -35,7 +35,6 @@ obj-$(CONFIG_PHYLIB) += miiphyutil.o
>   obj-$(CONFIG_USB_HOST) += usb.o usb_hub.o
>   obj-$(CONFIG_USB_GADGET) += usb.o
>   obj-$(CONFIG_USB_STORAGE) += usb_storage.o
> -obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
>   
>   # others
>   obj-$(CONFIG_CONSOLE_MUX) += iomux.o
> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
> index db8f35c10c4..e7d5356e521 100644
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
>   obj-$(CONFIG_USB_ISP1760) += usb_urb.o
>   obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
>   obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
> +obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
>   obj-$(CONFIG_USB_R8A66597_HCD) += usb_urb.o
>   obj-$(CONFIG_USB_EHCI_FSL) += fsl-dt-fixup.o fsl-errata.o
>   obj-$(CONFIG_USB_XHCI_FSL) += fsl-dt-fixup.o fsl-errata.o
> diff --git a/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
> similarity index 100%
> rename from common/usb_onboard_hub.c
> rename to drivers/usb/common/usb_onboard_hub.c

I'm very confused by the various Makefiles at play to reach 
drivers/usb/common. It seems like the root Makefile unconditionally mark 
drivers/usb/common as buildable? But then drivers/Makefile has a bunch 
of entries specific to SPL only. What's actually going on? I'm trying to 
figure out if this move truly is equivalent to the current state or 
whether there's now another Kconfig symbol in the dependency tree for 
usb_onboard_hub.c to be built.

Cheers,
Quentin
