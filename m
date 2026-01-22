Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98C1C44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 07:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6F483AC5;
	Thu, 22 Jan 2026 08:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AxJD61MD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7776783AC5; Thu, 22 Jan 2026 08:09:49 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49EDD80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNNQSmM6CiVlbPvPBRjGvxKMZK4BkZMSqMACdLroFS9Ug53nH3N2L1gNI1sJMFksDE2Cf8jB0cFcs/rtprNqlHgJpPicZ9SKn9tNnvu8Da0HtfOJGdsonfOYiCn45Q6JXz3ZwhOnYXSaqaNEoiVleT9wUdTRSiOICObYdZP1rfd0adUmofdaIKHJ/ZDC68oEPKwZNEOxoBPQjFxULDClQ/Vcnbb3tE/M++t+bk4D3iW4O8uP1zsAxA7TQIX9k+DnrxzgxUHrOz7uRSZDV5Q0a/YvUcNvAcX7iSxPvoLc6FgyeEWPI5+5Pc3ohaBKXhcSpa+cFhlLYxnnkhO30gDPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hQTuz2A9fSHDeGsTZIZHK6Aa1xZb11TWuKFXZ/8lkc=;
 b=e1c+f7UXLjDeHuyZWtQcw7a6Wo+C3OXcnSh2bE0Ni/FTVYxeDRu6FY5XG6NhQjn0+5bVXOhna0YS5rfIzHysyzv3tCAeM9s3n4X3lLyiQ33uuSKhfRMUYFzzg/XDoo5U/tyUQf0V+jebAJQetgH6P4eMMO9JPoboOnEocnZvVX8SkzHD4o+EN2mPM2jqbKYec5AvwPG+sIrfBEISkOgFavz6+oSbIyvdaz0IKiaDnwhlyofjDEmcfOffmSXgiaBarry5BPkt//XNW0Qv6IWbG/XXVAfVLWmOVWGxOP8FmujQgsdPntcq2WnJLrScYQxShItncl6Oq50SxWZrzZBDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hQTuz2A9fSHDeGsTZIZHK6Aa1xZb11TWuKFXZ/8lkc=;
 b=AxJD61MDcoXmqcI13JIySZf1dLRrmbW8kVWZx7lw5PAq2OM4lYF3I7K4DjKcfV45YU83b9zertA2UwETOcgGyduYLgjIAMhY4mSMtvfXdsGM+g0yH5sWdHfMMGjb7/QfXqVz4jrqD6w0jBowkd8pJ7WNHSqYv2zMRB0/mOzkQoq+3CbmXQ+lk/QRoSs8xA3Gh4v4cP1OiJ124jxH1ms3FyZI5vYSHXQMClOoE1qBPwd7Awznu5RU4vfzmWo4VdK8s9MPOMQDtdh2DHaE43ByYOEiXDqC3we3z06+5TJ9t75kRA1TbnYLsTOH8rhjTf2v5Etk9FNpDQQfuarMCGOI2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 07:09:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 07:09:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Julien Stephan <jstephan@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/3] Fix compilation issue on regulator_common file
