Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23012D3B985
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 11:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746F68960B;
	Tue, 26 Nov 2024 12:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAn1WzW9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07CD89691; Tue, 26 Nov 2024 12:19:54 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D6A895F4
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 12:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqBzdJVYxiGA8X4D6cGtc1Cj9nw4F0SNv1wjI5odTWRthQqCSrwkbPdNXDVP7cNrx4ep+gvmv8hZnh2f+R9jSMAnd040BuzV+gSuXwIq4hxM2XGqdehoFllMZwXVl+/yUUZ2QIwwePxOOWhTvN9mcuT/lSv41tpTBiwpopCqi6E1zyjB6NuWpOS6Gtyy2FD6Nc8SY2YwazHeot/FZLgzKBsAX2BcoehHIBTUH6EQhHIg6RuUWUff1/LQRUUNRDyYIxKZH1zI867LIULPs2l7vI/KoLGBAKNzNc7bfS/wMqIAkrOIfbFLup/11UU5B/ZHn/K5n6GwU1G7k7ZaLxsIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKJEl8bLzbYVqPwxP58W/PdGSFYu+MDfk4Qpd/cbcC4=;
 b=qLIwaRg+lQj2EQ3Yu0yokjgob2v/A3F6qT6tX5IrnMWvkbSpmFGxoiuwvwAPx5pHpt+pkh7wKTqOL9Sm3/+j2ImxOsYNCRjRBCWqwdNqAqwHnqmZICTLqYDYxhmiqjtKlkMYVpnsIApLY3mtTD2hGeolp8I5uz3bht0tcStm4LDlcWoc2teSS/vJJIIRPEYi3xhgwST1nl17+1LEncNjxSRkAwCi5H9Q1KW+i45OQ65Alc/FuouLsDhc1AflQppnT00mexqNNffuGzGL9VbJCQJKPqgCLwYlM403FfpnSutS2sVQjj1bkjTUUwbCIFyOe0DN9239iWJ7USMWEciCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKJEl8bLzbYVqPwxP58W/PdGSFYu+MDfk4Qpd/cbcC4=;
 b=pAn1WzW9cQkz7PS2fa82Tgc7RCr+/p88pBEtIQkoRRCKqkP6r2fA7GKME//W/o3spyvx7QpRbcAPeSae6Gkx4GE+fjushiG1O97lW/fTnAJ8zN5Y52CY8Bvmm1mSAhCUSXZCQ+UufttwV7fNNl3fL175yOQNWMspHb/BL21U0JE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 11:19:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 11:19:43 +0000
