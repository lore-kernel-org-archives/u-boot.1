Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA74606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mHqWrp5l;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=BzPR3Ify
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B79E7607B3;
	Mon,  9 Nov 2026 14:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXQrNu7dEM8t; Mon,  9 Nov 2026 14:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B06756072A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794233012;
	b=edPw4bJ6nnRKRTF4UiWdIb66+SXtU7aK3jBchrcSuxXsKplwssHfcXkguH0qoagXzx/Y
	 dhWd7Au+3XJnlVAvO6Ta9/2xpwuRpbgopL30FTViQzZ/r2i5GLJu+0HzJ4aexIKVLpjoa
	 tDL672qEKo+R1C2/HUdEK8liDip6e+gvcL1xBEDY114cEoWZAkip1muhXFHNTBiHP1xcX
	 e7CeI2AKHWvJBeJ+e/p/Ye9XSJ1r6DoJxxFAAcd+Xe4z+4z//+rrn9vFbx5odNtTyX/SD
	 ynukq66c1Lwujuq8KI0D2lvxQU2/F7WW+skH68/q7z3RT+AEzxfBExlVZeUJS63/oIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794233012;
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
	bh=B89yc++K8MxcpkmqxhmoAKIYz+RG82viJG4vUnFvDyE=;
	b=YSKDa+GH0kydvUm+/F8ePdjRR0wVmtX4OAuNmmyMEJrgatHEDTqitWrG35kZmJysq1JY
	 e5F+BCpLvB8y40fcMbFdWsCaPlEO02Jo9g1cqadu8VHv48KHVg15mRP60dNBOtXmYclK3
	 x0pDpl9TZzwuMaPLO2kucT/7rMUibFiOURV4uMgGv9vFjwo7LnSbfM0D1mFjgJqays6o1
	 w5nyvTzj4KAQ2NU4+y8Tcpwf3WLQ6u5aa1rbH+SdOw95t9OTnXUSu3Fo3vik/AruEeiav
	 1uj87vfkZM/fImbxVWdA+JWbazR4Xmtkd5CDZEwsniJfO+L0gH8KI7+JhRIDdo+Ll4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794233012;
	bh=B89yc++K8MxcpkmqxhmoAKIYz+RG82viJG4vUnFvDyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mHqWrp5lUaU+Px3agLdzk5b6FfQa71wKjFMl2+a7pml/eQ2NeBw87hw6UIF1TIOgu
	 9h1ATK/d1psKnQN5FhCiYBjpEC6+n86YvdgcT9zIfBgqVixhNKWL3n9df9Ub1Wisct
	 yQGQi9EcjoopZ21kS2BIRzgNY7Mr+PAcS56iw1FgUjMlhwNyR684wg1tMMVcvafgiq
	 s9S5TH5zeDJzKKU/9ni0/k/pOtm7FrfBHQoCIXR1GCC4MgTaAkwnDAe54oVjYKEsgm
	 Z9eDefoI4lh6Qa4a9x/f7i+/xqtBlWG3BS3OiWS61kmJpOfnxi1MyFFfEzEhKCiWEi
	 /hC9iKoJ/VasA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B06756072A;
	Mon,  9 Nov 2026 14:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5FBA2AC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2F8140709
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wu3SXDXnqyd for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E09D040631
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=BzPR3Ify
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E09D040631
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B89yc++K8MxcpkmqxhmoAKIYz+RG82viJG4vUnFvDyE=;
 b=BzPR3Ifyml8s0qayZ8VQjKhbxoP2CuW9fS8/QTsV7+kyZCVHRmINo12qf+/nh8iwYFIiNdw7hh8J48zm7+GDM0Ri13/h2rbGUkBoJ/HV+P4jPpkHRCtB6xThsu/qVaiUotmlErz/9G4PCwn9X9lCGhNUB6XfxFIzk8Hc1fxDgSU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 14:03:23 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 14:03:23 +0000
