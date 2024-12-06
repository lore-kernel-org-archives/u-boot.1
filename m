Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB502E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BBBE8932B;
	Fri,  6 Dec 2024 15:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="LcHHyPTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 789E889581; Fri,  6 Dec 2024 15:00:37 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DE789274
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  6 Dec 2024 15:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgb8gFeRP+IpFmEmOyUz08s5n40cgKi6o8+RpYaBXy7Q317aGTbhDwWo1mSWE3vQTeSaLHGKL1PUclEp9lFYUpAYpgffRi8ycVxiwHGOzSO0hy2sPzvkCi3Drg7rhljjAkfIquES5PnHLM3+4X9rKUPm44c6X61KkHYHXSay4xo+0UDgfYGDbtBBaX7qJTZmtEG36R88dZMqfp9kvB/5XrEGANxdOb6H2olJyWOB9qV7wsFN+xSoCADOyQ0BBj7iYu2H8BYLoFNXi67nvKTDLFcBbOSULd4OOVw+nKLXvg7EkXDzOxDqhxcdagvcL5vmqnzx3sDVBzFMu5u2iL4wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqF5SFX1XX0wPQySJQVSITgJcZjU3aOegYQgi2GajYc=;
 b=t8/F6+VtY1NiLdmWUmQk9PPprUtRBljx65hIwKqgd/E+hd0uja9wBKdzXMxQA+bVIgjaZwHxTL08jwQiQBk1V6uHMKIo9KqRVB5PRFUjfcv97uTr+WvWjODH6nfmLkwGi5mROCwXdih+IyZnEhgJy3obUAD/soLDbpG8tWcfkAVxqnyc75zrVicYsRuYNXhy9/mE88/JoZkKFT5J5Fi+Sl6Dgzt8DIKCfPsc+5ij3YRZKh6tcnNI835/yjcbwcj9MXCNYkMJVGPHmY5AnDcFdIs6AZAGt0Wa7adz2L40H0sKCgPXcDcsJIXCbUXb84Kfx1gyniGax4V8W0RcDFsVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqF5SFX1XX0wPQySJQVSITgJcZjU3aOegYQgi2GajYc=;
 b=LcHHyPTMAOXpY13m/cbwuK6UjLJfdi1JlaD6JuJ8iNMy6bfuir3sJvYxgs4CPSnQnEarbA3Vm4UoCFvyJ2mxWOHQYyMeoifZDV4ndWTZe30qDMJPSHYrxe4iDFQ4OTFjrvXt98S9HiV1Wmd8vDGWi/MP+cHAOb+abSntdzkGK6qAj5X1j/ZdKciG4lmSFWnZd+/yzjGW7PKuUcej98PMkItxpMS2U5fGwYUxE/aoSoqDNaDJm8GcrOOYu5DEYDdp2NjP/h5d6HukJ6l3hjf81+PiGUbPu/7FrK3QZzf/vMGl5+Mp5DtUlI8IBcwW0CfQUhLlhCAYZSPaEQViWf+uEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PASP264MB5902.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:49f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 14:00:33 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 14:00:33 +0000
Message-ID: <86e4f4c0-8214-447f-9b9f-5749b79b3f56@softathome.com>
Date: Fri, 6 Dec 2024 15:00:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] lib: mbedtls: sha256: add support of key derivation
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-5-philippe.reynes@softathome.com>
 <CAEfUkUL=wrwVbVO9ke-XAfK+4qMro-wNCyxaUg-GzaN-5T4R8Q@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkUL=wrwVbVO9ke-XAfK+4qMro-wNCyxaUg-GzaN-5T4R8Q@mail.gmail.com>
