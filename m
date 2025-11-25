Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB56D0E6C3
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 11:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1525383FE9;
	Tue, 25 Nov 2025 12:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="VFWafniZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 403DC83FEC; Tue, 25 Nov 2025 12:04:05 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444FB83FDF
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 12:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbx5WszRr3h6ahlmsjMUIS1RAVZPmfTmN3PYkLZVQCtuVsAhn+4qUBYYD86jSH8RXaFceND6dGhUNPNI6w1le442dKP/OxoEDNV5HjFLD3erlIIBssv+SYdcZ3XpDzQmOcj4ZYOGBSBvtatyTLcTAPOfF9mXnOe1w/UOV3d+NmUTkyYe3u5pd7jx3DcKK0aQ+K7VCC+9PfxdRfGMVGm5czHGGh8TxeHq4PVcrm13z+qo4Cltkf6s+FNQy8HF8W0PAGX35Gl00LYKzjpraAYUVkyI+EVojvAySB4REzc4qJ5PHSy2K+PPben0qv6q4aip4Kkh3X88JpVul1vABPvTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moDPywDUC4RSNIKIJirhhMMcNr1+TO0Yb3XMDL3+RqQ=;
 b=eiYXGV1sYEC66j1LIhnD4QyIyZtZwPZQ5nbVXHdKUEs5sEdWeXFxgQEXrcOO+KB8TI1t1WbxwPpxkZ2+P3l+eBRzoPBFP2YYopa3vict1SdelbICG7BH+ZUhc44/9dLJXhhQDmtCpsamylqzLe6S2GszCLMkFYKv2yNkNVWnNGPwFbxmuPppwvDT2J/ZRw3cOSgKd5d+XPssy7xDuGcRs9afDxl9uO5X5gNdohED8yqpf8QH6zbaPZeEeVYA+kYwq+PO130LxzN9LNnt6kfReKwRMdS7XlS7GVpBNP4/n563K/Xqb9PrRExBS/ML1sH3cFlJFt9WfQS/pce7JWGRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moDPywDUC4RSNIKIJirhhMMcNr1+TO0Yb3XMDL3+RqQ=;
 b=VFWafniZZpiny7co+zEBE+MkEIYdJdmitFOV1lh/6XmXD/UaSAMFjjKUrxOz3IFcO2Ep/XoE15gOEUGpJjwTto/xc6MWt6IawQIwX18YunFQj6JWsWU1j8zvTP9M3PyVF1XUBujzvXEMFwzEZs6JPj2Sci4aVxX2hdprLt/RwYpGWyp1OU8fKntrj6eBJhX6c0eYdS901+j1bjhlcM7BkS3tMiuEVvC9KX2yHBI3Qvvel9uNFbma3SszSI2iC8BEw1GtQpucG/5XNjmRoz5WPVQqYEzTDzpkPFDm9cCfHgmKw0pF4s6vfykkQ7FrIT4rmEVXX8cISCofrEAoEYZu5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3665.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:157::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 11:04:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 11:04:00 +0000
