Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2A606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AMKpZ/yg;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ZdulwTDo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 618AF60E36;
	Fri, 20 Nov 2026 14:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HQ-ghc6DQCxk; Fri, 20 Nov 2026 14:11:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 746B060750
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795183908;
	b=GpV5NqZh+L6r3klQbb98mQRlgYuKKvU29ywzsdZWMaPrFuH4P1EU2qH2MtnInpvohzql
	 0r/6UKPx/ciJcjj26nnpOj3pmIf5+d7PHLIRcm38ZFSGxOWJd0a2ab9RJUHmNEx7NZ3Q6
	 odRRKvGjflxdyEihnwuBG4rTfDF0xvyrOgl8Nu9yBNeMvumakoq0YTUxScpvYostpchPH
	 pPGgG/bS2iwkEFi98usdLSzdFtiwjmd0q60Jhn9gbcQoKZRQxaXZxakt/Gd0zY9R7dS5O
	 bBfHHioV0Pe8AocsOycNfbaTPtj5VdflXMh4MOAOFc0m0xOrHfShgvpnH8x7uVFQxQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795183908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=qlMAGYC5uJbj6p+b4wA5lEWZBwz6Kay2iFoOdqZrMXM=;
	b=RKGbQ55F4PSulE5oqnPmVAgrwUlWPkyIvh/J3cDNCtbhYGsdQmxDIN9wzJ4Fo/c9Obft
	 f7bz2ur9VSN10bJo96oPF+FlOyY/EiOSvTpYZ2XBuAYGaqGvEaNKQnneVwz+WIYMiPhb1
	 kObNnTJmlE1cmzLqcxU42j5nGzKowS0Ccq8yEfmNVkJJBeTXqbGhN9+FwsI1+hdWsWI5x
	 9DoOyEKfHh2lAZdOvNhToRtE+5bUVQ5qJVKdmF9ZJDM7Rl9gvHxVfzonBkthnPyQZPMEt
	 Eu0UGj6QcWLjzGRLykoyR90qnmlm31S1BNUjl/ihLCFRTPGPAsdltvR8VxX8MF7u2/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795183908;
	bh=qlMAGYC5uJbj6p+b4wA5lEWZBwz6Kay2iFoOdqZrMXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMKpZ/ygNDi8DqUZmDrUT5ek7Rr8SftD58raFq9r3VJpDftl/Fsu0aVeqC9mqpGjd
	 yTROoPXUb9KHIlQn0ie+MmfVX29mAnF3qfJydboJsADWZuF3HKOej/f0cJoqm39cr7
	 UNk2mk6YHe9ZKYtdOT1pkAHxuuRlUDuy+AZIXr/hvdIHmivKJgIVU0HNI6NfotFHqx
	 oUkhZ4mwJC7QRSh78qHpG2zWORwmEhhxdFX0+lHLQnONaVHtL2wTRD8ZwZRBzUPe2g
	 Un47O7OkgM9E7UdU8maKvy524EEpGfOdM+ZVRpeoDy9wOnGhSt9lZQHTop6kJyR8hC
	 NWh7lZFZGsjtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 746B060750;
	Fri, 20 Nov 2026 14:11:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E92F9E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF480815CF
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3eSnsov1dttJ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 14:11:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B111D8159C
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
 header.s=selector1 header.b=ZdulwTDo
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B111D8159C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlMAGYC5uJbj6p+b4wA5lEWZBwz6Kay2iFoOdqZrMXM=;
 b=ZdulwTDozQC7el0OsrQrCU+AsaPH5Ic2cmi8KOFFWMqRBYdoUrZHsHAyFX3qQoGfiy/8FsDyaU0gchqjANhOXKh3Q4E2Df8BGovRxQw2YdQegSwXb2smmKfBJQslOvMtzPmQY08sdO91QUHe8zESsrv7HXdvZRnz6vLQ7dhAsG0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by CPJPR04MB448430.eurprd04.prod.outlook.com (2603:10a6:380:20e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 14:11:39 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 14:11:39 +0000
Message-ID: <7929ab12-1e1c-4f80-b227-b4422c17bf08@cherry.de>
Date: Fri, 20 Nov 2026 15:11:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] arm: dts: rk3399-pinephone-pro-u-boot: drop VOP
 clock assignments
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>,
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <ag.dev.uboot@gmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
 <20261011-b4-pinephone-pro-defconfig-v2-7-6b7be35fbee7@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-7-6b7be35fbee7@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|CPJPR04MB448430:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f8d140-1053-4b73-da97-08df47103209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|6133799003|261009223027099003|4133799003|3023799007|11063799006|261021121427099003|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026135527099003|261026140227099003|261022105027099003|261026130827099003|261022075727099003|261022115727099003|261022113327099003|261026121527099003|261021133027099003|261021130227099003|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: U22ea9fxTokKBjZH4xUL/A7wDJLmA1FYBpJuVxXWWIz/JJVeSt7VvXCkocoOYoG/zCEjb6v7WZ0Rz4dd6MVOldLapfP8GBqKhudunXN/ziTJi4w2PHcUAiNocUPUUU4+dLkvquYbSZjWwabv1/IlJVdEyG0WZ6puNm0UL73y/nEbowl7kLuU3Iztzi5NzCtApwss3Hma9oJhAnteFrWOcPNykWXfS3A9Ggzp4SIDE/jmsU2KbaSqa6F/HL4y9eaH0ZwZRPxOFteZ2E3zCJ6TcoR672dDJU3jNRGjRIt6gO3MMEM9btNkeshMUuBCzjWgVP1cHasQm1Kw2fvUTFq6cu/dsvDae2plASzGbR6cjD6DZ8JVjOtJndDE/bsQ3GoyFpcP5qdHJymHANcrDeE6/q9JVr0wAvbg2w0RcQWr/vUm0emQuagp2EWUCPyZtc4iVPDggp9nXpjCuJnWKpZYKr7Ei5zND4fPdNfvZb7S+jGxRJnvv9BHqV28qpjAL/KBoLVwHA2GSPYPurZAy2dX0PQ9KLX7v4xLMG+aOSMtEmZ/LFmPTS6dO7/R4eLtMPjgO3/mGZmXOmbZQztlEvBYGgUJtXvebS9O87IKQKvTATo4Ku1j14VUONOI6aBT6NrhV03JTHH2B2aXsxZDzgmUOa5IU222YSdYLtHiXZ+l6T4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(4133799003)(3023799007)(11063799006)(261021121427099003)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026135527099003)(261026140227099003)(261022105027099003)(261026130827099003)(261022075727099003)(261022115727099003)(261022113327099003)(261026121527099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU1Pbk1Pc3R5YTkzZlhqOXdldFZJeHE1cE5WdEh1WWJVMllITUFpaENMbXdL?=
 =?utf-8?B?alhsSzZlK2Z1QjFvSmg3UzJucUhvZVpzRUhzU2lMMElheE9JejRzMEZUTG54?=
 =?utf-8?B?VWNqRUFrU3ZvMWJSbUI0NGVycTc1MW0zSTFZZkE0dmlpdklmbjhHTGNjT2FX?=
 =?utf-8?B?Zlp4bW84WThlRjdmQnB0Q2tpUDlnN2FubjdUaW1iZURZTzVkNUFubngwZDYy?=
 =?utf-8?B?b0dIRFhJOCtSb2psb0IxOXBabTl1NWpwRUMzR0hDV3MxQzFQNVp2VHY0M20v?=
 =?utf-8?B?UlRSUXRXdVdlcVBrRlpCeVZSdllsMDd2S1JYaTBjSm5lU21ManptWjJ3Y3FY?=
 =?utf-8?B?UmllbitWeFMxYmpoVGNXUS9Zc29YeXczbWdDVUs4UG1jeDR5cE9LbjNLMGNW?=
 =?utf-8?B?Kzl1KzR4SGNwMHd2WUR2VWdYWmt1NmNBbmpwa3hCS3ZOUlB6WjBwak1pSlQ2?=
 =?utf-8?B?aEkwekdOWjFrQm5VUDB1V3cxS1FCWi9SL1dRdS9RdUR3UzlRQzYwMjJSK0Iv?=
 =?utf-8?B?R3FJMTRvOHltS1I2alBUM2JyUjZIUFZtZ0dwWDMzYVgrclBueE10ZnVwdzN4?=
 =?utf-8?B?VEpkR2tOZkE4VTZVT1R2K2s1SmhlL01vUVhBYXphMUFRS2JUZHkvRGc3Rk1U?=
 =?utf-8?B?K0trNUU0WHNMRHhOMDhabFpIWFRhY09rV3d6RlhaMkg2UW1nM1Rxd3RMMnNz?=
 =?utf-8?B?U3ZDRlQvQnUyZUh6cUpCc0czaUtTbFFLU3pETzZ3akxOdHJoRzlMbWVvUG1o?=
 =?utf-8?B?ODUzOVFiNG9rRXRTMElRQUtPcno2VW9WeTRhZDhzZThYd1R5TXdodW1yc3g5?=
 =?utf-8?B?enFLQzFGZk1jYjFadHpxNit4YTJHYzgxOXVVa0VlU2U2M2dNbDNWd3FJL291?=
 =?utf-8?B?OXh5NWFGZW96L2M2bWlWeHdZcitmdml0bGVIcDdpZllieE80WGt2Ti9qZDRL?=
 =?utf-8?B?YzgwcUdJRGM3NGgvZGtNNFBpZGhXeTJkR2xuNEUzaGhUQVVyMDliK3k3Mys4?=
 =?utf-8?B?cmFHaDNKdVd5MkZNeVI2QlRrQ2xuL2l3b3d6NmZTZGNlV1JGMGJrTjBZNXpP?=
 =?utf-8?B?aVdTSmJvd1d6dHJQSDB0TFVYMFNUMHRKVG5CaTN5MWNyNEx2bjAxbmJscFhr?=
 =?utf-8?B?WnY2UmpQNVVHUldUaTZmalRLbTV3N1BZcEJ0ZW5mVmJwalR0WkcxbFdKUzdW?=
 =?utf-8?B?R3dacVhCSG5tekhQdkNvV1ByM2RvVHkwM1ROeWxMYkoyMlNpSGNNckJoWDFK?=
 =?utf-8?B?Y0psd0N4bnplM0xNYnA2RnJSK2pRWmtFc04vRHFrcGJKSHdHVDZpQkdxTzk1?=
 =?utf-8?B?d0xhNzJ5MVhVZHZzMzB2T3lhbGxQT0Y1ZW92bjBSQjlEZ29KdEl3U251djkw?=
 =?utf-8?B?ajQxTjY4eXVsanhFOVd0bVBlWGRabnFDTWZPQTBZK3gyeXlCTHNid3liRFBQ?=
 =?utf-8?B?ck42STBPWFhTZ3pqczFlNG42bUlWb2JsTXYrV1YrYlgrdjM1UXEwQ09tNGN5?=
 =?utf-8?B?eUdtL1pleXI5Y1JpeTFRNUc0L2MvV05Hc3F4cVB6R2hLUE1yckdXM0lSWDdm?=
 =?utf-8?B?Vm9zdDNIUmkzS0p6bFdTSWE4YjI1RzdiTVA0bUh5MGhuUDFGbkEwRXVVckNZ?=
 =?utf-8?B?TkR4ekdEOEVoeDVYZWlsY3dDY3N6TXoyVWh2SXVmOUpFMksyN0N5c0ZmNTRJ?=
 =?utf-8?B?ZTlpV0RPOEU5K083eE5WZ2pDZmlxRHNYVTZrSkxPQnRHRE8xMWwrSEdtSWdN?=
 =?utf-8?B?RmpyV2tFSWZCUWFrME1ZbTc0Rjd4d3lqOHJGMEU2NXJMajJTYkJLVytsSG40?=
 =?utf-8?B?Ni9aMlJtQTlWSTNvMnVZRjd6cDgzOTJMQ3RpNnZKR0hub29yUXVtL1BWSGNZ?=
 =?utf-8?B?Wm5wWW11bTBiREpsUmFkRm8zeXlEenVSWTRRZVNqUlZTRjQ2YU90WXd0K2Zk?=
 =?utf-8?B?MlE2OEpYcUtkZ2d3dml3MDdUcExrOFZscGlDYVJ6T1RGTE5BUWdpakFUVURX?=
 =?utf-8?B?eFA3aUphTTR6ZndDSmRNQkUyMlIxWE9rQ2hUWktKQk9LekMxTGJGT05HNit1?=
 =?utf-8?B?cllJYng1MmpCQ2EvcU9RVHN3TUh2TG1SalBWQ25ueURGMzJHeHd6ZWlQU3V3?=
 =?utf-8?B?WWViYUtWSktRM2NLR2tBR2Z5NXNBdWhKejIvc3RPc1JZQmtUVzVBbHRUY1Vz?=
 =?utf-8?B?KzZSb3Fnb2hldktmc3JROHFKN0hqdWgxQnZ4eHVLeW1INzk5QklrQzVidi9N?=
 =?utf-8?B?UlFaMzB1NnFHM2FEeVZteUIwU3JZV1hOSzBvdlNJeHpLTVNMQXFzTVNLa0dL?=
 =?utf-8?B?UFdYMXg1alZHRVFPRkRyZ1U4Mmg4cndGTGl1d2V1QXdJaGNEcUJRUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f8d140-1053-4b73-da97-08df47103209
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:11:39.6324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jy5dQamR2abn4XrojrhZPA7KnlQtis35ISEb2vXoKljsOarIqq9it1Rn2sWcgwDI13LvISgSKBidWhDrd0c8VnI7nlVz92G1J1hKYLkNIZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPJPR04MB448430
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Petr,

On 10/11/26 9:35 PM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> The RK3399 clock driver cannot handle DCLK_VOP0_DIV, ACLK_VOP0 and
> HCLK_VOP0 parents through clk_set_defaults(). Therefore probing the VOP

Why not? What are we missing?

> fails with -ENOENT.
> 
> Delete the assigned-clock properties on both VOPs and disable vopb.
> Only vopl drives the panel and the driver shares a single PLL between
> the two VOPs anyway.
> 
> Based on megi's fd095c54eee ("rockchip: rk3399: DTS video output/menu
> support on Pinephone Pro"), https://codeberg.org/megi/u-boot
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index 2825d43a9d8..a3a8610d56f 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -41,3 +41,15 @@
>   	status = "okay";
>   };
>   
> +&vopb {
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-rates;
> +	/delete-property/ assigned-clock-parents;
> +	status = "disabled";
> +};
> +
> +&vopl {
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-rates;
> +	/delete-property/ assigned-clock-parents;
> +};
> 

We should try to get closer to Linux kernel's DTB, not further so this 
is not going the right direction.

Cheers,
Quentin
