Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C83606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CozofnY3;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=CO8HIjXy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3E50812BB;
	Fri, 27 Nov 2026 17:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k4VQbYgKvTzk; Fri, 27 Nov 2026 17:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5567C812DE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795801664;
	b=Ec73VdbLXr01scI/TzS+wNFtAvkIuBDtW57ql6yVmWFLZtEvUCivJJVE8q53XKgLoZT8
	 5g3Otbx2XoyEIL1971Ou2U2M3biYTojwQzDju3tcZa9kth0EmLFWmNkdUZydvsQYaRgtF
	 SMs4v22HX2bNJrftVAG73wpBbDp5P9VOUR/Lb5L94pXHBvIyaethTMMrP55k8d496fVlc
	 eQxtk29THwVFLhk0xJcwqYSBIUQlchQMYLwWPHGGn8jP3gCTe8oe+K39BWF7MYO7vUuo7
	 hpZWtHQ+gUS0yRPJMjTlwLlZ0idwnrQyMN/xGbfABGrn7hscPfXHxKwlcYabNjXoSFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795801664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=+nFs1KoO59oD2jo6Zol69v+B1CKDzarMJbSqLsImQ+s=;
	b=L+h/0kx2obLQ0vuy7kOy3fcxztE9R9LH3OQmyQmszJNJ7uzu/baZS/pT4c3619O+EFx0
	 kxQnVa8zRwjFNwGqsL6caONU/FGCXgrE78rA60kSREC2d0U7ihkFExao58HfZ58aqEyCM
	 AVPv5nDQ8GdUX9TGkM0yCGnpCfQKwXFUBaq4P1gL8wF4ol3rL7nIlk0jGyR5xCaIv7onO
	 GN9103nUE2n5Kp7a/mYBih5dRq4kDmfnh+U5cWMoF0UKsL/R3zb4G6ZEOvPIPmJ7oecNz
	 5t194d+DFQrv4YId7doc0nc1Ys/pesnUobCqrMJJ9aTLCgd2elzaQNLUSu+MUtAOS6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=CO8HIjXy;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795801664;
	bh=+nFs1KoO59oD2jo6Zol69v+B1CKDzarMJbSqLsImQ+s=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CozofnY3iL2HvqgeQT2XsiodYrD6uW2Q7pfZ0GSw2c8UEHMVxYO6HXsPdZprvCGsR
	 tHklXuuCnz2M7Tls0JIPb5UtSaRZA3CtIMGYqRcCom6ZA7ZR7y26B1utZkRKBkZ76e
	 4QCFKW0QqhtLtMQaQ36SgmQt0bQ/RSybkm2tnju6XtRelh0RkvaZQ+lJaA5Otithpd
	 5Rc2eUrxiilplKRSEZ3eyTE0pKUGyBuGbxWAGDxCPJfnAOztzQeEHMu7xzl4VlnCPW
	 BYoauYpklpCwaqCCeo8rgYYJ7aaJOb78CbcaPwgQ6IRrxJB9EmVX/PvLwPSRfdfmMF
	 SurFLagoFkYkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5567C812DE;
	Fri, 27 Nov 2026 17:47:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 765943D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B724812BB
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7JN4pnbAzIW for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 17:47:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B547812B2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CO8HIjXy
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B547812B2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nFs1KoO59oD2jo6Zol69v+B1CKDzarMJbSqLsImQ+s=;
 b=CO8HIjXy05E2j/PzJqTVbmfA5xPTZRW4kkwUw/xo3bSHO5XuvRQKUSGhJapCSmcWB48Ns1PKtZmoKnH1OAgOp1RFB515Uw9p94CYqBqScjyED7BwQBA5QulrtogfP1miREcR0as0NKlf6uAQLEln7KWUCHL0hBEoRKRZ0JY3Cn0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMZPR04MB295117.eurprd04.prod.outlook.com (2603:10a6:20b:7c4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Fri, 27 Nov
 2026 17:47:37 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 17:47:37 +0000
Message-ID: <eea442a2-e3fe-4ac1-9910-d20e7c1b4c1e@cherry.de>
Date: Fri, 27 Nov 2026 18:47:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] Dockerfile: Set SHELL to in turn set pipefail
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261127162927.3545062-1-trini@konsulko.com>
 <20261127162927.3545062-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261127162927.3545062-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF000001F7.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::905) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMZPR04MB295117:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b9cb0f-1551-4e34-16ba-08df4cae866f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|11063799006|4143699003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NrG5syX254fZJv/q+NkgcaaJIERSSx6ZTimu+FImjpfB5HFX9/Pf6G3CfltJB/G03ENmRcwaD5juYBGrLTEyR6hH+ocho+Hb7l16Qw5fsRp2JA9/fLq/ISEpJkh7T61g8xoBGYeU1LkTKT0Nvlh0aLYXVeUmwi4W0dGlUZGYSrVIiGVsH9X2x8s4Wuk2bbmawmnhKcOAtuLRW8D0JtBv3FO8Dcfkz47CJ3UslFF+Ekxn7Y5syIK7ZnBJZtOLVAXH392oZkKr19J3rsF7gOL9ACIG2Uko+trUH2cCuNgJnavzkUxe3Hl4U7SBEv5Ex9tYrj0vugni4f+8+0do8p51uOWiUZDAA2V5omYq/00szvMDZ3ohfl+UWPk7Nz4cGzsSIlQeJOlc6YSXS2hgwhcemTOyc6Azf27pnfQOLs48UhhY6UWZTwMgQLk+yYF9MAbUSa2a5vhmJN5fiTDI3P/Cvduhs7A7wuyPSO/1KPp8kamjT1zv7mJsfEI/PExQU2OYnIVxA19dWotSsoQGvAyPwBpjXaEm9zyX/VESSGGyXgfOMK9fXroFt2CwgF9Ptngy1IZASg6zMRglktDiPP9mzsNQ/f5l9G+Vh/WsZevNBXTEzwpV1wcI2nQdtnMdQl0zfp2dno68ScXVz4zv+6v5Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNaSEIvcklpZXdnYWw1RzNiekNuUk42RTlqeVl6bXZoSmRJVllRVjViaThK?=
 =?utf-8?B?Rk43ZVMraUJlZStEb3lHS0hIYkVKZmhPY21mYmVhR2E0dFRhRU1CK3QxMUcr?=
 =?utf-8?B?TTg0dXNxamF2NUhHZXlYYi91MC9XMkJSQlVHTUdiek03ekJGbkJQcHNOOUVX?=
 =?utf-8?B?Y1NUaHBFVFB2aHhQcFR0TUlZWjE0Y3BMN3g3ZTd2b28vVGIweFZhVkdqOVBU?=
 =?utf-8?B?UkpoZVMvcko4NThaeUNLSVdLTi90VHVrNEI0c21hMUFqVWttQjlRNEpieXhH?=
 =?utf-8?B?b1NYZXdpNStPRDdtRUtSMkxvdlZJSjY3cVBYUnhIOVdPSWRFQTFLOFMvQk85?=
 =?utf-8?B?b0w1UHZucmhmeExYTjVVS2pReGlQeGhhaW1sSThkMG9zdXJpS2tYdFVPdWI2?=
 =?utf-8?B?TXZ3ZE1laHMzMVVBWXBNRkJuSk4xS2xVR0hJRG1ITHlBOFlZR2tha0FFSkRK?=
 =?utf-8?B?QVZPbThUODF4eUx1L1VYQitKRmJDb1BWVG1KU3R0VlZYQXdyc0JiRTFTNVJU?=
 =?utf-8?B?dUt6Zm5iaXpzVTdoY0hrVE9RYTZlNmNPekZidFFQRzJMMmF3SEhEWUdabXQw?=
 =?utf-8?B?cWlNL0VWUXZZSWxwWUtZeGpjaStKbVFXV21ZbXpNeGxQdmNwOWQyN2dER0xD?=
 =?utf-8?B?NXljNlFjbW95WkpLUzkxRk9ZVk9sZ1Y0bjlZUlRQQ29CanlsMWJpdGFCYUxk?=
 =?utf-8?B?U05hMGRyTTZmdDFTU3B4dUI1VlhoRHNUV3M2YUNrd3pacEVoazhFa3N1NFp5?=
 =?utf-8?B?NHJrbkNidno1K2xsZXp4YTdkdU92S2o3dnlmUnBtTlMvUDFUV3EwSU9OME9K?=
 =?utf-8?B?dTFHM2hPV2JINVk4eEZJQy8rTXFHL0VQayszd1plWEoxL3N1WmthK09iMXc5?=
 =?utf-8?B?RnQwWDR0cmlDczdtd0ZqcXVidFQ2ZnRxanBzZFhnaWhsNGs4WHU0R3VHc3VG?=
 =?utf-8?B?RitrcDdRbkE4SU1MaHpkZ2tlbGZHN0syOGtFb08vNU1Nd3krenE4VlNHQ2pX?=
 =?utf-8?B?cWZOQVpWZWxEUjVkc0xld1dncGhUNVRoMVNadEJnZzlFL281eGJoMk1Vd1Vj?=
 =?utf-8?B?c0xhWWRRVmYrL3lRK29Vc3J4aml4QnE3K09nVUpyVU5jNDJlNm81L3BlcHBE?=
 =?utf-8?B?aXlSeGlPbHBISFdjYWttdGNkMm90QURMNFBxTFM3SjFjalZWaHRCSkZTUTJl?=
 =?utf-8?B?bDAwWmpVMlZZU1JGR3VSNzBhUlM5RjZPbFRTZEtrd25aUFRhdzAvNkM4dC9D?=
 =?utf-8?B?Z3pERUZtR1lsZUxOOUFSWGpFSEJIQThzUzAvYm0wY3R3UUU0OXlPZVIxcUs0?=
 =?utf-8?B?aUxnOEZSdE5QM0s1dlRkZ1RpdUtLQzI5UjhmcEwrTStERi8ybU4zWFlraG1E?=
 =?utf-8?B?YnRyQ1ZvMlp1TGVrSDJQanRPcU1yVjRIU2JTV09YWmZwNWhtcVJVZEthUklr?=
 =?utf-8?B?eSt0RHArSUJqNWlBY0d2Tnd0SUJ5K2NJS0ZYSmo0VlI0dnJZa041NmQ2V25D?=
 =?utf-8?B?S0ZiSHo4RFo0RTNBc3lmZTFyb3RKRU9qNGx5RWV6N09McGJzc1h1REY2dG43?=
 =?utf-8?B?Mnl6T29ydCt0T2lFWmR5ekF6c3YvQ0xxVzBBNXVzeUx1QU1jRXh5NzNqQjl0?=
 =?utf-8?B?TE5yUlFrZkprQ2IvZjBGSkhxeWd4UXNpemJ4d3h2Z2U0dDNGZnFQWVZMMkY5?=
 =?utf-8?B?dWhMMDVHWTVBcGxvNlFnY0c3Y0E3TlZZeGFTb3V1YUl5SGNyV1hLZ010K0Za?=
 =?utf-8?B?Sm9ON3dmZjNCMmphYURIZVpSaVdFSVdVcEhmRXo2T2hnYSs4Y3EvN0NSUkxZ?=
 =?utf-8?B?Qk5WWFdrV0JiMkQvbmhxUEovRmlBakRjQ3NlUEpKN1Q0dkV3VXovYWljNGtY?=
 =?utf-8?B?d2hyRXpEdisxcW04RzIvNXRVSW1TK2JuZFdWVnVEMy81ZnkwdzJ4aTdOM3Fu?=
 =?utf-8?B?US9jc3ZTdFFuRlhJd01TWkxjdFA1c3J5UVBPVW5DQlpYa3AxYnZZeDRaclVn?=
 =?utf-8?B?YzkzVFM1MjZpTFZibjRuT24rTWh1UjFaMGJtL3AyM2crNUxETXluVGRVZXRh?=
 =?utf-8?B?R3IzN05ob05lR1VRRjRkVXgrY292ZTVaYUN4UHVpYjV2Z2tOMytqUklWRktj?=
 =?utf-8?B?aTk1dGU3NXVPTDBuU2RLZk1PN0VxR0w3Uno1ZTlqMS9EU2JUWmw2OVd4MDBv?=
 =?utf-8?B?QUtacmNETDgwdHRLY21wK3Ura0Z2SkorL3JhalYrd2lPQWo3dWVpSVRFT2E5?=
 =?utf-8?B?enFraFVDK2ZsUXRUa0VvdWdlRHQyTFp6N09ZV0lDMmIzK3pqN3JlcGhPc1Zn?=
 =?utf-8?B?Vk8rOENXMzF4ZXhiNXBQaDhDWndlWS85YzhTNGpxbHVoL0N0WHYxQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b9cb0f-1551-4e34-16ba-08df4cae866f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:47:37.5336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boOoVyW6ZAD3VW7EIvkeqtbsB+8XIVGwZ9p288zC5WRzcD92QKkD8hy2/WX6Qj/vyxlP//RKvTo2DLTgd1rgXXeRJlHyAwirpfSYz/UuWZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMZPR04MB295117
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 11/27/26 5:26 PM, Tom Rini wrote:
> The default behavior of a Dockerfile means that pipefail is not set and
> so errors of that class lead to successful builds but incomplete
> containers. Change our SHELL to bash and set pipefail so that all of
> that class of error is caught.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

> ---
> Changes in v2:
> - None

The file was added in v2 :)

Cheers,
Quentin
