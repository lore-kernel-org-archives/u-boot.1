Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4CBCFD37F
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 10:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764EB83FDF;
	Tue, 25 Nov 2025 11:50:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZoOWPbWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564C783FE6; Tue, 25 Nov 2025 11:50:26 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513D483FDB
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 11:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ0IGzAXVjBE+XFpElmXpe8Z8umTjUr8ygmr68YlmcN2EO5ynYvEEu3AmK9JPk7dSCcJAY8CPRHvW9vStT178vE/7cQBif8ZP/O1Ei8XSuCbqonkgbp9YaiqwHDCqPNi8bosJdVPKrm/gDpe4oPmmjCxnjSro5UCd7BqcMEh+RNiKCDCN2TpLSK2zXK45J/L00sc4Sz7CCbp8BAf9yWEEVgMauewBl7/Uktn8OmNm6jG9+Oy+3OdF0kOm4pNZV9CnYJENv9hq0X3SOejN39JCvj2j4+K7xZ7EVIASQc53zEIkk/3IpR6ed1qjuz9NczBehacX4BIGUfPjalxYs0j0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwW9KZKuSHvqJ38trflQWeq5nIvPyX5IDHKHS57GKuc=;
 b=cY+5B3eFOay74lox34qHgtO0svUW5FFJK8r482XMY+LfYwCeSxZoyUkkx7HM1VjjFsNncMPfTT0tHfoQa/cUmRFwP9y1uU7Ip1LiIHVqjAU9TFB2ZTYiwMPHwCnYcwfBAJWrTDxOG3GHQzGJ6Xiqs3KFDXm5ISVXYUsGPS4glXuspqPQjrgNusG0/XFfXrigOH4upw83GlHhuKkYDgZp2D/LXg7dKkUeciztsOWYkspLUryOHEbyGmUHJoh2FRCpihJu2Bo+UhNmXlHbF/JdpXbxUL/o18GHu/P9evu0SimGHWPY17BmF1gfOirKA5Mdrej1L/ADjwXVtERcgjUFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwW9KZKuSHvqJ38trflQWeq5nIvPyX5IDHKHS57GKuc=;
 b=ZoOWPbWW/m0fuhCc3gConp5QS6qR66L647TQ1WGL8OKKK16hAJ6zi2E0rqvJ+CsqMg9ntpNOvzVRCWlJV0tHLwFY/k8doz5J0Dl/nWTCCOx49RoY5pZT0CSQTg2tFPZ3KNshf1s6zNpE3x/h1Jj1c7LbNtMJyTq/NlPZfdG16kQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB11545.eurprd04.prod.outlook.com (2603:10a6:800:2fd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 10:50:21 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 10:50:21 +0000
Message-ID: <cc5f03cd-6caa-4129-a4d9-b502e9c61990@cherry.de>
Date: Tue, 25 Nov 2025 11:50:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] test/py: fit: Deduplicate the test
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251124194201.83326-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251124194201.83326-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB11545:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a4c5a8-80b8-4f8e-6fc5-08de2c106e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU5tVHh0MzRRSjFiVW5YdGkzWll0UFZhZ3pQd25sRC80YnFIS0ZQWmJ4bjhY?=
 =?utf-8?B?a25uV3dpYXNUOHdoRTBkMkxVazMwVlNCMG43RERBU2ROV0tmeVlDQnFINjJi?=
 =?utf-8?B?cE03MFc0UVBPK3RsMlErdjNnZWZaODZQY25ZMDZvdVRSOE9KZU1EWlg3N3VV?=
 =?utf-8?B?UTQ2a3pRaC90VDZsOUZYa2dXUitsRGtCdG55ZitzVm5wNGFNanRrbW5SYytm?=
 =?utf-8?B?ODJTMHRBZ1FOSy9FL0NWSWVrZHdHS2JjKzZMS2xOSmoyck82Y0daT0dhcDhH?=
 =?utf-8?B?anQzQ1dOOTVBQ3k5Ui9XbXZLYnU0dmFBL2dNTGg5bm9pdzFiVkRrdXNPcG5B?=
 =?utf-8?B?UHVCV2hmMU5qR0Z6cWpmMklJQjhYRkhyVWVyWUdJdjFHbDdmdFlrNmlEdUtk?=
 =?utf-8?B?Zms2Sk0rMzd0NmsydDFMRDZ6Zk1zUWd0NTF6cmJ4WGxMeWdJdzMyZFpjWDI4?=
 =?utf-8?B?c3B2QkJ4aEJ0azFmQWFTS0dNRm96ZmNIN3QrMldnZVVuSkN4TnRneHFDdmxH?=
 =?utf-8?B?bEdGYSt4US9ncnR4RXpSeFRzUHVtSyt3cnkwQTRtWk9FcnYxaC95U1JoKzdt?=
 =?utf-8?B?dG9KVGIraVE2akpMcHIzVXFEYUZ2dlV0REI0SVp2VHhrK1owTy9TSFhBOXcr?=
 =?utf-8?B?M1NIQ0JSVmRZQjl6Nkcvd2gzUkh4VTV6ME50V2JNOFlPcGlObUkzQ2F1Umdz?=
 =?utf-8?B?WlAxcWdrbG52OVA3bGc5R0Y4Yis4NkxNN0UrM251amZ6OWRadUpBSEdiNUhL?=
 =?utf-8?B?c3AyQW9ETjFFVmdVMmxKRkRDbWlONXowRFBvUy83cEZ2ZmxLNXBEbFZCelQ3?=
 =?utf-8?B?RCtoWkxOYXR2YnFKenVrc0swUlNwdStrNy8xbzhEb1h5aEE2ZFZZQm9nVkM3?=
 =?utf-8?B?Qjg0TkZ6bkY5TVVYOHZLS3NoajJwUVRHd1hkZEt6UmYxZUxlaFdnQm1IOGhM?=
 =?utf-8?B?anA3NGE2Wm5NdlhVeU8yZm5taFRYZXcxUThqYkVPMENWa0dNek9vcGF6ZEdZ?=
 =?utf-8?B?YUM5alREMFBHbnNVTHdZL2NGRCtVN0czMnhCMWwwckUxZTlBVThHSHB0SzFk?=
 =?utf-8?B?d0JQMTJic3Z4RkVyclVvVTFYTmVNbUhyd2tteGdKU011TG1iT2wrWnRjSHQ0?=
 =?utf-8?B?bFIwQ1FHTkNKRDVSTTRFRjVQQmRRZ2RBQi9JYjR6dWlackdsMWR4ak1VZnp0?=
 =?utf-8?B?YTBQV3NUUTIxeExiRnhJR0kzYmlNREx6YXROaE9mYjdmRndjR05QNCtLNldJ?=
 =?utf-8?B?L3RITWRQUWVoT2EvR1FwaXlHYXpMaEtLcG8vUStqMmFiYXd6anhxOCtBc3Bk?=
 =?utf-8?B?OFBMVC9jb2pyQjREVFROWmFGRjdMZFo1bVkrSHRxVEEvbDFSRkt4dW5wWFZx?=
 =?utf-8?B?YzA3SlNiNTdGZG1md0E2bWlCb3RVZUlsSit2SVJjcGNXai9CVWkxbUF5OWtW?=
 =?utf-8?B?QlpJVVFZZ3ZjUENKWnFXSFdheFJjWGJtNFFoRHBLMUR2VEVwc3cxNHVxekVq?=
 =?utf-8?B?bk5MUkQ1R3RvWWhmTTR4d1gxQ3pwMzl0Y3JGN3pabExwejZHQWFHUjJUTFNh?=
 =?utf-8?B?MW0yWkQ3cERxZENqZGgyY2pVYkFBNUd2cWw0Y1I0Zzh3Q3p0eGtkMlRzTWlC?=
 =?utf-8?B?T1BLRDM2d0tPaUpPRll3T1RZVm96NUpLWFVoRUlLbUhOTU9XUDNhQ3BOb1ZD?=
 =?utf-8?B?M3g4WnMwU1Vsc0ZIK0dqdmREaWJhMWU3RzdDMGlKYUpPbjdkNDdUa1pWWjBY?=
 =?utf-8?B?VEJzc3lOa011d0xNSWxGL1BCbDVNL1RZV2lnLzVmSWtjUnVDTUJEVVRTVXdy?=
 =?utf-8?B?bkhFY29GRGVNeEJPWFdKdW03TEhuNGpheVQxUk05ejg2a3lYZlFWK2F4TEov?=
 =?utf-8?B?TG1xRzdKZWpVczY4WjRmTm8xcmVwcEZYUTFZeHh4VFhnMVdpT01FOEtDbEVJ?=
 =?utf-8?Q?NPmhhSNO1ntWByV+pAt/nT2v+omPDcC1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFU0QzB4RWZ3MTdKQ093eDdJS1Q1M2JqNVNFaSthQjY1dUdxRDA3OTA2VU80?=
 =?utf-8?B?MGdORmFWck1xSEtpT25xYSt2SjZxTXFtcnBHemxGWnZJMitDUjZ5NWliei9i?=
 =?utf-8?B?RnkyejZlMEpaeDA3NU9TdThsa0dSMEFpUkpRV1UyRTZ6L1ZaZnBGNHEwZW8x?=
 =?utf-8?B?M0lCbHZJajZxMWZOVzlkU2F4cllsMm5BTUIvU3VsT1NRU1RzYSsyZWZsQ2NN?=
 =?utf-8?B?TFZuZjFXc3I4Qnp0eXpXdnNtS1JkdkdiS05BTVhxUjduSmo4UmZMNHFvQWV0?=
 =?utf-8?B?bStDNTZSY3RpaEhwM24zRlo3NENlQVhUWmgrc3hIU3d0SkdCMmlTS2p4a0hM?=
 =?utf-8?B?b1lJUWNEdmxkUzlNbnBJY05ZYlVLc1R0dEJyeHRoWEVwem9xNjdLNzRHWVVU?=
 =?utf-8?B?WXpMZnRyb3ZvdVc2QUxsdGFqbkQvc2g3Y2RVdnh2NzhIL3JYTVVPdkZJZUFq?=
 =?utf-8?B?S0JaMTBYN2ppUTZDbjErdUtIYjhwZXNvOE5SQ21DZys1NURBZWxVWkdsakZz?=
 =?utf-8?B?M012Y1FpcGw3cmR0RkYrTE1RL0w1OHBXRWdZVDIxdzArMXhZUHJ3dGFDenlT?=
 =?utf-8?B?NGY0QVo2LzdVZTFBN0ppc0VKTE9LWGVjV1JpbDcyQ1Fxd1d1OWszVjlkc3VC?=
 =?utf-8?B?R3VZWFpRQWVUWFN0aThRSkQrS2l5ZWluMHExRzJOd0UvbzdTZ1hGQThoeFJz?=
 =?utf-8?B?dVBXOUFqMXM5T1FOSmc0T3F2cUlnREJBbTNSQmpWM1NlZG1QRFFHaWxqOXgv?=
 =?utf-8?B?TWZmMEhNVFJrWnB0ZnJFeWF5OUF0czlYV05TTVdxYmowZlRuYmJYV3N5eWZp?=
 =?utf-8?B?WWhiNXZ4QXBFOHV6VmJTamowdXZ1Snh5UHdmbjBnbHVHNnVuclUxYU43cnFM?=
 =?utf-8?B?K3l6U044WlhiY2R0R3NONjFiVHAvSmkxaW91RkRmS3NWc3lIK3gvWnVvRGF6?=
 =?utf-8?B?K2U3czlkUGMwSkJJUzZUYWhTMW9PcU84dGtWL0UrVXBUMFpMK3F5ZW9PR2Qz?=
 =?utf-8?B?SmZoeXY2Q1pUYk1NSlVwYS9wYUVTZmFsamMwdklXc25iNUEwVUx3Z1B2S0dk?=
 =?utf-8?B?cmIvZTFmZm1rc3hNbkQ2QzRkZTh1NllHWFhQUTk4aFRXS00xd29vYll3NXdi?=
 =?utf-8?B?OEtWZGJtQTJrcis3eWdSc0pNaDJqM0I5Y1Z5dlpFSXVtT3BVWWpUeFIyYUVo?=
 =?utf-8?B?R2p5bWVDaEtvTW9TNExmcTF6YmFKTTNQQWs3Z2NCQ2lXZG1Oek5KSkRVaTdL?=
 =?utf-8?B?MFQzbGhWYVN6ZlE2U1lyYlNWRjJvNVpIVVlnZkpFVm45ak1CTWJ2U0hSK2Y4?=
 =?utf-8?B?MUxQT0JqVEE4dFNkUE8vcjNlRkFBc3ZFVUJ6bUZZMEF5bXRla0EzOXphRTRi?=
 =?utf-8?B?Tzl6a253SngyaU1zaWVYbFdRNk1rQmFVbUlsMmxIaisrcmg2MTF0UXJMMW90?=
 =?utf-8?B?NHZBMDFUMDZrbHNWMTJLVTI1emkyeVpGMTBDaDRzTUNtZlMxQXZCOUFLYUtv?=
 =?utf-8?B?QnhjdEx2M3duWUM3ZWlTSGhoMmNZSWFocUF0Q2FGSEE3RzJaY3JBL0FuVWpo?=
 =?utf-8?B?dnora0JZYUN5cUZ2WU9DVHRkVGlpYXZtcVVVTmpaWWxBcjhuTWdPR0VOanFW?=
 =?utf-8?B?NkUxdkc4bE81QzhOZG5lTWRvUHpLU3FidVJzSXVUamY3djduajBDYWZ1VGtR?=
 =?utf-8?B?cFlyMU5zcjRTR2ZMeTJIOTJYMXBYWjUrbm1NKzNwVGNYZXhKV0IzVTdXeFhu?=
 =?utf-8?B?cHoxSk5ZR1g5SU9xNmNpZ3k2UTRZTjZVWElVQ1dPa0l6TWpwaGZMN2ZQN3Ix?=
 =?utf-8?B?NG1DV3h3VFNVeDFPR3NoUjNoaE1FLzBLd1k0b0RvMG9JSmNrU1RrdEI0RTlN?=
 =?utf-8?B?WDczMTN5MHMxcTRFZURnaDE3RzFjVDVDeU5nZmNyVWZzeHN6MUw2dGI0cjNm?=
 =?utf-8?B?YzM1YVMyMEgyRlZDcSszd2w5UHpaQVo5VHprTFFHd2hzRERVY1phcEJ4OElr?=
 =?utf-8?B?a0l5WVZxbEVNazhOYTNidERta2ozY3NhRUg3MUZtUjhiMWNFaDhnZXZsVW5E?=
 =?utf-8?B?NUxHY0tTM0NIQWlDY2d0WTB0L0IzMkJ3Y1dFcnF3clgrV29MTGN5Sjg4Tktr?=
 =?utf-8?B?dVJkRnVDMDRtNWh0YmF2WG1tTFFidi9lSytIL3FFYXN1cDRTRFZwSEJWalVK?=
 =?utf-8?Q?o57RnV0iUyqYAwKtq3ZzH3w=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a4c5a8-80b8-4f8e-6fc5-08de2c106e0d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:50:21.1687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk0L9M5ec/Mil3l5fXZXupuoxzM3QobEoth7qT5EPSXZPwG2HWdR9NqpxD5T2fbkSCqI/hnD4/3ZUrGQeFsh9QRs/bqq4mLd2xuMqJKMdyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11545
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