Date: Thu, 22 Jan 2026 16:24:01 +0800
Message-ID: <176907022014.3206735.9395382067925603753.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115-power-regulator-fix-compilation-v3-0-08b329543e13@baylibre.com>
References: <20260115-power-regulator-fix-compilation-v3-0-08b329543e13@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c765f06-a4ac-49c2-f64f-08de598538e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2Q4U1RpT2dWSHFjU2s1cG9jMFpreWladVg4TWcrMC82Q1ZaQkN5SldEaTlX?=
 =?utf-8?B?L096cWp4aU13T0EyMVpzamxKMTJiQ1JDYzFRZ2l4Y0d1Zk03d1NrNWZPYWhp?=
 =?utf-8?B?eHlKRDI1S2JZem91aGNvMTAycWJURlY3UjFIRmt0OTZOZmxQQUVCbHZCeFQr?=
 =?utf-8?B?NFBRdTlaU0lTUld5d3cySUN5MUJEbXkxQ2N1V3JnUEltSGxoNUh2QndTV1Vt?=
 =?utf-8?B?TmlsdVREbGRJUG05L1lxYU91UU0rL04wYnV4VkJrMVZ2TTBSR0VtT1V4UEpY?=
 =?utf-8?B?T2FEMkNnSzlvdkhzZXF6UWhOYUtxV2JieDA3Z2JDQXgvOTkyelVUWkVCYjJ4?=
 =?utf-8?B?SUVoYVZTYzN2Sld1ckY2K3pQblcyMW5pVkdOVTljOTRQSTh1Z1dacVA1cmEx?=
 =?utf-8?B?cXdBRkpuY3dqS0V3WVM2WlhvbDNPMUFvUmVmVTFXVnR5akhJM3dBN0tscjNB?=
 =?utf-8?B?K0tnR3FYZnYxQkpoc2krbTl5MFQxS2dFWVVtYVZiNWROdnZYN3VFKzBnL0JV?=
 =?utf-8?B?bVhVY0hIdlZ1U0FEZWdaT0xlRUJUV0hZbExYT0lMLzdMWllDeHdyZUVkVnUr?=
 =?utf-8?B?azhRMWdTZSt0ZFUxRXVib21ROUNsc1ErdG9udjN1S3RlY0Q1VTFveFcySXBK?=
 =?utf-8?B?bWxMVzZhRFI0SnN3VHF5dHFrNGdyY29MV2NUM3VzeGQ1YkxKdFgzVzBrR2F3?=
 =?utf-8?B?Y0JUMHRkSzEzRm54ZnpVcHFIZzYxakhrbVhQdG5KdXpUNk8xQVhrdmhNQnJF?=
 =?utf-8?B?NGhzb01XUFhqZHNEa2gwV3FqT0Q0cUJJUVIrK0hlSEI3NHN1QTFvNFQvTGZL?=
 =?utf-8?B?VlpTRzFuazBzRmV4SGJXY3grVU5ER2FVcGJSRFBmelVmYk95cXlzdjg1RUJR?=
 =?utf-8?B?ZFcvREllbW0xRUtyUFZWRzYyYVFidUhGeDZvSG9UQ2srZTZtQmIyZi8zbHJs?=
 =?utf-8?B?d2V6WHkzN2ltRWVmTHQ2cUQ5TjlPTHdpNjJuS1RYVndpT3ZUYXRPdHJTMkVp?=
 =?utf-8?B?MmlYMm4rQVlZNEZiNGlLbWJyQmVaSmpXbHFLNVlrNkcvWnliNklCbTlqdnJ5?=
 =?utf-8?B?Z3I3dE5EWVVlSURHVS9pR2VSU0NiL3h4R3lnMVNuc3ZNdVhtTWVWZTk2SlJH?=
 =?utf-8?B?MTRIbHJ5N0V3cS85TnAwRnNUbERCRkNBY3FFWDJJQktMdE9DUFdQOXczSWlM?=
 =?utf-8?B?cUFNYllpZC9QYjlIYnhwRlZTdVlsbHkzdjUwMWh4dm1iTlNUbk1YRCtLcWRI?=
 =?utf-8?B?REg5VE5zYTRrbzMyQzZhYlgwVFNaRVM0c0FBL3l0N3RqSTBMSEZ5YWJDVkpU?=
 =?utf-8?B?OTVKdzlQVzNINkhNMnpaNmVuaGRxR3pRdjhkclY3SktqSkJSZVo1S2xTaXBQ?=
 =?utf-8?B?TXBhY0paZEwvK3M0TlBmaEtUYVZNcXlzd3FDNGxyR0hTUlhucGdvbXlmRmNs?=
 =?utf-8?B?VWt3SGY3cTZ3MFFCenJxcENnemo0S1VIUHhmTjJYa3RGbEEwclY0Y2xmeERz?=
 =?utf-8?B?dU8zMUN3MnM3SzBBaE5LWHdnUVk5NXZuVk9zSEhqZ0pPbGZyMmt4dlFjUjBF?=
 =?utf-8?B?QXdNcldnbk5ic3FraEZWODdIb3dmMGttZG1QRkZza3RmNG9BSnpqN281MWxV?=
 =?utf-8?B?cnV2Y0padHZBcnZGYnpzTi9uMjJSL0c5RjJkUGJxdDR3Y0Y0Si9QaW1RSlIw?=
 =?utf-8?B?NTdoclNiRkVMOHQxdS9TSTB6dUc5ZFBPbUFoMWNFNERSVUhtZnRaanROM1Br?=
 =?utf-8?B?SUxGUDB6VXI0NDNYanpWOGJ1WkszTlRDcnByOUhzMEROcFUxREVLNk9PU05O?=
 =?utf-8?B?b29rMStPakwrSEo2UXd0SnJ1MldtaWZ2Nzc3SjdhS1BTZXZXMVRRblZkOXlG?=
 =?utf-8?B?dVlNK2Fla2Y2TUZLWW8vU2Z1Wjcwb0dzeVhOY1VkcXNrbFhhTlZKS2hneWZR?=
 =?utf-8?B?ckZuUEVLbzQ5V093Mk1TN0RvcmFoUlhLV2w0dTRnaEJnRnRNOFlNWVNNVVRK?=
 =?utf-8?B?SVZVS2VJRkxVcEJ3UVRYRHJXQTFYNVhWTHptU1dYZ1U5aXhBYVBUVitNVHov?=
 =?utf-8?B?aDNaNG91ZzUxZjJZaGZjcmxuLzZFVDlQMHo1d21wbTJFK0VteFRTRGZzYXFz?=
 =?utf-8?B?M1cxaENnQ0N0aWsyRjNpNGttdi9ZZ3ltam1ONFY5VWZ1bWVXWTRXOXUxLzl1?=
 =?utf-8?Q?JAnuh2ImMnS+KIqP0Bz/HFc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlI4U0lKZTVjdzA0Mm9TSnRGYVRwR0RvZks5TFlJTy9zbFhNdHR5QSsxcXpT?=
 =?utf-8?B?T1Y4b2Q2ZkVhUnlLdGhSTzd5WDhRTFR4Mk5xUVFTMzBCUjIreFdrOFpLNHVy?=
 =?utf-8?B?dHk1Y2xsdjJEWjR6cXJoSGl0bkdmbVUwb1k1dms0L29tK2srSjFJNzZiSkpn?=
 =?utf-8?B?ejFzZlpkYnJoa3A2ZXJydEtWeVYxU0xaVzJpSnYyU09yOGU4NkIwMzc2enZS?=
 =?utf-8?B?V0FScXJjS2JPQ3BBazF4NzA3cmdtNEtqcml0RTFabG5VQXZhdXZyV2Y5Q3d5?=
 =?utf-8?B?aUwxY25LWWZiM1VERVJ6TGZYYlVKdld1N0s3aXFZQzV3UHVmNjkyaSt0My9E?=
 =?utf-8?B?NjJQMWQ4dHZrYWkzL0x0REo5WXpXR3dCSkJldElnN2F3QmRwaW5UaHhRNzlJ?=
 =?utf-8?B?REtLUko3SHg3ZlpONnpJMEIvQ0JHeWg4MkRHcW8wbjh4THU1cHUrMXpHWnMz?=
 =?utf-8?B?WnFEaFk1bzB1dE40WGhqZjd0dVpybytPUGdiWGRpbjBnMHZhT1pVMzZ4R0pD?=
 =?utf-8?B?SGJ2Z0R4MkFsTmMzYnVSeXJOSEZFRDNURDFaS2xCLzNpZ0VVU05UenhVZk5r?=
 =?utf-8?B?ODNiZjB4clA3UmF5aTNnUUc5NXY4VFBTY0hSdmsvaW11QUF5YkQ3bzdlcHRI?=
 =?utf-8?B?cDd4bHlRaWtDbWxBaVFSQmErYy80UE4ydDdWREN6czFJb0dBWjJhUVR6b0ZZ?=
 =?utf-8?B?WU90TXArM0pkVmF4THZGT1hXMkJwbkdnR3dRZzEyVG0waENxV1NFRjlOM2Rl?=
 =?utf-8?B?TEpBbFJneUtUZm1nb2tkaEU0NURJS3Z0TXBrUEo3YUpaekpJeHpNRUcwSXFE?=
 =?utf-8?B?TDhYdjl3Z1VlSVM5R25sUmV5QS9lUHk2SFJsMG1ORVVRZ0FlNjVkbVlsdkRn?=
 =?utf-8?B?SVJUNVBSWWlmR0IwZWdKZXlKVlEwVUNERjh1a1hmL0FDNXNBVFJ2R3pINnJO?=
 =?utf-8?B?a090K2ZWc2N2QVZadUJ2bDBKL2t2VDZBR1JLdVExci82VFpSNmgyeC92b0JR?=
 =?utf-8?B?aHpyNS9JMkEwdjNObGJyejVCa200cG45MC9oZFh3VUJDK0pzKzk1VUdJa1FB?=
 =?utf-8?B?ejlhcGQ3TUJ1N1RnMjBJZmgvRXhKWnp5ZHVDMkI2MWpJczdweXdlQ2ZBOTNH?=
 =?utf-8?B?eEhoNHpqajQ1dmJ0OXBvNjFlUitJUWE1MDRpQjBtaTFJNnNpSHkrNFpoY3Bx?=
 =?utf-8?B?enZNMU9EZ3AvQ0RVa2h1OGRUeHEyWEdnVWwrN1VJOUt5SE52WXVQK3o0MTIv?=
 =?utf-8?B?d05wbU5PMEVMVTlERVVGSVlWdUsyMDBmL3RnV2NwSFA2dk9JTTlZWU9rWmh6?=
 =?utf-8?B?VXYvUE5OWGNlZUhWZGpKaFVYMGY4d0NoS1htNktmR0wwL2VtYzN3SWRHMXps?=
 =?utf-8?B?TFBLVUlkYU5FeExpdnQyYW5relV5bmJYOFI1ZjQrZDdML2NlV0ZEaWo0bEhU?=
 =?utf-8?B?VVR3VGxYQlhOMXRLVmczci9ldlB1YkFFMGY5WTg2aFlPbjZKa245TkF2RWd4?=
 =?utf-8?B?QnB3WmFQZHVtTUhpL0lHR3E2L2d5alp1OUFZOU1CKzZjL2tqa2F5V2ZTT0x6?=
 =?utf-8?B?VVZXZEgrN2dCN1ZDQVRzN042bDVlaUdYZFFFckt3dFRHYzhEbUpEYys2cVZZ?=
 =?utf-8?B?NkZqT0NUY3JTMDQzWU1XSVcxbjdHcnBQRkF5WlBhZGNmZnBSeU0xR1VRMjBQ?=
 =?utf-8?B?WXVtWG1DbVRrRGVwaEdDNjh6VFJpM01aWnpjdXZ1TmhMaEhwTlFCTExWZ1Ft?=
 =?utf-8?B?RStXK21iUm1JOGErbGY3UmtReUp5OHQ5VnJJYnRzVC84VHdyNjU4enVJajNy?=
 =?utf-8?B?K2g3cFR0RlhWRTJhQ2lYQnZSWmZNWjVlUWZuQ0pCcDJsbTFRWDRGNUhnOVBh?=
 =?utf-8?B?OEJGY3ZWVThSYmZyVUMrdHRMcnEvUU8yUmlzdFJQV2RzYWJTdTlNc0pOdy9u?=
 =?utf-8?B?RmUwSXpxbWswRmVuYkZzcEJiY2V4aFJoZVhjczNPaEMra3NSdEc1dll1T1Fs?=
 =?utf-8?B?SUlXZmNYYUNrMlBDeGE3czByaTdVRDY3Vnc2U0xiS0NCYWhYSGZXd0QrL0FB?=
 =?utf-8?B?Wk8yYUxqT3lHdUNGYmM1L2FvQVZYSHZBNjJMeTNOZk1Ca2g0WHB0aDF0QUsv?=
 =?utf-8?B?VWVoVWtoejNicm16UEZUdkpwVzF6Mm40dWNlanNNRDluWlRNNFlTOHE1ZSt4?=
 =?utf-8?B?Nkd3WlVGTkNYZE9ZREZOS1N5Z29SSHhQYzZDSkN6bEtuZnRkQzRHU05jd0Fy?=
 =?utf-8?B?MGpjOGwxOEo1U2JRVEJhMmlrc3BMYjZ3YW0zbTRUVFBLYkhnQ2dJN2xONmd3?=
 =?utf-8?B?SDVLbzk5aHFuWWpwSFg2cHUvSUt4M0tMdWNqV0Z1ZzArTTlzM0VPdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c765f06-a4ac-49c2-f64f-08de598538e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 07:09:45.6592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du0d1+hc5rzpCKUseLuAIeASyBKKukeGiXlvrFeeRJhDgVP2/Wad3IRYtBmY4El2OKZm7P0eGyUOBQWwaU9iTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586
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