Message-ID: <77f605d9-43c6-473e-960f-6ab58dfc79e1@amd.com>
Date: Tue, 26 Nov 2024 12:19:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
 <20241125180847.GK3600562@bill-the-cat>
 <ad58b032-f618-498f-8cce-f13d0f6d6021@amd.com>
 <20241125184824.GL3600562@bill-the-cat>
 <8b3eaf58-4e5d-4d6d-ac3b-a4fb57568473@amd.com>
 <9adc2b2d-6d89-4e4c-851c-8817b7d291d9@canonical.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <9adc2b2d-6d89-4e4c-851c-8817b7d291d9@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0212.eurprd07.prod.outlook.com
 (2603:10a6:802:58::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fe4c42-6bf8-4a72-05b0-08dd0e0c3a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFZxWC9TMmwrUVJoanpMQ1hLNXFoYTc3VnF5eFg2WFhrbkVNeUdzM0cvbElj?=
 =?utf-8?B?QUo1ZlFva2RTUWRDQkFGV1Z5L1kzUDdWMTNwYk05SWZuSUJScS9kMlZuWkly?=
 =?utf-8?B?WWFuUkpTMERKMFVaVGx6dC9helVkOU1LK3VrQnZudlJaU21UWkgxVjVuNGZR?=
 =?utf-8?B?RDRmZ3d5MUxhNnFiUEdvRGpaL2FZTVd4U3BxNGVRdURkWEJsUEhYSVNsRVcy?=
 =?utf-8?B?M0JiTGd3K1Z6SGxreHpUWG9hbS9yeVowZkpGcmFXblAxNDRjeFZNTCtlTXVs?=
 =?utf-8?B?MEVXUE1LQnFCTmx3Q0Mrc0c1ZlY5Y08vRWpIRTkzUDdGc1JHbUgvYjlIU0JC?=
 =?utf-8?B?YkZOQlJmTXBNZWs4ZXpNOW9xbzFRdmdST0NreVk0bXNEQzJqd0M0bHRrNDNl?=
 =?utf-8?B?K2VWSUkrNlFYMnRoVmpDVkR5NWJPU0UrbEZSV01aVkgwOHprKy81UElyZDNO?=
 =?utf-8?B?UktPZG9ER3JTZEJZcmdPNDRIZ3puTVZQcE9RSnN6YUdaaGhHMWl3WGJOZXhI?=
 =?utf-8?B?Sko0bkJ5ZUFCbzRxTGk0UVZ5Ky9BQ01pMWZVQm1PazNZVnRhWkVLd3h5UXVl?=
 =?utf-8?B?YS9pWlBEbGExdXhtL0ZQVDBCWDBYQzNYWnB5ZTlXdmlFalJJaVBaQytEQTMw?=
 =?utf-8?B?dnkwaCthRDJSTFA0MDV1TjVpUVJHWWdQbERzN3hEV0xUUHV5OUVibGdySEVQ?=
 =?utf-8?B?eUVCVmlMWS83cjNtbEZFQ0RNdDc1VG1ndGRMVFQxNS93WCt5N3BuN2M3OXli?=
 =?utf-8?B?UE9iWDNtSk01YUx5TlV2TEdPVTdHTnRGVXlPbk1rbm1aN1lZSW9DeExocGpu?=
 =?utf-8?B?bmIxZkNFU1BQY3JWMzc0UWNzalhKTHl6MTYrOFh0MVlvamlzT1NGL3Y1WENX?=
 =?utf-8?B?T0VoMXFRdnZ0SE5GbmM5M3haUFUxK0wzaDZseW5mUHpQb2g1MHNSMVZqczZi?=
 =?utf-8?B?emVPRDZ0b09wZ1hZTC8vcngySTJLc2FOdm52NE50akl1Sjk3YmlpZzUvWHpD?=
 =?utf-8?B?L2NMRkRIYmhSRmpyUnFBUTV0cG01R3JhZmtkTkgzRHB2U1hZUWw2WDhoWjd6?=
 =?utf-8?B?dEV1OC9CVENwdWhkV3BBcyt4SlVoZC9wcXU4VWlFdkp3MDJtRHFzZlpVNEhH?=
 =?utf-8?B?VmhzckRLOWkrNXNxaVR4bm9HMFhNRWZvNWlhTWVZTlJ3U013U082TU5Jak5V?=
 =?utf-8?B?SmNCOVh4WTJEK1U1QnJ0SXpWMVUxaVRvWnBub1kxTjFxZXR3cFhBUEVPRHNj?=
 =?utf-8?B?b3ZXVjBKd2s1K0pMOUJsNnN6L3lsMTRTMmQ4RytQQjlGdlRIQzZkWWxPc3Jq?=
 =?utf-8?B?TlUvcnN5d3lTTDFxYW81YVhjbUMxbjc0a0ZMejVvQVk1R0JhMVFMbll1K1Yr?=
 =?utf-8?B?ZHBLUU1lZWFndW8zOTJDcGVVMk1xelJDeDlvcG5aa2xyWU40WFErbkQ2MFlk?=
 =?utf-8?B?VXdyaW1xUHVXYkYxckNoQ0w0c1lhcFE3UUJOOEVUK0hGYnp6amc1Z3crYXlz?=
 =?utf-8?B?aEVFek1hbDUxcFBQOGE5bGlHWUVSTlpYV1ZqNnF2dWpwb2FINXRoTkxOc01I?=
 =?utf-8?B?SmhqYit3VUxPWlFJV3dXSkhCOWpLSldvTktlTXpJcTFvdGNmSmZnamZDRndy?=
 =?utf-8?B?Wkt1Y3FFWkdpK1dPb3F2Nm9rZkk3QnR5bHJETW9CU3ltQWhIYVQ5ZGRsZ2dh?=
 =?utf-8?B?REhicjNrR1VXdnF3UXpKNW5WZGltOHJZbHAvUVlIRmNHQUNGTFVNREZSdzBV?=
 =?utf-8?Q?RzWYfvQ7zrDFdawiaQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01mYUVrMXpCMlM4S1RWWmlXanlwejhHaHc3Q3NQVEZEaHhOMFl1enREbC92?=
 =?utf-8?B?QVI3S0l5bnRMY0hMaVNicFoxTUxUaUtmLzJRUDR2QTN2RnNwMXB6aFRoU25F?=
 =?utf-8?B?bkdzaUVuS2dDM1BVdmRRb01rTWxXS3ZMMjR1NEc1cy9XRjU4ZkJIZy8va2Q4?=
 =?utf-8?B?YlR2Q0hCUklEa0hXR1FQaWlhcDBRNG1VV1RLN2VBWDR3VzFOc29hTlpDZGhx?=
 =?utf-8?B?Y1RUVGl0Unc5cm9ZQzZIYURVQmZPcm10Z05qbS9lZmtTd1U3QnRaRUIzZEto?=
 =?utf-8?B?VWwrNDFyeFZRMEFCVXd6TnNOenNocTV5K3hGSE9SMzdHR3ZkZjhsa0YwTkU3?=
 =?utf-8?B?MGF5N3dQSkZVdmwrTW5xLzlSOG51cUthTitQMXhwZTIrd0hKUUJtNEIvYkIr?=
 =?utf-8?B?aCtNS1l2U281enkxRnV2ekRqRlAvSHBlWXBjOU40Sm5zeG51ZTgvL3RKNm1n?=
 =?utf-8?B?V1VJcEovWHVSd3RRZkVHTHBYSDJCVm5qZGErbEFCakUwWXRyRHJ4ekMwZ0xt?=
 =?utf-8?B?cUdSVDlBRDJPeno3K2ZiVE4wTHhSempwR0FIbEdGR0wyOE82U3hTc1cwWGpm?=
 =?utf-8?B?UUtmOHoxTUo0WkpsaDFxeVQzbGVScVk3T1JVYXJhak9OR2tOcGMwTHRGR2pu?=
 =?utf-8?B?VmtPNW44MXJBU01uV2lxYVA0bGIrOU1qUno5M05ZOHRWbUJBei9CWURJNXcw?=
 =?utf-8?B?MmdWWDAwblBlTXJuUkFmMkpId3lVa21QbXlmbllXZnJCRGVqTUlMWVM5NGl0?=
 =?utf-8?B?UnE3eUxPeHBIVEhnV25mcTFHNHdFaDJpMCtBdlJxek05MExXOVRVT1VLWUl1?=
 =?utf-8?B?cXJGbnAwSTN3amUvR0pQV2FPYnpoNXBIOEJQaUNpUXlBRkhCRzFHSitZRWx4?=
 =?utf-8?B?eC9tT2tmMHVncjBHQzY0WjI3dEI2dEV1UXhQNlhldjZLNEsvdXZHM3lFYmox?=
 =?utf-8?B?RDZNOGNrelo5d1RxYW50cFAzcmh5Mlp1eFE5aktoN3hUdFBGK2FGVjI5R0Rr?=
 =?utf-8?B?ZjV6US90VmlMOEkycGx5YmhGK2xxcVl2anpBYmVrTmJ0RTZLQ3p3Q0lZeXcz?=
 =?utf-8?B?V1NTWVg2S1NHeCtvZTFpOUVwSEY2QzBqdWpkSUt5VGdHUnd6ZUZ2VTFCM2NO?=
 =?utf-8?B?ajlQampIeUMzOGdiazNpbGJES2FPSlpCZ25qWGorNERKR2xFWXRHTkpNU0gw?=
 =?utf-8?B?VzZ6cEJBMnlOS0tNRC9ncXhCaERrV254ZmVlMktBaVI4OENuNm8zVmlXeG5u?=
 =?utf-8?B?dnJuUFV3NVRNOHFwU0tWejJjVnVNLzBMZHVvTWVQTjR0WCtubGJFUW5vdUJ6?=
 =?utf-8?B?NG4xV0g3c2tyQWVpUHBYeVYxWmI3QjRDOTg5MnJNdzRlSUZqb3p6SGZ1SUE4?=
 =?utf-8?B?MFlTMHFJd09SbHBOSEdWMVdJOHAvYzRnazhuUUIvTTBNMlprQlhPeExVcE1x?=
 =?utf-8?B?YW1XTHlkNVZqUzhpSEFWK01vMHA3M0tKL0JWd1E4a3pwSVJYUTNvem5GcGpN?=
 =?utf-8?B?K3BVZzk3azVhaVAwMVV2SGRiZlczODYvK3ZRNjE4RUM3VlBIbjNyaU5IU1Qv?=
 =?utf-8?B?R0s2b2pWTGE4clkvYUxPV0F3L1BIUC9JMCtORUJjd2lXcHZaQ0tRc21PdWxF?=
 =?utf-8?B?SjVxRzR3WjhZTFMvc0kxOWF5QnRSRFFteUJScGVQdlNrTEZZTTU4V25BV2ti?=
 =?utf-8?B?QTFkemlBNThwK1VmcGM5L1NzT0dEZDlPNG80RWJuMThqd3BvZ2J5T2hZQWlS?=
 =?utf-8?B?RERlam41YUVtYVlOUUlYaWdHb1NydmQwNkRKWXZ6WG9sZkhCZ09nWEZ4b20r?=
 =?utf-8?B?Q2wxK1hpd21qTGtTODkvYStMWm5nRFJTN2N1cXFJQXlnaEJIYTdFSkZ4THJ3?=
 =?utf-8?B?S0R2akk0WllNMWZxYjZGaXlhcEh2NmJsbHBlZ2QwTXRCOHo3M1U1VnRac2tY?=
 =?utf-8?B?VjRBb0JDb0FFVUtUakw0dXRyTGJEa1N2aWluVzlZQXVWc050Z2piSXljRGRJ?=
 =?utf-8?B?RDk0a1RMOE1oTVJOVXdkakFqRWZrTUNnMjR1aVVMU0plZlkvdlRRM0xQaFVE?=
 =?utf-8?B?L1ZjWHNWeC85QWJNNXFDR3V2SmRPalZYRXVWQ3oyd2J5STEwdVE1MVFZU2M2?=
 =?utf-8?Q?eWZbxqy8F+WFZxTtqNGvtIk5E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fe4c42-6bf8-4a72-05b0-08dd0e0c3a5b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 11:19:43.8877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crOYljAYzuiLdiYOlI+koPbI1aL01cmkdXkLcaSs1RcDx2NXHPqyUzrKscbylHNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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



On 11/26/24 09:34, Heinrich Schuchardt wrote:
> On 11/26/24 08:57, Michal Simek wrote:
>>
>>
>> On 11/25/24 19:48, Tom Rini wrote:
>>> On Mon, Nov 25, 2024 at 07:44:15PM +0100, Michal Simek wrote:
>>>>
>>>>
>>>> On 11/25/24 19:08, Tom Rini wrote:
>>>>> On Mon, Nov 25, 2024 at 07:03:41PM +0100, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 11/25/24 11:35, Heinrich Schuchardt wrote:
>>>>>>> On 25.11.24 11:02, Michal Simek wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 11/25/24 10:21, Heinrich Schuchardt wrote:
>>>>>>>>> On 11/25/24 09:32, Michal Simek wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>>>>>>>>>>> The CI uses the following command to launch 
>>>>>>>>>>> xilinx_versal_virt_defconfig:
>>>>>>>>>>>
>>>>>>>>>>>        qemu-system-aarch64 -M xlnx-versal-virt \
>>>>>>>>>>>        -display none -m 4G -serial mon:stdio \
>>>>>>>>>>>        -device loader,file=u-boot,cpu-num=0
>>>>>>>>>>>
>>>>>>>>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
>>>>>>>>>>> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
>>>>>>>>>>> relative to the register start address 0xfe20c100.
>>>>>>>>>>>
>>>>>>>>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>>>>>>> ---
>>>>>>>>>>> v2:
>>>>>>>>>>>       new patch
>>>>>>>>>>> ---
>>>>>>>>>>>     configs/xilinx_versal_virt_defconfig | 2 --
>>>>>>>>>>>     1 file changed, 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/configs/xilinx_versal_virt_defconfig
>>>>>>>>>>> b/configs/ xilinx_versal_virt_defconfig
>>>>>>>>>>> index c8f166c1221..06a240173ba 100644
>>>>>>>>>>> --- a/configs/xilinx_versal_virt_defconfig
>>>>>>>>>>> +++ b/configs/xilinx_versal_virt_defconfig
>>>>>>>>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>>>>>>>>>>     CONFIG_DM_USB_GADGET=y
>>>>>>>>>>>     CONFIG_USB_XHCI_HCD=y
>>>>>>>>>>>     CONFIG_USB_XHCI_DWC3=y
>>>>>>>>>>> -CONFIG_USB_DWC3=y
>>>>>>>>>>> -CONFIG_USB_DWC3_GENERIC=y
>>>>>>>>>>>     CONFIG_USB_ULPI_VIEWPORT=y
>>>>>>>>>>>     CONFIG_USB_ULPI=y
>>>>>>>>>>>     CONFIG_USB_GADGET=y
>>>>>>>>>>
>>>>>>>>>> NACK. That's not the way to go. If one test is failing in CI
>>>>>>>>>> disable that test not really support which is for HW too.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Michal
>>>>>>>>>
>>>>>>>>> Hello Michal,
>>>>>>>>>
>>>>>>>>> It is not that a single test fails. USB is completely unusable
>>>>>>>>> on the board. 'usb start' leads to an immediate crash.
>>>>>>>>
>>>>>>>> I am not applying any patches on SOM with HEAD and usb is partially 
>>>>>>>> working.
>>>>>>>
>>>>>>> Don't you see a crash when executing 'usb start'?
>>>>>>> What QEMU are you using?
>>>>>>>
>>>>>>>> I can agree that it is not super stable with upstream only patches
>>>>>>>> but that's different story.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> The problem already existed in v2021.01.
>>>>>>>>
>>>>>>>> Any log?
>>>>>>>
>>>>>>> $ git reset --hard origin/master
>>>>>>> $ make xilinx_versal_virt_defconfig
>>>>>>> $ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
>>>>>>> $ qemu-system-riscv64 --version
>>>>>>> QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
>>>>>>> $ qemu-system-aarch64 -M xlnx-versal-virt \
>>>>>>>    > -display none -m 4G -serial mon:stdio \
>>>>>>>    > -device loader,file=u-boot,cpu-num=0
>>>>>>>
>>>>>>>
>>>>>>> U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)
>>>>>>>
>>>>>>> CPU:   UNKNOWN
>>>>>>> Model: Xilinx Versal Virtual development board
>>>>>>> DRAM:  2 GiB (effective 4 GiB)
>>>>>>> EL Level:       EL3
>>>>>>> Core:  32 devices, 13 uclasses, devicetree: board
>>>>>>> Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!
>>>>>>> MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
>>>>>>> Loading Environment from nowhere... OK
>>>>>>> In:    uart@ff000000
>>>>>>> Out:   uart@ff000000
>>>>>>> Err:   uart@ff000000
>>>>>>> Bootmode: JTAG_MODE
>>>>>>> Net:
>>>>>>> ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
>>>>>>>
>>>>>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - 
>>>>>>> 5e:f6:37:a3:68:24
>>>>>>> eth0: ethernet@ff0c0000
>>>>>>> ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
>>>>>>>
>>>>>>> Warning: ethernet@ff0d0000 (eth1) using random MAC address - 
>>>>>>> 5e:8a:ec:a9:d7:e8
>>>>>>> , eth1: ethernet@ff0d0000
>>>>>>> MMC: no card present
>>>>>>> MMC: no card present
>>>>>>> Cannot persist EFI variables without system partition
>>>>>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>>>>>>> Missing RNG device for EFI_RNG_PROTOCOL
>>>>>>> Hit any key to stop autoboot:  0
>>>>>>> Versal> usb start
>>>>>>> starting USB...
>>>>>>> Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
>>>>>>> elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
>>>>>>> elr: 000000007ff17fd8 lr : 000000007ff18940
>>>>>>> x0 : 00000000fe20c100 x1 : 0000000040000000
>>>>>>> x2 : 0000000033310000 x3 : 000000000000003f
>>>>>>> x4 : 000000007ffa74b0 x5 : 000000007c112880
>>>>>>> x6 : 000000007ffa74c0 x7 : 000000007c300000
>>>>>>> x8 : 0000000000000684 x9 : 000000007bda668c
>>>>>>> x10: 0000000000000003 x11: 0000000000000188
>>>>>>> x12: 0000000000000000 x13: 000000007bda6be0
>>>>>>> x14: 0000000000000000 x15: 000000007bda6224
>>>>>>> x16: 000000007fee9244 x17: 0000000000000000
>>>>>>> x18: 000000007bea6be0 x19: 000000007c111b48
>>>>>>> x20: 000000007c111240 x21: 0000000047822004
>>>>>>> x22: 000000007ff998b2 x23: 000000007ff998e8
>>>>>>> x24: 000000007ffd4514 x25: 0000000000000000
>>>>>>> x26: 0000000000000000 x27: 000000007c111130
>>>>>>> x28: 000000007c1110d0 x29: 000000007bda67b0
>>>>>>>
>>>>>>> Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
>>>>>>> Resetting CPU ...
>>>>>>>
>>>>>>> resetting ...
>>>>>>>
>>>>>>> $ cat u-boot.map
>>>>>>>     .text.dwc3_core_init
>>>>>>>                    0x0000000008068f24      0x6a0 drivers/usb/dwc3/ core.o
>>>>>>>     .text.dwc3_of_parse
>>>>>>>                    0x00000000080695c4      0x310 drivers/usb/dwc3/ core.o
>>>>>>>                    0x00000000080695c4                dwc3_of_parse
>>>>>>>
>>>>>>>>
>>>>>>>>> Do you know of any QEMU/U-Boot combination where USB ever worked on the 
>>>>>>>>> board?
>>>>>>>>
>>>>>>>> Why was this visible in CI in past and why this pops up now?
>>>>>>>> What has changed? I don't think there was any change in QEMu
>>>>>>>> regarding USB but I can double check.
>>>>>>>
>>>>>>> We never started USB in the CI.
>>>>>>> With patch 6/6 of the series usb_bootdev_hunter() is invoked which starts 
>>>>>>> USB.
>>>>>>
>>>>>> Did you push this to gitlab CI? Which test/py is failing there?
>>>>>
>>>>> Er, we don't do "usb start" in CI yet, is why it doesn't fail there. Or
>>>>> are you suggesting this is a QEMU problem ?
>>>>
>>>> This is where it is failing from dwc3_core_init().
>>>> dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
>>>>
>>>> It means it is likely qemu model limitation.
>>>
>>> And since this is for the virt platform, doesn't it make sense to
>>> disable it until the model is fixed?
>>
>> If we are talking about CI it is about pytests. It means we can simply just 
>> disable that particular test which wants to call it.
>>
>> And I can't see any issue in CI when this series is applied on the top of rc3.
>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/ pipelines/23565
>>
>>  From my perspective make no sense to remove usb from defconfig because it is 
>> used on real HW (we are using this defconfig for real HW).
>> If there is any issue with USB then we can just disable USB in CI only.
> 
> Hello Michal,
> 
> Thank you for the suggestion.
> 
> Overriding defconfigs in the CI is possible. I am currently testing with this patch
> 
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/commit/ 
> f1980dd387b77200a987c50c4856c3b52df664c6
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 4ecf76eaa0b..bac577ec008 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -511,6 +511,7 @@ stages:
>             TEST_PY_BD: "xilinx_versal_virt"
>             TEST_PY_ID: "--id qemu"
>             TEST_PY_TEST_SPEC: "not sleep"
> +          OVERRIDE: "-a ~CONFIG_USB_DWC3"
>           xtfpga:
>             TEST_PY_BD: "xtfpga"
>             TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 2164ad79a72..714284a56df 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -508,6 +508,7 @@ xilinx_versal_virt test.py:
>       TEST_PY_BD: "xilinx_versal_virt"
>       TEST_PY_TEST_SPEC: "not sleep"
>       TEST_PY_ID: "--id qemu"
> +    OVERRIDE: "-a ~CONFIG_USB_DWC3"
>     <<: *buildman_and_testpy_dfn
> 
>   xtfpga test.py:

I more think to do it via u-boot pytest hooks like we are doing here for 
skipping tpm tests.

https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py?ref_type=heads#L1

It means if this is any EFI test there should be an option to disable the whole 
test.

Thanks,
Michal