X-ClientProxiedBy: PAZP264CA0105.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::14) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PASP264MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d8e94c-a834-40dd-0f50-08dd15fe59d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWM4LzU4SDlTejZEbVhnc0pqYkJVYi9YcDcveE1jbmZwWWpDWnc4WG5INFk5?=
 =?utf-8?B?Mk54UUtkMU4wN0swVVYzRFdLeWg1V2ZVbHU2WUo5akNQenAvV09lVG1sTExB?=
 =?utf-8?B?MExGR1dNeVZ3RWU4c1lkYzFIL1FHa2lIODlMSFBCUG9kOFZWVjlVTTl1SVNs?=
 =?utf-8?B?RlhQNWd1TDZOTTd5bFNUbG5JcHBJN2RpQ2NnZzhvUUY1UkFCK2M0R3dJK2Jy?=
 =?utf-8?B?RE56dGRiZklxMWcwOExUaDBzL25UTFFMUmsreXI4cHBBc1VuWDFrT3ZGa1Fh?=
 =?utf-8?B?cVVsLzJLNnhkYjB4TUFOaWpGakZhZmF3bzZHVERpNS9lZzNKQnlDSEk4aEVk?=
 =?utf-8?B?akozRnpuaC9yR1ZuUEtjdnZUSjJlNklJQ3V5VkdkN1lvZWVpbDUydHAxZ0FL?=
 =?utf-8?B?S2Vqby9QeHlYZEJIbXJwZHJYM2dyQThaT2RkUXFvZ01QVGVRV0FhK2hMSmFB?=
 =?utf-8?B?YnNFY2tGVjF2cmQ1bjVCZTdWVWYwMzN1eXNjd0d4ckxGTm0rUUo0N0VrTEpr?=
 =?utf-8?B?ZUYxMm5QUnlZSjFBMHNWY0RRYzZ0UUhqZFd3Q1dMOU1CTG5EcnZiQnMrZWxJ?=
 =?utf-8?B?YUJVbTlYMythakpJdTE1cFZvaHVTbWRHQUloUVpRcmcwVXI2TlBCMFJ4Nnhm?=
 =?utf-8?B?c2lnMElRNWhSRVpORG1mSVo5bTNNQm85WUJnMlhuRk5QelhyTTIzdGpYNjVu?=
 =?utf-8?B?M3JzN256a0tkeVZPRlc2UzJMTnhaWEdhajcxRVFFaS9mZVBZM1F0MXpyRVdL?=
 =?utf-8?B?SXd1emxDVVZBVmZNR1BpcGNLRzdtczk0SFI0MVJjSUVRWTgraUVvd0FEbXl5?=
 =?utf-8?B?Rko1OUlFbUtURE5rKy9kaFFUTk44V25QZE5hc1ZDN2xnWGxZUU14TU1XL1Qy?=
 =?utf-8?B?Y1RDL0tZa3RSU1Z1Rlg2T1pLOE5wazhPNUdSZkJZWjljWFJjRW1xMndJby8z?=
 =?utf-8?B?RE01ZUFWTVl5UFB5QnlDV1dUTEhxSko1V2N2cVFJcTZ4WThCVG42NDZPOUF6?=
 =?utf-8?B?dTBzVG0xVjlvanBMK1dsRmNZcWVSMThjbjhsdEp0L1ZjblZGT1ZQbmxpankw?=
 =?utf-8?B?ZXhTOFNOTnNZaExFUllab0kyNG1wNC9PU1ZSRUlCaGJjeHlFWTcwN2pjOXJT?=
 =?utf-8?B?c0VCem4xL2JlQ3VldnBDd0lKUVoyT2loTFdyTXd0QU53d2tRQWJDVTBOYlM3?=
 =?utf-8?B?RUl3UTM4R2lKelo0eWEva1MxZWhHMXFHczZ4dUZLUGdORXVMaHIzYThITi9z?=
 =?utf-8?B?MFl3ZWpUSldiYXFta09jUXRwL25oMlNtNVpPc3JFMUNQaGgrcUU2NC85YUMr?=
 =?utf-8?B?UklSTCs3ZVVlRE5XNnNtcUZ1M2JSTnV0c3JUTWloYUJONW1PRGJUMGlQaHFQ?=
 =?utf-8?B?R2dsOUxqUjJSN1EwUEJ1N1hmT0FiSmY0RXZMV1c0aHlvM0ErMG1lTXBmY3ln?=
 =?utf-8?B?Yk84RWJPOTdlRmh5Z0t6cWpPMlF0ZUxIajMzYmhzU1VUVXlaZTJ1VjlFVjBD?=
 =?utf-8?B?d3cyOG5aeWs1bU9yZVo3YlNkMnBJOUE5R3FGcmZwNFU3RnFCZ3l3bWJ1ckZh?=
 =?utf-8?B?UGJpVU5PYmtVTzZ4alVNOTlZd0g5cWRNR0NoelRueFFBZzVNSEhNMW9tM3U1?=
 =?utf-8?B?VklScmIxSWV3anRDL0xFamwwczc4NU9BZHZPQ0xoM2N2VUhVcDZqNW0yK0Ja?=
 =?utf-8?B?S0NJcklpRXErbVVNYTRwSlVnejNTWWhFZXVUeURNUGNUam5CZ044Q2k2cjBU?=
 =?utf-8?B?b0hlTis5STR6NnlEcnZtckUzZDQvdkE0WFVkSHk0VnlocFFVYUlrc2JQK1Bn?=
 =?utf-8?B?c0o4UG1QUlpJM1RzVXhuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHRvZytwbDBEUXpZb1lTM0lCczBacTNLVFJoRnlXcE82UkFDbXkxQ2h2aGdr?=
 =?utf-8?B?cHNySkFWS2s3VzJXZU5uVjhXaGx6K1pWSUZZR0dTOG15MnV1bGdyY2pPSVdr?=
 =?utf-8?B?UnhVaXpIYjh0NnNQYzNDTU5FcWNoYkJHSEpJT052bDBUbEIzdUdGS0thRDJo?=
 =?utf-8?B?OUUxOGdRaXR6Y3JnNzRWVEVjWDdKS2RJWmYzMllBN0dCdFYwbXFHUk0ycUt3?=
 =?utf-8?B?R0F5Y005aWR6L3FuaW5JdHAwcUF6VWJjZFkrNnZQd1dNUlFoeWhCS2d3L2Ir?=
 =?utf-8?B?TGtrdEE4YWxjTGQ5SWtvbWJGMjNrTE4rZzlpaG1ZbkxxZjBkazY3SVpyZFdR?=
 =?utf-8?B?a24zazVzWm9mZW9EMGg1dlRETGlBbWdVaG1oaWxsS0dib1NpeUVoWnFYZ2o3?=
 =?utf-8?B?b3EyelpkRS9GYWNhcW1qODczT3dKYk00NGRvMVovbWZOTnRTc0ZpcVJHVmZQ?=
 =?utf-8?B?S3RlWStJK1pSOFJZNHBSeUx1b1J4biszYmp2S2xSM1pYd1Y0Wk41azFFMEdZ?=
 =?utf-8?B?MmhhMEZNWThkUlgzOGEveE55L0w1K3E5OGdNQ09oNlJZSzdKOW14YXFONmtS?=
 =?utf-8?B?SExXemNZMHZTczRTblV2ejRDQ3gwQVFFRks2YmUxbS9velN1SWFHVXE3RGVX?=
 =?utf-8?B?b1lnZ1pBbnJRUDc3TkUyOXhjSXpIT0o4SlpwZWxPenkwQjNqUTkvY0dwMnJX?=
 =?utf-8?B?K0JJVWQxdVJ1azZZelFRY1daWHd5ZEhUd29vTDAwSDQ0WmpIVUVQT3dlczlt?=
 =?utf-8?B?Nk5TOEJOZTE2Vi9vMkcyeENPSzdOYzg4MTJyL1lDaTVnbHhYQ1JPRnMzT2ox?=
 =?utf-8?B?RnJmbGJTZVU0SWY3WkJjSG1UdnVCcyt2VVo3TnQyZDdvdXFKb0NjME0zQ09C?=
 =?utf-8?B?SVBXZ3VnVTNMU3pPalduOXJDNEtldkZYSTNIY0UxWTFaQVNQRXlUczIzTnp5?=
 =?utf-8?B?clRoNzJjSFdYTGJZR1BLQzZlUUxlOHU5b0NBU1k3NGRXZXhKdHFFdU5aQloz?=
 =?utf-8?B?ZXh3ZjN5S0RGRzJRakFRNDB2cm9tSUZlM0pheG5UNjNhb0oreVBTajRCQ3dn?=
 =?utf-8?B?YlFSbnRrSnd6ajhyRjlqZTJTR3FSNTUyNlEwdkJxMFpYZ01XVEEzM3lsREhG?=
 =?utf-8?B?bUlkNFR2Z2kyeHJWaEQ0blNpZE1ZMHYzK09KMFpuYUVkS0dlU1NGdUdxYk9o?=
 =?utf-8?B?M08zZk5kMklERUxrR0FiS0pZMnhPeCtQRTFUWTJseWZJUEExTXFsUEIzaHZ5?=
 =?utf-8?B?RTFGMzBzTEd0bzdUUWhhOXNqRVI5MHFYN0F4VGg4cHk0Vlh3UFZSSFFjVWda?=
 =?utf-8?B?eUVWeFgya0hsOUZEQXpYT2ZKdCswWWNZem1UYnM4QjVNTEV1ckpJd3BnS2Uy?=
 =?utf-8?B?R1RtUUN0QjJYOVJ5OFI3a1h0dHhJQk9iZ0JmSER1MldCTTYxbitBNHRBVGhR?=
 =?utf-8?B?MVhCaTUybGExcnFTeGdMYitpaXRaKzRyMWJvck0xejZKS0hVaXE4TlJtM1h2?=
 =?utf-8?B?RjBlbXhiTUdIeEVnS2RKelp5Z0pqaFA5VGoyOUJoeVlrcmZzTUNvcUtjQm5t?=
 =?utf-8?B?a05hSS9DQmZaV2JhcEVqV2V3eUlKZHpXSDZyK0dkeG9LN3d1VUN3Q1VheHE5?=
 =?utf-8?B?T0ZiMytCdWxvTU5EZExZZC9FM1ErZDY2QjN2V0V5aU5uV1phWVZqV3JQMHBh?=
 =?utf-8?B?VTdXNnUvdm1BQ2M0RUFFb05rMmYrYnMrY3VZYzlndDhkWUVQOE1nQ0VIVFI1?=
 =?utf-8?B?WUZlVTdIVkZrcnRNV3VWUk5Bc2hYRlIyTUwyaWtYN2hNSGZzWUczNlh5bTFq?=
 =?utf-8?B?WGhsSWNtbWZ0U1dYK0crQVp1YVpVSjBqTWw4L2FnMjBlVW9XR253SHF3S1JI?=
 =?utf-8?B?VUlqWUw4dzJndWZGY2hNUDIvNlRHSnlpTDVJbVFYNENNRTB4Z1ozTW54blAv?=
 =?utf-8?B?OEtpc2oxc3k5ME4xc0dndEZSYS9MQXdoRWxSS0xGaUNVdTVtc3VrMHdENUtC?=
 =?utf-8?B?TzlmaThkUnQ2NkhZYUpsMGxZdGUwRFpvcExrWFBHTHg1aGRUNVVwR1FzcWJE?=
 =?utf-8?B?ZGJqTmh6OUc4NFRMZFFrelQxbjZ1bWZtZ0R6aktCZnN4VDFIU09UWkNWUXg4?=
 =?utf-8?B?eWs5TWZZbi9ta0sxQTd4aGFCbVZqVjBDOFBONHVHczRqQnFaTGdJdUFUWGZ6?=
 =?utf-8?B?M0xmZTQrOTJSSGN0a24zMk9zQ1JpS2dNRXNFN3RDY1FxUzR6YVY2MjVqYkJv?=
 =?utf-8?B?WEtFRk83ZG9VaUo3b2JRdktHTWNnPT0=?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d8e94c-a834-40dd-0f50-08dd15fe59d9
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 14:00:33.2532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIsQey4el6h5S50xiEvfGzXbt/C3fWwGaI3iti6EThCziWBfI9RUd+9Ni3aRHlzmfItxlayEhygD68rb9e2odpqC+AXj1A4G3URZKWm4ekQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5902
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