From: Peng Fan <peng.fan@nxp.com>


On Thu, 15 Jan 2026 15:30:42 +0100, Julien Stephan wrote:
> If CONFIG_DM_GPIO is not enabled, compilation of
> drivers/power/regulator/regulator_common.c  fails with the following
> errors:
> 
> aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_of_to_plat':
> <...>/u-boot/drivers/power/regulator/regulator_common.c:30: undefined reference to `gpio_request_by_name'
> aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_get_enable':
> <...>/u-boot/drivers/power/regulator/regulator_common.c:57: undefined reference to `dm_gpio_get_value'
> aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_set_enable':
> <...>/u-boot/drivers/power/regulator/regulator_common.c:92: undefined reference to `dm_gpio_set_value'
> make: *** [Makefile:2029: u-boot] Error 139
> 
> [...]

Applied, thanks!

[1/3] power: regulator: common: remove unnecessary debug trace
      commit: 7dbec4f77c907c20c1ae707bfdd8ac356b0e0986
[2/3] power: regulator: common: use dm_gpio_is_valid helper
      commit: 0411cac1616c5ac3223367e054f4e8eb3ad524bc
[3/3] power: regulator: common: fix compilation issue
      commit: dab2c154f605b2f6742aa107dab2b55b9824fdf5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