Message-ID: <da653d41-6c49-46ff-99df-91df27e45815@cherry.de>
Date: Mon, 9 Nov 2026 15:03:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, s-vadapalli@ti.com, Jonas Karlman <jonas@kwiboo.se>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 186f0ead-3bea-4c72-13d8-08df3e6a37e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|261022105027099003|56012099006|261009223027099003|11063799006|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261022113327099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7Mu+HOJ/eAbNaXkSoqE4xG2BGRAm92o5rw6zyWW7QdDkiBQk8ef34+9tEskqQ97ly7ApcooGYoozwUXp6cRp5XV+YaIW1b2NC52dGzD+O4S/rZxTGygCazgTBfDu0B8xTCK9v8bDv+6P2uLD4qvsibHW0NBjHMRtECTwCPjlq+PICjKM7wiv5T6IM/JVtsC+zqOq7hD574EQN9F8u28lnq9E2117tuv5LdU56bIx2nkH6H7dc4/MpSBKx0DJLk06z5eQk6GILb7aF7p14pTJqRoQVi0893tNoz67DH8onogSoaGgaSy9jzB7KdojG/Cs7HvFZUiMr0gclSaGjxnZWP8cpwlHWtpodXCJ/sk/MKA8/xCU0r9H6+fuR02/WBrff3vWRUFY+Zja7QjTPYpwrQm/QEQqPBiGzo7H0T3c3qcQx07j4j9rUYsgvsX0S0ylhibPuahcXr3x78/VZJcuL8B8c2uqn6Mc/NvZ2T02FSQcVpTM2t3Ge+h1bTDGNSt1mz0cJ0gAfpQqmhQ301J2TfD+DQN2pIedfhGuDljT4aYU+t5wFkxQhISXswK+UK3+madHFgQ1A8/w4KEFgf3MXG2qc5k6ajNQLCQF03wvzraqrJ/SHDpOObA2ZRUZvwnc8s/7bCfIEcoEVhp8gjmKTByQh75/gWMWxiOfksRurGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(261022105027099003)(56012099006)(261009223027099003)(11063799006)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261022113327099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THFYZDhyaXlTS3hOS3lOZUxjUGdPdG5HSWFOdmgyTmNHSXNMWGh6bVRmV1Qv?=
 =?utf-8?B?Uk5ZSEk0cGVHaDNxMmI5YXlPTUdGYjZORVhMeEJWTkNybHNhRkJLUy83NXdY?=
 =?utf-8?B?YVAwaHVjNWhsZkpsSlFvTlpjNFRZMWpNeVc1NE1zWW1OTkpvQkI0eGRuVTJN?=
 =?utf-8?B?a3kwS29vTXhWdmZaczd2dExQeHFXcU5TaDFZdTdTMUIvdmZHaG1vODZRaGJr?=
 =?utf-8?B?RGtabklwZm00ZzBPQVlXODV4OHo0b0RzMkxWRVE0RkFjT1ErOVowS0RLTS9o?=
 =?utf-8?B?VmhWeHBIcmJUYS9CUmxneEx3L3dIWWx6UStlNElYUW1XSWVNVDNxRUxpcjFW?=
 =?utf-8?B?NHN0R2JGL0FidUJnRnN5ZUZrZGFtSHkzTmpQYkNzd0hqd0d1LzlnM1ZnMVZh?=
 =?utf-8?B?ckg0QnR3NDczUHhlbk1yOHEvZzhYUDg5d2pqc2hRbmxCQ1hBeTllR1ZZN212?=
 =?utf-8?B?eWl6c1Y3cit5ZHJNdVFhSll2UDhTdE9hTXBnd3VmaWpnanp6RjN3dzkwZHBx?=
 =?utf-8?B?TmNCSndJVWh4SEowL1I3QkltZ1hkMVllY1RJYjgyNjR3aHE2NGRzQlBSS0Ny?=
 =?utf-8?B?NFFSNmVzQzB2NnZWSE0xQzR3M1hBUjdpVjZKb2VLYVNrenhwMGxCNWhxOHh5?=
 =?utf-8?B?bUdkazZHRUtubTl2R01aVUpnSzZsbnlrRlQ3ZzdCdU5zQS9VOVBEVUZ0YndL?=
 =?utf-8?B?OW4zSlFzZGxsU2IxL0JRTUYrd0ZJUTBoKzZrZFQ4R2tLL29QWnpVcTZnOTRw?=
 =?utf-8?B?OGdmTENiaE8xNHllKzdDS1NkUWlidjFpN3Z5eEhEZTI0VG9UamhMbEN3OHRr?=
 =?utf-8?B?RmdYY2tZcGRXVlBuSG1tTkwrM1F4Z1Zjd2k1YXNGUmNza0kyUU1oVDlHeVFK?=
 =?utf-8?B?SkJFK1h6dkxiVHFLN1N0YU5UdWIvMVdSQUhJS2pDYzI5RHlmWFZkajNkNnZO?=
 =?utf-8?B?MFBwRG1RRWE2TExqTlRVODhwMkhydC8wSyt3emM5YVkzb2lvVnFZM0Q2TVU2?=
 =?utf-8?B?L3Fqb0dKV05CYVpRZXBIaGZlUUJocTBlSDRWdjJ3YklMUUhWM3pTTXNMTHhK?=
 =?utf-8?B?U1h0eHVnRy90VncyMDJsWWlZM2hLemtZMUhQS3RMKzBFWTF0MzZIeVhacGZU?=
 =?utf-8?B?eDRFYjNKS0Q2NEE4TGlQdC9ZWFVXS29TSW1OR29xd0YydWMydWp6cmx4OUl6?=
 =?utf-8?B?TlVqLzBmR1B1S2xYd1lXc1MzNkFBdm1PV3c2eW5ZSlZUWEtUaUN0U01mNHZC?=
 =?utf-8?B?Nmdvbkx0RVJXQjdYcHhQdG1HQWVQZGhiRWRTM3hCTUc4WDgxTG05S3RENHBX?=
 =?utf-8?B?eWN3VXUxOFBtNVQ1V01pTXdHZURkWVpDa2dPL2s2WGRDNjU2SERHNlV6TWZ0?=
 =?utf-8?B?TWdnaUN3Sytpamwvb1FlNFIxMkUyNjFaSnVsbXBMckZFL2tPMjV0MzBUUGNh?=
 =?utf-8?B?emdObDZDZWkzR0lNeDB4VDhwUWpUMDhwSStjMXFHMTFGYzl2ZXl5dzJVYXdP?=
 =?utf-8?B?MHc4M2Z0MExZQlozRFFJRngyRDAySmdCdkQ0YzlMb0EzNkFUVGwxUW83Vnk5?=
 =?utf-8?B?NkxRNksybmpObWlBa0ZJdk11Y09lNXZnRWcrTURkMlhacjJoU2hQb3NrL2Jk?=
 =?utf-8?B?WVlzL2ErU1pBc3lzbGlCSXJLaU9pQ3NoT2wvMzVyNzFiY1NGVHV6SENNaTBH?=
 =?utf-8?B?bVVYbit4K2lSbFBwU2RFVHYyVUc4dXUwV3I5VStjZ0ZuVklmdTRzRTY1enJJ?=
 =?utf-8?B?QnJGMC9CZWZnZE9tZktlODJBbjdPN1Y5N0JzZ3psRzR1STU0T1BKOEp3T1F3?=
 =?utf-8?B?YjIxOWpneGtaN3ZsZ3BtV3FINERNSlUyRmtiYXVPblpmYkhJYUVvUzNReDVM?=
 =?utf-8?B?cW1xWUlEYzI1L2Z0Y21qY3FyRFFRcUV4RFJnTXI0bGdRa1dWMXhVemdzUkNX?=
 =?utf-8?B?eTNtRWx6QTc2T0Z5amxhbngzeGVseFlSRG1ZRURDK1pGR3VQb1hEM0YzZlIr?=
 =?utf-8?B?STlDam9scHFLQXcxKzM5VVdsbVdWRWxiQUJDVU4yME9ZbnRKS0lTc3BTeU4x?=
 =?utf-8?B?U21CazNwcCsvUjg2RW5BdlJGdDU1RytDcHpLRDF5a096UEpWWkUvNzF1dnFt?=
 =?utf-8?B?SENPREQwbFk1TmNiSVptaXdFazVkMFQ1Z3JWV1M1UnZ4bFNwRklOaTYyMXRM?=
 =?utf-8?B?empjTGN0Y1lpZ3cvTDRVL01kSkhkY3lsRDFDTVVMb0JHbnlvVnNhUk8xUTN2?=
 =?utf-8?B?RUhuWUJvUU15QitJMzAvZGtCcER1VDNKbm5tSkp2NTZ2R0Q4NEpsQTkrWFFl?=
 =?utf-8?B?anFqR1grcmhiZ1BJSVdIc1BpVDg5Tlp1OFdVMVhQbUp0MTU5NEtOZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 186f0ead-3bea-4c72-13d8-08df3e6a37e4
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:03:23.6458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4yZ1BeTwJ8oNMn2E19afQMkAERwEBb17mpVpgcn0uH7c5yCtB7VpqXF4QtA941rmT+Wk6+1I6WgnBpWflRtsJMGrWTDuUOLy1+wAD+GIWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580
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

