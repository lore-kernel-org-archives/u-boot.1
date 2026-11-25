Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D2606A332
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BCUOlyxX;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=LTQRscjr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E1F380FB1;
	Wed, 25 Nov 2026 18:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WeTBYb1qJHcX; Wed, 25 Nov 2026 18:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B589D80FB3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630425;
	b=bRAzCeKaiTH6EJ3cH3pZBhe5bLz/3xcDtzcWOFjDoh4eDBrivxCHI1oD6oIGqy1IfF/6
	 XNQdBEa+ulZEV+AQtSlKJ6j8UXAcqAFU58kr6rk7I/uIDKpt5MiISauXsT3JQ1DNTLj4Z
	 JhovQy70GDGjwQX1rjWUhAm5GkvCZ9erH2A6d7/udZPv+gz5E6yC8ISBUWcwktObLE4Wp
	 zxTHvO6xM64GlTu4IB5iSq4B6AHNVuLb5Dwo/ewFx0finSLaFm7gaMKPbvyJwOwXTkFHV
	 BR1B7ethSSuiX30Bq699U2/X7y4lMu9nOSlrkGYR2GtRNSxtuybvSLHklRUwnctdHFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630425;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nY/wSWPdqMCQeaKM0i1vZtQUfHazugATj3YoxVqo5O4=;
	b=Xjr9a5QUEOTdoVGMBLQJko/TyxTiJzGhisxrHN3U8YFYQn0EEJ2iJjAnZNaBzsH3/IlX
	 3hmhuVIwg+h0J3DZGHER4zfLNkIKbljUd6YXEIs8VjJd/SIDzmN+/LqGiAxMOzJl3k6MK
	 ryy/Q3g/M5gZSqAM4QV9wYq+xDfbhCVf3BFGhfpFkgKkkdpDokdKVU14Jn31+Nne8RFZO
	 oMp2x21izzJQfnbx9ypzOpCaXe+KPhieFPhQCu9m9ghQHIRS0TjoHJfQr1UqVxb/Qh0eA
	 ce2EP1OBOmCLoIIiLmI+SNjOjvXugT/XGpk4JRoCuyYkVHYIdOOWa5k7n96DvfSMLfQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630425;
	bh=nY/wSWPdqMCQeaKM0i1vZtQUfHazugATj3YoxVqo5O4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BCUOlyxXkmzfvZ0ZzU99MAc7k+igh5bs9R8cTfhcNgqdd8f8rLsqGjpQq7WV0/mTW
	 ZxBvaILyPbIacf9ow0ikMdjsRDZH8SH9SpYw9KnxhasY51hkeGPLy0TpZU79CCZu1a
	 EKEw7IEYzAEhZpV7C8SuQefxwa+OH8DFjsfOVRsSNE5ZId91i2P27WHY/ZF1AkPybl
	 Ls/9iNjwq8FPraxyOWuhxl2ApxRXW976/ogK7zxccgvU2v14Nrfd58HzjmFpqpO34x
	 x0sF/wBv/QfFYIBPeItN32mP6WJ8U102JTOvkNE0Ss8QB6s3sGWaC6aT8nJA5pc5FW
	 iTISJOxdzAnUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B589D80FB3;
	Wed, 25 Nov 2026 18:13:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33A6A325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 260CC40242
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FM0FIWCbkoZQ for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 53F74400CB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=LTQRscjr
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53F74400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY/wSWPdqMCQeaKM0i1vZtQUfHazugATj3YoxVqo5O4=;
 b=LTQRscjrPzFRwvXpGgZnJpbIHFBPj1koKRh7rgfS3j+N2CxeF0qSVaIhXrGdU6473oKMrLsKD5CPUIpSS55tJ6sl/kivMlf6D3wwrwQarkqJiGfkU4hN3bbpHDCh5PkO5RSjOylIP31QXpbw3cgF7gUogIjZ+wpBnH7WXORALdo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMBPR04MB451729.eurprd04.prod.outlook.com (2603:10a6:20b:798::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:47:45 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:47:44 +0000
Message-ID: <4594214b-9dac-4ff7-8819-45b1b02b46c0@cherry.de>
Date: Wed, 25 Nov 2026 18:47:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/23] lib: Let SPL minify zstd on its own
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>,
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-4-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-4-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMBPR04MB451729:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b262072-27f5-4a49-517e-08df4b1c35ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006|261026121527099003|41080700001;
X-Microsoft-Antispam-Message-Info: 8X13VuXJahcmI2fa27PkcLnByzvmnKpags6MnzwtaorZbYAGxwIWgquy2gZVLX/67xH2w7+xNfbvxGCGRzcEIAK8UimxJcBcikAn55fRD7V6REiV5G5l4rPPrzlxVfRkPxrkX+iumwkko9S5AjblshpIHya8ZQ5zzfe841EaAMWw7BA8twCqtAYOjUk4A1lFuYOAIuMmA6i6ByyXtUTKXvh9FANTBEcnKj1ER8+EReFpFqWcZI/+LUhHhLQMqFAFKIvJV+l8kjQh7NebC31fU7BOdDR+AOpkHguy1rbnoR6dbg0/yBAK7IwaEcTo4AwTx6td9S0Zxa6B7+D2HRkCRRQhD0oCIExGzyav1IQHHYnP5xFzJsv3n3t6qdwuuHf7izNQaps9q6busLxdFKc8Tjzaqaarj8yVIL8dgmPs8Kn3kDxpm8ymLJwWJRKoq3zPzlqKye4qgwh56hAe09RXVfnip4/IRUunBIJ+Ynjz0uXGH/pNF83sfKa2wIkuBvQObk+bCM3kaqyUiPZXrG/1Lr029R02ok+TWY1ZYzu1cURta8qxhNV/hst/Zm4pbMsF9jRNuRIFM8AcTp2/5RpOYoqO2cNUfg/BBREm6F8sP7OBO6kuWOVpG3YyiosYM9Xyebx6kNJoQR35A9IlDCh3SpDED3VRqu+GPIXqR6XYIkZRXp8nVxuQA6FO+GsEHeVfMbvlGg3gWOT477Bqbcd0ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2YyTWgxQ0NrOXdmSmN4NTQwWnBEMGFTZGY4cGxPUTNOVHRzSWtLZ2d5QVJw?=
 =?utf-8?B?RmJla2c4UVRyQ2xKSU4reDJMci9RZThIYXNMclBBYzYxdGdyblQrS3luSVlS?=
 =?utf-8?B?aEx4T2VZbDZKeTYybG5uRDJsN1VGS3MvVFBHU2ZzeEZuTEpnREVodjN1MSta?=
 =?utf-8?B?WUJCWHJjTVZneng3bEJscjk2L3RxQkMraFhnbjh5bkVMY3NFVzdDcytlbzEz?=
 =?utf-8?B?RkpPbEJ1Q1RrbGoyeFVTa1VjbzI1RlZITHRTV3FNeTRmdG02UWxzUkpTVWgy?=
 =?utf-8?B?SGlJNnBuM3NiUkhDUVhFemY1d0MwRGJCdkF5REFwQWFKd2xnNHc2ekRJalQ5?=
 =?utf-8?B?NEdIaE5Ua1dDQ3FzRnJZZTIvZ1JkOFN4QmZ5OVRsa3JiVUF4bk1zRHptNXAz?=
 =?utf-8?B?U1JIMHNEVVZRUVVQc1c0WFNaV01VK3lTYWRZd3cvSVh3OUpPMDkrWitmN0xn?=
 =?utf-8?B?Tk1iaVhzandSQjR3K0pub2RPTlE0Rmg3NFU1NjhjQVlDbVMzVWdnTDZ0TXRr?=
 =?utf-8?B?UXpqUVNxd1RJVWhvbDllb25EMFQwa01YT1RqeFRnWFdIVGQxNUxnWURpQWxT?=
 =?utf-8?B?TWpXQzJranp5K3dkeVlBY1poaVpNMDBhK0lieGhEQ3dzQ0hCYkhyK0xwZVZx?=
 =?utf-8?B?bFMybHp6ZFJ0T3h2YTcwMDlVaDhkZ0xLZG43K2xrS09sRkNjMHVHWjUycVF6?=
 =?utf-8?B?MGgwQUtuck4zeUdOTHlCeW45ZkFkMlEreGpWMS9sd0FpMk5lTTdxTFdhc0xC?=
 =?utf-8?B?SzRqbG92bEtYSVRPNzBoaUUrWXdlVE1WT3g1OGxuUFBBUytJYWhKWk5UVFJ6?=
 =?utf-8?B?RmZ6SmJuelBCMjJCeVR6WUo0WmViS2FuVVN4elcxVmVsKzJrM25lMzIwaXY4?=
 =?utf-8?B?Skt4YXptQ0NGN2VIQWFnWHYzRHl4ckFpRE00TysvQlhYYjRrZ3VrbWJSWm85?=
 =?utf-8?B?TGlKRmVPVjZLWEIwT2E4RTh1TnRyUkdVSk9hekV6a3JQNHowU0RkS3hWa1gy?=
 =?utf-8?B?c1JRSlh6TU9UZHYwc3VFbE1qMUl3UlRkbTMveXRxR0NYZVRsQjRpSzAzclJv?=
 =?utf-8?B?bXJwczNhKzRkNE8xSkh0dG1UcUUxTVhSKzJVcExjWE9iYnh4REo0QXMvN3Zy?=
 =?utf-8?B?aXFCMmxTeXI3NTkyeXFWSXhVUmNPSlI1SzJGQS9oN1hnODMyUDdUVzVuR2s0?=
 =?utf-8?B?dUZNblczZkpSOVpJblM0cGcrNkJuWWEyRFc0czRiVDN2K0QxWHIrZFRYUjFM?=
 =?utf-8?B?amFoQUpkSFRKd2lnMjNQNTM0b25yeThjTEdmNSszVGp3OHFaYlgrQWNBdjJv?=
 =?utf-8?B?UXlRV2dkcUlVVVpNbVBhbUlWT0dJbWRET2cxclNldm1RTFh1R2s4SC9Vekx3?=
 =?utf-8?B?aDlGa1J6L3JxSVE5T1BUTUJwZTZWcHFyaStsc1FKUVpKdjlVbm0xb0ZxUENL?=
 =?utf-8?B?SldldXZYUm13UXJIZ0NLL2ZNUkU1d0tLN1l0R05iWVNhbEgvaG5KYndwUDVK?=
 =?utf-8?B?eWFMcmRFZG1UT0lTU3NOdVRtdkc2NXJXd0REV1A5czR6QjQ2S3pDUWFKU0F3?=
 =?utf-8?B?clVpQmhHUytCczNuMnBzMFNBY0tXbTY4anRER005ZStqYzVQM1F5c3p0SDQz?=
 =?utf-8?B?R3pTWGxkTUZUNE9yQS9zbnJ0RlEwZ3RDWjRma2xRN3hLd1pULzhFOTJMeTNt?=
 =?utf-8?B?MEJsZTFMOEM3Skg5UDJrMEJ5R3JxM1FvNlU2a01ibnlxTmpFbjlWTmFJWnpH?=
 =?utf-8?B?bEpnTVFudSswclczUW1jVG9ybTVKMHdJejNqVmRoUmhGU2w0T216OHZWTTlr?=
 =?utf-8?B?aGh5ODFPdDFabytMT0Y3R3AvOFdRMWhrdlljWjM5ZUtHYWIxYldlZFRqaXlV?=
 =?utf-8?B?NUxXYlM3K2ZFTEFuOTg3L1h5SjN1Sm5wbGJGYVdyekpRMnpGRmpvMTlDaHJJ?=
 =?utf-8?B?NWFjVkxUeUxEMzZLRVFKQ0hjYTdnRWllNDRTU3QzMkZKSXljRFpaemppMkxr?=
 =?utf-8?B?c0trRS94YVpHdzhncG9odnBSTmtYYWlxdW5zbWdYNWpPS3RodmdnSEVSWVNB?=
 =?utf-8?B?ZUpRM0lJQlBtRTBXQWtoRVFnSS90MnZtQXA3NFlySDVLZ2tVSEh2bnY5YnAw?=
 =?utf-8?B?cGhubThXeGhyb0F2Tlo5d1UyVU9KYjRyaks4RWs4ZTA5MGxUYXZUc3lRcFJZ?=
 =?utf-8?B?dWFxelM1TTJESmJkVVhhZGdxQzA5OFVOVHViZkEzaTFzNnR4aU50V3NMNGpi?=
 =?utf-8?B?VjVNK2pGYldLb0RQVWRTaFVDTzl6cUJQYlp6dlFyWFliTFM4eHhaWXlLNnNm?=
 =?utf-8?B?c281TGxaVGs3MjUvMGxzTG1iejh1L3hsOHA4UmFPR0MzeHBHQ1pDdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b262072-27f5-4a49-517e-08df4b1c35ed
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:47:44.7632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkBN81be/loeMlnqEA8pa9kGz8BbKwW8FzebwRAep1K9pCPVwBD5e8SWiHJm/S+0gFRGWBqcO9d3OxTiikW/p8c/rWDp0bV88eVTa2mA7Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB451729
X-Mailman-Approved-At: Wed, 25 Nov 2026 18:13:36 +0000
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

Hi Alexey,

On 10/20/26 6:40 PM, Alexey Charkov wrote:
> ZSTD_LIB_MINIFY is offered only inside "if ZSTD", so a board which
> enables zstd for SPL alone gets the full-size library in the phase which
> can least afford it.
> 
> Add an SPL-scoped variant of this option and key the build flags off that.
> Default it to y on its own rather than follow ZSTD_LIB_MINIFY, as size
> matters more in SPL than in U-Boot proper: a board which turns minifying
> off for U-Boot proper now has to do so for SPL separately.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
