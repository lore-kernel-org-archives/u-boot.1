Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3F606C43E
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PpfbZGp+;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=HRsA9Dy4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7119C409D9;
	Tue, 10 Nov 2026 15:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sjes4iFushZY; Tue, 10 Nov 2026 15:45:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8EBD440946
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794325535;
	b=BoxCXWrRa/zjI6+XyRfKm3eE2PQs+qfO/RxRpNXFwQHdtx55xuebahr7ok2RvnFg7OOY
	 IGshR+Aa+i7Bz4TKAs00nKNcBwBGPXgzZ1e8g5QON+ZrUpnFzuDyWcn+Mi4mhKWJpnT/w
	 FtR7XZcX+MFmWCXpGooZgFaA+f55RlbRBqJc8hpsND92a1APExmDpzqZfaB0drMxemepP
	 Ir/cBsxAeQ/Ngdp47Xiz7vfXIzdglagk+jX5f98eIJd16BYMGbNnhFQzmRs9Q8jG3ErO1
	 r8RzgVNa2hB65C4m1WkUTD0Lo6RBnw/cPbfjjwAnLv3d9vHsptuTkrF96rtUNSbXMDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794325535;
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
	bh=ZxtDLWC9BRdjfAJMGT6ItP7nNUzc40hoOna9pqP7lYA=;
	b=gyALfU4hoNvrGszTyOnlPWxVS7SAtViGD9hMpDxONKf5+qzSk/iQBkzE1M2edjPEdr/Q
	 Psjyf4CjaIZQHb/TUPn2afyFrEQ9C3GXRK8f7Pg6yg4+IVYAROPGLK/Zjk2usO9FRgbuH
	 EcZRUDYMqq6enL8OOEHEcc1A4/ikJGVumTRIqKPv00VQhm//cG3NykVkEF7D79oK4/fS2
	 1YGXh/ZwX09XD2bBbqWrub87T6jAuoYccto1PpSUZCUGa1gVvU9Kfjz54S7BkZmukIFTU
	 NHn0gUe1TMTW6QH9CDMusU6X/3cuUidLCpCpBZMCVtsUUarXiGNg2YQWW8j0xfEBwZw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794325535;
	bh=ZxtDLWC9BRdjfAJMGT6ItP7nNUzc40hoOna9pqP7lYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpfbZGp+jy0CjlalHXDmlYYc0GC+hD0kNiZJXidZKlCLh01s+mp7RF540z4c98vPL
	 fNZ4QHn9Aq2SUUFVFYLXfoNUPZjz38ATxPAEz0h9DM/S0dkKLnDtp+6QgPky0/UbwL
	 wXZohBx9+oLuGJqNyXiaCT/MEFFCum+zu0JBvcQJQyRh6ksfnTtYB9tTuJe7B4y8C+
	 3DtDlbG3Gyrt26vdwAo1pkLgExhYJtwPRyaEp8TnwofennlwmQr9m7WKrIc7bsFYH8
	 bg7ACi1suGzcR3nLuUKamd6jQ3s+rUUAFfWX8nMcVXYfGmUYYwX9x6oaBBW00oYtfx
	 xtonlM5P1BYeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EBD440946;
	Tue, 10 Nov 2026 15:45:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BF2F388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CB75400B4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUnjkuEnbclO for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:45:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 357134008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=HRsA9Dy4
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 357134008E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxtDLWC9BRdjfAJMGT6ItP7nNUzc40hoOna9pqP7lYA=;
 b=HRsA9Dy4mxf+E2LRE35rbiA3A/jZ6N5+fXMDdCvmAQAulsxiMixwd7AHCwHGc1RqskLLJdqC2NyFKPyZYgHdznng0JS2mhrMOSUNZ7y19ksvCB3GpR/OYVPJGyPibeH3BlWk8BAk9LDEdYh29Fhi2vbCAg75RzNHGlBvEdY5B8g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:45:26 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:45:24 +0000
Message-ID: <821c871d-cff0-4000-a0f1-4dd63f4047ac@cherry.de>
Date: Tue, 10 Nov 2026 16:45:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] arm64: dts: rockchip: Split out the common NanoPi
 RK3528 parts