Le 05/12/2024 à 18:18, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Wed, 4 Dec 2024 at 12:54, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds the support of key derivation using the scheme hkdf.
>     This scheme is defined in rfc5869.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      include/u-boot/sha256.h |  5 +++++
>      lib/mbedtls/sha256.c    | 18 ++++++++++++++++++
>      2 files changed, 23 insertions(+)
>
>     diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>     index 77dbcd4553a..0a6e309e3ab 100644
>     --- a/include/u-boot/sha256.h
>     +++ b/include/u-boot/sha256.h
>     @@ -48,4 +48,9 @@ void sha256_hmac(const unsigned char *key, int
>     keylen,
>                      const unsigned char *input, unsigned int ilen,
>                      unsigned char *output);
>
>     +int sha256_hkdf(const unsigned char *salt, int saltlen,
>     +               const unsigned char *ikm, int ikmlen,
>     +               const unsigned char *info, int infolen,
>     +               unsigned char *output, int outputlen);
>     +
>
> An inline function is needed when the build options are not fulfilled.
Ah yes, I forgot to manage the case where sha256_hkdf is not provided.
I will be fixed in v3.


>      #endif /* _SHA256_H */
>     diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
>     index 1b9fc1a8503..c38e3e5818c 100644
>     --- a/lib/mbedtls/sha256.c
>     +++ b/lib/mbedtls/sha256.c
>     @@ -11,6 +11,9 @@
>      #include <string.h>
>      #include <u-boot/sha256.h>
>
>     +#include <mbedtls/md.h>
>     +#include <mbedtls/hkdf.h>
>     +
>      const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>             0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
>             0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
>     @@ -98,3 +101,18 @@ void sha256_hmac(const unsigned char *key, int
>     keylen,
>             memset(tmpbuf, 0, sizeof(tmpbuf));
>             memset(&ctx, 0, sizeof(sha256_context));
>      }
>     +
>     +int sha256_hkdf(const unsigned char *salt, int saltlen,
>     +               const unsigned char *ikm, int ikmlen,
>     +               const unsigned char *info, int infolen,
>     +               unsigned char *output, int outputlen)
>     +{
>     +       const mbedtls_md_info_t *md;
>     +
>     +       md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
>     +
>     +       return mbedtls_hkdf(md, salt, saltlen,
>     +                           ikm, ikmlen,
>     +                           info, infolen,
>     +                           output, outputlen);
>     +}
>
> Missing `#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)`.


Again, you're right, I forgot this #if ...
I add it in the new version v3


>
> Regards,
> Raymond


Regards,
Philippe