Message-ID: <eacdabf6-9cab-4782-8712-b74dc51fd2c5@siemens.com>
Date: Tue, 25 Nov 2025 12:03:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
 <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
 <CAN7C2SBtyc_i3inaCMBCUr_x40_d1LqEARtb2iJms=rHt2TtsA@mail.gmail.com>
 <74bf28a9-dbcb-4bf0-8f99-9239018a94a3@siemens.com>
 <CAN7C2SDz08cDgKQXMwJfDf_pVfqhhz2BJhVKHk2WqHP+hhE5Ow@mail.gmail.com>
 <bf13f555-b1e9-4208-9497-baa3870bc0ed@siemens.com>
 <CAN7C2SCQd9M=ghBFt2t2Kg1w=VLA0DOMY9HnbwTH2Yram1iYfw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAN7C2SCQd9M=ghBFt2t2Kg1w=VLA0DOMY9HnbwTH2Yram1iYfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4399e311-d317-45bc-e12c-08de2c125646
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmJlaUI2Q1NRbldvaE5acHdmcDkwUmNIbFVNRFYrQy9mRi9vSXIrZTNzeDQr?=
 =?utf-8?B?N1FlU0RtRjE2dy92Q3NjblJZWm5iZ3RYaWhIUkcrT3dxNXV6c3VuM0Y3R3gw?=
 =?utf-8?B?am5sNno3NHRQeUZmYkZYWWI2TW5YNFQrN1o0eHl1cjA5WnBsTDBqN1p4WHZZ?=
 =?utf-8?B?NlZzRU5EdERBQzFwZk80QkY0bDFkQytKWDNTUzl2U1NMcDhyTDlCRUVxUE1z?=
 =?utf-8?B?NTZPMU1DZHNLdHAxV09mSVhObnUyZ1BWb2JpcERyOE83aDJncVN3VHJrYkU0?=
 =?utf-8?B?eXRKdUhpd2FBakdUYlF4eFNORUtydUlVbmREM1BoejhuMlI5MEphNS9RdVds?=
 =?utf-8?B?ZzJFNngzR28wR0g0K0QrSDF1RXVzY1daS1JTbWtTR1VmcFVTNjdsbzVMalor?=
 =?utf-8?B?aHQvcW9iekhHKy9jOFVwTVZqRmxzeEwrYk5JUWlZbkU3Vzk4VC9mN2x2RHJr?=
 =?utf-8?B?UDZJMnN2YXEwS0NkSWRUaEpkaGY1L2Y3RnNNRGcwT3lQcGpMdW5UZnM0OEJZ?=
 =?utf-8?B?R1pMV0g5R0wzM1VxQWFFcEJCMnh6ek5mTyt5Nm11SG5VSkVUbEVFWmZRKzAx?=
 =?utf-8?B?ZGZVdnJqZG5zRUZqMnIxZXNBeVFhVTFvSENFOWxpQXVWTHFqSFVTVmxPcFZi?=
 =?utf-8?B?UDJHcHFUSUVmeEMwUEpOdzM3ZHB0dVNRRkF5SjZDN0VmUUFhTlhHS0l4ckhV?=
 =?utf-8?B?M3NHaG1vc2hobStRTkgxbHBaYjRKdDFPSlQ1eS9DY0pFR25ML0p2WDQ2cExn?=
 =?utf-8?B?TEhOckFycmJCK2JnUmpTY1pEUFdsaTNzeW5LMEhzOWZxMFFiN3hZbWk5SFVW?=
 =?utf-8?B?cnRBY0YzMzUzL2pzZmJWWE9jM2RqZStXRFlEemdjWFpDMGpnajVQZk9pbEZG?=
 =?utf-8?B?Z1NUb084dCtPVEhaMnZvajB4cnRUV2pxS2h3dS94L1ZBb21EcHk2Q3AxVmFX?=
 =?utf-8?B?bkdOMnBmZkdLRTdPbWJvbEZOMzdmZWtYRVlGM2xWN0t5L1lKT1RiT2puYTRO?=
 =?utf-8?B?dzlEYUtuRFpYZmtVb2JxUEZIa1Y2cmtqbEZZOUg1bWMzcUJxZVJFNVNkeExl?=
 =?utf-8?B?eEtqZHRFd00wQjFVd3VhUVdCWjBTU0FwemY5dzhRR01hSnB3Ly9xTGczck5v?=
 =?utf-8?B?MUF1M1EzUU4rb0lHSjN0MC9rc1RaWTJTb2xRc3ZURXYxaFJiTVhSeUhSdTNB?=
 =?utf-8?B?dCtZRmJCM2JMVVEzZXBCS1hnaTNwN1BZU1g2Y2dKbDRIanE3aU8yakdwRE5K?=
 =?utf-8?B?ek9Xc0I4ZmtWSWxpWjVjOHg0UWVNS0p0MEErRFYwMnVtbnNiSmowTlR1MWlP?=
 =?utf-8?B?ejR6OGFsYTF6QVR5cWd2aGpOOWh4NEhJdWRURFVvZ1Y1WDI3d1g3eEdzbzhQ?=
 =?utf-8?B?TUs3MVRZYkI5VjlPMFBSbll3WCt1N2xKNkhIOW9PM0hleVkrSGFlZlJiU1VF?=
 =?utf-8?B?YWducXdGMHNiRG5TeWZTa2FkejNXN05xYnhNNWxKaVlMSzZHZEJqVXBZT0lX?=
 =?utf-8?B?Wks0VmI2UmVzNklpY3NaOVdFQVYxeDV1dHRjVmRlYy9uMG9hREhpYnZkaVVh?=
 =?utf-8?B?UFVyMzNURFFsczVzWFdNU2dUQjZ1TGdrdll6TWRlQUlreDAvUDA5dm1wWFli?=
 =?utf-8?B?ZGxJZkM3TU5SYmdINTJYWXNUUm5TbTIwSzFiN2U5UzZ4RlE1RlJqU1lEcW5L?=
 =?utf-8?B?RlZnemFXdTROci9ycDdWZlRGOTNydUVIQkFHOVlGLzRXc29jS0NjdEpqNU5s?=
 =?utf-8?B?V043Ump4UzdTY0RQbjcrb1pmRDJmWVBGQjJJY2NFSVNYWXpPZlB3T281djVl?=
 =?utf-8?B?U1JQOFptYVZrYWhOaENXWFlCaUYxZHVTNU01a3hVZkpTSXIxREJaVjRROTRs?=
 =?utf-8?B?T05Qa0ZYcU9XbVY0c3FRQmhCUDlLS2RzMWkvMlpCMzhGQmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZyN05ab0IxVHFwaHpwaXljaVd6RkNITzQ2MkR1MGhIMmtuTVF3VVJuNXM0?=
 =?utf-8?B?QXluYVlKa1kwaUNHSXRnaDN2RHYrVDNYY2IreEpvRWlZV0J3cUhoRTRrL3VK?=
 =?utf-8?B?SnFhL2NYeUJHM3hyb0dGMGNKOTdPaEZuWWpiSysxMEVsU0QzZFRHUWlIY3BM?=
 =?utf-8?B?Q2tJRXBVZkVtT3RvZklPT3FTc0dFbVJjbWp6SGdHVFNzVlhBaUNBaFVTSzVN?=
 =?utf-8?B?ZWpOd0dJMG9tY0JEWk9BWVROelVRT2lyZ2xMNGFwVEdrQTF4RVVubmN3cUhF?=
 =?utf-8?B?dktoRnFEbG16TEdBR1NRTVVqa2t3R21jYVphU0hxZzJuS0RBMEtjY1ZsUm4y?=
 =?utf-8?B?RXJRQ0d5SUtGc2t1TEJEaENhTWFuenlRa0syZlQxUHA1WU1uclRWcThpVkpW?=
 =?utf-8?B?anhUZFNoallIUHpwd0pXb2doVEJrZS9oallLQ3dLa3grNFRRU2lNcFovdDhT?=
 =?utf-8?B?dm90UTdoMGMyRmNlR3VPcnZncE1yL1M0T3l1MlVhZzlPLzFwUmRsUndBNG9t?=
 =?utf-8?B?WjlEWmc5ZVFrcTJvSEZEcEJLQnFnTXRaM2FZdWZXM2hUMXcyVTkvcmVLYkNU?=
 =?utf-8?B?b3B6OFQ4SW5scGp4SVgzQk85b21IZlNDdWJKN2pLQkFodlZ4ZnFvQlgvWDQ4?=
 =?utf-8?B?Kzk4UXhtaWFDcERoeURJZ010K0VDemlpYTVCNnZlVVV3L0k4cndjc3VUSitR?=
 =?utf-8?B?enVDYnpVYnpKaVFYUTVIM1hlZXpQNGFTVGlmYmRWYVp1eFdXWHF6cmlmWlNh?=
 =?utf-8?B?NFREWjF2UEgwVFRvNnlEY3hjc0F5ZUQzZkpadUtnUGtmNHQ0OGhnc2gwZnNz?=
 =?utf-8?B?Mlh1NGFKYkt6VDdmWG8zbmtvWWRoMW9ZMlAzZllMRFBqZzVNRHpkeTVRVVV3?=
 =?utf-8?B?VzZKbXdJSmZVOVE4TU91dTJJY0FIWDBYdSt5YklpeUczd1RUYStQWVVvNUxL?=
 =?utf-8?B?QWdOcGhZVWxWalg2ZVBNbUhuamt4dmN6R0t1Z1VwbFpaYkM4cmpONXJHRStS?=
 =?utf-8?B?VW1yWkhPUFNBNHJoOHh5clR3VjI0RkN0UXhpSTN6Y0E4OFNYOVBUT04veUVC?=
 =?utf-8?B?bHZnUVJjK0RHd2pSWmo4anc3ZmliZ0lpMEpBZExGQ3BRZmZ3bm8vMlljazJX?=
 =?utf-8?B?M0RTeVB0UGF4QmFudzc4Nk5nMzhtUVJYT0JwK3BvREhybFM5TzVJNHducGta?=
 =?utf-8?B?MkJTNGUzS0xWRHJvUGR5aEdOQnJ6TkJkdHFUb1FnTllRZ1hTMnUxdDFmN0ZK?=
 =?utf-8?B?ZzRWKy8yK3JFQWJNNEU3VEFNaEF0amthOEZVZHhjVG1MZ3FTdTJkcThOaG1w?=
 =?utf-8?B?R214Z3g0Wjh1a0R6ZWZDU09lZGlCdmlHV1lhK0hOeW5Nb2dqVjRSY0Q0VmZF?=
 =?utf-8?B?Y2EwdlpYZklmbFBpZzVIbjJEdWN6Tk53VVJHNGxYalUzdFE4ZnZFSnlyVkxa?=
 =?utf-8?B?aHB6UUVFNThwSXB5TzR0ZTE1bHo5SEhWSmcvYXdHbVY3WnE4NVo2RTFUQVJG?=
 =?utf-8?B?N2JHLzd0RTN5aXZtQ3JHZ1BheCs0cUdTUmFZS1BNcndjNkNCVFV4RVZIL0w5?=
 =?utf-8?B?SkpjZ1FvTEJhckduMkZ1d2lpK0FxTGxqMHQ3dFFHTXdxSkg2ZkJOTysxZEY2?=
 =?utf-8?B?cHAvYVQ2aUcyaCtlRVRXMi9Oak9ZUCtYSEtvV2RQektwSjJmYVNMcnBIVDFS?=
 =?utf-8?B?cHE5YjNMaS9RN1p0NG5GZnRrRmJITzA4aTJxWklOSThIOGFHdnVSekhjZ2dI?=
 =?utf-8?B?US9lWVNhN3p4YWx4WEZMeU1jRVdwYThsYkxyMDhmaFRpMXJwcDBvTmVadERO?=
 =?utf-8?B?d2ZVZ0R2Q25MamY3T05QZkhVamhqWGhpdndJYUl1VmNsMmVvSlNGZ3pqV2lY?=
 =?utf-8?B?ZTdnSDdkQ01GcS9yOXVtUGtBQmNmUG9ONGtKUUkzZnVBazkycWZFSVl4Rm1T?=
 =?utf-8?B?M2NETzI5dUVyR3o0TXQ0cFdVQ1lJNVRtYzQzZm1MQnVjZFRtWHhCb3pUMlow?=
 =?utf-8?B?UkM3ZjVKNDJQS1kwanA4NExZZUdsUUVpZXZhM0o3cXdNc1dRN2pIenBuTk1B?=
 =?utf-8?B?b3E2bnNNLytBQzFJazdoRkRaaTZUT3hNMjgxMGhkeHhHbWdCTDRDcncyN1Fx?=
 =?utf-8?B?cTJVYlhHZldleUgrM25uYWFTWncvL0ROOHBTbjNvdGlncDBEVkdGNmlTSkZy?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4399e311-d317-45bc-e12c-08de2c125646
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 11:04:00.3461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOWt7/UXgxXPJc9IO8c5HDeCIcpFwn+Dlu/L2PKKRrsn4cZXkjzC50oH9ZqvLVKAZPuv9fjP6rJrzK5ujInl7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3665
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

On 25.11.25 11:17, Sune Brian wrote:
> Hi Jan,
> 
> To be honest, it has nothing to do with the board.
>> Different boards.
> 
> deconfig itself also requires alteration from first place.
> As of early this year the boot detection, so any sync
> patch had been pushed?
> The detection is completely universal on cyclone V HPS.
> Unless you have the power to reload the HPS bootloader.
> 
> But long story short, I did not have any issue on
> Cyclone V socdk
> Custom board two variants on size.
> "小梅哥SOC Cyclone V" by china vendor.
> Which this board is a clone of DE0 nano

Strange that it booted then. Maybe you happen to work around the wrong
offsets by adjusting your partition layout, rather than by teaching the
SPL to load according to the actual layout.

> 
> So I cannot see how DE0 can have such power to defer.
> So long story short this patch is not really a must.
> 

The whole series seems to look for new owners if I read [1] (even if
that patch is incomplete yet) - though it contains valid fixed IMHO.

Jan

[1]
https://lore.kernel.org/u-boot/808832bf-e185-43f0-89ba-58941d2535c9@siemens.com/T/#u

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