Hi Marek,

On 11/24/25 8:40 PM, Marek Vasut wrote:
[...]
> ---
>   test/py/tests/test_fit_auto_signed.py | 98 +++++++++++----------------
>   1 file changed, 39 insertions(+), 59 deletions(-)
> 
> diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
> index 0b5dbd5401c..3895e7d9369 100644
> --- a/test/py/tests/test_fit_auto_signed.py
> +++ b/test/py/tests/test_fit_auto_signed.py
> @@ -138,6 +138,29 @@ class SignedFitHelper(object):
>   @pytest.mark.buildconfigspec('fit_signature')
>   @pytest.mark.requiredtool('fdtget')
>   def test_fit_auto_signed(ubman):
> +    def generate_and_check_fit_image(cmd, crc=False, simgs=False, scfgs=False, bl31present=False, key_name="", sign_algo="", verifier=""):

I would have grouped variables for the same "theme" together, e.g. 
simgs, scfgs with key_name, sign_algo and verifier for example. But 
that's fine as is.

> +        """Generate fitImage and test for expected entries.
> +
> +        Generate a fitImage and test whether suitable entries are part of
> +        the generated fitImage. Test whether checksums and signatures are
> +        part of the generated fitImage.

Would be nice to have documentation on what the parameters represent and 
what this returns/raises. Not a blocker though, I see we already don't 
do it for other functions.

> +        """
> +        mkimage = ubman.config.build_dir + '/tools/mkimage'
> +        utils.run_and_log(ubman, mkimage + cmd)
> +
> +        fit = SignedFitHelper(ubman, fit_file)
> +        if fit.build_nodes_sets() == 0:
> +            raise ValueError('FIT-1 has no "/image" nor "/configuration" nodes')
> +

Only downside is that this exception will be raised with the same string 
for all callers. We call it multiple times in the same test so it might 
be difficult to identify which one actually failed. We could try..except 
the exception, use the content of the exception with

try:
   generate_and_check_fit_image(...)
except Exception as e:
   pytest.fail(f'FIT-X failed: {str(e)}')

maybe? (NOT TESTED!)

> +        if crc:
> +            fit.check_fit_crc32_images()
> +        if simgs:
> +            fit.check_fit_signed_images(key_name, sign_algo, verifier)
> +        if scfgs:
> +            fit.check_fit_signed_confgs(key_name, sign_algo)

This is a typo.... that already exists in the code (confgs instead of 
configs), so "fine".

Mmmm, we should also verify the signature of the configs, but it's a 
TODO in fit.check_fit_signed_confgs(). Maybe someone will implement 
that. I think it would be valuable as I would expect most should be 
using conf signature instead of image signature for added security 
(though I haven't found articles about that but I'm sure this has been 
raised a few times already).

Checked the diff and it looks okay so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