Hi Anders,

On 11/7/26 8:21 AM, Anders Roxell wrote:
[...]
> Tested on hardware with v11:
[...]
> - Rockchip: host on RK3399 Puma and RK3588 Tiger (Quentin). The two
>    Tiger regressions from v10 are gone, and he sent a Tested-by:
> 
>    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma usbdrd_dwc3_1
>    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger usb_host1_xhci + usb_host2_xhci

As promised, I gave DWC3 on my Pine64 Quartz64 Model A a try but 
couldn't make the single USB3 port work in U-Boot from main at 
ab4dc5aacf95 ("Merge patch series "Misc Fixes for VGA BIOS Emulation"") 
or from v11 at 6030c4d33099 ("usb: dwc3: enable SUSPHY again after xhci 
is registered"). It works in Linux though. Maybe I'm holding it wrong, 
who knows, first time booting the board on my side. I've asked Jonas on 
IRC if he had USB3 work at some point since he's the one who added its 
support in U-Boot.

One try:
=> usb reset && usb tree && random $loadaddr 0x8000  && mw.q 
$kernel_addr_r 0xffffffffffffffff 0x1000 && usb dev 0 && usb write 
$loadaddr 0 0x40 && usb read $kernel_addr_r 0 0x40 && cmp.q $loadaddr 
$kernel_addr_r 0x1000
resetting USB...
USB XHCI 1.10
USB XHCI 1.10
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
cannot reset port 2!?
ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
unable to get device descriptor (error=-1)
Bus usb@fcc00000: 1 USB Device(s) found
Bus usb@fd000000: 1 USB Device(s) found
Bus usb@fd800000: 1 USB Device(s) found
Bus usb@fd840000: 1 USB Device(s) found
Bus usb@fd880000: 1 USB Device(s) found
Bus usb@fd8c0000: 1 USB Device(s) found
        scanning usb for storage devices... 0 Storage Device(s) found
USB device tree:
   1  Hub (5 Gb/s, 0mA)
      U-Boot XHCI Host Controller

   1  Hub (5 Gb/s, 0mA)
      U-Boot XHCI Host Controller

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

32768 bytes filled with random data

Device 0: unknown device

Another try:
resetting USB...
USB XHCI 1.10
USB XHCI 1.10
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
  ** fs_devread read error - block
ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
unable to get device descriptor (error=-1)
Bus usb@fcc00000: 1 USB Device(s) found
Bus usb@fd000000: 2 USB Device(s) found
Bus usb@fd800000: 1 USB Device(s) found
Bus usb@fd840000: 1 USB Device(s) found
Bus usb@fd880000: 1 USB Device(s) found
Bus usb@fd8c0000: 1 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
USB device tree:
   1  Hub (5 Gb/s, 0mA)
      U-Boot XHCI Host Controller

   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Mass Storage (5 Gb/s, 126mA)
        Kingston DataTraveler 3.0 1C6F654E48EBB161D95D8F07

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

   1  Hub (480 Mb/s, 0mA)
      u-boot EHCI Host Controller

   1  Hub (12 Mb/s, 0mA)
       U-Boot Root Hub

32768 bytes filled with random data

Device 0: Vendor: Kingston Rev: PMAP Prod: DataTraveler 3.0
             Type: Removable Hard Disk
             Capacity: 14784.0 MB = 14.4 GB (30277632 x 512)
... is now current device

usb write: device 0 block # 0, count 64 ... Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
0 blocks written: ERROR

Yet another try:
=> usb reset && usb tree && random $loadaddr 0x8000  && mw.q 
$kernel_addr_r 0xffffffffffffffff 0x1000 && usb dev 0 && usb write 
$loadaddr 0 0x40 && usb read $kernel_addr_r 0 0x40 && cmp.q $loadaddr 
$kernel_addr_r 0x1000
resetting USB...
USB XHCI 1.10
USB XHCI 1.10
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
Resetting EP 3...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
Resetting EP 2...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
READ_CAP ERROR
abort_td: Expected a TRB_TRANSFER TRB first
BUG at drivers/usb/host/xhci-ring.c:591/abort_td()!
BUG!
resetting ...

Once I attach a USB2 hub to the USB3 port, the USB stick works just fine 
in U-Boot (in USB2 mode of course).

I've checked with git-range-diff between the v11 on GitHub and what was 
sent here as v11, they match. Considering the RK3566 issue is not new, 
so unless Jonas (or someone else) can help me figure out what I did 
wrong and make USB3 work on my Quartz64 Model A, I give this series the 
green light for Rockchip.

Cheers,
Quentin