To: HystericalDragons@proton.me, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
 <20261103-nanopi-r28s-v3-2-ae8664fd168f@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261103-nanopi-r28s-v3-2-ae8664fd168f@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:803:1::23) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6045ddfb-008a-4d6c-bf97-08df3f41a2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|4143699003|56012099006|261022075727099003|261021121427099003|10067099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: foRUOoOe1pTIrvRFyDFBMl2cwdY74qVqDcu7yWSIZxoBYdtFEGkSSlxh/EcNqI+deuLDb1iWWW08SfqlYTRa7BKEHxvPZtdxbGWMobLwDELwkE4Kw4GhU1q7weZ8xBMnQXERltx5USeE4L7s1g5CRRoiQRT7TuvMIfs0grwcJzhpXSlTTrgabEz6vH7hYvFRDYef5ZP4RkswkbiJn1cUEdUl6RJz2FyetVEwn5/Bj9cAD3UuB4G2Sj7zzI2mOd7I4dfnb6pVP+lZ4XaW34vZih8xUEcD/SpZSpYMb06apXLo+wxgvi0DXZokZOVOQGVJKE9OMaB2Ojy93C9qxya/3ab+eGzpVHR06Dp/+o8b/uiJ2uxErI0qQILoIFXQSJOZc7Kax186VvxBqvvs6IMJ1Ryp5UNmX8rl7PfgFWIGMNz2NVqnQJNBV6aVSVPOGX0PcBmIilopH9eAe3FokMTDWPw/f/TYPjkauKZtlxmQpk9RnNJm1mhUa2+5CDnfY648ZpZ/9LqtjaL13yu3n6GKnjMXeYmSD2SUxG53+EeHRMVQzanzMBMCw/RRikhfMJzsD/rIkKPHSlhrVeq/GF57f04Kr9MlG21mUQjXkDZjv+h5/5IWcFX8M85FuTLWXv4l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(10067099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEpVQmhIK3VKTE5WeS9ENzIzS25DRzV3RWxHNjBIa2YzeE50aEQ3ZzFLOEJn?=
 =?utf-8?B?TlZvcThWL2toM1R6dHd3UkMyQVYyWHZmRUJFUC9XbHZ3OUt0SXNyOURVbC9q?=
 =?utf-8?B?MTR4ZGtod2xZN1VqZ1dma1FWT3ZVc1gxRlBVVGZkRzhSVUdPMHF3dFZwNm9u?=
 =?utf-8?B?dEg3eFZjVW0zcm5mRUI3N3VtUG5xT01EZVdET08xcXkyaXdOT0Y2VHZqT0NM?=
 =?utf-8?B?QmRibS9zM2hHV01KcVE3bjY1a3l0MjhpUm9aaGNWbk5xU3JqWHhtNDlmamRp?=
 =?utf-8?B?dGNpbjNSMGNMZ2pnSVg1YUhmU1NDL2h6MXpSWlV5TWFoVXc3MmFxUXVGYVRM?=
 =?utf-8?B?MXNXMm9YL3VUbE8rMDV5YWZLam5meTU0b0NtSDBZRGIza2NzNFVZeVJGZ0Jj?=
 =?utf-8?B?RVRVNG1vUWdlc0g4L0cwVk92WVB2M1FuTktCYVNHSWF1Y1lKNGRvOTZHRFE2?=
 =?utf-8?B?Y0FUR1QxUGViZE5uQTVsQ3I3OFQ5VTRTWG00Q0UyZWRRUWVBKzF5enF2Qk1V?=
 =?utf-8?B?eW5vZjlLNUpkRlZacG9xMGpPcU5CWlBGWFZWc2VMeHBPSzB1T0FGd0FZbThW?=
 =?utf-8?B?MlE1OU1UTkdEYUlITms3R2ljTitoTnNVQTV6Q1pWWk5kdjVhUmNwQ1lxQ3JT?=
 =?utf-8?B?cVdCRnBIMWFyNE1oZ2t1VjhTV2VZLzhKZ1ZLMmtCYTBXT0JLWE1VWDB2NGxs?=
 =?utf-8?B?ZDhsdldySEhnVzZBUS9nb3FpWHhjVXZXODVSSlN1WlZNekVycFFWUlNHRTJz?=
 =?utf-8?B?cFpXSXR4cjdOeGN0M3pTQjk3NURiVmROY1A4c3RDNWFqdFhpUGFUUFgycTdQ?=
 =?utf-8?B?WnY2WEtrdWlYVUlIZ0I1OFA3aXdjeVkwcCtBazh0UHlOQ0Z3QkpDdTY4NTRi?=
 =?utf-8?B?U1NRVHRqa3dZS1ZabklFSE9KdERqZVU0bkhmL3F4TXdRU2lkdWFqU0tVUEpl?=
 =?utf-8?B?RHNaODcvVTljSFlHcVl2Uk5YVm4vbFYyWkQ3eVFBcml2WlBBWnlsdGQrOGdB?=
 =?utf-8?B?dlc2cC9IVnBYcXNMak5hL2pHWFRJQXYwUkFEWnQwbEQ1NlliTkN0Rk5kZTI0?=
 =?utf-8?B?dTY3a2pTUlVNbVR0bmVUYXZONENJTVAxVlJ2U3dOWUlOd1Rmd2NTMUw0N01i?=
 =?utf-8?B?b2xpYjRORTF4M2dKMENGZTFsU1RiWHhodGwxeUc5VTBLUWFVLzFzVWZtOCsv?=
 =?utf-8?B?R0UzWVkyL3VBdDVLUi85emRLY1RzZ3BjQkVZQWoyKzdnN3hvN3dBamFDQlhS?=
 =?utf-8?B?bUVoUzZ5V3FkUHc1WjZ2TmlFRnp1KzlmSVFLK0FpM2JqZ2dlMCtVV2VIS3RN?=
 =?utf-8?B?Q2x5K2taU0FVZTE5cnVwZlMwK2hPTE9Db3Y3VGI3UlBOSDUzUVg3VVFubEdV?=
 =?utf-8?B?V0dvSmZudWJaUFFLWC8wN3NCeTdGeWZqMWRKZGtSRWxWS1JZUzVRdW5lV3Z0?=
 =?utf-8?B?ZXdYSURvQXBOWFlUSnlGZ2o0aGhZeG95ZmJROUUzTlJ5SHRCd2ZKUmY4dlY5?=
 =?utf-8?B?VFUyRSs1ZlpYb2ZOaTJERFlDR2drSEdIckw1UlFpd2NXWFQ5NTRhUlFTbTk5?=
 =?utf-8?B?UDB0QWZXZVY5QkRXU0FJUFNaU1Y1RC9UMWZXbU8wbzNNUDN0QmdFR3dWVHNk?=
 =?utf-8?B?ODVqNFNybDRHc1BOY2NScmtDZlBhR3RkWW5hTmYwQzJLTnYrdkRMd0JhSXBl?=
 =?utf-8?B?UG1Od0NxZnUwcklTd2xNd001RkZyR1VoZS9yOVVQekZ3MC9HcXZnK2g3Z1pY?=
 =?utf-8?B?SWtxRXB1QzI4KzNLdEY0WTBUenhBUnIzMjFRQnpJOTZZRjU3emNKNjc1Qis0?=
 =?utf-8?B?QkswcktvM0RNWUcwb2d2RzY0S0dISS8xVldEcmhyRlJsQjQrWU9uRnFEaHNj?=
 =?utf-8?B?SldwbE85ekNYZmZuM3BzcjlUWnM1N3pYdHRya3dIK3FpVjlFYmV0c0Q0d2VI?=
 =?utf-8?B?TFZIMzc2SnA3Y1pxaHMwa1FodG8wbG1zV0dMOTlhY0lLMkdYT2lkczFPRWp3?=
 =?utf-8?B?dDllR1J4Y1BhZXpxYlRxcVN0T3ZkR2trMGdYZWVOdEptR3JXQzYvaTA2YjI5?=
 =?utf-8?B?ZzljQkFrKzhHTTNvOFdRd2Q5UjR2L3kxcU9CV3ZaZTdCUlpLdDlWdTYwV29C?=
 =?utf-8?B?SmZGZWZxaUFwYmhMRUlxS3FZNWc3YnZqZlVXSCttYkFoaWE5YzFYMldYVHh1?=
 =?utf-8?B?VzMwVW1tSnpQWVNwdjJNSXVPQkFJUGtWZWRlVXRWL3RkU0hFZmYxSzRmSWVX?=
 =?utf-8?B?RkFtVUNHTmpCOFNhellCUURxUXhRVmUyS0IvZVdvaVRwcms4aTRiSTVpRkda?=
 =?utf-8?B?SU5pV2h0dWNtU243Zmh2d1h0QnltK2YzcjRIcWtCOHR3NlhleWJFUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6045ddfb-008a-4d6c-bf97-08df3f41a2c0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:45:24.7523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yz6CQ7vVKx+Iwa6MIGj3ZXDqBAdfJOP+e8YGvVG2iX4ghGc4KPzHQ3txzprvCvkhcY7YmgEsLTKLz5Z6Sypivojmhy+JUdlJdqdi6tC5xmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403
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

Hi 安容,

On 11/3/26 11:37 AM, 安容 via B4 Relay wrote:
> From: 安容 <HystericalDragons@proton.me>
> 
> The FriendlyElec NanoPi Zero2 and the NanoPi R28S share their power
> tree, storage, RGMII Ethernet, RTC, LEDs and debug console. Move those
> parts into rk3528-nanopi.dtsi so the NanoPi R28S can reuse them, and
> leave only the board specific nodes in the NanoPi Zero2 devicetree.
> 
> Both boards drive a green LED from GPIO4_PB1, but give it a different
> purpose, so the common file describes the LED itself and each board
> adds the function, trigger and default state. While moving the LED pins
> give them the usual _pin suffix, which frees the led1 label for the LED
> node.
> 
> Suggested-by: Chukun Pan <amadeus@jmu.edu.cn>
> Signed-off-by: 安容 <HystericalDragons@proton.me>
> Link: https://patch.msgid.link/20260919-r28s-upstream-v7-2-e80a6f8ef521@proton.me
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: fdb087806e808ccc4963e2e5225fe16581ecb421 ]
> 
> (cherry picked from commit f7f1ea96945deee8bbadfd0737706ce770315342)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
